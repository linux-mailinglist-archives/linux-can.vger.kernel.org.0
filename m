Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAFE76296C
	for <lists+linux-can@lfdr.de>; Wed, 26 Jul 2023 05:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjGZDtL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Jul 2023 23:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGZDtH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Jul 2023 23:49:07 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394B02695;
        Tue, 25 Jul 2023 20:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJxoWezQlO6Y39gHRAHCsf+TfncSKSGB6UPZTyhuf0M49qff4qXq7AUfimAGpQ4KTBCFiHovIhwVD1tKiv2FdR4TjjdtD6FR8HmkQffrHBQx8VxPn7mQ1Gldg3/QtE35y0Tp3IDCy9pdadb9kfqhKKcLcfMWw91/G4cFBcga69jRi9YfI3wyFOVfCNj0ZOv8LGoxsZLiX2BXAgp3rumMJ+xuhS9Ai/Eg0TpO7AhuJhSY+ZaFJGb4ztfRVYBquM4tcSx9+B9THnfoTLd47T5u5aAbipoNA4mM/SZbRkPV794gmkP4rR5Aqyli5Ctcxf2P+XtaQMvalNFZu2xPopIxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKzJIDZI3tCmCYbPRUhfsrCqmxCsO1V3a5Gwi7pWJRI=;
 b=chEZfd4ig+48ey9HGWvBg6CHS6cH7ZLVLIk0XJRzD38/Q4iS7OpAlgI70sjuRpPWxAcZk8EistpweA56ZNdoqXkDfjcumzV+emRKPkEmos8bbyZfqnNVawLx632slkNG9LauhnWXAZvVNtJ3r+nq/zOmWy2lAnQzjIc7uEuBmzEvbSwGCdPsfsWuRn/qqUOXMNXY66k8xuAZuTE3danlOtgQMYbsm4k1zsyfj85+/8RRLe7sFUQRghpPgJFQ0mMbww6IrI9N/h+0lH7nmdt5rSIXUWi4AQ6gENO6MSY4OTmhr5QX6GE7i9o788NKhCo6twzhuoNA72yEDGS90Hr4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKzJIDZI3tCmCYbPRUhfsrCqmxCsO1V3a5Gwi7pWJRI=;
 b=TrmwuDu4SQhKd+FrbXUxN4h7tr5RHuyUxJKedqyxX16syRkQP269bmbnE+QGXWAdpKvFF+U0yA/N6SGAkNytWnt0uJH8PuvlNZDbltb1pz1FU3k2s40N2hDJmKUKQL+2ZHDluSFr9eCtlrRj6acrCO0rRz/CHzTeh7mJ3+Srlsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DBAPR04MB7413.eurprd04.prod.outlook.com (2603:10a6:10:1a6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Wed, 26 Jul 2023 03:49:03 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 03:49:03 +0000
From:   haibo.chen@nxp.com
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        wg@grandegger.com, mkl@pengutronix.de
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        haibo.chen@nxp.com, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: imx93: add the Flex-CAN stop mode by GPR
Date:   Wed, 26 Jul 2023 11:50:31 +0800
Message-Id: <20230726035032.3073951-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0177.apcprd04.prod.outlook.com
 (2603:1096:4:14::15) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|DBAPR04MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 0715b540-9e4d-4b50-deab-08db8d8b409c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDJkentyr6lPt92GmzoQlJgM8mUKndMWngWjXRqzpPTclzmnt6Ue+AeyOVlzglNujJTthHfFC5E+vMTMv+fFiUYRn0/eRm9MK63n9XzpHCJs6zTnuQ9xUPazJRLylQUw61GEOFua+x1QPTuEFmwRJ+kS/+vTCQ4UQ8WmviSGksuIkIE1kC/PLYfEhuqNXGqPIh4CR7MV6YRpQ6CM35RVHyXNVkpincWcmXjQcUhOn5ayI9zX7NAsjJgexuSqi+rkAu4AScC3iYxlh7XR/gN4dfFCgM975CNNMWymlefELVwUgK0kjFtJ3h5+LiLPTZaLH60dCwZFd72YKYXaFf40qJD6hNJkckWcOCVR2LELwgSm26j0dNH0Sxcdo9buGHOq+mcQn4rBhFGbNGZmm2OK3OWhS5H+aBIhubMIif8wxXf2gRSmZDma1Bbtnc6ExkP4rrYu+4BJsjREA/SUZ5wPtB+0ECC7KNqnvFvcFZqgfsCLhNorYFE30FqOOhZ6JOs9qydegYpxhMViUH6xSiEMh0dRM5m1jRnk9J5zrJSahVMZJzX+mHMerIJx6I32tdVxntf8Hbe7AhkyR3rB8rKP2V746pGeKQJ9g6fX834FwVh+M27qgm3GKn09QDu7HpsN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(9686003)(52116002)(6486002)(6666004)(6512007)(478600001)(2616005)(26005)(186003)(1076003)(6506007)(2906002)(66476007)(66556008)(4326008)(66946007)(316002)(8676002)(7416002)(8936002)(5660300002)(41300700001)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czcxMzlybU9XOTBpbEcySnpUU1QzU2lxVXIrUTc5VTJGLzRZalBTdFB5cXFT?=
 =?utf-8?B?UDNtZHZjbmxIek5GTXZRR0thRWphZG9aZGFhOS9kV3kzQXJFSE9IZ1VOeTVG?=
 =?utf-8?B?bVFQMUVFcGE3TDZrVXFZVTdrbDdPNmdLdXIzSnRPaC9iSWxSNkNqQzZZRnJh?=
 =?utf-8?B?eGRXbUN6UDZIUmgzazZxMEtQOVQwMjg2c3YvRTZFRUF0aGhDWmVzcFgzMnNM?=
 =?utf-8?B?ZWxtQVRBVmJvSmRKNVZDMzhqaFRwNkhTUGNYQTVKWVdESEdESitYU0FEK2xJ?=
 =?utf-8?B?aW5jb0FrMW5qWW5zT1AyT3lLaHBxRXkwKzdKUjlnUk5GQk9EK0dTU2VMcGhX?=
 =?utf-8?B?NEVwUnExSHZKQ2FTSTNhZW1LYTM1dkZ5ZCs3YWVnOUxhMUN3VUsvMlU1MVlX?=
 =?utf-8?B?UVUxQjJYRkpnSkxBMldjNzlpS3RoTUM3QWZMWFEzcG5RSnc2Mktpc0oxbklz?=
 =?utf-8?B?Q24zM3psblZvcFExcm9IK2lLcU9JYWdnM3haeVZlQVl0dWZjZFRsTDErOERT?=
 =?utf-8?B?Z2JMVHAwTnk0ZE1OOHhJekhOSHE4RElWZGxFWEFFYkVUZWVsOEZiK0RxYmY2?=
 =?utf-8?B?RSszUXIrRjNmNWRha0hoRjI3alZmd0cwVmx6dDJlRkpBSnIrbXNsV0FhS2d5?=
 =?utf-8?B?YzZ5ekNtaVBqNThCekh4Q3RPcEkzYnQ2bEdmK2tFTHdBRzJ4SEltd0NNVlBN?=
 =?utf-8?B?T2FYM0oxaDdYSm52bzRmR09TNkgrVUdyeVpKS3I3eHpTaGlDVzNFaDd2ajhI?=
 =?utf-8?B?ckJhSHN0R1g4TkZGd1FkRjA2Y0oxTldubGRFS0lCdEYvYlhBcVhNM0Y3bWVp?=
 =?utf-8?B?VVFISnNka1kzbm5kSGdCNUg4MmNXZkd3aGk2NmZDcWpOUS82eVhEY2FlQWlu?=
 =?utf-8?B?WTNsOGFaL2hhQ0VMdE8wRWx2K2NBZWQvbk1pSCs3N3Izb1N6R2JzejEralEw?=
 =?utf-8?B?bjE4cHRtY3VHRnhBanN6RSt4Q3haNzdzWUQ2M3p0RDZPSENhYmtlSVZCa1Nw?=
 =?utf-8?B?S0VjQm5JckhJNG80VXgwdEhtOGFNZk9MRDdQUXJidjVwRWlUUnFTVWVSZmdw?=
 =?utf-8?B?VG8xcWlMTjZxSXcyMlpKUDgzVCtBQUNiTGpFWlJGV080VWVhZzJ0QlVNcytm?=
 =?utf-8?B?eXN0bTZSZjFDT2IrRHdGc1RNUU9uWE8zR1hmVGZDSXVPeU5tQ2ZYUDYxZFYw?=
 =?utf-8?B?S2Z4M1NIVkNjV0NvaGFHOEorUVRLVVNNODF0b3RyZ21KQVVLM21NQjZjczBm?=
 =?utf-8?B?MWJpY3k3aTJaQTVldC9rUXNTd0hXYUlOakFKMldJUHF3dzBLT2JZYVFuZU50?=
 =?utf-8?B?ODNBaVZIUDNuWGRqUVlTMU1ldjIwQ09xUEdTUFhFU2lmM0FzaWMwMFJwSFFz?=
 =?utf-8?B?M3hmV3VpeWVVWlovUWJ4cmR2NkRPNURzNzc2c3ByMHROdktiU3VwaThnT1M2?=
 =?utf-8?B?SHZvSUhKSm0wbjFTK3FyUG9ERFRHWXNyZS9jd3BtTWpMS09PbTQrTlBNTzhQ?=
 =?utf-8?B?elY3STFEVUpjTU9pTVRRRmkvN25VSUk4RUNXYTQvK1JVMy9WSEo1R1ExUVha?=
 =?utf-8?B?aUE5T0ZKNVloNGlNaW1lTmtmeXpNVnB4UlRISzBHbE5oMW1SeXF1V1llaUQ3?=
 =?utf-8?B?d01TWkdlL3QrNVNJNmozY3RSMkxYdFZMWjFrcXA2TDg4YzRWWTVqMkJFaUVY?=
 =?utf-8?B?VGRoa0hOZTlDVUI1VjJnSTRYMHNJTGlFTnY0YndaKy9ZL0FYd1dPNEgxR2w0?=
 =?utf-8?B?cUIyLzlzajNCSFJoUEN6ZWFySVNXUVVQZEdiYUNnOVRWRXdJelUxZ2JxR3pU?=
 =?utf-8?B?TVl6WWZ5elJZOWNFSTNHYVlLaDJCRzNoa1N6QjV6b1R3SkNvLzZQSWswQzl4?=
 =?utf-8?B?djdIVHV6YzBmU0Y2cjJnZUFLc3kybTMzWUl6TEdmOVBZeXphd2pTQTc3YkJQ?=
 =?utf-8?B?R1FJQlVDRm02ZzZHeERaYjhCbFpBWnNaeWxUbENzU1pCa3B2YVU2ZmFVcS95?=
 =?utf-8?B?QzR5ZEdWLzZYYytFeWJSbHNjNlR6QVJqMkFYREpXbFJCZVFtc2xPR3ZZV3R0?=
 =?utf-8?B?dlFqSCtuYnl6NEJSRTNHckxXd2VVZkptRnhoZFRNZUoxTk05NHltdTlVbmM1?=
 =?utf-8?Q?owdLcdjOE+FwiiwU0jcKsLiJI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0715b540-9e4d-4b50-deab-08db8d8b409c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 03:49:02.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8l9wVlDKNNW9rzmeMKxfp1gLLago4E6dFygghuwMBi7S6CZ1SWfh3sSv/8r77/M92i1hPyJHcbnlxTYP0qLU8A==
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

imx93 A0 chip use the internal q-channel handshake signal in LPCG
and CCM to automatically handle the Flex-CAN stop mode. But this
method meet issue when do the system PM stress test. IC can't fix
it easily.

So in the new imx93 A1 chip, IC drop this method, and involve back
the old way，use the GPR method to trigger the Flex-CAN stop mode
signal.

Now NXP claim to drop imx93 A0, and only support imx93 A1. So here
add the stop mode through GPR.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8643612ace8c..d8113a9b11f2 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -280,6 +280,7 @@ flexcan1: can@443a0000 {
 				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
 				assigned-clock-rates = <40000000>;
 				fsl,clk-source = /bits/ 8 <0>;
+				fsl,stop-mode = <&anomix_ns_gpr 0x14 0>;
 				status = "disabled";
 			};
 
@@ -532,6 +533,7 @@ flexcan2: can@425b0000 {
 				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
 				assigned-clock-rates = <40000000>;
 				fsl,clk-source = /bits/ 8 <0>;
+				fsl,stop-mode = <&wakeupmix_gpr 0x0C 2>;
 				status = "disabled";
 			};
 
-- 
2.34.1

