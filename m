Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E77B4934FA
	for <lists+linux-can@lfdr.de>; Wed, 19 Jan 2022 07:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351778AbiASG3z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Jan 2022 01:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351700AbiASG3z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Jan 2022 01:29:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30A1C061574
        for <linux-can@vger.kernel.org>; Tue, 18 Jan 2022 22:29:54 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nA4Th-0007tj-ES
        for linux-can@vger.kernel.org; Wed, 19 Jan 2022 07:29:53 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E90C31D37D
        for <linux-can@vger.kernel.org>; Wed, 19 Jan 2022 06:29:52 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id CFEEA1D379;
        Wed, 19 Jan 2022 06:29:52 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3069d397;
        Wed, 19 Jan 2022 06:29:52 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] dt-bindings: can: tcan4x5x: fix mram-cfg RX FIFO config
Date:   Wed, 19 Jan 2022 07:29:51 +0100
Message-Id: <20220119062951.2939851-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This tcan4x5x only comes with 2K of MRAM, a RX FIFO with a dept of 32
doesn't fit into the MRAM. Use a depth of 16 instead.

Fixes: 4edd396a1911 ("dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
index 0968b40aef1e..e3501bfa22e9 100644
--- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -31,7 +31,7 @@ tcan4x5x: tcan4x5x@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <10000000>;
-		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+		bosch,mram-cfg = <0x0 0 0 16 0 0 1 1>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
 		device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
-- 
2.34.1


