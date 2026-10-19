import { Module } from '@nestjs/common';
import { AlertsController } from './alerts.controller';
import { FraudAlertsService } from './fraud-alerts.service';
import { AlertRulesService } from './alert-rules.service';
import { AlertTriggerService } from './alert-trigger.service';
import { AlertDispatcherService } from './alert-dispatcher.service';
import { PrismaModule } from '../prisma/prisma.module';

@Module({
  imports: [PrismaModule],
  controllers: [AlertsController],
  providers: [
    FraudAlertsService,
    AlertRulesService,
    AlertTriggerService,
    AlertDispatcherService,
  ],
})
export class AlertsModule {}