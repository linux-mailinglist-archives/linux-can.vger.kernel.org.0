Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6EC15553A
	for <lists+linux-can@lfdr.de>; Fri,  7 Feb 2020 11:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgBGKD3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Feb 2020 05:03:29 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13774 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726619AbgBGKD2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Feb 2020 05:03:28 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 017A2B3H026967;
        Fri, 7 Feb 2020 11:03:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=nsyoMErbR7vVNG6EV1uMNBReftbJlbC2kIjKB+OcfVg=;
 b=FP24hJzC0b/4tHZ+pjpizi+Yjh1LgJcO+zH5bVt+gyagUAnmm1si7LCl1gxQK4uYbDd6
 33CU4Au/oqtLjAsyShHdrBupcFlN1wqVZ112o/TRKgZ24XzVY28gnpdHQa6dM9RyeXC6
 5bpikRK9UUk6YOvn885TyX8G4zbB/C3NgqGp9FZveP+vxImMbmEU63k72LxzXevQfYVI
 rfRVOoI642OniZ2YIY6NroAAI26eiild52NZJkE727kQLq+OpmEkB6uRDUZTMt5NNwCF
 FsSwV9nw1MhjyYhtpExfYFRKQuB5eelUZ5RDPdfKKpXHT9SztD6Wp+o/0BFfSXdm+xRD Yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xyhkbrc0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 11:03:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2AD7B10002A;
        Fri,  7 Feb 2020 11:03:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1CDD32A96FC;
        Fri,  7 Feb 2020 11:03:09 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 7 Feb 2020 11:03:08
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <sriram.dash@samsung.com>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v4 2/2] dt-bindings: net: can: Convert M_CAN to json-schema
Date:   Fri, 7 Feb 2020 11:03:06 +0100
Message-ID: <20200207100306.20997-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200207100306.20997-1-benjamin.gaignard@st.com>
References: <20200207100306.20997-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-07_01:2020-02-07,2020-02-06 signatures=0
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Convert M_CAN bindings to json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 4:
- remove useless ref to can-transceiver.yaml

version 3:
- move can-transceive node into bosch,m_can.yaml bindings
 .../devicetree/bindings/net/can/bosch,m_can.yaml   | 144 +++++++++++++++++++++
 .../devicetree/bindings/net/can/m_can.txt          |  75 -----------
 2 files changed, 144 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
new file mode 100644
index 000000000000..cccf8202c8f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/bosch,m_can.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch MCAN controller Bindings
+
+description: Bosch MCAN controller for CAN bus
+
+maintainers:
+  -  Sriram Dash <sriram.dash@samsung.com>
+
+properties:
+  compatible:
+    const: bosch,m_can
+
+  reg:
+    items:
+      - description: M_CAN registers map
+      - description: message RAM
+
+  reg-names:
+    items:
+      - const: m_can
+      - const: message_ram
+
+  interrupts:
+    items:
+      - description: interrupt line0
+      - description: interrupt line1
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: int0
+      - const: int1
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    items:
+      - description: peripheral clock
+      - description: bus clock
+
+  clock-names:
+    items:
+      - const: hclk
+      - const: cclk
+
+  bosch,mram-cfg:
+    description: |
+                 Message RAM configuration data.
+                 Multiple M_CAN instances can share the same Message RAM
+                 and each element(e.g Rx FIFO or Tx Buffer and etc) number
+                 in Message RAM is also configurable, so this property is
+                 telling driver how the shared or private Message RAM are
+                 used by this M_CAN controller.
+
+                 The format should be as follows:
+                 <offset sidf_elems xidf_elems rxf0_elems rxf1_elems rxb_elems txe_elems txb_elems>
+                 The 'offset' is an address offset of the Message RAM where
+                 the following elements start from. This is usually set to
+                 0x0 if you're using a private Message RAM. The remain cells
+                 are used to specify how many elements are used for each FIFO/Buffer.
+
+                 M_CAN includes the following elements according to user manual:
+                 11-bit Filter	0-128 elements / 0-128 words
+                 29-bit Filter	0-64 elements / 0-128 words
+                 Rx FIFO 0	0-64 elements / 0-1152 words
+                 Rx FIFO 1	0-64 elements / 0-1152 words
+                 Rx Buffers	0-64 elements / 0-1152 words
+                 Tx Event FIFO	0-32 elements / 0-64 words
+                 Tx Buffers	0-32 elements / 0-576 words
+
+                 Please refer to 2.4.1 Message RAM Configuration in Bosch
+                 M_CAN user manual for details.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/int32-array
+      - items:
+         items:
+           - description: The 'offset' is an address offset of the Message RAM
+                          where the following elements start from. This is usually
+                          set to 0x0 if you're using a private Message RAM.
+             default: 0
+           - description: 11-bit Filter 0-128 elements / 0-128 words
+             minimum: 0
+             maximum: 128
+           - description: 29-bit Filter 0-64 elements / 0-128 words
+             minimum: 0
+             maximum: 64
+           - description: Rx FIFO 0 0-64 elements / 0-1152 words
+             minimum: 0
+             maximum: 64
+           - description: Rx FIFO 1 0-64 elements / 0-1152 words
+             minimum: 0
+             maximum: 64
+           - description: Rx Buffers 0-64 elements / 0-1152 words
+             minimum: 0
+             maximum: 64
+           - description: Tx Event FIFO 0-32 elements / 0-64 words
+             minimum: 0
+             maximum: 32
+           - description: Tx Buffers 0-32 elements / 0-576 words
+             minimum: 0
+             maximum: 32
+        maxItems: 1
+
+  can-transceiver:
+    $ref: can-transceiver.yaml#
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - bosch,mram-cfg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx6sx-clock.h>
+    can@20e8000 {
+      compatible = "bosch,m_can";
+      reg = <0x020e8000 0x4000>, <0x02298000 0x4000>;
+      reg-names = "m_can", "message_ram";
+      interrupts = <0 114 0x04>, <0 114 0x04>;
+      interrupt-names = "int0", "int1";
+      clocks = <&clks IMX6SX_CLK_CANFD>,
+               <&clks IMX6SX_CLK_CANFD>;
+      clock-names = "hclk", "cclk";
+      bosch,mram-cfg = <0x0 0 0 32 0 0 0 1>;
+
+      can-transceiver {
+        max-bitrate = <5000000>;
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Documentation/devicetree/bindings/net/can/m_can.txt
deleted file mode 100644
index ed614383af9c..000000000000
--- a/Documentation/devicetree/bindings/net/can/m_can.txt
+++ /dev/null
@@ -1,75 +0,0 @@
-Bosch MCAN controller Device Tree Bindings
--------------------------------------------------
-
-Required properties:
-- compatible		: Should be "bosch,m_can" for M_CAN controllers
-- reg			: physical base address and size of the M_CAN
-			  registers map and Message RAM
-- reg-names		: Should be "m_can" and "message_ram"
-- interrupts		: Should be the interrupt number of M_CAN interrupt
-			  line 0 and line 1, could be same if sharing
-			  the same interrupt.
-- interrupt-names	: Should contain "int0" and "int1"
-- clocks		: Clocks used by controller, should be host clock
-			  and CAN clock.
-- clock-names		: Should contain "hclk" and "cclk"
-- pinctrl-<n>		: Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
-- pinctrl-names 	: Names corresponding to the numbered pinctrl states
-- bosch,mram-cfg	: Message RAM configuration data.
-			  Multiple M_CAN instances can share the same Message
-			  RAM and each element(e.g Rx FIFO or Tx Buffer and etc)
-			  number in Message RAM is also configurable,
-			  so this property is telling driver how the shared or
-			  private Message RAM are used by this M_CAN controller.
-
-			  The format should be as follows:
-			  <offset sidf_elems xidf_elems rxf0_elems rxf1_elems
-			   rxb_elems txe_elems txb_elems>
-			  The 'offset' is an address offset of the Message RAM
-			  where the following elements start from. This is
-			  usually set to 0x0 if you're using a private Message
-			  RAM. The remain cells are used to specify how many
-			  elements are used for each FIFO/Buffer.
-
-			  M_CAN includes the following elements according to user manual:
-			  11-bit Filter	0-128 elements / 0-128 words
-			  29-bit Filter	0-64 elements / 0-128 words
-			  Rx FIFO 0	0-64 elements / 0-1152 words
-			  Rx FIFO 1	0-64 elements / 0-1152 words
-			  Rx Buffers	0-64 elements / 0-1152 words
-			  Tx Event FIFO	0-32 elements / 0-64 words
-			  Tx Buffers	0-32 elements / 0-576 words
-
-			  Please refer to 2.4.1 Message RAM Configuration in
-			  Bosch M_CAN user manual for details.
-
-Optional Subnode:
-- can-transceiver	: Can-transceiver subnode describing maximum speed
-			  that can be used for CAN/CAN-FD modes. See
-			  Documentation/devicetree/bindings/net/can/can-transceiver.txt
-			  for details.
-Example:
-SoC dtsi:
-m_can1: can@20e8000 {
-	compatible = "bosch,m_can";
-	reg = <0x020e8000 0x4000>, <0x02298000 0x4000>;
-	reg-names = "m_can", "message_ram";
-	interrupts = <0 114 0x04>,
-		     <0 114 0x04>;
-	interrupt-names = "int0", "int1";
-	clocks = <&clks IMX6SX_CLK_CANFD>,
-		 <&clks IMX6SX_CLK_CANFD>;
-	clock-names = "hclk", "cclk";
-	bosch,mram-cfg = <0x0 0 0 32 0 0 0 1>;
-};
-
-Board dts:
-&m_can1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_m_can1>;
-	status = "enabled";
-
-	can-transceiver {
-		max-bitrate = <5000000>;
-	};
-};
-- 
2.15.0

