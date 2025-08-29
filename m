Return-Path: <linux-can+bounces-4396-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A495B3BDC8
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 16:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADAC680EC1
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 14:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8904D3203AE;
	Fri, 29 Aug 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DB0wTz5W"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E801322A3D;
	Fri, 29 Aug 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477807; cv=fail; b=svork1DiyhKyueD4l5hK5qrEoryiojGKYGPfFdDiAVRuHarv431IEzjh4jdylLHG6Aar3x/7jE4EPXRIc5mtqdTm3sduHwCtBdgBz9+tYuO94M7dwRnK+ZpLLarTBDjYVuW9gfW+k4Df1eXY04VP283lAlqKx2TUANhqUWdeiwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477807; c=relaxed/simple;
	bh=4raSwcPzqhMYJnzPJRy/cz5giOdrcOoWYRGK3YmAEeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j5FCJsReilh7hnOBWW0gn6W91N/BaNx3SgSE+VToape2sjWErgWzksaWWTvcoisLVehnFPb3FBvHJ7lhIrKVh8fYQUo2F6TSOC9QWGDhO4Us2bdF9gvAL2qPiP5xxlo+cM+cCRls9gyTnBFJ+hbuUEc7nlBmJPVkXZzNLnSlDbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DB0wTz5W; arc=fail smtp.client-ip=52.101.72.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPvw9WmQ8732RPJXn/AQCYmzjBNSOk+hImj9Mv1QzBr5cgfuRrFDYKaDFHa2KHv8EeNvJQghqw6GqrHZzGHKzW5Qza7wS3WBVoTYWtKqrktjoXV7NVM6MHFoms7VXp8sh7V5iRjwYqcpahqCs2e54U6VhmTt/c0cHBI35xPl/Sy5roJUA/6E5Hkct1i+D8glx0vepXCChSz/054v9p6i6zUJArfw4OEm7tK3rGfRvlyWW4C4FtsWnZczoU438ES8+pSyUCeIrAukRjovPMUsHRTdOPA1iplyty3LXIvilMJhtAC4AZ9rMgAAzynRb37ZWF9KKHgKmgl0caBzQRInYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3gXZ7lsIraGy1WszJGwL+w6/y9DQE0xhXqjtBzm/pw=;
 b=BB+WkGZtqXfZVhO9D2NoxQycDdxFKOe8qhO0bHJNY6qWqEa4TjxSdRW1yK1gCFKKFcolsLNi1goNvKIi1yWfA/ZrSNG7cw4NRDKVXkJU1/tjIf+C4UEE/UGqQXBckYR7XaRe83FgTpW77LY8n2xhXckxSSKT0sX7F2skMT4Pi9FQWuX9MGxEjHPNrfcL7tw5olY0N9/xyyEYhGqx3aV6u72QlLZOb2pDIXeVq2RIpwZaaakCki6uIBhSjCIX+RQcdkEFMaPzzr4fdOCNWh0aijPTaq7cINLZFpcH6VItvc3zfybJtCNs9J7o4yzdtaHgyrkKM2HG7LubbrgnN9RP3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3gXZ7lsIraGy1WszJGwL+w6/y9DQE0xhXqjtBzm/pw=;
 b=DB0wTz5WM952OM2DIF6iwRC9VZW8oBFr4NnR/LhROexp24M6cxLNnN+YTwD8dgPdUKTFZEkERFExmeAwEUE8eTOV1NXvYp2J4+/CK2MynACbfUL/sXi1iM8M0ZjOOYO9NIUX24Bp/gSq06JD9wvSApkvCOqecg0xXvKSuSmUchda+NOeAXPz781Sh5mVgeZ/aYjkOst3PLiA7ugbWLWk6KxE2GncUAEUHjWDjlygGvVIsS7fjm3S3999IbF8tVxpLRGTg4llu/Wv3wUlTtYfM9ptljm84xiGbRV+jRXy25rdEbfT7jwzzHvWcYrr3v3jGXYhV1NORS2S9SMUIhBtGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Fri, 29 Aug
 2025 14:30:02 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%5]) with mapi id 15.20.9052.014; Fri, 29 Aug 2025
 14:30:02 +0000
Date: Fri, 29 Aug 2025 10:29:53 -0400
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
Subject: Re: [PATCH v3 1/6] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA105X/1048
Message-ID: <aLG5YQvw1rVRc//I@lizhi-Precision-Tower-5810>
References: <20250829-can-v3-0-3b2f34094f59@nxp.com>
 <20250829-can-v3-1-3b2f34094f59@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-can-v3-1-3b2f34094f59@nxp.com>
X-ClientProxiedBy: PH7P221CA0065.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::31) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AS8PR04MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: cb61d927-d6be-4645-c5c0-08dde7088a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mQX2mxw1FP6yx878sHU9U7Fc74O4c476nYKu3ytwy2OLxFuhrEPXnF/hSLG2?=
 =?us-ascii?Q?Sy+rPUxejNGevdWmx1NJ4WLpT4xOSw4tr2VHLG4PamrfwY+Bs6vXpHJU3INL?=
 =?us-ascii?Q?DpuMvBzB/mpoxPgKSZKfRvbaHqMaJDPJtGnj2vuL3E3F4dnOWQq7MroyVcwE?=
 =?us-ascii?Q?GxhU2OGgkQ1VEElauibspZiKoumoVETaBbXDV5zzKEhXxoo7w/b2sTFdspVk?=
 =?us-ascii?Q?xWgUdJmHyBVOmTuxBsR93LREQFDZoZVKO7yHgiHEorZTHl0OoL1oY5D14H0h?=
 =?us-ascii?Q?ihgA9G4ZWK3Cis7S937OowzVC3CKa8JZh/XVez46SKPgyzEWsDY4rU9CuQOn?=
 =?us-ascii?Q?nlyvQ7nLSXnPZsMggCLvGcZEd49Gr1Bkf8sgrZT0vnIn0DlJ9B+fOwEc/SFV?=
 =?us-ascii?Q?2pH6y2Vto4ctYiJgLh3/U6CrNgoI5YvaAeCkFkLbHAmq9cy0m7YaGHdiiogF?=
 =?us-ascii?Q?rG40THuL+7dDrM5ETE0+D+eWAuH+cvpg5fc6BCEZjEA/0BhvEUB9pWUknJ1h?=
 =?us-ascii?Q?du5hKZzCfXLGIhi/WEX4HRTepE+wWK1LFpjHUuk2seHrZwff5tdDiQONa1Yu?=
 =?us-ascii?Q?AF6bu7BgC3Go2Zz1EOb5/oHdr03QuGIOv3ZvozXtgOyDEiQgvUa5MGeJAu4m?=
 =?us-ascii?Q?Kot9goLQrf0+EJFbwYa/q8Iwmb0lLW3r1V2D1JUzyPAHbV5xJ5LqbRHyByQp?=
 =?us-ascii?Q?g0zb9+YN0WNNNgd+Cs8yI/AN3yzLzor1MOD98gv8dS83RowcfsQf5SRW4Ble?=
 =?us-ascii?Q?V29IH93JIkJbVhr1HNArQN3zYvyRwmtIzMltlwhddUZDCyi2OhmbRv4JV8Ag?=
 =?us-ascii?Q?woxBAiRqAaGGUtdA4hc0HRFn+S5kY+VNTqv/4XMnpoWl3VA9Kb9HLmkRt3q4?=
 =?us-ascii?Q?2Hx+6r/zf5o9RjH6mXsXVibAf1IRdSObX06Z4c8Mrq01czCDkVwK/rGv6Kbi?=
 =?us-ascii?Q?gLgnmu+5g7bML3m6TUcaSKC1Ke9ip9jp6whZ/s3inAVvn7fig2KgQfIBMYu9?=
 =?us-ascii?Q?M+fxdWCa/P4it2CcrJYxeNIhEZKjA6jKPjGLylDBkFG75tcMnsZhRF4ZuHKj?=
 =?us-ascii?Q?qjgnk+IiFLpFIVN7++WLjQoJapuVu7TaL9NkZlnVwqti4/Yf/CRrLQFpvWVM?=
 =?us-ascii?Q?KDHUB/RDOZTqz/1j9NO6nYxQoM8vo3H9k20v1aDdI+zhobU1i9u6HcVFvBx0?=
 =?us-ascii?Q?+7hdfa2vC/N4zmL0+M+MxdC5/OY+LdilRfr+5M8ZuHMZUmO8+ZoiuJbMx8as?=
 =?us-ascii?Q?0AcyLfTN+dMphphQIFhC2/xXs+YIjTWpACJrBS8xyGXzOECwk8/RGiV0lUOJ?=
 =?us-ascii?Q?qhDKBqwyZg1Lo2Xgq2VtNa/pjtMTdlv2tm5f0KCOl3IUYrcD8t7rGLqg51ru?=
 =?us-ascii?Q?6gAYlFSD83nCnfjkxwcnXIj9TVdgYHT3xb7s82iNQg6+TPPNuDJ3NidH7uVr?=
 =?us-ascii?Q?hFntJVxX1yqCr6TrXnMJzOhnSx19q093dTjk2NN44GUoAJ6EugpdjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sSmAfqZmLWi+PPEOS6d4v0DQI5EsJiOhl/kyP6IHb5Ki+TOaP2dst2W2g/74?=
 =?us-ascii?Q?LRTYUJlKDi22/TSCgdblAlTkfX5/L1LEHVH2TEuPwQJl5NheLFdb58d9X9+I?=
 =?us-ascii?Q?QiKAFQDJ0r8i+/nH8dz9JJC5dBJuecP0upgZQZg+bq2JGgHhQLlEaiWNP9wg?=
 =?us-ascii?Q?YhLV7xpr2sVWe5rLfiLjz8HK3qQMvJlIPFgouPwYdxPmS5cH0oe70m74qDSf?=
 =?us-ascii?Q?SxT/wXkafrtoc7UWcJQRXNQdGhVzJWWSqWsw6sH70WwDxD1Sskg9p8SEAIiv?=
 =?us-ascii?Q?yHUgaPnaQFO7eUOon5ezbjXGvpmDZasVacoBljw5O5ccvv+iYPOCo2ZE+5Nq?=
 =?us-ascii?Q?N3zJrNfQ52+z6hn6Djd2io0z/bRkhHaxbdUuckKvk+9nOTP/M43Kio0g+X2j?=
 =?us-ascii?Q?8UDklJC0gV4yNAe54o0f+i1Cp/fC9U+m4jRnavT2yOJVyUrAiNTZUZ7NU8fI?=
 =?us-ascii?Q?eTGJW8T8dPR/2FsFPzRN7LzzgqWqDck01GtcvKIbbHq67+XzY+Yk7/8Eezp2?=
 =?us-ascii?Q?Djv+0XoJ7XWsP6rQwcYdnk1oXIC9DTXYHm4uj1lhiIpCCYh+iyp5gCOTMc8w?=
 =?us-ascii?Q?Z5gPTURYSAMelAb5a2EeoBG4UjrpBZbILD6MtfvdghYTpJkqlvY9RjiLSFkm?=
 =?us-ascii?Q?zstBYZa8CTRhgsE4Tb1TuHffZ0Vd/SIaTRV562gei6GZQu/Tv82w7bYuKo3/?=
 =?us-ascii?Q?vRKJvFlQ9oUNdnLgf8iwWW76/9zA0kH+945kd4c3WOcktsRGlZXYR+Eb2tuC?=
 =?us-ascii?Q?YInQlSSXbtFyGedw9r6dSoD0yPZukv7J0/gik6AHcgs8TSf2OVQW5HGdVBiu?=
 =?us-ascii?Q?IEqAz0wHLeSBYVsV1RlIc/aDotQXzO9AD7KR4AsjmdUNJSdldo30ULQH4Cr1?=
 =?us-ascii?Q?UZXC3D5+boUyQs7mATPT3O/C8o/Z1qwIeWerdfMQBr7DIQbU6L9+9LeqHPe8?=
 =?us-ascii?Q?vpS/hIA9jokjzsQeXRCGVAOWHri1pJkG+nyw0MzY7to4NctwZ7OxFeFRgfYC?=
 =?us-ascii?Q?ObnO83atfdy9BRF9eA1Hphj+zIkoTR32bVwtDUooPH0XDBygG5Q1ID+ruJ30?=
 =?us-ascii?Q?FCwPa7W4ZURk9ydzOlr7qnd5v4Io+yPNok716UX/5P/YgeyIPi8AZYV5rosg?=
 =?us-ascii?Q?aOo/43eUcrqvM1QQ32py1FnwVGL70IQaHZjdjUWivQ1bkITWGoXiWW8kK4tQ?=
 =?us-ascii?Q?Ej2aCBMmtCxMF+kZoqRXdWhDSVYzGoRlIltRz0BNfsplp7HkQ4hCa91oBupm?=
 =?us-ascii?Q?xTG5/M3zGxwpatPIDGRWVXLiYCbb7sQ2tTQmp1fkQUnaHsAu3Pesr1z3sZMF?=
 =?us-ascii?Q?9FZrVsN4KLV3syaJNs0XpRjhxXB1G1A4rDP53RYTZp4/lXx21SDpVIzV4gz+?=
 =?us-ascii?Q?UGGH9K43zEcsz6j9R/ATwk0asgcBQ2cyPibJoojG7fdQWdCzIMF6hbitRpF6?=
 =?us-ascii?Q?aa3HcEpoOk7tzMY1ynjtgEpYsqvngEJynA5wET3GMyG/TnphEJ++dsywd6nn?=
 =?us-ascii?Q?bIl1LTEHSPf4qRhVGnEfQbAejUlp4kMRL/IybyR91wQdaUheblDmKT2TFa9E?=
 =?us-ascii?Q?5Qw8JdxEIAxryRGUKKsQ9SV8H4I/geRWdBRlNZoR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb61d927-d6be-4645-c5c0-08dde7088a34
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:30:02.3342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SL6OF3sI/POnGTij0RF6c998yMk/dzf2BcMrL8rlKadtjpUOVEGAYOoFpyCOCLm7asu4ZhahYlbYZeBSvKzrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8660

On Fri, Aug 29, 2025 at 03:08:56PM +0800, Peng Fan wrote:
> The TJA105[1,7] is a high-speed CAN transceiver which is a pin-compatible
> alternative for TI TCAN1043 with sleep mode supported, and has a compatible
> programming model, therefore use ti,tcan1043 as fallback compatible.
>
> The TJA1048 is a dual high-speed CAN transceiver with sleep mode supported.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 32 ++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 4a8c3829d85d3c4a4963750d03567c1c345beb91..a225540545301e443e3460b933effbad48786597 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -19,18 +19,25 @@ properties:
>            - enum:
>                - microchip,ata6561
>            - const: ti,tcan1042
> +      - items:
> +          - enum:
> +              - nxp,tja1051
> +              - nxp,tja1057
> +          - const: ti,tcan1043
>        - enum:
>            - ti,tcan1042
>            - ti,tcan1043
> +          - nxp,tja1048
>            - nxp,tjr1443
>
>    '#phy-cells':
> -    const: 0
> +    enum: [0, 1]
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
> @@ -53,6 +60,27 @@ required:
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

maxItems already 2 at top.

> +    else:
> +      properties:
> +        '#phy-cells':
> +          const: 0
> +        standby-gpios:
> +          minItems: 1

minItems already 1 at top

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> +          maxItems: 1
> +
>  additionalProperties: false
>
>  examples:
>
> --
> 2.37.1
>

