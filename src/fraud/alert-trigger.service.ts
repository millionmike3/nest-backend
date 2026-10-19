import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { AlertRulesService } from './alert-rules.service';
import { AlertDispatcherService } from './alert-dispatcher.service';

@Injectable()
export class AlertTriggerService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly rules: AlertRulesService,
    private readonly dispatcher: AlertDispatcherService,
  ) {}

  /**
   * Generate fraud alerts for an application
   */
  async generateAlertsForApplication(applicationId: string) {
    const application = await this.prisma.application.findUnique({
      where: { id: applicationId },
      include: {
        fraudEvents: true,
        FraudAiInferenceLog: true,
        FraudEscalation: true,
        FraudAnomalyDetection: true,
        FraudFeatureStore: true,
        FraudCluster: true,
        FraudTrajectoryModel: true,
        FraudPropagationModel: true,
        FraudContagionMapping: true,
        FraudTemporalEvolution: true,
        FraudNetworkMapping: true,
        FraudPatternEvolution: true,
        FraudSignalChain: true,
      },
    });

    if (!application) return [];

    // Evaluate rules
    const alerts = await this.rules.evaluate(application);

    const createdAlerts = [];

    for (const alert of alerts) {
      const created = await this.prisma.fraudEvent.create({
        data: {
          applicationId,
          eventType: alert.type,
          signal: alert.signal ?? null,
          payload: alert.payload ?? null,
          metadata: alert.message ? { message: alert.message } : {},
        },
      });

      createdAlerts.push(created);

      // Dispatcher expects (eventId: string, applicationId: string)
      await this.dispatcher.dispatch(created.id, applicationId);
    }

    return createdAlerts;
  }

  /**
   * Manual trigger for custom rule sets
   */
  async trigger(applicationId: string, rules: any[]) {
    const created = [];

    for (const rule of rules) {
      const event = await this.prisma.fraudEvent.create({
        data: {
          applicationId,
          eventType: rule.rule,
          signal: rule.signal ?? null,
          payload: rule.payload ?? null,
          metadata: rule.message ? { message: rule.message } : {},
        },
      });

      created.push(event);
    }

    return created;
  }
}
