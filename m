Return-Path: <linux-can+bounces-4481-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CADB43E74
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 16:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BFFA415D4
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE0B307AE1;
	Thu,  4 Sep 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ob0IXTyg"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A58303C9D;
	Thu,  4 Sep 2025 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995525; cv=fail; b=p5Ny9qJFme5zmawYVEnXzrEuGXqgEjC9dR+d4Hd83Px899nuwVaytmOh5xcsDFpWFqIDXorq0362Y7oJo9Nqfx0VHbtTC5PD3Jn7V/Ugp1lHCTLx5d4/fAu4U6/SY69a6jaHr4zkhYGQz2RjbVcTcaacZKiz7P9ED1rhhgDiDZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995525; c=relaxed/simple;
	bh=F1/epbr8OIfs3M8OYB5Vi1DK/vpH1jb49pC+897Syec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=slC1E6EhcAMCbxQdjpBHeNRMH0VGBxrkGFxzOT4YrY4kgfLeiKLVkppSsAsHDpCMCykrWrn0lfAEcuVEre+KWro8a5K801dNvhtl0/C1DbZGdM3/HXPFzZiKedkKPGw0gKzgZIxP/SfXaj8oPd1lWpdo/T7m3KH/BQH/3A+IlIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ob0IXTyg; arc=fail smtp.client-ip=52.101.84.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALC5jrxNMOdPeYsvDk6udKGBEo7szYPxMvre7mxjaIGFeOsDRzclGCEAvmUTjBbA87FQvz8bl19jb6VS9z7pGn08OAe4uQF+ItYY4yhWgmGtXZRhCiOwenTGT1Qs+CGGM33oHDSFoC3WWjOjx0F07fVGH4XBae6wNqilzPL37uF+MCsXyl5SeQ2Mc+S2M6wqEhvtI1kNFgDNsqIRPPxlGAJHeTXAFWBHvXmcfIjPMxjAbjSGyJHuq/o3ILM/o6hi365ilynogpkNZ+UZOlbuUZP7aPqzYAkOgvEO3l1ljb95uuF994DYSN1ToBKIP0dNVB2ilfkTEiQ5e0N2Sz2gKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYptEAC0Qgw5z9/pWSxwLA7cBiJQO2jRppGgWvFW4pE=;
 b=PhNt0Js4rrFvT8aLCap+m1IqF3jg9UegMN8wouw6BhTl1E2z6x5V0ImVHlewubN6yOzIizC0feeXArL91qlREaB3SJJks2USZNx1SRCk9LQobuPMQXCLNisBDXHfEwSsTQlsJWxMw/EQsAlFwaiujNPSGlixTrr5je/YRPEkaMYkY7TyqEVjz8qmu49tWib4uoKvMDqu2K70W5mF+VMNsHQvQ8SUpsGISARJLvCWyvjtwULF+9FExRvrtqU354peB/uFawcksZAFuEFivGHWQq7ynD74nrCpmtuG/Pu8oDpI8PGMYdgDsb0Yob5yavSPl70O6Sz2oKESW40SLU57ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYptEAC0Qgw5z9/pWSxwLA7cBiJQO2jRppGgWvFW4pE=;
 b=Ob0IXTygonjJLciDCl5pFWd9lFWuImEExWpfVVCylRu2wABcp2R+yty7JRVwNLmjsx3uYBBhWKmO2WFWnUdEvrC1cZ/oDTixne1UNe/fOxtKz+zqUn3WRZoHKtxUxIz/UMbVJ8Z2lq1NcviilIxKIySUButkHPgajS7OW4AZkfs+o1JLYP5CMtGFUo6ZVdizAlDzdi0SI0n0gvZ565rITRq6rxQ6D+1S1ucVo3un1HIXvw9EFMW3aQlEtKLepcLsCdCsGHv+6hhtYrtENqqCQevgaXIHAcAFAKriHtJP9H1o7VQ3Z/XriFULpIbbtAotKyEvB6iNDykAn8W9Q4xVcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM8PR04MB7380.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 14:18:40 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 14:18:40 +0000
Date: Thu, 4 Sep 2025 10:18:32 -0400
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
Subject: Re: [PATCH v5 4/9] phy: phy-can-transceiver: Drop the gpio desc check
Message-ID: <aLmfuA6kj1qq7Cec@lizhi-Precision-Tower-5810>
References: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
 <20250904-can-v5-4-23d8129b5e5d@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-can-v5-4-23d8129b5e5d@nxp.com>
X-ClientProxiedBy: PH7P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::24) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM8PR04MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c71e5ab-34c8-43b3-118d-08ddebbdf273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LVV9tghFx0KWK6bUFG+6rBn/tuWDTaa2AIeZVLoSYwAnS2ymxlVveMA+8l+b?=
 =?us-ascii?Q?cCCZrr7o/GRgJByJ8q61wd6KpsFrPhP5/VmJeMx8FmmOyNdz/uUBd0UFN917?=
 =?us-ascii?Q?e5gtWh9f1P7ffLTghOFnH4skI6ppxshof0d77EBkfwQuDeMA9B+4oVViqzdJ?=
 =?us-ascii?Q?FSTvvJR3sLPXgkEfg5k6Ah5n91a+6Dymi8PNTKDVcm7r+nqbNPjpIm5g80pd?=
 =?us-ascii?Q?XJLJtP/kfGFomDyByRzKtB6Kr2W7Vlty/ODWVOBPQ0n1DUak4q9f0QR2EVVW?=
 =?us-ascii?Q?wpFSuVaIKKwidQ749mAF4aOhbrVAwXGcjhFwb7jNal0FyMJuXUqjHUIA5ZZT?=
 =?us-ascii?Q?fCbuUSsf6bBywfrOa9774OOLaEY5e5rswgMSotzrU26/y8iqdESxF8xGlgTB?=
 =?us-ascii?Q?s9waSETqdPtRJeRbN8tu2FbxS8OCo7BNtWxici83yzsw4O16bp0fPGPkcAHr?=
 =?us-ascii?Q?M3ZnYYYwtnQK51gH8FrVOaW4aB6rqfZbfV9BXN+E81Xq7R3s7PipfLmHk1SC?=
 =?us-ascii?Q?FFa9sq3RjfKZUVfYyQn1OAlQli+qtyUdvO/c2gn9ZQifEjuiU8xrVMP5l4Za?=
 =?us-ascii?Q?bdzPfMdIziJJ/ZXeQPRXSRf3rR0rp+kLBY2GqiO7rSnU4uEhZW9wrHJx19CR?=
 =?us-ascii?Q?/wVsTm8qO9m4rTfN7hxpQwrUNZRxAdmgd6bOtJGtnqdvWA5D/9EcAuwvMsfT?=
 =?us-ascii?Q?d0AdkrSHRA6ucp43CEINgW2TR+fViMkUmA83Aaa6TC3AIr5GykW20DTlvO0J?=
 =?us-ascii?Q?MwYT5Kt1dyx0ATwNz5JkyCoA2U24uQQFVh3A4YiDJZS1P0Dh5xbFZpi+LkhI?=
 =?us-ascii?Q?nUY0nWysSXUnnlHVOoN7sGjJFdr5Lu9ARU/j0t7pSQhIVEsRLUJmcjXdyPDn?=
 =?us-ascii?Q?4ytJXSzjrRfBKPUdC7IuQvBq+McIhMryz7vdr83rCgnYx8tLyvfP6GBHRlYj?=
 =?us-ascii?Q?S7G4xrdiQnv1CHp5MEyJ1ln1xmlkl3TKoqpyXT12q3HjX+INbFAXE6DW5npy?=
 =?us-ascii?Q?9Se1TiPBh6XRzD8ZRpbu+K542dQdGeXIpOU4J/zTcJ14AB1HsNpppQBiTcoM?=
 =?us-ascii?Q?p+8F0b8wbs1oXzgroOjjeuUkENbsGArHX8osQOKx4Zn1RQb2HOuBupFOk8aT?=
 =?us-ascii?Q?2e/SbCrFfPT22WPy8hdmUvnl2aAs0pz3v6GqjQahb2veItOjk601iU8N7oKT?=
 =?us-ascii?Q?w0IIr9qW+xEOy/Mt0n4fIiOfsYSdtNy3+NIYFkmUm6HZINocXJBbsnmMJZhi?=
 =?us-ascii?Q?r9u3z5K7catcOqtZI6XuxxMIxX55lrVKYm76iFbH0Wt4Z0WGm0dE7iwQF1Sg?=
 =?us-ascii?Q?8hu8wSjIu+6097L0rEOWee/oSMhfgPYdYVZ1Qdy4Tu3Q75XWdYeizjkoZG7r?=
 =?us-ascii?Q?Z5FOMo5HZdm5mAeGD8/XsOnT1HDDvboeGfJN16Fnx0djr3SvMaqOgX58F8Up?=
 =?us-ascii?Q?CsACAM/wnF6ISrGldCk11I1TpIj5QRpA2AOaz2AjNWDXylXHRUQXIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fcUjYWDWHCx1Y7L8NxKWdGfaWt8rU6bMe8ALg6rfWZv98/oVEYg0B/vrcFaU?=
 =?us-ascii?Q?Qe8kQ0soWGlDBC5F6Q85mnxyQSYaQEa6eOtHRSS28FaIBicAodHGqGcREPHn?=
 =?us-ascii?Q?QrRmaqZvQ7fg4Cw9yS1a9ugIMKnHCZpgJ6l2O9juGrTzfR059DgKMpmJIQJ1?=
 =?us-ascii?Q?fvKALPPPFZdchIh6qI1sx89ukMtmLmC4Xqx/YWDwjjqIc8A5en5vPON4m8m4?=
 =?us-ascii?Q?zJhqzG145t4BET5FF8NgW33iP8PR1+0jAPm0S3bnmxofR3pSiXZMD1GyapaG?=
 =?us-ascii?Q?e2RJOrIYYLpf4eFm8Uuk0h2N/luMUrEOMgrzJtaWOmnHHUx43KXnCWatxmVK?=
 =?us-ascii?Q?XFJTfBv55zkSAnGhWpXSZ5w7rRRzbvT0qCMTCvYn64gploY34NdJ2dzW5gPG?=
 =?us-ascii?Q?cg3z6LowFvrAH8eYL4yHbLa1lrPiGkO4UbvxIYU4oQuYI7XEBtzkWO9rOaMU?=
 =?us-ascii?Q?I/52rWTZ5fLqB8aLYFRKOq66FxMFJht29feB9+M6HpRJawRekKc8JAunK/go?=
 =?us-ascii?Q?a9TxxinqRGCU8Bi9W2J/Dfp/YPZUiCClWXIwAFuEFp5gWCZNDAxfmUkCrCS3?=
 =?us-ascii?Q?1j4eIJsiFToqPRCHJ6LxCPH6oMOxug3JeOA5yUNl6ooW8My322v2zYjtULl/?=
 =?us-ascii?Q?CTusSeHRVm+gJFWytzY3r8wepMvRMD/YyoYi0H1vZUUrmvVjX/Zg/3lc2G4G?=
 =?us-ascii?Q?RKS9L8djg0Y2JUMYojEQiSJw9wIEd3HV797q3y+vt/yNBDzOK86HlGoP+ZL1?=
 =?us-ascii?Q?QuSA8fC3BfNwn01cdO/utvnohlHKtCetqgII3+W26hV6oy8Brk9qPyK21izf?=
 =?us-ascii?Q?cNaX18NAVmH7yRHdBu/5PKHRFk8XNl6vyhHyvllr0emMOCNeUKGESWRnIxtG?=
 =?us-ascii?Q?RBpVkmMun5quzaHObyazij3gbnr4UsKFbDUc4v4JoRvXXmJCPTyaBRhCWY3s?=
 =?us-ascii?Q?6b5BPf0fYAWuXCITYF1O0Zr5Gplryn5ORqNvu69Ot0Ysv76yf65fYDbCZMXI?=
 =?us-ascii?Q?SDFX8ISVOcAVVIloRG+0gnyx2VDT59KLhWidNuh6oiFvD+AFPj/fTs6MZ/cc?=
 =?us-ascii?Q?UOzSyb15G7ajGhp2yDXDO+l8ehFUEdwbh2bmn/5SjxoWsK0s7KqkLD74ghXe?=
 =?us-ascii?Q?Vb4lUy/cU7A/5XCEu5JTvxW2cWvpjdb+osBUCs/Os9FqkwA52fCYEF9gjHoj?=
 =?us-ascii?Q?plZAO2AKa1lOyXIrNL1B8IOfbIr8cbB64bR7PrUatwZ4Ib3CtCHr8SVZmMzb?=
 =?us-ascii?Q?egYs+nXkhQ8n0eBPW5bv7ILkKWzfyu9ldAJNNTfgxEOquOTfumGka2lBrB12?=
 =?us-ascii?Q?vkixKTzKekMpduNxHGPm13kMt0bPFKtgkZX97dD4A2pItT3xZsjPafdekHq4?=
 =?us-ascii?Q?4cQdxjhWEYLlFpGN/WKl33WC3McnQIESk87Zg7V2i4A3foVnWD7YqTUtliwC?=
 =?us-ascii?Q?t9ntXfkkA1u4mek9yQqFdD8jOK+nyTh30YHOf+ENtw0I+CnDc9RGKY3Q4Ot7?=
 =?us-ascii?Q?3adoKeTI9UGaS8QpvHPdNnQrp/uHCQnbbYJghqn4C1uRWVu1Go0J2nROejpV?=
 =?us-ascii?Q?pUDwUx96F6Y5umAm3U3slw2zFCiQcPdAImAauupa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c71e5ab-34c8-43b3-118d-08ddebbdf273
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:18:40.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMkclWMrgi9S2+v4McQUZUCJvXhyttxQS09+4WncNOE8it/QqY0NTqrO/q2y5/GcanSLkJVKJ3jdxBdrk8J9Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7380

On Thu, Sep 04, 2025 at 04:36:47PM +0800, Peng Fan wrote:
> gpiod_set_value_cansleep has an internal check on gpio_desc using
> 'VALIDATE_DESC(desc)', the check before invoking gpiod_set_value_cansleep
> could be removed.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/phy/phy-can-transceiver.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> index f06b1df76ada023f432dce892c3346f45397ab54..b7d75a78d9242e2003660a87d2d4c9f784aea523 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -46,10 +46,8 @@ static int can_transceiver_phy_power_on(struct phy *phy)
>  			return ret;
>  		}
>  	}
> -	if (can_transceiver_phy->standby_gpio)
> -		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
> -	if (can_transceiver_phy->enable_gpio)
> -		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 1);
> +	gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
> +	gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 1);
>
>  	return 0;
>  }
> @@ -59,10 +57,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
>  {
>  	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
>
> -	if (can_transceiver_phy->standby_gpio)
> -		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
> -	if (can_transceiver_phy->enable_gpio)
> -		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
> +	gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
> +	gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
>  	if (can_transceiver_phy->priv->mux_state)
>  		mux_state_deselect(can_transceiver_phy->priv->mux_state);
>
>
> --
> 2.37.1
>

