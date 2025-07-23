Return-Path: <linux-can+bounces-4042-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 481BDB0ED4D
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B6E1C82F07
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25E227B4FB;
	Wed, 23 Jul 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="PjeZ5YpK"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2127.outbound.protection.outlook.com [40.107.20.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAC827A914
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259600; cv=fail; b=b3OkfA7mdC1efy9/4izJg5ECgrYV0Re085UdJTRdsPilcl9k6BpiIzbtPnyQG3V8h6sIP+XsJ3hTJsI8mC5lU+wH3rbeq5QFDkmf/oJKx/LWUevj5Xmuvmdbt8gYShWpnttCVa7PdUOYSvOEZcF/76pbzIf0gMcMGMF/+B6eSUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259600; c=relaxed/simple;
	bh=vTKu7wus+AmW/1q+IQVL5d7V2Klqeaxp5Z+z081MxQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wb7rJFFi8orwDbLLcW5vRl4pjwy5om+ta6HcyiaE+7dM2WFIle7O/b1NfZFcWk8GbHMdiz2pBhqRvRqjI2k7NeIKFh7jdHXZGk6Q5zv5vn5414HeOzfAGzyyM1lM+jCS53JR2dqjYVrUKKE39XMBS0tFw0zsG+LJUbVcWODnaNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=PjeZ5YpK; arc=fail smtp.client-ip=40.107.20.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FU+fvjYuP8tARDMobHzeorkDP9MmL5AZIueiSwbAcCnMuGbtsUuBjKdVwyHFYNVr6d4wBLEmCGZIZjE08JEU2lWFEHZGuGpscLPLKhPcdtbL3CsI44ZeotD6qMQG0f/BmuISkfSHT6ox7ZBQMiThymcotQSQqwsOXz4cW073hfM3Ll1qce8t4UXfahC6CHx6o+ja3U1xEaHUykKXGTdGkMy/Mr1E3sAQ2RF/EwVrgvbrhadPYEAEK7yj+HksUDNvVsi93sBtASv0gxEymxeytRCFUsM0/cfPu/mOaty2NSUxI2mxhBs3POuBD4QM0xoqfRCJjvqwmF1/HakrnamklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzVfymdtLqloUTGHZEzMhunW590Ey2EqEUOJX2QbsxA=;
 b=rxpmKJpanomSP712aINXXb3lL+fxwR8ZLtZodESK3sspLXs0BvQ85k/jQQfJPb1iPk//GvSVLH4C5a48wXP9WJOe9L97NFtEF+R0YSFJbpQMWRbCYBEM9WT8L997bQJ+F1Rc6+S3C1B8D3tszY5wMe/yd5x6TfawG1XlH16oy7xTJ5ajXrBHNxC/h5XB1iiIpHQZD6nA6z9ponHlzsqTnJ9k2TesIEDSZ+BUyOUgsRtx8gAw76HUqrrZdmYEFxiUSgIFnsNlHELG2edHroeWhHZEiY6IlUMII1PlsZkJqwoyiWwbYY7NURICoa98Tv+rVA/LfNN+PJYqVHLRX3SsnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzVfymdtLqloUTGHZEzMhunW590Ey2EqEUOJX2QbsxA=;
 b=PjeZ5YpK5ZsUnmXORWrFuRGtX7dHB0OyqM/jpohbMIe3oMAjNEJ86KGbjCV/a2kIMNJMx/k20hACLLG1re7CjZM5pomRGwlrU1CztYNhtdUdzbpHp8cEenS0KIP6FeKTDvkAKfeQFuRc01HVIGhE2Hp9odfwE+b6P6cBx01KlVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0773.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:33:10 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:33:10 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 7/9] can: kvaser_pciefd: Add devlink support
Date: Wed, 23 Jul 2025 10:32:34 +0200
Message-ID: <20250723083236.9-8-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723083236.9-1-extja@kvaser.com>
References: <20250723083236.9-1-extja@kvaser.com>
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
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0773:EE_
X-MS-Office365-Filtering-Correlation-Id: 533c4d02-db80-4e52-d687-08ddc9c38e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WLaTL7sKgvJguCQkEeOdWF1pBFfiECuzB5quBfUL6ZSpesH2wRw3R6WB4aYo?=
 =?us-ascii?Q?M2+qpn8Rngr/I3z/CwnKP0DsnRWz+2eSxH+uPeJc6B3vZEA7cim+DLtvf/w4?=
 =?us-ascii?Q?Dj8pbFvKFsTeSaPXfjSUGN5TmY8DPAFBfglPLRP3Y6btayLlO5JwN1edzWKI?=
 =?us-ascii?Q?36TGJG1JUklIEKIdBWJdkXle0i0nfw7vsNWA9TqE+CjuScalEOul6+dGLUuh?=
 =?us-ascii?Q?6mkq1zsfWfxanBIhlbii5/5N0VqCdah9fibzPlJsrH/Vwjmkh9LjwQ2EsQXd?=
 =?us-ascii?Q?Xg5EQChf2Qi75CBzuWuHdx1CWP1FA+2m2y9Gog3vlUvMxc3MMYDig28HOyIJ?=
 =?us-ascii?Q?4xX7qxMgFVuwIAo26H/XB0ZL2Eu4zMpV9ibx8jmB5KYxOj9KOMDSf+pUOoK6?=
 =?us-ascii?Q?KYe45XRUTF2kDzZTxbH6CXlGYd3FYiurXYoE2IpDT3hXgYgON526HtOzPtsi?=
 =?us-ascii?Q?ZD9/jqpMbyZq3RTxyOeFOgpKtmV1nIo09DXtboWqAVze7U5X6cnKFPMIAknr?=
 =?us-ascii?Q?fG70ktRohrLEpmEWPBvRDYkp6YarbcgYDEo0+Kt12Q1nkqRD+g1A35tKOs6W?=
 =?us-ascii?Q?So9jhlcdwBjM5bpzmroEDNOfuZ7dDJcdyHRUJdo3GQ8mHwB8JNLGMPX7EJi5?=
 =?us-ascii?Q?qKw+CyzOC7zeaIR7esHq7Nb9Qfv+4M+CEUqzKUsGDxPf7i6suKsPyMvxI7uP?=
 =?us-ascii?Q?+NK8a86fpbc7i0Xlrn4ojTRh9EM9+wfaVsUh06pmi2NT8/e4wH8IUtyu2Gzr?=
 =?us-ascii?Q?iipwdrIWZcYKFORFS6CgQtyT2YyC50l7Z5jdVu9N7xn9hIzS5sqPqf/+vmH4?=
 =?us-ascii?Q?FoXeOjP/LWNUN/6b6T0AdsPWyMqJRcARidkPqOy8NVtomaZtTZg4L4td3axz?=
 =?us-ascii?Q?vyWDVv0gJhc/1l4NG1P1h+nj5jBtocvAu7UrUfGX7kLi25St4Xhqb9RNhl1V?=
 =?us-ascii?Q?Gyp5WgpVVQP5PVKVEKGf/NHf5fuxofT/YNXLkAufhGAv0z5Npu6vZJKdw5oR?=
 =?us-ascii?Q?KK59ePCCXOM0phGtF1aF95AX6/0WdaiTjIC20riT1zWQFpJ6dYf9CpISamll?=
 =?us-ascii?Q?q5tEDCXr83B9zeUq6PtkoKEOAjA5xNKIm1beSDUwTfyt3WIRGnDR3y7djzmZ?=
 =?us-ascii?Q?SpZinxnhUAbTCx2EKTT7uBNGvMzd/l+8CuF8/ozYDYHNxAJ9NHeOJDSAwrnv?=
 =?us-ascii?Q?qjsqbTmXuz9LB4inO6a0J7CrB6Tm6bAMbIUI8tVyI3MAuHqAVODLwNykxCVm?=
 =?us-ascii?Q?2TDghdLhMRn2YCbLgxcaQO1QFmUqaKvOJmvJLoC53ZtPY9TamU7m8uSQcC3S?=
 =?us-ascii?Q?GBpoL/SEclxxQtrVA/LMsLTdm+9fY5yeF7ZIztAfGLTjUDu8gWu3CP0wuO7Y?=
 =?us-ascii?Q?G/0ls7mKMvMGwHclh4yK4r+7ZwkfHpHOcRVX3wkBAPoKctK+geaStM2pbTvC?=
 =?us-ascii?Q?nGPHG6Kxirs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J/qm2dRCA0sBtrg1ijUjLEECDxoCa9pbPoDgrw2BRXLqBNU3HS9pkC1lwk9j?=
 =?us-ascii?Q?7cWH6CcNfP/frvKSGQFuhP81FJ7E8RxEsS7My4QtRqdjxENthUgSmmKn+WEC?=
 =?us-ascii?Q?0Jv+hQgn34TeESvE5O4kwZb/a4VzQtYtySuYpECQWyZu6gC2M2zySCJrEhVn?=
 =?us-ascii?Q?GazpIooLwkuEXi0mIG3v1iV9uvQS2mgx0ZLY/zFTzRqK7YJMh8jP/ePXYeuF?=
 =?us-ascii?Q?B0P0wLUpAD1EcPzseGblm4rrxouFf0gA+VMWa0qE1t47GqxD+K/Z30wkcG8o?=
 =?us-ascii?Q?bUyudffd66nSGK2UJYNTzBUOvPLIC/axBHxEtPag+VPRxRVCs3H+QpRYLWUn?=
 =?us-ascii?Q?LMqAQOPGe5i/oJt9yVYhS+BEwVn3q94TMYCpSNyO2oLT48cBlN1cqtjR533a?=
 =?us-ascii?Q?0rJH32qOVupIYi79thIQH2c+CzvzQmjYEOuWDYqkr+6xrWYirdz6SmlQAX11?=
 =?us-ascii?Q?2sHaDtXp3twArxFOQjfqm+8TdyjBXZkju1eOjcRhvC8EjWiHuXa8x3syOToo?=
 =?us-ascii?Q?wnQBFRJrxs/WgGGUN2jH1bbxd9ksLx1K2Zw9Z283rzreRDVSpM4nxoje5LxQ?=
 =?us-ascii?Q?PNcuDYK5JEv/t3TwjOFetFacvbNQPilkxJ1leV7r9AjkrSLMJT75+S5BpGlU?=
 =?us-ascii?Q?R/IQnuzp4QwjD0PxzAsiPds3Ojn8Gpv45FnrJyhTG6FewZfUGCTE2hRyy74g?=
 =?us-ascii?Q?2+Z6jb8IFtZGXjAeDU+JTpa9ffX1cizasxIqrzVNTS5WSuWwOISm/c9uyk90?=
 =?us-ascii?Q?QNiLGSWnYef/z8dP6mosFmjGdlcvT6BOXYqEBv0DI39jcujnuG1nYc8JzMyr?=
 =?us-ascii?Q?nWAn1yaowECO8s4l+lqHIvDERm2xv53PPgH+8wdsEilgmfEoc9RLckw9DVBN?=
 =?us-ascii?Q?wI4OLO/E8sGaDw/vWxI9ByHFJYWS7bQYLgHELhenNsjRi5l4lMviOZiP+lRm?=
 =?us-ascii?Q?E1phmO/eAdv1b3gItsutO8J9czC+8gEPZKcaMlAoIdflgZwLcvoR7+acFnkJ?=
 =?us-ascii?Q?spjpBGY9V4tRlEiluBnMcEw/+T3lrSRMjrhpcyrwXbft0HZTKGzP8plbWU7G?=
 =?us-ascii?Q?SnxowHlt1wXfBDpmgXBc0CkZLqaju019wZAm/gQ7KHOZAtW8tKEudyANSD/m?=
 =?us-ascii?Q?WTHQfxLRYUSmVXsFdUWfDJi/rqhhNrYuEwIH394Gxpmu2FP4JImY1WDZomzR?=
 =?us-ascii?Q?5xCq6KzV8TgD3w+MATsmoFhgu0V5ezGu6nSzNMVkyvevIlFavwnuVXBa3u3d?=
 =?us-ascii?Q?MGZjgsZSbwTXTEveLrtsASO06kJowskzZWMGcJYUPGLuRHiQF6FPKRpD0Akv?=
 =?us-ascii?Q?va9ndOGWkrmJzCt9fJnXpWn+WNziKpy7R7G7csbjiydzZXiVnyIvU6AZg63x?=
 =?us-ascii?Q?uyTqSpBEQ0XNFlx0XzN0dsQlBk7E56ABc+3Q++R30Ygn504xinE5YB+reiZ1?=
 =?us-ascii?Q?NoDxGauQ2Mz8AgK/Ha2tlGwwLLUmHSMq406vvkPLkxGX66SY/jrupe6r6oyO?=
 =?us-ascii?Q?xT7zKmhbibEubuno6sG2VwJLSaXQPiZW/MI49ketYqh49VMCdhY7DLT4OjRM?=
 =?us-ascii?Q?vHkjpqC5MQ7kdzMSwE0EsbICk/3Kz3Xhjdk8AMN/fyEAobzZ170HJPu6xT6Y?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533c4d02-db80-4e52-d687-08ddc9c38e35
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:33:10.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cI0rTUtE/gfrX6V85e8qC97EzIH3iZZNQ8d3VYncMQYIOYO4QY539cy6cVIiJVAdz8mZobIaOoNPUAFFRaRKWnaB34Mx87S4LmTr6jQ8bj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0773

Add devlink support at device level.

Example output:
$ devlink dev
pci/0000:07:00.0
pci/0000:08:00.0
pci/0000:09:00.0

$ devlink dev info
pci/0000:07:00.0:
  driver kvaser_pciefd
pci/0000:08:00.0:
  driver kvaser_pciefd
pci/0000:09:00.0:
  driver kvaser_pciefd

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/Kconfig                           |  1 +
 drivers/net/can/kvaser_pciefd/Makefile            |  2 +-
 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h     |  2 ++
 .../net/can/kvaser_pciefd/kvaser_pciefd_core.c    | 15 ++++++++++++---
 .../net/can/kvaser_pciefd/kvaser_pciefd_devlink.c | 10 ++++++++++
 5 files changed, 26 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index cf989bea9aa3..b37d80bf7270 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -154,6 +154,7 @@ config CAN_JANZ_ICAN3
 config CAN_KVASER_PCIEFD
 	depends on PCI
 	tristate "Kvaser PCIe FD cards"
+	select NET_DEVLINK
 	help
 	  This is a driver for the Kvaser PCI Express CAN FD family.
 
diff --git a/drivers/net/can/kvaser_pciefd/Makefile b/drivers/net/can/kvaser_pciefd/Makefile
index ea1bf1000760..8c5b8cdc6b5f 100644
--- a/drivers/net/can/kvaser_pciefd/Makefile
+++ b/drivers/net/can/kvaser_pciefd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CAN_KVASER_PCIEFD) += kvaser_pciefd.o
-kvaser_pciefd-y = kvaser_pciefd_core.o
+kvaser_pciefd-y = kvaser_pciefd_core.o kvaser_pciefd_devlink.o
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
index 55bb7e078340..34ba393d6093 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
@@ -13,6 +13,7 @@
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/types.h>
+#include <net/devlink.h>
 
 #define KVASER_PCIEFD_MAX_CAN_CHANNELS 8UL
 #define KVASER_PCIEFD_DMA_COUNT 2U
@@ -87,4 +88,5 @@ struct kvaser_pciefd {
 	struct kvaser_pciefd_fw_version fw_version;
 };
 
+extern const struct devlink_ops kvaser_pciefd_devlink_ops;
 #endif /* _KVASER_PCIEFD_H */
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
index 7bdcc84bce21..b553fc1fc3d7 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
@@ -1757,14 +1757,16 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
 	int ret;
+	struct devlink *devlink;
 	struct device *dev = &pdev->dev;
 	struct kvaser_pciefd *pcie;
 	const struct kvaser_pciefd_irq_mask *irq_mask;
 
-	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
+	devlink = devlink_alloc(&kvaser_pciefd_devlink_ops, sizeof(*pcie), dev);
+	if (!devlink)
 		return -ENOMEM;
 
+	pcie = devlink_priv(devlink);
 	pci_set_drvdata(pdev, pcie);
 	pcie->pci = pdev;
 	pcie->driver_data = (const struct kvaser_pciefd_driver_data *)id->driver_data;
@@ -1772,7 +1774,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 
 	ret = pci_enable_device(pdev);
 	if (ret)
-		return ret;
+		goto err_free_devlink;
 
 	ret = pci_request_regions(pdev, KVASER_PCIEFD_DRV_NAME);
 	if (ret)
@@ -1836,6 +1838,8 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_irq;
 
+	devlink_register(devlink);
+
 	return 0;
 
 err_free_irq:
@@ -1859,6 +1863,9 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 err_disable_pci:
 	pci_disable_device(pdev);
 
+err_free_devlink:
+	devlink_free(devlink);
+
 	return ret;
 }
 
@@ -1882,6 +1889,8 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
 	for (i = 0; i < pcie->nr_channels; ++i)
 		free_candev(pcie->can[i]->can.dev);
 
+	devlink_unregister(priv_to_devlink(pcie));
+	devlink_free(priv_to_devlink(pcie));
 	pci_iounmap(pdev, pcie->reg_base);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
new file mode 100644
index 000000000000..8145d25943de
--- /dev/null
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* kvaser_pciefd devlink functions
+ *
+ * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
+ */
+
+#include <net/devlink.h>
+
+const struct devlink_ops kvaser_pciefd_devlink_ops = {
+};
-- 
2.49.0


