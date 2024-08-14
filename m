Return-Path: <linux-can+bounces-1194-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5940F952046
	for <lists+linux-can@lfdr.de>; Wed, 14 Aug 2024 18:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5480D1C2211C
	for <lists+linux-can@lfdr.de>; Wed, 14 Aug 2024 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEEE1B9B47;
	Wed, 14 Aug 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ESdBqwhn"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240561B8EB7;
	Wed, 14 Aug 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653870; cv=fail; b=OljKJhPvqA6vzLXxCHYqd+NMUuevM7t6MlHNKV+7ar1KhuO9hCpflMT8zIX5ipd6VoEcdUBbYYjfsRzdle2SGEA+KeAShSjdJI4vmMS7SvfR44WLehUztiWZG6NnE2ULHZGRRo5Wq7NxQZ4bySKhBlA88Ob50dbqhfQrMwtIihU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653870; c=relaxed/simple;
	bh=Htx1oc9G13xwCQNiXjGvSDK9Vgs/8iwpWt4YiRlFXis=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UWjfZx9+Ye+sDCv/g76rtWjMoGMEXN9sRHrwA9YGHkn8iL4r0xh7qQHX2goSmvIDoXxYtGy8oPjgtgr9LXxsxazniPQ2PQeb6dT8PU6vBRKfp9VR/e3FGITKP/CinZ9qCSMKw4VEq1vK2wHaaBYS0KbPQ6L9fx65A80ni4/wyRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ESdBqwhn; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVHy+K3Inv5jl7ECSu319t2Bye67q2QXKOfDu2MQ6bJIj15vCUfpBTKA5JiqkSNgdbQ1XHb1Ybn3BwDo/yoW3TAdOleNbn0wVp4qWCcbHG9DZuK9E/eWb+tdhTQBVTqGxhLiGdBIlcLhmu/6PrnI6eZ16nKSwo7ASokUVV3kGOaSdqb525SliBGkUmAJHS79AEiTBEgPZzpfflMTdx8ZfMeTdH3ofL+//g03sZ6qHOWzq0e+B0uUADg2DOGBmI9WEai0ORSm1EloxepH3W2cfZqTUzBODxb85wiFnMFl7YSWvteksk5EkMCiQkquiOw45jORCS/wItPr5lT9lPGdiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ckNRVgo2c36MeTqUTk+EkLlBsWgB0Uj5FS7/7axYWg=;
 b=PmZqqvUOM7HEPNuBpDTVggg/fX4ye66vy3sw0hOUCpX8z7BaJMFpI+u1SsH3tI+4RGV1mJsJtHvgOFqsXv8lvgbYvqj8E0LKmIBocRy5oQLKNY4Gf9C1+DGC+cUKwMUmqRWMza2B+9CX37RLarBBDg9OT0J3kY2TcUTASegevNMhjYf+v/VgDDJkJEBCFlvJHLNXibzo4fMaJ9SZ5VhyquA022KGg9N860SJz16KPuYXNHZkMapKONUTu9kH73zyeaekBrCT0uGnVgj4NpaPjP84xriuBlj1kGLKZe2U9frgVW0uSH8kH60y5EhLiuoW8EoNgi7WA6HW1yxt3yFisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ckNRVgo2c36MeTqUTk+EkLlBsWgB0Uj5FS7/7axYWg=;
 b=ESdBqwhn9Sn2okNrZr2D4/C7mrRPScqb022ydfTdWQQoMWl+tAdgYzW/RPBrKMdyqhLLO7QHa3vpTPf8J3KRjGAQZiffDS4nP7ye6uFyXY/DD6A0bs9disQ2vozD6J/6HabA8fRaMU0k3N/DyfrHIwrU3PqbGAC3aw/n+3gmnC8okK2qGVnLoKShmDiWoQbbyhmZ3MPhI837ChIdRey0Ik4I+wQnPVba56k4ybYdafboyuvJBjYLdc9XM07m/oSm2PptoVp73sBr+nEN7a+D13SB3rroEMKis4NMiIT53C6CXJMDHV3cWKdtHC4Gnfx/6MhgXB3nsquzcCdWigB0WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10229.eurprd04.prod.outlook.com (2603:10a6:800:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 16:44:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 16:44:23 +0000
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
Subject: [PATCH v2 1/1] dt-bindings: can: convert microchip,mcp251x.txt to yaml
Date: Wed, 14 Aug 2024 12:44:06 -0400
Message-Id: <20240814164407.4022211-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:a03:80::41) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10229:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c4228e-8925-428b-b312-08dcbc805a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	RFd9QKmJEIuiRLY1DqNgM5DIpMqvwOxFTK7h3DKO6ebtG6pxCfLSfslStGMOmj/cH+6BITecG6mYMvHml8MN5wohxrTt7o7wCD97y2jrZzdvkxHdqfU3csbvJQBJejD53ZTsoi+huNC2MvMhQLvbz5OUYgDZz6L6TzbAgUcVSdpzneRJOvRuIqcOrQC5/8vy6/95q1Ly5cCKCK4totedd2BGRmkT66Ob+9aYZsVoY98ssYF6QNlyUEU7JSdVaxy6KPvhqtB3oJKHjQfdkywtzE4pd6K1mHfBXh+jQ0fpi9ksvlW/B1mZeAAJgMhUV91XUzI9Ys385Dgq2PT4hY7Zv68MyJkKt1Vqdf6jqOS91D3gGOEsKfIbz2CXcLgvKsbSyV48hiBeKULit7WNTtlbRsJyPh2y09AQoXrzfZG9jZNEAZK4UDbRKGIFo34Hwczzn0M6y/Qw/E/7056utO2Sy4mqhfsEjmeH1m/yztfqKHlIu0PcjSnc6LG19Myq+5TthACm2d7LlpMn93Iv13MiNBj8RSXOWw7vAO5Kv5R74COpfrAnnDfio0TeM/WxU6Joo/E3YWZoMLUoQgSx1veIaS4RBiMmX0hPAKFNkAMqHh4bmZ7SCNinopDNXL0vcFjsUoH6IIAx5ds9GWxRDnfCpK8b5jx2Qa3wGCmhg8H9mMMz+kHGJ0jJjmeBAILekY8k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5mZ8oXTGL/xHr0gSDfJN4ts3mRICtEw6G1DzFK0sUVUNynT3r/dVYZOkxjsT?=
 =?us-ascii?Q?EBbZds3qpOUjpwMn49xSFIYUHkB/IA01wun0G9AAzufa93PVmp6JNWJ1UMCw?=
 =?us-ascii?Q?+kJBtBtrQphrJDj/0dA/u6eDWO4E74fPfDoLW+NTeM43O67t7/BNaEHvupr1?=
 =?us-ascii?Q?sB/W/zkF9Js43nez1keaDhXqS0vvQ/Pfja7MalSYWvX8aXqCy3WQnognf0Zo?=
 =?us-ascii?Q?mVKoro0uz5+nAGzl2oN4fblFUYNoXe1zSIupyhnAsRbZlCZaeGoxjPbEISCo?=
 =?us-ascii?Q?IfMM5syRq/K1+vJHjr6j43VuoVVpMucWpNhttrc/fK3+xLFvXWMnK+Gehaag?=
 =?us-ascii?Q?JNnibzHcEt2oHvmVhc3LCtDFeuU2Ys1B1xgE//OV1lh18jS65ywamsene8kY?=
 =?us-ascii?Q?nN3EXtOdl96xJgKWdX+z3Zzlhc6I/w7z6txxQKCEwhLRlA2SmQuALBtpRv68?=
 =?us-ascii?Q?ZfFAapH2PFxXjr7/3clCbQ3dUwBrVmrS+wJhfWNNYtBvl62TDq9tGC4SPJec?=
 =?us-ascii?Q?hFSGy1vAp6Zw+CD4t5oixW4AQ+sibVMN5DOOnCQbIOHCKXuXUUSUgB2FVi0m?=
 =?us-ascii?Q?MgfcjmGBS57GuofyLezlDKvF14wIqxojCMjHVklKVcn6jMSWwcc+/EsrU2SQ?=
 =?us-ascii?Q?/wxZJDII+Wf5/ZEGTier/6YQCFEKPCUPvJ2ZivJ4RZbgWZmHXET1cldmVFUj?=
 =?us-ascii?Q?iWCxJZbthdgRWaaG66YgwxymR7h4ieDGPXkVLZXR0zj7HZHnMnrwukcOuy0q?=
 =?us-ascii?Q?EooRJmD6YztpveeekH93NaHMEP+XRLbs08aPmZPq+OYVfOczEw+OrMHR3NYK?=
 =?us-ascii?Q?hKpNH6bMvF6GGsBCRVbrUzHhwXiWgZqH5+IKLxiPOIqt9hfXTt6ST15o6jnO?=
 =?us-ascii?Q?cAHe/ZE5btmAVmOd6oBCt4viGe7KTxTif3s9njmrU9lDWnfKjUZCEO9DnAsM?=
 =?us-ascii?Q?/ARBA09mvRRe1k/c7hLi2x6sA1b3UvX4vgrTmBhDbgHeHQ6Is2fz702wjNiT?=
 =?us-ascii?Q?ydGAIBM2FM8tF3OqhS9AygRK06dik+R1BdLHoeXS9Tn5Yra7UY94JAOuIw34?=
 =?us-ascii?Q?v4Y3pomqYkNPfyPorX954OIQUNU4J8cTYiRJeVOVKDyDq7DvQrc3YF50TTwT?=
 =?us-ascii?Q?KxEP0A5HJWzn0eytzEtOvdFtFX3Bqzi1jmPSxwEKp3UutESq2VCNatWZgOIy?=
 =?us-ascii?Q?bHHYPHQ5Y1p7V92kJ4knlMUuhCkm+exfylk241zNzIyru0mkHD708myAc5vT?=
 =?us-ascii?Q?wtQJmMfTfuHyzFsYaB7VM/UZuJq9/7ONIydduF5j9YALwHW0nUjt84DI7moV?=
 =?us-ascii?Q?crb9tr2kh4zxlEttCrwdFEv6MPjJ/SktizHcX8AhQrpOmuvfC9lKmPhfPpCC?=
 =?us-ascii?Q?xP4S8SwdRnExYbPL8Bhtenw8K3N+cMiqpU2LH5kjzpUaa5Ir+QknS24F/YDz?=
 =?us-ascii?Q?giGHc8H0vT71k6FZk4cR6cY3Mrpqd2lprTh4fcrOKrUlxr3otxk1fiCRAHif?=
 =?us-ascii?Q?AMIkZIj2DBAi90Wv9CIl9XReC8o2jWli8Qb4TaF12s0T36qHavZL5wdj4f/l?=
 =?us-ascii?Q?3Tc2z2gZoebhuyrKOVHzgc8TDvn8RH2rhQ9LHsDk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c4228e-8925-428b-b312-08dcbc805a37
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 16:44:23.6691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRVDYbEVLVvkpaxEv1QlrkRQypG6w/8Eh9Wz8lPuEXsw6lrN+QlWmOmDcN1tD8ryPVYFEq3Da7yVZCfwQ1vHug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10229

Convert binding doc microchip,mcp251x.txt to yaml.
Additional change:
- add ref to spi-peripheral-props.yaml

Fix below warning:
arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: /bus@5a000000/spi@5a020000/can@0:
	failed to match any schema with compatible: ['microchip,mcp2515']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- Change maintainer to can's maintainer
- remove label 'can0' in example
- file name use microchip,mcp2510.yaml
---
 .../bindings/net/can/microchip,mcp2510.yaml   | 70 +++++++++++++++++++
 .../bindings/net/can/microchip,mcp251x.txt    | 30 --------
 2 files changed, 70 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
new file mode 100644
index 0000000000000..db446dde68420
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/can/microchip,mcp2510.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP251X stand-alone CAN controller
+
+maintainers:
+  - Marc Kleine-Budde <mkl@pengutronix.de>
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
+        can@1 {
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
-- 
2.34.1


