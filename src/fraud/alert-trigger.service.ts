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
    // Load the application with the fields your schema actually has
    const application = await this.prisma.application.findUnique({
      where: { id: applicationId },
      include: {
        fraudEvents: true,
        fraudScores: true,
        fraudLadders: true,
        fraudChains: true,
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

    // Evaluate rules using your actual rules engine
    const alerts = this.rules.evaluate(application);

    // Persist alerts as FraudEvent records
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

      // Dispatch alert
      await this.dispatcher.dispatch(created, application);
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
