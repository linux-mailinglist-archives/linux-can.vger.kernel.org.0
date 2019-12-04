Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5594311311B
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2019 18:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfLDRxV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Dec 2019 12:53:21 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53190 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfLDRxV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Dec 2019 12:53:21 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB4HrFnI109065;
        Wed, 4 Dec 2019 11:53:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575481995;
        bh=iL2XbLmD+TrHNi/uMsELiJCOuYQfFmOUVnCynnFZPdc=;
        h=From:To:CC:Subject:Date;
        b=C2b+auW9hcSaC/m3uLidmaCMnA7SYbKMHz9xjCuYyd+VJauLtN1SQUIfHtEotKs5f
         P3CPluvvS+cg6l+mop5hs8VIxwoB4H7dsiutq7LWDfuRZ5lBqhcSKOu/ZRRbyqBTDI
         5cEsEVwxSllLgn9nu7/Ve6zwtjFOlgOUP9/AWcSM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB4HrFI7040834
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Dec 2019 11:53:15 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Dec
 2019 11:53:15 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Dec 2019 11:53:15 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB4HrF6Y012761;
        Wed, 4 Dec 2019 11:53:15 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] dt-bindings: tcan4x5x: Make wake-gpio an optional gpio
Date:   Wed, 4 Dec 2019 11:51:11 -0600
Message-ID: <20191204175112.7308-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The wake-up of the device can be configured as an optional
feature of the device.  Move the wake-up gpio from a requried
property to an optional property.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
CC: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
index 27e1b4cebfbd..7cf5ef7acba4 100644
--- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -10,7 +10,6 @@ Required properties:
 	- #size-cells: 0
 	- spi-max-frequency: Maximum frequency of the SPI bus the chip can
 			     operate at should be less than or equal to 18 MHz.
-	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
 	- interrupt-parent: the phandle to the interrupt controller which provides
                     the interrupt.
 	- interrupts: interrupt specification for data-ready.
@@ -23,6 +22,7 @@ Optional properties:
 		       reset.
 	- device-state-gpios: Input GPIO that indicates if the device is in
 			      a sleep state or if the device is active.
+	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
 
 Example:
 tcan4x5x: tcan4x5x@0 {
-- 
2.23.0

