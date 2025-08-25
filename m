Return-Path: <linux-can+bounces-4363-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CA3B34656
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 17:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5826B3A5370
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 15:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD562FC008;
	Mon, 25 Aug 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cq/dojPt"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6972F2914;
	Mon, 25 Aug 2025 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137182; cv=fail; b=RNw1NS3EjIIF71iBC+85E4i0qH4FmspmnAhHReskElcCjUt/StXRFZjIiAtFuwQT1luCaaaqmjCh60dmgh0a3u3XKqrN8vGw2PPKx+NsFlC089mZ3GsYRyB+sM5x443eJSxMoIZMm8dN1UTXHJC6AbVDzju+poi/d3SxZUfoQJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137182; c=relaxed/simple;
	bh=jSmXK386oMhuFeFLRW+uUdqypw9F0w36cmIbMazL/VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Llc2WoueLAooR62zp7UNbYoyh74BYYdj4A5lj1FKEZv2H4B7S7x0Bw8E7cVMer9Xel9KkONyb8HgP/1k5fW58slStFMrqPemE1T0Zwub+d3H0B/8HDaZAU+go8wEuTufvHkhy6iKhWwU259QRPz7AL5VD84p0XqJG+caRr02Bf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cq/dojPt; arc=fail smtp.client-ip=52.101.84.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAW2iCyjwFYop6IKnA71uYlTyYNOI9zUQl8yEzzJK6kyLjPGE5Ut8qZfgQRqzcSaS0p67yQMleBwh1wymvoJvJfSMGZjwmCJLmgcgLHdRxvtpoYzd5n+VYiOorEb5OX6VBchavB8qAauQUrHPUz8iM/OQRWo3RBG7hc+3KiEXyRgI3ScYk46yZjX/fEz97DJacNFvnh/s7RU4M739VmXGnCoFmspYhR5UjkzCS324jAh7uG9yt1mwnf9hzectRwbHswkb8Rd2ztUauCNVHNMfjA77G2m+DwUADuF8+NZ27AS2dzDVTj/KIGBNnWFdqBtaio8cgQBd0V/CrdVQHF35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3DrOc2Ad6FUPHEneZ/jpVbmxs8aYEMV8KAxru+BCk0=;
 b=gjeqPsKAbJaP5yCgOG6Yz+Zk2lGNJrJuEcVGJWNhfOlLJ+qSBc0MP/wMb9wblJdabrVkYUq3QFOLaZLIhH1BG2hrH4jJLHjoLe6WH1/D12hOvvHAfg9Zibb49ut3p0YUP5bEWGLpSTorndYyl82G0xa2kTgeW6qrHlzmf629uxGlOAOEIm242Io2I1htN4sqMXNhRdp1mvEKpqOOu5WIRL73gOrVmRVa/AH5oGW9q1+7g+FUbTUmjW/rxDQgL37u9PoZJXvDA4BqQLy/bw5InNX8h67SXrzxAHjmRdprGpV+QoAuv3/KuJGRUDrSj8QdNMFlDNm4i7D1ku8KVAKAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3DrOc2Ad6FUPHEneZ/jpVbmxs8aYEMV8KAxru+BCk0=;
 b=cq/dojPtnN/DsiU4xvJLX8GkkDu87YZsxeK1u3Cpoq2Arg0RRUFbM4czDP11CxxRWfOWk3mHfPLMVZ6813WbskDyyPNwek0gc/TsX5J4wk1AGsIjXNm6QCVHszlRYLsUDC74Z6gapzuSaYD3/4vohhNQzDf526BocktquI19JSzFt0MexNuoija9o0dRuKbRIrF7nwH3HIISlKVgbwhof4ek12duC6LDmqNAZXqFeFHl5IuYVS3OEyaOKLoCv9M1td8ob7iLD2ZES0kHfAjE/e2Ul5aVnTaaJUy2h4Q5KcUhC4aVgYqv8B8AH8G4eM+XmOVtBrhZOVA4SJ5WqdoaBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM0PR04MB7171.eurprd04.prod.outlook.com (2603:10a6:208:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Mon, 25 Aug
 2025 15:52:56 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 15:52:56 +0000
Date: Mon, 25 Aug 2025 11:52:47 -0400
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
Subject: Re: [PATCH v2 2/5] phy: phy-can-transceiver: Add dual channel
 support for TJA1048
Message-ID: <aKyGzza24CqIwuwn@lizhi-Precision-Tower-5810>
References: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
 <20250825-can-v2-2-c461e9fcbc14@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-can-v2-2-c461e9fcbc14@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM0PR04MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 37eebd0e-ef41-42df-ab1f-08dde3ef7587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JjEc8APjCMT/0mkpZtR1Skdeng/Wui4C8YngfOT4FKmY1jepFbnqoFFg+Y1J?=
 =?us-ascii?Q?+xRkdpJZWWJA7XvqbsnSBPWsel7WeRgCVzY5d0SC95hsYC24rmzPfUXMhRtF?=
 =?us-ascii?Q?Ix28FkG+0mL9hDKROFD5jv9cCOQTYQfVicw5zA9fd0nWAWfsQZrq7JhTUqDv?=
 =?us-ascii?Q?WTlp+QCPqljvddopur4D27egKMr57+ODunijQvJnF7S9s6LYUSadmW+7uvOz?=
 =?us-ascii?Q?HIjDCZSXUlZKsvw3n0gJheGhSN+RSMS5CtNnqEWUnhOP8XusCeFz2fLy6xSk?=
 =?us-ascii?Q?d9AgioxGN3mfYWWMUkbzY9czQV3k0IoldqM988k0EswWqwsp7aGQRU/mWlr1?=
 =?us-ascii?Q?hgSTmyj21vJbmwsQgq26ItET40wO8pbVr1/ddV8I+Aw0JT9oyjx76Gs6pTIv?=
 =?us-ascii?Q?LI9ht0o8TCx2jXqonUzwwFnhVGfN96vj1znEk+6nBfKzMuieydw37QfybqWA?=
 =?us-ascii?Q?lTh2K3WD5QobKStfcbkHqEEAbyS4IefZRRrqruMkPDn0iyO9pCwGwly9xViS?=
 =?us-ascii?Q?g1WJQHtFEYi6ydh4adjUq4BEPctjmGAib/juNz+lm+dYbUxFrXHaXuSUFQo7?=
 =?us-ascii?Q?xOcOyoiTzXVymN390jvdl7pOA/MerI8S/rixPaROMF3ilLY+/3g5LyJqI+J/?=
 =?us-ascii?Q?mAGBMFyl5mB3XJzN4hEJhQE026q2skVjrfeRwSfd4j0hgX4M4v+wJohiBZyy?=
 =?us-ascii?Q?DxwW9rR0Xr7SD93Pxih+CCCmQahfQ/OA/vZbVc5N2lCjJCj6fLToNPtjHW9U?=
 =?us-ascii?Q?KvjRzikTEaGYQTRo8JH4++BOY+6jZYl29RZ38tPrsfIlOwwnCKLlr6I3fzT1?=
 =?us-ascii?Q?hSMFxMqROgm7hmwdjLWXHpkI/UDa2shpIqXv6t+TCagiCQLExlzeydIJJrha?=
 =?us-ascii?Q?ZmuQt74tKt7v5g2qwJj2JmUjR90lJXsdxJOGSlUqwK+akzYsVrYeQqMHgfz2?=
 =?us-ascii?Q?AR6qY4eWCG4zQQIThaeOwsDxbVXfxdi/GgnpY/s6Y5WvPT6JZEnSug4kMy27?=
 =?us-ascii?Q?DSmMA3DuRkQFH3Lu+FFxp0F2imq3YB7inzJoTfIwU96RnlV4dDjkHGfeO/sZ?=
 =?us-ascii?Q?8DZ7J5Tp+D3PTiyXDX7+D6+tw0rK02heXeBtMbPQg36zr1eaX2IUkWC0xIQA?=
 =?us-ascii?Q?hzXDRzkh8c7a3QpK7pCE0xSPD5tBcKqVVfnCGgopC6aqOUMfXWxaRaBGaiqI?=
 =?us-ascii?Q?p5vNPPWxlwBFW46pG1qj/kfnigkb4Z11UeqIKVW3OGCkXKXBD/buSoe93dEL?=
 =?us-ascii?Q?jfiszqjziOT9R1JIxmTUTDzklCvVLLc18ERX9lXBChD1PQd14zGEgC3i9Vnv?=
 =?us-ascii?Q?y3C1Or7F8T/9Ikr5wAEFngylvObI9IIuyubFAs09R4RPLiLL4idx8MPB/0ka?=
 =?us-ascii?Q?HZq2QZcKA7TQRx0w1tfZNr374rxsiaN/PqJM7DGLSU8MHXkNbWagF7v3BmIT?=
 =?us-ascii?Q?373JG5OIo3/kOC4A1gDu1CFunKAL6HXHWYp9unDVDMdTSlpH10nGbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bOZceR+0O5OY8PPymFTIJBUE5Sard4mM/xwKVSipX0QJ1japBImg/7hkoZkC?=
 =?us-ascii?Q?kJEjcSOAVRu9cgJ8D7l3DNNyMb+KHwzrHHOgZsm7hKG3qZT8O5gRrLs4iy0L?=
 =?us-ascii?Q?uYdJEXZ7yPZQvw3SeYj6W1zhtd7DhK/mgyLDiDt2Lmw2Krfg0O8LO7Mb2NLy?=
 =?us-ascii?Q?Z7f1VABYlrYptO1Z8hIcJTolBrxtjUxR4GDgJXxYIKgDPtgSY/RPzrb+ys9Q?=
 =?us-ascii?Q?QBlWag4zq/bAsGK3tVsfv/808IwKbJTErL9ZF5F6Ee0uBfJuKcWrf+u2gYw/?=
 =?us-ascii?Q?MVOufXahUzIbI3ImKKEbyQ9noz+P27U9mkl3trjr/dLP1YDzpVjiTeUxOOR5?=
 =?us-ascii?Q?rHTl9TJKPWxpv9GQ0g8ul3bIaO/rQ7VzuMkWVdEGbREkSj2nHfHZjyDBwL6J?=
 =?us-ascii?Q?ZC3HESNCIrlpdUEW3Ad5tgP9B766sgdQHpf6tK9JeeK7ozLDixgE3KhutyVN?=
 =?us-ascii?Q?i2zi8yzR8gkLogYL2P9otoyZAi23eA0zGLkb5gBGmX9KWL2KvagTyWww88Xu?=
 =?us-ascii?Q?JUhboAN1YKci29SXgBuCIo+ES4+vVWQw37J46vsCz9v+9cN4ym8Q84uSuFzl?=
 =?us-ascii?Q?fsAA0bhysjQNPa44T1bs0Vtny8IrTkyykFptmdebaKNRzyJZLyTrpVA4qSg3?=
 =?us-ascii?Q?u5yaz8y7V4zi9VGZUennOHw8qvuN4bbXd7kNSzLGmualHVQmNgKi/IztWEqu?=
 =?us-ascii?Q?nAN+2tKWAXpUWxcE2l8WbhCx4JD6XF7EhWilJZnAW01wbMr+ILIX5OSUPjQr?=
 =?us-ascii?Q?wjeDfCsNVdDGBvJxtHvdrZJ7kRcLBdJ+oDcAi1/1jMxPNRD5WT+PSfyzCvHh?=
 =?us-ascii?Q?CtZ3lPzyO+4kJwQ/i8Bw9Y55Arw588BkH0L5eFl6QfNesN1fhvGY3KghM9kL?=
 =?us-ascii?Q?Vex7eGPsWPo1ycfhMabGW9YY4G+HCwLBG+R6zyTurPyfgBJT+iFmnwhjJXpU?=
 =?us-ascii?Q?obxJH2fHOJASqqV8+9bNNaKXaHrG4/1UOYliLljtRYPHqPcdAPJ3AkjFhHCq?=
 =?us-ascii?Q?jHhJfbepX0aBslS3Y2a7kD+mUmJp5hLQgX0lzDzI1K9Ag8URio3N+ZevIqXI?=
 =?us-ascii?Q?2QTl0OZJNX8laimPUy53At8wjwdAL0160ypXySb/Sra92HBOCvKJkhgmobbU?=
 =?us-ascii?Q?5+A5AYAPs6EnDIYoT0NxXi6cGXWtIvkgTn08IlAGgkmjzvWc1u4nzOzQBkpT?=
 =?us-ascii?Q?9coS+Yzot8OLmQvgnHQvXXpFjz3fa+X/f8v3lbJP2EbSPb5j1iyh+09VkyRq?=
 =?us-ascii?Q?CTwtJSmlTBB4axrl7/E7rJEUSCNzArnwvDfqHTw13NwuyraDcg7cSSDChV5d?=
 =?us-ascii?Q?fU8JeooxF1FvoHnQoj15O32rJkJuEweXdC5RmBAZNo+fyQk++DDArCf88bZY?=
 =?us-ascii?Q?zcq3P6jsyNqJVI7C2MJPksXiZQ/rgHDUrhoeyzw/hZngdTcQVGJnK6XBLT9I?=
 =?us-ascii?Q?oCU3f/Eyza6GBB10QcSYUL+gD8hPpQ+70L62QNuBiCqlKyWGARr6GYwF33SR?=
 =?us-ascii?Q?TVGY/KCRMa02x7C+widNMv/6okFLtFbBYs+NdQ+/vVflnyGqRWTpNK1bHXh1?=
 =?us-ascii?Q?kNf75E0vTGtYRykEzUk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37eebd0e-ef41-42df-ab1f-08dde3ef7587
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:52:56.6627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NA20u0hbkM5BiDBiTP9Z0kObjh0OjjYFxknWrorL6359dpW2y6ucyPACD9GiOgLZmWs/l4Pb3ssSlSGDbF3aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7171

On Mon, Aug 25, 2025 at 04:36:43PM +0800, Peng Fan wrote:
> - Introduce new flag CAN_TRANSCEIVER_DUAL_CH to indicate the phy
>   has two channels.
> - Introduce can_transceiver_priv as a higher level encapsulation for
>   phy, mux_state, num_ch.
> - Alloc a phy for each channel
> - Support TJA1048 which is a dual high-speed CAN transceiver with
>   Sleep mode supported.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/phy/phy-can-transceiver.c | 117 +++++++++++++++++++++++++++-----------
>  1 file changed, 83 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> index f59caff4b3d4c267feca4220bf1547b6fad08f95..8f0baf0d29536d2b18c5839d6275f020f9af7e45 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -17,13 +17,20 @@ struct can_transceiver_data {
>  	u32 flags;
>  #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
>  #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
> +#define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
>  };
>
>  struct can_transceiver_phy {
>  	struct phy *generic_phy;
>  	struct gpio_desc *standby_gpio;
>  	struct gpio_desc *enable_gpio;
> +	struct can_transceiver_priv *priv;
> +};

I suggest create new patch, just add priv (without num_ch), which simple
straight forward. Then add num_ch, which will be easy to review.

Frank

> +
> +struct can_transceiver_priv {
> +	struct can_transceiver_phy *can_transceiver_phy;
>  	struct mux_state *mux_state;
> +	int num_ch;
>  };
>
>  /* Power on function */
> @@ -32,8 +39,8 @@ static int can_transceiver_phy_power_on(struct phy *phy)
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
> @@ -56,8 +63,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
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
> @@ -76,6 +83,10 @@ static const struct can_transceiver_data tcan1043_drvdata = {
>  	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
>  };
>
> +static const struct can_transceiver_data tja1048_drvdata = {
> +	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_DUAL_CH,
> +};
> +
>  static const struct of_device_id can_transceiver_phy_ids[] = {
>  	{
>  		.compatible = "ti,tcan1042",
> @@ -85,6 +96,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
>  		.compatible = "ti,tcan1043",
>  		.data = &tcan1043_drvdata
>  	},
> +	{
> +		.compatible = "nxp,tja1048",
> +		.data = &tja1048_drvdata
> +	},
>  	{
>  		.compatible = "nxp,tjr1443",
>  		.data = &tcan1043_drvdata
> @@ -103,11 +118,27 @@ devm_mux_state_get_optional(struct device *dev, const char *mux_name)
>  	return devm_mux_state_get(dev, mux_name);
>  }
>
> +static struct phy *can_transceiver_phy_xlate(struct device *dev, const struct of_phandle_args *args)
> +{
> +	struct can_transceiver_priv *priv = dev_get_drvdata(dev);
> +	u32 idx;
> +
> +	if (priv->num_ch == 1)
> +		return priv->can_transceiver_phy[0].generic_phy;
> +
> +	if (args->args_count != 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	idx = args->args[0];
> +
> +	return priv->can_transceiver_phy[idx].generic_phy;
> +}
> +
>  static int can_transceiver_phy_probe(struct platform_device *pdev)
>  {
>  	struct phy_provider *phy_provider;
>  	struct device *dev = &pdev->dev;
> -	struct can_transceiver_phy *can_transceiver_phy;
> +	struct can_transceiver_priv *priv;
>  	const struct can_transceiver_data *drvdata;
>  	const struct of_device_id *match;
>  	struct phy *phy;
> @@ -115,52 +146,70 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>  	struct gpio_desc *enable_gpio;
>  	struct mux_state *mux_state;
>  	u32 max_bitrate = 0;
> -	int err;
> -
> -	can_transceiver_phy = devm_kzalloc(dev, sizeof(struct can_transceiver_phy), GFP_KERNEL);
> -	if (!can_transceiver_phy)
> -		return -ENOMEM;
> +	int num_ch = 1;
> +	int err, i;
>
>  	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
>  	drvdata = match->data;
>
> +	priv = devm_kzalloc(dev, sizeof(struct can_transceiver_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
> +		num_ch = 2;
> +
> +	priv->num_ch = num_ch;
> +	priv->can_transceiver_phy = devm_kcalloc(dev, num_ch, sizeof(struct can_transceiver_phy),
> +						 GFP_KERNEL);
> +	if (!priv->can_transceiver_phy)
> +		return -ENOMEM;
> +
>  	mux_state = devm_mux_state_get_optional(dev, NULL);
>  	if (IS_ERR(mux_state))
>  		return PTR_ERR(mux_state);
>
> -	can_transceiver_phy->mux_state = mux_state;
> -
> -	phy = devm_phy_create(dev, dev->of_node,
> -			      &can_transceiver_phy_ops);
> -	if (IS_ERR(phy)) {
> -		dev_err(dev, "failed to create can transceiver phy\n");
> -		return PTR_ERR(phy);
> -	}
> +	priv->mux_state = mux_state;
>
>  	err = device_property_read_u32(dev, "max-bitrate", &max_bitrate);
>  	if ((err != -EINVAL) && !max_bitrate)
>  		dev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit\n");
> -	phy->attrs.max_link_rate = max_bitrate;
>
> -	can_transceiver_phy->generic_phy = phy;
> +	for (i = 0; i < num_ch; i++) {
> +		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
> +		if (IS_ERR(phy)) {
> +			dev_err(dev, "failed to create can transceiver phy\n");
> +			return PTR_ERR(phy);
> +		}
>
> -	if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
> -		standby_gpio = devm_gpiod_get_optional(dev, "standby", GPIOD_OUT_HIGH);
> -		if (IS_ERR(standby_gpio))
> -			return PTR_ERR(standby_gpio);
> -		can_transceiver_phy->standby_gpio = standby_gpio;
> -	}
> +		phy->attrs.max_link_rate = max_bitrate;
>
> -	if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
> -		enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
> -		if (IS_ERR(enable_gpio))
> -			return PTR_ERR(enable_gpio);
> -		can_transceiver_phy->enable_gpio = enable_gpio;
> -	}
> +		priv->can_transceiver_phy[i].generic_phy = phy;
> +		priv->can_transceiver_phy[i].priv = priv;
> +
> +		if (drvdata->flags & CAN_TRANSCEIVER_STB_PRESENT) {
> +			standby_gpio = devm_gpiod_get_index_optional(dev, "standby", i,
> +								     GPIOD_OUT_HIGH);
> +			if (IS_ERR(standby_gpio))
> +				return PTR_ERR(standby_gpio);
> +			priv->can_transceiver_phy[i].standby_gpio = standby_gpio;
> +		}
> +
> +		if (drvdata->flags & CAN_TRANSCEIVER_EN_PRESENT) {
> +			enable_gpio = devm_gpiod_get_index_optional(dev, "enable", i,
> +								    GPIOD_OUT_LOW);
> +			if (IS_ERR(enable_gpio))
> +				return PTR_ERR(enable_gpio);
> +			priv->can_transceiver_phy[i].enable_gpio = enable_gpio;
> +		}
>
> -	phy_set_drvdata(can_transceiver_phy->generic_phy, can_transceiver_phy);
> +		phy_set_drvdata(priv->can_transceiver_phy[i].generic_phy,
> +				&priv->can_transceiver_phy[i]);
> +	}
>
> -	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	phy_provider = devm_of_phy_provider_register(dev, can_transceiver_phy_xlate);
>
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  }
>
> --
> 2.37.1
>

