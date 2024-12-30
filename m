Return-Path: <linux-can+bounces-2511-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68C59FE70B
	for <lists+linux-can@lfdr.de>; Mon, 30 Dec 2024 15:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F391882987
	for <lists+linux-can@lfdr.de>; Mon, 30 Dec 2024 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D95F25948F;
	Mon, 30 Dec 2024 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="I/lezNmC"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2128.outbound.protection.outlook.com [40.107.247.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784D1A7AFD
	for <linux-can@vger.kernel.org>; Mon, 30 Dec 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568840; cv=fail; b=jbG5hrviBRBPYMrdplt/5bQIz2rwmXdkS7GHWWyf9QPA39+Zf4Wx3MI61eVCwj0KECUq24ze9P+aS2Z9NjFH3jsIDCAEFOVcdGpjeNrwHEoKkpwMd0lIAdEbQw6iHKY7PvVcSzFoAONNhKYmfvocbL9iW/BWs39voAfMFAwkm4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568840; c=relaxed/simple;
	bh=2IfLVGaxe6K4bdNhwwvvqN+d6nQHjP+4Qe8b3rGaSH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bBU5ALxUR1L3KPWVTJs1akghncLcWaOAvyVVRpPMHpVVPonHg4afaGNFTEENcL1qGqo9CdpCARP0lZuE3/LaGbT0EQ9BsKpFZQ8lNzX9uMF0EaioM4ROpt2R5oXUt52S2o0Zn5bLqRhuWIQqV7Mn7GNmur7oyRqaNhaGiMcLbRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=I/lezNmC; arc=fail smtp.client-ip=40.107.247.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQ9l1urMP4/wCEsk5FxYp9i9r7cm0/r0yXKPrDSvzP2i7n75bsNkpi1Tv1hVBlnryNVDXH8j92F1JMbZwx01b4MBhc62lQ+19nPDFtlHot/KjETMd4DGBZcnIIh2+yidUOMpWXngAnKOrLJndKvJ+SxxD4eBeThFlr4Q63LKpA2cJ4f5TrSRZ5gj1HWgN1ZHP/KKS08/ZxFAEx0tl7GZob3Opc5WYLCQzVl8ooW4R9WUSNfSKSNV7XhvuDjTVC2Xp4zjXROcgXj1jUVG/1dAQ3wmk9n1KLqZmGouyehtc22yu9rHgODjmhVACzhcYRVZg77wWPpRqBReR+7hM0/Vug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtSMA8wBPwZsEcosnHt1PgvjRavNfWgCqbQEyL0Cmz4=;
 b=ZQi7UoZ8uczm2wcEfRNKmqtXJ10K+5FHCvkxf2JevGzH3WyfWy35ramrvEKw3SxSL/74hxeGSXUAdEYRu7bwzACddGeNmeWLF/F35vUIk+ctHAVh5HPg0+fjU6PzLqk+eMUUpfj67Wmc0QBbGzfNeKMYy8LoFz5SQGbvLmKkx8YcQal+jD90eyW5T6mW4fhwL5EnrbH2skThs1AvFMXIVbktxKv2mtKtyoB4qZ0HiYuNn4kxUkgF8xs2K+17JRMMpwRNVlgJQKB5H3SxoQjcbpLTkVYywMtb0RVNEMY9MAmPujvy+rsqwZAZSyv17LAtCWxA0WB5rERQQ/4V+9jB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtSMA8wBPwZsEcosnHt1PgvjRavNfWgCqbQEyL0Cmz4=;
 b=I/lezNmCy5Vik3tprHjm1Y4T9sCKvMTB1Cw+USWLsvyad/mvNoMnIk87zCpn6xYactwczMzqY24c54BlWdI2k39/WX0Yw4M/IR4HzblF5py/It0rM0Y/O0nE7ILMvoN5Nqb4i4n3C8E4Xfk1wpNzQ0lxQ5ir4jUCM9UpeScAgmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB0820.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Mon, 30 Dec
 2024 14:27:13 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%4]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 14:27:13 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 2/4] can: kvaser_usb: Add support for CAN_CTRLMODE_BERR_REPORTING
Date: Mon, 30 Dec 2024 15:26:43 +0100
Message-ID: <20241230142645.128244-2-extja@kvaser.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241230142645.128244-1-extja@kvaser.com>
References: <20241230142645.128244-1-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: fae1c949-2cc9-4d36-c9f7-08dd28de0d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EmWCth+kbatrTcrtadBBE2TSrfjElgSPHcrfLepdcbGkkmARuMhbW26fbr7u?=
 =?us-ascii?Q?/XEekxHB/9OQ39ifSDdEq2TdegR25jgrAd/kb+2hAoZfJ7EffKtywQIWpZK9?=
 =?us-ascii?Q?LzDIuy35+WdyaM8XtFOXKf/qwcVPwqyWQyBmgSGF/knWyyrehlZYpH2kfmhX?=
 =?us-ascii?Q?qRwoUugelNdaGbiNIuQiiqw0iM2x1B46AkiSTvbsLIk0oNv47OECVfw/RnAP?=
 =?us-ascii?Q?6BZu7trURDxb+NFz6oWOuaqfw/8BPzBRa58Ryx1IXWqrT/jBz6liMSXb4nPs?=
 =?us-ascii?Q?Pbw5sty4z3a5EjugngXF17W90ej4tYWVRXi6V47Otk4bui2W/auT1mYIqHsj?=
 =?us-ascii?Q?YCUtbjLueINeY9OcZc+KdrHDh5IyUu+GvXh/6Z03fPn9JYv3p16VbquT/VQ3?=
 =?us-ascii?Q?3C8QP8D08O7WNAhxSW2Ii+yHB/WvyhAj0DPpuHiOJ1IaD2f4SQ+YWEipq95c?=
 =?us-ascii?Q?ZHrBYnWOnjT2urYA+ORUqovwH1hLo++/O+GLvCxnZtX+GRPI9LppUFzaCRj/?=
 =?us-ascii?Q?cDpvnnoWbo9hN79LDuC+6CPmif3o7IcbyxSSZvC9Bikeo5rDBoLigsrHhvCm?=
 =?us-ascii?Q?kmgOM+Ede7pqgyXWXgxkX/dWLPrzNIECnqxFGHmKkd33CbZQ/5mJkq8rtubs?=
 =?us-ascii?Q?2DqDP+5YDacdxC2rQMx8PB34xYmIFzJbKKbtnUIEs9aaWdOMG/4LuX4XYcKr?=
 =?us-ascii?Q?k7eJk+3qbOACOIkmkfq7C7mZGEj5UyMazWWGAKBJRZasKWa7EPmAP+9dllnh?=
 =?us-ascii?Q?PiZMlQsbxtEN7l6BC3KAv1Z+simRCHtje3uhQ7Dd3N5uWMDnq/P2Ytk9liJk?=
 =?us-ascii?Q?ZPIcwi+u6bGlfuOGmq6jPELTaUeeOmQPTjfcbkxYLbcKsqLf4hd+oqLA1jGD?=
 =?us-ascii?Q?Zj322ribp800sVh6pOyzw5k5wvlSzlS4otIoKkQNVsDRZJQsLRcvrUkVTmwu?=
 =?us-ascii?Q?8f16Qpw6eYJd6yVORnSdo0xwqOljLbRVpNQKluYq9ZTNkHJvYgjwifXKmg26?=
 =?us-ascii?Q?pQ2VTA15MaSBTFgS6KNP7KnmL1cqpzbeWQIgGS9vYGOcddyTADEieYWN72aL?=
 =?us-ascii?Q?nps/HLdh80F/iFSeEmPRyhMpGTk1NI8SuJfEOEVZKVf4c0+qhZ5tnfIGaCqC?=
 =?us-ascii?Q?NPQULTwEH5ukUNFN+6aGhlrdip/BwjgjBSpUzc9wT7HtUi7G/OZXuH356mt0?=
 =?us-ascii?Q?vSWTYzok0mYMzT6DfIgxgK4SFaoceh8oqF10tpwL3WuPKXZAOF3avTwN1ZW7?=
 =?us-ascii?Q?l9hshW8N6+8luUOhhUxzBepZIg5ycKbNJ6hUpzAs5bFZsI2Q7Ld0WRjNql+G?=
 =?us-ascii?Q?ni+d/x+I+qu+EFvUv8W1KC/+xZXfQl8DWfFQaWTPOMhW67Fycn1Eb0DD/ABg?=
 =?us-ascii?Q?hF3Tlhx1IXOvWozDeGwjfUQp9br3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q5W6Ek8Ry6ZZAlqziPPqMRKLFilqWMPTpm+TT5tUHcAdNiG3IWQGmJcUwN+5?=
 =?us-ascii?Q?Z6i0l0cvzXjAWJlfQNcmhmUPE6tuSyvvcurnPOBOcYExf5PuHUIJe0nNwRgk?=
 =?us-ascii?Q?fcnFTc3BuUcCVyOY7qwDugX9w+6B87FwBNwTai7/NfGMFhmp13QUNlUgce0I?=
 =?us-ascii?Q?ciUD/aNMW46NGsAtqm0pAbtxooOnBZ1hM7nKqZxr0bPJ9IQwxCa4G84plYZr?=
 =?us-ascii?Q?V6tx5yKxX5/P6CrTUe4ehGhAGBn3x67lvy3laP71NcqZfh5h4IOXErgN/jQb?=
 =?us-ascii?Q?74svXocIxkZHFYLf07mXycbfnGcpHzvhVXLsDBo2/AtNTkALuGJEcEuy+aGY?=
 =?us-ascii?Q?u9gqjvsi9kcY2lKLCAUPjuG7Xz1lBIqAGNmextjB8OdIN0Vr5PhfTkJnl4fw?=
 =?us-ascii?Q?vDxEBuPddbkRrPhmvAkbZ0nRhgoiEQNshABKjviY/EmO2QDCfV+BXWYA5RDK?=
 =?us-ascii?Q?MnxLRteitO4LDxeNb++MXb4QeDH9PBnDkXGxA6M1+GRoD+B3tc1ZZq3eak9F?=
 =?us-ascii?Q?16OorJ0fyVXJZrVL9VEO2/vwCf+ZsYokNNmXcRzMiZ/0Av64kEJDf2XAEn6q?=
 =?us-ascii?Q?2SxZIgSuzbex77HS2nefcYw4R2COPSBeKtWFUtKTktPrFglmzXPD/7zrzKrJ?=
 =?us-ascii?Q?mN1ANDHwq8gTfxgwFnMj3/Sqh4haGq11HbNx1feofDumG6HyeHCQcRXMXclg?=
 =?us-ascii?Q?StSaHsiZloST+5BwGeQauaum90XVa/SQm8rw+8sYSFKZRxHHRzM0DghvVvrl?=
 =?us-ascii?Q?Vr3idixHzUIYDfpLjgFt2CsXxjrsm0t98m9SLw9BL30mx5K1e/SBxjsQUlDp?=
 =?us-ascii?Q?rfqFCV2xSzZyKYjYOf4Xra0w3TnTfZFzRhjiSB0Ysc+s2Tk6tWKHKx/XtGQb?=
 =?us-ascii?Q?JpA/M7clDHMuHh+XKqY6/FuVABv8AfKVWadWAZmWTRIAaZsJgP8+Mc8AGhrF?=
 =?us-ascii?Q?Klp/mr89YZS5XKaHN+ZG9ZJJhQ/Lqh7kBPrFUo5ogpPjqiMpn4DTBWGV6Vip?=
 =?us-ascii?Q?PDlDw3eoBJ60mxKeHVfEE52TtBaweQhjil7FfQBlOhDPZXvvfdlKs2r/ewQL?=
 =?us-ascii?Q?dbY4Nscnmh1CSjucq51bfH5ymAgwF5U6C1iakEoIOoigtVdX7mtKb1bJXMw5?=
 =?us-ascii?Q?pYCVu4wDB1znFgCZYrHFuU6XNOGad7DsOYwQ18MnYC6IW4H2r9HNDcEIqgyA?=
 =?us-ascii?Q?X4ssM2+fyaYXCq6xznWMkPYXUPuaYVucH9HsUCt3F3gEs6IeiCwjuEWZ10to?=
 =?us-ascii?Q?uzI3ixjBHqgr6BfVPjcCmlNYRnPV+1i5jMFz9UIVuO3j3UUawntlaoEXukwm?=
 =?us-ascii?Q?YmKFiAY/NNWb9xdYvqwm0f7cd5SQssPatRySXeBwhVwCVU+zHvVOs4fg0UBN?=
 =?us-ascii?Q?tKSt3GWHXlz4EkCDeM2bo/ub6H25/JOSX/jFK0SGFJp61LmYU0B5XaeU5ABV?=
 =?us-ascii?Q?IoA+R/WK84h20Lp41hLjZue0SH4Gv1laAcBvqGhgN4YbCEC3YslXtU+oFQnw?=
 =?us-ascii?Q?yLoXnGVWWRABSWy/ny64+L/nyhWBn8zbIlqtx/QEQWEpn+2JxsfuAXYC7gF9?=
 =?us-ascii?Q?MFdnFrFl6luhgtNJPjAARXlMJhIMyNlQoc6DMQUahN7Va+evvvO9+l7V20KB?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae1c949-2cc9-4d36-c9f7-08dd28de0d5c
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 14:27:13.0021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSjHap1yIx4XptjMILmFAMwb5AosO4qH2PHG5joGIfDbuzRr69GLovzVYJNBK4pz2s2t0hdf3OpuFy8fguDYAyiV3h9gSCCy6Bh4PPp6uFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0820

Add support for CAN_CTRLMODE_BERR_REPORTING,
allowing Bus Error Reporting to be enabled or disabled.
Previously, Bus Error Reporting was always active.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  3 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 29 ++++++++++---------
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 13 +++++----
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 7d12776ab63e..dcb0bcbe0565 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -818,7 +818,8 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	init_completion(&priv->stop_comp);
 	init_completion(&priv->flush_comp);
 	init_completion(&priv->get_busparams_comp);
-	priv->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC |
+				       CAN_CTRLMODE_BERR_REPORTING;
 
 	priv->dev = dev;
 	priv->netdev = netdev;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 5ec8b300bebf..8e88b5917796 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1084,8 +1084,8 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_net_priv *priv,
 {
 	struct net_device *netdev = priv->netdev;
 	struct net_device_stats *stats = &netdev->stats;
-	struct can_frame *cf;
-	struct sk_buff *skb;
+	struct can_frame *cf = NULL;
+	struct sk_buff *skb = NULL;
 	struct can_berr_counter bec;
 	enum can_state new_state, old_state;
 	u8 bus_status;
@@ -1101,21 +1101,24 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_net_priv *priv,
 	kvaser_usb_hydra_bus_status_to_can_state(priv, bus_status, &bec,
 						 &new_state);
 
-	skb = alloc_can_err_skb(netdev, &cf);
+	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		skb = alloc_can_err_skb(netdev, &cf);
 	if (new_state != old_state)
 		kvaser_usb_hydra_change_state(priv, &bec, cf, new_state);
 
-	if (skb) {
-		struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
+	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
+		if (skb) {
+			struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
 
-		shhwtstamps->hwtstamp = hwtstamp;
-		cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_CNT;
-		cf->data[6] = bec.txerr;
-		cf->data[7] = bec.rxerr;
-		netif_rx(skb);
-	} else {
-		stats->rx_dropped++;
-		netdev_warn(netdev, "No memory left for err_skb\n");
+			shhwtstamps->hwtstamp = hwtstamp;
+			cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_CNT;
+			cf->data[6] = bec.txerr;
+			cf->data[7] = bec.rxerr;
+			netif_rx(skb);
+		} else {
+			stats->rx_dropped++;
+			netdev_warn(netdev, "No memory left for err_skb\n");
+		}
 	}
 
 	priv->bec.txerr = bec.txerr;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 0491b4a6d8e8..6a45adcc45bd 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1120,8 +1120,8 @@ kvaser_usb_leaf_rx_error_update_can_state(struct kvaser_usb_net_priv *priv,
 static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 				     const struct kvaser_usb_err_summary *es)
 {
-	struct can_frame *cf;
-	struct sk_buff *skb;
+	struct can_frame *cf = NULL;
+	struct sk_buff *skb = NULL;
 	struct net_device_stats *stats;
 	struct kvaser_usb_net_priv *priv;
 	struct kvaser_usb_net_leaf_priv *leaf;
@@ -1142,7 +1142,8 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 		return;
 
 	old_state = priv->can.state;
-	skb = alloc_can_err_skb(priv->netdev, &cf);
+	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		skb = alloc_can_err_skb(priv->netdev, &cf);
 	kvaser_usb_leaf_rx_error_update_can_state(priv, es, cf);
 	new_state = priv->can.state;
 
@@ -1176,8 +1177,10 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 	}
 
 	if (!skb) {
-		stats->rx_dropped++;
-		netdev_warn(priv->netdev, "No memory left for err_skb\n");
+		if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
+			stats->rx_dropped++;
+			netdev_warn(priv->netdev, "No memory left for err_skb\n");
+		}
 		return;
 	}
 
-- 
2.46.0


