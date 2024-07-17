Return-Path: <linux-can+bounces-985-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5873993440C
	for <lists+linux-can@lfdr.de>; Wed, 17 Jul 2024 23:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D49B1C20B30
	for <lists+linux-can@lfdr.de>; Wed, 17 Jul 2024 21:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AFD187355;
	Wed, 17 Jul 2024 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="HnmoEQ6b"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023137.outbound.protection.outlook.com [52.101.67.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689F4688;
	Wed, 17 Jul 2024 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721252657; cv=fail; b=p1HlGk8sP7LAjFKkuJyXJNKDfPW4P1qpm89f2k/6deOpcUutro1EFc80BPqbJku9MmY2M4n7yWfbl0fq2vdMAZV148p3XFLj99tt9lGOVr774zMltfy1t93EejnJ/606dEEcJCBJ+ddujOPp1i/7plKHYp4fSgdqxRJRKpZlc9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721252657; c=relaxed/simple;
	bh=iBuU0KgkP5loNvI9ehGVm8Olu21jZYbjftYW2u+nLvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XX+Ogj5E+sviZTOnzF4bqHo15wU/bVo4LVc3vTeGV4GuFVcHUtE2SGJ9Csvgn8ObvsPJQsBT7NjjE51/cqLxsygpHC3xgll8dpY5bSZs9fJdMSeXDYeMCZN6JGay0LaJukSXsnCLcOBXx8XB4Cb7lrcXEPGigZjSK9sx9k1q7rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=HnmoEQ6b; arc=fail smtp.client-ip=52.101.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1nKm0aGduJvObZnGvyNKcMYj6XX/r79L863PsmrcZtiQuxIaioeodwdtSuWqGgQ51AJ+c5NXQ5xd6ShjDyKb6rSCm/EYjMl5KILa2OZyo8HuGAAtksEYgzl/hqB0wQNRg00PfPX5fhiy5o0mA5yVFf7cU41ElcrOW9Xz+PIL9cgTFzpAepxopP/zSvGCIA5UqeXBGk1gadl5D2U2csQKrAKTiF+2vaDOAVp7fa6mEgsIfKKZWlVKpZ2yXqikLvAOg8FVNrzbMXso7BiNJUoygA7qzSpqVILcHxnqpRp+g+BPVVvTDwvXx6LZfoBQKtx0Ta+E6yr7jqvzNubqQ7Jnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLB1l7TZKzTbV5W/Z74Yx3nlK05AboEEchJ6yWSO0m8=;
 b=i1PvgIoR4y/w5ChLzosRNXg2NDY4sL00maC3xRU0n/xO+ndiNenIOKQ7eNSVOzIc45eK9R5e2O1z5cmV4nxS5k+irR3xb2FrynXSJ4XXMLjqh2+GMY5o/6pOZQo3oRPR5sWSuyymb8/5oohGqLK5cJKZHJqHXcPgk9K5aXgxaZz9KO47YMA4ZtJjvQWeZZw4gEKApBsNQpqJM/VS8HhHzeVucx1U0L8kqSJ1GgHEvGtekf0pFriiAFPlsgXa6o9a4ONpjfbveM/HNxt+NV01uledVKNZfDjWDa83l8p51rTqcaqju5u8QSVfRwnLGJN9vf3mR1gWxBHdtIqNbEtiKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLB1l7TZKzTbV5W/Z74Yx3nlK05AboEEchJ6yWSO0m8=;
 b=HnmoEQ6blubqwEFrZCsqLZDNA+qTV2XCnkyu86ZVtCUW1+NIeeXBFSjpFKMQqSlb9yN3BXvmq4bEAJ8dy5hcTexGd9YOZVg7ue5pQ03BhIZ0mXPMN+Aff97NedD+ykX4M8zoJZDn5DAjYlLG++wa9PCeEZT1t1Sx9h6ekbSPiSs=
Received: from AS4P191CA0053.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::29)
 by DU2PR03MB10163.eurprd03.prod.outlook.com (2603:10a6:10:49d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 21:44:10 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::b3) by AS4P191CA0053.outlook.office365.com
 (2603:10a6:20b:657::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Wed, 17 Jul 2024 21:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server id 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024
 21:44:09 +0000
Received: from debby.esd.local (jenkins.esd [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 8B2287C16CB;
	Wed, 17 Jul 2024 23:44:09 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 7EEA52E0166; Wed, 17 Jul 2024 23:44:09 +0200 (CEST)
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
Subject: [PATCH 2/2] can: esd_402_pci: Add support for one-shot mode
Date: Wed, 17 Jul 2024 23:44:09 +0200
Message-Id: <20240717214409.3934333-3-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|DU2PR03MB10163:EE_
X-MS-Office365-Filtering-Correlation-Id: bc644768-dd9b-4bfd-a9ee-08dca6a99761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEI4UFlDMXB6VDM4aFVBVEJnb2ZZdlBRbFlpNTVGdytvbHlMMGZSenlPanh3?=
 =?utf-8?B?UVpURXRvTStqZUJRVVc4a1ROS0xHTjRxN2E4NGJ1eGpnWjcyMUpienZQQXBH?=
 =?utf-8?B?N1ZyNmdOSmZINHE5a3VTR0ErdmZONVlzTUg1T1g2TWx3R3BNSjVVdEZTc0xG?=
 =?utf-8?B?SXpkNHJ5akxpYVR2TlJqNTY1WlU0RU4zQTVFZWg2OGZ1UVQ0Ym9FdUt3UXBO?=
 =?utf-8?B?TlFjZTBFRFZPYXZ6QjRhOHZZclF0UFBWSGU4bTF3OWVwY3owSWZCelFYQVls?=
 =?utf-8?B?RkU5RCtJY3ppblZDZ0xuYWRLMkxGNGF6K09KVEJBVXpJMzg2YWFyZ014bnJI?=
 =?utf-8?B?bmp6OTVJS0VHQkVCclB2M0k4cXVBNnFRUStnWUZkSktNVDJtanF4NDl5THpR?=
 =?utf-8?B?Wkw2eTZhR3Zxb01sSFNCenpPL2xWNC80Q1pNelNFV21CMDVyNXd5eEtvM2RG?=
 =?utf-8?B?STlaSE5RT2ZkUDcvOGpxWEQ3NnNzQ005ajhjRUsyL1RrdHpDR3dOUGpKRkND?=
 =?utf-8?B?YkdpL3ZINWZEcnJuMldTZXN6clhVbnRqYXVpTTZPNWFNRVBSblo1SGhJMDRD?=
 =?utf-8?B?RlIreFpuS2d0R2g0UWVhbER3TmxPVWI3aVlCbkNaa2xJR0RSb2hvU2VENzFD?=
 =?utf-8?B?TDUzUDh5d2c0R2lQbW1LcW1IdmtiUCs1VGpLbWJ6NjQxaVN2UWhobnd2V3J5?=
 =?utf-8?B?c1FRcHFXbm16a2lQcG91TU5FN1RaWEpwR0xvMCtCMi92VlBkZUVmMW1CK3VS?=
 =?utf-8?B?VEFSdXl3dnlqTTVjR0ZkSzFDSmlkTHZRUmhWeTY3TW14QjJmZ09FRFBKY2h6?=
 =?utf-8?B?b0JyMGJkSzRHcXFjV1hYZmxpZW94RFd0U2ZtdklFRnMyWTRSQXlTc2w3Yjdq?=
 =?utf-8?B?aVQzQTZacTVmallKOE5aQ3c3N1RqblhRMW9vdThwNXFPVnpPSlRzRGs4V0xk?=
 =?utf-8?B?bFJWWnBxT1U1Q0ZTWVlFM21lV0tyVjE1ZkhpeGQwZFhKdzRiamloaHI0Z3pG?=
 =?utf-8?B?aWdRc3R2OXRoQTdsWGl5U3JwMjVRSHJUTE1IR3pQVk5qd0YxVmVFdWk2NmNJ?=
 =?utf-8?B?QU55RGROYzBnVGpjcUJOZ0RMYU1qaEhKWDdIYjgvdkpZMGxaMzhhUEhjWkth?=
 =?utf-8?B?dGV0TVdQL29nZS9Ka0lkdEdjQVFtMER0aDk3cVlERjUvSTh4SjY4dnpybG9x?=
 =?utf-8?B?QW1rWTJPckg1emJqZTAyakxiN1g0cWdEMWxmNU9YV1c5L3VkTW5iaTBwVmtY?=
 =?utf-8?B?R2drQ0lBRHhDSlJSQ2RwV2lieFQySVptMVNCVjNIckpHNHFDcUZrQkVjamRl?=
 =?utf-8?B?WjZNekZrQnNMU3F1UU9vbTM2ckVtVWhOTy91WDR3c0pEa2dtTmcwaUlBRzN4?=
 =?utf-8?B?eHFBeUtQeHp0a0RlSTBRTWJzOXhpWHRJU1Z0d09VTWFzcEhlOEM0dEthV2V4?=
 =?utf-8?B?OFN0dzNWUUZzeWIvTE5EQ3YweWJEay9NbGkyYUcvTDgxR0pldkd4YjBMdFdy?=
 =?utf-8?B?RGF1RVMzazEybnlKV05PbmZYNU1pY2FSdCt1aUxzUTJ4MTJKa09WaHN2RFJB?=
 =?utf-8?B?cnJxT1J4akxQR2JVYmphS1ArZFdkdk9DNmZWYm5rZllaUlpVMHlVbjZ4WWFv?=
 =?utf-8?B?VS85TkYveHM1aDFFektzeGJDN0ZoZ3BwcjdncCs1a1c5bm9tYjFQdVQ4MmdH?=
 =?utf-8?B?b1dFN1BoSnlueWpVQU42MWtBVUIwUWxFYTNEWk1rTHJNVmNSalhQam5wZ0tF?=
 =?utf-8?B?MnpQMllidkhBV3M0bWhvWjV0dEtzeHFNZEowT2Z2UEl3N1owSXBMZHBXNGZX?=
 =?utf-8?B?dndxekFBd3IwTGhGUTlmL0ZvRHpkRkN1MmhJZ2l1Mm1ob3V5Q1BzZGw1YWZZ?=
 =?utf-8?B?UitqcGE4a1NWWGZwQjd6K0dFYWZhMThuSC9naEZmMVZ3N3NZZ0wvbnhvcHZn?=
 =?utf-8?Q?me4DzJCHosh9Pp0DaLVSsuTv4cwGf6yh?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 21:44:09.8586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc644768-dd9b-4bfd-a9ee-08dca6a99761
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB10163

This patch adds support for one-shot mode. In this mode there happens no
automatic retransmission in the case of an arbitration lost error or on
any bus error.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/esd/esd_402_pci-core.c | 5 +++--
 drivers/net/can/esd/esdacc.c           | 9 +++++++--
 drivers/net/can/esd/esdacc.h           | 1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/esd/esd_402_pci-core.c b/drivers/net/can/esd/esd_402_pci-core.c
index b7cdcffd0e45..5d6d2828cd04 100644
--- a/drivers/net/can/esd/esd_402_pci-core.c
+++ b/drivers/net/can/esd/esd_402_pci-core.c
@@ -369,12 +369,13 @@ static int pci402_init_cores(struct pci_dev *pdev)
 		SET_NETDEV_DEV(netdev, &pdev->dev);
 
 		priv = netdev_priv(netdev);
+		priv->can.clock.freq = card->ov.core_frequency;
 		priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 			CAN_CTRLMODE_LISTENONLY |
 			CAN_CTRLMODE_BERR_REPORTING |
 			CAN_CTRLMODE_CC_LEN8_DLC;
-
-		priv->can.clock.freq = card->ov.core_frequency;
+		if (card->ov.features & ACC_OV_REG_FEAT_MASK_DAR)
+			priv->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
 		if (card->ov.features & ACC_OV_REG_FEAT_MASK_CANFD)
 			priv->can.bittiming_const = &pci402_bittiming_const_canfd;
 		else
diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
index ef33d2ccd220..c80032bc1a52 100644
--- a/drivers/net/can/esd/esdacc.c
+++ b/drivers/net/can/esd/esdacc.c
@@ -17,6 +17,9 @@
 /* esdACC DLC register layout */
 #define ACC_DLC_DLC_MASK GENMASK(3, 0)
 #define ACC_DLC_RTR_FLAG BIT(4)
+#define ACC_DLC_SSTX_FLAG BIT(24)	/* Single Shot TX */
+
+/* esdACC DLC in struct acc_bmmsg_rxtxdone::acc_dlc.len only! */
 #define ACC_DLC_TXD_FLAG BIT(5)
 
 /* ecc value of esdACC equals SJA1000's ECC register */
@@ -59,7 +62,7 @@ static void acc_resetmode_leave(struct acc_core *core)
 	acc_resetmode_entered(core);
 }
 
-static void acc_txq_put(struct acc_core *core, u32 acc_id, u8 acc_dlc,
+static void acc_txq_put(struct acc_core *core, u32 acc_id, u32 acc_dlc,
 			const void *data)
 {
 	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_1,
@@ -249,7 +252,7 @@ netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	u8 tx_fifo_head = core->tx_fifo_head;
 	int fifo_usage;
 	u32 acc_id;
-	u8 acc_dlc;
+	u32 acc_dlc;
 
 	if (can_dropped_invalid_skb(netdev, skb))
 		return NETDEV_TX_OK;
@@ -274,6 +277,8 @@ netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	acc_dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
 	if (cf->can_id & CAN_RTR_FLAG)
 		acc_dlc |= ACC_DLC_RTR_FLAG;
+	if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+		acc_dlc |= ACC_DLC_SSTX_FLAG;
 
 	if (cf->can_id & CAN_EFF_FLAG) {
 		acc_id = cf->can_id & CAN_EFF_MASK;
diff --git a/drivers/net/can/esd/esdacc.h b/drivers/net/can/esd/esdacc.h
index d13dfa60703a..6b7ebd8c91b2 100644
--- a/drivers/net/can/esd/esdacc.h
+++ b/drivers/net/can/esd/esdacc.h
@@ -35,6 +35,7 @@
  */
 #define ACC_OV_REG_FEAT_MASK_CANFD BIT(27 - 16)
 #define ACC_OV_REG_FEAT_MASK_NEW_PSC BIT(28 - 16)
+#define ACC_OV_REG_FEAT_MASK_DAR BIT(30 - 16)
 
 #define ACC_OV_REG_MODE_MASK_ENDIAN_LITTLE BIT(0)
 #define ACC_OV_REG_MODE_MASK_BM_ENABLE BIT(1)
-- 
2.34.1


