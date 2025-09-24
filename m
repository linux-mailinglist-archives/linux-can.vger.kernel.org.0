Return-Path: <linux-can+bounces-4976-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90757B9B109
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 19:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20704C7D8C
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 17:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C69231771E;
	Wed, 24 Sep 2025 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="JmuTUOk9"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021089.outbound.protection.outlook.com [52.101.65.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A54315D5F;
	Wed, 24 Sep 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735046; cv=fail; b=dtJRxopzduZas8lvQQ2lH//deO0UmTr6B6GPzFPXb1s04Do01FYR/SJmDDaPorQmg1FUO6sLXmBPlYGT1zYHk2bntZZClkSio2hC3IAmnySTX+ToWi/Wauy6gm/vvJ27sZZ85E5TmqLfETxuJU2eSOzBrb0M8rgWCRGnUWusKIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735046; c=relaxed/simple;
	bh=GhnnqP3iyuoEZugACUchM4uHMj8DZ4WGN8+iDTC4wg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2Ck5Y9WIGgK2epCWmlBCstCekC0mzTkHBbaPAn8MqTNvtOr4Q28HerZVe5H5WpM6rw0te/C9n0My+apWRnUETFI686LLXX7KPlMENDWbXrO7t9HEw/yIZZbrzqvyC16GlveI0VaJ4GI59HjEJj+bHo3CwXf/Sci3P9jxX/dWDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=JmuTUOk9; arc=fail smtp.client-ip=52.101.65.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4YCcQl+X5QpzC5s2TkPqHKHppLD8MM11+LI6Xlhj/Ts7Q0D7pZLvNX4b/71/CCon0MBR80jXqyzat1Mdi/MpmYx77cRtLf/X9XLNqwPHYU3LlRjqUSk/wgsBTm6FD7R2vPv6L37+Vb2hB5JuYqImLBxC46MZicT+mB9cpA5f4zzytxDuj2UbhYs2jw3NV/4QsMssAshgPjqGRBN4OcMVKmmzLPNM50YeInFMdAa9tylzBVWa2T22XBoMkPcMz6MVQlA+SfR2AxMW3F+k35ySU17GPMVXXuCmIs9ZSnO2W0NWkjkWeNqJ72g02EvieWEdcoFYxA+PPHM4jwLxht+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWjd6bmJU6L7FolqEPjUp9kMWfKlCI1aIyoMh8a0urs=;
 b=NH8f7r7qa4hTvskD38MlvcRMYJlZAgMuRn09TcHG2OR5TDqXQhsr5F0hmwGNVUhZCAZE/T6206SKFxt9e+/KejW84CXBZhQ1HwjbMwPfqBOuV/Wp/nAsn+2Y6gub45LF2YZVbYOyGvmGjwKZKHMGC5lVxWPKJd39mZ4XdXz72/S7XuLqd3nKs4oo4uDv0MYI6aTcVj/AMof7gWXPKchEkX2aV6w+EfUHGN9pfJiG55sNlRRIT2DSjEPzrzNFBbc7HjRHL8sKKKPSHil1aPS3W+C6KFkajGJksKD8WAjLEkr633VDUoHtxAhXwykzDWCKf0qbyKEVnuWAyp82GcqZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWjd6bmJU6L7FolqEPjUp9kMWfKlCI1aIyoMh8a0urs=;
 b=JmuTUOk9WE8VFwrj4jKfMgmXqmUIyt2JF50hzrbju2iVR+8tYxfn+ThaBW5Rp6ZYnCNcFBdvC/qF2XKrH+i8P9u3s95QbTLwhcxQONVgS43mDeH+T9RMgE1lN7If174zXHcRFgxFzRIudHTA/kmvfzGULbEkg2eLLakKjN+TyqQ=
Received: from DB8PR06CA0038.eurprd06.prod.outlook.com (2603:10a6:10:120::12)
 by GV1PR03MB10800.eurprd03.prod.outlook.com (2603:10a6:150:20d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 17:30:37 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:120:cafe::46) by DB8PR06CA0038.outlook.office365.com
 (2603:10a6:10:120::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 17:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server id 15.20.9137.12 via Frontend Transport; Wed, 24 Sep 2025
 17:30:36 +0000
Received: from debby.esd.local (jenkins.esd.local [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id E1B767C16C8;
	Wed, 24 Sep 2025 19:30:35 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id D7E642E25B4; Wed, 24 Sep 2025 19:30:35 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Frank Jungclaus <frank.jungclaus@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org,
	socketcan@esd.eu
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Simon Horman <horms@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 2/3] can: esd_usb: Fix handling of TX context objects
Date: Wed, 24 Sep 2025 19:30:34 +0200
Message-Id: <20250924173035.4148131-3-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250924173035.4148131-1-stefan.maetje@esd.eu>
References: <20250924173035.4148131-1-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E7:EE_|GV1PR03MB10800:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3fe0f9-6a08-4a00-9f24-08ddfb90129c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aldEa3IzZTNZQkdsRjBCWmtwMUxvRWVjcWtqSWpMMzNlU00rZis1VU5CY3Jh?=
 =?utf-8?B?ak9mTWNsU2hSK2JYd2hpS0grbG0xZkdlRHRWMUMzQ3dLM0E3aDZYelRoVXZo?=
 =?utf-8?B?aWhTTXNvRzdTWUVGeVpZeXJiSGJlbVNOckRnZCtONGFDK3U0eUV5dGJ4bTIr?=
 =?utf-8?B?QXhLb0NOMUZzK2l2Tm1lcHQwbTJtcGYyV2gzbm5vRVhrT3JSbE8xVXdteEo4?=
 =?utf-8?B?VDcyYUR0ZWdPVzcxRzU2VHpHZjJGSUxJQTF4MVZYN090NlluT1ZnTEZiY2ZF?=
 =?utf-8?B?VHRnL2hMaDZsV21sekttaEU3bzJtLzJIb25xSnN1a3VhOGVKb0VmeTFlZTdo?=
 =?utf-8?B?ZTRzdXFJZUVJZG5NTk9OTWJUSXRGMzR5SHdJR0hUdU1TaWU4NW8vNjdIdWRE?=
 =?utf-8?B?NnFON01wWmRrdUFuTEgwTVZRSEZCRGsyRTg3MklHYUZDelUyclpBMHY2Snd6?=
 =?utf-8?B?RGg5SXRSWWdIL2NaNHpiZU16a1dOMnIwRS9UellIT2pUZVY4OGxpSkxWUWkx?=
 =?utf-8?B?VmM0Q203WnQ3Rnc3VWZ0QUlDYkhMbHh2WmdxeWFoVWIwSEh5TGVwUEVEdG1v?=
 =?utf-8?B?MktRaWRmenY0Y25iZmN1ODVQTWREWW9OVDhsQVZYOE5tWmdSeml5dm9nZjQx?=
 =?utf-8?B?cWZZcVNCamFHT0pLM3hpVGpSb3RrcDB5Zy95ZmtySU9HYnR1Mzk4YU0yRTEr?=
 =?utf-8?B?cWhQQXU2N0dvM0JJSEMzVUF0TzdJejNhVUZtTHNHNUsySEFSdHlFaWY4eE43?=
 =?utf-8?B?eStxMThSb2lWdGxOa0xwRGkvZEhLZXh4UVBTK04xNEp6ZHBBU1N2MG1FMVYz?=
 =?utf-8?B?TENva2tURjBCQkNuZy9xV20yN2Z4UjczcmZBVEpsWWcySXFFZE9LMW5mWGd4?=
 =?utf-8?B?QnMva2s2MnJ1a0w4WnZHR2JxSFFLbEpMdnh3cmN3eE54QUtkQTErdnNMdkpE?=
 =?utf-8?B?YVZmb2padmxuMzVLSEZlZW9JZTFvTFhRd3BEWGtiblE4TTB2OUE1MVBxSFcw?=
 =?utf-8?B?dVJlZ1NkNGdJQXNNZFBLOUd4UEE3Z3pFd1h4RTM5NWtJV3N1YVFkOTZxdEtx?=
 =?utf-8?B?Qlc0UXdhVEtWWE9SUHh1K1FqbkFCWTJFRkc1VEVrRXY3dnEyNGp6WXBPRUI3?=
 =?utf-8?B?OVdwcEM4d0xYb29CSTNkMWpuUU1oMHdoNVNGZmtjRVNrTFBRUlp1c1k5UW1I?=
 =?utf-8?B?ZHV0VFU4TW1qWlVmbGdIWlBjc3NtK0t0OHFYMnY1MVNzNGJBcnVsSzVFcFBU?=
 =?utf-8?B?WitWWERha1FJbU1ieGRMajE5cHJjQm1RNHRPUVE0Zk1EM1lLZm9qaDFmTS9m?=
 =?utf-8?B?Vy8rVS8rME5SbURtRTVVY0o2SjdkZGgzQW1VWDljQktKbitoSFF2c0VBNEFR?=
 =?utf-8?B?UjhHWWNmVWNzdmRQRGhNVmdZc3ZzbXo3MW56eEF2N1FMUEJEd3hkeGh3cllX?=
 =?utf-8?B?Z2FOYkFadVE2d3duOWtQa1hNM2dPNFR4cXJUdnpBQ2NhbFA4YkxuQTUrY0Rm?=
 =?utf-8?B?R0s1VW02VVE2YWlHenBxZTZxdzRDRlpjeEJnQnB6ZVEyR2o4WTl6bmdua1pY?=
 =?utf-8?B?bUJPSlZwNXA1K21DMDhiU2J4OE9jc21say95N1p2RmwzNURNUjJ5eWZtcGha?=
 =?utf-8?B?aFpSWk5GRGN0NHRvMEZ3bTZUeDlYMFF1aC9WZEgwV2JLQ3ZrdmI3ai9Mc3Qr?=
 =?utf-8?B?R3RHa2YvaUhsczJvT0c5b2s2enBsU09yMFBLMmpsdk9LUWF1TjlJbzUwSFdL?=
 =?utf-8?B?NW0wUWhkV1gxSWZKdnJlVlNOQWp5M2ZzL250VVB4Y0R2aDNxbGMzN29iL2Zq?=
 =?utf-8?B?TkZ5UFIxdWliaXVRajgzamNRS01RVXhobTM5eDJKVVhvelMwOGVjUXBQcnV5?=
 =?utf-8?B?UXUrbVlEdzlDejVKcXc3UEhTQXFGZ0dHUDBqT0hJcUo1T0ljMVV4b3hPOUpT?=
 =?utf-8?B?ckk2ZjVHSWFNVGl0TFFUR1hjTWFTWEhLelJESlpScE1FSDRiZjdpSkxvNkpZ?=
 =?utf-8?B?OUpyWm9mc0VBPT0=?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(376014)(19092799006)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 17:30:36.1521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3fe0f9-6a08-4a00-9f24-08ddfb90129c
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10800

For each TX CAN frame submitted to the USB device the driver saves the
echo skb index in struct esd_tx_urb_context context objects. If the
driver runs out of free context objects CAN transmission stops.

Fix some spots where such context objects are not freed correctly.

In esd_usb_tx_done_msg() move the check for netif_device_present()
after the identification and release of TX context and the release of
the echo skb. This is allowed even if netif_device_present() would
return false because the mentioned operations don't touch the device
itself but only free local acquired resources. This keeps the context
handling with the acknowledged TX jobs in sync.

esd_usb_start_xmit() performs a check to see whether a context
object could be allocated. Add a netif_stop_queue() there before the
function is aborted. This makes sure the network queue is stopped and
avoids getting tons of log messages in a situation without free TX
objects. The adjacent log message now also prints the active jobs
counter making a cross check between active jobs and "no free context"
condition possible and is rate limited by net_ratelimit().

In esd_usb_start_xmit() the error handling of usb_submit_urb() missed to
free the context object together with the echo skb and decreasing the
job count.

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Link: https://patch.msgid.link/20250821143422.3567029-3-stefan.maetje@esd.eu
[mkl: minor change patch description to imperative language]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index ed1d6ba779dc..588ec02b9b21 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -460,9 +460,6 @@ static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
 	struct net_device *netdev = priv->netdev;
 	struct esd_tx_urb_context *context;
 
-	if (!netif_device_present(netdev))
-		return;
-
 	context = &priv->tx_contexts[msg->txdone.hnd & (ESD_USB_MAX_TX_URBS - 1)];
 
 	if (!msg->txdone.status) {
@@ -478,6 +475,9 @@ static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
 	context->echo_index = ESD_USB_MAX_TX_URBS;
 	atomic_dec(&priv->active_tx_jobs);
 
+	if (!netif_device_present(netdev))
+		return;
+
 	netif_wake_queue(netdev);
 }
 
@@ -975,9 +975,12 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 		}
 	}
 
-	/* This may never happen */
+	/* This should never happen */
 	if (!context) {
-		netdev_warn(netdev, "couldn't find free context\n");
+		if (net_ratelimit())
+			netdev_warn(netdev, "No free context. Jobs: %d\n",
+				    atomic_read(&priv->active_tx_jobs));
+		netif_stop_queue(netdev);
 		ret = NETDEV_TX_BUSY;
 		goto releasebuf;
 	}
@@ -1008,6 +1011,8 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	if (err) {
 		can_free_echo_skb(netdev, context->echo_index, NULL);
 
+		/* Release used context on error */
+		context->echo_index = ESD_USB_MAX_TX_URBS;
 		atomic_dec(&priv->active_tx_jobs);
 		usb_unanchor_urb(urb);
 
-- 
2.34.1


