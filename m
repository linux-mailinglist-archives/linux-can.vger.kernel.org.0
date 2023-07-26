Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB31A7634B4
	for <lists+linux-can@lfdr.de>; Wed, 26 Jul 2023 13:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjGZLVr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jul 2023 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGZLVq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Jul 2023 07:21:46 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2080.outbound.protection.outlook.com [40.107.241.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8D1FD;
        Wed, 26 Jul 2023 04:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN8ylth24eTMiLMqm+A+aq3KwzVzL1mWpXIL5lhk1zXyeXP6w+16R/dzfHIb13gaZPR55Fm84x81BBTdttOXDvbw/hR+tSwfaJlbRAlqBxZvSNvAJYSnp409HNT29H6gbvl/SFGBcNDX7vXOBzVU3nImT0DF0lnuKiga4zJtj7x9yQazuMgaHXPQkaskmr3agyxwFjrfwZHorwWtAidvbyA9Wkno1Hol8oTtpwD8YCgb8CBEhyebfQpXBB07bz9bVID9IEWNXVi5jlKhee703p3cDWXNtY1qFezY1HIyc6sNYBA5Llb+iCT32/zbBaP1QnF3ti5KpoGAU1xZ3rXkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElRugvWN47yKwMJ5g5V6v/TdVSudwimQn3gWZdJLl4Q=;
 b=mm/R9/Y+0wD7yzQIWhberVBXxcUZU4HsbsaKBAWvf/7Nx3o3+wfe9hq2xBzL0cWB8iIoFg7wAuLecacg/kqxIjlzGYrOBvee4bdbE2t8sBvYVzH1lHGIU5H7zaH4yu+Q5amJwJmuclQquBhHM/gmc7mkouTLnAJYOQm+K5H9WiBvf4+mtxzwfZfsze/Qr8b8I/OXikIx76zwhCEekL/4uuXFM28Fc+kth3pWcjCcKzfRsSpxgo7wwE3s0v/FRZulWNHGlmQt0WSU/lEx+huwCKvOIEpFdYWtoLOeSviyMxAZFbNG6+4X8Jtu/3CDFp2439fkzQj4vy7lqleEtgdHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElRugvWN47yKwMJ5g5V6v/TdVSudwimQn3gWZdJLl4Q=;
 b=LFEHxdHjDNJmG6iyc4BLQfbQ7dqMS8TLsf5gHBOs6/STbvFAtB6p1zxJ3dPw+alA4DRe0KeDA3lLkXrKOipkcpyNgMhItwBF7DGo+pB9++swvXKWOUNT7FgKbxh8kVXb9A3RDkLTo0Z+sAtLFyrfcpU6yt2zAX9cqARU9aA5BlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DB8PR04MB6892.eurprd04.prod.outlook.com (2603:10a6:10:113::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Wed, 26 Jul 2023 11:21:36 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:21:36 +0000
From:   haibo.chen@nxp.com
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        wg@grandegger.com, mkl@pengutronix.de
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        haibo.chen@nxp.com, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3 2/2] can: flexcan: remove the auto stop mode for IMX93
Date:   Wed, 26 Jul 2023 19:24:58 +0800
Message-Id: <20230726112458.3524165-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726112458.3524165-1-haibo.chen@nxp.com>
References: <20230726112458.3524165-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|DB8PR04MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: f02a20f3-a5f0-4210-a13b-08db8dca7979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKnf84boF3F2D9x2ioNJqcvT43lbCLZlRn74TVKEcFS2yuYZY4QJhbfUdhr5A+rkajg00X8xQRSB8qPrYt0BxpAuDstQEpq/CrRiD7xA9npTJHeb+vWHsKmRIpvjzlEzKJEt3ImCaRs2zzekL//4GXWylw6m1ptnwVjvcAdGCD0cgXoxaHqyqGKjEDmYKHgMOHZuxypUv73GJ3wf8CyvAwzMvkfDl37b76AF9PBvjI4y8Dzc/MYI0KxDjocV5FALUY2Np4SHrvBQ38lO3m0F8e4v8mFtgHFtMDpWJR+TD2S0iOtuNYkhJrcZqXslpWDdz2dfjhqsTSqE1p9/oB2+gTU/RtqtTcCR/enNmVYa3AfaxLuU1RUHXnPkaj9Ehn0VxUCa0BeTwqiAKlppR3zxn1dEhxSoR1QUH4grpu0Ym3zKeNAwsDGnkekyuQ0t5tkX2qK77ZdpMUZJazMdQn2PDHGNh8BuW/rONkjAvTwxNR+uMewXZSSEITk8KMM6Og3V5F/xRuEQndOoKZ9wGTJbn845FhV0fpRUckmGJKA+7GvE7bUk401DrYH7f4iqAHhmQHoJmcr/k+sKdtaABZm9lEy8K5/5o3Ov37FhcJAVhn61O2sFfCKC4TbhdEdZzFHh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(2906002)(52116002)(6486002)(6666004)(2616005)(38350700002)(38100700002)(36756003)(186003)(7416002)(5660300002)(86362001)(83380400001)(41300700001)(8676002)(316002)(6506007)(26005)(8936002)(1076003)(66556008)(478600001)(6512007)(4326008)(66946007)(9686003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5PvQl5XkUj8yu3b/BTpzMkUCGr6ka3u7h36FJ/Ok6rDc0mdAQeTMmmeLPdSq?=
 =?us-ascii?Q?cyZRNsbV6iRcAPNO/z3Y2gWJTP/FfxstEJ54J79vbY8wKl/bzLGntmIdFBX/?=
 =?us-ascii?Q?errNsQon7KNAjpQUntndEgxqNQJY7Qa6YtP1J6eN023Fg5gyboiiseJLn/m4?=
 =?us-ascii?Q?YdktutY5+jP5tjLnxsBbeakj8cTsiXD8dp1pqD2kKMs8WOpiXBz01jzdIIvr?=
 =?us-ascii?Q?jG+1MzYQX67GjTDL2NMv7kpT75lp6XFWgfDoMOvNUOE7Htk9nNsIVhzya34e?=
 =?us-ascii?Q?21FxHckNPZj5NSzI2aCRjEBTAwpjl65L1xwssdnQ9q1v6KDRsbuo3M4sD3mV?=
 =?us-ascii?Q?XQofCdkezyNpyECqiECECXuNUKwkVMQHMluFNoc3E+p5/XVmC48rm1xwUsJe?=
 =?us-ascii?Q?obeF+fLjvP/2OO1XBl8qyWrhjI4syD048Y7Z8e7PSswzSfwPy5SZEr/8PtZa?=
 =?us-ascii?Q?9bF39GNXiBYai/VMwp/Oi7jmz+rpJtHrcUv53mUAx4lDvnRQsvpPOl8QQeTs?=
 =?us-ascii?Q?tI9bQZ1HD/QzDOcnxKyoph1kWToxODoz/BYiAk/UW3hc3Te1XIbo3Bj64xa0?=
 =?us-ascii?Q?MwCerCjuwOM+8Y/Z7wDmIXMSlnQcoeys6uhuxbhKRos3QYnO+0YdyDCjsXCA?=
 =?us-ascii?Q?kO8isa9Ow30FJlbaKCC4I1xXXceHvNI3uEJlsLl1r0AaC32OsKFoJz0SfDh7?=
 =?us-ascii?Q?Avsp2laqIUu7sl4t071JmucrkFhitQUQNUF7muHIwT1wO3NhXGroTZg3Z+wg?=
 =?us-ascii?Q?5R9SSB3JdF7f7wmo+0+Ayj52VjJ3F+kyIRgdpOpDlGNTEr5Ukran2hjSnons?=
 =?us-ascii?Q?j6QWckL/bG7li2OCBmPJpWPL8hWpc6ZDQZ0YWxKqa4KWIVAgms8z0WbAdMPw?=
 =?us-ascii?Q?0smTeBhJIWmvnhLwLboEOcfwwniBWjHixD602RH7PpWSKHXfalHVT+XZrWcG?=
 =?us-ascii?Q?eOdnfiXSYyA63pM0lrfxnFZ6177HdlzsbxC3rnhzCn3LVW3x4pZRdP31DWat?=
 =?us-ascii?Q?vXsbj6/2UrpI1MA8si1C9MezXaEK2ls10HoIWfSOdIaJJ+p6KlABVhbN6kFx?=
 =?us-ascii?Q?8Kz8N+o0oP3Mb5k0PNhogycuUCg1W7LJtYIwTLtArZS7vRQmiQhWVUjhBGDY?=
 =?us-ascii?Q?Iwb9erVQLqU3tCs4v/gmYZ17lezXDWDCbm7eA/vtkuAlBmUDFJX3RM0SRXWu?=
 =?us-ascii?Q?EYhu9zVPIK7XqxqPH8Lp/N6OC2BSnytAiYP4U6PHi6tgQQPVEc7c2QidniLu?=
 =?us-ascii?Q?twYNEk2H4bD73mgNHApVacytXa4sW7Wc0i5yu61tkq8D0eJefIHtELHq7pt6?=
 =?us-ascii?Q?zU6gxWaS6HXh6lyCEoin9T4sAdp64m+aiC3JYjdwGNrcH5HB0Nwy/hoalan0?=
 =?us-ascii?Q?aqHJcnE60HT4kihuNL3aWd/MEbvhdDG3W6qHjL1ah1t64ekFVh791DmKI9u9?=
 =?us-ascii?Q?lWZ5EBip4FbyljDOgrgARoe/X5Cc1C/6wKYv67Oi1J0dovR7Bh0mgC/Yl5w9?=
 =?us-ascii?Q?0v62XfQmtAoJqnH7w/fRYvKxlrbeleioLgwHXhgqldvbJmATfgu3l9y4GKKg?=
 =?us-ascii?Q?TntB4onefY90Ala9ikfPy9lfMpY1y+RjqbcrAcXG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02a20f3-a5f0-4210-a13b-08db8dca7979
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:21:36.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3xxxGIq7NkbnmTRiXWlKbJ42OHw0eSRyAG1Pqo7nnRkylRLGVXgNveXp0/Z4yk49jSNbw0hiGMGkbz1XTKk4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6892
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
system. IC find a bug in the auto stop mode logic, and can't fix it easily.
So for the new imx93 A1, IC drop the auto stop mode and involve the
GPR to support stop mode (used before). IC define a bit in GPR which can
trigger the IPG STOP signal to Flex-CAN, let it go into stop mode.
And NXP claim to drop IMX93 A0, and only support IMX93 A1. So this patch
remove the auto stop mode, and add flag FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR
to imx93.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 46 ++++++++------------------
 drivers/net/can/flexcan/flexcan.h      |  2 --
 2 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ff0fc18baf13..d8be69f4a0c3 100644
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
 
@@ -1994,13 +1983,18 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 		ret = flexcan_setup_stop_mode_scfw(pdev);
 	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR)
 		ret = flexcan_setup_stop_mode_gpr(pdev);
-	else if (priv->devtype_data.quirks & FLEXCAN_QUIRK_AUTO_STOP_MODE)
-		ret = 0;
 	else
 		/* return 0 directly if doesn't support stop mode feature */
 		return 0;
 
-	if (ret)
+	/* If ret is -EINVAL, this means SoC claim to support stop mode, but
+	 * dts file lack the stop mode property definition. For this case,
+	 * directly return 0, this will skip the wakeup capable setting and
+	 * will not block the driver probe.
+	 */
+	if (ret == -EINVAL)
+		return 0;
+	else if (ret)
 		return ret;
 
 	device_set_wakeup_capable(&pdev->dev, true);
@@ -2320,16 +2314,8 @@ static int __maybe_unused flexcan_noirq_suspend(struct device *device)
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
@@ -2347,15 +2333,9 @@ static int __maybe_unused flexcan_noirq_resume(struct device *device)
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

