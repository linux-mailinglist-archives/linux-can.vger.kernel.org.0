Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0A6762970
	for <lists+linux-can@lfdr.de>; Wed, 26 Jul 2023 05:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGZDtN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Jul 2023 23:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGZDtM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Jul 2023 23:49:12 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE022695;
        Tue, 25 Jul 2023 20:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQrV6B0xPpvNeN2QDXmA9U3L7pdzxcm1qSheN/krX8dh2CJB8g3RCqSYJXVHzU853vfbtzB5cmclFegR4XNZ/GtvIAJTNbU4Xr1J6JHmuXEcoNbqBUZ98+2F+pO93MMT4D/mamvsme6fUZwA20JMeEwInxXd0M4ZHtBq5xEkmbMZp3j/YtSv6WYCb52yiy1kNZrNwHqRok9kPWK3VcVuHd7smgQTeMHeGFPKi0NpyEoZcUrkk0bnpg2yJf9XYGN79MvEGh4H54/HMV25hgA6qkkkUcoTROI+pLL45wscwx0ThTcsVDHcL7V5XNX+WQkU3eMk+WcwNTi8YWnvY7p0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFqBySWy2L/ju416QNxCm+th8CNeKvLK5GiwGc5vMz0=;
 b=JRXefThUGtiFeapU5WCAWq/RGbLIRRsVvaWibrUy+VKQgGsE6ESLP4KovEQCp+roW+wA/8CVtZp8lZdqbG8Rtpni/Jx9pp4wY64186Yh1p4jFh+aASLngDr6sw5FdRZj0J10IHsPo4IbpIgfN2Kf4cOV+fAqMJD2GW5LO6/ihGhhRkIRL22U7GfXkgU2nAuAcmptE0FvXnhUgwhnj+gzThtSZm9J2ZaxUP1HF9Ucvy/KIOMloWWX0T9PsjDnm4FWhbbgSkei7aeQg5ft1Q7dymzy0XyJCMJMhnMoBVP9xmGcgUm9n6pWAd4cpTcbqDjmdlpnlLqRY+oLgbtXO6DkNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFqBySWy2L/ju416QNxCm+th8CNeKvLK5GiwGc5vMz0=;
 b=a3MElCgF/8FpbnIASm9jb+1lwrcYk6id9Pdhwdd22/hgE4E6febPG14Axxu+zLbnaLAWCwCi5Ptpz2SL9pwkop/wJsxEK+1RDVI29z94f628WV/bHclKfjAXI34MHcP0DgjKhE+z2T/pubErmF2n74el9b5YBFqafK4hUUKuPt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DBAPR04MB7413.eurprd04.prod.outlook.com (2603:10a6:10:1a6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Wed, 26 Jul 2023 03:49:07 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 03:49:07 +0000
From:   haibo.chen@nxp.com
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        wg@grandegger.com, mkl@pengutronix.de
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        haibo.chen@nxp.com, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 2/2] can: flexcan: remove the auto stop mode for IMX93
Date:   Wed, 26 Jul 2023 11:50:32 +0800
Message-Id: <20230726035032.3073951-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726035032.3073951-1-haibo.chen@nxp.com>
References: <20230726035032.3073951-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0177.apcprd04.prod.outlook.com
 (2603:1096:4:14::15) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|DBAPR04MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f973ea9-f508-456b-c02f-08db8d8b4397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nXWWRlb8rmMqccUYNBugccvvDYQAbk6aY/heQ3z0h29MElODvI1V/+F/l+LdgWRtyTlnBwAt2qm1558MvEv5TB5IU7v5Do23ZLGXC2+/ieWydv1XC2R5ks4v1z34H2LLG2el8PmXxx8atqvvmve3QBol0zRSI/CIFAbPCKgt2zNQBTnb60qXGqL92Zl4VMsXpOENOIUx+LMNPMveGePmGCO3sJ1G3BMvHewocJAAB6DQ6ahQ2ZXabtOusf3yY8Iyfsxv/vwYHSt3asQkFJsM+bvgA3t9X3fDhSVHrQk4oJ5Yxw8bAkWm4MSgmJ8IC11hiS4buYsJtnA3HsUplli4g+6RyBfW5ENiQ/y8ou/zjbER+/S8GVnjwjYuxOKj50UlZeqTCzuEDOmAw2J0VGdkm/qVLQrnJ8qaqOQM5HOMCgqQFVnHzYMMqu+ejecpCuTgl9Ip5zw20YO08bBGFpLbizPbLu9c/l9eKFCDOjiuC6MCOJXpqUFtIN+5/5otUApgyCtRaxalrqExbC1vd61+AXuLtpD0mp/SPV+cp/L4gV/D7uUL9m6VTDORbGOmDeTEgqaLHfLdSfifYA37j/wKH7XYpnQXTX0fPzU2u82F7MTqwAhim2dTMBYYRYy9Rui
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(9686003)(52116002)(6486002)(6666004)(6512007)(478600001)(2616005)(26005)(186003)(1076003)(6506007)(2906002)(66476007)(66556008)(4326008)(66946007)(316002)(8676002)(7416002)(8936002)(5660300002)(41300700001)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TtCFLw10j14bpNv/mau4K/iKPgbXjPztrP/2pjGd18OqJolVH2+2UIJRscso?=
 =?us-ascii?Q?ViW7AbPUr3ziDFM4DJY8O3zwKvY+WhWC1sJ8fbNaA68uZMfn1nBZ6dJGwOQC?=
 =?us-ascii?Q?jFbTYwBapXTEjoJKTg0z2n2FOq1rULOQu+AamvbuU/7EOn8UjkSlS9h7iy6M?=
 =?us-ascii?Q?f3wiYSMPzvqj2EzbOx+WGZoS7QGZROv6FHWyvnM4SzM2uVnypCEORTS+0I1q?=
 =?us-ascii?Q?yaVQmNotselEATYhIDlZxTwnhjE0X3/FN4PdMu0BhUaoTXnsivcmD3/2JOzS?=
 =?us-ascii?Q?FpPQrveSAS7SCN08oYLua/8wXzGS/W9fjodXm6MAdhU1bG5HJGfOp9+qKAB+?=
 =?us-ascii?Q?33MUjHYFWOluNxobtdD7AgKJHUYYZldEMMRVI2SR4JUiVc1eYV9mAWFlJwzc?=
 =?us-ascii?Q?NG/DIWW4pEm5kAwOdE8cm4gXLXmfpvThhvpVyTWMAJt9AFYcrmGLTwu4h1vm?=
 =?us-ascii?Q?IamKz8hX9x2hn36tJReiO3FSTIppFjl5FqOyA6TcMpNcU05flmLO5ISVv2AD?=
 =?us-ascii?Q?NXYQXP6e4ZNhQi8a2YHDaHEC8qN3HqqRtVpIBHYnH+7xUxByGQuatLShFNn4?=
 =?us-ascii?Q?X6lO+poreCv/u+R7x4JWNuKY0bdQpsMEXncJxMAiIeViYxQWY38/eiKuyVHS?=
 =?us-ascii?Q?VbYAneDIJyfBzbloTAJTgrg5aS1PvQA8YAf99O5fkeNy0a5zDijDBCcryG8l?=
 =?us-ascii?Q?hVXf6fCXabmS325LwY3RExX+HJ4THBV98+ubGLrLnPm8wnX5WPF82F3Wla95?=
 =?us-ascii?Q?3LhpuDyA+A9sHMe4yelXpWSvJrhBOvMaELXb64cTpwf2mKProxcmnjAAwEAN?=
 =?us-ascii?Q?eGDj+s3dlkSbDW7J924O+//Qv6e/K1507VtsUPDpHuIRQWrqBqZDMqVBl0un?=
 =?us-ascii?Q?T3La4ndpVGyrApSQD8+WPrSj1E56WBO/O/MGjg5QA9fdTPM2DgboM6w3qajT?=
 =?us-ascii?Q?D9wjeiQArQsKsBiYdYTdXGNVdGblxGf0uHXr0R3VexC8DS0kB/GzPEOfPIPR?=
 =?us-ascii?Q?VYJJXdxpyXzEmVy5mdspQLus0b2O+1zjAANupMjgtkdLZd6sSB86A0WTJLTM?=
 =?us-ascii?Q?onPWfieuSKQJ2ZtNWaMd+7YuTgzBQUezSzz1OEIOJn5iAUv3Hpy2PRD+DcxF?=
 =?us-ascii?Q?v9vC+U1ES8izIKRyBNWjUtIJxBw5/kbbCJeQ/6GPj7I08bp3yppz3dC5C6H5?=
 =?us-ascii?Q?zOToq9QNuD3YNg2kjOwO5De23Mops3Ax4QW+cNhOV+LUnhbWaxmkT/QEWcmZ?=
 =?us-ascii?Q?UVwtaqeHspl8UuiUyFEc22KV6Ac12i0rxWH5IntipLkUf9uQEgFNztcfcHAR?=
 =?us-ascii?Q?mviYwd9yHO+npOwHiN0cPMYfFcQVIfgnorHOoREu6uFD+Mebkb8HW7ZLtUO0?=
 =?us-ascii?Q?vHED0RYzzUoY03Z13FENGo7cJqbqfO1Oulv4U66NWUn5rlFqS1jonr0sevVi?=
 =?us-ascii?Q?GPAogb4pLgCCC9a1JIoMUrSI6LFNFZQu3MdjPuLUEUOHsDO45lpK684nywNN?=
 =?us-ascii?Q?EJ7aJPrHdPdo10ZAcOTKcvhLBSFHp3Gp4JwGimehqyEmO1tfFUV+Fn2MuM1g?=
 =?us-ascii?Q?fJDWIHnVjhrnEXWihJUoUxZDVZVHKZ6oY+LGZE8j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f973ea9-f508-456b-c02f-08db8d8b4397
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 03:49:07.8745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GM9GowadVWvFYlZMX0mjog0fY5e+O/00eWRCf3mOAUyA7UMt0OA4CSIDqOLF3mUH4177At6XKIAN0aXOJKnZOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7413
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
system.

IC find a bug in the auto stop mode logic when handle the q-channel, and
can't fix it easily. So for the new imx93 A1, IC drop the auto stop mode
and involve the GPR to support stop mode (used before). IC define a bit
in GPR which can trigger the IPG STOP signal to Flex-CAN, let it go into
stop mode.

Now NXP claim to drop IMX93 A0, and only support IMX93 A1. So this patch
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

