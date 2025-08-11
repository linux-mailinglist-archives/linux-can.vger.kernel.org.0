Return-Path: <linux-can+bounces-4198-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD55FB216FC
	for <lists+linux-can@lfdr.de>; Mon, 11 Aug 2025 23:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10291426F88
	for <lists+linux-can@lfdr.de>; Mon, 11 Aug 2025 21:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EF32E426C;
	Mon, 11 Aug 2025 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="IWpMbUw/"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021129.outbound.protection.outlook.com [40.107.130.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A02E2F16;
	Mon, 11 Aug 2025 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946380; cv=fail; b=mr1Fvre2v3Jz9XtDOZWhxuCypwpxu2bmrI4vVDnJ1R9m59I0g+QT6MxOaPwZEk4sdrGqVIJs/IQI38h9/HhI5A0ZVYqgd0C7GZBjOvcOCIQODh/rvFzMUIZ4xG6sHqfbo4Qx4fiZ1lYqdWLqejppr+GB9tGndQj1m38T4POI+b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946380; c=relaxed/simple;
	bh=3xl3NZoO9HpKE1KPDEtS7rbKrGBtpK2Zd0pby32GFdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y28zqeoUBSQ7pegyt6LHaN56i4vK7RwbEJIMPgPwBLyQ21kQIrtlp1TnC+3pE3FN5fbMTZkZGATHtyj806eNITgA2mjYnaZECR9dDgQ7Rbt9qE5Ok7bvUYA2M3W8jbSFgUTx4//uzvkvBbZsQ/tMW843/QAw0NhPyDXzPUYgIMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=IWpMbUw/; arc=fail smtp.client-ip=40.107.130.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsgF6WFT/m4Uh6PLU2YZgqlKlClS1fQLtGQN45vU66frR68hrfsBMdC1Ea3okE+WBLFFDtUs6VtJ4Qbr6uawUL+vIfl/tCv0jAQFdu7kdLO2x7K/Tsh857WA4+1vBbbmylP6kF22j+dgQt8AW00rWpDnWqJd9NM+tyU2tsvOAXf8YWJ25j/oVHD0zSNWPTWJ2/otytBk9nhmJdmcvkqHSbdVTODXR0/HJEXNVmkoQTKodKnF/iYitjeuK+UAUGzHkCnfCjSCUU1uknOMQgD+7PRmeLPdr09HqGGrrCs5E9SOfLuCgvF3byZKTiFljiGIMoiAaLUE4WfZuujtzf69Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TlPuMv5FDq0QJ9Sx1K8RmKty4uZ8ZhXLY7+cj1rS1g=;
 b=IakIy/Ec1NPGZ56WiOccOGIzEtUudseSclrb/S4pdxP9LkR8TJcvkvthX1vPrQFMvk74yFTcWjuePdetEkbt4z6q13vPBIOwLOSyWDSh+W82Nhj2kZEQ7oruXNDm/YrOh6qvJpnxNV3Z7D8D6udP8Y4yaBDXXVPfHmrSKcv4Y1wlcMnm5j1dsSADBMibbY8pfluwz9kR/kLIYAgnm5VlH5oUzF8SAaFNagcAGvE9lyKiFr71Ack1xiYHJPMfZtAkGfcnszrvLmv2q5rL2RDSzAC3Zc3uX5joNcF8DKg5htgZNGy1ExzI/F8XVJO9Nt1AoLQgCPleL6ifZxBx81E5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=esd.eu smtp.mailfrom=esd.eu; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TlPuMv5FDq0QJ9Sx1K8RmKty4uZ8ZhXLY7+cj1rS1g=;
 b=IWpMbUw/tAQ5GoyUCUipT+l/XM2V7vDuFRAvol+bFeMM4MdwnBs0EGlDZfWOuOOZxNb+BGopjUBeBj47Bh/EiN0gK4K+Jd+5qdLAwEjLLfbRwL5OYKM9kDlckkkJBbrBPtzrvjNLeKhESeTQHLtxRRuJ8LBI/qh42bH6OEvWki0=
Received: from PR1P264CA0188.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34d::8)
 by DB8PR03MB6251.eurprd03.prod.outlook.com (2603:10a6:10:137::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 21:06:12 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:102:34d:cafe::ab) by PR1P264CA0188.outlook.office365.com
 (2603:10a6:102:34d::8) with Microsoft SMTP Server (version=TLS1_3,
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
Received: from debby.esd.local (jenkins.esd [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id EEA067C16C8;
	Mon, 11 Aug 2025 23:06:11 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id E7A9E2EC3E2; Mon, 11 Aug 2025 23:06:11 +0200 (CEST)
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
Subject: [PATCH 2/6] can: esd_usb: Fix not detecting version reply in probe routine
Date: Mon, 11 Aug 2025 23:06:07 +0200
Message-Id: <20250811210611.3233202-3-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A791:EE_|DB8PR03MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 7983fa99-3007-4eb8-28aa-08ddd91ae6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk94U2pxYVVndE9NY1BROG51TFlGVXE0MUpmR3JPK3B5TUtqWE1NOUZiUHZv?=
 =?utf-8?B?WERRTkZWWTJJeVV6NzE0TUpLVlNrbGpkcW8rU0VPL2hzZjhqcUFYamxpQk1C?=
 =?utf-8?B?VHA2VXlLczFJY21Ta3h0SDdpN3pJRmJ6cCtjREZOa2NmR3pNTHh1dVpXMUtK?=
 =?utf-8?B?cVdmbXVUU0NOa2dLVSt5OWg0djg5dDZ0ZHlHRGt5TTFjRG5PQnh2aEFCZ2tk?=
 =?utf-8?B?UXNtS2hzbGZIL3p1S3dBbktBdlhwUmZnTnRwS2d6RzArQ1pDSENDZ240T1hw?=
 =?utf-8?B?b3dwVVRSTENubzcrMCs5aUNmZW95TjZOVSsrS1ZGV05DS3N3SEs3dml0VkVs?=
 =?utf-8?B?c2s0anpSRHROT2p4QXQyTWR1L1pGWUZmc0J4WWxnczhYWEw3QlUvWldMUHg1?=
 =?utf-8?B?MHJVTTRmVU9HK1dPckcxU3JFK3VSQWo5bkNtSExBVEZEcks2ZmtXdnNqUlpL?=
 =?utf-8?B?OSt4OGw3WTduQ3F1OU5UaDgzYytBQmdHbWFrdVY0RHdJUDNVcW9XQzRiT1Bp?=
 =?utf-8?B?b3hnazVzcnVCWWhUU3JLSVZ6dThObDhjZWNYNmhyakNWdG52MzU3c1k0Yyts?=
 =?utf-8?B?ZDJadTdxeEk1TmxhTkJ6Uk5wOHJka01jSEREQm5jeXZycHRsU2tYMVRLWmhK?=
 =?utf-8?B?YU0yYW83UHRWNW5CUGUvSEJldS95Rm9uRG8zS1pISk9abCtyQWkzZDBBUVFW?=
 =?utf-8?B?Mnp6eUZ6M2FRSFlsdTY0V3JHcUFjeVpYY1BpL0s3TVB0THIwYlJnd2RoRDFD?=
 =?utf-8?B?Vi9oYmNPM3JYYktubWFqTEV2S2tjbElKT3dLNGcvTGFmMm5xMnA5NGF3SDZk?=
 =?utf-8?B?SnF0a0Q4NG9tay9HYUVIODk1eVJlbVVkdmFySzltand2dHJVSHBWNkQ2SGQ1?=
 =?utf-8?B?d3hGYU9TQU9zQXUybXFTZUV5cWRxb3RBV25MVGdmdmNrcjlRRFU4L3pzY3Nk?=
 =?utf-8?B?VU05MEVYeldmelBvYThUR245dHhoT3o3SkRGKzlLaU9VeW9jZjVwUUY0VjZG?=
 =?utf-8?B?NWNmbmFpZHlsZmtQZ2kxRW5ZeGRraWJKZ2RkZ3lpS0wxUlNzZFVidnU1em1j?=
 =?utf-8?B?ZHFjSGlOMDdoTzNRbXlnb0ExSVNIMUg5K1hlZmRtUDdRbXJSSzk2RWNVUjJs?=
 =?utf-8?B?dEJYVmoyNGllcWM0bXhsRU12dWRLbG1jK1htSGlMVDE3UEFIbjkrZGp4eXFl?=
 =?utf-8?B?Zk1yZFRrZGRnMUJZRnJMSytGRUYyYXkxVzlqYTZmZFE1Qm15NlFYMHJ1cXNE?=
 =?utf-8?B?blRVN3d4M2U3VzBWeXBXSkFqd2ovTXdUSDlVaE5tVlJtZmdIcXZhSVVWTXNR?=
 =?utf-8?B?VHVHdmNHSEtmeFM2LzlNbFl6M0pPVis2bzdTZ1FuY3NlRDFScUgzT2NOc0pL?=
 =?utf-8?B?eC9rU3B1L2ozbmFkUVFWQ29XNGx4WTRDUUNhVjIwNVB1aUZaMUZoY1YzWEhL?=
 =?utf-8?B?UnI3YjVXZ0dKdDRTY0pGTHZsUzVSMTFQejB4NTdDQUlja0xVY0d2ejRXSTh3?=
 =?utf-8?B?WXpSa0NkOHJQWkJvMVZiTGRWc2JmdFJ5TitiS1lRVHQxV1FGSThvaEZoRk1V?=
 =?utf-8?B?TVVHaEo0bThBRFhXVWRCRkFPL0txVTlQWFBud0MyMjhZTHZsdmpxbVRFOXdQ?=
 =?utf-8?B?OVg3VXZKaitYZ2F3d3R0Q3FzQ3ZIWnYvYTVjNWZUSHVJTTJiR3ZiT0tpV05r?=
 =?utf-8?B?bjAreXovVXQ1R1VOSXVLQlNrSlQ3MkpCbzhaTlRuOUVpQUN4cGhjeVhvQklm?=
 =?utf-8?B?RWIycUg5UnltSTRRaFFXaXl2emdTeHRsSnNqUWFNdldDTXRZM3pNbmVINlg4?=
 =?utf-8?B?YjZEdTNCSU1jN2dpRFc2S3h6bHFXZ3gwcTNLbDIzZk9hNWRMcGlRUlduSWJY?=
 =?utf-8?B?aFJ4MzFjSmlBb2t4TTM3eEVQemswUWZQOCtRdDJiMVBhNnVTQ05pWHQrYzZ4?=
 =?utf-8?B?SmR3MlpLYThJQXN0ZXl2R1F0RUc2aUhUcVVicDBQbHczRGhoQUMwS2gyR1pQ?=
 =?utf-8?B?MTFoeTY0L0dBPT0=?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:06:12.1428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7983fa99-3007-4eb8-28aa-08ddd91ae6df
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6251

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
- Use a transfer buffer "buf" with ESD_USB_RX_BUFFER_SIZE.
- Added a function esd_usb_recv_version() that reads and skips incoming
  "esd_usb_msg" messages until a version reply message is found. This
  is evaluated to return the count of CAN ports and version information.
- The data drain loop is limited by a maximum # of bytes to read from
  the device based on its internal buffer sizes and a timeout
  ESD_USB_DRAIN_TIMEOUT_MS.

This version of the patch incorporates changes recommended on the
linux-can list for a first version.

References:
https://lore.kernel.org/linux-can/d7fd564775351ea8a60a6ada83a0368a99ea6b19.camel@esd.eu/#r

Fixes: 80662d943075 ("can: esd_usb: Add support for esd CAN-USB/3")
Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/esd_usb.c | 125 ++++++++++++++++++++++++++--------
 1 file changed, 97 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 05ed664cf59d..dbdfffe3a4a0 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
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
@@ -625,17 +629,91 @@ static int esd_usb_send_msg(struct esd_usb *dev, union esd_usb_msg *msg)
 			    1000);
 }
 
-static int esd_usb_wait_msg(struct esd_usb *dev,
-			    union esd_usb_msg *msg)
+static int esd_usb_req_version(struct esd_usb *dev, void *buf)
 {
-	int actual_length;
+	union esd_usb_msg *msg = buf;
 
-	return usb_bulk_msg(dev->udev,
-			    usb_rcvbulkpipe(dev->udev, 1),
-			    msg,
-			    sizeof(*msg),
-			    &actual_length,
-			    1000);
+	msg->hdr.cmd = ESD_USB_CMD_VERSION;
+	msg->hdr.len = sizeof(struct esd_usb_version_msg) / sizeof(u32); /* # of 32bit words */
+	msg->version.rsvd = 0;
+	msg->version.flags = 0;
+	msg->version.drv_version = 0;
+
+	return esd_usb_send_msg(dev, msg);
+}
+
+static int esd_usb_recv_version(struct esd_usb *dev, void *rx_buf)
+{
+	/* Device hardware has 2 RX buffers with ESD_USB_RX_BUFFER_SIZE, * 4 to give some slack. */
+	const int max_drain_bytes = (4 * ESD_USB_RX_BUFFER_SIZE);
+	unsigned long end_jiffies;
+	int cnt_other = 0;
+	int cnt_ts = 0;
+	int cnt_vs = 0;
+	int len_sum = 0;
+	int attempt = 0;
+	int err;
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
+		if (err)
+			goto bail;
+
+		err = -ENOENT;
+		len_sum += actual_length;
+		pos = 0;
+		while (pos < actual_length) {
+			union esd_usb_msg *p_msg;
+
+			p_msg = (union esd_usb_msg *)(rx_buf + pos);
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
+			pos += p_msg->hdr.len * sizeof(u32); /* convert to # of bytes */
+
+			if (pos > actual_length) {
+				dev_err(&dev->udev->dev, "format error\n");
+				err = -EPROTO;
+				goto bail;
+			}
+		}
+		++attempt;
+	} while (cnt_vs == 0 && len_sum < max_drain_bytes && time_before(jiffies, end_jiffies));
+bail:
+	dev_dbg(&dev->udev->dev, "RC=%d; ATT=%d, TS=%d, VS=%d, O=%d, B=%d\n",
+		err, attempt, cnt_ts, cnt_vs, cnt_other, len_sum);
+	return err;
 }
 
 static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
@@ -1274,7 +1352,7 @@ static int esd_usb_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
 {
 	struct esd_usb *dev;
-	union esd_usb_msg *msg;
+	void *buf;
 	int i, err;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
@@ -1289,34 +1367,25 @@ static int esd_usb_probe(struct usb_interface *intf,
 
 	usb_set_intfdata(intf, dev);
 
-	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
-	if (!msg) {
+	buf = kmalloc(ESD_USB_RX_BUFFER_SIZE, GFP_KERNEL);
+	if (!buf) {
 		err = -ENOMEM;
 		goto free_dev;
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
+	err = esd_usb_recv_version(dev, buf);
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
@@ -1333,8 +1402,8 @@ static int esd_usb_probe(struct usb_interface *intf,
 	for (i = 0; i < dev->net_count; i++)
 		esd_usb_probe_one_net(intf, i);
 
-free_msg:
-	kfree(msg);
+free_buf:
+	kfree(buf);
 free_dev:
 	if (err)
 		kfree(dev);
-- 
2.34.1


