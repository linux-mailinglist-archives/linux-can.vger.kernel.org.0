Return-Path: <linux-can+bounces-3014-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CBFA54E7F
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 16:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118A33A8EA4
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7454218C337;
	Thu,  6 Mar 2025 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ONF9d6sf"
X-Original-To: linux-can@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A213B5B6;
	Thu,  6 Mar 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273400; cv=fail; b=beY7OsFIjDzmdfM/DqXOYjsKzB3h5a1P89rq2/xbZ4voEK+IZnVyoq1we6C6nevXTViytRygMycrvBEVOKAacfx0VCNqqZqcz91X/ldiAC1LhruOm2qxnQjACw+ILYGkArVU6I3z80Sz+ABUIme+WKh8ZJLdExSyfCb9ouniobA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273400; c=relaxed/simple;
	bh=8myB+d3qQhiZbYg4NpDx203zy8jpxLX5goZpiUm77bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tOjlJJSRl2yUDl3nrS42mo6/34DjVp6xYgDLHhgXme0Zv0LthGCyQFzudYNgGEn4W9crb1rpVFgnBoqFGJln296Zq+T555lECN4o4MS+3TcZBxuAG1E9UpeY1dxFJqmDXywWj/vXPLHhCUwowS7KrSIkPuUtvKK/zTX89gBbJWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ONF9d6sf; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rO8aUPqR5aTgguPnC7oEZntHVFXU/Xaz0aYOgLzZ8Pye7cOALL4S5EEwYafbY4A27psh9lv4ggToAfLX2yr3zCeTiuZ3Q6CZZMUxHys2TCD47863TiaY7eWo2WJjBSHEM7FD3S8YGLMqdDWrqbeVRvhrYfn6oxFrcMOut8OBDjlz9652ZHsnFHi+FCRZwYy7nMl0x0H4M/AsiKfyp3b2hLFZIKCeOjExe/We47YwNZ+5+DAFsw1pl2pdVRYDV8ujMK/ElmfR/i/uZLTmKtUVfL/QGvC/b5seSgNLLoCDq04CP7rne0DgRhywJEEu8UNMv/vuJ0iV9yul/jdfRY0lcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPeAPRV7MMQLAnFXyPdxcOLxiI0kmwa0lbCq7HmNKVw=;
 b=pmggmiEhiMxGvOSaK6JA+Azqb3FdnDc/DsbRljT6+PMJK9mPgjVFMvZ/KMPVnu1ESpZAdodYHPK2amitUJukcrhKa/23qhAXV48t1D/uNo3guqrl7V3fjYBxrsPfU9bhRARl+8M6TN4wO2W2SR4BO0eOXCXZsCNBQShVoQg6/Nm6grbEx2RTxRC58Df8TLS6H0T4tmJGnu2VO2U20kK1GaMQ5ojZVKFIR9fR8tbASFmMpBxpdB078tVwwJIS2eDo+BWJyoEnOseVGT8V+qPxOuMeox4MfkjmIqDJ50D/I3E4P/4pdcMp80dnwETJfsED8KUEXTw4BJ0gV+JOmhUbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPeAPRV7MMQLAnFXyPdxcOLxiI0kmwa0lbCq7HmNKVw=;
 b=ONF9d6sfdIiYmrQYteHBIZM8idWJSWQjiJ+337I7FCgxTDuf3cWlOqIJ2me5eV/25cB/8/bArzH45StZCfcjAmBg1jDcagS8HO2UzVczf4Ae5eVjISeRATgXIKj/2cPeJsy3b39TbA8rOIFbh/w04aVjx4B78hsgikrZ28H5DsIHopzf3+q9mWqsThWOv4Qp7OIg/2AoAnJWLQCOL8g9YU7gBeCC0Ir6uL8Pke8YLkonrwvC2xOsh2pN++DmEFQJG7aBrq8VcQajrtnfCVYvJ6HBK1Ax0SaaIF6gd4frNx7bqwbJVUAy9MUJ+WPgIEd+9et0Y5BY/JKr31AuRXcEeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7890.eurprd04.prod.outlook.com (2603:10a6:20b:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 15:03:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 15:03:14 +0000
Date: Thu, 6 Mar 2025 10:03:07 -0500
From: Frank Li <Frank.li@nxp.com>
To: haibo.chen@nxp.com
Cc: mkl@pengutronix.de, mailhol.vincent@wanadoo.fr,
	ciprianmarian.costea@oss.nxp.com, han.xu@nxp.com,
	u.kleine-koenig@baylibre.com, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] can: flexcan: only set CAN_STATE_ERROR_ACTIVE when
 resume has no issue
Message-ID: <Z8m5K5EwiyiYikqL@lizhi-Precision-Tower-5810>
References: <20250306065921.2329517-1-haibo.chen@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306065921.2329517-1-haibo.chen@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd648f8-2e75-460f-1bd1-08dd5cc00530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eSKih+2osAQv42pOJ8YcfPre1GivVvdH64L5FX1RXz/0XyhbWDG3RRV5AZtV?=
 =?us-ascii?Q?cn2aQ7d3wKd3QK9/Ccm6G0S+HQkX4fqYLNjT7W2IanIoGrGnPwCzMB8VsHnV?=
 =?us-ascii?Q?GpxrT/sIT6iNmuuhSP4fT0g03W/LZyPcfKk/C6T/f3nCg+POksJbjuN92Ls6?=
 =?us-ascii?Q?6sosfYyLsaG6IDNmT3ko2go6OMxj50RotaeRhxJFqqz3ed488HzEGUWPHVvN?=
 =?us-ascii?Q?NrWfu/sXE1aDSEaHWC6OMehY/wmhrywaepP/PI84FpWudbZXWqNmAdvidJfc?=
 =?us-ascii?Q?0UeSBQoaPgCl4wWn9W24QNkEycRdXQVG2CURBHyqnJ6ixSFsQCgYivbtOnJf?=
 =?us-ascii?Q?JUKzoPCQVHbH7wo3wkv+DqMbiWvE+tb/81o6GxEPxvi2Oiy3jjBCzgvcXGzD?=
 =?us-ascii?Q?fKPblrWalLVkdts9T2BH49OJe97VOCIqjty/WUR9oePdfXhc4akPfl2Yo0h5?=
 =?us-ascii?Q?wy9uNC7xIsKSTssVEEJyiW+FMxmmavof9/t3yYDI7Rn0gHsQ8xG5vm30qtf9?=
 =?us-ascii?Q?KFtFkepRPez6eSRsRQTfyW2a6wyRyTWY5sqnlKAHpfKUyQhP6XcuT2RbW6BM?=
 =?us-ascii?Q?qA93M9t4zAS5FqFFd8fkDR87eKEHMUGje6YRR6CrVp+P+XX75TjyBMzNDh2F?=
 =?us-ascii?Q?xma9I2Krs0HxQ1hVcPa0iQlgc1Wut1JwXMX/kPYosfWuTVIPYxDtl0SiSKwn?=
 =?us-ascii?Q?zHYCunqsw5H4GMXRZxeSDYWHHppVSYbs5TacZoW+0DsaYCu8boMqQkzzSpZz?=
 =?us-ascii?Q?BuRx4qDAZ0ZdvyrB4QrFLoOVLHQpD70y8xFP7xljTxCjOXMW2hPGvfbdUrP9?=
 =?us-ascii?Q?GPfewzvFXN5cOXleTgs7ibIilBSHZpjygE0mwJI+tHLdVOycBSGfpMuRkpwV?=
 =?us-ascii?Q?KeoXaxk2ioCfM5x1khYllgXRCX7SFVihtZyBI9KWax3tGkVxR/lwJafvakzB?=
 =?us-ascii?Q?qpLX5wDTkfRgIqxn8Gd+UGeDixub/Ze7LyJHIMD5cONhB0bZ9uh7A4VF2pUT?=
 =?us-ascii?Q?Ov2tXVg2f9yF1FkBxGs+swXrpMLMyRLOF+qBlA+fFF+Y0BTzwS6XVQb5x2a2?=
 =?us-ascii?Q?PciPHXEj8HlPZWqYziMkyzJxctR7SGrndRWTK+DcK2/J2GEdNziwuD0EBje1?=
 =?us-ascii?Q?4wQI06x4sqoIM0fPumHrBoYGb8i2fY+yTpPyn/+R11lDPkAsywAHr/EoYgNe?=
 =?us-ascii?Q?f9b18BKgVLp+/RIxwgmIpnqdKvz39uEOv1zgKNTxXmFHkykx9KE6bq+zxuG3?=
 =?us-ascii?Q?CkCyrfLtF4vyY0gN8IMhbTgH5vlhKRaMLKKbrTDDvcwCox3+zqZjM8UNKDGu?=
 =?us-ascii?Q?OPk+ZCcnnBxKN0Ingqwzqu1H9DVKApcoLdYBL+/co0en6pSx7o3RzvxPuhfh?=
 =?us-ascii?Q?6F5GIwonrQ4Tra21jSIf8SoJbHtE4KUCf6p9YdbYXm/JglwZC/1WdxBVgKEl?=
 =?us-ascii?Q?iUWUXKH/mH9hc3pDHyBPl8E4MlPkZuWa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5k7UgcRyry4ZhkLofOHDjvnlRWZzXnO+eFnGC0FtLeKgn/j8tpvJe3eBE85z?=
 =?us-ascii?Q?ugh6tTwsBJIzP1u5iRLKlR/kaAR3Bs2paNUSZWPJI4t8VOQLSlXu6KZ23gYD?=
 =?us-ascii?Q?/9JtN2Jm/T6mMXwzjKIWztTPsn6q2z1irx87i4Kg0LbqcjwrJfo8+d6g+89M?=
 =?us-ascii?Q?CCYNpUc8o1fuLDmQk91PBFSJVjz9k4KSbNcJ5HUNcRgxlPyME3ao4c1p2+ic?=
 =?us-ascii?Q?fG3poGCLLmsnclVqR8CKFfbfSgxsgyBgFSyyPnXozTpRWhk+XkphPZK0mVK9?=
 =?us-ascii?Q?KoZfgiwjZJXJs2L+Q3qe2msf0OdfKUfxkVuenO5RbmI3pOTJLxd5Fg53UGK2?=
 =?us-ascii?Q?iGB+vKiY0fZrmbzw7OIBQthyDwwDSoJCS4SRuJsaVoo29kWiVX7KslqtCTZ3?=
 =?us-ascii?Q?Qaeg9ht1r42odm1a9D+NIa4nHVaMND0y9OcxUrDGwODt9JNYmq2zHFI4ISd5?=
 =?us-ascii?Q?smEaiHN1iihXDm7HvlZDEHU+/bMfiWsDdP5ZO5arV3MFMB6eKEyegVAN5NfN?=
 =?us-ascii?Q?WWnAeWotLBhnNCLNEn1sjiB6AfVgqt+SFdrUiTfqB645t+cu9GNiPcuJTjVU?=
 =?us-ascii?Q?BnuVGQKgCv8urH9IfoDzqOsgX5I9/BrPxImmNciqIFnyoafacOkqHuC0Aaoq?=
 =?us-ascii?Q?qAcD5Hw1pbHRwNJvinDxeh3cfYxb12XLrtaa/PBws8clJb9idfRkAvnEwaB+?=
 =?us-ascii?Q?J5V8ulEB+CqUB7OtIADvNoZw7ZZibg/VwVoA7M3xhrmobWvSjmVqrPcyK3bU?=
 =?us-ascii?Q?M/13Y8kZx4XoPSxMGyqgdz8nwldko3/Yr9T2+QTEhigPU2xEp1P2nNTZGda/?=
 =?us-ascii?Q?2dDGMcoZZjW72EILfeU/li8s043dmxjL1wxuszWZ1d/Kp42TlVslLwM+af+I?=
 =?us-ascii?Q?RvVsXwh6oRrq7qw0l8yEEoOy9V625/tK5Hc0VR5jUZJCo1428BqzDuRT1JKD?=
 =?us-ascii?Q?nSAamkzdCDhoXz10pnX8uqvYz/ZbR2BIL7IerB8v4OJpD7mc1K7VJkSgLuQU?=
 =?us-ascii?Q?bCILGHMiwQx4jrB0WD+0RfYAQU9AigrvuYz4xfyLYpBAG8yeuHVxU/VOzcHr?=
 =?us-ascii?Q?Tyu9Hd0qJMtuHSWNrKtmSpwL935hy5QjCFT4N2wRhXuzUT1a7i93zTbSZXg4?=
 =?us-ascii?Q?q/QOEPSJEp4O2l6K/zNzw5/HiYHIYTIkT/uL2VS16cPo+rBurgIloop2AjYg?=
 =?us-ascii?Q?zGu5T5UnGJgcwSq6Rc3gCsnJCiM/KFyj59GsHuOHv65ZYFtgocx2k9pxm7vm?=
 =?us-ascii?Q?3Zk6gVNSTy46UgxG1RUMxDzuo6xCmHvo7LrH5ToWHDXIlLBrOyseaBqbM+G1?=
 =?us-ascii?Q?IAIEm1JMAAmGpKGgal8BT/5DELhIheVryYgNiNP6BIqdTGJ6fmUg7t73A3MD?=
 =?us-ascii?Q?h2gS30Fj+XMxaWhFvjsaz2Os16pujJzG5o2TZtAyXx4RaguI8Q2IxA7mK4uJ?=
 =?us-ascii?Q?RjjLmvk9fzhdCHYAAQh+zvBjrw9fHtwDjXB7oW4jFZpyLl5+KAnKZ3yBp+58?=
 =?us-ascii?Q?oXtCC1Dk8euYU8th9nFZDh69T8ISnzD0R3cGnWAbYtSu4rf++tlAdud35Zvz?=
 =?us-ascii?Q?NK5o70i81kuHUINLAZ+1oLoqQ9G8Z+dL1CctNKcS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd648f8-2e75-460f-1bd1-08dd5cc00530
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:03:14.8340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vn7B6F2HJ//kJTGT+t41aPcs9DWu/ZBc+zAEv4ul0D0MAXMyjBU1jnIxYiwKzoXxjTF9cOFWqZlUQRN7ATcJ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7890

On Thu, Mar 06, 2025 at 02:59:20PM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Only set CAN state to CAN_STATE_ERROR_ACTIVE when resume process has
> no issue, otherwise keep in CAN_STATE_SLEEPING as suspend did.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/net/can/flexcan/flexcan-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index b347a1c93536..8415ef71f1b1 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -2311,7 +2311,6 @@ static int __maybe_unused flexcan_resume(struct device *device)
>  	struct flexcan_priv *priv = netdev_priv(dev);
>  	int err;
>
> -	priv->can.state = CAN_STATE_ERROR_ACTIVE;
>  	if (netif_running(dev)) {
>  		netif_device_attach(dev);
>  		netif_start_queue(dev);
> @@ -2332,6 +2331,7 @@ static int __maybe_unused flexcan_resume(struct device *device)
>  			flexcan_chip_interrupts_enable(dev);
>  		}
>  	}
> +	priv->can.state = CAN_STATE_ERROR_ACTIVE;
>
>  	return 0;
>  }
> --
> 2.34.1
>

