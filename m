Return-Path: <linux-can+bounces-5301-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE813C29E52
	for <lists+linux-can@lfdr.de>; Mon, 03 Nov 2025 03:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D0F3AB4DD
	for <lists+linux-can@lfdr.de>; Mon,  3 Nov 2025 02:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11DC286402;
	Mon,  3 Nov 2025 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GpA244dK"
X-Original-To: linux-can@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010004.outbound.protection.outlook.com [52.101.69.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57E383A14;
	Mon,  3 Nov 2025 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762138581; cv=fail; b=O/H6Nn1+uvOr0yqJtelzmzDpYSFz2vj2cBoOxP5NVl827WIcfg8TrFiJT/EsqWpw18AfX50ACt4ppjBDlEtPunKflndiNQqpSyMRSTpH1nfK92iHONtVIqJn057wYK2mdqleQL3QAhntzCkSuJslI24twp6KguQw56JfHCRMlnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762138581; c=relaxed/simple;
	bh=9LGs2YRsK6gUALdRrmdAbZzLPhG7H239FiiKMSH+93E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R/gz0v3AFsF5lSAxDz0/leASHcPg3rPiKeIdU4FI2ydgkji8lrAJvu3gdssiEyZaAdpslE+15Z3kJBmQ3tgsIINFUhxd0aXzC3JGHCdo6MVz+C1qgcFcpzStkcV9YubrS26oyg6ygIlZ69gSnoFAsdnSJ0Rn78AyyiDYf2VtRwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GpA244dK; arc=fail smtp.client-ip=52.101.69.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLSf6AYVXwKLkvSiC+lkt1hXYRV6G+iMaQIjFoebgoM6HRcMkP2WgNl1bhg2GjjNe7bckkIAnFLdC80iwW7ctl4SP33xw1U9OimdaczzIWpVm3XmzMIiEUtVMuSNjn1LNjpMKbbXIFIyoTg4ycXcnaT1H5ieJ5UgUljytOrXHV5QQT1NM1Eq6+ZhCrAS6d+ACuC2E3yAKd4INPdSHLBUhsjSugT0xuUuw6H4xNzwSZ/Jv82MktA7o2jRsTbU2ZHwhpIov2kSP6UHJtLsGk6y8zDDnmqlHAau86eoKFKsnYSSOxqHSvR82SMH3ZgDZYrMN5iIbXAHaBbrFoDUjqK4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ti66uUvmN+e4E5TSYt+WkKkYVrtvo5cHHT10C2GD5/I=;
 b=Dd4xnsAjuZaAkY9llvolp5pv/sEz/odLFFf7EIUDd5fIKaujrDPjvadJnSio+AGnbTKn4VZNlFD/mC8HdfoxwTn01WKmr9PjNiEsGKpxaKRvsptG9L2iugpYhHetj1SuXDIOieKKbziB4NsYmX9Ow3lY/atLLh7tfQSplHQoKVnppiy6t7NqOUzkS5j2iy5PvO9Irr8ev0Widvy+sRNWcE3E6NWUlmESX9XtyRY0pjSjUiyFV6wk4LupQb6zoVi6ul6LMWcGmWqhLtpE+5EKkzcWXfnSF15rC9/KaxjZznpNZ6QCtkxkEO1KkMSyO1YwqRwz4VNf6vYeNVTeCJ051A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ti66uUvmN+e4E5TSYt+WkKkYVrtvo5cHHT10C2GD5/I=;
 b=GpA244dKAMx7M3Fq2aixOMy59sT+zKJKyGtPH60cUavN6MeM0CUVwfdYFqu4UvJYeuVqSU5w7G9ecR59GoVmI6D+SoQusq0tNPkYnKmGEwmpkwKrCVQR9pVyPyQF+PCoZeV/Tekw9LyFtlxlWxM3hDRlzk2b8gwyYQaPH00BTx/B/3taCkjuJzwiGN+TKNKhZ062WVBRziZUrlOU1ahLmQv6dEYFJPvfTA4+P5VxcWlEL/KeRAH2/M1tDu1fLt6alVZwbJcs7Qbq0IqavHPNlGW8w3pc+3SNieZRnOartDBWTvS1ZYdn19AXEE90NEEOFhp4WPYuUviVNIPSABkEkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10352.eurprd04.prod.outlook.com (2603:10a6:150:1c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 02:56:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 02:56:15 +0000
Date: Mon, 3 Nov 2025 12:08:26 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/8] phy: phy-can-transceiver: Support TJA1048/TJA1051
Message-ID: <20251103040826.GA16149@nxa18884-linux.ap.freescale.net>
References: <20251001-can-v7-0-fad29efc3884@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-can-v7-0-fad29efc3884@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10352:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b66cd0-4d4b-4fac-7bbb-08de1a848d8c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NKCzD2NA8v3s7cgpFgFj/T4TUzVkUmkLH7pBpUJkymaOLJSCUojaddxpfwxK?=
 =?us-ascii?Q?xaAxOZuwIp4Wx7VqEkH69ythKMviICS8Cst6ToMdukLIGazUkePobKS4+Kg1?=
 =?us-ascii?Q?wDmuMSfS3w7SXhlYRpmfsT1xB1iUVW0vZxr1AjJ1Co9muwjYeDhezvCgNSwB?=
 =?us-ascii?Q?ZGw4DizmloBG9Jou8IPLgw8y9Hc5fQreFrHDZ4QUtq2qrl+A3kCxzCFBRfo1?=
 =?us-ascii?Q?TWb8zoufBZ+zQqZ6ZVCBXQ+cgv5bSXl6jnIlXq0JUaqotQ/LYPZ4nAqZHvzU?=
 =?us-ascii?Q?eB4O/vNSoIE4Qxrh6+/FD0p5sLHnJWc3W3aI7oPFOsWbkfZC2jg3Fkv89l0M?=
 =?us-ascii?Q?0mx0xpzM19BSPW69GKyToobV/ErjqUzS9+rdtG46jma1ju+suTMCcAbXc8MA?=
 =?us-ascii?Q?h3n41W7bhsv/SaqHsvCoOG6txt3dKYsQgafKhmGcEWaCSUjfCD2ktzHD3s6J?=
 =?us-ascii?Q?AF0zlaYe4DppA9HCVBmvqD2pb/o3aPbj9ESvZPNh1jjjYD3P+T3lP7n8MBuv?=
 =?us-ascii?Q?OYXS5wXam6EyfYwBbsq7BbCxfAIV25PE9sb6S+/0nx8BxmUuMlz5+NbgnOrV?=
 =?us-ascii?Q?5dZ94V4XYXvG0FqXECLr7UDKJhJKoYgG1GtJ/X9PavqaGoToAZuBA5Rc9SuB?=
 =?us-ascii?Q?rSbI9Ww5/FQIODAtO1Q0vVNHvv91mrtxr1IU+sEnGPFh8M4r1rkC8nAXtIrx?=
 =?us-ascii?Q?7VBlGnjg/Ih8s5qe9tJAA23RwUD5VGClR9YYdXTdSdyKEGELwTEra+O3D3U3?=
 =?us-ascii?Q?cB5GNZfQydU3jRe9fW2MKChfAUdZ7t6NckJVSfCWyHv5Pd3Vi8wC5yMmoiD3?=
 =?us-ascii?Q?PBvIE3iW3yGGKxyg6ca7qOhtcMJtBICTszewH/dSbTdKQgRtcn5JnKWklhQi?=
 =?us-ascii?Q?o5Oier+zirt+kuWnO6tGOmEzKEoM0W2lDn2BvJjPnnz1XCljednB5S2vNe7t?=
 =?us-ascii?Q?QQ0aW6XTduOzZNuAZnGQqccir/APKjxreVI1css4rGTx4uSsbLz5C6CA+3fG?=
 =?us-ascii?Q?Wp6z7RAoBsz+bG9PJH0Vktnd2b3UZp3vNRK351rzOGDwon/RpNh5MvkTnWrW?=
 =?us-ascii?Q?tSrBmZ1o+xt1+xNWiGif7uqu3yqfHfHFcP30MS62z6HHiHUtyubTRBB2yDzS?=
 =?us-ascii?Q?x1y7HqnXWW4mvGxwd59uH6lN1TNiWVpwXRUbOoIMVG8JBa/xA+wawAm2DYYO?=
 =?us-ascii?Q?fszpSxXdY5miM14wejWMAXVisTirbeJFiimpQDRe1rf1ZyOSR9wtGa7TJfnv?=
 =?us-ascii?Q?QRZ5tT4AXgaWy7eDgVgg7n1oQBgezFM+8JbLHYVPqJKLoZyT1TUa8Rql9CpI?=
 =?us-ascii?Q?I6QdYQgWyqO44bQKmNT9FPtbciZ7YLF2tUub1Zpi4m9HamRTRFuD1kWjNZGx?=
 =?us-ascii?Q?4yHYVRT8QeFu5bdBF21FETNjpVf6HfkFJ3BODUshwfYmNZcqESFxF5yKZphT?=
 =?us-ascii?Q?0g27reNJREohi9laWE1dwJYEsTYh666BuOoj3bE5j+jUB9j1eZHR93tkCSYr?=
 =?us-ascii?Q?6SQJ2eCGN7/xwCn09CudJWspnzjLYNtYWo4w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Pvdnf3n2w9IQT/yGAbLh6R//kthUFZ58o43lbpxw+FSEerwq0doXQ1MEBWW?=
 =?us-ascii?Q?ut50iNlvGUUds0gqctraoimDQPExcD+RTVtggSkZ3BYGCScfsH/cKJYk87TX?=
 =?us-ascii?Q?9J9YuYx5g1OTgwYCTtGDjcM4xA+LHXupsA804cHhh4QD3h0g3ZuHCmg9swca?=
 =?us-ascii?Q?1L+TpSxvBXJIv2hOuBIDqOjxX+4CRjGxLETw2oyF5aHKP8rpGjF7fdZNTfr0?=
 =?us-ascii?Q?Fgx0vTWIkm/DSMDnGsyCDmbtCcJso6GkskFj3JpFQ+qapazjbPkJtyqyvU1Y?=
 =?us-ascii?Q?SJj0z7NpowQBzTCXeORFr233h9Tl0yj6MRxHUJy+yqeIQ+h085GKHmxjdlmg?=
 =?us-ascii?Q?OhtGljXg6rugSkduGF7EyfP5KVVnkbad+o5C/OgF24xNleo2diXrVGqWc5nh?=
 =?us-ascii?Q?YwuI7A3IgwRwFXQAcJm/IoQfE4WzP9Xh9Wr8EJI4BSb+9Kjo9H+7t34H54OP?=
 =?us-ascii?Q?0HWkpnzwj3MBlEYRiuIGeSU0AkcMBtvBkBQvPbxHKz9vsFdE0SXDWrjzB2gr?=
 =?us-ascii?Q?osIa9Ae8rWJTTBPSS/LH3BwOAIkDP50Mx4tAV/XPh3C3uOU3jPQuuw/+2pnp?=
 =?us-ascii?Q?RIiBAQzDWBcl3Ig0iqq0WS1VT3FMYs/NMwXTB1fcJRAFsB4ADIIpMIjEohlu?=
 =?us-ascii?Q?wMgrnf+x61khsQeYnwqxov3KTzZDn8riwdf20cO/dJm0lMANhrKIy8WAukbK?=
 =?us-ascii?Q?s0I8J+z5B7PGV6LMrPStk0jlkm8YkTdeNJorkygpB4SqN+feRKbiPdfifqnH?=
 =?us-ascii?Q?is03UPMydL5u5bbc4sK3NkWAqCHnysrGBUAAkg00v/pE3L/mZnwSUUSXxt4G?=
 =?us-ascii?Q?kUh6ZfIw2jPa4SH5AG5R/DVjS4Xtx69qyat0SXNyK+mwIZCnJZywDIMDXV9E?=
 =?us-ascii?Q?uxSYxs1n/rWmQrUxFoygiT2ZgOhO22O0DMtpuqOXbDph3jJcayZST4/Nn0Ko?=
 =?us-ascii?Q?l7fRmzAh+8Y/jn4yX826a4BSWQGPtUR4CBNQ2eczakRtRCGvOJ3eVBihkD58?=
 =?us-ascii?Q?UOAEaPbYqupjvQiaMVzanhQVn4AK9M4ylFhMXlmV4VJYlgcShGZrbkBqpRqp?=
 =?us-ascii?Q?GHCqklIeYGfpF5UUf064hom+AuEjk9rFBGS5RUewBFX/QnpzRZrBK9Hp3swV?=
 =?us-ascii?Q?xy34D9i9N3EpW7k5l3gtQY/d1IVp7NSOqOOuz609/Deq1cJhR9D82DGdU6ZB?=
 =?us-ascii?Q?kXOdhpQsfiPvorYrLE1bATLD6ypy0qxhtq6lYu10A7NvD0AAJI7h5P9x6GC/?=
 =?us-ascii?Q?d5iXl4LP7jucoijBFqFkkUQMMKSbJPM/p7GQtZK30Si05t8VRc1LxUlHBFnC?=
 =?us-ascii?Q?fiIsvwDhshb7Av38FL7zJVKaJ5LFZ/trmywhJ57F1qePHrfQ2lrpbjQnCqr0?=
 =?us-ascii?Q?Stycdy/mqFGxepRgNV98ygNQpV0jTsjXBXbGOBfk+MwYqSypHMF8+AO71DGS?=
 =?us-ascii?Q?5Oli8YsjSsu+AMOYTC8p4j+azqOM/UK8NbAIANQSUQiSTZVf4KhJoB8Td+1L?=
 =?us-ascii?Q?XQTZTndc/VPVXpiZDfKmAR6WafY9+Piqt/N5Pr3h0/I/vh9O4chFjM2cP5Fd?=
 =?us-ascii?Q?IjIyIvxyA6yyEAOlX9FobyidE6csKqukY8oPsrxm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b66cd0-4d4b-4fac-7bbb-08de1a848d8c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 02:56:15.3649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXVWUoDyoTVz/902YJ9MYoYI7FnAXqM/sngJrqLRO2wK9prC4Fj3ZikNKb2NmbRDi4RsKJUEXEuFq40Ichix/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10352

Hi Marc, Vincent, Vinod,

On Wed, Oct 01, 2025 at 09:22:31PM +0800, Peng Fan wrote:
>
>---
>Peng Fan (8):
>      dt-bindings: phy: ti,tcan104x-can: Document NXP TJA105X/1048
>      phy: phy-can-transceiver: Introduce can_transceiver_priv
>      phy: phy-can-transceiver: Add dual channel support for TJA1048
>      phy: phy-can-transceiver: Drop the gpio desc check
>      phy: phy-can-transceiver: Add support for TJA105{1,7}
>      arm64: dts: imx95-15x15-evk: Use phys to replace xceiver-supply
>      arm64: dts: imx8mp-evk: Use phys to replace xceiver-supply
>      arm64: dts: imx93-11x11-evk: Use phys to replace xceiver-supply

Would you please give a look on the driver changes?

Thanks,
Peng

