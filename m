Return-Path: <linux-can+bounces-2117-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3FD9D2F13
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 20:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A741F23334
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 19:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669211D0F56;
	Tue, 19 Nov 2024 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V/4vII2M"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755BD198E63;
	Tue, 19 Nov 2024 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045815; cv=fail; b=qwT8Xs+NlZ8c6Xk5bZVQtOxYUMBMstDF3N5f80770lGIJpWWixTK0T26er3bxWE5s1ct4go9ge6thiYvmsfAF84SqwaicGEq77jHND/uy5EugHWVtcN0QuNKUnf1+8UTWNdpy1cRws/laNZG8rtyylMXEBgjlEDTgVaxF4z7zMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045815; c=relaxed/simple;
	bh=lCS1U3qiG3foust6P9Y7HD1gCw4x/nYPAPoLH4gnYag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g36jfzznWKNVAKrH9coBWgz3SkcHjI2fHJxZCZJpyBIJzwXJI53Cg6oz3IjidWxdtRAEdZp/hODXiwFYtV3zo7WYoVP3Id5qTjT9gK40HRiwTk4eNptmt88BWof7zBlE6/WTGTcMsoglw7b9QPNEv1PEtgPMSV1TVV9cjmdWTEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V/4vII2M; arc=fail smtp.client-ip=40.107.105.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pa/nPac1yjDAIu5+9zPIzLCMc+qTok/3nh11c7JzoJ8NAo8Ad2W9lsVi5SIjnOOG4ielRG7TDgp7aT2nNNldC36oU2qQJas5cpWHqca72S+X+TbONPl1Mmz8awZ3p1A4z2m1v97Bnv43okTFkFsYYLiC1lIIRa/D4SyDCkKXOCh7kz9quFdw7sM6x4Nfmjjhtu9P4o+Ogw0oqcv/yALF3CWCpUcrMY1/7PGt5NK2LO6pEVUeM8J3xKVagYsPvOv6ZiGIq7S0kP6daQ/wvq933nYPOPKw66s5ZNtXbfuI31BbbY9ctTJYzj+4lceN23Ne8cvm/rJGXdL2AiRmUNZAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X77goTQOdWaSFWd8vUHy7fDGAiK8x1PSgyYQJQUZraY=;
 b=Bg6MjhHQvE2MPiUWBcci2UPm0FMiTwalYO6EWrxmbYSU0hrIH0KpMvjQ1NPuaQ5tnKmFLuX/J5xWjMOWTyhYM9hid9WFrpq7K7mKGXouNT3ZL7FX2AIt4TxJ8Ey+NSKxenMUCDs8qBhD3LY0tIV08O6HJ66sgc94hkYUuHtpBELEtjjafrO/OUOTjPskvTn65PfkBbiPiacVcZf3gcIfrvuoU96DtwXhDhBI+zRaNOy3zrbZuEfqfHakKp0nRg1EBppffBr7T1+7jVOVwa2fR7QpKrorbWNP058g/Qd9A621WXuuSSm/m60CMv4AbwqnMmWkIXgG+7nf/3tthv1nxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X77goTQOdWaSFWd8vUHy7fDGAiK8x1PSgyYQJQUZraY=;
 b=V/4vII2M8rTCq3aiFeOaiU87gbaFR2Q7Kl0YKroC1Hx86t9D6Jq07/NcaWcUTWPy6W6Qq9pAwtBg7C61DVG8fl1TZ+r7DSvZjjRxrPmwFPPu+XMkGtnR/6sCk7zGgakU+Wy0POHno8EmTQiy6uChIgpjYyQQDLhEoNe9MuSZP8FxsAV8kJ6zH9dU5B9X9vKJvjMWMQIKSv+waoNAc6a1NW4nSQ9yfPtWCIyp5987AmzK/DanjkoLf6KjBXvhyNGRWK32baUjst8a3np25WznvWrcmcNs2z6TL+lbmCcSWPxJJP2cx5TvfpPWInilvGcwFVgVzFmXU8U43yscqWQ/mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7628.eurprd04.prod.outlook.com (2603:10a6:10:204::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 19:50:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 19:50:10 +0000
Date: Tue, 19 Nov 2024 14:49:54 -0500
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
Subject: Re: [PATCH 1/3] dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC
 support
Message-ID: <Zzzr4szwvs4RPtTB@lizhi-Precision-Tower-5810>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-2-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119081053.4175940-2-ciprianmarian.costea@oss.nxp.com>
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6fd13f-2c15-4e5d-0b81-08dd08d3601a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SO9aCd5391Ef8EtA1eH9YJ7vPhGFul1O/NgaUkc1sRz1L0swGVysvivVov4T?=
 =?us-ascii?Q?+F0m9LK59UB6S17pqup/Kt3l87F0ABrsf70DYvsBRINf5sAeIu009Pk81PBp?=
 =?us-ascii?Q?cF6zK+WkPdbsQ2ZWcdujcs6J/h46TvHDeALtwIG7EIsvHtIe6IVCbx/4LGoC?=
 =?us-ascii?Q?lb65cq3r2HVYJmvg3apNqHHWM0uVARCX3S5SzN9HL3umOHiC+5NI7CHqhkI/?=
 =?us-ascii?Q?TYadXZ/n5dO+ppZeFJfJoVsz3rf5u1ai8uACzYs3UZlqFU9OAR/aqWZ/H6v7?=
 =?us-ascii?Q?M6w0Ans9m//graMppvhAIbKq3C0J5uk7HQkzP+SsU1ajFsJmtfC+RpgaVGN4?=
 =?us-ascii?Q?XmEYQTyHu0cHMkTFdHuHta4KlA2SL5eEKxwTpbpzQs5gyHilbY/VY0SkqxXI?=
 =?us-ascii?Q?0TWuMbmhXVdUnjC8I+I6RY8VzbwFSgu5PwRzUriGpmnpNvcTtsDhUEzCB7KM?=
 =?us-ascii?Q?OZu6hm1WupQJJcqScH9HzcW0rKBexmmG2f36GOoab8PfAqAqNM/BDZRdFl+9?=
 =?us-ascii?Q?UStSuVyk2dA+EVWPMHGgFgjHFXLQ4UvCle9mlE7y4/nCTFETyUg+sFygiM34?=
 =?us-ascii?Q?59UMIkjpXKrmJgqasjmZoe7FI6HcpxIGOtq4p4rlc6yaZDgNVypuyxZGKSBl?=
 =?us-ascii?Q?tTQ4u+6wwb/I5aPI9b3GnWeF2lMDy3gHYop56RHZzsGpfas08/UruK1+YSWx?=
 =?us-ascii?Q?C8/+g2qaLPLsoZmadutkmUUTg0Zctz8vP74084Y9NlaJv/gaFWGTiJNq0Fsu?=
 =?us-ascii?Q?bir1EiGlHRoRpE611117VM9/ZiZFsYhobo8IieqZoljnmCYcRpLFdCtRxBuc?=
 =?us-ascii?Q?V7zLEPxZT/M5ZG3/5n0XLMrjhXWGqyNCR7L8nIkwqw1leSkAyyZCEMgj/y6b?=
 =?us-ascii?Q?fB5xhN2+hXuOa6k4DsjsCSGtQS0gykfA6tUlJmkICpKGuv+jN2PXjpMwyo9b?=
 =?us-ascii?Q?M3m2n/dhBRB//iWELtuXCSDHr9NGM116lb5YRKM7N/XkZQ0gTa+j1WS9UW+d?=
 =?us-ascii?Q?Ij2AATtC8rdyNeXpSfuPVvG5zUHE/hEykOfoizARYHdydZVGIItZxv5WM0Cq?=
 =?us-ascii?Q?Aa1LWkS2PfQ8e1zk/lse0+xy0V8AW5XT8B56H9JyC0sPLkWdfMSJYXktqxBE?=
 =?us-ascii?Q?c08iwY7QRy/FQrA+2+J8LOpxcChiVjaeGuEeyvl3WwZJ5YPBNE0r4ah9TyBS?=
 =?us-ascii?Q?AwjCkDoEb5buAEq6tGSPF29JsJ1Fq3gog0p2CFfjYdE2c1U7rawa16M00tBn?=
 =?us-ascii?Q?MkhdvF34+ZUwrmYjJwsOK/ggjspA67f3wxYpRBACCYIIKsjqKgakZHOz1SQA?=
 =?us-ascii?Q?mS/ilMzN+KkZbh9y/Owa5d3j5JZPKASEFvRUJ7HqX9gidER8//mpB7vUpXgn?=
 =?us-ascii?Q?GKyjtA4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0AhNUT8c4j7b4q2a4mMKhcF1zQQagRMBFp6XOeRy3mmRtUNeIiQcrNH5dzhl?=
 =?us-ascii?Q?/9YbtZar1CVMkSvhhP7Rs667tB9h+zvHlqXJOtM8QVn6iGVv145x32MHqIYg?=
 =?us-ascii?Q?N+pBxa88mvUvvlQ5Fx3iaL7vkTI0L9O6dKXgnQaUUD/neLqvEM7cApapU+wH?=
 =?us-ascii?Q?k6sq+S3rUSf1A+o0OrgCvQ9RUzuQBu7J7acUSI+y212VIcPUzrlOkyHB7tpF?=
 =?us-ascii?Q?yf2uJaLbSUQlrjJnKNchWLxM3x1nxMTyyB1BqgZ9YiGagWXTjrtzf76vcNNY?=
 =?us-ascii?Q?Bi4p7rUnCBxq5UgrtAyhtVcnJh9sKd+ACVMf6aiKITtqM1mhIDMZQ+pLghDh?=
 =?us-ascii?Q?idfpOUZE+mG7xZBLFLz4HmBbahRszSCFz2gv8GnIUmyI+xy9Ml1mFEJULlIK?=
 =?us-ascii?Q?8lKyRvBPIITe94gyFhZCJDBnGPAXGlcrq4pFKi8Q6YyLjHMSTe/cJy8wPAIf?=
 =?us-ascii?Q?5k99jCB8dGQ+Snn2n8L+uQADueNQESkGRhJoWLbgMSuG8ZKjdhNjDECXmjbi?=
 =?us-ascii?Q?KSppeMc5ftxSxUsj1Bf+Cu3X41wGf9uRfF+Qiau8HAzWEgkLOBo75NjNzFDT?=
 =?us-ascii?Q?S+KLKTgfrLzTPg8r+nHejilvQc8NzCZmC/O7DqXygE8E90bLGirSCQOMody3?=
 =?us-ascii?Q?Va+wA4K7aM8OVODtVFiUCuOqFmGb5ZRc3Kyd+OhXTRYrQriw0saKME0hRTuV?=
 =?us-ascii?Q?5ruZzL9W24mBzrHm3/9NlrGJ827vkMbuCc/h3VE4bkO83JNE+j9u2Iv6NSMO?=
 =?us-ascii?Q?hpSSwnB58ubVBqE3AxU7aiOOa8ycauw5O2qN5J0ObtDH88wYdcqrnxnGXUl/?=
 =?us-ascii?Q?Zjju9EXcTdme8ujbF7lVp0Uk1G4/dRxrcuwAQfk7bJF5uiDmkfGyDnlz06N5?=
 =?us-ascii?Q?IkvLJryO9ASq6Yj4YH6cgLwnDlxcjQevjnewMgnC387Uv7L5L+BiMOdSir16?=
 =?us-ascii?Q?orQkKx2E6693mEPKdrhf9m4LQj7dN9TmDl0tXo9fWhN8KAr30s5U8wDG18Vl?=
 =?us-ascii?Q?4v5a7gH069LvTmtBTqIQRfUMjE4Uq0gFCLFh4McTZPoZTz18tQugtKX35+MX?=
 =?us-ascii?Q?SIcLECA+ctB70+B0G0OrzGrxf4RG4EP8KfPBm6u6HKRLwvHF5s3JBOAPamTi?=
 =?us-ascii?Q?gxJI7XwqSL3guupnh8ccxEdW4wsdgWJXDxRYNYGJamMQeRpL69nLl/OrXHVP?=
 =?us-ascii?Q?rXeYRQuEZL6XP+CYSvg+0yjWACqpmy4sKtWHx0NMqOH09l6/n9LecyZ9wvTB?=
 =?us-ascii?Q?9pC/zd/jV5LMaXF64+vKYXM8pclWLQY31NcIW/cLQD07CcB3r+drk8E/lxQ5?=
 =?us-ascii?Q?n0u/+YkwvbZRC9kUovnFcXarVKfjUqClCEG6TzNdd4yDBrbbbz/FDt65vAaU?=
 =?us-ascii?Q?DaoCYxP9vzScNhx197VyMDvvpV7T/yr/vaN1ttDcyzQnt4d3atsvDrUzppSv?=
 =?us-ascii?Q?CXjosWb6Dbxj3nq5gHSsUfQ/aFsTNFJtfF4KjMdZOLt4kcTfQoXBOjrH0oW7?=
 =?us-ascii?Q?UZetCVj1bDjEvXXpzt04Yt4nNtE95DRrr64r7WmAaNY/58pAzWvrIbnq2Knc?=
 =?us-ascii?Q?5XGlLm0Yl4RjpAoSvyo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6fd13f-2c15-4e5d-0b81-08dd08d3601a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:50:10.2510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWDCMDTnK58e5rZx14gn5s0olXRnAvWR1nvIrCf8QqDa1e7ZqSatPrJeDAj+q1o/4A7nzUR5WsdSCPrLAEUaNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7628

On Tue, Nov 19, 2024 at 10:10:51AM +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> Add S32G2/S32G3 SoCs compatible strings.
>
> A particularity for these SoCs is the presence of separate interrupts for
> state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
>
> Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
> same restriction for other SoCs.
>
> Also, as part of this commit, move the 'allOf' after the required
> properties to make the documentation easier to read.
>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  .../bindings/net/can/fsl,flexcan.yaml         | 25 ++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> index 97dd1a7c5ed2..cb7204c06acf 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> @@ -10,9 +10,6 @@ title:
>  maintainers:
>    - Marc Kleine-Budde <mkl@pengutronix.de>
>
> -allOf:
> -  - $ref: can-controller.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -28,6 +25,7 @@ properties:
>            - fsl,vf610-flexcan
>            - fsl,ls1021ar2-flexcan
>            - fsl,lx2160ar1-flexcan
> +          - nxp,s32g2-flexcan
>        - items:
>            - enum:
>                - fsl,imx53-flexcan
> @@ -43,6 +41,10 @@ properties:
>            - enum:
>                - fsl,ls1028ar1-flexcan
>            - const: fsl,lx2160ar1-flexcan
> +      - items:
> +          - enum:
> +              - nxp,s32g3-flexcan
> +          - const: nxp,s32g2-flexcan
>
>    reg:
>      maxItems: 1
> @@ -136,6 +138,23 @@ required:
>    - reg
>    - interrupts
>
> +allOf:
> +  - $ref: can-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,s32g2-flexcan
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 4
> +          maxItems: 4
> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +
>  additionalProperties: false
>
>  examples:
> --
> 2.45.2
>

