Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9419B5DA
	for <lists+linux-can@lfdr.de>; Fri, 23 Aug 2019 19:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfHWRvW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Aug 2019 13:51:22 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35254 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfHWRvW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Aug 2019 13:51:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7NHpHoR011757;
        Fri, 23 Aug 2019 12:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566582677;
        bh=etS+2Gmyl1yYgVrWZXMyu2hBcj/5vVbIb8J2vvnliUI=;
        h=From:To:CC:Subject:Date;
        b=fOJzl/mltuJrToht8ZaukIwX+Ph+X1+2akmA+T/rtRyj0qfkeZ50pREwqhsx+d41r
         wPCTLnY61+m0XbrKcTxXSHZY9grA//EQHgLJR2cq1hnLtiG8D5ubVbOSOMc1O83YgI
         yiYj9NyL0rTIx8pGcF4rZ5vSHJBOkj3+xZimjRng=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7NHpHDw045580
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Aug 2019 12:51:17 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 23
 Aug 2019 12:51:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 23 Aug 2019 12:51:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7NHpHJU051287;
        Fri, 23 Aug 2019 12:51:17 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-can@vger.kernel.org>, <mkl@pengutronix.de>
CC:     Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/3] dt-bindings: can: tcan4x5x: Update binding to use interrupt property
Date:   Fri, 23 Aug 2019 12:50:56 -0500
Message-ID: <20190823175058.7442-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Remove the data-ready-gpio property in favor of the DT standard
interrupt-parent and interrupts.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
index c388f7d9feb1..27e1b4cebfbd 100644
--- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -10,8 +10,10 @@ Required properties:
 	- #size-cells: 0
 	- spi-max-frequency: Maximum frequency of the SPI bus the chip can
 			     operate at should be less than or equal to 18 MHz.
-	- data-ready-gpios: Interrupt GPIO for data and error reporting.
 	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
+	- interrupt-parent: the phandle to the interrupt controller which provides
+                    the interrupt.
+	- interrupts: interrupt specification for data-ready.
 
 See Documentation/devicetree/bindings/net/can/m_can.txt for additional
 required property details.
@@ -30,7 +32,8 @@ tcan4x5x: tcan4x5x@0 {
 		#size-cells = <1>;
 		spi-max-frequency = <10000000>;
 		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
-		data-ready-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <14 GPIO_ACTIVE_LOW>;
 		device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
 		device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
-- 
2.22.0.214.g8dca754b1e

