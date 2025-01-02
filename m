Return-Path: <linux-can+bounces-2520-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1724D9FFEF2
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 19:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D143E162B7F
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 18:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292AB18BBAE;
	Thu,  2 Jan 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="KX3nHo6B"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2110.outbound.protection.outlook.com [40.107.20.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2128614F9F7
	for <linux-can@vger.kernel.org>; Thu,  2 Jan 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844312; cv=fail; b=UZEK1nhEYQ3T0PUEkaXu4Lz7HmooquDDJ2VdcsmlAg7Z09WvP2+svf2LrAExFRUu4ae6k6ewto/2Kko+oK4SUMQWw7Lokq8AEjGy3fOWqDkP3LVQT4PIjhiL8IVb332ZUFVCl/StTh7jH0p76I/P1WLQuH7H96vqKKgHpo2L22g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844312; c=relaxed/simple;
	bh=9784VvNqHCOWB6mdAMdUBAwJo/p31IKwQBxwWWHRNa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLbKS9YNytuEEJcNMaSwNV5SS2/EcbQrKrJGtHraKYlszm7UOsvfgMKXgtRKuWTQLqD5tu60Kh5d9jpJZCFkK62TiZsYki+RJU7/M/5I4lQZrA/PN4ee2cuc79zye05pbsmvWjeXOLtgHr8IRoF8uVQPp1bMMz1ShnH5ztoxfUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=KX3nHo6B; arc=fail smtp.client-ip=40.107.20.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLAZmJ9liybDVoDncLehQ51uVKFtu/SXt2CByynSDpUQoGRkrXk6kMgUhJNWbh0b4phCVvXXFr5aUt13NSsUwqLbB6u3lY/8sZkZ0wA2XzXUKlSf+QNHKXCR7T5NXj2nAtD7/QvOY7b98d2ea/BR0GgMeYXQ+AGlyuYoGVJDhX3Krm+8pz957u4MMr5wg3w5EswG7UmJ4CvFFintG/uvkqkocdVspjWu6n3fk43lYE9LRFyGTGn+7ZPh8CywVmQeCSBUVxVA642Yqw/6rH6HSk2ksYC2OUn0/mJJ3guRQwYAx2EZcieysx3kaF3L0hcbUN65HjP+/haWmUyAIupGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+HZXg0hj5oh+1G4NsVvm5CVc2/lGNsYTgQ1P5UY0mY=;
 b=pClPxtXHz8YxbkHyU5aNvbA5twBq+ElQsBWXfV8X7IGocLzWUjO5atKMFWt8Bn2C4B6yA7wbr7uqcbO5/Ax0H0z0K5nBwIMpWJma3IMnEgbBpoBRPO9iLQgsfTT/lKr2v8ecSrZbnMWUNpBwLQV4rAa545WPVGrrlC/NtUgqPMDldQmx9KfQQ6OiCqM12dbglmeHHsWi6egadAoBVPFFssPEQPsQTM5veJLmBGAF7YGy2LfcdaIKbeP9xhSsMIt+xTEDSnc9HeXv28NQlCKGntLMVaRU39CH6Jk4m0mwyxfZM/mm1JA28gllwyVSlNShA25+gpp62x1y3ZVTpCzkvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=gmail.com smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+HZXg0hj5oh+1G4NsVvm5CVc2/lGNsYTgQ1P5UY0mY=;
 b=KX3nHo6BQ7TVRhFCnYHrwx5nlgMeMH454qhMqzgmshuP7vojSruga2PNOyboBBdZ49HLwL5Nni++MvESyWJIOLmUTV21RLLun7rDuhiOnoQHhgQOlPDN9qyT0TKsXqu+M4+Rq5ZWjZApp6+kJrPAmVL4XGLwwHae1n8UG22bSUc=
Received: from PA7P264CA0251.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:371::19)
 by AM0PR03MB6258.eurprd03.prod.outlook.com (2603:10a6:20b:159::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Thu, 2 Jan
 2025 18:58:22 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:102:371:cafe::8c) by PA7P264CA0251.outlook.office365.com
 (2603:10a6:102:371::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Thu,
 2 Jan 2025 18:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server id 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:58:21
 +0000
Received: from debby.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 69A177C16CB;
	Thu,  2 Jan 2025 19:58:21 +0100 (CET)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 60DB32E8046; Thu,  2 Jan 2025 19:58:21 +0100 (CET)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Robert Nawrath <mbro1689@gmail.com>
Subject: [RFC PATCH 2/6] can: esd_402_pci: Add support to control TDC mode and settings
Date: Thu,  2 Jan 2025 19:58:17 +0100
Message-Id: <20250102185821.670839-3-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250102185821.670839-1-stefan.maetje@esd.eu>
References: <20250102185821.670839-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000199:EE_|AM0PR03MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: d6172756-5415-43a8-ac87-08dd2b5f6d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzJqSVphWWVhOSsxSDlLMzJNL0tHNkxPODdtK2xMZUdxMkFSZ0ZDSVFQanVh?=
 =?utf-8?B?OVozY1hTOVYyYjFCZzE4UzBTbGxibllYWkhJQXBIOVVjTnlGS2Nab21VZmo3?=
 =?utf-8?B?aUNtb2EwSnlvT2pvcG16c0lrWVlienRSOHFYenlQcHcvZlNtLzdiRlMxNmJN?=
 =?utf-8?B?dGp6ekR5cnBhZVUxbTJnQm5YZVZ1UEpMV0NraS84aUtXbnA0eUZLVSs1UmpG?=
 =?utf-8?B?UUEzZDQzWkhsd2VJV29JOGlNZnZRYUIwRzg0cDhwdjg1cWNYcElRZFpoWUJK?=
 =?utf-8?B?Ukhlc0FMMmtNdkFGTnZlb2tQSDJ4VWo3a3JEUkd1THNoZlVPQ1lzTktoVzRO?=
 =?utf-8?B?V3NSb2ZOR2tKN09pZGNxL1h0dUwrNWZ6cnFpMmhOeFZLRFJsNnpwZTNSV3dt?=
 =?utf-8?B?eDRVM2dUSzQ3am1raG4wc25HdEYrSjlZVUVJK0hRTW5zNHM5d2gvUzh4M2Y1?=
 =?utf-8?B?UlNYS0wrV292dkdHUEtMdDVURzFSZVdoL1c2ZjhnZzM3ME1KTDFQQXdjdGcy?=
 =?utf-8?B?a2xuaTFKWnJ2RU5DTFJoOGQzbCt6cEhaakdOYUtMVjBtTzdkWlg4UTh3VXdt?=
 =?utf-8?B?eFFLeUxHVTh4ZkdiZHJ1bUkyaE43Qk5GSk5YaVJQV20rSTF3bGRFL1NsYUZW?=
 =?utf-8?B?YmxtemJXekd5U1NHZ01zbW9LQmY4ODJpT0JuSThZRTk2V1puYnhBTUtSc2U3?=
 =?utf-8?B?clNtRG5MWVRTTjU0THRrR3BpVVdQaTQ1MXZHaDQ5ZURCWHRiNWZSdCtIUWRy?=
 =?utf-8?B?RXlPWVNhc05PaVVFWTkxdGs3M2JnVi9CeWZja2Ntb1ZxSFNlckZNQnh3ZUlE?=
 =?utf-8?B?bW5VR1hHdi91L3oyWFpJLzlEL200bENab3NVRWRRQ3RaSUwwbEFsdmtlMzNy?=
 =?utf-8?B?aHpjNWhRMS8yYXJLRjg1clB2ejZPbVBQRkpvSE9tdW5JbDVhYW9BTENwNzVT?=
 =?utf-8?B?aVZxYmliY1EvR21QNHNoTU9BZUc5SnBXQ1h0NmFtSTNtL3RkbldQOU1jT3Nk?=
 =?utf-8?B?SDBVL0FsSmtRU2x3OS9ycXJxdGREKzAzdkJaMitqWDZkb2N1RHpWY3JnclVM?=
 =?utf-8?B?elJpRnpiTXN6Q3cxNFRVUStSZEJpR29OSDMrVml1bldRQXlyR1d5dDk3Z3dE?=
 =?utf-8?B?QVI2SjdEWW54YnFKbWVGT3hNdEQwR2VXaFE5YUV3VGlDQko1VVlqdk8zUlA1?=
 =?utf-8?B?RWlFY0V0bjcrMXZVVkpOTWhyWjJ0YUZ0REh1UENKcmpnajNIUWhaaWZsNHY0?=
 =?utf-8?B?dmMxYTR2MDl0ais3eTZBZzlmaGFGME0yUmlSRktnUGRpY0NkUUw0Z05xckRm?=
 =?utf-8?B?eHRJdHRLbmMvanZCcTlkcklscDQ0TEpwcERONXljMnlGMzZLVWlkb0wwL1lH?=
 =?utf-8?B?NTVKMnVTSi9lZExhYkNVRnFrdFgxbk9wbDFYK2tudjdiNXVvbXNqcjF4N2RD?=
 =?utf-8?B?QlZxb0twTUdIUEtWSFdWNFJBRVp1UFVHMHlzYUFlOXkyYU1LYjZlMTZGa0Ju?=
 =?utf-8?B?TXBZYVBNYnZsdUQ2VkI4cnFoaTFhbHZEdEpyelRFb2NTbU5kQlRKYW5DbW8z?=
 =?utf-8?B?WloxTkNHMS85MzBySlpIdmppSkhDa2JJWjhGVDk0MkFMNFFLVVVOcERxeWpN?=
 =?utf-8?B?cWp4WFo4TTBkeXQyTTdqR09oeTZxdWRHYklyMEV6WkRiOXZTSDhqOEViTXln?=
 =?utf-8?B?NEpBaGdNREF4Y2FESUNwMm5iZlJUSEh2VGs3cWIyTlZkMHUyNGRSaXRES0sr?=
 =?utf-8?B?Tm9GcEpiWTJFNnVhdEhEQURSVDZURlJjL1V4WHhZYUxaNlBOTTRWRGRNS0dM?=
 =?utf-8?B?TEs0cUFsUGZkSlZmdWtSb3hFeldJVnVySkRhdy9HQ1NjYmxxMHQvc2MwUXRy?=
 =?utf-8?B?UlNESC9INVhYWG84YXUyN3lHSDNFcWlpbktUdm03eW41RjRmQzAweXE5czBp?=
 =?utf-8?B?RWZMT2RkSlhwSWxPL09qU3pQUmx3MUNZSXNNd29pb3B6MHdaQ1FJSmFkT2k1?=
 =?utf-8?Q?IKYHu+fUMHT5FmjkgHdjhztVmdCPR8=3D?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:58:21.6175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6172756-5415-43a8-ac87-08dd2b5f6d96
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6258

Add the feature to control the TDC mode and (offset) settings via the
netlink interface.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/esd/esd_402_pci-core.c |  17 +++-
 drivers/net/can/esd/esdacc.c           | 111 ++++++++++++++++++++++++-
 drivers/net/can/esd/esdacc.h           |  14 ++++
 3 files changed, 138 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/esd/esd_402_pci-core.c b/drivers/net/can/esd/esd_402_pci-core.c
index 0c0fc159a1cb..03df04251c03 100644
--- a/drivers/net/can/esd/esd_402_pci-core.c
+++ b/drivers/net/can/esd/esd_402_pci-core.c
@@ -95,6 +95,17 @@ static const struct can_bittiming_const pci402fd_data_bittiming_const = {
 	.brp_inc = 1,
 };
 
+/* Transmitter Delay Compensation constants for esdACC controller
+ */
+static const struct can_tdc_const pci402fd_tdc_const = {
+	.tdcv_min = 0,
+	.tdcv_max = 0,
+	.tdco_min = 0,
+	.tdco_max = 63,
+	.tdcf_min = 2,
+	.tdcf_max = 63,
+};
+
 static const struct net_device_ops pci402_acc_netdev_ops = {
 	.ndo_open = acc_open,
 	.ndo_stop = acc_close,
@@ -396,9 +407,13 @@ static int pci402_init_cores(struct pci_dev *pdev)
 		if (card->ov.features & ACC_OV_REG_FEAT_MASK_DAR)
 			priv->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
 		if (card->ov.features & ACC_OV_REG_FEAT_MASK_CANFD) {
-			priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
+			priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
+				CAN_CTRLMODE_TDC_AUTO |
+				CAN_CTRLMODE_TDC_MANUAL;
 			priv->can.bittiming_const = &pci402fd_nom_bittiming_const;
 			priv->can.data_bittiming_const = &pci402fd_data_bittiming_const;
+			priv->can.tdc_const = &pci402fd_tdc_const;
+			priv->can.do_get_auto_tdcv = acc_get_auto_tdcv;
 		} else {
 			priv->can.bittiming_const = &pci402_bittiming_const;
 		}
diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
index faad38e23251..0f1d32a7f812 100644
--- a/drivers/net/can/esd/esdacc.c
+++ b/drivers/net/can/esd/esdacc.c
@@ -418,6 +418,106 @@ int acc_set_mode(struct net_device *netdev, enum can_mode mode)
 	return 0;
 }
 
+/**
+ * acc_get_auto_tdcv() - get the TD measurement
+ *
+ * @netdev: CAN network device.
+ * @tdcv: pointer to TD measurement output
+ *
+ * This function returns the value of the last Transmitter Delay (TD) measurement
+ * if available.
+ *
+ * Return:
+ * * %0		- a valid TD measurement is returned
+ * * %-EINVAL	- no TD measurement available yet
+ */
+int acc_get_auto_tdcv(const struct net_device *netdev, u32 *tdcv)
+{
+	struct acc_net_priv *priv = netdev_priv(netdev);
+	int err;
+
+	*tdcv = FIELD_GET(ACC_REG_TDCR_TDC_MEAS, acc_read32(priv->core, ACC_CORE_OF_TDCR));
+
+	err = *tdcv > 0 ? 0 : -EINVAL;
+
+	return err;
+}
+
+/**
+ * acc_build_tdcr() - build TDC control register value from struct can_priv data
+ *
+ * @can: can_priv data structure
+ *
+ * This function builds the TDC control register value according to the three
+ * supported TDC modes:
+ *	- CAN_CTRLMODE_TDC_AUTO
+ *	- CAN_CTRLMODE_TDC_MANUAL
+ *	- none of them i. e. TDC off
+ *
+ * The measured transmitter delay is named here TD to distinguish it from
+ * the TDCV value possibly set via the netlink interface.
+ *
+ * The 6-bit value written to the ACC_REG_TDCR_TDC_OFFS field of the TDCR is
+ * named here TDC_REG_x. This field is a signed value TDC_REG_s in automatic mode
+ * and a unsigned value TDC_REG_u in manual mode.
+ *
+ * The esdACC controller is always aware of the SP setting and adds this amount of
+ * clocks to the TDC_REG_x contents.
+ *
+ * Automatic mode
+ *	SSP = TD + SP + TDC_REG_s = TD + SP + (absolute TDCO - SP)
+ *
+ *	Therefore TDC_REG_s is (absolute TDCO - SP) which is calculated by
+ *	can_get_relative_tdco().
+ *	This function provides access to a "full automatic mode" that is
+ *	selected with "tdc-mode auto tdco 0" which works always for all
+ *	bitrates (SSP will then be SSP = TD + SP + 0).
+ *
+ * Manual mode
+ *	SSP = SP + TDC_REG_u = SP + (absolute TDCO - SP)
+ *
+ *	Because there is no TDCV register in the esdACC core the
+ *	struct can_tdc_const::tdcv_* values specify that only
+ *	TDCV == 0 is supported.
+ *	Derived from the formula without TDCV TDC_REG_u is (absolute TDCO - SP)
+ *	which is calculated by can_get_relative_tdco(). "Negative" results
+ *	trigger a warning and are clamped to zero.
+ *
+ * TDC off
+ *	Set TDC control mode to ACC_TDC_MODE_OFF and clear all other fields.
+ *
+ * Return: TDC control values in esdACC TDCR format
+ */
+static u32 acc_build_tdcr(struct can_priv *can)
+{
+	u32 tdcr = FIELD_PREP(ACC_REG_TDCR_TDC_MIN, can->tdc.tdcf);
+	s32 tdc_rel_offset = 0;
+
+	tdc_rel_offset = can_get_relative_tdco(can);
+	if (can->ctrlmode & CAN_CTRLMODE_TDC_AUTO) {
+		if (can->tdc.tdco == 0U) {
+			/* Special case: Use "full automatic mode" feature. */
+			tdc_rel_offset = 0;
+		}
+		tdcr |= FIELD_PREP(ACC_REG_TDCR_TDC_MODE, ACC_TDC_MODE_AUTO);
+		tdcr |= FIELD_PREP(ACC_REG_TDCR_TDC_OFFS, tdc_rel_offset);
+
+	} else if (can->ctrlmode & CAN_CTRLMODE_TDC_MANUAL) {
+		if (tdc_rel_offset < 0) {
+			netdev_warn(can->dev, "TDC manual offset underflow: %d\n", tdc_rel_offset);
+			tdc_rel_offset = 0;
+		}
+		tdcr |= FIELD_PREP(ACC_REG_TDCR_TDC_MODE, ACC_TDC_MODE_MANUAL);
+		tdcr |= FIELD_PREP(ACC_REG_TDCR_TDC_OFFS, tdc_rel_offset);
+
+	} else {
+		/* Overwrite tdcr to clear ACC_REG_TDCR_TDC_MIN again. */
+		tdcr = FIELD_PREP(ACC_REG_TDCR_TDC_MODE, ACC_TDC_MODE_OFF);
+	}
+
+	return tdcr;
+}
+
 static void acc_set_bittiming(struct net_device *netdev)
 {
 	struct acc_net_priv *priv = netdev_priv(netdev);
@@ -431,7 +531,9 @@ static void acc_set_bittiming(struct net_device *netdev)
 		   "OAM?"[FIELD_GET(CAN_CTRLMODE_TDC_MASK, priv->can.ctrlmode)]);
 
 	if (priv->ov->features & ACC_OV_REG_FEAT_MASK_CANFD) {
+		/* Initialize fbtr and tdcr with reset state values. */
 		u32 fbtr = 0;
+		u32 tdcr = 0;
 
 		netdev_dbg(netdev, "nbit timing: brp %u, prop %u, ph1 %u ph2 %u, sjw %u\n",
 			   bt->brp, bt->prop_seg,
@@ -456,12 +558,15 @@ static void acc_set_bittiming(struct net_device *netdev)
 					  dbt->phase_seg1 + dbt->prop_seg - 1);
 			fbtr |= FIELD_PREP(ACC_REG_FBTR_FD_MASK_TSEG2, dbt->phase_seg2 - 1);
 			fbtr |= FIELD_PREP(ACC_REG_FBTR_FD_MASK_SJW, dbt->sjw - 1);
+
+			tdcr = acc_build_tdcr(&priv->can);
 		}
-		/* Write ACC_CORE_OF_FBTR last. */
+		/* Write ACC_CORE_OF_FBTR as last of bit timing registers. */
 		acc_write32(priv->core, ACC_CORE_OF_FBTR, fbtr);
+		acc_write32(priv->core, ACC_CORE_OF_TDCR, tdcr);
 
-		netdev_dbg(netdev, "esdACC: BRP %u, NBTR 0x%08x, DBTR 0x%08x",
-			   brp, btr, fbtr);
+		netdev_dbg(netdev, "esdACC: BRP %u, NBTR 0x%08x, DBTR 0x%08x, TDCR 0x%08x",
+			   brp, btr, fbtr, tdcr);
 	} else {
 		netdev_dbg(netdev, "bit timing: brp %u, prop %u, ph1 %u ph2 %u, sjw %u\n",
 			   bt->brp, bt->prop_seg,
diff --git a/drivers/net/can/esd/esdacc.h b/drivers/net/can/esd/esdacc.h
index fdbb017b80a9..33c6dbf60f6e 100644
--- a/drivers/net/can/esd/esdacc.h
+++ b/drivers/net/can/esd/esdacc.h
@@ -61,6 +61,7 @@
 #define ACC_CORE_OF_TXFIFO_STATUS 0x004c
 #define ACC_CORE_OF_TX_STATUS_IRQ 0x0050
 #define ACC_CORE_OF_TX_ABORT_MASK 0x0054
+#define ACC_CORE_OF_TDCR 0x5c
 #define ACC_CORE_OF_BM_IRQ_COUNTER 0x0070
 #define ACC_CORE_OF_TXFIFO_ID 0x00c0
 #define ACC_CORE_OF_TXFIFO_DLC 0x00c4
@@ -114,6 +115,18 @@
 #define ACC_REG_FBTR_FD_MASK_TSEG2 GENMASK(19, 16)
 #define ACC_REG_FBTR_FD_MASK_SJW GENMASK(27, 24)
 
+/* TDC register layout (TDCR) */
+#define ACC_REG_TDCR_TDC_MEAS GENMASK(5, 0)	/* RO: also known as TDCV on other controllers */
+#define ACC_REG_TDCR_TDC_MIN GENMASK(13, 8)	/* RW: also known as TDCF on other controllers */
+#define ACC_REG_TDCR_TDC_OFFS GENMASK(21, 16)	/* RW: mode dependent signed or unsigned offset */
+#define ACC_REG_TDCR_TDC_MODE GENMASK(31, 30)	/* RW: TDC operating mode */
+
+/* TDC operating modes for ACC_REG_TDCR_TDC_MODE field */
+#define ACC_TDC_MODE_AUTO 0
+#define ACC_TDC_MODE_MANUAL 1
+#define ACC_TDC_MODE_OFF 3
+
+
 /* 256 BM_MSGs of 32 byte size */
 #define ACC_CORE_DMAMSG_SIZE 32U
 #define ACC_CORE_DMABUF_SIZE (256U * ACC_CORE_DMAMSG_SIZE)
@@ -390,4 +403,5 @@ netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netdev);
 int acc_get_berr_counter(const struct net_device *netdev,
 			 struct can_berr_counter *bec);
 int acc_set_mode(struct net_device *netdev, enum can_mode mode);
+int acc_get_auto_tdcv(const struct net_device *netdev, u32 *tdcv);
 irqreturn_t acc_card_interrupt(struct acc_ov *ov, struct acc_core *cores);
-- 
2.34.1


