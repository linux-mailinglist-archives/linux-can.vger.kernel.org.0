Return-Path: <linux-can+bounces-4480-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C68B43E6C
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 16:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C011C2749C
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BDE307AE1;
	Thu,  4 Sep 2025 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jj/E9IsD"
X-Original-To: linux-can@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD13307AE4;
	Thu,  4 Sep 2025 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995448; cv=fail; b=KFsRBvRv4UgSnqs2p+2RG9JjKabwG7IZDPe/JndM/ry3wQmp8e0I9fRAVpRkRAK9e2HnzoH1r6TMYpJmhiKF/Gi67EOXTdXBtU8bIOslf4PSLDlet5RZyJ2z1V4hfu13ETrHRDVg8bI6AAYuNqdMmwzz0SzooN+tv75MsrdNmhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995448; c=relaxed/simple;
	bh=i82UVtxkPhY09+iZ/hJjdpav7vTmvvJG39e5HYCK69o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rCJIycZNSuiuBjh7On+TpS61slPYE/6DEMqzgy3/pg+VnoO7+TCkrbBU8efmjVs5+RTlIGCD9+BHJv42EpAY/eRtybUOKnEZw4GO0S5ZNjbBIQJCLrCVNfULKXj7jci38Kf7iHizeKCJ5sI60Na+4AEIaW+LzyOMAs+P6C93PiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jj/E9IsD; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iz7CG5fMWtChr4ywsB+aHTOv1wBydiU9kjo6oM4eaJ1jCyMTEY59IKVsAlH9ulrIqelszqZceqF2TNMHrspJv1BWSGSMz7YpPGbJOVNy5fKx7i3UchNx7Ew2q+jJKjso4xk1OyGxLAJRJrwMTYlvEHLGVRnu3FqTxSif1IlPm7JQWRPqBbhT9Clp8EzumCST/9YuT3d/36+RyeMW1yeoq6dFXI8vcf10bSFQPyxEolc3W64/5weoaEPoCZYXuw02eOh9ENH886CyvFogF12pPLfrxfPNgxZjQ90l08u7rCjj+NTjWd4dI23lkA/09//mZJGbdi5FEg3hPbT8PJ/X6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gO7x5dEYNGvNugp7waxmzPmDj5iTh0FeNaD8Uk9KpSg=;
 b=pyw/bzdKhjYv/jzj6Qgr+GHy5RvYXgeMCn0nhCuxjGf0omYrvoGJ2ZFeyobYacBECeeKlsJORyPYOrEAwME+53nAlPDEXrWNpp0j6Ss0zEV/O4DhoD25rc66eDchsP9NU/A/KB8Dhykwmd2RednFHl8recSjejBMSxa9FxtfEqQr6XUdTyWG1Gt2JvlkHwkf0AzCNNi4NukM5idcfprSZ35BQokAZmMb+vXJVLwYjn+d1mzNAzwN93dMh9wO4fWOPrRvRMg3G64xCbdhnzZzUScDWyQ5ix/94JoCOgHqak1ajnjSxpKvkRkCZqgRy/D2C5+VI20+TJd3FFrECUIaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gO7x5dEYNGvNugp7waxmzPmDj5iTh0FeNaD8Uk9KpSg=;
 b=jj/E9IsDKXsElAdgECUCd8wT0R43MDqza9bnQg5xa5E0/e+xEc0yRe4tsm4WOk3sTiljPUsuvM8obn/ZH7ifgZbvNaghTxKxafY0acaewv/9l4EfU0odajthye046zcfqsQVmIJW1LxI1kUOt/e08cH8+D22TT3YE9tdsZrUrInFOnfkhHjl22I9VBv4SwHW728lNLGhDOtJGSB4dW8MgCJL8l2fImq6hqSVKERgTTM+9qBLqC6qVFjmem1USio1yDUx/d9ywE45c/bZkC9t+RT10q1rNbamxFLYW9XqiGVXeR1okt6ZG+KOdoKeXR12Y0Um0PR6vbQoWzcYYbHKYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB5PR04MB11254.eurprd04.prod.outlook.com (2603:10a6:10:5e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 14:17:22 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 14:17:22 +0000
Date: Thu, 4 Sep 2025 10:17:13 -0400
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
Subject: Re: [PATCH v5 1/9] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA105X/1048
Message-ID: <aLmfaZQcsd8zqY/i@lizhi-Precision-Tower-5810>
References: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
 <20250904-can-v5-1-23d8129b5e5d@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-can-v5-1-23d8129b5e5d@nxp.com>
X-ClientProxiedBy: BY5PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:180::18) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB5PR04MB11254:EE_
X-MS-Office365-Filtering-Correlation-Id: 003120d1-cd44-4c53-45d5-08ddebbdc3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nhzmxaPVFf24w03amFIn5lG6gqx0xBNgCgHlp/9yOmbTrT2+HARgtyakrYn5?=
 =?us-ascii?Q?EiuEfokre2vN5FI/nDrmPE5ftUmHesoLFUB3x49bDDQwzlOL9Gegn2Fovz9n?=
 =?us-ascii?Q?qGZ+/zBLq+KeTGd62jDuvH+RG1MTQI/BTQG1Z2f8oB67WlctVsA/Nja2cF69?=
 =?us-ascii?Q?priRj8AaLar7hdUkFtp8XWseKeOLtR1NAVdeUf7gXDAkLuwr8bpT+ay5V6u4?=
 =?us-ascii?Q?n1K+EXP4xvEcihv8ZSj8OGyLIaZPBUa/UpuzAzHcd69NAeZTlsnLbUtJQjcZ?=
 =?us-ascii?Q?8GKBXxNyS20D9aAX2AHIsZKj7AZoDV4ulL66ZoB8oKcD5kGAToPU2jELAUjo?=
 =?us-ascii?Q?okTp9wn1ECD1aCibj6oKW77vpDJgATdFSdZ5bXHfphWEjA85iiBhnG5vLWat?=
 =?us-ascii?Q?mRW9dlKboa44HkltZ8RnwSPnboEqFNGEvxNL1EMBqoG+Bt5G3irDceZeJ9fO?=
 =?us-ascii?Q?jSui7NG9WPDSNfbebjtg1PVbtcXMwaymqOFqP7TkmOpCkN1VkFPVewK0dvdI?=
 =?us-ascii?Q?fdQxbT9/rRQ1hBrWGEc/mO1MzeCB890fnhGPC1gcyhL31Vqh3cTSBQkbdx97?=
 =?us-ascii?Q?Iu0UmMz2uIoK008RPy+suoFXajHV3ixVf2CIHnp1GC76NV7RcK0AtVz6H8RH?=
 =?us-ascii?Q?7VEpHufVSfAE6pbvJcLnEHkHC3mbb0mkiTghZIuiA1UbEKTC2WqJOd7Rsk87?=
 =?us-ascii?Q?6zm+HqjM9Gg/03HIEXlxSAslDfQr6WXLxYxxctaIiKV1XO/0PUEvmtBbHjTd?=
 =?us-ascii?Q?KKh2GfJ9ftjNnHiX3FikjXpZC9PXHiO5u8v0b3DH58X01J8UpM1V1tX6UjHz?=
 =?us-ascii?Q?SJFLB2WQpKrpuQo239k9Lg0iPAddZcRWV+TOZP96ToQgpeJ6Yyx6RHtNncDI?=
 =?us-ascii?Q?iMwpUoISSdJYcX47Zu3izENrsULc/j4y4EE90L9yQTuINcN7FoXsh2cZHTkC?=
 =?us-ascii?Q?K1qtnvZgBEbebynMhbBGzGYKG8zzNFf6hOeDXBD+r0iBijRh/pXavGP+58Dz?=
 =?us-ascii?Q?5v2N+TeqT+OeyzYUP9LRF8Z2cSOAp59Yq15fmRR5NSi6JAJFy2PXJqXqUvge?=
 =?us-ascii?Q?8Hqj/BwO6eP7VxSJWC3Q2F4kyRgForBhAmWAbJd9GA9fNfE8Ki2AX2bL1kt8?=
 =?us-ascii?Q?qUpiN4AVBP+Rj+U0Erc6RWW1DRvi3dP7pm/26Rhw0Al/Wp4tFxxejyZgv8oC?=
 =?us-ascii?Q?nZQMAXo6gUVBaf+wO84K3ae/8ajkHo7YVLzKJM2CmGhD4oEjMdAdH5pZVoGk?=
 =?us-ascii?Q?0Ejqgj1fQHO86WdboAVzETEVFDQNiDwKOgcQ39+AyyhpVEa1Vhu1ILi4IXtS?=
 =?us-ascii?Q?IM8s7f323Qa7t6gz73CnDN4VblqbS2a4Rra0KaZDc9N2Wc5OyHd5NzPVp60X?=
 =?us-ascii?Q?0reTj5u1Nu4gchsrxdDQ0DWT9pDHzAICOEBL9dQKCeNa7VWidnbKLEN17zJR?=
 =?us-ascii?Q?k4aTj6+PgXBLeKo8cf+boAU8drdL6puba4W/jNFaOH6asFtW6ZL6nA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?juChAwgJX+li6RMiQLug3FW5rhPl+gZPx5mnLCe4uejzq6x96VddNEMcvcOn?=
 =?us-ascii?Q?kSM33CSmK4XVWnCDxWY7Vf8gHc/IZHOyfk2ukn3eQakyL5niARNmBDVCiQU7?=
 =?us-ascii?Q?riHkdtEsWa7yv/2PhHyQxbAIAeN5L8SelqRYDUY7AHobPYLrQllip4My+XaL?=
 =?us-ascii?Q?3TNZ3H6tuebBbjxhMNaA5cQtfBg28lSHy6uXpfGhNSWEkMP2DVjn7UFsUVJ9?=
 =?us-ascii?Q?xJLPvkAGhqnc25RF+eAXQhQFiyuSfWY9lli+jUd9/oO5ZNchgvDII24iB6lg?=
 =?us-ascii?Q?HnJOXcS4HNZb92KEk/HHQ2HkB3JGLTR2dhu/cguBU3a6biKhUtJrm3Ptk5Rb?=
 =?us-ascii?Q?TcDpPhfoT5xha48VeeP3QQ6XAMBZXrcN8/ftIqrIPHHHMcFcX2R6nJlMYz8F?=
 =?us-ascii?Q?R08c56npGUjS6wttFoJG8B84RIOc8btupOXPL8KFI/d/tQKGphvRCXIgF2PE?=
 =?us-ascii?Q?B0XWJsYL17hNttji5mVt18ZfMdNjYtyNy42vNCR5LL3lReC8z/AkhRtUIuSV?=
 =?us-ascii?Q?yruuf3ZN2b8w7rZqeRusF7UMAPGrJwvE2whoKVPZJFBOYecFFXwNuYkg8Dg9?=
 =?us-ascii?Q?iQ7hDINZkc+FbHyCl115HxIatOtSb8xWRPnUAjZ+ZOwm/yRzSwLuTNaNDt82?=
 =?us-ascii?Q?YsDlqgPxqb25Kq2YEKQwtS7yWkG/yEAlb2I8vuSJnKikbZAGb+e6DFwb+ICJ?=
 =?us-ascii?Q?e3n9udIOurqBFjZhCez1dfFsriTVIFIWoDZv+/WOwsiV7ssVVY0dXafLqzKs?=
 =?us-ascii?Q?fBAxoRexb6ZCmprdgMb/yn9sKdeF5FKnX8WcwPDLha6GZwjiDVJZRiCE5mOc?=
 =?us-ascii?Q?SdqH1IoyUyHYTWIxxU/iZh532JWum2LXx3PpSnHQwt7QGOuYhsJzvezPdjib?=
 =?us-ascii?Q?L/0uMfeH/b3+bt09t4z22N8RYX1bpEe4PLG2txWGzBGUTwOlaIkr7cJdGKnH?=
 =?us-ascii?Q?JXby9K6J2TWjgo+3guWRkDDEvS/CNTT7dP5PVEOIyqmKUADcTVRArJXrOfps?=
 =?us-ascii?Q?YOZi2YghHvaot9jENTU4wXSTdZ4pwEJW5qLiN8rs6xy6vgrr/9TmAflOeFsZ?=
 =?us-ascii?Q?hswEzmnRSkyub4Zcj+gBC9EQz5oQn1Ue4BmNJKvhSzzglbyANGxiQjrdS5xa?=
 =?us-ascii?Q?SL1ZPyQZ8Z1MphXesLWvviJNMM+K9XlFwOl/YN55eNwPJu1fP3D3H8gvprA/?=
 =?us-ascii?Q?KkTDCCvhZc7r/DDYqdC18R+M+qHQaaNJy0S3aCBl9GGfyWusZq3dQBQkAYhj?=
 =?us-ascii?Q?WorKO3E1wnEKqTXjzXfOTvgYLH9O2SR6hek3ec4NSQUrV7dfilUYT2PFu8sq?=
 =?us-ascii?Q?cXVLhBmgVXIXbu+wVk8Jo3FuZrqCnc30wDnGoY/JzX+cFGLwN7k49fpZZ+4A?=
 =?us-ascii?Q?gRPdPTuYIj3E3kLpvX7MR9u+s3vfcQRLvhdjPD9mdKhe6PBi0UV/T+IMwh0r?=
 =?us-ascii?Q?PLuA0LeDXCC/xOaeU58ZEC55SqGvXs6dgn8eqZF1OU7eXleZbuht8PdWXHux?=
 =?us-ascii?Q?YUgRXnahR/2DkZ3ydnmo2oafupgp9mHvAjYA++Eg4c0FVgVdQyurUpq2OXIR?=
 =?us-ascii?Q?qv8gu9c+UtknLQ1a2l39YjHCrjNX91pCAtLxN8M3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003120d1-cd44-4c53-45d5-08ddebbdc3ca
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:17:22.7597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFuW2tk5oQNxo4Lzxlfxgfc4oVSpmhdwUF4jmGwdJNRxUvmaW9bF0/Q8CSzebaxM0JviNPH3Zs+9zDXnvFMzww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB11254

On Thu, Sep 04, 2025 at 04:36:44PM +0800, Peng Fan wrote:
> The TJA1048 is a dual high-speed CAN transceiver with sleep mode supported
> and no EN pin.
>
> The TJA1051 is a high-speed CAN transceiver with slient mode supported,
> but only TJA1051T/E has EN pin. To make it simple, make enable-gpios as
> optional for TJA1051.
>
> The TJA1057 is a high-speed CAN transceiver with slient mode supported
> and no EN pin.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 69 +++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 4a8c3829d85d3c4a4963750d03567c1c345beb91..124493f360516eb203e8711cb96789258dd01119 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -22,16 +22,26 @@ properties:
>        - enum:
>            - ti,tcan1042
>            - ti,tcan1043
> +          - nxp,tja1048
> +          - nxp,tja1051
> +          - nxp,tja1057
>            - nxp,tjr1443
>
>    '#phy-cells':
> -    const: 0
> +    enum: [0, 1]
>
> -  standby-gpios:
> +  silent-gpios:
>      description:
> -      gpio node to toggle standby signal on transceiver
> +      gpio node to toggle silent signal on transceiver
>      maxItems: 1
>
> +  standby-gpios:
> +    description:
> +      gpio node to toggle standby signal on transceiver. For two Items, item 1
> +      is for stbn1, item 2 is for stbn2.
> +    minItems: 1
> +    maxItems: 2
> +
>    enable-gpios:
>      description:
>        gpio node to toggle enable signal on transceiver
> @@ -53,6 +63,59 @@ required:
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
> +        enable-gpios: false
> +        silent-gpios: false
> +        standby-gpios:
> +          minItems: 2
> +    else:
> +      properties:
> +        '#phy-cells':
> +          const: 0
> +        standby-gpios:
> +          maxItems: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - nxp,tja1051
> +            - nxp,tja1057
> +    then:
> +      properties:
> +        silent-gpios: true
> +    else:
> +      properties:
> +        silent-gpios: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,tja1051
> +    then:
> +      properties:
> +        standby-gpios: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,tja1057
> +    then:
> +      properties:
> +        enable-gpios: false
> +        standby-gpios: false
> +
>  additionalProperties: false
>
>  examples:
>
> --
> 2.37.1
>

