Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9274D28533E
	for <lists+linux-can@lfdr.de>; Tue,  6 Oct 2020 22:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgJFUh5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Oct 2020 16:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgJFUh5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Oct 2020 16:37:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F460C061755
        for <linux-can@vger.kernel.org>; Tue,  6 Oct 2020 13:37:57 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kPtic-0002n3-Du; Tue, 06 Oct 2020 22:37:54 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 09/17] dt-bindings: can: rcar_can: Add r8a7742 support
Date:   Tue,  6 Oct 2020 22:37:40 +0200
Message-Id: <20201006203748.1750156-10-mkl@pengutronix.de>
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

Document RZ/G1H (r8a7742) SoC specific bindings. The R8A7742 CAN module
is identical to R-Car Gen2 family.

No driver change is needed due to the fallback compatible value
"renesas,rcar-gen2-can".

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Link: https://lore.kernel.org/r/20200816190732.6905-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/rcar_can.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
index 85c6551b602a..2099ce809ae7 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
@@ -2,7 +2,8 @@ Renesas R-Car CAN controller Device Tree Bindings
 -------------------------------------------------
 
 Required properties:
-- compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A7743 SoC.
+- compatible: "renesas,can-r8a7742" if CAN controller is a part of R8A7742 SoC.
+	      "renesas,can-r8a7743" if CAN controller is a part of R8A7743 SoC.
 	      "renesas,can-r8a7744" if CAN controller is a part of R8A7744 SoC.
 	      "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
 	      "renesas,can-r8a77470" if CAN controller is a part of R8A77470 SoC.
-- 
2.28.0

