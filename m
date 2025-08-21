Return-Path: <linux-can+bounces-4286-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F264B2FD47
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 16:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA295E5502
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1F02D9ECD;
	Thu, 21 Aug 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="EQVZRxVU"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021098.outbound.protection.outlook.com [52.101.65.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322B26D4F1;
	Thu, 21 Aug 2025 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786871; cv=fail; b=UUozz6Ef9p0WOJnd5UIbn4WH8xolXHhj/9Ym3V09W7AenxBHwAH+kGCzXeWIFVhlRXGhqFkn463T8CGpPu6SjTmZoCDeITRJwm4yPRNaOMMXmzB5wrCNb4l4eZddy4cUM9fcwacyLv3xGBOudjS2HkMIfRahsKncKnhf4tr9l6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786871; c=relaxed/simple;
	bh=gRKM3bGvh6URvzMjYgR6VikWRzFDqjJDJVWk3glsm7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVHSPFLaQ6EjwukXpcXm44pdnoAcG7UksNRk3WSJD3z/7X4E9RKCVf7C6U3MrRDr2g9d3CUy0qu+jRFTptFgcWtEHMnEAQ+eEaVZLjITbeayiBceraEAxVxzISvt1elO4bkAWjTArUxfXACEvcSoNoh/6gHHTGAd5Dh3HKslUu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=EQVZRxVU; arc=fail smtp.client-ip=52.101.65.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mK8GncDlQEg2ZPe54kzC8wGSGuZ6OxZ49g29oDRGd88mn3kftDqjfMimdKvmUqjtvQwPod/FCtPKGphwYlN8cIQkGvP3fzvLuBOuhSlcmt/3jVMa2Xp73TQQTezU3zckQjnOnMdQQf4QNpGoJEXqs8HbXokdzmkm85RkqrwtKjwXI/0n/uzgDKBT4JNQSdEN9ZdxbO+B9K29SWJ6iiPcbsjLBDBO+6nBQi0tbtqlL4SAatwDCOhNJToIFrZPF2qQzg9RHGaWcT7nGmQ8HOo3wSvlR+GYswe3g53MLJfcmZpJipto/5t2TzxZFqiH3kZkKhn6cUt0B6u0ycAZ5IjbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KK+eSIaDftlPiAH2dNafToUJ2nGk2w/ArRbYj0ELdoc=;
 b=R/k5xBHKWab9HK6o9hmbegFhGZacjBZGcuZczSikHpeyinaMkwILe2T26A1swlZH2yH2tT9BqXvEb9FjktytbR6S1gkRqP0SdYdFyFsl0gVe63da6LyVywKHTKO8IDWJVtSnmY92xXuLseDPOcnhqFdIChH6ShPQ6qu0555bVsuQv63aBF6PX1k0swHvKyKtQh1O0eLcqyNyQZxOWBCOpPgWfXvitkD1ispT7HutgCx0NoVn+8pUkDIT3TFIAIsKG4iF0whitvNb2kElFrf6fZXQFb9LhoENOViLddOxsrrbhdk9YBt5t4qrnrKyztFOkQUo23F7InzekWTfnVoi9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KK+eSIaDftlPiAH2dNafToUJ2nGk2w/ArRbYj0ELdoc=;
 b=EQVZRxVUzqdi454YH0T3M0fwhnqlRmVkuS8GnNzubKFC+O+3VMFS/PIe+uEhN2JClgquRr2suaZY4CvD+YPDJ9WcnshCv89tl6nYJPKQAP81wwRpD+fkFhH8ZSyaHknXJJjV2YSmI9Em+R4dLUyq29C+9DmVvhf3eQ7H64M2m6A=
Received: from DUZPR01CA0195.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::26) by AM9PR03MB7963.eurprd03.prod.outlook.com
 (2603:10a6:20b:43a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 14:34:24 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::d5) by DUZPR01CA0195.outlook.office365.com
 (2603:10a6:10:4b6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 14:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server id 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 14:34:22
 +0000
Received: from debby.esd.local (jenkins.esd [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 7DDFD7C1635;
	Thu, 21 Aug 2025 16:34:22 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 6D8E02EBFF4; Thu, 21 Aug 2025 16:34:22 +0200 (CEST)
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
Subject: [PATCH v2 1/5] can: esd_usb: Fix not detecting version reply in probe routine
Date: Thu, 21 Aug 2025 16:34:18 +0200
Message-Id: <20250821143422.3567029-2-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DE:EE_|AM9PR03MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: c6280fd8-a045-47af-2d6d-08dde0bfd25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|19092799006|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkJLYTVBamdzVThkRVNRUnRwVStwajNCa2F0RkJYN3hTTG95VWhmUDFyNEFt?=
 =?utf-8?B?aGRGYVpZck1Gc2xpMGtoZCthNUhVek9FTDNaaHdmZ0Y3SENoREN4V0s4L0Z5?=
 =?utf-8?B?MnF3RkFxL25sYjlJSlVMcnMxa2o0c1d1K2wzSEtOazBsNzkrTjY4MUNiVHJH?=
 =?utf-8?B?R0hNSk9VQlpDV3kzVnpST1lGUGF1NTJiUUZTOFFwN0N4SHkvSXVJVnluSVhE?=
 =?utf-8?B?RlZEVVl1RHIwY3BGNHVocS9FYmdXTE5WaHdSdEhvb05hWWVVbm9uc1c0ZlNB?=
 =?utf-8?B?OGtrczhTK0dSOXpDZU5vTDdBL2hIUXFIc2phT20rR2ZaazZtcWV2S25CNDhX?=
 =?utf-8?B?SlVyRTJzYkZYSXE5RmsvSHQvMCtvaXpOMEdYUjlTVHNFbjdOY2Ric3h4ZDZo?=
 =?utf-8?B?QnVFK3htc2FvZnFHSkg2c0NuK0pKcUVRN2NjQ1ROMm1pOE1iaS9pWlNhZnEw?=
 =?utf-8?B?cGRGWEsyYXE2eEptN29aajBtek5hakhxbUROaW1BWTZNNU9CMjRYQjV6Ym5l?=
 =?utf-8?B?Ym5tam9OTHR5YWR2YXVZL1Z0cG5zZVVkZWNDa3ozczJ2Y1ZOeVIzUER1VnE3?=
 =?utf-8?B?ZSsrKytSMmV6dVFjU1MyY3ZsdHBFejY2MmZ0TEQ5bDlpdFJTdm5neGhMRklM?=
 =?utf-8?B?c2hVdkJiRFVVckhPaTZEbE1ONm4vNmtCNjVQaytvMHlSa0hvQW5hRkErRE5h?=
 =?utf-8?B?elgyaTVIbmJjUlp3c0JsUXQrVTFxY1NCMDVvUVpzbjJ6Y2J0Z0RucVRZK0k2?=
 =?utf-8?B?OUs3UjA4ZUZDVHRod3dQSkp5UEY2V0U4Zm91NnBEWHlGTTFlOWVaK3NPUC9B?=
 =?utf-8?B?QklZTEdiSEJ0aThzcVpnNTZLOXdiY0RBWVNVdi9STlRrNWs2c1VRYitwaXBz?=
 =?utf-8?B?RDdtRm9ETVlLblFIenVPbnBDOVU2WjBtdEdWOVRtQVBuc2Y5dVM4c3JoR3ZY?=
 =?utf-8?B?Nk9oa3VwellWMW5lUGYxeDE1UVRvZlZqVkZaOGFsNCtubkZsV0hKYXJaanh3?=
 =?utf-8?B?OHdIc1NlYVJ2ZDRzSTExTk9DREFIdk0xaFlSWGp1ME5uaklUM0dIVFlPalVo?=
 =?utf-8?B?MHMwVnN4ZVYrbHJSTThuaUZKa0E2V3EwYWREWVJMT0NpR05QQVFXeS9MZ28y?=
 =?utf-8?B?bURUM3hKWENYZzhQWm1yVmpoM09NQXFmNVZWbkdhekYwRjBiVXJSTndzVjln?=
 =?utf-8?B?Qm1PeDRQTDVRdjBnZE85TnZKQW1nZlRYT0JBdnQyT2RLbHV3OUFMSzkyNGZk?=
 =?utf-8?B?WWZ0UEpmc0tqR2RPUlNUKzRyMFBrQ3dIZUtPUEdPeVVLKzZtMG9WMWE0Umh3?=
 =?utf-8?B?N1hneW1xQjN1NWxuN3hla1g4Q00zVXZmSVNZejlIc2NqSjIxeHFTQStWU3NS?=
 =?utf-8?B?aEhXUktjTGx0UjNCRFpHQWducGl4NHN1U1ZvYXBEckxBSTJnaEdmVXBNQzY5?=
 =?utf-8?B?Zm8vRFBmKzFUcW9ySWFVS2pXcWNFUy9iMkpvWXlLMTcwYUhQQStpdVNtR0ZI?=
 =?utf-8?B?NDVaeUFVNnF4b1hiOUhPZkVTaC9nVElVV09KbGc2bHBLTmU0YTlxNmVOR1NQ?=
 =?utf-8?B?Q0dTZWZ0RjMwd041WWs4K01JU0lzeG9pRFp4WjFrZXVRaWwxZFpncDExWlpR?=
 =?utf-8?B?UzFyY1V5S0IvTFdOek1HZm9MdTc5QVo3aThqU3M0SmczTkZNVmdrRzhXRGZL?=
 =?utf-8?B?c2NSRGJvSmFMZFFPVnpYRktpcHBjbVkyaCtCVzVvQkdRMUpZZ1dUNWlNWXQr?=
 =?utf-8?B?QUxxQ002RTRvazZ5RWlvWnEyODB2c3pIV0R0Q0JQc0NpTDNQZVByMTF2NWhK?=
 =?utf-8?B?MFlRbFF3aDZzMHcvdzFBNEx0RXFpdFBmenNxZjBvUTN2blhnZXlnWTU2MDJZ?=
 =?utf-8?B?dUpRcTYwcHF2ckNqYTRuQXJkcmlLN0ZOM2grR2NiMTlROGd4bjRTZzVJaENU?=
 =?utf-8?B?Ujg0bTVWM0NsL0ozZkhCOStsUlg2SFFheHNwTnBsbWkyeXJvWGVrR3pIL2Yx?=
 =?utf-8?B?b1djbkVLU2k5NzdQbEpYaldlbE92dGtIRy85cnNqRWdSWDhBR20zbVRJcTZV?=
 =?utf-8?Q?1P/HAH?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(36860700013)(376014)(19092799006)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:34:22.8100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6280fd8-a045-47af-2d6d-08dde0bfd25e
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7963

This patch fixes some problems in the esd_usb_probe routine that render
the CAN interface unusable.

The probe routine sends a version request message to the USB device to
receive a version reply with the number of CAN ports and the hard-
& firmware versions. Then for each CAN port a CAN netdev is registered.

The previous code assumed that the version reply would be received
immediately. But if the driver was reloaded without power cycling the
USB device (i. e. on a reboot) there could already be other incoming
messages in the USB buffers. These would be in front of the version
reply and need to be skipped.

In the previous code these problems were present:
- Only one usb_bulk_msg() read was done into a buffer of
  sizeof(union esd_usb_msg) which is smaller than ESD_USB_RX_BUFFER_SIZE
  which could lead to an overflow error from the USB stack.
- The first bytes of the received data were taken without checking for
  the message type. This could lead to zero detected CAN interfaces.

To mitigate these problems:
- Moved the code to send the version request message into a standalone
  function esd_usb_req_version().
- Added a function esd_usb_recv_version() using a transfer buffer
  with ESD_USB_RX_BUFFER_SIZE. It reads and skips incoming "esd_usb_msg"
  messages until a version reply message is found. This is evaluated to
  return the count of CAN ports and version information.
- The data drain loop is limited by a maximum # of bytes to read from
  the device based on its internal buffer sizes and a timeout
  ESD_USB_DRAIN_TIMEOUT_MS.

This version of the patch incorporates changes recommended on the
linux-can list for a very first version.

References:
https://lore.kernel.org/linux-can/d7fd564775351ea8a60a6ada83a0368a99ea6b19.camel@esd.eu/#r

Fixes: 80662d943075 ("can: esd_usb: Add support for esd CAN-USB/3")
Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/esd_usb.c | 145 ++++++++++++++++++++++++++--------
 1 file changed, 110 insertions(+), 35 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 27a3818885c2..fb0563582326 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -3,7 +3,7 @@
  * CAN driver for esd electronics gmbh CAN-USB/2, CAN-USB/3 and CAN-USB/Micro
  *
  * Copyright (C) 2010-2012 esd electronic system design gmbh, Matthias Fuchs <socketcan@esd.eu>
- * Copyright (C) 2022-2024 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
+ * Copyright (C) 2022-2025 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
  */
 
 #include <linux/can.h>
@@ -44,6 +44,9 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_CMD_TS			5 /* also used for TS_REPLY */
 #define ESD_USB_CMD_IDADD		6 /* also used for IDADD_REPLY */
 
+/* esd version message name size */
+#define ESD_USB_FW_NAME_SZ 16
+
 /* esd CAN message flags - dlc field */
 #define ESD_USB_RTR	BIT(4)
 #define ESD_USB_NO_BRS	BIT(4)
@@ -95,6 +98,7 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB_RX_BUFFER_SIZE		1024
 #define ESD_USB_MAX_RX_URBS		4
 #define ESD_USB_MAX_TX_URBS		16 /* must be power of 2 */
+#define ESD_USB_DRAIN_TIMEOUT_MS	100
 
 /* Modes for CAN-USB/3, to be used for esd_usb_3_set_baudrate_msg_x.mode */
 #define ESD_USB_3_BAUDRATE_MODE_DISABLE		0 /* remove from bus */
@@ -131,7 +135,7 @@ struct esd_usb_version_reply_msg {
 	u8 nets;
 	u8 features;
 	__le32 version;
-	u8 name[16];
+	u8 name[ESD_USB_FW_NAME_SZ];
 	__le32 rsvd;
 	__le32 ts;
 };
@@ -625,17 +629,106 @@ static int esd_usb_send_msg(struct esd_usb *dev, union esd_usb_msg *msg)
 			    1000);
 }
 
-static int esd_usb_wait_msg(struct esd_usb *dev,
-			    union esd_usb_msg *msg)
+static int esd_usb_req_version(struct esd_usb *dev)
 {
-	int actual_length;
+	union esd_usb_msg *msg;
+	int err;
 
-	return usb_bulk_msg(dev->udev,
-			    usb_rcvbulkpipe(dev->udev, 1),
-			    msg,
-			    sizeof(*msg),
-			    &actual_length,
-			    1000);
+	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->hdr.cmd = ESD_USB_CMD_VERSION;
+	msg->hdr.len = sizeof(struct esd_usb_version_msg) / sizeof(u32); /* # of 32bit words */
+	msg->version.rsvd = 0;
+	msg->version.flags = 0;
+	msg->version.drv_version = 0;
+
+	err = esd_usb_send_msg(dev, msg);
+	kfree(msg);
+	return err;
+}
+
+static int esd_usb_recv_version(struct esd_usb *dev)
+{
+	/* Device hardware has 2 RX buffers with ESD_USB_RX_BUFFER_SIZE, * 4 to give some slack. */
+	const int max_drain_bytes = (4 * ESD_USB_RX_BUFFER_SIZE);
+	unsigned long end_jiffies;
+	void *rx_buf;
+	int cnt_other = 0;
+	int cnt_ts = 0;
+	int cnt_vs = 0;
+	int len_sum = 0;
+	int attempt = 0;
+	int err;
+
+	rx_buf = kmalloc(ESD_USB_RX_BUFFER_SIZE, GFP_KERNEL);
+	if (!rx_buf)
+		return -ENOMEM;
+
+	end_jiffies = jiffies + msecs_to_jiffies(ESD_USB_DRAIN_TIMEOUT_MS);
+	do {
+		int actual_length;
+		int pos;
+
+		err = usb_bulk_msg(dev->udev,
+				   usb_rcvbulkpipe(dev->udev, 1),
+				   rx_buf,
+				   ESD_USB_RX_BUFFER_SIZE,
+				   &actual_length,
+				   ESD_USB_DRAIN_TIMEOUT_MS);
+		dev_dbg(&dev->udev->dev, "AT %d, LEN %d, ERR %d\n", attempt, actual_length, err);
+		++attempt;
+		if (err)
+			goto bail;
+		if (actual_length == 0)
+			continue;
+
+		err = -ENOENT;
+		len_sum += actual_length;
+		pos = 0;
+		while (pos < actual_length - sizeof(struct esd_usb_header_msg)) {
+			union esd_usb_msg *p_msg;
+
+			p_msg = (union esd_usb_msg *)(rx_buf + pos);
+
+			pos += p_msg->hdr.len * sizeof(u32); /* convert to # of bytes */
+			if (pos > actual_length) {
+				dev_err(&dev->udev->dev, "format error\n");
+				err = -EPROTO;
+				goto bail;
+			}
+
+			switch (p_msg->hdr.cmd) {
+			case ESD_USB_CMD_VERSION:
+				++cnt_vs;
+				dev->net_count = min(p_msg->version_reply.nets, ESD_USB_MAX_NETS);
+				dev->version = le32_to_cpu(p_msg->version_reply.version);
+				err = 0;
+				dev_dbg(&dev->udev->dev, "TS 0x%08x, V 0x%08x, N %u, F 0x%02x, %.*s\n",
+					le32_to_cpu(p_msg->version_reply.ts),
+					le32_to_cpu(p_msg->version_reply.version),
+					p_msg->version_reply.nets,
+					p_msg->version_reply.features,
+					ESD_USB_FW_NAME_SZ, p_msg->version_reply.name);
+				break;
+			case ESD_USB_CMD_TS:
+				++cnt_ts;
+				dev_dbg(&dev->udev->dev, "TS 0x%08x\n",
+					le32_to_cpu(p_msg->rx.ts));
+				break;
+			default:
+				++cnt_other;
+				dev_dbg(&dev->udev->dev, "HDR %d\n", p_msg->hdr.cmd);
+				break;
+			}
+		}
+	} while (cnt_vs == 0 && len_sum < max_drain_bytes && time_before(jiffies, end_jiffies));
+bail:
+	dev_dbg(&dev->udev->dev, "RC=%d; ATT=%d, TS=%d, VS=%d, O=%d, B=%d\n",
+		err, attempt, cnt_ts, cnt_vs, cnt_other, len_sum);
+	kfree(rx_buf);
+	return err;
 }
 
 static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
@@ -1273,13 +1366,12 @@ static int esd_usb_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
 {
 	struct esd_usb *dev;
-	union esd_usb_msg *msg;
 	int i, err;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
 		err = -ENOMEM;
-		goto done;
+		goto bail;
 	}
 
 	dev->udev = interface_to_usbdev(intf);
@@ -1288,34 +1380,19 @@ static int esd_usb_probe(struct usb_interface *intf,
 
 	usb_set_intfdata(intf, dev);
 
-	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
-	if (!msg) {
-		err = -ENOMEM;
-		goto free_msg;
-	}
-
 	/* query number of CAN interfaces (nets) */
-	msg->hdr.cmd = ESD_USB_CMD_VERSION;
-	msg->hdr.len = sizeof(struct esd_usb_version_msg) / sizeof(u32); /* # of 32bit words */
-	msg->version.rsvd = 0;
-	msg->version.flags = 0;
-	msg->version.drv_version = 0;
-
-	err = esd_usb_send_msg(dev, msg);
+	err = esd_usb_req_version(dev);
 	if (err < 0) {
 		dev_err(&intf->dev, "sending version message failed\n");
-		goto free_msg;
+		goto bail;
 	}
 
-	err = esd_usb_wait_msg(dev, msg);
+	err = esd_usb_recv_version(dev);
 	if (err < 0) {
 		dev_err(&intf->dev, "no version message answer\n");
-		goto free_msg;
+		goto bail;
 	}
 
-	dev->net_count = (int)msg->version_reply.nets;
-	dev->version = le32_to_cpu(msg->version_reply.version);
-
 	if (device_create_file(&intf->dev, &dev_attr_firmware))
 		dev_err(&intf->dev,
 			"Couldn't create device file for firmware\n");
@@ -1332,11 +1409,9 @@ static int esd_usb_probe(struct usb_interface *intf,
 	for (i = 0; i < dev->net_count; i++)
 		esd_usb_probe_one_net(intf, i);
 
-free_msg:
-	kfree(msg);
+bail:
 	if (err)
 		kfree(dev);
-done:
 	return err;
 }
 
-- 
2.34.1


