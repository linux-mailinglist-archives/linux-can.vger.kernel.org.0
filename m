Return-Path: <linux-can+bounces-4085-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28774B101CD
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB177ABFBD
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 07:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC6C262FF6;
	Thu, 24 Jul 2025 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="kpXj50g8"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2132.outbound.protection.outlook.com [40.107.20.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B861F4606;
	Thu, 24 Jul 2025 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342241; cv=fail; b=niQSxeFuQ3cVnOVG0JnwQD275QxU0ZlBaVVy+rrtfnR+aOOFb4kA1oMyGYmeirXSQK72UZHebbzwbCsu7xVhqALayNlH4zVj+DCAbeWdVJ8TDPCtinuRUXpVGQZeINHqtYmfrXHs6JVQ+onJ2rYuTWDfJ/uWlU1pPZLZVfTULaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342241; c=relaxed/simple;
	bh=nrW/YA7ZgDD1SteGKTQbEEK6q9vRorW6LVHIrELRGKs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gfy9QagXsmKkVfxgXFvsUL7kkFT2UaVS5ezwKtea8hTg5XqVY8A0HZ9l/ndPCg2oxGsZTRMzhiJ9gsp0tKpWuwDvSLudYejCnRJmqdLHI0S+E+UuwnFpaz2pxqwonjObvd6rDcOLusqj6CFArSsgdqJhCWi45LJFvdj848JhNAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=kpXj50g8; arc=fail smtp.client-ip=40.107.20.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnZWM42FUu3F9zcxoiJwThkLygGIk62zVdNB7zm5XzuORox65v6ln+BhtYMy164s2MQvG0K0Ji3g6OZxmO85nGlAhA9GlGQp7ZpWXr/pcVMsJBlqKyDWN7zN+lCwvGdaxYgnb/gBsCyaeACBNFQ2dYx4/b8tLm12z4vd3RCUjKnUdSxroZr6O1vvWNegJVycvbJk3FIr1e50U9jExEJzB4xDTIusFPCv9m4FAe7f9JApDPPLcviw2bEvFkNa/7MPpAqRBsNQoKRPy+dY8FQ8MFgKL9utNKNfL6rehIO6G/SWF0TpTMTOIeYea4l3eXczwjLCJgoYRF52hky6f9okHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zxOaLUzFYvcCaE5FkDAXZ9yfz/lJHsZ6DtASR8AL50=;
 b=Q3q1LbDyhEL4QpYtufImCMUjqI+K/QGkO9nI6VyP5v0NOR50IpFAXqqQklLQgIh9/ZTG5HCG4YPV/s8FFJlisrCykAd8dUmB8l5jaC8fps5JqsnsQhZMLsHWlHE0sQkC/H34md8mi4Fg8QQS8DaTI4Vp+KRNB/S/zUeCPMJE+zDo5XnARi4QQwSDSDF2XgqP7XDRoz2/TpJDrkFQbj1/ZGU6bWQEAapprgCc3rOF3ZPp09ToUPbb4w9pQWRSMV4d4471Ka05y1EN4GxSWR1rBF3p/ax1pVfzVDYxrruOYL5By7h4Ujfm5Rgzs6nSkVLqymq8qLKHOdzWm3Ma4sLfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zxOaLUzFYvcCaE5FkDAXZ9yfz/lJHsZ6DtASR8AL50=;
 b=kpXj50g8TjW/GRfNri9l2oD4loTJW+tjRNaaIySQDpWqOL6LgzW/ZEA2j7wkXmI9QrkreRU/ilAgdznQZrW04LCZljvSQmyQmKrMJiRjH0TwAuUstKgwwQbqHmt+dk3RgwnUfqFjhx/E9owIMLEEDOShhMWljyDdh6JwCklrKEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB2657.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:32d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:30:33 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:30:33 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v3 00/10] can: kvaser_pciefd: Simplify identification of physical CAN interfaces
Date: Thu, 24 Jul 2025 09:30:11 +0200
Message-ID: <20250724073021.8-1-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::8)
 To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB2657:EE_
X-MS-Office365-Filtering-Correlation-Id: 192b8f73-6fa0-4fbd-ba8e-08ddca83f97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GGGM75UrQAjI8+wtkT9MuK/d/8OOMWy/atUvrKyt67HbmUBjfOed8zVTh908?=
 =?us-ascii?Q?ip25ADD5wZcGgs3AFh3Bsi8c46ajXKYUVOyIUoKC/3Mmm5qqNzbbQ09g/ybj?=
 =?us-ascii?Q?GF5ZiORyjzA6HD9BGbYXUKMdtfR6FAcsmFaO4/lwRbotNNdlgH1nmtf9FJwK?=
 =?us-ascii?Q?J1urMsQIfCNxyARLhcn/m31NTh78LvN95lgdAk7wZejqB9dxd2gHwMSSHN3N?=
 =?us-ascii?Q?nYleTaBfBzH1MMDtKx0m4MsvmCnVzwpfutKHZ6WrUq22kPzMK8qjzeT9aQPm?=
 =?us-ascii?Q?I72kNn4hGUDzfENRi2DH8LiwHgwMx52401qUV+jClfyYKJnI7E/7QfBtE8eX?=
 =?us-ascii?Q?I2JmQsSj7ERpcrl31NU6qRbieK1fGFFvGMxeUeRPfIQHYNpBEocyn/ms5D/w?=
 =?us-ascii?Q?Jf521RwMh9YK2Mjn+5/gYY9Ol4+a9XiBkQ54Fm+yZY3i6IBboAXc3UTjMART?=
 =?us-ascii?Q?AAcLXhb/ZXc+DGZjH3wEp9BrBGRaQ0QPNzjKHa1zz49q+XjsiCOBhCA8T9ns?=
 =?us-ascii?Q?G9Wpr9RyzbxIzva8Xb+XEdFim7VY4JoQ/HW/1tbd5Roc4l3i6qkHklZyLfMJ?=
 =?us-ascii?Q?QyG6D9inG6cONbTCTK9y5TwR0n4dSGCdgjSNwsLqTC1xPErZIFT7Y1M2AwK+?=
 =?us-ascii?Q?OWcVP9Fj5NA2mlN3wFhuYD45Jy3LFdcGk0K7cWAlI9Akp4g9psCPtw0y5+HU?=
 =?us-ascii?Q?ck69KURaACrU7cAZ1kmzlR48GZ7d04xH8tPai0lJ8JGSZ6AY3yOiVMfXMmvK?=
 =?us-ascii?Q?DpHHBgfnW+mys12a8YNCCyROmBCOXt4yW2rbOw5sBGvkNRPoXD7DmrJI8vs7?=
 =?us-ascii?Q?7yHOBuIQoxcOBYJBs2sFHfvOgTvewYi8LmhfkEauG6kSpfgX4HhyAE1N30cq?=
 =?us-ascii?Q?ZSydjG9ibik2wgMgp954jVOzbx9DsbSNtEE0uuWjPMZ09DA2qunAs/9BAWxR?=
 =?us-ascii?Q?ConxIBFNf593iPFFWQ3ft6pt7zCZVgy+HIv2GYKa35GwZl2Nie6XozWHE0ZG?=
 =?us-ascii?Q?v02LtNDZ1c/tloXEmCuvqyOHY0nYNygzKjbAQRCTGFI1/KR8K/TpSGukpDNy?=
 =?us-ascii?Q?wQkR+iw90C0a5beAN1KxvNrucEYsHiLHlrunI609y9XFoRqVJozkmcWHdjPI?=
 =?us-ascii?Q?M+GSAgvZKOWanNji1SPENF7guMEaa6ODqYRtjxzDP2H0nA70v1DcxWoYrCic?=
 =?us-ascii?Q?Ri6oM4Gaaab9ozUCZIYIVLO92/fVIEWtycUyecYhSSqY/cUw99U1q7vD0FHL?=
 =?us-ascii?Q?scoozyl/5yzV5rzQSe3XTTBlRJUvY6S74eLjuA355eLVuY4xjxddDkkL1m9I?=
 =?us-ascii?Q?FLH5/bPp2/W/sNgRXzwoHbn3ljbtzkQFWyfRU9507EkBVanubWUCG4UUZSKC?=
 =?us-ascii?Q?GAHzQklnww4Oe02u0zeKlY9mz+jm4pWe3w43hO992Lz+3fqNikN9l0OHSbDU?=
 =?us-ascii?Q?DSMNOx8sX44=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?acmcT4MF9EGb8tO/lWdUx3JjIawoxzexmzEL3iW656WIkXZscfHhlwz5epsK?=
 =?us-ascii?Q?u8at4DFCcbioAne+kQM69IFhQaKfVxcniX2WyCZzS02BlHMHLVUGuFWnDsNS?=
 =?us-ascii?Q?FVslpoqiyLWMJ8EVKSt0Q2v91VKZvBnjD1m06JJZzM8I6sCldBJvz9Skj5FD?=
 =?us-ascii?Q?bS6OWUNCsVdJKc8o6G+Dk1y4Szd6bYrEzltQCSaj2lWgy1GOyTbSqQPWsPk7?=
 =?us-ascii?Q?UIhYDGNYqFoHutvWklUAZ2pE3qLPTrvrzS44Hat3AGk0GMiYEMT9j+ZwzbP8?=
 =?us-ascii?Q?u1Agx8fO3+pf8yP3+xrbJfIAVDV8cl1RF9GtNVlUodigLcL7aZQFsD5SD3sz?=
 =?us-ascii?Q?c85APm04KFQ1Zp99Hr3u5tneUR/8R1GEWpCfgznF17pewCdUzwTsCiiKA1Gg?=
 =?us-ascii?Q?SJQ9PhI3rzO9m5axoasbmbQ6AGwtznxVB8kK2JsVsMryNw7UQ6XCE4a7Nk4j?=
 =?us-ascii?Q?ZR8ZhzRFXbSWuZk4qF5SUfFWWYe3tXmfTDQi8v5UigRNT2T1zZeX3bKaqc5U?=
 =?us-ascii?Q?ZCi4E8zG3JvF1ovRUPRpgI+Du+MCfoCZ3hLv2Yg1YfC5GxXR8nVYL7R1KRAF?=
 =?us-ascii?Q?cRMzhlL+iqOucEIdiuT/rjMrX9HUtkm+tvUu7XY07+TPp5+eRHzDMBO2nk72?=
 =?us-ascii?Q?H2aqfbT7ZPdQwmhXyepmK1f/o8iDJuukr88L2pDYqcvfEgaHgiga3V2UuHMP?=
 =?us-ascii?Q?7uOBLqqXdmJalSiVJmRONqWL2c9tcHxV0wMvS7WRe63xsWHw+YKt8hXCEDUK?=
 =?us-ascii?Q?XdPJ0pjhUy2ZlLzBVyEToUxgxNoyUn4XQvp4qY2eOsbmOCDvVRcFdxh1ziXO?=
 =?us-ascii?Q?P6ImnI7z5vU/Y17jv0zo/xzPj4e5mCOKyVxIEv2xzfIA3AW9t4p7ch9zpKnR?=
 =?us-ascii?Q?1HbNy8sT44XeKGbNoi8oGo0zOom7f2mb8KuqcZhymrSsac5Bg2N7QddjX94/?=
 =?us-ascii?Q?mXleTpQGsZxPOi5tWj51mC1a85h8kABF1Pml3RvzWuABbZDRQlDVKuoQkTdu?=
 =?us-ascii?Q?BGTZ0YGutgVvpSdOs1ai+BK888T+bHyIpxzX/88H6R+1SNN/q5Hdi/GAofWW?=
 =?us-ascii?Q?SN7jVxtQmU9JLlN/D6rp1rb95STs5aXvtTVKquchTP8l7RNsCY4vsRLO15xT?=
 =?us-ascii?Q?gxLYcY8Eq12jU4h/hLnTZlbQfxseam0gjH22cl81o5l1mfNYgGO8KqKG2vK6?=
 =?us-ascii?Q?MixoT9zaURdFSEVbBj8PI/JJDrdcoGvA9M/4Z/qGtyT0z/E0/GTWbaZFo3Vm?=
 =?us-ascii?Q?SvKakfeqsUDOJSFN/WYkHOlCJChvgsEK6X010LdGrINHlOKVwzZlUZU1Bjpv?=
 =?us-ascii?Q?BIqD5tTC4IACxaxPgOvga73NXhn06XPrzATArrkR2kc0NDIj1CFeeqlBk996?=
 =?us-ascii?Q?okWevi8YW0fTp3+Slt7jKsPMXndoGOAVZBoJEPG2qPc98c5cU2cMNXVrXacY?=
 =?us-ascii?Q?lw4Rj4R+6bVgOl2c2Is3m9O5B9NZJlYfV/aaxCcDNx6H2m/QHfjqAw1lJHz3?=
 =?us-ascii?Q?otNIoekYA7vt+WgDntFV7+p2YF9hJ2dsOlkC7CRADEpKgYDieTkebSd2Lr4m?=
 =?us-ascii?Q?iZXO3cWmL4c2qvlf97ZfV5D0NnB89StJL73K4nePFhH+dKaFYKutV8g6NQQQ?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192b8f73-6fa0-4fbd-ba8e-08ddca83f97a
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:30:33.5897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7Tyep0wL9+BKFFtDXSTL/A2zMus2l5/hRMKa2Kpl/pBtlVaVq4h9LTBeoxiY2We7rl4KS3Vj7RlItYHl17c1EsAzhcj/pEoLaUslyYYCIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB2657

This patch series simplifies the process of identifying which network
interface (can0..canX) corresponds to which physical CAN channel on
Kvaser PCIe based CAN interfaces.

Changes in v3:
  - Fixed typo; kvaser_pcied -> kvaser_pciefd in documentation patch

Changes in v2:
  - Replace use of netdev.dev_id with netdev.dev_port
  - Formatting and refactoring
  - New patch with devlink documentation

Jimmy Assarsson (10):
  can: kvaser_pciefd: Add support to control CAN LEDs on device
  can: kvaser_pciefd: Add support for ethtool set_phys_id()
  can: kvaser_pciefd: Add intermediate variable for device struct in
    probe()
  can: kvaser_pciefd: Store the different firmware version components in
    a struct
  can: kvaser_pciefd: Store device channel index
  can: kvaser_pciefd: Split driver into C-file and header-file.
  can: kvaser_pciefd: Add devlink support
  can: kvaser_pciefd: Expose device firmware version via devlink
    info_get()
  can: kvaser_pciefd: Add devlink port support
  Documentation: devlink: add devlink documentation for the
    kvaser_pciefd driver

 Documentation/networking/devlink/index.rst    |   1 +
 .../networking/devlink/kvaser_pciefd.rst      |  24 +++
 drivers/net/can/Kconfig                       |   1 +
 drivers/net/can/Makefile                      |   2 +-
 drivers/net/can/kvaser_pciefd/Makefile        |   3 +
 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h |  96 ++++++++++++
 .../kvaser_pciefd_core.c}                     | 144 +++++++++---------
 .../can/kvaser_pciefd/kvaser_pciefd_devlink.c |  61 ++++++++
 8 files changed, 258 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/networking/devlink/kvaser_pciefd.rst
 create mode 100644 drivers/net/can/kvaser_pciefd/Makefile
 create mode 100644 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
 rename drivers/net/can/{kvaser_pciefd.c => kvaser_pciefd/kvaser_pciefd_core.c} (96%)
 create mode 100644 drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c

-- 
2.49.0


