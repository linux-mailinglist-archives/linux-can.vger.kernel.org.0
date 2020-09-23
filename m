Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FCA2754EE
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 11:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIWJ5h (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 05:57:37 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:50369 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIWJ5h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 05:57:37 -0400
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5DD3223E46;
        Wed, 23 Sep 2020 11:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1600855054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v/THBDWHjinc6YkEQTDvQltoa6qIrDED6upRwuC7cLU=;
        b=c1G4oJDZWtbrQbi3/m2aqKRaoyjbNPbiu1NcTXWzMn72m8pjDPtFJEhKnG4JCR2Y6t3Lv0
        qo1I0eNQyKSgYrvBX8htsgWe+jAn88iJluXKPxxXTyqlaTaZ3VRcamEcY+gFcVLdv5Z2Ts
        Ue+g3JHsd1bu+qKoacfmpyu+VQHmybs=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] arm64: dts: ls1028a: add missing CAN nodes
Date:   Wed, 23 Sep 2020 11:57:10 +0200
Message-Id: <20200923095711.11355-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200923095711.11355-1-michael@walle.cc>
References: <20200923095711.11355-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The LS1028A has two FlexCAN controller. These are compatible with
the ones from the LX2160A. Add the nodes.

The first controller was tested on the Kontron sl28 board.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 0efeb8fa773e..807ee921ec12 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -386,6 +386,24 @@
 			status = "disabled";
 		};
 
+		can0: can@2180000 {
+			compatible = "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-flexcan";
+			reg = <0x0 0x2180000 0x0 0x10000>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk>, <&clockgen 4 1>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+
+		can1: can@2190000 {
+			compatible = "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-flexcan";
+			reg = <0x0 0x2190000 0x0 0x10000>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk>, <&clockgen 4 1>;
+			clock-names = "ipg", "per";
+			status = "disabled";
+		};
+
 		duart0: serial@21c0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0500 0x0 0x100>;
-- 
2.20.1

