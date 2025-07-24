Return-Path: <linux-can+bounces-4086-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F84B101D0
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 09:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D475AAC181E
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F522627FC;
	Thu, 24 Jul 2025 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="XIo83aT4"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2131.outbound.protection.outlook.com [40.107.22.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1595526A0ED;
	Thu, 24 Jul 2025 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342245; cv=fail; b=XE2PqCROWcKPTuuBkgYnnfxD756VmVWlo3LO7eoqOfm3N+nQF3kJBvpf1h5FgAxBYI8WYICACv7VzsuIZBQZiifxQme44fwpEQg/aWazB3E2TVwK3UkYDtezkuaGwDkG7309Yy7GwyLMC/hUlxXBxOwJb45gxc4zXXUVqc5saLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342245; c=relaxed/simple;
	bh=Ws54W/nON2+l1udS3LXHVYwrO+PH8kxr70OFsPc2ONo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rhZGXstCx3rZeHicXZfXlUhxkTUIFL7fJCW2VHg8zd25Z6xVtOBqN0CaFfGnzzJuIVgLPK7hK46kIMP37AxhZKBiCPKebTofK2mMc4/PUu9nmvgYFpfsmDa1eNxlc2ooRrVVgi5mDbh76frr1T3m1TBcvQVMV0Vc1Ih10ERjiqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=XIo83aT4; arc=fail smtp.client-ip=40.107.22.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVnxKHK7eFEGXIkC6bmB/FNY3znZwb69ZBX1sh7ATL/gxVeUqOdsykHlCzmaYH+ceL6turTQ776y/CTNtBeYIOPXfKlE5GJJKqadOt59rmzet0z6sXC87pxjnB+YNoOzQnLI6/6xjhVJ6m0bekeDc/45lSi+c8IgCwm4qxvfdGiwj67Dxib5Hzw58u9pIQY0z/sF5tUNESGh7gXnLeBwyme1rzmdUkAt0/Put3m9z5TQ1ci/sBJVN9edglY6FqvbOMHFbmshRQWzq5qIuEIfY9tQiL2p1c2gaTUQ9+TaLF0JAATVMxJuVpqN85apdF2iSomo5iM/7DdEFef/FoGGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2ampLLw3kZ8gxEAVLGubuhpk7xP0YY2GA59j1QiUIY=;
 b=JE3053sjLYBQaYnmYxv6T5fV4+V0T+1DY3aM0V+TGyTcMHv20yLgSJ43uTq//CXgHZFSHtjrQghGQsRPMt7GjCkF/dFLlfMRDbUChf+aIpcCUbrlhWquCCqz8jCUhRczcCEXdDVRMVbeDuNX0CNMuw7n72JGFmjXpHvhnnJEWY+4bm0jcibWzGBZ7+P6k1hIXHUldu6bdwoyOoIAMoRDmrVTA0TKZTkVj6XpMXFhpwqw4150ONsPSPFyHLyunfGEDEzUC8dJj1TEXfwC4xHGxCOZU1rwvvm7YrPEsfRUYPr0QwZmXHl60peuKeWCFqzFik+8XLPSkQ0ts5FlqehILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2ampLLw3kZ8gxEAVLGubuhpk7xP0YY2GA59j1QiUIY=;
 b=XIo83aT4+Od07M2OgeSWhvpd4pF3JCi2Ex+NYY6gM8GJgE4el62gP15MqFmeNVOzbrpiKJkz7nOMiPiSgKLWfXqovghv0w/dnbDzTrxcLZI3B5e/HudD+rSRyjhDMp1iOyebxMBgmAe8f2Jcjq9OSuA98QoPUxonU3bG53V7GnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AMBP193MB2850.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:6ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:30:38 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:30:38 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v3 07/10] can: kvaser_pciefd: Add devlink support
Date: Thu, 24 Jul 2025 09:30:18 +0200
Message-ID: <20250724073021.8-8-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7f227054-c693-48bc-6601-08ddca83fc8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7KtA7nfRQ5iAzWZqbABGDJgYZ2t8ExvvO1hd5cK0cBbJpKuVCKqOejp4gAd8?=
 =?us-ascii?Q?0E4voSYTk7M/HkfqoUyUxbDT79JNHVD5oAtxIEZ0gnmBBXLD/Uca+gregs3G?=
 =?us-ascii?Q?6D4z2rXX3ISuK25+l0l+GCvIV011AJPvsM9WnK66/WU2kvXJCXDo/Xa4sWkN?=
 =?us-ascii?Q?Rv3bY6p1jyjX0MH5h0dekWYodMVyG8/UjG147geT3bnoO9f/3CFKt6hu/90v?=
 =?us-ascii?Q?vxCeWHDlisYNbKH+xlcq8206unA2KrYsJV58AzwQVvv6LNFQUtr/HnQ+VVoh?=
 =?us-ascii?Q?UgGLtfpHo2MauXr2Z94Aou21n6WbLRBaYk6yi2OYq3xmAfhe0vUSwMIooJoS?=
 =?us-ascii?Q?xK7ojTopfNExGP3Qy3RkFv1bn89PBMg7FI/ed7K0KO7arGt9X//8Z6qeR0fX?=
 =?us-ascii?Q?Zmt/Ih33XR6RVBk/d9LBaYockf95SsAOXt7yU3T3eROcHN46rdflUygE+Npm?=
 =?us-ascii?Q?8NkHN2Bu1yWHsQPWlf6oBRw+0vHSCfEiPfOtuJhDTxaLao976/l079fvPUrT?=
 =?us-ascii?Q?gQCrhK+pUUHRoqHZZgOklNTWjE3cObNS9Hs1eBaAIm9sdeO/pRBr5MjwR1jm?=
 =?us-ascii?Q?Yi6qBPGVtfSAPMdRxV/Cvc7sLoJfzyQMecpWPq1ReFELKPxoZSxu9iyZwS/2?=
 =?us-ascii?Q?cGtnUz41Dvr40SITBRd+wBrmemqg8PeIWLBAT5Cc9noZnaz474pwKcmRGm/u?=
 =?us-ascii?Q?Uq0g37/ldHXQ3gi7bHTNl5YcsdoYtYf8yD8BweB9AL4uYjyqKO31NhUTeUwq?=
 =?us-ascii?Q?yyj/24HJxGsfT+vgJ4aeBGxbU1QNBXsMToYN1XSb6RmfFZvX22QI0fWkIaIe?=
 =?us-ascii?Q?BxoaLnHuP+y9Zlc88mahzasxkDFNXEyxtzV3Ve+/DAJQJ/PDmAE+fzdc/n0c?=
 =?us-ascii?Q?uDyMSgU7JcFB0s1Y+TUlgXF0W01NGD4gaTl+Ay/lB8Xr0zRemsk80M0d63Wz?=
 =?us-ascii?Q?RzP5OnoUDnrB/FRtgYnA3vVIVHxkafRVirk50KbGrVgDt8H9oY4QsX+6J/Zn?=
 =?us-ascii?Q?rT4KGV8V/hXZWGjsCfD+RONG5nnf45jLw0LQaN2aUwl1iDLNi7pfrj4hNmrD?=
 =?us-ascii?Q?XFNRTIW+ib2XP12E60mSisO6wJRMAMaj2baFtIj51Q7zHO6nwQ//iphZPmhl?=
 =?us-ascii?Q?vsY2AfsHkOyGmXCBFm/qHn1w9Arg5CYDTH6lZkpfx8fiuibx6sN7MexBaIKe?=
 =?us-ascii?Q?TCtW2zdmKmllcenvNnzhiYnaNkiuAlhZiDRuMnpy/SqSye5MdDe7EN9vwHvg?=
 =?us-ascii?Q?rsAqFL8ChJkAQrx/hie5WYXmFgMGHhXqcOOb/iS3Tn98yEUbgIirsz7A2lOE?=
 =?us-ascii?Q?2oW6DhAUHC7twu+Bhid0Ts0vmWabBnP70jvBG217ltuI2OcrcwzEqy2wtN8Z?=
 =?us-ascii?Q?Leuesh0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e+ZMEdj76zcfUQJN/PNAzarZ0vWB5m5PGrfDv/TlHFJqE+gm7q4vFsoDUyTI?=
 =?us-ascii?Q?0unifiIspDOW4OCdzhP+3xbc7manrgRPTkwoLl4K0ZCZ71ngAu2an6qN28pV?=
 =?us-ascii?Q?y6xHPDSPfp8s+Hh/NOK9xgvUP6/Vj3F/7yJEmjKkdASU+FculsxYn9HPXfiR?=
 =?us-ascii?Q?ZK1VV2O4mS25oAqN90NSO5chRcBSjUm3mtBYBMLpWwq3OBl3iUic9znQzkhx?=
 =?us-ascii?Q?fd882GiNezAuw1QMalsI5S+5gsRZDyrIpbdyMmaBCr+2t7PbELQp9k4EwtVu?=
 =?us-ascii?Q?wvUohSwmet8xE73uygLKzvfFOnYqcYah1Gn+xWwDvwqeVd8FB/iiFxw4TSyQ?=
 =?us-ascii?Q?XZX/daRbYnTbNDEIkY88zjlL20XeAppUnONlIRgZuK94y5aNF+KZcrRI9UNi?=
 =?us-ascii?Q?DI4HkD5iAdo7caZQYXfQV+aDFtdyNraScBE0tQWXrKQjq0WjFhpe36flsYM+?=
 =?us-ascii?Q?r/pFRzuGZIDGSN9lyekxzqnSs/l2/Zvczqai1X+Q4pfVt0nJ+MBCs/QHa081?=
 =?us-ascii?Q?kE2p6cHVLo63uyy8fOBB9rplFKdSU3KGNMRvb+Fr1jMm4N97HYoz+gfIkT8r?=
 =?us-ascii?Q?HWJxWyqt6aGY89K7KewccJk4kyGQIYNnWMbEKdhY7WSZQ782KSvFqLlUqB7T?=
 =?us-ascii?Q?I8X1hO8P4IfCSFI5Og9AVuFDQBm4kZLacEuVzYVQ7Bl1m9cWHmADCR/rXg0D?=
 =?us-ascii?Q?4yGa06hDTcJeqV+YYJaeLomsSIamEkbJjTvtgcvkDiz87vsZsVx2maqINLPW?=
 =?us-ascii?Q?hpfoaUNVP+zxHx5/bfHEhkGDz2xgnMsahdQ/GZ+q7ybFcef1Ztw7VWkIfMI1?=
 =?us-ascii?Q?nOSpEs2YPawX54KZhDnLSgym8p4FYqv/v8dCe2ZBOAktdmjwIA4er6VkPiKY?=
 =?us-ascii?Q?BkI2uTuRhSpPmv+a7M/Jf6o1XBTF5/52eccpF/zBP8GrkcwNKXxmmEZ1yg87?=
 =?us-ascii?Q?T2Aq2sYg2/ZphNfZLujVpz5YGrbyD+eOruKneNrll6EZKuLQb5lUx2bePI4p?=
 =?us-ascii?Q?cTnzkqs6ZJLzl376o0wRUGXxyM2pJeWXettHBgLywS5Omu1jCWw52VQ7hN43?=
 =?us-ascii?Q?llGhr5iBHSI18DxO4p+Xdl9Jz0uJmOsIbKJQsEwtBUaEhOaB0zKe4ueCeWSa?=
 =?us-ascii?Q?z2AuUGqJOrzYZu5Nca0deaSQvbUnixHYIiv3SloVtCnoF2TahmUEwGO32nsD?=
 =?us-ascii?Q?xzyjBjonOrSIgsI2qDZhjssPc9b3ufW9T5eB1M0igSogIHk55VCrm3o/ckwh?=
 =?us-ascii?Q?bwKdwBMxhyssgQjpf/41fdcrFp+8mzNZM5P2NR16HK1HkOBjJgRg0evrg4dG?=
 =?us-ascii?Q?RDZa4wFeVRqGuw9vcPibqRR2lhLvuITdKMO/XI3BaRRGTeolinIsEX+nf/EC?=
 =?us-ascii?Q?8NNEFKxL+RzUggiQExq/5Rd+ip0T9RVEK7INTJmrLrM18lholczF7Kc30SNz?=
 =?us-ascii?Q?yJiTYZMEka5OwYpBw1NGbiIAGLSFU18brXvtMg7AXgyT+91QQyBBPC9c2E3T?=
 =?us-ascii?Q?AdHluK+kwuT1965IJ7J2/2CAfPuCVCnnR5nsV5QB7GfA1zqhZxkchlJ/wTCU?=
 =?us-ascii?Q?ZcG65N5kZ2VQyATuIq96yN6y01mdoEh8WQcZAuY55AnqhrtOGHEIY+YK0QbT?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f227054-c693-48bc-6601-08ddca83fc8c
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:30:38.6840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twwIlx/MlNqf3ErJzGedQvnCTYz9t5Hcfwula/gPPyOGWcH4rTZo/rnf0dBQG/40MnsAro9nbLHFAvGLyxdT+H0Qv4IJ79BodadHWliDbHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP193MB2850

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
Changes in v2:
  - Add two space indentation to terminal output.
    Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m31ee4aad13ee29d5559b56fdce842609ae4f67c5

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
index 97cbe07c4ee3..60c72ab0a5d8 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
@@ -1751,14 +1751,16 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
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
@@ -1766,7 +1768,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 
 	ret = pci_enable_device(pdev);
 	if (ret)
-		return ret;
+		goto err_free_devlink;
 
 	ret = pci_request_regions(pdev, KVASER_PCIEFD_DRV_NAME);
 	if (ret)
@@ -1830,6 +1832,8 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_irq;
 
+	devlink_register(devlink);
+
 	return 0;
 
 err_free_irq:
@@ -1853,6 +1857,9 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 err_disable_pci:
 	pci_disable_device(pdev);
 
+err_free_devlink:
+	devlink_free(devlink);
+
 	return ret;
 }
 
@@ -1876,6 +1883,8 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
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


