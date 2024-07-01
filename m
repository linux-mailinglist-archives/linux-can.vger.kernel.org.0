Return-Path: <linux-can+bounces-928-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9225591E49E
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8FDFB22798
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24DE16D4C6;
	Mon,  1 Jul 2024 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="dvJe2Z7b"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2125.outbound.protection.outlook.com [40.107.20.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D3416D4D4
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849014; cv=fail; b=BKHdslDRe/Kqg4PcM5WQ+b52Ya4dgf2avZm/OTdytGZQwiEHycpzTR3yaaBpmapl/gEey+05NHO+R8XD7RbVcHl4f00xz1LUr0Qw1lxEJBckItX92oSh2BEAjqX/kuasmrXoUZv2gN3VfjeyvkcLXTKBJWrjVmFKFDSorr3eN9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849014; c=relaxed/simple;
	bh=GaJCMgApORX6cs87RtBwgiTksjm/xIM/zhi5ZdFuXKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sZVu+Ak7yxf6kALelXIT7mms8a7QX+Qi5Jd1bDmmXHRZB/vp3JETNanoQbJ2WXS/C96Hb/RVTQJSYxZ51T64E1oD0zqj2pxWIAeRDS68bCtPdmMkivwrPJ5//fXgeElM2xiQyuYGlWiiOYasKRPTs+jBJIdQ0y9/NDYHMDlk4PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=dvJe2Z7b; arc=fail smtp.client-ip=40.107.20.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIAEXHW+v90L0bcIAZL7NZ7sP05rvAAqWl4QD3Ton50+ZCeod1Xj7zX3laoRnCJPVZ//53DvGSpf7NrxTHgjShNUgN0wse7fbtiJtOdW/47efqliM5pemXekJ6y6NzxDZlVpc8zAy7CNpB+ca9X8wHtKe9/QxYT+XLXkPEcmKOm6j/6hjnMc1KVLSW25SfSVuOQ/DaJijiViU7Fzi5xvyxyJhEg7zI5llVDMaCZ8p19BAOvUxMoAuqVCJIs8iWBbtvgvQGiln8d2Rgngg2+F9AESsILfOtmiWgiZVzYYjzbsiEt1eoe+55qKRERiXv4O10SaBFx97Z/job9Sao3cTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIPGekZ3gmp2jNh4p7whgzJkNXIkvIX7XjS2L0o+rvQ=;
 b=SONSqQs7lsdT9P2oj+dR5LAYakA59nZ8S3qwMp1fnnxyGbptNEm4q+iiCGFgOYdvYXi8XeF3wu1vL4lo5ik+IMqeipq233jO5LLKei+9hiwiogQtbjH6YnOh1OswJ5N5TAGTxZ8SNRMkjj+08HXG+6kyOLQ2PaVx0lu3xwjktpFRV7sHcxrm1iFChdd0ztvvGej4tqtxoYrs0e6CyBnjWsBRqvxueVWfvTkhkyNLFONZxc8x35fMlINrmGD3OU2RuPQaLoYXs+y4xGy9N2B3YVY9/BUP5lgkj7TAoFYoQ+7nMqLtggZMtIEfFyLOYl2ikmwMBNOnPmwsRVCWcz8dQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIPGekZ3gmp2jNh4p7whgzJkNXIkvIX7XjS2L0o+rvQ=;
 b=dvJe2Z7bK09rClqnLpt205gBzxj0WEKRJKgMeJecRGgdanolKJDmqCJBP0Ar6IBrfVxmdG5ZLg2A5saPSIffc2pY/o5nUG/ezvBC2u93PaeX38f8O5MCqdOc8Opq4GEwHbPxwEY2MKuk7WWVXOXYG66CCyAu9xbNYNbF0LBgoPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0519.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:50:03 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 15:50:03 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v2 08/15] can: kvaser_usb: leaf: kvaser_usb_leaf_tx_acknowledge: Rename local variable
Date: Mon,  1 Jul 2024 17:49:29 +0200
Message-ID: <20240701154936.92633-9-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 62c5a4bc-1803-4195-c279-08dc99e5786b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R+x1P2dQq44m4ichJgsp8iW7BCkA2dOW89+EoRlSJuP/2yzgLg0Qzd4xxCBm?=
 =?us-ascii?Q?8akltv0P6QKJPIVHCDPFw4vX3n01Xu2r/o5fXEhJipHdxO09BbZWb27CarU8?=
 =?us-ascii?Q?hQyP1evsNrB0ntDbH2J6MJjbwnhvM/0p7VKN+6X9Hx3G84L80meN3X9/riwQ?=
 =?us-ascii?Q?HS1UKj4vuHmn9m6YeLLPAHpsQnwSPN0BvmeFkQcjuvFP8AmuMUIL/l1svOmS?=
 =?us-ascii?Q?T2T0+1ZCcHCQJ97OKMGgjjjUaxXWDrUXgFDvPnyHQwkce0DCwthGOcDOuf7H?=
 =?us-ascii?Q?qTsw+QJltIm6nMxrgFOluGa+xfOKxumZZK4o/516tjSIEQ5Ik2X25qRMuTBB?=
 =?us-ascii?Q?ojDa3Cu2xLFvLi8jyXFmj6pr2rCpHt9tdtqmRsJcndchpwosJr9EZYcQM8P3?=
 =?us-ascii?Q?zvE74Qtl4a6F3/zy8eHIFfy2g5AsJBxEFJu6AWJg+E3gAT0gglfdNOHV9knG?=
 =?us-ascii?Q?0WvpKvoSA7VEbuvB3f2ldVshF2jbycPRNS9Vhx3frfylbDWqYP5OsnnezjUM?=
 =?us-ascii?Q?jzjfgG/JW2mI5wvW+rP6oDNd3HbNT/JU6KsO+v2VT3Sq9ucT+Eycj8IL5Xmf?=
 =?us-ascii?Q?O2GcnuPJiyzDEcxaCVloae2G2hBUeX8AzdGXznkgX4RNCpRloTmOL1w770Dn?=
 =?us-ascii?Q?v+2juEteMl/82ufV1RpiI95qmIhLA3arsdvOmz2toqCkdFnPB1sVxE2tbfxl?=
 =?us-ascii?Q?znRzln8hod2uBAkf7F1w+eecVm5aAcl1ZVWiVKFk7Kd8vKhqIMXoMalC7BGj?=
 =?us-ascii?Q?h0tAQZB/mx2xGXvfBeaEHuWf7M3Cbl3o5+p4AvuTLhS2VGbwDn672WaLFOlu?=
 =?us-ascii?Q?C0DO1nhZSPCyX9cGDbzQmLJ4f9lCAe/A7CRJcaSZo5WSnys6UxbyB6awAC6d?=
 =?us-ascii?Q?j4OCKPVE4ndo9UW5d1GKdf2HhL6jqhsR0lHLwsj3MkMhmMQHH9MVxEWP6usB?=
 =?us-ascii?Q?BoigFqBqLNDFu5THi/h+7hAXbS5Roxuq68jyU/VYFEh+qDbmmj3LsGYZbiA4?=
 =?us-ascii?Q?MmQYTKLCf9lUNcg54wXGXgYqXyCrkbxMCAQdGjzmA9OMKSzhEW1qpOqlkOf9?=
 =?us-ascii?Q?9KMxjrOmdOp2oBJJbiaM8ppVXw/SwAUPatkKIwdJ1grPR2rSp+0Ig0FGtTAC?=
 =?us-ascii?Q?TfIzkrLtWbBu16Z5Dbi8hHQCCcaHqOEU4m4duxQS4TnkHkVhpOoz9vpqlPI1?=
 =?us-ascii?Q?qdJOmjjKo8V1U6p9LK3D+orelW1TpxA+LfoQqr9jtc1fJhTV60y4bZeGXooq?=
 =?us-ascii?Q?wkHoOiQJSxvYrdlsYqPczwXO4Hfoj8ozyJzD6xWnK1oof0tl564E1/Dd60me?=
 =?us-ascii?Q?psd+3PO6/5twWSCizDnBjWeLV0IYFrJFEXBrxw8VVAhSCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9uagQCXPv/Hqqxu+Pjec8xuKnsd76w/erE32A4hRPflEsXXiaaAnLwFbZNbZ?=
 =?us-ascii?Q?TlBsaD5X8Dybj4yxbbf8PR2LOlSj6KRpKcJ5VZXBngniC6zsYvjUl94xwTrh?=
 =?us-ascii?Q?ciZaScj/0vR+wzdA9MjGbFhmgRKkCBQPihiZcsISeWiXLUU4B/8+qJ/Tysnz?=
 =?us-ascii?Q?cpxUBUnS2md+wEpq6/3qeX8kt1yV+cNJelGvDSeBumfwku/A20MdMAlipzpx?=
 =?us-ascii?Q?q4zJhawNyPdC/xZTSgts7tAWa2WNyxsm/085YnACD3vp9V3qcJGzBOCD3+eg?=
 =?us-ascii?Q?RqARDlF2Z87wKFgefFpKukAWELo+6x89coDFr754/YwfFUrX2ByFlvUfArbm?=
 =?us-ascii?Q?exbQfnKP1iThqv94zCKclQs8RtKachIhdokeMBfHc14YyN43A5cHkCS3hf26?=
 =?us-ascii?Q?RP4rxF11Ng5lglrkfiG5ar9jRwkD9sKzEtiEGtm84KoRrW4ECm4qLB/F0Ubm?=
 =?us-ascii?Q?pgie0QBmy2Exw7ZcKhJfITiD6Uwd7pG2EC4gSXWqaF0rjygqPwtmUx+6WDJD?=
 =?us-ascii?Q?/8u8JBBM3LQYMR4fsQD3CQoAyHK/mYTdf7ProKJHGdX3R4fR7mR9sx2TLwh8?=
 =?us-ascii?Q?HJb7OdkLXY4POwVE10SM293gokedQjQXMmUZlgvQFRHMBfE6I+3y3i+91oRO?=
 =?us-ascii?Q?ARfxzgo3OjP8/xhqaZHRXB+iLOqgkjQhSNEtlcMQwXPB2BYc5z5cykyeSiz7?=
 =?us-ascii?Q?AZRlmj4lFJUe90KPq7MSvCuhmD9nbCJlLw99ze9NgTN72MoeNyjRuhcZ4lXm?=
 =?us-ascii?Q?BSqa3/7QFttXnS6VnZLjYEbpS75MiKFgHQdaZ6U41H0R6pGzRcryzWcBxueA?=
 =?us-ascii?Q?/kOf+2fpaZ+/zbVDicYospzF1ebWQT2+fJ4z/A7c6l0L410C4FmPdEJ3BHST?=
 =?us-ascii?Q?KBXxno0o2ouTdyxU8NzNHGadL4KdhyoIPikqvuGVYK/+h05AuymJTaQF5XPN?=
 =?us-ascii?Q?gcnN7bwr05gS7q1WgMXP/SXM4zbNXMO4Yp9u/XVczSYSkuOPhmPZq3a+hQ1a?=
 =?us-ascii?Q?l3Tj5nBGiEefwKXeEQG0NaFKoFxFrTBY3LwV8kzGtM8zZilU1CfrLQRZN0Y1?=
 =?us-ascii?Q?HFYg7VPFCABJ0V15iP2krerECB7VqAZK1HamDPNOL2wCKjN70UGqc7/mcTxx?=
 =?us-ascii?Q?WLQZz1kkjKhfJnBZgPNLnZ581bhPi7TXOkZsFMjTLnouTB8HPNYBF+9ZY3wj?=
 =?us-ascii?Q?aQpNlzqrRP9qkLKcr410YLQ5ov7JY+Tj7bfbkkGGJ6ctDomagUyGKzC6twTO?=
 =?us-ascii?Q?UtWqeMJKOHXAMO/wMBUcY0B5CsmINJnkM11ssVPOoN2ZzOQorkGESLba40tF?=
 =?us-ascii?Q?BIydZ572kObZIem5FWy0upIYUhUBwqzFEdxxmFZCAnroiP8RsAxY3U82hXyi?=
 =?us-ascii?Q?q8QVn6ux+oGz9WT62BDqUjA4R6+Ch2Fi5EeE2fJK0EyuODGIUQbQvVpamRbV?=
 =?us-ascii?Q?sLUJnWHYTCrJJh4SNN14NkiZ43826boY2XzooQifR+nNQU+AbWqG4VO8rDO8?=
 =?us-ascii?Q?RdRleqAhr65724UKcBjLmdabrmj9Uc0Wh5pxfxQG0PxJlmaHE+/J3CMuGYVE?=
 =?us-ascii?Q?a1Ajkv3bc0rMyp00dlc5XboYDIeSgQgVByDpKHl2?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c5a4bc-1803-4195-c279-08dc99e5786b
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:50:02.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5FO1E3yfQIe/OBHGotIWCXny4PR2Lf6BLZyiEe/6kssCAGmqmsufEYrJ90Qr4v4aT7s6WVldRCkeHOjvly7Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0519

Rename local variable skb to err_skb.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - No changes

 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 3245471e906b..caef1f26a95c 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -936,14 +936,14 @@ static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
 
 	/* Sometimes the state change doesn't come after a bus-off event */
 	if (priv->can.restart_ms && priv->can.state == CAN_STATE_BUS_OFF) {
-		struct sk_buff *skb;
+		struct sk_buff *err_skb;
 		struct can_frame *cf;
 
-		skb = alloc_can_err_skb(priv->netdev, &cf);
-		if (skb) {
+		err_skb = alloc_can_err_skb(priv->netdev, &cf);
+		if (err_skb) {
 			cf->can_id |= CAN_ERR_RESTARTED;
 
-			netif_rx(skb);
+			netif_rx(err_skb);
 		} else {
 			netdev_err(priv->netdev,
 				   "No memory left for err_skb\n");
-- 
2.45.2


