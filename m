Return-Path: <linux-can+bounces-4079-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734F3B100BF
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 08:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4EE9189C229
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 06:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54820230D0A;
	Thu, 24 Jul 2025 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="QPGIcKAL"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2109.outbound.protection.outlook.com [40.107.22.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4110E22DA06;
	Thu, 24 Jul 2025 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339054; cv=fail; b=YWlJe+emhPUfkdYz1Izt7NdaljV6Sm0UsMr0KJkj0KpqTmpqUsT0eEi2qlPDfJG6dOqvzD0X/D3KHpNZfhUSTNXRX7WbOLIj0QyI7QaHedTqgH1bqFyUQhvqA0cHe+08WgFVQ7GrJkhGWlNkK9+srPWPW0ZTEBJMobc5UZjc4WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339054; c=relaxed/simple;
	bh=NxxLw2acRRVoaYm6sshSREOTUfQ9Ljw4DkhVeURyWPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o0o0mid7BUC6NwYavzKoFp3OXH48jrGoEZF7BxMufN2Wdf+ioY6K0Pie8/nGXmHMMaVL7iS/y9ZL4AiNHUEjdQpZhr6gIK0GmdP6igK5jnRF3OKEycFWRIMjub/HwWhPVa2A/wsIuWA/fF7aUV20OhAE1c2IwNfdlhuD6DvGCBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=QPGIcKAL; arc=fail smtp.client-ip=40.107.22.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8OY9clH6wE5+rwmIyWyqLlyQh3b5lfDJto/QCjuJ2RV94HZbntYyVwfUA5YBCreQq0HceIQm+goXSDqWiSxpF0mnkQ7ZcxGyxOgp8xmzyS2jW9zqpRMDZREw7KL78SyKDAm785cCntS3lLV929gD+46XZ3C8GdSgEtpwsPWAdhATOcTVX+39PdK+XFCr1ZuhfsNKJYBosxjXARbNQg4M9Y5SPGxkKk/yJC3LOQDUDil4smxrfb0SoSETopFdQRTZuphdEv0mSwESoPW/s72ahhvOctY4MTL7kxMXl4WJ4bZtcUK4J1G4M7yluY58882j0Le+GrhOwZkQ0YVs7dWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyFHKM0gCkKssSEyB2CN08UVzTjVmsl/7UmTcf7fgbY=;
 b=Vef2RMzD72hD5QjM4gdNSJrX2cqk9sTOwp41YhiDeMWibx8grgV+MK3hUMnGYuUrB0eM3q0/ke1BuHiiAoTTeylfPnpeUZAQrf+sC+fFzdP3gZ1nZoRfvw+XhDMVwPc21gMzcup4wkcE/ulLvATuRCxjgUJTigOPJdqGj+F/U6jDCje0B5RpNTD4NgLY4TjYFJZJr0G0ztLnd0s6R9nG3dMO2LC2nLbAsOkVmwSp/MEAG3y5NNCPC2X21TVNVptHXV3IY+2MrsCXHbJvjpe024V45b7+EXp0xDazzFSRRlA01mp+ZJ84AaKZOHb+Nzqpm9krkR69TCYdooaochgrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyFHKM0gCkKssSEyB2CN08UVzTjVmsl/7UmTcf7fgbY=;
 b=QPGIcKALe/d/Ic5unCR9iArcHpi4099f++yZQ9FB3IoKXzi3MpE1cpRcCf0Ed5KWV7AdEDtEvZZQ/zVPbcNVSGImzeqUTSfE19ZLDm4t38Fs2Adek8OoWxcaTxFdQIsQIh0rhpGUr80uXPXMjXyFWWSLn0mMO8dlN3gy/0mHe/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM0P193MB0562.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:163::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 06:37:20 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 06:37:20 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 09/10] can: kvaser_pciefd: Add devlink port support
Date: Thu, 24 Jul 2025 08:36:50 +0200
Message-ID: <20250724063651.8-10-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1c31c647-dc93-464a-1ef9-08ddca7c8a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PTyg6m6F9ob50Fz55ticpVjfkKokaexLw9zqr19p8/CmRVBB/Oel4YWrPHJK?=
 =?us-ascii?Q?OSiOAOg0VHwbOw/+/bpf2VI81CbVIvuCeVyRNiCzjzsS+qMRumrOzkekriOy?=
 =?us-ascii?Q?A8JcWN9Fc7dD+Of8agbTk9HWCo7meMpY53YjWvR3kpw2FiTJpb4AmDJWLmaC?=
 =?us-ascii?Q?/pX4hCGUSmFEL1WPkj/RuvVYI5v6l4X3r6ymr7VFkDUsI0PpS6s/boqaFTvp?=
 =?us-ascii?Q?J/P7NvSqAngTasEuTubY7zaIgB4l0wPxiJeSaSCH/BU82L4Ta+nYgJwjJMRg?=
 =?us-ascii?Q?K1dZshrB33AFxwoyPmk7jAAoQsOAIV6pQfbfVhSBKm8N0dtDP5voqV/fr9sY?=
 =?us-ascii?Q?BvQECcoGtWPKfVvmK+Ki0w/qVs5hF8gimbzktWxCwM7fv3NPL14DdKBdwXnG?=
 =?us-ascii?Q?dBbYK9MwPWRBfy5tX4aOPVSWUOI+WQ4ulP88DZjidqQGQXYlt8sxhem7h7ro?=
 =?us-ascii?Q?PjPQoDFh/GjgTcDUNd4QDiMmy3AU3pRX7MUJOXN0OtaMDfbmCGDCJm4L+tN+?=
 =?us-ascii?Q?jd/+GnqiG3/61ZGrtqHzKgPrzV62Nv9torRcobIGa0h5KvcxBmXbtYLUJYuQ?=
 =?us-ascii?Q?/lnET7WwZkutTZM3D/Ln4O/x+wxwdio7+y9rlakAMD4uEqCWG040nHgCrcdI?=
 =?us-ascii?Q?sAZ7UpeD9SWcOZHaHx7tcmpEs/ZVpk8ZsE2pNURG2JLdd7vdWc1aD5tQEwM6?=
 =?us-ascii?Q?AKSPFIMEQNSnOOIFN35OwRMe/cVo1n5CNClVQ3JM/mb7wGsYSYCe6Un/yqHM?=
 =?us-ascii?Q?sSaG/0z5/xNF64pylf2aF/DP2JmeWPxGc2QxqMg3WoTK9gMfrQOun30K1RwF?=
 =?us-ascii?Q?9WMjiBEfslvPLW1BEdqyiD8p8GU5QG6nR4vqM8Mgh+lrSdR2YC7AcK2QOkb6?=
 =?us-ascii?Q?1RA0aUI0ifoXaAF/F5lpXHccDaB8P7zG5qQy085ITfcGGF59Tcw701iOkEBP?=
 =?us-ascii?Q?tIjGHdqmALVF055XtBlBr7JT5sijwhYs6xUP2RnBTMDozmUfFNIdIKLU68eF?=
 =?us-ascii?Q?WQaSbj7kRgBnmQ475uixtpPWC8sYCgkGzqR9xMLDQnpQDpPokgfa8eEI0USq?=
 =?us-ascii?Q?z3XkpcuOpbki+6/cVzD1YyDxwFBCeZAjtqX+9xlrrmMMQT/f+TfkE5TzjP2x?=
 =?us-ascii?Q?OY+Bv4lzmIQd9p0PfbfTMI/qghuYhH4Gujxfo/TUui2PXJZ5b2cvyiBvmh3o?=
 =?us-ascii?Q?vOzfCF8s8ql33jd8oiulEuNXirQ1q2m4u9KKb9xS3wBVd0u65Eq6VwN2kyC0?=
 =?us-ascii?Q?EGBRYBM8QkZjs50TZ2IrSnRFU7NWaqYxA5Ukqch8pLK1a8EZAEiBREg9psfM?=
 =?us-ascii?Q?6DiGT32knw7XWRb9bf1nkFpE+fgHFJvHn2UtuaPfXNHmv7ETcWMKr7BA7LTz?=
 =?us-ascii?Q?h96t0Fo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tKtjPJYNElAnaN0uZcxiifQ5orD22We83zAKMHJSjvJ+Bcbg81cMpVu2GLPQ?=
 =?us-ascii?Q?WXXq5b+5aHeJfRoGhR25ivLBBHPOPWlDf6Pvak9d5MwPVMUdj39QwBsthjaE?=
 =?us-ascii?Q?pVFhK5N8VWV9SbqjIt7XvURJhhWvFLRJHB5U2YF2Nk06T6nX/lzRWSwKS/gM?=
 =?us-ascii?Q?bx6HMCybiZNWZGdEufY6Yey1tEkscnvXK2oZpnX1kKr842I7ojoWZIrDDdtf?=
 =?us-ascii?Q?VsxA6BYFYmU0ZyXHf3ZuC6vLhw0Cf9inEFT5OOsZMTkGHN4g5i8ZpQBT4Y7G?=
 =?us-ascii?Q?AToc4yKB+t/5Ng5KxEimo4uNcqsLfSpaSGSmgMpAiQkcGLrqKx3TcTk9Nskt?=
 =?us-ascii?Q?yH5AWvRdjwMiiQc3SSgJppA6UPYK9Nn2n5Mfml2kw6Y7v+pYaoF4XEkkPXlY?=
 =?us-ascii?Q?QwppBPkWS8WyANmHEjs8RHstyS4c9EDtuGXIPB5JMtJ9FDbi+nf/cAvDl3AA?=
 =?us-ascii?Q?dcbmPpc/659J3ucVoN5TkYlJyORlNbHbL/1+ey1jhXwhHx/Uz6hV5rwlimjJ?=
 =?us-ascii?Q?Q5UiIpCRMINY0JPepux6cgBwQxoLm2ytj6gl09WRrn1gzuX0LK23d4NVYNrV?=
 =?us-ascii?Q?62/ks8Fm/rW65GsiM6AXu/Vl7Zndt0vasyarxJ2tURbvOU4VKQT5niqY0vx0?=
 =?us-ascii?Q?0ziPLST3A8dAoi7cKryEhaTKrRhwrz25g/56Fz1uNdxSGyfROf2Vt372vjcv?=
 =?us-ascii?Q?PPSpQyeGp7979wu9M8K2Vty09poLNAiH7o2Ue/a/KgkHX21W1Q3OqJU9YXlB?=
 =?us-ascii?Q?UjERzha6bWn0rsmU8NL+H7QdL4YUR8PTlBpUl16jUckVjOS2hWpKTVefsyz5?=
 =?us-ascii?Q?wvnuuwqjBkQ9kLidcXj2fzaxLBAj3sUq1GwnR0e4uXKlhL/tGN10kD0HjhBk?=
 =?us-ascii?Q?+nlwvKECLqc43g0oaM9675SLcz6duv8uOlCXuH28B3eXqneFCI0pPy36sefs?=
 =?us-ascii?Q?bkD+w9SWS549Zhik9CgUjTSetC6y4UDLqy/581TL5O3OikQAZ+jO1A5C6HXo?=
 =?us-ascii?Q?whPdv7qD8UguDb4Sl6I7czyxMZtwPr/A6m9niwK/KolLGLEah/wKFSTEGwDa?=
 =?us-ascii?Q?IErIisHktbrMFNjhO2PPw8vN6Qn0PXM+RlyIoQKG7xqtv8MvLnSli1qwJYct?=
 =?us-ascii?Q?iQw36FOP34011Tt0998+6Spd0i9LFP87b/b3xv3764D6WlM8dl3XxGVmNfEN?=
 =?us-ascii?Q?ryjdQ/DwqgIJguxZzj2lpxWv7j2tSwUDeRXgi+3AkEgX6aW7IhYRay2qpo3B?=
 =?us-ascii?Q?4uYAOub7R9bWESaUeTltrnWVQq4QMcaDmnnWtCgKUKdksp1e2BYjitRLsqaG?=
 =?us-ascii?Q?39PbCuEOZb4tTCHaoaqt6is5nQDwhu0ow/m+WSkaTcZXxHTqrvUzANeEkwXh?=
 =?us-ascii?Q?t3iCzNtxqM8zC7zzcth/a9PUu4mCVpqq0xokWXlt9ubvwyAKKSWCNXzd6gTr?=
 =?us-ascii?Q?9TsRspV1Ivwhp3sQnA4RdbACAJDTi3EERjpiDofi+R8GVt/E+QYQ2+tuo3mW?=
 =?us-ascii?Q?fnkeCxOtO6hMrJkVNvzULWib+SNiSRv2N7r6GfIuVhogNtPuLAF4MSdnj2aU?=
 =?us-ascii?Q?Re/KPlGJepoYtgijf70YVSqRXQWReCgmdUDAYrFRMneMUDjbobQy9zKXBkJF?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c31c647-dc93-464a-1ef9-08ddca7c8a6d
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:37:20.5358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEZkypLJbSFl9ZF8dLVQmbogYHKg+KAQu8lkSVhn9YulD5k3bpkqVXUDwnih6vqLOK9w+TWDEXYPhDF7bUWpPtEYZhKyzzKPWHw661AqUUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0562

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
  - Add two space indentation to terminal output. Suggested by Vincent Mailhol [1]
  - Replace netdev.dev_id with netdev.dev_port, to reflect changes in previous patch

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


