Return-Path: <linux-can+bounces-968-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8194092EED3
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2024 20:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62C71C21789
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2024 18:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7983316E87D;
	Thu, 11 Jul 2024 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oy4AgKC2"
X-Original-To: linux-can@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339F16E873;
	Thu, 11 Jul 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722212; cv=fail; b=Sqi+clS411tlHvlHRAvwDWeHGBJtnMJK99h7csks+aKehQJv9VSuW6hYm8XU719NXBG7yOLsC+l3sD08s9TIXQ1521W5PAx5CJwMCy2sQ7OTsC7W+hNP8hOpYyQoIArN2Votb3xHYWVEpSFk/FJ51/TZxX3UtyQzPFV7T60Q85I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722212; c=relaxed/simple;
	bh=njFj/Lt+7JoMrNVZPHbsuqPQDfqzLOXzFzu1QBPFn5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fhPAH6fTrEyDLFyUSepruMuCr4nbApsX+3xQ+uMHGHu5d8ExoOpJhA9+psp1V3acsxEKTez4Lh2JJ9BAixn8YqWU8M/9C4o8YgcTHKacm5jnRKJ6Oat3+VrSoDMFGD2eyzAAcG1w89FLMtBLgT38JHDwyTxVx0SvMcbLYgyss94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oy4AgKC2; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D76RaA/SmPsg5qcF0KTe4HEn3ZaCo3cueo5Kl8SuKP6L09+bq4AO2btuIES63keJlYVGHPaopul0fz1VtjitEIZXiqF/Vt5igirb9qWoqbedamfhbIMvFSNnmQHEFZyCI26X2lBXUvcPc/ag26wHMe711UDPJAxiMYAn+/JR1uxjn1q6s1eCa8r5NP4mCkLq9g30YJNCz9edgJuKbaUvCiZcRTB3gU+qCdJc78rLI93ksfRDPgdwwx1xCLvMyW1igTt3PYSHtdsTy62sU2KQf1qEPNWho3wSpKI6m52NRF8LG5UQf5kvUfPbD0d9t/k5SIZ37yc/JDcWwJEEVFYoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UaekAOZ93Ecn0tdL5zanKt3sp8FnK2YqOCD7hmNFCM=;
 b=ZF42kL7Cv0AGLNpEsBTiNHOUaxnlqGxAzzAqTdJ8U+c4lqaCeRvAuE6L3KcDpzP+ioWKWb/Ui0AZBVMPq54RxO8g4CuzB4AEgesSLZY1YGKjYopo3grhG/UAQXTIUlYhCXLC1xrVOEzEHduLTAGGM+9WhP2e64m0pUKTvEJRJCdXmJlgHhXY7Mxm1WqcjxgJu+vRhGOH0EzY59LMs7BAm6XnLjbCYZkxQDXY0XG35U/cOsB2hmMWNVz4ZBvLcmlAlxQOfOQHnmNc6lnj3qfZM8uJJQCgpLqZKG7dRLGP0D/+V1/vhEcNFRz/gymbaZy1y7rXxf4cU3db4tj8TBiFkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UaekAOZ93Ecn0tdL5zanKt3sp8FnK2YqOCD7hmNFCM=;
 b=oy4AgKC2kugo08mHM0xOtvhvqgaBKBsg2/zs7BfQiOAiyYq40l/L5AYNGdHJC0BHBU5tvDF8aJWBd7IksN4BfTlND5ohCoIpUhh9K8UBaBUoOmmmXBgxp1Ot8wiE2rogIBR/WryIqrvc5DZKOqUyUMQzyQd2jlLFC7G91NCoEzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7514.eurprd04.prod.outlook.com (2603:10a6:10:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 18:23:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 18:23:28 +0000
Date: Thu, 11 Jul 2024 14:23:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	haibo.chen@nxp.com, imx@lists.linux.dev, han.xu@nxp.com
Subject: Re: [PATCH 3/4] bingdings: can: flexcan: move fsl,imx95-flexcan
 standalone
Message-ID: <ZpAjFc9OwxkgbTmJ@lizhi-Precision-Tower-5810>
References: <20240711-flexcan-v1-0-d5210ec0a34b@nxp.com>
 <20240711-flexcan-v1-3-d5210ec0a34b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-flexcan-v1-3-d5210ec0a34b@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 0993ce01-d058-4f8e-fd91-08dca1d68f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BA2azEiKUL2qikhHnLl0pcH37TxHBw0HwlOqZC4kxsMBSsZicehx5v8NmT1Z?=
 =?us-ascii?Q?NOCHTUUk5J6oQkLBhOimDaygs3DGtoMRbfcB96NPcP/Nh5C5ic8wZXOby2GY?=
 =?us-ascii?Q?LGCt8d+8JSggcmYcvFOjM9jEJNXkoTREXfhVCMqIKUKbaJ6QxADuGI+hxxIa?=
 =?us-ascii?Q?9gyJi8mgZ+KNFxhjzbNA1+085K5wC3W3Ezh+c9ypv1o2ElHHpbN9EezplRFh?=
 =?us-ascii?Q?PNg3c4Ute72fCpubDGuKHzssfcxtkZYktoP0RUb7/g5gMJw03srbckHeZRYb?=
 =?us-ascii?Q?57/Zr09eVcpWZ3mMM45dhgGYLDqOFrvtAbJzrexmKHFbyNc39gyX219kAIe8?=
 =?us-ascii?Q?3hnHQVMFkvfJ9NakH/BM0lTis2Nxc/jm8xHdYzo+v2mlKnkOcDzY2b8OAB17?=
 =?us-ascii?Q?d+eZsWrBMwq1e7wQSVkwWHek6kTENQswRWtW5jh+MGkppUel5o2+6a0ak+Fh?=
 =?us-ascii?Q?mESOXBhf8hUwQIqJ636o058WtattTsNx6EQ0TUNCFYXr9PdEcEbI232RTYMh?=
 =?us-ascii?Q?VU1FNoeboGeB41R9WLGckq3xRwHLkjrAsDdGkHN/2KgaanJQas5obtbFiSLd?=
 =?us-ascii?Q?VTE7/fhR3g033RWGjJiWXcwsI+n995tM3NSg86MGH+5j/v++teEXfclfpVfz?=
 =?us-ascii?Q?IoS2WGMCGQoVjRjuFrViJNBls+zTx36TZZq2ViTN65uwE87iD7IMJWuYGHAd?=
 =?us-ascii?Q?ckSROpxz9Il1UJCJcCq2o6QhUmro6OkxF9W+k1QrLnTAp2s0hdVzJ2jH/f8y?=
 =?us-ascii?Q?jrUKjWDo6+kXWJVplNy9DSq3JDEkGQAKPjJ+IHfUQ9DouKW2bO1VBR9nROzm?=
 =?us-ascii?Q?rawxTBKLu7rbgkBMYRXZUFRCQhEvC7QD4lDCXiEk4q+nsyE1ycQTU5rBt49I?=
 =?us-ascii?Q?3JMujAltHqTB9rRHBXi98F2X/MwYoSLF3BXofnRN7PadWNDUauoOzQP0If4Q?=
 =?us-ascii?Q?pACAATR2WASHZA9OheuUuoGr2Kh9GCRpYunsS8aQVur/qPcw0XcRAmA5Xhej?=
 =?us-ascii?Q?s57tpfnUAGbZ73qf7DxSlw0Hww4JrDfO8UhEtrekNCA2B9Pj6R3h+KlPcYI3?=
 =?us-ascii?Q?79DGtVahOiEd/9QExDKkuRj4KkmfNsMwyDkevWhQ1tCZE2ZC0vQJh4GVlKPc?=
 =?us-ascii?Q?Irz0/v56B+LIQfyE8VXVhPn6wgMpte6KeBPn02s4EdsSPQ9987FYPJ58OwCb?=
 =?us-ascii?Q?VqrpvqAAox9QYDQuD4yCKbDcBWwvbZmyf3AjGGwfph8tSQEdPpoStOtyUGRZ?=
 =?us-ascii?Q?Hco86Z+HmyIgwHvbG7NiZVhC0yZ8DjkIKKLynBEHCpdsHf6//NmIHCkNKBQX?=
 =?us-ascii?Q?K1YyMYAg139EruaspT7KIBKwXEd/AxNu6KzB+aEB+SYxEeWL2w3lcPzPoipo?=
 =?us-ascii?Q?82QvE4EQUJ+gEnwpM1Ei9f+B2XoeF9PuO6yr3psvu74md31ORw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eu7FgSK7JPWsK7IyLlo/1FAwaLBMWbEP9D6lcnpm6oDtXBzE2X08P0ep3eeN?=
 =?us-ascii?Q?KqYKGxcP1321Pw9MdIbTcm2ufn758TSx1rxcMycxUW5lpbR7NwVmntfgZ1T2?=
 =?us-ascii?Q?J4cTXtCsl3cEaYM6SL2OYlQpCXChEsedZlubUMusyZA/cGFqY+hBuxivPi3w?=
 =?us-ascii?Q?WYmXFvxk3g/S76DL6Nr5F9Ww54YOsyka8GcGkBDmo8TrCnjgl/nYRHBh/1Hy?=
 =?us-ascii?Q?ZjKax46Kp+qZDLoi9gsjwadgbEmtcuc4xWTr50CqSUIiHOJGNEVhh68a/JK7?=
 =?us-ascii?Q?IGFORog2ar5xcmdjE9jZpCDW1WRjsaSjWhfz1swgts4WjmWthoituhXKKwp0?=
 =?us-ascii?Q?b554DqK8RWagrFgW4vQYWn4QdYXQdjeBtQzscNoTi3yQH285724hJ7dl9nch?=
 =?us-ascii?Q?nbodjG0XnAqVYloSrqTjl083PmHY4SPFh04G6/XHKAOTI9CMP/h8twjNIlbV?=
 =?us-ascii?Q?4d2gK4c+y9GJkukSj+YX0Mesx4riDS0sF8IjHyHLzls9hyFdetDlpuau4d9s?=
 =?us-ascii?Q?G8pBTDb/sexy76Lchrxvz9HMza4KbpC/wx3MOj8+WqlWMtZ2vPfbIGU02H/Q?=
 =?us-ascii?Q?I13UYsBq5V2S99fEvB2fFN1Gt/0nspfYccBYnj/e3iTVkF4tw9eO/IP+BJS5?=
 =?us-ascii?Q?53VsLsEhe5L8Xmex1zfuvVRnSyNwIQZ+lvefMT0QYgUpcFyi/sag44PBQGoD?=
 =?us-ascii?Q?cfXlVGuCbDoZMhs9cDjLIzDYRNKvBHHok074tJQCinC+twgZ1qVSW0My/cst?=
 =?us-ascii?Q?1iM0Lb/ZZUbCITHVRH5C5mVfz1GH7+MIu96WjRBP01JOCMwKt5ALwh1NpGjM?=
 =?us-ascii?Q?yvDygZyjAQrut4EphwFEi6iuU395lHVaIiHgB13c5ePEB8NJobzSHEvMPGlg?=
 =?us-ascii?Q?2+WULeiOGnH5+gUWkmdT/lCx86Je1D4J3wMj0giBDpCgkvj2NQA66M2amh2O?=
 =?us-ascii?Q?Z1F2CYTXT5d0PYX2qlu88pNDsheuEK0gdYN7omM4DCvRMg7pKx39XinpX4ah?=
 =?us-ascii?Q?8+E1NWiHOHqh0/tx9xHWBTgUHf/oG9CVBebWxrAbuYbf8umeVhALqEhdRmvx?=
 =?us-ascii?Q?YHZbM0PdDrN9qcP90tRIZHzlkSKCL617XgorYhZwWDeUiNjwUK8POxn8Poe3?=
 =?us-ascii?Q?1RBpwxS+8MMub4ih+Nbgim8uCEbJC/V3200jQK+GQnvphLl1qQqXARUOny+o?=
 =?us-ascii?Q?oqZuVF/CjT4JvT2B6W8ICnBNUf6r68WrP47yCAmug3BwXULiFaCXagrzJzI4?=
 =?us-ascii?Q?FkDeTaCaTOkyvkqcuGXVI1njILlWSd0F2n0GWcCoIXQrE5TXBf05N/EzmZwq?=
 =?us-ascii?Q?5X3D8+vQinRfdLyiiyyMATCD7ONfhbI3SHZScQRKzxPxJh0iBr1YWDRRZ4rF?=
 =?us-ascii?Q?WZGwnyUdzviZByGgGH+Jgqitz2mGnWfS9RcF5iNZCJKE+EFgC2NBTFTX1MPc?=
 =?us-ascii?Q?RcQI8H7CsvXzKj6aFXbD3C0N/rjU+A2IhgWzKKOM42CowzIl4GkLPJevcbeN?=
 =?us-ascii?Q?m6zNO+ZbmyxPehmnKCk7ppN0S3llJozfcK+Ag3ZGr//rTEA1es0bUd865jDS?=
 =?us-ascii?Q?TTByBFERkBp7aBn9o9mrIa5/b3Xjxb8/MQEw/CJ8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0993ce01-d058-4f8e-fd91-08dca1d68f45
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 18:23:27.9403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVYb+X08IU2LhyaYciEfqcKJKojbyi0TPm7++ZBCN2pt1YA9diaiM1MtB6x7cfnLgHiUOfS15ouf1Zwu3E4kkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7514

Sorry accidently delete 'dt-' in subject. Will fix in next version.
Frank

On Thu, Jul 11, 2024 at 02:20:02PM -0400, Frank Li wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The flexcan in iMX95 is not compatible with imx93 because wakeup method is
> difference. Make fsl,imx95-flexcan not fallback to fsl,imx93-flexcan.
> 
> Reviewed-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> index b6c92684c5e29..c08bd78e3367e 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - fsl,imx95-flexcan
>            - fsl,imx93-flexcan
>            - fsl,imx8qm-flexcan
>            - fsl,imx8mp-flexcan
> @@ -39,9 +40,6 @@ properties:
>                - fsl,imx6ul-flexcan
>                - fsl,imx6sx-flexcan
>            - const: fsl,imx6q-flexcan
> -      - items:
> -          - const: fsl,imx95-flexcan
> -          - const: fsl,imx93-flexcan
>        - items:
>            - enum:
>                - fsl,ls1028ar1-flexcan
> 
> -- 
> 2.34.1
> 

