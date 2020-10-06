Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA8285340
	for <lists+linux-can@lfdr.de>; Tue,  6 Oct 2020 22:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgJFUh5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Oct 2020 16:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgJFUh5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Oct 2020 16:37:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ADEC061755
        for <linux-can@vger.kernel.org>; Tue,  6 Oct 2020 13:37:57 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kPtid-0002n3-9Z; Tue, 06 Oct 2020 22:37:55 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 11/17] dt-bindings: can: rcar_can: Document r8a774e1 support
Date:   Tue,  6 Oct 2020 22:37:42 +0200
Message-Id: <20201006203748.1750156-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006203748.1750156-1-mkl@pengutronix.de>
References: <20201006203748.1750156-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document SoC specific bindings for RZ/G2H (R8A774E1) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20201005081319.29322-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/rcar_can.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
index 2099ce809ae7..6a5956347816 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
@@ -10,6 +10,7 @@ Required properties:
 	      "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 SoC.
 	      "renesas,can-r8a774b1" if CAN controller is a part of R8A774B1 SoC.
 	      "renesas,can-r8a774c0" if CAN controller is a part of R8A774C0 SoC.
+	      "renesas,can-r8a774e1" if CAN controller is a part of R8A774E1 SoC.
 	      "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
 	      "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
 	      "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.
@@ -38,8 +39,8 @@ Required properties:
 - pinctrl-0: pin control group to be used for this controller.
 - pinctrl-names: must be "default".
 
-Required properties for R8A774A1, R8A774B1, R8A774C0, R8A7795, R8A7796,
-R8A77965, R8A77990, and R8A77995:
+Required properties for R8A774A1, R8A774B1, R8A774C0, R8A774E1, R8A7795,
+R8A7796, R8A77965, R8A77990, and R8A77995:
 For the denoted SoCs, "clkp2" can be CANFD clock. This is a div6 clock and can
 be used by both CAN and CAN FD controller at the same time. It needs to be
 scaled to maximum frequency if any of these controllers use it. This is done
-- 
2.28.0

