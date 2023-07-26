Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7574E7634B1
	for <lists+linux-can@lfdr.de>; Wed, 26 Jul 2023 13:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjGZLVp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jul 2023 07:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjGZLVo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Jul 2023 07:21:44 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2080.outbound.protection.outlook.com [40.107.241.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D39110D4;
        Wed, 26 Jul 2023 04:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6YVy6M1VItomtlEfxzaHu9r62t8Qy3pXJpaGeWdy+n323GK8cDfoyf6yZXBNWzOlOJWzH9Mx8HUEp3YFqq6Xo+FdQoNAYQOzdPwkoj4BjKfodpFabC6ddVkaRFlT+nl4vMUOEdSKyKYvKfDTW9xR/a6swsQoKHfAipSH8nBHhIp34x0hlty3KmagrtqmxykRB1/gAh/i2lS959lcm7YkSDKVDmg3mkO1zziWhGZsv8YqRxDW9FrvzAyXtan5JjyuFHrjNEnzXBNvt6Lb+WNIzqtJtnDq3gjEB4L7rXiUKYbXg1uOiTl6TgHtj4dhoF6A+i2AoDfBrK8NC5ed2jHNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IOQxIa8FKC0yUlr0xsHuBIdtG+zywvS5eDQEPXrJo4=;
 b=g8E5en/jMQtCXwkUVmxTNqmYJwIC6xacGzKJe4LR3Ny492p6r/zdMak/z8x5LOHthrtw3oIgPXcCYwrS5YZPXxolXSZw3le35rp0gAXIgls+oH62iCqoJ4mMhEQjAqR3+owELgusGsDoJhKl5kDQeQKIESv9GVymgQ3cvdg0K04NVQNMUm+ciEkrYL6KFjlt5Z4+uFsREwcQyfu2YB7iZ7/keYYOehTWZSo/ugpg67fG+EqGxGSu1tOaYR1QLCFUPQ/O94KZMc1I/t/VnDV9UJ8yyFu5o/EZmlP2DbdRmpmNFbPGSts42m8sR/wKI8inBt3OcRJTJO1x3sCJZZjyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IOQxIa8FKC0yUlr0xsHuBIdtG+zywvS5eDQEPXrJo4=;
 b=Y5zQgd5oZVxgZ6cUkfOaPAfM83KJkdQKm1o3fSH2w59GHXIwBIQhteTEVuKw0LH6CIwbFU6gqgI91mm/qO1kkNDM4dkpZKH00iPK7YMy1ktHBXjHLlCrKH7AAlunI0wNLZKzXIHB7UnYXhAn4woOQdIHezTz/rPSrgkRLdVn2R0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DB8PR04MB6892.eurprd04.prod.outlook.com (2603:10a6:10:113::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Wed, 26 Jul 2023 11:21:31 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:21:31 +0000
From:   haibo.chen@nxp.com
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        wg@grandegger.com, mkl@pengutronix.de
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        haibo.chen@nxp.com, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3 1/2] arm64: dts: imx93: add the Flex-CAN stop mode by GPR
Date:   Wed, 26 Jul 2023 19:24:57 +0800
Message-Id: <20230726112458.3524165-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|DB8PR04MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: db47d5ad-573b-4b15-5c9c-08db8dca767c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nyO6F1nn1XhuY1ex9HGqpiV3XtayohqgQpwhf3LwhpWOeuRwkFqm6ODv/twM70igBUxJDQLVeuJx+pBurtBzuQgFyW5p313Yh3Yz5iVeLfkNTu+t52z3TVnjHclcCc0sSTxjLzd/M0MFMaarc2HSa9fj91EzyyfUAgIBN4vZLH4UD+rQ0wciZauu43geeyYrEkZcXjfVsZv/h9J5SIxjLDTPMhggBtEVz5lrXFmbz4hL4ahtz+wMy04scOMUErC50qTyVBB6FZoQr2x9I5AMqSUi9QP8keHpXZg2a8q9ehtk1mfXzY3wg5ln8NA0sk0sCO/v5atqggk1hsSteA9QGvLUB6TJNer1xqirobn1qPX5mV4jdrti0uQezR0X37AhalF1eCpgFlw6JMpfN7oUP1pEf3z/u9hcRmEurer7f65zlTu8RJdsOuUp/IxZwSZOD2NpxnA6m24Pduu3mtDq+XfQDMThmM1rEzW1xa6uoWJE2iQw+MT5GbaZkPq17pE/J5ATNRVlEjeQ/KSy3TIy6BwamHkB1gAzNUEaGl+M0Nhb54HDYk4m0FDoiMYKhg0vXPq4mN18Qkg0qCgpAvwnZ6WLhxQ7t8rmViotCJgOuHKyxdukWsqyvGZKke79y1Lw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(2906002)(52116002)(6486002)(6666004)(2616005)(38350700002)(38100700002)(36756003)(186003)(7416002)(5660300002)(86362001)(83380400001)(41300700001)(8676002)(316002)(6506007)(26005)(8936002)(1076003)(66556008)(478600001)(6512007)(4326008)(66946007)(9686003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHAwR3JDVFk4TUVnbTN2dlNuRkJYbUhCejBkcUh6SDVOMjhJb3o4VnZDenZp?=
 =?utf-8?B?MWdiTGlqSEFHazNrSnFRV3dTRjd3YkxBUFRGYTFQMnBudFNvcTVoUFdjMHVS?=
 =?utf-8?B?UXg4MjNRTFRhVVR6YXhWSzNldEdIc29Rd0pCNklEcUVIL0tlRnVPaXVTV3o5?=
 =?utf-8?B?VTl1aGY2UlcxaXg2dlRCT2x0QnVMR0VwZ1JuOGQwN25wNEdBUi9kVUxkRnc5?=
 =?utf-8?B?M0RkTkpIRjdMbU8yRXJWSkFYOHd2Smw0MXRvZVhQVmlORXgyLzA0UW1TSEpL?=
 =?utf-8?B?SUE1L1ppc2N2WExvVXpWS3BnZVdjazFkZVo1b0lwUVlSSDd2bzgyUTlST1ox?=
 =?utf-8?B?b3NNdEhCZGdTaUVtSjd1dXg2b0ZtTGdaendnZHdRek9GMWxIYUdIamdrU1Bt?=
 =?utf-8?B?WGs4emRtN3BwR2NDM005YitlbnVCZmczcWFqY05USFdBU2tyVzgxY29pRFRB?=
 =?utf-8?B?NzdoU2llWlYwZHhUZFA1TUhoc05ERWlQVzF5ZnRxUXBMeG1NRUZjUWpoRWxa?=
 =?utf-8?B?dHNRTFBSSGRXejRHcVUwcCtsaWdyNmhuZ2NWTHlpUURmZGE0Z0U1bXN0ZitU?=
 =?utf-8?B?TVVUbS91d3EyZzQ1QVFIZ3Q3VWVVQkw4Z2RPV3E3dkRGbGNaQ1pqcEd6RTc3?=
 =?utf-8?B?bmsvaVhHbDQ5NnRVNWVNcStGTU94a3lUTzRRSlFtaVZBOFhPMjhML3RJR3Fy?=
 =?utf-8?B?TkkxbHgzK0ZJR3JHNGdrYjdOcU1KM2pyR3pSUlFwbmxjZWJaMGFIeE5oOU1k?=
 =?utf-8?B?RkVpTXhmR3ZINUV3cEpkeHhOR2NMRFAwOFFnZUw2SjJLaHBOYWFST2x3OWZS?=
 =?utf-8?B?WndoblVXK2kxMTlRZUQwc0FzbDRJeWVnWEE3eEwvN0I4RXRrMlpiYXZ4Qkha?=
 =?utf-8?B?M25sa1JkZjIwbVlsK3FIRXpGczMrUnlkWm5nOGJYQXBNdTBXa1oxUDluNU9B?=
 =?utf-8?B?Y0RacjdUcHBJcnhZcGd4YkpzRk5rbDhMR3BtczROdFN4elppM294a1F0WHJo?=
 =?utf-8?B?SlVDVFZYWmh1UUNnZUNWalJBVTEzeHcvTzV4bjFqWWFNa2RCWXlMOHBES0ZV?=
 =?utf-8?B?T2lmc1U4SmVNdFNqSXFtQ1lDOVhDaXFiRjVod25sbFZ6Q24wS2FDK0VkOUta?=
 =?utf-8?B?ekx2emo2YlhzOTkydlNYUW9pVEcvMlBKdnQ2bFUydE5BM0pZa2x2bWZFWm13?=
 =?utf-8?B?a1E2eU1va1JaRlhvb1Y3dmpXd1FvSkxXMEZRRGpDakhWRks5TSszV25LUUN0?=
 =?utf-8?B?VW1jc1QrbDVsdHEwb2R6Y0RQVkpKY1A0cFNQU3hRc0VQaVg2UlpJRi9zeEt6?=
 =?utf-8?B?dVpyL2o0MWxYci9oL3JJQ05JY0JNQm5jWHFodUp0ZUhaMzFaRzcxT0FLakVi?=
 =?utf-8?B?MEZBcEFXdFFWVHN6dzlQR2UrZ3ZIUVdhNGVqeWt3SGRxU2Zxa1I3SHVBZGpE?=
 =?utf-8?B?RUZ0alRzbjRxbGpwTkJ4K1h6R0NwTWJEbnFSR29SbXlFWGloYWVJOWJnN05a?=
 =?utf-8?B?Q0QwaHJRNWppMERZYW1TL3VKQUp6SlFlcnBWdUFtQ2Y0aTNTSTFOOWxLWDVB?=
 =?utf-8?B?NGdVbWo3T2hEajVqN0k2bFBMb2tQaE1UNjJvWUROV3V2clI3OWU1cElTczZO?=
 =?utf-8?B?WStWcG1xazZWVm5pUk90bXBybHkxQVlSWnJHenlxd2V2SG5RM09zNlZQZHJk?=
 =?utf-8?B?eDNnbndFZCtqYWU5R1g2aUtqU0FXOFJwUkQvd0VlVE1qamJGWHVkaXQweHVU?=
 =?utf-8?B?d2kvbHJkYWRGTUtEYzVSdDVGMTFZU2Jpa3ZDNmFvUFJiUUhCTVFCNlFtRHVu?=
 =?utf-8?B?Y2tLT0I4bXh2SVA4RVAvOHpBZkdaWXlaT3hoWXVET01meisxSmFxZjlHbWVu?=
 =?utf-8?B?Uk83L0ZpRUFkRGxleVFXTWU0ZnBUd09uN3VWSjJlK0hnaEdVOHZObW5FZWZJ?=
 =?utf-8?B?b29saVpUZUxPMzZ6TmRWdjQvQUJSZUxaODIvM0ExTENLUEdVSGxDdDlncGdV?=
 =?utf-8?B?K3QxVWFtMEVpaDJueUI0YjlYZE53UzRkZGhZQ01vUXRDR2IrT3Z3V0JpOXFm?=
 =?utf-8?B?akc5c2ljem4yUjROMFFkRnMwUDlrQnk2NGZpb1NBRmIyYitzNUxIY09SN3RK?=
 =?utf-8?Q?STji5jCx1pAbbPwYqY/XgbwAX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db47d5ad-573b-4b15-5c9c-08db8dca767c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:21:31.6428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zp4guQRAJ6nTFdbEUhM7H6kTyNkM7Hp4wGse/erOq5sBB5yzs70C35pLtf4RyPeBqNLsoRNR5pL28x44G6m7w==
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

imx93 A0 chip use the internal q-channel handshake signal in LPCG
and CCM to automatically handle the Flex-CAN stop mode. But this
method meet issue when do the system PM stress test. IC can't fix
it easily. So in the new imx93 A1 chip, IC drop this method, and
involve back the old way，use the GPR method to trigger the Flex-CAN
stop mode signal. Now NXP claim to drop imx93 A0, and only support
imx93 A1. So here add the stop mode through GPR.

This patch also fix a typo for aonmix_ns_gpr.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 4ec9df78f205..e0282c4ba11d 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -185,7 +185,7 @@ aips1: bus@44000000 {
 			#size-cells = <1>;
 			ranges;
 
-			anomix_ns_gpr: syscon@44210000 {
+			aonmix_ns_gpr: syscon@44210000 {
 				compatible = "fsl,imx93-aonmix-ns-syscfg", "syscon";
 				reg = <0x44210000 0x1000>;
 			};
@@ -319,6 +319,7 @@ flexcan1: can@443a0000 {
 				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
 				assigned-clock-rates = <40000000>;
 				fsl,clk-source = /bits/ 8 <0>;
+				fsl,stop-mode = <&aonmix_ns_gpr 0x14 0>;
 				status = "disabled";
 			};
 
@@ -591,6 +592,7 @@ flexcan2: can@425b0000 {
 				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
 				assigned-clock-rates = <40000000>;
 				fsl,clk-source = /bits/ 8 <0>;
+				fsl,stop-mode = <&wakeupmix_gpr 0x0c 2>;
 				status = "disabled";
 			};
 
-- 
2.34.1

