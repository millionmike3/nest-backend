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
   * ORIGINAL LOGIC
   * Generate alerts for an owner
   */
  async generateAlerts(ownerId: string) {
    const alerts = await this.trigger.generateAlertsForOwner(ownerId);

    for (const alert of alerts) {
      await this.dispatcher.dispatch(alert);
    }

    return alerts;
  }

  /**
   * NEW LOGIC
   * Fraud Summary (recent alerts)
   */
  async getSummary(ownerId: string) {
    return this.prisma.fraudAlert.findMany({
      where: { ownerId },
      orderBy: { createdAt: 'desc' },
      take: 25,
    });
  }

  /**
   * NEW LOGIC
   * Fraud Timeline (chronological alerts)
   */
  async getTimeline(ownerId: string) {
    return this.prisma.fraudAlert.findMany({
      where: { ownerId },
      orderBy: { createdAt: 'asc' },
    });
  }

  /**
   * NEW LOGIC
   * Fraud Clusters (grouped alerts)
   */
  async getClusters(ownerId: string) {
    return this.prisma.fraudCluster.findMany({
      where: { ownerId },
      include: {
        alerts: true,
      },
    });
  }
}
