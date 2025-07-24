Return-Path: <linux-can+bounces-4077-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43405B100C2
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 08:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC2277B6418
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 06:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1762822E406;
	Thu, 24 Jul 2025 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="eQAwvKQ8"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2109.outbound.protection.outlook.com [40.107.22.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D751F5828;
	Thu, 24 Jul 2025 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339052; cv=fail; b=jSoQJX5yBUvIIKZoXfSUcLfGODvUK5dHjtiOF7YnqEt4T9xKzm27fkmvIrnqJ2m95vgMrc4KuNqx3GFDJVZSU/oXk93kj5BKXN8URgLsSgsyspj4xm/AVUvimCYW1UxKhYyJqP9pFTZv0+lLBGBW1eP1OfLhtjOm8NRQcCarHPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339052; c=relaxed/simple;
	bh=bExiyrErzx85G8DEJ2c/d3PoFtCOvypngPaaaZ4pSH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qblRR413J1QYl+xb8DPGOAVY32TKHbO2TfvYZ4OuazV8g7U161auQ1jv9ZoWJBmDqik1LBlfqw4Jwc0YTKkEHwAfCQzE4KBVtrlzrS85vmf05oAZ/yKZ5QJYA1GYJg5ziXN9kF6UH+hoQA2FmJ0bl4fNsURrzCfsgxPnUD/4+iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=eQAwvKQ8; arc=fail smtp.client-ip=40.107.22.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7f921YY0/fxV3TTdZ8gHm6rHdoDEOWLFeSWgXr9CfC9qP9TFRpWIeJXpcANwEamfBvovhzQN1YotSU6sOKJIQikANz1jB7ZOFUvQlgiGIFxyAUVKiQQwjoMxbisUKRRKnuaIK5CJ8/gZpweKkTWFlGLkceVPrFdDmCq3MANOeHifuLXjMNTsVV2WExJuinG3qMmsaCezurxTGFb3gW2gAdAVzEmfg/QRswAOiipOeuLENqqW18Fa/BFqR3wQ3JOOAC9pZBcREs2su66yi6smDmKcQzjjjHqxxZaTlpkgKMgg9dUK2TxDIXu8cJ4qI4fIi3SFDs/2nFmV+FLLPGOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyyXcwC4vv5jzxuV+qbeiAAFvG52cW8/XF4xWfaTZ2I=;
 b=vnMp0Nx98fZoSjWGSI/nxLfu3wNTmH6qKyxf0M8XHOuyCgA7bMHge3Xvq3+mj8VbXSu4jCjvNFUAR4gpzA0/3G+p7oAyQpv2weVPI7wo9ahBjPft3zeF2eBsSRmiQiHeOho3KFCFacuIs7HxwBXS3J1Y3SWNbqw9I78aLqoa0GiU7+k67ToxBQ1fy3YeWayN1FmvxDK13HP9vy2tK+GI9nD4WphqDnH/3CsdW0GUKcNrWhu/MIAGNeODWatZswMZEMAwsPNx0Qp0v8ytk8JHk9Qy8Wj72yUN5HIp8WFlDaSL9Q4wN5z5dm06B3psGDZdZZmWpPytNogvfM67vY6xhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyyXcwC4vv5jzxuV+qbeiAAFvG52cW8/XF4xWfaTZ2I=;
 b=eQAwvKQ8W2FWAmgh/NdjPZieJlenr5x92VJBd21Loo8U6ePalfBzo+GNm5XaGTq+60/W6qCXPdG8O6QO9Gr6SBUiOGWtft6vvKB6YFCHXpbh8YtO+AveRv8EoNYERQ1vOMPIATnQOcD2jcFV3YEzwVn5a9oW+QzQNBu71HHtKuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM0P193MB0562.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:163::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 06:37:19 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 06:37:19 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH v2 07/10] can: kvaser_pciefd: Add devlink support
Date: Thu, 24 Jul 2025 08:36:48 +0200
Message-ID: <20250724063651.8-8-extja@kvaser.com>
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
X-MS-Office365-Filtering-Correlation-Id: 86229110-e938-4171-c050-08ddca7c89be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MlWVwJbXqLy7HwnJmmF9MEgm1jqsqvnOlAFBM5gJmAagHzQoZw2NWOvbEVwk?=
 =?us-ascii?Q?J0A2iDTG2Ri+635lra/v/1s4K/OOp2s1akIsT6HaWh4rl1+tRK9A459qyUC7?=
 =?us-ascii?Q?jswCeFtLJa+smUzfH8G+5pfpB1WLtn+XLKBe2KIqMhMz5X+1cBekw4q4pEyK?=
 =?us-ascii?Q?Mgd43CtSO4Y8mn7P7+8I3Zas5Da/dDOk28DLX/WLFaMBrKA8ObFc4tj7CQSf?=
 =?us-ascii?Q?WQSZMuYoXtbRsDBcIYYcurfjfq3iT2dtGj5LGZD6EPmC9XjmNvc5g80HBJXc?=
 =?us-ascii?Q?dTWtGCtyApcCA6YPSL2/9SsysNaqQ6L5fLu5h/CS8kHPJjeGxnOtR60IOZYa?=
 =?us-ascii?Q?ShbgDCoKuSoJsl0M9Yzyn0EXm8olbcCn69r6nYLQ+q6e1WvfA8m0lHX/CX3J?=
 =?us-ascii?Q?i8xp2Pt1njXb2aP3Ri8p5W3GmWCh8/vBdlthOVi1CHi91D4s7orFaCVzV/2l?=
 =?us-ascii?Q?1IBo4P0cIA+INcfDs9bBBGObiqz3GHskJVfwVo3U7IVHON1LOw3m8e7Dxych?=
 =?us-ascii?Q?eqPg3sAD8WBQ2aRoycJlf2dqRXGCESBllPj3qEWabbiC5iRIIrCGOGqBZtwZ?=
 =?us-ascii?Q?4HmxhzIvSm80NuUPehiH4KiCojsDTBLrIga9Sl0AWR5D9bGs9SG0gtM4ek/I?=
 =?us-ascii?Q?cxlQerbFb//3/561DAUHBXKuD9yeGvThHAhfIDK1z3GBvI0ZmMr7yl/VN+8/?=
 =?us-ascii?Q?cNu0Fev/MdaQGhFU+VQdwp8K/k+uSBHCjULWZZgDkHXzKdTLVXYi/wBxyy1o?=
 =?us-ascii?Q?bjlJ1gEK9z3/igxpgFwPAmNGVqO3JCJ7zBclDUvhOubsdh5xKsA/sBSWQQWv?=
 =?us-ascii?Q?cA4vuhEPzGZEoyLF8KZkkKb7EhhPykG4aSxPrkgWn9Wye+pxu46/I5HQaWCT?=
 =?us-ascii?Q?G8pNXtLbHin8y52STPAb8pT6YyTqeVeLHBx3+H7mYD78SkJnZzElJKQft+aW?=
 =?us-ascii?Q?pkfG1M59ZI2t9s8yfEyGGtMDr6UOd72jNcEdRySDfY1y6g9xoT0ym+r3SOqb?=
 =?us-ascii?Q?Bqd7rF9BQN2Ehfnwf/coAjK8c7n/mAn6LIleWh98/1DoTFWLGdy6SNo8jpVn?=
 =?us-ascii?Q?ospz6M2CFzJH5Y5yHB0BWh3d+DDr0JXeMaeVhX99jfqqSv3fmSJB3l7x3/GS?=
 =?us-ascii?Q?sLr/n9Vqwrf+LsV9gU/3cAPuXcnxMWK/gjQzrU7C0LIDldgx/KuvGxMKt6xj?=
 =?us-ascii?Q?eIAkN+kmSjSS31cV0Tqg2J0W1KHZ+Nub4LZ+zuErX0ER9nWdhzZ8I8vo0oBj?=
 =?us-ascii?Q?gPTrINU9qK0f0vR/eWbJFlBzOpv6DSg1pciKch+yO6kwPJG/OCkDTOCtaJ4R?=
 =?us-ascii?Q?uo0TgAo+gWDFwy9Phsd6qbJQfvp0mrskaib1DqsqPCQ8AgLnLM1X3ZAv6EGt?=
 =?us-ascii?Q?iW9fzNY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TqK0iLiVjqriVr0S6bRtiEl0UhbSWcFnIoHfB/NZe/ErP8iQ/8s/nEEeTQpD?=
 =?us-ascii?Q?GbPMJleu3gR6vyJvA0vRKzUFRGKk1TBocH2/oJ2mhjic42iQmOdq9IxdpqSY?=
 =?us-ascii?Q?CJSxncXfqhjVoq1FkTBbV3I4I6YUNKl4Rp8eCDeoExE98+yp7iX1PO4t0qTI?=
 =?us-ascii?Q?5OJ5Ji2HWypFC/y2//9EXJpP6EWeMqAGtHKzGxRw/NeiL+0NPcyzrac181eJ?=
 =?us-ascii?Q?P0Pz8ycv6Ya4yccS04Fbvt2725yB/dq1zJ9tIV3MzFsAPV4CRyNh0C0+SdFM?=
 =?us-ascii?Q?wTukf40AFGHXopTwUc4CY6/n9frhpLOBTaSgQRevQVxSdijrFjIycaAuBScf?=
 =?us-ascii?Q?Krp/lBDDIRgQ8vYm7QvGc1CkAhcJNoLkR2Lai0M8xxqM9ltvDBDD3Y++rMjb?=
 =?us-ascii?Q?WxXsIK55u1tX0UsinfowsoWoZzOjkqQWMTG8MCu7ux/luWKDfvdhzEx+3n+t?=
 =?us-ascii?Q?+Jsv0TCSKA2In2YVV1r2GnEG+6NJdOX2cMZ5riJHOFO+9JacNXz1IlZBr7TR?=
 =?us-ascii?Q?cVyce4XwnerDk5dsL5U0HArVeSAJZtsAf4OFv0FmcDxVeH7PIxjSIpBvuqzc?=
 =?us-ascii?Q?GH25nYhbhkhi4ohoPkIfTdcIS4FRiPKm7/N4wVc8FDhi6HHEDODLXWTFJH5b?=
 =?us-ascii?Q?3cKuL8ORVF5487/tchLqVmqLFYCqS9DHsritvG+Ko59Si3OoSVtIl4b1H+hh?=
 =?us-ascii?Q?22MIW2jUFSoU4NT55OTjUuum35r4CHNaX4tuU6UZzFNMuWQMEPObq4MysLqI?=
 =?us-ascii?Q?ChS4XA8FuBxXNyGlWdIrds5YeVd6PIMXSU99HXfaSBkRKmSYXGJ7KrHHC76X?=
 =?us-ascii?Q?CBP2/1aNQlxvmMK9WSsyXxw7zvVvgpk6J1QDf9k7iE4csEW9HV5xGdrKL2u+?=
 =?us-ascii?Q?fnRqzJQXadmrYpXq7ysCC7r7nMN5OiqB+4ToLSwx4AZ0KslMGzlJSE6q5cqb?=
 =?us-ascii?Q?T6o38qDHeRkNUjn19w3l6lKAPrhZrAYeecRmAcERZ7suUg2YnEZGZgWql+J1?=
 =?us-ascii?Q?9AOvTzCOXNosrnzVrpQD0FR8cutIKdkwnaBfw2GwQTjLUfQWbl60760mPXng?=
 =?us-ascii?Q?zUy9LXfS92JopvUhn+Cd3K5symWzis80MxAGsOCaq42wsFzQdc8876d2U+YF?=
 =?us-ascii?Q?hMJIuD8x7E6TUQGntMdRBZTNknJpnXQs5aIV7JwM5W+sZ0ftsKN9nS5q4SP3?=
 =?us-ascii?Q?ZBqFLEjVfdcAFNNBorZJM+a3MoFms7jlrr3jXm7A3DWO/CwkHroA9llna21u?=
 =?us-ascii?Q?H0+BdGtwMXrEausOhBEYUt9jV4ExsqH0pT94Hx2ssAOnoRdMCCdpJ+Csnjta?=
 =?us-ascii?Q?sLzAB4G4le8IINaEvjEokhaNL0HU7E8wN3xYXDYabBNnM1QiEFB1NOJ8y6sS?=
 =?us-ascii?Q?SLf2pB43TU17GYBfHtDjD2TFOThL+LsrDRRB/0Wai6SBPmKem+ADQr+UqE/x?=
 =?us-ascii?Q?IAGUElOIfx38gd5aggVz17DGQu5jW5CM+rsZP8mCyC2cO1cMHy+d3K6PI9hc?=
 =?us-ascii?Q?0JkiR1Ex3sIB1hFhp3BMLaV1idGBf5PSThYRbniCz4lenrtOrpafIAO3uwEc?=
 =?us-ascii?Q?CAa9YGJhxvWNJueA4tV2a75AP/aHKi6Sx5zBTOZNq7nYI9cVWYdHi18zSG34?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86229110-e938-4171-c050-08ddca7c89be
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:37:19.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WFmOd1cLLeQHwGCtOcKrQrnXgSFc7w6tAIUYZPKKwa6AGh9ttV3WyonuDwObJTextv4zRs2hFoExjhEE6WbzQnatyefxBmuipssJNE2wMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0562

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
  - Add two space indentation to terminal output. Suggested by Vincent Mailhol [1]

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


