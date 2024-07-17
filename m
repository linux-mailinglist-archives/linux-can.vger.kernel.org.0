Return-Path: <linux-can+bounces-987-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0C1934412
	for <lists+linux-can@lfdr.de>; Wed, 17 Jul 2024 23:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45405282B41
	for <lists+linux-can@lfdr.de>; Wed, 17 Jul 2024 21:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C005E18C16D;
	Wed, 17 Jul 2024 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="kxMdpF8A"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021101.outbound.protection.outlook.com [52.101.65.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE43187325;
	Wed, 17 Jul 2024 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252658; cv=fail; b=tWj4WXAMvzzN84VmzxddVsqqOp1YPPEdzrJ+ikqDG/q8XftiuHn9kZKmj3xr9LilaUjS5pIMlnxYVnOOtg/AZIZX8nv9rvXyr3Gt333o0XLLwryqmco/6NhvwerC3YEo+4B80sZ9hAAYVBRNDDrNeAhG+bFWYl2gweRjHZy05s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252658; c=relaxed/simple;
	bh=fWbvBHKrWJT2QHXDdYmHiLsEgrKYcWS9XghsdlLl5jY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLg10Bf2XrRpEKsq7AdC6xXjevNriaEz7HQkmzkGMZwqcokCLG9iDV2CQIZRzMsX0E5aC5lVjzzZstuHRTGwXr0caFkRn3mLhEZrqQ7Tmejo/xQ/SF1y1UHdMoGfjNDyyZXH+9I73mWDe6W0CtpeOyLD2P0waeEQkr3kdZkW4QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=kxMdpF8A; arc=fail smtp.client-ip=52.101.65.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E19Cxvhuil1JPN3qhN7JrSGw8jiYbcrPWCyhML9SAg+2xOgKpBLzeF5MVcVtlv+7bEQnLHkZHgabK83rudh9Q8ctH1MSH97ISlw5tyLTSITAevVJDgNztaDuPPenYL5hADskRswzQVijDQblkv0dqhbFBvYNfzDf8RIDhUE7mcGBLaVtw5Fn/UX7uGovWMU01jZJFmquClnDxRudX+kwS1+elpllJefcaJje6HxH2dvv9ZupsLM6tnFr+7x91YpwNfl7uuhd0EviKTr+zHTSsGKvYKGRNhMlF4/tMTsfxKTYGWjZ2kND40aSsezyc2wHI/Kw0HArxf9fGxTtxwYxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t9cg9MUrzlNcPKH8xVyy9AVPEoX4vJ/X1Ms2jwjlhs=;
 b=ygJNQbMqBkAkImdYlQlX4gqgr0G1B9PR+14LtauOWHUn/mI6vDdQHknpw3CJbgTbcfBnJPPf3ucwY47+rnUUx8ohK2hiJSxcNunMv4YIwUUantArxz3VQ8+lEyhEsbgp4jHWTDIpjTCLgae6YODOHsPOGG2GWiOLXYwEMUl0IlHwIhDHNRkfTIYWzA6oMef2SIMann6Sa3NMVKD+ktBDKzFQytdcIuEIjnp50JOvmsdQQkMEUM8TOaD98MNhPUtqmpI+I7DMY2QUVnbmu4Ko+TeVebdkh8DipuSQlj22jNeKBI4pJ/MLWRy2wgIAY7bxp4zhnqz3jdE0fyZZItIAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t9cg9MUrzlNcPKH8xVyy9AVPEoX4vJ/X1Ms2jwjlhs=;
 b=kxMdpF8AnZZIYh3SoLkVtni56+8SYUnDgMLljK3lytJmMdTYErr6E0huVYtI9dTPXeTHXdOvPxkngIlN8+pU14Fn3H+SgLfHw5NuUYAf2ZyjyQIeHu8gkedEQqhjKdlHQnB7Mi76SU3AWowCIvmxjKesmMC8fWdvHq2O4/rVmOY=
Received: from DUZPR01CA0233.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::17) by GV2PR03MB9524.eurprd03.prod.outlook.com
 (2603:10a6:150:da::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 21:44:10 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:4b4:cafe::5a) by DUZPR01CA0233.outlook.office365.com
 (2603:10a6:10:4b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Wed, 17 Jul 2024 21:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server id 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024
 21:44:09 +0000
Received: from debby.esd.local (jenkins.esd.local [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 8947E7C16C9;
	Wed, 17 Jul 2024 23:44:09 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 7A03D2E0157; Wed, 17 Jul 2024 23:44:09 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 1/2] can: esd_402_pci: Rename esdACC CTRL register macros
Date: Wed, 17 Jul 2024 23:44:08 +0200
Message-Id: <20240717214409.3934333-2-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240717214409.3934333-1-stefan.maetje@esd.eu>
References: <20240717214409.3934333-1-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9D:EE_|GV2PR03MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: affec90e-0fa5-43c4-d1bf-08dca6a9976e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHFudXptWUtCT3hpQ0s4SjM4dU1xdUthSjJmNjR2SnFGM3JNY2dVb0U5Vmxr?=
 =?utf-8?B?cHpRWWRqWjJpaHV0dzBkZUtReU5lSy90QWZmZ3V2VGNFSTR0cUsrK1VhTStM?=
 =?utf-8?B?c0JkNzBWNWxDRDRCZ3BSdzNJb09xSDVnK29Va2tVcGk1cXNSZzE2b2pqdzI0?=
 =?utf-8?B?NHZpQ2VwT29xL2tMWFQvdStONWw1Z1Rkdmk5MkNEUUsrOFUyeGxYL0RUd2RG?=
 =?utf-8?B?TW1rd2srcktSOUZ3OUFvWTBmcGxWVWQ5SXZtVXRVTlFJM1E5NGIybHR6OHU2?=
 =?utf-8?B?WWptNittU2hZWlJDb1VIa3M4RjBNUlVVbnZ6d1plczk3S3V0MjFHbjFiM0p6?=
 =?utf-8?B?emJBM1I2cEVPVmYyc0t6TmJXYUhoQ1FRRlIxL2dLV2hBakt6cCtRSGdRcm91?=
 =?utf-8?B?dHY4Q3F1VWI4eTJRM1lENHJnYlNxR0Q4cEhLZ1hHeG1rR1hwMnFPNkNyYktk?=
 =?utf-8?B?RnlYVDhuMUhqcDFuUnNlVC9jSml0NS9SZUQ4ZGJhWHVHZmVDY2hDTjlKblY5?=
 =?utf-8?B?clIya0draDBBTGdzdTZrNDJTYmRsNi84dlJ5eGVkMEdnaGl6S09YUVNnOGJs?=
 =?utf-8?B?VGdYdUpQcXZNQ3BsU1Y2Sjh3R2NZalgvSTZ5LzM3d3BSTWg3MUhoQ0RJbHM5?=
 =?utf-8?B?TStWUmREUmd5a0RMYnZTN3g4dXQ4a3F2czAvQWQ2d28vQmNsUnFxNzE1UjMr?=
 =?utf-8?B?K3R6TCs2LzBDcjJhblhnR21CTkVuZTdOdlZSc1ZKV0I2N2NHa0ZGYlAzNURa?=
 =?utf-8?B?U3d6UHdsWk4xU3J1QVpiWldmNFllU1dKZDJMejNZMlRKM0VVVDkveXV1SFg1?=
 =?utf-8?B?ZGpEYjRYMHd3REhqcjdFc1h3cTEvcmNYV1ZqQkxoR2FVM3UweXBhZ2R3WnRO?=
 =?utf-8?B?SlMraFBGMFZoRkhjU2MxbHVuZ05RQUJ2a0tMUFNOU1ViRXhQV2JPdlI1Yjdk?=
 =?utf-8?B?dGpqT0poMHdWaFRmSGFDOVJyNmNRT2JwZTV5OHhBbksxWnZuOXVPaXhPbXlj?=
 =?utf-8?B?c3dTTXlVd0srZ3ZjZHQ1QXpHLzE2RlRHSmYrMEU2d0hPVDBDV1lKb2l0ek9L?=
 =?utf-8?B?NllXcDdqbGFnZytnVm9aRTJrQzFlYWJzZVJTY1dPcGEwL0hoSXJMbFRsQ1FP?=
 =?utf-8?B?b1YyZHlUbjd4RDM5NkFUeWlHK056Zy9vcDRqaEhHWFhxSlo1Wm0vTHcydW4x?=
 =?utf-8?B?eGduTTh4SWxoZDd3akF3eVl3cmIrZlpESTQzbU9DbEp6NFp2TnFYekJ1R0lL?=
 =?utf-8?B?S3ZZaTdBMVVXNmZJbE9MVHZkY2pCTnNDemkxV1ArMkViN04zOTVzRU9jNzJT?=
 =?utf-8?B?ekhkZHlMT250WjR0eUsvTUVkbjhTMnNXbjJaWHZiaXNOZnJpaUZWSXZUSUdB?=
 =?utf-8?B?TnZBTG9mMlB6UFE0YmlLWm8xYStCanVoWnMzR0pCSFRTUENLdlRHblZvNXFV?=
 =?utf-8?B?dmltR0VDZ2ZHMVp0bW5VektTVnYwcUQ5TGdYN3RVYmhtcHRlNzkrZTliTEhB?=
 =?utf-8?B?TnNnNFdhMjVMSE9rT0h4YjNEKytDTWpOZVpiTCtFWlR0bTJqdGZpWWloR2dV?=
 =?utf-8?B?NGlHOEEvMjJZQTVEeFpHNlROVjNQb0hzczFsK1hmR2g4UlpwaEduQVZUNVFV?=
 =?utf-8?B?WGVLdmZWVjlTOE9KYXExNyt5ZTYrN29jbHJTR2kwVlp6OVBrMndWR3QyUEQ5?=
 =?utf-8?B?bndKVnRuRlh6OVV6dWRvek9JRDdwSDVmODJnd0ozNHJCZXJBTDRMalYzbllO?=
 =?utf-8?B?aGNIdHZxRHB2MEZKbEh1YTE5NnJWWVBybW1ieFF3bEV3anRPeG9vVmYwQmhi?=
 =?utf-8?B?WEd5U2lCN1AwMU5na3lyOWdQMVVzYlRUc2JWcTlSRTRiYXR4Q0k1MWVLaDkv?=
 =?utf-8?B?dDNPMnZVNGI0dml1Y25reGdXbGxXNHhsS0xidHJjZ2VhcHNENDFsam9rSTlL?=
 =?utf-8?Q?CG9osnl92IU9MGGyPTUPIcsIiNcQuFyi?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 21:44:09.8980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: affec90e-0fa5-43c4-d1bf-08dca6a9976e
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9524

Rename macros to use for esdACC CTRL register access to match the
internal documentation and to make the macro prefix consistent.

- ACC_CORE_OF_CTRL_MODE -> ACC_CORE_OF_CTRL
  Makes the name match the documentation.
- ACC_REG_CONTROL_MASK_MODE_ -> ACC_REG_CTRL_MASK_
  ACC_REG_CONTROL_MASK_ -> ACC_REG_CTRL_MASK_
  Makes the prefix consistent for macros describing masks in the same
  register (CTRL).

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/esd/esdacc.c | 46 ++++++++++++++++++------------------
 drivers/net/can/esd/esdacc.h | 37 +++++++++++++++--------------
 2 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
index 121cbbf81458..ef33d2ccd220 100644
--- a/drivers/net/can/esd/esdacc.c
+++ b/drivers/net/can/esd/esdacc.c
@@ -43,8 +43,8 @@
 
 static void acc_resetmode_enter(struct acc_core *core)
 {
-	acc_set_bits(core, ACC_CORE_OF_CTRL_MODE,
-		     ACC_REG_CONTROL_MASK_MODE_RESETMODE);
+	acc_set_bits(core, ACC_CORE_OF_CTRL,
+		     ACC_REG_CTRL_MASK_RESETMODE);
 
 	/* Read back reset mode bit to flush PCI write posting */
 	acc_resetmode_entered(core);
@@ -52,8 +52,8 @@ static void acc_resetmode_enter(struct acc_core *core)
 
 static void acc_resetmode_leave(struct acc_core *core)
 {
-	acc_clear_bits(core, ACC_CORE_OF_CTRL_MODE,
-		       ACC_REG_CONTROL_MASK_MODE_RESETMODE);
+	acc_clear_bits(core, ACC_CORE_OF_CTRL,
+		       ACC_REG_CTRL_MASK_RESETMODE);
 
 	/* Read back reset mode bit to flush PCI write posting */
 	acc_resetmode_entered(core);
@@ -172,7 +172,7 @@ int acc_open(struct net_device *netdev)
 	struct acc_net_priv *priv = netdev_priv(netdev);
 	struct acc_core *core = priv->core;
 	u32 tx_fifo_status;
-	u32 ctrl_mode;
+	u32 ctrl;
 	int err;
 
 	/* Retry to enter RESET mode if out of sync. */
@@ -187,19 +187,19 @@ int acc_open(struct net_device *netdev)
 	if (err)
 		return err;
 
-	ctrl_mode = ACC_REG_CONTROL_MASK_IE_RXTX |
-			ACC_REG_CONTROL_MASK_IE_TXERROR |
-			ACC_REG_CONTROL_MASK_IE_ERRWARN |
-			ACC_REG_CONTROL_MASK_IE_OVERRUN |
-			ACC_REG_CONTROL_MASK_IE_ERRPASS;
+	ctrl = ACC_REG_CTRL_MASK_IE_RXTX |
+		ACC_REG_CTRL_MASK_IE_TXERROR |
+		ACC_REG_CTRL_MASK_IE_ERRWARN |
+		ACC_REG_CTRL_MASK_IE_OVERRUN |
+		ACC_REG_CTRL_MASK_IE_ERRPASS;
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
-		ctrl_mode |= ACC_REG_CONTROL_MASK_IE_BUSERR;
+		ctrl |= ACC_REG_CTRL_MASK_IE_BUSERR;
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
-		ctrl_mode |= ACC_REG_CONTROL_MASK_MODE_LOM;
+		ctrl |= ACC_REG_CTRL_MASK_LOM;
 
-	acc_set_bits(core, ACC_CORE_OF_CTRL_MODE, ctrl_mode);
+	acc_set_bits(core, ACC_CORE_OF_CTRL, ctrl);
 
 	acc_resetmode_leave(core);
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
@@ -218,13 +218,13 @@ int acc_close(struct net_device *netdev)
 	struct acc_net_priv *priv = netdev_priv(netdev);
 	struct acc_core *core = priv->core;
 
-	acc_clear_bits(core, ACC_CORE_OF_CTRL_MODE,
-		       ACC_REG_CONTROL_MASK_IE_RXTX |
-		       ACC_REG_CONTROL_MASK_IE_TXERROR |
-		       ACC_REG_CONTROL_MASK_IE_ERRWARN |
-		       ACC_REG_CONTROL_MASK_IE_OVERRUN |
-		       ACC_REG_CONTROL_MASK_IE_ERRPASS |
-		       ACC_REG_CONTROL_MASK_IE_BUSERR);
+	acc_clear_bits(core, ACC_CORE_OF_CTRL,
+		       ACC_REG_CTRL_MASK_IE_RXTX |
+		       ACC_REG_CTRL_MASK_IE_TXERROR |
+		       ACC_REG_CTRL_MASK_IE_ERRWARN |
+		       ACC_REG_CTRL_MASK_IE_OVERRUN |
+		       ACC_REG_CTRL_MASK_IE_ERRPASS |
+		       ACC_REG_CTRL_MASK_IE_BUSERR);
 
 	netif_stop_queue(netdev);
 	acc_resetmode_enter(core);
@@ -233,9 +233,9 @@ int acc_close(struct net_device *netdev)
 	/* Mark pending TX requests to be aborted after controller restart. */
 	acc_write32(core, ACC_CORE_OF_TX_ABORT_MASK, 0xffff);
 
-	/* ACC_REG_CONTROL_MASK_MODE_LOM is only accessible in RESET mode */
-	acc_clear_bits(core, ACC_CORE_OF_CTRL_MODE,
-		       ACC_REG_CONTROL_MASK_MODE_LOM);
+	/* ACC_REG_CTRL_MASK_LOM is only accessible in RESET mode */
+	acc_clear_bits(core, ACC_CORE_OF_CTRL,
+		       ACC_REG_CTRL_MASK_LOM);
 
 	close_candev(netdev);
 	return 0;
diff --git a/drivers/net/can/esd/esdacc.h b/drivers/net/can/esd/esdacc.h
index a70488b25d39..d13dfa60703a 100644
--- a/drivers/net/can/esd/esdacc.h
+++ b/drivers/net/can/esd/esdacc.h
@@ -50,7 +50,7 @@
 #define ACC_OV_REG_MODE_MASK_FPGA_RESET BIT(31)
 
 /* esdACC CAN Core Module */
-#define ACC_CORE_OF_CTRL_MODE 0x0000
+#define ACC_CORE_OF_CTRL 0x0000
 #define ACC_CORE_OF_STATUS_IRQ 0x0008
 #define ACC_CORE_OF_BRP	0x000c
 #define ACC_CORE_OF_BTR	0x0010
@@ -66,21 +66,22 @@
 #define ACC_CORE_OF_TXFIFO_DATA_0 0x00c8
 #define ACC_CORE_OF_TXFIFO_DATA_1 0x00cc
 
-#define ACC_REG_CONTROL_MASK_MODE_RESETMODE BIT(0)
-#define ACC_REG_CONTROL_MASK_MODE_LOM BIT(1)
-#define ACC_REG_CONTROL_MASK_MODE_STM BIT(2)
-#define ACC_REG_CONTROL_MASK_MODE_TRANSEN BIT(5)
-#define ACC_REG_CONTROL_MASK_MODE_TS BIT(6)
-#define ACC_REG_CONTROL_MASK_MODE_SCHEDULE BIT(7)
-
-#define ACC_REG_CONTROL_MASK_IE_RXTX BIT(8)
-#define ACC_REG_CONTROL_MASK_IE_TXERROR BIT(9)
-#define ACC_REG_CONTROL_MASK_IE_ERRWARN BIT(10)
-#define ACC_REG_CONTROL_MASK_IE_OVERRUN BIT(11)
-#define ACC_REG_CONTROL_MASK_IE_TSI BIT(12)
-#define ACC_REG_CONTROL_MASK_IE_ERRPASS BIT(13)
-#define ACC_REG_CONTROL_MASK_IE_ALI BIT(14)
-#define ACC_REG_CONTROL_MASK_IE_BUSERR BIT(15)
+/* CTRL register layout */
+#define ACC_REG_CTRL_MASK_RESETMODE BIT(0)
+#define ACC_REG_CTRL_MASK_LOM BIT(1)
+#define ACC_REG_CTRL_MASK_STM BIT(2)
+#define ACC_REG_CTRL_MASK_TRANSEN BIT(5)
+#define ACC_REG_CTRL_MASK_TS BIT(6)
+#define ACC_REG_CTRL_MASK_SCHEDULE BIT(7)
+
+#define ACC_REG_CTRL_MASK_IE_RXTX BIT(8)
+#define ACC_REG_CTRL_MASK_IE_TXERROR BIT(9)
+#define ACC_REG_CTRL_MASK_IE_ERRWARN BIT(10)
+#define ACC_REG_CTRL_MASK_IE_OVERRUN BIT(11)
+#define ACC_REG_CTRL_MASK_IE_TSI BIT(12)
+#define ACC_REG_CTRL_MASK_IE_ERRPASS BIT(13)
+#define ACC_REG_CTRL_MASK_IE_ALI BIT(14)
+#define ACC_REG_CTRL_MASK_IE_BUSERR BIT(15)
 
 /* BRP and BTR register layout for CAN-Classic version */
 #define ACC_REG_BRP_CL_MASK_BRP GENMASK(8, 0)
@@ -300,9 +301,9 @@ static inline void acc_clear_bits(struct acc_core *core,
 
 static inline int acc_resetmode_entered(struct acc_core *core)
 {
-	u32 ctrl = acc_read32(core, ACC_CORE_OF_CTRL_MODE);
+	u32 ctrl = acc_read32(core, ACC_CORE_OF_CTRL);
 
-	return (ctrl & ACC_REG_CONTROL_MASK_MODE_RESETMODE) != 0;
+	return (ctrl & ACC_REG_CTRL_MASK_RESETMODE) != 0;
 }
 
 static inline u32 acc_ov_read32(struct acc_ov *ov, unsigned short offs)
-- 
2.34.1


