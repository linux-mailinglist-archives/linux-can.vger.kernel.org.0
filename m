Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF7131E92D
	for <lists+linux-can@lfdr.de>; Thu, 18 Feb 2021 12:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhBRLdA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Feb 2021 06:33:00 -0500
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:25830
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231338AbhBRLDV (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 18 Feb 2021 06:03:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfBEgba66V2dRrXTQGY4PhrMhrOhMqMmSGZpwTSZztYck6y5fKyO9J/humZg495ev2sC8FG5V93aRvQcb+ExEUJDCyAntReE+oi7SZj9o2j4skQLXFS81Iw0n+7o8OwvxrtIw+up/LzodZZsZe4a7yvByjk6CPCr1eenm5vsg30sKssCMgfJAmscgks1ZKQFHYRvpFpt3kQIiJMknRP1m52ih3Zr8rmA7K17bn6x6d/4nKKgaXS5jGxED+T85D1jNxuqBcHD7Vc9MRSNRM9lh1qr0CA8/vVwDvioE5iyRWh04MR9cszNIx9ZdQ7Og3l0DlVoCueiaBf3Tu2BQOy/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPazkHLyFs2Z6gWxvc0cdc+gg8Ixgn8LAPLDmwAHThk=;
 b=cvpz2uREhx1hebzfvd+ifPI/NiVtAJD0wHK16GgTvpS/QrHAZy17ZfcT+JAMkkj+B+sAU7ReNSJLBjl+P/oiLJhwx6WCeB3OkbE51Dn3Br/2X4SJJjPnMsDsIsEiB4RmgrLxeqDhAtU8uBJREV5ZrMcDLviIufNY1hhR34CZj8p2OdZ8201eKi6WpfMQKqVzh/oWC7JyD4TPA8TjALq9KgdLvdKD9tUUmK13kyXRYSFyp1l3es6CwvxzEQ7ma3yrWMweUa7ZIgHcnOQH/JVXnWmBCQf5Ktc8nqAJ7qGl20nWcRCmNfxA7FYU8lV5pwbJBOZ0NSfxMtCMeQm4l9fRJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPazkHLyFs2Z6gWxvc0cdc+gg8Ixgn8LAPLDmwAHThk=;
 b=o1H8LBNWZuoiMcYBr3Gpp8tUUqPbiakqaGpok9s+Zn1Jpqzw+c754meGIsrBrzqX6hSs+Tq6mq64jwWECGWptvVC2CQtg0wYkdPnGU8nLAP8NN2ngprHgW8f/dQHhJlIbfasPhN8Ef/MKXbsF5D/RZDKB4C+sfoitCW6Upn8FWg=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0401MB2327.eurprd04.prod.outlook.com (2603:10a6:4:48::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Thu, 18 Feb
 2021 11:00:22 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978%4]) with mapi id 15.20.3846.042; Thu, 18 Feb 2021
 11:00:22 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V3 3/3] can: flexcan: invoke flexcan_chip_freeze() to enter freeze mode
Date:   Thu, 18 Feb 2021 19:00:37 +0800
Message-Id: <20210218110037.16591-4-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218110037.16591-1-qiangqing.zhang@nxp.com>
References: <20210218110037.16591-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0037.apcprd02.prod.outlook.com (2603:1096:3:18::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 11:00:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3dd91b5-0c12-45ae-2b31-08d8d3fc629e
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2327:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB23273B7341C9DD712103F943E6859@DB6PR0401MB2327.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P43tSqbGD03nkse93ZO6FfcF6hoC7t262kHvjDNgq7e/MTvP7mZYADMNY3ZzIrB4mhnAXCY5niP2kDhKQvTgE61Y9wO3UkOanXnglM4bMSUFGRy81kMpXf96/rpY7lWhIPZY5g2ttCWuA8uU8uPBYDX2qOZUNB+VDMpm1QwUlWQZDTy4bb/BVquSAL4dOGZ6KGmMELpi2Wv3SjhO4RuvQIJ564QWvH65filtY8BkNXy0paIDc+OABXTzZGjqegv2HOBPUohsCzPGjY30/aH8Sduq6d9F125Uk9P9bdvoGUFIk0KT2nudwbQDIuvi9KwxYCD0Jy3uAYzIwfwFXs/6Qdu73HO4CTTJZEHtcnFMvCMnQd3+tfqtqFG9wukSbY9O1VQLVYC2add2P1g7eny60J4T5T//VMrvUqxI9MFEqLsWXeiq95AbjdFkoBrMq706x2s9SfJlJK7OvQ1a6aUExyH5/l75enqrJhn6rowUELb9YGDCWfg9hdtJ9PecQM7PZI2XkaH1eNVuDUAY8Y6nWCpGrekwF/AFT0ENty8pCN61Si3imzEznzIxtqg7cMBc3JZexLICC+DIxtlt0VZrzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(66476007)(8676002)(66556008)(66946007)(52116002)(8936002)(5660300002)(6666004)(186003)(1076003)(6486002)(86362001)(69590400012)(4326008)(478600001)(2616005)(316002)(956004)(83380400001)(6916009)(36756003)(26005)(16526019)(6512007)(2906002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w3pyVtZ7IA/uyxcrTwAZtEDareeffmXjHng2jByPNQ6lR0gOP9z385e+zKJM?=
 =?us-ascii?Q?udLwUyyZ65+rTFWaD09LbdEikB/BCb2s/TXKFXgoGaXHA99+gdFlyjyjRbA9?=
 =?us-ascii?Q?8V/yJ0KqtXLFy8xI8jmnD6CldBSWa9luv73f/l/jMwlu6TpuMTDibykK5c1+?=
 =?us-ascii?Q?5trnmWVsYHWiub9LAK2xfhkCgyuXOnSZtFAGJbGZvohOJ0/6QzKRH3NrW5wZ?=
 =?us-ascii?Q?s+6nByzdGvUjwnnwmaeHlOwCGIiaGsqooZXe1JPtQafH5abU5FusfMAroZ0c?=
 =?us-ascii?Q?Awr+RmCZsI9Op8J300UXXbUC6Ju8AVH2kj4vddQiHicwKy7wJWn6qgVaBXPT?=
 =?us-ascii?Q?qsOrdpms0KYSoDcCS9D8I5ZcnqpRHGgVUniKodrMWV2YkgYzUQh/su779x03?=
 =?us-ascii?Q?J8dMwI4oAhmR4hKAb8VBURmzuZmGZDapTWXvSzu+WScXcEtmdXp2gpmi1eSk?=
 =?us-ascii?Q?F4f3GZTViXb1SGLluhxHq/Fmyv38g3sljkIAOP65JUAuOyav9DwtoJnHp0hM?=
 =?us-ascii?Q?qE87eszHYmdpc6B8eo1fmaV5vl0VbM7we/3ypzMcrIWA38ahsTRmWHqspo6a?=
 =?us-ascii?Q?wCqF902hJApHD3MLRHsrG5+yJBrwKL6AZqBY5UQUp6Qr1fqbwD8Ornnr8VWZ?=
 =?us-ascii?Q?Bff8gwnwoYmZNf4Rn/KGs63sM4GKp9zItAoGXM8zhTsIrz9797Y1lq1nCHz4?=
 =?us-ascii?Q?ifGXUFCK3CfaVFkID/oc1ep6kkLb9XKaOm1zPv1QMUD6TyDqRUsnEqEDVYUW?=
 =?us-ascii?Q?lFocBRBNQ/ZXue75ue2np9FM17lV3qhlHd3OOMjTeoKWTL+hML7QVmbd1Fzn?=
 =?us-ascii?Q?kIq0IroVB+e/i+yT/+lHNLQVLpKnDKtVJf252B0QI6KEZ9wtZk4ygTBz7Tck?=
 =?us-ascii?Q?0a6ii+VCl0vS1lhGFKg3D1yDmeZGjEbuBed7O3uvfIoVhr5WmdllWua75u/D?=
 =?us-ascii?Q?dZrKOgT9jxbHgG843hYOYdRu0qKMo9bxe8gNNOYTL9QoBz7bJ8Qsp7tpt38R?=
 =?us-ascii?Q?LZy0V3CUrKm0t4pj5nR6TOIoay4+5m5AGwtlx7tlD8+De59MeM93zSRSmYYt?=
 =?us-ascii?Q?WIJRSmDGgokCNljuEoTicpiwiSljYBQavz+jzxQTgk1DIwptqF32Dfe+p2oe?=
 =?us-ascii?Q?LclWo09INZpcg9BGRf+/ywW31Hzg94y0NwM8kK44G36b+Jya41AwhUIGl206?=
 =?us-ascii?Q?xk6kfKStEWjodkRwrEswYL8lmJ4csrV199axTNQoGzDeqUEnYYqA0fOsydZ1?=
 =?us-ascii?Q?FDxZ1Rc0ODHXlPaNnHRewG5G9Ja5W3tdt5AIQN1rrAuE5h+Gg89DrXMEzlfF?=
 =?us-ascii?Q?DI4jjPTkmxFv5e5ZSTnzBx8f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dd91b5-0c12-45ae-2b31-08d8d3fc629e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 11:00:22.0453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+miZ1E2bfTbHSP7SAYHpqGh8p7TKU/UZNtL2AJQuOxjDOzSB/r+1xzKCYEueq3z97ugadrV2FN2jgiVoyDEVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2327
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Invoke flexcan_chip_freeze() to enter freeze mode, since need poll
freeze mode acknowledge.

Fixes: e955cead03117 ("CAN: Add Flexcan CAN controller driver")
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index d6a84b7e06da..bdfb36496d96 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1440,10 +1440,13 @@ static int flexcan_chip_start(struct net_device *dev)
 
 	flexcan_set_bittiming(dev);
 
+	/* set freeze, halt */
+	err = flexcan_chip_freeze(priv);
+	if (err)
+		goto out_chip_disable;
+
 	/* MCR
 	 *
-	 * enable freeze
-	 * halt now
 	 * only supervisor access
 	 * enable warning int
 	 * enable individual RX masking
@@ -1452,9 +1455,8 @@ static int flexcan_chip_start(struct net_device *dev)
 	 */
 	reg_mcr = priv->read(&regs->mcr);
 	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
-	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT | FLEXCAN_MCR_SUPV |
-		FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_IRMQ | FLEXCAN_MCR_IDAM_C |
-		FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
+	reg_mcr |= FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_IRMQ |
+		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
 
 	/* MCR
 	 *
-- 
2.17.1

