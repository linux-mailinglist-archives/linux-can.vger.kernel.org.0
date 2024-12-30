Return-Path: <linux-can+bounces-2510-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFF49FE70A
	for <lists+linux-can@lfdr.de>; Mon, 30 Dec 2024 15:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE74E1881E73
	for <lists+linux-can@lfdr.de>; Mon, 30 Dec 2024 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF7B2594A6;
	Mon, 30 Dec 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Jt2EfqsM"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2128.outbound.protection.outlook.com [40.107.247.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041D25948F
	for <linux-can@vger.kernel.org>; Mon, 30 Dec 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568838; cv=fail; b=HwcyE01jmLjeUlVOpW5tIUe0a2i9KcmXjPmGq1mcyQIqfD5EqqylpbAPNlUYJ3xIwV6xSr1bmLVxWsyJbgK+sqM8x8bXLVAZH+nBH9h+IVT9JZM2sB1VxQWGXxlt/C/1de/EwkH7LZCwbgil3Twl/ZCe7WqKbmzNusLlfne3C64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568838; c=relaxed/simple;
	bh=m1yMFvgwsPyHN8J/OFnaLpeIrBGOPKw9/ijy6JLV1ik=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=N6hEGPED4sjvo7Vf+lFI3FuyBfHHxV2+zdDx06JZ7TUuEsth1berk3c5L7RBvhE+Exd/nDW+DGH3oy6NgqFi7wzakjuvGnD7PZAlQqME8Bin3N7lBkrwYTR4xkuL8xgJxpoKCa1AlHMh7wl6h4VAjviDVOi/KQLwsCtp7gErZbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Jt2EfqsM; arc=fail smtp.client-ip=40.107.247.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUMN6HRY4odkVuPHyf0zMVfSt4qtW/3r28jDQnrdYtTOIoca3EbhWZctsBZjqr9iern/IbJY0kAhS3ougqSNKh7GFmPW59zYnFYo97zvrzMOqK952cTGDmfF60vjcQjWZ5k3Pcy75czhU+t7/9BwWqgmZleeCMKslQS6KVFmdZtQ54cQtDuAlFUktDtDtOSk3rbzATzn4h3K0MOtMRRK6GgUhx370dE8cULwik7mQXJCWG8kA0nCrky5vTep3xm8yHXB1+4uSRo73J0jdjeB9zPC4XngFKtTZtzYkQytSqdK7mJAc1NmsFBBX9VyO6F2VW52sDmCMZGpDhwPYJ87Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPwhIaDwxjotS7KJToPFrinCF3YaFNLnTrGPeWZ843c=;
 b=jATIqzVTHC5T4SI0WaUTQvRjx3MLp7lcKh4uC0+0HG1zr2M94cLKtvHBmI3bmOpEkK0kCMK5YtLbX6mHB96qctZcDsHZK3pUY93s6Fkzxk+G68hcGsb2+4bIxUWaTDicnW+g24ItLhLTYyyBWzawcIoXu7BrBAXWnZezKRwjdw+FxZT5mbk6NCZ2O27/X2L1ZSrgxEMDVhsZ9du7ErRa81TvvMLFhtv/K2RRc7r9cvRHSBvz0OkgJXxt2EzB9U6CjM5wk3Ds0SuBg2/Z7AHOoXfZxAekcM/jfW9dL7grJG922OB0FNA02XbD0N50UzPzP2U3TVjjICUx1FfcIVX8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPwhIaDwxjotS7KJToPFrinCF3YaFNLnTrGPeWZ843c=;
 b=Jt2EfqsM0EBmM4/FqVbvWJvHk9ItJ/jMvPWEdvm18EnUYmKSrsg1/ejlTdTxbpOe5UyeYYXjC2Tl9nUWFGW/poZCs4lpFaGrJRBQUfwu1inSMi4D6jvTJIhm7Sp69DMahc23HTLNSOcTCCphWILerUaQW7e0Qa5tpfSuCf8wosw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB0820.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Mon, 30 Dec
 2024 14:27:08 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%4]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 14:27:08 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 1/4] can: kvaser_usb: Update stats and state even if alloc_can_err_skb() fails
Date: Mon, 30 Dec 2024 15:26:42 +0100
Message-ID: <20241230142645.128244-1-extja@kvaser.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E44.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::51) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB0820:EE_
X-MS-Office365-Filtering-Correlation-Id: ac609470-09ea-4b5b-9cb4-08dd28de0a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XTSJADaTUuIdFkXb39KDrSnPYd5HecHalYHFKEYDfcANfG1fwzk6ybSFiE+C?=
 =?us-ascii?Q?LgDC1UNTZd1k4IR2Fk7Wa6LH1fqo7q7nArPr2TZHsKIgwJJru4iFz/F/+bHg?=
 =?us-ascii?Q?2Rx1S9Qw+8njP+/i9TXxDLJh2A2L5+15mWZe4QL0x81piFhtqkEYRz+QbEYA?=
 =?us-ascii?Q?fWUiYpAfe/rXfBm1LCe0rBgX+MMngl9mxWbFbXfMGkLnQHhv694IbK9KRL52?=
 =?us-ascii?Q?Z6iyFilJ9GNXZrlG8wxp/h+sHxTFIyszdFECsPHxmzPN+fnsgQfB2wjsMrEm?=
 =?us-ascii?Q?9E70lfuXnvdMTPQeeHUH8y2/WKyE1Gxy/nI9IuY9Lhx0y/cz/kyoCnZSzvHW?=
 =?us-ascii?Q?CEyXepY8t6BJP8N0eLbOP4snUqgRm0Os2nEgDcjSvptkwIJxCfT/TnDgyZm1?=
 =?us-ascii?Q?WrIQHSKRuBKjf00GPdEMhheuoElYo/xQAB/nLgV+yhjeQhzgMjQB7WIcl3Lb?=
 =?us-ascii?Q?VIVYSOdKWITLKs32QJBrSkecsCUjZ/dh8rHpapnSJjvfG/SLAEKhM6wsl8ck?=
 =?us-ascii?Q?Wb7jrtMnKoypnw6e3VHvK9dHQgCEnav2yID3k98gimdrjbKteuVQ1R6MJ0Ze?=
 =?us-ascii?Q?5CyxppPZCFN7DYEWdzpivlEWvpLw9oRRhEKjdTR7jT9CQ3/31dOVzwXcL7TB?=
 =?us-ascii?Q?Vuy/zuvFr86tM/mqom9QmmOMxyCIAQzcdwUcl4/LB48eeGajs5mzyjK5qfLx?=
 =?us-ascii?Q?HBqIYfMJpO7mA56iyn0dwhN0flSCR9snH3UiqizDiSEbtma92UGOd0b0vLSS?=
 =?us-ascii?Q?DGMy1xLLG5EsE6u2ZnIh/iDyU2MmFoJpW4/QrjYysQ8wnzFW8sMcfC82h3ip?=
 =?us-ascii?Q?oSLQzyF91cSdbcVNg8e4OdE0SXvOXptKP/G/R28fedz1VeniMUD29Zbt5hLa?=
 =?us-ascii?Q?dMZlbyCiCTE4Ws8yuMhQg7LMZB2VDrdiip8kkEMBalQPNYp5MPowIznW0OdX?=
 =?us-ascii?Q?B82BIt8z6MJH4aZH4TgdGhGJHvuMBrgu+LF2BT09H3yz57f+N4kVcsAY40hd?=
 =?us-ascii?Q?jf4T34WPiYwTybPJuC2uFvdd49IMcZhv3qGGyLU8505mdZUrSk19gGcsqdig?=
 =?us-ascii?Q?uhiwAvh6FxcQijDyaQjyV92sNlOwCaEDUWe7yFkHQNDwyhiNKdrgrAa8ldHo?=
 =?us-ascii?Q?/Jhll2pF/4/YQcjPiYirjGwjtk3gfzFhdjS8fCjMo9yHyEG8NBGiHvywBAQX?=
 =?us-ascii?Q?gCp+qyCiI4dtHHCp3Ba6aYaLyP/ubPJuaBJzgMbqqf4lnwwt9p+9YNfbRAYX?=
 =?us-ascii?Q?aN6bAYd4kYmxsVvfEKeRqM/ScQqsvO4sHUynNbZCm3SAxKsI4GqDZcT23MaO?=
 =?us-ascii?Q?FB/hVOZsJ41qovMnP2U62s7wO8PQ3My2MWpyKNxvA3S8eTmc0boryS++lVL5?=
 =?us-ascii?Q?YBCACeERh7gPQIC2bgggb3QU7pAi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Je4Ca5pO03CuDpxyCr1rRz6EISEj99eSeh0ugws3nZX1tyVOsBfpsm73vZ8c?=
 =?us-ascii?Q?3BCNAYLIvmeOLMDfZiMsUpk/fx4gNVB8LQOz+p7k4Mwr0K1HCzp767E29Ewd?=
 =?us-ascii?Q?boTjsoEQHPlgSOxP3QRi4AsMjwpZ6srM+jE892xAVaYGUqmJHXlTRKuyZebF?=
 =?us-ascii?Q?7VBejey/5Eknq7RQeqnHlkqTV3Pv0p6j8tDzNBL2Igr4lRibGmAy0HcOgWQe?=
 =?us-ascii?Q?hzeqWYf766X/F4j2V5IfFFCN3D1HYl8EdxXEOoIHjj2EIdmMf/WDoafm4t3U?=
 =?us-ascii?Q?PWh0gAaFkrCugrxNfXpKNwtcPrInyYTOrM7r7VM1IyIaIJjQaRZFJi00wTS9?=
 =?us-ascii?Q?m077CWGpWwr6IcD/GrWl0K0XVGt/AjqsbtuLIRFRe1MnaoU9jHAdAbhUOLSg?=
 =?us-ascii?Q?S3k4dIfv0YIBve0Astxq7QRh/hbgrlXKd/UlMzqyKi9sT7gwyqQUCQIKtCpI?=
 =?us-ascii?Q?jUc8iy8xkJa2LbkAWtNf4qwWc2ekvuaBHWz7s/dNQDN5VZwvBJ72vEurIHEC?=
 =?us-ascii?Q?7nvMkctlsYhJ2LaGe7RE7Z+LJDMY4waTx+gMndHIciDNV+Hx7Cd9BQ4dE0mB?=
 =?us-ascii?Q?c4SQq1CLoOYtTUY8W7BXYuFT33rm1fQh5j0j+/ZxdVrllDovqYvtowNh03Q6?=
 =?us-ascii?Q?VhS9AwjUN5lsD2E7hr08bvWAKdrXTMMvuPATx9qEQs4N2BByw2QJ7RHWE7EB?=
 =?us-ascii?Q?KfdqY2iKg4W5G4a2ftJSvgMmNavVbsLgzqtdhjfptF0D6xK2xTgq0EQ0Q2El?=
 =?us-ascii?Q?x7bGfiYeQqFjSnjD47jTOUUC25KyuSKIOPGgBA9JgmMNtqV+AT1IinlM2sl7?=
 =?us-ascii?Q?HhTZjpwy2MOo2Ig27bBBUFEyE5MHkF3mEuAgCP+pR3acZUxovlBwQWDZQmoi?=
 =?us-ascii?Q?asIXRYBweskbMHqH/xagfiaNkbhJWqVri10a7JlLycv7DeSUVHXqngL6P0qn?=
 =?us-ascii?Q?LV5aYiwwXPLAAfRP6zEdLPiIu701dtnJh8cs+OOheIv2Sn1c9+15ftrk7o9Z?=
 =?us-ascii?Q?MeLKtGPN6c836b162phaxwhTvzG5yCr2qaxAnagu0mOlyEVh1qBHy3n5Ixs2?=
 =?us-ascii?Q?lCgmmL9aSvV5b0tk3QnxKqCH8kpZHt2jx+CsKpktIYHiBJ0G2bdtrFOHG2ru?=
 =?us-ascii?Q?fJbaf7Dt6IkngVY+Y7JjfVkUNMe4+9RJtZzE6EAF3c4LBbnrojI+mJ1C07rq?=
 =?us-ascii?Q?V03ml1cIgcAUJhKHi88+pkGrayFsUMx9PMnJNxq/ilo6UjT9RTnfpUrv1kC8?=
 =?us-ascii?Q?z0h6D/edHRqc4dB89smwiKGJdlX4ptgu7Kfwo3KVyy7X3IzOZMpw6Q8TsaMu?=
 =?us-ascii?Q?9efNrlyym1tagGpiYw77ki4e9j3P8Ur+hT2sej7nzaTPIQAzGu6AWoka0loF?=
 =?us-ascii?Q?3BDVZAOO+ceJK9OxcWFn0tq6qV2qkES4yjhwijDumKfgwA4uDxv7o2LwPjxs?=
 =?us-ascii?Q?gH0qh+oKU4SPjOeLCJn288peR2/pVBadwjDJbCxjFU4IX4PDgLlM3p/B/Vzs?=
 =?us-ascii?Q?xW8WPZB8rPRRx1C+kmdy7xbMUQ6M5l8d8ARfneofRZJ/GNCRIuvuJz04UMvE?=
 =?us-ascii?Q?uUo/uK4Lz8wis3A1EfVyA45UZfBZlupgaNL8GajwpM6+CtwOTjeKM0MPH9Wq?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac609470-09ea-4b5b-9cb4-08dd28de0a6f
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 14:27:08.1134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53hlTFJDjaPi9M4tsAdqao/aNITCWByEDqfc00asQK9nJpc2mM6msUOZMcq5ATdXb7iqawCbprXz/yeQhFIPnVcb323e28OzQqn1Hw45L+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0820

Ensure statistics, error counters, and CAN state are updated consistently,
even when alloc_can_err_skb() fails during state changes or error message
frame reception.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 124 +++++++-----------
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  |  31 ++---
 2 files changed, 60 insertions(+), 95 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 3764b263add3..5ec8b300bebf 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -926,6 +926,42 @@ kvaser_usb_hydra_bus_status_to_can_state(const struct kvaser_usb_net_priv *priv,
 	}
 }
 
+static void kvaser_usb_hydra_change_state(struct kvaser_usb_net_priv *priv,
+					  const struct can_berr_counter *bec,
+					  struct can_frame *cf,
+					  enum can_state new_state)
+{
+	struct net_device *netdev = priv->netdev;
+	enum can_state old_state = priv->can.state;
+	enum can_state tx_state, rx_state;
+
+	tx_state = (bec->txerr >= bec->rxerr) ?
+				new_state : CAN_STATE_ERROR_ACTIVE;
+	rx_state = (bec->txerr <= bec->rxerr) ?
+				new_state : CAN_STATE_ERROR_ACTIVE;
+	can_change_state(netdev, cf, tx_state, rx_state);
+
+	if (new_state == CAN_STATE_BUS_OFF && old_state < CAN_STATE_BUS_OFF) {
+		if (priv->can.restart_ms == 0)
+			kvaser_usb_hydra_send_simple_cmd_async(priv, CMD_STOP_CHIP_REQ);
+
+		can_bus_off(netdev);
+	}
+
+	if (priv->can.restart_ms &&
+	    old_state >= CAN_STATE_BUS_OFF &&
+	    new_state < CAN_STATE_BUS_OFF) {
+		priv->can.can_stats.restarts++;
+		if (cf)
+			cf->can_id |= CAN_ERR_RESTARTED;
+	}
+	if (cf && new_state != CAN_STATE_BUS_OFF) {
+		cf->can_id |= CAN_ERR_CNT;
+		cf->data[6] = bec->txerr;
+		cf->data[7] = bec->rxerr;
+	}
+}
+
 static void kvaser_usb_hydra_update_state(struct kvaser_usb_net_priv *priv,
 					  u8 bus_status,
 					  const struct can_berr_counter *bec)
@@ -951,41 +987,11 @@ static void kvaser_usb_hydra_update_state(struct kvaser_usb_net_priv *priv,
 		return;
 
 	skb = alloc_can_err_skb(netdev, &cf);
-	if (skb) {
-		enum can_state tx_state, rx_state;
-
-		tx_state = (bec->txerr >= bec->rxerr) ?
-					new_state : CAN_STATE_ERROR_ACTIVE;
-		rx_state = (bec->txerr <= bec->rxerr) ?
-					new_state : CAN_STATE_ERROR_ACTIVE;
-		can_change_state(netdev, cf, tx_state, rx_state);
-	}
-
-	if (new_state == CAN_STATE_BUS_OFF && old_state < CAN_STATE_BUS_OFF) {
-		if (!priv->can.restart_ms)
-			kvaser_usb_hydra_send_simple_cmd_async
-						(priv, CMD_STOP_CHIP_REQ);
-
-		can_bus_off(netdev);
-	}
-
-	if (!skb) {
+	kvaser_usb_hydra_change_state(priv, bec, cf, new_state);
+	if (skb)
+		netif_rx(skb);
+	else
 		netdev_warn(netdev, "No memory left for err_skb\n");
-		return;
-	}
-
-	if (priv->can.restart_ms &&
-	    old_state >= CAN_STATE_BUS_OFF &&
-	    new_state < CAN_STATE_BUS_OFF)
-		priv->can.can_stats.restarts++;
-
-	if (new_state != CAN_STATE_BUS_OFF) {
-		cf->can_id |= CAN_ERR_CNT;
-		cf->data[6] = bec->txerr;
-		cf->data[7] = bec->rxerr;
-	}
-
-	netif_rx(skb);
 }
 
 static void kvaser_usb_hydra_state_event(const struct kvaser_usb *dev,
@@ -1080,7 +1086,6 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_net_priv *priv,
 	struct net_device_stats *stats = &netdev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
-	struct skb_shared_hwtstamps *shhwtstamps;
 	struct can_berr_counter bec;
 	enum can_state new_state, old_state;
 	u8 bus_status;
@@ -1097,51 +1102,22 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_net_priv *priv,
 						 &new_state);
 
 	skb = alloc_can_err_skb(netdev, &cf);
+	if (new_state != old_state)
+		kvaser_usb_hydra_change_state(priv, &bec, cf, new_state);
 
-	if (new_state != old_state) {
-		if (skb) {
-			enum can_state tx_state, rx_state;
-
-			tx_state = (bec.txerr >= bec.rxerr) ?
-					new_state : CAN_STATE_ERROR_ACTIVE;
-			rx_state = (bec.txerr <= bec.rxerr) ?
-					new_state : CAN_STATE_ERROR_ACTIVE;
-
-			can_change_state(netdev, cf, tx_state, rx_state);
-
-			if (priv->can.restart_ms &&
-			    old_state >= CAN_STATE_BUS_OFF &&
-			    new_state < CAN_STATE_BUS_OFF)
-				cf->can_id |= CAN_ERR_RESTARTED;
-		}
-
-		if (new_state == CAN_STATE_BUS_OFF) {
-			if (!priv->can.restart_ms)
-				kvaser_usb_hydra_send_simple_cmd_async
-						(priv, CMD_STOP_CHIP_REQ);
-
-			can_bus_off(netdev);
-		}
-	}
-
-	if (!skb) {
-		stats->rx_dropped++;
-		netdev_warn(netdev, "No memory left for err_skb\n");
-		return;
-	}
-
-	shhwtstamps = skb_hwtstamps(skb);
-	shhwtstamps->hwtstamp = hwtstamp;
+	if (skb) {
+		struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
 
-	cf->can_id |= CAN_ERR_BUSERROR;
-	if (new_state != CAN_STATE_BUS_OFF) {
-		cf->can_id |= CAN_ERR_CNT;
+		shhwtstamps->hwtstamp = hwtstamp;
+		cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_CNT;
 		cf->data[6] = bec.txerr;
 		cf->data[7] = bec.rxerr;
+		netif_rx(skb);
+	} else {
+		stats->rx_dropped++;
+		netdev_warn(netdev, "No memory left for err_skb\n");
 	}
 
-	netif_rx(skb);
-
 	priv->bec.txerr = bec.txerr;
 	priv->bec.rxerr = bec.rxerr;
 }
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 6b9122ab1464..0491b4a6d8e8 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1121,8 +1121,6 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 				     const struct kvaser_usb_err_summary *es)
 {
 	struct can_frame *cf;
-	struct can_frame tmp_cf = { .can_id = CAN_ERR_FLAG,
-				    .len = CAN_ERR_DLC };
 	struct sk_buff *skb;
 	struct net_device_stats *stats;
 	struct kvaser_usb_net_priv *priv;
@@ -1143,18 +1141,9 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 	if (!netif_running(priv->netdev))
 		return;
 
-	/* Update all of the CAN interface's state and error counters before
-	 * trying any memory allocation that can actually fail with -ENOMEM.
-	 *
-	 * We send a temporary stack-allocated error CAN frame to
-	 * can_change_state() for the very same reason.
-	 *
-	 * TODO: Split can_change_state() responsibility between updating the
-	 * CAN interface's state and counters, and the setting up of CAN error
-	 * frame ID and data to userspace. Remove stack allocation afterwards.
-	 */
 	old_state = priv->can.state;
-	kvaser_usb_leaf_rx_error_update_can_state(priv, es, &tmp_cf);
+	skb = alloc_can_err_skb(priv->netdev, &cf);
+	kvaser_usb_leaf_rx_error_update_can_state(priv, es, cf);
 	new_state = priv->can.state;
 
 	/* If there are errors, request status updates periodically as we do
@@ -1168,13 +1157,6 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 		schedule_delayed_work(&leaf->chip_state_req_work,
 				      msecs_to_jiffies(500));
 
-	skb = alloc_can_err_skb(priv->netdev, &cf);
-	if (!skb) {
-		stats->rx_dropped++;
-		return;
-	}
-	memcpy(cf, &tmp_cf, sizeof(*cf));
-
 	if (new_state != old_state) {
 		if (es->status &
 		    (M16C_STATE_BUS_OFF | M16C_STATE_BUS_RESET)) {
@@ -1187,11 +1169,18 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 		if (priv->can.restart_ms &&
 		    old_state == CAN_STATE_BUS_OFF &&
 		    new_state < CAN_STATE_BUS_OFF) {
-			cf->can_id |= CAN_ERR_RESTARTED;
+			if (cf)
+				cf->can_id |= CAN_ERR_RESTARTED;
 			netif_carrier_on(priv->netdev);
 		}
 	}
 
+	if (!skb) {
+		stats->rx_dropped++;
+		netdev_warn(priv->netdev, "No memory left for err_skb\n");
+		return;
+	}
+
 	switch (dev->driver_info->family) {
 	case KVASER_LEAF:
 		if (es->leaf.error_factor) {
-- 
2.46.0


