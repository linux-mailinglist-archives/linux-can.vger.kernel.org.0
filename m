Return-Path: <linux-can+bounces-4284-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EEFB2FD0F
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 16:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C647FAE7CFE
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 14:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C832D3A88;
	Thu, 21 Aug 2025 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="fBOiIvCu"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020073.outbound.protection.outlook.com [52.101.69.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4269128467F;
	Thu, 21 Aug 2025 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786870; cv=fail; b=qGQWdVYuKGR4pohDHA9ob9lG/Kj1OLb1JQHAG/BEjM9oIClFCD5dkvqL7M4K5eu3h0gy1Pk5b9tipTIPlCrIzyi7iLPB7nq3lnIv4ub28fbXkmfLTXp2dr5HS/5yNFd5nxu+sjKqT3H6F9PD9kUDrv6Ef8oak7lwjPfegf5Bnv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786870; c=relaxed/simple;
	bh=ypmm/i7g/yMHIGfDaVawIsG/YvryNhDMAUhP6HQU2Uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qp8/o6VA3SAxUu3Sn2jq9/5/iu7nxWJGMTSBhsISqv1egTC6SmQIf3xGNIMpeeg675wwyOZU2FmVsPUkSZsHNtD/A9eZuzAAWd+y4zOv7Z+/Oc8SBKRzE47rBiorLnzCyMV+KT1/46cFZ1Zoo1zkJFG0jCB97jwr4e26RqUdZuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=fBOiIvCu; arc=fail smtp.client-ip=52.101.69.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLxvIbUEP0WmDLDBvhb3rad3l3iARLb0UpG4bZ7XOQ0i5geYYqdZA7TTyJvOq5uprwJNWrHcXnsKAVa3U3vW1BKv3UbGIpiwUlXVhEsrsqy1OD6EhqiNqbFE7pkNT00AC8F5Vkt8vMwtevAriCiHjvrMGjpKvsR+hqCL3Al+UiAN5ac0bV5Wurd7eFSE9mzHf21Vn3APKzHyk2+ureOCbSHZATpT+bXrgbl6/PIvQ7jgmisOJDCa0kdZ1CzxVHdpDlFTTWBl7mNHyakD2nu1VhlnUr/JDLTUwqw58Hezb8L26G0fJX0wkGGqVGq667nvm3GJMLcfFms70LIPT3fF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4qBiX6dmDXDITe+VzlsdxgQJNYG8puaLPFEmtxMyic=;
 b=nwQT/MCBlSUO9ne0pOeDMtT/MkSSlXsD8Usb82OCgZHK76t0Y7krCanTRqMtRtFkwNVRoUMaSMToIapnQsWJsKXqPx1weI84wOrL0kYzsHnCkbbE/E85VwPCb0C9VfOQjMEsBEzyQvWyWITwwEvJvRskqig5oOw+1DcUyGJ9yuLtBchqirR4e7MBIoF7W39yh6AgYfbB4MA7qvCc21Oa3hT2qUrxl+3taEbzNG2wF/5yRSR+Ise2RLXcKtmHc5Yh71be5iGPCHhoZDWHBCyeUel/yrHmx20Xi40MZswECqCSJ7khIAcWisEg0rPOsIRiHiDHZhHY2q8bZplHyBLhpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4qBiX6dmDXDITe+VzlsdxgQJNYG8puaLPFEmtxMyic=;
 b=fBOiIvCu3x3RHq3HdT7YB3mkJQBfQBBONbsTZpHqgFcDlqnDBJT8TGBTH69NRA6J8mhEOXcjgO7/O3aZ28yqpEUm5cbi/jqRksGxRCVUgU4bb/qGAeqGU0T5q6VGq95D31UT7NGfKQS+0HQQTvmlVGdBT4x8+XKoDuSE8tlMqe0=
Received: from DU2P251CA0008.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::10)
 by DBBPR03MB6729.eurprd03.prod.outlook.com (2603:10a6:10:209::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 14:34:25 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::cf) by DU2P251CA0008.outlook.office365.com
 (2603:10a6:10:230::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 14:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 14:34:24
 +0000
Received: from debby.esd.local (jenkins.esd.local [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id A34757C16CE;
	Thu, 21 Aug 2025 16:34:22 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 99E132EA436; Thu, 21 Aug 2025 16:34:22 +0200 (CEST)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Frank Jungclaus <frank.jungclaus@esd.eu>,
	linux-can@vger.kernel.org,
	socketcan@esd.eu
Cc: Simon Horman <horms@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org
Subject: [PATCH v2 5/5] can: esd_usb: Avoid errors triggered from USB disconnect
Date: Thu, 21 Aug 2025 16:34:22 +0200
Message-Id: <20250821143422.3567029-6-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250821143422.3567029-1-stefan.maetje@esd.eu>
References: <20250821143422.3567029-1-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E4:EE_|DBBPR03MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 39556d26-2889-4d61-814b-08dde0bfd348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXBkL29NTXNDTkpIWG9lV0JHQm9hYy9pbVluL2dBampGUDZDY0lwdEMvVTdW?=
 =?utf-8?B?ZlMzbmRBQXMyYkpaZ3Q5RlF5T3BUTE1WS2lDNTF5LzNsbDBhcVFlcXdaZFl4?=
 =?utf-8?B?THlXS2dGam54WnZnZ0Y3emhGZFZJVUR2RFBiMHllaWxhdFB4ZkNrb3lLR0Rh?=
 =?utf-8?B?S2R6L1FFU0dUQUpSYWkzK3pjekZYd1VQMFF3RWZyMnhyUG9VMVpPSUpoUkxR?=
 =?utf-8?B?V3VCck9acHVkWHlUaG1MTGN1cmYzZ1JNK2ZTZnBaRXpQSkNsL3RId3NXMTNW?=
 =?utf-8?B?aDVSTWdrelZBb3hqc2p5MDZpWmFqdm9BSFVFaEZOTk40WXE5K2MzQUdMdGlj?=
 =?utf-8?B?dHhPS0JXTzJ3WXVJbTNMMlVFcjJZUElQVHg2Tm9sZGZzT0h0SWJKSlBEd21T?=
 =?utf-8?B?SUdPdGY3RHE3ZGZ0cGxBbEVHa3RQTFVwdUFqVWphVGRYeWRvTVp0SGxvRHho?=
 =?utf-8?B?b2tLZlRjYlBxR3N3eUtMUDEyY0FtYWlkTzREQllzaWZ2OVoyUnk1WFE1eCtT?=
 =?utf-8?B?YzFPd0lIUDdBZWNCWnNNY3J4cWNWaDdKQkhmd0U4QzJvM213amtzSW9CTDZj?=
 =?utf-8?B?V0puaUptejFIOXV1RnJ5c1YvV2x2RzhqNGRmbDYzUWppMXo3R0xwc0E0c2hY?=
 =?utf-8?B?anZ5KzhXbFJmNVBRVUxYcWo1N0xQejRlMzRnQUZzcXR5Y3ZkSmU0TzFQeFVD?=
 =?utf-8?B?cXU1NlpnUWhZb2ZTQXN3d1AxWEozMkcyeWN4bW5PVWhxd09oTXRFSHBJa3BR?=
 =?utf-8?B?dnJ0bmNUQmVxd2ppcy8ycHhCdkRwc0hINUxGS3RCNDBvV3IxRjlKM0pUR2lZ?=
 =?utf-8?B?WUwyc0ovc2MwRHdwQlpEUkdwajY1TXltMzRLUFhFaldHOGRwR05MKzUyN0h2?=
 =?utf-8?B?Y0ozKzdlMlQ0V0lKV2kwVWN0QkF0RDNick1qT3ZLM2IwVERMZFNpbVBqZWpn?=
 =?utf-8?B?ZXpVUllES29oZ3crbGpGY0pjTWNvdEdKYU51UkdGcHNSdWlyYW9MR1U1KzBN?=
 =?utf-8?B?THJwWHBFeXR0TlpvTkxCSTl6c2ZVN2pGQW5ETnlIZEZGcEo3cVd2QjZKMkdH?=
 =?utf-8?B?aU5RMmRIUlFUSmRRZU9SbkdRczdKL3VuVTdXcnV5dVlTT3JGZDZoeWpKN0Vt?=
 =?utf-8?B?VURTQ1V0KzZZdUhGQ0pXU293c1p5WGRERmRsLzIya09JejR0cy95dit5Tk1S?=
 =?utf-8?B?eHRWV2hOUmZpZHRTRld2cHFvSjRPdEE0YWtoOXhTSTdrSHZ2ckFGeE9mR1l3?=
 =?utf-8?B?UCtEMFMvZWQ5OGNwSjVwc3hkTUtNOE4yazhLN01hWnBmdHJVVS90OUNOVlV2?=
 =?utf-8?B?SEdNempLVFhKNU13ZWFRZFRwUmtxMzl1ZzF3Z2JOQnNsU0FVbU5PTzRBZEhs?=
 =?utf-8?B?TzlmOUFuRldKWFNjRFBxcjcycWhCeFJrTjlLdVBGa29mVUZuWkt5eUw1VXJH?=
 =?utf-8?B?b2cveDVMbER2cXJySEhHNzc1T2hZTll1UlJSK0YwcmUrc3ZmZ3ZNSWJwenU0?=
 =?utf-8?B?VmE0Tk1tdFRQdG4yRjVEUDlxa0x2NHQrOHNPZ1F5eEkydTlyQ2g5dVd6RXVO?=
 =?utf-8?B?NGx1TWNZZE1CUmdOcjIzRWJRaUhJRzZITTBQTS9YdzByOTZoalBWQk03VEVM?=
 =?utf-8?B?OWtycjJDekV1MTBhYXBDbmN4bTFoWWREZGg2dml0VnlNM08xU0p4Q3J4SitP?=
 =?utf-8?B?a2FlanFvTXU1U3ZQVmRCay9udXpmN1A1Uk5CY3FyTzBYL1k0Z0F1Mk1oYUdF?=
 =?utf-8?B?SWJGUUN5Q2NoejB5OUwrTkF3SGd2Zkp6bWRodVczWWR1eWQ5cFRYZ0FrRnFs?=
 =?utf-8?B?NGtXYnJ0R3d1SHZBUTNxYmtBUzhWckJXdVkrUVQzYmRxT3dRZHpYbTZPc0Jw?=
 =?utf-8?B?SG1JOUhJNHhocTJTTytBOCtSVlA2MCt0eFFwMnBGQXNKSEhQNTNvemFmQmt5?=
 =?utf-8?B?K0toOG1EK1hKRGh3S1ZyaHV2Zm42YXA3RkNodDFYcWZ2cWNZVCswRTY3WHRk?=
 =?utf-8?B?WkVKRkxKS0RiVHdUZ0JqSVlxZVppTkpZSWNJVHhCY1M4ME1JZ3UyOVhiRXVS?=
 =?utf-8?Q?aJy+TV?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(19092799006)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:34:24.3527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39556d26-2889-4d61-814b-08dde0bfd348
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6729

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
index 8e6688f10451..0196394c5986 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -281,6 +281,7 @@ struct esd_usb {
 	int net_count;
 	u32 version;
 	int rxinitdone;
+	int in_usb_disconnect;
 	void *rxbuf[ESD_USB_MAX_RX_URBS];
 	dma_addr_t rxbuf_dma[ESD_USB_MAX_RX_URBS];
 };
@@ -1047,9 +1048,9 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
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
@@ -1066,8 +1067,10 @@ static int esd_usb_close(struct net_device *netdev)
 	for (i = 0; i <= ESD_USB_MAX_ID_SEGMENT; i++)
 		msg->filter.mask[i] = 0;
 	err = esd_usb_send_msg(priv->usb, msg);
-	if (err < 0)
-		netdev_err(netdev, "sending idadd message failed: %pe\n", ERR_PTR(err));
+	if (err < 0) {
+		netdev_err(priv->netdev, "sending idadd message failed: %pe\n", ERR_PTR(err));
+		goto bail;
+	}
 
 	/* set CAN controller to reset mode */
 	msg->hdr.len = sizeof(struct esd_usb_set_baudrate_msg) / sizeof(u32); /* # of 32bit words */
@@ -1077,7 +1080,23 @@ static int esd_usb_close(struct net_device *netdev)
 	msg->setbaud.baud = cpu_to_le32(ESD_USB_NO_BAUDRATE);
 	err = esd_usb_send_msg(priv->usb, msg);
 	if (err < 0)
-		netdev_err(netdev, "sending setbaud message failed: %pe\n", ERR_PTR(err));
+		netdev_err(priv->netdev, "sending setbaud message failed: %pe\n", ERR_PTR(err));
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
 
@@ -1085,9 +1104,7 @@ static int esd_usb_close(struct net_device *netdev)
 
 	close_candev(netdev);
 
-	kfree(msg);
-
-	return 0;
+	return err;
 }
 
 static const struct net_device_ops esd_usb_netdev_ops = {
@@ -1439,6 +1456,7 @@ static void esd_usb_disconnect(struct usb_interface *intf)
 	usb_set_intfdata(intf, NULL);
 
 	if (dev) {
+		dev->in_usb_disconnect = 1;
 		for (i = 0; i < dev->net_count; i++) {
 			if (dev->nets[i]) {
 				netdev = dev->nets[i]->netdev;
-- 
2.34.1


