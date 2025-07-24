Return-Path: <linux-can+bounces-4074-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9279B100BC
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 08:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50BE67B2CC2
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 06:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A6E223DEF;
	Thu, 24 Jul 2025 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="aWJh8Lbw"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2139.outbound.protection.outlook.com [40.107.22.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCE61F5828;
	Thu, 24 Jul 2025 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339048; cv=fail; b=CsAzTVqrK19nrfh9lmgZpjfRRHdl3ijgxv1Sr5k9hbWO8fsjTksbcYf1g1PfNb0FBC0lWAa87x8J0JjfKV7EGR5k7xEoWmV1prMUj775upxzp/blaib7a855ZIr/yDorXpE81WK/ZxdERgFuSgiwwA1hTdlsaApBvlRR1xj79Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339048; c=relaxed/simple;
	bh=G4kxVG8lH/1eR4j8Pp2+5ZUJnXVhsS655ClbLO+6EM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QLIxaRViWPBV+f5r0/8WHa48KxyZFbom91J/sNKo4Du83SXF9bS0bdRUu3tZ6U9SDKu46EiMv6L7eLPXE4ySLIC/uqZZu7snDNJHz9ua2FtSGfjPAJWpfAEaEBRMHy29XSOBrrp0JFhHBwp1Kn86L/cc9R26DlY9zkPc4T8pIaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=aWJh8Lbw; arc=fail smtp.client-ip=40.107.22.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPmgYsPDBI1JCZs7OuZ2ZttlNFhuRJjTdaDobL/gT+vMFq+945IIaQQ6UxIX+9OGrBIVdN6BjgrLJPQtxQ06KdE2JNmd5HBZIkGUuzFCqBHB3kHz4nhNqB+r2/C+BpWb8lkc76jPkMHgoDuU8jzEI3wtg2OT9PT9H4B4CurOdPPB+ktmflRqw1Z2U8ft8pWYcsd9wmFKSxlBfNvatMGOStJFMPrVLX5Wa39pce3n4LnmwA5q8H+7sKu4F3jEB0gypoHR774z5YYraQMq2ywccVc29ZdRpqa+SWJycVio7h11GKJMxNSKgoBNMpPiR89mgou4CKgKTm6dPQUNrteLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKMPXcv0n9Z3WFR94f/p4CGGbK4pVHL2nHNbxxmvuv8=;
 b=wwch8I8U5WLysTO18SK9nvq6YfwCd2uH5dYQx/flr9VtO1RiawsUuI9QClQTaru0Ptdwwjciy6isLrF9UTHyQ/G+nnBQhvmwUjGJJv1sTyA02od8i4HN83vP0KwFEebgJrz+UI57dQCOVcg6byk/T/bQyy2nvZJwOybtNC/xJk/jEGTqVTK0CzvLjXt/jynxWLgAKyjQ7XorV+z1yk3rVPKuup2dIci8v0glHX/MB6EVVcX+mjzGBYIH/SePS4FLa9VP+nWwqi7dWP4f5HVS6dhvsDF7aDhSxBzkvgapuzmH9TuBHMhgOc8wDKq/hwTElssPiiHxIqwKj5ihbskRMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKMPXcv0n9Z3WFR94f/p4CGGbK4pVHL2nHNbxxmvuv8=;
 b=aWJh8LbwWVcZRLZyuN1gQWrT8fE4nJybO+urC8rNu8UUTpgRcAguWBilU7dSA0A72svG9BSOUrx3yzRoRiNOeYz4yBxeXtu77vU0U4SH8IiuUE4H80YrPvmxpZ9L7BkWRLC5VRXpXqBLVWYRE8fViYbskb9CIfqQ+02n47+Nhk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM0P193MB0562.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:163::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 06:37:18 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 06:37:17 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 04/10] can: kvaser_pciefd: Store the different firmware version components in a struct
Date: Thu, 24 Jul 2025 08:36:45 +0200
Message-ID: <20250724063651.8-5-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724063651.8-1-extja@kvaser.com>
References: <20250724063651.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0034.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::15) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM0P193MB0562:EE_
X-MS-Office365-Filtering-Correlation-Id: a114a21d-7d48-4cba-04de-08ddca7c88cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QJRXDk660d1KvEkuj81V+IHbGzWxzh90iQpXbR+T3TzeieFkoifOw+Yv7v2w?=
 =?us-ascii?Q?3NbYcpc+2sXw+GY3epl9zVWaeX891CXCXoTjDU8+njGUakByoSTWNpKrNOfZ?=
 =?us-ascii?Q?AB8jFa1aZce4GOUzBC9a0Z/HSXj1g7uwokdDZ5V9HeEMyt62+Ac1YGzIN2vr?=
 =?us-ascii?Q?muaDEPm3XPLStlVS05LBLqldBxGfRhK6Y99LkQ7++ls232HfjtjPorUSacQA?=
 =?us-ascii?Q?UPze1L63G0IkJ/DQkrgjS7vLYzd4V/H0JeSHfY3/743v51A5ILdLvXayIyJU?=
 =?us-ascii?Q?9r3/pG5BSA+6pZ8xI1Y87AsAxVUIaSGKOqYMrNADYT0afSItKCcEbggEfEFt?=
 =?us-ascii?Q?Vk7hQfAsCbvhINCCBpvkFoCE37Ao1ByZFRmMy4uVNYfsEf/fsgDeVT5dem6x?=
 =?us-ascii?Q?Fn+0QJ5r+fVtLXoi0MntbM1PGNToh6+rPjDa2M6GGKUb39K10UBylx0QLGL5?=
 =?us-ascii?Q?rVSbItnIbwIO1UrVtEJcKjZyh/j8VQmQturcBMc6GvQ2TgKpLzh5mIfN5pMe?=
 =?us-ascii?Q?dBQUHfwiRAlCn106naXg+XHOIC09QGv4vWcQRpVxI6RvJTUqj5KCqfrlj4Qq?=
 =?us-ascii?Q?BxX44sxa5wIV+lecQY0wuH8zxp6SHt80hlbjxDQQblH5MBFD8QjMdYISZZXF?=
 =?us-ascii?Q?hp61cKtl+3FcGUduCLbF2i7rS/bx87tySvalBeKUNlgj4A/d2m1fsSXPrzzU?=
 =?us-ascii?Q?et7DX72j5WRvWPrmyZsrhTqEI7I4H6XUOGw276hb09duCu/ZSM3l0jUady9v?=
 =?us-ascii?Q?Le1SZ0/Y2ouuvcq3Ft2vixuwj8R4U7hxlaDoC9PANpL7A2GZ0yx7Quv3DrN+?=
 =?us-ascii?Q?pl4lfO8LwaK1v/+GfjBgHkEDhetjvG3pWiVtYutKT4HiIGW3/VekXdaLSlMI?=
 =?us-ascii?Q?VpFdTL7y8/2/y3TNu6eVkxWjucVO6FXD1TNNwaG2yzNDqsUqLvZRz+sFrUzC?=
 =?us-ascii?Q?JKqE4AlLEVPPYm/zrAnkshFbR/rLGMBsp46c7jEnBNJyv/eNVlSTrvPw4mIf?=
 =?us-ascii?Q?WZGFkqK4OhX0P+lBDYa2gZXauPffEUWVKjxSNBtzrGEeMGNx/flP5usmUrHk?=
 =?us-ascii?Q?7yqvEMsKCqz0S9h/syJSJ8/nq1/DOcfhG1zvSjzJjbmGYG7eayTnI6EWRL1j?=
 =?us-ascii?Q?VW1cYnEDK8halRGzRMrDAEp4mTM8QG7Z0dR/R42z4FzbXxi1sWkwulIW8lAy?=
 =?us-ascii?Q?KKt2nqznJRyDKBUpWENMBooWt91byTvJUNKKO9bISFFndrLZqXY4PM78J6Qi?=
 =?us-ascii?Q?l9IB49+ItJOQMvH62O+HZw3aLz24326RH7lh9a5XV21CiDrsSWo6M+3obRlw?=
 =?us-ascii?Q?7S49b+svml/SHhfKxDaq8TpkXOxS7vJOrPvlGUnTm89cVQaPFtveAdkUMAvg?=
 =?us-ascii?Q?QNUqRBc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b/4Cm4kPojZ63I2NtxZoQn0ABg3dVUXR1+DO7qizCKxFxXdNxFRGt+DqC+XC?=
 =?us-ascii?Q?b5xMNCogcfnSQT95znClDoGYXGzzkIobCIwiGHPuoWtYRX8tJ9NPXHbxt0+P?=
 =?us-ascii?Q?mU3gnfHIwuelTj+FEW+qfxugVsLbMOfIq+IQw4FJm/YHlmo3SItly6L/Cq0a?=
 =?us-ascii?Q?MO41HZsHY3IyhMKcPLul0n+ig/Bn7lbU3shXJz0EkSi6nRwybg8KDP/pgCg8?=
 =?us-ascii?Q?lI7sAYjwYcDGuyX41h5Wl5+elD7QgkcCtSO2R3BbdUA2JK4gwy7klr6Dtuxb?=
 =?us-ascii?Q?538EHEOrE6gG2whDkqfgt7uPZmb4MnNOz76nrM604jI1yw+r3SvDLsjmmPaT?=
 =?us-ascii?Q?X836h3TI2tnU0Q8qtp9Pi1nazsp3S7Lnubr0RuMXTnu99qqSfWQ9QDh+hZvv?=
 =?us-ascii?Q?rM7NtByYW96qMETh2Sb+bc9aduEPnvrODnhNtaSt9SYUXnkBDcYdfaFcw4PP?=
 =?us-ascii?Q?VVKN56o5OeYbTRI2c9itckp4sUB+MB2AAjzTl7HrfMzlox8SEbjuWWNaXpdo?=
 =?us-ascii?Q?XSulbZorEP6wDaSbXP6FodkIX1ygobC60p9MoQ9Spl8zAhUIULdnqL4lg4U1?=
 =?us-ascii?Q?ibKJrSmIVA1iqec2zLCDTXV4ZavNjJh9wfk39zyvuguckFPMvEDTxNbRaJEf?=
 =?us-ascii?Q?VdHKYqA/DzCZ20mobA0c3gZS5uIHmVTVBVLVdcvVqi8fRN7PyTA9C4HeajjG?=
 =?us-ascii?Q?p3HfNX0ZTnMpM0F4Gngv+Jlrlh8Zo4DEZW02CaFu0PyCETm873QMUNdSs3cw?=
 =?us-ascii?Q?kzATRM5hn+rk4ieY3AazEwTnCW4zWNoY+LRI2HQUAPTuEwmBc9uj+nzmJlCU?=
 =?us-ascii?Q?iryLMJ6lUn8IK9FICt/zwe0Eoc8kooetdE8HwLsCO8EHdE4CRRhCEETN3QDW?=
 =?us-ascii?Q?TJVT4tj7ioAUICPDRQADgZbXPcruFl+Ycb512aI7eDemBsOngTIrSF51xLQ6?=
 =?us-ascii?Q?gB9Lr+hCFzhuryVVqWAg9ufypCHQC6rYD9COBJB7hGqCkg65ghtS+C2bKhkc?=
 =?us-ascii?Q?ZLbGJpIibmF45SQYlOIm3SmzoEJ15nNalxsLsA7VNZCz/+4U3jsr9Da8otp8?=
 =?us-ascii?Q?YvKppVN/cDgSTKGpBN6ZYkJjO/Z8ZiqiLGwTt2FjEp9JvnX/dadQ4prcr2ZX?=
 =?us-ascii?Q?I1JGqrwXAVKeNG8mvjvJ/ueCtr6WYTPHCjbno1Of5dPoPK/EcFZRVQqGifzG?=
 =?us-ascii?Q?boNTji35Or6tS4iTmDXzJybuqnDg88gs0JMrlRzu4SScWzbnSskigtpZLrbo?=
 =?us-ascii?Q?8r6iTf9q+dtCISxw+BqDgt6hczLp4S4dNyHFhFMCBqPArCepK5h88QKzQD6x?=
 =?us-ascii?Q?YyTVhc9wOo2vblT1vR7pYZz4obr+Vt0KmWSFZOnBL60I7HwNS5L8HaWoydHS?=
 =?us-ascii?Q?LPSQ9Y57n97336a+JEONm8kshAbThGmv81PGhHJyxSyrILs/145RUOvsRlCr?=
 =?us-ascii?Q?IzmjsFQ5LjOPDpV13B+49o4M6OQN8QmLpBwStTS7oQb1MUhO3kmQmZUH4ODv?=
 =?us-ascii?Q?Cw99vm5aIzH565tKNoNZDYu+8IcdO+6sT0ZFmbczjNhBfinK7ftxaiVK9vJU?=
 =?us-ascii?Q?ZNddtO+qmxuNCW8CLJGl0D031odefBqn2TSD3VKB4Xibfi9LKhKiX0zFLq2u?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a114a21d-7d48-4cba-04de-08ddca7c88cb
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:37:17.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wK/ftZgnsW3w2a3JWhG4mqXJXO2+JeCb8RCYU7M6Tt354yzG3F2c+LW1vccC9YMX6/aEbL3Hf6bHlyAhDp9iw4Uml9w8E34ufZsV50m/X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0562

Store firmware version in kvaser_pciefd_fw_version struct, specifying the
different components of the version number.
And drop debug prinout of firmware version, since later patches will expose
it via the devlink interface.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Drop debug prinout, since it will be exposed via devlink. Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m2003548deedfeafee5c57ee2e2f610d364220fae

 drivers/net/can/kvaser_pciefd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 4bdb1132ecf9..7153b9ea0d3d 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -325,6 +325,12 @@ struct kvaser_pciefd_driver_data {
 	const struct kvaser_pciefd_dev_ops *ops;
 };
 
+struct kvaser_pciefd_fw_version {
+	u8 major;
+	u8 minor;
+	u16 build;
+};
+
 static const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_address_offset = {
 	.serdes = 0x1000,
 	.pci_ien = 0x50,
@@ -437,6 +443,7 @@ struct kvaser_pciefd {
 	u32 bus_freq;
 	u32 freq;
 	u32 freq_to_ticks_div;
+	struct kvaser_pciefd_fw_version fw_version;
 };
 
 struct kvaser_pciefd_rx_packet {
@@ -1205,14 +1212,12 @@ static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
 	u32 version, srb_status, build;
 
 	version = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_VERSION_REG);
+	build = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_BUILD_REG);
 	pcie->nr_channels = min(KVASER_PCIEFD_MAX_CAN_CHANNELS,
 				FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_MASK, version));
-
-	build = ioread32(KVASER_PCIEFD_SYSID_ADDR(pcie) + KVASER_PCIEFD_SYSID_BUILD_REG);
-	dev_dbg(&pcie->pci->dev, "Version %lu.%lu.%lu\n",
-		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MAJOR_MASK, version),
-		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MINOR_MASK, version),
-		FIELD_GET(KVASER_PCIEFD_SYSID_BUILD_SEQ_MASK, build));
+	pcie->fw_version.major = FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MAJOR_MASK, version);
+	pcie->fw_version.minor = FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MINOR_MASK, version);
+	pcie->fw_version.build = FIELD_GET(KVASER_PCIEFD_SYSID_BUILD_SEQ_MASK, build);
 
 	srb_status = ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_STAT_REG);
 	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DMA)) {
-- 
2.49.0


