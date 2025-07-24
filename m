Return-Path: <linux-can+bounces-4071-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEFFB100B5
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 08:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704095858F2
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 06:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CD721B9F4;
	Thu, 24 Jul 2025 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="VQwGVwDD"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2139.outbound.protection.outlook.com [40.107.22.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBCF205ABA;
	Thu, 24 Jul 2025 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339043; cv=fail; b=h7cjZP7f075PoFXM0kTkGa41FF6sxzA+2r3t4xoBcUd5JxX9S7yt3emlnodCzMo3rAlz7sYA6/ZmwZURfMwK9vsQzodG/YDnxsEbDuxOqxlFMCz6sLF0J/15iZgPltGiIOP2WwsgBCzkhxDXG9kCcSL1SpzdfQkIAvLMEMAmAVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339043; c=relaxed/simple;
	bh=cty/iypbAvEhk8gstqLp9xW6IDMsDobMloLKJmFBQmI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tI0f6RZ963/LZrdE0RrT+062XHEEyp7t9VCH8hx1qSuG5f2rjf70jPS7rajHpKOZ/XJfWMhcdhopg3QxPyp5XR5ZzZMl8kh0oUNgthH373Eyl9OyE7ph7bJ3afduuQStMmqAtrYUiahaqLAWpDw6SX6HKjtuMJAvu6GxMTse6oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=VQwGVwDD; arc=fail smtp.client-ip=40.107.22.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQ4zmPlNxs31CpV52gLB9/AEYWniNYo3ctAmGBT8I5Qd+9jCS+V4Ci9nQw/vBZZDqkVv4QZwXOzrto3Ubsyw9ovxd9r/u2YCGMGuiUSqg8yVsKihleS7Cv0GD0ODMamnP/UEDvejed29y8g1YDUL9Oep6EfjBb8AzKmAbUmKwJqekKtdDPet4vNxCFPVGTZIv33ldh5lmRZhULJjtC/ONqG1iqC36S648qu86KvbNrhQ2hN3DkQ8YOxGUEwk5JPrGksbmMWObJvsG4sNre4uOhwzFSlxXLzXS0EjMAYYRxlsaUbKDdY+z7Ds0N8GZvr5FMSC5T3w1c6M1mKgEU96HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/M3dltBHyH5jUy/eV6zbeZx0L6ES87FCh1yQNNUxBMg=;
 b=d3c7XUdObLMGGym1V2vxf2SXhuNG7HnmjEY8NzBWemGXN/cWhp6Ld94BPeyEpLtSYODQlPrHHsBUqs1y9DnnWCpnlnz++nK3+VsjmUnOJ5wDsq9w93LrqQkefHw4wACzNSxF0cEL7+zi8/9QREAZTYPkYzb4uxZHqPQRNKF3UcEfXz8Ftmd5SrjhBS+aknkUGvABOub9M9gspX0HkK+TqWbVqZBm22cpDvnOjeMwx0HGvDicaxlVwuKMbQHIi6RFdVzMBY2rCAWNZQ51WShftVX5nxh9lSgf6ToXo+bIrNVX/igor7zEfu/8AalmKIqNDVnLoS524e1cRxUTIGL09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/M3dltBHyH5jUy/eV6zbeZx0L6ES87FCh1yQNNUxBMg=;
 b=VQwGVwDDgZ1lWKHjTAron3L5+RlVL2aF25T1Fucq+zZMLqP1DQl0RWm80gyLw9NgggZ+hQ/aR+Xxh4XDpGSk5rltwKI1tbNj9qKWxdpghoom/zKkYpNBWYK+SpZKl+grOPwR/VriHx6onxAiCfwWkruFFCO7sO9F5tVm3ZUsJVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM0P193MB0562.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:163::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 06:37:15 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 06:37:15 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 00/10] can: kvaser_pciefd: Simplify identification of physical CAN interfaces
Date: Thu, 24 Jul 2025 08:36:41 +0200
Message-ID: <20250724063651.8-1-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
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
X-MS-Office365-Filtering-Correlation-Id: 3fb5c72f-60d7-426f-6d99-08ddca7c8746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3A8p0tPUBiAyPovYygrjnxpmS5a1NpvpQSYfMOWAUSD7cSKwR8wv8DDvB6WI?=
 =?us-ascii?Q?3FRB/Xwb4j0lECh86M+oMr/NWrtL9ITL9Ss2Vl/rsheV41zFLH7aY/UGARir?=
 =?us-ascii?Q?0MxMMn4vnYd3IvK095cmEGfpIz34paxLqxgoVFbvW3uEUJpeLSZIANjrQX1J?=
 =?us-ascii?Q?fQBZ2H5Nqe1D3UPF3xKfdwVtt64+jlCN0jYB2cvKKWQiFWd0vJLk3tpKESqm?=
 =?us-ascii?Q?/uQScQy88pXRnO9vfT86hpPHK0I61GyftM+2Kc5Yh9FyNnF3bnERXogwaOA/?=
 =?us-ascii?Q?WVlVdHKLnhYs/3gQ3Q1fFu1UYQ65DVSMcaI1Evvn1KaQCAXx6J6+Or2mvBlq?=
 =?us-ascii?Q?o0Hnj0X3gZzR94doMbx5e9YTHJVZQYicqoWAXxR2UMwtpUXVm9Z+yGyXJjne?=
 =?us-ascii?Q?2ukFzyDjEGN2U2hErdq+WiH6NJf7hHZk5vRqXW2OPcOoTFFAi+KEgcwuQLOk?=
 =?us-ascii?Q?x1BV4auLNWwWVBKZuU7K+HpaByacTZ9rxohG3x9o2ArprUCwP2EN7KeGSZ2b?=
 =?us-ascii?Q?DGqPCEMMBWgk9vrVW+SQjGDqEgkh/1PYAs133tjrzBZxAOxWsW7qz6ysjIu/?=
 =?us-ascii?Q?FK7/Tqmez0tJb6j3s4csQOUnk+CgN5m5ubHezVZPeat7gm3nf/KD+lvbHlcO?=
 =?us-ascii?Q?4wbk7zDT3Dc1P0WOBZ4840RbBvlBMbI0WcyGJVPhWt5YmUnVKazm+mSeANhl?=
 =?us-ascii?Q?jP48OfVsE0AmywgmOUxnoD4AJ2jmC+fJvg5qG1EMNE4T5ZpKj6Y5/Sg3gSLn?=
 =?us-ascii?Q?a7S6sRT1MyAoD0NthAbEWkrgxYAvh2uRCCbej9YTGKiQ+DCoeNlFTF37FmuC?=
 =?us-ascii?Q?5wb4NzmqRFBwXKQesaLzDa1BHX6wycK60Xyk/cRuPnDCUi5MIh785TutVqfR?=
 =?us-ascii?Q?E5SAwYCCEWdupQtSdwqQyNJ/mB72AjnLlWGCt2G8b5XGx26/0L0G8xZqYrcS?=
 =?us-ascii?Q?k9Ae9YYNw+lT9DjIynI71O8MVXYk5AbImVoevNg2RI3Y1fqZUKna3KqGXMCm?=
 =?us-ascii?Q?vxzNX9vf06vVJaxauefAZf/WMa9XZwhy4lY2nSUWStASiFNApXb1dLi9eUP6?=
 =?us-ascii?Q?5zCNkP5AO/sdS7HcjBgwnCMalw/BLeFhjHfc5DepfB3fF4hne5kNvQLnw/JU?=
 =?us-ascii?Q?tgCH4hFUj5bX7WeExBzA3/0WQQu6Qt1pWUqZQnXNT2mBHi0phv+L/DI4acHw?=
 =?us-ascii?Q?4GBEzdtHR9rrcjL39vTSik6HC1H11sA9aFYpKHKry0PjUHWsqKPKqS/DyVFb?=
 =?us-ascii?Q?xud/UR1VMzlNwQjpvNyRvvhe6RR0IZLj/Jv/x8Mw2bi+bPePlP/z7lkPgMDP?=
 =?us-ascii?Q?HZfMsI0LhQV/Qo3q3rRWBTEgGg1LIKJ6w5C3OVDxnmLXpiES7afvHDt5Q3FA?=
 =?us-ascii?Q?80gi9fNWbrjubf5QIs5WOE4dsYcEFFdxxrFU7dUWiR8YdJR4fHqtq9lgX5S/?=
 =?us-ascii?Q?WooSCW3Jcl4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NBnis2hU0VFl7/vMFbftSMEipKEt5dBNaWY3s3W1KIyoG8AAJ/NRc1TlgJnd?=
 =?us-ascii?Q?ibsR/G408rBfFuuQjwbpRdnz/znosVg55aMl/MpmUrq8jDHmufk2QuXHZT3L?=
 =?us-ascii?Q?Pfk24ZMCBgY2js3bJrYnlSGfcTEZtpB+dGBtOyYoSzQQblWUuYINaNJcVWKD?=
 =?us-ascii?Q?ElSH0kfM7yvZESMurIfXfqhGHj/b/501O5eEegs1Er6aIJX7NRBNNGci7eTs?=
 =?us-ascii?Q?6spg2GZ/PTwCZ8+H1hQbHX7AtSSckc3VxpZHn3rDDA4h18mcZU1iOQ+fAa1c?=
 =?us-ascii?Q?iktlJTvaJo2FBYsn/Ok/UqDSGURdsl4Ul0jnpve0LBsovMKZIQ7cyiZptRZi?=
 =?us-ascii?Q?lvW+gz0IKKrXJM5iZL2MuMRcGSUNBD1S56gaiBJOpPNJxTh2IF9c6DgYt+j6?=
 =?us-ascii?Q?T9ehrfJosQ4LdkjXoZQVfgiBvKrT8mZ9lmquKc7XTczqFJgZW87HFNjGcWfc?=
 =?us-ascii?Q?82iUPQBQ5ksYKiGdx2rOCGDVTs2rW5tlt1tJF0zspax6mh9gEMWiCye4uVzJ?=
 =?us-ascii?Q?qHjFVCMoOaALiToyl/bw0b+xdx6eaecdjuqJ7FD6qyHWVMpXQcYTX/F4Iwst?=
 =?us-ascii?Q?o+wKAWAT9/ByD5777lpwLaL2/SFqjijUea96mxJFJnu48/Y/iOKxptHP5bRU?=
 =?us-ascii?Q?DMGE9tmd8fr2DgNwaZYjcHlC5IakOaYWCB2E599RSqgI9KOQ9XrOAmvZ0ggK?=
 =?us-ascii?Q?eeS6TmS2sdG85bZGrqubKtiSGMLALUqo5G4V88sYNfODqgTQXZO4SVzGHle7?=
 =?us-ascii?Q?EppCK+23UaI8S1hhqqxrOI6pHNAh70IYwSSmqp4ECjqhhOt9PmA7jtqebFkc?=
 =?us-ascii?Q?VQR3y6Y9zTYL+4cVSnZJEKth2SA4CzlmBJ01gi8+jwE5Z+YWneUdMRArooTS?=
 =?us-ascii?Q?9o/z97pD/T2e38ho+z0P5juZT3qLaUf0MRBUyCrZvSI1CVoln3ACnaxlOjmH?=
 =?us-ascii?Q?+vyyh9sH9shbKQMuwLh2SYGhjMIrW3hj2+ns086nltdI+gh4bMqCXrtLg8zd?=
 =?us-ascii?Q?OwnMF2fhloL4P0fxER2Sk5bL3rZgD8u0ZWSEl9kmVrTHRckvMUr134odxtT0?=
 =?us-ascii?Q?Q2QJmOEgVS6TjfRWsJ1pO55RTHjMhyHoVAiqs2RbRKPP2oiHe4AM6CXQTc5X?=
 =?us-ascii?Q?EK9Bk3101NfWKndoKS7Nm1a4Eu1Ll1r2TtGmQ7+lX8583/TR31HZVr8sC9zh?=
 =?us-ascii?Q?JWIqyZFXg+5HO1FvhqDQznJ0YYVi/8ikYMPhVSRQjZIXoFj/d9gu9rjaHOgp?=
 =?us-ascii?Q?jq/JmfN50w8F5d/SoFhYlHKGCaWUH4eod7csNu3zJQYXubfse+9zcr1o+BNU?=
 =?us-ascii?Q?YHoJdlHqlwaSpvwWjh7m+5SGI39OqbX80zinD6gcpS9xthW7AXyDC9PrQ/tW?=
 =?us-ascii?Q?ktEGqc9v0Znr8PaEJ5Oj51b7hygRPoW/HUQv15JoI6oyVPiDtNj7KOHUDNJl?=
 =?us-ascii?Q?B8jzJmE6WLPQA8WBQr+fEs6J5qaoWAjcfQ0qUgEMs2aP79l1d1zKPynqVw6l?=
 =?us-ascii?Q?lveLIhYYWLgRNxJaN4sBpQKIIKxCP2ZIJ0T6f6qtGdagu13hG6XTH+BtAkL/?=
 =?us-ascii?Q?zojGy9T+0cr+6LbNDzgxD6YcIHGUAdfZ3a3rfuLTslW4NdWMtmnoSNhpGtO+?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb5c72f-60d7-426f-6d99-08ddca7c8746
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:37:15.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2np/YRWkcxfE6cWoMBZx5ByEtkmNx+OZa3p0v3h9ge3gisO7t1sma2TYXVYDROexv+NUQTYONY/A+01csxyn+D+MncL69eDWytVRScWsyQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0562

This patch series simplifies the process of identifying which network
interface (can0..canX) corresponds to which physical CAN channel on
Kvaser PCIe based CAN interfaces.

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


