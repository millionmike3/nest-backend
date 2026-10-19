"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AlertRulesService = void 0;
class AlertRulesService {
    evaluate(owner) {
        const alerts = [];
        // Rule 1 — Multiple SAR reports
        if (owner.suspiciousActivityReport?.length >= 2) {
            alerts.push({
                type: 'MULTIPLE_SAR',
                severity: 'CRITICAL',
                message: 'Owner has multiple SAR reports.',
            });
        }
        // Rule 2 — High fraud score
        if (owner.riskScore >= 80) {
            alerts.push({
                type: 'HIGH_FRAUD_SCORE',
                severity: 'HIGH',
                message: `Fraud score is ${owner.riskScore}.`,
            });
        }
        // Rule 3 — Device anomaly
        if (owner.ownerDevice?.length >= 4) {
            alerts.push({
                type: 'DEVICE_ANOMALY',
                severity: 'MEDIUM',
                message: 'Owner has multiple devices linked.',
            });
        }
        // Rule 4 — Routing cluster
        const routingNumbers = owner.ownerAccount?.map((a) => a.routingNumber) || [];
        const unique = new Set(routingNumbers);
        if (unique.size < routingNumbers.length) {
            alerts.push({
                type: 'ROUTING_CLUSTER',
                severity: 'HIGH',
                message: 'Owner shares routing numbers with other accounts.',
            });
        }
        // Rule 5 — Document fraud
        const docFraudScores = owner.ownerDocument?.flatMap((d) => d.documentFraudResult.map((r) => r.fraudScore)) || [];
        const maxDocFraud = docFraudScores.length ? Math.max(...docFraudScores) : 0;
        if (maxDocFraud >= 70) {
            alerts.push({
                type: 'DOCUMENT_FRAUD',
                severity: 'HIGH',
                message: 'Document fraud score exceeds threshold.',
            });
        }
        return alerts;
    }
}
exports.AlertRulesService = AlertRulesService;
