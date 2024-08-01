Return-Path: <linux-can+bounces-1103-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06DC945403
	for <lists+linux-can@lfdr.de>; Thu,  1 Aug 2024 23:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBAD1F2463E
	for <lists+linux-can@lfdr.de>; Thu,  1 Aug 2024 21:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB86E14AD2B;
	Thu,  1 Aug 2024 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M3pEG/qd"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013030.outbound.protection.outlook.com [52.101.67.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A88142E77;
	Thu,  1 Aug 2024 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722546694; cv=fail; b=g/koQolifkIvBPDwuNcIx0kbXjh1+5CiFbcWCnmpftBuHGqpQ300mXB5Cm8rqurfAfhd/nXCKP057ftD82+ULECYrxBNLed1A2do7OQwzzwgi1a8BaxiAKNvWWLZUi0hz8X9nLiabmOHQkxFQ7xwnYjbRHscTSgL+V2KvpB7P2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722546694; c=relaxed/simple;
	bh=e4xtg55mdtO7+HmmkbTIln6zq+THkmNa7kbW89JFx2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jkh+G6AUSfNscEVfHklalmkxTb8uhmu4nWaKvfyX3sDz9QA+KbBXQcM4SgSW/EgEQrTJR2XRyoR1hT9dDcYHvugimxjLlhTZNPgpVAZAtmznAhmimlXktwi2/oANdRk80fNROG7ocnIzm3CY6i+8AJ69mzyYW3ubFejjitX5gQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M3pEG/qd reason="signature verification failed"; arc=fail smtp.client-ip=52.101.67.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MV0C2aI7t6Hr+pZkBPoY6wwdSJFFEDY2ZEDPV1MnL0KCEwjYK1ulOBgFCl/q9CfuqpB0P7NVy2y7cbWhKFnPJ5oitbo9VI05+Yu4/JBerSztZtXgCwAXetAXDbydFYTwrefKnv/EupgG2ZZMrxk4ZwNFAg7j8afaRezXklU7Oey7tsTkXUCgg6Wh8xUZvNQTgSaOgb17weUwzlqyoQjL5dM5aKj9CawzR6uoOh+6pf02FRzcEsGerpCjY87ynnaBOVD9vrnNjfQSSaOPoWMaqiLW8P6iZ3aBAOz42KHvuk30SMq3Khku02gURAKQLAOLHfdf542leOIJlUlqAepocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHdjCen7n1k7BbozH6+kCl7flBliRpFDL0+efUJwIDk=;
 b=yiYV65cB2eW+suSUb7kQydu7R5X8yD6kpoZKG3XkZWY1JaYhA11pOcqZJx6jhpxxrGFGLc/OMyvBDozXoI8oLpjK7JjZEgoJqPYTrOsuDJAfciH8Z8CY7lsOpMh9GPIU4YOb8CyduUrzzEzyP+5QzR3NnYjv4dQrddmAzBtDeUuFRz7qax6Nkd+4Mqx75ajKCEPgQ0bXxCGttGCxFfKhjh7x9gZozQGvT12b0nVwsWP2Y1pdxsh6gJBvwd1BapOaeLt+mfjqS4Xbj/TTJgJlmz3Z1KYzCXLTW0a3+iS+cT7JFdLTL86Q1lvsfMhd4In1Rv0YjGH5qQsYYos/r+7Cng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHdjCen7n1k7BbozH6+kCl7flBliRpFDL0+efUJwIDk=;
 b=M3pEG/qdyszoaE0Cs/o4kZ5gQHv2EzJ102bYqUlP0a/VlPxOMcV2NUPu65bSKWZihyDzCKrYeGld8r2tzOspNxG6ZFCfuaFN0O5ngFAexBM8pI+cvjYcBcJOAephQDP2lZ2G/hOE+TGza8wOBwXoUy2b1uK4llQocXRrVa7gYMzBTb+JIrFGq3hSUqCbmAHsNFmmaHc54XjVm3UYSlby6HoxV7uMdp3L6xpUKvh4+zOe1P2H0kTJNZgxwvp5DMHRrD1N9B7GIM1PVCISNT+iPboTRRRt3+O5xJx/k3FYd3cRuJkWgtzYhX0Bst8YMeqc1luHlwdmna97ORP9dmM65A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 1 Aug
 2024 21:11:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 21:11:29 +0000
Date: Thu, 1 Aug 2024 17:11:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: can: fsl,flexcan: add common
 'can-transceiver' for fsl,flexcan
Message-ID: <Zqv5+St34E7hR2Ou@lizhi-Precision-Tower-5810>
References: <20240629021754.3583641-1-Frank.Li@nxp.com>
 <20240704-outstanding-outrageous-herring-003368-mkl@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704-outstanding-outrageous-herring-003368-mkl@pengutronix.de>
X-ClientProxiedBy: SJ0PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e16ebe-92c6-4aa8-84bd-08dcb26e831c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?NjfIS1iBu4prbZ9v1bSRJt17fbizpcrdx7C20/SxUs2qyMuH2G9BV1PkMk?=
 =?iso-8859-1?Q?eSqXCxAd8TTuLmdMI/ZRfx8/oEsuldSTE3wdTPx6sSC6IRiruTYPOaTL4f?=
 =?iso-8859-1?Q?qUha1Vj+FVTTN9tvxEmkX5nS+n3QiY0hXHgwsI6PSQ9+Aa2s7P6JGqolVn?=
 =?iso-8859-1?Q?ycSWRhZxncBARi+5iqKRHuKAevKZJK12QnN+G0HDpKEF+YsTOR+j4vW94D?=
 =?iso-8859-1?Q?Q+Dfy+mrNzwmoW8cypitEINxesQG0VJ2+wcrlNjvTEKVnLeBhE2jv6y5SC?=
 =?iso-8859-1?Q?IG9NYDz+nkT0c+AxGGaoR1xe8vn+dytQYbi3YLt7yHiIRYpo0p0ImXGpSP?=
 =?iso-8859-1?Q?ZIYnnisYOHAMqyKRWdeemJA/qLoEeQnuofwfDVhcoV/D2cM/DqC3hzDPij?=
 =?iso-8859-1?Q?y9b9IE/G/x4ZPEXamA+ysx1h8riHwR0IpbUloNHf03obEiwh9RqnINbLNz?=
 =?iso-8859-1?Q?mMJRftPe1GPHlog7Frk+fKl/SQSP19XdFRBC2gmmkpJAV2wojNFTIPp9sK?=
 =?iso-8859-1?Q?nblppJe0KFbU22XEKrSEpFau1hquoFInA+ryC3BLNFo+d/xxMvScGg1U70?=
 =?iso-8859-1?Q?iJ4koUTyfpxzF0A+FqTsBpvxQjqSZkDO7N4S1ENUnVOnRQPcMHy3vV4aAH?=
 =?iso-8859-1?Q?5g3x1bBBvNq1bTjVn43BaDDqaj6pVUA1xNjCnsqG9AzTMxel7KhrtJrAi4?=
 =?iso-8859-1?Q?Y+WBOsYdlT+teSQlaNNd9ykMr0p12vFuBU8mojqAEITKQeuTy9zBXQbGCd?=
 =?iso-8859-1?Q?cY9Nb8ggkwP8lKUKVYUjy7W5BXTUnf2XIjJPFewEkEkEfx//W3Sz6JoeAF?=
 =?iso-8859-1?Q?Cf+An/rkZGvjX/ZBpnIpauSBLIK621EpWsxBBELXqGyU9dkW/q0QdaNI0/?=
 =?iso-8859-1?Q?ETTc+Gj5trYagNOxiqiP8kggfo9ShMs1E4eB+p0Uriy5GJ+T2tGk+nOG+4?=
 =?iso-8859-1?Q?FGZ/+WWwiGFCJqGknhprRmd0g3erlATP/R3uXNGddTEC+l56o/xMjuPRDJ?=
 =?iso-8859-1?Q?Mi2ct9kpIfMuiWtmKof7N4JkW9Hg8N/MBiHTe4ahVCA3Vtx+dMxXbQSPiD?=
 =?iso-8859-1?Q?77oeuprUMzc0ox1jZV1M5p8UTxdQOMu/XAFLXXuNS+Ge31REMl9q1TVBkk?=
 =?iso-8859-1?Q?+ixywn/m6c4POYWL6U8ieDD7z7kPEMo0q838dHFeB4/NzlT1eRCP84n0f7?=
 =?iso-8859-1?Q?88Usb4ObUApb3+BgP7szPiPBejryI1oYcpSd5y5JKxqwufkB393+EGDqk/?=
 =?iso-8859-1?Q?nheSfFobxdV+H+b4zvwmOejxYSESMaUAaQNTXMMHHDU4+FPH8qc6Ao0oiq?=
 =?iso-8859-1?Q?eq07Z4xEOyaK0dK6eSkPgeAL4Yb+KJ1R3r6e/rWyBLWnDzjkXXlBzJ39wE?=
 =?iso-8859-1?Q?wWJPxiXuuWsnU9CeRJJyIF0SdGfZGx7C83+yfxuFHcEK+DUFQyP/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?QqtIzafQiQHn7x/nzIv5edCltRoQ7z4kvfi28tPCIkNnM4cDUDPDlt2nTw?=
 =?iso-8859-1?Q?JyMUvrfV08WKBED7BA+8X4V4T9nJfbv10bCbNdXzI2VxpNvOxzav9qGpnN?=
 =?iso-8859-1?Q?RbmuFcUi/IlY6t3/h7LhuXTbqCFaG3/24fJnNQbfIjILMO/cbkvIcA2+lh?=
 =?iso-8859-1?Q?N5ETFB3QA/exSN09XmyHDw11Eb3FxfL4oeIUsZujsgYTiJfiJEbnNDUbf2?=
 =?iso-8859-1?Q?YMzO756QuyPGAsniVd6Npmx2VFLopLGuWIhxAkZdBmfqCTmfGlBlTGwNtn?=
 =?iso-8859-1?Q?lK4ldkq9UcYnxs7pnjhBT+e/8FjRbTeoqQlome4eATXIjKQnzb1IuHYPC9?=
 =?iso-8859-1?Q?WWl7u8bwH0S3AmlA8NEoQNH66ARgmb3jGx+FXSvEsNGlLaQkYgy0FnFMnj?=
 =?iso-8859-1?Q?9t1KtOBENskn9rK2fQvcGhHCzX8+4I8Zq/muXuJ1x49VmrO8TV6U0WI+Li?=
 =?iso-8859-1?Q?ft7cvvEp7hOAdQ4KIUeiC/iYhLd/aF796k6U6olAgGV/ehe3+N++HRTWbs?=
 =?iso-8859-1?Q?QjVrbyVvZRR4/x8USYywciQapSj0e3EJ8qozzx6O6MHoKgd8G7HZfGYWZf?=
 =?iso-8859-1?Q?UMLv5ODSBKbCAJShgfAo7A/hKxTBFrgk6GZsPYtF16XyO6nddCWhVzD9kH?=
 =?iso-8859-1?Q?sjuwNUyiW7D61xfr1j7dGnjw+KSjMtd5j83tmmuZckFrU29rDY32yt7mO9?=
 =?iso-8859-1?Q?dHFpx15cXshaql4/R4EXE/fZ4ZM6mS4PYlPJ8yBP8696FBBgDvmZjcbmLV?=
 =?iso-8859-1?Q?BNaQ/JqAdC+0LDitAiMK+GWw6yb0sUbtO+TnbM8d4FajP7YHjIy+GK4U1O?=
 =?iso-8859-1?Q?wpYzdB5fhQpGnWkIHbeTKgVLju63wY10CSmtD8z0uurd2TyZGp5KBnvohP?=
 =?iso-8859-1?Q?+VW2LDzNjT7UrWobjXJ/D3tHVuk05HkEDmkJ862c2fVR9aZmZ7dBk8hAWL?=
 =?iso-8859-1?Q?ipRrYjZTESPd8ch95JIHW6KxJDitXAgOFJz2Wml1fGOaTBwXP2QhmicToz?=
 =?iso-8859-1?Q?rCk29x4J+l7B7a0bQz51XVGjxzOfqAZEdxTac/L39i/qQSlup5SpS7dGFs?=
 =?iso-8859-1?Q?1ZFEwtXXipjrATarQvhCyFIu9xAXzN7pWRqe9cI6tEmqa9BWJgrojIIKGR?=
 =?iso-8859-1?Q?Sdxz63UN9/FrbEofzgiiD2JGfDCvoA8e766u5oKynWeSiQ1PQvOmzR90zM?=
 =?iso-8859-1?Q?qAChRx8gJpKGfMY6ilBoV+1CdMrdbT6ysJO7ODJ75TT9EN8w5HW+OVVcmp?=
 =?iso-8859-1?Q?lLsEtRQYNv1oIrlsWAuAsmKC7LNuu4YO6Pw1dvwYmR/HY/hZq5RW/XeTNw?=
 =?iso-8859-1?Q?mz7IInmakWXIXYYdv4qJ/AARau8FtxRj+M0ttS27wIC4quPmzt4O38b/GB?=
 =?iso-8859-1?Q?W3C9pCfq/nLi8yP9CL/eVsHctzFBo/fqKjYH4ZZ8zJPLy+sEBk48c0ZN46?=
 =?iso-8859-1?Q?MapF4nWkfd/1Ag89+pYTgbUwrLKJaoAqmv191Z0fd2E8HMRZHLtyPLoTsd?=
 =?iso-8859-1?Q?mfZAXok13CbCWP2hJIfVJdF/PCUVuGfCwfTRUREMmI6tj6JlIRIScOl/Fx?=
 =?iso-8859-1?Q?Qrdr6lET0CwwY8vmRitcs8axzTcViHHyW8wInmUsvg+9ZHoEJsg06umDmz?=
 =?iso-8859-1?Q?xAA+TLBI5Dz4g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e16ebe-92c6-4aa8-84bd-08dcb26e831c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 21:11:29.6744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mt4w0bZRz4vybSAZ9UnskWeSb9D5cpccRthwoHOIy2sTQYZX/urUuElelGRdXV+pz+aqW8hgE0lrP+05I4e3zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635

On Thu, Jul 04, 2024 at 12:07:02PM +0200, Marc Kleine-Budde wrote:
> On 28.06.2024 22:17:54, Frank Li wrote:
> > Add common 'can-transceiver' children node for fsl,flexcan.
> >
> > Fix below warning:
> > arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: can@2180000: 'can-transceiver' does not match any of the regexes: 'pinctrl-[0-9]+'
> >         from schema $id: http://devicetree.org/schemas/net/can/fsl,flexcan.yaml#
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> Applied to linux-can-next.

I have not seen it at v6.11-rc1. Anything wrong?

Frank

>
> Thanks,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



