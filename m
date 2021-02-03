Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C8730D6FF
	for <lists+linux-can@lfdr.de>; Wed,  3 Feb 2021 11:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhBCKDv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Feb 2021 05:03:51 -0500
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:34654
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233215AbhBCKDu (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 3 Feb 2021 05:03:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OR+HdSw5goT7K2L3Wx6iOcAEXppKDwkI2NEV8cvFLMF3GYCdQg6xJLCDqeIs0mlIgM3VqbWpVeBMuFyHZAlVve+dZd1KXDq2ayuXhiMSoiu4tWAePPZ3zb2lfZz4AfS5NareZhVpZjrAJ1LxMfAhrs/bAkultynf0TjuAOBtHw4RG0e+8tDJfsmSYH1MEr9BQMicIs3Aa1iuysPL/cUHwBi/Rx7Wic0fIUiaiycX0M/+TJb13tK3GgXYELhjFBA6feXuOZ8WKpebkGoaR1Yj4UWXIkhzgetS3CZwNTF8yZkp5VmItBm9lox+Mw8kbBdmNn1aPAJKTGo8wje6cWexzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9E9ysgqPiu/Gvq12PtvruH6J7e9Zl/ByzTHCVlEfVI=;
 b=EahyIzvYiUGCkztPaPUHpLeLpUca6y3n4zgjnKhEqZBpNKy43xWsxr03IVFGvKbMXXpcbLkFolAmYQBFFFaPAXL4Ja7H5o8Qy1HPAWxxAlt9rGx9tY17qu3ZA4i4FQRx+f+XOYDvgzTjZg8nBc86Rtnl/qO7xBKGZgIAfwvExYL/V41zdzYCHIoWRvHudWqgKLfKZLV5v1vSwtOYGBaXzUGzXehOD7kmsFaEoZFbIeZzo2/P3PF6/1JS9/JSTCd/RBEIWhU+13WvpgTQdiyxLRiGfR0TEgpVeOQc184Z154Oq1OVCEcBsizW21TURsZAzT92VlNaIzA09NdfKsI34Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9E9ysgqPiu/Gvq12PtvruH6J7e9Zl/ByzTHCVlEfVI=;
 b=jjwAhE3BjO0k0KQke8849Pao8mK8vJGPNPNJQVakm+59UJQAYJAoynKiXZ6ltd4TyUuC/05aR9WgmMLAslwzj3DIElnkDsVpwkjGuAEnGin8ozVXh/tQ8HGgLtNx8D6DOYobxbEvWJXGWh8cfXlTF3CFUnwYFfgqnO9/2mTwKSs=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB5193.eurprd04.prod.outlook.com (2603:10a6:10:15::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 3 Feb
 2021 10:02:26 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920%3]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 10:02:26 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 3/3] can: flexcan: invoke flexcan_chip_freeze() to enter freeze mode
Date:   Wed,  3 Feb 2021 18:02:55 +0800
Message-Id: <20210203100255.12472-4-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203100255.12472-1-qiangqing.zhang@nxp.com>
References: <20210203100255.12472-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.0 via Frontend Transport; Wed, 3 Feb 2021 10:02:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e0766ec-c413-466b-b66c-08d8c82aceef
X-MS-TrafficTypeDiagnostic: DB7PR04MB5193:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5193989E9F95CCB1FC1775A2E6B49@DB7PR04MB5193.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uI6tfXiOWLK0yb79WZkO82dRz7TeA10SdG4dUeFWx01lsn/NKr/M2lKFwM5yckBE940RZ3C26FZ8Yd6eQ83gj5oLqTVyTtVGtdF4OKbprFz6TN+CLd9ToTJTxoZOOzbxfjGMIBCM6XUXl2wIT/gQfIjjBmaebcBD7NmceQ13ORyWSOzlH+buEO3E9qYt16sWTiTeDQJa7cctU6FGCqamd6Ot/Httxp5Z865AyES/n7kEuOrROqV94jdjkVQqAdhV6ujLmP+Z0pL4KKH0mZ7u6LtXz7FWS58CBmMoGFalbuwE3oM1VvnVp5l7o9v3N8+ZdDKZUh13ohLnAbR0yqVQRLZxrtW5BdvQYyYfcmHpmh0HcuC/vFles+3eOjqatsDFDR4x95J41wQ1eC22eyhILBoD76qywhA+fN5UIyRuFPbMTt/nZMvCNb23B3TN70QrqwHS80OFxkEGvWl5N3Qrle1UpigKHoWrUln7/bOB9Kas6GH7W791CfSiSpA50mbyZbc17+EW0QqvvB6P+pNRu6ouC4rXgspFCWn67xWsxZ3bn8hX+ve33eCa/8zCCa5mPoIGCnkOZSyAy86y0Npofw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(66946007)(2906002)(26005)(66556008)(6666004)(2616005)(1076003)(52116002)(16526019)(36756003)(8676002)(83380400001)(66476007)(6512007)(6486002)(8936002)(4326008)(186003)(956004)(5660300002)(69590400011)(478600001)(6506007)(316002)(6916009)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jI1vY9iRKmFKmXahSraiBk75nrFCfnYxFrkl99h6UQQ8HA62MhcqzMMfjstN?=
 =?us-ascii?Q?GA6kix00xMcVml8/DY3x9WTiFcVhMqsKCpQR3Smv4IOX4HzX2h80Of4e+PMn?=
 =?us-ascii?Q?vdSk6gaplo/ShpIin5GL2+kjNzRwBdZsVLenE6sPRJc9Sh++OOwGYfhj8llp?=
 =?us-ascii?Q?+CjEOCic4VPNupH8RmUWyUMrQw3gDMbrl2Xp/fI78zPyT5o4MAcyksGGaV7B?=
 =?us-ascii?Q?Mp3vTUXAQZm0mDfCGxJzU//Ys++9HtVxuyMObTtCV9l7rT14SXZgRsBJJDTA?=
 =?us-ascii?Q?hSqfSefSXREoouqbAHooJ4WHffKpERdlJQUuwhuFrUFhBiaaSsYJmCp+K4Gg?=
 =?us-ascii?Q?Pc6yNuvcTlkfVV3yEIJ5KBHJffEUOq5kP1e833dHgPbCS5h1ZahgMjnArxgL?=
 =?us-ascii?Q?ov1O35eRkGZ34WsDMVGj47cBcFB/HZ52+wmoix2Ih+eLb72Y9n8N8US1TGzU?=
 =?us-ascii?Q?NmeoYuZ/pwp465R4ujCWoqtTb4re+Ba2dkWNQ7ZtRIPVRu4BavORuXYf1Ijf?=
 =?us-ascii?Q?mO1quDHzd10rzasThonqTGptJoMiYL5mmwSSo3xmMeE7+vtzTpTRiFpOvlym?=
 =?us-ascii?Q?E96ll/d2O11rHV5LCMPDyFq7QRm4tfmPKAp2hFCd56CYe++r3dE7pu2zylI/?=
 =?us-ascii?Q?8QmdvRJr6mln1qJ9ZaXtPd4rp8zAvANUVVTVyiq8NYMtlvwK4ybY7xKnMvg2?=
 =?us-ascii?Q?Y3j0CAEtQ6JiBE5G4kYUgJl6eeiw7sc3JU1+ZCkn0IcW0+xS1RY3ohVHW04A?=
 =?us-ascii?Q?pXWCvmGcr415LIZvCL07rOY8KQt7SuFKDtOD3N8Jt2Tqu3UZ8f1b0qI2exjw?=
 =?us-ascii?Q?wYTggdaUtTaBtBsR3fjF0FCsPNohcCYddBlXVD2ntoxpF9TBN3j8a2li47zr?=
 =?us-ascii?Q?hJVJ8Mv34hByU+plY6vpC4hYs4Kj1ONcWbNTbyHMHqQETWDoranVT7X1YCRb?=
 =?us-ascii?Q?tUTMx6HnpXIykB57e4RcEWI+cWWmpeQAjHsEnDYoBk/R0Ab53GWuw8TGlAk9?=
 =?us-ascii?Q?Yufg00s5xizaKbeuGsgPGrRy0g8BPx/t5Xb1AJoR7veqDBT+ZTHdT3WksGU7?=
 =?us-ascii?Q?R7UNmaZt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0766ec-c413-466b-b66c-08d8c82aceef
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 10:02:26.1860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsZFP3ot23x1M411yBaX9mxw7cV8jupkTTsG90PLpiuz7eNarIS8Njvbno0eXIFzFtFF6OSRU/kEEYtTc1sAYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5193
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
index 84c98ea7dd55..c1f28a5497e3 100644
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

