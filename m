Return-Path: <linux-can+bounces-934-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A9291E4A2
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282DC280FD7
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D764716D4E0;
	Mon,  1 Jul 2024 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="U88spNq5"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2125.outbound.protection.outlook.com [40.107.20.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C816D4DE
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849018; cv=fail; b=CoB+hK0BkSpbcVfOh63BnxiG42OipDn0sPlcpoeb/DEwPHAhEON6r4VNs4UZL7CnPyu/RPJKbwvnRWDQ3NX7pMW2tcwEeZnj4qhN/1Jl+RyOJPgEO7vJ0bqiedP2b3ktQFYrnWEuwVu1TgYzwYiKkK2fZx8iI2ddUi/mEqAzwzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849018; c=relaxed/simple;
	bh=W/D6wjrdcyaCcFsF+349oPmGxsqUxxI/N3npMDkgr8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tQIi8yKN04GXRa+l2HWBx9NUaXBchgRILpLAhWuACWS3WRduRDrkzWAUuB6QLaImPwT/hcBe3Fly6pMgqZZ7fzRLtgYW01eFSfW7lQ2zVlpZ7Bkc1/g/tIU7EGxkT3Tso+9qayktnBhUpIjHfdp3o2DF06OZBptTz7cnfg77/fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=U88spNq5; arc=fail smtp.client-ip=40.107.20.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/UVfd4v7EqASLFpGSBf6wbqUNiImSX/8eWBkZCJi9UouDgAOEtteui6lbeGN5Z10Ojq+mGbZiFKoX3OsDpKuYhYEAknSfNFgBLw5JfOTFGXy38y+T2fcq0kA6yjj3dbTYnkffnRxamXaHd/B0bazxSNGHjqvNOO0K1QXQoCQ7SpFbXNLCvI3hdRiVS78b9cDItYGOmcKrD2oxntYe0FEC5TIvCfFS/bjyFTPVwyvsQKSJPc3qS6n2JHY7tBBcN3BKidQFDduG72+cWTkXJNiZwTlyVLfN301SkdQ1nZoMj5fFk1ozK9OOPoNcGxblx823MUCuVl5wHwnjPloeFeUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/isADPdwgtpiDg68F5Mjq8nkrQN1BPrDOG75cqRUa8=;
 b=Ay/xSyrEKue2F6r3txMI2Ec8V+Tw8E8+roYxoQuqTMILyC3cVWRmKsrtKxY+Lk6hYCcGTzZJyz5HBBwrH2HW8qpn0GeZwL71Osh9Iscvg4+SLqWdOWcqvw5gha6N397tOVz3wWe8YCN1+uAFE7Gtwe9Chrdus7M9+NW5JpHnZThk9YEKJ2S7M06xO4nuiqCT+vzIRM54EciPRLXMAiCTc8+kqbkeLPHRqZRN5Mo9pVWLK5Be1vujzv6ZAodG3fwQ06dO5HReEncVVkip/578QQEoqK0f+CFjmDsc/8WAcp/fjGNt8UEgdoc/PRBeeNA+3Onfl0199XFP/+HGt4uvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/isADPdwgtpiDg68F5Mjq8nkrQN1BPrDOG75cqRUa8=;
 b=U88spNq58Rub5H4IkM/divm7MAFwdvG/CpeyBf8SEfgl5lVQWAKYlPlKMPzGRPz7nB75bR/zSASHtS1/8gb14zvL7kPlI4FbxZaonOt7dozigRCjwjfNf9yxdT6CM2i3h+B4mtEw/Szm5Ygch0qPIjPZsTrgR04LzoWwgn0BS94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DB8P193MB0519.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:50:06 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::ecab:d3fc:ce8e:ab6%6]) with mapi id 15.20.7698.025; Mon, 1 Jul 2024
 15:50:06 +0000
From: Jimmy Assarsson <extja@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v2 14/15] can: kvaser_usb: Remove struct variables kvaser_usb_{ethtool,netdev}_ops
Date: Mon,  1 Jul 2024 17:49:35 +0200
Message-ID: <20240701154936.92633-15-extja@kvaser.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701154936.92633-1-extja@kvaser.com>
References: <20240701154936.92633-1-extja@kvaser.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DB8P193MB0519:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d60099-db58-412c-1baa-08dc99e57a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QFKaxnHuscMWoaZ67kZKgJMIYGsKcD6rbLwlWUKhnpH810rN9ITbK8zQtBOa?=
 =?us-ascii?Q?Vr5gDTt1M8uAzliuRrVDJMTtfn9mPWtIo4CcK1x6VY/ksduo5wGHRq/E2Kov?=
 =?us-ascii?Q?jr6GT6cc5WGiwC6BsCgNFh2wIT/FZTd3XXZ9VfqyqrQW9/pX5RfPSLTjiCUz?=
 =?us-ascii?Q?PjuKJMDycd/c1acuj+XvbNuJjua+2dCTKJhB0KiyRK+xzlcKLp+k2YY3q4JW?=
 =?us-ascii?Q?evg6oO8KNuLwt1NKf2NV6yIl352U6sD/PuTuvGkifVlW9oV4LI7LKeWvDEej?=
 =?us-ascii?Q?K/M5ZcpJ83nUpiSsEFNBLIrFFBEdexQtUaGMW1FZUYDmWZWY3mzGTjseAayt?=
 =?us-ascii?Q?c8LmnbjRJt45K9amIG8PSKnC2SPy2ZOe/mXvuWnqc0GkcZhtBA1TLeR6zSsI?=
 =?us-ascii?Q?H/He9gUcCw14HALmAOKqPXj5Dtlz5D+yDOHjEH28voRc1akn3m2z0Kz0gGIi?=
 =?us-ascii?Q?j4TACFPMK6UuFxztU4B14IxH1KngY7uYp/FOam2KGASYlMFF+bB/iN+/TuqT?=
 =?us-ascii?Q?CKhyrvLqLjgKojuqbFc1lxFmrXXtFaLsamueUto3FA/C0NNdV198beti6XQw?=
 =?us-ascii?Q?+S9xYquuDm0IvoI9nSPfVISFrbkjxVX5vyaB2By2mOgCAu480+CYJ/uKek/C?=
 =?us-ascii?Q?MRRzpPIiNfYYBEblL7yB5sDjLIej5IilmtOi8Kwpc2KzcABr5mqI/LXiU/zw?=
 =?us-ascii?Q?P9Hg5ZQD03WPHMm1EoAXrDKh/o3tYbQ01VyZbkujtfqZR592HKNU53cOGTgt?=
 =?us-ascii?Q?xIkUtdXBiUBWCMIjM6rBuqXntJH4BKPYgjG3mFDuOsL8xxJ9J4CnyJ0XuB35?=
 =?us-ascii?Q?jsuq+msxzQpEZaGHam3r1pUw/rtLd9j8PZo0IrSGmgiHQlxyyrEDsnMcSlxX?=
 =?us-ascii?Q?k6P0UwctsO3fnl3Ep3n6W7vK378kxzW/cpWvbVUvtbY9W9w217hEZcA5Xw1K?=
 =?us-ascii?Q?LYle+AmWq6w+C7ArKeIKjX3yrBJhLAagSrPeq4qMFnorBGA7UGlJzFcWjmeM?=
 =?us-ascii?Q?GKxyBslO0koMWK+cXvqeixaIIFCSaDipgyx90AeJ+g6DGOiBW1EDCuD9/r4g?=
 =?us-ascii?Q?jxf57yimYl6H8apa9PxTUj+DscT8SH4b+DwroHqraSpAOAsW6PJaDvhIdv5B?=
 =?us-ascii?Q?syD+eADIB7coINQJI7MkSI9Ieq9UKSYcegKeRMzZxl1/VmEo3lJq9ej80zpW?=
 =?us-ascii?Q?uBBWh/SnroHojKVl41KZkV03DNDV3zRf1AUc5IbOIlRoqpDtN3ycymVX3S1U?=
 =?us-ascii?Q?Wz1nORzKt59WbGlZG7dnNW1bhL0ujE6ny1tzqINrvDyHfTf42RJ0iIvVCzIJ?=
 =?us-ascii?Q?PlmW8dYwGfvyO+Iu5SL6p/juFE02em+6POc7qpjBvMoOXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4PsNiOuKczY5Z6w1U2YGhLi/2Z+J09mOkCBBEErcib1lIhUm5Lpcy7TnXd1I?=
 =?us-ascii?Q?v2t9pnPlJRBsSAUI63tLmIjKlCUtd4kibaNJQWT5nd6V2yn1uFnstIRdeRQB?=
 =?us-ascii?Q?2U9Ho1ai5Kot9hD0h3nldk7s3R4D79olyyxQwshex98k/WxjmrAS7EpEX4mM?=
 =?us-ascii?Q?Gz1joc7MRvxR3lsKBmwNvksmswR/Uju395SsVOmODitGzuoy592FSHmP6oj4?=
 =?us-ascii?Q?Ph2rFbo/TabkYnz4NIEBCq4ChYhBLYwFhm7P8CYpUjuEkMPgIq3clPdFgxYp?=
 =?us-ascii?Q?MBR77aiuBnG8CBMfbzvJY4qeBCEJZxQ4mW7AyHolnAJysBJ1sQyNTuo0vJ59?=
 =?us-ascii?Q?nJYUeoTGldChXkgejmOPY66wWZ2pfY+HXXukSMA9BvXTLImjvae+KFoE9U8v?=
 =?us-ascii?Q?CB6O6y4TptREvVox1L7jslGThgrEQHJ4/pA5tqpL2/Jl6Iln6h1rz1iAoBSE?=
 =?us-ascii?Q?9DGcXltpB3N31Tpx29sU6jZm1qR9E+YtBht1kMM/fq2KPPtsZjNounp/g34C?=
 =?us-ascii?Q?aFUYcE/vDhpz9WNyym7NL/fV40atXI81v5GDa6K6SN3M+oxobGr+JyzIChIp?=
 =?us-ascii?Q?dScDCSFM/whMNXp2yh7i3cETeh6kC2IidznOV4tI/Uh2yiRLsovS9sfmmFxI?=
 =?us-ascii?Q?dyO99zgtCyqYilT4SwRs5/u/2CvjoVDqgFLml/j3ZVwfsIqNcqTYHcj/a7l6?=
 =?us-ascii?Q?yXatySG0w7d8jCBauXhmi/LeJ1BdYDdR4Iq44/npoH4NZnqSIF0iqU2sP2KA?=
 =?us-ascii?Q?KAUxnqwbH1/pVh9iaKPe7nA9YXlz8MZ7q7xKz9mk0xeb3/Lh370rL+jmpuEj?=
 =?us-ascii?Q?6sBxRcUmWoALirUSsXodI839Y3Qh8D4cVnyKfwBuboVgUt1/C9/OZommp3tW?=
 =?us-ascii?Q?O3n+OZIQhEl5DoZaSFcTk2UoTRULyqg8IKo/Jh3p0V6NrUsxtYNB2xWUyYzd?=
 =?us-ascii?Q?FJSm2GtyXQhz4KWSe0+alpsz2d4yEXIa+X+K1wsQOKxieh365pEv0ZOLOxrw?=
 =?us-ascii?Q?5tPybZoTPSdzJf4yr32jsg0vBRxXzpHEqMjoFvxlW5QXHOS4MJI3DxQB0GfY?=
 =?us-ascii?Q?803tsxBc6gpPUCb5oVCLgIt2ojDIAoBsuRGjBFqs+wzGxca46AUdOtXydqqj?=
 =?us-ascii?Q?sRSJN9op2ngQB2D3smNOPyEg4jscS1AHeSzjfUKz+Yd6iIdXXPPkPvUcmwua?=
 =?us-ascii?Q?5EkXgb/oiikcSj97U7FjfyiyPf0Bv1c+3zwBoPoRFc7+WKKkjpuAbjkTI2xF?=
 =?us-ascii?Q?9ZPqWwUqrHEWx6/4bqCNMNzBBkEq4PCPwgCJwZDJYG2/4jwkBPy5r/XN5ZJS?=
 =?us-ascii?Q?bZS+D+ogBEHM/jeCShAAZArV7fL28jCRPXZlIiW2X2onHPpO0UZjhvXkNeiq?=
 =?us-ascii?Q?NM6bgvBm7YOce5XChPCBC+UQKUSw5T++kicLbYJnBRDbORCx96UwJvOQ4iuJ?=
 =?us-ascii?Q?1cZQ+a74ey0ECs4n36uN2ahLnOUvg1MLEwyY2iqMbe5ncKVyw5bNwSFLFN4m?=
 =?us-ascii?Q?6h40FVxiTWzto3J8CZ41I3ndRrOrFd8daxf850RdWRSwnrS/rLefhxTRxqiQ?=
 =?us-ascii?Q?SSTZJIKJqVTkiMlThoMzGDuBAzTxu8uvpQ03BCqv?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d60099-db58-412c-1baa-08dc99e57a80
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:50:06.3127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFGWaO6KmVuEspxRF8fbKA0vsBfjvvrK+tBtWTQ42oQyJhQMCSQa7hQK5iESV0SN6knnOdDPmy7AtSU1MLOz1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0519

Remove no longer used struct variables, kvaser_usb_ethtool_ops and
kvaser_usb_netdev_ops.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - No changes

 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index a4f32d57173a..4b6c23121b5d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -753,13 +753,6 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
-static const struct net_device_ops kvaser_usb_netdev_ops = {
-	.ndo_open = kvaser_usb_open,
-	.ndo_stop = kvaser_usb_close,
-	.ndo_start_xmit = kvaser_usb_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
-};
-
 static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
 	.ndo_open = kvaser_usb_open,
 	.ndo_stop = kvaser_usb_close,
@@ -768,10 +761,6 @@ static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
-static const struct ethtool_ops kvaser_usb_ethtool_ops = {
-	.get_ts_info = ethtool_op_get_ts_info,
-};
-
 static const struct ethtool_ops kvaser_usb_ethtool_ops_hwts = {
 	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
-- 
2.45.2


