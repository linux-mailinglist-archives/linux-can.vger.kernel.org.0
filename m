Return-Path: <linux-can+bounces-4094-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51529B101E4
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480D23BD639
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 07:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ED326E14C;
	Thu, 24 Jul 2025 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="T0rAWXEv"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2132.outbound.protection.outlook.com [40.107.20.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E28B26E706;
	Thu, 24 Jul 2025 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342253; cv=fail; b=q5Ghj+3Cf6rWOw2CuFzQj0a+FhyHPzYLYuzedVs5OcTLfjTc7M3GA29cftZ/7AfSu3IZgWsZi1VUkTbfwfb89FdhYf+MnXUfM9i4wWJxjj+H86xVOygnJJLhDx72MexXVcjkTAVlOzCwRmetEcirfEs1EFDM7xFh6PNIkS8O1tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342253; c=relaxed/simple;
	bh=bMV5ZPMcAQxEMgPH4APEt63fGnI4Jb6E3NU5wY+EK4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pjRDVfKaxtLqehCzMcKaqMV8wnykxu71SFQWzF4SjvcaDoiIlSQBmdc5ttRcqWkkUUGN9BZLrMBeGEY5TRuilCaXuQNj3j8R4VemCkWe1BG4EMmZwY6t+zgavgsLQjhZYs+QR3ihuiiFAHDCF7tY86b7WpVYFwzBeyp7MMQbGqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=T0rAWXEv; arc=fail smtp.client-ip=40.107.20.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmWEFfqVgHqlVVbV0EWk6xx1HVG2C2ScURS/ZXQm24qvNyYr5Taphj6bKCDEhcswlQm6KZh7Wmy1dV3jYUypHoa3uCiKYz4THudcC2lOIpF6YYINmNjYY7oNrGx1TP3fQyQ6rsRauAZ8UWRIGYr2lEv+1WTBDSvz/ECN7BjiXSZM2Gw3N0t0Y+r9XyWQRCaF5Gn4kjjpv1q+zFOzrDlmYocgnGFqddXw/RaM6Z5kK7Z2P0ch92x+J4OxEieKOpSIiYVqYZsMNObHdm3KuMIc3zUjl9RUGif4CKAaiCZjY79WDolsL0gyqOhjrHWatvVmbk/rEg128Mav4/Q7iTg/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKS+P4R4fDTfQbzGYalIxx889MKB5kaRyAhl88dG5vE=;
 b=dRaJnJehFiCSxY0IWcLXX/FjCR55GBtQM2NDdkYdfwr7Ho+D6ZXMF+G4K0NP285Oq7mNbPB3vE0JdrqKH4Zmz/2gLn2a4CGqTBsuzV5qByMHUV5/tIzKRYSCOvhJ24QrnNqdwWvUwJdzSjc7odwntCZE/9whheqyOK58HCKn4mfzSupSwJGQBv23aJl9FsWSf1AkqND+E8bkstzfpLmLNH3czPz0i3yX2z8MpTbyd+ppQ7SQK4biHmF9MyczfJV3xuzFGcGsJAMnGixIWhX6GE+JEDuRBrM51wWKwDAGBkU+A2B75KtMgW5jerEPD7f6IKsK7wJ/DLaPxv2tVGZQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKS+P4R4fDTfQbzGYalIxx889MKB5kaRyAhl88dG5vE=;
 b=T0rAWXEvxrStqskMko2gzsREZeiEOKmjhzGO4lA2V8pH8nj88Hx7ALB0XibcMzNhRmUXTiXBjwORObtPrLjoW40sNkKBKvrE7cFHrX/h8avjtircJO30yn1MWpaMaSNmB78Rgh9XIqqerWWiublI1ATLhsBIDrfdKYSCkt5J/mM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM8P193MB2657.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:32d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:30:38 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:30:37 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v3 06/10] can: kvaser_pciefd: Split driver into C-file and header-file.
Date: Thu, 24 Jul 2025 09:30:17 +0200
Message-ID: <20250724073021.8-7-extja@kvaser.com>
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
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM8P193MB2657:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4aa04a-44c2-4855-de49-08ddca83fc1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QZp6SzpAtK4mSB8GtWN01bL8VwQwvzR8pEjulL96MEIi2gmxb3GzptsuapLW?=
 =?us-ascii?Q?BslLau1H9Uki9RKTPKjoGp5bpAMK+cKHd7AzWWE35Gjihm3oPFcVGLFtMRN9?=
 =?us-ascii?Q?/pPE8BhToY4oxNSRF7GU0vfP+xAIwnPGwzTyuz+KrqsxN1hsjrPGV9mAphyX?=
 =?us-ascii?Q?HZJFzWx6M3XaF1QsPDsfHtMbxtDsYXVJIhXmWtclea6HubOAmDRt0d5kg+YM?=
 =?us-ascii?Q?lz26O/ZJ2qfXHeL1ZaD5KtKc2ziY+iaYib8cs8R6rPXDkIk1Z/cuVENDDWLx?=
 =?us-ascii?Q?tqZkT7x/ZLaARF1IMA7tEi2lUGoMmYkTzyHA6yc1DaC84I84/+xsxkc7q9i0?=
 =?us-ascii?Q?pXxEizIZyFj2ziYS7u2qsglj2y3DgFKMKkwniX2e81i3bGgiUxEyLKi9f/s9?=
 =?us-ascii?Q?BHww7dN4vIyW0gVRESmoMLiMw1dZNPz/bV5RuwdmZ2EoiFj32M6C9pDIWENY?=
 =?us-ascii?Q?lhIdQ5aM/Be+Nqhhud9lGoiVylThg26NgHuPEaPuzsP6Kdg+HwFdDt5xeMFs?=
 =?us-ascii?Q?IzcgAkNBh/GWQ4347x/B8aWNWuyzG43j0TtGU2u7/IHBT7BWNEwDIYq2kJSF?=
 =?us-ascii?Q?InUU+zH9ZxguIxJ4O3qItejySIhkzsBqI2fYWeTobDNL9XacSG6MFIHOhP3c?=
 =?us-ascii?Q?jGqDfNNJ9cJ9NfqiVHKoGtCrxrJWkhxH3TeUz/cirL6HWeKeiYW5VqLMVHWE?=
 =?us-ascii?Q?10uTRYTaq6J4qQ2RTX47o5G9lyBuva89CxrXVRa8vL+qExH7jr70y4Yme51F?=
 =?us-ascii?Q?vHnXmkSnIxRbzkkAq1gjRo5ddmrvMjgbe1SpIZ/1/axGCduMM42mWmAaxKi9?=
 =?us-ascii?Q?3TxiNgTo+X+pNEWEf0EaLmXbOEApaqfy8lpxkdv6GqUCdpmuQnoytUGkPMho?=
 =?us-ascii?Q?lkKfcvUqpG/F6Y4h0LbRmuofQ6er997cefNbhOzBamOyKx8HmCBQ0EBBGD0K?=
 =?us-ascii?Q?I6DJVY2IGzyHUN0wm87f90vvI8eSWuBVSF3n1YHEJRYfLzdEycOmZIgIb94j?=
 =?us-ascii?Q?IToyzNnpbayyR8GxnqAQdq35ly4W7mvzeUb1qVvBkvnd9Xb+00jg3PDO4wbC?=
 =?us-ascii?Q?UFMeBNVVixddHqyJ9wIDqZP5s2R36nL1X0BgKgFs3J+M1XWSvjhKHbpzHBMR?=
 =?us-ascii?Q?2l24CFfXF7p4/d+2cJ/+JM/OTIsaq/lZroaGL9y8G/VwXWH5GbM87OdMe2wq?=
 =?us-ascii?Q?f61bbctHwX6TgF+4wTV1gGNieIV0sWDATNqBKkVmchGFZjNUi9vb5SQYIsVv?=
 =?us-ascii?Q?GqnBnvcemVwokih3vrMTetD8/qANxki/iVlLeHZKFO1mUeIiB7bP2pHrUnZ7?=
 =?us-ascii?Q?hz0cZpEkjttoYb23OMLd+tXas6O4LC+V30e6AMDcdZzPIkZ8muvgXNrnKnk0?=
 =?us-ascii?Q?pGLlvsMkMkFGIcxExXwefybfSMOHQhiZ2F3J+liGduq+i9BEFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8/9E1itubIJCZv+C657SE5TEXdaaRRxYS6BeWWs1Y0X0Sm9K2M+FctWyn1Xt?=
 =?us-ascii?Q?QQpp9zD+C6b7n2/jZnXnq95+Ts8Cxqva4ql1+8L1Na3+9DyqZ5ggTt0OgwoO?=
 =?us-ascii?Q?LGHcBepN5aVYx4skMiwbH3HbBnLaL8FmlATaTqrsYVqoZsp5FOFWu/nnzxfV?=
 =?us-ascii?Q?2w1QdBQ2sp5BdME37opFybCi79VMWjlrI/fRl97rNe8DQr6I0ND3oaOWUv3y?=
 =?us-ascii?Q?pF0vS+nLpDATLUFJSVTVVcrhsmWIK2hhYbG+GCXeD3E1kalNl+bmQS+EExw6?=
 =?us-ascii?Q?0cGXXjmwmNVNXL1WmgeCmawOWFpnw+ibyp89Y85ySBUQKM4KbFi0ruYLpEY7?=
 =?us-ascii?Q?uOjbMpUSibH6TOtj6m7JZ4a/xr4VLucCtRmDO4p4JPxrAf6VIQWZQGP85Nyl?=
 =?us-ascii?Q?iqxIniHvZaxkaxHrm//TBQ5Ns0j0Q1UmFkRCKmUNwzl5itbkdhJfZK0225r5?=
 =?us-ascii?Q?nfqKqrfYse7T2NYwP8snYTLKwHQPcpg4gvYBWfXcTDLM5X6FQ1fZufWq8nOY?=
 =?us-ascii?Q?/OM3XexxQGgLBBjA6uN3N1WU8GhiCWyg74AM8+Vixi9Mm9Eau4RhWUVAbhhI?=
 =?us-ascii?Q?o5FFxyRukf1y8BHlygBoTwelFOl2obabC9EG60b6yt95OPo4ccXq5yRPY9Np?=
 =?us-ascii?Q?VgfT5Q65aCPNR4acjluwY7k0EMea2/qWdrOTl8TVAz4+YIanXY8lJmAUNewF?=
 =?us-ascii?Q?I9pcK8NrMd7vaSo5ERwMpC3TzsMIXY4727JTi65eNib5Q1/rhoMSELgJJtsG?=
 =?us-ascii?Q?mCyRcAVjjGt/0e2DmtHUBIbfWMx1XyeEgVVEVRHe8Xg9IbztMeqLDFG7aCH2?=
 =?us-ascii?Q?zUaYWPLpoKLZyLumn3D4lHbxoHfszc20jMV/SM/PAQSz5GsJWEetA7vlNvM6?=
 =?us-ascii?Q?TMgdty2nXq6Kd9yKDDyvoHH8ZW2p2mPy1emQjYkX/Eafe3dxYEfswmfM4op0?=
 =?us-ascii?Q?gzqZ+RKdSH5DxAdb1ngzNhe1DU4dVVLA8aqh7Me+e6HTb1ZTnM1XU2fL3aet?=
 =?us-ascii?Q?FYdMygaWCqyU5QWUAUpRONFCapHoX9YDyw5qucZp7iHhxo1ZcymtLEblhgRt?=
 =?us-ascii?Q?ooA6aXSsJHENNU3M8YQt/Q5mYnXrmj5qR0cgifit0QZiLHo+7cynnFqBV/b0?=
 =?us-ascii?Q?Tv8sq+2Ibwc1jdMETsBN/CISaKYNqZ/p/8TCJF8qKHnK6Fld+zSyqZdRBQRj?=
 =?us-ascii?Q?4dr62+cUQRmLwwb0/m0tuMiWPS4Y7Yd6UZvpS2uSr28Bf3EsKF16dZxv3BJS?=
 =?us-ascii?Q?hYtYMkl7P1gib92eCCT6Txage+KpNrQAoQIBXOv+J9TPpyl+r1hs+k4mjdiq?=
 =?us-ascii?Q?6ccIPWb6Ymh1+FYrbcLAz8pPFh7Y+nE9YY5mC5LCRAxbAtDBwIAeMrAvhmDd?=
 =?us-ascii?Q?zNmmIOvPouEtIITv0UFt9N6gUcm9navRmepJnfZQR9OqdrELrMPjTz8GomU3?=
 =?us-ascii?Q?3oz01yzi56wAACC5jkYwByZFpX4BiovbgzieW3Bp+4iDGg+BLY9tT16eRw8i?=
 =?us-ascii?Q?4vTgNv27V3MIv5nMXcQJu04f8Z9M7g7za5FwXJXq3aIMTSFvip2m8m0z5Dp8?=
 =?us-ascii?Q?1x1BOA5cSDfbE+8jEstudZmfWcQwNb7pmOKG09sKTJic7y4MDM2xpxkxCUm3?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4aa04a-44c2-4855-de49-08ddca83fc1e
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:30:37.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojFbFm8kUvZivp/pv/cdL4HvFI7+dIQUeCugI3UWIyTBfH0jL4TyVAsUWnx+A6yz88u9ThwJfq1UGPeZwONW74+16YqPOPaHBJfWcAcrRII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB2657

Split driver into C-file and header-file, to simplify future patches.
Move common definitions and declarations to a header file.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/Makefile                      |  2 +-
 drivers/net/can/kvaser_pciefd/Makefile        |  3 +
 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h | 90 +++++++++++++++++++
 .../kvaser_pciefd_core.c}                     | 72 +--------------
 4 files changed, 96 insertions(+), 71 deletions(-)
 create mode 100644 drivers/net/can/kvaser_pciefd/Makefile
 create mode 100644 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
 rename drivers/net/can/{kvaser_pciefd.c => kvaser_pciefd/kvaser_pciefd_core.c} (97%)

diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index a71db2cfe990..56138d8ddfd2 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_CAN_FLEXCAN)	+= flexcan/
 obj-$(CONFIG_CAN_GRCAN)		+= grcan.o
 obj-$(CONFIG_CAN_IFI_CANFD)	+= ifi_canfd/
 obj-$(CONFIG_CAN_JANZ_ICAN3)	+= janz-ican3.o
-obj-$(CONFIG_CAN_KVASER_PCIEFD)	+= kvaser_pciefd.o
+obj-$(CONFIG_CAN_KVASER_PCIEFD)	+= kvaser_pciefd/
 obj-$(CONFIG_CAN_MSCAN)		+= mscan/
 obj-$(CONFIG_CAN_M_CAN)		+= m_can/
 obj-$(CONFIG_CAN_PEAK_PCIEFD)	+= peak_canfd/
diff --git a/drivers/net/can/kvaser_pciefd/Makefile b/drivers/net/can/kvaser_pciefd/Makefile
new file mode 100644
index 000000000000..ea1bf1000760
--- /dev/null
+++ b/drivers/net/can/kvaser_pciefd/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CAN_KVASER_PCIEFD) += kvaser_pciefd.o
+kvaser_pciefd-y = kvaser_pciefd_core.o
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
new file mode 100644
index 000000000000..55bb7e078340
--- /dev/null
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* kvaser_pciefd common definitions and declarations
+ *
+ * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
+ */
+
+#ifndef _KVASER_PCIEFD_H
+#define _KVASER_PCIEFD_H
+
+#include <linux/can/dev.h>
+#include <linux/completion.h>
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+
+#define KVASER_PCIEFD_MAX_CAN_CHANNELS 8UL
+#define KVASER_PCIEFD_DMA_COUNT 2U
+#define KVASER_PCIEFD_DMA_SIZE (4U * 1024U)
+#define KVASER_PCIEFD_CAN_TX_MAX_COUNT 17U
+
+struct kvaser_pciefd;
+
+struct kvaser_pciefd_address_offset {
+	u32 serdes;
+	u32 pci_ien;
+	u32 pci_irq;
+	u32 sysid;
+	u32 loopback;
+	u32 kcan_srb_fifo;
+	u32 kcan_srb;
+	u32 kcan_ch0;
+	u32 kcan_ch1;
+};
+
+struct kvaser_pciefd_irq_mask {
+	u32 kcan_rx0;
+	u32 kcan_tx[KVASER_PCIEFD_MAX_CAN_CHANNELS];
+	u32 all;
+};
+
+struct kvaser_pciefd_dev_ops {
+	void (*kvaser_pciefd_write_dma_map)(struct kvaser_pciefd *pcie,
+					    dma_addr_t addr, int index);
+};
+
+struct kvaser_pciefd_driver_data {
+	const struct kvaser_pciefd_address_offset *address_offset;
+	const struct kvaser_pciefd_irq_mask *irq_mask;
+	const struct kvaser_pciefd_dev_ops *ops;
+};
+
+struct kvaser_pciefd_fw_version {
+	u8 major;
+	u8 minor;
+	u16 build;
+};
+
+struct kvaser_pciefd_can {
+	struct can_priv can;
+	struct kvaser_pciefd *kv_pcie;
+	void __iomem *reg_base;
+	struct can_berr_counter bec;
+	u32 ioc;
+	u8 cmd_seq;
+	u8 tx_max_count;
+	u8 tx_idx;
+	u8 ack_idx;
+	int err_rep_cnt;
+	unsigned int completed_tx_pkts;
+	unsigned int completed_tx_bytes;
+	spinlock_t lock; /* Locks sensitive registers (e.g. MODE) */
+	struct timer_list bec_poll_timer;
+	struct completion start_comp, flush_comp;
+};
+
+struct kvaser_pciefd {
+	struct pci_dev *pci;
+	void __iomem *reg_base;
+	struct kvaser_pciefd_can *can[KVASER_PCIEFD_MAX_CAN_CHANNELS];
+	const struct kvaser_pciefd_driver_data *driver_data;
+	void *dma_data[KVASER_PCIEFD_DMA_COUNT];
+	u8 nr_channels;
+	u32 bus_freq;
+	u32 freq;
+	u32 freq_to_ticks_div;
+	struct kvaser_pciefd_fw_version fw_version;
+};
+
+#endif /* _KVASER_PCIEFD_H */
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
similarity index 97%
rename from drivers/net/can/kvaser_pciefd.c
rename to drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
index 8dcb1d1c67e4..97cbe07c4ee3 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
@@ -5,6 +5,8 @@
  *  - PEAK linux canfd driver
  */
 
+#include "kvaser_pciefd.h"
+
 #include <linux/bitfield.h>
 #include <linux/can/dev.h>
 #include <linux/device.h>
@@ -27,10 +29,6 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_WAIT_TIMEOUT msecs_to_jiffies(1000)
 #define KVASER_PCIEFD_BEC_POLL_FREQ (jiffies + msecs_to_jiffies(200))
 #define KVASER_PCIEFD_MAX_ERR_REP 256U
-#define KVASER_PCIEFD_CAN_TX_MAX_COUNT 17U
-#define KVASER_PCIEFD_MAX_CAN_CHANNELS 8UL
-#define KVASER_PCIEFD_DMA_COUNT 2U
-#define KVASER_PCIEFD_DMA_SIZE (4U * 1024U)
 
 #define KVASER_PCIEFD_VENDOR 0x1a07
 
@@ -296,41 +294,6 @@ static void kvaser_pciefd_write_dma_map_sf2(struct kvaser_pciefd *pcie,
 static void kvaser_pciefd_write_dma_map_xilinx(struct kvaser_pciefd *pcie,
 					       dma_addr_t addr, int index);
 
-struct kvaser_pciefd_address_offset {
-	u32 serdes;
-	u32 pci_ien;
-	u32 pci_irq;
-	u32 sysid;
-	u32 loopback;
-	u32 kcan_srb_fifo;
-	u32 kcan_srb;
-	u32 kcan_ch0;
-	u32 kcan_ch1;
-};
-
-struct kvaser_pciefd_dev_ops {
-	void (*kvaser_pciefd_write_dma_map)(struct kvaser_pciefd *pcie,
-					    dma_addr_t addr, int index);
-};
-
-struct kvaser_pciefd_irq_mask {
-	u32 kcan_rx0;
-	u32 kcan_tx[KVASER_PCIEFD_MAX_CAN_CHANNELS];
-	u32 all;
-};
-
-struct kvaser_pciefd_driver_data {
-	const struct kvaser_pciefd_address_offset *address_offset;
-	const struct kvaser_pciefd_irq_mask *irq_mask;
-	const struct kvaser_pciefd_dev_ops *ops;
-};
-
-struct kvaser_pciefd_fw_version {
-	u8 major;
-	u8 minor;
-	u16 build;
-};
-
 static const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_address_offset = {
 	.serdes = 0x1000,
 	.pci_ien = 0x50,
@@ -415,37 +378,6 @@ static const struct kvaser_pciefd_driver_data kvaser_pciefd_xilinx_driver_data =
 	.ops = &kvaser_pciefd_xilinx_dev_ops,
 };
 
-struct kvaser_pciefd_can {
-	struct can_priv can;
-	struct kvaser_pciefd *kv_pcie;
-	void __iomem *reg_base;
-	struct can_berr_counter bec;
-	u32 ioc;
-	u8 cmd_seq;
-	u8 tx_max_count;
-	u8 tx_idx;
-	u8 ack_idx;
-	int err_rep_cnt;
-	unsigned int completed_tx_pkts;
-	unsigned int completed_tx_bytes;
-	spinlock_t lock; /* Locks sensitive registers (e.g. MODE) */
-	struct timer_list bec_poll_timer;
-	struct completion start_comp, flush_comp;
-};
-
-struct kvaser_pciefd {
-	struct pci_dev *pci;
-	void __iomem *reg_base;
-	struct kvaser_pciefd_can *can[KVASER_PCIEFD_MAX_CAN_CHANNELS];
-	const struct kvaser_pciefd_driver_data *driver_data;
-	void *dma_data[KVASER_PCIEFD_DMA_COUNT];
-	u8 nr_channels;
-	u32 bus_freq;
-	u32 freq;
-	u32 freq_to_ticks_div;
-	struct kvaser_pciefd_fw_version fw_version;
-};
-
 struct kvaser_pciefd_rx_packet {
 	u32 header[2];
 	u64 timestamp;
-- 
2.49.0


