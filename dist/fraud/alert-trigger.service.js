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
exports.AlertTriggerService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
const alert_rules_service_1 = require("./alert-rules.service");
const alert_dispatcher_service_1 = require("./alert-dispatcher.service");
let AlertTriggerService = class AlertTriggerService {
    constructor(prisma, rules, dispatcher) {
        this.prisma = prisma;
        this.rules = rules;
        this.dispatcher = dispatcher;
    }
    async generateAlertsForOwner(ownerId) {
        const owner = await this.prisma.owner.findUnique({
            where: { id: ownerId },
            include: {
                accounts: true, // was ownerAccount
                devices: true, // if you had ownerDevice
                documents: {
                    include: {
                        fraudResults: true, // or documentFraudResult if that’s the actual field
                    },
                },
                sarReports: true,
            },
        });
        if (!owner)
            return [];
        const alerts = this.rules.evaluate(owner);
        for (const alert of alerts) {
            await this.prisma.fraudAlert.create({
                data: {
                    ownerId,
                    organizationId: owner.organizationId,
                    type: alert.type,
                    severity: alert.severity,
                    meta: alert.message,
                },
            });
        }
        return alerts;
    }
};
exports.AlertTriggerService = AlertTriggerService;
exports.AlertTriggerService = AlertTriggerService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService,
        alert_rules_service_1.AlertRulesService,
        alert_dispatcher_service_1.AlertDispatcherService])
], AlertTriggerService);
