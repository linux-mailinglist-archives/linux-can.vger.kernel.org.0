Return-Path: <linux-can+bounces-4365-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 023EEB34666
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 17:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9DC2A452D
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 15:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C8D1E6DC5;
	Mon, 25 Aug 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eyFwikIt"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013046.outbound.protection.outlook.com [40.107.162.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F22F4A1B;
	Mon, 25 Aug 2025 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137355; cv=fail; b=Obaeb7hYrlBGL3dijIutBClxXU5RTqZ9pSoNFGvAG8nqLBCvSWj4fPQNX6OHsNGbizxFPZpmxp0tx8Rmn/0nQBzJHPqahQa/VXtrNkRhYZqzkgiGP3XSvJ/jzC2si/bwo/ec2HwtQSeu9FpRIVIc6zUkv8qmxEqGlIoAi5NU3m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137355; c=relaxed/simple;
	bh=OS8/gr91f6i3UrAY10OJK2Di3OajGOw/33HVTTpzYWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aQ6NbL8iRR2go1tTo5vlABGBIr9EsVvcxdO5al5I5tzTgX0Lbt2e82IqHKhZQJaDbsdm4Sh9oOiMm0yLJmlghMtfUfOocvY204iNaVXVjnOefZO1hAWR0kpoGBnAf+FyIubWV1d6mtl2rBGpB41os1muFPEaelj8/cKibXcptuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eyFwikIt; arc=fail smtp.client-ip=40.107.162.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZScElYaTUCqZxl1caT+Vf2O5YrwCYd3QULH7A9Ykbljt6vQ/ocr5fP33ruCsmxcjivZLVwjBtMhGu5mfhhIvHdrkQS9sluPdxfNPC6pDKxJO3MjFb3++r1jo8Q2qivF6sYzdrWrpu2DoXZ13ozB2UtoK1X+2OV3jgckZ6BjTaJSz3+zJi/KlAtWhWPp8cU74POZX/q4e9Fx+7OPXRRIoCcdif0g1TTSApY3V0nyMGwycDMayKxILAT5zHPyl5Mq9CiXj8D2AVG7hs8rkk00y+atcaMT34XC63tKgrE+Fo4KPF+/CXXVvqWrCObQyKDUu0oYBd5SAr5FOvvb7U29Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j81oU7h6ABS8mu4/DagiCSXowt1eIsZjjrFZIC0vquU=;
 b=GZhXNV8HP9/hdAb2WQtJWngdQ45jlNEX99Lr/UBLLCjZDamGbiV/Chukuurn/KYBvbMZyFH/aSr5EsFoDEGafqxT9OkX3YFCz6rJavpw836G35uB93ERc/Jsviw9UWONkXejG5hDEs8s8ixfIyiZJ3XseMeZHZv2lhqCKq1thnINui+QMd5gvmLgbUWu92b+qe8ROGPCPGjZB6DD62x/S1MvkzL0EBBZxY6rddvvVTO8IKS0iXcKwkQjPuxqCd+k28q5r14lKGmn6AZu0wfHlPiagP40Mvf5D9enbVubEgC9EJAaGrqgLxJLKFFQ8lOVipXF0Y0cEpBia443s+yXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j81oU7h6ABS8mu4/DagiCSXowt1eIsZjjrFZIC0vquU=;
 b=eyFwikItbn0VNnAvK7TdtvH81O8GLRtVv+0oZ6lEJhbk8hZ2+NBl+nMppa9sFsTQtvFBvghB80Gt9PQtpMjJ/CdkLZeix8RvXCvOVREBTdH40WLiPi9fUWacsj8IF4nnIhNdwnycHCUl72tVvusiJuHrOk3vVZXaznAHzRGuZkf8s7IqxZACbw0YIa+/mZo0pCJ5idQ7YKN82+zTGrn+ht1p2fYtMLuiOLgGk4QcnowuvyIXR3kHAU7zCEIea2Qbu99BLFx4KJAJ0xUwGzZQGbEpchdGcnIZLLEM45kA3fxn/GtnwVD8p8bRf6EzKgWJfv3MdQ+A3abfv0FliXiFpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 15:55:48 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 15:55:47 +0000
Date: Mon, 25 Aug 2025 11:55:38 -0400
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
Subject: Re: [PATCH v2 4/5] arm64: dts: imx8mp-evk: Use phys to replace
 xceiver-supply
Message-ID: <aKyHehTGrQHWQJaD@lizhi-Precision-Tower-5810>
References: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
 <20250825-can-v2-4-c461e9fcbc14@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-can-v2-4-c461e9fcbc14@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::29) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: a71a7b84-28c5-47df-231f-08dde3efdb5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7oa0Of8KE7aliVo0NsOWzwfpqgS0WRk1qfKnrmgzywfxem2hJoSNcInbYVQS?=
 =?us-ascii?Q?iW7JR9QvMz4s8xypjq5ChnrRva4837Y7C66DGQl0bs2iM/c5Tmx3itakIdVb?=
 =?us-ascii?Q?LTLKnquWRvraFlbb+ZiFL7ZnDwP2KZp3rexOYrL9RfMVwvjKlLySbmqzEmcG?=
 =?us-ascii?Q?kkwoQ3rl7/w3nx68WJOO0IfLRAPhLXC4GCQzLX6CxhGEzItC6PF1uZgdi+GE?=
 =?us-ascii?Q?D5sJmK9vN2hB+hd7lbZEjbYaqUwZW9qXPxt/Czja1GSMwqCbR1a8nYPew3aw?=
 =?us-ascii?Q?6Wd9a5cnior/ALSCPBDJb1iYNeSlXc0H1x/S3+oTWqiKSVCxvmd3LNN9vsjc?=
 =?us-ascii?Q?mQ6qwa0iVmwc0GiDtaw8UZaGxPBnRaRkcSAgMpqBZTSjEPLkflaqGuNSlV+K?=
 =?us-ascii?Q?MK12Lqm5SYSBjT4jK8e+icqtHbIL6cp160fksGup+CeDrjbQxXRdb45qVsbb?=
 =?us-ascii?Q?eq/DiOqa3meMc/q/hkQdmBvT/xXXYrjvStGWrQuRD0/2x0mUeBdc6tBGlDi4?=
 =?us-ascii?Q?vAxhC+sTtzQ1TzPbPZTwuucSYXT5hE5wk6sHQqKiG/fySOWz9z0ub1RmH7km?=
 =?us-ascii?Q?rhAHkvNPvzUipXs9Bvbs7bp8LG8r5mRdMUKIx/nGrVA07pTFeQI62wPRgcer?=
 =?us-ascii?Q?EcRL4RZV8cDtrhGpmugcten6Vd/nNp92ReHcMRlf5NqPGM7qJuw1z6JwwIbq?=
 =?us-ascii?Q?raI9fXEsPszE7ityWsBAmEhLfgAtl9b0VaEBk/EyuF8lIMpycWt99enN96I5?=
 =?us-ascii?Q?Y16zShlIKeOFDJnB/QXkzj2DFOI6K/rGR78nnxAY/3PF0zhTiv5DoY2bfDiA?=
 =?us-ascii?Q?aYF/YFOnmuEUFhsjGENC+cWB+2XZZ+yds1YHUdvc4za3/5s5UJda/hy9lgPO?=
 =?us-ascii?Q?5esVeic6sRKeupw7EIxgHxUFPuCt+icQ0TaH5r0iwLeZoOrFV5Lj8jwnKkYe?=
 =?us-ascii?Q?v7lbAjQNE6RnWD+9fc3lmgZyRNSA1LLW/s/3pQfjyZ273CcVTzjvIJKFWfFL?=
 =?us-ascii?Q?R6m+7cnt+1DBu2Wl6d5n/KoATuye4gW3wyZZSafxO3KSvmvFKdVOmv1bDURB?=
 =?us-ascii?Q?QiQEPgyONbDnkMA3TKHQHIhEA2vBNtTdogfebWWTO/rU/RKpyq40lKWEZ/Nz?=
 =?us-ascii?Q?wv86IOO8ZLnckuLqU6ddnn3IfaKB+r5x/c9OZo0sVIod30wf/Xoehulu0rQj?=
 =?us-ascii?Q?dR/34Ma6q7ox7WlC7ZUBU6/+YGNDGnifmML8v3WPrUkh2gzTPGWfLVVgQyWH?=
 =?us-ascii?Q?ruO/TW4tgsLQT8hnnRldW9WUONhK6Q8Eszo463B9yoyExVasRA53gzm6W62O?=
 =?us-ascii?Q?4Xpv96Qp3coiQqXgxWlsVcMYNhlcq1aS8AUf+FnlEU4ngBNquJtkM+AIUZ85?=
 =?us-ascii?Q?C3H/ofzYAkjAxssJMAw9OpyAMFOkBEUDZ4qBcbnPWJvxGKodpQ/yMYqwV4nC?=
 =?us-ascii?Q?yFkz2R6Ue4zRXLfzr/5Wz1DHV04ewaLz3AIxldyT2vismCS2W5qKtw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ucFFrcEbM4lV+rZTAldT05ky1pCkdr0YuKAlBGhpYI7cjlLaJ3fbgLobD8QB?=
 =?us-ascii?Q?05goKOGRcD0g870JsHFoXmmq8o45JYCY6NcShhUaAEHocHmJlt2W7jKAaNWd?=
 =?us-ascii?Q?5KMbeEh9oRJlGcSd9Ifz7mzutXaMb1kYu5JHHtHA3VuGJ9iY0MlaRAq7dYaB?=
 =?us-ascii?Q?Xh2tfOdeQh04IvUFsoj9wUe98SVNW4J0xnWozzkJG6Sg7TrjQeE6zTa2uWkl?=
 =?us-ascii?Q?lfj4mmk6goKVT6GyMQjbE0ILzPDgOpAjcPXUz3CPm0NbhmAjvJvrP1MIWWf/?=
 =?us-ascii?Q?ZrmylwJTsBKD5jT5dNLg4ZojWo1+ySjaAerpMmS2vV/TZhajWm48fQlLx8Cz?=
 =?us-ascii?Q?htHARTKhw0L4mlpKaXjXjLpyAP8Eu4Evv3FafY3nG9k6YgTdU2aRjLdIeuAX?=
 =?us-ascii?Q?07P7N1oHLQVhiPs6+JkZJsHjd/ZiQ4Ys4nKCGbxtchgvhYl2xZ5lXlBgHqk+?=
 =?us-ascii?Q?ML2I/7a1u2vv49G5K4k5Ql3i82s74eRe4o7ivGqKkUszdIonNdg8OVph/lVE?=
 =?us-ascii?Q?uxeNcFcoG0VDtqaw8Ls3EBkLWgz2f4OVbFBXeqiiuSyFwiim9j8h8Yrd3gIm?=
 =?us-ascii?Q?MDmRrWW2MQlpqkBX5ddxPOSC88G1Ky1EXD3a3jCQxhHGZA1TQoRWbU+5QpMx?=
 =?us-ascii?Q?zzfu/UWsEtmpM6sboO8GkljnLBr5xiTAVQtr+wqfexErUy0ABa1KfAPj8fJw?=
 =?us-ascii?Q?FoEMlvH9pkHl7g9dgr426d6okl4WyUHJDxNgu7mpmqBixSbX3K7Hp3SFjoW9?=
 =?us-ascii?Q?vZwRood3eDy+JjdGRnwST3C7dU8KU4GodTm5C6Tr9Ytk6eHYPa6q4xiq4ju4?=
 =?us-ascii?Q?QrBmZUf4FH6SDgEsavYZg/vEl9AvqaOcuiRn9asHGoiSo2yW6Qp2qWdGDs+g?=
 =?us-ascii?Q?qpi70SZChE2xz7zyAdV+3+yls+9A8aix5ThZuv8oNfaNd7pevL/Vqr4FnB89?=
 =?us-ascii?Q?xhk1M/7TRLW1ICnVnFfooZyRmHE6CiunEs76v2LBs2qaUUnpHrvnWYyTPhgw?=
 =?us-ascii?Q?gHnXTP5920/jWuVNKEiokDNe3dNJDYn5akoEwShJp1xGgk6JT5gZD1pnaca+?=
 =?us-ascii?Q?aeFd88IHYeFzSgT9mhKc7O0GfV5jsYQdHcP1IDFzzm3ePTyDuYOM6WLiJycU?=
 =?us-ascii?Q?NF3TT/+Cd+HvHlDnOQQ2bOaUZrVZUV7yoAkO++DFKdg5BR0yXZR0Ms628kEJ?=
 =?us-ascii?Q?fuveUQPxOEtvgutqGm1jvZj1wuhsCw2ahexnNf9tIiG+xbWJxK4O9x6FXbh/?=
 =?us-ascii?Q?WtixwwNK2s5bOVcoPuS/Mcdb8sElHBQZd2CG5pXj6m3QR8I+5pDf/zjNBj1m?=
 =?us-ascii?Q?c9+JUB2ykUv+OeW9aaXGH0t448OO+ZpjtRbqWSfubziFTyrcmQjbHjN0jmPX?=
 =?us-ascii?Q?aKctJhS+Q2PDnIC2hmahCqtx8HzSys0U9FkpIf0wfvA4l/WPgP8IkCXfTPKQ?=
 =?us-ascii?Q?jgYL9n2ZsewLlvJ7Zo/6DvlMW8lUpfrw6ch69JuFDqQC6WRoDkLlMg/DNXth?=
 =?us-ascii?Q?rjk7COOBa5SCb30VWd59tXgkDVDTKyk8pOtHkkWyq7MNOB3FiuRc6kSz6kBY?=
 =?us-ascii?Q?YSHSxsA+2eBURFtGRYIJrdvmx2Z4EooRD1OxlFf/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71a7b84-28c5-47df-231f-08dde3efdb5a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:55:47.5132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHpdIwDv15a6hcmK7qESDgzG0g/QZH309Ra9LInjAbuIWGFi1hf80Z3KxZb9r0FFg6+cJEk5D/XZt02ECRgagA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213

On Mon, Aug 25, 2025 at 04:36:45PM +0800, Peng Fan wrote:
> The TJA1048 used on i.MX8MP-EVK is actually high-speed CAN
> transceiver, not a regulator supply. So use phys to reflect the truth.

nit: wrap at 75 chars. 'transceiver', should be at first line.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 43 +++++++++-------------------
>  1 file changed, 13 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> index c0cc5611048e6a739f13c14bbd2e7b26f2715696..d238d419d87cc7c99d472720c96aade90275cb0f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -56,6 +56,16 @@ memory@40000000 {
>  		      <0x1 0x00000000 0 0xc0000000>;
>  	};
>
> +	flexcan_phy: can-phy {
> +		compatible = "nxp,tja1048";
> +		#phy-cells = <1>;
> +		max-bitrate = <5000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flexcan_phy>;
> +		standby-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>,
> +				<&gpio4 27 GPIO_ACTIVE_LOW>;
> +	};
> +
>  	native-hdmi-connector {
>  		compatible = "hdmi-connector";
>  		label = "HDMI OUT";
> @@ -103,28 +113,6 @@ reg_audio_pwr: regulator-audio-pwr {
>  		enable-active-high;
>  	};
>
> -	reg_can1_stby: regulator-can1-stby {
> -		compatible = "regulator-fixed";
> -		regulator-name = "can1-stby";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_flexcan1_reg>;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		gpio = <&gpio5 5 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -	};
> -
> -	reg_can2_stby: regulator-can2-stby {
> -		compatible = "regulator-fixed";
> -		regulator-name = "can2-stby";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_flexcan2_reg>;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -	};
> -
>  	reg_pcie0: regulator-pcie {
>  		compatible = "regulator-fixed";
>  		pinctrl-names = "default";
> @@ -431,14 +419,14 @@ ethphy1: ethernet-phy@1 {
>  &flexcan1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_flexcan1>;
> -	xceiver-supply = <&reg_can1_stby>;
> +	phys = <&flexcan_phy 0>;
>  	status = "okay";
>  };
>
>  &flexcan2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_flexcan2>;
> -	xceiver-supply = <&reg_can2_stby>;
> +	phys = <&flexcan_phy 1>;
>  	status = "disabled";/* can2 pin conflict with pdm */
>  };
>
> @@ -903,14 +891,9 @@ MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX         0x154
>  		>;
>  	};
>
> -	pinctrl_flexcan1_reg: flexcan1reggrp {
> +	pinctrl_flexcan_phy: flexcanphygrp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05  0x154   /* CAN1_STBY */
> -		>;
> -	};
> -
> -	pinctrl_flexcan2_reg: flexcan2reggrp {
> -		fsl,pins = <
>  			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
>  		>;
>  	};
>
> --
> 2.37.1
>

