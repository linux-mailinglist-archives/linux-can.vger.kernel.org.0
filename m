Return-Path: <linux-can+bounces-4364-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8879AB34659
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 17:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C8E1B2025F
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBD82FCC02;
	Mon, 25 Aug 2025 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eGG8BoYy"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010044.outbound.protection.outlook.com [52.101.84.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF7145FE0;
	Mon, 25 Aug 2025 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137233; cv=fail; b=CvCivFFfK/1+wOVekmK08YFo3yujcP+6pEAldnBAQpcVv0zScQ1pt1SVZCtM3i33rvqzvZd/junwHfcIQfl4QFsL5W6wgR8X8nDk04OaF7NoWrugQZ0/uVRjM/5SzQYEpY73NJJ1YODalEVmud5FQZMgCK7SwFVSgUoNw3cYOtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137233; c=relaxed/simple;
	bh=C7zPiANJuMdqElsm6nT/gBqC+NFy/yc9WMJr7TXejVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VjlQMk7RSoGZs+3JUpaMfhiot2RF6y602oFhEwN0aG9cldgDPjFb6jrug3SLeNu0vswuMZ1+vibKu6l1CaLMRV6SaL+N6ddEjdT4jr0Ex/if8t654aG0G69rOlV2qpiew6Odf9NcAuM28gFlBqJIIVZp59qY8hgTnlVAndI4ZSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eGG8BoYy; arc=fail smtp.client-ip=52.101.84.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CG7Z+ja4Acf8C1ukxlS4PfiGJ+WZVowHz09yiLc/Iaz5I77uSX5K0SHYlU7ro1kclIgXQy7pOf24F9GzcdpjI+xL/vxRXWNpsdT8upYmpOlJsTybVlbPCjOqHLqtuOeVTHJRXDGAkKaBottywwP2NQBtWZZFDgSaBnfQeIx/sulog8CIUojHrPzoakcWod6mT4BedZ/omMe+9vCSi3470UeuEoMwN74ZH3pfcbb5XvQBjsTvZa00M+0Hgg9uCO/aWByTHgunafOGWcg1fKqRO5O0DOXWOAFRcbFClvStni0oE+ZrG4o4EaMOUNeG89viyfR5bye26ibIGxS5X0hSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vVlSV55pG6kwzqGYXdMSZJdmiHsquJ/TnqXl8lFzzM=;
 b=iynWIE9tCDbTcCnI3+OzP+BJQunbwXLn/jxyy3NxJxgNMFnCKfM226px+z8BtGWiCuwbYEzggAx+bfBNfqMKzNmUboSBXi1zTipbARcz7VNk8cuLZYExAlB7hPGRhFTm962KriOYhvKFMFppyOmyVi1B1nT1aBXcyHCSX8GVtz+S8EkPoyT5eMyPquhu0cgDWqnS9LB3HXLnE+9EkMZj4TrAIImXIS/phUH40j2JKCTPSC97Amsf9DRUmZ6KL4zYv0oRbwpaLeBwNkfVxxIrcQbHkZg4YHSuvJdF6ngLLiEGG03tdN3vqNV03TwsjBv4ld8Yt7JZv2rD0ognFlO1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vVlSV55pG6kwzqGYXdMSZJdmiHsquJ/TnqXl8lFzzM=;
 b=eGG8BoYySF6lCkw37Xh0SxeBiQQcslxfhI16Bntzq5Siu6UCfKggGeNrdieKjP1R5EQqG9CchmZo8FcDoSxJe5JWBNoghYzivOMYvZIUWk6Gq2GhY50Vx37uG7ROCIqz4QplgUjTz+oHLFaDMMgFnCI+b3OuJR1iNdQGfh8/eveCoiCmrOj3dv0hAk/zrlNYrP+PxbVHA1m3dNARRb5wn3gcwocT6hbWnigzoKCGntDi2N0ShwokEQb9xs/fqEF1ag+ZzXIorjUm7arac1XJnRTS+/P2D/UmH3shmRkJ5Kx4qVv+G4FhRfz8l3MFrhcq6hqAYmX2rppcArw7A81ZQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM0PR04MB7171.eurprd04.prod.outlook.com (2603:10a6:208:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Mon, 25 Aug
 2025 15:53:48 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 15:53:48 +0000
Date: Mon, 25 Aug 2025 11:53:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/5] arm64: dts: imx95-15x15-evk: Use phys to replace
 xceiver-supply
Message-ID: <aKyHBqT+VG2e7PNf@lizhi-Precision-Tower-5810>
References: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
 <20250825-can-v2-3-c461e9fcbc14@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-can-v2-3-c461e9fcbc14@nxp.com>
X-ClientProxiedBy: AS4P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::13) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM0PR04MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f047ef-4dec-4d3b-e55a-08dde3ef9494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8YT1awrY7SU5oAxfHAXxSwED2P0cqsUY/4e5hjg8Ix+yeRyL3ph1o2G3V9y1?=
 =?us-ascii?Q?LU9K8jjGOMc2B8XIO9vXftiiptoAt9vMXUyd+NnrDrStlPJBOCO75b7VBtyG?=
 =?us-ascii?Q?b+9cs+S7syTcC1aWDY9q4BUTL3Gxu0s4D3B2bfGBfaXSnOtEBgKJvRsAe+N9?=
 =?us-ascii?Q?NV9JKR8NZzme/nuU6i66fqEzMTW4WJIPYty04fu1+rm6jY3RMHpq8fFc92Yc?=
 =?us-ascii?Q?IvyyB4J3eS+9KfiDRnlxCsYU+aI1PJjecJJ/8XJCk+p/mO2mJh5HMt5c5uEA?=
 =?us-ascii?Q?pNz48JJa0g/+rxG8+Ip5olO7/o+LWdh6ebckv3yIQpAkvGZdI0ZIh1/B1KEi?=
 =?us-ascii?Q?nf83ZGXVw0pwfKEcx4AvpqZom3vGVM4LhI8a0yuRQmrLe1im57v3EATh+kBE?=
 =?us-ascii?Q?X5vpt8S5b85bQFnPoxgPiovbdmcxkl3QQg1UiOUW9M+TVHrSExDvU3cf7mTg?=
 =?us-ascii?Q?2FAI9bOgM10ttDfeLx/ByiJ8NK5VL8d+hoeWxxyzOM4h2m5BGMwuSm21XSZo?=
 =?us-ascii?Q?1W3U6GTrcLIJCwpWJ6Syu5aGBNIUPVjoiJOCl0c6jf63qEg2vkW2S/qw1w1x?=
 =?us-ascii?Q?/van/xbYGKN84Gvt0Emr5aBS6eswGXoaXt4vfbfgZV63A2XLhnggOHopb+2+?=
 =?us-ascii?Q?8Kc/CEDAIPzOs29qHscDys11ORl4rcoXC7IE7VojNVI8GLbmeM7wZluvcYPo?=
 =?us-ascii?Q?wwbK5pHaXH3aDpTP/eI8wKVKkvBDkmN+GJPJh/ulu7CjEFajz99s481eeclD?=
 =?us-ascii?Q?Basnsyn96vpvKQbFKJZqa8Wzv9ILN5/BCoti1FnIyT+pzX4HnWXb5zcpDW4y?=
 =?us-ascii?Q?8C3F00AQf3/yQlI9pcpYDx13XqQE8eE2+M7UOATQUoSK1KFsN16LEVP7D7Pg?=
 =?us-ascii?Q?lF2iHN1zHRc13CtcYNuR9Y4uZKWVo0CGHgkjb97wXXru+vGX2Bth+R1VqS3e?=
 =?us-ascii?Q?g22epcpO52YAU2rzO3SjO7Qq2qxIvUIALyepdAxkkZmE7ZRK0y043zhphupx?=
 =?us-ascii?Q?tkfTvCYGQOACOfROBaOHrWVRCx3NwLLVa5vs4UNEQSrenEyd9C/OlGurUo/G?=
 =?us-ascii?Q?u6izHKkc0Beu432hVJrX1Nclls3aSHYEiTEIjRkeN5GzcK0gTzO/biEqsbM4?=
 =?us-ascii?Q?yd4Mle8EubfReKDUeNGy+S1lbJUOMk0bwBlapiOMBnCIqg0yfh3nM6EOs/+d?=
 =?us-ascii?Q?9smmVm4k80BAh5CtRZKpuB0Iq8nh+b8hXf1scviux2pom9p1+0ixnBmIalDF?=
 =?us-ascii?Q?EvIh3LuVkBVDHNO7aS8ElzSpUOMI/mdbj37JOjpBy+TWkR+E0FHVyquRR4Mo?=
 =?us-ascii?Q?+83EE19XhHX9p6aXPvdvDe3K4Hq0k98+z0OoEwAym3QtNG4oh0lQtox8/b0Y?=
 =?us-ascii?Q?3RO6WPPMsIOY9OJn1Lq+PnXI1J3bZJQZbzIz+KiHpJIFpTfYEmxslikV7emd?=
 =?us-ascii?Q?mTWJCCfd5u9NAoGbyenEGQ09YuSkR5CiF4DMc3B0W3r6RNVPsN5RlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t9r5qqqwKUqQLSXw1+led3divjbFjrYlT2HNzq+Zc4VpB/iA4QRIn3Mu2DNy?=
 =?us-ascii?Q?tqbRQPLbMLYxuS+dJMguW6ZnWVGxY1ymAqL1r/J5MdQ51yB1SIq/uQRoDauj?=
 =?us-ascii?Q?dF6auykgOper5/hGEQIii8uwWoDVTotujBzwwnnB+/Bl5CpAr1IlbOEJS0tQ?=
 =?us-ascii?Q?wKdGATQ+6MSp1pQoCsoGpHRnAukKcKn+XcI4bSEp4pV3g2WtPiQmWRw8kThz?=
 =?us-ascii?Q?yv81qyzWXyOXF73id1Uly6s0x+GN4rU5DnvfpAPMgAfRuObr8UVqDwNShecw?=
 =?us-ascii?Q?kcn8Y/XKMYgqHbglPEZqDNz0bGCDdYGh3mmb2K2YNUXEj3stjI+3gJbNE40V?=
 =?us-ascii?Q?Tp5cBzEEmAhvObWZhWbEsaPlQEmaK27hec3ZGi4Ea9Z5qGgSqVfklK5/ZdP6?=
 =?us-ascii?Q?RAKnyi37dSl4hx2E3fuzIJ9trbG3siC1nOuouwPMFX444H8BpjWTh3c90B1z?=
 =?us-ascii?Q?2dGSZIi+MihV6fP686cnhPcfumCgBhO2lWMZb9lJ5sfh1vP2kn5TBcBH4BcR?=
 =?us-ascii?Q?hP2BgndHFTcGL/3iMayk47OPwj7s8JA9A9EIEsjMwIn5CrXo3ufSRpJXSg9W?=
 =?us-ascii?Q?9hNSAzpF20c6pRQ/thbhPMnenkOlpka89PMyVkUwko/LMgop4J3c/V/3EqRk?=
 =?us-ascii?Q?Q9UBuNSNh7uGdVq70RfnwwazjtIHYboXpwCT8vG+PtrnIAV/N8TS7kIpiw/5?=
 =?us-ascii?Q?B57fNKVpYPYxQKrePB8EW9slKxefyeqd50XeIYD0IEbHuR15MN1T8BvDb1gE?=
 =?us-ascii?Q?5/68EhiUyLn9RXH7MneTFuiwv8djsHxa1Gu+Y+C5Ia7OatQYpPwUQYhF6wOJ?=
 =?us-ascii?Q?5fLXLWxhu4I56+xFD4yFioMcQ7jMAwjOKcsAZqn7ZjSsXi+OYVNbX+XCqcX2?=
 =?us-ascii?Q?Ne4U6gV54cM4apKn8rPcmrQ9N8NQI5miyc5i1yh7UfiDZ4lDLtmRdPB+M3CB?=
 =?us-ascii?Q?Xa724q/AFRPCOrtp9vLA20OfVi65yJ3pcPEGlyy10aE4k5ayecBu9zuoHD4l?=
 =?us-ascii?Q?YAc3c6gwjDLfdEpRF+Fbfl/DmcxEyy5JGeNSPDS+VIFQTFUZNVbG3NWFlSS7?=
 =?us-ascii?Q?iyn2XJYD8ZmLQuj/ut+XDuUJHaUfpJnGTVEWXQCevcRvPEXVE157VGNmAFOy?=
 =?us-ascii?Q?IVn4VCFerHWJfdakYGsgUYvvdK6+XCux5fwfrfjMJ1NS6Tz3k9rV/ykjkxzk?=
 =?us-ascii?Q?+LgnjfIsmempIF7M1CqHrVb69PV7/ks9j7PlDgdiMFPTWRuC3JS/HZRmN2wT?=
 =?us-ascii?Q?r/fT6LlA3HQ0/iKeXgonQfr/7tZ1H19/c1AOzSFer4woKFMYTePrtpP/OcEW?=
 =?us-ascii?Q?eA9Y5TzNDf5O4lb5SUmfv/UsExBgUj4Ra6Zrfgm9K+UY0AoiAQh9ALXUDyQs?=
 =?us-ascii?Q?HmoVDQEJ7zDm4CxZK3g3d2JvoX8qoYTMNzdOD8PtFkwjEXCn2XI8uYRM0IVo?=
 =?us-ascii?Q?xqt0XPn6n3snCA0C1ckwkq1oi8ub+SooqSv0aigxFNYAzPCx12os2Lp9X1Ry?=
 =?us-ascii?Q?LhiWqgRVW9B0/90guYobaTvTMV6DwvB3zLvi8utzff8gM/o3qhw7jhOJ5qrB?=
 =?us-ascii?Q?aJOdqMvkOgMvQ+qmxrGDBDAyfTcqfKMrZp49Qg27?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f047ef-4dec-4d3b-e55a-08dde3ef9494
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:53:48.7307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfCR7DkwaNED+ixnnBCNrVKPHcUP7XXy3gRQ9LFbzjzj/ZJhb24OVhQ2lfxxH3txZXLoOPmpozs/+achnxSgbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7171

On Mon, Aug 25, 2025 at 04:36:44PM +0800, Peng Fan wrote:
> The TJA1051T/3 used on i.MX95-15x15-EVK is actually high-speed CAN
> transceiver, not a regulator supply. So use phys to reflect the truth.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> index 46f6e0fbf2b09106e6e726ff8b61522d1359cfa4..f6197ba356d49b97bf7287c3f0f86ef84f89bac9 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> @@ -89,12 +89,11 @@ reg_audio_switch1: regulator-audio-switch1 {
>  		gpio = <&pcal6524 0 GPIO_ACTIVE_LOW>;
>  	};
>
> -	reg_can2_stby: regulator-can2-stby {
> -		compatible = "regulator-fixed";
> -		regulator-max-microvolt = <3300000>;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-name = "can2-stby";
> -		gpio = <&pcal6524 14 GPIO_ACTIVE_LOW>;
> +	flexcan2_phy: can-phy {
> +		compatible = "nxp,tja1051", "ti,tcan1043";
> +		#phy-cells = <0>;
> +		max-bitrate = <1000000>;
> +		standby-gpios = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
>  	};
>
>  	reg_m2_pwr: regulator-m2-pwr {
> @@ -300,7 +299,7 @@ &enetc_port1 {
>  &flexcan2 {
>  	pinctrl-0 = <&pinctrl_flexcan2>;
>  	pinctrl-names = "default";
> -	xceiver-supply = <&reg_can2_stby>;
> +	phys = <&flexcan2_phy>;
>  	status = "okay";
>  };
>
>
> --
> 2.37.1
>

