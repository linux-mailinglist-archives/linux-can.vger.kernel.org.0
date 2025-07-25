Return-Path: <linux-can+bounces-4130-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33650B11EA8
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE22B5A48DB
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A662ED153;
	Fri, 25 Jul 2025 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="VuKyLN7P"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2105.outbound.protection.outlook.com [40.107.247.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA1F2ECE93;
	Fri, 25 Jul 2025 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446780; cv=fail; b=POLZ8Oh7fyvF/rDF4JN8M4zOkQmKXYVHglD8LXMB5s6nRCXBDhyivp3C5s78fIJaxK5Wox/xVON333ClVTq8xs6kuYPAUMlMXhIkJG6g4bRZKt9tMFdt+h/dWfUpzCHfd9uwwbDqg/YOM97s+bWB9vrGqNnJ8ohfolSsyN18OOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446780; c=relaxed/simple;
	bh=iTlNWGN1t9HAWeCLNfvOjCZFjSqI0pMdlMfuIRkFOEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fyjY5nvDwDpGBBs0SYpBIdnSXs+dpLAz+TPgDiQCY6GBizDeBnnPtXwEyG1Sd1EeU0/hUWA5BbGcq/YwLZ37rnbPvdDBIYRtlv0UyA9RzksvLFPqlx6BH2xphoz9mOi8QI/dZfCAa0o1YEoX71ZI7izPI3Fs/TW4tCZq1BVmv/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=VuKyLN7P; arc=fail smtp.client-ip=40.107.247.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCE0jwO5+MGFezGKsuiB/MEzUGHJKWL7o+qdabjJdI/QFG3HVJznPil/KX6gEJeci7BK6j5i5zksHVjh+62Hhnq2TqciU8adFiWsHIW4CWlUoGq6P3i5kOWoYtENm0DxnInmQAsP3u4AYyZRHINGiRQXI6dw6ybEd70ftZnAeCOO9z7i11vwXnyshptC5wqUCQQpsvlnW712bjAa3fMA11P/uflE+Nh8t6u9oscz3S2AnphDm1CS/K7iH2JKaeFneP9zam2DAp6UU5vc+CLGQi02r5T2aEBI5yqyhrujyPo3eS8X2ygPbodMV6cK1PxVrjfpl6ZVG9Ok2cJttrfpLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIpMELYptrMNKwGdX7KIEBSUdGfm9DuaSZRv7L6KRFQ=;
 b=G5ogEgF9ozyHOhL/Xs+moaeg4sfWmYesPHc8igqxLvoyKvCbVsRVkZUCYwnVpfeXWb3Ybt/sLNjdXDg80rbEDKfVfzyG/hZ2BTc+LUVKX4XtzsUnBOPj7qkDxAOwDa/nmIO9RYr7bGlo45IhSewnxKMTEKD+fF0hAXINeC0Uvh7TQ5X9hHsKVyPp7Vx/f6ZYBoXrbZUDR/i+pSaPqcshKom2aJrjjCHysiF8cO+ntyIYd3rByp1qPfNpjHME24BYtgIX9gMhFaNbDWCooo38MPEpT4h/LUeGIxVtYCEIugSJy9Pb1gk2IKEDcirCFVR+tkc6TSaCUuLEFlZzZ3YIoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIpMELYptrMNKwGdX7KIEBSUdGfm9DuaSZRv7L6KRFQ=;
 b=VuKyLN7P9WI4qadVVfQ4fS+jBQ/pGHTOK6Gl3vr9xoxuhEsBQLZxywxcmeoglOVGi9T5Sf9XDwFfFTs+Ek/Zuj/jg9999FNZL5iHN4h7cnWWYjsGvqyyofAydb6ZvmXusyqrtKXQ3q4cuuTZCXy6sQfj2lC19+YbofufjPMeT/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by PAXP193MB1376.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 12:32:48 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:32:48 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 06/10] can: kvaser_pciefd: Split driver into C-file and header-file.
Date: Fri, 25 Jul 2025 14:32:26 +0200
Message-ID: <20250725123230.8-7-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: dcc8e4cc-90e8-4023-0c55-08ddcb775d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?euDrFzKUqGo6J1CMpNOHNzWpVf3iBd/xJJ+jUvMlzkx6X5fOX9F615qm4csN?=
 =?us-ascii?Q?M3g3jMDZztKQSZeK4sERw8QKl+q462YPuFMHxLxCyK1mNDp2DI/cDaIaEaXn?=
 =?us-ascii?Q?Uy3YnX1w9fbuCdlSp3lHUCyEmFtzOX8qs2nzEQFXNWzomqD3pSmhLqW6qx4k?=
 =?us-ascii?Q?2y8KdAkTeNG6+sIpYEp53xBSnGwokdepwFe1uB4ZVaWLbfBdj/b2fql0kd9w?=
 =?us-ascii?Q?NSqxxtLNZmyQ4mxaoNiSwhMMeqhws8pT6m8dJsyN6o8RJtdBs179gXenM3cO?=
 =?us-ascii?Q?eXQPkHbvBK468V0NMUai0y+eZovnqRPEun5bLMW3B30wSMbWmxRupSrjio8i?=
 =?us-ascii?Q?fI+zUvNdEickvXOh702gy63Jsx3mSWY5VGjhrSDGrjWAPFN+xbsnsfq0qZpS?=
 =?us-ascii?Q?l58pQnlByDwf6Q+9itsikSc/xhRCTym8U/fpbdgChrBm3mnDnrjaBIDc3mMR?=
 =?us-ascii?Q?AOA6j5/eg4IBuY7iH/wxZ8tGKWA7EInkBbB/Sq/6oMU3AvgVVOpyVb/YmFEa?=
 =?us-ascii?Q?UH4D6Tpr/nU8SADYiir7LpQvnpYugTtstvlG8IhAWY7GHm56uTSwNcWOJVkt?=
 =?us-ascii?Q?bmxGI++5gsG0oJpefZYVoihb7vmyQaB5FsenpakzCH0MykWGoct++8IFm1mJ?=
 =?us-ascii?Q?MU5aR7PIroT/FDRddohKvyQJ/N9CTHz3JbWeosSMIVnw8jXPHHxHmUSwSdOt?=
 =?us-ascii?Q?TBzX3ENYXo8F3CNLT0qqKIx6q6i5mwV7IfnXLMx6O1g8F7FXXsbi/5HOAkOO?=
 =?us-ascii?Q?eAKwfnV7XEz9AL36Zr9zgP/3KB+aGG8D0oJb32NK8Jit2OjLCs2HbUL1X/Me?=
 =?us-ascii?Q?vgpgX/5skohzYlStf2BYIyUOJ6j5zmm9bZl1pW0QWjrWap/G1JziZjqGMweM?=
 =?us-ascii?Q?6RoXzrZhaWR5DJ6WmnkCo/dxyfo97ZgMgFslkLswkL02VckWGLFxqiA631Rn?=
 =?us-ascii?Q?HvauidPXZR12oQ2iMqMcyblJ/hN0YQKc9C7BpRSlovZvCFT+oH+C9SKtYEQK?=
 =?us-ascii?Q?0NM/DvpceICdUDzSVxCjBHuavHDKTMcWXeZ00+MqW9o/5yeXKfEc1jMUOdmT?=
 =?us-ascii?Q?ovJS6iEUd33D5Kk6DZrusMXggkMS+RiXFAhVvk52VUMxa6rDzwZziYOzrr1+?=
 =?us-ascii?Q?40uh2j2J1fd8rhjOm/ApBUPNcxm+cM4vB5+EEU5W0it02NXXgsrl20eNkWJQ?=
 =?us-ascii?Q?hvS4nR5SzlS1+i1VZ1Ces5ITOB3ylBAzgDHx9kibufc6NHOrEyfOlADnEPvZ?=
 =?us-ascii?Q?CAGgSD7ypP2O7sniJRMHJ11HVq1zj/D/RHd0ASkhigQHWf3E7dkH6MMET3gG?=
 =?us-ascii?Q?BwVZY+aBNg4phzGISFE+YOT6H3uYPHL3G0Ec261myuAMrXieDohCgA9O/QZo?=
 =?us-ascii?Q?qMUPAcn/EDrsrfyaxaIPfLqQdKrFml2yLs4Ze/dk6rTX/E8B2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AHIo9fG4wJ3OOEA8zpCHLhiOw21R8z8FhxjU0HL8mu5Ow1lUBokR2BGEbtwP?=
 =?us-ascii?Q?mQmQmtVjyj+0E4zrLv1LcIfNOkP7tPqA4USFXMFyX7AUoGHv/0/7J0KeGE6b?=
 =?us-ascii?Q?CJJS+ZzR0bsteJ7o9PsvPpA0UUAjFH/0yjp+fCO9/u2hinu7JPG3lDy3rMvo?=
 =?us-ascii?Q?NakZVVSoHeAfqqa4Uc/IGIn30RyNEarRDsi5z7erYCEoytUC1tjItbPtSeU2?=
 =?us-ascii?Q?vP5JzA06ZSbHU1F9fOhIP7AWQDTorWpA1IBmeSF0a6oDOodgjMX1D1ozL5aG?=
 =?us-ascii?Q?IwU88MAm+PXvl3b+PQjSP6Q/Ez7ILZ2UXcn67FwJYdz9sxjOJxQ1O93puaz/?=
 =?us-ascii?Q?0p3oxumFVsUW0erUWQF4nMFk/OppRCf6AJn3qcmKL799/mXUUnicYJ+tjjK0?=
 =?us-ascii?Q?v+sL3bMoR85MzKiTYjBnqgQVdqQhsfMx3xVdCCLh2q1FRcIl25K/47sKpR//?=
 =?us-ascii?Q?5ep9k7TQngSrcNNNteZlUr5maYR+PW/cgVIiF6mBLa6G+WgOEMX9LUZo5lU3?=
 =?us-ascii?Q?qOj4pXOzQVirhTIFq9/5raTjaFawQYTzaxtNbrwwnLNQd0nC9VpckJdyflWc?=
 =?us-ascii?Q?qyJwx7vJvRjQMAdUEH89okhMDaeUmNLCRWQh7DdcNyEGOZ7o8QKmAq6NYWeK?=
 =?us-ascii?Q?PWLqTwl+BraDpv0mJ0Y7UbXKfNkHTAlkn+29Ey5UWh4MqG5H75fc/oU26/Fp?=
 =?us-ascii?Q?6czEwGyPfoB+sspmza3z989PiMuJ1CV5rYf4yxKU+KCZYoZSVbxZL1CJ2LOb?=
 =?us-ascii?Q?iNwgBhtY2ap00Agjaae4KAdTvDaxu1rHTzEMpAoEr9RhU43NWLr9bxcid04v?=
 =?us-ascii?Q?wRkHZHDiH1gULl0/FnURUFkswFJed4CgMzG06EnPt8ih7hdIVJuKfWMYHNP0?=
 =?us-ascii?Q?xoi/B8EO4unGiGjQq7pYCPxhCIGZN0V7etO0DLX1Gh7EpFjfXQ55yuhMi+Mv?=
 =?us-ascii?Q?ybWs8i68z+AZUOUWfCC/dgUXU7UPEKbIu4Pd9PRAUa9bXLULIxIgbDZLNSkU?=
 =?us-ascii?Q?9GluzRalR205OdLdrr71DHpt4lX7jPGQ0nH9Kufe0J4Y7qTfoyszIs6BBPDp?=
 =?us-ascii?Q?LV2F7YHlLktaQGuuhkR7VbhMNXm4+FD9diyoir7if/+x0afw7o81637dle5A?=
 =?us-ascii?Q?71wLpoRnrHeZaTOW2ZR/zVO6xsu6mZSalzzut8KzoPBu3WhBWwg3E4G8fFKw?=
 =?us-ascii?Q?njVeycGbI3LoxpXKymJIHfVUxBwFYqoN579akUUoQvFDgEmMrEtxn3bNxKUG?=
 =?us-ascii?Q?8kXIgNOMBg27dQz9zJBoWPXcEzTmFd/S2j8F9nVf783ktGCXIe+DQX3mh9SS?=
 =?us-ascii?Q?YKqcVmS1hUPSMltHa2Rs94Kkk8hnku6Tn4Wj1VvGUmz+ShY2XCVQRm1cPtOi?=
 =?us-ascii?Q?xuijeH1ZzFA6wLwG0bH9tK/EY83xScTNLv1gtgRA8lGioWY6EXoYf2KwMlQI?=
 =?us-ascii?Q?BKhjFvCbKARiLykzcqLDLBADN6CSJ4ts0+DDl/9d5mCaUqOMIsCJb7IE3PMj?=
 =?us-ascii?Q?jQhwJsVZI13s+SqWF2QEzGGuQrVEpQqRA3td4yeX3yPQ/sD4YSIYURprDsgi?=
 =?us-ascii?Q?a6Ix2d15OqON776qHG0J5vQ1PBUMY7NJg8TTSGe5U/XaulDSXTqSNxLMfKWR?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc8e4cc-90e8-4023-0c55-08ddcb775d54
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:32:48.5182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74to/m9rMDMITq4+C/8ghFqrn52jq99LM1CbPXcWw212ugRSK4VDpM6Jwa1Ag6JbcVsgwtLszB2wUmrNsPm2TaylHBl9pUSMfcnlSYUa6+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1376

Split driver into C-file and header-file, to simplify future patches.
Move common definitions and declarations to a header file.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v4:
  - Add tag Reviewed-by Vincent Mailhol

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


