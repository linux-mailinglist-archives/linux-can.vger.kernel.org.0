Return-Path: <linux-can+bounces-876-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4883791C6F3
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A86F1C23E1B
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3471770E1;
	Fri, 28 Jun 2024 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="Ql9YV2KJ"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2107.outbound.protection.outlook.com [40.107.104.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972B77F08
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604560; cv=fail; b=EjmcC1ZcR8nmDH8rmwJLQWo/CY0zoQvShUCpos77NwNO1smTYYjWwu+IocdQsmuRvJxqm5raRbbX3zCrcwYl5HP9r8ZEDg1sTpajpY8IVErKSNKAGkz2vSlNQPEFaPd5i1mLN7fnfiVv3ZjznURav4n+en/AQley2d/UpypQRTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604560; c=relaxed/simple;
	bh=AasPA1wIbMbq29ypxacSHHR6qcOdVxcHwijgwGzWJ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TAc/qQM9FHRSIcmIbY5tl4rVAtGR4NYUgsMVL/lPN4kLbU4E/LDV3bDh3Vl/IM4OGzBGMRIdj05jITWBn56LHC41ShH4nPYNf+GHd4CD4Nc4IimFzrl7gOBwu1oRPRuL991BXQisDLhp0mIid/XIll6Yikzui8I2ZWiOcIVysW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=Ql9YV2KJ; arc=fail smtp.client-ip=40.107.104.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+7wIFOfGEJmNjxqgcm608MkhVem8Mq0NuQE784BAaQZqphhr2vhEIM4eYlxDPW9xdUZZ6mvT5//nxbuuXphY4rbpbW+nShYvbU3/lBGoZNEOkJai2AAQdjQTAuzDBFkd66QyL+pSQkjzJOlo8d18S3kSrZxPZWKzlG45Ft0qGc0vM3yaZF3/dMbfW7qwRx/dpXOXDbmJviRl2bE5ssSSMqo5cEy1h20YKAwsl24/rUjnSBpoI7hNyNcHFaAw79apUH4kfHYvWbAn1fhJhvLdlZHAjqbKsPnef4jLoMRra3bv3gVPh1LISwfIqv2SqsaRbk+KG/GNN71dh2XAQgAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoxOqi1cuJrFY/4cRgcf+RoctFoXA2Vl3ASTMgmf3/E=;
 b=QoFX06/F//FOwdH770s21NrXbOpZXGArGhZ/JhEswMyG6RUdRAtTywOvk51xWvK8Wkb7+2Du97kQZ20HISoek0dtdtHodupc2B/TNKnoCLu1eHGzWBGFR8s6c9iV/bSeHpSrqmE+rJ7vygoot+cFjkuAXvElVWruZJhRUn1+OmDv/hzKLGPBYqbDtSvVPF8GtBD0RhMNyFbIvN58LgkFCwNwO5VaIO0qowHbpHZWTjnXhufi5D2ZxeYBrEZ/dany+erqHTaYP10hZGTHn/geW6046cobJIigjrIDfQOMsx9pRlSxPiaYujwl6ICtGolu7h9L8joXdnXmVH17EIyHkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoxOqi1cuJrFY/4cRgcf+RoctFoXA2Vl3ASTMgmf3/E=;
 b=Ql9YV2KJDRiedKnLDLO3u5CHTvo2Xe4J4NiQKPKFSpLTulj4r0iV5q+Ygd0klYjXf4ErpDY3C3znXMOQ9d6TdxNlY1Te1mhTOVOakz7NpIjfmgMbWyY3VGakxin/QAWkORK7RWnhfv7SmALKer1aGojZSmW4GWCehu/Er5NhxAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1142.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.38; Fri, 28 Jun
 2024 19:55:46 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:46 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 09/15] can: kvaser_usb: leaf: Add hardware timestamp support to leaf based devices
Date: Fri, 28 Jun 2024 21:55:08 +0200
Message-ID: <20240628195514.316895-10-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628195514.316895-1-extja@kvaser.com>
References: <20240628195514.316895-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM9P193MB1142:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d901e21-7e5b-42a4-40a7-08dc97ac4ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jZvqfsK3CwAHVLYBkegZZQPhRbFY5XcZ9rcP4xjjSen9egx+mEipXVLev/F3?=
 =?us-ascii?Q?B5KD53t6fDakIGWReahmRvy0Li/QveRJSVEPj8YzEzNo9jdPSXZny9RlUypf?=
 =?us-ascii?Q?zJPVWRaxD6ttpw1uTKR0vRaWd+66P5sOK3WVhKo+K5PUWJ4ZXRBFiGN1yxrO?=
 =?us-ascii?Q?eC/+4qze9d3Or4+uVXzJOE833bHxGiKUMSJTvM3RaUFZM9DfCKyLrCt20F02?=
 =?us-ascii?Q?awtAOYAmvMHUCgVo17S8VNMQbsrhMJmT5so37ktQ/WpQuMuuGpgJUaYk8zYx?=
 =?us-ascii?Q?zzVV750Q3TYtdO8k9ik0TTYTfI2onuxe0gZXUEKqHV4YLA3ARhGWHNranRqi?=
 =?us-ascii?Q?mwSMIZPUJ5diYCziRrjDSR7sLy+kjtjDNIr+I43xkGJ2ucux3WRUbKVCMGlP?=
 =?us-ascii?Q?UXu8/xG0OVo9OeA4sO74pcXUtBVCBMzS+nj636THckezYw/Z8J1dZDNa0OYE?=
 =?us-ascii?Q?g4nmPtSlRajFa6Y6QJuw/AOsRieK8P8zIrqoZ5urOO4hPf0Y/9qLGY3SRj9z?=
 =?us-ascii?Q?C8lNTVFw/2JoYWvVUzuUQyv8PnnYpLtJDmG2f/F7aRQZcDuY7N4tgzq9OecH?=
 =?us-ascii?Q?0wehUtm1nEe3AZtcBalDV7Gy5QS2TOdai4KlQC6xmTTd/8Dc2AAFUrmk9TDE?=
 =?us-ascii?Q?VpjmbrdnLjTtlb/6wdTD2B+SDOQ23uZWCBvvo4V80WDlcgjORtramRQTNKbb?=
 =?us-ascii?Q?GqFgh/eSoQt7MItzTOZraIWkcM2gSZm+TXDhFor6ywWygG1551QkS3urf8Zu?=
 =?us-ascii?Q?eSkPJ0t8fFfcVN9dnMyy9Za+lxi4gVW52hR7/PQ6S/EvL9r9b5urLy0WfLpM?=
 =?us-ascii?Q?dvqPvSdt8G79/8Xrh6JfkkO0fNGTDqQieQS0M64XKd306vL/VV3FfcnIL5dz?=
 =?us-ascii?Q?z/DNu0AR260HLzWntpj95fbh9KZJokHCfbLla3e1/sAK8IGVSkr/3S2NgfqU?=
 =?us-ascii?Q?c0WppkKlU7IsFUBQDsFD9VgPYi9UqtuTw3KJDy4Ll2j0nkj5B9f0imFcl36S?=
 =?us-ascii?Q?u+4k9Xs/MltE2HSd+N3c+oTcKS4XMBWzuAr8xB/O7UNKynq9fgVWj9l+1M72?=
 =?us-ascii?Q?kI2dssGa5MbRALEauRtQnGxwe0WlfiRFT9EsVixXcnaqf1XA2O4xgv6EFrpk?=
 =?us-ascii?Q?XA9xpXq7f9yHYUskw7qRh8TIvUrMIF4tlV3M/OsQRibP6ZWPzPeQ7F2scE7G?=
 =?us-ascii?Q?Q7yU7ynGsxGhAkPjZKSqNqUKab7RLQ+TplfSMchVPE6Xh3M0zlVyMR2lWqa4?=
 =?us-ascii?Q?nSOEfSfX1btba5KsdQkVcuWhSzc6atplBHcF4L/nz4YP+NzuWY9X3DoC5V1h?=
 =?us-ascii?Q?bzP1PhS9NFVUiXsQQcapx3NiJkjE7QFLrJXhf70UQ7Vk5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aQESleoZeJ250RatRc8myy219zzVvlC5s5O2anix/7ulst72be3g7mG5wLkm?=
 =?us-ascii?Q?JPimxyLRV0zMRuj9+OK45HpSt7upGO8MeN5eV7TbiDn8zpdO8xEORlL0W9Y9?=
 =?us-ascii?Q?CBTetzUl4dDW4HUMV9Pv8U0Sp99pbE0r/XRb5ehXMWpeCvRfxR6TUu8hbylY?=
 =?us-ascii?Q?sPj+DcyKs2Fs+HmNGT1yRgwmmPBvPryhMO99cWY6THCJR7kcUeGRPNQd6XUR?=
 =?us-ascii?Q?FDaWRPzyloDBUHG4Q2iAI8rXgTQxBpKxSWz/i1wJcO4P8cgpyf4R8505ytxL?=
 =?us-ascii?Q?jzX/p99LKWZIj8nN+J5ZAu64Sax+5dGJ5oct0Mvk9lCLEHWQCdV1VnNABvqe?=
 =?us-ascii?Q?orLfM8BMWR/HHi/MSRSSr4UEljQB/H7VQitX1VpfbzT9yWY3+yxnQmH+Q3Oh?=
 =?us-ascii?Q?hbVMwnxvvTyQtXQRaDIvtK7Q/RgFtb4IL8s68w0k/LbFXIsRgL7fM9kZmR9e?=
 =?us-ascii?Q?zZ55WCykceWKc0XIldK1GX1kYQJeawdOe8w5cvJFKiVzSU/JjXwcc/bs9UtI?=
 =?us-ascii?Q?UyhtMEDElw2SmL5EOXapmoZcr06fh/LJHyIjIOCKP+usuaAb9h6N1hHk4F+A?=
 =?us-ascii?Q?JrlG5l3dmxnJNahQziC+HYBER2TFGC8Ou/u2NKdmU1bBjYP4S8OIzwGJyjmX?=
 =?us-ascii?Q?VyvDjjAkrn9eies64HPFiqCOeIaInfJxAkIE74j5G+QVjx2QLKCkOPxdTuVQ?=
 =?us-ascii?Q?LCTkf9zojC79/KyHCYl6BmgQqUE0tVFlF7oSgixfbjMysal8242MYMOt8HwQ?=
 =?us-ascii?Q?fcgvicQKB/tN2SYy8wBHy3IBFNUMmUcKp7GxS9GFqiK/noVBu3hJC8rO+R1i?=
 =?us-ascii?Q?/mIsv2FSn4Z2odobMsSTyQWnr+JN6qazXRCq6D5MwVTGbdWBBFPy7HkDbp/z?=
 =?us-ascii?Q?b3iZTbXVmsb8nR0AS2MoNqQB/awTKI7qD2gCglz1GDNp8KS/eR1bKPDWE+sl?=
 =?us-ascii?Q?gohssezLZLsggDrABTKTNkpAG0qQUoSF0YL60hs6qDYNzRTsNeoNapxGnokP?=
 =?us-ascii?Q?r+kigcLQxAzr17vkRoOO7QEwfeFf8VWZrHv/jDVuNJwSZPEdUM0rT/9+BmV2?=
 =?us-ascii?Q?R7in1ciVf6FOIql477VBhVt51+3/lUHKOfwd726xO4rf+ipo4uV9kWak9r/m?=
 =?us-ascii?Q?LLU+0OM/gT1tAY8uZnq/rWaOjCKD8IGWcMI6olN//ms2CmldXAHN0axU3hC3?=
 =?us-ascii?Q?b9+Y904WGGKgXc4YrUHZZi9H1XUfTUrePLwQArstrh+9Vo8YxlFFCtsVT1PW?=
 =?us-ascii?Q?dl2ZznyckJdXhO2M5wXS8JCUrWsyXh5D5YI/da6xksvzaMgmEtIDbbO3zBIc?=
 =?us-ascii?Q?i9Oh81yIvMwUSXfqLIrK3ptjHkV3gcglHuSXv5cH/ps/R8rqolGgQ7I6IS/a?=
 =?us-ascii?Q?vvoJIf3sypu4NmiUkSCOEp/gg4kpNDfG7QQDc1+rMNmYs97UT9hWV+RePQLh?=
 =?us-ascii?Q?aYZM3nl8wQ8MVTZB17ytdDn3q/5DW5bYa8aVpLCIBGBYXZq81ig0kNPDX6z2?=
 =?us-ascii?Q?Mf+JCIqPVEdIPqU+OkcuqkxCAWWRZf6Ii2cNsaA/ZDQhoYELRgsYq3Mw8X6C?=
 =?us-ascii?Q?ry9IwoBwHletM/24ezW1XsKIPpS/srd0a3KQotmz?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d901e21-7e5b-42a4-40a7-08dc97ac4ce1
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:46.0581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5udh6KdDpCIlK+h9J7ustn6X8IHQvfug+84j61Q5ow8doGdpllUGLBY37UasRWp2iV+DpU9VreXlco469EFNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1142

Add hardware timestamp support to leaf based devices (M32C and leafimx).

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 11 +++++++----
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index daa34b532aa8..b5d762d38d5d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -106,14 +106,16 @@ static const struct kvaser_usb_driver_info kvaser_usb_driver_info_usbcan = {
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf = {
-	.quirks = KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
+	.quirks = KVASER_USB_QUIRK_IGNORE_CLK_FREQ |
+		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
-		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
+		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ |
+		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
@@ -121,13 +123,14 @@ static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err = {
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err_listen = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
 		  KVASER_USB_QUIRK_HAS_SILENT_MODE |
-		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
+		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ |
+		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leafimx = {
-	.quirks = 0,
+	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index caef1f26a95c..c0a8713d8cf2 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -915,6 +915,8 @@ static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
 	struct kvaser_usb_net_priv *priv;
 	unsigned long flags;
 	u8 channel, tid;
+	struct sk_buff *skb;
+	u64 ticks = 0;
 
 	channel = cmd->u.tx_acknowledge_header.channel;
 	tid = cmd->u.tx_acknowledge_header.tid;
@@ -954,9 +956,21 @@ static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
 
 		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	}
+	switch (dev->driver_info->family) {
+	case KVASER_LEAF:
+		ticks = le16_to_cpu(cmd->u.leaf.tx_ack.time[0]);
+		ticks += (u64)(le16_to_cpu(cmd->u.leaf.tx_ack.time[1])) << 16;
+		ticks += (u64)(le16_to_cpu(cmd->u.leaf.tx_ack.time[2])) << 32;
+		break;
+	case KVASER_USBCAN:
+		break;
+	}
 
 	spin_lock_irqsave(&priv->tx_contexts_lock, flags);
 
+	skb = priv->can.echo_skb[context->echo_index];
+	if (skb)
+		skb_hwtstamps(skb)->hwtstamp = kvaser_usb_ticks_to_ktime(dev->cfg, ticks);
 	stats->tx_packets++;
 	stats->tx_bytes += can_get_echo_skb(priv->netdev,
 					    context->echo_index, NULL);
@@ -1334,6 +1348,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 	struct net_device_stats *stats;
 	u8 channel = cmd->u.rx_can_header.channel;
 	const u8 *rx_data = NULL;	/* GCC */
+	u64 ticks = 0;
 
 	if (channel >= dev->nchannels) {
 		dev_err(&dev->intf->dev,
@@ -1364,6 +1379,9 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 	switch (dev->driver_info->family) {
 	case KVASER_LEAF:
 		rx_data = cmd->u.leaf.rx_can.data;
+		ticks = le16_to_cpu(cmd->u.leaf.rx_can.time[0]);
+		ticks += (u64)(le16_to_cpu(cmd->u.leaf.rx_can.time[1])) << 16;
+		ticks += (u64)(le16_to_cpu(cmd->u.leaf.rx_can.time[2])) << 32;
 		break;
 	case KVASER_USBCAN:
 		rx_data = cmd->u.usbcan.rx_can.data;
@@ -1410,6 +1428,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 			memcpy(cf->data, &rx_data[6], cf->len);
 	}
 
+	skb_hwtstamps(skb)->hwtstamp = kvaser_usb_ticks_to_ktime(dev->cfg, ticks);
 	stats->rx_packets++;
 	if (!(cf->can_id & CAN_RTR_FLAG))
 		stats->rx_bytes += cf->len;
-- 
2.45.2


