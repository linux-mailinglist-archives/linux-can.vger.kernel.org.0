Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6611763146
	for <lists+linux-can@lfdr.de>; Wed, 26 Jul 2023 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjGZJK0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jul 2023 05:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjGZJJg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Jul 2023 05:09:36 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3391AB5;
        Wed, 26 Jul 2023 02:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3+V7dXhzohwucb/bEpfGZzLYpomjnZ6ASZUYW87nMee85mPqarWGitj1nLEBR6cKFcGquLx7a14nFdpcQv1I7y0HjuVQ8cgt0OyRR2rhR55HkHQINneUE0HW8g7scQEmx6LC4QUisRbF7iPqqpv6MPhp9bompWJGCdA/MPYC34vByPgMOEBDkDsU7c9mTl7golLIPDUbCoilNP4Vmj0T4IG4rVyKSnuCDVXz9VI+IbalzuU0DqnzYdfO7R+kL3LuIJPg2Sv6T3KjBGSQ2Kol0V/1fTOcdPFId4PhAMLe+5qkiCBep6WOqmOH6SSQHAF6xdMZVy/Ds6TRU6gahr6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSwo/TnEqDXh8/tpa2MZKXk+pxxpbNGr9bPHDr4nAuo=;
 b=P+7vpBIER6FOzaUiThELZq2J36nOVZNukJQF3uaDN0Wj2OCCWoD9xR+wYlNNkKarsDm61u2rNmmijcsON0XWFrHKWlq+4hgINdBGxMkArc+CWfTyo+5k0WKsBaPdouGjknNHA8BlchOozIWQD9InC39NkEE5wD/cg8vjAxQwHPetsq741iXiWQs0GPdEznMQMD0oVZ8t9zo2NzVmkst7/OHuzLIj4fw1wnPKDUAUpQTS2ZtUBgG2kPLhHu9f9nMTpKVm68L1TJyLLvDt4aqnCz/dPPrlB12EzMaeDHGEZ+OtM2p7njArS0FKe8pprsGQD2w/N8kwV/DUmFeSrlrojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSwo/TnEqDXh8/tpa2MZKXk+pxxpbNGr9bPHDr4nAuo=;
 b=XXI6n25mti/aBnUA2AxL8y5JDXjyXet6uzPboRGkEz4Ryfl5hF/OQ4to1V/rqFyF1tmGnTdv+st9lMBM3ERFGAUUs+mpLMbsV20Jm59ZN/ZpuqoOYcSCw7UXm8lMX2+G0RCRnYWOobPRwUwe4Oc5Vbf+TA6MULoTMH4l0ng/0jI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 VI1PR04MB7056.eurprd04.prod.outlook.com (2603:10a6:800:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 09:05:35 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 09:05:35 +0000
From:   haibo.chen@nxp.com
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        wg@grandegger.com, mkl@pengutronix.de
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        haibo.chen@nxp.com, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 2/3] can: flexcan: remove the auto stop mode for IMX93
Date:   Wed, 26 Jul 2023 17:09:08 +0800
Message-Id: <20230726090909.3417030-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726090909.3417030-1-haibo.chen@nxp.com>
References: <20230726090909.3417030-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|VI1PR04MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf77a1b-2e57-41c6-b8df-08db8db778fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ip9rW1QHy3HfSn+MFF/jCF1JcpRZcVWTdWmBPe0HAANjwA8+cQ7F/D3XRa7cZfnwIJRdWKjGwTQWCkr+rCnYGFmPI66EBPJ+XqCdugilUb7uIb/PVmFTcJ6bEEXYzKPL0HeDBRCpplnV1Ru4+CEaoEe4zt6/Qx7AtDQ+BXcX/OzkHQAeM0y8Vn++KNYRe3q0yRYUR/wg6IwcYM4254HFoGfqnOsFf9s87kvHpbvKHWc8c0exIg1bTLSO+p/Qmu5VaGYvixhS9llTDRUZ/fEDGSa9LwxHF87kR6UMtSfzCUqq6S71GIWgIyCxHeqLCVw5gCDRxvS+U+TsUjV7oNHYZx4sICtSRLZz1ZFwqESr/0iOg5M9YsOC2a2TU2ALZvUuKw5lUSW/RdUUvxtUmOdkUHXMQrNrreT8jIEUjPN7VkhUaXCZGE4psRuQyEg3FlsfF66jvCRA2ymv0PqlWp+0Z9lMax61TsY10HXWzZmTYo46kk/ZvK9gTZrbseZU/DVSVP1CkhGnmqChb4taVvONaGrqRb1RsBbresG7ES+tDNpW7VPEvhx2suMbO4oQUZduSrqcmoNYl946FnHE3OS3EFqBEneWFgLaW4bA/3TJ8RBHPX6PyVlg0dNPt9GVL40p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(6486002)(52116002)(6512007)(9686003)(6666004)(478600001)(83380400001)(86362001)(36756003)(2906002)(186003)(38350700002)(6506007)(2616005)(26005)(1076003)(66476007)(38100700002)(316002)(8676002)(41300700001)(4326008)(66946007)(5660300002)(8936002)(66556008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ycTuBlRR7+IN/G19ZUKTH8CZDSR4JiAteDag9wBj/xVOZ6YclwIGIUChnm4R?=
 =?us-ascii?Q?g1BFNBF7r2CvEbDXKTdabzw4JcOZMxSlYUSsgWBSscJKzOZOCp6qM7r7cK+5?=
 =?us-ascii?Q?pKIyk+dhQ31ZEvvSXdAFf8K2oTznZuCvnNAKdLLKjzsKMvM7iceZLKneQ3N+?=
 =?us-ascii?Q?z7aaeSlNYFyFArEhfndFa5NMP8EzLMmWjozAMd1B7do9LhCwO+8DP6uYo6Kh?=
 =?us-ascii?Q?9i1WeK2AReTl0m9He+pKoulJ3yRqdHM8SpmrgOmoDdp5nlaArgGlBaFqVtoH?=
 =?us-ascii?Q?hBDSvX9sR80eTTjGIa1/JOpICuXTRBsfqlDDYF6rswKzVlWPwZJWzHBOfsZA?=
 =?us-ascii?Q?5APe4COqDLMUJVfZr2ZRyf9wiGBO2CSBa7DoW7PO3rZ/4odGczXB27ub0BIQ?=
 =?us-ascii?Q?etnXH1sDYXPkFfssiCKVhsL9Kk3SrlDBD/Zjqtv3ffapccMXYKprjFbgSTuO?=
 =?us-ascii?Q?E0U5Eo83KRPEdZppAC5KzRkjs8sNdQdaRXHAyxTCzMZzS7Mc6GiwP5YijS43?=
 =?us-ascii?Q?do7rkJlQ+4q5DJAR0A+CCIazc022NdoYo+sXRqi6TcZTJFxKNSZQk7UwpjVW?=
 =?us-ascii?Q?ClFZ4uuk8QHbmJFfdLeUM0i4aFH0rUF/d7a/sbz/ozTixt7szXFtEibJAUi4?=
 =?us-ascii?Q?jf+a45hiWRqYCQxOD2gm+vJZj/UbcwoUGe9BciyTR7eHSGg/TY0JA1p4b/wn?=
 =?us-ascii?Q?2TqpqA9qmNYo1sfq+NPxAaGniSHsp4tiytLS+XCsH3I1rj8RbrUNbyWWZmTP?=
 =?us-ascii?Q?5RistzHUPn0P7Nt1TqkKgnpiUpMeS/7VYa+AB9EZN5gr/rwlfViNgwnobgJO?=
 =?us-ascii?Q?sGAHNi2Bf8xSDoR5UVnHRzokbrZygKXb/IJVrV/2wde/dXUk5/8vywW2qi6L?=
 =?us-ascii?Q?uAPAhJJTfwrainOmIhOVuhJJGG6iChKJ5a3NjsnyGGmlvd652tC3sA5qAuc1?=
 =?us-ascii?Q?Oo1m1GjIZ+WvjvJz+BGdgLw3TnlB5zL6Jz8CcaKwzB0PfGL94FpbdM9v5DiX?=
 =?us-ascii?Q?Nw85pEH2fGXJwwrNcvuRvaT77KTUZRpB1tX1WaDpz2znq/qJrQ4cn0ALa36y?=
 =?us-ascii?Q?YN8oimXD4mX0IaSjF1TBVPIYD0FvPY7ZONFhnendcYeCjODSWsPPlByB2U+o?=
 =?us-ascii?Q?ynCEXWM8U1IyQgX8tbX0+WvglI3vywdqq3tDpi0jfvnvL3VWKFkY67UtQED+?=
 =?us-ascii?Q?9ID1NFbSnUTS/yfJ+M0vhflQwqC9arz89aKj2gkfJn/45hoqbMHGhXAwHGIX?=
 =?us-ascii?Q?J57RxhK8CtIcCQsDpIJ3WO+q/23RqKl91j3c5AS5PPJ9CHnG7fLoJdxi84R1?=
 =?us-ascii?Q?ffghNfItKaTwHnUE00Of4cayMuMorgETiwqLCnivua0XaTFLcNpO0KZ3eBhx?=
 =?us-ascii?Q?Yw80EzDdUBNLgHqcGJcG/iJiEVEOsfMpAQ/JXUGYn8OAE0qJAJcuWlZ3ge2g?=
 =?us-ascii?Q?LwJffQR7wJL07TrlXZpTv19E3g2lrhMeD6Y9htKwD/klstZB0Oy1sih5YIX/?=
 =?us-ascii?Q?hC3wVbWyGB39MhWbouANNeUHu45+Nx7XPmnGAgWhOvY3yVbo/3zESWlTUzlz?=
 =?us-ascii?Q?scR7cG63AdcE48r3UaizjcCcmF2Lw7gVXYUQDDK9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf77a1b-2e57-41c6-b8df-08db8db778fd
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 09:05:35.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SQKXb9Ak3VHhCcNkJvBnDR6sdo5LrMaxPqvJYhrGrdMUgsPVoXPlVPO0FZADWsZ54Sq9kkV5bjUlF6klKaL4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

IMX93 A0 chip involve the internal q-channel handshake in LPCG and
CCM to automatically handle the Flex-CAN IPG STOP signal. Only after
FLEX-CAN enter stop mode then can support the self-wakeup feature.
But meet issue when do the continue system PM stress test. When config
the CAN as wakeup source, the first time after system suspend, any data
on CAN bus can wakeup the system, this is as expect. But the second time
when system suspend, data on CAN bus can't wakeup the system. If continue
this test, we find in odd time system enter suspend, CAN can wakeup the
system, but in even number system enter suspend, CAN can't wakeup the
system. IC find a bug in the auto stop mode logic, and can't fix it easily.
So for the new imx93 A1, IC drop the auto stop mode and involve the
GPR to support stop mode (used before). IC define a bit in GPR which can
trigger the IPG STOP signal to Flex-CAN, let it go into stop mode.
And NXP claim to drop IMX93 A0, and only support IMX93 A1. So this patch
remove the auto stop mode, and add flag FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR
to imx93.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 37 ++++----------------------
 drivers/net/can/flexcan/flexcan.h      |  2 --
 2 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ff0fc18baf13..a3f3a9c909be 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -348,7 +348,7 @@ static struct flexcan_devtype_data fsl_imx8mp_devtype_data = {
 static struct flexcan_devtype_data fsl_imx93_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
-		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_AUTO_STOP_MODE |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR |
 		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SUPPORT_ECC |
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
@@ -544,11 +544,6 @@ static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
 	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR) {
 		regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
 				   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
-	} else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE) {
-		/* For the auto stop mode, software do nothing, hardware will cover
-		 * all the operation automatically after system go into low power mode.
-		 */
-		return 0;
 	}
 
 	return flexcan_low_power_enter_ack(priv);
@@ -574,12 +569,6 @@ static inline int flexcan_exit_stop_mode(struct flexcan_priv *priv)
 	reg_mcr &= ~FLEXCAN_MCR_SLF_WAK;
 	priv->write(reg_mcr, &regs->mcr);
 
-	/* For the auto stop mode, hardware will exist stop mode
-	 * automatically after system go out of low power mode.
-	 */
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)
-		return 0;
-
 	return flexcan_low_power_exit_ack(priv);
 }
 
@@ -1994,8 +1983,6 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 		ret = flexcan_setup_stop_mode_scfw(pdev);
 	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR)
 		ret = flexcan_setup_stop_mode_gpr(pdev);
-	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)
-		ret = 0;
 	else
 		/* return 0 directly if doesn't support stop mode feature */
 		return 0;
@@ -2320,16 +2307,8 @@ static int __maybe_unused flexcan_noirq_suspend(struct device *device)
 	if (netif_running(dev)) {
 		int err;
 
-		if (device_may_wakeup(device)) {
+		if (device_may_wakeup(device))
 			flexcan_enable_wakeup_irq(priv, true);
-			/* For auto stop mode, need to keep the clock on before
-			 * system go into low power mode. After system go into
-			 * low power mode, hardware will config the flexcan into
-			 * stop mode, and gate off the clock automatically.
-			 */
-			if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)
-				return 0;
-		}
 
 		err = pm_runtime_force_suspend(device);
 		if (err)
@@ -2347,15 +2326,9 @@ static int __maybe_unused flexcan_noirq_resume(struct device *device)
 	if (netif_running(dev)) {
 		int err;
 
-		/* For the wakeup in auto stop mode, no need to gate on the
-		 * clock here, hardware will do this automatically.
-		 */
-		if (!(device_may_wakeup(device) &&
-		      priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)) {
-			err = pm_runtime_force_resume(device);
-			if (err)
-				return err;
-		}
+		err = pm_runtime_force_resume(device);
+		if (err)
+			return err;
 
 		if (device_may_wakeup(device))
 			flexcan_enable_wakeup_irq(priv, false);
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 91402977780b..025c3417031f 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -68,8 +68,6 @@
 #define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(15)
 /* Device supports RX via FIFO */
 #define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
-/* auto enter stop mode to support wakeup */
-#define FLEXCAN_QUIRK_AUTO_STOP_MODE BIT(17)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
-- 
2.34.1

