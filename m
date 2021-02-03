Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ADF30D6FE
	for <lists+linux-can@lfdr.de>; Wed,  3 Feb 2021 11:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhBCKDs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Feb 2021 05:03:48 -0500
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:63459
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233379AbhBCKDo (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 3 Feb 2021 05:03:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTLN/JgYLqwXbd6ksP0emVDE73WTChG8owWVi9y8mqN6ApZTRehCcnlPuOaGDroAdSZeDnMX+M8OuJO0oz8i+RdYu3oUphRlkxt+eMcRWR8qtdZw+WgetL3KfdOKoPg49l5sTzN/XiiHJwvM/kSxU24WpC46f2nLmya3S3plFxqn9d4DISD5Y1ar5ef9F80G/JwsmvfQWm+7jDaeYIruKQp7HelqXFkmaOKirxPgr1IZEYyQdXfZ4krfl2SzrovPZ5jQbCgkXcerq3pR8CCmuEh+3pJpfIkKC3y5VXvtc2G7QZFOq5DOfLecsFE1TGxD52/zRTjrleCfhp0j7UzaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7k4Kcbhg9B0a8WYdRaBEDKDJrooeP9tkilf+N5xAcw4=;
 b=DoGhlW345QcI3smwLf93LtJT7b0JLPjmSZFSy/aYUN/nbYv2MTtRTWjUJ5nTECjeKSTjpQXcLRrY4NdK5k1TyJ2jDTfnU/8nHPIU+lroRB3aZUsjeMK/l6qecHJy7SqWcnEb/V//v3aaMAL4LVQr6rlpBDVVCwcFdInHrmRCFhl5NCWIjqVse4DsjqCfEK6L8XUhkmQeCWt0r7rNyra9RYTymWCM3NZ/L/n/MrDZFJuLp3XNiGawptx0lq9KqVkXFps9lwHZHfi9B4MY6euNDsNL0a+GrXJZ5uDgswA7TfywSuNf8wSSTqZs2lVlJtzqIUtug+GxbJ02tmzBmKjYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7k4Kcbhg9B0a8WYdRaBEDKDJrooeP9tkilf+N5xAcw4=;
 b=OQrNb++5/3Ds8meBdJXEY+fWw2IuFyECIXVR0RPOgPZ/F6/DIVz2EENjzM1pnYe/DJRpY81ahwe0UJTVGknRHPQAvgpelCpi/MFKiM7XfE7Cl8AYH24QpXGiYVGhmyVGcfvCjKSTEHZR5uWfby5eZ8AYKKGqKZjXOa8lCp7M8bs=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (10.255.185.79) by
 DBAPR04MB7429.eurprd04.prod.outlook.com (20.181.184.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17; Wed, 3 Feb 2021 10:02:24 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920%3]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 10:02:24 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 2/3] can: flexcan: enable RX FIFO after FRZ/HALT valid
Date:   Wed,  3 Feb 2021 18:02:54 +0800
Message-Id: <20210203100255.12472-3-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203100255.12472-1-qiangqing.zhang@nxp.com>
References: <20210203100255.12472-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.0 via Frontend Transport; Wed, 3 Feb 2021 10:02:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13bb9908-1769-422a-ed73-08d8c82acddf
X-MS-TrafficTypeDiagnostic: DBAPR04MB7429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB742914A9F24309ACC9381657E6B49@DBAPR04MB7429.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MG+Kxw6Vk1yVChKYj73ZRzoRmrhStVhMh1DwEBpZLZs90JA4UtjXEE43madDDNmdZRBDWeK5X8d9WXP1JazxZI9x95EYcGpMe7NNlEsmPFxD69rSjoekLWj5Dq8FZBiHuQfgCo+SGFSV3T0iR3DYNavL2weRdsGQ1MlPHxTxNvg/02DKVxJ9Pf2UPo5Ozwtn+pRoOKCE+gzE7WNt3Z9DgP9s83Jxp8h+w9B7S5+yCP2Hc85K8zX+em5FqF0gk8hO0t9uVAxNxU94Qy0soxw7hCJ+sEtrvrHiBNdEL3eppNxqT7fe5+g7lhAbfItMgsLl0hhc1Lr4sfCuyPgGVAC7sjaNWqOeukg5UWQ5w2X0sCHRhmqSn0bAzJaeOqi20Dwmtm19ZX7wbcyHBIPIKdj/6Ja6NwYu9T7EOYnitfRG3k8Ciamast7QW7qeXM0SDg81A+QqWO+aQiBYIpFxiOmos6cR/WezQ2ACnxh8Rw8XLfL//VcG7xUMfRsvSyKRRK5kmCFq0WJapivtvdLUFHM1vBCdxosmw2EFhiUwHg9L2+c6M43ZNacpgpg2Zd5C5q4k9/8hITGCyzsu5Le/V3Mylg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(86362001)(66476007)(8936002)(478600001)(2906002)(4326008)(66556008)(52116002)(66946007)(316002)(1076003)(956004)(36756003)(8676002)(26005)(83380400001)(6506007)(16526019)(69590400011)(186003)(5660300002)(6666004)(6916009)(6486002)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6YIy4R+Hne6YsYC4xFPoChgpfWb0Q3qYT2YkNyLkMdsVLD3hxYeM0nZ9Y8sg?=
 =?us-ascii?Q?S94d/68jv9Kv5bXMya/gijoUEO9C8eACsHFKTm/e0ieNPKXcvs62EdlN94BF?=
 =?us-ascii?Q?9zsNweCSzt+CI+0BDhcGCdrnQTwD02XD8vZbGAncQI8SD+qMQOVHLxNy6Zb3?=
 =?us-ascii?Q?dYk0P1CDLj0F5v9WILIVwG7lIfPI8odYe4U/sdmc6hYD3X7Le2xkbQhspnh7?=
 =?us-ascii?Q?Pl8Mo8wyRM987OMEihebNOv+Mu2Cd560tJquJ/O6hQ8H2HKeseU538sFrRC7?=
 =?us-ascii?Q?+CJ5tNAuHq1A4nz3QZbOnBNTJZQxX5MNHCuYM+O8bD9wW+Y0h6OBb6DKSQKF?=
 =?us-ascii?Q?N3WOcXGXTFW8hMaP042ZG7o12w9QqXFdtKgytLZ3KKIenJpuqCWVFdjUx5Fu?=
 =?us-ascii?Q?zs7HYRl+RIBqIIIGO+Xyo8mRRxzLxZJhG3n1DBPnf1jXoPbVOJDVYGMBQZJh?=
 =?us-ascii?Q?eAG8UkBrFZe7RC41RUC461BNZF+RWI5eztBOiYGUgbO9UTqAQJXJarXJdD1+?=
 =?us-ascii?Q?rPiRWchCaoCrSLj/D9g8lZPkOivHpZ5D0wot6TB91du1u0Czgz9z1b2ra1FJ?=
 =?us-ascii?Q?aVYdgpvcP+7lqtvVkOmTbWAW36mqa34pcdX9epHM8DB7k3SD7rlkqBxzim8U?=
 =?us-ascii?Q?W2jQmSPQfd4lTd3TD4FBr/Ra5wun2oyLgLLi0g3gjvHFpnowsUuMLU/uvueB?=
 =?us-ascii?Q?dcr9vY9nod3NK9gBzUP2g3X8AL9VYAVdt3Wi9T+lizHamTARzeVGqru6C6nG?=
 =?us-ascii?Q?PFw8mFCtR7u4PwggvYfze4EyRkiEz8kXUiycgzAbk2RRT6DzBF2ljrzssn+c?=
 =?us-ascii?Q?FsDbyZQhKyZjB8gxbNR3Ok4hRfbG4rONJNESsIxkywWmlRFnSfspjiO5edpk?=
 =?us-ascii?Q?tZQRkyE6maD7Z4ew6wJteHwQCgY2fdGnZaGVm/Z3e6snn1x8C3FpDAJwjRdo?=
 =?us-ascii?Q?kq6XRCQOW4QDj3ypq04EdA+mUY+BB012GnxfDLha4KrkntZAMeNXYDtOQFGj?=
 =?us-ascii?Q?+gC5ED2Ss1AGKbOlOgKu7hPAbePMIdVihqjFZuw58yRv865xn/pUjScQUTZn?=
 =?us-ascii?Q?jVwXNL74?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bb9908-1769-422a-ed73-08d8c82acddf
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 10:02:24.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MT0CIinLXArvXpSAjT+D9B7Y+ipSNSTBq+QptvusR/4BHlE5aQdWJTfNvqnHaC33tKMSDzDjbEnEMxfHQJv1QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7429
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

RX FIFO enable failed could happen when do system reboot stress test:

[    0.303958] flexcan 5a8d0000.can: 5a8d0000.can supply xceiver not found, using dummy regulator
[    0.304281] flexcan 5a8d0000.can (unnamed net_device) (uninitialized): Could not enable RX FIFO, unsupported core
[    0.314640] flexcan 5a8d0000.can: registering netdev failed
[    0.320728] flexcan 5a8e0000.can: 5a8e0000.can supply xceiver not found, using dummy regulator
[    0.320991] flexcan 5a8e0000.can (unnamed net_device) (uninitialized): Could not enable RX FIFO, unsupported core
[    0.331360] flexcan 5a8e0000.can: registering netdev failed
[    0.337444] flexcan 5a8f0000.can: 5a8f0000.can supply xceiver not found, using dummy regulator
[    0.337716] flexcan 5a8f0000.can (unnamed net_device) (uninitialized): Could not enable RX FIFO, unsupported core
[    0.348117] flexcan 5a8f0000.can: registering netdev failed

RX FIFO should be enabled after the FRZ/HALT are valid. But the current
code enable RX FIFO and FRZ/HALT at the same time.

Fixes: e955cead03117 ("CAN: Add Flexcan CAN controller driver")
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 737e594cb12c..84c98ea7dd55 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1825,10 +1825,13 @@ static int register_flexcandev(struct net_device *dev)
 	if (err)
 		goto out_chip_disable;
 
-	/* set freeze, halt and activate FIFO, restrict register access */
-	reg = priv->read(&regs->mcr);
-	reg |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
-		FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
+	/* set freeze, halt */
+	err = flexcan_chip_freeze(priv);
+	if (err)
+		goto out_chip_disable;
+
+	/* activate FIFO, restrict register access */
+	reg |=  FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
 	priv->write(reg, &regs->mcr);
 
 	/* Currently we only support newer versions of this core
-- 
2.17.1

