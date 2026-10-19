import { Injectable } from '@nestjs/common';

@Injectable()
export class AlertRulesService {
  /**
   * Unified rule evaluation engine
   * Combines transactional rules + enterprise fraud rules
   */
  async evaluate(owner: any, payload?: any) {
    const alerts: any[] = [];

    /**
     * -----------------------------
     *  SIMPLE TRANSACTION RULES
     * -----------------------------
     */

    // Rule A — High transaction amount
    if (payload?.amount > 5000) {
      alerts.push({
        type: 'HIGH_AMOUNT',
        severity: 'HIGH',
        message: 'Transaction exceeds $5,000',
      });
    }

    // Rule B — IP mismatch
    if (payload?.ip && payload?.ip !== payload?.lastKnownIp) {
      alerts.push({
        type: 'IP_MISMATCH',
        severity: 'MEDIUM',
        message: 'IP address differs from last known login',
      });
    }

    // Rule C — High velocity
    if (payload?.velocity && payload?.velocity > 10) {
      alerts.push({
        type: 'HIGH_VELOCITY',
        severity: 'HIGH',
        message: 'Too many actions in a short period',
      });
    }

    /**
     * -----------------------------
     *  ENTERPRISE FRAUD RULES
     * -----------------------------
     */

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
    const routingNumbers =
      owner.ownerAccount?.map((a: any) => a.routingNumber) || [];

    const unique = new Set(routingNumbers);

    if (unique.size < routingNumbers.length) {
      alerts.push({
        type: 'ROUTING_CLUSTER',
        severity: 'HIGH',
        message: 'Owner shares routing numbers with other accounts.',
      });
    }

    // Rule 5 — Document fraud
    const docFraudScores =
      owner.ownerDocument?.flatMap((d: any) =>
        d.documentFraudResult.map((r: any) => r.fraudScore),
      ) || [];

    const maxDocFraud = docFraudScores.length
      ? Math.max(...docFraudScores)
      : 0;

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
