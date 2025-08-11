Return-Path: <linux-can+bounces-4196-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 160F9B216F2
	for <lists+linux-can@lfdr.de>; Mon, 11 Aug 2025 23:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F51D1A24623
	for <lists+linux-can@lfdr.de>; Mon, 11 Aug 2025 21:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAC32E2F01;
	Mon, 11 Aug 2025 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="HAfdd6sU"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023108.outbound.protection.outlook.com [52.101.72.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6202F2E2EFD;
	Mon, 11 Aug 2025 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946378; cv=fail; b=EvqYSq5a1nJdJAeJX2mA5g8EXJhC+Iw/2VVEw0Mm9g41B1GXm8lBJ0J1RT9pQHUIqd4qHwJbyedFHTsa+RuhHXPnOMpMUwf8XfPOpNirnKjeeVkwjmXpvIobH8tn1HI1Ic0HWUKdgYSOJ1J/iShu+MzSXW0i8cRykv513nbD20g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946378; c=relaxed/simple;
	bh=P7t9qu7c4KHhx3Y+Jm6XHf4AWodnscV0Ieqdrrasqg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qV85K7/mY4Y8lBL2Nej58j2mlItZUFSfv1m8ueHDgHqXu1ssUalwMJxTeVLLzybHgGqjGbrkS4GMReuOyzBtQ5AbESEKM3i5kIh0Ef7pcONUWNwlVsJ8Lks4CPt12FBsjDmevlm7RdVPUwAjOchHFmgYLHvy1/pTGr88hDYJhC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=HAfdd6sU; arc=fail smtp.client-ip=52.101.72.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJCiO9A1TlaMfCe2nVJnuYjZ1voV0TmhHvrS7Q8/RiWHDkYTGy3aDzt5EbrjApcSgorXiZTTcc+pRTRqHxNWBejl5g4QPCBkI0Lkb8AeFG5jaZboNbHmVBiiZhroit6cz2w/sFoRYINeX5A8i4Ixg3laAYpmfyJlSoOwkcUQLLep7kK8QYb8VMCUOCmr61Mke5EOnS+GhiMp56g8XC8gJFo6zBmUsccZWDrO6xeYREnCQhizpwrPKiSynbR609TucomjnEA+hFoyUOz8f73e771sIY4MyaL5/+fQFK/VTRXHjqf01l1ad+z2OJIiv1i8Fu+yR0u4itopK9fqcyDfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkfXdh6rBk6Ow1r8nxN3cuLrzmEpCHu24ogGMQ9iUc8=;
 b=uXWg99M2TZ23f8fUXZJBmONA0+gP0/W+Q0xTAtv+DxlpF4zimODlzy+3nujMg1Yjqa5HpYoMDSXYZViozwfWTEEZr292mSlUXxywbIADDmBmeqy5eHP3fNu8E12TPTt3YBC4Y5RDCdqdClHTCo7Fww6JqDrJMaGhjQkEMysv8FT+OOrhZn+hlK2xwdcGCiEWHroBlHTPfXdp30ZfP3TFYOZEe2tVqeiU7BK4ueO8b692WjZQmij6puHxFwLggkTF6qDUx6Jt1e5YoBoTQJstY1G1FxFwyaWUEJc900Nzj4aiU0OG8Jb5Lj4NI0rZnoIK/QAM5rs2Ug6W22QFC40arQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=esd.eu smtp.mailfrom=esd.eu; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkfXdh6rBk6Ow1r8nxN3cuLrzmEpCHu24ogGMQ9iUc8=;
 b=HAfdd6sU+xRrEFyRcvbtFxAUvDndLG2kc+7HthaWNa7B4yHPn8N3MiLhF6b3Rwjfk0tETC/LcRiHfBU7td7gOwbk5DpWnc1HdQjW9fquetDYI2VqOeJSwiO8moevWrcBuLA1aAGil8DNQ9LW4xDqFruwzOIqdZuTELk2k2/+IXo=
Received: from DU2PR04CA0154.eurprd04.prod.outlook.com (2603:10a6:10:2b0::9)
 by DB4PR03MB8612.eurprd03.prod.outlook.com (2603:10a6:10:388::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 21:06:13 +0000
Received: from DB5PEPF00014B96.eurprd02.prod.outlook.com
 (2603:10a6:10:2b0:cafe::2d) by DU2PR04CA0154.outlook.office365.com
 (2603:10a6:10:2b0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 21:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB5PEPF00014B96.mail.protection.outlook.com (10.167.8.234) with Microsoft
 SMTP Server id 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025
 21:06:12 +0000
Received: from debby.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 0244B7C16CD;
	Mon, 11 Aug 2025 23:06:11 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id EEC1D2EC3E4; Mon, 11 Aug 2025 23:06:11 +0200 (CEST)
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
Subject: [PATCH 4/6] can: esd_usb: Add watermark handling for TX jobs
Date: Mon, 11 Aug 2025 23:06:09 +0200
Message-Id: <20250811210611.3233202-5-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B96:EE_|DB4PR03MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: ffcc833c-d9f0-4ffa-07dd-08ddd91ae75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|19092799006|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXl0bk5UU0ViQUN3Y2lhRDlJSXY3MER2eVl6ZU0yU0VyUks5eVBFVTN1d0Nh?=
 =?utf-8?B?Wk9aTEhqTHAzRlhLOWkyVkltVGtNdjVUSGYrNmtaYVZ3UWNRL2VHLzQ1T3ZW?=
 =?utf-8?B?QnBHVWIyNlk0T3NSaFMzKzVYQzErRUs2TnBmUDhna3l5QUlvWldSRUI2cTZT?=
 =?utf-8?B?MENZRGdpWU8yZWRVaVIzcEZtK29YRWU3K3ltT05EcXFYcXdMYUVjajdJSlU4?=
 =?utf-8?B?Z2trRDJHeUNZenFzamtudlFTbExXMmxvMzhBNVNnYTZndFdCN1c4N251ZDlL?=
 =?utf-8?B?UTJ3cko5TTNMQ0tWWDh5NWJKUkZuSis3eHphNGI2V1MxZjF3aTFtR3ZIWXhz?=
 =?utf-8?B?OXhUdjBKUEQraStXNlRtMGZqNWhmSHJ4S3cyUlB3d1FVN3phT1VJRWMzMVAy?=
 =?utf-8?B?dWV4WU1iYjZBR0UrcndGeTVNaVJJc3REVDdrVFFqZVNQUHhFTkFsSE8yQ3gy?=
 =?utf-8?B?RXlQOXRnVWl5dVR2TldJY3g5OXg0TW5Ja1NicmpwVVBkRXBuRGxiSG9IY0pP?=
 =?utf-8?B?ZDN1WVlPZndHNWpkYmxqT1F2NVdXKzVTVkVwejZab1o3d2t6bmhURUZRTHUy?=
 =?utf-8?B?U2t6THRLQytCOXJ4OHdDTTZMMkJVc3RRSUVsb01aYjVac1BXRXR0UW5PdzNC?=
 =?utf-8?B?bWpHOXNlWms3Ni9lWm10aml2YXNRTFlNcDFnd2JNNlhMMUlmdEVFSmluVWRZ?=
 =?utf-8?B?QnUyb2R6UE1wbDRwWm82MUh0eXkvUFRoSnZJRXFrTjJOMkdDOEJUejc4M294?=
 =?utf-8?B?Q2NDZ2p2TDRYMWV5Zm1Na29icDZKQ1lLMkZqdVRzdUdWaHM4VG1udDlrMGY0?=
 =?utf-8?B?czR0OHlTSjdoWStPT1BPTEJPUkk3b1dWcjdVNEZsa25rM3lya0laK2dqanI3?=
 =?utf-8?B?THZrQmNhYW1ZVTRWYkVKQ01sUlh4ZmNsZ3RocVFkekNWQ2VUZmJWNnBaU3JQ?=
 =?utf-8?B?Z3F1WUtPZjFRNUlZL3VJVXdrcjNYU2Y3Y2xhOXo0aDVSeHpPbzI0SFlabnRX?=
 =?utf-8?B?SU1SOGcxTGVpUjE1V0tncWhYbmZTMHRPaWpJRWcvRVdYc3Q4WGJIRmRUM1ZH?=
 =?utf-8?B?ZmNMTTBEVStHb0toTE52Q01yYmRNVVhkWkEzV1BkREMxS0dQblRsNUlTdmxE?=
 =?utf-8?B?N1JKNHkvTnVtbmpORFVhRW1aUDVRVzVPQmhFZWFsek9QcWlTOEFIR2c5cVZD?=
 =?utf-8?B?WkxERGVaVkFQK2dVd3d1TytqcEkvZTBMTmxhSjJDZzNZYTMwdEZuTlpld3Jl?=
 =?utf-8?B?RGltbXJtcDFndzhJeWh5YmtmT2o1RkJ1RENZSVdzU3JtSGhFeEVaMmRmb0t2?=
 =?utf-8?B?S1kwTXRQOEpyMHJZSmFJeDh1ZTFvbXgrUUJ0QnZ3eW9MNnFkcVkwcENHZnV5?=
 =?utf-8?B?TTlFOTB3VDQ4dUc3akluQmZNUmxYd1FxeVB5M0UvZ3BKdmJlS0VBZjR3MDhP?=
 =?utf-8?B?QVNYdk9ZRGp1Z0FGbDlNY3V0eDB1b3l4MXhCOEdTdThnVmhhZXBqMnNmSGFp?=
 =?utf-8?B?eFlFOXNrMzJ1OVdORjJybzZlcFJlMUdWVnNrUnhtUllnd0M4aTRNbTgrNGxr?=
 =?utf-8?B?WGhSdHdlTUpHNlg1QWQzanRVZ2JibVZpRFBBQTNrby9qM2xtdXRJNXM4N3RO?=
 =?utf-8?B?OWFUTVAxNUs0VVpuajRYSzhmMlNXUlRPa1JnR3Q3WE5JMUhnbUluazRiVmhh?=
 =?utf-8?B?S3MyaWppeWs5Y1FsVkZWY2ZZRHplTFhjY1NtemtwS3pwbEFlaXltNWErREhQ?=
 =?utf-8?B?ZmlDNStiU0hSKzhaUzdwUVhIRVpVaTVEZnp1QzZ6WVZKQUFBVUNOTk9GZE5t?=
 =?utf-8?B?UEwvK0xsMHlISTJCNGszWnJjMUxZZStmZEt0Q1VTemY1dVp1UE5lVWdUQ05P?=
 =?utf-8?B?SFYxaWFGMGxnZjFSQ050MDFncnlhQjdsR0UzYjI2anRQSWpqT1c2a0JjVGQ4?=
 =?utf-8?B?QkRrNHZmMzV0M3I5QStOK0hpRmlHR3pIc1JtY1J0TUE2a012NXgvME5VMzlr?=
 =?utf-8?B?TWt1d2ZPYkNOR3VmdWVwNDRTTW51MXVnZHY4SGpQTWFhS3RsZit5ZkFUa1Iw?=
 =?utf-8?Q?NdJtje?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(19092799006)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:06:12.9280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcc833c-d9f0-4ffa-07dd-08ddd91ae75b
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B96.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB8612

The driver tried to keep as much CAN frames as possible submitted to the
USB device (ESD_USB_MAX_TX_URBS). This has led to occasional "No free
context" error messages in high load situations like with
"cangen -g 0 -p 10 canX".

This patch now calls netif_stop_queue() already if the number of active
jobs reaches ESD_USB_TX_URBS_HI_WM which is < ESD_USB_MAX_TX_URBS.
The netif_start_queue() is called in esd_usb_tx_done_msg() only if
the number of active jobs is <= ESD_USB_TX_URBS_LO_WM.

This change eliminates the occasional error messages and significantly
reduces the number of calls to netif_start_queue() and
netif_stop_queue().

The watermark limits have been chosen with the CAN-USB/Micro in mind to
not to compromise its TX throughput. This device is running on USB 1.1
only with its 1ms USB polling cycle where a ESD_USB_TX_URBS_LO_WM
value below 9 decreases the TX throughput.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/esd_usb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index fc28fb52564c..41ff453f87b8 100644
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
@@ -973,7 +976,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	context->priv = priv;
 	context->echo_index = i;
 
-	/* hnd must not be 0 - MSB is stripped in txdone handling */
+	/* hnd must not be 0 - MSB is stripped in TX done handling */
 	msg->tx.hnd = BIT(31) | i; /* returned in TX done message */
 
 	usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 2), buf,
@@ -988,8 +991,8 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 
 	atomic_inc(&priv->active_tx_jobs);
 
-	/* Slow down tx path */
-	if (atomic_read(&priv->active_tx_jobs) >= ESD_USB_MAX_TX_URBS)
+	/* Slow down TX path */
+	if (atomic_read(&priv->active_tx_jobs) >= ESD_USB_TX_URBS_HI_WM)
 		netif_stop_queue(netdev);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
-- 
2.34.1


