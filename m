Return-Path: <linux-can+bounces-1455-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C829723D0
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 22:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70F6284872
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 20:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE3418A937;
	Mon,  9 Sep 2024 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CMLsXmZi"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96618A931;
	Mon,  9 Sep 2024 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914305; cv=fail; b=kmhpESCUIUWoVg3rEzSdY6J7oeMObIJWzMq27MlInW8tHI/E65DQXkzE8fwJ4gy7MWDerMiDcjoTOE8wLpl3bORKnxHh3ljd5mum0NQcHb1NgGuEGo9m5X2BmKc11ULw44gso71Zf5g0H9EW/sdsNEmOs6W5pelSVmCcKGEwLu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914305; c=relaxed/simple;
	bh=Qfac5kU2GDRBgClF5EhkseIVrxs/JAfkl2Sn0YrSjXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L8+A5ekcIpT0sm29UlwAEi1n53lYShFgolf82LjB7alQtezVipC8z6P/jhfnJCA7TVlPVkqBv4QmyZ4iK7WeBzumyQEgwTSU5g9U1Gr9DnxTVuhS8QFUefSUxSZQi8d6rNuJ6p4Fnlsk8HImTaM49Ga57ku6eyeJDmNYO6zsw3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CMLsXmZi; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUCEas0dAR8XU4GzcBX8AigIkbaL/9FC8MvDM3BJVQhX93Zl/1IGtYUma0Lt00jGQMonIwsrN0JlGTNiTl+5xtjLFRO7Mj7PaeCjmn8sP1D3MZyZkc5X+mXQng+qMU6Rn7adXF4e9Gotll/xMb2YQlMjXuJOAOX7ab2sSw5QJe8IxXgLkqvG0TGsIEnW0NcUESpjhL/yV5a0C95MbZxd0bi59c47aXI1bGYau9bJg4aVIxsvnF1uEW4eDwFpEHf9r0QWw0Lshutvp9yjosKfH8sEZuAiNnAffJAMBrK6ZHcZVYaEUTkwZmuwfTFEzS0NfiymvMg5FpNCBWZBIBrVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcHsRXL2N8yDOwSplGftL7QZNCPTRYorlve6buR+ovM=;
 b=CXfdKs8mP5CQ8fu2PzeWAjNId0//0fpVz5SwQwZ2lM3e2ptRlIt425w1/U5fdlGkZvXmsFERRvB07XeqWHnWdazo0Z/6Ao6jBvHoHQOo4Pn1oI5Upsr7a4HX4CUwPbmgx/x25eGXmSxUKuAnh0zC6gdyv3aYJCPj5+su1FBaeP09NQ0OefhtoalCmQszVjnuECftw17fyxRmxyrt2p3Xv6N8qjoVYR7UEOEPm5T/nKKAY5iX8uNidUB/twEwXrCDjeNOXKCmrMwGA+POwKM8PdNu7sDUpUDxk4+zqOcMY4iucdpTyboUt3uNJjuzfA3XkWbbhk57NRzVkEzylEeUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcHsRXL2N8yDOwSplGftL7QZNCPTRYorlve6buR+ovM=;
 b=CMLsXmZimP7Om/oyzjgPTT4XqSTPfwG9vws1HMxmRVT4FxkVAPjwbQCAYfzcVuscwVmVEnzBf8uGq6UWzZIXXop5jm8fVfsvZZA70sF2pBjPB9C5/pTMuuHuRE/ktTUd167x5ULl4gxdryPBe8Rbd9wc3NHkBIhTD1BZAQTfq+IJJHCoXR9hfsc3EvPjsjFnAO1ImINV+jEYoDUnsbght5nsHfQZDvPu+GMyQWLQBEqhr4Zm3lDgUmgvqcru3DshKyIb3f/GW8IBpWy+5xelXd4QpL1KMAtL3ZGhis2t2EsOaquRtfugQu7/atnxXrKHE1uWlh24W+flbTUlUqDrNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7943.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 20:38:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 20:38:18 +0000
Date: Mon, 9 Sep 2024 16:38:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: can: convert microchip,mcp251x.txt
 to yaml
Message-ID: <Zt9csuQwWomPqlqc@lizhi-Precision-Tower-5810>
References: <20240814164407.4022211-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814164407.4022211-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:334::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 862909df-656c-4551-cc20-08dcd10f569c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZIzKZhfWSGz3VosANPqPxJ0DiFuA/+GSIVlXUU4AxeA0i8uMKio8x+SXeE4U?=
 =?us-ascii?Q?hkbb7E3X/bXfarC+4i7U/OYR6WLcgyhoKeJ6a1lOodiIRY/TGN/Vn51wRpG6?=
 =?us-ascii?Q?2OHIYUhFelonBqwM6EpHanjiJhpsFbfyWy4wTA2rQmQvn/vRvmaNtcBt0Gmh?=
 =?us-ascii?Q?zDzhBueRgBY34S+EMCrFQcJT2nvB+YqJKXQek2Yy646WAIUzJnwOpevweqow?=
 =?us-ascii?Q?zXGWdL39yxj/PPU5zi9+eq7c/53J6OTcBVP3flMc65asIDCWIyUwHTLN4GXj?=
 =?us-ascii?Q?3GJKBz8ZEoWVt9MSudul/0xAGG3CwYRO8Jq8l0XPTAnwxH06vHx1nhHtZbZj?=
 =?us-ascii?Q?5cn5CxDxg7Gh2VtauWxHqOVgAXvVcWjtHcY9b6Bt32IXyvHXtfWXpYt7lynD?=
 =?us-ascii?Q?ljQKxI68zY4ZHQa9HX98cvlghYmR3xlQMbocGuy/tRVRZfW6OZYAGvcSClp9?=
 =?us-ascii?Q?PWxpyoQi6z40PMILanNtRnKYU5akIHqyRBUUJ29RcfPDQcuJvG2MzA3GROFt?=
 =?us-ascii?Q?Lzv5Pbp4uvH8+uu/YqOztxLOh8L90KecgLzVLvolanPxT9KTyhPULZd7QdLn?=
 =?us-ascii?Q?CiVMda5DDEdRQITJz69mXFmUIvxthUf1N2u/QVse/jyqN+nUPmrmOoCykvLx?=
 =?us-ascii?Q?65rrlzM0vuDyHMDJ4xXpVX1aP7/BPdSNEejyqkATRwYsX73ICifeOLUV6rtY?=
 =?us-ascii?Q?PMRWYRa0NB6mfeLlj5fI47z5OUA1BKZDk0ZS5hK4KuJi/jXef1wS8xSQMg0h?=
 =?us-ascii?Q?nzfiqZwnddQa/4T+3wUhsa8n41g3nYM/R2eLMW96shQ429w2EvyACVvniW1m?=
 =?us-ascii?Q?Gt7j9RYHQwKo2aiQ+dyhLAVLo+fvqqoLFDaWgucbg5Siaqyy48NXTYGQRWsk?=
 =?us-ascii?Q?Cqkl3Gsudr1fys1dVPH7MT7g4gxR+i8Vn9b9jisRR36ftdfPOsoFk7tCv7nJ?=
 =?us-ascii?Q?COd7KQxg10USZf73zTlfT4tDfHekogVgVUxLR/4EFmHxt6SO9hBZGjQWf4L7?=
 =?us-ascii?Q?z80dCSRIxZGRtKiwl5A58aVWc1oVI3hexgOZhkh0V1LyeZ4b3MRPLJjpYAHg?=
 =?us-ascii?Q?wFWRipHrV0TnV1waAthsGrnQmKsvR/jW82eDwT0HBC0qGk8SRyK8MDpzzXXL?=
 =?us-ascii?Q?XqtxzZn4dzvlgYBE6cgCFM4DIM80/Qoi8Ec45feFA+Ea2WEm08gwKy4LlFC0?=
 =?us-ascii?Q?Eec3QAxWH2Dhg0TKhgH0kD4LDqh7M5u5eW4EuuuqMxvT1Q5KjuyLsvYweUww?=
 =?us-ascii?Q?SgyvyvKI6A+jMrUOB5lKUb/HSncl10paaETCFhE9R9EYH8Ys3Z7rrcR32pk4?=
 =?us-ascii?Q?M4/Pumz8mCUFvrgVXVDOrbb1BkvcGGg1sF+rmAqjNu1N0BrAkWOnu1wbr47q?=
 =?us-ascii?Q?xlKAEEo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EMYsCEQv/zIyEZZ4XyPtSsbNYe3681rKCD8egbz3LuAXo1382iR/WHsF6nNn?=
 =?us-ascii?Q?hyXfcu5sVLCxznYNgMA0prEnsdGzFRjNAr1SMRl9DbesKjFqd5290BbopSJz?=
 =?us-ascii?Q?93Xv/xeu4FfuN+q2he1ltcNvivlWhCkWUqthWUCOJXuLNVa81Otk6fA8alyW?=
 =?us-ascii?Q?3O0LMSrUgkOTG04pm2pb+qwEnciee8507OqWdbmXqHg2oUU+v7pyavffKJlN?=
 =?us-ascii?Q?cKnO25D2q67i5mPUSnvp+VFT70yoVr2Qm4hWv9DFX3Reuw75HtyFxgatk1W/?=
 =?us-ascii?Q?QQQ+cpfJjzsnYJ9coxv+rBtfgJBh97q+I7D+9V7RPwb436YMKBudsG1T/22b?=
 =?us-ascii?Q?EdYJUIQmCYBh0VZxJY+hgriKqIEpnzAU9OhYoO7XOJpTrrDw20c+DEN5iRcQ?=
 =?us-ascii?Q?WfmO7dEab/IJwahTeFL/17tnTUBjTU8AtoBL4tN0zMxE5Ar12A570z2UPU/Q?=
 =?us-ascii?Q?ESzWoHWhJhIXmBPNgjO7Nfnkk5MXjDfGJ+tqsgHrr2b6xjFsV5Lb3h2nzX0r?=
 =?us-ascii?Q?klsHMQlYo8GnDfAK/v5YgZELNPWeapqXnzpCNbm2FCYMN7lszit8IXh5DLnp?=
 =?us-ascii?Q?GYCcBdn/XPKkJCrUK2w8pIbR/LzOO+d41hQqFdCvm+f7MSaKgNdvd/xcXoxx?=
 =?us-ascii?Q?DTZPhli5diq2W4KJhf1useTn+Z7H5jBwd1RaNh78T5J+e5myZecFuwhm7UN4?=
 =?us-ascii?Q?FxYaYnIUiIRjiU2wmpTHXbYBYeVxHH+WvU64aZI1j4/68VwHyTaVdE9ntfUN?=
 =?us-ascii?Q?jJnS9AxgwmgcORe3dSW5SPQMWoZSy8bcRRyk6Q7NEMOogZhE5ljX+qE63WqH?=
 =?us-ascii?Q?Xy+SBTAqBmE22ifC68nK2va91RsgS+t2/2QgNoLn4dtfi5otQb0nKi4W5k5m?=
 =?us-ascii?Q?rtHiHpR++7ZQ342wkDrkbb7mQoJ1ubAu9DBhkWkGFzaooeOKQMFp1Cn5dAPj?=
 =?us-ascii?Q?gZoswsvI4APMvS3cLQXRobMU4qdB2MMGODjGUifGkStFXWs3+zmLQpOAoLho?=
 =?us-ascii?Q?HvXr+AVGzCVGYCWWfpyk4rPhL5b1Rs47oFpiDZezTMhN5NNp1H0H7ACC483V?=
 =?us-ascii?Q?5auY2IXHJ+yGZCHmfDfCHPQOTkIFAWpR9ucJz+wru9woLkTSAi2AAdFluTOi?=
 =?us-ascii?Q?7UahRydn76FMBE9M84B0cNpvGG6JqbXJESbhRz6FiKe6Rfx6CgcGvo1l0pBO?=
 =?us-ascii?Q?9z9et/JhT8Nz9lSAXzKn4tcsz8mkKMvyd3okutfgELNbSV6Ax9/IYqA6179V?=
 =?us-ascii?Q?Kr3/O+d0GKC5mi+dBJ7vZjjcDxJH15UQWYsEbu3CWc/yJp1mwAfMOQm12cwy?=
 =?us-ascii?Q?HJ7qjR7q8JdLkiz9I9V4UNYenu4npaBBGXmkqLBy4iOuNyl1mI9NFWxnd6A9?=
 =?us-ascii?Q?sR2WEE7KkU3mSIMsQTdqFkNfqHH43E4ZS3iRltz90RpEcMGEEGtJsbMj1nGP?=
 =?us-ascii?Q?rO/NFRGCOgaiOhl13GAAF2bxsZqbb7alG1TZAZvf3yDLcipmBYOxbwQJ4hyK?=
 =?us-ascii?Q?AeoWhQhIL+5fKob/EKzRhLVphpXWUYvKf2wucEuNbuKiMxrm0FBlTgEMLPBj?=
 =?us-ascii?Q?piIF1nCW39D4LQmWrGM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862909df-656c-4551-cc20-08dcd10f569c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:38:18.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVdvTrNf/BuCAg2QEmwyGftPGqz/70EDYUdE2LolffZgj9041o11t3CK7Za+DRoFpBmTo4F7DKsf/86cTlI0qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7943

On Wed, Aug 14, 2024 at 12:44:06PM -0400, Frank Li wrote:
> Convert binding doc microchip,mcp251x.txt to yaml.
> Additional change:
> - add ref to spi-peripheral-props.yaml
>
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: /bus@5a000000/spi@5a020000/can@0:
> 	failed to match any schema with compatible: ['microchip,mcp2515']
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Marc:

Ping. Conor Dooley already acked it.

Frank

> change from v1 to v2
> - Change maintainer to can's maintainer
> - remove label 'can0' in example
> - file name use microchip,mcp2510.yaml
> ---
>  .../bindings/net/can/microchip,mcp2510.yaml   | 70 +++++++++++++++++++
>  .../bindings/net/can/microchip,mcp251x.txt    | 30 --------
>  2 files changed, 70 insertions(+), 30 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
>
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
> new file mode 100644
> index 0000000000000..db446dde68420
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/can/microchip,mcp2510.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP251X stand-alone CAN controller
> +
> +maintainers:
> +  - Marc Kleine-Budde <mkl@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp2510
> +      - microchip,mcp2515
> +      - microchip,mcp25625
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that powers the CAN controller.
> +
> +  xceiver-supply:
> +    description: Regulator that powers the CAN transceiver.
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        can@1 {
> +             compatible = "microchip,mcp2515";
> +             reg = <1>;
> +             clocks = <&clk24m>;
> +             interrupt-parent = <&gpio4>;
> +             interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
> +             vdd-supply = <&reg5v0>;
> +             xceiver-supply = <&reg5v0>;
> +             gpio-controller;
> +             #gpio-cells = <2>;
> +        };
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
> deleted file mode 100644
> index 381f8fb3e865a..0000000000000
> --- a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -* Microchip MCP251X stand-alone CAN controller device tree bindings
> -
> -Required properties:
> - - compatible: Should be one of the following:
> -   - "microchip,mcp2510" for MCP2510.
> -   - "microchip,mcp2515" for MCP2515.
> -   - "microchip,mcp25625" for MCP25625.
> - - reg: SPI chip select.
> - - clocks: The clock feeding the CAN controller.
> - - interrupts: Should contain IRQ line for the CAN controller.
> -
> -Optional properties:
> - - vdd-supply: Regulator that powers the CAN controller.
> - - xceiver-supply: Regulator that powers the CAN transceiver.
> - - gpio-controller: Indicates this device is a GPIO controller.
> - - #gpio-cells: Should be two. The first cell is the pin number and
> -                the second cell is used to specify the gpio polarity.
> -
> -Example:
> -	can0: can@1 {
> -		compatible = "microchip,mcp2515";
> -		reg = <1>;
> -		clocks = <&clk24m>;
> -		interrupt-parent = <&gpio4>;
> -		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
> -		vdd-supply = <&reg5v0>;
> -		xceiver-supply = <&reg5v0>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -	};
> --
> 2.34.1
>

