Return-Path: <linux-can+bounces-875-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C0991C6F2
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E40CB20CAD
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6C77F2D;
	Fri, 28 Jun 2024 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="MJWTs7aI"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2111.outbound.protection.outlook.com [40.107.104.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB6977F10
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604559; cv=fail; b=RwUjMqwNh9LNJUqCm1uUWZED0Jweh3smtwufenWPvcaNnSNZBZpFVYkVFU741MDZCwIKi6IypJvX4Z161DoBOgHcLjw1IyFGkhhl3u0RmGaDZDtQe8JJTskH594GQIrSPwEnwAzPc21tL5vThMSSnMLQOMaKE7L+nx8TMDidAkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604559; c=relaxed/simple;
	bh=+JOCkost8q4HI0iIZsZ56nshowYoJe12pytZUFmsFEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RH7ax8n05Rgv5oSNJEjJReZSqqcCeSeiDBWcAsRZpIpGrYtf3Hq6G/CNySTw9ayq9+M3gmsd0+8dCTD+NzfRm0EVYunCZTncjelMChh0QohljbNte6hIJDK6vM8FdYovJ+WAFuzgoT9kAadITzdJ3I+nT2DtEECWAr27zIdrLgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=MJWTs7aI; arc=fail smtp.client-ip=40.107.104.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBKt9JYXUkkPaT5Jb+XWCh0/+AxtFv/gLs1Hle45zZWB0R4Hc2cvISVlVrAXkWtvCDWFrWE6sLAGcdxkDixOMoggH59hsMlUPwqBrc2vdQWCikBFZ6Xy2+57hlU3i4/MMeY3wS7AnHAnrQ9BD3/9JFRvtM/xR9YQOOVW26UUxXZZ7YbAZ0PHRc6EKX0L31NCqP6lG9+7/VXQEt702+teUbMjXsnDtplRouOxqbTZdK63tCoLN6chhLl6ACB6RIXlOMJfz8t7e+Wv49vttHBf1epA898+bjZX/WBZv2B1iNEUrn4uIi6t01fYtMm2BIVBu9zzD5bsBGLu52kLj35dpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSrKMZZ8Zi4vsYvqnJpz+f+n+w/Mm0rVmtZ/VfQrcaU=;
 b=lM7J0eFDsbpPP0IM4/EjmqvH4KcX9BGeaFY4AXMi3KquQvDubi5PkpQlwY4BAODyUZ8pwhEL96FYkJZJCUwmXVhQP3R9GARFqU2zk7W2kL2IBPrsd+KI05QTYMkax1NVqtzjHwaDKji+2qNVCpgGB6L1MGw3rWjAnVFEtntbE6PswkwycMJXg3nGU7FxDpzExHjdIWdO/TV+R455cdXEWDlw/4lmkUf81jdiEapZf/lRYr4IELZbW9AdELynwqsNAsJQJphIsnL4fRcWdQQKwd2mZoE24gonLbWA8GXZJniOn/tZ7Ar7zkAy/I22Jgdw2iViR7+KnXym9AWz7XKncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSrKMZZ8Zi4vsYvqnJpz+f+n+w/Mm0rVmtZ/VfQrcaU=;
 b=MJWTs7aIS8nNXmU3pkAi3jnRxhIKjc9NUbHXuku/EiSVG4YJEvlJHmvi3PkAJVcABOhGG4/2yC3ap//v3PeSmXKGVpAPHpCWMTVEhP04J/o8x0CsuGf2dXhYx9P2TrxICXSSUcn63yGb0oC/wEm9MqUmz5fBH23yrEvIqqndoG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1142.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.38; Fri, 28 Jun
 2024 19:55:45 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:45 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 08/15] can: kvaser_usb: leaf: kvaser_usb_leaf_tx_acknowledge: Rename local variable
Date: Fri, 28 Jun 2024 21:55:07 +0200
Message-ID: <20240628195514.316895-9-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b8aa94e-4010-4eeb-dc10-08dc97ac4c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SS42KcYnU+KEnlRmZEmDM8BG7HYhl7E5GfcQdovucO2CBePvhApU9z8qxm3D?=
 =?us-ascii?Q?oKslqWOQThZ9MNnTzOoLpBrd98HrJv5baKeoP0k4wiBPfSQs1eM0wnCdj528?=
 =?us-ascii?Q?3b9eKIXlGicHLbqu5+/nPjQe7p1KysUBGpUHp3f3sbZsaSZpwa+R/sjJTTRQ?=
 =?us-ascii?Q?VMRiDgzWBiWFBPYaQnbbeESWetxck0ula7ThPpwrlybosjTfqh2p3EdFPQ7m?=
 =?us-ascii?Q?6Um45sOYfyEI5RJ4BjkC5KI0T5+LZo/xjZh6oklfhBXUeQeMtRmKcKaDJA7P?=
 =?us-ascii?Q?DqtgrZPi7g8Rq/UifMFYmJQtY/XDYjq2vJTlPyDUkgnAXTbqCy+dY4/13ugs?=
 =?us-ascii?Q?sFmfH8rn/YXb5qvzfKAnT9iQxq/mrKIfY4PxzIZegVl+56N4ok6oEWt/20o3?=
 =?us-ascii?Q?tx29y9aQN9Bw6EJ3O2TCexbtF1jYRAP14Qr4RPxXK6b6PEzbgZBYjPkRiU1f?=
 =?us-ascii?Q?40wHJ3lf6XfCkFVdkzlXh+8xMp2Lmmg+/v8Ww1/TxmWYIQV3SFxaK9WlwTZX?=
 =?us-ascii?Q?ou5wNrVElq5S6Vb9Dt97Yu6YJfvMUg1MVM20IHyFH/XuR01FOYNhUkiemYH4?=
 =?us-ascii?Q?dtwjs4Kt3p4PKVtk1lZoTYMBvbjX4ltCY10a2WKhdZDJaym4LYz8QFPWCuHt?=
 =?us-ascii?Q?iXLFMB6gZz2//DYRAzNx4gVrhTakQeYIF7TDqElTUWLYjLXWliNehrIwtar2?=
 =?us-ascii?Q?JevXUZdwxdnS2mrrsmFemBdlrBurmEIIqlejHqsPim90UdRcXUkTUcra8cBE?=
 =?us-ascii?Q?n4xNHQpAPQ703/Hl+kEO6a8bAUoSQrbTwunxC3OIeDQV4gLByjZkdFD/bcLR?=
 =?us-ascii?Q?YSbOJXSjrc/OB9gH03d2G0WqQ5N+eS0ivMNutscx2GKQn6T4DEvgMFr27Z7R?=
 =?us-ascii?Q?sO9QP1oQcVLjEy5fGOyoGL5KAQ3nqROI7+2CqHy26DynWq17/HXe0mjw4W+2?=
 =?us-ascii?Q?LLfpM1QHRbXYWuQ9toJsc2VhZ5xgbZCnvadW1mhH5+GDO1dORtwHNOeLFLQp?=
 =?us-ascii?Q?NVe94IIwH71CriDyiOGfIGCLo1lT41I2BzINsFNGw6Gz9e/yS/SPFHqRgyDa?=
 =?us-ascii?Q?yEV7q2NywdLwoZn9nTWtFpDa4AQrwMxtRkpGXFlhgg0nycVMwPsJrBTFdvAh?=
 =?us-ascii?Q?JCiNOY+wfnOzjBm+qqM16lEV7uUqTwDFrZiODu1l+9AVITcixtoc80OhPgnW?=
 =?us-ascii?Q?wKxjuzOZ/FCfOGHrdaZEzv2OgrWMKGA206HdbXFtFMQVtV2I8P6snba5hKnu?=
 =?us-ascii?Q?TFwRBRgncGDkSa/4ZqGF4oj1okccMud6NbTjDnps/9Gn1KyYFbuyVRPGLik5?=
 =?us-ascii?Q?AfMvJUeEP8TyWnEmxMKbg1NHQSU9HrSTsmW37nNY+HqSdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TApxiV7z5k6PQOOdjnRv8GjfEap5AxJW+Q0csAGQjov6lRr7tQGtsfjpkwaL?=
 =?us-ascii?Q?KdJKUxITwjnJRo3cnb4apoFd0DKlYirNNelU6XmJxGNH/+6oVOHrJPqnR5sa?=
 =?us-ascii?Q?GnO4P/8ndx/B7/NgaX+kK9n5wr+BgaDzJCZSbw1KWdjfQbib1MP6XRb83btp?=
 =?us-ascii?Q?Q/bm/3Q580kmJ4w8HoNRAUHxAgT08XfZZCZVXcCgZrhih0AYz5WxWNv1C2QM?=
 =?us-ascii?Q?hYbXPCDWFAw1uE/D+5M6RgQTqIuThunCU4+V5K+yHJ8IuXm9CghSR89zP+tU?=
 =?us-ascii?Q?OUruDZ/dG29zTJDFS/nRhzh15zcxZg6RsHMqI32/hVO/+0CZo46INpX2RUgP?=
 =?us-ascii?Q?1/vjxgNMBYIn6poPDVl28yd3Z92vAzON6HUneMv0PTbOroroLqHTgyK2xaWy?=
 =?us-ascii?Q?xjBwuv10UpGQiLWPDcdwmXwBub3ocM86g2Su2JG1ybfHj5Q4bKFIwZP2qQWy?=
 =?us-ascii?Q?4fbrRRJZ3MTZ0htvQCFWcOc+TnTQLyg9HgKfXee3M3CEDNa7L4P2yLs+vTt3?=
 =?us-ascii?Q?rOe+80YWcVyQcVQ7Nzo63N181/HCRIm26bJV3tLZKYC7WrDM/Ltv02VNO70t?=
 =?us-ascii?Q?+r6Gd+svHHLTeuByhO7PqpVzPWbt+Vx/q21LgbB6V9iGaZoLksf6EktEVrZW?=
 =?us-ascii?Q?cayFkJJMzUYsakbUH6Syz+YZ5TGxh7jSl8PVAzF5xE9x3llls6XhWmAHku7D?=
 =?us-ascii?Q?OGv6vosODsdRnlCuAbARMvNncfoqeJCylDssCeW7fiH+VJbAGmMhb0rraX2f?=
 =?us-ascii?Q?wE1GHdOXn8YHsadZu7XyD058Pgb8sQTymEz6Fns+KbW7LOb7hjrNwkH9xnzu?=
 =?us-ascii?Q?o9PB1VvQQut8mTUVZIO34Xd2fzST2ZzEpgAA1pLut1qnSfk2WTvrvbThuLcW?=
 =?us-ascii?Q?+ccEVrMxsh8UTaCLpANGoA5a4xvbqY/alJAOtvBtgYEFmZQrJlf7R2bet1yL?=
 =?us-ascii?Q?Z8EIg1U1EBKlL8G+FBvroW2A+n09f5CIC+X7cRW8Bjf6z3tWF4PUHLWJmWdv?=
 =?us-ascii?Q?MorII79pREO6hD/Exjtbo/jRkEEN0/9xxEF2/R6kLYD87ta9Bp6pAThLByKz?=
 =?us-ascii?Q?C6zJp9NLuVytH3/zDhMTbKXA0S8BkgdyzWx94b8z5iVUPgsBHlQvtqGloP5w?=
 =?us-ascii?Q?9ARvQGuwqf/WMtphbSkDZ4rhODOq+1Kr9DUsO+AKIS0P3ntEQPbFk9960/fi?=
 =?us-ascii?Q?mz7P3M7y3JfIFJvRVZPA7M2f34X7IXEY2qjUx5DQ3EWQwoMdOsh7R68lz1e0?=
 =?us-ascii?Q?Rd/wf7j792opzYSf3oP3vTlqTunRe/IsyRx9+QNQ1H/LxXdvvF/oqgDt1LQU?=
 =?us-ascii?Q?BWHpBgBUgeMBoVF3HY4gMsueQogYhFUWMA4h1x3msUJklSvCQhziYzTVOu99?=
 =?us-ascii?Q?cpGkok5353yZdWI0urBWQ5tDgoMkCVwlANpeqvsjKJAFAGhsxONNN8AkuNd7?=
 =?us-ascii?Q?ZGdCeHu8NuanxPVX30ZcnT+q7dEpgEQwLl/sWaOPnIJ9sdhhfORvXO3ZdVqO?=
 =?us-ascii?Q?A/lCgQDHus8ybhfMHEFPTSWsyGUK1sUjYsWgJvEERUOmethyApW/LKyV+vWl?=
 =?us-ascii?Q?Ztt12lcB+hl85uffmBi1KkKapGi6/wi1Z3YboasC?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8aa94e-4010-4eeb-dc10-08dc97ac4c96
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:45.6287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueLBl80EDOEGuYKGVB9lfeZnkMNP0JBElF1Mvojhs8QfSk4dKEgdRq+a9PnUBI+2+1/m+0gQx8a/sU928YhaxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1142

Rename local variable skb to err_skb.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
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


