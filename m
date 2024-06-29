Return-Path: <linux-can+bounces-893-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 696EA91CA80
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 04:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBB21F22824
	for <lists+linux-can@lfdr.de>; Sat, 29 Jun 2024 02:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381656AAD;
	Sat, 29 Jun 2024 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KOcN9fBc"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145763B8;
	Sat, 29 Jun 2024 02:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719627501; cv=fail; b=guTP2QTiqsrYjqt519sO27oKLCgn/WaWCrH7Ay+hcKo2zN0HabAIa/sjEeXzdr2VTUCWIZPcfMBrWMG3jsrZFcwhFu9lbVOQmAkXcgPDIUylNPE0VP5BRhErkFLca/TCcW6KWFrE/fO43cyY6Pf+Cgs1yAONKmlq0R8gk/cYuQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719627501; c=relaxed/simple;
	bh=cFUFo87Le31AEZWSzLEV4zAP+M/n+3q3YLuNEvEh3A4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EkxZ4RK+xO2B3TGp4ZFoyntvnXF6C33/PW3v4Z62tAImRD02Atpq/KA+jCTl5n903PmevHIWpFGX2p6EsKGiMFBG4++zIpI8rtFyIgUmfmZcOzqnEWdsDz9HUJllfv5zK5t9InhpuvhgSPbahFn5NzNOz/ET3yDVu5UY06ESwOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KOcN9fBc; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7cuy9RViaiuOl5/B4mTmLOxRdu+iWiq7/Ogr5kkGQGCIWrFnyhcMvjDttZ+RD6pA0HnXrS/UlGQH2BIQ1RMoTcChnM6d57ef4v6BFug5IIpNKtdcHdgl4ldO6IwVTNnauF3aAmpotCja11fnVvd4v/0Ago92YFbhyerWgIzV1BOHBuLRQ9sNNU4kgQeBkK7FxoiY1khN/ohWEr8MXoFvyZjVFBu1LqET/AH731SeEbtijaiw/lGyNR9o/cM3moyVvEihbpCPEC/MWl3UfSHwnoYM62tYwaFXDPey42SGlD7SbMl/fZ/kJtBR3c4IjZU+9p8WVdPPww8R1eN4TsDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W75/dEKxcN7qv1gFI3WU2iYxw0xPVUK0NgebHV9shaw=;
 b=Ez5CC8u30uifa246Ir4GEl5rEjRvsftWjWNpGuUxp41RnbEmUrY5g9YZwWlLinv40ePOaDSFKeD8brg0520qNdqo7w0YlsQEe1++RjMeLIpAQxXY4j8lIPmgoXBml4BGCukdIFGBaUfFM3Q/R8W4b6DMxVyiDKLclfH+869cChMypOeLmg4zXY+WU4XlJeXZIAjIsWF27LyBEDZ4MDyn8fS1l3c6dkkr/G4/1lJt0UKPBO3x2/6HDXuWnBK2XRU3iMPIQgUsUNb7zr09WFYeDqwVLjqJS9xrMdvMMhoGTj96/SVoAAYIxF14peQISSaa57EzeniVuvhOQ5dQHzXKcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W75/dEKxcN7qv1gFI3WU2iYxw0xPVUK0NgebHV9shaw=;
 b=KOcN9fBcnnN2ESVfzrI3oLFGdEc2uTBM8+ms3MD3PQevzXjkXedj0KkNShX+8MQBeXX3qW4BvYHLXpTRVVYJX4EQ25bZ4hIRx0o5ajBZOw99NFxMfWX/Aso+Jr/b7C1npkDNhX5MmeEq90+LpkLx9pNKBYQIjhQly1bK+U7YDR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10589.eurprd04.prod.outlook.com (2603:10a6:800:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Sat, 29 Jun
 2024 02:18:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Sat, 29 Jun 2024
 02:18:16 +0000
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
Subject: [PATCH v2 1/1] dt-bindings: can: fsl,flexcan: add common 'can-transceiver' for fsl,flexcan
Date: Fri, 28 Jun 2024 22:17:54 -0400
Message-Id: <20240629021754.3583641-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0027.namprd21.prod.outlook.com
 (2603:10b6:a03:114::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10589:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdc58c5-cf80-4317-2e26-08dc97e1bbf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CfoQ/Xbp7/LTR1frDS9wCGFZBgf0E5WbBctHXLXVIH9bz7F2XJO95OHJhb4e?=
 =?us-ascii?Q?tJBH3zoOsSo+c2S/fLcph27FlsUkYYPsJjFsLKk7cwyBlW4cvrgNkNh7eh3Q?=
 =?us-ascii?Q?KW19Fa2Ks7cIDL/Pudh9C2wSukDKoYZC3B41Ayf0Osr0yr3DB1Uxgz9+6XQF?=
 =?us-ascii?Q?chvIVzsG5zqhWY+jRnRO9Z/cemlNyLIELHffm78m/vZloew2eP8KIG2fHRQa?=
 =?us-ascii?Q?sf8YDv/2AIMrn3dGbHESa0WpngM2/AZ+8B66c8FOX6r7WvWCNj0mjDDHd9gx?=
 =?us-ascii?Q?trIByG3cf/VwacpSYAa4IXATfuuFuMyPVUqJVtJPS9JXqG30mEjH6jn2Cfbz?=
 =?us-ascii?Q?/KhkokDsT91thmSfJ3sGHJ9gHsKYahtjdsw4qTfBHQGfYFYJUSN+PThxSwP8?=
 =?us-ascii?Q?tQGCYOsghJ7FzVfbUQPdMF0g1bqDSjIsXr1dcLreF27Q4k3HEUN/92KGqFSE?=
 =?us-ascii?Q?0MrxlCj6g0hESOVbkd+6XApEzR3ntmiNTpgmdU+F9wSt/Oz5qg5AQasqlBzd?=
 =?us-ascii?Q?OVHsJ+BRPoKI1kI0O34HrlwH+oggblBs04pENiL2lIbCCaMqTnp9k1e/rTy5?=
 =?us-ascii?Q?toZU8SWniRiOfpFk1fjaKkSk/KBjQqzgU7m6WoGl1KBfwFWStN4oHCKosgVk?=
 =?us-ascii?Q?tJYTufYx1RyGeZaO6vejI4ynDbsFXiZ9xnUSMJ/uSV93ON94uaR19Wzg0piV?=
 =?us-ascii?Q?ijt2JFZzbkkVMXf0CyZKi1optanwoGkDj1e8dfqPmMasbuaENwnlVSE4/c+g?=
 =?us-ascii?Q?9quygWX5H60Aud9zaxIPLOIGOtdf55hJrf/RPGIRD905slE3o0BhgwuYC3G+?=
 =?us-ascii?Q?4u/0M19RsPymSEqYri2caRBomzumduRWHL38KmmX/P6j+Y7ChUfaDm41qwmS?=
 =?us-ascii?Q?FS3vNf5GA6Gy/6q8lB6B4fuNztre7RpG4PCwSGXeiucXBSrmI25FY2lalIqd?=
 =?us-ascii?Q?i2aaQfmrGB0fYhPBtm6GgilPpsDFZvFEyCdGuYq1vKX1IsJdtYNtMwU1aP56?=
 =?us-ascii?Q?gvAnvv38yn65nqnbbuxt78q7JWt133n812ez2drQcB+uf/RJD7ZFTPdCbVji?=
 =?us-ascii?Q?gRaIVaOkcCYzJspCFb5P/c4HJ4gw/ikBmvGd8k+rbQWNChA70LaJS9olsp4F?=
 =?us-ascii?Q?3rdqh7IDELrvQ7o67ps++1h+f5JuAW4gEQJxOp1+amhtzqLPT9j3uxQpvniV?=
 =?us-ascii?Q?N+cOvtwXAq/rg4oNGZhfVtdsPYDCYhqL3+O5BjS2VlfWt+lI/1DpZvhQVkpn?=
 =?us-ascii?Q?1EFHFpBAldeszHFnCoVWE5A81cSKdBbxvB60keDRMl4RL6l5IYFRNhkWuRk2?=
 =?us-ascii?Q?mEyK3w5WI3f23NZqjeuryFSqtRSjHO7l+A7vuWHQ2/+bNdnV17zBV5L4hY4/?=
 =?us-ascii?Q?9PwdDrIpxeACk3rYm44S4QudBjAe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VT06zaXj8Aonq2Z3X/9Eu/Odz+yHPRVl3MvqjReV5nH1ny45cYQC2let0Lnw?=
 =?us-ascii?Q?hfQvy9z99PDvENVuLtq6c4wg5+koKgHQdiYFU9ukBVqRMxgZGt3JWvFy5eZc?=
 =?us-ascii?Q?5XJvRc73iFivVsRg5rZCGiHfyuOCh2worxA8LONBo0Slq5VeayhRW/+z3DTc?=
 =?us-ascii?Q?qGm1DjTemHYtSb/P9YJpTZkM9CrsnUGufQI6zpQWCmo93HZk9chQ198V8f4p?=
 =?us-ascii?Q?/1Xu1RQgXS1xEYvCIzha7GI9cDyaMxx78yD/iViRUE9PH57jnV42W7Mm9bwt?=
 =?us-ascii?Q?xSArKPYKjLxteOetv+yfqzagcKg9nFDg8VJ7VIaETfCsz91sXLxW+XANv5hd?=
 =?us-ascii?Q?9tKB3aLG+hBKC9nx0f/1WYfG7AI2fBLfjfB3ec+zSZoSKTsaidUMe/EvM+F4?=
 =?us-ascii?Q?izPZjpE9ZvkeOrWknSWZ5uY3Fu1yRB1tjYq+h2f3e+m9+pgG4Y1VoXjvPSBW?=
 =?us-ascii?Q?/6UkcE7jc7teQqdnhDXCOpF8AI0NJaC//5W94Pw07fYKLRchfeyE/y8G4LqN?=
 =?us-ascii?Q?X2okmtUJpbHw8vDg/blSj13gCvOs5VUSgjA04DPvlmfiKshTULyU6PqZY7bn?=
 =?us-ascii?Q?aFXUHN7HgLEfJMPsQzp+CVSAusofY3sEfDD/ovTzdnMtMWnAwIKAc5QBjqA6?=
 =?us-ascii?Q?zHJbQ2i58K/oW1q/pWBdQFlWK/qirh86Xo5heu9WiApjK5/tY20C7uEz2yUw?=
 =?us-ascii?Q?iy3CKcvWeFk6lcmN9ZCJDHQaoxhtD99IX4ai7XsyRTrIhpEky7yIcieCySe/?=
 =?us-ascii?Q?1wcKD2Y9xhtxC4IZRGy1gIJPYHbOP8xMpMUy3Whkk3gl7ZnDu4tStWPnOCoc?=
 =?us-ascii?Q?F0ri5VupJ9Ptufkr4kr3p7YlrhaH/zhYAELD6S+T2dvggb+wEDTxJblX27ms?=
 =?us-ascii?Q?c1IDzywZCGOUluJfJrqaRw3NLXhZbx2N2B1rjEwwJW/j9FM9KTZrU0p0qVkH?=
 =?us-ascii?Q?5lz4p03UYt6SSQrReQ2ioOa8O4sOqX9x0hd6+q2P7jho+JgRT72aQi9opRDG?=
 =?us-ascii?Q?okULLTWr898esOINrMQ2eM9UC1c47woDJL84JcCfaqdIQtjCJU2OXc0i7spF?=
 =?us-ascii?Q?EuTuUIF40XS+x2BUt1FzZJGJde9kEe0+YEpp4tGqP3NZU7gNmpxw2Om5fdy8?=
 =?us-ascii?Q?wYpMdF4ihb4yrrJKyQjd5IWprMjBphFwTDiU55OfbiYyxozva9jv9F44fr+K?=
 =?us-ascii?Q?YsrLkCHB2XaJ684ZU3YjUEzSfKJ0uaUeEPVEUAEGwtYZvwXHu7AWNvxE6Vq7?=
 =?us-ascii?Q?/VnN+qcxZFZtqCgGqviOdQ4kexdMupxgakTpzLW/A4thmhFDVlmZFQxWfgAS?=
 =?us-ascii?Q?/G0VIIIsWd+Uht3/Rv1uk6UZcifimMQ14OBMMdQtitRMHfTNM91FgtopWxis?=
 =?us-ascii?Q?TbVxqkcmYKiDQo9e2Y5KW+b7MwA7Iep/HRGi6SEBKf9oI99OL6+zpvtrmnZl?=
 =?us-ascii?Q?P6cJOBMQw4waTsflJMCdnLeYVyXLBryNZxm16Ua90fhO/jnXIqQn4Et7MSwp?=
 =?us-ascii?Q?Wk/h87j1c9CYD0hBrl/Ha1r5tMFZnA0ekQgerHyJz5TWwVpkZcv3j4JYK8Fn?=
 =?us-ascii?Q?eCD5UqN/CadgY55varVxRs94+dWOla9TXhKuXT/d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdc58c5-cf80-4317-2e26-08dc97e1bbf3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 02:18:15.9638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVlI7FajcZMELGGgNZbfqLhKO5y1ZUKohCYLc/i77r3o9qhNf6hIP2dvAGVOk0TvviX2pvMNqAVJfIfeuV5cbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10589

Add common 'can-transceiver' children node for fsl,flexcan.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: can@2180000: 'can-transceiver' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/net/can/fsl,flexcan.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- rework commit message and add fix CHECK_DTBS warning
- Add unevaluatedProperties: false
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index f197d9b516bb2..a4261a201fdb6 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -80,6 +80,10 @@ properties:
       node then controller is assumed to be little endian. If this property is
       present then controller is assumed to be big endian.
 
+  can-transceiver:
+    $ref: can-transceiver.yaml#
+    unevaluatedProperties: false
+
   fsl,stop-mode:
     description: |
       Register bits of stop mode control.
-- 
2.34.1


