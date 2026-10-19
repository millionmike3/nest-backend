"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AlertsModule = void 0;
const common_1 = require("@nestjs/common");
const prisma_module_1 = require("../prisma/prisma.module");
const alert_rules_service_1 = require("./alert-rules.service");
const alert_trigger_service_1 = require("./alert-trigger.service");
const alert_dispatcher_service_1 = require("./alert-dispatcher.service");
const fraud_alerts_service_1 = require("./fraud-alerts.service");
const alerts_controller_1 = require("./alerts.controller");
let AlertsModule = class AlertsModule {
};
exports.AlertsModule = AlertsModule;
exports.AlertsModule = AlertsModule = __decorate([
    (0, common_1.Module)({
        imports: [prisma_module_1.PrismaModule],
        providers: [
            alert_rules_service_1.AlertRulesService,
            alert_trigger_service_1.AlertTriggerService,
            alert_dispatcher_service_1.AlertDispatcherService,
            fraud_alerts_service_1.FraudAlertsService,
        ],
        controllers: [alerts_controller_1.AlertsController],
        exports: [fraud_alerts_service_1.FraudAlertsService],
    })
], AlertsModule);
