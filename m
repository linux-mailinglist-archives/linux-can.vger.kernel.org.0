Return-Path: <linux-can+bounces-2716-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5CDA25DF1
	for <lists+linux-can@lfdr.de>; Mon,  3 Feb 2025 16:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDA73ABE79
	for <lists+linux-can@lfdr.de>; Mon,  3 Feb 2025 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045BD2063D7;
	Mon,  3 Feb 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="TrMEOjmJ"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2123.outbound.protection.outlook.com [40.107.103.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932623774;
	Mon,  3 Feb 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594698; cv=fail; b=NXFiy7P9PPEpkpLme1xbN89Hg1OlZSmmuYaQJuniOIvuwOBCFfocmqzzhAZbW4RqJFrBWpxbjGODjDlV1qyShuZmDzRNGZVEHTEbaco8nxcx9bd1XQZM3xS4Iy+ZJG8kokGHSwv8LEa8YPR6cCqsw7iQZWVJNr3ZNrtnwo1XGI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594698; c=relaxed/simple;
	bh=70n3EYf1ATLOMd5HEJfyWyjnXssVsWHFWBmGVaX8lpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOr9IxwM0m7CY9soltlSPRmDs0QObdO6IFBJk9QvSn3HaYDqc2cfSndhSdYeNfm7Xw0XSbJvMGOOHd1ovK+QZzbFQ/Ul+VD18149+MZaImJWyM2txyrkrYRJn30qsP7fhE0kaN2s6QoCjudpj44PQr4yKq0e2noDpr/wSw/XVxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=TrMEOjmJ; arc=fail smtp.client-ip=40.107.103.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFwFbNNA41XRCQ4+eg8gDeEB7cJGhTEoEC+2CZ9smLqeGshDof3LekpPYuWVb9ciTn+ihzRBCvKetptJ8nBeUKYHuwt1a5Ql3qFkBmrQNQDpdgzstym4dS9ibEciXNrOBg56d7DhSAiYTHEP8BXnnoyltDzsiQH+YaxPXANrcYAB9KFZpLFj9h7IrBDHEJnVwWyts75pJBWZPU1BXe861c479AzhyzDfsY525goM1RnVqu6KL7EZCncGdflTnKLHFjESX354VepAzpv+7nfFE5X04GDBm5+72udkCb8Yg/cnR6sWVVhBOTheqB3v5a38+d/ndEdoTIttZWHjrKAvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PbTugyW7Kg+pYgMehpRO/CeJObbWgQNnITGUVr4j/o=;
 b=ZU6rrwGDomcRyZguO/mxXGTZsm3Omdr/xcBVLr+v6Qrh5h+lNZSy4OvQxZU4agJU3xNzYVhjpoIq0YbKhEAQFySGrQ0HC5PTlKbtNCP5XqdAGcAvuh5hLDd+s1kSRuvzVOY7NJxlDUdeGtP5UV9uqGm4nO0XVHJjpa7V6ZChudvSwMM7N9wu1fD5g1GQ2ZGsE17Q7iLHwJNnkf+Rx/pY7bo+5h0MmkjEVmS0vVO/K0Mwe/iLCB5yu5UyoFI4FZ9Del1nxoBPogKIlPzHSQmMVFbnAZf2GXVDb08HAN5HG4uoBcelkQk8it62febsyVum88+CTuM2NdP4wylqe1KFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=esd.eu smtp.mailfrom=esd.eu; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PbTugyW7Kg+pYgMehpRO/CeJObbWgQNnITGUVr4j/o=;
 b=TrMEOjmJ0oCE9A/bYUa7dqFL5HsQ71mwcljlfXfzL8wyRD45uedv9Fx5ESFordSSATlbCzyPPknbmykIK1Lx/wlG/LWMXp1ZgyrB9XmG/eUbixuFO1Cim/SPK1DaIFA5vetSb1ijpcfgB2pbDGF5I5COxcpRehCc3xMhCfLGxiw=
Received: from AS9PR06CA0463.eurprd06.prod.outlook.com (2603:10a6:20b:49a::14)
 by VI1PR03MB6221.eurprd03.prod.outlook.com (2603:10a6:800:134::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 14:58:11 +0000
Received: from AM3PEPF0000A794.eurprd04.prod.outlook.com
 (2603:10a6:20b:49a:cafe::ec) by AS9PR06CA0463.outlook.office365.com
 (2603:10a6:20b:49a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Mon,
 3 Feb 2025 14:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AM3PEPF0000A794.mail.protection.outlook.com (10.167.16.123) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 14:58:10
 +0000
Received: from debby.esd.local (jenkins.esd.local [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 60BF77C16C8;
	Mon,  3 Feb 2025 15:58:10 +0100 (CET)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 5161B2E82C4; Mon,  3 Feb 2025 15:58:10 +0100 (CET)
From: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Frank Jungclaus <frank.jungclaus@esd.eu>,
	linux-can@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH 1/1] can: esd_usb: Fix not detecting version reply in probe routine
Date: Mon,  3 Feb 2025 15:58:10 +0100
Message-Id: <20250203145810.1286331-2-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203145810.1286331-1-stefan.maetje@esd.eu>
References: <20250203145810.1286331-1-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A794:EE_|VI1PR03MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a68a7a-3b5c-406c-c45e-08dd44632d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHpvcEgvYWJxRWc3SnpCcXhaeFAwT05zTGlJVnlkVkFyYlN2YVhhbkVmV2hy?=
 =?utf-8?B?eDlkcVBYNTU3Wk9sUE9RRHNRckM4NkdmVlUvbUJCTFM2ZzV0V2ZhMjBZT0F0?=
 =?utf-8?B?U2RTbzFoWWppWkJRZExzcDNFdU9NRkpKaWJ0bzBkMDRHRDdSQ082UDNrNVo1?=
 =?utf-8?B?dUc3eVJoYTFZRHcvMGZ0NWg5M0xJaE1lL252UjJxbUg2cGNNY05YU1dQMGR6?=
 =?utf-8?B?MHN3ZVRsbFI1TTFtTlhRSXFkM0RqUnpvSmZTZ0JQZ2Vtb1VSZWM2UE04bFJo?=
 =?utf-8?B?Y1FldG5SaXhUUllSTHNqek5kdEk1K0xXbnBzY0l2Sm9IQnFxdDVGL0c4T2VQ?=
 =?utf-8?B?cVE5YklLUmJodWdRd1E3NStMVFdrMzNEcGt1dnpPK01EbStoTnBRcGRLbGhF?=
 =?utf-8?B?MVJJeThPZnNmNVFzUEVQTlJOelpVdzM1TjFtazJ6Wis3a1dQSGhHQTNDTGhr?=
 =?utf-8?B?aFVhWTFpekVCMGFZcFVZekZzcmdtUFRteE4yaDVQbEtmb3VVZlhYbUNvL0dp?=
 =?utf-8?B?aG05ZitrTDBqNWtWcm5iRVNEcDF2T1Rkak9kNk1qUXhQakxTS3A3bG9GUHM2?=
 =?utf-8?B?S0JmRCtHZTcyakZJMXVvbFB4MmRJTWJsRHhkWFBSMFcxNitXa1hJTVdCdXQ5?=
 =?utf-8?B?UU9JdWlqQjNzSWJSNTVrS1h4Nk0xZjdrRmFFM2JCeGRTbzZJS3kzQWc1eWZW?=
 =?utf-8?B?MjVTd1p5V1pIakxPT3c3aFBQbnNvUjBFMWVvb3g2bXNDWTJrWUNjdlBCZUhS?=
 =?utf-8?B?bkorQSt4UGlmR0Y2NkJiSUFJSjBua2NUUVI1R3ZMSjJQcXJMSkM5RlV6OHN6?=
 =?utf-8?B?dFhISGlERmFEVjJDRXlmZjVPaXVRa00xSk9tY0QxN21YUzYrUXRiWXl3WTVC?=
 =?utf-8?B?ZU5pQ1NsUjVVamIybmM3NjdyKzdrenVjWEdJYjVwcjNrcTlOK1hoQ2duT01a?=
 =?utf-8?B?S0pDclUxc2liUVRnTUE4V1ZjalAvcUZ0OFVKV2lGRG8xenpscTR4V2ZRZFQ3?=
 =?utf-8?B?U0xRQk53TUpmdEl1aktJQzRPekpsL1pHbGNLUmxyeUxXWGpDREFQN3laN0lT?=
 =?utf-8?B?Z0ROdUxlZXNBTDhMeDJoSGlMeGxuNVFmVHZETE55b2pqYi9EZmxSMm5WTHRU?=
 =?utf-8?B?L0tZV2lwZkRYOGRIRmRSQ1l3cE1QaHVvd2hZSUFHcVNBWitRVkdDWnBpeFdr?=
 =?utf-8?B?Vng4b3hpQlYxdXZZRXFhQnJ5MGdxT29vZ3B5ckFCY3ZzRi9qZWw0RmxSRDEy?=
 =?utf-8?B?Ni83ZHo0NjI1N203Ymdub0RlellFbzk0cStIYU5Pa0tPTTJPYmV3b1QxY1hD?=
 =?utf-8?B?TUJJdWt4ZFhGRHhLVWhSdEx0SzBKcEpPMnBVMU96aE53VnBZQlJYYXViQmNU?=
 =?utf-8?B?akZ2bHJoQ2g2TnVVbXUrZzY0SUx6SmJuUkZOa0JMdkU0L0xVSWZtQnJ3aTVw?=
 =?utf-8?B?VnJGMzVhRElhMzZVZlN0NGJGK2xQZzB6SWkvMHB5TldEN2V1MERLeExjVW1F?=
 =?utf-8?B?a3FWWnkwYU41dXl5YTBrZm9QeGRJOVNZeDdZRFVlNDJOa1BXQ3JIZXZOWHdN?=
 =?utf-8?B?dmZoMld6Q0hiWDYzQzVmVTZZcmpFNGVlWU5hZFIrWjZUUndwUG1MV080RnU4?=
 =?utf-8?B?WWlYbG04VjNUTGdBdWQwdmFzWjlUdjk2T1pWcmg5ZmF2R25yMm5pczZLVDNX?=
 =?utf-8?B?WCtHT211aklRQ29KTzcwYVR6Mnk5YnZVOXNTdTNXV2xielZkSmllaE4yd2Nq?=
 =?utf-8?B?bnduYjNmS2k2dDVyT2REc2V2UTBHZWtiT000NHFHM0h5TGR3SkRuWGVOSFoz?=
 =?utf-8?B?MW9oNDhVRVBaTmlDUCtnWWM0cjJ2L3lHWStKUHg0bFFpcFE1bkZDRjdKSHJu?=
 =?utf-8?B?azBucmlNRGRQZTdkMjQxdHh2Yi8rRWo4OW91emdEV1pjSW1jbHlRQVVHVHJO?=
 =?utf-8?B?M21QSWZReWxyKzBVejRuOWZJWEJqR3JTa3RiazhlQ2ZPVUZTNjhRSVp3Y3B3?=
 =?utf-8?Q?AUIoL57ltoAhGSEhMxSoBlTV1ug83k=3D?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 14:58:10.6147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a68a7a-3b5c-406c-c45e-08dd44632d2b
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6221

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


