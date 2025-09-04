Return-Path: <linux-can+bounces-4483-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C176B43E93
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 16:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A773BB28A
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709DD2ECD23;
	Thu,  4 Sep 2025 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FNPEoSPv"
X-Original-To: linux-can@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574532EFD81;
	Thu,  4 Sep 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995780; cv=fail; b=LqiEVa6RUqKoyyVMQjTwBmF2fwAcGFq6/k+zVmRsTKOT2dnkBTcs64SRigW/bkfyczKHMg2dngXLSXCSmZYmyNBux+ioyotRoPOpjvuoqq+8a4U5yuMUuKQ14YUuSsj9kUIzvlEzyZcQ7t21qIFuZNtJqI23W1QIK5th+uguIiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995780; c=relaxed/simple;
	bh=/U8aAMdQEDH2ygbpJRe7K0D5iRiam/Qqzg158TkGm/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mNdkxa2UWYoQFicfJagWuU+EvibnFFRU8axJZXLBQqJQEHFQuWl+vUqnPtSqSF7Ze7sW0zKR/1Qb71ZLAKy3LJZyirNYWJmMgzWfbYyZrzMMWhr+KJQaR9nh5kC83hYTPv34XQ8homHwZ9R00lE72BIuGDEj72BR2cJUj9J2J5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FNPEoSPv; arc=fail smtp.client-ip=52.101.66.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxfjxJBgI7bFiCNYd1op3j9pQA7P6TYf/EGaZ9O7PbAYRZX/MazgoQ9Fj/WI6Fz3FJA20GYt+MBBswYspTiScnVwepYlZGyyBIf59BHs2Tishmb5l+EvZLaAW6XISNGbfUbCWEK8lZIfcXgHkaxO5RjQuvtf78MxkZtQIjaKdbbMflSkIchvRyKRayPgjrYmdPkYwLF6F0NzTufLojgX8VfU0swBdVaylWysQ4cJSVcxvFh7mutWLxOBUsSxoJYAZ1YAtMxrNk8jZbI3wgZj7nSbuM4stgGnfd6BS3TMGbkv//khRkM0lWDhNdO/VDY//CJOwbRb8BSxvR4JSfr3Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EbKBkFAuo1NteYzvE4dUEWB/YtLESQqvNvC0CaLi7s=;
 b=xHBuavPraio9eH6VbNw6bwFA4zTMiLfITfsQsbOi0lvKibP1xfneKwZ2dy63wBT5cbr6/es7urRTOZIUtUE+vIO93hfuVzUipbhshoWb00H1vIkoFUJmZEBYyTSeH1tB4tJnMzQqdr5WnivyobIGz4bpunaoaHG+y+8q+2sE64oV0IVh7iVML4oNFhIx0uEPIJPDI5sHzJqyCsJWQ1q/TK3lJmA3hgaWlOrl83nyh8yOJLbKKzjYXLZMP6eX0q77jFe6OALoXFm9lx0NLiSqn9CA+UQHZquelXmNfJBx1J3b7Xo9EE1B/YA8mBucdpmCnFjPGKnZJFoqi+qIXZz2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EbKBkFAuo1NteYzvE4dUEWB/YtLESQqvNvC0CaLi7s=;
 b=FNPEoSPvnQ5hYK/1Cm32F9Szxs1Oj4hxhLFhe64yUGlRZisGjxK/IwNXJos8duPj8x2U1lXdirpkEndhvS6M7O8SRVzrcGzseMp5u1AdXUKf/Ps/RuOIyvQ2ocI7ytLnqPdGUIyDD/8ZrArIhAM/+XEog5C5qEWOw04BHcoufIZdw28EXDInl+QYUx1IWW1YHpyUIt98BDi/ygooz02rSQ6cy9LooulPzTY1dSuGX4py4I/unAdzjsWRKLYpkDCfZ8ZQThbxf1KYWpl7r67tFBuJpEtqKBV2vCiN5Op7xY0ieRpGiWkcyw0VAQSmO5lD/K7fFKClBqKP3+xthVP7BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB8PR04MB7099.eurprd04.prod.outlook.com (2603:10a6:10:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 14:22:55 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 14:22:49 +0000
Date: Thu, 4 Sep 2025 10:22:43 -0400
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
Subject: Re: [PATCH v5 6/9] phy: phy-can-transceiver: Add support for
 TJA105{1,7}
Message-ID: <aLmgs6aAm/2Rj+Bo@lizhi-Precision-Tower-5810>
References: <20250904-can-v5-0-23d8129b5e5d@nxp.com>
 <20250904-can-v5-6-23d8129b5e5d@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-can-v5-6-23d8129b5e5d@nxp.com>
X-ClientProxiedBy: AM9P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::6) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB8PR04MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: d865bc08-e63b-4d2a-198b-08ddebbe8697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KDxxuXILH+QeDdad3jrc1NMuJlkM2FSELI9hnz9AJDehQZ7BCOdW+ZGXC0Cm?=
 =?us-ascii?Q?Eguz842bwTs8t6WDqOLzLAWwlMUCoBAs+M5PiWVTUaQPjI0nv4z7vnIvtuq7?=
 =?us-ascii?Q?GSFys8dCSUKJE3FkaR3oo3KcVhijQlCfuz3z1yFp409vM8CAxEVPzWFlxvNs?=
 =?us-ascii?Q?oYLY6iWlAZYu/RqrFped1kVJZ0p/mcgpoYZRoWknHyr0G7b3a1Ppl9HO1pBg?=
 =?us-ascii?Q?lHoRe/MLyWSbNmaDvIOOgu7ecP4OPdWhx3LElaBNhRrVyF0IF2VQRrli7lS9?=
 =?us-ascii?Q?HmOVp3sEMhg7J4CvXZS9ap8ObNAi97Bah7MaEBhm0f2HIA0BCqSveea/R3Yf?=
 =?us-ascii?Q?7baupnjuCUEm/4kDJE8tkWNrx1zfGA/SJC5r6BQb6s4ZzHae4+/5tQTzYu9e?=
 =?us-ascii?Q?pNYg8iQmmMAX0gmX8bG6QuIeVnIew9fKNoM7+tm8QmGGzzHP4gTz4RM3MzsU?=
 =?us-ascii?Q?6PswfrMTc3jR7L1BcJj0uW2FQpr5v7AAnmVFy5dhMzEG2WPxD+41dmWMG/JZ?=
 =?us-ascii?Q?M16RQ+EjFth2wwCcHhX5vDiFOBFtNROMvvWpWpMqKIO1RF2qepl1qRA+0kRA?=
 =?us-ascii?Q?/+0HSvZ9sO/6QAdU0RZzfyM2/I5C1ET3UlBZXxWHmeIKVU89nQTOp8CVMk+e?=
 =?us-ascii?Q?wOlQs5oK96x+upZI2tDOtFReYKtV4mh9Z7yMzl1Rlyq/SnKrKVdszpBOVqiE?=
 =?us-ascii?Q?IWjWoC6ZfbvP2p5gI7Ed80lCsRmCwd18q2RdG4GUFl+rd/mausZaceYc4anJ?=
 =?us-ascii?Q?GXLI5GRXVtprTVtbk0nIASvOUG/wc7vQKBoegrxZF0kpm2jVOuj5uK/dQKKa?=
 =?us-ascii?Q?Yq75o9Fd5Jc83U2YhWwkr6l5P8Zj3nheAyaUQ4p0PL4w7yPtriJ+bfbSiB+R?=
 =?us-ascii?Q?5kmQj+zdipEbh2HKxsB3K2hiTTMHU5LTnmW4e96fk0WtJc26dXRm3htHCKWo?=
 =?us-ascii?Q?DaR8zzWVtGLbrjKdAY1TYVsYVp2G0Glbp+TD01RWd7ZYqtkoft/uFoZX1LSl?=
 =?us-ascii?Q?gY0PB0dq0YIOuVvnS+n3qRX4hiVW9VTeszO4cTwXi7SAX3Ue4oCFDBvVCwnD?=
 =?us-ascii?Q?T6vdZTc4H9rKb/Skjuoe52MU4kprkw1Xr+ndSE6K2TB77UR7aHk7Xgmd3RJa?=
 =?us-ascii?Q?3mKsdKuKrnpywlfr1Vd2/45kRNPBlLK2ZCDoKMpt3XTtUV/YMmm5Rvk/o/Xv?=
 =?us-ascii?Q?uYBiHZow/W4uLI6v4aoDkmJHQmz65nLOheWS+XIFr8JF5HqXqGit9u18vDMm?=
 =?us-ascii?Q?Pc2yE3AG4He7SDh+Wgr9/DdEhFI6wIBhVkWt4RUcJs6Ckyj9pUE9fEzlXOX/?=
 =?us-ascii?Q?tKunnxzYbXqZmNKymtr7cDgriwIfU5s5Gzbztrugu9bXyZW48KvVo3uKIF8H?=
 =?us-ascii?Q?8zNc6yvGbLGlaPBVA9ezPffrqPQqcpAlcNdGWSUcgNJ3xmDUV+Q3wRB7/Xda?=
 =?us-ascii?Q?KhgT04/XOG18A38sn7N0CDFNiqOC5KxVWz0Ge4FnWLdA9ARQ1xHGkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qaLD+qAblRBh6bsGH3MaAMMjOn/GaUx2ISbhVe0NWr8VC8CYBr826WqaLSEF?=
 =?us-ascii?Q?D3xS6NVakDA2Rd89LyDjFqN5TEBAhZDxsicq/emGNUN/9UCO9f5DCx/metAY?=
 =?us-ascii?Q?w7sJZwiJSgGzs/ilPygZjV78go1FLo2wGrDoAcKbUipdrdNo5bni8DUI+qZe?=
 =?us-ascii?Q?eOzhNTZPCO3LeY16QsG2gTKxKZYwTd8JEocVIsTD+NFN9HpaD9KcOYuCc5fM?=
 =?us-ascii?Q?YTozEu3dLdEnUdbYl6fHyt1A7Thjfew8Ga7YZSZkjt9q+MGqlDuvc+9WhX20?=
 =?us-ascii?Q?w56/+1ATcZuLgRQKAS0anlZMBuumkig9+9FZ8VgD/KiEd8MUYA+8FJCIyF6H?=
 =?us-ascii?Q?cwbZgjLlyBRMrO2m3wrnjnyI8FQou5R5Sk+06JX4k0hCXbP2LlSnvP5DpH68?=
 =?us-ascii?Q?ndedJlD7ctyQJmoilfLUQ7prg/cfeDh1+4lueuXOmQs3k6yHFDcTQoLYCgWp?=
 =?us-ascii?Q?tO9xg5hZWSPKKI1jWtaQtve9L+a51RkkSNrpusxrJXBoWxDgqCa6qNZDRIfq?=
 =?us-ascii?Q?5XEYeZZO66WST9sjB12aAa/D1T0NOyHbk4kzBUZiaUIco6hP96mlgE0l38G1?=
 =?us-ascii?Q?rls21nIzHN757JVDxlrsspfSz7RrGziYbC/Oljr3/3DQ+HKb3+MZ7mkX5IYU?=
 =?us-ascii?Q?e16AMhn7C3dEZnadgGsaj3+M5U0+faMab8NXzsQ8libaOTp2Z2FPMDyeCjKc?=
 =?us-ascii?Q?1LobEccBy20/whJV3HglnsQ97R/I7B0xajCpD1fPILh4+axoXJmmgpwRKVra?=
 =?us-ascii?Q?jllW1h2fnfgjKosEgpi7sF5AQAGTLiGiTWlfgNYkx0MV5Ua4yqKxn0npp12p?=
 =?us-ascii?Q?GFqrzWBJul3t4etmOHaD/gzrHUQ231NPc+p5g7rMwDbYHSAXl7fWEoscEp+l?=
 =?us-ascii?Q?o+mkoOj45zoJ7LJNyhhlVAqlub+do3XwfzNw/nztsHhdRWZufD/u963P6SYQ?=
 =?us-ascii?Q?snQ+p/XYmnEM9lBLDRyAAzyHICoObvriuwKIDHLr0k8qujZb1y+VYXXZ9uEF?=
 =?us-ascii?Q?I3bxMZIkHJu+c68l7yev1YGNlvivtv9xLlZLvkKNl+lphcp48mt3T530knFb?=
 =?us-ascii?Q?fZTWXGpD2d8Pt9YVOPSaf3ciO6Skajgx3YsEDb22I4UDksmCxrDwNJzQo99E?=
 =?us-ascii?Q?FP/NfBoe/t9xvmUOEpu5M4Ss1kElpvW0S44cx765k6WhTa2W0CaHGVBvtQIY?=
 =?us-ascii?Q?DzSypOslmwPyEz7mlVwFQ2uQF3hataj7MrWHlSLSxODb9amm7rMt5Aaotby2?=
 =?us-ascii?Q?R1/7B0VlA32QYIMJhzs9VUbsZDqtXM6m5slKAWYuhrel8dlHXJq0ruJQU/VW?=
 =?us-ascii?Q?BuGipOrmVPafKyDinwOCEiiiQeKIx7gT7KWavX6qXLFmXColhz0rPq4qEUwq?=
 =?us-ascii?Q?KDV17IgHymHBY0CbQg/k0O1iz6/Srv7Xggzc0RNkZmD1rX0mY9zmyBpDE5zU?=
 =?us-ascii?Q?B05yciMAXZxRUYn/obEWzDbRxfyPpa8H9MRTW58+QnBpNzGbsokjfHZ7LXdT?=
 =?us-ascii?Q?iI/hXCXV2VrbWa2Z17SvOR6m+YQ5FyIvlAU0qIhYJTNVxShy245jIxgC865M?=
 =?us-ascii?Q?R7PVECli5OO6fXWyFiODUHdGlChPE3dSQO8Hih3c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d865bc08-e63b-4d2a-198b-08ddebbe8697
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:22:49.3855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gc/nh6HSwZuZPIvJQMFaw0puU1p/mmn6bnaMoqXc1KDdrzVorzRR7sGs6mQ9IF/tcMTeTDaTP5W1MVM7JZbdwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7099

On Thu, Sep 04, 2025 at 04:36:49PM +0800, Peng Fan wrote:
> Support TJA105{1,7} which are a single channel high-speed CAN transceiver
> with silent mode supported.
>
> phy mode is not implemented as of now. silent settings are kept in
> phy_power_on and phy_power_off. After phy mode is supported, the silent
> settings could be moved to phy_set_mode.

nit: function need "()". phy_power_on()

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/phy/phy-can-transceiver.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> index ccb29e1dfe0d07005b4bcd8fefa2787292d921a0..d9fd3564970695d5460ffdc4e8636dd7638d64a2 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -18,10 +18,12 @@ struct can_transceiver_data {
>  #define CAN_TRANSCEIVER_STB_PRESENT	BIT(0)
>  #define CAN_TRANSCEIVER_EN_PRESENT	BIT(1)
>  #define CAN_TRANSCEIVER_DUAL_CH		BIT(2)
> +#define CAN_TRANSCEIVER_SILENT_PRESENT	BIT(3)
>  };
>
>  struct can_transceiver_phy {
>  	struct phy *generic_phy;
> +	struct gpio_desc *silent_gpio;
>  	struct gpio_desc *standby_gpio;
>  	struct gpio_desc *enable_gpio;
>  	struct can_transceiver_priv *priv;
> @@ -47,6 +49,10 @@ static int can_transceiver_phy_power_on(struct phy *phy)
>  		}
>  	}
>
> +	ret = gpiod_set_value_cansleep(can_transceiver_phy->silent_gpio, 0);
> +	if (ret)
> +		return ret;
> +
>  	ret = gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
>  	if (ret)
>  		return ret;
> @@ -60,6 +66,10 @@ static int can_transceiver_phy_power_off(struct phy *phy)
>  	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
>  	int ret;
>
> +	ret = gpiod_set_value_cansleep(can_transceiver_phy->silent_gpio, 1);
> +	if (ret)
> +		return ret;
> +
>  	ret = gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
>  	if (ret)
>  		return ret;
> @@ -92,6 +102,14 @@ static const struct can_transceiver_data tja1048_drvdata = {
>  	.flags = CAN_TRANSCEIVER_STB_PRESENT | CAN_TRANSCEIVER_DUAL_CH,
>  };
>
> +static const struct can_transceiver_data tja1051_drvdata = {
> +	.flags = CAN_TRANSCEIVER_SILENT_PRESENT | CAN_TRANSCEIVER_EN_PRESENT,
> +};
> +
> +static const struct can_transceiver_data tja1057_drvdata = {
> +	.flags = CAN_TRANSCEIVER_SILENT_PRESENT,
> +};
> +
>  static const struct of_device_id can_transceiver_phy_ids[] = {
>  	{
>  		.compatible = "ti,tcan1042",
> @@ -105,6 +123,14 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
>  		.compatible = "nxp,tja1048",
>  		.data = &tja1048_drvdata
>  	},
> +	{
> +		.compatible = "nxp,tja1051",
> +		.data = &tja1051_drvdata
> +	},
> +	{
> +		.compatible = "nxp,tja1057",
> +		.data = &tja1057_drvdata
> +	},
>  	{
>  		.compatible = "nxp,tjr1443",
>  		.data = &tcan1043_drvdata
> @@ -150,6 +176,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>  	const struct can_transceiver_data *drvdata;
>  	const struct of_device_id *match;
>  	struct phy *phy;
> +	struct gpio_desc *silent_gpio;
>  	struct gpio_desc *standby_gpio;
>  	struct gpio_desc *enable_gpio;
>  	struct mux_state *mux_state;
> @@ -213,6 +240,14 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>  			priv->can_transceiver_phy[i].enable_gpio = enable_gpio;
>  		}
>
> +		if (drvdata->flags & CAN_TRANSCEIVER_SILENT_PRESENT) {
> +			silent_gpio = devm_gpiod_get_index_optional(dev, "silent", i,
> +								    GPIOD_OUT_LOW);
> +			if (IS_ERR(silent_gpio))
> +				return PTR_ERR(silent_gpio);
> +			priv->can_transceiver_phy[i].silent_gpio = silent_gpio;
> +		}
> +
>  		phy_set_drvdata(priv->can_transceiver_phy[i].generic_phy,
>  				&priv->can_transceiver_phy[i]);
>  	}
>
> --
> 2.37.1
>

