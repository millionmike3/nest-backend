import { Controller, Post, Get, Param, Body } from '@nestjs/common';
import { FraudAlertsService } from './fraud-alerts.service';
import { AlertTriggerService } from './alert-trigger.service';
import { AlertRulesService } from './alert-rules.service';
import { AlertDispatcherService } from './alert-dispatcher.service';

@Controller('alerts')
export class AlertsController {
  constructor(
    private readonly fraudAlerts: FraudAlertsService,
    private readonly triggerService: AlertTriggerService,
    private readonly rulesService: AlertRulesService,
    private readonly dispatcherService: AlertDispatcherService,
  ) {}

  /**
   * Trigger fraud alerts for an owner
   * POST /alerts/owner/:id
   */
  @Post('owner/:id')
  async triggerAlertsForOwner(
    @Param('id') ownerId: string,
    @Body() payload: any,
  ) {
    // Step 1: Evaluate rules
    const rules = await this.rulesService.evaluateRules(ownerId, payload);

    // Step 2: Trigger alerts
    const triggered = await this.triggerService.trigger(ownerId, rules);

    // Step 3: Dispatch notifications
    await this.dispatcherService.dispatch(ownerId, triggered);

    return {
      ownerId,
      triggered,
      status: 'alerts_processed',
    };
  }

  /**
   * Fraud Summary
   * GET /alerts/summary/:id
   */
  @Get('summary/:id')
  async getFraudSummary(@Param('id') ownerId: string) {
    return this.fraudAlerts.getSummary(ownerId);
  }

  /**
   * Fraud Timeline
   * GET /alerts/timeline/:id
   */
  @Get('timeline/:id')
  async getFraudTimeline(@Param('id') ownerId: string) {
    return this.fraudAlerts.getTimeline(ownerId);
  }

  /**
   * Fraud Clusters
   * GET /alerts/clusters/:id
   */
  @Get('clusters/:id')
  async getFraudClusters(@Param('id') ownerId: string) {
    return this.fraudAlerts.getClusters(ownerId);
  }
}
