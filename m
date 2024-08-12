Return-Path: <linux-can+bounces-1190-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E38194F8D4
	for <lists+linux-can@lfdr.de>; Mon, 12 Aug 2024 23:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2FF281A15
	for <lists+linux-can@lfdr.de>; Mon, 12 Aug 2024 21:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A350E198A05;
	Mon, 12 Aug 2024 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LE02oWTk"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39062194C62;
	Mon, 12 Aug 2024 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723497408; cv=fail; b=H5ar2RZhq0o6yC2c9vbL1hjKAtEXqqXjTUlDAQJc+xndLWQtGf7W4HK0sNEom9gJefIorNZ/CHTRHxnEWxrG/PYoSk6GQfw2nYQsVD61Js25JMh4adOlomEgYx442deEEs94ACuZcUInnMnSFlQPbnSd9uY84IO8zd5WN8+rTO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723497408; c=relaxed/simple;
	bh=p1y7BPCWBUF/jtBog1a3jSXLv1oFNXo5kQ952iU56nA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TCHXyC+1kTdLJ/5th41OyguEztxdNqJyhioXI5o1Hzc2w6nzKWxWX+f3Q5yPoQ/kDWn7OFbm2+FTeSsya9d7YkT5JxXfK/OVMMuUsBV3YQzJVWY2zikbnhasNMi/PszWK8c/15JekB/2xRaPWJz1/OtMaP0JaJEE0e8Y6cqf2ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LE02oWTk; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfqCkJOitrOOmKHXucNhUn5PCw7q/4eONcWXOKMk/3Abta/1WzLompyGB8o+vkV9L7oT4b2gH/L9/YPQ+2D4NL+Itj5tmnxNcLIIBqIjEkW/D4VB0I4DO0gVBSpnLEDtSsekAW2R4B+IRFVPMp01otVHb1pPpN+laZt6fXqDZOsUNPzclCNyzRI7Vg4sSeo7v6LrTyJsrOr+fUVFZtzKRWHQtiASwXsyndP3yJ5aUTk3iJCpUj0sxQi6d2wKFOAcJ4qUoB3joG6pRFFo11WjMqM5m1IFZ8NyS1GVkyCM71sKQ+JCpNGwEdP2XXHbAlnu4xhpFk52d2svu1yfr50ZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Yve8N8AzjLHNdR5CIWMDqdHbNKyZPk/TPEATrZdq6A=;
 b=nL83unP2lqreoDddIizWZuGziOaGrGbCYNvDv4hpKnNQAzVTcdNc6lvDHXX29G1psilEcnNJmYCyKfN++taoPp5PmKwLJnEKgcTPplzWC9C/tpcdGPnvo/6/7sLYjE/kvLAkStfq9MNYU6AptzJlPquJ3uX5r3dS+G8kF/iDl5eTrdQ8v3hXq7dENWunT5Zh3bLeek4E+B2U7FRG8RcknCoRsKKc2wzcwqlcK+Xwc7pZVByYpABgZ+pYycTQqrZbFgi9uG8nUQbd7Wzbh34ouGmxhOgX6gqDRMKPzaPvrCYDp9PZswEN4aEkJzZyacwGZaccPe6V5I1wEzltK9c8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Yve8N8AzjLHNdR5CIWMDqdHbNKyZPk/TPEATrZdq6A=;
 b=LE02oWTkfEuosw/4ZKwfhd3O+ZLMHCYIgaXG7GBjON0s11KuiGrZJDAkrg6Sev3wAbS/fPt5Vl+Fp7UPKo48Ku5HbCOJbi0X5XkD5OC1TxbVOHoS/XcjNAi8u/h5iHjGViQDzvvLUk09SsmJ3rbo3qO5B8Z+SoaHan/j7vY4QLf/7A2K6OZ4TD0ZifRY2JyHAwhtitxXSKEDnvfShgP+PvnjwXIDHz3UhLgMVNWK88JQK3on6u8Urdl1xsWXTiG0S3mYsHj65pby1tHM9150VaP6oDEnzvsAI/t3IgRzR5+VjYMhbcVjJiQgJBJszaj/GXjF6tRk9mH+gEjf2l1aDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8357.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Mon, 12 Aug
 2024 21:16:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 21:16:43 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-can@vger.kernel.org (open list:CAN NETWORK DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: can: convert microchip,mcp251x.txt to yaml
Date: Mon, 12 Aug 2024 17:16:24 -0400
Message-Id: <20240812211625.3835600-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c04e127-caca-4387-c21d-08dcbb14107d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rXVoYg0BdLw/PPm4zolWFiZeikPhd+ILXmEjF89zbl0ahoWu9eRdrrS5047C?=
 =?us-ascii?Q?J5aCdroIyKRg2ndWX1QPSyQQEfxtuA/TOfUyeb1P2ImktnNzUQhBD/4QxGgn?=
 =?us-ascii?Q?81kLINZe8hL5DGFMkd9nvyTEKcQi9Lq4fxyOucMyYkzTXfsjDVKdoEC0R3Bq?=
 =?us-ascii?Q?UJxHeG5ZY815ELX5AJh0e9FSzdpUAPNosTrcg4qlHI6UrdD5KCTgf3nZRLcp?=
 =?us-ascii?Q?vuZ7Iz4sQRTvGYTZa2mAR1rNs7wx0gkAqkVlvSfngKxA/2urpQcImt/zlfyE?=
 =?us-ascii?Q?s5bj1+os0JcGkZrNDMqEYutWW75tM90JxVDPUpPWmAYkQfKPP+CA0JJGzFTr?=
 =?us-ascii?Q?8VwuSg1apHeIefF9+3OsoBpju6mSbOymKJB/x+kXTxCyKLSnZFyT3ri51DHc?=
 =?us-ascii?Q?ppMy2IDITqVYtYIhggp3x9TC677fbz+8u1SKeOVKvFT+7TsCq306vp8I8+9h?=
 =?us-ascii?Q?HCY/wYPCF/LUts+aYNcLWVzSiSKAbYiS0IHQBNJnFsmlUuYbxJ9qJROjTIZq?=
 =?us-ascii?Q?g8flzjyuPtJfDrFoHWFyEZTMPmfjYLhok31eiD0ae9uH6pieAujABB7UVmOu?=
 =?us-ascii?Q?c5X6pJ6kkq0apXGAD+2a0m4csKlOahH6XAG1z4NViSCeSgMA2DBaelAznL6S?=
 =?us-ascii?Q?TaKgy9xSBNyCZJa9s7yAWyCXUmX8DV6JeuxrQZvmHya6YoPFyTJZMUQUaQKG?=
 =?us-ascii?Q?sGtK14BOLQJ4WvM48WPxUFidrhO2oA1jfZ5zgQ4InoQjhNSUk1tTyBEDItW1?=
 =?us-ascii?Q?/YxbiCTFH8pSQeoJ23njqxNxOaENKFLvmvq4ePtjcSlqfsl+vAqxVvTG8DlW?=
 =?us-ascii?Q?cHM7khFvslVBKZB8cBXUztkAHKhhMjI1XHmc90AsTKrX3Usag7lV2xMR21tB?=
 =?us-ascii?Q?f39lIScVUgWO+voShGUjJNMRObKdqgZRYVg7RcBuqENN2F8n9wPnRSETQ27M?=
 =?us-ascii?Q?2iH4uw9ylYgoum0E5bbcAB9GGff4VnwNuwuweAE1cBj6SO3qIScYi/hdQgl2?=
 =?us-ascii?Q?eAEgdtP1Iq9C+nRs1EJ89Lxupkscf+gYhP2cHhnhn9oL25VqC2MFqWsR+17o?=
 =?us-ascii?Q?uq/d+ZDzGwDNFToz6bulnLJ84QLZSGtYCVZbIkiyz0QbSwJTFFqOiMW9Oejo?=
 =?us-ascii?Q?dRJ9dh3dvcc6aiCPPivhz4anOYQjczJwZPQ3ktMkvXGAaI4YRbG/jwvU5bTF?=
 =?us-ascii?Q?VfFkD0Uce5VRxo2XTKhZ4e6F1q0SluqgUIJGNQdXDjzxyekjXMrqowrrVAAl?=
 =?us-ascii?Q?z31IzhDhGUy6WvtVYBksJPWic/+rvc0oUHiHs/1qbAIzjNKTiE+pixGu+YuO?=
 =?us-ascii?Q?ozLRgbbYFjT0Xga4jCAdl+k6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GgYW5WdXG0wap1JhAKWtUylUqWXmtJZf9Z0PoMMXdZMDBlXoN70Dur2YGY9p?=
 =?us-ascii?Q?Aw5/dcdjJB/AIxyd5AyiEOAAbihtKWa8ZR+Rn3SSEAG8TwN61cOYou4lxUI5?=
 =?us-ascii?Q?lYqy5QjtWQqtBR0ko+EJ98hnW71qOZ5aKJKYT6hq7mjZvdDUKsx9poiOU+Of?=
 =?us-ascii?Q?k79NqDhMYNAnUthdP5gLPb1289JD7HOAC4+nzdBft8ynJIDm1LUMrbLyMYvd?=
 =?us-ascii?Q?an+/pwMhPZh7UiNU0OEsXhSdg6c6TFgz2qKkP9e+koFr3HXLrlSWHx0xs4AW?=
 =?us-ascii?Q?6drOkqfGfQ4mPG5RU/PMpEdYiAPLCYwINwxJ+xvswQNWrQYeYF+5Cc93fvlq?=
 =?us-ascii?Q?AY37uEILzRy0zkvL+xORmqgZtAnhNQXyBYG94kB3wJC5Vqzx8WaFIjWm4RxE?=
 =?us-ascii?Q?Tpas/uC7jbrz+otTkiWTrW8/G51E3lcIUnj1vyDNt4kB63WJk5Z3A5Ena6hN?=
 =?us-ascii?Q?7YP2v1eGjabIs5pnayY0GRotCeONQ0rXmp3omHVw/M8wv2NR8hOOhFj1jOYj?=
 =?us-ascii?Q?l5/yRpSc+Ggvdcig6KnQ8aTdtL/Ap1rvzoHsa4l6BwkbpPcUBYTVvrTY7Wjp?=
 =?us-ascii?Q?udxmzwvh0UQsnSBsl0JB3LHNfe+mIXOV37U9S6lGJxWLEjnk8NfDiCqXkjo5?=
 =?us-ascii?Q?HQEhcBDrRe1wy2ku7BUJ/gBIGn507epiaom07xp4jMhfUyYFMqimXBFVQBse?=
 =?us-ascii?Q?LYsR58KUjtsJIz7Gz0b8dF+tKSi84UovIUwIjVxJpBjlRVO5b6jjoEmqst4a?=
 =?us-ascii?Q?xcrCe0H0VAJuFddkqtgFT+pYGoQsDDpsxzCcUArp+pLEId42/f36KlIEV+6D?=
 =?us-ascii?Q?EYhGamqv8/KLruiNcT9LKI2ZLPdyqZRsD716dY1e1sunOEWpF/pyIRPcVPvq?=
 =?us-ascii?Q?mLXWO6J/kweuMfCjCRRyPU446iP+GehayCVBemq9ESRifaWF0lSvk8BLKAZ5?=
 =?us-ascii?Q?WZSDoSy0r4uUjfMrG5J6bdG5bV0LhUcodbm8rYOhhlUIVXv6p0A0CWsLDePr?=
 =?us-ascii?Q?LLp9l14pDrPFl3IsZjDU86As8xlg8yvgM5l0MBHVQkaWq2aP1ICzrE7mwF+p?=
 =?us-ascii?Q?8sKRv3PklYk1vKRlEMnUEktKRE4TPdEHK17OgnJ48w9RgDu8AM26DljbNgtr?=
 =?us-ascii?Q?KmH4W0zimnGP7pyTUtC/qGejXHVgmMkDemOkxburYQRh05GhYKGNqHzemiZm?=
 =?us-ascii?Q?8R9OnYAOTe0unAMJIxl66FUeY230Ewo7oJAS675AueOo3XjJpWGtoCoeONjR?=
 =?us-ascii?Q?26aowWr7KjwxuFfQqDIEzGSbMrBcsMfviO9EwUKp77OEZWtl9fYkSy3B2KJi?=
 =?us-ascii?Q?o5BLZFkc927hsIO6jOx7cJ4adju1IUmpbTJHopZkc/zyrrHrqVxGTQN9HdsC?=
 =?us-ascii?Q?7zTNBr07DD3z31T5jsa1qiw+Dz/jZJJaxIizDWLoreCd3zQXyqyo9USc1Cn/?=
 =?us-ascii?Q?WjneHO//Q3TCUHkhoovEkq8yczEPpdoUjFmeSDHaBgUpuR7midzv6B9hHFKs?=
 =?us-ascii?Q?h9q4MGrVtuac+25Vqu0JXXKDklBV043sRk6BQTI0HNJGKe/J5cXGYkRyIS3a?=
 =?us-ascii?Q?nzqt8VsW6lHDFrFztaW4WCWVhYuTeCmAC8bw83MI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c04e127-caca-4387-c21d-08dcbb14107d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 21:16:43.1798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVtoUU9ni9cOxCjnXNstNOQq89uoDLp4OYlBh95T7t5yMbRL3aevIAjbrNJFouRxyYCjeHgW7GmDbE6rQ57xIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8357

Convert binding doc microchip,mcp251x.txt to yaml.
Additional change:
- add ref to spi-peripheral-props.yaml

Fix below warning:
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: /bus@5a000000/spi@5a020000/can@0:
	failed to match any schema with compatible: ['microchip,mcp2515']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/net/can/microchip,mcp251x.txt    | 30 --------
 .../bindings/net/can/microchip,mcp251x.yaml   | 70 +++++++++++++++++++
 2 files changed, 70 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp251x.yaml

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
deleted file mode 100644
index 381f8fb3e865a..0000000000000
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Microchip MCP251X stand-alone CAN controller device tree bindings
-
-Required properties:
- - compatible: Should be one of the following:
-   - "microchip,mcp2510" for MCP2510.
-   - "microchip,mcp2515" for MCP2515.
-   - "microchip,mcp25625" for MCP25625.
- - reg: SPI chip select.
- - clocks: The clock feeding the CAN controller.
- - interrupts: Should contain IRQ line for the CAN controller.
-
-Optional properties:
- - vdd-supply: Regulator that powers the CAN controller.
- - xceiver-supply: Regulator that powers the CAN transceiver.
- - gpio-controller: Indicates this device is a GPIO controller.
- - #gpio-cells: Should be two. The first cell is the pin number and
-                the second cell is used to specify the gpio polarity.
-
-Example:
-	can0: can@1 {
-		compatible = "microchip,mcp2515";
-		reg = <1>;
-		clocks = <&clk24m>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
-		vdd-supply = <&reg5v0>;
-		xceiver-supply = <&reg5v0>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.yaml
new file mode 100644
index 0000000000000..789545b6c669a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/can/microchip,mcp251x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP251X stand-alone CAN controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp2510
+      - microchip,mcp2515
+      - microchip,mcp25625
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that powers the CAN controller.
+
+  xceiver-supply:
+    description: Regulator that powers the CAN transceiver.
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        can0: can@1 {
+             compatible = "microchip,mcp2515";
+             reg = <1>;
+             clocks = <&clk24m>;
+             interrupt-parent = <&gpio4>;
+             interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+             vdd-supply = <&reg5v0>;
+             xceiver-supply = <&reg5v0>;
+             gpio-controller;
+             #gpio-cells = <2>;
+        };
+    };
+
-- 
2.34.1


