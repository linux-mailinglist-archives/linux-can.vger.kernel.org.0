Return-Path: <linux-can+bounces-4054-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F96BB0ED5E
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E794D188C840
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1B8272E57;
	Wed, 23 Jul 2025 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="WP8H3wQy"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2106.outbound.protection.outlook.com [40.107.103.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9A27A929
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259749; cv=fail; b=bEVIhiI6gHjxIoFT/HnqI6D/9A08dhtl930WU298lR2Hfs0HhOTZcnO7X2SjuAuQaz8XdxGguMbslRqWMg36AKgcItKKUBIiMnhfPvOFRn6vPlsrJDQWQdcbuXbk+iIk4LUci/0ut6BNp0HQBN6aUXZPfx1Xo/EvU3e5tStlyHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259749; c=relaxed/simple;
	bh=8ICrD5q165ARgLA+rFn80vIHbnAfE1u3EUwVb4U7RSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NIN9g1bBPqdQafEmnXJ0WSw+F51OolicFMLr26f4hh6CyJf95/g0vgeWlXK4jIGEBKE1qkK93bCASHX76igW+LXpW5DZPwX/wSxG5kYz/Rdsx4pd9gGrcNhdC1e3WN1vtjV3IY0pinOJ2ROqNoEUKl/BEbwlnqTXQinUpO7A5gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=WP8H3wQy; arc=fail smtp.client-ip=40.107.103.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPyraiZ/wGlgBACKw++rjhXtGQxzGNyRR2rij4y1dGn0UInwViEOzEwmknwICeFpmDj/5AEKbtRUDbvxDBj7UorEMelMFjiHrdnxGS66Zgd7mucg7i/5TtuZ2l8zv7i5TfxxqO87IUFP+au7wEqH/LxOrCUV3VI5p5Cwx96AmNZIW4MU31USB9UfpUy7H3u3LFoY9ExYVBJH7eiZmzoBmKSL/WrkZvh05A00UwvFAu1WV2SbfYE2zLnPNtNuVArU9guoCjGisjKU+EAj+QuLjK4WsImVFqCWAnEHcVhA0nQkziuIlyCBt5hq3mQLkv6TKJwo2eUZOXmyjpGCiJ66zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CDTRG/0FrUj2WS3f2P/FwFmbFru1/PubHgqYrfdaX4=;
 b=t+iMnvWemNwCLkCTCI2stpAo9UqkDotH9ryV/CGMMKaLc3tLAao55/VT9PGmgyitdHkPUQxmBbTd3lbHThCFsLl72O395P6iow6fJWXY49EDw0JuRuO/q4ZaE5DDi0zuwi+uMLRlb2Hat1GTCIvggafEmbvMytwbZ2EMyL3gauWWOfR/cry0KuepdfwG9ZJlzOP4qzdzIB2TbnQrMDE+2WqXIQZ6KFGQeqOcWXYSuQJ894b+d87wLXCjPuwlujloewcNwGpDwFDBA472GWLXfCwxPq15BGrVnz4q7zjpGfkVsBkF62f5iRWXok98D6Nc/KiHyUs5ctxRX6Cm3Dzhmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CDTRG/0FrUj2WS3f2P/FwFmbFru1/PubHgqYrfdaX4=;
 b=WP8H3wQy6yU2Yk07S6p4KIxkj09uBtzGOq8JYIBT9CWnwV0LxMfT3UNwsJSpA2VR2kLjv5OPukZVmQYra5dyg5Han40eWzL184tw2vS6kNV7mI/ThtH85mojP7FgMVoh9SJ3dPz2yhikMjgbEwCJvOr7h5HpnLyAqq21Hbw66k8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DU2P193MB2018.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:35:35 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:35:35 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 9/9] can: kvaser_usb: Add devlink port support
Date: Wed, 23 Jul 2025 10:35:08 +0200
Message-ID: <20250723083508.40-10-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723083508.40-1-extja@kvaser.com>
References: <20250723083508.40-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0064.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::26) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DU2P193MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b85f1a-320b-4d8e-364e-08ddc9c3e518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mcic6YmEki7xsZG0YMw9IxL8cH5Ufss+dG6EXYyAqlJp867QRkjuRwWwrE1D?=
 =?us-ascii?Q?24JxE3lq8ehwNsEtddY+hpvXXprarxHhzYVr4GAgOBxlatfRhq5382HnqhWC?=
 =?us-ascii?Q?ukU2dDrPTIz7sOkihVbnTABs1uisLUG7bDDdX4hdm3LrDiFK4Eth8PcKNV4B?=
 =?us-ascii?Q?P7VeJ6py6NW3yDaIO54Ff7UrJ5+mz5SAS6XFgLvdffVhUmKItNGpqHKBbL8/?=
 =?us-ascii?Q?RIuyj11V6/upUg4HdwgxfUTvz7ooXsbj58kIK6VWCLrR+ffwYqyDadOBcq9O?=
 =?us-ascii?Q?pmB7bl/vHAyXBdqckVuU2kv9z35gvQuoFxD4hvLidy/5RmZbuwtOHe286r/G?=
 =?us-ascii?Q?BRnmLq1RcBP0OF10jnMtr893Kh5DQjGgjhrmR077On7/IqViW0S6WPi85AT8?=
 =?us-ascii?Q?zVp0eBohFAtarlLGNBPMhiskqfoTbKyKyKVaqp8b6vTwdrR7gwJGMM7+VAcX?=
 =?us-ascii?Q?gFU46F7ymUf2DafuVLd937QK+LGszrWkhDV4L5KFh5k2Q70DuAYtd7BcUmEP?=
 =?us-ascii?Q?pjsiC0z5A5WwzJm4Ksuclj8L0/fA+zt1T9CPnj1ZaMqsciYvsa8KuPPNeLxn?=
 =?us-ascii?Q?wPKM17ipB9Arsy7+AWlClq3JjjA43tqxz5/+aG7aUp2GGLWpjMsldZAFY/fV?=
 =?us-ascii?Q?QAE/2AF1IX3QHofCZevVXE+0mgwflifKEWoWS46XGByt4aDnmf1flR+YgVHZ?=
 =?us-ascii?Q?G1yQNhwUllRo6bAhWZaxFKE/noKVx7sMIOJ/gNidYNr1w0QtTJRBqllsEXB1?=
 =?us-ascii?Q?8Ihs3sqgpCEhTvQq1hnoecTjNFXE6uI8dL99RX8jNkmfBr9RH6DBBfJxtuel?=
 =?us-ascii?Q?+IJMYVuBCR7iIpBVhUkIPAzC91VEhuwym5TvUnGpq9w+/BVjjczkdMSqfyRg?=
 =?us-ascii?Q?tG4V2v/BBJh/eJYqP3qORX7pjGY/lcnO1RlQVqc502Jyjza4+n218fhcdDYF?=
 =?us-ascii?Q?PelPwowJrsqnkid4ORSDPVez1m5OinbGvguCR+QsfMvsZUGr7tku05PtxUW6?=
 =?us-ascii?Q?eNkrXZ0po0QLc7IkkaIf1WZG+bIDwrXXbYs6L+cDbtNTa2AWf3n2i24Yht2j?=
 =?us-ascii?Q?xjrjmeHK0xrM8rUcdT4D/sjmLvh5Eq8Z9L7Vrgvmc1+7461h02V8+37rKO+3?=
 =?us-ascii?Q?JPjr8s4SUyuMOJRG1PnB8NnO5GZQIGNvRPKyfFulPmFN0X4iD1SSXBCHsZXc?=
 =?us-ascii?Q?EMwje8SkqHiAPAE8QpVY32BMqU00fLcFmgBbT0840ywwvkvzaD20G6Fad9c0?=
 =?us-ascii?Q?DwgG2oMAZFNN1UUioz3vUakRjE9366JhZjBqngGsYM0/W0em5VOm+MEf/9fB?=
 =?us-ascii?Q?CbFvCWBY7fFwxZXF532QbzWDsHPcyZU8PlcNB1sY5vpy/xx/T7JLllSH2BbK?=
 =?us-ascii?Q?kT/vHV3P/NTC3Vr/C1wTiqVVVbdxoL1hI40tC1DUOCapsPuQekrG4f1Cf6pf?=
 =?us-ascii?Q?FRk/D/Pr9pk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Btb7GoC418iilKOFYREjLjghahNW0+7tJRThCqQRqrD+hk30n1KuyJETkhEC?=
 =?us-ascii?Q?X8KnwSNgFVmCl0tZETOBT4iuR6y4yIVi7FFkoAr0qGiE8U5XNNPsv9fhiuuE?=
 =?us-ascii?Q?e+FDt/XD2UMFzbkEl9eFaARBE9pJ25iVN7NibOLx8ISOqdrpQ6v+emDkFrSB?=
 =?us-ascii?Q?ObZ8ZN1N3Vs9ul3YkKNrOhL17a6Otael8IaCGjb8gXTc8iyP2PPap20vEWfx?=
 =?us-ascii?Q?SutXieBXjVZJC79VGZYXUT5TEL3BgtVPQg1HRyOjDqC7FTq2pPo6NLUVqHpI?=
 =?us-ascii?Q?Fh3A4V+kIffc4wU5s8lnQsfjIyXUFPTCn6wvIZeEYV5DvX1HF0mi880zRW2S?=
 =?us-ascii?Q?JvyiWp5DilemW2mFGBe1PMRMK/BgxXUQ5OCo8VldsEMhXmKDFV1FWGo+t9Nq?=
 =?us-ascii?Q?0wluypEjLvrv2ON/9bHMSQTd7qrC82ZcOoQz2BUXT0KW94TiiFWywemG8t8g?=
 =?us-ascii?Q?C5FHZNZYfvnnPNYRUtuJIwo9QOu5g47uj199LHhDGXT97L4RwbeTVMokyP5I?=
 =?us-ascii?Q?Y+6j+Ol7N8K9T6RLb/PTYrKUnudz/cRegtbyamsY3J15bg8fX1ze3XjYkinJ?=
 =?us-ascii?Q?XzZDXxmGKkRjIdXVpmw2UaGKCSElDW37ajGQ/QSQyYiOixWNEKcflFDdViRs?=
 =?us-ascii?Q?0O4/Qcyay22/BzSAjT5kN23sGyYJxB9AB1f9BnwJnHpfqzYWlTi38LR4r16K?=
 =?us-ascii?Q?F+XbaK26VGkOUTpGIcGwd3ghJTOlOEEDnwMRcaW3g0R3EXXpuT9xpDDT/vil?=
 =?us-ascii?Q?RSfr8UKnrvWZscHUa7D2Kz7u6AiPLkMg4nWRtEBKrbmdfqGMv1VSiDUr9syx?=
 =?us-ascii?Q?C6q4J1OWIA0xKblF0C1u+khDRjEmNAt/ep5/4t9H9gMUDwsdnLhpOrIF2U+g?=
 =?us-ascii?Q?kdbUhEt9CSYub/jqImKiYBAy0iLe1/hxQpMrtda+SV55voRLtvYJwdkLOXdq?=
 =?us-ascii?Q?yIj2XXga6kU8fsA95HoN3MwRubOauaanprxraFul9BJRaC14jTtpFoXZCYei?=
 =?us-ascii?Q?IKlF/QCoZm0Wwyye0Fw9ZoJ0oX9UOnaMXojlFjUbdcFUmLet9rtfn6LtYxm8?=
 =?us-ascii?Q?pmNYIPkobRDX6lm0WDdVM3v1ZmFdsg8Lq+ZYgwFeJQgk2aXBFQjrDS7Wy3Og?=
 =?us-ascii?Q?kElZVqInodsB3rYJwCGvEEokk5Wk1vGnxtnI0sM2qlZZvAQTNDQIQ/6DFLAt?=
 =?us-ascii?Q?MDybeZ2jdfI6o/kNBBwoHJ/Ql258A3cjqEAiLzoIL6D+pRtzO8Dsw19V/DIH?=
 =?us-ascii?Q?MgyNj/jwvzgFysnVagJefd6IcFPOiIMYeOqfYBQCpFCnPO8CUerWpy4u7DNw?=
 =?us-ascii?Q?RqRwx/WRK+mE6LDKSiJqh5J21g0wnN/CDZxUGVugVVYK61d4ccPxfzTeX+1f?=
 =?us-ascii?Q?G9Zh888fadha3oW6FnaKRd9B71u4/Q+ZVdtc0lHIk5o0Jk5fVCqBt1c3zE25?=
 =?us-ascii?Q?XLI5gC6PEcrtLz9SbtrGGa9rzkXQlOi4g5n4HJQ35MdV+ksuopZIRbxiMRtG?=
 =?us-ascii?Q?rD4JsjX0k0B7NFX8g6zKNdDWlkaSwS7/5uTIf469xGjdBzl6eBPUQbvdcVN7?=
 =?us-ascii?Q?noeTfglWbPQdvIEQ0UncC/0VqquOkaOoVa75DKBELUQT4q8LVI0z6sHnBJuP?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b85f1a-320b-4d8e-364e-08ddc9c3e518
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:35:35.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCRCM97PuQb94KtjzdnuPqwS7laiYCK3Rr/5xcIin8Dht2ZyLRnmLFGwNM7dk18aWiTC9s71lzU/AwIMzuRV4pQAvzgC1Od/10PLFbaRao8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2018

Register each CAN channel of the device as an devlink physical port.
This makes it easier to get device information for a given network
interface (i.e. can2).

Example output:
$ devlink dev
usb/1-1.3:1.0

$ devlink port
usb/1-1.3:1.0/0: type eth netdev can0 flavour physical port 0 splittable false
usb/1-1.3:1.0/1: type eth netdev can1 flavour physical port 1 splittable false

$ devlink port show can1
usb/1-1.3:1.0/1: type eth netdev can1 flavour physical port 0 splittable false

$ devlink dev info
usb/1-1.3:1.0:
  driver kvaser_usb
  serial_number 1020
  versions:
      fixed:
        board.rev 1
        board.id 7330130009653
      running:
        fw 3.22.527

$ ethtool -i can1
driver: kvaser_usb
version: 6.12.10-arch1-1
firmware-version: 3.22.527
expansion-rom-version:
bus-info: 1-1.3:1.0
supports-statistics: no
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: no

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  4 +++
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 15 ++++++++---
 .../can/usb/kvaser_usb/kvaser_usb_devlink.c   | 25 +++++++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index d5f913ac9b44..46a1b6907a50 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -131,6 +131,7 @@ struct kvaser_usb {
 
 struct kvaser_usb_net_priv {
 	struct can_priv can;
+	struct devlink_port devlink_port;
 	struct can_berr_counter bec;
 
 	/* subdriver-specific data */
@@ -229,6 +230,9 @@ extern const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops;
 
 extern const struct devlink_ops kvaser_usb_devlink_ops;
 
+int kvaser_usb_devlink_port_register(struct kvaser_usb_net_priv *priv);
+void kvaser_usb_devlink_port_unregister(struct kvaser_usb_net_priv *priv);
+
 void kvaser_usb_unlink_tx_urbs(struct kvaser_usb_net_priv *priv);
 
 int kvaser_usb_recv_cmd(const struct kvaser_usb *dev, void *cmd, int len,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index d93b9460c683..4b29cc3604f4 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -821,6 +821,7 @@ static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
 		if (ops->dev_remove_channel)
 			ops->dev_remove_channel(priv);
 
+		kvaser_usb_devlink_port_unregister(priv);
 		free_candev(priv->netdev);
 	}
 }
@@ -893,20 +894,28 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	if (ops->dev_init_channel) {
 		err = ops->dev_init_channel(priv);
 		if (err)
-			goto err;
+			goto candev_free;
+	}
+
+	err = kvaser_usb_devlink_port_register(priv);
+	if (err) {
+		dev_err(&dev->intf->dev, "Failed to register devlink port\n");
+		goto candev_free;
 	}
 
 	err = register_candev(netdev);
 	if (err) {
 		dev_err(&dev->intf->dev, "Failed to register CAN device\n");
-		goto err;
+		goto unregister_devlink_port;
 	}
 
 	netdev_dbg(netdev, "device registered\n");
 
 	return 0;
 
-err:
+unregister_devlink_port:
+	kvaser_usb_devlink_port_unregister(priv);
+candev_free:
 	free_candev(netdev);
 	dev->nets[channel] = NULL;
 	return err;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
index aca36794198e..81e389e49a3e 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
  */
 
+#include <linux/netdevice.h>
 #include <net/devlink.h>
 
 #include "kvaser_usb.h"
@@ -61,3 +62,27 @@ static int kvaser_usb_devlink_info_get(struct devlink *devlink,
 const struct devlink_ops kvaser_usb_devlink_ops = {
 	.info_get = kvaser_usb_devlink_info_get,
 };
+
+int kvaser_usb_devlink_port_register(struct kvaser_usb_net_priv *priv)
+{
+	int ret;
+	struct devlink_port_attrs attrs = {
+		.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL,
+		.phys.port_number = priv->channel,
+	};
+	devlink_port_attrs_set(&priv->devlink_port, &attrs);
+
+	ret = devlink_port_register(priv_to_devlink(priv->dev),
+				    &priv->devlink_port, priv->channel);
+	if (ret)
+		return ret;
+
+	SET_NETDEV_DEVLINK_PORT(priv->netdev, &priv->devlink_port);
+
+	return 0;
+}
+
+void kvaser_usb_devlink_port_unregister(struct kvaser_usb_net_priv *priv)
+{
+	devlink_port_unregister(&priv->devlink_port);
+}
-- 
2.49.0


