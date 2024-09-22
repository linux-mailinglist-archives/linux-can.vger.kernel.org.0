Return-Path: <linux-can+bounces-1522-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B3297E2FB
	for <lists+linux-can@lfdr.de>; Sun, 22 Sep 2024 21:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E201F210E1
	for <lists+linux-can@lfdr.de>; Sun, 22 Sep 2024 19:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E14345003;
	Sun, 22 Sep 2024 19:25:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2104.outbound.protection.partner.outlook.cn [139.219.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97112CCC2;
	Sun, 22 Sep 2024 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727033154; cv=fail; b=XrwY1J/LI7WRiNfsSa53CjIebS3OBB5M2kDoj3FqgxEm0iNoRywCGonLHNgKhRtJ2WX2slHbs37N7xyRaBcBVpZIvhfbKMN1oYLvjjGFvDTzLIoj11UAiUGopiOx52yKr7nXMyQAbvYavdaBnsoQnpK1l2Qdk9of741XKG0XnQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727033154; c=relaxed/simple;
	bh=t9bLzqApRzCMyuQxF5Wn6L3PAzWKXW86DEQUXk3N9JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sa2hBZEELj8O9/rDW+KcH+mFXFsl0mJ8RXyGJ7NT+JxO5NeIa1jvpNmNBUmwM0Jmd9V3iNGXTmDljiVPswH0mjEiKXWmG5Id1roOjUCCOwY+sszLKZc6kP65djMdWyHaBSGXoekTdx8d2/HbM4cLnhPdSzwFm+2fUldf2e6Facs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLy5//gxz1EEqENPkIWjCjwz1HhPNHwrYrDtgK44KjAjYHA7ss9gwfar5B4fcYqlZ9l7TafSsNv35LkRuonXb/WdLsBXdi+JP05udicI9H/G86CUHK3PU4UMnIL3zy523YvG80q6FYv6z+YICCtm0wDnAe6p4IH+EmAEKl8g5s9kVm7Y7zylxtvzRjTRdHU/EOt8rJYJKGhrq8JKrA1hMVY23AeyhRBmWpaVvxh9lcim/OO1GalGKQdETDlNoFOH9zMAUzMd/kEC4kCpW2hWrRo7uP19dSw58edbOzVHdc+ctQ5JVOndZUjpi3lyHBpIvyuHqlisx9zjA+iczg28mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGog7RH8gMlxqZjwmj0fjNLvCAAwCP9dhYNgE08yFVo=;
 b=UyYrEDpQBofN7sWfbw82EMXFzDcHM9EcXNPvN1LOopJtjKJe1sVp+zvjTU51f8qhVGh5eDR8QtdP+1Ln4tdHulc3H9P0mLnmlInKIXuQUSB7JDwRROMNc51K7CYBShxATWAQWmiPLPOtInP4qQNl4t066AnvbWKgC7PeFX4M1tj2IhdNfxoNzcdVFGC2Wjc4ig1w9MYn7iY9AEycztg8VkmJWGTU57Y9VU0uqrKQMyZIwN0ObsuWkxxetbBpmQy8lDq99RnpxpDamJaUi+BlG7vl1qgCHIW8/4Si7xVCfl8UKJL9UCKVsZeld2HtYu5zePCjNdaTYivh56Gw7JSe6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30; Sun, 22 Sep
 2024 14:52:02 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.7962.029; Sun, 22 Sep 2024
 14:52:02 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	William Qiu <william.qiu@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: can: Add CAST CAN Bus Controller
Date: Sun, 22 Sep 2024 22:51:48 +0800
Message-ID: <20240922145151.130999-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240922145151.130999-1-hal.feng@starfivetech.com>
References: <20240922145151.130999-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0027.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: 425b14e6-5b30-4f5b-7654-08dcdb161df3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|7416014|366016|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	Kl8kFGbidh6eORm1N8kZPPBvOftKpQR4EwAz1SRtGMCdVoJyHz8iLl4PUQpmpbghuVqzuyW1w/cUJqGq4cRKm4Vy12x5r4EMIHA1zr7UM6pJxwNOb2NmPeM+uNNXCdyw3TYcdEq8gIjmsi09+UV5+rwPZRDJjYs7GEde5J+/I/0qOB3Cp7B6KblTnTv239XoHTznj7t/74DbGtbODmf0ydOkWpLYinTexRW4MRzieotFB5BdPz4S7FV9jK2S+XitajvJ/i93zlSCW12pY2q5rnAK1Qv+KMWRyvQ5DHUA5t4mjx5sKrDNKBKnsO+g7wHhLQKzKkRVeIaWcxFTOAurqoJfHEKc8GoikR92d+NW9pv3cvhIr5jWVLWwXy/3sBPoco8WQd4ni2eSDEjRHiqGroRPs1y3t98gHDVYzLxLokVRWBSHvPMUmcgy7ZfkUO79MMx/OI2NpTTxhn61BxX4kTd0iHQ6MabuoE01KN6qFPiwDKQxutuOJgLtq7a8Ku7x7GxaxDsv6SWbxFOxawquE7NTKVzahUbgr1gEKv9sqrK0Jdq3LW18Uz4DiFCnY6xX3BTtUxlaXfzjwvPyxqIr/7W3R0SjyhrfDdn3LUzBZqocB3lrEUFmSMzp2UTMLDOQ3ET3ez/zI9AwgeY/E8SS9Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(7416014)(366016)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q5bg4uScxmppeOhhlvCGkNav7o6SgZf5N4ue70zuuxH91IwKWAtvYhNf5UQq?=
 =?us-ascii?Q?5LE+OWWSCfBNtgkv7sFKqzwFZFE4O+DWcuIxpVkLy2Bjqc3OQq3f2q7mIyE/?=
 =?us-ascii?Q?ylvDb8lIzVTCWaKhN6UZ0XUfixMmJMjXWWnbcF5NO3EtidyoAR1NmEBYBHQu?=
 =?us-ascii?Q?DoC3sMi5IqXWa4+1QejoxIGa3A6ic8fSriwksBM2/2xIlKYKB97lp7e0Qztp?=
 =?us-ascii?Q?t4623606kRnI2e0wkHRx5J9COr+Jl6qp074P4//FCyeIm5BOdY2fP5pm18RE?=
 =?us-ascii?Q?jq3za7NzId/4VEpNx5Ar05v93EKid3/C5M0ONQwjBu+lFzsrqdTja7fp0Oaw?=
 =?us-ascii?Q?QfuhIpxhgorC0KkGxP8jpwSZTj4hXee2sMtsRv3B+eHXw2LtHNaMe9fx8QLR?=
 =?us-ascii?Q?QuEVBq6pApG4wqk45Dbfcea8tBJby08Fo69E/6Ly5mYBitaMVFRSW1SitRS+?=
 =?us-ascii?Q?NkRizo7bqakc2fwOrR1i7KQGBrkLVl6f8qKeEiDW3t8XOsjMsq8Z9bWdRgQE?=
 =?us-ascii?Q?M34TI3+eEpPIIAH1vtqOnfCWw5hqXjU46PNJBv4qcglw5pv4oRjUPFbMOHjw?=
 =?us-ascii?Q?xjlXx5oENXcIGiUBi8sg7+WbKXzwlPgPVFetXyMsLwkk6M6QZ0ZCy4O4NXdm?=
 =?us-ascii?Q?OzD6kuhKIraXN3XBIYDe1GMS5yHoRd1FbmCiozMo0EXLEvU19ln4Tn1XY7j+?=
 =?us-ascii?Q?Jm019I9yaZe7rnwt10bBQ7Il0b5nz7AuD7E66E1+9J5tkPOrgkRERQZB8lEZ?=
 =?us-ascii?Q?7MZyPfK7xCx2USTLiNA+AEsvtU628HzblaAT5LqusbrMtzvXOIe0MSiHyhez?=
 =?us-ascii?Q?30boPYrm9AeAjcMNZgLxIYduM+aaXLPNgoVb9tgI0uIPjlJuhayB/Q4nwEyJ?=
 =?us-ascii?Q?e2W3JVoBsdo7L8bjqwzYd6XJQ0FwnuZfxVIjsFht9ANTXDfYiRmMnD6Y1RnG?=
 =?us-ascii?Q?BXKQWaCXkvP6bs2iLznfp3KbtGoxEUGga0lkpfxYr8cR/hkBCLGX3Yqx++7a?=
 =?us-ascii?Q?LTMi+kG+AcN8dAPeLkTHVrd/jRbIQouqyGbOGUnQMFIqkv1/S5RjP/Oq/iAj?=
 =?us-ascii?Q?YkHQ3fMsa5eyv0rwjbfAiMG+DNHjrJoQKipakBcHT45E5pCUjHUsK+nvc3s2?=
 =?us-ascii?Q?g+nYVG1HxOwmfBkE74vWh9dsPFi4WlZpKS92K34Xt0D9HfHXgdQUULG87ySW?=
 =?us-ascii?Q?cnqCiTydAkwt5XOORRVt5Xt5Or8k5B2/n4uIxY/Hov+hr25HNZA7/3x2mQ8a?=
 =?us-ascii?Q?vVLwwP+PQ1d8oZkAKSycOUBvoq5WFyvM4ReuHz36p4QRiOwt46zKhi3mVoB5?=
 =?us-ascii?Q?8WlKBLNCKQgpcDVxCSgHAnQd9Y0J/2KbM5Sfd2/75W+ziOTBZyuklDnj87kW?=
 =?us-ascii?Q?/6JdfpR0Gt/EKBb9bmgBLDnJTQ+wZ6RbqBPDx0kuxHqFHkcgXOuu4h/7u3nm?=
 =?us-ascii?Q?97BniAzkUWnBlo50lk6P4ZKfrw0Iq3zqtdSe28rT9KUFedNL5g7UJuoPzOS7?=
 =?us-ascii?Q?Vbw5Xx/Adh05KfZaI09voDDgQs4q5wONjKfY1sxyN3zyPuoOx+zBDDvWzoW6?=
 =?us-ascii?Q?scFYl6K9vPI0HJVKDGT0wBxGOHt13IffobQk/pFPcqoy3vJI0I/YJVveaqpO?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425b14e6-5b30-4f5b-7654-08dcdb161df3
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 14:52:01.9311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thJ5eDq9rH0wOq2fgwK6HTDxx4q836ZaFf3Tw69bm4kSDPKqFJQyDZm2M+uDPMlUgKnxTnB3c+6k76N1w3ZwvFItyY50oQ6HeyrtLUf85y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145

From: William Qiu <william.qiu@starfivetech.com>

Add bindings for CAST CAN Bus Controller.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../bindings/net/can/cast,can-ctrl.yaml       | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/cast,can-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/net/can/cast,can-ctrl.yaml b/Documentation/devicetree/bindings/net/can/cast,can-ctrl.yaml
new file mode 100644
index 000000000000..2870cff80164
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/cast,can-ctrl.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/cast,can-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CAST CAN Bus Controller
+
+description:
+  This CAN Bus Controller, also called CAN-CTRL, implements a highly
+  featured and reliable CAN bus controller that performs serial
+  communication according to the CAN protocol.
+
+  The CAN-CTRL comes in three variants, they are CC, FD, and XL.
+  The CC variant supports only Classical CAN, the FD variant adds support
+  for CAN FD, and the XL variant supports the Classical CAN, CAN FD, and
+  CAN XL standards.
+
+maintainers:
+  - William Qiu <william.qiu@starfivetech.com>
+  - Hal Feng <hal.feng@starfivetech.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - starfive,jh7110-can
+      - const: cast,can-ctrl-fd-7x10N00S00
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 3
+
+  clock-names:
+    items:
+      - const: apb
+      - const: timer
+      - const: core
+
+  resets:
+    minItems: 3
+
+  reset-names:
+    items:
+      - const: apb
+      - const: timer
+      - const: core
+
+  starfive,syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to System Register Controller syscon node
+          - description: offset of SYS_SYSCONSAIF__SYSCFG register for CAN controller
+          - description: shift of SYS_SYSCONSAIF__SYSCFG register for CAN controller
+          - description: mask of SYS_SYSCONSAIF__SYSCFG register for CAN controller
+    description:
+      Should be four parameters, the phandle to System Register Controller
+      syscon node and the offset/shift/mask of SYS_SYSCONSAIF__SYSCFG register
+      for CAN controller.
+
+allOf:
+  - $ref: can-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7110-can
+    then:
+      required:
+        - starfive,syscon
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    can@130d0000{
+        compatible = "starfive,jh7110-can", "cast,can-ctrl-fd-7x10N00S00";
+        reg = <0x130d0000 0x1000>;
+        interrupts = <112>;
+        clocks = <&syscrg 115>,
+                 <&syscrg 116>,
+                 <&syscrg 117>;
+        clock-names = "apb", "timer", "core";
+        resets = <&syscrg 111>,
+                 <&syscrg 113>,
+                 <&syscrg 112>;
+        reset-names = "apb", "timer", "core";
+        starfive,syscon = <&sys_syscon 0x10 0x3 0x8>;
+    };
+
+...
-- 
2.43.2


