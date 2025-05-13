Return-Path: <linux-can+bounces-3567-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E111AB5819
	for <lists+linux-can@lfdr.de>; Tue, 13 May 2025 17:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D02188824F
	for <lists+linux-can@lfdr.de>; Tue, 13 May 2025 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9911B24EA90;
	Tue, 13 May 2025 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="WhiGIhtt"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2102.outbound.protection.outlook.com [40.107.241.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8320482F2
	for <linux-can@vger.kernel.org>; Tue, 13 May 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149010; cv=fail; b=Jxo7jz1Ybu0dyNMsj6ZAa1Rx5SItp9wZBGLBoyYam4iMUsYeyZ1h3nFsOn47DSINzG0+JS88vMVHFJ6n3lZlL8IiIBUKHKPa1PaiyyzKhV6XREeTEYRM9djxX6MWDc3UhYlHGR11MJa9PNH4cd1+JNQ5Tm5rxuitDDfZ8fnWi4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149010; c=relaxed/simple;
	bh=1idkSmEbQCv1lBuYIs4LKdMErjPvGQ7k4LOShVqm6Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NDYP9JXP3iG6mM4zZyErPUOA+4HCtDp4MZOTJu4ufk+8RO+1udPZfMAXVEi1ba0Y8OcaYcyvPChWD4XyUKb0zmOPyLYKoBefUYI+x/wJH1hDJ7bnzcfkaHL3b+BFUAp5PJt/HCRbIu73b+0UVD6xgKh494oy1mhA5roXvIQeZPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=WhiGIhtt; arc=fail smtp.client-ip=40.107.241.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMzKB+8Bx9KcERu9G6yiwCucQwZAX9yKli5s/O1nb9gtgiD21uVxtgiPmhXSGaoVRouJdhAlQlcVnKBsnhSu+kfZVMF9fmMQK95WJ6CoPPzFSLkfohsJxsbbSXsnOYxWLIvcFZkBf9y6cDXYjUrF26PXZElSNTT4PmVyW0OAcbcbG36EdoBw9vfmIq/lYe8+4qFzUoj345gq+8xIFiOtZ48rSp3MyiMZ53enTJA+4NxFstWUAi1zV8GauwEPJyd5DJXCQWaryWfALfRcAh3aWRGO3nlH+NXPNMVRWiS1VDavHgk0EkAz4LN02ZxA3o+rkR8v4sBitbwMqnOij1S7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzltrWKiABksDHyFVb4NRlQL8blMMfXcJkNIlndE3YQ=;
 b=ALeV0LvzWb+DTzbkFrUr+u0hp1MDRy7AwGparmssDPXxIraBssnrf1wnxB87QS8j2XOkhHcvZjbmXsMIRwazUrfbm3DrK6WZP+7q01aVfGeJOkXXCs4YoMQloVtuSkA0LemRPu45z7SgOoLPBrNIiNu3lffcIvEN7yox3xAs/f3+cSZpT+jQbatrK6kxcpdLlqhuy6HL1222t+MGcBOZqKETycCYalBOR5ZgAEcA8d1O5CQhclL7FOhcXrLnxDjbqOrE0wmb1N3poYnA5sVFgWAXjwoJUefVZZxi6KbZVN5GalkMBW3yCGHYY2irxk+hu0dRD6WQ701dBiWfozSDPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzltrWKiABksDHyFVb4NRlQL8blMMfXcJkNIlndE3YQ=;
 b=WhiGIhttPHg3p3jXix919uwM7KbeUKCAqRSwEuI4b9gTmH3RzDDD/m0spHemBO06tPiarCGD3NyB42LSnNYHtxC5RleDYhM+QNuHSBl7P3EtEgEGS05UNvuJ08iqKoTMGJul3GZfEziEfPEjL+uDdPsKRwDO4PbHHR52KoIuyxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by AM9P193MB1096.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 15:10:04 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 15:10:03 +0000
From: Axel Forsman <axfo@kvaser.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	Axel Forsman <axfo@kvaser.com>
Subject: [PATCH v2 0/3] can: kvaser_pciefd: Fix ISR race conditions
Date: Tue, 13 May 2025 17:09:36 +0200
Message-ID: <20250513150939.61319-1-axfo@kvaser.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0026.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::25) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|AM9P193MB1096:EE_
X-MS-Office365-Filtering-Correlation-Id: ff43934e-0d96-474e-a02d-08dd92303cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j7MIGprs2ZQzFWZj9oZJ6tuoS8sxwmuUDe887ZjpPsa9TmL3i1f9yJiQFnLn?=
 =?us-ascii?Q?EqR+6lsMZvjSDsUycZwccT0xgx4JjO1Pqsz2SXDSyaZIxqwwTFBbs3ql0YF3?=
 =?us-ascii?Q?uP4zPHMmrDL8/ON4Jofbwc7bPkbipAneObhpAT2L2qecdsp+C4l7nMqlOKVx?=
 =?us-ascii?Q?GXcp5mu24I+p3Xb7IGin5p15fMH7SM7LJm19qvgNbI8NZCFTy1OMHpFjLmZw?=
 =?us-ascii?Q?euTjEcFX/bsa1kqYQkF9XSWkgc2dt81sNk0ldi9laoYOKK8t4W08OShG/R06?=
 =?us-ascii?Q?ivHpMgPS3AX6UFEpAB/5pWPrB6RqoD9d7zeG+iIxq6BWvInzapq5LScESvvJ?=
 =?us-ascii?Q?HsTWLO372R8taPXsyStvPPq3b2E7eeaw7EZvvxYG7USQoDwRJPxDQ+j1xhLs?=
 =?us-ascii?Q?wpJVylQLkJTwWaY/CE2CmqgLLumyGzc+G1mgE7VQGtZdu8W3RhSLtT+PB+03?=
 =?us-ascii?Q?p9HT4BZHyvcxWuH7LlwZMOuV74ETCgcCyMDmJJa0+kcc7YuBjcD1cXi9e45r?=
 =?us-ascii?Q?N3MZNIXCf+PXe5hR5VlzKlOVBS2OeCXpe0YOIPyU+/Yj6CZyKtAZ4q/wCT52?=
 =?us-ascii?Q?u3SGggEdEYU2NGyyZTytqoHur0WPXakvTORXpHkhLgB0ZjmjLpk1hFH4t1zt?=
 =?us-ascii?Q?8pj4KEltRvT1esCYeVIVrmEbA6N4anvHngxgzF5T7nV7guMysUPu06GHxD0v?=
 =?us-ascii?Q?n0fkRafpyAkLxMgnuqpvkfPWy88ZrPEV2Z91+KXgcqvt/kjrVq2IrXXEVCm7?=
 =?us-ascii?Q?f9cgp7UxqYgRTKCPXfCOBZc+3xcjSDbws97d2Ajfhz95mruxBJGoSPiSshMZ?=
 =?us-ascii?Q?9td/VNh13ELbYIR2hKjNX5Rg/R/6yqSXpI0zhEqrGLlrcDKIbz7/gm2/d5Ri?=
 =?us-ascii?Q?GS6u1wt9S+z/POgkVcETf3BcKZon8QqGdbfFf1p0i9a754ANOyx9nbwyBKGb?=
 =?us-ascii?Q?N8u3/cIk6jZNz1dT5vx2vFgHTpLJb7Za0efRysBJI8J7KillhDcr6O514u1f?=
 =?us-ascii?Q?+t5UlIpz0CiWJrPxcIyEVFPwgzZgVSeYU1mujOX3iA9Iji1pai4b8nG8sCfB?=
 =?us-ascii?Q?tLZnK8FutaMNJ6i4O8jP2jIutA39ah8pc5DNy8GGrnVJK94IR7CQQQYdhZAc?=
 =?us-ascii?Q?7G0xi9lATtIosuG/mwRyu+JGVKDyGdn76u1sx+S90h05zw61QtN2hZifq17i?=
 =?us-ascii?Q?YFCrVmuCUd+gsaQy/FgpmstbXeKLulQKT3a7udQk147onH1nVA4NMI+tTUom?=
 =?us-ascii?Q?bh/MgA5cPbuTtXpyb2AkjgSEGTOuoaoZQ1UogxvmEZGPp+jkidnbMw3QKIkU?=
 =?us-ascii?Q?mOCCk53U8NW1Tn3Dg19U6bTQuHt21IXFKsFkhV6fiJUJ3rswPrPgBQp8xq+N?=
 =?us-ascii?Q?T9x0OYhgwjJJMh+NA2TZLS2btnpPhvNuBIbT1PSTOjW4J7Elcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6mVqt9mY0xpORf1wwoI389KAM+/vWhuMP4oT91UeOYz9GcmzUKoH2NaUFCiI?=
 =?us-ascii?Q?BQwLEobfLTTOIeSKlaEmSSnyektSwC6qGOF1k3eoOryUefyX0STXpfub8jTx?=
 =?us-ascii?Q?fSKk9bCoMWjSbWLMEixLsasLvpFAfapbNFsJC7WkQCdX6PCI0KT2+HJ8VCYp?=
 =?us-ascii?Q?6U5Muobqsd6pZ7+6MHqqhmqjiz4THz7A692ltGmJuhfxVoxNJLvbiGhNdhfb?=
 =?us-ascii?Q?yxCju355jrr1dEuO9SONwzCTg31pozcGHnqsLFSUNO12CL1TaSfuGg6en4Q/?=
 =?us-ascii?Q?DuqpgcbTMXcXFC2ryvXTugEyVHB14akJf2wd4SpcCws6RFnmGzi01xnlLIrY?=
 =?us-ascii?Q?MEHqw4WL4zCOBlhOVetHlVyUDS//58NTpAopKw5Izyoutp9vOgT1wfbeG50d?=
 =?us-ascii?Q?kQK0MRO3ESfz1CTIJlU/Dcf/GhfoBAusR5nKuEL3D2c1N6EUhJahFxd1MNLN?=
 =?us-ascii?Q?cLNcJ5CNjX/m/paqC+xjj8m5ZZkql1gYRBXdOzzWj1/eTudMeqsQf03oLqKb?=
 =?us-ascii?Q?7Nha0XjYxvvd/N7nahsjWsj+LUxF46VxFdqc8g4te3dYeH9GXuj12uxMZdRt?=
 =?us-ascii?Q?OmeaiM6AH4J/TD6IPFkcfaktE/h7ETut4P/GhS1eK14J9ZH/h/K3NyLiRe0l?=
 =?us-ascii?Q?hRrg+C49GTLykRfMdwwPDfD1zXz5gf+1d8mJQHJtaAo/0aYafjlKk9NFJ8fK?=
 =?us-ascii?Q?dME9z2XT/bUWR6FSIGxUjtwc9qBSXnPsiPzHurc2xkCavlvWJLYbz9o0quFS?=
 =?us-ascii?Q?USsUipHWTHo5P/VMH3GpphT2mK4EA2E4KCT7nfeU34ASrce6RQ3uhEm12Dwd?=
 =?us-ascii?Q?9l4Zs2R7YgUN08GadK3qRBLJD5e7KEiAkz7/rmQmkrBcsJGb6Ltmn1nYGDOv?=
 =?us-ascii?Q?QLp+D7JquTp+hm28hpMBkFYSNscoyNZz8JLgUZa8JTeeSBoz7OLWiNlyqh2D?=
 =?us-ascii?Q?RGkX3VHOhVoXBKrfg7m2endivmg0FprtgqKtzfG21zVTxo3EzEJyv1JRcpb8?=
 =?us-ascii?Q?iUYMC5MXCl84UmAeEHOtLEGQuwr/fTUka/guxC08OY5Qb0nyWfeZznweNtmR?=
 =?us-ascii?Q?cs2RP3WBTt8/6vm/n/i/A3XY7P/33Gi8jsAhbMErO5nwJ8J7jd0lNReIWEj8?=
 =?us-ascii?Q?PLams2obuaQETC6JFlD1JJbYnZjM8QxDweK0QbNYmvYogMnZezpyPngiA0tY?=
 =?us-ascii?Q?+xN1NovqGgBLxloHgkDOWGPK+RUAr2aWPsa5MJvYRCWJEF3+8eltYFsFUCCY?=
 =?us-ascii?Q?eg+J2WnvD1EbLXkZiZIu7lFpFxV2XM88g9nRue+/oFa85Uj+NQ0ucIMkFcGS?=
 =?us-ascii?Q?6XjTgfedRE7G/BWC9P1YWYIUoKyQbbhXlaGBYz90qCLUyurjzvAyUmABiYjO?=
 =?us-ascii?Q?P7bCiazT53ngfQKmWzLzG2UHB8yp8x9onlWSkEtLxdRiOKBUUZIkrGHrysFy?=
 =?us-ascii?Q?kH3kE7j2tdVOu7YSnTVB06c80aHSSxLxeeYzaUBc9a77Ui8ZKMEj4t2fbiVm?=
 =?us-ascii?Q?Z0jJzcq1uhznHOEWcBkxRs1z58Na2mQ8NyJr5rmk5plBbVjP+EQQSrOvQ31d?=
 =?us-ascii?Q?FgTbsGvWICGZJ2kN18qGqXYc5ft0oOJpYg3Orcr8?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff43934e-0d96-474e-a02d-08dd92303cdf
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 15:10:03.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYBDhR1pu76WXD7ChUqXvpp0v8FrfZLYtTx/KAeFEw3tEVsPollaDUTx+xoL3VnZG26ra5/hkl+fTzgv+QnP/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1096

This patch series fixes a couple of race conditions in the
kvaser_pciefd driver surfaced by enabling MSI interrupts and the new
Kvaser PCIe 8xCAN.

Changes since version 1:
* Change type of srb_cmd_reg from "__le32 __iomem *" to
  "void __iomem *".
* Maintain TX FIFO count in driver instead of querying HW.
* Stop queue at end of .start_xmit() if full.

Axel Forsman (3):
  can: kvaser_pciefd: Force IRQ edge in case of nested IRQ
  can: kvaser_pciefd: Fix echo_skb race conditions
  can: kvaser_pciefd: Continue parsing DMA buf after dropped RX

 drivers/net/can/kvaser_pciefd.c | 182 ++++++++++++++++++--------------
 1 file changed, 101 insertions(+), 81 deletions(-)

-- 
2.47.2


