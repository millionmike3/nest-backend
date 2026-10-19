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
   * Generate alerts for an owner using:
   * - full owner fraud profile
   * - enterprise fraud rules engine
   * - Prisma persistence
   * - dispatcher notifications
   */
  async generateAlertsForOwner(ownerId: string) {
    // Load full owner fraud profile
    const owner = await this.prisma.owner.findUnique({
      where: { id: ownerId },
      include: {
        ownerAccount: true,        // routing numbers
        ownerDevice: true,         // device anomaly
        ownerDocument: {
          include: {
            documentFraudResult: true, // fraud scores
          },
        },
        suspiciousActivityReport: true, // SAR reports
      },
    });

    if (!owner) return [];

    // Evaluate rules using your unified rules engine
    const alerts = this.rules.evaluate(owner);

    // Persist alerts + dispatch notifications
    for (const alert of alerts) {
      const created = await this.prisma.fraudAlert.create({
        data: {
          ownerId,
          organizationId: owner.organizationId,
          type: alert.type,
          severity: alert.severity,
          meta: alert.message,
        },
      });

      // Dispatch notification
      await this.dispatcher.dispatch(created);
    }

    return alerts;
  }

  /**
   * Simple trigger method (my original version)
   * Allows manual rule injection
   */
  async trigger(ownerId: string, rules: any[]) {
    const alerts = [];

    for (const rule of rules) {
      const alert = await this.prisma.fraudAlert.create({
        data: {
          ownerId,
          rule: rule.rule,
          severity: rule.severity,
          message: rule.message,
        },
      });

      alerts.push(alert);
    }

    return alerts;
  }
}
