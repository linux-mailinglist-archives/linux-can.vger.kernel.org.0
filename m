Return-Path: <linux-can+bounces-3570-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEAFAB5820
	for <lists+linux-can@lfdr.de>; Tue, 13 May 2025 17:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39133A7A43
	for <lists+linux-can@lfdr.de>; Tue, 13 May 2025 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F9C28E5EC;
	Tue, 13 May 2025 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="iXXPawG6"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2114.outbound.protection.outlook.com [40.107.22.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450EE482F2;
	Tue, 13 May 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149020; cv=fail; b=hfE18r25ehSfu7OhHVUxg+2R9cfymVtHjOSvcoqesyGL4MG75RniuX98KYuvpLfM4/rN6j0EApBvceo0PEAcVepdfXNBL9Qz04tZeM7ddhXXROlLE6H+kfvCOpfvVWYFwl7ogi482eJlULzSuNfNWo08Nm+hWcuLmco/uqX11Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149020; c=relaxed/simple;
	bh=cHyFhLgZgXczPy1YDuJGgvZcckbko3tqzyoomWqLRnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oA3bp6FEHmiUEKqwXvjKDgDadUUS3TwfywKRWwXAC64dFziTt+MOPFqR5gEuQPgtjbm0oTMZRwipMaj5NayjEfiwES7qC+IDItsE5mWHC5zIVz4NYc9zNhDPC+ujuSUCpvDgg0Jtro1EvJYrxb2dJBOPGllKZdnkpbxtMv71b2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=iXXPawG6; arc=fail smtp.client-ip=40.107.22.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxgBTpvbdgkABk7dJtZgbx1OwMpI5meKtgOLVXztVhzEWgH5SKOIQurSoVWBmKzfhoIQz7uedq0JEr/TIn4/VxUWXqUL/uBksY+m8Vl+OQwMgWyd3TUQmisQL9agm+IccYWxvdYQekggR0a7r3GKwDaUwu7eP0kYOaogt2Up4jKpJYTK4a8qL2zrtGp1P1F3w63Dz9ZVeiVmlB8eGAUwaK7tOsedhjEwsQH16WOGmQ7zgoyJgr4F7WiA1WcbSFJtz83CU4Bx6394aXD5Rg21Qx9Wh3QiWS+Wcau9s9Aiet6FClmM1N1pS9uRnp5LpFHzvA1WwFWWBu2p0IRGp+KTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlG/P3jWuScz824gZK8v9sNZx33XrP2syVe2GUjjMFQ=;
 b=Oy0U32WQnlbExJa3jc5/3KNTvX7kqK1B+PiBcAQeV+oZHYSMbqYHCrg6cwkb7gkEgOrDhF4kJ2XhOf8kc+ExRqF8AgcJK3N15eI1n9NJKPNIqcBKMAVtjFozJnrODc4WH9JpDyligaSXACV7KOBcJSWzezSigqP2AOHG/d2goBnE+6yY006dSGSu7RrfsdG9mvGPlUuaJtCcmolgxI0YKqOgRnGR8VbarCt5avvTyCqJ88E6C65uvQSOgK7i4YUQinIHCuVMgJ0/6AAuMC99p5k8N6539Z/2z9pH8ONVI3c6jgye/y5kN2hoNnmIJRpNcDCc7c6J4y1te77JooJq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlG/P3jWuScz824gZK8v9sNZx33XrP2syVe2GUjjMFQ=;
 b=iXXPawG6L/dL9ON/8W7dg5YSXwHcSx1lAFyf4uHD/VdwEj0m/YaqOYx6gw9UqmwJTP4Lg4SOicfk1Oc1OzDkOQbmQ/6R3BCnS6SFPiO7CQX3Q+12jCdXAGbG7Qpj3eYjau2sFfaf4jusLe1i0F/wvjdgWi2DbH3qWiQuCiPaWpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by AS8P193MB1352.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:351::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 15:10:14 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 15:10:14 +0000
From: Axel Forsman <axfo@kvaser.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Axel Forsman <axfo@kvaser.com>,
	stable@vger.kernel.org,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 3/3] can: kvaser_pciefd: Continue parsing DMA buf after dropped RX
Date: Tue, 13 May 2025 17:09:39 +0200
Message-ID: <20250513150939.61319-4-axfo@kvaser.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513150939.61319-1-axfo@kvaser.com>
References: <20250513150939.61319-1-axfo@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0033.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::13) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|AS8P193MB1352:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5f70eb-8e1a-467d-0a81-08dd92304380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PbAS/z35lOhPMHJLcERvbGKPRl/Z3blelwp7Cq/GvJYYw3zmgCKv/xkK4gt6?=
 =?us-ascii?Q?wrxjZzGVBAjza8zvEMD2CzpWVonx5E3791Wo6WGs/6xayKxZDTHsvY7LCk9D?=
 =?us-ascii?Q?71fDIGtNrc3utGzv2jRpwGFrwHR9mUHS9aAnrIsb8gU5iKUWFrqJqtmIWJqE?=
 =?us-ascii?Q?uK/0DGRFa2D10Vw6ZQtKdcsHLZjk84ivvVwXFx/dJTq7EwjlMjDcmVrC1CIo?=
 =?us-ascii?Q?YNL6WYiAdqUNcRHI6vCSMSwKTPCw0TSwMEkqcjFR1dJdITaw/y0diaynWxjx?=
 =?us-ascii?Q?g6/JBg+oyZ8epdR3E18sjRG+W3sXv7qFywVgKT9llu2s2/9L6i48ao21xO6c?=
 =?us-ascii?Q?WlK2tCjAKZ80d9wwKshjvtPz14PhBSXWDRAVxP5YtSH4oEoX0LW15ikpCiAl?=
 =?us-ascii?Q?9rvSnHIh+HWHbJgB6vy9wPwfxL+icunynvPoL21EXziw5DZp0snPZMZkXE7Q?=
 =?us-ascii?Q?S9Q3ZDopfmIh2HBTXFHAJktRFq9kiAZ7Yf2kbKDLavssDNGgcMfyGaztNE8Q?=
 =?us-ascii?Q?FoReIQxiqtrS2VtQOK4FxQfHwieFJTnU2DhSjsjYI3SW2/y3kfDS2LLlEDgQ?=
 =?us-ascii?Q?IJOSNvRY/HdQGUEK/DonVk2NBOVBhOetW83OFU8aNSh7gzox1j/Fs3DyFgow?=
 =?us-ascii?Q?Rq8qgNAToVPpK/z70//wyik4sShn3KMI8rs8/f5T04F2rE82pvWcUGAX7FSJ?=
 =?us-ascii?Q?1w8bW7Wt7maJKlH/6idXuSvj2gQ4qO/wHG9LIDXoRdUPQPL6i/nDW1gNNLx4?=
 =?us-ascii?Q?pEJCfJVNWBirIfAWoqXMmHCPTSGEkb5w1qU35veAj8s6BXqrtc8GH3XNm+nS?=
 =?us-ascii?Q?5NJPxKZ3BcuTYDU9vyYvju9JCHtjc9loklGSWdVtcsAFWIWQ+Z6dssI9n0YS?=
 =?us-ascii?Q?Kmyoyu4CwNJt4CnI/GTmHMUcIZ+W2X/EDoZAldKcHvqjh1EJA0wOUbyf/leL?=
 =?us-ascii?Q?AwbmnOWjapqf7yEgCrpQLjMK4UJ8D3Gejhnlu8KRvDTv6DW/+AURTirVedus?=
 =?us-ascii?Q?B0CYtHRFjKpHRcIjtE07YQoammpeTxT09lowlb2ZqZmxAN75FDzVX024Ugsf?=
 =?us-ascii?Q?D4zatbMgLXMfRl+Z16eztg8xTkGg3ZmPjRKOupN3eL+8x8KrGuqtsMxPpkr+?=
 =?us-ascii?Q?BWiF0ZDufIJL0cUoZwK6jJSsihmsjd59V2aJO4wTq4fCmfRqx7fvBIW3bDfl?=
 =?us-ascii?Q?fmTVZXzt328sTxIKVVc+SnGLSxyNALHB1j55Lf9BytXHtEueeU+5YZ/c3oQ0?=
 =?us-ascii?Q?M097CJJo+4YQDB2OZvpoE03/EHNIjuga/BsgI4+8vMqUza78Icjw+MQlJlVT?=
 =?us-ascii?Q?yXiyywD1AxYNQ9siWH/5jE0G4DNi/rzCxO6rARmdHNydbMM1v22+tD+wTaHq?=
 =?us-ascii?Q?Cpx3lNebfUcxB3lKe3kEQGx4jfTXsKh3duwvUBoIJ6eoR81Sil/4sp3Nc4Op?=
 =?us-ascii?Q?VTMJQQUvQx0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?syG5rTcAIFyp5SnhFXXMZQvCdG4qQJsUvcChCdaBVTJKTH864rYRsltUPUhi?=
 =?us-ascii?Q?1IeLOm1lmoXefrw6Qnqv68FjMUyVLssEKxKxrJxzgyaLUtll5T1GiTSD7wJ5?=
 =?us-ascii?Q?9DUuOjE0hN04BwHO3e1TSQSXtobPYCgjj+W5HBsW58TQFtUE0e6D5JZr4UHd?=
 =?us-ascii?Q?TsXhtvjJzRyEUjUKaPeR+4K8niC5cToyt9UaXjV8UvBTUQZVuWMn1G8Cu31P?=
 =?us-ascii?Q?ujiZHYjP5ZkQDEJC1gcnAxyr3lMOEJKwR2PmdhhTGIawWF9tZwAX8ueKsJsW?=
 =?us-ascii?Q?hES8JNSdU/3aMZBZ7bPT5Q8TvM1QNWXKX7carfMJTTKl8iOVFvHx3nJxFkC6?=
 =?us-ascii?Q?FOUSTE7unzAQftsSSJPqOGG4VwZ6C3Yl82g/iTW2YaX8teyBBwP+YpWGR7nw?=
 =?us-ascii?Q?S5Q2EpWudcS+/ZcKg2SC1JmugjB0RU7Jbjmecm2Fugiee04pkXJ4V3RRx/S3?=
 =?us-ascii?Q?RGhADTLxo3VIczffYYNX60Gv8hz4PNudDQt/9mV1yhFldMo3yA3S435x6DAa?=
 =?us-ascii?Q?9Vb51Y/RDIdgCox+6cj9yuud9DtU4UstVAE9YvJr9yXeyBtcmZKYIRIL0rzg?=
 =?us-ascii?Q?ePpy4/eA0xVL7oyl+G+DJe+gpgsoWa/Zw8d4dCKyYC2CuxhyfQRzgRe/fhOM?=
 =?us-ascii?Q?Ra1i6bkuXqLbDfnZCijgpsrLoIqncvB9926lfF2HG/9nBWUb4clOKCP0LjeO?=
 =?us-ascii?Q?Ege4CSWBHuOseNvskqqVo8VJKn9TLBTc1JY4ZCNvZCm7Xb7kms5LiMW3T+vE?=
 =?us-ascii?Q?Mjzdl4lLuc/5rKF8L8JJR2jgvBqOehglwXjGHxADrKbR9UXnzVLrCOL2j4XD?=
 =?us-ascii?Q?8U//xHmgWW2FDsnXUY5urHf1Hrs0nt0WTeEcdTrN9fsvB/XVqFaLjl0h69SR?=
 =?us-ascii?Q?tTvPVRalrytUwik5Xd0GG1fDYGnCXsuCT5/mc7Z/3d9b2as0qj46WS8XmPI7?=
 =?us-ascii?Q?34JHGouFCQJ3YDsIbbzJEoI6CGeQzAxpvRZNm7DDhBPk+/ycAyePIpOfzoQJ?=
 =?us-ascii?Q?3QehcwMlJolXTdVEnauKpWOSdzhe3MH//nekV7vpVNgjY1pLazWUsnpffcWJ?=
 =?us-ascii?Q?Lgv4knoBc3TeKQhEZWNVqT4yYroESlkLY5LOKd2s091rjr6vP94zDS0+hz9K?=
 =?us-ascii?Q?3Ue6SFJ5OkNGZo0QNFBtNn6s/qwNT9TVg9bmWSfFSby82I/3F4f4mo8wLlJV?=
 =?us-ascii?Q?5ouP54whtQmKcjj1uy7kkewQ5LeC7JCVHL7GRK6m/4SNS8odrRq3R6m8m4Jp?=
 =?us-ascii?Q?QuyRWbyqhXSlDeObpFCfj/tm3tbtt0uoWhwUXyhkSnkp0TiGyAmhyy3A1Rrs?=
 =?us-ascii?Q?YFR2GptDQV8QBhtfMESO07rHUYfdvnKTkBRNBabCnodYrOztr1y6YFWzfT4A?=
 =?us-ascii?Q?ck5lIT6dfEXHj8WsX+rsL6PnhMvNYj3pHlxeBRMc5w0O+wnjM06bg55tgI5B?=
 =?us-ascii?Q?ll/kpnyERdqVwNB8vx/NmUurnx/9QMX+08YgHJ1gSkcRtqx08sqZYbcPhLBg?=
 =?us-ascii?Q?041ueHHDpmNrnyLORqSp0t4iPDJHW2oiQVNkkkGQYRh2Zm/sys3ZHVwxC+FC?=
 =?us-ascii?Q?uPR2/DprADtYAQdF9SYN8Flk6Rp8yIoRK5+pHY1Q?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5f70eb-8e1a-467d-0a81-08dd92304380
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 15:10:14.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84f4uh0HVZylY6r1Ly4Fsj8ZJeTjKBtGRBEgzbOfE1UwjTc6Thud7HQUTNsafGirY4GQS1QGlUZKRn+6/3RuOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1352

Going bus-off on a channel doing RX could result in dropped packets.

As netif_running() gets cleared before the channel abort procedure,
the handling of any last RDATA packets would see netif_rx() return
non-zero to signal a dropped packet. kvaser_pciefd_read_buffer() dealt
with this "error" by breaking out of processing the remaining DMA RX
buffer.

Only return an error from kvaser_pciefd_read_buffer() due to packet
corruption, otherwise handle it internally.

Cc: stable@vger.kernel.org
Signed-off-by: Axel Forsman <axfo@kvaser.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 6cb657018cdf..6b3b04b5a4c2 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1209,7 +1209,7 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 		skb = alloc_canfd_skb(priv->dev, &cf);
 		if (!skb) {
 			priv->dev->stats.rx_dropped++;
-			return -ENOMEM;
+			return 0;
 		}
 
 		cf->len = can_fd_dlc2len(dlc);
@@ -1221,7 +1221,7 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 		skb = alloc_can_skb(priv->dev, (struct can_frame **)&cf);
 		if (!skb) {
 			priv->dev->stats.rx_dropped++;
-			return -ENOMEM;
+			return 0;
 		}
 		can_frame_set_cc_len((struct can_frame *)cf, dlc, priv->ctrlmode);
 	}
@@ -1239,7 +1239,9 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 	priv->dev->stats.rx_packets++;
 	kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
 
-	return netif_rx(skb);
+	netif_rx(skb);
+
+	return 0;
 }
 
 static void kvaser_pciefd_change_state(struct kvaser_pciefd_can *can,
-- 
2.47.2


