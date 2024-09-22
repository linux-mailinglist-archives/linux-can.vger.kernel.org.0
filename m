Return-Path: <linux-can+bounces-1519-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DCA97E22C
	for <lists+linux-can@lfdr.de>; Sun, 22 Sep 2024 17:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9871D1C20EF3
	for <lists+linux-can@lfdr.de>; Sun, 22 Sep 2024 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8C8BE6F;
	Sun, 22 Sep 2024 15:09:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2104.outbound.protection.partner.outlook.cn [139.219.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5E2581;
	Sun, 22 Sep 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727017765; cv=fail; b=MHeklQ5RUpjr6sCz4nSJZMbDxYvujwGdQgE7rtIai6HocJO6EqZtxM5UzAG84Kw2MrEJw+pk9rZqMsI20LRm4DbSfF70isJjVeYj2N2c6g91FniS9pEuTTar3ltvtq3SUGi3FAyJWIGZVvpsQdzBPYMGMqYv9AdZjcDd8sG82G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727017765; c=relaxed/simple;
	bh=yIv5AywgoYUiexghGCHAegZn/GjkhYyKIlhJZ3Gd1gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kE6Sz2DJnbpixCaxLvDaxExwU5YkOa77KBWxNLfMhCaf1ldJmRuJOwUG312uVC1C0uJ1pwygfuQpTRn1/H96iodf8s/Gxugz5ddYC0qkXkwDP2wG/Xj8v7VWEQrjarUg9d7I+fxVoFsetJhLjbTf7dL1eINniO7Rp2xQ3piJBGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWvscdSOZFMCoh2pB09MxQ36ZOG1GHwPMeeE1/xCsqWCDKbLzVMDxBxwpv/6Dg2i4sI+UYS3RO42EErVkw393+VlnUivdxwnGN8yqVL4AWyY47sA1xkBVWzOwQ2RYLbpdnD7j2go2KIYUBR6ohFoXdZ7/Zg3fP7s6l+TNRj2+RC1fhUqDouoEkm4alO3GYFuU1NtuAeX4x1GYTjnBdkjA68lThR30t84h3na/UXK3jvil/Ng8UyoX1s6aQUGvACwpQ+twAkwydFxZjbLuAaodR7fowsjatoyOkuc0SIX9IMUsbcB1jsitb1cNRrw7e9PBmg9hAhMO4/6eyxzjjS0bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boQOFNz2EK8l2+Om/smGByT0hie5kB/d7HNghFz/its=;
 b=S7JlchTkOStbUQrC60aDwmF5s91e2evWQg46UaLTp0uzzYodD9sX4lKUTDtGYXuYyHM0owe4ZjXYSSPT1RhV4ncd7o9v415yoMGZunhniy93a04aZNqjY6EBAlwyZoXA1qr0EsNBygb5btCYX6rekB2bWMrI1xtNcnMogPO5mp3OJzdEpXJIUGhsoBZKnZ7rCmgHv6mlpfArMKLnIDoPCm08FzCsdR2MPpn8terFMlt8U22ByspdEKEmijhLk0LoAul6gE5J8KXYYpdWm9G5mwiWv38zwmZHOOtvGEC0+20j+37F9FWAdn9sPzySwADJU4427cDNeyfNhxDUYt2e9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30; Sun, 22 Sep
 2024 14:52:05 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.7962.029; Sun, 22 Sep 2024
 14:52:05 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	William Qiu <william.qiu@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] riscv: dts: starfive: jh7110: Add CAN nodes
Date: Sun, 22 Sep 2024 22:51:50 +0800
Message-ID: <20240922145151.130999-5-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240922145151.130999-1-hal.feng@starfivetech.com>
References: <20240922145151.130999-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0027.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: cfea74a7-0952-42b0-1b07-08dcdb161fbe
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|7416014|366016|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	5P4p6SelbiLdbau+aFsXuIQ3zucWTYeq2q6ZVytPDdBqwJPlxGMLL4MlQQVJ6/p37axjKKq4Ip/6Rz3HwDt5x6N79Io+Xcyy2OImpRbKzrHmJw+CGcUEg0j/EsrX6BB8n+68vryGDSDEsrwxR90STdmrINpFp/rDZMN1r6+XU+S1RICcLLg3NT6YJSqlzPDnK83oxi8/GTJ9adwoAV1fWgq4G5rryhAIbHnSmes6xJBEMyJPR8KVMvb3nXALSl2sRCrCaauUlz86vBKMjx+GfhOP3CzfEUNH7emUNm1/trJXR+Pm/keGuKLgUCf7CsqQnoomqcdZAne3PQO9a+LdykIekEhRzVkCrz4giyzvaolLWh9KXM/KSNb7Df3cHcE0REN1vfj7/pVBUMXjxzhlwdOP20WCdpA97AJ5JThb3iICTJ1LmWZ2P38X/uNWntcwFZjt9WfE1v+24kgxLItA2H89/uNUPyVlAePZGACbNgC53NMSzIaX1AdH/ogpGGbG9sMqmghuW8GdCqhlVIwN198G3WB9kwlrtm6Dfnz7XpzqVZETEtdlp4zvClX25Zew+qt/TN66/Smq5Rnh4p4jBhlJyjHs7Lu9g9/61bSJXdYFFm/MIBwRTV4n9rlkFUfFVUx5q3aFAIM8Q5uiwWWbgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(7416014)(366016)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?viW24WfvDb1tv6OLIE9BdZltT2YPPbsxNRq/0FZHEY2/JDwhoLZY/WEWGn5J?=
 =?us-ascii?Q?CssKL3yYfSYLnS98qEbp4dNQSxi3fZM7dBfl+JgUOTUQsYVWZgeW+XSyrTPI?=
 =?us-ascii?Q?XDtc6pXu2G4+XNCSEQ7TEvyQxMEmjZBU484dNMYMpxWXBY6a6w/GaePotNU5?=
 =?us-ascii?Q?gvuXn4cPxuEf+A8iyDAzyJSgdZy20SPKRtELoskdUY+6p8d/pUMKivrq0JBp?=
 =?us-ascii?Q?pofjvXA4VlJlfntF6si4+i+h5P/NAzSrfOgvXv6iIr1hudJXY7IN5WQ+WbB/?=
 =?us-ascii?Q?/mMb8x3YCxZrONyMT+pVtWmnCv3f3GENG46qu6qlAxnxBZnzkVBJr+ILyCSG?=
 =?us-ascii?Q?Z4FjD9+6LzdtElqdtawH0ZniQPJ/CvXMCJ8nZxI7vHPn2QqRTvm2F9HEuZCt?=
 =?us-ascii?Q?j/Zf098BNYdkIhEXtQmPPyD8uiJqEllzrixP1GfRRQ9QUn2tkAz6AcxDe221?=
 =?us-ascii?Q?45b/O8+Wo+byt1BFvND3F/t69oxZflOuLS3KctROdMHXySEPCYQINrhMGvUv?=
 =?us-ascii?Q?Lr7SeR5W4qy+BqxiBSWSyZIjERJoGZN/kVm3d2svurr3QEJWMftBWWGnm+dJ?=
 =?us-ascii?Q?TS2pByrPA62k7/ApH/TN38kmv08kW7vZzqZSsKRKeHPLkC4af+vRfeiaknnj?=
 =?us-ascii?Q?8RfMfNCpV9y9ZxaNVLjTAi4jHxslYVj7U6XmOpohsmjf8dJpH7f+rwNfpmr5?=
 =?us-ascii?Q?SoSWXiDkr7893ZmEZDRNV+rpGNiUxhsu+Q4WBpWCLCnEvLCNbWczbO4pLkkA?=
 =?us-ascii?Q?XgOA1zc45uq6rwib/iTTmGqPIGHzT/ie/WAXFh1bYSQ1Vc+iW1AhhQy0b0E8?=
 =?us-ascii?Q?TfTYPFH7SZ/AUPKc7MSAfvshAh7KtMbpgYCt0bPiMl/vH+4tz6NZ6DyfCfUz?=
 =?us-ascii?Q?VIx9h0g0CLxR2VX//F+sjpCWY0IBCyniFAWmcueXXodPTxNEZZJ8MRPf4FEO?=
 =?us-ascii?Q?WeOPJ+j1AmwBfHoije4Y2egsmJXGSv68/zCKnKqZjJXpf9P9vHnXURBbE5uw?=
 =?us-ascii?Q?o74yP8p8XFGjmI+Z4ipbae996o5RhRu1FacUyF3Q6hhjwkK3blZwuW3H7vvu?=
 =?us-ascii?Q?r2Xq/mMu/Bqk67SNcnU3/3Mcxl+s31dg9YR9BtWrKa5jTVeVRSZbn9b6ChVt?=
 =?us-ascii?Q?sDDLeIEaBi6Sy73C3J1zZDYJ8hnWs4GfQBaEXiTyGtMv7DRsaPi3RShrQ8Sq?=
 =?us-ascii?Q?gY/KOeAfZWSxrLA9hm7NL0OhQVJc2JSQc2a2bsVDNKip2T+VEPN0CwcSr5/v?=
 =?us-ascii?Q?m5X1WKH6H64dePamk+9csPKrPhayYkL/rrjY6rjSePyMETo9TqbieGHrAcu8?=
 =?us-ascii?Q?EBtXytNLfRaenCF39UHhFZdC4mkQ8au0Q7XgWHBTYlo/sQK7ooiPT0IcpRP5?=
 =?us-ascii?Q?Wsf7FZuNJG4k5seUknmNQLMtlNjDXM4yE7vVbvIs9rCeyBn6P3dMN38bq9P4?=
 =?us-ascii?Q?RPFDKjpby+QFYgGAHQUS0q81PLlreU0SUbSGEWL+is/y8M62T1Hi8KXIcong?=
 =?us-ascii?Q?OArfR66FJFDMmAvuefbK3n9+48To5iz+Lwkkueh7oHMAp6c4W8hB0F2O+7rC?=
 =?us-ascii?Q?B2ISm3TRwH8pLKwlOIQ5sIJE6qeXBM79Bvv7GQVvPMW+YnRfe7OZPlpflcUj?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfea74a7-0952-42b0-1b07-08dcdb161fbe
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 14:52:04.9079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4/D3q9LKbwZzsVogxJXMM6vijOUDiIqay45GMD7eLn4/j8BSLTb0PJ2t0OKIY//Q8PeV0bQsPgSPr23RaaAhXAz2z9YeiNk9WxoNM3L000=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145

From: William Qiu <william.qiu@starfivetech.com>

Add can0/1 support for StarFive JH7110 SoC.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 0d8339357bad..368cc40829f9 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -929,6 +929,38 @@ watchdog@13070000 {
 				 <&syscrg JH7110_SYSRST_WDT_CORE>;
 		};
 
+		can0: can@130d0000 {
+			compatible = "starfive,jh7110-can", "cast,can-ctrl-fd-7x10N00S00";
+			reg = <0x0 0x130d0000 0x0 0x1000>;
+			interrupts = <112>;
+			clocks = <&syscrg JH7110_SYSCLK_CAN0_APB>,
+				 <&syscrg JH7110_SYSCLK_CAN0_TIMER>,
+				 <&syscrg JH7110_SYSCLK_CAN0_CAN>;
+			clock-names = "apb", "timer", "core";
+			resets = <&syscrg JH7110_SYSRST_CAN0_APB>,
+				 <&syscrg JH7110_SYSRST_CAN0_TIMER>,
+				 <&syscrg JH7110_SYSRST_CAN0_CORE>;
+			reset-names = "apb", "timer", "core";
+			starfive,syscon = <&sys_syscon 0x10 0x3 0x8>;
+			status = "disabled";
+		};
+
+		can1: can@130e0000 {
+			compatible = "starfive,jh7110-can", "cast,can-ctrl-fd-7x10N00S00";
+			reg = <0x0 0x130e0000 0x0 0x1000>;
+			interrupts = <113>;
+			clocks = <&syscrg JH7110_SYSCLK_CAN1_APB>,
+				 <&syscrg JH7110_SYSCLK_CAN1_TIMER>,
+				 <&syscrg JH7110_SYSCLK_CAN1_CAN>;
+			clock-names = "apb", "timer", "core";
+			resets = <&syscrg JH7110_SYSRST_CAN1_APB>,
+				 <&syscrg JH7110_SYSRST_CAN1_TIMER>,
+				 <&syscrg JH7110_SYSRST_CAN1_CORE>;
+			reset-names = "apb", "timer", "core";
+			starfive,syscon = <&sys_syscon 0x88 0x12 0x40000>;
+			status = "disabled";
+		};
+
 		crypto: crypto@16000000 {
 			compatible = "starfive,jh7110-crypto";
 			reg = <0x0 0x16000000 0x0 0x4000>;
-- 
2.43.2


