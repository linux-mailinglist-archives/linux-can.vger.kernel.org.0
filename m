Return-Path: <linux-can+bounces-2523-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8999FFEF6
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 19:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B0D7A1A73
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615BC7E782;
	Thu,  2 Jan 2025 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="WFwH6lbw"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022139.outbound.protection.outlook.com [52.101.66.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13C12DD95
	for <linux-can@vger.kernel.org>; Thu,  2 Jan 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844313; cv=fail; b=igRiPZ8aNiU9xanwKzWDWZ23JT3a56/0yiCvGFFbtNDK2aCBIB9+pXP7AmIW0t/bavSRM2Ese6RobVIO7p7ULRp1rhqE6N5IDL5uyNAGMaQbG8kAqUjwgbibOozRgEsPOmEU4b6z5Ro8KW+Gc4uJwMYpsm8j+Au9co7i+ggv1rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844313; c=relaxed/simple;
	bh=1GhURzftVTWrizJ8/TLhvdcty33LL1yU12mFq1R+A3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WN8lLFqNk/BqMEe7yKb9b95I9osU82CzaY1fRIJJneENsQWPMPPZyNJUTnR6ier+2YYCLTtMjd05hnq4aYu8hm6cgpcAVueaEf3lNWO6ADKlEwHSRDUlps/C3Jg+VFdFcWrxX+x04qrSsqFd46caNxryf+YxwCOfdH9nBHyJrK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=WFwH6lbw; arc=fail smtp.client-ip=52.101.66.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aukqHPJmp7uvDZkB6nX2z2cfnUqt2NI239N6enGYa7ZlrQCQC1DdV5+33I+gR4mou8AbhvApZspNaoAKoVpQ/wO9Sh56ay5rsyHistLifQy13O54WmwYo8Ln9HvQUHJMSd6BpZxoifmNk4BX0mWKaQa5xjhOeMsZv/hyTN21UDwe3t2+joQXYCv1E9tDar5HOl8S1NpvvbWdGd02cFQ9gKuoC1wcMsKZO/SACSoeOM4wVqV4uxW4L+DU3e8xEklrsLi8rYbipmGOxBh5TLLIx4gBrGoEL2F35mXFMDEeIaK+NCtIqXM/RoZighQi7zHPRxf7TkFGWq2nu4Fy9e7r5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrCffxMbHCOb46Lkak9slvxismUrrB/vCrZMEz23lZ0=;
 b=b7lcbPwbnhgIM/OnVvB2nrJzpMdvK3+y0Gxrfo5uzcWzDCB44Q6/qmihWz+c1l2mUIcuKW24s7PM2PI+cvn7xB+J1T0bD2KNXXL4gCTWmFw5LTLg5mZ5TkeC6SiyWwRdABB8PHBoKO3QWlP9M8mOIS7yQhBKfwaN5U8+rb8uKaW3mWt5Q0BqbN6L62ryATL8V2pa2JO89OZ26CwuMZiVrgHbdPlUBiB4Z3PPoUbnvlYXp9+EQ4TrroALjGuIWaeHz0JeWl9JsAIUbuOhnIYdlYBBCrltQWRjfkPO/e3xwykxOjCdcrwY6jh1CaKexan8JcFlOv812X67dvKYrUATDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=gmail.com smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrCffxMbHCOb46Lkak9slvxismUrrB/vCrZMEz23lZ0=;
 b=WFwH6lbwTWo+dIm61fN2lI4RJgQHfidm3xRoDvZJ/4DMSpRYgcWqn5QG28x8w4UVUNUK7m5UNOTMFqSVb9R4jaL3eNTYhd89E9lBqN4XXc1SQ7MWVjyfUKDEEih/Ni+nTBbP8/RCIosHFKWwP4GduS7PgHoKcFdm4TclsKZyzOA=
Received: from PAZP264CA0156.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f9::17)
 by AS8PR03MB8441.eurprd03.prod.outlook.com (2603:10a6:20b:52c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 18:58:22 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:102:1f9:cafe::8f) by PAZP264CA0156.outlook.office365.com
 (2603:10a6:102:1f9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Thu,
 2 Jan 2025 18:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server id 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:58:21
 +0000
Received: from debby.esd.local (jenkins.esd [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 6DDA47C16CC;
	Thu,  2 Jan 2025 19:58:21 +0100 (CET)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 63FAC2E8047; Thu,  2 Jan 2025 19:58:21 +0100 (CET)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Robert Nawrath <mbro1689@gmail.com>
Subject: [RFC PATCH 3/6] can: esd_402_pci: Add support for esdACC CAN-FD versions below 0.72
Date: Thu,  2 Jan 2025 19:58:18 +0100
Message-Id: <20250102185821.670839-4-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|AS8PR03MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c4a302-5b88-48a9-8b5c-08dd2b5f6d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MG1TQkxTRWk0dzdyckk2SVlLTndTZjlFY2NqdTF1MloxWkNhN1BOV1ZQdmFz?=
 =?utf-8?B?b25EVUxJdEZIWG95YXY3ZGo1YU9mM2ZpbEZDazRCSHRIVVlqdmpyT0p3aG4r?=
 =?utf-8?B?WGI4ZEp0eWYxS1VTOUpSaG5rTEhZajNZMkdRcUdaVjhGU0MvbkdobjM5ZXhq?=
 =?utf-8?B?ZW5QcE4rZlZtQUdUSklCM2hlejJobFljQTg4TFloVnVIWnVYZEgrODNXMWVj?=
 =?utf-8?B?QWdwU1dpTUZMaDRmTXUvZ0dUa01GY3RibndGV1J3ZG1PYlhrUXhScG5XMXZR?=
 =?utf-8?B?cUFyQlhxVk9kMnpWT3dsMjJMVEY5K3ZVQWRsZFBRN1U4dFMzUk9NRkMvZlRY?=
 =?utf-8?B?M0RjQmlRK3dyOElBeS8rL3AxN1p5NEFoWWh4cSt3TzR0TjZ6VVUzTHZJMCsr?=
 =?utf-8?B?SkJ3MXFXWktsUGdFbTlJMHRHZlppS0M4MmNoMjNCSWlwV1g5R2F6Mk5Qa0Nw?=
 =?utf-8?B?czdjSWNMN1l4bHY1bFNTdlF6eDVCQnFsclZUa2tlVFAzZUUxRmQ0T0tYOVE0?=
 =?utf-8?B?SHRVVC85Y1JSRVk3TUQrY2l0Y2t2ZVVOMFBZVk5kbjk0TVpoQ1MvMExUY2tZ?=
 =?utf-8?B?bWgxVjFJenV2VnAzMGprUGUzYXlTT1N1bE93MUlPdmZsZzdXL1BXc3o5L2JZ?=
 =?utf-8?B?RlJCU29icGpVUXJNQXBaOFNMRUYxMWErT2RFVGJGWDZiNFlabFd2MGVIanZE?=
 =?utf-8?B?NVg2dExoZGNlN2t5MWdHWkNyckY5dmRJMHBmS1k4dDlpSzhNaVFDNmhOK1cz?=
 =?utf-8?B?VnZqbi96U0NCaWJpLzA2RC9yRDhOdGYzU2REVmlhdEZ4V3YxUUtObC9wbWFk?=
 =?utf-8?B?SkpDS2F4c1hUdkpPN0pEM0lMQ2JhREVCU1ROalMrLzVZK0RTcjhpR1l1b0Y4?=
 =?utf-8?B?NktCVE1rL2FCcjZxb21QU21tZnRadWJkSkdpRm90QnhrajZES0V5VXlyUEta?=
 =?utf-8?B?ZnFTdWFQcjN4SkR1dnN1cExBWG5sU2k3WXhzQlRmOGoyM2hGRzE2dTV5NnBY?=
 =?utf-8?B?LzhqeENVVnF5QXVqak12bjhCOXdNME9TSi9hZVIyQkF1NlJITkhPQVZPWkoy?=
 =?utf-8?B?S1MzVnUvd3dUdGlJbXJQZlBlekpxWTNabFRhSjRVRGtOK2hYcmkyL05SalFz?=
 =?utf-8?B?Sy9nTjFzOElqREtVcm9sNlhJNHRCVzNUdGdqN3B4TlJYTUtpZ3ZVSVdmeGhC?=
 =?utf-8?B?MC9xSVl1K0sxMThmZUw2RHBlSW0vZjRXSkFMUzJnQ3BoZWRRS1I1azlqUTlT?=
 =?utf-8?B?QldvaVJEd1M1SmhQQ2FxMU1ZS2dCb25DMDJYWWdpeWZzckcvRDluUFJEcFE3?=
 =?utf-8?B?NEp0ZnFWTEJScWd2cFZVRzVFajFGd3ExNCs0cE1TM3hDaFlXZ0hhcXJmd3Z0?=
 =?utf-8?B?QWJLMncxTGdsdmd3UW9ER2xkN1Bma2EyZW85WVAyYzd4TnBaSGV5eU5UR3Fp?=
 =?utf-8?B?Z3JhMjVzTjhhUFhLNEJJdm8yME9SWURhMWE3NFVlQjVTTDlnVDBub3cwNEY4?=
 =?utf-8?B?QXpHclhzWXVYdVB6dGplRWNhUlV5NUs1Mm5qTWVybUpvTUNUdXpELzJDbkov?=
 =?utf-8?B?dkdtL3A5d0ZITitKSTJjTjdMQ1lzeFpDckRBUGNDMExnTURHZWhCNjNpVjJP?=
 =?utf-8?B?MlFWZGZGZDZ2a0xWWHhsTmlCWlRCSk1zWThKNlZhbzQ2UTE0dmdjUFRNa2Vr?=
 =?utf-8?B?KzU4TmRpYk1XYmQ2Wlo3VW5WMm1QSkJJN0lXOUM3ZHd4eUx6QzJ2S1NlUTFJ?=
 =?utf-8?B?RjY0alRqSmZUdEo0dksrWU5Nd0lPa3lpbHdLSFFrUmU5eGt1R0d1QnRiN3Ar?=
 =?utf-8?B?aC96TWZKNTRtVHJIN0lpZ3ExVjJnNk5OcngxOVZaazMrSjR5RkpuMFdRaDht?=
 =?utf-8?B?MS8vNDFONkJyZVR4dmN1emIvN2RQOUU5akxoeGNvOTFpbUlvczc3YUJjWjY4?=
 =?utf-8?B?dFFreEJiSGJKRTBZaGtNUmRqaU9XdUZldWFETlQ2RTdJTlViOTlLTkdubG9m?=
 =?utf-8?Q?PiTnSRlW6nWAjImjH3jtFFqkK3m7sk=3D?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:58:21.6363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c4a302-5b88-48a9-8b5c-08dd2b5f6d99
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8441

The esdACC CAN-FD FPGA versions below revision 0.72 (0x0048) have some
features missing:

- Older versions have only a 8-bit wide BRP. Therefore its maximum value
  is 256 instead of 512.
- Older versions don't implement the TDC filter logic.

Also the DAR feature (single shot) is implemented only for esdACC
versions 0.72 and later for the Classic CAN and CAN FD variants.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/esd/esd_402_pci-core.c | 65 ++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/esd/esd_402_pci-core.c b/drivers/net/can/esd/esd_402_pci-core.c
index 03df04251c03..1152182aa64a 100644
--- a/drivers/net/can/esd/esd_402_pci-core.c
+++ b/drivers/net/can/esd/esd_402_pci-core.c
@@ -95,6 +95,32 @@ static const struct can_bittiming_const pci402fd_data_bittiming_const = {
 	.brp_inc = 1,
 };
 
+/* Used if the esdACC FPGA is built as CAN-FD version, for versions pre 0.72. */
+/*	These older versions have a maximum BRP of 256. */
+static const struct can_bittiming_const pci402fd_pre72_nom_bittiming_const = {
+	.name = "esd_402fd",
+	.tseg1_min = 1,
+	.tseg1_max = 256,
+	.tseg2_min = 1,
+	.tseg2_max = 128,
+	.sjw_max = 128,
+	.brp_min = 1,
+	.brp_max = 256,
+	.brp_inc = 1,
+};
+
+static const struct can_bittiming_const pci402fd_pre72_data_bittiming_const = {
+	.name = "esd_402fd",
+	.tseg1_min = 1,
+	.tseg1_max = 32,
+	.tseg2_min = 1,
+	.tseg2_max = 16,
+	.sjw_max = 16,
+	.brp_min = 1,
+	.brp_max = 256,
+	.brp_inc = 1,
+};
+
 /* Transmitter Delay Compensation constants for esdACC controller
  */
 static const struct can_tdc_const pci402fd_tdc_const = {
@@ -106,6 +132,18 @@ static const struct can_tdc_const pci402fd_tdc_const = {
 	.tdcf_max = 63,
 };
 
+/* Transmitter Delay Compensation constants for esdACC controller
+ * for versions pre 0.72. No TDC Filter register present.
+ */
+static const struct can_tdc_const pci402fd_pre72_tdc_const = {
+	.tdcv_min = 0,
+	.tdcv_max = 0,
+	.tdco_min = 0,
+	.tdco_max = 63,
+	.tdcf_min = 0,
+	.tdcf_max = 0,
+};
+
 static const struct net_device_ops pci402_acc_netdev_ops = {
 	.ndo_open = acc_open,
 	.ndo_stop = acc_close,
@@ -202,6 +240,11 @@ static int pci402_init_card(struct pci_dev *pdev)
 			card->ov.version);
 		return -EINVAL;
 	}
+	if (card->ov.version < PCI402_FPGA_VER_0_72) {
+		pci_warn(pdev,
+			 "esdACC below version 0x%.4x misses some features, please update from 0x%.4x\n",
+			 PCI402_FPGA_VER_0_72, card->ov.version);
+	}
 
 	if (card->ov.timestamp_frequency != ACC_TS_FREQ_80MHZ) {
 		pci_err(pdev,
@@ -223,13 +266,7 @@ static int pci402_init_card(struct pci_dev *pdev)
 
 	if (card->ov.features & ACC_OV_REG_FEAT_MASK_CANFD) {
 		pci_warn(pdev,
-			 "esdACC with CAN-FD feature detected. This driver partly implements CAN-FD.\n");
-		if (card->ov.version < PCI402_FPGA_VER_0_72) {
-			pci_err(pdev,
-				"esdACC CAN-FD below version 0x%.4x not supported, please update from 0x%.4x\n",
-				PCI402_FPGA_VER_0_72, card->ov.version);
-			return -EINVAL;
-		}
+			 "esdACC with CAN-FD feature detected. This driver is not feature complete, yet.\n");
 	}
 
 #ifdef __LITTLE_ENDIAN
@@ -410,9 +447,17 @@ static int pci402_init_cores(struct pci_dev *pdev)
 			priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
 				CAN_CTRLMODE_TDC_AUTO |
 				CAN_CTRLMODE_TDC_MANUAL;
-			priv->can.bittiming_const = &pci402fd_nom_bittiming_const;
-			priv->can.data_bittiming_const = &pci402fd_data_bittiming_const;
-			priv->can.tdc_const = &pci402fd_tdc_const;
+
+			if (card->ov.version >= PCI402_FPGA_VER_0_72) {
+				priv->can.bittiming_const = &pci402fd_nom_bittiming_const;
+				priv->can.data_bittiming_const = &pci402fd_data_bittiming_const;
+				priv->can.tdc_const = &pci402fd_tdc_const;
+			} else {
+				priv->can.bittiming_const = &pci402fd_pre72_nom_bittiming_const;
+				priv->can.data_bittiming_const =
+					&pci402fd_pre72_data_bittiming_const;
+				priv->can.tdc_const = &pci402fd_pre72_tdc_const;
+			}
 			priv->can.do_get_auto_tdcv = acc_get_auto_tdcv;
 		} else {
 			priv->can.bittiming_const = &pci402_bittiming_const;
-- 
2.34.1


