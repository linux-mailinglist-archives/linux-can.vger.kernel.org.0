Return-Path: <linux-can+bounces-4107-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 345A6B1063D
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 11:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8FA1CE6761
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC6B2C158C;
	Thu, 24 Jul 2025 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="DYmOIbxH"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2132.outbound.protection.outlook.com [40.107.103.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF37F2C031E;
	Thu, 24 Jul 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349142; cv=fail; b=pmhR89oX2vUm36BcWK9zlTQPw93WmTiCPe5XrUGerQCGDgnIbhNs5pgiS37vhvApuO3Ap6gd7Wymp3qKgYIggm8YDHNTqFI/3QQe1SVIddgMhaMXzp7p8R4P9NvymepRC6jt+ff2Z1tSFMhiDMYnV7LORga4N8HVZmp1sntBDCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349142; c=relaxed/simple;
	bh=mNd7GiiTvyOf3z8n5J4DOLP/TIIpDQGAQZIKz9kjSis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OKNCWpi/Nd1SmpiIVYRAHEFqqaSKcAkN4p9ucYEPxKShFRwf/GlfxmG51KOl5uapWae1NCYeRfK16UcNnerKqXtXR8cJ04KSAZD8lCBk5L+gZfC98w8iZChe9rJEpV8ciXZ4rN4MTMMbHvqPnPJl4yKsovgSxnsgarKUOKrUJV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=DYmOIbxH; arc=fail smtp.client-ip=40.107.103.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOntDMW4Lsd/3ztzuYJV9uN48UdAewZZ9pSVtM89FXRBZCcFrLVcOz9n0Plb0WbH/5mZVwmRM+H7MnXVC0OLzS6RWwfs6nWcU7Nsv7Qy8c/94jOk2BxIOjgZnaBDqCznWU78VdXlXJs3JYU3lNJM5Ken/JVFxxa5SvihmK7ae+rBIlYGqVDopnKXLBtbi8zXeU8837VERRIsy1cEFAQRCL/HHGLGY3W0GSgHNZq+gJGMJ0NUTNewqxcAExZKk0+sf1kZj3qyta9oM87tKyFocMrbJHjFmtvWbM9kqE7+bWwkv0TvNEQlyPTrNmVXx4cGjyMb/836jonNKBN7ux6t0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOr52pJEcxNpwCBu7FGzEpiNgsLWOHsblR2HZ8ouS+w=;
 b=mvrZCsRAtvuLRAaGDB70Pc/kJNvpvt25BfKObKuuVJ1Wpgfp2UNtV5b6J3FtOlTQLH0aMb5r9tCq3z3YZF899mKLDMIM+TYXzi/WlHJkoFbmVV6aDK09mVixNxnUNb1Tk4KmyU8q9SfqeOHyPY8Q2xh+gjp1QQyQr8t5o9/LQrcK5mNRMsb/wMZaqV615IxgAThP+2W1kKFo3dPi+miMFo5nEU1hBV5PUL+vrtzaBjnrv4QgiNsBjgjCsMV7htX5WCX84kyTPeBrPAqTukgZW+oOPhTeHOfs3sMwnbkMEnyaO8u4NPViPW0LGoTVvFHsiPfJZQkMZeLr52n5mklIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOr52pJEcxNpwCBu7FGzEpiNgsLWOHsblR2HZ8ouS+w=;
 b=DYmOIbxH2oBYM1hO/PMzP7jd3MuCv5bqTHBM8BwzBtzReAfYk5zGlIC8a4xG4VGiVdkyjD/RN5dN9vy17kuLh7WQm96vhRYpliUvOEvwYFWela+oFtkxQWv6J9mNPgabaj1uRjbyOySZP8x69y/Vle2KI6RlHl0TL1w2VOtSFTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB9P193MB1433.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 09:25:28 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 09:25:28 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 08/11] can: kvaser_usb: Add devlink support
Date: Thu, 24 Jul 2025 11:25:02 +0200
Message-ID: <20250724092505.8-9-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724092505.8-1-extja@kvaser.com>
References: <20250724092505.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0060.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::21) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB9P193MB1433:EE_
X-MS-Office365-Filtering-Correlation-Id: a2eae51c-f917-458e-82ee-08ddca940716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b3lLVdUSBOvX68LV+/TvXYrWVr+SrsMDQez6HIMGLWkFZ6+jS40A04CdvR7k?=
 =?us-ascii?Q?tqet1P/RUEGNecz8Cj6jYpGHK3SK6MnDdKgMngxEy7V8LxD6g43itxnWOk8N?=
 =?us-ascii?Q?u51u9rl3g0dO3/Juwhy1QEDudqoeb+5gmGPplA9BOJHH5ilGqNDNZ32beU3v?=
 =?us-ascii?Q?EC6gQpKDdnpkJP3/FtHf05cstM2u+uC1ewZt/fdy2ND/LSx9P1AKtZGth457?=
 =?us-ascii?Q?TCIgx3HRQ4l+A5Lt8JYPIQ3qp9Rfu9onCZs5a778/m4mbuMAeo037lBlD06b?=
 =?us-ascii?Q?JFV1lcGnKxjPRm/xgEBKuiRUq3UwYcza7Z96I+mnyM7wHtFIrWL4zyGUyoVV?=
 =?us-ascii?Q?tnuUiDCdD7dXlWs/nO+gqjjofg0u6bsrevkevQW/iJjcxqmYkzKqvkphfZ95?=
 =?us-ascii?Q?PfthH6y4b05yQ32RevUHUTBspvGnP8Xkcra5sNRqwwS6b5ZvsPwWoGZBbeOx?=
 =?us-ascii?Q?MXuwb156U0IHv6T0nXX1WtxNepXCPIdMFeG4RW6OPQq6pvRlaBePBnduOJ3X?=
 =?us-ascii?Q?C5roIbSlSYawaI3a236ciReBJ6j36hrvPKbDLy0315t/wk+zeGCrp5cSa8AJ?=
 =?us-ascii?Q?q1Afzkoqmll8YBF1Y3WFAMBQkZyghOCdBKmrFpeGAUYtfKvDZp3WqWRaPplw?=
 =?us-ascii?Q?vcv6XslnAa7tPnL2IqYU+k3Tj1Z+/TsXyaWQp5Lk6cqW+BiO8Q7K+nMfBF9q?=
 =?us-ascii?Q?UkGpMyTN6vHUgZUrp/x6JOIE15jey65hju2Ch3+RE0SEeNSDrHkzRfLlIY5K?=
 =?us-ascii?Q?LMTwdeUfb7kXZY0G+tULWyyC96q2+sb3shge8ru2LTRRB9998Apag5Sv8V+j?=
 =?us-ascii?Q?Drca8C8VhNDjJjMLrdhA32e/ttwkEv2fND/XtVsLk4GiwjIvMt+z5tldeAOW?=
 =?us-ascii?Q?SLGFn0VKWm2C+mZraqBG+aa6i2PgxtCa1Ls1LUVDG7tK/vRsgnf4961lvLlU?=
 =?us-ascii?Q?fOHFoIhWjDYPJkUrSIERbvR38wlwMuV+4MusNTJtXKkkTbEjnjITZY8I/TJy?=
 =?us-ascii?Q?R3/29aesnoKVCfxw4OQbmHAULUq+ch/6mlLHQfmRXdGC/BRMMES/f2T6E++B?=
 =?us-ascii?Q?6Rarj32H8iJpmPXyXacBWFEhbr5tY5bph0SVj8GGupny/fTlrCTBIEeEf9CK?=
 =?us-ascii?Q?KXJoI1qfVH11HIuQGZAYj3Jp2hkR4TzWdZ0rFRgqnOUmiGlFrxGdVEEHRJ9k?=
 =?us-ascii?Q?KSKGPO4aLokXaA5DRI+KGeI6Yk/0U04On1PavRDV74hSDcM5rD/Bho/RQ/i4?=
 =?us-ascii?Q?lntRMKq6MmadjZNiGQPCpK6E4O+6P5347f3z8ZQqXDe9YJAiTry2rIqoF0jv?=
 =?us-ascii?Q?xeFA8l5LV54NSdcnu9DYYr5ihzhbd0MRGI3oMu8/s9jZ9M3dhUPCtqlY+3I8?=
 =?us-ascii?Q?118SlUY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6SnORmhdPk2jJRkvTGVnufDNN+09c6MH3wE7LiWbG0gPI1BlAfsAYkUmGtrQ?=
 =?us-ascii?Q?O+lP5LMh0yBE5ArRcQ5hWDH9M+V9+EwLeymOG55tzQEJLr1EHphO3+tvUINZ?=
 =?us-ascii?Q?bWmIRJb3/JjNyhACQDkvlgVHSRbQDmKgwZib2GFU0vwfDOj/JQZhrD9eX5UW?=
 =?us-ascii?Q?N+lB26QwS+0uvXb5fAxzH2cmWkc2+A5h9xsgdfXRr8ANPCXE1/RtiptZEja8?=
 =?us-ascii?Q?7nUh5AgTPUqbYhLOLe168VWIZPZqQjJMUwTG6ZAJhAT7xqOevofpRZuKn6e7?=
 =?us-ascii?Q?Rs3THiAXrofkSccok0f7wMlKKGVpJmfX1kr8Ov6utJlcj2QkJedBCkdGHQcA?=
 =?us-ascii?Q?7pJjsyTiAeYygdmx6vAtGp2c4faNvThfcZxjD9Opf4l1zC29NvUYuhttAlal?=
 =?us-ascii?Q?SKGS+B7vB38tT5JzaCX1cUFoiuRBHRPrzZyuj0PQZC6GbJaESVYKyCvboQvK?=
 =?us-ascii?Q?h+1oga94GYv0ifGlG0cIuR2BGnLD9O9pV7WBqxd+tmy26X8JKblP5dVgYbc2?=
 =?us-ascii?Q?afozzJ7pLABsup/zqAWIZM+I6KBbJ4d9YyFXtHSlLwYtmeM/D9Eeq0nQKri5?=
 =?us-ascii?Q?LmGmWIzW+6LsVKT93h9q3a7ZNNR8boQGhvv7z9NdQrtSRNsasIKFG27ioelp?=
 =?us-ascii?Q?lUx+tzRTq+8XRTyKvxeH/TD1KsOSkpzjpDmG4Sj4+8emoHgVOPDJlc/byeLq?=
 =?us-ascii?Q?hPrHHLDCX+DsvD2hc8XSXRqejfJOMCHKQcYbNU3RYI7uBo4/fceIO1js+gOz?=
 =?us-ascii?Q?tj2onPKrwjHRik4wqmeSq7t48e8ppJQvjPexvqvMEWjlEK3jW4y0ssaXwcaO?=
 =?us-ascii?Q?HdrO61XU0hurh/wEXDv6SZuYvJBqeh+Zay+aYPJzZJkCrRCr3HYnRYH9DbJd?=
 =?us-ascii?Q?c415xF8ds6JdGt0hezgcIghZIq/26wBqofWw/zRAdUXDibm9M+mA19B9PDMu?=
 =?us-ascii?Q?xtfRUw2HjnW4Oyi3vre1Bx1Mpcd61G6rANVP6m0KzLzkBh12LOo021/XufL1?=
 =?us-ascii?Q?/mMBwKOmWeSTddaoiJ70kTY3Bib8Xx6VQ9q3qnDcdhrf75NS81sUgRyeOj20?=
 =?us-ascii?Q?4GGuNx8BDAf8I6vM06hOqs1a9BMaUeWpD1KsSscjCuh4qNurN93vc2+On2X1?=
 =?us-ascii?Q?Z8+9sPfYMwZCFYC9d1REO3g9EfiE9fqL5gR3w1TofDbLQisU4Q+FZpfOYlPn?=
 =?us-ascii?Q?+4+9hE6xdw8lZ84Pgf1Vfzxa3K+YDnENx3JZTuL+LQSYQdT55XUybVv5cMDN?=
 =?us-ascii?Q?76Dky9p0f6lWRt77VLwcBivYdiyxdaqMkKTfPEaEtUjtmqwv7FjeQD3EeLSw?=
 =?us-ascii?Q?KxNrH+Boj6DCcdZRejYXs65G+chkTjE2DycVX4VGaDjQ1PVixryvaAMTAEGr?=
 =?us-ascii?Q?3DhXh8L/7+J6px5wXJt4DSnsgqcDndl+ub2NL2hKsvw2hk4GAXbewKQLgoDF?=
 =?us-ascii?Q?6Ju0XSdAaXHBbCuAY/bDIXDbCPI4DClDqf7EqwysXdZ7j37rGnJY9ZMwtKRf?=
 =?us-ascii?Q?CkBoW31iiI7tDl9rAGRm8SImVDlyBNyuTdMsOjFuMszPleKdrJplpQ1TSCvu?=
 =?us-ascii?Q?n3Gk0kROa847Tqm5lWQBCuWOkCZZeLY38uwkpeUR90tKmvFuHuAIJM7AFfEL?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2eae51c-f917-458e-82ee-08ddca940716
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:25:28.3794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PUbX16nocFOML0VNsdtBsljhwvej0gK1qOik7R01BTgl+1dAYWiaklT57Yh/FHEX0uz2YxmDVMz3bvfFeKZlovs4hm6FB8meDwDxfAwDZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1433

Add devlink support at device level.

Example output:
  $ devlink dev
  usb/1-1.3:1.0

  $ devlink dev info
  usb/1-1.3:1.0:
    driver kvaser_usb

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Add two space indentation to terminal output.
    Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m31ee4aad13ee29d5559b56fdce842609ae4f67c5

 drivers/net/can/usb/Kconfig                   |  1 +
 drivers/net/can/usb/kvaser_usb/Makefile       |  2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  3 +
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 72 ++++++++++++-------
 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   | 10 +++
 5 files changed, 62 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 9dae0c71a2e1..a7547a83120e 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -66,6 +66,7 @@ config CAN_GS_USB
 
 config CAN_KVASER_USB
 	tristate "Kvaser CAN/USB interface"
+	select NET_DEVLINK
 	help
 	  This driver adds support for Kvaser CAN/USB devices like Kvaser
 	  Leaf Light, Kvaser USBcan II and Kvaser Memorator Pro 5xHS.
diff --git a/drivers/net/can/usb/kvaser_usb/Makefile b/drivers/net/can/usb/kvaser_usb/Makefile
index cf260044f0b9..41b4a11555aa 100644
--- a/drivers/net/can/usb/kvaser_usb/Makefile
+++ b/drivers/net/can/usb/kvaser_usb/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb.o
-kvaser_usb-y = kvaser_usb_core.o kvaser_usb_leaf.o kvaser_usb_hydra.o
+kvaser_usb-y = kvaser_usb_core.o kvaser_usb_devlink.o kvaser_usb_leaf.o kvaser_usb_hydra.o
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 35c2cf3d4486..d5f913ac9b44 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/usb.h>
+#include <net/devlink.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -226,6 +227,8 @@ struct kvaser_usb_dev_cfg {
 extern const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops;
 extern const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops;
 
+extern const struct devlink_ops kvaser_usb_devlink_ops;
+
 void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv);
 
 int kvaser_usb_recv_cmd(const struct kvaser_usb *dev, void *cmd, int len,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 2313fbc1a2c3..b9b2e120a5cd 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -914,6 +914,7 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 			    const struct usb_device_id *id)
 {
 	struct kvaser_usb *dev;
+	struct devlink *devlink;
 	int err;
 	int i;
 	const struct kvaser_usb_driver_info *driver_info;
@@ -923,17 +924,20 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	if (!driver_info)
 		return -ENODEV;
 
-	dev = devm_kzalloc(&intf->dev, sizeof(*dev), GFP_KERNEL);
-	if (!dev)
+	devlink = devlink_alloc(&kvaser_usb_devlink_ops, sizeof(*dev), &intf->dev);
+	if (!devlink)
 		return -ENOMEM;
 
+	dev = devlink_priv(devlink);
 	dev->intf = intf;
 	dev->driver_info = driver_info;
 	ops = driver_info->ops;
 
 	err = ops->dev_setup_endpoints(dev);
-	if (err)
-		return dev_err_probe(&intf->dev, err, "Cannot get usb endpoint(s)");
+	if (err) {
+		dev_err_probe(&intf->dev, err, "Cannot get usb endpoint(s)");
+		goto free_devlink;
+	}
 
 	dev->udev = interface_to_usbdev(intf);
 
@@ -944,50 +948,66 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	dev->card_data.ctrlmode_supported = 0;
 	dev->card_data.capabilities = 0;
 	err = ops->dev_init_card(dev);
-	if (err)
-		return dev_err_probe(&intf->dev, err,
-				     "Failed to initialize card\n");
+	if (err) {
+		dev_err_probe(&intf->dev, err,
+			      "Failed to initialize card\n");
+		goto free_devlink;
+	}
 
 	err = ops->dev_get_software_info(dev);
-	if (err)
-		return dev_err_probe(&intf->dev, err,
-				     "Cannot get software info\n");
+	if (err) {
+		dev_err_probe(&intf->dev, err,
+			      "Cannot get software info\n");
+		goto free_devlink;
+	}
 
 	if (ops->dev_get_software_details) {
 		err = ops->dev_get_software_details(dev);
-		if (err)
-			return dev_err_probe(&intf->dev, err,
-					     "Cannot get software details\n");
+		if (err) {
+			dev_err_probe(&intf->dev, err,
+				      "Cannot get software details\n");
+			goto free_devlink;
+		}
 	}
 
-	if (WARN_ON(!dev->cfg))
-		return -ENODEV;
+	if (WARN_ON(!dev->cfg)) {
+		err = -ENODEV;
+		goto free_devlink;
+	}
 
 	dev_dbg(&intf->dev, "Max outstanding tx = %d URBs\n", dev->max_tx_urbs);
 
 	err = ops->dev_get_card_info(dev);
-	if (err)
-		return dev_err_probe(&intf->dev, err,
-				     "Cannot get card info\n");
+	if (err) {
+		dev_err_probe(&intf->dev, err,
+			      "Cannot get card info\n");
+		goto free_devlink;
+	}
 
 	if (ops->dev_get_capabilities) {
 		err = ops->dev_get_capabilities(dev);
 		if (err) {
-			kvaser_usb_remove_interfaces(dev);
-			return dev_err_probe(&intf->dev, err,
-					     "Cannot get capabilities\n");
+			dev_err_probe(&intf->dev, err,
+				      "Cannot get capabilities\n");
+			goto remove_interfaces;
 		}
 	}
 
 	for (i = 0; i < dev->nchannels; i++) {
 		err = kvaser_usb_init_one(dev, i);
-		if (err) {
-			kvaser_usb_remove_interfaces(dev);
-			return err;
-		}
+		if (err)
+			goto remove_interfaces;
 	}
+	devlink_register(devlink);
 
 	return 0;
+
+remove_interfaces:
+	kvaser_usb_remove_interfaces(dev);
+free_devlink:
+	devlink_free(devlink);
+
+	return err;
 }
 
 static void kvaser_usb_disconnect(struct usb_interface *intf)
@@ -1000,6 +1020,8 @@ static void kvaser_usb_disconnect(struct usb_interface *intf)
 		return;
 
 	kvaser_usb_remove_interfaces(dev);
+	devlink_unregister(priv_to_devlink(dev));
+	devlink_free(priv_to_devlink(dev));
 }
 
 static struct usb_driver kvaser_usb_driver = {
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
new file mode 100644
index 000000000000..9a3a8966a0a1
--- /dev/null
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/* kvaser_usb devlink functions
+ *
+ * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
+ */
+
+#include <net/devlink.h>
+
+const struct devlink_ops kvaser_usb_devlink_ops = {
+};
-- 
2.49.0


