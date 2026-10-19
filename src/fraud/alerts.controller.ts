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
   * Trigger fraud alerts for an application
   * POST /alerts/application/:id
   */
  @Post('application/:id')
  async triggerAlertsForApplication(
    @Param('id') applicationId: string,
    @Body() payload: any,
  ) {
    // Step 1: Evaluate rules (correct method)
    const rules = await this.rulesService.evaluate(applicationId, payload);

    // Step 2: Trigger alerts (correct service)
    const triggered = await this.triggerService.trigger(applicationId, rules);

    // Step 3: Dispatch notifications (correct signature)
    for (const event of triggered) {
      await this.dispatcherService.dispatch(event.id, applicationId);
    }

    return {
      applicationId,
      triggered,
      status: 'alerts_processed',
    };
  }

  /**
   * Fraud Summary
   * GET /alerts/summary/:id
   */
  @Get('summary/:id')
  async getFraudSummary(@Param('id') applicationId: string) {
    return this.fraudAlerts.getSummary(applicationId);
  }

  /**
   * Fraud Timeline
   * GET /alerts/timeline/:id
   */
  @Get('timeline/:id')
  async getFraudTimeline(@Param('id') applicationId: string) {
    return this.fraudAlerts.getTimeline(applicationId);
  }

  /**
   * Fraud Clusters
   * GET /alerts/clusters/:id
   */
  @Get('clusters/:id')
  async getFraudClusters(@Param('id') applicationId: string) {
    return this.fraudAlerts.getClusters(applicationId);
  }
}
