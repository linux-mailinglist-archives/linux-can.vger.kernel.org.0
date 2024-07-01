Return-Path: <linux-can+bounces-922-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED9E91E497
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319641C21C44
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C5116D4C7;
	Mon,  1 Jul 2024 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="jdrBi8Bq"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2125.outbound.protection.outlook.com [40.107.20.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1216D334
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849010; cv=fail; b=SHevrHo3iJxxB1wKPMgdh7qTT93oCpThTtJx1nMWuUBmMUn7+ZJzDSe432DFEYg/rJVul4OP7Zj5Gnj/UIfouILX0W9HYUgeIKq5oJ2qbTloCbGRslZ49G8B0oiNa+mwyAkahf31MkI9YNpBF8ddtpep0+9te52XVVPnK4xwIp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849010; c=relaxed/simple;
	bh=mp4J5QTGCyRNmNCcHddXe5eheC27cMqEm3nWc3J8C50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h5SW0iFzJMHg9bMmO64F2+3ujasSTEQ6/Uw9hub6Edx5ykwY4Po60zGr0iKWTnyfzFendJaiEsdyPMbdoxXT/3tkmUE3Mv/3cKo593G2oGbqQ1vlxa89/RMrTXChRIjiVKWdBryqhj53Alts/uQEfxh4DFouDmf4qHeJ3Iv9EMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=jdrBi8Bq; arc=fail smtp.client-ip=40.107.20.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ/p4je3yLkgCgkXoItEuqa1Y2jC+28ujyMnPFX4SkuFASCwE+qjA6cRZi8g7y4DKuAQvNEnzJt/aku0QYD8QOURxVMm/HNmlGpgzpieJ8QYan+FPf7mfNicOykAC1Zd1MjyXD6tBCPsKE//ZIQL8hMu60HzQrAFMfH4fXxs0aaevfuKxfBKl1TgAqwsfl8mXPeqPov6YGCkcs5AVs+S6tiW9ZdvHzb1FwtOXatvcgNJ76tAiXGvS0KfROJHiqMd08uJtUjvkWQjE9HG3D7rBO6f0qkx8DJvInVCBEqyCkIOUc4B6EuOdqvU2koyMRqob8bbL7jRlJRRfZZX63OrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/4H0flEHyW3+ooRAO4Nn5+zxRpdtoWNHdZbnQjEyyU=;
 b=iMG2HMa1V6zlR0iAmKKZ3WPN6zzeKl9FeVyNxcqO4EaZ1ZQLZC0UbiQGBi24OfgF+jU3ucDpbGBgQ6D/ezwwdlJ6smp6Bjz60WAF6cHPz1M86RmgEVJFto2sjZLGaAAUCy4IUIrbEZ2+K6Hq4H8+3YNd9E7xkDeNgwehy0vPDul9CjVgzSNZ7LdxsYhrwuHhd8sRbvxZ7eZ4GiRH2uWHqUaUw2A022Qu3DUbSV4lMW6XSTlXA9qZB+ZYhyshXA/prUXAzp3UBBZMQ2oeymDfLtUyXG++iFnFUAmJqCYresdiDftmS6b+AIISIph6MYsgXOJoC3VII+Oz7GCeGyj2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/4H0flEHyW3+ooRAO4Nn5+zxRpdtoWNHdZbnQjEyyU=;
 b=jdrBi8BqtUfFnG+TbFHfrhuzdq2N+R7sqMscx9HeKLph+mfVqgsIMfDgqroJ8kv2JSCvk0hdAtu4yzwts/+CVwuHUC0kvISczQLlcHGGByYmJ7C7+22owML1DJE1cVog6lJaxnRSiVUDVSjcVjPEbJSLeERiYfC4SHMFaJWUL/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0519.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:49:59 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 15:49:59 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v2 03/15] can: kvaser_usb: hydra: Add struct for Tx ACK commands
Date: Mon,  1 Jul 2024 17:49:24 +0200
Message-ID: <20240701154936.92633-4-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701154936.92633-1-extja@kvaser.com>
References: <20240701154936.92633-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0519:EE_
X-MS-Office365-Filtering-Correlation-Id: edf40f0c-8ca6-4629-93a7-08dc99e576b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9TbNnDn3XX7vbGqmo1rrLsfR3SFF5LG6lcTw51Luw2970z1FgLpY8BaxzyZo?=
 =?us-ascii?Q?tKUiOdq5p0VMmy+F4awXi+D2lPLiB7LZ6hYScohETVaFVCYHQe0moGBpHjJl?=
 =?us-ascii?Q?55FnDblqB5bJ6Fq6azY2DcByFo/rr+6AgAocVSAPet56J5d9JOrVRxox2fNk?=
 =?us-ascii?Q?WHLJN2DEvxTmso87wOe9De5FfgHNf28aX7Zqu0IvEPjyiwe+SF31OQwNPoHR?=
 =?us-ascii?Q?ZYA52uTTbPhRsuHi9QQdYUPFMW0F5K9FwCQCKCd42xGT/jT7sxcrG2vc3ixC?=
 =?us-ascii?Q?gHsIkx/qu4LErgI662DiAcMRj6jlw255LXS31IBgoFJGL1aULlFxmOLW6f/h?=
 =?us-ascii?Q?VUUPqEh7taEBkDdSpCd2WN/dlLKz/1TbzP04LhQgk+OL6RTl39Es1aH8Hs1w?=
 =?us-ascii?Q?65iC4WI9FRc6XL7nUqlRRO1ypD395J9q+jr8P/DayltbZpSUiSJ1rXQ9Hi1o?=
 =?us-ascii?Q?4wRF3EMhCSycmFonKwhntQCqihqqQNQouNoTCsrZRsCbkLX6gX5FbSrl2WN8?=
 =?us-ascii?Q?OYsPKrKFx7xR/DEHDnHy+hkgM3TTHzJtXEKHZXWk5jx6rpvtatMjkG2DtuvW?=
 =?us-ascii?Q?SbisHQwE8L7kMv8NxMkqmSdJk1bR31aurZjQFU4rUoGWQaPsBbLHhksD+5k0?=
 =?us-ascii?Q?sLU58YEdhSu2aHxScsvnNxxMu8Uv7I565Ux1eeatfAedc8m4WLApjFkzqcwF?=
 =?us-ascii?Q?/i13JcqajsqtHq/mNJhaIDeIbXvAKtijETzAc3Tpr94km0lu7oxxOIePBVkn?=
 =?us-ascii?Q?fF8GwAlmmC+ChXJIMyqgTCuv8R3GwIHXpS7/dwDQky5lKPO3lTooW3TvbyVX?=
 =?us-ascii?Q?OQtVTh4icDXL/o3gD/Q6peCP43jk0xuGDOL483pNxszN4d2jztIofjHoCwiC?=
 =?us-ascii?Q?dYEbqtzhTANdgBl+f1D/HUYqqusmVxfodyISFPU66TLtgZr56BZlaqdbiZXn?=
 =?us-ascii?Q?nvspDg8Kj639SsFTMoEO3r1itgC/zPv4oVFxV148elbrbHQWNiQ8aHHEJhRy?=
 =?us-ascii?Q?2hk4DVo0qeaN+QnwlYpeEJVf5gtakWdtdCp5y7SutmqJmIyQo20sX+c9pQ0+?=
 =?us-ascii?Q?xOVB7c/ZOQNTsSSHb2NVDRY4LXgB7FiyAV3GKGm0x5LaGWsrwQMVXDI001z+?=
 =?us-ascii?Q?nIBkoQ6ilZPnMWn9dA+0qcIOYIvAQLcfOI5f4HZBNLnf4LA8MwF5IU0SKr/D?=
 =?us-ascii?Q?BP7LXcQoWfzN12v7oJABn69xVE/iqFFN64wLvvCe2lweK5Nh6raq6owgL7sr?=
 =?us-ascii?Q?3sFkXszDb/EPojEpry1SwbVx309bxywqJHqdxg7ozjhH45UD8ldJmT8td3mz?=
 =?us-ascii?Q?ne9V1zKoGHC54jvldHmGbYDPhbMwaUxIpp6bd06/MKKvuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0W5P6xcTMmg0YCUms9xZqdAT32kj8Usp5Gl+bcQKHAEHiV298hBjLwPSwOuA?=
 =?us-ascii?Q?QR8F/eXLgBD/vvFHG2B4Nk0Pp66krFSkd32HzqT+KXvR8B+Ayp6tvjOgdxPv?=
 =?us-ascii?Q?LRpOd2DyosAyD715Yha/kGg4CosyX0k6CiIbwxoUggeiw+K4MawWYxrkjIoA?=
 =?us-ascii?Q?ruNs5Yi4M2GAuodQybXy4Q/7QiRflAlDJyqXWSfiviTYI6KLzo2SqQ+jz3Uh?=
 =?us-ascii?Q?PJDpgSsPDTYmF4kXW8jlLIpVUNMrWihbKb9gq7JR28LD5FAPQHXMQH0C14Jm?=
 =?us-ascii?Q?ur1VrW7m1Mq05K8a26Qoi+6R4h9jRsQlkIfF/qmmNcUeuUKn0YkELwDpyHN6?=
 =?us-ascii?Q?u91U54Rk+NxHE1dG4z61hJJe9041OIl0eZCMsY0m4Qk3aoG41QPxp2S4zWJR?=
 =?us-ascii?Q?7OCGorxfIR/D+ktdfcjv42SGJyVffl/zuVd79ClAU5Mx8j3Gvft2VG6zEBpY?=
 =?us-ascii?Q?fvmW6r80W+3ZqQ4y/32LXnfx2HRPONtPaG20qykbSjPkwbl4bCqGybMYnd1C?=
 =?us-ascii?Q?wX67IuQQcHEN2qjRpPtdj/nEMCcBaSxuwlTknrgwZkEf8AIxOim5AuOnp1nr?=
 =?us-ascii?Q?eo9MUkwkqtl5txvfiAv4FAzk62hkLBgIZF3Eq6dSPG6v7oSNUMO93whTXvrh?=
 =?us-ascii?Q?y46BuVjA26BzUFFZhaOVzpcfF6lWxR2vZ7OyqD49OKydFo4KV6W0tY7Hpore?=
 =?us-ascii?Q?BBKx9qPO6qPKJO0z0M9Tb1ZRNF80qWvaV/721t3x2fo0AhHNPanGyy3cG6G0?=
 =?us-ascii?Q?wOJHhsPAeyj/Ud3vptRyUMmL8LRDbibJ7Chk9kgMb2f5BbZ7+1+NCCe3BxJU?=
 =?us-ascii?Q?IN1sNaZFPx77A9GG+MCPWpNnCP4n3yExGVStokLVKTK9B9GjQZvuwW9sbZE4?=
 =?us-ascii?Q?b19Bsoa43OM1DwYAYJVSwuyQqNwLybleYX4yaJfcehkor4c8dxXSMJa7auwB?=
 =?us-ascii?Q?ldX1gYSAHK/oIfszvqbneYZT2Emlr3+ikVzPL6CyHXfwmqrz1TXVmwEaXaF3?=
 =?us-ascii?Q?omJH9ORKh+Ow1jsnjA6i4WYf9+L+EArypYhYnyfUHj8gbZaXeVivCIbBxUnm?=
 =?us-ascii?Q?FFvHt8fd0BIpNkwNgSnzaa+AZ4ngh4B4jquy0cu0F72ULcZhQxOqy6YfriY0?=
 =?us-ascii?Q?MKEo2oIRnY+8Is8S+PXnNQwW0YLZwGQmHgtJHcnnwSpp81EpGPZbN8fKfX04?=
 =?us-ascii?Q?igvbIOWLJda7i94I2hH50pEtWRLSccXO0dwjnOFlVbqlAENpkQ+HoBPv/sxx?=
 =?us-ascii?Q?VHL2mmLsWIupoMSB2LJZS4o7SvanKEO70O7kJDMJa1moB7LJxhhCdeUBRwui?=
 =?us-ascii?Q?CT8y9d3D2+vqjXXwNStG2tkohiBNdN0n+q65h0nekzuo3p2V/ybAJk1V8hqv?=
 =?us-ascii?Q?+AXj4YP9QRSAMipOvonqS4N79k18qOGU9TlW3/a8g7DLFc0/d3JfF/MqO/fr?=
 =?us-ascii?Q?no6yUG0gDQNLMXaNmT11LQXQh8n3ZvROt/7VQo+qOWbK9d0VpjlrfvtROnOV?=
 =?us-ascii?Q?ra57foAs0jIbm0tPiN0nPuIiO2LIwuSGm3WiKALwEvxsbEYt6uMNAMz+BwwN?=
 =?us-ascii?Q?+a0/1nxTrdP8XF8kacVwRPg5OhaplPjhIgsq9cBU?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf40f0c-8ca6-4629-93a7-08dc99e576b6
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:49:59.8931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDNlVnyPpwI7FQhk2I/l/lwT5dF4MaaMxQuj7IQ2PCUXfVCK4eV4vBUGYmboqESFHafR8xdY+vbeCaTz7RPLmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0519

Add, struct kvaser_cmd_tx_ack, for standard Tx ACK commands.

Expand kvaser_usb_hydra_ktime_from_cmd() to extract timestamps from both
standard and extended Tx ACK commands. Unsupported commands are silently
ignored, and 0 is returned.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Utilize new helper functions, from
    can: kvaser_usb: Add helper functions to convert device timestamp into ktime

 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 84f1f1f9c107..f102f9de7d16 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -261,6 +261,15 @@ struct kvaser_cmd_tx_can {
 	u8 reserved[11];
 } __packed;
 
+struct kvaser_cmd_tx_ack {
+	__le32 id;
+	u8 data[8];
+	u8 dlc;
+	u8 flags;
+	__le16 timestamp[3];
+	u8 reserved0[8];
+} __packed;
+
 struct kvaser_cmd_header {
 	u8 cmd_no;
 	/* The destination HE address is stored in 0..5 of he_addr.
@@ -297,6 +306,7 @@ struct kvaser_cmd {
 
 		struct kvaser_cmd_rx_can rx_can;
 		struct kvaser_cmd_tx_can tx_can;
+		struct kvaser_cmd_tx_ack tx_ack;
 	} __packed;
 } __packed;
 
@@ -530,9 +540,14 @@ static ktime_t kvaser_usb_hydra_ktime_from_cmd(const struct kvaser_usb_dev_cfg *
 	if (cmd->header.cmd_no == CMD_EXTENDED) {
 		struct kvaser_cmd_ext *cmd_ext = (struct kvaser_cmd_ext *)cmd;
 
-		hwtstamp = kvaser_usb_timestamp64_to_ktime(cfg, cmd_ext->rx_can.timestamp);
-	} else {
+		if (cmd_ext->cmd_no_ext == CMD_RX_MESSAGE_FD)
+			hwtstamp = kvaser_usb_timestamp64_to_ktime(cfg, cmd_ext->rx_can.timestamp);
+		else if (cmd_ext->cmd_no_ext == CMD_TX_ACKNOWLEDGE_FD)
+			hwtstamp = kvaser_usb_timestamp64_to_ktime(cfg, cmd_ext->tx_ack.timestamp);
+	} else if (cmd->header.cmd_no == CMD_RX_MESSAGE) {
 		hwtstamp = kvaser_usb_timestamp48_to_ktime(cfg, cmd->rx_can.timestamp);
+	} else if (cmd->header.cmd_no == CMD_TX_ACKNOWLEDGE) {
+		hwtstamp = kvaser_usb_timestamp48_to_ktime(cfg, cmd->tx_ack.timestamp);
 	}
 
 	return hwtstamp;
-- 
2.45.2


