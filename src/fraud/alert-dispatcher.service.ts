import { Injectable } from '@nestjs/common';

@Injectable()
export class AlertDispatcherService {
  async dispatch(eventId: string, applicationId: string) {
    console.log(`Dispatching fraud event ${eventId} for application ${applicationId}`);
  }
}
