Return-Path: <linux-can+bounces-4975-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0192B9B0FD
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 19:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370714C0361
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765C23164C4;
	Wed, 24 Sep 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="VDYH3/mn"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021138.outbound.protection.outlook.com [52.101.70.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447C313E0D;
	Wed, 24 Sep 2025 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735045; cv=fail; b=Pzz7Flo8UnY3Cr4bE0kXyNYN9qFLxnuYmVkIGmq/B0TE2j2R5CVMMIdo2e6jULx9fM5Q8H7kBaW2J9hORTp5WPW/9iQTTiQPoVicFpaeU9IQUgw8/6GUuaqdU1wQXSw6djIJWJ9bo+4ArI7fEelZv9mOTYrtP8n2698TwD9T8CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735045; c=relaxed/simple;
	bh=ecYbGq63K/WyjVbKAGLlPrJYwdZwT2U39x/RVU7WF/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9GQF8/uZ5Qmxez95yF+exCiEpHbbRwLf2KoaJRTkQe6P5qiR/N2IGViW601WXR6hk6BCZBdbRgSZ6q/cO21puheSBY5Fc5WjGZOC1e5T2TCA+f4OuXTB3nPt80QBAN9sWB31wopoRgDr24dUJTFXhxDRjYe9mO6pxt2a3qPRuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=VDYH3/mn; arc=fail smtp.client-ip=52.101.70.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRy6moxIO+XMH01Q3iM+CjDm3G4lR5B4XTCPvFFfEXpSmGCPGGv6a7DiMgQQWK2lUUB7j6ZHXzz1W2+GzSA0ED9Tk2lk9rlBX/EdjBrCiAJREAo6pLGdRJ5HiRGTnNSvc8Yng5IcE5ixyz5zFOs0j3RQeR1NIKGZ+l+NXraqDUiV2KMYxdffsnlIKFdKkOSU5fs9+nKUSjRlpVE/pPZ5ry3/4O714/xShKb9k0nZGn+TTp88dFwwVUPxR54EaelhQ+rWSlB2AXmGTXjIkRSGd6yD/ZwA6CH2J007hEUfsdb3HEwNADOdgjo9zzGCygpzsdpQHv+QOmjuPjgL0sbEJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2Rm1cYTroGyzhTE3E1ObYG1r12WCrAFc6JGbuFNQAQ=;
 b=yeNtTcqHqcY21GvEzm7kpA1nnd57sco1DHFHxt7LEEC8Wgo65qtbe7CgoVEqb9hwmoZOTraUZ7dUgAFSINzl9gMGlzUo+OExu5QImrLgzHRwVvjqMbjmChwMjE89cT5wk3Gg+gJ55EuHXXByLjfYdTWD8YnzA/p3JOWicuqJ7PdCYFwTTAvCfUdPIVL+ZTmN7jnvQSEHnBET12SxVPwF5NUr7gjPggKM8QBugRvBkoY48oglZmZPZR5EC3PQ5lguMdjbwB/QUnrDBXCbsyIspc+xu4i6zTdQTnimpPIsbYlH/MqLJJA7IH5W8L8iLzcEUEyl5nsMh6BvlqS4n8NAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2Rm1cYTroGyzhTE3E1ObYG1r12WCrAFc6JGbuFNQAQ=;
 b=VDYH3/mnCQBj2OPuFrT3ZY0CF085nC0LaXKWczwh1hqR+A+zB2zBZjoGwgAPSYe966h0a8f+hVNGQPll5brz0qteqNs2P6SHOtqsmt4pnErXWczdnQDIHIe9E7mo3Y9ZFycSEUu5+Ir36fe7t+YawNlOcZF25jEy5ARB348ZQJQ=
Received: from DU2PR04CA0338.eurprd04.prod.outlook.com (2603:10a6:10:2b4::8)
 by PAWPR03MB10003.eurprd03.prod.outlook.com (2603:10a6:102:35a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 17:30:37 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::84) by DU2PR04CA0338.outlook.office365.com
 (2603:10a6:10:2b4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 17:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server id 15.20.9137.12 via Frontend Transport; Wed, 24 Sep 2025
 17:30:36 +0000
Received: from debby.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id E1B457C16C5;
	Wed, 24 Sep 2025 19:30:35 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id D3B1A2E25B3; Wed, 24 Sep 2025 19:30:35 +0200 (CEST)
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
Subject: [PATCH v3 1/3] can: esd_usb: Fix not detecting version reply in probe routine
Date: Wed, 24 Sep 2025 19:30:33 +0200
Message-Id: <20250924173035.4148131-2-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|PAWPR03MB10003:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f46a69-828a-4040-0c99-08ddfb9012ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2JOOFdGM0MzMzZvaDMzMklGc0xkUG83YW14dVY5d2JRVFZzWFA3R2RhNHdw?=
 =?utf-8?B?My9HNEovYVZ5QmlGbjR1RklKQVVCM2srQ3RWY25SdXZJS1RwcEEzcmMzdVY3?=
 =?utf-8?B?QVYzTUFKTW9FU05tSGVzQmxYdDlndlVnVGw2VWZhVzBwbmF5YzhpdEVGRHBU?=
 =?utf-8?B?U3NEcUVpa0Q1VytDdEc3U1dVbHQ1MXdhQ2RDUWFSa1NxK3NUQnZwU3Q3MlB4?=
 =?utf-8?B?V3cwVGJQd0FVM1hYR1BQc3RXbFJaMkZyUHRQTDhCeVZZY0xsTkx4MEFPMXJs?=
 =?utf-8?B?cEpnU2llZ0lldWF2SHQxUElMYTNjazRKRThJUmJBZnpnaUJFbER0Z1pxdHov?=
 =?utf-8?B?N1FpSFduMitoQUJiSkZmUmpOcHNTSzhkVkRoazhqVkxwOXIyRTNwL0U3bjQ5?=
 =?utf-8?B?UWQvUEFoaFlCV1crR29FbFF3YTUyUzZRQytZTGV4ajRBOXlkT2dXVDYvaDdi?=
 =?utf-8?B?YitLcERxa0Jmc1JtSlUxNlA2clk5a2xma08vcmxqOHhhcFpyMnJJNWZDSHI4?=
 =?utf-8?B?ZlBjbzk2cENvZCtRTzZzcm1yTk9Fa2hIQ0pnTGtIa2lPbTArOHhuRVU5UmE3?=
 =?utf-8?B?Vzg4THJXcUFKWEdSUUlIcE1xSTRDOTNibFFsemE3b1VzVVg2akl6djFFelVm?=
 =?utf-8?B?MlhRTzRDM3ZSamlOUnNOeUdxNlExM1Y4NUZ0M25vMXJvdWVXemNsTm96dTFY?=
 =?utf-8?B?bXdFejBrSjloQVRFdjlveDVJUGRvVElFcEpMaUIvVTN2eWdmWUh5ODhUR211?=
 =?utf-8?B?eWtMV3BJdzdEcDEzK2pDQVo4c2Qxdm1BZlFtL2Q1UW5Tdkx6SmY2SlFoMzA5?=
 =?utf-8?B?VWhDdDZlbFk1aURBbVN0TzE3ZVpza2swdmIxMWdyNXFDaS9scmMwdjd3aFd6?=
 =?utf-8?B?ZnU1OWtqcDlIVU4zSU9sakpKZ004VnRrelA3VHAxay9uK09HYUxlQ2JMaC9L?=
 =?utf-8?B?ZjJRTWFwbVRVT2ZkL1pwcEJLYSs1UTI0ZDRSdjhSY2M4SXVPUVNrTndHZTll?=
 =?utf-8?B?RVVZMTk2WW85QzFvVkFJZTF0T2RHSGQ4cWVjazR3ZnYxVzVwQWFNcUt3RXJt?=
 =?utf-8?B?eU1LdWk3b3R6VTlEVzBrYUFqNWhBTXZKeHdXek1FRHBqTnZZd2RSM3ZMOGRh?=
 =?utf-8?B?YlRqR0tSTmhZQVlIVGJ2T25OOFh3dFkxOE9tcUdRL2FkdEwvRTUyR0xMbTJy?=
 =?utf-8?B?TzVSVk8xc0RTU2EycUhTaHVTRXQ1UzUxTWhGMi9IUUxPaks1Qm0yVWtMUDlo?=
 =?utf-8?B?WHMvbEVxOFVOaUJub2QrdUxZLzh3TjlFYXdOTVhESHB3OTV6TENkQ1d2ckNi?=
 =?utf-8?B?V1pCSjNheXRJMWRNMmw1QStFWXZEMU5BaUxFRHMrNW5ReFNYekZiaGhjdWsx?=
 =?utf-8?B?SDlBS3FlQXhTSDhCek9Jd0orSWxLdFNCWFJMcEMrelRpOUU1QktRWmYxZEdP?=
 =?utf-8?B?L1ZpTnZ6RUh3YkFSZUJNZWI1VTZEbU1jSVJ4NEh0NVBSdWRJd21WVGJiWWor?=
 =?utf-8?B?U0svNmVEVmkrT0MrR0FTVFhQdzQvWXJxYjFJUTc2ejExOXBOZ2c5UEdhbWha?=
 =?utf-8?B?WjVjZHhicE80MVdjaTNXVWN3N2FtWGJ4V3JnSytGRHdRb01kR3kwYTJCWG5h?=
 =?utf-8?B?Q1dUS2UyaUtKTzNYZHVaZW1makYweE5QK1VVaWxodUN3S29sODdRVTNuR0M4?=
 =?utf-8?B?RWNpNm1SSVRzSFZlYmFhWW1RdXlIQk5zeURBMU5Sc2xndWgvTTI4QmpqLzds?=
 =?utf-8?B?Z0RqZnJlOVFKQTlUWkZKU1NnamJ2OVpDOCtnT1lBZWplbGkwT3hBa2VxMXYv?=
 =?utf-8?B?T0plWW1Tbkt0azB2dzVPZGZIcGcyMjB5TTlvd1FveHhZWWx1c1RYNFZwaGxV?=
 =?utf-8?B?bXQ1L3BDUXd3YmNHdU82MkhxVEkxdDNNMlhhYzZzTkF6YlYyMDZSdld6YkYy?=
 =?utf-8?B?USs3RjQvSFpGUTR6a3FMSHVibWlUWlFwVjZoQ3NaZEdPSDU0c3gzL1BOOCtU?=
 =?utf-8?B?VC9KdG1YTjNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(19092799006)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 17:30:36.2668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f46a69-828a-4040-0c99-08ddfb9012ae
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB10003

This patch fixes some problems in the esd_usb_probe() routine that render
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
- Move the code to send the version request message into a standalone
  function esd_usb_req_version().
- Add a function esd_usb_recv_version() using a transfer buffer
  with ESD_USB_RX_BUFFER_SIZE. It reads and skips incoming "esd_usb_msg"
  messages until a version reply message is found. This is evaluated to
  return the count of CAN ports and version information.
- The data drain loop is limited by a maximum # of bytes to read from
  the device based on its internal buffer sizes and a timeout
  ESD_USB_DRAIN_TIMEOUT_MS.

This version of the patch incorporates changes recommended on the
linux-can list for a very first version [1].

[1] https://lore.kernel.org/linux-can/20250203145810.1286331-1-stefan.maetje@esd.eu

Fixes: 80662d943075 ("can: esd_usb: Add support for esd CAN-USB/3")
Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Link: https://patch.msgid.link/20250821143422.3567029-2-stefan.maetje@esd.eu
[mkl: minor change patch description to imperative language]
[mkl: squash error format changes from patch 4]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/esd_usb.c | 149 +++++++++++++++++++++++++---------
 1 file changed, 112 insertions(+), 37 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 27a3818885c2..ed1d6ba779dc 100644
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
-		dev_err(&intf->dev, "sending version message failed\n");
-		goto free_msg;
+		dev_err(&intf->dev, "sending version message failed: %pe\n", ERR_PTR(err));
+		goto bail;
 	}
 
-	err = esd_usb_wait_msg(dev, msg);
+	err = esd_usb_recv_version(dev);
 	if (err < 0) {
-		dev_err(&intf->dev, "no version message answer\n");
-		goto free_msg;
+		dev_err(&intf->dev, "no version message answer: %pe\n", ERR_PTR(err));
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


