Return-Path: <linux-can+bounces-870-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3270E91C6EC
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA141F2555C
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC05770F0;
	Fri, 28 Jun 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="WNRWb4CF"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2107.outbound.protection.outlook.com [40.107.104.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF0770F5
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604553; cv=fail; b=V+QpSTdfalcnuV4Fz4W7109dYiQYwpT8N3hJgn9p7wI7OzMfxtiYXVRsBam3nbWspconpcW9cnfJynqsueiEb6TNiGsThswJzsJSlwWzTqt/1EioKHawb6g6dwCSevOu8aGjoBq9O3hNXcqLhznRY48jbngreZe5WtbuC0UT+/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604553; c=relaxed/simple;
	bh=dWykIqgJ8XQwri3K/RyYuAoXabDiYcLEJPCcSd5HMpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fuH8SIWliahYwHdIRB5s35kZUcydFKXKG2PH2BGX8M13GnfSGExYwt0nB06NHheUfDB1NHbfbBaN/nnPh/EJqMohlgvicejyl4v+29zgtKAYdl3BBX68fSgvNfGPc9PBTl7A/W+NyLZVixbKAdGY3FE6aNTWq/KoenI9ud8EyX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=WNRWb4CF; arc=fail smtp.client-ip=40.107.104.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dY3Kcj/I0XQB9zPuKlf5j3JM5qIsgR9U9yJ24OJ8XeouTUAvD6B4SkKU7ze4uFkA/RSbQsA+l1gHVFhBcn4l1ZB/+8PA14rq6Ni7J3eerIfJVpYs4JNTEu5IxDZMxDkkBaThgm63kF66MFbrj1cG3ewT5tw7hw/dCq4YCYVfuZQlynlv9IKqaAQrTN5QrzK7NqnY/ebwkxHRhKlpzIw2cp3amA4VnP41NVclKJJ+92l6/9hfxPnI1j4TvoYDwbPjee8nRgAvgYv2WVknnCvDLRGNewAek9J9Wb46kJOSewY1MBLZIPrgyNzha96KVNvUguVF0///Hfp2X4rblun3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKDXBtL0ivtRDiETYtnQ5N/uDhQ5UPi2ve+th/ZAEqM=;
 b=dNYVYWSz6BHxz+Cqly5mfWsG/lZ+Y8sdiaeZ9AZbJLfQ3QK0jWZ5/VC5iyWht+ceKzVutkGWGot9IMOHd2vX+GqOYO7HcBaz93C9qu/sh5xCeNr3gB3ba4CN0KBGxQVp2iWLpPXHTbHZpMALH2+t7+78JdK04aTTkUtmL1OHOw/8MOwP78FUUnETw7t6/KTQz7Xd3vi0beSDVgn1XeRFgbmq6lJIZb7o74WaXTDnhu+OVXp70al34GY4BmWeX++t438P18z+xP5s2fPLjnY5q+cXOcT2wOZXQiCtu/tgwyBEqqcoqCagO/wsaIv0NLxhWhE7dazYQxRtKLnjtUNHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKDXBtL0ivtRDiETYtnQ5N/uDhQ5UPi2ve+th/ZAEqM=;
 b=WNRWb4CFofOJgqxEzA5RwD528CO6jFvhDsf6OMv376Mx5HEjIDtMDXZQdlMZOKbolCQLTdxX3iAQH2wskT5zq7r4oP579/KZPMwm/fy4r2g8I6K7H+VtvFn0tE/517nGtA/H6ZmXw7m01L/G6WovEGcWb8cnvA0/TxcZArquLwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1142.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.38; Fri, 28 Jun
 2024 19:55:42 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:42 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 02/15] can: kvaser_usb: hydra: Add struct for Tx ACK commands
Date: Fri, 28 Jun 2024 21:55:01 +0200
Message-ID: <20240628195514.316895-3-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628195514.316895-1-extja@kvaser.com>
References: <20240628195514.316895-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM9P193MB1142:EE_
X-MS-Office365-Filtering-Correlation-Id: d71b0ee7-67c2-4e60-c8c2-08dc97ac4aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ARHLFV7cNKskjDkJKrgNeJbBtCgDxD9IWc27J7W/m3I2DkVO54yVppP4YzcD?=
 =?us-ascii?Q?lAdTcZtAsEuWFeFpTA3kezGFStttNKCRqb3difH3NQI3wRkUsGuPgc5HOoof?=
 =?us-ascii?Q?PkGhT16TgGHJted9GdLxNE2ycAZcX/RbqWUKRVbUE0cNDwsrjTTRXaP5tiYj?=
 =?us-ascii?Q?/PztMtS9XH1YD8WNWphmFNuSnWqSYXhzA2r2DaNjZzex8YIBGB7KW8AoUP2p?=
 =?us-ascii?Q?WM2Ccylc+ScpNEnwhna848elMLQLGwMt/V7TtuvGu0bfmwqY7nPR7r0/sUZy?=
 =?us-ascii?Q?tGigypYURI5kCd42daoHSGf2ZYeBtWsRlvO8ekJM5m6nf+DbATtg+J08SRcH?=
 =?us-ascii?Q?g4NZ+icOe60hFGDRVH4hhjKLuzmhHZx77p5Kaj5t92bTWZ/zkgdWp8okywbQ?=
 =?us-ascii?Q?KmeWIFWRc71tww5zdnyH+9J24kAh8BNYwOHB2CquMZHUO9hxGW7pdAj9KXiw?=
 =?us-ascii?Q?d4uvSRL9Rd3xMx6/syomX5Lk2ukeYJKC4cK90+YB11M0zp1dTme/jcYXAUCv?=
 =?us-ascii?Q?Tezg2p2ZQG3XdjNXSoYEY4R/OPrTwsXyA+zHKQa4HaAw5K4D4b39ev+uK/x/?=
 =?us-ascii?Q?gdqWhFc0QXhuulPVAvBdAHinsZT5V5u2QoRc0123mvSDZ8+wdCXYUkrDUD82?=
 =?us-ascii?Q?9ehxs1nPXtGJjhHyRs3X7iEEBXg5E0I4BmRI6Eae1pqbrJHxu5RD31StmECE?=
 =?us-ascii?Q?iaMwJbV8bIDXO9fTOAEGn10kSgXI9a/uqpRjsusWKFFLf89AS5QUV5QLaPd9?=
 =?us-ascii?Q?thU+JNS3UNP6zBW2lE0eqCMn6zeifuVrWrNK3xszTddeBkc6SCNWBglKlYiF?=
 =?us-ascii?Q?s0FX+frAieooZKQUb/JVwjNXhbNmE7z7zCCRxRUs/nQp5Zcjt6Dh1pU6dpGv?=
 =?us-ascii?Q?TQXP90dZcywE4MqlevIrCx0eh2rHUwJS9Y85w0rVL42h5Mmh7J84IJzMOaqr?=
 =?us-ascii?Q?nGgk9xB1+Kgbo/S3LwzbiEhYMydaJ90V4qegAKQosBEz7xwBDB2xjWX44w6s?=
 =?us-ascii?Q?vQ6QTlG100kWFKzznjCwbvQ35mBHATw1NgEYm/ZKLEIn4vpP+C09hEjAFIH1?=
 =?us-ascii?Q?ZiVxe3FlDKu0qe+5LJcv/XHFQiBWaiz7OGmfRPBFCIrU88nsaD0Fte6WwBHB?=
 =?us-ascii?Q?hfubOXysB42ozkAZzqQAVmQBzXC6H8W/utq1HZ24EOSVdAzKtKVRbZVKCHzL?=
 =?us-ascii?Q?Uk2sZSNwMrOa5Z1Jq84uvv/crDng0rCJGNAcTBhRK2JBWhtU/c4CDsh1mnKO?=
 =?us-ascii?Q?u7387xJakxO3lBEqblCsAkmIEqoFKAtQvIDYGuZY7i0X4lcwGsdvyPYV3Hx4?=
 =?us-ascii?Q?UU6gVOGXJJaH+lge7fuX8kEP0KxkWFO9SQMV7KjXUIYvNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jqhwgybD54NOZCfFdnM90nS79IB5joKmACkpV6FkGYi/5jymdC1ucwxVNPKz?=
 =?us-ascii?Q?utOIOw5b/LhDw/7JyyKhC9mat9E0glvS7ddGlXmmupgWCcr1hSy3RoFNLVH3?=
 =?us-ascii?Q?OtwefEsFhpiJPNtLVwFb4D8JPU4xd43WvvcviMCTIeGo4Shas11l9mve8oUj?=
 =?us-ascii?Q?zKnBVGUwN99yIJKZ9shKxyhsPIBfE1s+OnpWzz1LulDvwdNqKTAofbDhV9yT?=
 =?us-ascii?Q?eiDIxwvC6WlP7LVz2pEWDltAkAo0M+pakVarn3k1dkdgq3oASW9xJ0pTXdsV?=
 =?us-ascii?Q?AFElmyLP7DBpnmK+MFIHVdtP9mSdWGqir3Gfr4dx9ZhWlefEvlejWkq6PT1g?=
 =?us-ascii?Q?dFgsAXZkk2mA4gB8AUOpmLztnyuR+e3vYwzf1ouMpMRSqfFLvTbGxO80yNyZ?=
 =?us-ascii?Q?xVQBhb5FSp+yi2dFAYnGHVHcQhCO2qdEGSSyFWZE2e340a9ibgdEAQisss5D?=
 =?us-ascii?Q?TovYEvoGgtLPw9dLF3672jzSwHuvkYclt3Cw9eyoDQ6ggTcA2kgFfq0AqwYG?=
 =?us-ascii?Q?l6W9pWyVxzWzbdd56AWQldJ3k1qQ8e78XMHkLQKidSC2GvDc6lJNeROag5RF?=
 =?us-ascii?Q?MNu4gXFk/VScLTHl/iSesoQs6A7bhbcWbd4PZ6eqeQ08oF99IvP8i/J6lprB?=
 =?us-ascii?Q?uQ29ACTe9mbg1myJVo3JJi6GUjt9BVKcatDagxlF+BbRn0q2fzA5SiLPc0Am?=
 =?us-ascii?Q?y0tGeAptg/m7e/A+V2JOQMfLa9mvYcPiNhtKl+3KHE72zFqGosn9vU6vv7mS?=
 =?us-ascii?Q?izHPy5I782PChPBiKMZJ1Z4/7ofyJlIOqpB0175NAkVsTJb1lxN9tY9yrXNY?=
 =?us-ascii?Q?em9LZL9qEYRPie8fc5pHK47WplJDveQH8kk9mfyC0fWQoMD7a1lAN5kWBIJQ?=
 =?us-ascii?Q?t7ukZ4NBec4chSRTHfwPB216q1frWMMbfNrolK5L6MwL9xPI7qUvK7yczibj?=
 =?us-ascii?Q?YOSHYwpqX7CvuW9bs0lovX2vnOu8/ALL7YIID3Ols0dYvgDHi78ycqrICOnX?=
 =?us-ascii?Q?fxl8C/9iyyx2F1KqD88Eq/uUSDDH+f4kxkaL/a2OSemdWq3VPpU5vnSS288D?=
 =?us-ascii?Q?e/lI1ncookr+oRpAgzz8nOLBwl4OFAEgwd2tnSd1dGuylqYvydpRUrXlZnWt?=
 =?us-ascii?Q?VBmbHwu3p5m7YqiUEdghIqLkQM/yNFt8qfLLgTgszL9n8fmlS/SayeVt6uPd?=
 =?us-ascii?Q?ntRwe5nafgHdEn0/UHmdK6jHsbEeVXb9mgc69AI2pvLkjOHXfB+ppb75EHqp?=
 =?us-ascii?Q?W6YaGSUvy+tSVP2FBx6AfA5/MzDaTGEN3Q6a3ByRBGYOvHRpBx6AoFIs3/AT?=
 =?us-ascii?Q?NNnSoSZX2SOI2v1sbEaJc9MPa6YFqDQm2ItI5eBBQgi4koE5CV2Nyqnwnn59?=
 =?us-ascii?Q?56ejl5Mib5vSi90zN5aykl1sf3EPsYPVB3F5NRjjsSFrnlbDal2iFq8sA4TU?=
 =?us-ascii?Q?ZV6lS/JAa2M9v3uupqOBs1cLlUJw3t0Xdl0f/bCw5OB8LHAom+yHBKi4h24B?=
 =?us-ascii?Q?6wSkFI+nwRFZwhN9VS+eP4mAKITOqI7tvbay/qhFkAGFFGJ8FNlrGx6kp6gh?=
 =?us-ascii?Q?vTTHVjWK5jxI/bhHt6DRFlIFmNRGobiHJCNiV5va?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71b0ee7-67c2-4e60-c8c2-08dc97ac4aca
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:42.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LufzqABvg7zqF4WNcbC4nlmWltKiG+/iKpISE0+Flu0meoUv149uF6EQrUax3qufL006LUOdc5zx4rwDBYv5bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1142

Add, struct kvaser_cmd_tx_ack, for standard Tx ACK commands.

Expand kvaser_usb_hydra_ktime_from_cmd() to extract timestamps from both
standard and extended Tx ACK commands. Unsupported commands are silently
ignored, and 0 is returned.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index a971fcb6158a..0be1cfe8d964 100644
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
 
@@ -525,16 +535,23 @@ kvaser_usb_hydra_net_priv_from_cmd(const struct kvaser_usb *dev,
 static ktime_t kvaser_usb_hydra_ktime_from_cmd(const struct kvaser_usb_dev_cfg *cfg,
 					       const struct kvaser_cmd *cmd)
 {
-	u64 ticks;
+	u64 ticks = 0;
 
 	if (cmd->header.cmd_no == CMD_EXTENDED) {
 		struct kvaser_cmd_ext *cmd_ext = (struct kvaser_cmd_ext *)cmd;
 
-		ticks = le64_to_cpu(cmd_ext->rx_can.timestamp);
-	} else {
+		if (cmd_ext->cmd_no_ext == CMD_RX_MESSAGE_FD)
+			ticks = le64_to_cpu(cmd_ext->rx_can.timestamp);
+		else if (cmd_ext->cmd_no_ext == CMD_TX_ACKNOWLEDGE_FD)
+			ticks = le64_to_cpu(cmd_ext->tx_ack.timestamp);
+	} else if (cmd->header.cmd_no == CMD_RX_MESSAGE) {
 		ticks = le16_to_cpu(cmd->rx_can.timestamp[0]);
 		ticks += (u64)(le16_to_cpu(cmd->rx_can.timestamp[1])) << 16;
 		ticks += (u64)(le16_to_cpu(cmd->rx_can.timestamp[2])) << 32;
+	} else if (cmd->header.cmd_no == CMD_TX_ACKNOWLEDGE) {
+		ticks = le16_to_cpu(cmd->tx_ack.timestamp[0]);
+		ticks += (u64)(le16_to_cpu(cmd->tx_ack.timestamp[1])) << 16;
+		ticks += (u64)(le16_to_cpu(cmd->tx_ack.timestamp[2])) << 32;
 	}
 
 	return ns_to_ktime(div_u64(ticks * 1000, cfg->timestamp_freq));
-- 
2.45.2


