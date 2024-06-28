Return-Path: <linux-can+bounces-874-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA9991C6F0
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 21:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF87B1C23CE5
	for <lists+linux-can@lfdr.de>; Fri, 28 Jun 2024 19:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E9A7710B;
	Fri, 28 Jun 2024 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="ei4cpmXp"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2107.outbound.protection.outlook.com [40.107.104.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E49777113
	for <linux-can@vger.kernel.org>; Fri, 28 Jun 2024 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604558; cv=fail; b=gFyCQCuM9keuI2DuEwZJOjyTQRe7TZnIjphj6OFZIkHALdSOQK1SxdxNRqbZfSkXYUvwbknWyDSJXjsKoKPNDr0KZcCzxk9HIXej9ObJUqXFEc3A+hd6q3tAZj10VjAnB7tQSfzUAYENYh8aW+AAduFzVIAvclSRD007uOcHg38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604558; c=relaxed/simple;
	bh=h4wuG104ze7OUfEz+xHx2k7Ncntg0FkGU9Oyo7j84BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k+LoXpu5xYpqQIyJ1lKZBo7yihgqO4a+mpvz02rs0oTba5WyMVyL/ak6l/OfEuu5h5pr+IqzT5rpvm1y2/3vO1Q4LJyX2P+i6D+9auqcSPl0Sh0yw4XmdfXdBalgnMr3Ck1KknaU+L+oogaarfY2IgjTMDEE0kyMZv0zXTAI4ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=ei4cpmXp; arc=fail smtp.client-ip=40.107.104.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGeMjXoxzoqmSvYRXh0bwLRs3zVAcm8zQlZWYVxZaEii9ra9FumyLIuE77lr75ffZBHJWJjnQaswhWfaXjpCM+ZH0yhPv2nrCl3YGEWDWHt6Nm9OwmjrdlE0s6HXJ+aDX+s4e6TOL5Ibmcv6FA0CLWSRl/6CePkp+qQ54FKvezV1J9I96qZFz8QIYRLzF9eKkKma0nEOAnS/7z9YYCd6H6sUbyskjmbGwgpV+jY0MYYRZKv3+Y1v2H74W/TwlIIlNGj8P63GmroxyQQIkDEn9of/UnyvZyGcjteekyVtEhHFu63vcyipsEoGF4xmSLLWrdhoqYf0X+8BVb5UfyFxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=441qUjzTtNg486uFHIARNuDwkYz6cyT8RD0uOxLTOjQ=;
 b=iBEXXoLG0I/9NHaJvLHoHiQt/eC6jRfMU+wxfTpXRyQMYNCttP003djBZwdz9voJStGVvNZJV37fbRJi0FmQqJ5EVT7hEobtdXjoCBIzNFnJ5vA/hwfg44NhoQUeLD/fyGkGdboIQL5EMtmLmYEFZ5vBGRPm0xd2a0Xp8eCJyirHBFXlQxn7bZ56pOAcrXfKVQU3q6MAuV+cQ29tMh8I5eS5VNUYEZ6k1Rgx/VLNZOmUbdyKhksPtjxQwpnaAG1TkV3GnpEJdP3ytLtEJsrfIDixAVc7AN4ETNEbsrWi5rkgnXi3LDAT34fgG65COWWS4lDvWp2SfChgRBh8enWYRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=441qUjzTtNg486uFHIARNuDwkYz6cyT8RD0uOxLTOjQ=;
 b=ei4cpmXpMNp6ix2Nsu+XEDYPSQkhgGMEPepkAQuNttl2Ykgnbnwv5VQaOmnw+/6KjM0y9Xe8J3q1IQPeOSBSWO9bT1CHeVwbnKu5XIibHI1FVnuBciVDAoVutsjutMy/Zts2tAPJQw+Vb4oCfmELmR1jEWaZywiVJF2mgR53jEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1142.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.38; Fri, 28 Jun
 2024 19:55:45 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 19:55:45 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next 07/15] can: kvaser_usb: leaf: Replace kvaser_usb_leaf_m32c_dev_cfg with kvaser_usb_leaf_m32c_dev_cfg_{16,24,32}mhz
Date: Fri, 28 Jun 2024 21:55:06 +0200
Message-ID: <20240628195514.316895-8-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 75c1e0b2-c3d1-4aa6-1bfe-08dc97ac4c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Vlzkx6RyoblwZ2U5c466nOhb/o3/wp+Sq0bt8V9X+seUDQcDH4cGB1/Pd5G?=
 =?us-ascii?Q?HoZGrc2+6htZ9Wr5MPteQD3F9/qrs1v31/hZ+JGyf5EDo2Gb27fHRbVnUPUo?=
 =?us-ascii?Q?6jIZ6m2oeu3jn5UhLAPSlBDqWLTJiZH0937J1dTuUXhbn9E1Ao32DwLI9+Rt?=
 =?us-ascii?Q?aKwWdz/fe9LtaWf1gs0eM7GphD+rUAB9hs+Wlvu5Y3vs/Pk295nHmnkIX3EU?=
 =?us-ascii?Q?TCEyvIKKK+vrfLr4gP67iyUyJCMUHu1rt+VDnmIxApnoK8oy0am/cIFYbo/e?=
 =?us-ascii?Q?EpkTVMIOI+LRXMf8YwFz82RX8ySXWL6tVLaxQawJKR+HLBOVCTD+rDE8mLva?=
 =?us-ascii?Q?W7f/rGSZj8oI2VCIjf4yJw/qqJshis6GEoZeZAEalJPRwEpKRQBuxhhVR1IT?=
 =?us-ascii?Q?T5SCzodH5qvKJd7rNuv12PB/mbWldfTmqtfIwgRoDp9ps+7ZS3aupFneUJ6R?=
 =?us-ascii?Q?wqXmErWc6QaYLM9G9kNiX+tSjc1SjzFIX2o+FPFT3NE2MqiI57t+jUrtxSNJ?=
 =?us-ascii?Q?/pmoROPVTg0ucckbT1oV5K01sBwLZJ8IC/jGwYI1dE7QWXkO32JNOPpyF4fK?=
 =?us-ascii?Q?iPRyL8W2Iv8PX+f5cnFYVBGOAMtFdEkadfMyhNMSdK2wt4x33gS3Za1JRMzV?=
 =?us-ascii?Q?a9dtiB9YitROUAaAkkzbo5D+VncAqGMye7pJD2jyAkYZ6w1G8F7rv/zvsxm2?=
 =?us-ascii?Q?idUf6f9sH+p2h8H9uULRiiEr2b6kioyBFktnZDF3hTb20KQ4EtpcvXs+xLxw?=
 =?us-ascii?Q?BMz4W4IMt5EAzxNY8UHsZgY2TWNHfK6wfO6yijh7jNo343o+iGxt1HllyCH3?=
 =?us-ascii?Q?8Zh0QxXiXMbMyy62p101MuHMKd5u7/qYfY5Rm58o1UNYVFrG4b3MOaH306HO?=
 =?us-ascii?Q?/2l5bAyks1YRgs51Ax0DEo3HdBFEf4wVjr9UiZtwlCl4J9S3MBkcKhfY+2wq?=
 =?us-ascii?Q?O+tcNL1YMwjUzyBhaFxV5gFo61pVRSwxNsl5Q7X3e9v+yDJ+KQ6+NqW5nzDU?=
 =?us-ascii?Q?uKD6qj+lxeQ1l58s2eW8QeMHz7yYxVupti3ui0/ylQcWYrx8SG5eXz0zkzE9?=
 =?us-ascii?Q?Cy0tWaNwtr3fxH+GrAziuEHfo5eeyf386d8gVhfaVLhi+smGK3QpltX5sWQX?=
 =?us-ascii?Q?mrJjulipd1j048v3AcUwUr8NVSXVJzcnVVg6tNkhvXsBaCyHwLDgpSDaFCJU?=
 =?us-ascii?Q?UCHalnkn6Ml3Og4ObxHiLqiH+zYSQBTIh+Sch3xs6fgTF5FO+DcGU0dxuWGw?=
 =?us-ascii?Q?Ile97hJhHudFJMc/bjhJjA5vr46JHgU2PIKIYDDpzLR9rwVDBLHYzbzvMCcV?=
 =?us-ascii?Q?KDiB/L3RpVdgRenyioFxAZZf+7TCHXfLwbMH2tvVwB0b3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZpTCXjni8nSoSortK8jJQjln+zinzBx3EhuCUBgJu9SwtfJ7jgeb0TOdbP6w?=
 =?us-ascii?Q?hv2dKIztAR53c/18Z5DQeBVVwGP68gtkOlJlD7QqWUA/MNN/CC5+k0gdanm4?=
 =?us-ascii?Q?yWSa95VjPQL2ybZtNk+6yFJl1fPtalifLiPiPt7K+BOmi8FNCastcUsFcVyz?=
 =?us-ascii?Q?LyXGDYJhRuloAwy8ru0hdPaQ27xx5VS6kI9pIT33mbwGEpQlMy+40UTjMbzW?=
 =?us-ascii?Q?dTkY+NQICpIqwmAPWtiNJD7lcncLtC4ro8nQ5hTnYXB9wV+A9fpxKQ0mz+MO?=
 =?us-ascii?Q?TEmvPJeRnpl7nUbiaA7ZL8PvHUxuv79+/CXWx49VPAnpz2+CQljTHH/X2ALB?=
 =?us-ascii?Q?GY0QMXSdEXV01WGTJm6dKITV/qeA1+tnZXfobhXlpc6AUatDNiFjGD9w0kfD?=
 =?us-ascii?Q?OiVi5UsG0AFFIxgxUkRIDh/K60K2yZRpw3tXAh+ZcnlKltZ+Aq77u/UeikfT?=
 =?us-ascii?Q?LPT4UM8yuYeZHNkDXBnS9Dlrl8GKzvxIsKYK6jUhVfjZbVl2nNcX1PoG69jh?=
 =?us-ascii?Q?L75647/a5abwd5AQTMiZl9MPBSqHN+2MRIseITvMLCfs22ofqv+/SM2Sw5At?=
 =?us-ascii?Q?Y7r9Z7zawPNkVuqQDF9Pbi53ag/mfQoZVjjGniLdqIX2LQQWx6BpK1R5h9e7?=
 =?us-ascii?Q?3KZ4LK7oKeFJYe8uJEEsE/5d9PzqGRNE8sCiXgfLxw1dnMLIbZqwGHCpCT6U?=
 =?us-ascii?Q?2RstfNx3u94z9t5kPLST4CdmbLPFtTf40BDO849oTwKKUFBqGR3s3ew1Lu6D?=
 =?us-ascii?Q?mnLC7gKa6WOlz+ksRLRJRS/mRP46vnmjioMMzTficdwn1BxWfjY0SQym9e8k?=
 =?us-ascii?Q?CVPIKyF8gNXTxEbu1mocLNsFeeLRn4dlJIwyzTlRrrCfsQXn2o52Y8AyOTyv?=
 =?us-ascii?Q?vjoGjpVjSne4dJo9+f5H5Yc/dHiTmk+U7TY6M9PqRRubyI81jwPLudR0aHrB?=
 =?us-ascii?Q?shnHr4oMX/v/vG14T4I+LK+Xvg6ZUXolQAobUYX61gHXttBIDf1ivIwoMC87?=
 =?us-ascii?Q?nwxzDOkzVnZiXAVzm/FQHKvq7fjMvOnOStzM7EiHkeB2NYQym6ENHIX9Q+Dw?=
 =?us-ascii?Q?Y/NOq+YEH0bdr0qS2DMKSPye3Iv6oB3g8nzEDSmZRLoW8Ctc2zLQ33HFeh+u?=
 =?us-ascii?Q?WiZE1S7UIPKW61jxQGdGRqCa6UUoDActA/LUHxWBWvYPpCCMRGdV/zfvSE4f?=
 =?us-ascii?Q?q7tVxKyFoZr8UBWXeJ4vgXfYE1OPI4AY88dpRjHVvLIKuvRRbFdMgzO2aiu0?=
 =?us-ascii?Q?VMPTv94P01gQE/PLyaRElqzZ0hOnzwd7dJawfxdCD1AlCav3lSj0OEfbE3Ep?=
 =?us-ascii?Q?y0dCvpYuzWE4UOpTjgaQ/HZoPcXU3y3n97zmXd6znpCyjRw6RtwHypzM4SEm?=
 =?us-ascii?Q?6sIEgsgV/uF4HIfkSTfbs9Fngm8AnacAHol5DQtwGEx1BsMl3+8VRwgY+rBO?=
 =?us-ascii?Q?4usMbMGQKz2PGre7xkT9DwKDgrx5HyYh7bYuBBbdg9isSZSVEucPizBsu6/q?=
 =?us-ascii?Q?UAfjSotVWrfVrDPqy16QTZVCpvP7791bRT0/kV6RkzFP6/jJY4cSIxRhcL+b?=
 =?us-ascii?Q?y8Lpiu2SkV6OSLUL0HX0P8MTishNG27FuclPtAAl?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c1e0b2-c3d1-4aa6-1bfe-08dc97ac4c56
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 19:55:45.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdPMR4AXB092bs3sE8exuW5yKLgij3cC6UzebH+SwddEplK2MmKVf9xPeEBDm2xO3xnTlDaVSMBwQ5VXz5/g+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1142

Add new struct kvaser_usb_dev_cfg constants,
kvaser_usb_leaf_m32c_dev_cfg_{16,24,32}mhz,
for M32C based leaf devices.

Note that the bittiming parameters are always calculated for 16MHz clock,
while the timestamps are in the actual clock frequency of the device.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 00fe7410e36d..3245471e906b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -471,11 +471,27 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_usbcan_dev_cfg = {
 	.bittiming_const = &kvaser_usb_leaf_m16c_bittiming_const,
 };
 
-static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_m32c_dev_cfg = {
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_m32c_dev_cfg_16mhz = {
 	.clock = {
 		.freq = 16 * MEGA /* Hz */,
 	},
-	.timestamp_freq = 1,
+	.timestamp_freq = 16,
+	.bittiming_const = &kvaser_usb_leaf_m32c_bittiming_const,
+};
+
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_m32c_dev_cfg_24mhz = {
+	.clock = {
+		.freq = 16 * MEGA /* Hz */,
+	},
+	.timestamp_freq = 24,
+	.bittiming_const = &kvaser_usb_leaf_m32c_bittiming_const,
+};
+
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_m32c_dev_cfg_32mhz = {
+	.clock = {
+		.freq = 16 * MEGA /* Hz */,
+	},
+	.timestamp_freq = 32,
 	.bittiming_const = &kvaser_usb_leaf_m32c_bittiming_const,
 };
 
@@ -686,8 +702,19 @@ static void kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
 	if (dev->driver_info->quirks & KVASER_USB_QUIRK_IGNORE_CLK_FREQ) {
 		/* Firmware expects bittiming parameters calculated for 16MHz
 		 * clock, regardless of the actual clock
+		 * Though, the reported freq is used for timestamps
 		 */
-		dev->cfg = &kvaser_usb_leaf_m32c_dev_cfg;
+		switch (sw_options & KVASER_USB_LEAF_SWOPTION_FREQ_MASK) {
+		case KVASER_USB_LEAF_SWOPTION_FREQ_16_MHZ_CLK:
+			dev->cfg = &kvaser_usb_leaf_m32c_dev_cfg_16mhz;
+			break;
+		case KVASER_USB_LEAF_SWOPTION_FREQ_24_MHZ_CLK:
+			dev->cfg = &kvaser_usb_leaf_m32c_dev_cfg_24mhz;
+			break;
+		case KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK:
+			dev->cfg = &kvaser_usb_leaf_m32c_dev_cfg_32mhz;
+			break;
+		}
 	} else {
 		switch (sw_options & KVASER_USB_LEAF_SWOPTION_FREQ_MASK) {
 		case KVASER_USB_LEAF_SWOPTION_FREQ_16_MHZ_CLK:
-- 
2.45.2


