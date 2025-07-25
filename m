Return-Path: <linux-can+bounces-4131-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BA1B11EA9
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D801632A5
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0572ED169;
	Fri, 25 Jul 2025 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="iP6ru8DF"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2103.outbound.protection.outlook.com [40.107.247.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C82EBB9E;
	Fri, 25 Jul 2025 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446781; cv=fail; b=Xym3Nas0W3dl1/N02gx//Z89Vk/Pl499LetOIXCg2cVyyg9cfPHouL6yBONNleaBhz5IpoPhYBnnbNNTDx44OBnrQGWjPLuw4chDwQD12jQjeVidn8Yt2AQ82K4BmFdoINsCQPCnx5uWHz+RviRflvYLfHvz4lQ/S113EVKkmME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446781; c=relaxed/simple;
	bh=LJmW56wvD3Cn9U4n3rJdWVfuMZxrMH5Xs6VxpwiSnbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UyXLbtwKbJXX3ZZhvOYyaELSwQwy2aDBgJgcFUtLus6ylAabw23kdjcjp/e1DQFbkIbluvfjRR7RpYqTEyTz5lRdJid0f8GQvBt3qLG4dAwfxkC4G5BehBH+8AkJVLQI62cZFaoDbuQvWQydmISkFEHfqOpgcxX+3I7x8tLGur4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=iP6ru8DF; arc=fail smtp.client-ip=40.107.247.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4izgLnR96C916V8Jl3lvpYI8a6vkftyxuFV1jKukiENPoG2dEZtLcQKDzq4sxG64j7C+c0/sJhirUZ+mzBZ3uJwGL4Gds1sPNQ3VYXSHhjWOujjbP7yumQxAD/AVUKNfxYCCMdWOIMnzZ0pFitj1cR2/D0SaSxY9p1H8b7+gSBjiZXHBpegBQhouA+4XUiK0/3bmuxiGhPogm3JxXag+ATdvSurpzUVoQC4PruBAc+OoPCSKyNcLxMhvVhIZ4YI56d/7J2ruIqJwhOLH84lToBMtYG50PrQdVizvAubQia/oDkzLusdzklt8MXPlcdmjBWy8Lb/rBzsU1XYYaO2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CopFkBhoSMI1ITojoPRwCnOrwmuzw5haaK8M/IY/Z0A=;
 b=N5JsTjUF6B+A+U8yrjBzclMp1KHs9QI16M8Z5dWY/lF1JRzJ/hqdo09C1ikfnmG08a5S5pNbf1lw7YM8aR4cm5sF0lkOeciG74y/QH8UzmsrbraQ3kc3GreddoC/Pj3vbX2PAtSUxIUEfxR7VhbLa7JfP5pMi7M+wDc/lL/6bXXujsKBx6623DWweGvW9y/sz+82zWz71I0Medc4KHIbFusTS8fXChfFCP7i8QxHoXXhwFlVpC2VFNbSxcWi72oZ7pWM5PhyNFOFjCX3NO92AB4J/Fs42Z2VuCywthUlldVc7AfBUq7Lam/ZgnXGkV8P2Gho7T0e92/JieZPVEMgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CopFkBhoSMI1ITojoPRwCnOrwmuzw5haaK8M/IY/Z0A=;
 b=iP6ru8DFh0gpI2L+hHwvGwi3npBoLH/Pm29FkMFO5qeLvnNFs9Ao1XAwQzKpZ3RCV2rctRW/lc+MKpvAhGc1hCW1n7FIzMnij79ZduspVFp4ErsSGs0trmqvmRLcSSoepK+bOD+rEwX7ys0PPNVYCVI7yFJ3+NP+xSUzMuU26ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by PAXP193MB1376.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 12:32:49 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:32:49 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 07/10] can: kvaser_pciefd: Add devlink support
Date: Fri, 25 Jul 2025 14:32:27 +0200
Message-ID: <20250725123230.8-8-extja@kvaser.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725123230.8-1-extja@kvaser.com>
References: <20250725123230.8-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0077.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::20) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|PAXP193MB1376:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c995fb-84e9-4ca9-e3c6-08ddcb775d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AcN2RL0Sl8i3DOFW9KYxb2K2LGi7500gTHwGTc8EfCnk3RZubyJNXNZKwZlE?=
 =?us-ascii?Q?l/sbM/n0Ckz5BgbNsUnp/3sUyjHpcEPM+jbN9gTTMzguWDZs68nC2TMkamkK?=
 =?us-ascii?Q?o0U+akAwm9qKu40KQIen7gM5eaQ8TOlbe+wWl2qBLlde5mbQjf+6H2O+j0z2?=
 =?us-ascii?Q?hBnfv+Q9D7LRaYWSePhm8ziViU8zptK4y/ZHG+dnpdBqhlEzDyKb+kcx417M?=
 =?us-ascii?Q?EmwYG8fmnZBW/ltcyXyrJGvumnGUNVzIH1tmCzn75qXu6kmRcU8A5iI6lJOI?=
 =?us-ascii?Q?HKolV498Rql9tZjq+/5tSRXh5UDngekER5bhjIw3Qbdq7a9Sg2WoqrhnKiMM?=
 =?us-ascii?Q?7qAQ2OKOL5OWezT9lQpzUT8g5Vg+C7lTWKi5P9irjdHSKHV9NYQgC3aotWH/?=
 =?us-ascii?Q?ZBx6Czj97DsS9o25oXr9Fhfa8upgJjF/pPt67YbGNcQVhbrKTWm01iUYSAmI?=
 =?us-ascii?Q?A+1m7b78X7lKZHXkfooQ3TmRz9pF1ME414Kb9Cg//Elp0lG9FkQafaV1V5y2?=
 =?us-ascii?Q?WowllZOLE/AWNtEW8n6Utq/wU/pxVSuk1ceo2e7hWj4b5m2RhvWVbmajSV+w?=
 =?us-ascii?Q?Dpr63u1ZZGdjBjgMFTJUdtnUmyeYnxWFKCS4MoAJtyLta6E5EiBPFDpxyDQn?=
 =?us-ascii?Q?e/OteW93rKd+2IaAr8tHX6ryRN97+Ey0gg8zipxmkYlulvPlbdAirvQIu1/O?=
 =?us-ascii?Q?tvYtVg7ZynIVZtnPBtjlwM8YnvRGnL2FLLcu0cSy7iDtjSIEKd9t0lmk0rcU?=
 =?us-ascii?Q?Oiyo/HCVxJpMXzQcRV4uzeM7vGJHKFzkqnwDht0MKd7bWrP6IY/vyh0Jg43W?=
 =?us-ascii?Q?FiaMOU25eCS/Zf7ZckSDwu8f3NL468+hzqcZiJA1q2ix9o/gTtkUTGlbGuQT?=
 =?us-ascii?Q?no2ObItVdZDV4HczwXJSjOnq+EWSb/nzMRooIa0i+F6IdETSREoZw1TL86e/?=
 =?us-ascii?Q?gjO+2gmmdhgoSz/CsRazrX6Okp0eqsBc+Prj5U/YgGy9uwOg1OxTlmkVnx6c?=
 =?us-ascii?Q?DhkZW/COng9aoDGR5eNXqVO06FP4YliBUzthAxT8SmfgCGE3xeYqbH4PW8Yu?=
 =?us-ascii?Q?gVDqmhFuScDZTOYBOpn2wLuIPOJlnNC8HX4VhTpkaFms0BFPWmwFFirSoL2s?=
 =?us-ascii?Q?jy1wEKM18BE89lh9s5I/dPJHGxfCFascdmpq4s5x1cLFYCBfPiPGyTt65Tnq?=
 =?us-ascii?Q?rG3Kvl93cs9wijPD+AI7tUr/kvITQzAfheH1fWIciaWz6hxNGMljTRgf0dmM?=
 =?us-ascii?Q?iinDoqIORLcowfS5SYlEfG1K43OgiE5SgVMfx2JbG+RqOWtl4vj+fws7/JDG?=
 =?us-ascii?Q?66rKaTXLW1AGiXe4SmtAuVa+JZYOekF0rr1oJ2KmwMdz7acvV8b9cquNjKkY?=
 =?us-ascii?Q?OvBQ06o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AekxZ0xx1XTL5FKrTalt2wApGPtB4oKYJnGWY4J/nfbpPJFpIjVgB34YC+1x?=
 =?us-ascii?Q?z2I4MBsb6HIEzGmVWHAxgJRWCiWTyGblIUdPc2f4I7GFA/8kyBnAFxm9Of5k?=
 =?us-ascii?Q?RuIJEH+cDUzBh7Wlp6Y/uFyW+Qq1xTMhl9wF21fxBbS0ysUGW1WFYdEdS8v7?=
 =?us-ascii?Q?yG+/Hs7TaNwyno6Qt5Ydy9jbEye3gCbZHtCnY8b7IAB22XSow0p+AtKDgBRO?=
 =?us-ascii?Q?HI7onXmUvrcexMYTAznLubw/OCqCCREZVuHpG9SHENSPJLkuH4KzA5TlO1Dj?=
 =?us-ascii?Q?SIN2Yhf4gWIVUi6bac5eP5s7Y8PC3irLUkdoMMclxlTNPV1EzJo09HcpUzkw?=
 =?us-ascii?Q?MYYOuFK15qw2+6LZT9SOiibqdDe9mghAUPpZwmzXkTuzDNUXACme20V8+Zml?=
 =?us-ascii?Q?iH4LG+hJhcOPpA4SQIqaTf5yo0jw+osm/Tf1e1nIXS9uylQa5geCiXWlfIN0?=
 =?us-ascii?Q?83B9S3G6xgxEmRcot3S19h4Ik0LgzyqHdxxadAtIq1YB2lPHFW5+e46DLUQZ?=
 =?us-ascii?Q?NAIjslp184CrNqxv0YeAMX9KqFdBpcwOiyvIMPDXVw35ELsq8rfxkgxKgp1v?=
 =?us-ascii?Q?PVJTUxkDLchbxvwsiFg2S4MwKADIJIKY1QCrCBPJwy47HSSSZdDlJjKZDl+9?=
 =?us-ascii?Q?HU4VlZE3PGwDBtRu1zJeQa7WvSYBf6MuBoYWzDrDs9oV4RzDv+ZtXTrugdpl?=
 =?us-ascii?Q?Rui5AUw/Yhmxz1X2BxUteaRO482wqC3kOgPEaTkOJ4BWuJ26KA7o4q3kxxMO?=
 =?us-ascii?Q?ipdgV5OQuAY60ficlPSHGcEC9FWf6FylvhI/YaacK+NU4C/wYO6oiqh22J2B?=
 =?us-ascii?Q?hRDcOJxGPy2FKuy0ojUDZeaZ4sM47XkWtGbwPLHPtCzwcVK4+553PlDFPSE3?=
 =?us-ascii?Q?Q94n27Te9JHX+L7Mzy06X51/rcFVR2ANZwCs+LqXv1scIWRJ2YvYTuyYtR9F?=
 =?us-ascii?Q?wc4lw6F8gEd7Ogq4v01l2Io5So+r05DJszR2+J/vCFkDCwZWEVhNYwbJfCC5?=
 =?us-ascii?Q?vyx0G/fVJQhVsDF7xlbzbgAqklurmNgBp5wgaCDSKaad0b6Zmuonex5P43YG?=
 =?us-ascii?Q?jeuGddIYJ8l+bXpE0i+z6aQ21cPM2AB5DeL40H86rRCYpTkcLQr64+1a01X4?=
 =?us-ascii?Q?Li03zxsUddSdets0Q6bZ7WQsY6MSDqTuLtXFf3T7N/G84zfu6FyivnZfjOPw?=
 =?us-ascii?Q?mZFd9fFVMNgkpqkN+GUpo2JWEsGQWYYPdTzqXASe3yOTZ/xZLlKEVsOUjEpk?=
 =?us-ascii?Q?x9XdzP3iOMK9R700FY7rkQURNzDCXQxudUKPKlJuZsXDTYBobn87QV614L3m?=
 =?us-ascii?Q?sY1RIzXLo39fFlkakuRInJaaf7GisXS/ybLXzcwT+YsIFQ2Ad2Gsmfi39RtI?=
 =?us-ascii?Q?r914gYxL805ntGdrWBhaPOCwevjTofzKRVRKO/1edTdehMzqOEO5vyxMm9AO?=
 =?us-ascii?Q?sDo7bev6EOp6KExrl8UHa4KNb0EBymsO4mJPdQtecMJww/kd2G5vfQkjhhqA?=
 =?us-ascii?Q?NQzsEONOhfzu1HeQ9RJqfMHv9ul+h01XGxU3SdTqTYyd0hq6xqkbKM1kOZIL?=
 =?us-ascii?Q?2wLYn7h/UEL1m/pDg1FXHIisG3UiEWU1dJNEsUV8GQ3jz53I9qfBc7EKRiZA?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c995fb-84e9-4ca9-e3c6-08ddcb775d9a
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:32:49.0822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ec8moxzutxsqXMGX9VcPqsH4iXkmyAV/bPbA33W0zvydSP64p/uMhXdPE9pzKQXpQ71NJjN6m8OuH0wSanaOqUA6hxzx3nMYeMlb1aer07w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1376

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

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v4:
  - Include kvaser_picefd.h to avoid transient Sparse warning reported by
    Simon Horman [2]
  - Add tag Reviewed-by Vincent Mailhol

Changes in v2:
  - Add two space indentation to terminal output.
    Suggested by Vincent Mailhol [1]

[1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m31ee4aad13ee29d5559b56fdce842609ae4f67c5
[2] https://lore.kernel.org/linux-can/20250725-furry-precise-jerboa-d9e29d-mkl@pengutronix.de/T/#mbdd00e79c5765136b0a91cf38f0814a46c50a09b

 drivers/net/can/Kconfig                           |  1 +
 drivers/net/can/kvaser_pciefd/Makefile            |  2 +-
 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h     |  2 ++
 .../net/can/kvaser_pciefd/kvaser_pciefd_core.c    | 15 ++++++++++++---
 .../net/can/kvaser_pciefd/kvaser_pciefd_devlink.c | 11 +++++++++++
 5 files changed, 27 insertions(+), 4 deletions(-)
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
index 000000000000..7c2040ed53d7
--- /dev/null
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* kvaser_pciefd devlink functions
+ *
+ * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
+ */
+#include "kvaser_pciefd.h"
+
+#include <net/devlink.h>
+
+const struct devlink_ops kvaser_pciefd_devlink_ops = {
+};
-- 
2.49.0


