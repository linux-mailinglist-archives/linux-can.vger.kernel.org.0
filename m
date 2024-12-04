Return-Path: <linux-can+bounces-2338-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ACE9E3FBC
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 17:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D0BB61607
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7D614375C;
	Wed,  4 Dec 2024 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="Aq57I73U"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2106.outbound.protection.outlook.com [40.107.105.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA658215F50
	for <linux-can@vger.kernel.org>; Wed,  4 Dec 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328409; cv=fail; b=UZemaskYinsGmmpFivBwmujtvzXsAcYCNzfNmVlqkmgIbcuO2AJSraJeblOqMi/F49N3Gbb7UJdeGIEQdbuVdodpLhe1PTgJB3bGwT5M1qlUarV6nqQg82zgTIpDCcjIsqZO57YNSSHnf+8OO8X31Th8ZIdx/at5WBmEh1SsNzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328409; c=relaxed/simple;
	bh=Gfcn15Rx7e1hWjbAutOK0x0oh5mrngdzTyFK5Vmhzl0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyCnZ8DBkovfnkenfzES3yQPKsKBNEahELWvAEkSZ6XlioQYxz62JZ0pYOsLt/UkLuhBXJe+g8i21AzWgPJSAKcck0zD6Fs4qmZVayIwuRyob3geNnpT6MU7xq1N7FKjWnD3nFowU6NUsr2Nh32DGoKAaR+zwVJ90wIAUODfwaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=Aq57I73U; arc=fail smtp.client-ip=40.107.105.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BU+UR+KKbU7Cgdk7ZlCZ4pKEaqcnogtVkyQUoTu303JUiFkGKF4dnHIQXXtgxaJNxVUweXkCgwRXY5M48ExBn28hI+Nb638MKf61lda+XhlUH2fhojKChhJZHbh6tNtBzC3JQOFfc1T1fKn3r6aUmgUSHcvv3COYxTBEzPfnsCi3f2Z8Y3+XvXVJA3FhBWtmagE3UVsRQ/hZeglNIVES0lwvLe0GHPp08HNcsfPHugaEY8vDL43AAbsiLiCB5Qn8m0W7MzLcTl2ZrQe8bZTrRkjrwm/Z09gry5+3ZOlQCcpFJ9jRETI66ej6S1yFSh8LA7IRGX6vsiMlLNj5RmQAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gW4tFnMmESfAc8XKt2lGSYCG6Nf6OoAnof6JH1hvdLc=;
 b=CnHxO1dvgyVxtoF1t+c69b7xnYBI1tsnRgFRBVFvGRZsjY5r6wMFB2CL7JaGjcDrEDn8woR+6mMPkBDaChAC1DmqfBjjCu5sqZpjHPaLOUm3dYY02IQkX0rscGjbyFV9m+Xx9yzGLlFK2BnlzCMpCCDtabB/AWidN386XUDsX02OuBHHY7Ufn6XDThSzrT2TJuUiH7ADEWH/199bXLGN4qLZjuiJB2eoGR531MKIhShO7qO9ndb0CKmIPTr6Y+Jpu6P3C3NfPqjiUlPZuTYQxyDrQFMcqBT9NAmTGWMGRzGvGGMcxv0Fzrjn10xJuBFi+QN84WfUbHmWWjTU5kgtcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=esd.eu smtp.mailfrom=esd.eu; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW4tFnMmESfAc8XKt2lGSYCG6Nf6OoAnof6JH1hvdLc=;
 b=Aq57I73UnwWMrBBZwPQtcfMuEugwVjAgG6CaAiEFKYLQnq4JPVJWF1+6CTUq8vIf4eIPWHlT/8t6fC1KUt11Wmvb3l6glFD4DcUjYcR6YrYGoiHwNYq68Q0US6kenroTrGPVytQjs8pR+aolxPo8ePR1zlPt4MBUlbHk8+P6Y54=
Received: from DB7PR02CA0005.eurprd02.prod.outlook.com (2603:10a6:10:52::18)
 by AM7PR03MB6231.eurprd03.prod.outlook.com (2603:10a6:20b:142::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 16:06:41 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:52:cafe::e3) by DB7PR02CA0005.outlook.office365.com
 (2603:10a6:10:52::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Wed,
 4 Dec 2024 16:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server id 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 16:06:40
 +0000
Received: from debby.esd.local (jenkins.esd.local [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 62CAB7C16C8;
	Wed,  4 Dec 2024 17:06:40 +0100 (CET)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 5781E2E189C; Wed,  4 Dec 2024 17:06:40 +0100 (CET)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Frank Jungclaus <frank.jungclaus@esd.eu>,
	linux-can@vger.kernel.org
Subject: [RFC PATCH 1/1] can: esd_usb: Fix not detecting version reply in probe routine
Date: Wed,  4 Dec 2024 17:06:40 +0100
Message-Id: <20241204160640.884578-2-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241204160640.884578-1-stefan.maetje@esd.eu>
References: <20241204160640.884578-1-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922F:EE_|AM7PR03MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8656ab-7661-45ce-ef9d-08dd147da3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkFNNUt1TzBQRlNaajNmWHExUkd2cG1jUjV1MUNhRjhaU1o3SVYzY25kVjVI?=
 =?utf-8?B?ZTlXUFJCNGN0cTJ0ZmVHbElnY0Rhd1N4SXB3NXdsaXVWYTJaZTNNblo1bzNL?=
 =?utf-8?B?YVZacEE4OGVObTdsSm1JVGQwTGJsN3l1cWNOK1lJZnpvTWJCU3k2SkNBT2p5?=
 =?utf-8?B?cWdtVlJUNXdzL1B4NTRZZm5PTk1QNFZuOUg5aW9zVXFvYmgvR1dQMjFNSmU3?=
 =?utf-8?B?TzUzbVFxbWlPWWhjeFd0LzBZenFzeDVsUDBURk9QYXg3ZGEySHJ6K240SVlX?=
 =?utf-8?B?RFJRSGVMaXdzVERBcXBDNnhtZVU4SUdVdDkvajlhWjc1eFY4Mm1XRFlydllN?=
 =?utf-8?B?N0xYamJZMHhYSlRUVDVEQllMRytkVVRDVlR3cWZPcmE1WWNFNG5lc0k0aHNX?=
 =?utf-8?B?R1BRZ3U5UkpvSjRDTFI3NzRKd0puYkVEb3dadkV6SVBUUXZrajR2djZzQ05o?=
 =?utf-8?B?cjVJUC9VWXg4MkNaZy9EZTQ5N0NmSVk2dFZUQXVtVWpCZVExZVNnN0VqN1Mz?=
 =?utf-8?B?cExZQzZZQlV4bEpjcVNrWmdsaDBzRmxRWmNWUkhab2c1ZkhjUEwzK0FQU2pZ?=
 =?utf-8?B?ZitPRXZHMHJROFprSHh3Tm5Gd0NtUTZaOXp1VHh0L29ObXozZ3JEZmVtWkFP?=
 =?utf-8?B?VS9XdHM3ZFB2Y3E1T2R3VnpKb2djS21CQ0twU3VjcndrMXM2dEt3TzduMTcz?=
 =?utf-8?B?dVNtcG9hd29aSVVpRGNCam8zaUcvWjRucGNxbzEydHJpaHVMTGQ1N3N6NEJ5?=
 =?utf-8?B?YUpuOWJldy8rTGZUSUtMU1VYbU83MThSd1VxMmV3bjVORUQ5NGhSdFJXMm1q?=
 =?utf-8?B?Y2VnYW5OR2JxSUhDWU4weEMwNG9lbHJya3lsQ1V0SmRIMUpyVVhONFpyZXNj?=
 =?utf-8?B?QksrczZESEsyOTZYeDhJWW5zOWIvWmhZZGZXZlBJUTRlbDFuVUk1N3pRamVK?=
 =?utf-8?B?b2pMcVoxY25iczhwL3A2RVBFTUNJZDRNL0Q1YUNVRS9LOC9IbWJtYlZNZjRv?=
 =?utf-8?B?NHZyVVhrMWovRGNUOE8vNWdOZ0ZLc1BCNXJXakxzVkNKN2dEaEcwY2s3ZXJw?=
 =?utf-8?B?dVFEOG95NDNLNXRQdzlrNUlEQ1AxN0ZCWjd3RWp4Vkw3dlhKckNyam1WUzBq?=
 =?utf-8?B?TDV6WDBtdGR3eEhzSnZHUnM1UFlISEdpeXhpeDgyaGVxRTMzdWdpTVRXQVR2?=
 =?utf-8?B?M1orQlR1bXhFQ0UrT1B6ZU5wV29jMUZJNkNSbmR5ZXYyMVZ6elpyN2x0UER0?=
 =?utf-8?B?dnVaN3BHMG5TTXNaY1RMQkpoWmYrS05ObXNaS3JlZWFnS3lKYUNHc3FGL1FM?=
 =?utf-8?B?NGVxUDNPelB6RU9zWDhSZnB2ZitmbG8wbk9HUWp3MWtLSmlsUWpWWmNQMlJt?=
 =?utf-8?B?ankza1FLc1hWOTBmMWxZMXBTek1zTzZlcWsybktiSGpJNDQ1Y09RMkRERGpR?=
 =?utf-8?B?cks2dGJ3b1RIZ2lUQjE3ZllVOHozdWdWS2JZOXU2YmVWeWRzclB3Y21TWTNQ?=
 =?utf-8?B?UVZWeFE2VHFtZnFoWGNFN0pmNUJpc0tmZ1YvbEY4dEVXRWxuUy9sL3lVZ0xh?=
 =?utf-8?B?YjBkTEJGTTBvMWU2WjdKUzA5RWhvdlp3dm0wZTQ4TVNxS2huOE04U1ArRmpy?=
 =?utf-8?B?blhEU0N5V3VqZmJrTEpody94cE9sZkdmZFRvTnVySFQ1eWxtZm1HNUh5dnpO?=
 =?utf-8?B?R3Z2YkZDdnhxcFNaMkJTbEFPaTF5LzdGNHNoUlF2alhwMTdlWDUyYTRnQ29M?=
 =?utf-8?B?bmwvQTFaS0J2SFg1ZCtuWVFPNmZBVml1WGF3VW50Z2wyeHhOd2l0SE0wWHJa?=
 =?utf-8?B?QzAyNE1USHVFdVoxVU14T2lucyt4ejczVkFnSDNGZ29VUnQ4YzBmN0N5Zksy?=
 =?utf-8?B?QmVZUVRuM2xVSVhFVWIvaTBvZTFGVmxlYVJqVHJYbTM5UDNmNUQxaTdzd3pt?=
 =?utf-8?Q?ahD/Z75NUxwweV83f5dgU5lHKJtDQosB?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:06:40.8174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8656ab-7661-45ce-ef9d-08dd147da3dc
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6231

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
- On kmalloc() fail for the "union esd_usb_msg msg" (i. e. msg == NULL)
  kfree() would be called with this NULL pointer.

To mitigate these problems:
- Use a transfer buffer "buf" with ESD_USB_RX_BUFFER_SIZE.
- Fix the error exit path taken after allocation failure for the
  transfer buffer.
- Added a function esd_usb_recv_version() that reads and skips incoming
  "esd_usb_msg" messages until a version reply message is found. This
  is evaluated to return the count of CAN ports and version information.

Fixes: 80662d943075 ("can: esd_usb: Add support for esd CAN-USB/3")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/esd_usb.c | 122 +++++++++++++++++++++++++---------
 1 file changed, 92 insertions(+), 30 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 03ad10b01867..a6b3b100f8ac 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -625,17 +625,86 @@ static int esd_usb_send_msg(struct esd_usb *dev, union esd_usb_msg *msg)
 			    1000);
 }
 
-static int esd_usb_wait_msg(struct esd_usb *dev,
-			    union esd_usb_msg *msg)
+static int esd_usb_req_version(struct esd_usb *dev, void *buf)
+{
+	union esd_usb_msg *msg = buf;
+
+	msg->hdr.cmd = ESD_USB_CMD_VERSION;
+	msg->hdr.len = sizeof(struct esd_usb_version_msg) / sizeof(u32); /* # of 32bit words */
+	msg->version.rsvd = 0;
+	msg->version.flags = 0;
+	msg->version.drv_version = 0;
+
+	return esd_usb_send_msg(dev, msg);
+}
+
+static int esd_usb_recv_version(struct esd_usb *dev,
+				void *rx_buf,
+				u32 *version,
+				int *net_count)
 {
 	int actual_length;
+	int cnt_other = 0;
+	int cnt_ts = 0;
+	int cnt_vs = 0;
+	int attempt;
+	int pos;
+	int err;
 
-	return usb_bulk_msg(dev->udev,
-			    usb_rcvbulkpipe(dev->udev, 1),
-			    msg,
-			    sizeof(*msg),
-			    &actual_length,
-			    1000);
+	for (attempt = 0; attempt < 8 && cnt_vs == 0; ++attempt) {
+		err = usb_bulk_msg(dev->udev,
+				   usb_rcvbulkpipe(dev->udev, 1),
+				   rx_buf,
+				   ESD_USB_RX_BUFFER_SIZE,
+				   &actual_length,
+				   1000);
+		if (err)
+			break;
+
+		err = -ENOENT;
+		pos = 0;
+		while (pos < actual_length) {
+			union esd_usb_msg *p_msg;
+
+			p_msg = (union esd_usb_msg *)(rx_buf + pos);
+
+			switch (p_msg->hdr.cmd) {
+			case ESD_USB_CMD_VERSION:
+				++cnt_vs;
+				*net_count = (int)p_msg->version_reply.nets;
+				*version = le32_to_cpu(p_msg->version_reply.version);
+				err = 0;
+				dev_dbg(&dev->udev->dev, "TS 0x%08x, V 0x%08x, N %u, F 0x%02x, %.16s\n",
+					le32_to_cpu(p_msg->version_reply.ts),
+					le32_to_cpu(p_msg->version_reply.version),
+					p_msg->version_reply.nets,
+					p_msg->version_reply.features,
+					(char *)p_msg->version_reply.name
+					);
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
+			pos += p_msg->hdr.len * sizeof(u32); /* convert to # of bytes */
+
+			if (pos > actual_length) {
+				dev_err(&dev->udev->dev, "format error\n");
+				err = -EPROTO;
+				goto bail;
+			}
+		}
+	}
+bail:
+	dev_dbg(&dev->udev->dev, "%s()->%d; ATT=%d, TS=%d, VS=%d, O=%d\n",
+		__func__, err, attempt, cnt_ts, cnt_vs, cnt_other);
+	return err;
 }
 
 static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
@@ -1258,7 +1327,7 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 	}
 
 	dev->nets[index] = priv;
-	netdev_info(netdev, "device %s registered\n", netdev->name);
+	netdev_info(netdev, "registered\n");
 
 done:
 	return err;
@@ -1273,13 +1342,13 @@ static int esd_usb_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
 {
 	struct esd_usb *dev;
-	union esd_usb_msg *msg;
+	void *buf;
 	int i, err;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
 		err = -ENOMEM;
-		goto done;
+		goto bail;
 	}
 
 	dev->udev = interface_to_usbdev(intf);
@@ -1288,34 +1357,25 @@ static int esd_usb_probe(struct usb_interface *intf,
 
 	usb_set_intfdata(intf, dev);
 
-	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
-	if (!msg) {
+	buf = kmalloc(ESD_USB_RX_BUFFER_SIZE, GFP_KERNEL);
+	if (!buf) {
 		err = -ENOMEM;
-		goto free_msg;
+		goto free_dev;
 	}
 
 	/* query number of CAN interfaces (nets) */
-	msg->hdr.cmd = ESD_USB_CMD_VERSION;
-	msg->hdr.len = sizeof(struct esd_usb_version_msg) / sizeof(u32); /* # of 32bit words */
-	msg->version.rsvd = 0;
-	msg->version.flags = 0;
-	msg->version.drv_version = 0;
-
-	err = esd_usb_send_msg(dev, msg);
+	err = esd_usb_req_version(dev, buf);
 	if (err < 0) {
 		dev_err(&intf->dev, "sending version message failed\n");
-		goto free_msg;
+		goto free_buf;
 	}
 
-	err = esd_usb_wait_msg(dev, msg);
+	err = esd_usb_recv_version(dev, buf, &dev->version, &dev->net_count);
 	if (err < 0) {
 		dev_err(&intf->dev, "no version message answer\n");
-		goto free_msg;
+		goto free_buf;
 	}
 
-	dev->net_count = (int)msg->version_reply.nets;
-	dev->version = le32_to_cpu(msg->version_reply.version);
-
 	if (device_create_file(&intf->dev, &dev_attr_firmware))
 		dev_err(&intf->dev,
 			"Couldn't create device file for firmware\n");
@@ -1332,11 +1392,12 @@ static int esd_usb_probe(struct usb_interface *intf,
 	for (i = 0; i < dev->net_count; i++)
 		esd_usb_probe_one_net(intf, i);
 
-free_msg:
-	kfree(msg);
+free_buf:
+	kfree(buf);
+free_dev:
 	if (err)
 		kfree(dev);
-done:
+bail:
 	return err;
 }
 
@@ -1357,6 +1418,7 @@ static void esd_usb_disconnect(struct usb_interface *intf)
 		for (i = 0; i < dev->net_count; i++) {
 			if (dev->nets[i]) {
 				netdev = dev->nets[i]->netdev;
+				netdev_info(netdev, "unregister\n");
 				unregister_netdev(netdev);
 				free_candev(netdev);
 			}
-- 
2.34.1


