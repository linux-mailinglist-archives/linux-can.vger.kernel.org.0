Return-Path: <linux-can+bounces-4283-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA76B2FD3C
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 16:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DED01D25CF7
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B34728CF49;
	Thu, 21 Aug 2025 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="cigSY+gk"
X-Original-To: linux-can@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023077.outbound.protection.outlook.com [52.101.83.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D72EC57A;
	Thu, 21 Aug 2025 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786870; cv=fail; b=FxSfcRN9OBuGmGCWjplc/1b0LyyOKIC9IC+A+EsEK3NfDEsWEkazEvZaH6i8Du3RXDCMXRH3AdXyZZXaF4dk/Zc5QzToHIIMh4io9auwhoCenU0VgmLXM3ho486DJi34z6fmL9djnygkjA5mw1HSRluNJsA+3lAuYtPr7UHN5zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786870; c=relaxed/simple;
	bh=7axL3aaZ2ExXoR6ou4AKA+OZHzR3evNXQxRH8EYaUiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDmX3yQbDpza2BZyJlWHG25XH0Jep71BW1UmbuRuPNO8SZZhWtXs+XqVVUVYRgM4MKQFHpFC835AU/zp3FUHR/xr1o1M5C3a863FtLZVb/RkFoW9CcBAjkUlET+KmAZ7TJPIlnjMAaAyBHPdEpnaheDAsbr6DFrBP2EEtjAgiwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu; spf=pass smtp.mailfrom=esd.eu; dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b=cigSY+gk; arc=fail smtp.client-ip=52.101.83.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esd.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwTtZuXQcKcdokGMo00xkiSW1OlgV8bfDvhJpEk4yPVT+phntd0qyKeWC3BH9Nm4KDmJm4niZUY7Xhv2hySln2iVXUWHtzL4XjKdVLptB0Hx3tRZ+4U6isgHtnQMGqspEJFVQ2uSimpaOCWV9hmyW1+kTDpLH/ovRQua7kqkztsbqcfkqLBSk2RWeYwlpjXDYiDiVn4LaPZ59cah4M1r0aD+le2wbH6enC3JK8PJSiQU7LgMxmQDpoSKDOaYzJ3GfWkAGAqAMBWtDrDq2BlIHs3HztNnbC7OI8BuoVx/azT93Fb5tvg21sXy1whg3VxMLyr1QosFJktLLyA8gmY5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrPmy4KgGhxgezEu7OI8MwL+/0kkdvs4jLY7nk/9UaA=;
 b=Ob00xqHeWmZt6c+UBwtfLJJERGN1ypU9jFMVZamhfGxK1mQjgM1+kHaOu8cWpiWRz2e3Ka7T8vb6O70LFfmjJ0rREVqDUgwL+/ig8sDTfdX5x0MPF2YYHuGc8y5VgTAUm40i/4kHXEv71Y2XIvtOKVVDB+aaFAe6aaKzRIXg7dWs1brn6mSEW5oFRXYuLEjnfUdXxhaLOs4FiLLXOxjkpNJrN8g1B5o2SlTWr3i8E5oJ3Ju0GVZJDck8URNVvaWLqJdnvuqL0oHCpbB3BCAVe+74wf0Cy9CyJs03kGPVzVWua5Eqsmkmtog1sJwjixKbqOIlgOWFh8fURR//5Emidw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrPmy4KgGhxgezEu7OI8MwL+/0kkdvs4jLY7nk/9UaA=;
 b=cigSY+gkHrw6e2ut/wH6x5cd0b5gG6mwf9OIuHpRlEe258Iz9MIYPN0XXKBM88Y+rLSehNY2/tBt+7ApH0PX3sDmyT3UhT4CDiD0BnMJ5AUdE4abeoBnD9g/ioCsCrhZMDptkxdcl2WBSqBKhEqLNxncwa9aZnBV4WwEvDhPdh8=
Received: from DB8P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::11)
 by DB9PR03MB7276.eurprd03.prod.outlook.com (2603:10a6:10:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 14:34:24 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::c4) by DB8P191CA0001.outlook.office365.com
 (2603:10a6:10:130::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 14:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server id 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 14:34:22
 +0000
Received: from debby.esd.local (debby [10.0.0.190])
	by esd-s7.esd (Postfix) with ESMTPS id 8ABCF7C16CC;
	Thu, 21 Aug 2025 16:34:22 +0200 (CEST)
Received: by debby.esd.local (Postfix, from userid 2044)
	id 84EF12EA436; Thu, 21 Aug 2025 16:34:22 +0200 (CEST)
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
Subject: [PATCH v2 3/5] can: esd_usb: Add watermark handling for TX jobs
Date: Thu, 21 Aug 2025 16:34:20 +0200
Message-Id: <20250821143422.3567029-4-stefan.maetje@esd.eu>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|DB9PR03MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: e611dc1a-1f5d-452d-16e7-08dde0bfd25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWs5bThYSWNJbitBb0VhRDdjcVBZTmFPT2FDZ1hVWXl0U2hueFBCUjVsSTk1?=
 =?utf-8?B?R0xDazR3eXl2OWUyR1A3bVNmaTVMYWc2RGVUektNeFRyZzFMVVFxaW9iemEv?=
 =?utf-8?B?bzlwZitpSHRucCsrV1VsZjNOYnlMMGdzbFJ2U2ozMFlmM2RxVlhqb2RZbmZI?=
 =?utf-8?B?WkQ2M3plbnE3Mk9yQXBGejFzNXJ3ZDNWbUNDdC84SSsrS0dwWEFkMGFIM2Ji?=
 =?utf-8?B?L2xLSUZ2Mk14TlFqTkpJcFRTM2lwVFg2WGpMc3l0MC9wT1FWZzI2TVBrdVY0?=
 =?utf-8?B?c3VlR3pMTG1lWm1Ra1ZNQW9EUFBrNlJ3YlBnSkFFZEhPYXI0UWxIdkFSUDIv?=
 =?utf-8?B?QXJEU0Y0Q0ROL2VTanBwWHpJMVFIQ2VXTEhYQUZ1YjE2L3JrQmk4cEdpcy9l?=
 =?utf-8?B?WUpGYSsrMVd2WVZUWk5BYUd5M0x6L2NjWldCR2F6cVFqMEhOcUloQldYbDFs?=
 =?utf-8?B?Y0JRdzhROUMyY0JZTkpoQ2tJNG11R1JsNkpkUSs4bWkrbGlHYmpScW5FMWtv?=
 =?utf-8?B?NjlXRVViMzhWVHM5L1FiNVd0R1UzSzNRdmZaWjZjZ0Fxemp0VVV6S3BCSWp2?=
 =?utf-8?B?aU5MbFJrWmIxeWVTZHhSSzl1eVZxcWxxRnVCUXVtQ0RVbGlxbzBPeXZNMDFL?=
 =?utf-8?B?aE41VzVFcGlZTW1IRlhDVmVWMityWklwOHZ3QUpPVGRkcDJ3amY4M3o4ZnVu?=
 =?utf-8?B?YTc4R0hTOENjUzBLZnZQU1ZlU1V1R1pjSEU3SCtPTGo0NXlhcWx5NUU0ZlBC?=
 =?utf-8?B?L0ZIKzJRVWNacXA1STNtTGF0TXB2dGMyL3Y0anEzZktwekpCdXZxVGp3Y3NO?=
 =?utf-8?B?T3dBY3FDeFpyZVA5dXJkOUkrRVRDTEFxck1qamRic0lCYXJ6L0VpNnk1ZUN1?=
 =?utf-8?B?RDAxUC9peDBoVHpmS0pLSTluWFo0bHZWYk0rZ0JhVE4zYS8rVHMrbWRuTG1r?=
 =?utf-8?B?MWppL1FVOHI3ZHRBM0NlelBNakxzck1oZVZTckFabnpQSUE4QU5SQ0NVd0tW?=
 =?utf-8?B?SVk4dmdZeTNickpneGhmcTRPWXl2QUJNU2lvTk00b0gvRHJ0M01KOFlYcVRi?=
 =?utf-8?B?L2Z2a0xUb0lqb0VQMnN3Z1Jwdjl2SUNCeU0zbE16cHpUdk1LZmZTN0dwZ3p3?=
 =?utf-8?B?dXhwVFBoQmVqdjArWk45R2RJdUdsWHMrV3pwZ0paVlQzR2g0cDczdDJ6UGha?=
 =?utf-8?B?ZlZLUGRNUHhiR3VSR3REcHhoYmlYOENMdjh4K09wby9EaDlXcnBqQlVoSHBj?=
 =?utf-8?B?aUs0eXBOVzFGNC9qciszRHExMkVkMVJCdkYxa1VNTW1ZYjdkbitUQjZ3WFBU?=
 =?utf-8?B?NGUrc3J6bTc3TndGUmVpL1JCcWF4cW5tczJlbzkzSlZsUzg4S3lOMWpEZG80?=
 =?utf-8?B?VlVIb1JpYWFaQlh1TTgvak55UkxtdGMxQXZWMElEYlJUeTVqb1l0OHpkTWhG?=
 =?utf-8?B?YkpnMC9rRXkrQnA0TXhKVWRpbkxPTDMzb0UzRTFYVEVNcGN4Snd1QTdOSkps?=
 =?utf-8?B?V0toOEs5elhhN25rL01Edmd2KzB2enVmb2VIQnRWVW1mK2Fzb0pjWklGZTVT?=
 =?utf-8?B?Tml6R1VoL21NT2U1cXlvMDVIQW5TYWMwTDc0OTYzc3RhVXc3L2ZrenVZLzlo?=
 =?utf-8?B?bnpkb3JrTmV1aW11cmVYTkMrcllJR3AwQ2g0UHNNYUhPSUlzTVFFYUl5Tm9h?=
 =?utf-8?B?NkRBdndmN0RqeFFFQ01vQXBpWW1mQU1jOXVGbktQZHQ0TXJaTlRzRzN3d2tn?=
 =?utf-8?B?QjF3NGNpdUsvR0pBTWNpUUtRV3B1aTNRczhiNjBOdmpxblFoRFZoWnU1OGcw?=
 =?utf-8?B?M2o1V2xjM3dZQnZGTFJrN1hLV0xTZElsMzg1ZG9YQW45ZWN5cHdyNGNqSFJ3?=
 =?utf-8?B?blVsZUZZZ20vNS95Z2tOWGdFZ3JvOXhUL1Vrc3A3VDNoZERkUzdBcXNibDRH?=
 =?utf-8?B?Um5CYU9SVWw5T1IzL3JxNjkyVEo5NnRBdzh6SWVNMENxY1hwRzhtaDlKQnNm?=
 =?utf-8?B?R1VTQXYvWlBrenNhRXIvUjBvUVBLVXJ5U3FWT3ppMEZpdi9GN2JIUUJLbWxB?=
 =?utf-8?Q?qAx+12?=
X-Forefront-Antispam-Report:
	CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:34:22.8029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e611dc1a-1f5d-452d-16e7-08dde0bfd25c
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7276

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

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/esd_usb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 4ba6b6abd928..98ab7c836880 100644
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
@@ -987,7 +990,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	context->priv = priv;
 	context->echo_index = i;
 
-	/* hnd must not be 0 - MSB is stripped in txdone handling */
+	/* hnd must not be 0 - MSB is stripped in TX done handling */
 	msg->tx.hnd = BIT(31) | i; /* returned in TX done message */
 
 	usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 2), buf,
@@ -1002,8 +1005,8 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 
 	atomic_inc(&priv->active_tx_jobs);
 
-	/* Slow down tx path */
-	if (atomic_read(&priv->active_tx_jobs) >= ESD_USB_MAX_TX_URBS)
+	/* Slow down TX path */
+	if (atomic_read(&priv->active_tx_jobs) >= ESD_USB_TX_URBS_HI_WM)
 		netif_stop_queue(netdev);
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
-- 
2.34.1


