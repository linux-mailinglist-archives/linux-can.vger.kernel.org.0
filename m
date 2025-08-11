Return-Path: <linux-can+bounces-4200-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBF1B216FF
	for <lists+linux-can@lfdr.de>; Mon, 11 Aug 2025 23:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA964285E2
	for <lists+linux-can@lfdr.de>; Mon, 11 Aug 2025 21:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F622E5404;
	Mon, 11 Aug 2025 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="uSbGyE9E"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023078.outbound.protection.outlook.com [52.101.72.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926252E3373;
	Mon, 11 Aug 2025 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946381; cv=fail; b=NV85a706lJv4abbuY22JDNs/DKhZ1lPQL4+Y9JCuCYq8rO8fh2tXKqhwi3T5Yk3SGdmzwSEyd0Sy0y+X9Nhf5PZviqiwjzk8b+9NxB/wsngV81VX2zIFt3KTdxZpU+6fRikHr0ivCJdKe9G8mioe8Y0htI3GZXHeJD8qCJOd6Z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946381; c=relaxed/simple;
	bh=wUlW2Rne+GSQ4vAwlRCI04fhUZBB+7OWApVNmifxJP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WG8LSZKeBIpYoyBbmS8ZBlTz/2gRhEo5nAYXTgi3E2WTxPqxoJ0KVYfOHMmWTLeO1BnGUfyoYWM1tqBXQ0Z7wg3UjPyI4vrq7wdSkQAW6sH7HI2dohoTBZDDfME96+msMjgjQOmXS1bk9+Deg9vLSdF55G1pHhb1aVls/HmT38Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=uSbGyE9E; arc=fail smtp.client-ip=52.101.72.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ac32AU59aZTONp5qSXT815HaKKB0UdWl9+nFMFbNa+46XTPpooKU6jcwx7iDQLhGwE4BE2NbMSPiY2iILmxCL88h1gfgH1v/0KSVBBBISti/xss94vZrwA3NGshOfU+13XlWGimjErPbiMVPauA+Vy/Z8Gr43JuFDM2y7guBCliten0a9mY+uENZo5uuLnrZLpFgF99qxy7P5mtdAoe8siogPM+2c0C7bNntLLaAx74AeMvK3HSWgqEnn6oLxcKBOVu2/n7o11funQnzv1hMM5km0pTA0BH1Sjp/UyC7VI/kc5/+AWCNBFYPpEhN/LjW+KeMO5mP7dddjtA6vEgFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/b5qKRyhJdxMBfd0NIfsEnPJqi8/JHVaZ0uUnM0dAA=;
 b=PGICMqoRYRwxT+VwwDUjM6MDH5QSlAI9mO48FXtvqNkaYp3CN4GiwWCl7NC5U6pg9B7zekCsR3osx2XFL2Ey+FfebmPSgrCEzXeKm/V9Ssrdb3MhrcuaushHqe/3D9jPK52c61L8VhCD4QxBkhLKau/JTN6Hih5r/LP0QIsIOjzkYj3bkC+QbpOXbQltzRZ6vXFJhtuvFOLC07hIpjBncKsSK3Mf4BQv9BF+pPp8yq3Utk9itSLRqhLTtrM0MU5qA1ygHxj8POQkCW2RfMpIiWanHbRkjOgp5SgBZL4Q6NDKDTzQifhYlpit/kZRyCUfns9oD6b+4L9zqudU7L2PXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=esd.eu smtp.mailfrom=esd.eu; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/b5qKRyhJdxMBfd0NIfsEnPJqi8/JHVaZ0uUnM0dAA=;
 b=uSbGyE9E9fh3S6KyzcoZIv0hOVOZCidDTdACk5MkiO2xDlLIjw3h93aOQ/RtDNbzSBELUEshl+w8FX6cz9NMdKob9rjuMLiAFos1+RrHlM0MZKp9p7q+DxMnBDxTAw0JN/XBJ75LBRT2Rk/8s5Aa1jyE4Z0DyTnVP2UF+iakPRQ=
Received: from PR1P264CA0199.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34d::18)
 by AS8PR03MB6838.eurprd03.prod.outlook.com (2603:10a6:20b:29b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 21:06:12 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:102:34d:cafe::6d) by PR1P264CA0199.outlook.office365.com
 (2603:10a6:102:34d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 21:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server id 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025
 21:06:12 +0000
Received: from debby.esd.local (jenkins.esd.local [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id F2E977C16CC;
	Mon, 11 Aug 2025 23:06:11 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id EB24F2EC3E3; Mon, 11 Aug 2025 23:06:11 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Frank Jungclaus <frank.jungclaus@esd.eu>,
	linux-can@vger.kernel.org,
	socketcan@esd.eu
Cc: Simon Horman <horms@kernel.org>,
	Olivier Sobrie <olivier@sobrie.be>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	netdev@vger.kernel.org
Subject: [PATCH 3/6] can: esd_usb: Fix handling of TX context objects
Date: Mon, 11 Aug 2025 23:06:08 +0200
Message-Id: <20250811210611.3233202-4-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811210611.3233202-1-stefan.maetje@esd.eu>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A791:EE_|AS8PR03MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dac729b-a266-4493-cb11-08ddd91ae6e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1hJeFF6NEFLTWVsT1RXZ3JWVXdPREc1VStzbU1yV0t0MGVEaG5nNkVnNCs4?=
 =?utf-8?B?cTN4dVpxZUVuM1pJOERuTUo3Tzlpem5QWDY4Umd4UXlaSXZ1M1NKZDlFQW00?=
 =?utf-8?B?U2dINXp6Z3d0NmxyUEpOY3lzamVDdnU3cW1xNVFUOWVrd0s0OHhRNC9PTUxI?=
 =?utf-8?B?UHVmYnVET3dYNUo4cFBZeUhNNnBVUkNtTGw1Z2xkSEE1WFptcUNzZjJOSlhE?=
 =?utf-8?B?UFFQMWZtcWFWelRWVXpVTWNKR2h5dzhSd29YdlZWMGowZlh2VzNpUHFRbWJa?=
 =?utf-8?B?cXBkSFcrVytYVW94ZHg2aVEweWpsSS9qQno2TmsySjhneGlrZTJqNU1rVk1J?=
 =?utf-8?B?UWtyS0ZyQ0lRa3FTNTZEY2FRc3FIZlAxT1FIQ0VpcVZJaUx4Q1RHR0JTN3pq?=
 =?utf-8?B?QzgrMlRHbEFxNUg5K1YwVittcll3OUsxMFBVa25kWFVVN0EySWFyWVpyMEhh?=
 =?utf-8?B?elUzV1NvL1RLWVVDb3VLZ1MvZllWM1poYTM0c2lORnMxODJFenN3bnBkbXdJ?=
 =?utf-8?B?NkVhVnBWY0NrYnN3UGVEVldZRTZmV1pnVStYRUpmOXRPYk1lVnNneWpHL05N?=
 =?utf-8?B?WDRydG1DYU9OSEU1WFpjSHRPMDNISWpSdDgrV2hnSXVuK1BJU1Zvd3FTQ2pO?=
 =?utf-8?B?dVZJcjBWVWFGVWprYkp4MitsNWZwMzRjTUlYVmFvZWhKWjBzaEpWRGJwdVg1?=
 =?utf-8?B?MzFEK2hiK3hXSlBtcjVKSzlkdG9TeTdrWjYvWjVwM0JoRlpTbmR2S1dtR3lh?=
 =?utf-8?B?eW5kUEZQOS9lVDRuK0x3U1RYN1RPQ1pxelg3YXY2dDlhUXlWbXpTOFBIallS?=
 =?utf-8?B?REk3YWNvQmt5aHlwUXV1TFN5WlBJZ0M1QkpWT2kzV1NKSVcxcVp2MDNsb3A2?=
 =?utf-8?B?R3h6VUNybFJmQ2hVVTlmR3VaaG9tWEY2NklZWkd2MXRWVzBHTkhOQUpMaCtL?=
 =?utf-8?B?dnFGVHQ5SDVvd2lPRDhxUkV1YXVjZU5zTEJVQTVjTXdLQUhwRE1TOG1BbTVn?=
 =?utf-8?B?Zm8yMHB5cUZMb3pQMzFYb2dOVFAyN1JMWVdOSm9tU2EyQTBtdFF0cmdMWDE5?=
 =?utf-8?B?ZjJCMFh4bDNweU4zV0E1WTVTeWtVR1lYVGlVZXZvalZyS1lpMndsWXliN1Zu?=
 =?utf-8?B?eGxWVkVPK3hxV0llMm9EaU43eTBJNVJvVVZvbjlQbDlycUdla2M1SVR1LzZt?=
 =?utf-8?B?WjRuQWFaOG8wTXNXdG4xei9MNmFWSnNGTHhHSDdWajc0M09BVDFNUVd2Wm1p?=
 =?utf-8?B?UDczb0NlOWNHeG40cVlNTVlPd2N3TUZmK0lRdEc4OVNYbk9vODIraDFIVzFv?=
 =?utf-8?B?SEtOb0NpN09WeFZCVXhIV2ZyR2FwempiaUcrZFZndnRsenk3VFNDSy9aOVBs?=
 =?utf-8?B?Ym9nR2Q4ZzNhcUpMUThjcmQ5dE5lN21CZXQ5Y2Jkcnc3ODVYL0tLOFV6byth?=
 =?utf-8?B?cnFPUlpucDk5NkhkOVBGSmpCRlhqR2lyZmUwMHhzUkNGb2Z4OTkvSkt4QVJK?=
 =?utf-8?B?bFFOT3J4RkpUWkgvNFpXSVRVN0ZNMDQ1ZjJYanllTzQySGJ6U2hodktzamxt?=
 =?utf-8?B?RTFhUGJMRGxTalNoZS9JY2pJdEY0amllOU9tTGp5TWlGMEI1T2huM3RxNlRM?=
 =?utf-8?B?cG1qdFJGdDJwVDc5aTVVaU9LSUZHSGowWGdNVUdTZHZHNXBHcUhBQWQ5ZERM?=
 =?utf-8?B?V2ZZemw2cDVLMHIyakw3T0JOYXdiTld4RzBFdmd2ejNYdmE4T3NNMUdaY1h2?=
 =?utf-8?B?WUpOdlV5RnMzUDZMaFlwUUExWFNyNmh4NDJ4TEdVZi9tODFSK1VLSy9kU0Vs?=
 =?utf-8?B?bEpaZGQ2OWRGMkl5YnRFZjBvOFJNRlpDUHVSZHdQamlmS3VBdDR5WWdkK21i?=
 =?utf-8?B?WXFtTUxVRnY0UmVPQTVGNVZaWko5QUZRMGZBOUFqZER4eHQrY1RmQUtDTXJT?=
 =?utf-8?B?aDJSRngxNXpRcW9PWEI0Tk5va1Z0NkwrVEVPTUl2NWV6UThlampFVEo3VHFB?=
 =?utf-8?B?M3IyU3EyT0RrRmRmQjRENGtzME1GT3JmcFJhOEgvdFFEVG9xV1lUQjgxWGZl?=
 =?utf-8?Q?/qYdSF?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(19092799006)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:06:12.1472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dac729b-a266-4493-cb11-08ddd91ae6e0
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6838

For each TX CAN frame submitted to the USB device the driver saves the
echo skb index in struct esd_tx_urb_context context objects. If the
driver runs out of free context objects CAN transmission stops.

This patch fixes some spots where such context objects are not freed
correctly.

In esd_usb_tx_done_msg() the check for netif_device_present() is moved
after the identification and release of TX context and the release of
the echo skb. This is allowed even if netif_device_present() would
return false because the mentioned operations don't touch the device
itself but only free local acquired resources. This keeps the context
handling with the acknowledged TX jobs in sync.

In esd_usb_start_xmit() a check is performed to see whether a context
object could be allocated. Added a netif_stop_queue() there before the
function is aborted. This makes sure the network queue is stopped and
avoids getting tons of log messages in a situation without free TX
objects. The adjacent log message now also prints the active jobs
counter making a cross check between active jobs and "no free context"
condition possible.

In esd_usb_start_xmit() the error handling of usb_submit_urb() missed to
free the context object together with the echo skb and decreasing the
job count.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/esd_usb.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index dbdfffe3a4a0..fc28fb52564c 100644
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
 
@@ -961,9 +961,11 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 		}
 	}
 
-	/* This may never happen */
+	/* This should never happen */
 	if (!context) {
-		netdev_warn(netdev, "couldn't find free context\n");
+		netdev_warn(netdev, "No free context. Jobs: %d\n",
+			    atomic_read(&priv->active_tx_jobs));
+		netif_stop_queue(netdev);
 		ret = NETDEV_TX_BUSY;
 		goto releasebuf;
 	}
@@ -994,6 +996,8 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	if (err) {
 		can_free_echo_skb(netdev, context->echo_index, NULL);
 
+		/* Release used context on error */
+		context->echo_index = ESD_USB_MAX_TX_URBS;
 		atomic_dec(&priv->active_tx_jobs);
 		usb_unanchor_urb(urb);
 
-- 
2.34.1


