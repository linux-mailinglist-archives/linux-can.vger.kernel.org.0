Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0A3285341
	for <lists+linux-can@lfdr.de>; Tue,  6 Oct 2020 22:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgJFUh6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Oct 2020 16:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgJFUh5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Oct 2020 16:37:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A7CC0613D2
        for <linux-can@vger.kernel.org>; Tue,  6 Oct 2020 13:37:57 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kPtid-0002n3-Ie; Tue, 06 Oct 2020 22:37:55 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Michael Walle <michael@walle.cc>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 12/17] dt-bindings: can: flexcan: list supported processors
Date:   Tue,  6 Oct 2020 22:37:43 +0200
Message-Id: <20201006203748.1750156-13-mkl@pengutronix.de>
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

From: Michael Walle <michael@walle.cc>

The compatible is a pattern match. Explicitly list all possible values.
Also mention that the ls1028ar1 must be followed by lx2160ar1.

Signed-off-by: Michael Walle <michael@walle.cc>
Link: https://lore.kernel.org/r/20201001091131.30514-2-michael@walle.cc
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index 94c0f8bf4deb..c6152dc2d2d0 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -4,6 +4,12 @@ Required properties:
 
 - compatible : Should be "fsl,<processor>-flexcan"
 
+  where <processor> is imx8qm, imx6q, imx28, imx53, imx35, imx25, p1010,
+  vf610, ls1021ar2, lx2160ar1, ls1028ar1.
+
+  The ls1028ar1 must be followed by lx2160ar1, e.g.
+   - "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-flexcan"
+
   An implementation should also claim any of the following compatibles
   that it is fully backwards compatible with:
 
-- 
2.28.0

