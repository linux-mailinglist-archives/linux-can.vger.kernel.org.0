Return-Path: <linux-can+bounces-4397-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C21B3BDDC
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 16:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF71616AACF
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CBB1A238F;
	Fri, 29 Aug 2025 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RAt4myGi"
X-Original-To: linux-can@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844E367;
	Fri, 29 Aug 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477948; cv=fail; b=pBtse/r5Pej0oCu0h+LPDvW1oxAgzgS9HyCLHEQpq6mfAeB+eJZ1ywP4Ul16HlHwaoOtyoijJlL1lwq1WfpeeVUzC6XmZNMPNg7MZgEkGIlBFoI3FQLN9jL2oiiQEHZEXo9JlhctINQYaEe7m2mmAD2Im8yD85jzi78Ade8xs8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477948; c=relaxed/simple;
	bh=M60lgyCcwoIHZsJThlTj5rMddrhgI89D3Pz2uBStQRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qJ7dNKdsGvJHI2RsT+FYE3ZOP/4PR/QY0Akrn6YSbvF0HvwpYnDjf+T5xzLcElEmVaMTIKG30LGbbWKHLKSfuCd8C5yr8wovhVslkvJtsqQ/EppFnoEnKc7ZwEf9I/+UmZ1Aa3aLjY5+iAQPSa5R26U2Kqv3Ny0IB0GRDARkwu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RAt4myGi; arc=fail smtp.client-ip=40.107.159.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1Z/FFv7rFJb2G7Tv42Z22Sj3VCYJnr/yP9m+yQ4zaEVrQaY1OZgFMbuDuI8rtHonU5k9zmLntPQ5knV5ZIR2I3h84Hn5s7Te+MVIyUzckJnvN1pQDqmjK0nnWT4+Dk0DVhEM5UHEE7vv/XKUx97UeywMNYmCjEw+9dQZ6hVAp2//6UwZnzdY0dnawH/sExhXTW3sWzPMsykTSmCiXY/wJuMVmvUlXdAit5VeajlAkRrMwNpNwa19d1FtLc9ME4i6fcV5xxUMe1jCMD25HGcTnPkPC8RlaciBOl7I1kEZ+BvpK6oWSbXSg5fAme7fOVjAQrUgQAhCWrfCxy/DSXp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tdpblxmbj1zmVxjLDF2rtEQaJ8+MV3lqGcMnNFTN81Y=;
 b=aMyPwKAb9JE6qSccfRARMYXj1pT78gKkcr7BEpQtFYE3rViXUhnV7iOeOyatw7rWTJnnz9F6/eWbZ6J8QEc/r6lqsPdBP+O7tM2dlQGn7P+W1JUlcIebEzEm69WVxOjFfUharonqXln+/3HV1SK93IFsMsP5hLzO3zYC/g/mpBH8Rjoit0w7FtxzMqIcko2sxfKBHLDo36kLp4ieds3k8TknkjaqiUBcqAaCAF5yvLQY/erSUzr3DUMtseOuQ/j+gO5Y6s2zdwOebdrDo5+SwvVxCbVAMwZpaIuBAdzZ7KrEtxz8ziV5GUysUGj79sX4AE9pA3WILJnmnK7YeEHibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tdpblxmbj1zmVxjLDF2rtEQaJ8+MV3lqGcMnNFTN81Y=;
 b=RAt4myGiF1fyPVU2hT0VoRUmd65ovOrXPhbwtYCh89Egp/7wW8w7vK4Vw2bhmH3EGjiVcOSJkpgIQT4WW213sXsOxNpW+oIGFtcDG5v/Vxh0dmxspHFSd2d1umpMBBeeP0+0w4uISMazPtroHXGPCrux6ngBJEyN/BZztT0kjAiDCTwUyp6WUS1EaI0mKhJJ83Aw9V3up/TzgfoWkJ/vP9K29Xdpy+SyORYBE40sH55uZeXvCLIVv8/cNu7/RshHo7wxQOBnW8B4QD5I9RSJZqkflbAypXwAdkybIyePIo4mnalzxIatpo8tlBactJUwYMj9FYx43VoUPXZqw+55OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 14:32:17 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%5]) with mapi id 15.20.9052.014; Fri, 29 Aug 2025
 14:32:17 +0000
Date: Fri, 29 Aug 2025 10:32:09 -0400
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
Subject: Re: [PATCH v3 2/6] phy: phy-can-transceiver: Introduce
 can_transceiver_priv
Message-ID: <aLG56YUI0/GBfcje@lizhi-Precision-Tower-5810>
References: <20250829-can-v3-0-3b2f34094f59@nxp.com>
 <20250829-can-v3-2-3b2f34094f59@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-can-v3-2-3b2f34094f59@nxp.com>
X-ClientProxiedBy: PH7P221CA0086.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::13) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AS5PR04MB10041:EE_
X-MS-Office365-Filtering-Correlation-Id: 55831813-ac7a-42b9-58fd-08dde708dad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7EBMpG1mCFHTay7aZItLF/XLrH51SZ/hY/3qIWiLHdaFOW2DfCcOUwjDZXd5?=
 =?us-ascii?Q?thRnOUQW11o3bejWB+xlY/DrvevNQTuAyIfxwiTIQyP4vFrTr3y0x57s2W3j?=
 =?us-ascii?Q?XvwZqo2FxqG9a35Zc3JYzvfbZ0lnbRAkAfY+Y44AZlNsr/MruEQdbg5UdUEk?=
 =?us-ascii?Q?5R13+t9HQMX9ehK9ZNEhc/pWBlaxRCiBWmEbTnRjWeKMUxnuAjSCXFQgbXnn?=
 =?us-ascii?Q?JmFSxAZO3SZAQuFGOVlaS3MqDbCytciERvfbxqtdgSQeUjv35u0Heuk/wcaH?=
 =?us-ascii?Q?+VyIdeGet6ZnAJq/n1fbZMeMzygeAr0rwlH7bawbew7ISNrUESUukJjg05jL?=
 =?us-ascii?Q?WT9Vc4vHNWAKUfBUMj8ITpVK1yCCuxoccK1k14EVQ8laI5AgBwWhOIQOklsk?=
 =?us-ascii?Q?VDwJv80ES3EFMzWHpkO+1PrU0GnwuAbeu/vCaVqCV8rV1SUhuWV4xi8zKffg?=
 =?us-ascii?Q?N/Hsyhyg3kP1GkOornifIb8GLSz/FM1eLXOf+9YzOR2Al8zkZAeH3JsCGHWF?=
 =?us-ascii?Q?to4cxlZUL9r+DR/VtKOYLZMIO2W449gTJoRbxsMoEa5+Jx2VR1veSLA78Rwq?=
 =?us-ascii?Q?9Q5PFaaq/ExLy+czHgh12Ln8QCStcH85BrRluviJlYfg2vf1A7Ibh26dLTyl?=
 =?us-ascii?Q?y+5V4Luf3eKycaemglOE9OcdCgTrXvbERFRBXA7+FK6BUe5sCY1AnRRbs90J?=
 =?us-ascii?Q?gzgSjWyeiXWVOGCGqp+np/k1hKYYGOHSS/7LOA7vYQJiX3sjKPve5BNGXWuX?=
 =?us-ascii?Q?hYrUnrkmp3FWjqqsUNg0IlGd7AU01eKIFiCa5fcCaeLi4VPfkXI+Ksf3GlWK?=
 =?us-ascii?Q?vEsEGAgcf4oiKS3WpQnnrE5SKyozJVKwkAF70b0MHNhVvXt3e79vU+lAnbKc?=
 =?us-ascii?Q?8QV51hIwnOExLJqUYKSY8A39pBJZHZiCvZMheNmp9iiyrj6O1MqjStmOZwF5?=
 =?us-ascii?Q?YEcYyMsTi36HzFRTAiZLAlD1gdFhqbVxVUsrUtdRIfsniRJByMy+0DrFpGdv?=
 =?us-ascii?Q?K8TKJEFC7jop4t/8WcTAIumE21ZVK5Btdck0lB/sNSRS1qH6wf3a/hWGG4wF?=
 =?us-ascii?Q?xODzfTDlPJRH70vnVuv3kiX87PLLy64sRfJEyoStaH36rGzEnY5/1r3JapW/?=
 =?us-ascii?Q?nk3/yeufC+VVzklD/oFSfTvXzhgB0VVVAUv8K1I733VbEVtfaQuUF2uqqh6Q?=
 =?us-ascii?Q?nSl7/OsJxfSpfnSkecuSQBJHzosGt1PebAk5sdvCEgjgcPdoR3ayTbJsMkB6?=
 =?us-ascii?Q?kij/btm94LKRzQvB1cGiqCxPSPUl6JsceGcX8YnezkDz1oEFOLsHWVCPNOU9?=
 =?us-ascii?Q?9f1P7z0XifwweU5yDSFQpBfYGEBuUidRxzq0OigeZUr/Z3JUqGJjZLNQsFQu?=
 =?us-ascii?Q?MY3UWs92VShSXiUi0Lj49Rhl6eqXWUXgxUt03HLOcC/Q0IwUzsLOhV+58XpA?=
 =?us-ascii?Q?J3AI2DmFYp/tXoD/q/5w+Y/EwKmlWtCDvlVYnMkYTYpM9xgdU0gleA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T7zB3D+tFVANZSrgwVUqYWDFMc/0lW0SaXvrkzUjTM/quss3cbrB6JhjhWS+?=
 =?us-ascii?Q?mwgSD786nlRBhBxGW7vTNWcqptNpk2fYIc13mK5NXYh7Y4px+rv0q3fQDb2F?=
 =?us-ascii?Q?CLtr9qaIUN8FqB4fInZvey3qB/Cjhz26b1MH/dq2iLMhXCSr6k08pfmlpHgW?=
 =?us-ascii?Q?my1MBf5lH6vVqPIQrFmmyheHAQOCIDmrxMUm6q3fVxX9n/WeDAL38ooDf3pw?=
 =?us-ascii?Q?0ZyIEkDGcekooHik3cH8P6tRznID+EAzOpGWY3wXiL2P49I2qeIhFikiA6l+?=
 =?us-ascii?Q?6jRq63hFA31LEltQYGUlBN+POwEIULSZUmbhKIaHxDoDPV4010IDVzE/znT2?=
 =?us-ascii?Q?DjThh2HnConB0MWkYSCaBsI4dkWukxxH/CLSC9I8NJq3rtUyoByruiuRBnYD?=
 =?us-ascii?Q?IefN6BdBqxU7oVuObckVksdB9wxxougwzPtLA64v1xRShqdS2OuupR92Fpj2?=
 =?us-ascii?Q?E+anEuawKPZ7O1XBL7XZ3ckqhjQbpP85ygON8KRZSJSZDWV7SsV5Fi012AHr?=
 =?us-ascii?Q?wJlunGJlje+v6ULRyKpMQ5ZtFnL88i+/ix4Cjvn6tzY2mWsWalgqcmyd+ZC1?=
 =?us-ascii?Q?JeS6CXuw1aTV1tCQrabh4bbpPaF+fnt4wp4mfUZHiP0xj+p1y68Epg26JzjX?=
 =?us-ascii?Q?uGQQ+F8abdrbLgW4T8eHFqEaY+0CuC5PQ0Kd6155QULgd87wQVnVePudS7du?=
 =?us-ascii?Q?NyrKcdt1fnHR+tAQPWZfrIE73UeMZu/mHctxFixgmWyfEUkMuSYJ7CXY5Yd3?=
 =?us-ascii?Q?0lIGJSBvdlgVqdt7om1RrkDERaDXpOGmqs84vsb3Hq8dToFG81Sz2lq5mnNp?=
 =?us-ascii?Q?8m/zDaebWtx6DP7hnleWc9mCQKsB3qTtmnKV5bs46QMmRuxBCGcBImPkvXIY?=
 =?us-ascii?Q?QwH9jjrW531Q9N2GDu+MdAr5Osak919yU5PaRzcDmx8onyaFH21mBedoq6Ue?=
 =?us-ascii?Q?2ZIIjZnnhgpZda7LkXbqebVluPfGTIBF3Rd32Ja2b3OB8qLDJEOuvsREum/o?=
 =?us-ascii?Q?2iputmpFLNWYj6tlkaFilWzpi5oswPxgbNC6ldWIzVXa4r4JJiw2wyZvdQYa?=
 =?us-ascii?Q?/vs3zhIuLRswhy0jfjqqSDXntu0LF0OyfpeBaO9P1P5yvoGRW4qjNIMGIVn0?=
 =?us-ascii?Q?cDOw9B6BH0QVfVmgQFbTv265QYzuNoOiVyAYTe4JphRWyV2+9wgZLXF/bQ6Q?=
 =?us-ascii?Q?OUVsU99jMevqe2/TCJf0Gqd0MbUb2++0ZY/aAU1ZCtKctGq875Pkcs/3mYZJ?=
 =?us-ascii?Q?05ICDR2WmpYQtU0+MX+KL3SqzcaFbzdvs+LY2M9nesrdsHvxbprec5k8Eyep?=
 =?us-ascii?Q?CbMcw4Et3DIB5RmuNEfDWBEzjTYUqfIFsA5qndEJwJ7P1bd6fdDX3BtzQ/zP?=
 =?us-ascii?Q?RaM/ok1AAn88ykDkgENluGq+q7rPvWAPG1RHqDptBcNPQijU1i/gbIyNB328?=
 =?us-ascii?Q?j/8yM5l522HVPVwylbfrxX0hMoFojN1clsnkxh9LpI2mlnmFmlxtZuWhcv/H?=
 =?us-ascii?Q?NFTcRU6ND7dEZLVlZpdr9aCO/G/YjwskAHFsVGlYbMe5E78SsOUWy2MD2qs1?=
 =?us-ascii?Q?J/+INyAjTKu9O7qzhISeAfyFV7zul8fQcC5gz851?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55831813-ac7a-42b9-58fd-08dde708dad2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:32:17.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Zy2eTB4lCj3s+2r8dIF9t9RN1n6aHD7zBaImFkDyH8h39z1cwh7sh3EBmLk1UwOq3Rwn0hlToLanSYXTed3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041

On Fri, Aug 29, 2025 at 03:08:57PM +0800, Peng Fan wrote:
> To prepare for dual-channel phy support, introduce can_transceiver_priv as
> a higher level encapsulation for phy and mux_state.
>

Nit: Add "No functional changes."

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/phy/phy-can-transceiver.c | 41 ++++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> index f59caff4b3d4c267feca4220bf1547b6fad08f95..6415c6af0e8414a6cc8d15958a17ee749a3f28e9 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -23,6 +23,11 @@ struct can_transceiver_phy {
>  	struct phy *generic_phy;
>  	struct gpio_desc *standby_gpio;
>  	struct gpio_desc *enable_gpio;
> +	struct can_transceiver_priv *priv;
> +};
> +
> +struct can_transceiver_priv {
> +	struct can_transceiver_phy *can_transceiver_phy;
>  	struct mux_state *mux_state;
>  };
>
> @@ -32,8 +37,8 @@ static int can_transceiver_phy_power_on(struct phy *phy)
>  	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
>  	int ret;
>
> -	if (can_transceiver_phy->mux_state) {
> -		ret = mux_state_select(can_transceiver_phy->mux_state);
> +	if (can_transceiver_phy->priv->mux_state) {
> +		ret = mux_state_select(can_transceiver_phy->priv->mux_state);
>  		if (ret) {
>  			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
>  			return ret;
> @@ -56,8 +61,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
>  	if (can_transceiver_phy->enable_gpio)
>  		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
> -	if (can_transceiver_phy->mux_state)
> -		mux_state_deselect(can_transceiver_phy->mux_state);
> +	if (can_transceiver_phy->priv->mux_state)
> +		mux_state_deselect(can_transceiver_phy->priv->mux_state);
>
>  	return 0;
>  }
> @@ -107,7 +112,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>  {
>  	struct phy_provider *phy_provider;
>  	struct device *dev = &pdev->dev;
> -	struct can_transceiver_phy *can_transceiver_phy;
> +	struct can_transceiver_priv *priv;
>  	const struct can_transceiver_data *drvdata;
>  	const struct of_device_id *match;
>  	struct phy *phy;
> @@ -117,18 +122,25 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>  	u32 max_bitrate = 0;
>  	int err;
>
> -	can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy), GFP_KERNEL);
> -	if (!can_transceiver_phy)
> -		return -ENOMEM;
> -
>  	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
>  	drvdata = match->data;
>
> +	priv = devm_kzalloc(dev, sizeof(struct can_transceiver_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy),
> +						 GFP_KERNEL);
> +	if (!priv->can_transceiver_phy)
> +		return -ENOMEM;
> +
>  	mux_state = devm_mux_state_get_optional(dev, NULL);
>  	if (IS_ERR(mux_state))
>  		return PTR_ERR(mux_state);
>
> -	can_transceiver_phy->mux_state = mux_state;
> +	priv->mux_state = mux_state;
>
>  	phy = devm_phy_create(dev, dev->of_node,
>  			      &can_transceiver_phy_ops);
> @@ -142,23 +154,24 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>  		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
>  	phy->attrs.max_link_rate = max_bitrate;
>
> -	can_transceiver_phy->generic_phy = phy;
> +	priv->can_transceiver_phy->generic_phy = phy;
> +	priv->can_transceiver_phy->priv = priv;
>
>  	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
>  		standby_gpio = devm_gpiod_get_optional(dev, "standby", GPIOD_OUT_HIGH);
>  		if (IS_ERR(standby_gpio))
>  			return PTR_ERR(standby_gpio);
> -		can_transceiver_phy->standby_gpio = standby_gpio;
> +		priv->can_transceiver_phy->standby_gpio = standby_gpio;
>  	}
>
>  	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
>  		enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
>  		if (IS_ERR(enable_gpio))
>  			return PTR_ERR(enable_gpio);
> -		can_transceiver_phy->enable_gpio = enable_gpio;
> +		priv->can_transceiver_phy->enable_gpio = enable_gpio;
>  	}
>
> -	phy_set_drvdata(can_transceiver_phy->generic_phy, can_transceiver_phy);
> +	phy_set_drvdata(priv->can_transceiver_phy->generic_phy, priv->can_transceiver_phy);
>
>  	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>
>
> --
> 2.37.1
>

