import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { AlertTriggerService } from './alert-trigger.service';
import { AlertDispatcherService } from './alert-dispatcher.service';

@Injectable()
export class FraudAlertsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly trigger: AlertTriggerService,
    private readonly dispatcher: AlertDispatcherService,
  ) {}

  /**
   * Generate alerts for an application
   */
  async generateAlerts(applicationId: string) {
    const alerts = await this.trigger.generateAlertsForApplication(applicationId);

    for (const alert of alerts) {
      await this.dispatcher.dispatch(alert, applicationId);
    }

    return alerts;
  }

  /**
   * Fraud Summary (recent events)
   */
  async getSummary(applicationId: string) {
    return this.prisma.fraudEvent.findMany({
      where: { applicationId },
      orderBy: { createdAt: 'desc' },
      take: 25,
    });
  }

  /**
   * Fraud Timeline (chronological events)
   */
  async getTimeline(applicationId: string) {
    return this.prisma.fraudEvent.findMany({
      where: { applicationId },
      orderBy: { createdAt: 'asc' },
    });
  }

  /**
   * Fraud Clusters (your schema supports this)
   */
  async getClusters(applicationId: string) {
    return this.prisma.fraudCluster.findMany({
      where: { applicationId },
      // FraudCluster has NO "alerts" relation in your schema
      // It only has: clusterId, signals, metadata
    });
  }
}
