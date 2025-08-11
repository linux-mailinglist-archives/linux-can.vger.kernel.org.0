Return-Path: <linux-can+bounces-4199-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFB2B216FE
	for <lists+linux-can@lfdr.de>; Mon, 11 Aug 2025 23:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F034E427B2B
	for <lists+linux-can@lfdr.de>; Mon, 11 Aug 2025 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CAA2E4279;
	Mon, 11 Aug 2025 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="aUEDuqog"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021098.outbound.protection.outlook.com [52.101.70.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC62E3718;
	Mon, 11 Aug 2025 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946380; cv=fail; b=uNxXTl1YFJsJ1g+xCbsyi8era2p4l8TwD+7UxuNQc52VxKkj0qCktxErOvdFeix3ocQc3NIjpow2Ze1jzO/5UMv0f4Olf+xqNRo6Q83xZ3AvFgPxnD5+KRLk14ZXM0RbzI9V6QGqsy7ctA22Rw5LYfhQTiMz568wZ2EKzpEWR+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946380; c=relaxed/simple;
	bh=Lnt+AzbuehWYqItoiXEoLVVnU4T0ynEwM5PNItkuLFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQfIO0SA6AQrMvjKAYbn0ozUEE4HfZ6oQkPzMFc+8wV6OEhibHJhaWrkyn6dpHpcuNG5GB30vHRHUBQd3dk9gfiz3xsqtnFrD7w8QPqOO697BSg3ibeSmBu/NRHmFEhPLQGcZRegjYJvuVxrAZrBn4+Ner3bUmqFUCkKOxxsVe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=aUEDuqog; arc=fail smtp.client-ip=52.101.70.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0NjoIkScKIU+Vc5x/T2eo/oCh2c7YtJoS31d+dx4C2IN1ZBT1Lz0wYDph0gjc/k5WgThwtkQfO+mytnA9GNDN0CGm/DsOyEd2rtWey2UZBhvZ8mvlWh7yR5heQExcsLITJYqL4S65ziJAnvLFCGhWF4QNrczTBmmtXoEWImDQCaUKoQqOsiNOigpkb/gHj/IT3p26dGRPNuW/2/pgYMdr4qy/LauLh1mQb6Hy+oIXYfSaLjIppehnbFQZI22ESUCpGTwGOthT6GTcJaPNuKDc5kmZTF13hkQRgnjjIclKYht7uZR8AHYox4+Tuk6M8YUbIUttbDSj1YmqPDromJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vt5Id6YLdp8N4cOxMqXPHaub+VuzeAbm/DuNkdL3cBo=;
 b=HPMHLr0qxXYj5kWQwJJgm1x93khRlOOMHHrN90CqhbmLckFzF3EA+JLxFubJDeVrg75RNOagcDoDRK2dtSI49zR+AgnLH7OaAkCUvXGA4QLyEuZRSr+h+g1YMayO3kNcOsMGaBVODaP03hVIr9vvjFfF6mHECt0QQumcOdIIJB1VqOiuHOE9C0vCEz5sIWQH4aA8ECyF0VM7QXjYxAj62Hr+GkUMDLTqn7eyWrZgD/qPzdmN9jJEMTVeUydQK1rWvBuURALPDHgLnQaXf69nD657crzrwemkm0EDwrPrqeaOu6YXuwY5ll2dEOnnAJmR6StsqTKQ7e3nRZ0XitxG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=esd.eu smtp.mailfrom=esd.eu; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt5Id6YLdp8N4cOxMqXPHaub+VuzeAbm/DuNkdL3cBo=;
 b=aUEDuqoglQvM4XxI+Ko2qLHUwY+8sUEM82ibZe3h/ej61b6pfpD/+xAD8XDNxMSIB880utGcxidJWrwVorHDxCuCNZjbCz5G6PcbzuZeDBoe9QRJrA2IaQoP7XMceJ4eDZuVVVaeRdsR9hUVE+uChEUN35Rw4ukF0EBmBkOMsb8=
Received: from PR1P264CA0201.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34d::12)
 by GV1PR03MB10702.eurprd03.prod.outlook.com (2603:10a6:150:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 21:06:13 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:102:34d:cafe::cb) by PR1P264CA0201.outlook.office365.com
 (2603:10a6:102:34d::12) with Microsoft SMTP Server (version=TLS1_3,
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
	by esd-s7.esd (Postfix) with ESMTPS id 05BD67C16CF;
	Mon, 11 Aug 2025 23:06:12 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 01B7B2EC3E2; Mon, 11 Aug 2025 23:06:11 +0200 (CEST)
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
Subject: [PATCH 6/6] can: esd_usb: Avoid errors triggered from USB disconnect
Date: Mon, 11 Aug 2025 23:06:11 +0200
Message-Id: <20250811210611.3233202-7-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A791:EE_|GV1PR03MB10702:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a10e989-087b-4307-dad9-08ddd91ae740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2lMUXNBZGoxY1ZRb205bVdkVFY4VkVBMkNoRzEyU3cwMC9ac25WRGVJUnJu?=
 =?utf-8?B?VFR0NndxdjdnZExkTTg4eUpuQTJDTFNGNlEvTmt4N213bzAzSXllcHJZVzJ3?=
 =?utf-8?B?a3VhTzYvZUluUUdRKzZWNnZzb3VxRHFOK0JESmdaclpsQ252a2t4ZGZSUkJW?=
 =?utf-8?B?VmpONmtNYVhnTW90SzJjT2dJamMxeWhVbzJ6YTgxT0Y3VWplYXJIY0lTdW5T?=
 =?utf-8?B?VHprY1AvRnBNTDFRNDI3YmJCYUdHU0N1Zi9TS1dxUjkxMlFqOHhCd3lvNSty?=
 =?utf-8?B?UldRUm11Z29LbWJXTm1hNjByMFFLVFdXamk1RVlEL1dlb1BwTWZXOEsrU29C?=
 =?utf-8?B?MVNob1NSTmZiK2FVbHFTV2FJU1RDbk83Sm9pVVhYc3djTHpvUjAyQXlYS1FJ?=
 =?utf-8?B?SlBrNlFGV2N0dm1wL01jeFd3RW5tVFNGQ0Y3MkRFT29qSUN0QVBDU2hNY3l5?=
 =?utf-8?B?VVpnZmN4dnhMTjdwQ2xyeVhPYVBnTmd2VmtHZVBKVHZFcGloeGZxRlVxcnV2?=
 =?utf-8?B?WjAzV1dYQ2gvNUtDY2RBdWpwaGhyV0dHRTFBTElzWFlEQm5zSTFrdTN1eWZQ?=
 =?utf-8?B?RnBTNDQ1UlM5ME15TUs3VGZ2SDNEcEt0Y1dmUzVvbWRCbWNwamN6ZklzOVlF?=
 =?utf-8?B?N1RKWk5EWGdXS04xUldTTDJGWjlaRS9VUmlhTzNnd0hPVkhQdU9wTGZlMGl0?=
 =?utf-8?B?VUQ5SUZwM0NSL3drWTMwV0k4QS9TYlZwcVhmRnBvcjVid0dxRHA2Y1JUY2Ni?=
 =?utf-8?B?ZVRVQXQvSkhSVU5qcmhzSm9CVlRkZG8wOGR5RUZvSVU2MDgwZU9aVnUzL1Z4?=
 =?utf-8?B?VXVmc0E2STdWbnduWWQxRnpTblZLOHFUOHFCMy93bjhudWNsR3p4c0JvdXVs?=
 =?utf-8?B?djFWcHJoemlSOU16VFBmU1BYUFVqUDZrUDJ4WTU2WGhVcnk1WHNtN3hiNXBG?=
 =?utf-8?B?RlpqUkZpdGg5Q1l4VGdLeEdLdUprZzE1MFhXcW1oVUtsb3dOOTlVZ2RsL2xM?=
 =?utf-8?B?c2tBbys4UEtmS09jckE3R2Z3dlBvT0g4ZCtaSkh0bkwvL1V1S0VTS25ZM0tC?=
 =?utf-8?B?aDExdEZuZ21hclZsVlRSM1QzckZ5dThrT01IRFdYUHlzZW5pMytMcDJCSUdt?=
 =?utf-8?B?R08vS2ZuR0JnN3o0aU95TGJ4blhpQWhLTW5aVlh2U2N4MEJxTHhES094c3pj?=
 =?utf-8?B?Q2Y4UnAwb1RpQmY0cTNHL1NkOUtUZS96a1hNQTZLZnoxVWNVeGRrL3BlOUFE?=
 =?utf-8?B?aEIxZzd4RDBJOFJSU1BRQjAyaG5vUkt2STltZFhWSDczMXFNT2VXY2RSWkdP?=
 =?utf-8?B?L09UeUQrZG5XUzJXWlpXa3QrZmVObkRGQlEyT1VaLzJoZWdGWVVZSkhwamho?=
 =?utf-8?B?d2tSQ2U3L0QrT3hzWlRpUzkvNTZqV29ST2pENjc4c0RKU2FUaEZJOVF5V2JQ?=
 =?utf-8?B?SGtuWE55SzFCSmFBK3JIdXdjVEx0ak1TSUVaeHRJNXg0aW1CeEcxcmExckRR?=
 =?utf-8?B?NFRMUmJiV0RuWlp2azJENjhuVFJYdWtaRlljK1VESmQ2di9Sd1B4V3ZabVF0?=
 =?utf-8?B?ZUg1ZGNDVDM2MXJUSExvVlRqRGJCY1RYVFMzZCtxRWhlSElMNWgxWXhMdkdy?=
 =?utf-8?B?OXljdVlRaERzUjVzQTkrcm1wbTZwN1VwUWkwUFg2bXpLRUxDQWxWOWpLMm9C?=
 =?utf-8?B?eE0vV2RTYUttWk5YQ2JUQ2RLYk9CcktxZDA0R3JaRmw1RmFKN0FjcFdORzdz?=
 =?utf-8?B?TVZZNjRPcHl3c2dEWHZhNWtlWnA0b2RzV25aODhRVkVINWFmTzhnYlpEUlRt?=
 =?utf-8?B?S2xDU2RRcW9wT2lVTjR1a3RZaDJJMFNlTVluRjF6VnlmN09KSVlCUjQ2dk9x?=
 =?utf-8?B?OGJ0SDh1emp2TDVZQ0sxUTVTTWNBeStoYW9NRUI1Z1RyWEFISEgrc2hzekMr?=
 =?utf-8?B?enRxOUdveHROdUNRQzF2UDRSeHIyZVM4Q2lSaWFmWmt6cUsrVWh2ajhnYVIr?=
 =?utf-8?B?RWNTRkVucitTQ2JmNklva1hkOFh5WTlrOTBlb0dxMVJpd1hTNk8zK2xQdmpY?=
 =?utf-8?Q?YnyIY/?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(19092799006)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:06:12.7819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a10e989-087b-4307-dad9-08ddd91ae740
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10702

The USB stack calls during disconnect the esd_usb_disconnect() callback.
esd_usb_disconnect() calls netdev_unregister() for each network which
in turn calls the net_device_ops::ndo_stop callback esd_usb_close() if
the net device is up.

The esd_usb_close() callback tries to disable all CAN Ids and to reset
the CAN controller of the device sending appropriate control messages.

Sending these messages in .disconnect() is moot and always fails because
either the device is gone or the USB communication is already torn down
by the USB stack in the course of a rmmod operation.

This patch moves the code that sends these control messages to a new
function esd_usb_stop() which is approximately the counterpart of
esd_usb_start() to make code structure less convoluted.

It then changes esd_usb_close() not to send the control messages at
all if the ndo_stop() callback is executed from the USB .disconnect()
callback. A new flag in_usb_disconnect is added to the struct esd_usb
device structure to mark this condition which is checked by
esd_usb_close() whether to skip the send operations in esd_usb_start().

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/esd_usb.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 3c348af566ec..70c0e7b96b8c 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -280,6 +280,7 @@ struct esd_usb {
 	int net_count;
 	u32 version;
 	int rxinitdone;
+	int in_usb_disconnect;
 	void *rxbuf[ESD_USB_MAX_RX_URBS];
 	dma_addr_t rxbuf_dma[ESD_USB_MAX_RX_URBS];
 };
@@ -1032,9 +1033,9 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
-static int esd_usb_close(struct net_device *netdev)
+/* Stop interface */
+static int esd_usb_stop(struct esd_usb_net_priv *priv)
 {
-	struct esd_usb_net_priv *priv = netdev_priv(netdev);
 	union esd_usb_msg *msg;
 	int err;
 	int i;
@@ -1051,8 +1052,10 @@ static int esd_usb_close(struct net_device *netdev)
 	for (i = 0; i <= ESD_USB_MAX_ID_SEGMENT; i++)
 		msg->filter.mask[i] = 0;
 	err = esd_usb_send_msg(priv->usb, msg);
-	if (err < 0)
-		netdev_err(netdev, "sending idadd message failed: %d\n", err);
+	if (err < 0) {
+		netdev_err(priv->netdev, "sending idadd message failed: %d\n", err);
+		goto bail;
+	}
 
 	/* set CAN controller to reset mode */
 	msg->hdr.len = sizeof(struct esd_usb_set_baudrate_msg) / sizeof(u32); /* # of 32bit words */
@@ -1062,7 +1065,23 @@ static int esd_usb_close(struct net_device *netdev)
 	msg->setbaud.baud = cpu_to_le32(ESD_USB_NO_BAUDRATE);
 	err = esd_usb_send_msg(priv->usb, msg);
 	if (err < 0)
-		netdev_err(netdev, "sending setbaud message failed: %d\n", err);
+		netdev_err(priv->netdev, "sending setbaud message failed: %d\n", err);
+
+bail:
+	kfree(msg);
+
+	return err;
+}
+
+static int esd_usb_close(struct net_device *netdev)
+{
+	struct esd_usb_net_priv *priv = netdev_priv(netdev);
+	int err = 0;
+
+	if (!priv->usb->in_usb_disconnect) {
+		/* It's moot to try this in usb_disconnect()! */
+		err = esd_usb_stop(priv);
+	}
 
 	priv->can.state = CAN_STATE_STOPPED;
 
@@ -1070,9 +1089,7 @@ static int esd_usb_close(struct net_device *netdev)
 
 	close_candev(netdev);
 
-	kfree(msg);
-
-	return 0;
+	return err;
 }
 
 static const struct net_device_ops esd_usb_netdev_ops = {
@@ -1434,6 +1451,7 @@ static void esd_usb_disconnect(struct usb_interface *intf)
 	usb_set_intfdata(intf, NULL);
 
 	if (dev) {
+		dev->in_usb_disconnect = 1;
 		for (i = 0; i < dev->net_count; i++) {
 			if (dev->nets[i]) {
 				netdev = dev->nets[i]->netdev;
-- 
2.34.1


