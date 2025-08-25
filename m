Return-Path: <linux-can+bounces-4366-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBA8B34687
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 17:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4839F3AE13A
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 15:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0122FE065;
	Mon, 25 Aug 2025 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R/3xNI3/"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B492FC870;
	Mon, 25 Aug 2025 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137544; cv=fail; b=hjBJM7JOioGmlDX0FyEEXb0hl0BEmpI53ajo7JLGg20l8QLZpFDjkKrT00MEeb7CUPHASwZDQ6ehbZUxbGsv1h5+D8aNWUhMRh+hrjxIE/QXPOKdDjGuRQm9pcNJpkOihO2tBB5WeRQCOIT8qjA4RmpytIFOlHdyAxAt2sxWe+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137544; c=relaxed/simple;
	bh=KQxESngFVTeI399ZQZMQRQ7JVPCFPEcuJ4e3veTsX0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ran+JodVwe8HMjQYn7qaDCDB+4qUdwd1Uzx7fL2wkHKW2ZpTvJgM9QDdbmHeNZU9xmIKX1CiQ7wQDDE1JBgb0f7xnHUGplOR6NAq9mi3tzk+7Zo6WRS8JWdj3F5/nZe2AnvInkLGAQgmqJxfM0aJCz4/vyqqUM7a9Gr0Ep6AI6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R/3xNI3/; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5/GgOSVF4LBhAtytpLLeXlg2uc4D6utl/8RHJXokzM3GWare1VkPHAQeEYZhwwpoHOLEerTSRzaher6YlHPIB3pPpR1yv1rNlSeXH3A1Sb4jcpQmzTkzbJh33fJY68CG6Fv4mFBlXsi3/G4FtdHIPVsJ4a80aGA2gLN1RyLGZ9Kig7DhKKreWqwvtuH+Th8TrIqwTF4XtDsumNMcApvxhMOnv6SS8T3DAPKcHD4VSXiyBybnqUCwrpRTp29oG7PatKcMwu6B6fuZ2WHdr27/qAcsFGclrXtA/hjx0PIkHWyU0065LKZ75LYDqPQWkm77iLq7xYnH9/hdnWKVzi6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlGAlqfLjWnMrJ/GM8GXOgCUtPCDx5iM/72erW7IsG0=;
 b=QbGe+OiIfi/6S+oYYlRXKADgALz3YKOftaODfA3FIfEVzpyLyHoCA8zwngsm6luUogSYZQxZ0cDizHW18X4+Xj4ThMRcWT8Ga+mYAlGoisNlymf5PJk/tkhBiu3MEhUDcRzrBxeRGPFr6WcRNZDDhuuJLm9vT0/qC/zz3G3e1AWQ8Anf5VrJh6kVJevp08kUOM/+s0Olutf33BzC7wMUpgATsg0K4d7KWY7JsSxiGqk7nMtuejLaBtlCJuwvMfss83HR3nKMmgpIbpG2AYGmQi8a3ReIs2g+qyBkCZYkbuRos0qXkW/3rItMtXNOvFKt6J1rHTVFKOFFcHB12fMUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlGAlqfLjWnMrJ/GM8GXOgCUtPCDx5iM/72erW7IsG0=;
 b=R/3xNI3/VKeoLiWB5hU4JdCtYu2fiQK/TNPGrTb+5elpQnQgp3ifbj5ZXYphQLG9WHFNo2rUyA92nPnDL24xhqkpOR+N/o+DCi96qIcAtmEcyVRtKaSfUpO5ZGzq8Ed7+uPUMv8EKNmEAGPBue8/v1f/+LGDFTbUTQJairwJLbfyfGrDUk01TQlWDpMepCKtpu/rKcQsu4s4n4P+DQv1h6P8/rDpozpIARzvvwUCpTqK4i5JipSHlo2CKlPtM04jK/DJI0mJ/XHVnC4JrF/yDp/9tfO4jv/Kkg86dxrn8HjGBntpyLcdHnWVhQTzFip6Z6rdXSvrsows887Mpw520A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DBAPR04MB7415.eurprd04.prod.outlook.com (2603:10a6:10:1aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 15:58:59 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 15:58:59 +0000
Date: Mon, 25 Aug 2025 11:58:53 -0400
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
Subject: Re: [PATCH v2 5/5] arm64: dts: imx93-11x11-evk: Use phys to replace
 xceiver-supply
Message-ID: <aKyIPZfYBAl6mrml@lizhi-Precision-Tower-5810>
References: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
 <20250825-can-v2-5-c461e9fcbc14@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-can-v2-5-c461e9fcbc14@nxp.com>
X-ClientProxiedBy: AM0PR06CA0107.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::48) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DBAPR04MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e71b9f-9407-4734-0ea7-08dde3f04db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lfCvwUlTZO9mab359iI1XA1eWlDdXgAuzwuzaNgLkHwctswxF5Qf85mP6wtk?=
 =?us-ascii?Q?ImTnlD+O2QiqZZE3DNARhoJqWSke+ZhiC4DFL3apBxUabdtc3hAe0Qij6XxD?=
 =?us-ascii?Q?1m+cc5DtoJc0VOpbvbqx5rxJjdoLdfis13CVrx9QLv97zC53S2fGB0m0BvDp?=
 =?us-ascii?Q?N+QiiHlFVu8MIHvOBm4nkjbLkQvn1mb9lJxj+LmxjWkJQ9d0tDDIUa+1FO+Z?=
 =?us-ascii?Q?dF5XtKEgwv6Ain7arO+LbPAnpylDozEwDVh+r2jCuFXfIDH/meVMETkSXO7a?=
 =?us-ascii?Q?zm3dGLCE9e4GLvKDh/qhSDeMHQVTIk7OVujRf7klZa9ndBWguTUAfdfGoqTJ?=
 =?us-ascii?Q?Qv/iJuiC4Es0hyDSittzpSVlfeyX3XSIf/VcQWHdDmHyhnvXw3shmdCfNRnQ?=
 =?us-ascii?Q?ERmwrFvOqZNcgYLr3qQpM1DRpZMrPliKyDE/OICfZ7kbouwGsL39ZYAqppLP?=
 =?us-ascii?Q?j2gbxUiQDRL4Cvn0zq5bSGgPzp5AzfvvpnKCRvjh6faaYNJIwoTwGVDaJxE8?=
 =?us-ascii?Q?wr3adZdtFfXMY30mGn4K0/bkOOTfRQHP+myVzCYhDvZxEkRgjSp7NZBLyjKy?=
 =?us-ascii?Q?2nSYvZHEbBcRRIG2hdjSjvQ4hLPXGk7OO2XfP4w2AY7cDiTx4sey6ZHhbRdD?=
 =?us-ascii?Q?eheRcVWbS9ddCW2S25jL7HT9a4D3o8kFl3PBRoEeZFx+aF5MuJRyju/4FPeB?=
 =?us-ascii?Q?zGU6WCL4+WYkT0xsHJpNznT1vBUeKocEVZ3i/NFwIZ03DxLW9K7XopbCre92?=
 =?us-ascii?Q?hd6I1oNc0GJtz0B8UBbZyDTriCn4VL86UxA1IqR1t/fzkWXoU6TL5Op6UPyP?=
 =?us-ascii?Q?OOH19iLr+X27PlTDx1keA/jtoVsDg/6ln8BNgd48ZJW/6tx485Xf9+5z5+WJ?=
 =?us-ascii?Q?Pn+aev3iVoUZ/zl4v4uwrTPnIrdlyajW6yY8xdooC5QEaFK54fk7DIIh0VsI?=
 =?us-ascii?Q?yq5O2UuZ0QY5WXiBN6lHHCg5ORo8NcEHCFTJoni4hw8qwzNrJbwjkbhpDmWs?=
 =?us-ascii?Q?54SVaSCrP5EIIwpxBi8JFodtPoQi3hcxfk55kVUR56tZXBgBftokGhEPlcHZ?=
 =?us-ascii?Q?k9y4gqb3/Ctbted+kLu3sZZY90Hh8caFY8faRNh6u6ELSSZb/aTVGtGfJ7Gg?=
 =?us-ascii?Q?BVdh0Hc8jZkkwyACH3kEbEfA/ESgApB5XiUceD/i4incnCoMraHzV/TIK91x?=
 =?us-ascii?Q?50l/KEvVj0OEoIYOI3PVuMIj5xEyaD7u6bnYkxFvO40to1cD6ZmPSF2VicXR?=
 =?us-ascii?Q?f6TwN/7mG/xuJ1D/0ZZLHqI/BMOWAw0xVZUvJyRQVDWrgip452Kho5HuQCow?=
 =?us-ascii?Q?Gkmp3kBv/wdTLSzU6cD8Q4K54BKcYZ1iI7S4I61OoAyVgcRMWXsY5sCemNF5?=
 =?us-ascii?Q?+XvykMq1Q7gIweq7oThwj/JcudMlhZjnfBA3AJDks22e1m0Y2XSoIvkyMf81?=
 =?us-ascii?Q?1DBk22bSMafA0Tg7XPxAzXYHNscRl3TmGzwaF53iltvKISA94RQSvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HDjJvDdQizjVeaU2L9guVMRxBPg6oM2++enHmNbMgn1BhGJ0trkGJtWYB/AA?=
 =?us-ascii?Q?rbl1MpDYfGhQ+x0//+/c6H+9RsostT+N5SwIU3pihAtTd02X6TSJ08QKdTGU?=
 =?us-ascii?Q?PzUelPTCD0BaLQa520N1yaycQY45KJql9fAZQFmruOBJWX6eJcrKRu7rR24w?=
 =?us-ascii?Q?NdWhwKXrjygR8q0QoI3GAQzy9qpwTZ3Od37xpX8iBQXCLJSRniDseo9MigOc?=
 =?us-ascii?Q?BRfrj283FovruYovLnLZ3ul/V3m7wySNWRjm4OiPW9GB083rfpjjM9ilm0NP?=
 =?us-ascii?Q?JWTXUZiFWJFWi8qoK7OKuMW0FhsUPqANf3FfFwFa0XeFHis1hlvuc0iuOuSx?=
 =?us-ascii?Q?z//MOuT2QTSkbnoAYqzqyf3hpJJRrh/RFEle+3DeGd1yB2ndGWGJ75tyUXQI?=
 =?us-ascii?Q?R6jY2ksgs7M+mfLdNKgAbI6Dw/Ew1TRkpT8NrGJe/UtBCUSyr6ZHqQns+EVB?=
 =?us-ascii?Q?ufVRzxbwYd4MhfQpA7sC9xixA2A7avwf6Qe5imMSr5mvlwfiwmLuvqTCW/iy?=
 =?us-ascii?Q?K4vVCZoJbjFSBkj4K0huS+QiDmhN21ukRyAIrzxHdAxGFRLdwvtLzhquhKm/?=
 =?us-ascii?Q?pqcm0G9Z2xTtG+aYqOlVZv219UdshbMWX1GY671Z4wL8AUIgTvKxSE0/kw1c?=
 =?us-ascii?Q?ZXdQECR8cA9987FWRJkZ923dfqZ1CBf8+lNy2bIjVMyoq9t0gBbzffbdXUL9?=
 =?us-ascii?Q?n8dEJy8zC4SzFJJtGLlAlUzMRv3NeNg5GUaIdjlnahxjziYY0N2xhgFxgg4S?=
 =?us-ascii?Q?YGO9aiEFsoLsaS24quahEdKe/09AoFwTd7eIYQUuIGrfpWKoPEMCT34CRXhz?=
 =?us-ascii?Q?J5HdObhvjyBD5gBrFNFx7yPEbe3IcsHW7AjQ+gXHoDoU3VXYI9UvSB7yD5IS?=
 =?us-ascii?Q?TdBMbEO7HwFqBhIZZaR0vBsKyu8amehwQ4Nl11+NrYv0EKROpdQKkG9A0Xq8?=
 =?us-ascii?Q?LCOTn+YGduq5mW3CMPgWyglnY3cJuYit1iaO47W6rnVbwsWHe4lhRuumXf9Z?=
 =?us-ascii?Q?lmS0zMmDrJwQWcok2DTpcQOFk9guN28y2dW2xA8XzwmaO43srBNl7cthjE86?=
 =?us-ascii?Q?6KeCvsQd3hEAUhLmciuCEq3J99UJj7cH+ZpOqkvVpeNoqTNN0BxsrSBE1SqG?=
 =?us-ascii?Q?22vf4nu9HfCypPzT051J92u7eTr0MnJkwxBIz0ab27vFS6f33/h0XcSobYv6?=
 =?us-ascii?Q?nyTwq0wZSJf5LaoguOM8nL70NgS6Yl2mFeJfLgbWlzbXizQ4jy80CKCdq9nC?=
 =?us-ascii?Q?mWIIJ87/2xzJTXrjcl8kfBUDexBufdvhYGE2teC0vxxNOm1a1JPbttvq9bZa?=
 =?us-ascii?Q?yz9aVQsOdP8AMqiIj6xsE9W9qOczmr5Z09GXUc+XJO/HJocXPecSGqU50EuC?=
 =?us-ascii?Q?Svdby3hUbzqynyF7CL/Ky9X3fMUIoweJZB1xT1E6zQHMwZCDG3DU7hJAfXEr?=
 =?us-ascii?Q?Bzi7lf4mrqq+nlLf514cvVazqg0DcGVuCMiKwXmsK1kxt2SCOPDIlXZ/6ONZ?=
 =?us-ascii?Q?O/nWkn0yUaRKDH3i1t7r8CvMwHcnsGuGg7cNc+xCW3ymvf6DIVi5Bld7UWw2?=
 =?us-ascii?Q?sSNmBL44L18kxgyjqsuc94JUYFRBaR93gVF79qgb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e71b9f-9407-4734-0ea7-08dde3f04db7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:58:59.3805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjhRWRwOgARMoM9L/TXKYUtyHzNpprzxYwZ07M4QE3/v0tD4KspNSCTR2/N8385uGgBrpAvfdQtqj1y67bvQVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7415

On Mon, Aug 25, 2025 at 04:36:46PM +0800, Peng Fan wrote:
> The TJA1057 used on i.MX93 EVK is actually high-speed CAN
> transceiver, not a regulator supply. So use phys to reflect the truth.
>
> And TJA1057 is compatible with TJA1051, so use nxp,tja1051 compatible
> string.

Need add TJA1057 into binding, "nxp,tja1057", "ti,tcan1043". You already
touch binding doc, just add nxp,tja1057.

Frank

>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index e24e12f04526c3a08c0bdc6134297fb010e6e926..94be59771cd05c93a6569ee08fff71bc11da21c1 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -62,6 +62,13 @@ vdevbuffer: vdevbuffer@a4020000 {
>
>  	};
>
> +	flexcan_phy: can-phy {
> +		compatible = "nxp,tja1051", "ti,tcan1043";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		standby-gpios = <&adp5585 6 GPIO_ACTIVE_HIGH>;
> +	};
> +
>  	reg_vdd_12v: regulator-vdd-12v {
>  		compatible = "regulator-fixed";
>  		regulator-name = "VDD_12V";
> @@ -87,14 +94,6 @@ reg_audio_pwr: regulator-audio-pwr {
>  		enable-active-high;
>  	};
>
> -	reg_can2_standby: regulator-can2-standby {
> -		compatible = "regulator-fixed";
> -		regulator-name = "can2-stby";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		gpio = <&adp5585 6 GPIO_ACTIVE_LOW>;
> -	};
> -
>  	reg_m2_pwr: regulator-m2-pwr {
>  		compatible = "regulator-fixed";
>  		regulator-name = "M.2-power";
> @@ -284,7 +283,7 @@ ethphy2: ethernet-phy@2 {
>  &flexcan2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_flexcan2>;
> -	xceiver-supply = <&reg_can2_standby>;
> +	phys = <&flexcan_phy>;
>  	status = "okay";
>  };
>
>
> --
> 2.37.1
>

