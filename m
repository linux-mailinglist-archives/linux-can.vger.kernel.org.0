Return-Path: <linux-can+bounces-3015-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366D0A54E81
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 16:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CC837A16B8
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 15:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D94188A3A;
	Thu,  6 Mar 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SfqwZGcM"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EBE2E634;
	Thu,  6 Mar 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273468; cv=fail; b=ZtBn+8FQgCE5+EtuSBQTgz4oblrUouGSK5ycGdAHPrVGPRxJTwuf+Hy4l+dX3d1//BtynoQHUybIdD8Ve4TQj+0ss8iTkKqSywd7Bp4MIJGUQ5GeV9E/zzV9WrjS5D3R904lw19y8hF9G5GZVHWleqx+gk5qNFKT7E2G5lukU1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273468; c=relaxed/simple;
	bh=8ObZGjj+m4AQkKiBVusKGP+I0PW56BNd0huWh1w+o7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bTCIbt5cZGfuIXFmRd5I0GrMAGZgFlwD8VW11qOUIqIKnz6yEQ1Fvup/If9RXYEW6MfJmDnfukhsudnk7W/z8Y7JqW0x+5I0QM2oDS3SH5Ine4PObRyNbbY1ZV02aCX7gZ4SZIH/vwuH7eaKXLeeurHRVa4Z5z26/hDlLFcn0jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SfqwZGcM; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIbrRN5Q1eoAo4ZGSepYx6XluA1lthmaNTaZggwWa5iQLbsDd7zHIsZYXxnm4YadkWVxu8AzrM/gHeeMDdsY8w13h0AMnxU2xrHJdZLB5Tve4bsQ/5eeTqVUiCZTBr7Vf+Zap13DDNjUKoKdRuhs4OSy4iqw91M+txrP4HQwfyMBZCHL+FA1NKLDWa0jzodBZKaO4GnwL+JUp+unZOw8n9qjus5F5CAtIfJQfKlWXAZEolBpC6LwzpUheVTWBLZ8SRXO1znIKuGdnsAP66Cly680mudT75ZlLS7IsRujepieyOIkBDdHOuV5ke5lQ23xzii3Jzj6sxLKLvY0NAQ7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI9PwG0lIuCbkq8XEhvUBnOTbUywQz0NtcNrRUiM0K0=;
 b=PNztHV3wbFXHJTOOR1i67bLLqvKE7GMEaiHOXHzZbsojmaEZNC0sADkHaRzQeI1sfMbDKNVKlCFvlGGXrGmKEzv4JRkXegSAqLOzJ/Nmp5j7RbNJKnRu0sm2+QjfncszCCqbGbnDgBTnqezpIMc99ehADdZ0YTIs63JqhsM7PYDOrNKchEsAS38Bzc75qfI9OK0OidlfvPJw68N0uNO21V91QOBRwz9k9QWNc5evkITG9N9ziqAsYoBVjTNOMJW2mBYJ29tnCRBk6AlfZwLaRP6pyGCQkG/g4K7Ua3y1l1MT5YJjwKEqS+hJ+RHpbl4vINbuC8SM6XVXOrnLyMt9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI9PwG0lIuCbkq8XEhvUBnOTbUywQz0NtcNrRUiM0K0=;
 b=SfqwZGcMPNcUSczC7GaYDZpew1whQePQymhlBLTG8cidlQaSQuagSMxmSFLiBAXvHZz8h7PRd4JNqOotw1btYFcMBGv2TUihaU4qBrIrm9FT6GFktn0vZR03kF8y4RhrWKlzgvj216kmHXlFyxzsuF6uE4TPtcuvyK0HsCJpcrJMYT/glEznEX9aGh226u7cy5VRHQuAgGwcemONinPfnMe7u0DLI4yinvhMc3crRmITfxQdp2SwW88Q36RhQUeU+sXet/B9cQHFxVmJErHXGl2ClGBQLkYpWwEhfjPbGo1zWePQSWWs/qdQ6rtLm9OiKufL5BbHfmo5+0BVw5UkOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7890.eurprd04.prod.outlook.com (2603:10a6:20b:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 15:04:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 15:04:23 +0000
Date: Thu, 6 Mar 2025 10:04:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: haibo.chen@nxp.com
Cc: mkl@pengutronix.de, mailhol.vincent@wanadoo.fr,
	ciprianmarian.costea@oss.nxp.com, han.xu@nxp.com,
	u.kleine-koenig@baylibre.com, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 2/2] can: flexcan: disable transceiver during system PM
Message-ID: <Z8m5cCC597WZq8uO@lizhi-Precision-Tower-5810>
References: <20250306065921.2329517-1-haibo.chen@nxp.com>
 <20250306065921.2329517-2-haibo.chen@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306065921.2329517-2-haibo.chen@nxp.com>
X-ClientProxiedBy: BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: f31f743a-7a42-4ede-50e0-08dd5cc02e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LNJzHY2PM4KtWL0zasrmb7LGNMjA1DVdxhazpUuukWvgtfkUNjAs7kbCN4fI?=
 =?us-ascii?Q?Hs1Rjx+pNa2d+N055Wt48XAEoJmMkFqVMnUZWaHmBnmMuC7cX0vQBpwO1Nmv?=
 =?us-ascii?Q?UuM7EqtpIUUncAHkw4cQF88aBJj0A+nJB5PSgFQoA++EBe4ddHG5XHz+ux5q?=
 =?us-ascii?Q?7OGmimh9uV91OMX3cHGE0L9WNo2iuT4diNqHx0KzXdZYlNPq3vSuS7oKHNtu?=
 =?us-ascii?Q?KlIvsEVEhFmTDHvjFZt7m5lPNSQzxT09SifgaLpH9s+RHNk7zmBFYS3YOAPB?=
 =?us-ascii?Q?uaC/Qoui9XVqE+uwoLF+O9KEw7RS+x6oRJYPm3rzUR+8vbwGrszEQRQmTAOm?=
 =?us-ascii?Q?XMvQaakzALrTTqwUEOzwrslAMJXynvvCtRcbZIvnI74lr4xDj/0Nu0dymiOh?=
 =?us-ascii?Q?BHeFDBoKV/cXSTU99vvvTMrmYebn8DLEAM++ka8h/B/1t1m2IWhNp9yVsCz7?=
 =?us-ascii?Q?2G4dFCdRnMAa8Wii/CX/EdccphldYpXdKDosXu0qoxgVsLCIfAzRqpcyVFlk?=
 =?us-ascii?Q?TiQX0sFgS82LRiuYntFOKLEN25JzvJYo4Qn7xEzFk/gSyy6yN2WJNPUparRm?=
 =?us-ascii?Q?ic9c916ltgIiv0HeXV8Adn3qkT1DBfK0hnyam6wmWhi/FeJiexQEOmp6UTqI?=
 =?us-ascii?Q?dq//CKHOag3QkrwZysv33Q92jV79Xe+Md9lwbQVh4WNSoejzyQZrVVmPoBg0?=
 =?us-ascii?Q?2adim5ffED8rM/kjXEGl/bzPB5kMJTuYEcp0MsTnJR36UE6ms1oEy8dc7pak?=
 =?us-ascii?Q?7oqOG0dQyeLwmXDIrRAmr5MuIM2K2lE/cueU/fcgcT05xDyqPIXPEVxLUY3u?=
 =?us-ascii?Q?V2Zpyvzusm/wFSH9dViOb5yNWjLDD4S5UylA/RyUC4Sy9UcfVh8yRGol07Ac?=
 =?us-ascii?Q?0FwSBvwmCJhqZOz+D+xSlEdkwHZ02qUDLsLajepOORcPYyI5rIHJHz5yv7o5?=
 =?us-ascii?Q?YNy1K/d6mNGSrCMQGIOr+G4orOGA+PY1Hv7xNPAg11d11G4L/ZDeDCO6T8HU?=
 =?us-ascii?Q?te7jSr47XFMl4DpLkF0G69MtDvuUWV0FaMlMYEbSBJn46l9zqWK1CliUQxMU?=
 =?us-ascii?Q?S4tXBek4zwA7dBL6lEjbUO2C+QEYnOZsZsiM9NNSU6eB9vykWroZ6cCxmnnt?=
 =?us-ascii?Q?voXAs16krs444RqWQQ9GeVJO2qPIQSorEUcQT/4h1RUtCfZsA8XPBd10DuZl?=
 =?us-ascii?Q?C3BXVgMSzyJ8Nz1VFA+xb5ZTOqhAK0IINJz8SRLAxR/0wrnL/Ixc4Zyp9af7?=
 =?us-ascii?Q?Yn3DvK123yaQAtaXHvkogFpPS7X1sVSQGumvFNgD3LMqZVJBTp1Hi277EwYM?=
 =?us-ascii?Q?JV3Ihc6Vg4YIMUFPE0J1HbeA+W55Z4uXmmkaBDdKKq8/K14WY748+RiPlzg9?=
 =?us-ascii?Q?vOaRN8N/fr1rnJhuDVa2fNEXl35XaaFVj1J0xb3gK6t0VWC/BlxUFkqNbTrA?=
 =?us-ascii?Q?UFgrKkQfNVB26IO8zUlULuuru0YLPs7D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHxg/iNBdQUvybXcTiGE6VcJq7edd6d2+Us0FB1H48i3Z35G4S+9oy/CzwNT?=
 =?us-ascii?Q?HsVeJrwFE8014qDH25tRVlgyyAfarZxvAD8kdWDaLpERDV+yYs3ge9GG8oH1?=
 =?us-ascii?Q?XoSg7a/p88zJWq/S/nBcJuv9m5u5e8hdVpgH/i9bYbHxCJoleaUoQQw9qx3p?=
 =?us-ascii?Q?FdobVb8UD2tz+dXKuEYFdhwxV6unGLfSFRKelJE8/KFlNC7lrM6sHGmLt+ct?=
 =?us-ascii?Q?H/X3LJSi2isH260lAg48MFt6Pz84tTSMPAgubAPrsqat4SpsR0ESkjH1S2u+?=
 =?us-ascii?Q?SxYuRr6dcSn51Fe+LdpnGcqQXof7Ne/Srh1+sxOKW086KYutfjeTaM1fgSdE?=
 =?us-ascii?Q?s0IcHITLmZgopx274DuvhyiOOOQO3qQUwVFYuikw4zdiine/KcR284EktFYT?=
 =?us-ascii?Q?Id/W+f+zuQ0CN3FOW3jFoJJc6nXM2Ox6YI3PKL7CLSwUSyYLB6jATBKFamvd?=
 =?us-ascii?Q?AZYKKCktE5vGYiIG64HYK6ink9yvjo6CoQ0NiyxAE4R/rGM2wPc7GHZ+qblt?=
 =?us-ascii?Q?dV2Ctx3YLntox15q5uqTNsQpjRHEnRnQDvxGDUGlyf3lksdFXtv4xL2s2d7u?=
 =?us-ascii?Q?Jf44bmybPZsiXCRP0MrA5eOXvlMpAV9fTNQvLuVKklpMEa7CeakwFQF7Ixrq?=
 =?us-ascii?Q?NCrTrBfjJa6j5y54AiCt2FoL8ThyHNYDNgiGOvqAveW3Vl7Wu6wua2bYXLL6?=
 =?us-ascii?Q?ho7rEoT93jgTglumleZ6a6fDr5cBX1uKDSWaKRE0htdutZvoEnE7G31S7gEo?=
 =?us-ascii?Q?rLF1wO7g5m6OhbNqd287mYNy7uVZ6U9hNswBbshYG/1zhNqOYa26Oy6dC8UN?=
 =?us-ascii?Q?x2LqCSrACZ98C+S7295SxHt5l7zicHd5ynLKcTg9MV2Gm0HCRH/8zQp0Yi8k?=
 =?us-ascii?Q?1YVs8JMznqCdRjXTgu+73NT11U24Le4BQx/jxsgFuiOn17rB07JiegXvsclR?=
 =?us-ascii?Q?IRlWCTf8MoloGYy+CELhsUL31n/9ep6l4S9wYBI1aW5Lygb7DABFkJ1F4UlM?=
 =?us-ascii?Q?bjJWI5nl2XUUrmMux5Ri9r/UWJsULynbDkWIhiUTI3zDUD5U+t+pyDFTtZhb?=
 =?us-ascii?Q?fwnT41TVrOP2DYLOL2+tSkVwlpBdwxEiZyTYfUot710Y/1ux/YRxvVnuDX90?=
 =?us-ascii?Q?xAwlYUpezURFHGPbb/UXyAguDqZKPwgr4/gzlaS8ugmamwuDydBKZc37giSl?=
 =?us-ascii?Q?fKLqb3BaxUl7YYoxC8+AMqTNxxm5Lx0TN58XAr9VKxb/wWe24Z9IvU2SOtvI?=
 =?us-ascii?Q?Vi0/l2kxtPx6JjqbzYQgwE5TBcyyY1MhzAolTLa50RLPOiapnrbLHWsNWZeU?=
 =?us-ascii?Q?qEfX4Ar5yPtIz49NehyQg/rKSCZLZPOt/ER/zPlGmltiqdbKIGM89Pv7GslP?=
 =?us-ascii?Q?NQ7SpX2Y59nPKkVHHORjjMKhMaTXeI/I1Q7niIk90b7F0Nb+mlMpijEC7JKJ?=
 =?us-ascii?Q?y7mc/5ZhGGg5p4YcTQss59mNjuSNSdOdGAzjT+tAj7ZA8Dj/hefDTDRyAgV3?=
 =?us-ascii?Q?ir7BoHHSbmxkeOKdfK1loqepfysvqvW8gDmhaaWImDIupkF49fVcjUKYut+q?=
 =?us-ascii?Q?8Fp/FCJfI7OTyu0uPeOPpMh4tqZ8t4aXuQCoKYo2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31f743a-7a42-4ede-50e0-08dd5cc02e27
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:04:23.6307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsT0MviJAzdiIZK129gX/1cTAueupmcpar0dJJL7iu9+r7rFndrsRR7IxM+xnz1MNednUS5roxghYoCuP21Ejw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7890

On Thu, Mar 06, 2025 at 02:59:21PM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> During system PM, if no wakeup requirement, disable transceiver to
> save power.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes for V2:
> - add return check for flexcan_transceiver_disable
> - disable transceiver if flexcan_chip_start() failed
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index 8415ef71f1b1..6c59c2cfcf05 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -2292,6 +2292,9 @@ static int __maybe_unused flexcan_suspend(struct device *device)
>  				return err;
>
>  			flexcan_chip_interrupts_disable(dev);
> +			err = flexcan_transceiver_disable(priv);
> +			if (err)
> +				return err;
>
>  			err = pinctrl_pm_select_sleep_state(device);
>  			if (err)
> @@ -2324,10 +2327,16 @@ static int __maybe_unused flexcan_resume(struct device *device)
>  			if (err)
>  				return err;
>
> -			err = flexcan_chip_start(dev);
> +			err = flexcan_transceiver_enable(priv);
>  			if (err)
>  				return err;
>
> +			err = flexcan_chip_start(dev);
> +			if (err) {
> +				flexcan_transceiver_disable(priv);
> +				return err;
> +			}
> +
>  			flexcan_chip_interrupts_enable(dev);
>  		}
>  	}
> --
> 2.34.1
>

