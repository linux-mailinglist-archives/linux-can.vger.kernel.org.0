Return-Path: <linux-can+bounces-932-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DE491E4A0
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645432811FD
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A87D16D32E;
	Mon,  1 Jul 2024 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="YSJ8CmBF"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2097.outbound.protection.outlook.com [40.107.20.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C44F16D4E0
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849018; cv=fail; b=kVzZjTkNm7b7Y5T0W8Sx0mRlteR1PGCKIBshd+TfiIPU2TQCmDrlL68gaxOvoFghY6VkVkbkvfqeMa2DpS6C4Oxk9gW19ZQqsxo2LtAnqa9lMwnrBnSl5V6epwlNPthVk22l0XLCQWaaJszQ2jdJKPEGvoaYiHc/swt2Lno3Ts0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849018; c=relaxed/simple;
	bh=nHqIfFdd5Pn+MiaUYNx99if5JAhi4xPgkv8/0/H+ivw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KWF3FWCvVII46YC60ZNV5h/KXPUFJrIWSxjbXsEJ2C5X7NWuP1sTO+yVCvaLPrcV9DGSn4VbeYWHWo4+wYDYTrrejIWAN7hFmYux0JxWv49TT4ZSJqES1t8DdHtsao1zmUYRgn2wauWQJ01cu3MrFssHO0DNLzbhKE3u+OG9riA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=YSJ8CmBF; arc=fail smtp.client-ip=40.107.20.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYXKpR66YqIU7bld3hAdh58bFQaxqwAwMx2p4jNwKq5BfQ2RlgIk/yzSGdx89kQ+LQczdbNHRfw3i27FCB1PBzrRnwOgvBDojFxdEJ89wdOrqbfGGvY4iGpB1VORTpxy7Lup0AA/GiqjRzVMDWiCHmVA/HCRgmplJRuosm93gE4MQCCtfWW/cKniWfRLUzOX6+aR8IQrLuvd9LvsQnGLMNVJq66xPa6Y1F+vWGfuc/mbtU6dzlxjukIuAi3TZWC9H3cmqc5FKLuIqjNOih6AXr7/ZEGha8HTAO9AOV9nHGm59E7trp68iLI19pmwxF06mGOsUPWrXijVRo4LznczLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOifEDqaRqy/U95eu+4SmdiPKcRGkEDIXSn/55EtjVw=;
 b=P0VbfIKkT921652sRnkZcYfRNnCiB0U/QXtbbChbHJ2luni4m0taqm1bQHzkHYMJ8qS3YBhsKyvj4oqMCquZa6PBnM+6OlddwIHwKID8k+CaVhF/YKx4XbBfRBaSlT8Hzyu+gfNwj1ZdDdeRfsHxs6yYYNJa4XBIRqCH3X6SLdHOhD5U6usSwfb4khE5TObbsm+zjeH0imep+hQ7dak24vjm2HOibl/jM9vCgq0FoAqZBrZoJKIlLogjzZipxZO5wKaa/WXQHsKKvjKfKuguoLLqfdPbmm2LTnPW3uIfv+9klD6+B4DFy9PLxES7lmSgho1twEwkywZ9buvg56/iyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOifEDqaRqy/U95eu+4SmdiPKcRGkEDIXSn/55EtjVw=;
 b=YSJ8CmBFiO9tEo8CxVBdKkstHuJ2o6IZBkzYK3fImwQhLGevdTh5YfAEIYMar9eDJvmtJMwRSV/YUxKZoU36mvJ7lNimt3LMUM+NKgng2/akzvVaczcRh+UAuIOMVGaQ4lTEpxjfHbeuaUxj6gOXaha1nLUkH/M3FRySB6PYpvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0519.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:50:05 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 15:50:05 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v2 12/15] can: kvaser_usb: leaf: Add hardware timestamp support to usbcan devices
Date: Mon,  1 Jul 2024 17:49:33 +0200
Message-ID: <20240701154936.92633-13-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701154936.92633-1-extja@kvaser.com>
References: <20240701154936.92633-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0519:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc2de15-f7cc-4c07-e223-08dc99e579d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sDQrHgsGix2HecG8fmK66/fi009+9j7V8JmmiWjTvkNaVvv1o0SPh/qaWntr?=
 =?us-ascii?Q?E5BIGyxXo4MX1tnsLbHSqbqhLYazm2TynxYLkxVtdW7XLbgRY6VDHp8MigmV?=
 =?us-ascii?Q?Q2kKKAv9mLXkZF8aWV7GrpWZr4kyVDjtAn4/zfD1+EFbaK2svUpMzM12acLM?=
 =?us-ascii?Q?Z6oRFAlKsI7/7a0iF/2hVzBrX9xYsGgQKEKYX+M1L2zSwTE1QRsPv/ayMZdp?=
 =?us-ascii?Q?J2vog3ghSHL4k6CMwIhL4JBZ6u+J3/nbW7Top0ZbAyNhkpNPb/AercdVuzFK?=
 =?us-ascii?Q?eaIVCsxRkwcQuT3NYkrFxovx+Pl3MUuPRtwNPNB3qtqRYHsDD0lHQ7pmdA9w?=
 =?us-ascii?Q?KjO6GYiQivotzizWiEnRB9R0A99dvCHlbmIQg7L4ubb3RdoGkmzSmQLA7VgR?=
 =?us-ascii?Q?2ZZQR/xXoomJCsd6Td5BWWUQB2ozOLfP+Y6eKZZXv0W9ENW5zb6Tj1b9NQOg?=
 =?us-ascii?Q?6rEi55rNCydH18Tw9ZttB1CghZp+NXqCWel7d2xvF0TqF//LBwsF+G3DpZJC?=
 =?us-ascii?Q?H/rxjErfYa6cta4mzaaDHdZBvue4eVx0HejKqzpPcuasfBZBLNXR1k4VjVfG?=
 =?us-ascii?Q?eq6ObFw/9rKRYLtSJKoeUbSr+c+QVXvgQdgid6pwEno0XDvryLIltoScBZ8S?=
 =?us-ascii?Q?PbKnsWGXoUNZK2txVc9L4SnHEl6i8YU7dZiKwcTJcF2x41RdyMe7SjooDivk?=
 =?us-ascii?Q?jqEPMCbUyQZAeD/Un/Qzsy35mIapN3lymEFd5L1JD6YD+j8cZGhg0NAVUZb/?=
 =?us-ascii?Q?HPkfZDwqumDGGQQTXTbDsCFOrSfQ4eR6URG/IzKSFd7WwPfUPTsHWukRS+mS?=
 =?us-ascii?Q?yYigHtiHK03LOsO95F+RSBSzPt8gs5IiTIUJSagNB6KXqEae0iYEx85Awbpp?=
 =?us-ascii?Q?J9Vs0zdfDnIrPNvti6JN4UYckXyJFrQDWg8x3PIuq9vCSlyC1N5xEs4+PLec?=
 =?us-ascii?Q?vW/OYiJYA9mbnhpP6ysOwVUznugPyaqC5/+QDSRfsvoyveMqQY/NdxcKfPPK?=
 =?us-ascii?Q?u8pIp6KLoSU1ejKwfF9bvqT01ydll3jbcGtb00iDIlTOQyP902ki011SZvTY?=
 =?us-ascii?Q?Dq3cLm6uHEpy89HLMKUWvFDG1qckmTmaac2UMWRE60Sbh3tXj32Bq++AoOmp?=
 =?us-ascii?Q?qXzjA4l9e8t7ItsKbn/ovT5Oxcp/us4ay0Nk7XCE+GfG4ewYSrfDozTD2mcF?=
 =?us-ascii?Q?dCm4Ox+k8AaRQNEQ/mxbEHNXBtkluM5Dd9PtspGDEij+ZNtaBgXxW+Ma9OOZ?=
 =?us-ascii?Q?XeiTwq9g4h2EcsHnWxEqnDJuKNBDWtSPwt2aUUUhAqP/5tUjt7ZwQtEry4xr?=
 =?us-ascii?Q?ANj0UTgzgZjfQgJka0Et1LxePq1tJmNhhB82+X+keIu1bg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q3RLvxhv8GYEZ6N4MJYW0cGIJLSyP2gOwaI3fs5xBBA1ZPGoYdSl830NSQsK?=
 =?us-ascii?Q?PtBbQKq/1Cc59cIbV119+JGs52TOTQxo5mgf+IATo1xAyWSU5I0hfHqIOMUB?=
 =?us-ascii?Q?gX1ZR0mBchyZZ8faQG3B91W6wHy02Avo3UQJYV2g+gtwvWMuw4vzCa/YWa0r?=
 =?us-ascii?Q?2lZBMxnBYC0aXM0PMQcH+qgSplvxDAs+nphDor5qDl+yMApQu15cW2vMXZN9?=
 =?us-ascii?Q?AH7gZYYcu2k3FDJB25Uwb6hhwmotiNL81u86Hw7YeBgofTkbzfJ53NOAO6L8?=
 =?us-ascii?Q?JZi5ukI6po9/8OELyOnRcBhkB5eBRqRWEV3Axh8UbQ8iH69Fbj/KR0s1xwI4?=
 =?us-ascii?Q?rO9MovUPo08HRTyaRmnDyUn65zLCEJ76jVmO6UfRJjLk9hael3+xxG/amqQ+?=
 =?us-ascii?Q?iQJWx3S/uzSwoBO6WlWtH1tanB9pjR/zZssP/hoZJNovmefN8db87PQHdMvF?=
 =?us-ascii?Q?LaXDgqwNI2Uw7oU8muOhCSTQ8hR+tq0gMyKn9OmMVJ1e1wB11HAF7FNT7V0p?=
 =?us-ascii?Q?K1Eg+WaF8AAbJvwH8gxSgRqFeYPf6cDQ+pyK1UZKy8WO0I5I9b60hOJNtAI1?=
 =?us-ascii?Q?NfVRALS9lCXvm5SoiHBZSiNkRPDI+Zsg5h5UAJ48os2+eI5DtTbWyz9N4b+O?=
 =?us-ascii?Q?b8db51SEGwLjgpH71LNCDwkQKsqKFbTCsLkJm73aQ/I/J4SoI03yworts8b2?=
 =?us-ascii?Q?bOsxf7L07ulne5dTbS8pqdbKTjl7MiGGBuVRy9ZRZhGmKN5FSuQtpY+OrYeN?=
 =?us-ascii?Q?b73TG50Ji0+C3t+LD1If+rfdlMRxU1BBh+bIOlZ/8xcWKdn2E/moHv0hkQ6r?=
 =?us-ascii?Q?aeVIJiNMrkC24C1jEwTqmeVo3BDf/zIz1mKj7vmKNIqaRYg7j6tVFojNoysh?=
 =?us-ascii?Q?BaF48wSZWNGcN4u2sYAWH85p/qlACg4UhsMqaOZ7H03bVBomMNyimcAykDhi?=
 =?us-ascii?Q?OShbFobP81uUfrj1Y3I3wS/pgt7Wiwz6yCIXG5l2en99Mj184YsWt2t8qqsY?=
 =?us-ascii?Q?l3CYJE2y7H15SyxRh/R9BUSAfGsCFM6Yix9oqz02c7Fa593OzXZ/OGpo0agB?=
 =?us-ascii?Q?R2B+Wvyg5zAOkDEpoO8VHitmkJDt+k58Te7zk4WM9F8Sj5FpzruCZMmqH5Nk?=
 =?us-ascii?Q?x6017+s+VAfujz5y8Fl4gIu5RTe8OLQiEhBIe7vMBrAj20TPdm23PdLs6JEW?=
 =?us-ascii?Q?M+PkGtAW3NvZUmQTEMcPaB3BsnUk3NXn5907dYnV70obP6B2ziM1y5nm/fJH?=
 =?us-ascii?Q?uaBWbULFiTAsFKpF/R1C3O+k93lQI/xsPQWN2YI3yCGzah4CqTmG0/u4VNrv?=
 =?us-ascii?Q?P1MZ5rqrSUvGSw1s9/9Fkm9ko6OzgPD7B6Hc1fuER8b4uZBVoYGWHJZux/ou?=
 =?us-ascii?Q?dJpYi1dNwlLXL5uHvzGHUW0ozT0BF2UTKEpW+wH5iEZnbqWlPaP15Ym83mhp?=
 =?us-ascii?Q?FL/o48ukNmN/WppSidiMTpJP0+8ppIthIpUp6lb4rSqb39ny3T3/jClkb7se?=
 =?us-ascii?Q?Tph/j/hB8QeTvejiX/qoeJsXurR25o4CtG9kZ943ipEMJRbamwQ4Ihgq+Ve3?=
 =?us-ascii?Q?4hFyYEr5VBFzqrazh+Pc0mQvtpV36inNCGxPFaEl?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc2de15-f7cc-4c07-e223-08dc99e579d2
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:50:05.1077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NwiWgL6T1HLzhghKawknAaPhWZq00X5J6epXrSo6OxLHG/O/2RqAJxYm+ZYXcG5gueyIW7cSj7JJ8vTgFrlVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0519

Add hardware timestamp support for all usbcan based devices (M16C).
The usbcan firmware is slightly different compared to the other Kvaser USB
interfaces:
  - The timestamp is provided by a 32-bit counter, with 10us resolution.
    Hence, the hardware timestamp will wrap after less than 12 hours.
  - Each Rx CAN or Tx ACK command only contains the 16-bits LSB of the
    timestamp counter.
  - The 16-bits MSB are sent in an asynchronous event (command), if any
    change occurred in the MSB since the last event.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Add new helper function kvaser_usb_usbcan_timestamp_to_ktime()

 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c |  3 ++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index b5d762d38d5d..576ddf932f47 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -100,7 +100,8 @@ static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_usbcan = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
-		  KVASER_USB_QUIRK_HAS_SILENT_MODE,
+		  KVASER_USB_QUIRK_HAS_SILENT_MODE |
+		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.family = KVASER_USBCAN,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 465707174f2e..6b9122ab1464 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -121,6 +121,7 @@
 
 /* USBCanII timestamp */
 #define KVASER_USB_USBCAN_CLK_OVERFLOW_MASK GENMASK(31, 16)
+#define KVASER_USB_USBCAN_TIMESTAMP_FACTOR 10
 
 struct kvaser_cmd_simple {
 	u8 tid;
@@ -536,6 +537,15 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_imx_dev_cfg_32mhz = {
 	.bittiming_const = &kvaser_usb_flexc_bittiming_const,
 };
 
+static inline ktime_t kvaser_usb_usbcan_timestamp_to_ktime(const struct kvaser_usb *dev,
+							   __le16 timestamp)
+{
+	u64 ticks = le16_to_cpu(timestamp) |
+		    dev->card_data.usbcan_timestamp_msb;
+
+	return kvaser_usb_ticks_to_ktime(dev->cfg, ticks * KVASER_USB_USBCAN_TIMESTAMP_FACTOR);
+}
+
 static int kvaser_usb_leaf_verify_size(const struct kvaser_usb *dev,
 				       const struct kvaser_cmd *cmd)
 {
@@ -978,6 +988,7 @@ static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
 		hwtstamp = kvaser_usb_timestamp48_to_ktime(dev->cfg, cmd->u.leaf.tx_ack.time);
 		break;
 	case KVASER_USBCAN:
+		hwtstamp = kvaser_usb_usbcan_timestamp_to_ktime(dev, cmd->u.usbcan.tx_ack.time);
 		break;
 	}
 
@@ -1398,6 +1409,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 		break;
 	case KVASER_USBCAN:
 		rx_data = cmd->u.usbcan.rx_can.data;
+		hwtstamp = kvaser_usb_usbcan_timestamp_to_ktime(dev, cmd->u.usbcan.rx_can.time);
 		break;
 	}
 
-- 
2.45.2


