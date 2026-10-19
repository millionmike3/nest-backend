"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.FraudAlertsService = void 0;
const common_1 = require("@nestjs/common");
const alert_trigger_service_1 = require("./alert-trigger.service");
const alert_dispatcher_service_1 = require("./alert-dispatcher.service");
let FraudAlertsService = class FraudAlertsService {
    constructor(trigger, dispatcher) {
        this.trigger = trigger;
        this.dispatcher = dispatcher;
    }
    async generateAlerts(ownerId) {
        const alerts = await this.trigger.generateAlertsForOwner(ownerId);
        for (const alert of alerts) {
            await this.dispatcher.dispatch(alert);
        }
        return alerts;
    }
};
exports.FraudAlertsService = FraudAlertsService;
exports.FraudAlertsService = FraudAlertsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [alert_trigger_service_1.AlertTriggerService,
        alert_dispatcher_service_1.AlertDispatcherService])
], FraudAlertsService);
