
import { Injectable } from '@nestjs/common';

@Injectable()
export class AlertDispatcherService {
  async dispatch(ownerId: string, alerts: any[]) {
    const notifications = alerts.map(alert => ({
      ownerId,
      alertId: alert.id,
      message: `Fraud Alert: ${alert.message}`,
      sentAt: new Date(),
    }));

    return notifications;
  }
}
