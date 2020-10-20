Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9C6293952
	for <lists+linux-can@lfdr.de>; Tue, 20 Oct 2020 12:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392223AbgJTKo4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Oct 2020 06:44:56 -0400
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:65030
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392185AbgJTKo4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Oct 2020 06:44:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMqyiNB10OHFAGT36Qx3yw4h40CEgpJ0lt2t1zKeh+EiCknLOBbITq9CHiNUOtuf4eKmNla0llvR60iQur7i97aEn+565CRrM77TxYbIpL3bFY+iC9c7bAeV7Re3JAuVq7nLKx9KjxYROaOma/YF27GAMhQDGg1ysG/kyMrCv/2KewSFrKcNh78Bh+5LXoCoaosRb0qxEl7zgumsPLP3ReXvl4UQBLFaQrHRzRugw2O92tjyJ8artST0ZkcpJmzipbziOJoSbYjUNc79e6PMEgb7CndAmf7k3DYPz1RIJ49zxPrYF+/B4OD7SLk4xhAxFOXV9Ru0G1l9GB7K6zA39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDjjuhGI4231H/vxUQJWB2bLclMfSpLfX3bjqmwj5O4=;
 b=eSJqEMUGXVEJcHj40XGtPI3AQi0Ij0Uj7E9vk84M+vWb8IbH8BM8bkuPJWMVyUfQBO2RdKbcm+rF4RwZpPjC4riu+NASYzM1tjJEto8qfj6O3ze+y9monzsTSk8saz7IOmulfgi/tYyTlf+IDvrdXONHSpoysoSeUz0TA4jNEqR2NwEqK7lMMKA3RahXgOyRIhoTqV5mT3/cLWuGV0/eVRUyh0uaaxSIocLyfAFJNIhS+MTJtyl+bgh9Gf57S3H47NQ5NmiiQmAwrQ2+avpg2ZJ7gnh2e+KlCrSh8t5bGubdZZmiWCxV/9wr26D3XZ3tsCKasBWzQRIl3m1L/Ny3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDjjuhGI4231H/vxUQJWB2bLclMfSpLfX3bjqmwj5O4=;
 b=lU7M1YP/BewMYh9Ejvd3QuAQweJnk1uoivI3NZrpRQdNs20M4DwuFbeeCqflV5nIVEemDp66gQNIRz0jpoDXrZafhAgPcFtcOlZL59BC367A/nzQhHQUizsuuot7sUrpKO4Z2VchKtQss2mSprUiOmizniJsUXT930oNnqF+Wrc=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4522.eurprd04.prod.outlook.com (2603:10a6:5:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 20 Oct
 2020 10:44:51 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc%9]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 10:44:51 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     mkl@pengutronix.de
Cc:     linux-imx@nxp.com, linux-can@vger.kernel.org
Subject: [PATCH V4] can: flexcan: disable wakeup in flexcan_remove()
Date:   Wed, 21 Oct 2020 02:45:27 +0800
Message-Id: <20201020184527.8190-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:3:18::29) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0041.apcprd02.prod.outlook.com (2603:1096:3:18::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Tue, 20 Oct 2020 10:44:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c2b9e3b-6aa5-46a7-d138-08d874e52c71
X-MS-TrafficTypeDiagnostic: DB7PR04MB4522:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB45220FC4902C8BF3DEAC8D28E61F0@DB7PR04MB4522.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bV3AcBh07AiJGvs6MMrITIcUDX/JHKFzJFMOnqp0Vi8WEACocQBTrPCcJ7OpQsFyVwgQiveSnUWuKzhFaw7EQ9941W+36889vpbJgrcoKs22RbGqP+mB0Z2EceUbN4EBOMmaxBhpMnk4EMFKacKB4wRWnCYrA/lTGzlgSJPBRpY971rwxcobaWDA9R8eo4YoY38h41NmTTq7QcqLqnM9QglXMwkz/HYB3lbOhihn0c/x/ovGxiS6i0Fyvo7j5L6NdxUygYl9i8CU83meLDdHiuZULzJS+PoB3YdpdYRWykSBCT3dQqWLLnLhNkHAO0P/v5zCEhG4x3ujE8ggBWirzriDChm3L6ww2jkq+yellLIzRvPTrY+Umx0gBY0YdqFh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(26005)(36756003)(69590400008)(6506007)(6916009)(16526019)(6666004)(66946007)(66476007)(66556008)(8676002)(6512007)(52116002)(83380400001)(316002)(4326008)(956004)(1076003)(6486002)(186003)(86362001)(2616005)(478600001)(5660300002)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AJtQxbyR95HNAIfgo2YVbVMwumiRbRHjSAY2bdnFm2xshZ/uTnbGEtBnb7XuJOzBxsL1yA0XbCf9SLSpzYbWO6w9+OjQkwh72w6qPX/MG1zi/+STJyk/qJP6Rpaf/aBDBsK+FAAhFc6JhW9JqONSOMVzD4seG1xC31z3vNCDTly5mBkXIht2s7PQq/Lx1SSE/o/FJVE+a5LwQygbC7PxxeyfR5553gGGmos4pkOs8fNrhdSQqZhq2QbhHuvtDPi32rSyLjCCCJoqYV0RfUxuO3PS/wKBSrn7EhGW8Jk6HYzFgq6fYKs2MKnPXAcBb5J2nY59C5+FpSeUiIZ2l004Qv9QEhX3yhZl4QPXa93aEdtDef1OEElAW5rOeqYnstxhRIiK9q+YTAk8hzXLhst+GAf21VU3ngeuYRF/i9f/ZIqnESTmFA/ERRxgD2m2UmJ4TOuvh/QsydlGHXM2UV1dJClHZQHsw8/TC8rlbEIRnx56uuFKyDbYJrcwKkiWKaPvLe0tIDri424rJc5NN9vB5S1SZ6DytsIaYQgr/D7ihJyym8tjxuDg5phFOW1/OGG9LcXAvDhDl+iRnHP/KYg75XtQHXiUFF5QGKbHeASf52Gk8iQWVNMet36nnCaKUxXxpD/UKoFKbEciuZsa/zKY0A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2b9e3b-6aa5-46a7-d138-08d874e52c71
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 10:44:51.7931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDpZSGot4iICV98RETUCY58kAqkgfq2KdrR+NWCqHTHUXD15uShbvL8nXMsr7LkhKsAtMfrnxdhmoBuFMfdxmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4522
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With below sequence, we can see wakeup default is enabled after re-load
module, so need disable wakeup in flexcan_remove().

root@imx8qmevk:~# lsmod
Module                  Size  Used by
crct10dif_ce           16384  1
flexcan                32768  0
can_dev                36864  1 flexcan
root@imx8qmevk:~# cat /sys/bus/platform/drivers/flexcan/5a8e0000.can/power/wakeup
disabled
root@imx8qmevk:~# echo enabled > /sys/bus/platform/drivers/flexcan/5a8e0000.can/power/wakeup
root@imx8qmevk:~# cat /sys/bus/platform/drivers/flexcan/5a8e0000.can/power/wakeup
enabled
root@imx8qmevk:~# rmmod flexcan
root@imx8qmevk:~# rmmod can_dev
root@imx8qmevk:~# modprobe flexcan
[  147.877689] CAN device driver interface
root@imx8qmevk:~# cat /sys/bus/platform/drivers/flexcan/5a8e0000.can/power/wakeup
enabled

Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
Fixes: 915f9666421c ("can: flexcan: add support for DT property 'wakeup-source'")
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 06f94b6f0ebe..881799bd9c5e 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -2062,6 +2062,8 @@ static int flexcan_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 
+	device_set_wakeup_enable(&pdev->dev, false);
+	device_set_wakeup_capable(&pdev->dev, false);
 	unregister_flexcandev(dev);
 	pm_runtime_disable(&pdev->dev);
 	free_candev(dev);
-- 
2.17.1

