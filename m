Return-Path: <linux-can+bounces-2118-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FD39D2F1A
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 20:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E051F2340A
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 19:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E501D172C;
	Tue, 19 Nov 2024 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VJFWsNiT"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2047.outbound.protection.outlook.com [40.107.104.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B2E1D0F5C;
	Tue, 19 Nov 2024 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045850; cv=fail; b=SqSh/WSHH3rP8Esz5cfI1XbBIx8CXl6V+Eh3DqFH8gQnIxLaJjH8HBoHq1YzlpImFGwr3R5gvBn2H+JiRYYJn7hBbFKfza5AS1uk0AbT+5j7jAaVRocp2ORgSrTZHs/a1FeMBat+FMVBrmcrPwCqnn3t/NskLp3JFN7jyrjZG2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045850; c=relaxed/simple;
	bh=LD5Oe/8KaoEEnw7rv79/dI6fhjTZpwqU3FFqEIjyAz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pVXb7qp7vnTc/YhBvKRcLFGd6LElIK4Yc3KPAtbXvECrs8kVW0ehJiBFP7WmjowaPnAEIDF2oBmjQ0YTSXZ7REwypA924JCqx6E4+Ep+YiVrosgGlvZ5rEzUL+Z88AAkWuTAo4gHR922yw0qzkxGtBXQksZWyDzNiQ4ddpjbv4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VJFWsNiT; arc=fail smtp.client-ip=40.107.104.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/7MnVzCTKVogCWEXRJwHivw81iXTJvAk4PDZ2+YLIzhbhcbpCGggEzYL8MfBL4/daaNPyI7p53522haSoZSg7JERhnVMjfI5SGgC12EsDDw7RtD+OV6a+Yjhm6bpp9h2DxFAkhsBYK50J0FXtZa3QxLzGLaW9Ym+Ul7PSKAfE05YB6MSmBkj1eWHsozD/FaZU4saAw5CYfSE1unS15W7BBPUP4lxR+Myct1SHsw0PAkxyVgrSB2oGSNgiAWJdxEwSQQYf5GcJL217kGW4IGBQsC7JEmijzmAUvkQ2HtNLzoFAoZygxyk5Nl1wQ9AeNVHw3cHtEPrXzzK4obuD15rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3N484l9aNAxyVk+91YeRRnHacmSQ4iuXnWggxuO9juY=;
 b=JRyb5QoXPxkCxY1j5BOjNehlfgBNWwHcjpbqu0DDvXyUxWbG60mQQ9z2DdbEfJ0AvWzRkmdHGiNV/uEsKARvL5N3SKF0RJDn/zDaw3AKCeLtqafVQjVS1PNg78uPft2B6ScvtmMaNHTbF+oPNSLjQee9UujMsOdySnKJszybrQ9vAGUdaWT3RQwaKNhD/nXXlegEA9OiMp6Qr7q/YucYwyF+qvAhi8uaKm/uQkCSTKl1BEqg9Uuw5d94uYNaUeHI8+FD/KADfBJVnzvl0PzHqxdlFItkJgiJnA9HBv/iF46TJ2XH5u4WQ6dImn1DRJbHn/ELReZiQGjFJ7L65KECqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3N484l9aNAxyVk+91YeRRnHacmSQ4iuXnWggxuO9juY=;
 b=VJFWsNiTgR3vPvDTrdaMCBnvroN16IDjxQPsOVsG4FmWKvvBpTAE0594j6RCLKsUHpnaeC5DTDt2xsXtd7S332Bj3o/Bqxa2jew5rGgMJI+2Ws/i2ibypdEhLY+baRS3ozASJXVvrWYmt+zS3Q4UXj9Q6cXzFrUoEK8pS4Ei6FGc9rkb6rwzpoAsAl9gQMb+lhapml0eRH1vPVVuB9yxK8CLyBEZhBBXv7POxNobZsdlTeWIolw1/10YmIpapU1/Fv4IJqBUqYY6lzkGGDPszYeVmmd70eWVHoHqVkq/6THAM9PbnELbAalbDq9P7RflwKF0UmAQH3eRcKCHeNQNFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7628.eurprd04.prod.outlook.com (2603:10a6:10:204::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 19:50:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 19:50:45 +0000
Date: Tue, 19 Nov 2024 14:50:36 -0500
From: Frank Li <Frank.li@nxp.com>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	NXP Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 2/3] can: flexcan: add NXP S32G2/S32G3 SoC support
Message-ID: <ZzzsDLIYVu+HPyTG@lizhi-Precision-Tower-5810>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-3-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119081053.4175940-3-ciprianmarian.costea@oss.nxp.com>
X-ClientProxiedBy: BY5PR17CA0039.namprd17.prod.outlook.com
 (2603:10b6:a03:167::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: ce817630-8a99-4608-fe01-08dd08d37557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CS4gbbm8GrHpRCYIfva6ohbVU9fmmPrW62hvU8HnsATANhLI3K8Za4nCxEEp?=
 =?us-ascii?Q?S+N3KzELpXMS3v7QmWCEo3YaHiWdi61li3dAVL29PjYaQPSHbsQoRhyrseFU?=
 =?us-ascii?Q?Ho/4jQcpH3rYlZlaJKWF5K+57wDM2p1K53HO2cJjFxtQdssHGW2AclRXr9rm?=
 =?us-ascii?Q?t0yW7DwjsFbWu+too6P96zroo5lUfg71G+Ur9KOjVeGovjIlv8LzC0H26OOO?=
 =?us-ascii?Q?RZqY/ufYtxq9JYJTU0xrLeAbOgUxzQ17FZzxo73MV9iS4Rb3RZZXvAJrcdQH?=
 =?us-ascii?Q?2LAq2/mF7dsZCXqIPi9tbyafLzRtdTocYX/WOjhIwzSi3chq6KU/b0Vwghqd?=
 =?us-ascii?Q?MALus5DClQLxDf5rYVej1MGhAf0+lTTwmR4D8GfY1zMr4uS54YeR6nS/ARCB?=
 =?us-ascii?Q?h809lnjxsOwEKaFSqvP2Zg9xbW0uYe5MXNgrpDtda3f0jobiJqgxGz7kfflf?=
 =?us-ascii?Q?PJ66m5joJ/OpQQE0hNDipUj+8KqNZEYe4TR2h+lFOrOJJHFXytArIcmjC+Bl?=
 =?us-ascii?Q?DeGP+DEKNTRqxXJFU1XpwaMIDdAERgNlE/JvRlSKaIo+rB21DLPpM9HXlkDu?=
 =?us-ascii?Q?tbgIBbF6fanVZi7gYbTzUujcjnHV5rnRtmwfE1sFP1wDaLOZ6NbdnMJB8h6I?=
 =?us-ascii?Q?hi1MYP//EIgJR5y+lOlNws0o+TG0O7z1nUPVbhl16L6MFkI5PGwi4MvkCYUw?=
 =?us-ascii?Q?X05MY+QMPLv9HevDMWbQ0/XDF/WGDjzn+tKrqFbf19EY+NgGzjK5X9/WEvBv?=
 =?us-ascii?Q?dx5kPd6g37zfndXvtzGLAIZ+8XWcWO0c3XDO2gsG8n7TU1Q8DVgj+fpYgQqk?=
 =?us-ascii?Q?6i3e4Uj3QQtAiTLrlqSYo2oaV0OtAJxj/Sk+mEmnDUMDFrUd+7eADzyUiGhy?=
 =?us-ascii?Q?Ur6q8aDdt3AyFIdbhu3HFQ10PZC9qRO9VU5nx+g7xCID6PsV738DonA8CAIU?=
 =?us-ascii?Q?juDp8KoGG7spFmAFDq3gV1pc5btAifFbTo4pR0M8faYtDl3mUt8/JynH/kEn?=
 =?us-ascii?Q?Vaar8KqhZ/w/NPYntNROvaX3QSmnbzYlgefhvyHQJ830ArCfBGoY+KTfN+1H?=
 =?us-ascii?Q?2jqL/kg4JvhmICOE2bXaYLfKsrG/sjGPxxEHAgrrJRL19+p29+lc0/upoh/O?=
 =?us-ascii?Q?UqpzhqgGKb1FJds+rXptw1O1FxMDr//PlqXc7c8IUSNKrHqu+Moj9xH6urJs?=
 =?us-ascii?Q?0bb0D8zjEM6ExxdHVFbyFdbSOyUL/Qx3aOD8gFcdL6IgNxWesZRMDq/wHwiO?=
 =?us-ascii?Q?Ej0uiemxZvCFG6DzyqZTeyc/KavAgVZxAAkoxTfyXs43Tfw6H1qJu/OY7oz7?=
 =?us-ascii?Q?ZB02FUaaQtp/Yhx6p9ZAn7t7qoQE/LjMnz+imw7E63GXxa3t2oUxRVFKpycB?=
 =?us-ascii?Q?zv7dqLU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DE4udV2v5oTCkHx65Az6FrSh2LKTCFiDqm5zEPgLkPtX+qKm2PgPCv+c8Y45?=
 =?us-ascii?Q?qtQqQJQ3y1nVRYzyMRaTDQ7d2vvTiIIPOGuCjJCqgHaDmhy9f1fwOSykfmqg?=
 =?us-ascii?Q?rAPIN2LRxR/6WFe2VRI3hvs4fkoM38Sl+EIje8/130va+jmA2yhsUNWfADpM?=
 =?us-ascii?Q?SIblXxi/erH7kOZEVONxg14SL1DkXRYEdkqv2RVd27owgixTxjxR9/QnCojF?=
 =?us-ascii?Q?nN47IaPFsZX8Hg5yZajMY4Sle0QasU4bCcHy08XOfGn3fO8uSJKjELpcjH+E?=
 =?us-ascii?Q?8U7WSUunlyH0QezOSz/VT7sOYATcUOlpjTxE/0c9EkNh1JEW2z5DUfmN/1By?=
 =?us-ascii?Q?/m5Qza2j9qFcDhxGjZ3gbOEZBqaQCmMdtqajPSeBztWl8c13z8okR7HqNsZf?=
 =?us-ascii?Q?I+0Khy6BIytf+Fz4VrgTVR5K8vy3ADbKfswbl9fuXn9JFWSJyE7H/V0LHzpg?=
 =?us-ascii?Q?bkOndRAwdm8bbn2ehF/gmfktZmHPOP+z90+o2GUK3TIarODXjh8QbfQm01W7?=
 =?us-ascii?Q?v7X1K11EKQYaJiqUHgbhgKVzet6lJdjUhZb5KJfjQ4MzHwvjMAuc1tFvTHxh?=
 =?us-ascii?Q?EJ2PTgJxlshgzOg4JnVDJFlFnQjuW0WCv3Mb91L4kSpf+vB81SWhm03arxYB?=
 =?us-ascii?Q?4LznZ/0V+Fv6j1d97mX1Kjt/FMEgL1UQ36XgiVUaE46YIRTWH+KLK8oWcqzj?=
 =?us-ascii?Q?aEal/pvtxtRkz95/v4SXxWI/w75GQYv6JHr8f56lZiGNTc+/2aCpc9xa/5iX?=
 =?us-ascii?Q?6F0RV2bZGU3C1qdyhvPBfHK42loLQyoQ8ySXaPgQwVwzAaDIeSMkMcMXwZNe?=
 =?us-ascii?Q?s6Ww3a8wIDCYrFC9VvHCWpN78u3bhtiX2QBMAYnSbQvOj6hLW+A7ya4Sy4Xt?=
 =?us-ascii?Q?nJiQA/42avQOiPg1iRXX5OMgA/HjztTTcFmZJTZ9lekLiAp3MgziBXJe6OZQ?=
 =?us-ascii?Q?22/uJ7H9OIjeFF0MXI/u6vac8xobZlwH/j7LhZNIvLD7gbjgFveHpY4nudIf?=
 =?us-ascii?Q?MpPG1bVgIQCsAISyLxlI9c+Nvk7+bICFHoyA2GUEFgW6lzb45Nd0EO5sw6pw?=
 =?us-ascii?Q?mZxbn/7d4Oy+II3WAfJ8fvcPb6rg4rqIOhYQGmyLoi/KyFqABkW3ebDocOzv?=
 =?us-ascii?Q?Z5V3VlZXrnLbtlpEMx/m2iOFjoOrY4BuaoULBbllt0jf09b1iAQMt0edeRf+?=
 =?us-ascii?Q?D5kUqHw5PYymIFc7HxX4qQiP4oRqMsICSfE/VFt5Kl54Lu77u2l++18k9JRO?=
 =?us-ascii?Q?puYwAC3rUIDaMax5YZOM1he+AYLIdJghBbRQWW4RT6rBvvbHsTgGgCxMpiWz?=
 =?us-ascii?Q?L38iWSqL588A9SwMrNd7uFjLONXZLUMBB7SQkuYQ1kgPXx/JhS7zSCVWY3cx?=
 =?us-ascii?Q?bF4aYektbyynpAZN8jst38RqdV6HIok2YZBIZ5rHyiLNtKQPkWnRr+v7SGqa?=
 =?us-ascii?Q?ov4/2h/5ABkhOac+0hyHwYkqwzSNnUdXk9Zqv5IaLxpAJub3zjH9e5u68WGR?=
 =?us-ascii?Q?cAf4DYLbykvQhiKlWLiKQPrXQv6c5ZJMGuv4YhmNb3mqRFEiy5Kiw7tGtjya?=
 =?us-ascii?Q?O0hPfQUJw0qq9WtEkjiydZbDRiAHCfGwDFdH9Qxy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce817630-8a99-4608-fe01-08dd08d37557
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:50:45.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PujR8oUdJFnPrQ7v33kirUmJwSDPkxy9U3IffMdbGuXDiTE5lpVPsHAUPaTItR5YFe8KOvT3rAOKI+eV9S7agg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7628

On Tue, Nov 19, 2024 at 10:10:52AM +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> Add device type data for S32G2/S32G3 SoC.
>
> FlexCAN module from S32G2/S32G3 is similar with i.MX SoCs, but interrupt
> management is different. This initial S32G2/S32G3 SoC FlexCAN support
> paves the road to address such differences.
>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/net/can/flexcan/flexcan-core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index ac1a860986df..f0dee04800d3 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -386,6 +386,15 @@ static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
>  		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
>  };
>
> +static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
> +	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
> +		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
> +		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
> +		FLEXCAN_QUIRK_SUPPORT_ECC |
> +		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
> +		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
> +};
> +
>  static const struct can_bittiming_const flexcan_bittiming_const = {
>  	.name = DRV_NAME,
>  	.tseg1_min = 4,
> @@ -2041,6 +2050,7 @@ static const struct of_device_id flexcan_of_match[] = {
>  	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
>  	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
>  	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
> +	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, flexcan_of_match);
> --
> 2.45.2
>

