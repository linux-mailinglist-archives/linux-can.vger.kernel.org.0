Return-Path: <linux-can+bounces-4362-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FE0B3460C
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 17:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4165C7A945D
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 15:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924122FE041;
	Mon, 25 Aug 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JleO6wBr"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011045.outbound.protection.outlook.com [52.101.65.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C39F2FD7AD;
	Mon, 25 Aug 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136398; cv=fail; b=dPYSJrmIevgtOOHAJZ3It/sfUbNWwBHk3o3OckhtssEpWK2h38zbyZdrUMehogEWhfNcxKGWm/noNnA6nJvyLIGGfcV8jxASjofsMul3ndz9SbVAPJz7oKs9mSTUez7QsXoGSrqHQMzpARxhEUTa9iV174cX+9QgxzIoT/WJkfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136398; c=relaxed/simple;
	bh=8+sJD7+FMzGtw28X6rZn0ojhLhuL5GlMDUxMhr1JwLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ssMXcwnFkPjbLXYEwyss2hfnKLIVcVgl/U8wPXPfIu3PIDM26mTdV49RoKigC6uIi8JJuN+hcWJ8+3t1hGMFeYDNAKw7aPxmYI22XMl7WRbyitLw0/V6/+YtSGIP0o/B2cg9buers1ItzD5RuBcMUuX8pzniBOWokRkwErlAWB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JleO6wBr; arc=fail smtp.client-ip=52.101.65.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3R0od7x7LGRiTYG17x5KPAc7b9i72IxchOJRRJGThrfP07wbN8/eQfXFM9KPuZ0vkLMbfzrbMxhjvKXX4u93H/A9UTknKzcnoopNyFux2Y+yVoGK+jc++CF/C2Q+5fY7YEtUl1P6MsWaqROahpxmRy4WuFAhm4OZ777vND4ZG6YrMxhNqu3eIR5fa+JfoKsWLqLAxKzzgbT4SRL9wVc0nm4ZQ/eetOsmS4Wq3XSfitLnM7jR6scRkESIzfmheIEQslqrYESlrXPF8J+W7kELl1IQQca3cDUtt1gl8vCGMadutnFzardZ87OgnVqRQl8So/E0CzRZ7nmghxO0mnISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDUGguZpxePTywgjsy8m7l3lzaHtz+hNpeGwcPRSqzc=;
 b=hsm+5lD8n4xAtlJbFQIi8bs3M+TuUZWT3H7oyKplaO9AZzCnfuYCKvXcHNaXrUk2PXGGFIiB7Q0zi3SeNqjQL7Ypg++f3/E9lwZt4zwlE+rcX/Vry1ESKTNBBE4T3LhahhHvEXs1fB/kullswCXEAXY6T63BGHoouD2vYYSmxZef06KnMUs9SZIsD6BRRxGOoVJ2Gtpi0d52HRN8mAwJtO7kLxeWiEtodOnH6RARNWZBpNYFgITedoD+BsfSUJNJpkamjiR+md29y71MZOS1CampQQzFbsRU2XapeGpdvICW+JjWCyrC9GeTSBU6DGpSZ8G4Bc2ffapFdngvk5se1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDUGguZpxePTywgjsy8m7l3lzaHtz+hNpeGwcPRSqzc=;
 b=JleO6wBrSHDULoxPeslIWSxbipyTCm7RP/WhieScitbL03Mfh6Dj6vaIriTkUzOCmDJGpWPRvI79q7ZCLKbbtIaHPn4zMGsHN8uCrIMkmpMVweYwZ6HvensGu2WjOCFQtzkdhf3YQVzY/aCzxxWbDo1nMUcBvebyS5lmBiFSEq2pYkJ1CSI6yOGhbzswHNfSv6QyFPIKT5be37tFpuzYJaXyUgjlckUQIUwS5ARtZv7opVktKWeHWdFmhV0vdpf812+qdMp1r7Q7lzIn3ceu4W6fjskD0YAkiUuL/FADfeepgtCXbDniiX49z3bDriQQoLtl0PfQf0Yek/j3ysqICA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Mon, 25 Aug
 2025 15:39:53 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 15:39:53 +0000
Date: Mon, 25 Aug 2025 11:39:42 -0400
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
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA1051/1048
Message-ID: <aKyDvtH0U9Idxq19@lizhi-Precision-Tower-5810>
References: <20250825-can-v2-0-c461e9fcbc14@nxp.com>
 <20250825-can-v2-1-c461e9fcbc14@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-can-v2-1-c461e9fcbc14@nxp.com>
X-ClientProxiedBy: BYAPR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::38) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd90089-ab6f-4b12-53e9-08dde3eda267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pQLIEC/Seyku7BdFAT79LZH6Xlf6SiYz0JDrApFmD86e5s64HwIa5SpYUYzN?=
 =?us-ascii?Q?7KkfjlqO8yYYb9r+aqA2BTJhjkB/EPwYAqWg60hFrq0FpXO3cjq3qYNJ9ysH?=
 =?us-ascii?Q?k0k7WQoic/zVuZEz3EPiU9gmAGhCDRRam2+CtYIOkIo32w10PrqtUjNGaKms?=
 =?us-ascii?Q?kc48ka3spptP8PGLyDMF4n3y2WtutNa+Fw6HQHB1n9AFIU87Huk7GxaLC428?=
 =?us-ascii?Q?y81NTfTjP0J+PaZQr2B1P7nOuMNHIa9VhjN9n/JzoTG9O4Xq07AaWaEvifsQ?=
 =?us-ascii?Q?yovoH1fhOm/UXKV0l2rkXTfivG7T2kC+x9XvQ3gN9KyBWYIPx0mp57vNO6s8?=
 =?us-ascii?Q?CC7g7EkThF4iFy8E94OSOM9byfYLh4hTiWdG0mEa8jA4lfCMs7IjjR0ob1ID?=
 =?us-ascii?Q?L79i76yvk6NIGJJJwe/mj7qgh2fHAE6D5zFQlTAlSTngMYI77x1RJIHgLRn6?=
 =?us-ascii?Q?p7KvdVUn346v8V2oeNBuj8v0BvyC7FsQb2+3avcsqEuu5wz45NKwjh31/QXP?=
 =?us-ascii?Q?0e1B8ER2Mh7gFz1y9KAOrGRR0UxacD0ljD1dIsszXludCqi3ac3Y6wN+aOFv?=
 =?us-ascii?Q?h7Jxdz8izrmVxv6EPmHc/xr4hwCep1gjwN51EiUy84bv8QMfOvRY3K4ZRH7g?=
 =?us-ascii?Q?C4yMT2ei5LgaMGY9B4W6nb5Py0nTEM3/or5LzJnMo1VN4hflqC74RrIN5N82?=
 =?us-ascii?Q?d7G4YTUupe8bOVrZTOB1rp1OLEFtzz2CcO1h9qY7zueO+zCystS7da8igayU?=
 =?us-ascii?Q?Opm1VTXi6Wc2mmcraIiq4rpJ3rodYR6zY2s8j4qXybwN/6W9QwDhXLN4CxBw?=
 =?us-ascii?Q?eQ8lDcm3gkkG/BL9Z/c5Tsz/LX/epQDHUbIQCoaO4ROGMVcKDbnzOCb/z086?=
 =?us-ascii?Q?mDHrud3415UTL/wB4vNYHpt6xeA93P9dk14YSw95hKQAI76M4J6qEc1rHJ4J?=
 =?us-ascii?Q?rVfuiLFnbj5W0a7RxkKj9etvQI1qgHV8zL8q+jWFy96UEt6lG8TbGwY+mWyX?=
 =?us-ascii?Q?UTHx8sgS2ZdrRjlAxUbwyS/JxxkpVExaC9bxRBuratxtTubeQLrPlW7VDncH?=
 =?us-ascii?Q?SBbUUTyGq+spPqEqDz/xq0QGQDtKiwV8yntmsPCA7o3baKIZdyM08rVy2dAG?=
 =?us-ascii?Q?Ye38n8Gko+t40fVUcra3+f2z8kuivQvaLnb1sQUFEW5yUGdD/IQUrrckyyw8?=
 =?us-ascii?Q?y4RjipTEBE79Fp/OfDF35DwMoJEJuJI5E6nugvNoXPIrYUF4orQaoiW84Xb/?=
 =?us-ascii?Q?S9VIn/AmyZzupapUY7Q6GoDSyuOQCr1dzmE0EbOs+uV8JH/o6UpKn6lwMcVc?=
 =?us-ascii?Q?9U0L8+jl8mTV+f9EMQcimYHshD1VQXKKorkgc6bo98RR03K1sIb3NPD3uPpt?=
 =?us-ascii?Q?5AMcZPhVc13rRUU6GRarq8WuT5KWRmUqxwHPNhDYFOGUtPlPra058vGbeMQz?=
 =?us-ascii?Q?VrdwdJwZeLslcoqKUI8U4naSGwGgu8ukjK2Uq5UtUqFlh4KoJNn9dg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w2QOQxQk9JprU8rYva573Pg88nL+jqZtVQbeHbTpE0Iw9mJDKs/QJvTurNDm?=
 =?us-ascii?Q?cHoxycnzKSuvEyGPx+hfev1Axe8gK65SHGCVHojGDkY/VYA/5GfsqdLUv/ny?=
 =?us-ascii?Q?2BqnhFBWwmZvm/VoNshN0wVTyXokIo0oTyo9oqiZ9xaXVghmp5vEJKQDw2rf?=
 =?us-ascii?Q?rfKMvi/VpfA7SfwyqaQK9IQ6KZ0WI3Bd/1NZFHtiB7hC96aJpZup+XEgbrxx?=
 =?us-ascii?Q?ux4vXp4YyID+MhL9P5xXJQIbtnddYfW3h/I07TFHRzrSvT2VzQwesB8yvZO+?=
 =?us-ascii?Q?j9LX89uYrepfNfcd8qgyJdUaoT3C1kcGyb7PV2vfiVbJc6wA1k+cgRFsVkbq?=
 =?us-ascii?Q?Fcm0dho5nNmThZD47wX/A8j97c1jL3pMKG3Eg8QotXbB9mwno+zJTGCY9xgI?=
 =?us-ascii?Q?SM8DDkiYgYXm2WxJ/p47qZlaJsSieXi3g8QQWTJv2aa3aUMYAdiCEeuhEvtT?=
 =?us-ascii?Q?bAwAwrWEpZdV+fVk/OXIkbdTqMjEy3eA1aGH1E5IauTTBoFswode4SG174Y/?=
 =?us-ascii?Q?KUxArV6RzZrl1ASFd/k4dz3bpUET+nsXvdTD5aWROYN/RZiQb0tkQDc+noBj?=
 =?us-ascii?Q?dWslKZeIXrnw3JhzoCJLAv3lzgPkgoRv7jph5/G6+9/ezGtQ0RBS6e5+2+fE?=
 =?us-ascii?Q?9LGP60eHb0ivP+i2FvyV3L3sbRAwCVlJ8n8pdVwtw3jBNGMHvsZcHW/4TeUf?=
 =?us-ascii?Q?rSYdACb8jiJ+C43PRlHdLLfMFR0ZumQqS1sMEN6DBm/UDjWWb354vzQR9mrb?=
 =?us-ascii?Q?hkfx4OqsSHnfhXoH+J/wm84GlU1ywyM72LwTntt3JNbukRWtmFr0QZ+0npBq?=
 =?us-ascii?Q?dfLphjH7r8x1tnJrH1CFR/+LxnLtYycvPSzF15xIJWOF57f9i5AJs8SAw7+e?=
 =?us-ascii?Q?kkOeOKZ10kSCZXAS8kk95dyjdmwrUJbmZAlyHKSiUcZ8jdkG0Nn41lcqKqfm?=
 =?us-ascii?Q?e8XMcoWtQo/usOKDu6WDPCi7HB7AEG+mUMobuv9TrgCvPSTtKLgx1CzBtIIe?=
 =?us-ascii?Q?mQg97qrxsZISVsVt460dSkZFQUZhLkL2WP9ru7GfQYTo/CeDEDf/fjQNHno0?=
 =?us-ascii?Q?BU4Gh5XrralRpIz97N5DfZFI5CeiVq483xaM43afV1NtWvOrJTZsx6ueA9Tj?=
 =?us-ascii?Q?YwwrwRVqIvlUINdxUpXcHzFY78BCgO+Yv+3HHFZQcpTEH4wIdQ/gqlubmcHC?=
 =?us-ascii?Q?w9uzckj10QVSM+9LQ9bqPI+41Csr3yidwqI8M3m7/VKMNtsVeDFcs3pF45PI?=
 =?us-ascii?Q?0eJKnIIV8WS1yTRhzyRYiUAB+pDEcHlxWZSfKRV1hMoqUxbZ/9TO01kLB8Hv?=
 =?us-ascii?Q?GgoeE48y64Kg09F0T3ePed27U5WPoCM3/hszWgR43i8aAQGqphEY1mWO5Zl5?=
 =?us-ascii?Q?9PLbpTfz4jnM7SrMxDXL3l7UVqoOhY+LHUNQf5X1S/uqoOECwENGxhBYUi5N?=
 =?us-ascii?Q?qaXfmAAe0xkUFCV+LCY+KsZn4EUquOtDUK9ZL+6Rlgd2ewt6OxNKRWeX7RHj?=
 =?us-ascii?Q?M8ow10z7iyW3VnV+IBUCgXa09u0XAYZmrh4eeFAZ18hkS2RwAVWZIDpUKTkz?=
 =?us-ascii?Q?24FYBre4k4hhw+U5LRLHvUg0ALaHiVyHPPheyR41?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd90089-ab6f-4b12-53e9-08dde3eda267
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:39:53.0053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARBKr9JjKNc7GUyVsDqzuJYfguhoqxdnVrPA2jPjF/fZPvC1+o1B7qVrhCULmnVExU1R4ffn+s6xCUGlOl9ABw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

On Mon, Aug 25, 2025 at 04:36:42PM +0800, Peng Fan wrote:
> The TJA1051 is a high-speed CAN transceiver which is a pin-compatible
> alternative for TI TCAN1043 with Sleep mode supported, and has a compatible
> programming model, therefore use ti,tcan1043 as fallback compatible.
>
> The TJA1048 is a dual high-speed CAN transceiver with Sleep mode supported.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 33 ++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 4a8c3829d85d3c4a4963750d03567c1c345beb91..3ae08815225d82b6a09cf8a6deacadbddf781fed 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -19,18 +19,23 @@ properties:
>            - enum:
>                - microchip,ata6561
>            - const: ti,tcan1042
> +      - items:
> +          - enum:
> +              - nxp,tja1051
> +          - const: ti,tcan1043
>        - enum:
>            - ti,tcan1042
>            - ti,tcan1043
> +          - nxp,tja1048
>            - nxp,tjr1443
>
> -  '#phy-cells':
> -    const: 0
> +  '#phy-cells': true

need restrict number, although you limit in allOf, still prefer provide
wide restriction here.

     'phy-cells':
        enum: [ 0, 1]

>
>    standby-gpios:
>      description:
>        gpio node to toggle standby signal on transceiver
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>
>    enable-gpios:
>      description:
> @@ -53,12 +58,34 @@ required:
>    - compatible
>    - '#phy-cells'
>
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,tja1048
> +    then:
> +      properties:
> +        '#phy-cells':
> +          const: 1
> +        standby-gpios:
> +          minItems: 2
> +          maxItems: 2
> +    else:
> +      properties:
> +        '#phy-cells':
> +          const: 0
> +        standby-gpios:
> +          minItems: 1
> +          maxItems: 1
> +
>  additionalProperties: false
>
>  examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
>
> +

uncessary change here

Frank
>      transceiver1: can-phy {
>        compatible = "ti,tcan1043";
>        #phy-cells = <0>;
>
> --
> 2.37.1
>

