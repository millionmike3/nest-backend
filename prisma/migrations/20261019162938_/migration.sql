-- CreateEnum
CREATE TYPE "Pillar" AS ENUM ('PROOF_OF_FUNDS', 'DEAL_PROSPECTING', 'CERTIFIED_CHECK', 'MORTGAGE_LOS', 'CRM', 'DIALER', 'MESSAGING', 'EMAIL', 'STOCK_SANITIZER', 'LENDING_SANITIZER', 'PRODUCTIVITY_SANITIZER', 'BLOCKCHAIN_AUDIT', 'SMART_CONTRACT_VERIFICATION', 'AUDIT_EXPLORER', 'AI_UNDERWRITING', 'AI_DEAL_ANALYZER', 'AI_AUDIT_ASSISTANT', 'BEHAVIORAL_RISK_ENGINE', 'CUSTOMER_BEHAVIOR', 'INVESTOR_BEHAVIOR', 'LEAD_BEHAVIOR', 'PRICING_ENGINE', 'MARKET_RISK_ENGINE');

-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('ADMIN', 'OWNER', 'UNDERWRITER', 'INVESTOR', 'LOAN_OFFICER', 'PROCESSOR', 'SERVICING', 'STAFF', 'BORROWER');

-- CreateEnum
CREATE TYPE "InvestorAction" AS ENUM ('QUOTE_REQUEST', 'LOGIN', 'VIEWED_DASHBOARD');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "username" TEXT,
    "phone" TEXT,
    "passwordHash" TEXT,
    "role" "UserRole" NOT NULL DEFAULT 'BORROWER',
    "walletAddress" TEXT,
    "ownerId" TEXT,
    "xp" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Borrower" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "firstName" TEXT NOT NULL,
    "middleName" TEXT,
    "lastName" TEXT NOT NULL,
    "fullName" TEXT,
    "ssn" TEXT NOT NULL,
    "dob" TIMESTAMP(3) NOT NULL,
    "citizenship" TEXT,
    "phone" TEXT,
    "email" TEXT NOT NULL,
    "employer" TEXT,
    "userId" INTEGER,

    CONSTRAINT "Borrower_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Investor" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT,
    "phone" TEXT,
    "userId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "investorPotentialScore" INTEGER NOT NULL DEFAULT 0,
    "investorPotentialBand" TEXT NOT NULL DEFAULT 'low',
    "notes" TEXT,

    CONSTRAINT "Investor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestorBehavior" (
    "id" TEXT NOT NULL,
    "investorId" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "notes" TEXT,
    "action" TEXT NOT NULL,
    "metadata" JSONB,

    CONSTRAINT "InvestorBehavior_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Lead" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "scores" JSONB,
    "userId" INTEGER,

    CONSTRAINT "Lead_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LeadEvent" (
    "id" TEXT NOT NULL,
    "leadId" TEXT NOT NULL,
    "eventType" TEXT NOT NULL,
    "page" TEXT,
    "element" TEXT,
    "description" TEXT,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "responseTimeMs" INTEGER,
    "lateNight" BOOLEAN,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "LeadEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ContactAttempt" (
    "id" TEXT NOT NULL,
    "leadId" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "notes" TEXT,
    "channel" TEXT,
    "outcome" TEXT,

    CONSTRAINT "ContactAttempt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AuditLog" (
    "id" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "actor" TEXT,
    "target" TEXT,
    "details" TEXT,
    "adminId" INTEGER,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AuditLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Audit" (
    "id" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "details" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "adminId" INTEGER,

    CONSTRAINT "Audit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Position" (
    "id" SERIAL NOT NULL,
    "investorId" INTEGER NOT NULL,
    "note" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "yield" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Position_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EnvironmentReading" (
    "id" TEXT NOT NULL,
    "locationId" TEXT NOT NULL,
    "deviceCount" INTEGER NOT NULL,
    "bluetoothDensity" INTEGER NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "riskScore" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "age" INTEGER,
    "incomeVolatility" DOUBLE PRECISION,
    "ipReputation" TEXT,

    CONSTRAINT "EnvironmentReading_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Application" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "borrowerId" TEXT,
    "loanAmount" INTEGER,
    "loanPurpose" TEXT,
    "propertyAddress" TEXT,
    "propertyCity" TEXT,
    "propertyState" TEXT,
    "propertyZip" TEXT,
    "propertyCounty" TEXT,
    "units" INTEGER,
    "occupancy" TEXT,
    "propertyType" TEXT,
    "employer" TEXT,
    "underwritingStatus" TEXT,
    "noteRate" DOUBLE PRECISION,
    "liquidAssets" INTEGER,
    "loanOfficerId" TEXT,
    "milestone" TEXT NOT NULL DEFAULT 'Application Submitted',
    "status" TEXT NOT NULL DEFAULT 'SUBMITTED',
    "loanType" TEXT,
    "behaviorScore" DOUBLE PRECISION,
    "fraudScore" DOUBLE PRECISION,
    "routingScore" DOUBLE PRECISION,
    "purchasePrice" INTEGER,
    "incomeAnnual" INTEGER,
    "assetsLiquid" INTEGER,
    "underwritingScore" INTEGER,
    "incomeMonthly" INTEGER,
    "debtsMonthly" INTEGER,
    "pitiMonthly" INTEGER,
    "propertyValue" INTEGER,
    "totalLiens" INTEGER,
    "full1003Json" JSONB,
    "underwritingPipelineOutputId" TEXT,

    CONSTRAINT "Application_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TimelineEvent" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "message" TEXT,
    "applicationId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "metadata" JSONB,

    CONSTRAINT "TimelineEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Timeline" (
    "id" TEXT NOT NULL,
    "applicationId" TEXT NOT NULL,
    "type" TEXT,
    "message" TEXT,
    "event" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Timeline_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationMilestone" (
    "id" TEXT NOT NULL,
    "applicationId" TEXT,
    "milestone" TEXT,
    "timestamp" TIMESTAMP(3),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ApplicationMilestone_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Document" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "fraudScore" DOUBLE PRECISION,
    "fraudSignals" JSONB,
    "embedColor" TEXT,

    CONSTRAINT "Document_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentClassification" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "documentId" TEXT,
    "category" TEXT,
    "confidence" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "DocumentClassification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentOcrExtraction" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "documentId" TEXT,
    "text" TEXT,
    "fields" JSONB,
    "confidence" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "DocumentOcrExtraction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentVersion" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "documentId" TEXT,
    "version" INTEGER,
    "url" TEXT,
    "metadata" JSONB,

    CONSTRAINT "DocumentVersion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentLineage" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "documentId" TEXT,
    "lineage" JSONB,
    "version" INTEGER,
    "metadata" JSONB,

    CONSTRAINT "DocumentLineage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentSemanticExtraction" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "documentId" TEXT,
    "semantics" JSONB,
    "confidence" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "DocumentSemanticExtraction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentStructuralAnalysis" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "documentId" TEXT NOT NULL,
    "structure" JSONB,
    "anomalies" JSONB,
    "metadata" JSONB,

    CONSTRAINT "DocumentStructuralAnalysis_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentExtractionPipeline" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "documentId" TEXT NOT NULL,
    "pipelineName" TEXT,
    "steps" JSONB,
    "metadata" JSONB,

    CONSTRAINT "DocumentExtractionPipeline_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentEmbedding" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "documentId" TEXT,
    "vector" JSONB,
    "metadata" JSONB,

    CONSTRAINT "DocumentEmbedding_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentSemanticScore" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "documentId" TEXT,
    "score" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "DocumentSemanticScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentRiskSignal" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "documentId" TEXT,
    "signalType" TEXT,
    "strength" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "DocumentRiskSignal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Disclosure" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "url" TEXT,
    "title" TEXT,
    "content" TEXT,

    CONSTRAINT "Disclosure_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DisclosureCompliance" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "disclosureId" TEXT,
    "compliant" BOOLEAN,
    "issues" JSONB,
    "metadata" JSONB,

    CONSTRAINT "DisclosureCompliance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DisclosureTracking" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "disclosureId" TEXT,
    "viewedAt" TIMESTAMP(3),
    "acceptedAt" TIMESTAMP(3),
    "metadata" JSONB,

    CONSTRAINT "DisclosureTracking_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DisclosureAuditTrail" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "disclosureId" TEXT,
    "eventType" TEXT,
    "timestamp" TIMESTAMP(3),
    "metadata" JSONB,

    CONSTRAINT "DisclosureAuditTrail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DisclosureComplianceSnapshot" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "disclosureId" TEXT,
    "compliant" BOOLEAN,
    "issues" JSONB,
    "metadata" JSONB,

    CONSTRAINT "DisclosureComplianceSnapshot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DisclosureLifecycleAnalytics" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "disclosureId" TEXT NOT NULL,
    "lifecycleStage" TEXT,
    "metrics" JSONB,
    "metadata" JSONB,

    CONSTRAINT "DisclosureLifecycleAnalytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DisclosureComplianceLayer" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "disclosureId" TEXT NOT NULL,
    "layerName" TEXT,
    "complianceScore" DOUBLE PRECISION,
    "issues" JSONB,
    "metadata" JSONB,

    CONSTRAINT "DisclosureComplianceLayer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DisclosureBehaviorAnalytics" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "disclosureId" TEXT NOT NULL,
    "behaviorScore" DOUBLE PRECISION,
    "patterns" JSONB,
    "metadata" JSONB,

    CONSTRAINT "DisclosureBehaviorAnalytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DisclosureBehaviorTrajectory" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "disclosureId" TEXT NOT NULL,
    "trajectory" JSONB,
    "behaviorScore" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "DisclosureBehaviorTrajectory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DisclosureSentimentAnalytics" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "disclosureId" TEXT NOT NULL,
    "sentiment" TEXT,
    "score" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "DisclosureSentimentAnalytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DisclosureEngagementAnalytics" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "disclosureId" TEXT NOT NULL,
    "engagementScore" DOUBLE PRECISION,
    "interactions" JSONB,
    "metadata" JSONB,

    CONSTRAINT "DisclosureEngagementAnalytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingCase" (
    "id" TEXT NOT NULL,
    "applicationId" TEXT NOT NULL,
    "dti" DOUBLE PRECISION,
    "ltv" DOUBLE PRECISION,
    "cltv" DOUBLE PRECISION,
    "reservesMonths" DOUBLE PRECISION,
    "riskScore" DOUBLE PRECISION,
    "fraudScore" DOUBLE PRECISION,
    "routingScore" DOUBLE PRECISION,
    "investorDecision" TEXT,
    "llpa" DOUBLE PRECISION,
    "finalRate" DOUBLE PRECISION,
    "reasons" JSONB,
    "investorReasons" JSONB,
    "status" TEXT NOT NULL,
    "notes" TEXT,
    "ausFinding" TEXT,
    "decision" TEXT,
    "conditions" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UnderwritingCase_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingEvent" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "eventType" TEXT,
    "payload" JSONB,

    CONSTRAINT "UnderwritingEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingStep" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "stepName" TEXT,
    "status" TEXT,
    "notes" TEXT,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingStep_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingDecision" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "decision" TEXT,
    "reason" TEXT,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingDecision_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingRule" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "ruleName" TEXT,
    "description" TEXT,
    "criteria" JSONB,
    "outcome" TEXT,
    "metadata" JSONB,
    "underwritingCaseId" TEXT,

    CONSTRAINT "UnderwritingRule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingRuleEvaluation" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "ruleId" TEXT,
    "passed" BOOLEAN,
    "score" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingRuleEvaluation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingAutomation" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "automationType" TEXT,
    "result" JSONB,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingAutomation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingExceptionLog" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "exceptionType" TEXT,
    "details" JSONB,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingExceptionLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingExceptionEscalation" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "escalationLevel" TEXT,
    "reason" TEXT,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingExceptionEscalation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingSnapshot" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "snapshot" JSONB,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingSnapshot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingAiDecisionLog" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "modelVersion" TEXT,
    "decision" TEXT,
    "confidence" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingAiDecisionLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingRuleChain" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "chain" JSONB,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingRuleChain_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingChainAnalytics" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "analytics" JSONB,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingChainAnalytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingOverrideLog" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "overrideType" TEXT,
    "reason" TEXT,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingOverrideLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingProbabilisticScoring" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT NOT NULL,
    "scores" JSONB,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingProbabilisticScoring_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingDecisionTree" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT NOT NULL,
    "tree" JSONB,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingDecisionTree_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingCalibrationLog" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "calibrationType" TEXT,
    "details" JSONB,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingCalibrationLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingScoreResult" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "score" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingScoreResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingPipelineOutput" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT NOT NULL,
    "docsRequired" INTEGER NOT NULL DEFAULT 0,
    "docsSatisfied" INTEGER NOT NULL DEFAULT 0,
    "docsPercent" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "milestone" TEXT NOT NULL,
    "underwritingCaseId" TEXT,
    "steps" JSONB,
    "finalScore" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingPipelineOutput_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingRiskFactors" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingRiskFactors_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingDecisionOutput" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "underwritingCaseId" TEXT,
    "decision" TEXT,
    "reasons" JSONB,
    "metadata" JSONB,

    CONSTRAINT "UnderwritingDecisionOutput_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingEngineAudit" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "auditType" TEXT,
    "details" JSONB,
    "metadata" JSONB,

    CONSTRAINT "PricingEngineAudit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingEngineInferenceLog" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "modelVersion" TEXT,
    "inference" JSONB,
    "confidence" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "PricingEngineInferenceLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingComponentScoring" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "componentName" TEXT,
    "score" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "PricingComponentScoring_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingOptimizationLayer" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "layerName" TEXT,
    "adjustments" JSONB,
    "optimizedRate" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "PricingOptimizationLayer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingSensitivityLayer" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "sensitivityType" TEXT,
    "impact" JSONB,
    "metadata" JSONB,

    CONSTRAINT "PricingSensitivityLayer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingAnomalyDetection" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "anomalyScore" DOUBLE PRECISION,
    "signals" JSONB,
    "metadata" JSONB,

    CONSTRAINT "PricingAnomalyDetection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingCurveFitting" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "curveType" TEXT,
    "curveData" JSONB,
    "fitQuality" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "PricingCurveFitting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingVolatilityTracking" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "volatilityScore" DOUBLE PRECISION,
    "history" JSONB,
    "metadata" JSONB,

    CONSTRAINT "PricingVolatilityTracking_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingElasticityAnalytics" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "elasticity" DOUBLE PRECISION,
    "behaviorImpact" JSONB,
    "metadata" JSONB,

    CONSTRAINT "PricingElasticityAnalytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestorPricingSheet" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "investorId" TEXT,
    "effectiveAt" TIMESTAMP(3),
    "programName" TEXT,
    "baseRate" DOUBLE PRECISION,
    "adjustments" JSONB,
    "metadata" JSONB,

    CONSTRAINT "InvestorPricingSheet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LlpaGridRow" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "pricingSheetId" TEXT,
    "ltv" DOUBLE PRECISION,
    "creditScore" INTEGER,
    "llpaFactor" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "LlpaGridRow_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductOverlay" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "pricingSheetId" TEXT,
    "productType" TEXT,
    "overlayRate" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "ProductOverlay_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NonQMPricingRule" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "pricingSheetId" TEXT,
    "ruleName" TEXT,
    "adjustment" DOUBLE PRECISION,
    "criteria" JSONB,
    "metadata" JSONB,

    CONSTRAINT "NonQMPricingRule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingScenario" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "scenarioType" TEXT,
    "inputs" JSONB,
    "outputs" JSONB,
    "metadata" JSONB,

    CONSTRAINT "PricingScenario_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingResult" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "finalRate" DOUBLE PRECISION,
    "components" JSONB,
    "metadata" JSONB,

    CONSTRAINT "PricingResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudScore" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "score" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudPipeline" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "pipelineName" TEXT,
    "steps" JSONB,
    "finalScore" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "FraudPipeline_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudSignal" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "signalType" TEXT,
    "strength" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "FraudSignal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudCaseHistory" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "caseType" TEXT,
    "details" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudCaseHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudFlag" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "flagType" TEXT,
    "reason" TEXT,
    "metadata" JSONB,
    "checkId" TEXT,

    CONSTRAINT "FraudFlag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SuspiciousActivityReport" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "reportType" TEXT,
    "details" JSONB,
    "metadata" JSONB,
    "checkId" TEXT,

    CONSTRAINT "SuspiciousActivityReport_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudEvent" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "anchorTxHash" TEXT,
    "applicationId" TEXT,
    "eventType" TEXT,
    "signal" JSONB,
    "payload" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudAiInferenceLog" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "modelVersion" TEXT,
    "inference" JSONB,
    "confidence" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "FraudAiInferenceLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudEscalation" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "escalationLevel" TEXT,
    "reason" TEXT,
    "metadata" JSONB,

    CONSTRAINT "FraudEscalation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudEscalationPipelineLayer" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "layerName" TEXT,
    "output" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudEscalationPipelineLayer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudAnomalyDetection" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "anomalyScore" DOUBLE PRECISION,
    "signals" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudAnomalyDetection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudFeatureStore" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "features" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudFeatureStore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudCluster" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "clusterId" TEXT,
    "signals" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudCluster_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudTrajectoryModel" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "trajectory" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudTrajectoryModel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudPropagationModel" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "propagation" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudPropagationModel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudContagionMapping" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "contagion" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudContagionMapping_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudTemporalEvolution" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "evolution" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudTemporalEvolution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudNetworkMapping" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "network" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudNetworkMapping_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudPatternEvolution" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "patterns" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudPatternEvolution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudSignalChain" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "chain" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudSignalChain_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudResult" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "score" DOUBLE PRECISION,
    "signals" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudSignalOutput" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "signalType" TEXT,
    "strength" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "FraudSignalOutput_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudAnomalyOutput" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "anomalyScore" DOUBLE PRECISION,
    "details" JSONB,
    "metadata" JSONB,

    CONSTRAINT "FraudAnomalyOutput_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BehaviorProfile" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "leadId" TEXT,
    "investorId" TEXT,
    "profileType" TEXT,
    "metrics" JSONB,
    "metadata" JSONB,

    CONSTRAINT "BehaviorProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BehaviorEvent" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "leadId" TEXT,
    "investorId" TEXT,
    "eventType" TEXT,
    "page" TEXT,
    "element" TEXT,
    "description" TEXT,
    "responseTimeMs" INTEGER,
    "lateNight" BOOLEAN,
    "metadata" JSONB,
    "behaviorProfileId" TEXT,

    CONSTRAINT "BehaviorEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BehavioralScoringLayer" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "layerName" TEXT,
    "score" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "BehavioralScoringLayer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BehavioralTrendAnalytics" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "trends" JSONB,
    "metadata" JSONB,

    CONSTRAINT "BehavioralTrendAnalytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BluetoothEvent" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "leadId" TEXT,
    "eventType" TEXT,
    "deviceId" TEXT,
    "rssi" INTEGER,
    "metadata" JSONB,

    CONSTRAINT "BluetoothEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BluetoothAlert" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "alertType" TEXT,
    "deviceId" TEXT,
    "rssi" INTEGER,
    "metadata" JSONB,

    CONSTRAINT "BluetoothAlert_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BluetoothRiskEvent" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "riskScore" DOUBLE PRECISION,
    "signals" JSONB,
    "metadata" JSONB,

    CONSTRAINT "BluetoothRiskEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BluetoothAnomalyResult" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "anomalyScore" DOUBLE PRECISION,
    "signals" JSONB,
    "metadata" JSONB,

    CONSTRAINT "BluetoothAnomalyResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerBehavioralRiskLayer" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "borrowerId" TEXT,
    "riskScore" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "BorrowerBehavioralRiskLayer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerBehavioralDrift" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "borrowerId" TEXT,
    "drift" JSONB,
    "driftScore" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "BorrowerBehavioralDrift_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerRepaymentResilience" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "borrowerId" TEXT,
    "resilienceScore" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "BorrowerRepaymentResilience_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerRetentionAnalytics" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "borrowerId" TEXT,
    "retentionScore" DOUBLE PRECISION,
    "signals" JSONB,
    "metadata" JSONB,

    CONSTRAINT "BorrowerRetentionAnalytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerHardshipAnalytics" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "borrowerId" TEXT,
    "hardshipScore" DOUBLE PRECISION,
    "indicators" JSONB,
    "metadata" JSONB,

    CONSTRAINT "BorrowerHardshipAnalytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerFinancialStability" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "borrowerId" TEXT,
    "stabilityScore" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "BorrowerFinancialStability_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerFinancialDrift" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "borrowerId" TEXT,
    "driftScore" DOUBLE PRECISION,
    "drift" JSONB,
    "metadata" JSONB,

    CONSTRAINT "BorrowerFinancialDrift_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerMacroRiskExposure" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "borrowerId" TEXT,
    "macroFactors" JSONB,
    "exposureScore" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "BorrowerMacroRiskExposure_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerRiskScore" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "borrowerId" TEXT,
    "score" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "BorrowerRiskScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerBehaviorScore" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "borrowerId" TEXT,
    "behaviorScore" DOUBLE PRECISION,
    "patterns" JSONB,
    "metadata" JSONB,

    CONSTRAINT "BorrowerBehaviorScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerFinancialScore" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "borrowerId" TEXT,
    "financialScore" DOUBLE PRECISION,
    "metrics" JSONB,
    "metadata" JSONB,

    CONSTRAINT "BorrowerFinancialScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScoringResult" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "fraudScore" DOUBLE PRECISION,
    "riskScore" DOUBLE PRECISION,
    "impulsivenessScore" DOUBLE PRECISION,
    "signals" JSONB,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "ScoringResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestorLiquidity" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "investorId" TEXT,
    "liquidityScore" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "InvestorLiquidity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestorPerformanceSnapshot" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "investorId" TEXT,
    "metrics" JSONB,
    "metadata" JSONB,

    CONSTRAINT "InvestorPerformanceSnapshot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestorRiskBandHistory" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "investorId" TEXT,
    "band" TEXT,
    "timestamp" TIMESTAMP(3),
    "metadata" JSONB,

    CONSTRAINT "InvestorRiskBandHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestorCapitalFlow" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "investorId" TEXT,
    "flowAmount" DOUBLE PRECISION,
    "flowType" TEXT,
    "metadata" JSONB,

    CONSTRAINT "InvestorCapitalFlow_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestorAllocationDynamics" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "investorId" TEXT,
    "allocation" JSONB,
    "dynamics" JSONB,
    "metadata" JSONB,

    CONSTRAINT "InvestorAllocationDynamics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestorDiversificationAnalytics" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "investorId" TEXT,
    "diversificationScore" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "InvestorDiversificationAnalytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestorRiskScore" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "investorId" TEXT,
    "investorSecondaryId" TEXT,
    "score" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "InvestorRiskScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestorBehaviorScore" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "investorId" TEXT,
    "investorSecondaryId" TEXT,
    "behaviorScore" DOUBLE PRECISION,
    "patterns" JSONB,
    "metadata" JSONB,

    CONSTRAINT "InvestorBehaviorScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestorLiquidityScore" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "investorId" TEXT,
    "investorSecondaryId" TEXT,
    "liquidityScore" DOUBLE PRECISION,
    "metrics" JSONB,
    "metadata" JSONB,

    CONSTRAINT "InvestorLiquidityScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PipelineConversionAnalytics" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "stage" TEXT,
    "conversionRate" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "PipelineConversionAnalytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PipelinePerformanceSnapshot" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "snapshotType" TEXT,
    "metrics" JSONB,
    "metadata" JSONB,

    CONSTRAINT "PipelinePerformanceSnapshot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PipelineVelocity" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "stage" TEXT,
    "velocity" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "PipelineVelocity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PipelineStageResult" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "stage" TEXT,
    "metrics" JSONB,
    "metadata" JSONB,

    CONSTRAINT "PipelineStageResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PipelineVelocityResult" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "velocity" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "PipelineVelocityResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LoanRestructuringAnalytics" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "restructuringScore" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "LoanRestructuringAnalytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LoanCovenantTracking" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "covenants" JSONB,
    "status" TEXT,
    "metadata" JSONB,

    CONSTRAINT "LoanCovenantTracking_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LoanCovenantStress" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "stressScore" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "LoanCovenantStress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LoanPerformanceTrajectory" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "trajectory" JSONB,
    "performanceScore" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "LoanPerformanceTrajectory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LoanRepaymentCurve" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "curve" JSONB,
    "metadata" JSONB,

    CONSTRAINT "LoanRepaymentCurve_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LoanStressTest" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "stressType" TEXT,
    "results" JSONB,
    "metadata" JSONB,

    CONSTRAINT "LoanStressTest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CovenantBreach" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "breachType" TEXT,
    "details" JSONB,
    "metadata" JSONB,

    CONSTRAINT "CovenantBreach_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CovenantStressResult" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "stressScore" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "CovenantStressResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StressTestScenario" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "scenarioType" TEXT,
    "parameters" JSONB,
    "metadata" JSONB,

    CONSTRAINT "StressTestScenario_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StressTestResult" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "results" JSONB,
    "metadata" JSONB,

    CONSTRAINT "StressTestResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LoanServicingEvent" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "servicingRecordId" TEXT,
    "eventType" TEXT,
    "payload" JSONB,
    "metadata" JSONB,

    CONSTRAINT "LoanServicingEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ServicingEventScore" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "servicingRecordId" TEXT,
    "score" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "ServicingEventScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Check" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "bankProfileId" TEXT,
    "amount" DOUBLE PRECISION,
    "checkNumber" TEXT,
    "routingNumber" TEXT,
    "accountNumber" TEXT,
    "metadata" JSONB,
    "payee" TEXT,
    "memo" TEXT,
    "status" TEXT,
    "pdfUrl" TEXT,
    "date" TIMESTAMP(3),
    "anchorRecordId" TEXT,
    "signerId" TEXT,

    CONSTRAINT "Check_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BankProfile" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "name" TEXT,
    "routingNumber" TEXT,
    "riskScore" DOUBLE PRECISION,
    "metadata" JSONB,
    "bankName" TEXT,
    "accountNumber" TEXT,
    "accountType" TEXT,
    "signatureImage" TEXT,
    "nextCheckNumber" INTEGER,
    "signerName" TEXT,

    CONSTRAINT "BankProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Signer" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT,
    "signatureUrl" TEXT,
    "metadata" JSONB,
    "bankProfileId" TEXT,

    CONSTRAINT "Signer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationScoringPipeline" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "pipelineName" TEXT,
    "steps" JSONB,
    "finalScore" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "ApplicationScoringPipeline_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationWorkflowAiLayer" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "layerName" TEXT,
    "output" JSONB,
    "metadata" JSONB,

    CONSTRAINT "ApplicationWorkflowAiLayer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationAiScoring" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "score" DOUBLE PRECISION,
    "factors" JSONB,
    "metadata" JSONB,
    "fico" INTEGER,
    "income" INTEGER,
    "propertyType" TEXT,

    CONSTRAINT "ApplicationAiScoring_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationRiskLadder" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "ladder" JSONB,
    "metadata" JSONB,

    CONSTRAINT "ApplicationRiskLadder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationComplianceLadder" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "ladder" JSONB,
    "metadata" JSONB,

    CONSTRAINT "ApplicationComplianceLadder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationFraudRiskLadder" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "ladder" JSONB,
    "metadata" JSONB,

    CONSTRAINT "ApplicationFraudRiskLadder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationComplianceSignalChain" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "chain" JSONB,
    "metadata" JSONB,

    CONSTRAINT "ApplicationComplianceSignalChain_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationFraudSignalChain" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "chain" JSONB,
    "metadata" JSONB,

    CONSTRAINT "ApplicationFraudSignalChain_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationDocumentCompleteness" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "completenessScore" DOUBLE PRECISION,
    "missingDocuments" JSONB,
    "metadata" JSONB,

    CONSTRAINT "ApplicationDocumentCompleteness_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LoanAmortization" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT NOT NULL,
    "schedule" JSONB,
    "metadata" JSONB,

    CONSTRAINT "LoanAmortization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LoanPayoff" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT NOT NULL,
    "payoffAmount" DOUBLE PRECISION,
    "payoffDate" TIMESTAMP(3),
    "metadata" JSONB,

    CONSTRAINT "LoanPayoff_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LoanDelinquency" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT NOT NULL,
    "delinquencyStatus" TEXT,
    "daysLate" INTEGER,
    "metadata" JSONB,

    CONSTRAINT "LoanDelinquency_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentComplianceScore" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "documentId" TEXT,
    "score" DOUBLE PRECISION,
    "issues" JSONB,
    "metadata" JSONB,

    CONSTRAINT "DocumentComplianceScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentTransformationLog" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "documentId" TEXT,
    "transformationType" TEXT,
    "details" JSONB,
    "metadata" JSONB,

    CONSTRAINT "DocumentTransformationLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentAiClassificationLayer" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "documentId" TEXT,
    "layerName" TEXT,
    "category" TEXT,
    "confidence" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "DocumentAiClassificationLayer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PipelineDeal" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "investorId" TEXT,
    "name" TEXT,
    "status" TEXT,
    "metadata" JSONB,

    CONSTRAINT "PipelineDeal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AnchorRecord" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "merkleRoot" TEXT,
    "txHash" TEXT,
    "anchorTxHash" TEXT,
    "metadata" JSONB,

    CONSTRAINT "AnchorRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScoreRecord" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "applicationId" TEXT,
    "fraudScore" DOUBLE PRECISION,
    "riskScore" DOUBLE PRECISION,
    "impulsivenessScore" DOUBLE PRECISION,
    "signals" JSONB,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "ScoreRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserRiskScore" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "fraudScore" DOUBLE PRECISION,
    "riskScore" DOUBLE PRECISION,
    "impulsivenessScore" DOUBLE PRECISION,
    "signals" JSONB,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "UserRiskScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LeadScoringResult" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "leadId" TEXT,
    "userId" INTEGER,
    "fraudScore" DOUBLE PRECISION,
    "riskScore" DOUBLE PRECISION,
    "impulsivenessScore" DOUBLE PRECISION,
    "signals" JSONB,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "LeadScoringResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserRiskSignal" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,
    "signalType" TEXT,
    "strength" DOUBLE PRECISION,
    "fraudScore" DOUBLE PRECISION,
    "riskScore" DOUBLE PRECISION,
    "impulsivenessScore" DOUBLE PRECISION,
    "signals" JSONB,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "UserRiskSignal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestorScoringResult" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "investorId" TEXT,
    "userId" INTEGER,
    "fraudScore" DOUBLE PRECISION,
    "riskScore" DOUBLE PRECISION,
    "impulsivenessScore" DOUBLE PRECISION,
    "signals" JSONB,
    "factors" JSONB,
    "metadata" JSONB,

    CONSTRAINT "InvestorScoringResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ServicingRiskSignal" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT,
    "servicingRecordId" TEXT,
    "signalType" TEXT,
    "strength" DOUBLE PRECISION,
    "metadata" JSONB,

    CONSTRAINT "ServicingRiskSignal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OwnershipEntity" (
    "id" SERIAL NOT NULL,
    "ownerId" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "ein" TEXT,
    "type" TEXT NOT NULL,
    "ownershipPercent" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OwnershipEntity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Property" (
    "id" SERIAL NOT NULL,
    "ownershipEntityId" INTEGER NOT NULL,
    "ownerId" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "zip" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "purchasePrice" INTEGER NOT NULL,
    "currentValue" INTEGER,
    "acquisitionDate" TIMESTAMP(3),
    "cashflow" DOUBLE PRECISION NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Property_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RentRoll" (
    "id" SERIAL NOT NULL,
    "propertyId" INTEGER NOT NULL,
    "unitNumber" TEXT,
    "rent" INTEGER NOT NULL,
    "leaseStart" TIMESTAMP(3),
    "leaseEnd" TIMESTAMP(3),
    "tenantName" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RentRoll_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PropertyFinancials" (
    "id" SERIAL NOT NULL,
    "propertyId" INTEGER NOT NULL,
    "noi" INTEGER,
    "capRate" DOUBLE PRECISION,
    "expenses" INTEGER,
    "taxes" INTEGER,
    "insurance" INTEGER,
    "maintenance" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PropertyFinancials_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OwnerEquity" (
    "id" SERIAL NOT NULL,
    "propertyId" INTEGER NOT NULL,
    "equityAmount" INTEGER NOT NULL,
    "equityPercent" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OwnerEquity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MortgageAsset" (
    "id" TEXT NOT NULL,
    "ownerId" TEXT NOT NULL,
    "borrowerId" TEXT,
    "loanAmount" INTEGER NOT NULL,
    "interestRate" DOUBLE PRECISION NOT NULL,
    "termMonths" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "currentBalance" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MortgageAsset_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PaymentHistory" (
    "id" SERIAL NOT NULL,
    "mortgageAssetId" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "principal" INTEGER,
    "interest" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PaymentHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MortgagePerformance" (
    "id" SERIAL NOT NULL,
    "mortgageAssetId" TEXT NOT NULL,
    "dti" DOUBLE PRECISION,
    "ltv" DOUBLE PRECISION,
    "cltv" DOUBLE PRECISION,
    "riskScore" DOUBLE PRECISION,
    "behaviorScore" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MortgagePerformance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LlpaGrid" (
    "id" SERIAL NOT NULL,
    "investor" TEXT NOT NULL,
    "productType" TEXT NOT NULL,
    "purpose" TEXT NOT NULL,
    "occupancy" TEXT NOT NULL,
    "ficoMin" INTEGER NOT NULL,
    "ficoMax" INTEGER NOT NULL,
    "ltvMin" DOUBLE PRECISION NOT NULL,
    "ltvMax" DOUBLE PRECISION NOT NULL,
    "termMonths" INTEGER NOT NULL,
    "llpaBps" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "LlpaGrid_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwritingAssetSnapshot" (
    "id" SERIAL NOT NULL,
    "ownerId" INTEGER NOT NULL,
    "propertyId" INTEGER NOT NULL,
    "mortgageAssetId" INTEGER,
    "assetQualityScore" INTEGER NOT NULL,
    "cashflowScore" INTEGER NOT NULL,
    "riskScore" INTEGER NOT NULL,
    "diversificationImpact" INTEGER NOT NULL,
    "valuationJson" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UnderwritingAssetSnapshot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RiskSnapshot" (
    "id" SERIAL NOT NULL,
    "loanId" INTEGER NOT NULL,
    "ltv" DOUBLE PRECISION NOT NULL,
    "dscr" DOUBLE PRECISION NOT NULL,
    "riskScore" INTEGER NOT NULL,
    "delinquencyJson" JSONB NOT NULL,
    "marketJson" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RiskSnapshot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerProfile" (
    "id" TEXT NOT NULL,
    "borrowerId" TEXT NOT NULL,
    "applicationId" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "middleInitial" TEXT,
    "lastName" TEXT NOT NULL,
    "suffix" TEXT,
    "dob" TIMESTAMP(3) NOT NULL,
    "ssn" TEXT NOT NULL,
    "phone" TEXT,
    "email" TEXT,
    "address" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "zip" TEXT NOT NULL,
    "yearsAtAddress" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BorrowerProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerEmployment" (
    "id" TEXT NOT NULL,
    "borrowerId" TEXT NOT NULL,
    "applicationId" TEXT NOT NULL,
    "employerName" TEXT NOT NULL,
    "jobTitle" TEXT,
    "employmentType" TEXT,
    "startDate" TIMESTAMP(3),
    "yearsInProfession" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BorrowerEmployment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerIncome" (
    "id" TEXT NOT NULL,
    "borrowerId" TEXT NOT NULL,
    "applicationId" TEXT NOT NULL,
    "w2IncomeAnnual" INTEGER,
    "w2IncomeMonthly" INTEGER,
    "contractorIncomeAnnual" INTEGER,
    "contractorIncomeMonthly" INTEGER,
    "selfEmploymentIncomeAnnual" INTEGER,
    "selfEmploymentIncomeMonthly" INTEGER,
    "otherIncomeAnnual" INTEGER,
    "otherIncomeMonthly" INTEGER,
    "totalIncomeMonthly" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BorrowerIncome_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerAssets" (
    "id" TEXT NOT NULL,
    "borrowerId" TEXT NOT NULL,
    "applicationId" TEXT NOT NULL,
    "checkingBalance" INTEGER,
    "savingsBalance" INTEGER,
    "cashOnHand" INTEGER,
    "retirementBalance" INTEGER,
    "investmentBalance" INTEGER,
    "otherAssets" INTEGER,
    "totalAssets" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BorrowerAssets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerLiabilities" (
    "id" TEXT NOT NULL,
    "borrowerId" TEXT NOT NULL,
    "applicationId" TEXT NOT NULL,
    "creditCardPayments" INTEGER,
    "autoLoanPayments" INTEGER,
    "studentLoanPayments" INTEGER,
    "personalLoanPayments" INTEGER,
    "collectionsPayments" INTEGER,
    "otherDebtPayments" INTEGER,
    "totalMonthlyDebt" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BorrowerLiabilities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerProperty" (
    "id" TEXT NOT NULL,
    "borrowerId" TEXT NOT NULL,
    "applicationId" TEXT NOT NULL,
    "propertyAddress" TEXT NOT NULL,
    "propertyCity" TEXT NOT NULL,
    "propertyState" TEXT NOT NULL,
    "propertyZip" TEXT NOT NULL,
    "occupancyType" TEXT,
    "propertyType" TEXT,
    "purchasePrice" INTEGER,
    "estimatedValue" INTEGER,
    "loanAmount" INTEGER,
    "downPayment" INTEGER,
    "downPaymentSource" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BorrowerProperty_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerDeclarations" (
    "id" TEXT NOT NULL,
    "borrowerId" TEXT NOT NULL,
    "applicationId" TEXT NOT NULL,
    "bankruptcy" BOOLEAN,
    "foreclosure" BOOLEAN,
    "judgments" BOOLEAN,
    "delinquentFederalDebt" BOOLEAN,
    "alimonyChildSupport" BOOLEAN,
    "coMakerEndorser" BOOLEAN,
    "ownershipInterest" BOOLEAN,
    "outstandingLiens" BOOLEAN,
    "citizenshipStatus" TEXT,
    "militaryService" BOOLEAN,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BorrowerDeclarations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerDemographics" (
    "id" TEXT NOT NULL,
    "borrowerId" TEXT NOT NULL,
    "applicationId" TEXT NOT NULL,
    "ethnicity" TEXT,
    "race" TEXT,
    "sex" TEXT,
    "collectionMethod" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BorrowerDemographics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnderwriterDecision" (
    "id" TEXT NOT NULL,
    "underwriterId" TEXT NOT NULL,
    "applicationId" TEXT NOT NULL,
    "decision" TEXT NOT NULL,
    "decisionTimeMs" INTEGER NOT NULL,
    "finalOutcome" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "UnderwriterDecision_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FundingRequest" (
    "id" TEXT NOT NULL,
    "investorId" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "type" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FundingRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdminMessage" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AdminMessage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentApproval" (
    "id" TEXT NOT NULL,
    "investorId" TEXT NOT NULL,
    "documentId" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DocumentApproval_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestorOnboarding" (
    "id" TEXT NOT NULL,
    "investorId" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "InvestorOnboarding_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdminNotification" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AdminNotification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudReview" (
    "id" TEXT NOT NULL,
    "investorId" TEXT NOT NULL,
    "caseId" TEXT NOT NULL,
    "riskScore" DOUBLE PRECISION NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'OPEN',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FraudReview_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PortfolioAdjustment" (
    "id" TEXT NOT NULL,
    "investorId" TEXT NOT NULL,
    "assetClass" TEXT NOT NULL,
    "oldValue" DOUBLE PRECISION NOT NULL,
    "newValue" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PortfolioAdjustment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Deal" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "summary" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Deal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Investment" (
    "id" TEXT NOT NULL,
    "investorId" TEXT NOT NULL,
    "dealId" INTEGER NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "status" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Investment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Commitment" (
    "id" SERIAL NOT NULL,
    "investorId" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "status" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Commitment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BorrowerDocument" (
    "id" TEXT NOT NULL,
    "borrowerId" TEXT NOT NULL,
    "applicationId" TEXT,
    "type" TEXT NOT NULL,
    "fileUrl" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'uploaded',
    "notes" TEXT,
    "uploadedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "BorrowerDocument_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Owner" (
    "id" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "email" TEXT,
    "fullName" TEXT,

    CONSTRAINT "Owner_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tenant" (
    "id" TEXT NOT NULL,
    "propertyId" INTEGER NOT NULL,
    "fullName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "rentAmount" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Tenant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Payment" (
    "id" TEXT NOT NULL,
    "propertyId" INTEGER NOT NULL,
    "tenantId" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "paidAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MaintenanceRequest" (
    "id" TEXT NOT NULL,
    "propertyId" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'open',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MaintenanceRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentRequirement" (
    "id" TEXT NOT NULL,
    "applicationId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "label" TEXT NOT NULL,
    "required" BOOLEAN NOT NULL,
    "reason" TEXT,
    "satisfied" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DocumentRequirement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LoanOfficer" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "LoanOfficer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingAuditLog" (
    "id" TEXT NOT NULL,
    "actorRole" TEXT NOT NULL,
    "actorId" TEXT,
    "action" TEXT NOT NULL,
    "module" TEXT NOT NULL,
    "details" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PricingAuditLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ServicingRecord" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    "nextPaymentDue" TIMESTAMP(3),
    "escrowBalance" DOUBLE PRECISION DEFAULT 0,
    "delinquencyDays" INTEGER DEFAULT 0,
    "performanceScore" DOUBLE PRECISION DEFAULT 0,

    CONSTRAINT "ServicingRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Task" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'OPEN',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "borrowerId" TEXT,
    "leadId" TEXT,

    CONSTRAINT "Task_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Session" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastActiveAt" TIMESTAMP(3),
    "ipAddress" TEXT,
    "revoked" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Borrower_email_key" ON "Borrower"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Borrower_userId_key" ON "Borrower"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "DocumentLineage_documentId_key" ON "DocumentLineage"("documentId");

-- CreateIndex
CREATE UNIQUE INDEX "DocumentSemanticExtraction_documentId_key" ON "DocumentSemanticExtraction"("documentId");

-- CreateIndex
CREATE UNIQUE INDEX "DocumentStructuralAnalysis_documentId_key" ON "DocumentStructuralAnalysis"("documentId");

-- CreateIndex
CREATE UNIQUE INDEX "DocumentExtractionPipeline_documentId_key" ON "DocumentExtractionPipeline"("documentId");

-- CreateIndex
CREATE UNIQUE INDEX "DocumentEmbedding_id_key" ON "DocumentEmbedding"("id");

-- CreateIndex
CREATE UNIQUE INDEX "DisclosureLifecycleAnalytics_disclosureId_key" ON "DisclosureLifecycleAnalytics"("disclosureId");

-- CreateIndex
CREATE UNIQUE INDEX "DisclosureComplianceLayer_disclosureId_key" ON "DisclosureComplianceLayer"("disclosureId");

-- CreateIndex
CREATE UNIQUE INDEX "DisclosureBehaviorAnalytics_disclosureId_key" ON "DisclosureBehaviorAnalytics"("disclosureId");

-- CreateIndex
CREATE UNIQUE INDEX "DisclosureBehaviorTrajectory_disclosureId_key" ON "DisclosureBehaviorTrajectory"("disclosureId");

-- CreateIndex
CREATE UNIQUE INDEX "DisclosureSentimentAnalytics_disclosureId_key" ON "DisclosureSentimentAnalytics"("disclosureId");

-- CreateIndex
CREATE UNIQUE INDEX "DisclosureEngagementAnalytics_disclosureId_key" ON "DisclosureEngagementAnalytics"("disclosureId");

-- CreateIndex
CREATE UNIQUE INDEX "UnderwritingCase_id_key" ON "UnderwritingCase"("id");

-- CreateIndex
CREATE UNIQUE INDEX "UnderwritingCase_applicationId_key" ON "UnderwritingCase"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "UnderwritingProbabilisticScoring_underwritingCaseId_key" ON "UnderwritingProbabilisticScoring"("underwritingCaseId");

-- CreateIndex
CREATE UNIQUE INDEX "UnderwritingDecisionTree_underwritingCaseId_key" ON "UnderwritingDecisionTree"("underwritingCaseId");

-- CreateIndex
CREATE UNIQUE INDEX "UnderwritingPipelineOutput_applicationId_key" ON "UnderwritingPipelineOutput"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "PricingEngineAudit_applicationId_key" ON "PricingEngineAudit"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "PricingEngineInferenceLog_applicationId_key" ON "PricingEngineInferenceLog"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "PricingComponentScoring_applicationId_key" ON "PricingComponentScoring"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "PricingOptimizationLayer_applicationId_key" ON "PricingOptimizationLayer"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "PricingSensitivityLayer_applicationId_key" ON "PricingSensitivityLayer"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "PricingAnomalyDetection_applicationId_key" ON "PricingAnomalyDetection"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "PricingCurveFitting_applicationId_key" ON "PricingCurveFitting"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "PricingVolatilityTracking_applicationId_key" ON "PricingVolatilityTracking"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "PricingElasticityAnalytics_applicationId_key" ON "PricingElasticityAnalytics"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "InvestorPricingSheet_investorId_key" ON "InvestorPricingSheet"("investorId");

-- CreateIndex
CREATE UNIQUE INDEX "PricingScenario_applicationId_key" ON "PricingScenario"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "PricingResult_applicationId_key" ON "PricingResult"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudAiInferenceLog_applicationId_key" ON "FraudAiInferenceLog"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudEscalation_applicationId_key" ON "FraudEscalation"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudEscalationPipelineLayer_applicationId_key" ON "FraudEscalationPipelineLayer"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudAnomalyDetection_applicationId_key" ON "FraudAnomalyDetection"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudFeatureStore_applicationId_key" ON "FraudFeatureStore"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudCluster_applicationId_key" ON "FraudCluster"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudTrajectoryModel_applicationId_key" ON "FraudTrajectoryModel"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudPropagationModel_applicationId_key" ON "FraudPropagationModel"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudContagionMapping_applicationId_key" ON "FraudContagionMapping"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudTemporalEvolution_applicationId_key" ON "FraudTemporalEvolution"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudNetworkMapping_applicationId_key" ON "FraudNetworkMapping"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudPatternEvolution_applicationId_key" ON "FraudPatternEvolution"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudSignalChain_applicationId_key" ON "FraudSignalChain"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudResult_applicationId_key" ON "FraudResult"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudSignalOutput_applicationId_key" ON "FraudSignalOutput"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "FraudAnomalyOutput_applicationId_key" ON "FraudAnomalyOutput"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "BorrowerBehavioralRiskLayer_borrowerId_key" ON "BorrowerBehavioralRiskLayer"("borrowerId");

-- CreateIndex
CREATE UNIQUE INDEX "BorrowerBehavioralDrift_borrowerId_key" ON "BorrowerBehavioralDrift"("borrowerId");

-- CreateIndex
CREATE UNIQUE INDEX "BorrowerRepaymentResilience_borrowerId_key" ON "BorrowerRepaymentResilience"("borrowerId");

-- CreateIndex
CREATE UNIQUE INDEX "BorrowerRetentionAnalytics_borrowerId_key" ON "BorrowerRetentionAnalytics"("borrowerId");

-- CreateIndex
CREATE UNIQUE INDEX "BorrowerHardshipAnalytics_borrowerId_key" ON "BorrowerHardshipAnalytics"("borrowerId");

-- CreateIndex
CREATE UNIQUE INDEX "BorrowerFinancialStability_borrowerId_key" ON "BorrowerFinancialStability"("borrowerId");

-- CreateIndex
CREATE UNIQUE INDEX "BorrowerFinancialDrift_borrowerId_key" ON "BorrowerFinancialDrift"("borrowerId");

-- CreateIndex
CREATE UNIQUE INDEX "BorrowerMacroRiskExposure_borrowerId_key" ON "BorrowerMacroRiskExposure"("borrowerId");

-- CreateIndex
CREATE UNIQUE INDEX "BorrowerRiskScore_borrowerId_key" ON "BorrowerRiskScore"("borrowerId");

-- CreateIndex
CREATE UNIQUE INDEX "BorrowerBehaviorScore_borrowerId_key" ON "BorrowerBehaviorScore"("borrowerId");

-- CreateIndex
CREATE UNIQUE INDEX "BorrowerFinancialScore_borrowerId_key" ON "BorrowerFinancialScore"("borrowerId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoringResult_applicationId_key" ON "ScoringResult"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "InvestorRiskScore_investorId_key" ON "InvestorRiskScore"("investorId");

-- CreateIndex
CREATE UNIQUE INDEX "InvestorRiskScore_investorSecondaryId_key" ON "InvestorRiskScore"("investorSecondaryId");

-- CreateIndex
CREATE UNIQUE INDEX "InvestorBehaviorScore_investorId_key" ON "InvestorBehaviorScore"("investorId");

-- CreateIndex
CREATE UNIQUE INDEX "InvestorBehaviorScore_investorSecondaryId_key" ON "InvestorBehaviorScore"("investorSecondaryId");

-- CreateIndex
CREATE UNIQUE INDEX "InvestorLiquidityScore_investorId_key" ON "InvestorLiquidityScore"("investorId");

-- CreateIndex
CREATE UNIQUE INDEX "InvestorLiquidityScore_investorSecondaryId_key" ON "InvestorLiquidityScore"("investorSecondaryId");

-- CreateIndex
CREATE UNIQUE INDEX "LoanRestructuringAnalytics_applicationId_key" ON "LoanRestructuringAnalytics"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "LoanCovenantTracking_applicationId_key" ON "LoanCovenantTracking"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "LoanCovenantStress_applicationId_key" ON "LoanCovenantStress"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "LoanPerformanceTrajectory_applicationId_key" ON "LoanPerformanceTrajectory"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "LoanRepaymentCurve_applicationId_key" ON "LoanRepaymentCurve"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "LoanStressTest_applicationId_key" ON "LoanStressTest"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "CovenantBreach_applicationId_key" ON "CovenantBreach"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "CovenantStressResult_applicationId_key" ON "CovenantStressResult"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "StressTestScenario_applicationId_key" ON "StressTestScenario"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "StressTestResult_applicationId_key" ON "StressTestResult"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "ServicingEventScore_applicationId_key" ON "ServicingEventScore"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "ServicingEventScore_servicingRecordId_key" ON "ServicingEventScore"("servicingRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "Check_applicationId_key" ON "Check"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "Check_anchorRecordId_key" ON "Check"("anchorRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "ApplicationScoringPipeline_applicationId_key" ON "ApplicationScoringPipeline"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "ApplicationWorkflowAiLayer_applicationId_key" ON "ApplicationWorkflowAiLayer"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "ApplicationAiScoring_applicationId_key" ON "ApplicationAiScoring"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "ApplicationRiskLadder_applicationId_key" ON "ApplicationRiskLadder"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "ApplicationComplianceLadder_applicationId_key" ON "ApplicationComplianceLadder"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "ApplicationFraudRiskLadder_applicationId_key" ON "ApplicationFraudRiskLadder"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "ApplicationComplianceSignalChain_applicationId_key" ON "ApplicationComplianceSignalChain"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "ApplicationFraudSignalChain_applicationId_key" ON "ApplicationFraudSignalChain"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "ApplicationDocumentCompleteness_applicationId_key" ON "ApplicationDocumentCompleteness"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "LoanAmortization_applicationId_key" ON "LoanAmortization"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "LoanPayoff_applicationId_key" ON "LoanPayoff"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "LoanDelinquency_applicationId_key" ON "LoanDelinquency"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "DocumentComplianceScore_documentId_key" ON "DocumentComplianceScore"("documentId");

-- CreateIndex
CREATE UNIQUE INDEX "DocumentTransformationLog_documentId_key" ON "DocumentTransformationLog"("documentId");

-- CreateIndex
CREATE UNIQUE INDEX "DocumentAiClassificationLayer_documentId_key" ON "DocumentAiClassificationLayer"("documentId");

-- CreateIndex
CREATE UNIQUE INDEX "PipelineDeal_applicationId_key" ON "PipelineDeal"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "AnchorRecord_applicationId_key" ON "AnchorRecord"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoreRecord_userId_key" ON "ScoreRecord"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "UserRiskScore_userId_key" ON "UserRiskScore"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "LeadScoringResult_userId_key" ON "LeadScoringResult"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "UserRiskSignal_userId_key" ON "UserRiskSignal"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "InvestorScoringResult_userId_key" ON "InvestorScoringResult"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "ServicingRiskSignal_applicationId_key" ON "ServicingRiskSignal"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "ServicingRiskSignal_servicingRecordId_key" ON "ServicingRiskSignal"("servicingRecordId");

-- CreateIndex
CREATE UNIQUE INDEX "PropertyFinancials_propertyId_key" ON "PropertyFinancials"("propertyId");

-- CreateIndex
CREATE UNIQUE INDEX "OwnerEquity_propertyId_key" ON "OwnerEquity"("propertyId");

-- CreateIndex
CREATE UNIQUE INDEX "MortgagePerformance_mortgageAssetId_key" ON "MortgagePerformance"("mortgageAssetId");

-- CreateIndex
CREATE INDEX "FundingRequest_investorId_idx" ON "FundingRequest"("investorId");

-- CreateIndex
CREATE UNIQUE INDEX "Owner_userId_key" ON "Owner"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "LoanOfficer_email_key" ON "LoanOfficer"("email");

-- CreateIndex
CREATE UNIQUE INDEX "ServicingRecord_applicationId_key" ON "ServicingRecord"("applicationId");

-- AddForeignKey
ALTER TABLE "Investor" ADD CONSTRAINT "Investor_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorBehavior" ADD CONSTRAINT "InvestorBehavior_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Lead" ADD CONSTRAINT "Lead_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LeadEvent" ADD CONSTRAINT "LeadEvent_leadId_fkey" FOREIGN KEY ("leadId") REFERENCES "Lead"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ContactAttempt" ADD CONSTRAINT "ContactAttempt_leadId_fkey" FOREIGN KEY ("leadId") REFERENCES "Lead"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AuditLog" ADD CONSTRAINT "AuditLog_adminId_fkey" FOREIGN KEY ("adminId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Audit" ADD CONSTRAINT "Audit_adminId_fkey" FOREIGN KEY ("adminId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_loanOfficerId_fkey" FOREIGN KEY ("loanOfficerId") REFERENCES "LoanOfficer"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_underwritingPipelineOutputId_fkey" FOREIGN KEY ("underwritingPipelineOutputId") REFERENCES "UnderwritingPipelineOutput"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TimelineEvent" ADD CONSTRAINT "TimelineEvent_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Timeline" ADD CONSTRAINT "Timeline_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationMilestone" ADD CONSTRAINT "ApplicationMilestone_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Document" ADD CONSTRAINT "Document_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentClassification" ADD CONSTRAINT "DocumentClassification_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentOcrExtraction" ADD CONSTRAINT "DocumentOcrExtraction_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentVersion" ADD CONSTRAINT "DocumentVersion_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentLineage" ADD CONSTRAINT "DocumentLineage_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentSemanticExtraction" ADD CONSTRAINT "DocumentSemanticExtraction_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentStructuralAnalysis" ADD CONSTRAINT "DocumentStructuralAnalysis_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentExtractionPipeline" ADD CONSTRAINT "DocumentExtractionPipeline_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentEmbedding" ADD CONSTRAINT "DocumentEmbedding_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentSemanticScore" ADD CONSTRAINT "DocumentSemanticScore_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentRiskSignal" ADD CONSTRAINT "DocumentRiskSignal_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Disclosure" ADD CONSTRAINT "Disclosure_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DisclosureCompliance" ADD CONSTRAINT "DisclosureCompliance_disclosureId_fkey" FOREIGN KEY ("disclosureId") REFERENCES "Disclosure"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DisclosureTracking" ADD CONSTRAINT "DisclosureTracking_disclosureId_fkey" FOREIGN KEY ("disclosureId") REFERENCES "Disclosure"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DisclosureAuditTrail" ADD CONSTRAINT "DisclosureAuditTrail_disclosureId_fkey" FOREIGN KEY ("disclosureId") REFERENCES "Disclosure"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DisclosureComplianceSnapshot" ADD CONSTRAINT "DisclosureComplianceSnapshot_disclosureId_fkey" FOREIGN KEY ("disclosureId") REFERENCES "Disclosure"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DisclosureLifecycleAnalytics" ADD CONSTRAINT "DisclosureLifecycleAnalytics_disclosureId_fkey" FOREIGN KEY ("disclosureId") REFERENCES "Disclosure"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DisclosureComplianceLayer" ADD CONSTRAINT "DisclosureComplianceLayer_disclosureId_fkey" FOREIGN KEY ("disclosureId") REFERENCES "Disclosure"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DisclosureBehaviorAnalytics" ADD CONSTRAINT "DisclosureBehaviorAnalytics_disclosureId_fkey" FOREIGN KEY ("disclosureId") REFERENCES "Disclosure"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DisclosureBehaviorTrajectory" ADD CONSTRAINT "DisclosureBehaviorTrajectory_disclosureId_fkey" FOREIGN KEY ("disclosureId") REFERENCES "Disclosure"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DisclosureSentimentAnalytics" ADD CONSTRAINT "DisclosureSentimentAnalytics_disclosureId_fkey" FOREIGN KEY ("disclosureId") REFERENCES "Disclosure"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DisclosureEngagementAnalytics" ADD CONSTRAINT "DisclosureEngagementAnalytics_disclosureId_fkey" FOREIGN KEY ("disclosureId") REFERENCES "Disclosure"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingCase" ADD CONSTRAINT "UnderwritingCase_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingEvent" ADD CONSTRAINT "UnderwritingEvent_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingStep" ADD CONSTRAINT "UnderwritingStep_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingDecision" ADD CONSTRAINT "UnderwritingDecision_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingRule" ADD CONSTRAINT "UnderwritingRule_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingRuleEvaluation" ADD CONSTRAINT "UnderwritingRuleEvaluation_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingRuleEvaluation" ADD CONSTRAINT "UnderwritingRuleEvaluation_ruleId_fkey" FOREIGN KEY ("ruleId") REFERENCES "UnderwritingRule"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingAutomation" ADD CONSTRAINT "UnderwritingAutomation_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingExceptionLog" ADD CONSTRAINT "UnderwritingExceptionLog_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingExceptionEscalation" ADD CONSTRAINT "UnderwritingExceptionEscalation_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingSnapshot" ADD CONSTRAINT "UnderwritingSnapshot_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingAiDecisionLog" ADD CONSTRAINT "UnderwritingAiDecisionLog_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingRuleChain" ADD CONSTRAINT "UnderwritingRuleChain_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingChainAnalytics" ADD CONSTRAINT "UnderwritingChainAnalytics_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingOverrideLog" ADD CONSTRAINT "UnderwritingOverrideLog_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingProbabilisticScoring" ADD CONSTRAINT "UnderwritingProbabilisticScoring_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingDecisionTree" ADD CONSTRAINT "UnderwritingDecisionTree_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingCalibrationLog" ADD CONSTRAINT "UnderwritingCalibrationLog_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingScoreResult" ADD CONSTRAINT "UnderwritingScoreResult_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingPipelineOutput" ADD CONSTRAINT "UnderwritingPipelineOutput_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingRiskFactors" ADD CONSTRAINT "UnderwritingRiskFactors_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwritingDecisionOutput" ADD CONSTRAINT "UnderwritingDecisionOutput_underwritingCaseId_fkey" FOREIGN KEY ("underwritingCaseId") REFERENCES "UnderwritingCase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingEngineAudit" ADD CONSTRAINT "PricingEngineAudit_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingEngineInferenceLog" ADD CONSTRAINT "PricingEngineInferenceLog_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingComponentScoring" ADD CONSTRAINT "PricingComponentScoring_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingOptimizationLayer" ADD CONSTRAINT "PricingOptimizationLayer_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingSensitivityLayer" ADD CONSTRAINT "PricingSensitivityLayer_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingAnomalyDetection" ADD CONSTRAINT "PricingAnomalyDetection_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingCurveFitting" ADD CONSTRAINT "PricingCurveFitting_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingVolatilityTracking" ADD CONSTRAINT "PricingVolatilityTracking_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingElasticityAnalytics" ADD CONSTRAINT "PricingElasticityAnalytics_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorPricingSheet" ADD CONSTRAINT "InvestorPricingSheet_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LlpaGridRow" ADD CONSTRAINT "LlpaGridRow_pricingSheetId_fkey" FOREIGN KEY ("pricingSheetId") REFERENCES "InvestorPricingSheet"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductOverlay" ADD CONSTRAINT "ProductOverlay_pricingSheetId_fkey" FOREIGN KEY ("pricingSheetId") REFERENCES "InvestorPricingSheet"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NonQMPricingRule" ADD CONSTRAINT "NonQMPricingRule_pricingSheetId_fkey" FOREIGN KEY ("pricingSheetId") REFERENCES "InvestorPricingSheet"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingScenario" ADD CONSTRAINT "PricingScenario_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingResult" ADD CONSTRAINT "PricingResult_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudScore" ADD CONSTRAINT "FraudScore_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudPipeline" ADD CONSTRAINT "FraudPipeline_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudSignal" ADD CONSTRAINT "FraudSignal_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudCaseHistory" ADD CONSTRAINT "FraudCaseHistory_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudFlag" ADD CONSTRAINT "FraudFlag_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudFlag" ADD CONSTRAINT "FraudFlag_checkId_fkey" FOREIGN KEY ("checkId") REFERENCES "Check"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SuspiciousActivityReport" ADD CONSTRAINT "SuspiciousActivityReport_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SuspiciousActivityReport" ADD CONSTRAINT "SuspiciousActivityReport_checkId_fkey" FOREIGN KEY ("checkId") REFERENCES "Check"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudEvent" ADD CONSTRAINT "FraudEvent_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudEvent" ADD CONSTRAINT "FraudEvent_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudAiInferenceLog" ADD CONSTRAINT "FraudAiInferenceLog_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudEscalation" ADD CONSTRAINT "FraudEscalation_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudEscalationPipelineLayer" ADD CONSTRAINT "FraudEscalationPipelineLayer_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudAnomalyDetection" ADD CONSTRAINT "FraudAnomalyDetection_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudFeatureStore" ADD CONSTRAINT "FraudFeatureStore_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudCluster" ADD CONSTRAINT "FraudCluster_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudTrajectoryModel" ADD CONSTRAINT "FraudTrajectoryModel_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudPropagationModel" ADD CONSTRAINT "FraudPropagationModel_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudContagionMapping" ADD CONSTRAINT "FraudContagionMapping_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudTemporalEvolution" ADD CONSTRAINT "FraudTemporalEvolution_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudNetworkMapping" ADD CONSTRAINT "FraudNetworkMapping_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudPatternEvolution" ADD CONSTRAINT "FraudPatternEvolution_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudSignalChain" ADD CONSTRAINT "FraudSignalChain_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudResult" ADD CONSTRAINT "FraudResult_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudSignalOutput" ADD CONSTRAINT "FraudSignalOutput_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudAnomalyOutput" ADD CONSTRAINT "FraudAnomalyOutput_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BehaviorProfile" ADD CONSTRAINT "BehaviorProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BehaviorProfile" ADD CONSTRAINT "BehaviorProfile_leadId_fkey" FOREIGN KEY ("leadId") REFERENCES "Lead"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BehaviorProfile" ADD CONSTRAINT "BehaviorProfile_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BehaviorEvent" ADD CONSTRAINT "BehaviorEvent_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BehaviorEvent" ADD CONSTRAINT "BehaviorEvent_leadId_fkey" FOREIGN KEY ("leadId") REFERENCES "Lead"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BehaviorEvent" ADD CONSTRAINT "BehaviorEvent_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BehaviorEvent" ADD CONSTRAINT "BehaviorEvent_behaviorProfileId_fkey" FOREIGN KEY ("behaviorProfileId") REFERENCES "BehaviorProfile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BehavioralScoringLayer" ADD CONSTRAINT "BehavioralScoringLayer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BehavioralTrendAnalytics" ADD CONSTRAINT "BehavioralTrendAnalytics_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BluetoothEvent" ADD CONSTRAINT "BluetoothEvent_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BluetoothEvent" ADD CONSTRAINT "BluetoothEvent_leadId_fkey" FOREIGN KEY ("leadId") REFERENCES "Lead"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BluetoothAlert" ADD CONSTRAINT "BluetoothAlert_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BluetoothRiskEvent" ADD CONSTRAINT "BluetoothRiskEvent_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerBehavioralRiskLayer" ADD CONSTRAINT "BorrowerBehavioralRiskLayer_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerBehavioralDrift" ADD CONSTRAINT "BorrowerBehavioralDrift_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerRepaymentResilience" ADD CONSTRAINT "BorrowerRepaymentResilience_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerRetentionAnalytics" ADD CONSTRAINT "BorrowerRetentionAnalytics_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerHardshipAnalytics" ADD CONSTRAINT "BorrowerHardshipAnalytics_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerFinancialStability" ADD CONSTRAINT "BorrowerFinancialStability_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerFinancialDrift" ADD CONSTRAINT "BorrowerFinancialDrift_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerMacroRiskExposure" ADD CONSTRAINT "BorrowerMacroRiskExposure_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerRiskScore" ADD CONSTRAINT "BorrowerRiskScore_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerBehaviorScore" ADD CONSTRAINT "BorrowerBehaviorScore_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerFinancialScore" ADD CONSTRAINT "BorrowerFinancialScore_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoringResult" ADD CONSTRAINT "ScoringResult_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorLiquidity" ADD CONSTRAINT "InvestorLiquidity_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorPerformanceSnapshot" ADD CONSTRAINT "InvestorPerformanceSnapshot_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorRiskBandHistory" ADD CONSTRAINT "InvestorRiskBandHistory_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorCapitalFlow" ADD CONSTRAINT "InvestorCapitalFlow_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorAllocationDynamics" ADD CONSTRAINT "InvestorAllocationDynamics_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorDiversificationAnalytics" ADD CONSTRAINT "InvestorDiversificationAnalytics_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorRiskScore" ADD CONSTRAINT "InvestorRiskScore_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorRiskScore" ADD CONSTRAINT "InvestorRiskScore_investorSecondaryId_fkey" FOREIGN KEY ("investorSecondaryId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorBehaviorScore" ADD CONSTRAINT "InvestorBehaviorScore_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorBehaviorScore" ADD CONSTRAINT "InvestorBehaviorScore_investorSecondaryId_fkey" FOREIGN KEY ("investorSecondaryId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorLiquidityScore" ADD CONSTRAINT "InvestorLiquidityScore_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorLiquidityScore" ADD CONSTRAINT "InvestorLiquidityScore_investorSecondaryId_fkey" FOREIGN KEY ("investorSecondaryId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LoanRestructuringAnalytics" ADD CONSTRAINT "LoanRestructuringAnalytics_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LoanCovenantTracking" ADD CONSTRAINT "LoanCovenantTracking_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LoanCovenantStress" ADD CONSTRAINT "LoanCovenantStress_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LoanPerformanceTrajectory" ADD CONSTRAINT "LoanPerformanceTrajectory_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LoanRepaymentCurve" ADD CONSTRAINT "LoanRepaymentCurve_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LoanStressTest" ADD CONSTRAINT "LoanStressTest_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CovenantBreach" ADD CONSTRAINT "CovenantBreach_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CovenantStressResult" ADD CONSTRAINT "CovenantStressResult_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StressTestScenario" ADD CONSTRAINT "StressTestScenario_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StressTestResult" ADD CONSTRAINT "StressTestResult_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LoanServicingEvent" ADD CONSTRAINT "LoanServicingEvent_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LoanServicingEvent" ADD CONSTRAINT "LoanServicingEvent_servicingRecordId_fkey" FOREIGN KEY ("servicingRecordId") REFERENCES "ServicingRecord"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServicingEventScore" ADD CONSTRAINT "ServicingEventScore_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServicingEventScore" ADD CONSTRAINT "ServicingEventScore_servicingRecordId_fkey" FOREIGN KEY ("servicingRecordId") REFERENCES "ServicingRecord"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Check" ADD CONSTRAINT "Check_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Check" ADD CONSTRAINT "Check_bankProfileId_fkey" FOREIGN KEY ("bankProfileId") REFERENCES "BankProfile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Check" ADD CONSTRAINT "Check_anchorRecordId_fkey" FOREIGN KEY ("anchorRecordId") REFERENCES "AnchorRecord"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Check" ADD CONSTRAINT "Check_signerId_fkey" FOREIGN KEY ("signerId") REFERENCES "Signer"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Signer" ADD CONSTRAINT "Signer_bankProfileId_fkey" FOREIGN KEY ("bankProfileId") REFERENCES "BankProfile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationScoringPipeline" ADD CONSTRAINT "ApplicationScoringPipeline_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationWorkflowAiLayer" ADD CONSTRAINT "ApplicationWorkflowAiLayer_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationAiScoring" ADD CONSTRAINT "ApplicationAiScoring_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationRiskLadder" ADD CONSTRAINT "ApplicationRiskLadder_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationComplianceLadder" ADD CONSTRAINT "ApplicationComplianceLadder_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationFraudRiskLadder" ADD CONSTRAINT "ApplicationFraudRiskLadder_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationComplianceSignalChain" ADD CONSTRAINT "ApplicationComplianceSignalChain_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationFraudSignalChain" ADD CONSTRAINT "ApplicationFraudSignalChain_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationDocumentCompleteness" ADD CONSTRAINT "ApplicationDocumentCompleteness_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LoanAmortization" ADD CONSTRAINT "LoanAmortization_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LoanPayoff" ADD CONSTRAINT "LoanPayoff_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LoanDelinquency" ADD CONSTRAINT "LoanDelinquency_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentComplianceScore" ADD CONSTRAINT "DocumentComplianceScore_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentTransformationLog" ADD CONSTRAINT "DocumentTransformationLog_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentAiClassificationLayer" ADD CONSTRAINT "DocumentAiClassificationLayer_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PipelineDeal" ADD CONSTRAINT "PipelineDeal_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PipelineDeal" ADD CONSTRAINT "PipelineDeal_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AnchorRecord" ADD CONSTRAINT "AnchorRecord_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoreRecord" ADD CONSTRAINT "ScoreRecord_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoreRecord" ADD CONSTRAINT "ScoreRecord_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserRiskScore" ADD CONSTRAINT "UserRiskScore_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LeadScoringResult" ADD CONSTRAINT "LeadScoringResult_leadId_fkey" FOREIGN KEY ("leadId") REFERENCES "Lead"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LeadScoringResult" ADD CONSTRAINT "LeadScoringResult_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserRiskSignal" ADD CONSTRAINT "UserRiskSignal_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorScoringResult" ADD CONSTRAINT "InvestorScoringResult_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorScoringResult" ADD CONSTRAINT "InvestorScoringResult_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServicingRiskSignal" ADD CONSTRAINT "ServicingRiskSignal_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServicingRiskSignal" ADD CONSTRAINT "ServicingRiskSignal_servicingRecordId_fkey" FOREIGN KEY ("servicingRecordId") REFERENCES "ServicingRecord"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OwnershipEntity" ADD CONSTRAINT "OwnershipEntity_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property" ADD CONSTRAINT "Property_ownershipEntityId_fkey" FOREIGN KEY ("ownershipEntityId") REFERENCES "OwnershipEntity"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property" ADD CONSTRAINT "Property_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "Owner"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RentRoll" ADD CONSTRAINT "RentRoll_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PropertyFinancials" ADD CONSTRAINT "PropertyFinancials_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OwnerEquity" ADD CONSTRAINT "OwnerEquity_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MortgageAsset" ADD CONSTRAINT "MortgageAsset_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "Owner"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MortgageAsset" ADD CONSTRAINT "MortgageAsset_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentHistory" ADD CONSTRAINT "PaymentHistory_mortgageAssetId_fkey" FOREIGN KEY ("mortgageAssetId") REFERENCES "MortgageAsset"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MortgagePerformance" ADD CONSTRAINT "MortgagePerformance_mortgageAssetId_fkey" FOREIGN KEY ("mortgageAssetId") REFERENCES "MortgageAsset"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerProfile" ADD CONSTRAINT "BorrowerProfile_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerProfile" ADD CONSTRAINT "BorrowerProfile_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerEmployment" ADD CONSTRAINT "BorrowerEmployment_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerEmployment" ADD CONSTRAINT "BorrowerEmployment_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerIncome" ADD CONSTRAINT "BorrowerIncome_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerIncome" ADD CONSTRAINT "BorrowerIncome_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerAssets" ADD CONSTRAINT "BorrowerAssets_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerAssets" ADD CONSTRAINT "BorrowerAssets_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerLiabilities" ADD CONSTRAINT "BorrowerLiabilities_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerLiabilities" ADD CONSTRAINT "BorrowerLiabilities_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerProperty" ADD CONSTRAINT "BorrowerProperty_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerProperty" ADD CONSTRAINT "BorrowerProperty_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerDeclarations" ADD CONSTRAINT "BorrowerDeclarations_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerDeclarations" ADD CONSTRAINT "BorrowerDeclarations_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerDemographics" ADD CONSTRAINT "BorrowerDemographics_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerDemographics" ADD CONSTRAINT "BorrowerDemographics_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnderwriterDecision" ADD CONSTRAINT "UnderwriterDecision_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FundingRequest" ADD CONSTRAINT "FundingRequest_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentApproval" ADD CONSTRAINT "DocumentApproval_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentApproval" ADD CONSTRAINT "DocumentApproval_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvestorOnboarding" ADD CONSTRAINT "InvestorOnboarding_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudReview" ADD CONSTRAINT "FraudReview_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraudReview" ADD CONSTRAINT "FraudReview_caseId_fkey" FOREIGN KEY ("caseId") REFERENCES "UnderwritingCase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PortfolioAdjustment" ADD CONSTRAINT "PortfolioAdjustment_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Investment" ADD CONSTRAINT "Investment_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Investment" ADD CONSTRAINT "Investment_dealId_fkey" FOREIGN KEY ("dealId") REFERENCES "Deal"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Commitment" ADD CONSTRAINT "Commitment_investorId_fkey" FOREIGN KEY ("investorId") REFERENCES "Investor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerDocument" ADD CONSTRAINT "BorrowerDocument_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BorrowerDocument" ADD CONSTRAINT "BorrowerDocument_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Owner" ADD CONSTRAINT "Owner_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tenant" ADD CONSTRAINT "Tenant_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payment" ADD CONSTRAINT "Payment_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MaintenanceRequest" ADD CONSTRAINT "MaintenanceRequest_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentRequirement" ADD CONSTRAINT "DocumentRequirement_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServicingRecord" ADD CONSTRAINT "ServicingRecord_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_borrowerId_fkey" FOREIGN KEY ("borrowerId") REFERENCES "Borrower"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Task" ADD CONSTRAINT "Task_leadId_fkey" FOREIGN KEY ("leadId") REFERENCES "Lead"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
