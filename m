Return-Path: <linux-can+bounces-2525-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD43D9FFEF8
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 19:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2261881399
	for <lists+linux-can@lfdr.de>; Thu,  2 Jan 2025 18:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9F61990DB;
	Thu,  2 Jan 2025 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="mWDOg4Ef"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2113.outbound.protection.outlook.com [40.107.21.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D070C1925A3
	for <linux-can@vger.kernel.org>; Thu,  2 Jan 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844315; cv=fail; b=ZwctEwCZjqI6w1ucyZuBu9ZgsRXlg2a33cc1w0GdxUdjDe+gCbhEHn7pZSLq8BZKZcDoA5qYwwyK/9Ynef+hMf9DKy93rc4DOE8f9e8YW296bDiArlSe1R47C3o+A+PW6Vmhak6EYdHDctzh1PJriUcXuCVIrJi34p3M3wnvWJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844315; c=relaxed/simple;
	bh=IBbhvtYvMg6HmB9sDs1VhuBC4cCiwYRNAOYlWV+/LTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ld+5yoGREU1JP3NysR2gVHYbYU9VAkGcKJSXurRiQunebg6uA8f7ymKEmVbgtUPyrY3q6cEpOtm2IYBRTLeB2mrAPXUw73WmOloPLtGEX9bEaDu5mot1L5PYzP3eiAft0eiNufI4GktUzeYuGOYSk+W3GqVEtP1CaFNq4zT8yXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=mWDOg4Ef; arc=fail smtp.client-ip=40.107.21.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wu3p/zLEBvlH19trxLV3Ni11vB6+n76hChyrJrgV5knUSBNKr6hgoCGsSxJSSzknGkNw5t4NufOvrzxkZl4H5p2BbVyZVLqnrS6DUMeHcCGPxvnoNJHjPdIcw6W7O7haMXT5ud8bKqX58uSV3xc2fqQL6swaTCl/HvE2j6upw6W452Z5KUDBMTRd2o7u5RijP1A2VE/VuamuZJ3xKJ7vMviNp+xctQlgrVwmjMfvU6Nio5wytVzXD6sOK6+fcnFg8bRmkZaH0FdFrUo+RYWnVFn4tq1roR2YDg61QlS5WBo2FEVpBU57IBvq2GIAFuNe0atQWDWDRazWbJ9gCuTpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qV2qME5yRDYCMCrbJk66Axw9sNICdNnKnF1Q8EpTKKs=;
 b=jXUjL6E8iV+Cr+WdWc9+vWXkmSWARAMQCPE8nHolJ8XbgEletkZz68ouVAm+Ppa1XBzv7vRak97WS83UsDUVMc/geW3/KB/SH2rw93sSXlbVqSeTGyC0s3zBz6qhIG0+I8mey2RPbGzSzwJ6zgWETMZX+viPBKUws15cvq3J9ZnVOlr54MBfN8KhAxVSJSsIde6oobkFdimjGZcgW0pJbuQOMo045NZMxKA0UGeegFZrK0DM40oHvLZVJEBiBGTnZjxAZDrN0yVkLG38lClFZapLuxInR6Xq0VSmk9bBBur4xgwxrPPoRGTpKnBLkqVodVac5e4+omGmynIQzajh7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=gmail.com smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV2qME5yRDYCMCrbJk66Axw9sNICdNnKnF1Q8EpTKKs=;
 b=mWDOg4Ef63pnYUtgqfKQgFoGMeLSqn9ZHREw3iAI9jyHng11r4XCgpfmj9xsFchQOY8ZEtbEjDEQpPbisI/HFw1CYdsOnkJRpj8D46cmyhZKzQr3+Lj8gIrQI9tQRiB0Ex+mRWrJcKe4KNMXyKyYCAmS9EqXxcjGlTl7uhen9ik=
Received: from DUZPR01CA0119.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::19) by VI1PR03MB6573.eurprd03.prod.outlook.com
 (2603:10a6:800:17e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.11; Thu, 2 Jan
 2025 18:58:22 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:10:4bc:cafe::1b) by DUZPR01CA0119.outlook.office365.com
 (2603:10a6:10:4bc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Thu,
 2 Jan 2025 18:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server id 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:58:21
 +0000
Received: from debby.esd.local (jenkins.esd.local [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 6998F7C16C8;
	Thu,  2 Jan 2025 19:58:21 +0100 (CET)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 5B3572E803F; Thu,  2 Jan 2025 19:58:21 +0100 (CET)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Robert Nawrath <mbro1689@gmail.com>
Subject: [RFC PATCH 1/6] can: esd_402_pci: Add basic support for CAN-FD
Date: Thu,  2 Jan 2025 19:58:16 +0100
Message-Id: <20250102185821.670839-2-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B93:EE_|VI1PR03MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 34798a0e-d70d-4b7c-e17a-08dd2b5f6db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDA1bkViMkVneFN2U2p3SkcvWVVIZTlYTUZLZW1JcWNFOGcwYVFRbGJmQWd0?=
 =?utf-8?B?OWVhSVRMVjBFYWllNkdpTzcwc09vdEVuY3pLZlIxbDlyUUdSOGRiSVRUUzRk?=
 =?utf-8?B?ZjZ3SGNvWUVhY1IvRjMyK2tTR21GYlE2WVh5YmJiWHNhT2lBWFV0SThiNVJv?=
 =?utf-8?B?WUp1RFVVNVA4UVBxV1piMFExblp0OEdBWVc2QTIwQXcySUYvd2pNSXcvT0hF?=
 =?utf-8?B?QUp3QnhMRVdPRW9nbFloTXZkL0lzeFVRMThzZE5FalIyZ1dOY2s0TzlRWWE3?=
 =?utf-8?B?MEhSQ3BleGV3dU9rRXZ1SGl4OXdZSTV6dVJMU05SaElUR1B4akQ5cmdlWjU5?=
 =?utf-8?B?MXQvakJET01mRGk1SDNWOVNBWWljWWUrOHdXR1NBS2JlUkhFTEg0NXI3dEYz?=
 =?utf-8?B?aU5uRUZqT3piYnB5Sy9XYUtYUW1XRG0xVjJQNDRnTkV0Z044SjFranBZUG1P?=
 =?utf-8?B?NjdCaGp5WVJEUHMxV3RrVktCYzZra2ptSVlqTStMa21nRVdFSDFIclcyVHg5?=
 =?utf-8?B?M2o1dHplODBFcGdyQzQ3MzhqdXNpRjJOcVZUYjMvU2lnSlpqaDd3aFR1ZnIv?=
 =?utf-8?B?MUNFTHQ1UjFRSzR1bU92RVNSZXpSTXhwZERpNDRoOE5uRlNpdFI2aXNja29I?=
 =?utf-8?B?TDVQa2cxajN2eXh3Q1Y2U080c1BTWDNoNTdFU1dSRWlFby9wZWlqYUwwQk9U?=
 =?utf-8?B?YU90eWpxOC8vR3FoQWFQZk5nTG11MW53Nk9FZmhNYXIrVEJHeVFFYWl3aTRq?=
 =?utf-8?B?Uk5kZmYxS3RiWEVZMmhZcll2b1ZpVm53c2luMWROeWZHdUhoSVhIWDZXMFov?=
 =?utf-8?B?c1o5YVlVVU5tRTZydU1hUk5hUCtJMkRteFg4M1Fxb05lMk53Q1B0aldjeWlZ?=
 =?utf-8?B?SndOdStuYmNaZ2oyM3JRbDhneVFSN2tTUjdWUUViYWo2NjNVQWJ1SGtVdUdu?=
 =?utf-8?B?VVY2ZkVya0ZaYU1CZHBZNWFteVhHSzA2WHRjT05HWkVNYnlpc1ZDL0ZYUXdC?=
 =?utf-8?B?VkFFVXhSUDdoSGtjUXFCdU1Na3NPMy9vZFlMb3pXeFF4WXpHUmc4S2x6aVlJ?=
 =?utf-8?B?VDMvRGc2S3MzdXhyR1hqYXN1aG5TK2xQOFMwMnIvYXBNUHc1Z2diSWZkZVR4?=
 =?utf-8?B?S1ZUajd6RUpIMEtvbGxnSUVHNXlDQTdvUnhDZEpZRldibmpmN0Y1cHE5bDkz?=
 =?utf-8?B?Nk5EV0dkZ2VXYm44QWxyTUQxcytPdXNsaklHYzdqM20rSkVDWHJaOStjdmJq?=
 =?utf-8?B?REc3aEppV2VmcXdGOGtjSm1oNk4yRXh6aDFhd3hYczBwUEFlQzBZWlViZitz?=
 =?utf-8?B?bkdPbnVCVlRwKzdoczJ2d0Z6NlBYVEZRM3ArbVlUU21wNlgreUpIRGRVekd3?=
 =?utf-8?B?QmdaUzRWWWlNRmYxOHdwRW9ObWZnWFFnR3lDeC9DWFNsMUJDeDIvTHhIM1NP?=
 =?utf-8?B?MFBmQ3Q4NzVteDRGN1ZKYmVkdXo5VVlpa05OQzk5Tk9kZ3lnV1oxNG42cVNF?=
 =?utf-8?B?emo2dUJaWHZ4K01hSXNzN3RBL2N0Uy8vNXpFOFQ2SmlQeXpWZFlyMm9GMHkz?=
 =?utf-8?B?ZnBIN2FDZzJLbDZhZCtBL3NFa2NNMld5SnAvNmZhdTlKUCthRzFoSDJ0ZTFN?=
 =?utf-8?B?ckNLaS9EeFUzVWliRFVTazcvbHhPRHdIMjdrY2M3ZTYxc29xQWhId1dZTWdZ?=
 =?utf-8?B?UUFWY2NZUkJ6RE9MZGV3USt4ZmNnNVIvVkwxOVV0cDg3eG9kYzFSbUpCK1hI?=
 =?utf-8?B?ZVJmd3RJTjVxMktNMU9rQmJoS0VsbHp2OW8veTBVRzNhY0pYQmh2ZDcxQWlP?=
 =?utf-8?B?bW5Fc25aTGluaUMxV3YzQ3FhTVdNTVFNRDZ5NFk1TWRlckJIUUhYZFVkRzY0?=
 =?utf-8?B?UnRQQlNGWWN5NFB6bmtibEc5U2ljdXZ6YnI5ZmtONFFoS1lvb3U2KzIwam5x?=
 =?utf-8?B?cUpUUmFZSnBwb0NGb1doUVIyL1BxVkxjOWo4bEJ5c1I3WG9iaktNcUZ1ZkVi?=
 =?utf-8?Q?o+S7kw32vUWxmixrGBa/GNj6yvFXsE=3D?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:58:21.7645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34798a0e-d70d-4b7c-e17a-08dd2b5f6db1
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6573

This patch adds the basic support for CAN-FD to the driver. This means
transmitting and receiving CAN-FD frames. TDC runs in automatic mode.

- Support only CAN-FD FPGA versions >= 0.72
- Refrain from providing do_set[_data]_bittiming callbacks.
- acc_set_bittiming() is now only called internally in acc_open().
- Rework acc_set_bittiming() (static, void, extended ctrlmode display
  in main stream, change data bit timing debug output)

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/esd/esd_402_pci-core.c |  37 +++-
 drivers/net/can/esd/esdacc.c           | 231 ++++++++++++++++++++++---
 drivers/net/can/esd/esdacc.h           |  43 ++++-
 3 files changed, 275 insertions(+), 36 deletions(-)

diff --git a/drivers/net/can/esd/esd_402_pci-core.c b/drivers/net/can/esd/esd_402_pci-core.c
index 5d6d2828cd04..0c0fc159a1cb 100644
--- a/drivers/net/can/esd/esd_402_pci-core.c
+++ b/drivers/net/can/esd/esd_402_pci-core.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2015 - 2016 Thomas Körper, esd electronic system design gmbh
- * Copyright (C) 2017 - 2023 Stefan Mätje, esd electronics gmbh
+ * Copyright (C) 2017 - 2024 Stefan Mätje, esd electronics gmbh
  */
 
 #include <linux/can/dev.h>
@@ -21,6 +21,7 @@
 #define ESD_PCI_DEVICE_ID_PCIE402 0x0402
 
 #define PCI402_FPGA_VER_MIN 0x003d
+#define PCI402_FPGA_VER_0_72 0x0048
 #define PCI402_MAX_CORES 6
 #define PCI402_BAR 0
 #define PCI402_IO_OV_OFFS 0
@@ -70,7 +71,7 @@ static const struct can_bittiming_const pci402_bittiming_const = {
 };
 
 /* Used if the esdACC FPGA is built as CAN-FD version. */
-static const struct can_bittiming_const pci402_bittiming_const_canfd = {
+static const struct can_bittiming_const pci402fd_nom_bittiming_const = {
 	.name = "esd_402fd",
 	.tseg1_min = 1,
 	.tseg1_max = 256,
@@ -78,7 +79,19 @@ static const struct can_bittiming_const pci402_bittiming_const_canfd = {
 	.tseg2_max = 128,
 	.sjw_max = 128,
 	.brp_min = 1,
-	.brp_max = 256,
+	.brp_max = 512,
+	.brp_inc = 1,
+};
+
+static const struct can_bittiming_const pci402fd_data_bittiming_const = {
+	.name = "esd_402fd",
+	.tseg1_min = 1,
+	.tseg1_max = 32,
+	.tseg2_min = 1,
+	.tseg2_max = 16,
+	.sjw_max = 16,
+	.brp_min = 1,
+	.brp_max = 512,
 	.brp_inc = 1,
 };
 
@@ -199,7 +212,13 @@ static int pci402_init_card(struct pci_dev *pdev)
 
 	if (card->ov.features & ACC_OV_REG_FEAT_MASK_CANFD) {
 		pci_warn(pdev,
-			 "esdACC with CAN-FD feature detected. This driver doesn't support CAN-FD yet.\n");
+			 "esdACC with CAN-FD feature detected. This driver partly implements CAN-FD.\n");
+		if (card->ov.version < PCI402_FPGA_VER_0_72) {
+			pci_err(pdev,
+				"esdACC CAN-FD below version 0x%.4x not supported, please update from 0x%.4x\n",
+				PCI402_FPGA_VER_0_72, card->ov.version);
+			return -EINVAL;
+		}
 	}
 
 #ifdef __LITTLE_ENDIAN
@@ -376,11 +395,13 @@ static int pci402_init_cores(struct pci_dev *pdev)
 			CAN_CTRLMODE_CC_LEN8_DLC;
 		if (card->ov.features & ACC_OV_REG_FEAT_MASK_DAR)
 			priv->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
-		if (card->ov.features & ACC_OV_REG_FEAT_MASK_CANFD)
-			priv->can.bittiming_const = &pci402_bittiming_const_canfd;
-		else
+		if (card->ov.features & ACC_OV_REG_FEAT_MASK_CANFD) {
+			priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
+			priv->can.bittiming_const = &pci402fd_nom_bittiming_const;
+			priv->can.data_bittiming_const = &pci402fd_data_bittiming_const;
+		} else {
 			priv->can.bittiming_const = &pci402_bittiming_const;
-		priv->can.do_set_bittiming = acc_set_bittiming;
+		}
 		priv->can.do_set_mode = acc_set_mode;
 		priv->can.do_get_berr_counter = acc_get_berr_counter;
 
diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
index c80032bc1a52..faad38e23251 100644
--- a/drivers/net/can/esd/esdacc.c
+++ b/drivers/net/can/esd/esdacc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2015 - 2016 Thomas Körper, esd electronic system design gmbh
- * Copyright (C) 2017 - 2023 Stefan Mätje, esd electronics gmbh
+ * Copyright (C) 2017 - 2024 Stefan Mätje, esd electronics gmbh
  */
 
 #include "esdacc.h"
@@ -18,9 +18,19 @@
 #define ACC_DLC_DLC_MASK GENMASK(3, 0)
 #define ACC_DLC_RTR_FLAG BIT(4)
 #define ACC_DLC_SSTX_FLAG BIT(24)	/* Single Shot TX */
-
-/* esdACC DLC in struct acc_bmmsg_rxtxdone::acc_dlc.len only! */
-#define ACC_DLC_TXD_FLAG BIT(5)
+#define ACC_DLC_BRS_FLAG BIT(29)	/* enable Bit Rate Switch */
+#define ACC_DLC_EDL_FLAG BIT(30)	/* enable Extended Data Length = FD frame */
+
+/* Copy of esdACC DLC register in bus master messages only */
+/* struct acc_bmmsg_rxtxdone::acc_dlc.len and acc_bmmsg_fddata::acc_dlc_len */
+#define ACC_DLC_LEN_DLC_MASK GENMASK(3, 0)
+#define ACC_DLC_LEN_TXD_FLAG BIT(5)
+#define ACC_DLC_LEN_SR_FLAG BIT(6)
+#define ACC_DLC_LEN_TXTS_FLAG BIT(7)
+/* struct acc_bmmsg_rxtxdone::acc_dlc.fdf */
+#define ACC_DLC_FDF_ESI_FLAG BIT(28 - 24)
+#define ACC_DLC_FDF_BRS_FLAG BIT(29 - 24)	/* enable Bit Rate Switch */
+#define ACC_DLC_FDF_EDL_FLAG BIT(30 - 24)	/* enable Extended Data Length = FD frame */
 
 /* ecc value of esdACC equals SJA1000's ECC register */
 #define ACC_ECC_SEG 0x1f
@@ -44,6 +54,8 @@
  */
 #define ACC_BM_IRQ_UNMASK_ALL 0x55555555U
 
+static void acc_set_bittiming(struct net_device *netdev);
+
 static void acc_resetmode_enter(struct acc_core *core)
 {
 	acc_set_bits(core, ACC_CORE_OF_CTRL,
@@ -62,18 +74,56 @@ static void acc_resetmode_leave(struct acc_core *core)
 	acc_resetmode_entered(core);
 }
 
+#define ACC_TXQ_WRITE32(core, data, ridx)				\
+	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_ ## ridx, ((const u32 *)data)[ridx])
+
 static void acc_txq_put(struct acc_core *core, u32 acc_id, u32 acc_dlc,
 			const void *data)
 {
-	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_1,
-			   *((const u32 *)(data + 4)));
-	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_0,
-			   *((const u32 *)data));
+	if (acc_dlc & ACC_DLC_EDL_FLAG) {
+		switch (acc_dlc & ACC_DLC_DLC_MASK) {
+		case 15:
+			ACC_TXQ_WRITE32(core, data, 15);
+			ACC_TXQ_WRITE32(core, data, 14);
+			ACC_TXQ_WRITE32(core, data, 13);
+			ACC_TXQ_WRITE32(core, data, 12);
+			fallthrough;
+		case 14:
+			ACC_TXQ_WRITE32(core, data, 11);
+			ACC_TXQ_WRITE32(core, data, 10);
+			ACC_TXQ_WRITE32(core, data, 9);
+			ACC_TXQ_WRITE32(core, data, 8);
+			fallthrough;
+		case 13:
+			ACC_TXQ_WRITE32(core, data, 7);
+			ACC_TXQ_WRITE32(core, data, 6);
+			fallthrough;
+		case 12:
+			ACC_TXQ_WRITE32(core, data, 5);
+			fallthrough;
+		case 11:
+			ACC_TXQ_WRITE32(core, data, 4);
+			fallthrough;
+		case 10:
+			ACC_TXQ_WRITE32(core, data, 3);
+			fallthrough;
+		case 9:
+			ACC_TXQ_WRITE32(core, data, 2);
+			fallthrough;
+		default:
+			break;
+		}
+	}
+	ACC_TXQ_WRITE32(core, data, 1);
+	ACC_TXQ_WRITE32(core, data, 0);
+
 	acc_write32(core, ACC_CORE_OF_TXFIFO_DLC, acc_dlc);
 	/* CAN id must be written at last. This write starts TX. */
 	acc_write32(core, ACC_CORE_OF_TXFIFO_ID, acc_id);
 }
 
+#undef ACC_TXQ_WRITE32
+
 static u8 acc_tx_fifo_next(struct acc_core *core, u8 tx_fifo_idx)
 {
 	++tx_fifo_idx;
@@ -190,6 +240,8 @@ int acc_open(struct net_device *netdev)
 	if (err)
 		return err;
 
+	acc_set_bittiming(netdev);
+
 	ctrl = ACC_REG_CTRL_MASK_IE_RXTX |
 		ACC_REG_CTRL_MASK_IE_TXERROR |
 		ACC_REG_CTRL_MASK_IE_ERRWARN |
@@ -274,9 +326,20 @@ netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	if (fifo_usage == core->tx_fifo_size - 2)
 		netif_stop_queue(netdev);
 
-	acc_dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
-	if (cf->can_id & CAN_RTR_FLAG)
-		acc_dlc |= ACC_DLC_RTR_FLAG;
+	if (can_is_canfd_skb(skb)) {
+		struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+
+		acc_dlc = can_fd_len2dlc(cfd->len);
+		acc_dlc |= ACC_DLC_EDL_FLAG;
+
+		if (cfd->flags & CANFD_BRS)
+			acc_dlc |= ACC_DLC_BRS_FLAG;
+	} else {
+		acc_dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
+		if (cf->can_id & CAN_RTR_FLAG)
+			acc_dlc |= ACC_DLC_RTR_FLAG;
+	}
+
 	if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
 		acc_dlc |= ACC_DLC_SSTX_FLAG;
 
@@ -355,17 +418,22 @@ int acc_set_mode(struct net_device *netdev, enum can_mode mode)
 	return 0;
 }
 
-int acc_set_bittiming(struct net_device *netdev)
+static void acc_set_bittiming(struct net_device *netdev)
 {
 	struct acc_net_priv *priv = netdev_priv(netdev);
 	const struct can_bittiming *bt = &priv->can.bittiming;
+	const struct can_bittiming *dbt = &priv->can.data_bittiming;
 	u32 brp;
 	u32 btr;
 
+	netdev_dbg(netdev, "ctrlmode 0x%03X, FD=%d, TDC=%c\n",
+		   priv->can.ctrlmode, !!(priv->can.ctrlmode & CAN_CTRLMODE_FD),
+		   "OAM?"[FIELD_GET(CAN_CTRLMODE_TDC_MASK, priv->can.ctrlmode)]);
+
 	if (priv->ov->features & ACC_OV_REG_FEAT_MASK_CANFD) {
 		u32 fbtr = 0;
 
-		netdev_dbg(netdev, "bit timing: brp %u, prop %u, ph1 %u ph2 %u, sjw %u\n",
+		netdev_dbg(netdev, "nbit timing: brp %u, prop %u, ph1 %u ph2 %u, sjw %u\n",
 			   bt->brp, bt->prop_seg,
 			   bt->phase_seg1, bt->phase_seg2, bt->sjw);
 
@@ -379,6 +447,19 @@ int acc_set_bittiming(struct net_device *netdev)
 		acc_write32(priv->core, ACC_CORE_OF_BRP, brp);
 		acc_write32(priv->core, ACC_CORE_OF_BTR, btr);
 
+		netdev_dbg(netdev, "dbit timing: brp %u, prop %u, ph1 %u ph2 %u, sjw %u\n",
+			   dbt->brp, dbt->prop_seg,
+			   dbt->phase_seg1, dbt->phase_seg2, dbt->sjw);
+
+		if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+			fbtr = FIELD_PREP(ACC_REG_FBTR_FD_MASK_TSEG1,
+					  dbt->phase_seg1 + dbt->prop_seg - 1);
+			fbtr |= FIELD_PREP(ACC_REG_FBTR_FD_MASK_TSEG2, dbt->phase_seg2 - 1);
+			fbtr |= FIELD_PREP(ACC_REG_FBTR_FD_MASK_SJW, dbt->sjw - 1);
+		}
+		/* Write ACC_CORE_OF_FBTR last. */
+		acc_write32(priv->core, ACC_CORE_OF_FBTR, fbtr);
+
 		netdev_dbg(netdev, "esdACC: BRP %u, NBTR 0x%08x, DBTR 0x%08x",
 			   brp, btr, fbtr);
 	} else {
@@ -398,8 +479,6 @@ int acc_set_bittiming(struct net_device *netdev)
 
 		netdev_dbg(netdev, "esdACC: BRP %u, BTR 0x%08x", brp, btr);
 	}
-
-	return 0;
 }
 
 static void handle_core_msg_rxtxdone(struct acc_core *core,
@@ -409,7 +488,7 @@ static void handle_core_msg_rxtxdone(struct acc_core *core,
 	struct net_device_stats *stats = &core->netdev->stats;
 	struct sk_buff *skb;
 
-	if (msg->acc_dlc.len & ACC_DLC_TXD_FLAG) {
+	if (msg->acc_dlc.len & ACC_DLC_LEN_TXD_FLAG) {
 		u8 tx_fifo_tail = core->tx_fifo_tail;
 
 		if (core->tx_fifo_head == tx_fifo_tail) {
@@ -434,9 +513,17 @@ static void handle_core_msg_rxtxdone(struct acc_core *core,
 		netif_wake_queue(core->netdev);
 
 	} else {
+		struct canfd_frame *cfd;
 		struct can_frame *cf;
+		u8 len;
+
+		if (msg->acc_dlc.fdf & ACC_DLC_FDF_EDL_FLAG) {
+			skb = alloc_canfd_skb(core->netdev, &cfd);
+			cf = (struct can_frame *)cfd;
+		} else {
+			skb = alloc_can_skb(core->netdev, &cf);
+		}
 
-		skb = alloc_can_skb(core->netdev, &cf);
 		if (!skb) {
 			stats->rx_dropped++;
 			return;
@@ -446,15 +533,36 @@ static void handle_core_msg_rxtxdone(struct acc_core *core,
 		if (msg->id & ACC_ID_EFF_FLAG)
 			cf->can_id |= CAN_EFF_FLAG;
 
-		can_frame_set_cc_len(cf, msg->acc_dlc.len & ACC_DLC_DLC_MASK,
-				     priv->can.ctrlmode);
+		if (msg->acc_dlc.fdf & ACC_DLC_FDF_EDL_FLAG) {
+			/* can_fd_dlc2len() masks its argument with 0x0F == ACC_DLC_LEN_DLC_MASK */
+			cfd->len = can_fd_dlc2len(msg->acc_dlc.len);
+
+			if (msg->acc_dlc.fdf & ACC_DLC_FDF_BRS_FLAG)
+				cfd->flags |= CANFD_BRS;
+			if (msg->acc_dlc.fdf & ACC_DLC_FDF_ESI_FLAG)
+				cfd->flags |= CANFD_ESI;
 
-		if (msg->acc_dlc.len & ACC_DLC_RTR_FLAG) {
-			cf->can_id |= CAN_RTR_FLAG;
+			len = cfd->len;
+			stats->rx_bytes += len;
+
+			if (len > CAN_MAX_DLEN) {
+				/* Fetch data buffered from struct acc_bmmsg_fddata messages. */
+				memcpy(cfd->data + CAN_MAX_DLEN, core->fdd, len - CAN_MAX_DLEN);
+				len = CAN_MAX_DLEN;
+			}
 		} else {
-			memcpy(cf->data, msg->data, cf->len);
-			stats->rx_bytes += cf->len;
+			can_frame_set_cc_len(cf, msg->acc_dlc.len & ACC_DLC_DLC_MASK,
+					     priv->can.ctrlmode);
+
+			if (msg->acc_dlc.len & ACC_DLC_RTR_FLAG) {
+				cf->can_id |= CAN_RTR_FLAG;
+				len = 0U;
+			} else {
+				len = cf->len;
+				stats->rx_bytes += len;
+			}
 		}
+		memcpy(cf->data, msg->data, len);
 		stats->rx_packets++;
 
 		skb_hwtstamps(skb)->hwtstamp = acc_ts2ktime(priv->ov, msg->ts);
@@ -637,6 +745,75 @@ handle_core_msg_errstatechange(struct acc_core *core,
 	}
 }
 
+/* Reassemble split CAN-FD data into buffer at struct acc_core::fdd
+ *
+ * The bus master engine splits CAN-FD frames into multiple bus master
+ * messages depending on the data length.
+ *
+ * - three messages for frames with data lengths 48 & 64:
+ *	BM_MSG_ID_FDDATA0
+ *	BM_MSG_ID_FDDATA1
+ *	BM_MSG_ID_RXTXDONE
+ *
+ * - two messages for frames with data lengths of 12, 16, 20, 24 and 32
+ *	BM_MSG_ID_FDDATA0
+ *	BM_MSG_ID_RXTXDONE
+ *
+ * For shorter frames no message with id BM_MSG_ID_FDDATA[01] is created.
+ *
+ * During the handling of the message with id BM_MSG_ID_RXTXDONE the
+ * reassembled CAN-FD data are transferred to struct canfd_frame as
+ * needed. The first up to eight data bytes are always taken from the
+ * BM_MSG_ID_RXTXDONE message.
+ *
+ * Newer FPGA images provide some length information in the struct
+ * acc_bmmsg_fddata::acc_dlc_len member to announce the amount of real
+ * data.
+ * Older FPGA versions don't provide any data length information and
+ * set acc_bmmsg_fddata::acc_dlc_len to zero. In this case the full
+ * data length of ACC_FDD_SLICE_SIZE is copied.
+ *
+ * This function uses the information in acc_bmmsg_fddata::acc_dlc_len
+ * to copy less data.
+ */
+static void handle_core_msg_fddata(struct acc_core *core,
+				   const struct acc_bmmsg_fddata *msg)
+{
+	/* Copy length table indexed by DLC value and BM_MSG_ID_FDDATA[0|1] message type.
+	 * Entries with 0U are never selected.
+	 */
+	static const u8 cp_len_tbl[16][2] = {
+		{ ACC_FDD_SLICE_SIZE, ACC_FDD_SLICE_SIZE },
+		{ 0U, 0U },
+		{ 0U, 0U },
+		{ 0U, 0U },
+		{ 0U, 0U },
+		{ 0U, 0U },
+		{ 0U, 0U },
+		{ 0U, 0U },
+		{ 0U, 0U },
+		{ 12U - CAN_MAX_DLEN, 0U },
+		{ 16U - CAN_MAX_DLEN, 0U },
+		{ 20U - CAN_MAX_DLEN, 0U },
+		{ 24U - CAN_MAX_DLEN, 0U },
+		{ 32U - CAN_MAX_DLEN, 0U },
+		{ ACC_FDD_SLICE_SIZE, 48U - ACC_FDD_SLICE_SIZE - CAN_MAX_DLEN },
+		{ ACC_FDD_SLICE_SIZE, 64U - ACC_FDD_SLICE_SIZE - CAN_MAX_DLEN },
+	};
+	int msg_type;
+	u8 cp_len;
+	u8 *dst;
+
+	if (msg->acc_dlc_len & ACC_DLC_LEN_TXD_FLAG)
+		return;
+
+	msg_type = msg->msg_id - BM_MSG_ID_FDDATA0;
+	dst = core->fdd + (msg_type * ACC_FDD_SLICE_SIZE);
+	cp_len = cp_len_tbl[msg->acc_dlc_len & ACC_DLC_LEN_DLC_MASK][msg_type];
+
+	memcpy(dst, msg->fdd.ui8, cp_len);
+}
+
 static void handle_core_interrupt(struct acc_core *core)
 {
 	u32 msg_fifo_head = core->bmfifo.local_irq_cnt & 0xff;
@@ -668,8 +845,14 @@ static void handle_core_interrupt(struct acc_core *core)
 						       &msg->errstatechange);
 			break;
 
+		case BM_MSG_ID_FDDATA0:
+		case BM_MSG_ID_FDDATA1:
+			handle_core_msg_fddata(core, &msg->fddata);
+			break;
+
 		default:
-			/* Ignore all other BM messages (like the CAN-FD messages) */
+			/* Ignore all other BM messages */
+			netdev_dbg(core->netdev, "WARN: BM MSG 0x%x ignored\n", msg->msg_id);
 			break;
 		}
 
diff --git a/drivers/net/can/esd/esdacc.h b/drivers/net/can/esd/esdacc.h
index 6b7ebd8c91b2..fdbb017b80a9 100644
--- a/drivers/net/can/esd/esdacc.h
+++ b/drivers/net/can/esd/esdacc.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Copyright (C) 2015 - 2016 Thomas Körper, esd electronic system design gmbh
- * Copyright (C) 2017 - 2023 Stefan Mätje, esd electronics gmbh
+ * Copyright (C) 2017 - 2024 Stefan Mätje, esd electronics gmbh
  */
 
 #include <linux/bits.h>
@@ -67,6 +67,21 @@
 #define ACC_CORE_OF_TXFIFO_DATA_0 0x00c8
 #define ACC_CORE_OF_TXFIFO_DATA_1 0x00cc
 
+#define ACC_CORE_OF_TXFIFO_DATA_2 0x0108
+#define ACC_CORE_OF_TXFIFO_DATA_3 0x010c
+#define ACC_CORE_OF_TXFIFO_DATA_4 0x0110
+#define ACC_CORE_OF_TXFIFO_DATA_5 0x0114
+#define ACC_CORE_OF_TXFIFO_DATA_6 0x0118
+#define ACC_CORE_OF_TXFIFO_DATA_7 0x011c
+#define ACC_CORE_OF_TXFIFO_DATA_8 0x0120
+#define ACC_CORE_OF_TXFIFO_DATA_9 0x0124
+#define ACC_CORE_OF_TXFIFO_DATA_10 0x0128
+#define ACC_CORE_OF_TXFIFO_DATA_11 0x012c
+#define ACC_CORE_OF_TXFIFO_DATA_12 0x0130
+#define ACC_CORE_OF_TXFIFO_DATA_13 0x0134
+#define ACC_CORE_OF_TXFIFO_DATA_14 0x0138
+#define ACC_CORE_OF_TXFIFO_DATA_15 0x013c
+
 /* CTRL register layout */
 #define ACC_REG_CTRL_MASK_RESETMODE BIT(0)
 #define ACC_REG_CTRL_MASK_LOM BIT(1)
@@ -90,16 +105,21 @@
 #define ACC_REG_BTR_CL_MASK_TSEG2 GENMASK(18, 16)
 #define ACC_REG_BTR_CL_MASK_SJW GENMASK(25, 24)
 
-/* BRP and BTR register layout for CAN-FD version */
+/* BRP and (F)BTR register layout for CAN-FD version */
 #define ACC_REG_BRP_FD_MASK_BRP GENMASK(7, 0)
 #define ACC_REG_BTR_FD_MASK_TSEG1 GENMASK(7, 0)
 #define ACC_REG_BTR_FD_MASK_TSEG2 GENMASK(22, 16)
 #define ACC_REG_BTR_FD_MASK_SJW GENMASK(30, 24)
+#define ACC_REG_FBTR_FD_MASK_TSEG1 GENMASK(4, 0)
+#define ACC_REG_FBTR_FD_MASK_TSEG2 GENMASK(19, 16)
+#define ACC_REG_FBTR_FD_MASK_SJW GENMASK(27, 24)
 
 /* 256 BM_MSGs of 32 byte size */
 #define ACC_CORE_DMAMSG_SIZE 32U
 #define ACC_CORE_DMABUF_SIZE (256U * ACC_CORE_DMAMSG_SIZE)
 
+#define ACC_FDD_SLICE_SIZE ((CANFD_MAX_DLEN - CAN_MAX_DLEN) / 2)
+
 enum acc_bmmsg_id {
 	BM_MSG_ID_RXTXDONE = 0x01,
 	BM_MSG_ID_TXABORT = 0x02,
@@ -110,6 +130,8 @@ enum acc_bmmsg_id {
 	BM_MSG_ID_TIMESLICE = 0x07,
 	BM_MSG_ID_HWTIMER = 0x08,
 	BM_MSG_ID_HOTPLUG = 0x09,
+	BM_MSG_ID_FDDATA0 = 0x0a,
+	BM_MSG_ID_FDDATA1 = 0x0b,
 };
 
 /* The struct acc_bmmsg_* structure declarations that follow here provide
@@ -137,7 +159,7 @@ struct acc_bmmsg_rxtxdone {
 		u8 len;
 		u8 txdfifo_idx;
 		u8 zeroes8;
-		u8 reserved;
+		u8 fdf;
 	} acc_dlc;
 	u8 data[CAN_MAX_DLEN];
 	/* Time stamps in struct acc_ov::timestamp_frequency ticks. */
@@ -214,6 +236,17 @@ struct acc_bmmsg_hotplug {
 	u32 reserved2[7];
 };
 
+struct acc_bmmsg_fddata {
+	u8 msg_id;
+	u8 reserved1[1];
+	u8 acc_dlc_len;
+	u8 reserved2[1];
+	union {
+		u8 ui8[ACC_FDD_SLICE_SIZE];
+		u32 ui32[ACC_FDD_SLICE_SIZE / sizeof(u32)];
+	} fdd;
+};
+
 union acc_bmmsg {
 	u8 msg_id;
 	struct acc_bmmsg_rxtxdone rxtxdone;
@@ -223,6 +256,7 @@ union acc_bmmsg {
 	struct acc_bmmsg_errstatechange errstatechange;
 	struct acc_bmmsg_timeslice timeslice;
 	struct acc_bmmsg_hwtimer hwtimer;
+	struct acc_bmmsg_fddata fddata;
 };
 
 /* Check size of union acc_bmmsg to be of expected size. */
@@ -246,6 +280,8 @@ struct acc_core {
 	u8 tx_fifo_size;
 	u8 tx_fifo_head;
 	u8 tx_fifo_tail;
+	u8 reserved;
+	u8 fdd[CANFD_MAX_DLEN - CAN_MAX_DLEN];
 };
 
 struct acc_ov {
@@ -354,5 +390,4 @@ netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netdev);
 int acc_get_berr_counter(const struct net_device *netdev,
 			 struct can_berr_counter *bec);
 int acc_set_mode(struct net_device *netdev, enum can_mode mode);
-int acc_set_bittiming(struct net_device *netdev);
 irqreturn_t acc_card_interrupt(struct acc_ov *ov, struct acc_core *cores);
-- 
2.34.1


