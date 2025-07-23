Return-Path: <linux-can+bounces-4041-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D85FB0ED50
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 10:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84327961BC9
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE29D279DDB;
	Wed, 23 Jul 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="ErIXWolB"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2137.outbound.protection.outlook.com [40.107.20.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB5427A92E
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259600; cv=fail; b=GKq2F4MjAJht23jVPcsCiHbujF2gfSoCv+6M5OVot3yhHhb96P3IfZ9iw10KR3IFJOIWqhSSz+zm1foCT+c02hVJXpDz7ht/uz8M8XBSZIWqYUbqzVC4chQuJ3jMRZn2pcbGzxHZgnn+Z1xql6PQ0T3zsoiJAXHPTUnuYVCZ24k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259600; c=relaxed/simple;
	bh=XN1zOihKSuBdrlcZ1lP4/Ob5bUOOcnJn3QwbemfthCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bnHcnIKqXuLNEmgYx6k5i1ONb0RnvrZctqEG38GnwqL+r85gT/72QyCqVaa2ubWXe1ubE3tfQ6xCq7h1nEDU5qXCvopNhRh0VySBjaKLIGxN95Li0rC3NuSbkl1yh+ylNmXEm2GlCQq6Pipj0rSIgb/MTDCEM4ValDWhpx2EC3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=ErIXWolB; arc=fail smtp.client-ip=40.107.20.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxaowzStnaMtG+mShp6ufkxkgB28wmSHw1pmd9oumaFb8NDiA6mzma5E+Mh1YKu6Onv2/IRCH6qtAhrW/97yVAfWHLkecFeEVBqat2/LiI1TW3VnpddEwdFDPDA6C/0jy2E9cRgmKskqZgURTsHyBka/sA5tknLtKUaibQebnAYud/wCfrJ6duS/DPGmO0BWdV5ebXYg1C0nTkN0c5QkHA1ZR7QIJTPj+AzZnf4r9VQD5K0DmZ7WjPxXE9hpAJLWdun61dHpyUrExRHaF0JVuI5yDqgRodw2yFFb9GKu+CsWU2Bhr5Ci0heqLukBktu1rYfaiCRdTF1Aars+lpe2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjexoQrA17pGrCNp5QkUopQbsH6+yno8U7BHlPwJFmY=;
 b=tGttyuL9+GSLdQnNiZMR7VuAdGglQ5kh2rcxLTddnwkDAnaYJK7jY9WoZcT1aSTNsEzNvf3/hygMoWYJdIG97RCEJomUS8cBF9mW7sSs+/3Kkxz1jbL4ICa82NFqfak+wW0m/hKmx2cjX/tK9IObZwPKwlLtO3P7qbyG/dPS36S4PWGNY2iQLZcJd43GewVNOb6+H+a9IACDaKsl9JCEPg8wk1uD88h0uJ1iExlzH2YolMjGwe1Q90a4cD+P6D7LbFnQuvCZrROEqTXBR9P+SaQSkl7DCdtlijTz3bskPGTyP+yjbY/C6EYsRSsnEicaBjeMIcL/SdV2FRKD1rcgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjexoQrA17pGrCNp5QkUopQbsH6+yno8U7BHlPwJFmY=;
 b=ErIXWolBko+GgBhMAgEnOjYjko8mKd+DqfMK43L2Bq1/8DY5g/zDXjeNa5gPUliw9FgXTdaxMrImuatd6b971nyl95O5ZUCt20PC/UdOvTQS2JdaHeFrK9s42ElcsurtFp3sJjZaoHz7MoEUY9BsVAMMuhn+hiWBG+mwFDvhzy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0773.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 08:33:09 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 08:33:09 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 6/9] can: kvaser_pciefd: Split driver into C-file and header-file.
Date: Wed, 23 Jul 2025 10:32:33 +0200
Message-ID: <20250723083236.9-7-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0312f12e-6a05-4e94-40c7-08ddc9c38dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0RJhfS8pGB7Nfpj93StRB+MK3Ku2oZzgQccdrK5Yb044/MoCwvD77LUi7d7G?=
 =?us-ascii?Q?Gxe0QGgX9UAGNspRzXdirnPSKCCwm92qBpRm3s+lj/OAAxXdW30wTyUWhIv5?=
 =?us-ascii?Q?6bSy7oI4abQLHFne6mRwICffAqIoLQn6wCNJKRwULIcTpGfRJwY/DCXgUA+9?=
 =?us-ascii?Q?VmwRRjOfgHeuU+fd4NCO89osWifMoaY6wygmARoyaT2Ia10X8/wpJutrkpty?=
 =?us-ascii?Q?Jg4H1vO+j9WIMruAj/iHVf498YrBQb6CiTvsRPK6xABp614hV3OUcUrhEKQ7?=
 =?us-ascii?Q?ncub59aIfrXisNvnF8D3NOYv20H1Ak/Uz7Nf2twvDllqgEvUj0EhQDLdMNjW?=
 =?us-ascii?Q?pAhspixzMmyPZhBcsKltYF2MhQafJiP/qnZuBiVXb+1C+t2wGyAr0rBWNK0H?=
 =?us-ascii?Q?nZjogpcKopMjxVnW8ZSXdgNePWee41bJbUkcqNbFn5/TtfHbBP7L0DxpibqI?=
 =?us-ascii?Q?IJjUoSGnRhVntPlkUnlonJeXyFK4snO9RUOSEqGNRz3Gckykt4YJ3847xGD4?=
 =?us-ascii?Q?vb5IOvVS4944s3tN/G/FPVv5wCQClg3kY1iMyR+P/IklPl8a5nFbcNDglNJc?=
 =?us-ascii?Q?VTT2+yOdsyIvtdiI/sX1sgIfgnYIo9B0xI0bNqPIqadxuaOFcHGrYez+S6/y?=
 =?us-ascii?Q?4otnT4RYOam/Q1iMrhOdtvvp2TM4iPqFPZCM8bnMDhvlRzMm0SlKzH2UAeFM?=
 =?us-ascii?Q?ApCIMdnJkcpt/YGUR2r8aqlIjyqVO8ilFIw7eeoC2eq3SOfTCuJ8D4Mit7Aw?=
 =?us-ascii?Q?RJjSAqVbibjU/r2VQRo4QFNkKrFYjdugjLAcAN+tYFucazdjuavUGCHRoMWN?=
 =?us-ascii?Q?gX57RFAZJMKwYVYebnYtQWw8pXqW7gPj2Sg+fJlLNBX2Vx/AGHg1uo6rNrXS?=
 =?us-ascii?Q?l4zIpAIUkIRbNLint11xmcvww+f1MiIqb/sSNnXSvBA2UxFHpfZ3Ju0Mf8Ol?=
 =?us-ascii?Q?dH85ImrBWKZZoxHKQh816YQtBQ+2ezXMkawi+U+WlRZBFpNBiKbsCJKNxGNi?=
 =?us-ascii?Q?E0NjYmNlUaqcbR7/QJ9M5mah/ijV4Pp15aztFRcUTYdKe+lz6CV+WcWi+rpY?=
 =?us-ascii?Q?YDbbp0jdInQhl+0oW7sGzaNqE1L7+djrJzKNVHwtq2/xB2rUy95JkWwlH9vG?=
 =?us-ascii?Q?HbfwL4wfzADPxReQR7JP96bL5SFxVXACjGNAHyRCIthO1ppo/nbqim0fw7EK?=
 =?us-ascii?Q?rFG0LBKeKW5tQnMn2BV/wFxfh2+I7lQLp6StXUHW4VSXDfFNvevGf6Bdtol3?=
 =?us-ascii?Q?kQhE7PPescFjtOAC1gMrUuwBysJ7YDa76GHCVVjWARYY6xMGeu2VoHPYllHu?=
 =?us-ascii?Q?J/i7s0LHH0nPesVHHpKS0fXPotNkDYQxwb7oGt8RHs3Xn55BABjHHaz2u66q?=
 =?us-ascii?Q?yYNNspjlX8T4jNgPgvWW5LttpeR4GCLTM0wLmnYYhmL+5tEpxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vd6UuOnQPdcpCyYqfj9HKL8xcaN0IO6r8K97gotPbU6b7CDYHY6FCYynR1il?=
 =?us-ascii?Q?rNss/P3+RBSyM0n+npv1qi3JRNrIeCF4t6frBSkBkCjoFlxCfU4wpw7IBzXD?=
 =?us-ascii?Q?zgIr1wRwxcQgsjyUR1JRCDxchZW//ma7NJ8cfXEMMh06ApKpKmK98zKNK8J0?=
 =?us-ascii?Q?gN1YFvwepq5+jy8JZ1ZbWWaxTtB/j2b0ZDXiShaXVEFT+v1djz9ScCfchQOF?=
 =?us-ascii?Q?JN4Q1EvrC4qhYoWtgqWv1Zo+v17ak98x3XWwyFss5plbl5+eiXjxssMqdwVD?=
 =?us-ascii?Q?y7KIiQ5327cgQlQ3wMGIQlx9369LAz2gOtWEP/NnpAmbxUXks3uhRA88D6GZ?=
 =?us-ascii?Q?ygQ3atuEQkpITDU5OYQiQjfYMkJAEVAwrOyuYJxQGcku/pOV8ztAD3z6FzUx?=
 =?us-ascii?Q?uwZw4+4On5HOL7ZQvvseGjA3ELsHAdndQh3I8ADjaeHy9neFnK4AfH7sLnIT?=
 =?us-ascii?Q?io2S+vny9U2AZRqCTtVDS7wYRLlpF/5g7B+g57V/xMLl5Xfg/Lm+FDbAwcM8?=
 =?us-ascii?Q?nws0tDnCYynmRcy1Z5TwuImSgEj0GcUko5DjBu9+TDGqjqo+RO5daVzz4Ju/?=
 =?us-ascii?Q?dO10HtTH1AOMjvS4bBxllht5tWstG9bNjdCDVHdMZthCXjYbXtWNFl3+uUb1?=
 =?us-ascii?Q?JWy4Kcitf+ZzgIg0W3vphtpVQhA04MqrK10vQNS6ublXCh2nDHJU/3PiFDPd?=
 =?us-ascii?Q?HeU1+MLyPCWPlEXytG6kwkIerqwQCyb4Qwg1azhFSHNzOn7DfVLGf/+xqBSp?=
 =?us-ascii?Q?cWyRjBVu01tfxRz3VMlaqhjmyaGVJxIpp97B+X9jZthpRJqRYeOfHvLt8EMQ?=
 =?us-ascii?Q?uhQ0p0s9ptFCStkwbxeleLhh2Sp0s1M88J+0vG3D0vhO41ObwnISOEpn9hnd?=
 =?us-ascii?Q?4IKr0B1WFng4V3P9X5kn9QZxrG6mB4zbHZUhYylJ9JerI3DY7e0AxaGvvmMB?=
 =?us-ascii?Q?iTFeTntLNvqdc0O+moWDw7synKMxCQ9x2/bODG81lpPCel3nNNCL2JT18gbg?=
 =?us-ascii?Q?L72hSNFlYnIA4iIR+4LCIxIyguuru4hFcWSw6OxHgRG9Dv4nsc450gkpNPf+?=
 =?us-ascii?Q?CwX6DN4L9JrqkiOTgpcKcNDb08mXsMZtfEzo24L2UoRLIVNDyeOKJLk9K0pN?=
 =?us-ascii?Q?KxJjhltzmVghdOVoN1gLTnixqwBx/R3kVDjgZWs9x0K2Tax0+hfJf/nPimGu?=
 =?us-ascii?Q?3hR/fl3ZCfWq0lCqoTPJ95W2oAb01kU7M697rMQmeRp6cKts6Z4gT/dNw8Ox?=
 =?us-ascii?Q?Aj50gO3aqMMQTOqDvTvqaPxPHaeq3KiQK271BgdlQ+wYXUVThbV1XbGTyVH8?=
 =?us-ascii?Q?th/LasA1lqO7J3EfboJyjFxZ01L5Bikk7ih/5vS3/S3nz0uWgbfR1O9fmxZr?=
 =?us-ascii?Q?0WOSjGX1yMikRHp+q+HZ/+EH2IFNbK6uHDCX5wul8XWZ3QFZZylfPkNeTodD?=
 =?us-ascii?Q?a0r+fAzJ79aLK/aUVoDXWzaSOVipFeAdIxCY90RjNFQOHMUf/073CrhvtkBO?=
 =?us-ascii?Q?Oal1rF7cvyLZzGfv3yxE5IMl0ywPtzPYJTpEfdAhjfPK/DlQF2ev8sQTYspY?=
 =?us-ascii?Q?fAYrVmagHd+Xu+DncFW+qpJIJ93bpD2iKZuOM2UwYxhK5P2mdfFWfHXaJZoH?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0312f12e-6a05-4e94-40c7-08ddc9c38dea
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:33:09.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5WBAWFsF8W0W+WXYuazqbvcxX2bKZnKzd9zceVXZl/AfsssWJCP8wjjT4wlSBxh2TITUABtTi6ams17bo6mMRX60uoPXex0mbQKkq0T0Ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0773

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
index 7feece6d1d41..7bdcc84bce21 100644
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


