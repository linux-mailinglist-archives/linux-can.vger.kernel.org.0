Return-Path: <linux-can+bounces-4977-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76261B9B106
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 19:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84169380BC1
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 17:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176343148CD;
	Wed, 24 Sep 2025 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="A/+H34zy"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022125.outbound.protection.outlook.com [52.101.66.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A673191B7;
	Wed, 24 Sep 2025 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735050; cv=fail; b=idLcDdA8NWFJNZY2qafdPizidfdjc51HDwpD6kT1G2/MjAHTYjG1WeIeVyMTc2sUh9wkwZtEIXJ+jgGJCu3X2cCUULnXUaEhOUTFDjqnBwQOM1DP8B4S8Kl9l4xkUbcgQYkXTT/5wZmRVq83aO8IL9jSKeFMJtMT3lCSlwGeDxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735050; c=relaxed/simple;
	bh=3dMcrfV2URR0yI/cjjkTmjwV1BTucSl5MD6pKbgFh1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9YkdCS7twzR4RyX25tOLkxKXzMMU7KNbrB20C44dEP+/zemBZdvq39o41w6mz53Xohc0XmakuMMHxuytHreJcKYCxNw2QxljK3i5Rv9N3Evdj8t/z8VtbP5htVsyujSwmtQGugg6nDD2iSvsRFeGYmFg+QGV80rkZFYAGBYyYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=A/+H34zy; arc=fail smtp.client-ip=52.101.66.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZFaHRg0qsDcDTT2Urf4HXts16cMBVCH4EhbgJaRfRebfqtutAMJA8kMO5anCmHfI1rSPsS2l5w5PgHrGwmmSz19SXdlJhaLHUY92ooQgPz2sgbAipLc5nDLFKRQc1BsINBn0AH5UNRUXKYM1g6FVAeoV52YdShUC4eVwBnYBuNShrCt4RDUdcpnrFRwfG+BZFu/mjr3LESJeIKWe8PPdpfEU4nx96b7xTCnQ6d10Zb5M8phYe+OxvE5mGHPqGa8/OHSodHPTWQp/cEfhBSAJEim4eQuzD9Lpf8IHZdPZNoEygz98xq+E+qNTB8oqsdZV4z8sXKYrmoApLmVd9R/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPxyuxybxjqTXwQLpo06+rU9ns1WmAtnMMiPn2PLlgk=;
 b=idsDYlambwhwfV+CMj/gtu2yVPRMjpGW4/Ab1QBK+sJPV0Umes7A+2roKIdxIHBVg/eZmCSrHY2xBrqOpwnI87eai0LGdrsnyqyiywPnELSzFc1HrcubHWetxomjFjVkSL3y70Qk8iDTMnHDnLIJgj53RGkhxUWxQyWdb93TD7mvIwufn45jAkucCfq73tq2gKalyakhHbg8eiscdVo0XbnQGngPwoP6Vuq1GaE/9ftZf1KWT8smxhumGDhYrFt2kqMYcrR5YzoCcX86722/XHvgRUWos0rj6301sPm68TVgNLNhn4uOHv8Xogg2gardPjZhEmiPNwBsRfVmsvY8Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPxyuxybxjqTXwQLpo06+rU9ns1WmAtnMMiPn2PLlgk=;
 b=A/+H34zybxkMuKT+Ai54AJHB5dg+J/ZeX1175/WqqGEZwxs8iCZZxNZEomUrQaZWZRFW1iKVUgfm3jV4HyeYM0ikgFn+KPVW3UmuIo90ZOYnJgPDoIatr5Uz8HVQoMLfRZteQ49SCCvl/KZ8uKS+YJphhYFpaBihLwSPHLsr6RE=
Received: from AS4P191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::20)
 by VI1PR03MB10079.eurprd03.prod.outlook.com (2603:10a6:800:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 17:30:40 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9::4) by AS4P191CA0028.outlook.office365.com
 (2603:10a6:20b:5d9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 17:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 17:30:39
 +0000
Received: from debby.esd.local (jenkins.esd [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id E29F97C16CC;
	Wed, 24 Sep 2025 19:30:35 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id DC31F2E25B5; Wed, 24 Sep 2025 19:30:35 +0200 (CEST)
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
Subject: [PATCH v3 3/3] can: esd_usb: Add watermark handling for TX jobs
Date: Wed, 24 Sep 2025 19:30:35 +0200
Message-Id: <20250924173035.4148131-4-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9E:EE_|VI1PR03MB10079:EE_
X-MS-Office365-Filtering-Correlation-Id: 12918814-e689-40bd-e2fe-08ddfb90145f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|19092799006|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEZMMExFbVk1bDcyL0M3enM4bkJMTVVEMjkxdm5kNytmMU1Sekc1TTM5WXBW?=
 =?utf-8?B?aDA3ZllmNzhhT05FeUFZeWhCTHNqaXJXNjA0ZktQZE40aHBYQVRwc2pZUTN4?=
 =?utf-8?B?THI5Vlh0c0h0WWNqZXNINnc4d29VU0QzMUVQaHlBUXFHWWkyUlNXQlJQMC9s?=
 =?utf-8?B?UDVyU05oNHRqU3Rmd1FrU0thV0xpU0NMZEJWZlVPNWkvSktaTnU4UmxXSGpw?=
 =?utf-8?B?RVJRKytxQldpV2Q0VVJGRHJObDBlNmdpUThGb2xUN0VwNmVJTmt0SlZ1aWdv?=
 =?utf-8?B?UkxFOGhDeE9LSzM1UnJDUGJleUJCS0VMcjZBZ2srSWhhR2VqbEsxVHQyYVdl?=
 =?utf-8?B?L3RTcGJkU1k3d3JVWlJFeVJxQ3AwRVJRTnFOa1pIclhtWlQrNk14VU1PTlhC?=
 =?utf-8?B?Vzhid0o5eHQ5OWl3dzRkOG8zL1dHZ2d0OFN2eXlTVlg5cjVtUCtNa2oxZzlL?=
 =?utf-8?B?eGpVQjdydE5MdkVTYmZFWDlMNHdKcXA0cThSQUhRWmVKeW5YcG5BSCt4SUZW?=
 =?utf-8?B?YUFaR0tBQ3hOdTFnY0d1VndMeXhlZFpnTUF5R2MxSlpiZ0ljenpEaFIxS0t4?=
 =?utf-8?B?OU16MGVNdzk3SmRvMEFPQVIzQmEwYmZ3R2FGQkZUVFgvUStCbGh2ejRXYlNH?=
 =?utf-8?B?U0NJMnJ4R2V6ZGFZeWpWRlFUR2lwQXVNT3NwamgzSklIUzA5cUUxY3ZCSkFu?=
 =?utf-8?B?eFZ5ZEN3d1NhREx2MXBERHI0cDlIRXhiR3N5dGM2em1IOVVDVDhQS3cydzU3?=
 =?utf-8?B?aFNhUGJkdWxkS2JFa3gvR2dUcHU1RHNxckYyWXAxRkpIVlYzQmUzT3ExYzlj?=
 =?utf-8?B?SkxaNUxpL00zMzV4M1d5WVgrd1JQb1M4UjRtR0tjV1BIUlZFTTlkdy9YREsz?=
 =?utf-8?B?bWMrdkxqdElUNmxwUGI4NGttWmwxNnljNGh6R2Nlc1ZSeHY0bk93bENzeU5q?=
 =?utf-8?B?ZnNNQTJnZDBJM3MrOWRpL0huR3lZKzBqSjhUTEk0R1hDUWhySzI0YlRiYVVi?=
 =?utf-8?B?TTh3UmFUSnBRWml3YXpXTUE5T1lpWlhUMkNGekJ6TXlOYkhFRGVnaVAwalFx?=
 =?utf-8?B?VTZpT1EwRUo2Z0lRRlBURjhSaDc4ZHdGNm01dDBVVmkwZy9QamttUFk3QTky?=
 =?utf-8?B?OTBwK3BUNER5ZUVCTC9WVGJ6SzNVVElJbk5iT1BYMmEwNnNPRzVYcFBuVzhL?=
 =?utf-8?B?WDdQRXVnVEdXeGZTTWZBWkc0RmxFYWJtVTk5SGxvd2Fzb0NhaDh3R2M0ZXNN?=
 =?utf-8?B?TGpuUlpjT2owaUpMdGRYd21VYVRWaDB0OFlOdUZpbWRha2VtSkh5TkxoaURB?=
 =?utf-8?B?QU95UmFNbXNWdlViZ0tiWHNWbVlPOGtDbHptUWtHd2VEMGJ3dVhTRFludEJM?=
 =?utf-8?B?ZFNFZVJLcUtWcTFkMGJmMW5ZWHVHc2F0bHZodWtraldRWmNIQW14c2pJSVN2?=
 =?utf-8?B?VGJDMFVXakVzUDJTRWZrQTdwcS9SLytFTXU5ZmRnRVdqYUEzOFlSU1JCZjVn?=
 =?utf-8?B?b3dtRys0V3VlRlNxOUdKNVcreU12MEF6S1lKM1FtU2xJZm1FWVBOeGdDYkFC?=
 =?utf-8?B?bTViVzllck83eFNIWHE1dUJ3QXRjSXFyVU9CWVNDWEJyNXZFQ1RPaHRCRFMv?=
 =?utf-8?B?SVJtK0hRaVoyK1E4TXhGMEpPWHlBZmZVU0dqcVl6YlkrNWtxd3BUWDBvVXFp?=
 =?utf-8?B?WUZacGtsbFFjb2hPK0x2NDFQVDRyU0VFcTZIcUVaYTBOWHJDSmVJNUpkRHp6?=
 =?utf-8?B?bXZDRUtSUDl1RGxRbUJEMnN1b2hucnlDWDl6d0RieXRQQkNEbW9NRmwwanF5?=
 =?utf-8?B?MlFNSnJ4bERHZVJ3RllVS0tkM1pKMjZVNVBGc3ZkblpLM01pS0RtTFV5SjB2?=
 =?utf-8?B?MVYwS250cU5OK3l0dUVRUHR3amhzSXdSb3hkaDNMa0NJZE94UFhjc2dTT0x1?=
 =?utf-8?B?bGw5UTJtTzVUQ2oyZkRvbGU2bDY1Vk9yR1BibmNocnZHOFNXZVpMUWJTN21i?=
 =?utf-8?B?K2FCdTluc213PT0=?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(19092799006)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 17:30:39.1423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12918814-e689-40bd-e2fe-08ddfb90145f
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB10079

The driver tried to keep as much CAN frames as possible submitted to the
USB device (ESD_USB_MAX_TX_URBS). This has led to occasional "No free
context" error messages in high load situations like with
"cangen -g 0 -p 10 canX".

Now call netif_stop_queue() already if the number of active jobs
reaches ESD_USB_TX_URBS_HI_WM which is < ESD_USB_MAX_TX_URBS. The
netif_start_queue() is called in esd_usb_tx_done_msg() only if the
number of active jobs is <= ESD_USB_TX_URBS_LO_WM.

This change eliminates the occasional error messages and significantly
reduces the number of calls to netif_start_queue() and
netif_stop_queue().

The watermark limits have been chosen with the CAN-USB/Micro in mind to
not to compromise its TX throughput. This device is running on USB 1.1
only with its 1ms USB polling cycle where a ESD_USB_TX_URBS_LO_WM
value below 9 decreases the TX throughput.

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Link: https://patch.msgid.link/20250821143422.3567029-4-stefan.maetje@esd.eu
[mkl: minor change patch description to imperative language]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 588ec02b9b21..a5206ff27565 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -98,6 +98,8 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_RX_BUFFER_SIZE		1024
 #define ESD_USB_MAX_RX_URBS		4
 #define ESD_USB_MAX_TX_URBS		16 /* must be power of 2 */
+#define ESD_USB_TX_URBS_HI_WM		((15 * ESD_USB_MAX_TX_URBS) / 16)
+#define ESD_USB_TX_URBS_LO_WM		((9 * ESD_USB_MAX_TX_URBS) / 16)
 #define ESD_USB_DRAIN_TIMEOUT_MS	100
 
 /* Modes for CAN-USB/3, to be used for esd_usb_3_set_baudrate_msg_x.mode */
@@ -478,7 +480,8 @@ static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
 	if (!netif_device_present(netdev))
 		return;
 
-	netif_wake_queue(netdev);
+	if (atomic_read(&priv->active_tx_jobs) <= ESD_USB_TX_URBS_LO_WM)
+		netif_wake_queue(netdev);
 }
 
 static void esd_usb_read_bulk_callback(struct urb *urb)
@@ -988,7 +991,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	context->priv = priv;
 	context->echo_index = i;
 
-	/* hnd must not be 0 - MSB is stripped in txdone handling */
+	/* hnd must not be 0 - MSB is stripped in TX done handling */
 	msg->tx.hnd = BIT(31) | i; /* returned in TX done message */
 
 	usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 2), buf,
@@ -1003,8 +1006,8 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 
 	atomic_inc(&priv->active_tx_jobs);
 
-	/* Slow down tx path */
-	if (atomic_read(&priv->active_tx_jobs) >= ESD_USB_MAX_TX_URBS)
+	/* Slow down TX path */
+	if (atomic_read(&priv->active_tx_jobs) >= ESD_USB_TX_URBS_HI_WM)
 		netif_stop_queue(netdev);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
-- 
2.34.1


