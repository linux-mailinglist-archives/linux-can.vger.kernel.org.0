Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF98763143
	for <lists+linux-can@lfdr.de>; Wed, 26 Jul 2023 11:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjGZJKB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jul 2023 05:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjGZJJL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Jul 2023 05:09:11 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2053.outbound.protection.outlook.com [40.107.13.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BCD2D59;
        Wed, 26 Jul 2023 02:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Axv3oCk/XbRXU/sfIpmZY2x9CJ5fY1uNzV7Ez9f0zb/A5UMpI0zFhi0BprjK4seuhTWAgPtgrYRyhbbL5mJhamKQ1KnFeLUq74HYhRyvecm7aWUHikuwOmlsr4ZxqiYymQZWI9+DEBn4AC/0ces3TUOVvEBXY5EQFkS7cIUeAP9liuwP2APZX5ic8dCnBUD1sQ9SNJ0AeDhKU7kUsKe2NjLjXWOWEkE9w81L7LRWpW0+BZxOIKRB3fUVDlCqyWQKyIM1cZPnYuU/K0LeRlWoWL8RLKhDxR++Opz+GYfQC5GFFy+TRg256CryF5PNBDWd0u12taltxMokfkMRGG8/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkgp1aONYEiXonWIrKmtj4+JiDEyuW/bDkG9WZciH1o=;
 b=KShjqYrzEUQ1Wb9r0F4CutD9MWMn+EYCdRgL15IBHfRxOPrrtj+havLGr5EUpmHT+O5r+LX1Bc0ATPn3BQ+Qc8uwnqVwE40YmVtE5hdM6PhqGMyzXaHas8TiP8SICvQ4Ba1oacGtRyLZjPJ5usGjuJ72a0J7qb8KIH92tE2/m0Q/tqUJ11yFasGQ6WJLtoggoe3Ka7sxzj1QEG4oKYgZ/hEDwVhGzf5/e7PB5AMTwmfgU+uAnvQWWTduriT5JedzQnk5VMTdfZggBwnyjrFt7l6WGjYlj6RC1AnbzxS9CLyoZlULrKW7Vxn3W046e2kwqLa36NOmvDE2YYAEOOhlbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkgp1aONYEiXonWIrKmtj4+JiDEyuW/bDkG9WZciH1o=;
 b=qcgRGkkp6CqcmJl0X8A69wg0QROsGcJQVX76gEff2rLi0fDQ0nwxq4Xifpj9vf/9iFJF6M3R9wJaJS0JCbNQb2wYHoH4l1O7e+AXEAHVrH2U1kFNieKgswHTNyYRQiEsXfN64BDBAzwW/kUZPYp9GpCw8KPH5oXvqFr38XMDJmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 VI1PR04MB7056.eurprd04.prod.outlook.com (2603:10a6:800:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 09:05:30 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 09:05:30 +0000
From:   haibo.chen@nxp.com
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        wg@grandegger.com, mkl@pengutronix.de
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        haibo.chen@nxp.com, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: imx93: add the Flex-CAN stop mode by GPR
Date:   Wed, 26 Jul 2023 17:09:07 +0800
Message-Id: <20230726090909.3417030-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|VI1PR04MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c29d9d-5041-467f-11fa-08db8db775fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNO7v2GHCoKJOs/hI4W0jMuMs/syjA3j51sEVHBlMCKocbdj5SkE5cwsG5gT5uZYgp55KBS59yhHhXFrwp2EuQQ9tj84K2i2OIvRhcPpcr6rYL862+9h88omybK91H2u35S+Y47F/TuStbMvYgbEhJbb2NQpNi92Exm9bayprrTnawHaHMmmhAslLQu2FMmjFJoFIHEvemjITFxDUwm0HFxI0aQU/ZETZwEcMw6VsuTJJglxd3M4YfeFSL3LNgO5WpOgyLYve3j8JTinJDAJ9Et42uH0Ix3atxZEyYLfGm6JtUvMRhrVbyljIFEzwhQYyL47D8lGpWFqshdnoZO2XIwUT2aLKwQDL/xkcLfOm0XHONlZa+V8OKd8u81k/xHPWJ0OjWLeJV3qjVWpdGz811xGmkf0WXgbLYlUKM+vZ8ciQc+OTHeoeU1e2GH7U+gNhKIs8OgVppxoUkz2SifwTFygNqLRkIYbHZIyZUkHRaQga4anWkU1jpEx8XtUJYqM83Jx28ftuXU3yMpXCVU37u9qiQoGxB2aINf+z8JkE0AklOGkYXDC05U0F87VmZZYIss3GpV+1qaTaqP+f0CkaITkIbIX0m6QqFCAq6bU65TIXnUu82pLozeE92bGqsK6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(6486002)(52116002)(6512007)(9686003)(6666004)(478600001)(83380400001)(86362001)(36756003)(2906002)(186003)(38350700002)(6506007)(2616005)(26005)(1076003)(66476007)(38100700002)(316002)(8676002)(41300700001)(4326008)(66946007)(5660300002)(8936002)(66556008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVhHVXIvaVB5UElldTBseUUycEdhMEZTUzIyc2Fud3E0R3ZqaW1XOCtsTzZF?=
 =?utf-8?B?Qkx2QWxtSmxIU1RxOXZqOUxWdG5HdmpkcndNVTRLTmlQMkhsb2IwTjQvU0dY?=
 =?utf-8?B?YnhTR0RPM3VEMXUyeTIxYmJFeXFha0NMSk1GaWJFZnQvZ0xjN0xQUTRUbDlC?=
 =?utf-8?B?K3JOQXZadDVTNWJkWllNaUtDNytPdXBGM1RYbUIzK0k4OC83bThqTk5jZXNV?=
 =?utf-8?B?U0ZiQmgxMnZIQmM3Yzg5K2dCb0xpWlpIeFZjWTdEM3FVdlBaalBOd3htYTI1?=
 =?utf-8?B?bk5Kdy9pNlRZS1Q0RkZyOXlrYzU1bGRPMUhPcW9zeDlQaWxnNFFSbzVOSHpD?=
 =?utf-8?B?akNMOWhmaHJIQ0k4TmswODhQUnhQbDBVallhM050elVPbm9mdHM1L0Vacjkv?=
 =?utf-8?B?K2ZINGhlTWtzL0NUS0t1UXN6UXRUN1Npb2xMTnNBekQ3aUw3UTMzQ3czYXAv?=
 =?utf-8?B?RGZ6L3lRVC9CWS8rK3V1TktwMEN1a1FtUUFaU3hxb3BjK3VVU1JDYmh4SXpx?=
 =?utf-8?B?OXlGbDBrSTJzcVVSOGZSNHpCMFEvK1VaendKV29HYlMxVnVQbEZJcmJ6OGp4?=
 =?utf-8?B?WEdrdWlwdHAvUWpFYTg1UjAyaU1YZVczdTFWUGFCYmVKUjJmMHpzM1cybU9p?=
 =?utf-8?B?d2RGM3JSbGJZb0swVDZVZ2ptV3NGbEdLVldKZ3BPZVFyekxWR1IzajRndGJr?=
 =?utf-8?B?VEg1RlgvQmg1MDVaTGpKNy8ya0JhcVhhUHFENkF2R3pWTkxJRnF2R0l0TU5i?=
 =?utf-8?B?RklvVVVuaVBoWXYzaWM3Nm1DZXVnM2p3QmJRNDRUb1hITDc2UUVSNEtVYW1W?=
 =?utf-8?B?ZnB4NmRNbGJ4bkRMUmtxdWRkRVFSanlVUHJDZEtyRGFiMWZTWEt3VFRqQ1pU?=
 =?utf-8?B?QTBqanRWMXpxTTQ4dllpSFFVUGJ3N1lhVGJublVObmRETDlJT1ZrdXhHTTlx?=
 =?utf-8?B?a0x1aVpBRWx6RXFmeXYrZzRzL2xsK3JCVGpsSVQycjJDNDBtSk1PanR6RzBt?=
 =?utf-8?B?eFBwUkwwTU5hUFZvaVVNOW5BMHpYWiszU044UHRVRWZPd3V6ZHRmREhGQWZW?=
 =?utf-8?B?S2VHb2RBZzlqOEdJQmMxelF5czhSN1JFdGEwUUVydEVKYUhuVVc0aXpYYk5h?=
 =?utf-8?B?blQzdTV5WFlhNjc2UTFsT2xaNTNtWFVhVDdDalRpZEhDMEJoMmpMWjJydGNT?=
 =?utf-8?B?YmhtWHloR3liMUtLSGVoVENrSXY0L2ZnL0xsTXJCdU03QTVZR1dOOG5KdFFr?=
 =?utf-8?B?bnZ4a0hSTGh0ajZZako1bkVsZmNZeGFzRGpzSlV6ck4vNHhlS01tVFFnRkZw?=
 =?utf-8?B?TVBqU1A4VzlXeE1vVnZqSm9kUVduNG1Rbm1tS2dXU09oNmpyRkZ0Ky9yVUV6?=
 =?utf-8?B?MUxENnd3RlpsdkdLcjdMOUZyREFMZEIwOFpNNHFxNFRWaUo2SG1KU1JJUjht?=
 =?utf-8?B?VzBTM0JBdzdTbDZIanAxSFJHNUt6b0VORkI3RW9UaDhvcmtTNHlDQ1JON1o0?=
 =?utf-8?B?WTkvaE96dVd2Y0FQUTErMHY5NEZrVXRDSFpIM1hzQ3NOc2pnbTNXbDRzMWRQ?=
 =?utf-8?B?ZTVqeFpidDlIdkd4SW9WMHp5eGd4UFBDVlBSZUdITFhyR0p3VUlUWnBmWHRp?=
 =?utf-8?B?QlVqVjBicnNsMTJ2dTBQUzd3d21VVzdwaHlqV3BaaG9GcnRha0E4a3lGME56?=
 =?utf-8?B?UGtxSUVYZGxxZGhGaUR4TmVlUU4xeHhuS0RZa2hFdmJ5T1FsZWR0M1pSL2dq?=
 =?utf-8?B?Z25zQmpyZ0VOZyszMjRVQ2RWYTNxclhFRmYzbTVscHFzWE9LcWJXbE5LSTU1?=
 =?utf-8?B?R3Fha1p3NDgwczY4bEdmRTZJSWx1aEJZaFVrZUtxc0hOZzA0MGJoa1RncEtj?=
 =?utf-8?B?dGF5WStFNUh0azNwWWwxa0FNNzZOUit2M0J5UERCbkZ1YW56dDZaQmRva3JF?=
 =?utf-8?B?a2lZM2pkdXNpVEFENUFSUHdxNXdkL3M2MStCOWdvMXpwSXdjRVV2b1pyWFlz?=
 =?utf-8?B?SCt6Z2Fjakt1MVFIbUdvUHp6aGlLeVVqVTVIQzZRREtxWUk1NnVCUkc5aDFW?=
 =?utf-8?B?REF3SjhJajVHQ2oxS2RCRkZuR3JSanJPbEttazNvZUJRbXltczRleXZHZ0xF?=
 =?utf-8?Q?YymsgkMXUBu/OiIq8Td1WJHlT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c29d9d-5041-467f-11fa-08db8db775fe
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 09:05:30.3257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6S8euYm+pM61Vn4Aq1+PA+LMGw9pVs4hj0XDplnLkNb8VsILN8dM2vdEeaM/emiqXO5olAXb+FAgRc2F2p7dKw==
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

imx93 A0 chip use the internal q-channel handshake signal in LPCG
and CCM to automatically handle the Flex-CAN stop mode. But this
method meet issue when do the system PM stress test. IC can't fix
it easily. So in the new imx93 A1 chip, IC drop this method, and
involve back the old way，use the GPR method to trigger the Flex-CAN
stop mode signal. Now NXP claim to drop imx93 A0, and only support
imx93 A1. So here add the stop mode through GPR.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 4ec9df78f205..d2040019e9c7 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -319,6 +319,7 @@ flexcan1: can@443a0000 {
 				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
 				assigned-clock-rates = <40000000>;
 				fsl,clk-source = /bits/ 8 <0>;
+				fsl,stop-mode = <&anomix_ns_gpr 0x14 0>;
 				status = "disabled";
 			};
 
@@ -591,6 +592,7 @@ flexcan2: can@425b0000 {
 				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
 				assigned-clock-rates = <40000000>;
 				fsl,clk-source = /bits/ 8 <0>;
+				fsl,stop-mode = <&wakeupmix_gpr 0x0C 2>;
 				status = "disabled";
 			};
 
-- 
2.34.1

