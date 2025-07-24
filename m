Return-Path: <linux-can+bounces-4076-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2F5B100C6
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 08:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5393BA061
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 06:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C72822A4EF;
	Thu, 24 Jul 2025 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="avi44HyV"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2139.outbound.protection.outlook.com [40.107.22.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A828224AFC;
	Thu, 24 Jul 2025 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339050; cv=fail; b=TmJ2j77OS4aCKWaQyDWYFm+i/zyomKan0aR9vgC4HH65tbzwlX7nu+wnetiBnjdgsrJrcOKDYW89FWO6G0N74i2mOLucAH4ev6fNv9Byo24QOLwraQoqe5Ndwnf0AFjpE4C0gB6AvGBFzRaFxF0LtZ9ozZr5lSMFV0f6qF5CScs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339050; c=relaxed/simple;
	bh=bMV5ZPMcAQxEMgPH4APEt63fGnI4Jb6E3NU5wY+EK4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IvTmo1Kf+Ly6O60/BdcpFMQTB02/KX8M3nwkj5/syAh0fOkc24Ib3xqnetKAGLUw8qxIgUHEHC733T18snZy8bBT1e/aKgZjJ7jkOv2eZnliF5hYaZxNcgW5uomxsYzNTk9Z6+kr6hOpuxl3KBCLGnnGQwUuKmUVYIMd5UwqvT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=avi44HyV; arc=fail smtp.client-ip=40.107.22.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsvttkAjI9PZk9uocTMcl3WZ7NHjLySndAKU2q/nFrfU/QPXeEbbBUdEuq/LtdS18+qCow06LhfxDcNeI18TZtw2IEjEjCYeBolVW8iHbKjw61/CPSbzB6r8SpHrJGzyqheXp96QdTSDi1XCxLkx5mnB3qnR7OUFUmakbcAknAXg+4D7E30SsfshX4RzcSNkoUpCkviw3OtaK58tatvYABFm884cBbzddBUj4SLEPqCSFbdOapXQVEJJZ13Bu+xbufJzO8vZDzOC5hwdwGarAyGkjXCkTDV0YTEj11hpSKFRPBFBrPspID47OWT9d1eexpFc2asHmXMbEvqeaoj8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKS+P4R4fDTfQbzGYalIxx889MKB5kaRyAhl88dG5vE=;
 b=ignUuFl1QR4Z8jEZm6UtNPZ/DYZu9456+HxhhgfW+a+UPxWy/OD6r8n6cyNgWOCH1OdGD/ZHxiiNvhSmWAKrErD/B3go+gogcUK6wtxLz5EeCYNLHivFmx6MyiipzD9S5R5m6a+vwl3yHLz8tYS/a+WV9vLsjlM6NyIRxGMmxrmxOqwHOUcMKEY3MeONPPRRkdSsbenWBr/wjOUETOfEoh3yDynVnoJRMdUVaFmiX0dICNBSDBIYIFXTHsoV/yxeebRhc6spHUuLtgSsgy8sF32nWPVv/KD1d1Rk4D2Benbx1gqvaPiXylrLzaBl1Ami5H5xLuXWtBEWwb+Kdvm0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKS+P4R4fDTfQbzGYalIxx889MKB5kaRyAhl88dG5vE=;
 b=avi44HyVLrwmTZc+pF62FgQnmlspLoKp/7AmRVz8ALdBAjA0O7wXILF8oEX0ytnxKothx7ia327GAMSvvff3rk5G64I+N5Pk0ANmd5yJuUoEeMzqeHMl/hlu8rFn/WgU4bRAw/+VRM4S9vqR2/CgyM/zbP1ZybhRyYgORg/1ME8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM0P193MB0562.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:163::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 06:37:18 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 06:37:18 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 06/10] can: kvaser_pciefd: Split driver into C-file and header-file.
Date: Thu, 24 Jul 2025 08:36:47 +0200
Message-ID: <20250724063651.8-7-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5b57974b-6a95-4085-9c24-08ddca7c8977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B5jf5lD7LYAyN4MgIT0NATpDVPfu/hzLTOI2BRyXw71fs84Grgk7v0pRIx1b?=
 =?us-ascii?Q?5g6anlYZUKj/PMaZZg8081tmdxB/6ZryUq6katXYN34skirc/LbxkQJS1W7G?=
 =?us-ascii?Q?dPsNIfF4ns76EyaKCp2pjn2h4O7+WSq0gEmudGyOD50MvSGY6aaf64UpPvhF?=
 =?us-ascii?Q?A89VDwvu4x8i/jJvVhMwWxYOXQf4aBrQBAkNw/cCzPWxnoG8B6ngB+MVi9hP?=
 =?us-ascii?Q?6Sbf4PiShyuZ62j7AJnSkMujjVixjtRWcEVAu1VCKCAqKlyYA8wyjIV8z2Xf?=
 =?us-ascii?Q?ecJ+VbjBAi3LLjcxaEmDCa2/6WAeBDTjdL4P7eDCO+tmlDpSyc0s4yWHG/z9?=
 =?us-ascii?Q?05uFVoafFnRs/N5q93Y/BQg7uzeLP2nZJMv0pSHGvjW+0EtIbPRLTNLtFNzD?=
 =?us-ascii?Q?PnHAclg0Ew/lBxR2FFLzXUsV6O2TVkRLMW26QI3wcMsJimHHHVWHzUqEsSG8?=
 =?us-ascii?Q?H6NWktc4q6vMh92/74ELuoy3HglQ7c0TI7bmcTAJPIcMiKYEPlWFwj5VYoA1?=
 =?us-ascii?Q?VocpaUvvMCVyxYPr9firujwOU+CXawy/EgAxm0YZWeJF5sApxrRirAIbFMZF?=
 =?us-ascii?Q?QKpyGBeL33BYqLjuFSwnVXvGDXGa65WkfSPpuwzA3aurd9CUzjhsl8MR56D7?=
 =?us-ascii?Q?VAQF0uuchNOUcmZO33IwMVImkGzK6wsnWxh+i4+uDyVBEzbXHzWR1LQT2dXc?=
 =?us-ascii?Q?vBSSyNbj51iRay/X9mvz8MmO7mQU9fywwtTXYdZpzO4XPQls7D/o01n7NdhH?=
 =?us-ascii?Q?ws5nWv0Cx5i8uMyDF56/UEDlVLZeUwPaSade7xlE7oBH30mLArO9umQ3ouBi?=
 =?us-ascii?Q?nQaXXwLEKGz05BAEFoSumCAe56V5lRw7ACgEYOwxWm67uduWsV8Y1rDEMDBk?=
 =?us-ascii?Q?JQo/JIK8LzBGgTyudAiptILUUS70ztml4BSGVPP7eXf0dr+HT/Ok1t09yiA6?=
 =?us-ascii?Q?S2+L50nw1V+XqtLuyhww4GTeV8UiXfNr7jwqcQS5sQ6+QpBtw1pSFf/k7Mg1?=
 =?us-ascii?Q?hTrOESpa8fMD1lNd23ic9x/LH20iIoAGY/wW0ZXIICl+/d7RPx4KUlhWOgha?=
 =?us-ascii?Q?M1oaw8Z55vvyQHy2Zr3bZqeTy3LyQ8b9UvT86JkzUTaNDp30KuM0qY4K7ad9?=
 =?us-ascii?Q?3V8w8elOZ71RflGOYocqGRTwtf8L+Pz94fCCd6Ky096zjUVVGV2RU0Aym+8P?=
 =?us-ascii?Q?SCfwY0cEtYLaHJQLMBH7C9+dM6WRgEM5E19So3KPvwK6N+w7MRvSWNY2Oura?=
 =?us-ascii?Q?f6NAO3xLFDKR7RHbwSkbTgOgnF+qHB22pyHIlk0TKM70ar64COSmapJKqXnO?=
 =?us-ascii?Q?1ayDpE9RzKkEpAvlANdS4sbKY1xsC3VokoOjw3q1ljsutGJUSb7f3qLSqj03?=
 =?us-ascii?Q?vaYT04d60K20cSdM/NcATDofuY2aNHoAfRJUXUY6VlS1QNwX9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4PKochNvRteNFW/Kwlgs8ivExjKyF24oRXeJ0I6EHXGCracau83iyqbjBe2b?=
 =?us-ascii?Q?vvWBJ1yGgNxHPWFh7yCbJs0cv8UUgX7/jV5oLThCyPjGxcTsDvoASB9o9QUH?=
 =?us-ascii?Q?m6YrNs+N2pTsz7zLJNYV7lio4yMRR+PSabHA36szCTTuUrrDd/UcjXW9HA5Y?=
 =?us-ascii?Q?UW+XJgtT87XBoOMpI8eDaduWD1gc6cIVFeZi1Vdr6v8+3ptGUt+QuMy7Nu7S?=
 =?us-ascii?Q?Yqg01a3zVGn/6MFqm1ogN1zWOmiTBj5bIhEJ1LE5aaCFgb3EOszJPSlhg3o3?=
 =?us-ascii?Q?BlmLwyq7q2pZk1hUAz0iUns9G9wNSmcuXBhPHcyTxRV7fFWviT/wIyQLgZhJ?=
 =?us-ascii?Q?+PAUkuCjhp+VT902jdNnivBI6P5rxUOw9WexGq600lnN3MxV8sMrKUPNkHR8?=
 =?us-ascii?Q?jf1AXCZ7lQ8x5oNa+id/pkOSObu92eODf2zCiyQkrBbkPEXgAVwii8AxknS7?=
 =?us-ascii?Q?k0wI1jS+uMvATq51qT5rE1+jqmuBzIWIVTEPY6DK+WHlBoGiPmAeNxvG+X5b?=
 =?us-ascii?Q?26+OUwenqIBmRQ/gxLwhgLUAb/avvQYU9I92RvZGTipFjjJ3foMDzJhQPywt?=
 =?us-ascii?Q?Wb/n7pX6i+x4mvmVV9B28+LS8DnZTSR2b9zkmOkGoV+iAmL/wYSEz4RLZ8q7?=
 =?us-ascii?Q?GFiuj7t4TsZD1z5jVeg4WkDoIVJt+LKbNJLPNsrSAMSWb6tP8ZnC6KAaYmIA?=
 =?us-ascii?Q?AjV4D7gBiDU5EO1AxkIH4xwYsR055i5Eap8nYFBsZK1gvMa388P3ceW0Cacc?=
 =?us-ascii?Q?jJfmQH8avRl25QJ1IJVTrW0BflpBl2W1FnQP/8Mdt+tPcBUR7Juihci7Ctd1?=
 =?us-ascii?Q?Bn3k5pdr1+yz4mOeCB/ak1Xs61boO95k7y23zJB7MBA3BkaUA+A69ntn9A6S?=
 =?us-ascii?Q?EMQlylJg9Ja/sa2xZPCT4tcwAdZ1B8TNafsX5fYyu3jKuqoUy9vJtt/od0s+?=
 =?us-ascii?Q?WWpuuD6vRV2x7JRt01RDw2jr1bWtvmWALLRFAFqoVU/65j++bxKHKqaaa/um?=
 =?us-ascii?Q?xz4dKFt3VMTVJoiVA60PCUO5IJVwrAKlrrdwzDKzm38GeZoe2CgIF7MrQeul?=
 =?us-ascii?Q?K8oOZFl8fBs7hJ/ifWxrLb6jqzg1IgVDObtji7FUrS3qGM+Yz6QwD27mrHdc?=
 =?us-ascii?Q?0eone/ZPHMSkHTS6CcBHLwwFQHjNqLOb72rRq5R29dXgfTno4NsgzVQUhoh9?=
 =?us-ascii?Q?c8udMJFjyb5npsFial8E0kzdocB2uOpo1coX2G8DV1fJx/8whr5wLmIRlTT9?=
 =?us-ascii?Q?RCzbD3RBRIeN72Q2/h4Q7CYESXWZYlnaPGD4Dx3bR0fBfIJllyXkJzKbMOcL?=
 =?us-ascii?Q?IKBo9T9RtDTIt1RtjVdR8125MXsB1fs4KG6o01/YvVsf5aTJl+IOhb55SGe4?=
 =?us-ascii?Q?I63yzzc5HLn9mtxC8f+s/FTU7/wOV8CKNqsV3nqvU+coqcTmdz/Gggyq0ZKB?=
 =?us-ascii?Q?UF0VlNWMVW3DSoCODASLC7Ezp6Goc/KIR6m1uShKKnAYsfhC+52Uc/1PUGwq?=
 =?us-ascii?Q?Q8GFOrvIF4FDMYrYLcSuEK9YG2GdxZKFbobUYN7rpq4lu+6fx3aZGuqEjUPi?=
 =?us-ascii?Q?xJqLUFEYoO/NlzULGrV3vwc/JOJPZIdk3AT15x5j4DyKlnkQsTGwRgMgc1UQ?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b57974b-6a95-4085-9c24-08ddca7c8977
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:37:18.9140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7npQFgZIBBnbeTAZfG8Ba7uzejzY3Jq/1dWf7Y0VS2x7BzxxkeE3R4k4phhaRszdfp1HaFbeaz72ulnvnGv+3dtJzl41dskTNfSEV6fs/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0562

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


