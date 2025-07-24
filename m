Return-Path: <linux-can+bounces-4092-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C50A1B101DE
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759461CC8886
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 07:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C7A26E70B;
	Thu, 24 Jul 2025 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="hiAPZLwr"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2131.outbound.protection.outlook.com [40.107.22.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4C526CE30;
	Thu, 24 Jul 2025 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342251; cv=fail; b=pC499PbeQj7Cs82IWwdqK+nNaSmSmfBBl4vM3tpTDKMgEV2zkW3zJu6nDmhw+q8Ck972p4So12ZOAnHxeInZuUBUJ4UZGB2lCwzQfd4QThGiUV2qM8ZO6/3Qyo9v8O59rdMkSDWeYS0qDJxs7KiDM7sBNITAtpYMcRRtOorJmso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342251; c=relaxed/simple;
	bh=m9Odsp6QOAadL9Hcigl1hUp3DYZc8QjlOOudyGD/ovc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g5vh11KbYHs7QORQ7TTyjaYByVj8wxYi511oF5JLVC/Y7db8bq1W8QqaN/4iW/slOUkBj0IcrIvDCuoLETalB5px2OSFeaamjLh+SiTAvy1ms6edab+PhbjONC47iGAqFgXjF4ggs3XeQTOb9TRtOB//nLGB6nJpZz0YMs5njDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=hiAPZLwr; arc=fail smtp.client-ip=40.107.22.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=an4FbuHVfDrY0inS6ezD+UTWmWCzR2GhM9TFZ4K6feSuHOIp8pFt1lwXPAaRO3Y3xHZgZPWuTIHtlEHQR1oQkq8kJ8NkLn1Dx/FUsE99Bi7eW/sLP+dDKGTRQsIl4rO5vVTArErD3X3QSwtPD/U4qMIUkurWpw6/ZeKdluq+Vq3QgEaxf97Ealuqvnx9obHlZwDFYESHVmoT0xAWwJQgwx5CGvKigfdE+hduNGAEVieus8qy3aQj794+knC2ZVWpluGmRn/LwtGeJkDzu0rwKoBS0H7X0pc+EeS3ADZLJqHm515dUeXBG/6Ts+nDSY7XCVB7BD4TMZ84msrxWf7bcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUOe6c4PA9i9pamoXsWJMDdjb4V+vNewWjlfiJxlc6c=;
 b=fxRPsx1SvQLsoOWk8QG2M7xrd4wx3K4eOywP7+72NZu6U58q3FZtXv2BYlT4tpVe5SGecnbaI/zSv2BoYcEbsQeULxnGUHb0VzhF0UOELWc9KQAPDbqvkCQBoHnL3Mi5dKqaT0Uy4r3Jsf5kMGHidqSu6CSL5NWtBaDsoU2IslHc6Sz2HcBb1C6yK5PtJpev3e4SLNH70C70FObMCFiY4iIGA1E+i63Y00aQMKpqqcTosE5hkmRDYw2RY2MPZqy9RL0ulF5pkTK/7AcmTb/6yf0g8AJ+eDp79yZZ9l636W/uh98Y9ZdosT/n7N28ivyFU1+UdfTojVTyuXi+fWVhZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUOe6c4PA9i9pamoXsWJMDdjb4V+vNewWjlfiJxlc6c=;
 b=hiAPZLwrBv9Gj2WOla7bfbYk/a6/O//NOCwOGyp/rSWvFoWsi9alXots1n/nPvpkQZzwiHDxTDiO6su4bozveTWmnG3AwhaSknUMcOK7k6qY1AAJ+/uCIHX3bOzpZdPUJQjXmMiezVpmfvAgX/oMOalcv5Ig0ofrEKfHrA6vLuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AMBP193MB2850.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:6ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:30:40 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:30:40 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v3 09/10] can: kvaser_pciefd: Add devlink port support
Date: Thu, 24 Jul 2025 09:30:20 +0200
Message-ID: <20250724073021.8-10-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724073021.8-1-extja@kvaser.com>
References: <20250724073021.8-1-extja@kvaser.com>
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
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AMBP193MB2850:EE_
X-MS-Office365-Filtering-Correlation-Id: b7582c69-ff2f-4db7-0614-08ddca83fd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qVQKLNZIMh0hCu//Y5w9++BoYzB2wiRY7YU7U1Yo328r4nQjf40ueZ7ep8nb?=
 =?us-ascii?Q?UFwpjns+vF5J2a5FjpY4bJFqH5Gl4LFJOUpmDXgVQurfV4hZ2uR3tm8mMGoW?=
 =?us-ascii?Q?LvuMKtknWGxScNZTHFxg7D80G5FYmMYhABcAZDKME0KBcf2bRyEQLNkLxxs3?=
 =?us-ascii?Q?RcsRNeQZQMXL0cK4va7W0w6aM3eN+ncn490pHx088AZlm2pu/bFdsjS2n+PM?=
 =?us-ascii?Q?/78uC9YZj9+CFs97zjJM63AiuFOufGsk7op1UxuZC0xeJS4RhtqRg5WwNT+m?=
 =?us-ascii?Q?nwT5AQuVNLQc7mjQy2Rb/y2paTS204fi2ZLWT2KJ+thHWZqFak4764+zRT3v?=
 =?us-ascii?Q?DZqYAtxSZZsH46aQSgo0ald1bMwc2aFo6LnpusTRPChFBSUUwdVikzNjIS8G?=
 =?us-ascii?Q?Hec6H8OskH0lsoyHNeukWuAXrfDs2nW99x5AB+qy7BWosD0Ku1daXJz9rAay?=
 =?us-ascii?Q?nYnnVaciDo3q6uMTnWPvAhCxGh6UtkGoQc97fpcozG3o7JOgD9W5mRbDotzP?=
 =?us-ascii?Q?3g1qlL0mEgNZK90VOez++nWT4nz5GjFBGEvAZnZfolsYqq2KWM1vg37TOken?=
 =?us-ascii?Q?0ioedJWPk5XymgL0dFDuTk1p2n5QR3hqrBZOQBIFxfw7bWZZPGMSn3HWoXE5?=
 =?us-ascii?Q?oxM2CoBqKHE+/Cpuw4fC3A+x5oqMN171Y0boGbKYR08H98Xb661VIcL79gPO?=
 =?us-ascii?Q?NBQ9ViMK7NhCtlVRVahyqBqUY/qVLJo5w0gFa+JzWxcGoF1mUy7jEjVGbFKK?=
 =?us-ascii?Q?nr7dJ82klfIZPqGOsJS2OZDcaoTcv3lryhLJDaNtd7qSFby51JZxzlOy9Nfv?=
 =?us-ascii?Q?SUu2ySoKXKbadDwMa6NMdUPjp1ck6oqckSR+pE8n00C386mXt0gmRkyknmwq?=
 =?us-ascii?Q?BnNwHxD7tGxl8c+QIUKhvZckUbGXhIhQMCWv1+fqin/EOJIai5naUTcVdNJ7?=
 =?us-ascii?Q?XAIyk7CvZdslSB87SNFb530k19sQLMxqDR2c2Wb3B7axsUUR8iQ9vkAc+WlA?=
 =?us-ascii?Q?aNonXDV59LPe0B85BjXjmKCKGEBylZ2r6mOYumhGJEvPZ0Cn2wDr2cYxpS8O?=
 =?us-ascii?Q?21gduibk2oYbMn374dowqUebjrdQIiLgEwkzX4pwWbSxg3i9ZC4Z7oA3vih6?=
 =?us-ascii?Q?AkUguUGy1V936hAHw+V4j/xB+MWID2V/SvG8J41JzEjzYUDPTbLSElsxYpJz?=
 =?us-ascii?Q?tZa4oLvV2mavy6eKjZN1ck/Nw9uiKpWwsTknbA+t/UKcp9jyiW2y+AUeHXS7?=
 =?us-ascii?Q?2ev6Ns2xxmo5NvuCE2n8ihcpuWSLRzoO//UgfbFtJZI7ufKLmae3hxMb2LFY?=
 =?us-ascii?Q?LAdJm2yZlq7v47tEKzImQwmdiNOVfU+J9Xd+GTw7cy1VORMu6NtcUX4sPtYY?=
 =?us-ascii?Q?l2UoPaI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7as2agAC73nnAKnrKL/iGgB1SxkuRGMOwm2A1W1HLsExmrod146UimeSvCbX?=
 =?us-ascii?Q?8REbHDzMpVEwz4zGO25RtRJ2DyLqE+nR19+hO0exauSPPGJDqSIM6SdCqonv?=
 =?us-ascii?Q?pixWpywQGcQs67BqTTlUKXGbZQW+zwVXE/CV9CVnghFcNH5sJdAn0EeqRm4P?=
 =?us-ascii?Q?Oipa5JAC3e7FiFlEWpyfI5JbQiMzmndnjsh5+h+Ip17dQaQjv2XbiyZdj3Zq?=
 =?us-ascii?Q?UxUqzP6CLIoWudldoQ8Tyn820e/mMx3k5Yw/pxeMF48wlmHqWtFhFxT9QUt+?=
 =?us-ascii?Q?pGhFcTUeFUi/1ql4piac3+2OZLU3M+xGtt7ab+oUk0NOECE3lBSX5WuGEt34?=
 =?us-ascii?Q?l9v0yNDe6sDTJT4urKh/gRXDDf3eDDPaK2lOnSMO9Etcm1e+iunJmMBcsNOT?=
 =?us-ascii?Q?airfJfoLCEcpNwA5dKaRcZnYPZmMwEppjEBXtlHsbC8OqvJf6Hah77H5g5wt?=
 =?us-ascii?Q?2WZ7J7PU5ZgrvLa67sGbpTDoIUuecj/WDQVdFsLKXTLSv+ITHo69ZySF9bNs?=
 =?us-ascii?Q?bz9s4RwlfBfnfWVlJ8zRTYKdCpBRSCOOhK764XNsUocLqd+Md/ljE4GMbBxO?=
 =?us-ascii?Q?kMqvzu6LAiVnB171HTBM1V1m1SdyyPX7i2T4Qxayek1l8VtmQbMwAw43x/f+?=
 =?us-ascii?Q?1a69vSz2c1/Qz2TZIfU2oPc7zeWh6hSRGYua1m8/rVZ3jOa1C7vFmIl3aAIZ?=
 =?us-ascii?Q?4bJN9D4uAtWxsAi85ABxbbML8Zzvg05waBF8qXqlz3mBovOnm5O2yottva/T?=
 =?us-ascii?Q?eZB4qGKu5rNi7kKZB7xXzGY/helzm/Hwb1hZFPvRCOa2E34Wy48+1amf0V+U?=
 =?us-ascii?Q?Oy/dBntzuXFq49iV+fboOTBPK3dFNVFXaWkeE0WSkQ5oc79hjqGjDGsSlXmt?=
 =?us-ascii?Q?u7rGfd/RyJMv/vS6gxzgArUm1G3hYCRw9+JB4iza3FKW3rbOYKg+iiyqie59?=
 =?us-ascii?Q?MfNis7qBBEsZYkS+jEcwCxl7IbQcQTDOpHQtmBpsq5fs+isssuhIToM0pReE?=
 =?us-ascii?Q?av1ciVk1Th11hJ4tvteupNlvpLkzUjcCYQrfrRJ/XfL9s2xdS+pncW3kkkf5?=
 =?us-ascii?Q?tJtD26hvNT2Q4jFeXxXCnXXtvMoDPznJfKMZ8bhwSnhJUCV8i125g4medhnq?=
 =?us-ascii?Q?vMZ9i5g2bvjPc79MayGiSv6+MedUr2kObXgqOZf039jksEXvnspK1JSuC+uF?=
 =?us-ascii?Q?IFEhX9PuMMN3/KeMSf3Q0vMmebIumKFtIem8M5BgTJscQFIh55VCvAnGQ5Lt?=
 =?us-ascii?Q?WHtGIJxFQSWlDk6r8t1Tg1oQ9Mct0vD9CfN+3dhAk3je4/qaklAaZ041/dJX?=
 =?us-ascii?Q?TLCETKi82ksaX/KJsj3bOySijINFQ+RfuGIuWIT/GTWxRUZqjBSOA7Ib1tOg?=
 =?us-ascii?Q?kE1FuQGVKlPBCZ+e0VNSLNyLY1epaBbtT1WnBlToT9L3pT9mZ7aSrXT5v4yb?=
 =?us-ascii?Q?895IHEG2W89RYf1PMQlO908RSEZli1W+vmCaY7IPqjIdrQsfKJXKnes+lwAh?=
 =?us-ascii?Q?z3gKQ7+EuP+xWrJ89JoTPjvWsg/3lyWw3Wbtwi5yiGMrjNgSgZFg+1DjMBAZ?=
 =?us-ascii?Q?tTj6RHQ3IE61KfIFH4chbds16VBQdeIFdLu96u77JlBq8syjt294h86dc8p9?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7582c69-ff2f-4db7-0614-08ddca83fd6b
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:30:40.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BYFAY8UwSgNj8wTpNNkuBpMSx7iKqK+0i1R3d3DXh7JxXzXya0VmfBwGACnmLbzfaPYAKoW5L/HMz5XOfomChZl6arnPGmGP0scx4+D9X4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP193MB2850

Register each CAN channel of the device as an devlink physical port.
This makes it easier to get device information for a given network
interface (i.e. can2).

Example output:
  $ devlink dev
  pci/0000:07:00.0
  pci/0000:08:00.0
  pci/0000:09:00.0

  $ devlink port
  pci/0000:07:00.0/0: type eth netdev can0 flavour physical port 0 splittable false
  pci/0000:07:00.0/1: type eth netdev can1 flavour physical port 1 splittable false
  pci/0000:07:00.0/2: type eth netdev can2 flavour physical port 2 splittable false
  pci/0000:07:00.0/3: type eth netdev can3 flavour physical port 3 splittable false
  pci/0000:08:00.0/0: type eth netdev can4 flavour physical port 0 splittable false
  pci/0000:08:00.0/1: type eth netdev can5 flavour physical port 1 splittable false
  pci/0000:09:00.0/0: type eth netdev can6 flavour physical port 0 splittable false
  pci/0000:09:00.0/1: type eth netdev can7 flavour physical port 1 splittable false
  pci/0000:09:00.0/2: type eth netdev can8 flavour physical port 2 splittable false
  pci/0000:09:00.0/3: type eth netdev can9 flavour physical port 3 splittable false

  $ devlink port show can2
  pci/0000:07:00.0/2: type eth netdev can2 flavour physical port 2 splittable false

  $ devlink dev info
  pci/0000:07:00.0:
    driver kvaser_pciefd
    versions:
        running:
          fw 1.3.75
  pci/0000:08:00.0:
    driver kvaser_pciefd
    versions:
        running:
          fw 2.4.29
  pci/0000:09:00.0:
    driver kvaser_pciefd
    versions:
        running:
          fw 1.3.72

  $  sudo ethtool -i can2
  driver: kvaser_pciefd
  version: 6.8.0-40-generic
  firmware-version: 1.3.75
  expansion-rom-version:
  bus-info: 0000:07:00.0
  supports-statistics: no
  supports-test: no
  supports-eeprom-access: no
  supports-register-dump: no
  supports-priv-flags: no

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Add two space indentation to terminal output.
    Suggested by Vincent Mailhol [1]
  - Replace netdev.dev_id with netdev.dev_port, to reflect changes in
    previous patch.

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m31ee4aad13ee29d5559b56fdce842609ae4f67c5

 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h |  4 +++
 .../can/kvaser_pciefd/kvaser_pciefd_core.c    |  8 ++++++
 .../can/kvaser_pciefd/kvaser_pciefd_devlink.c | 25 +++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
index 34ba393d6093..08c9ddc1ee85 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
@@ -59,6 +59,7 @@ struct kvaser_pciefd_fw_version {
 
 struct kvaser_pciefd_can {
 	struct can_priv can;
+	struct devlink_port devlink_port;
 	struct kvaser_pciefd *kv_pcie;
 	void __iomem *reg_base;
 	struct can_berr_counter bec;
@@ -89,4 +90,7 @@ struct kvaser_pciefd {
 };
 
 extern const struct devlink_ops kvaser_pciefd_devlink_ops;
+
+int kvaser_pciefd_devlink_port_register(struct kvaser_pciefd_can *can);
+void kvaser_pciefd_devlink_port_unregister(struct kvaser_pciefd_can *can);
 #endif /* _KVASER_PCIEFD_H */
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
index 60c72ab0a5d8..86584ce7bbfa 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
@@ -943,6 +943,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		struct net_device *netdev;
 		struct kvaser_pciefd_can *can;
 		u32 status, tx_nr_packets_max;
+		int ret;
 
 		netdev = alloc_candev(sizeof(struct kvaser_pciefd_can),
 				      roundup_pow_of_two(KVASER_PCIEFD_CAN_TX_MAX_COUNT));
@@ -1013,6 +1014,11 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 
 		pcie->can[i] = can;
 		kvaser_pciefd_pwm_start(can);
+		ret = kvaser_pciefd_devlink_port_register(can);
+		if (ret) {
+			dev_err(&pcie->pci->dev, "Failed to register devlink port\n");
+			return ret;
+		}
 	}
 
 	return 0;
@@ -1732,6 +1738,7 @@ static void kvaser_pciefd_teardown_can_ctrls(struct kvaser_pciefd *pcie)
 		if (can) {
 			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 			kvaser_pciefd_pwm_stop(can);
+			kvaser_pciefd_devlink_port_unregister(can);
 			free_candev(can->can.dev);
 		}
 	}
@@ -1874,6 +1881,7 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
 		unregister_candev(can->can.dev);
 		timer_delete(&can->bec_poll_timer);
 		kvaser_pciefd_pwm_stop(can);
+		kvaser_pciefd_devlink_port_unregister(can);
 	}
 
 	kvaser_pciefd_disable_irq_srcs(pcie);
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
index 4e4550115368..3b4ef1824ae5 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
@@ -6,6 +6,7 @@
 
 #include "kvaser_pciefd.h"
 
+#include <linux/netdevice.h>
 #include <net/devlink.h>
 
 static int kvaser_pciefd_devlink_info_get(struct devlink *devlink,
@@ -34,3 +35,27 @@ static int kvaser_pciefd_devlink_info_get(struct devlink *devlink,
 const struct devlink_ops kvaser_pciefd_devlink_ops = {
 	.info_get = kvaser_pciefd_devlink_info_get,
 };
+
+int kvaser_pciefd_devlink_port_register(struct kvaser_pciefd_can *can)
+{
+	int ret;
+	struct devlink_port_attrs attrs = {
+		.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL,
+		.phys.port_number = can->can.dev->dev_port,
+	};
+	devlink_port_attrs_set(&can->devlink_port, &attrs);
+
+	ret = devlink_port_register(priv_to_devlink(can->kv_pcie),
+				    &can->devlink_port, can->can.dev->dev_port);
+	if (ret)
+		return ret;
+
+	SET_NETDEV_DEVLINK_PORT(can->can.dev, &can->devlink_port);
+
+	return 0;
+}
+
+void kvaser_pciefd_devlink_port_unregister(struct kvaser_pciefd_can *can)
+{
+	devlink_port_unregister(&can->devlink_port);
+}
-- 
2.49.0


