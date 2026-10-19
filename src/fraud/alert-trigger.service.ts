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

  async generateAlertsForOwner(ownerId: string) {
    // Load owner with ONLY the fields your updated schema actually has
    const owner = await this.prisma.owner.findUnique({
      where: { id: ownerId },
      include: {
        accounts: true,
        devices: true,
        documents: {
          include: {
            fraudResults: true,
          },
        },
        sarReports: true,
      },
    });

    if (!owner) return [];

    // Use the correct rule evaluation method
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

      // Dispatcher expects (alert, owner)
      await this.dispatcher.dispatch(created, owner);
    }

    return alerts;
  }

  async trigger(ownerId: string, rules: any[]) {
    const alerts = [];

    for (const rule of rules) {
      const created = await this.prisma.fraudAlert.create({
        data: {
          ownerId,
          type: rule.rule,
          severity: rule.severity,
          meta: rule.message,
        },
      });

      alerts.push(created);
    }

    return alerts;
  }
}
