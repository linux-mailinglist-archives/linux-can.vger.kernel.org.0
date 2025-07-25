Return-Path: <linux-can+bounces-4142-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB200B11EC1
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3B25A3853
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A19F2ED86A;
	Fri, 25 Jul 2025 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="LBw4Nk6k"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2132.outbound.protection.outlook.com [40.107.21.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CD82ED17B;
	Fri, 25 Jul 2025 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446916; cv=fail; b=IQijX/cVCStvU61ZQqLfmAR6BlXNk6y7MnHnLgz2pKQiOrWa2iJkU4CzN9sigdbOm7r7BQW38j+KCR0nIQNGVsfRPLABuRQ0qoaxVxt6/t+iPIHvGSpVgLpun0udJuANZK3XqDHGAcecpaIHCfSK3bEpm2eDeUuy44Q3dehKSTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446916; c=relaxed/simple;
	bh=OoSQTyM16MuaHpaX2VBJP24PxNiH48RMbiIZQApVNUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nuoVIm7aj1S2Bl1Frx9jTeAlVQ9p9xggFFXpDhFV7k9WfNB+KnU5Nw7mhck4jca0iHeP3bkKER8sZnGICPzKI3Y7qpnKJzKszOyJ7bWc/r2FiKevg1XCQlGP9Fb5/zeNVYMEUgGKeONs3O+AAORgBOMqqxgkHs9Tk85L3IaiCcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=LBw4Nk6k; arc=fail smtp.client-ip=40.107.21.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVFqI/YYDzmq4GBWHnKe7bKXY5moqFAkArboACcizbs1dgNeuPjy4ZkpUcjJMhZL+lwtQWaw0RvVFZlntMNN+wUC4LCEkUjyolyMChtOTXx/gbJ2JbgZdyHZCFUKy43VwY7m1rq0/+6pzlfw5ZjpnQGFz6zkS6SiZKaA9cace5lUhi0A8MleF9ToBHmF0rAW9hS/MuP2Ah73V56jxhRYoIAfjMQZbyq8+OGA2n8H9jVQe3RiX8z4+A1Mw5R159HNeN/W75dpI4xxJX6lbg9Ndgwxz7Gs0ZDR2j+jVRTwZ0bROrXUBfAxTwScWpxy5IG5znVkOgDGiu3iqjWyLHm3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOZsdFARIdCfBI+4/kefXTFkeyWrPS/s53OpcnEYQRA=;
 b=eixImk1FI85TDlCqRm0lyS9WuKUxGdh7+njCIt1owDkZ0RphG54Sc9pzoOGWMnyuDtQi+plYTEuxufRrfQOs8W+xRBeBJM4SVyYq41V4ms1zdKgap3wPtjlf7iFp/wciKUy3t0FL6/B6s9jFJAoS4B9dVgo044h+SlIrrNyU4344Gj3jpjaBg/t/rNJPtFaHKZVVnVaJN3PVG+t6d0PdOsjj8Lm8c6kUwam9FEpniTDtL+Z963LMuJZzm3CvMhiSjEtxJ1l0KSMHo+3aWZR1DZ3dAaTS+8I3UG/9br3Y8i1KJ6K4sx9HtUjF3ubmTS6gLryINt3lBtA3+s+6FwTrLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOZsdFARIdCfBI+4/kefXTFkeyWrPS/s53OpcnEYQRA=;
 b=LBw4Nk6kmM7KzR9kSZ9AxVPzU1KGhgK2Clq081gFBOpZPjtxVA+ZW6gzo+yvogxhELOMjJf0RKi7xUtom5bHC65hQVBCCwUzSEcYse04bFBmnmYoKLSl7uhq4thZUPUKLLoLugh4Pek0tJPn/iMuNbB1ecRTlKjsGKdvIA/sPIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB1219.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:36a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 12:35:05 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:35:05 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v3 08/11] can: kvaser_usb: Add devlink support
Date: Fri, 25 Jul 2025 14:34:49 +0200
Message-ID: <20250725123452.41-9-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725123452.41-1-extja@kvaser.com>
References: <20250725123452.41-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::33) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB1219:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec4920a-2149-40cc-7c42-08ddcb77aee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Nx4h/X35MF8/sT/tlBplPmijzrTAvQAa0lHDLT5o3W9iQpHmcT+hRF7FFsD?=
 =?us-ascii?Q?EGZnpdVViil7UCkPYJeXn8uLLafP8L0h7KbbFKyTWvoct1jASsEWM7hX0HpE?=
 =?us-ascii?Q?yUdsQqb6t3jE/f/UzzROEHQbxCi4Q7M6XCxfsjMyf4MJNygdNfNxcmtQKeZ5?=
 =?us-ascii?Q?hqNd7L7OBuft3FhLwO0efJ8b4hZTHs9Iv974udG/0vxJnvMDATIELVbnrCgX?=
 =?us-ascii?Q?38hsZJGGSa3skSsglQMLaFrwSjqFHBuKnqk4yZrBBijbIIzjBADiN5+bgQXT?=
 =?us-ascii?Q?MerUgjZMW0uK1fSarGk2rhRzWGH5iR4EE4KmNBDEfWzuEUqLg85mVvvQDJtn?=
 =?us-ascii?Q?N43QuC9tQd/48rtweGVEiBmzthhFsrp4M8gGCPTRM6w3f7F6Y6abBRBWWRws?=
 =?us-ascii?Q?bKHmO6cKX2HlutrbuGvf1sLOCfaS++YKyilO8HaDpzfdQLDhICDi8mKHM828?=
 =?us-ascii?Q?VBuB7szOIo4kQmbE0zwL+SsKuYpKwpE40u/U2RuyCE9W7Y6pSm7EXEKLDKZI?=
 =?us-ascii?Q?wlwGgdPOTOF7SOaiC+FS11s9AZoX5sSowLqt8ovg4iIUnte7mjib9gQTAebo?=
 =?us-ascii?Q?5D9wd5TDdvOEt/rznGg9mbSIKY8NSHkNVNyl0kAx/jIn57JL4cH2FFK2Eh5E?=
 =?us-ascii?Q?kCc7AMpgwqzfKE5ADKFJj20EGBt5rqL4qgJ0/7fsNLhIWmLX+j0rYoTF6KQI?=
 =?us-ascii?Q?x+7oAXAfNPNEtQo0kOVas5RdY5bOzXb/MRoV12hraH7pvnz2vafBfVMWLIu3?=
 =?us-ascii?Q?DlMwd3NTHTF+qgDEdhfFDcZN55yXtj4JQDj8S0ukM/fyNSQBoZ11ksnb4utc?=
 =?us-ascii?Q?JjmYtWliqcwKvRmtZheBM/wu0clyTD0x3rAwiTEZ7lox307xGaIJj0vuDNOK?=
 =?us-ascii?Q?Lgxtogn34uPkXZjoPiOUCl17LWJi6Zk/tuaYvTTQg5NBLv6JS5Y1PS3sMfae?=
 =?us-ascii?Q?4Rru+Nhg9IFURw+nYI1N9aljVgu3JoJTzI6UxyltkM6xWF5N5wZ3qT4I0r5m?=
 =?us-ascii?Q?yQnTxyCndKiu3MD4TQcESwrSc2OtT4fGkCWb4aa9/LEmgJNeYO3FznBCG7aD?=
 =?us-ascii?Q?QsqwH6i7EH/bEvUGrj7E5t6IZkfSvDdv+5PMaB8xYB7H6cH4JI8rv5Pq5DwK?=
 =?us-ascii?Q?xlZeo+oXprwpVbLyRcGLC+E+/Foo80T2q0BR0aH1I9HMf8ZQ7sDIbCYyHL0a?=
 =?us-ascii?Q?pfP24wsUZNqFxUW2YDMhPX03P6PcCtww4f8I9UVUIpnLvj+eVB7bxJI+h653?=
 =?us-ascii?Q?9wQaQ9kB2lf7AbASFRCI7pYjHgi5aECpZ8HrWSxc3pPjj3YAQRPJ33qTQOqY?=
 =?us-ascii?Q?nauv8hBnYqTlMjjKQBQAzu0d4syzjxTy2zSB6xKiIx5XQuYIeKypOj4U2Axa?=
 =?us-ascii?Q?Kl0GksM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k1Homh7fD3NS94MPIRzSvTB8b+0KLU/dVnts4WZmfBMKGQKP5drwPdWV1mw2?=
 =?us-ascii?Q?3UlY+sWv+YyQXyapy3FdO6L+YmOKPw0PoY83mDiNaEGSSzoYl9zQRR6UlL+X?=
 =?us-ascii?Q?dwAqrI4waeFKOkWyY8qYl6ifbatKPm51XFv+pV0UkthZyj+7ZG8bTBvM8/kU?=
 =?us-ascii?Q?pp/itPQTZ+7sdbyLG1/lPxyVx/AQQBbuAcYELg0cILWaDMKkAu1IzzafUdNs?=
 =?us-ascii?Q?fJcUt6CufbGXQbJjihnA76nKzOmHK/mpihPUOHb1hszNFDvjmG/nLugov5Tn?=
 =?us-ascii?Q?PkqWSGQdH6ax2mLgwpLvAZEWtzUGooBe+hZJeP8jWVB/nAlXmm+HUI+st/29?=
 =?us-ascii?Q?JY0OZWaUTjvDlJJ2RY2uGmlo5bAF5Suu+JIt96gxVBDYjCLeLzmkAyDz4EU7?=
 =?us-ascii?Q?/RQw3UJCWVOS0lZAHJeO1CKg75WIwDvP0JBKR7oU81Q4RsKhB2FZLGZQ7UpN?=
 =?us-ascii?Q?pMGC2akx/xBHftHBcCHXD5CZ/0Gquv47JQI2N8PDVels8e1f7Uz//aPudwzj?=
 =?us-ascii?Q?o2aIsNpamQFSK5EoOdIJWHXE5vqxtA+2wEGJa83f+pKhE1ZzCQuT1uT7jfX+?=
 =?us-ascii?Q?Lq81GPxfeMiQhx2uSE2C/dHczaqXyObhAU22Ri+bJ1F9vnuxU0JGUT0NvkZy?=
 =?us-ascii?Q?1ZoMTeFNBwYdcEeLL/9qKlrHc/wM5ToGUOty8X0+HB8ir556Ui4G9Vvw+Q8F?=
 =?us-ascii?Q?uzYyXHOduOdtMG8B8D5dghOrt/7H5icxCpk0SDc+wgTinYGRfqiRF9XE548W?=
 =?us-ascii?Q?FvAcF9A5Qumr0KF+Rjbm+Gk2lPJ4p58yiMks2H9hkXEAn8MGj7KXlhs4Lf2Z?=
 =?us-ascii?Q?eNf9h2kXVlQrh0yyXvEbFQx2/XyY3jsko6Eki9NSIhZAc4U4/+WUhT999R/Z?=
 =?us-ascii?Q?2lIrZok8CeUK6nKsWLx0RIPf1zV+T2fRh/Vl06TkLUr3hOj3czKyzKxX7nwL?=
 =?us-ascii?Q?9BKNzXq+h0tEUdDLtDW2g9s7muy4wy+DE4pDhDHF26NtB1ziECK6R2iGLtKA?=
 =?us-ascii?Q?c1BBfevQc4j3RmW9mam5Z2AE2lEcnLmaZJOMPBlTYi4vi9gXn8VU2ybqclLJ?=
 =?us-ascii?Q?vet0ZHIycXx+iwmB/2mDmu7i8k/6DvJdT8GzHc/HNi5GJFK5PeszKj7/spXh?=
 =?us-ascii?Q?oV/PXpZiCfskOy4NK0G2klHRmx52yfCl1oSOJcm3WE4wb5GRkB/rzkc3JCkm?=
 =?us-ascii?Q?J8B3UmAx7MHt2BT4K9/8+i2yj8FZKjj/jnOc8FV2RHmDKiLyx448UUm58yUx?=
 =?us-ascii?Q?mWlpjnQ39sys++4MaM3DN59Cm4N1w6r8KUOEycVHd2ZNW6o7Zsjb2rE1D77B?=
 =?us-ascii?Q?FZ4MbaNJSZ2bDlZNDxY3LGU47OpNzhh2CL5l6e/qPoCc5iJgVX8PVDdkyqOF?=
 =?us-ascii?Q?FxnVt5D/zxxvU2KbVHb9fGY0OUv6NDFqyY4FKuk9vF872bw/YNZN9wR1uC6j?=
 =?us-ascii?Q?sP/gYoG564gVwcdONbmalQ2gW9G2Uws+EIDq4PmqzA3+sVxxvuomg6BppG2x?=
 =?us-ascii?Q?TeQlkneYE4lTtYVFT3cA3b9UjSFeDKHi2WsLqJ/8/5pl2uFFXKnJpT8nP2mz?=
 =?us-ascii?Q?wJZlFbztOstBSuBWMR4A9nY64+bYNo/w6tpx269V5Zrdrq++mto7iqdHN5dk?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec4920a-2149-40cc-7c42-08ddcb77aee8
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:35:05.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQpcIohMHpfefQHZx43FqVnWx1+uSvTf+ZF/NZdOO9HbvsivfyyBLxFEYDPO9hDIszIvB0w7VGHxw+LDkazmcoQ4DHmG7DHkva2qvKvtiyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1219

Add devlink support at device level.

Example output:
  $ devlink dev
  usb/1-1.3:1.0

  $ devlink dev info
  usb/1-1.3:1.0:
    driver kvaser_usb

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3:
  - Include kvaser_usb.h to avoid transient Sparse warning reported by
    Simon Horman [2]
  - Add tag Reviewed-by Vincent Mailhol

Changes in v2:
  - Add two space indentation to terminal output.
    Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m31ee4aad13ee29d5559b56fdce842609ae4f67c5
[2] https://lore.kernel.org/linux-can/20250725-furry-precise-jerboa-d9e29d-mkl@pengutronix.de/T/#mbdd00e79c5765136b0a91cf38f0814a46c50a09b

 drivers/net/can/usb/Kconfig                   |  1 +
 drivers/net/can/usb/kvaser_usb/Makefile       |  2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  3 +
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 72 ++++++++++++-------
 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   | 11 +++
 5 files changed, 63 insertions(+), 26 deletions(-)
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
index 000000000000..dbe7fa64558a
--- /dev/null
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/* kvaser_usb devlink functions
+ *
+ * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
+ */
+#include "kvaser_usb.h"
+
+#include <net/devlink.h>
+
+const struct devlink_ops kvaser_usb_devlink_ops = {
+};
-- 
2.49.0


