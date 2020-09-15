Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173AA26B1E1
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 00:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgIOWhK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Sep 2020 18:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbgIOWff (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 18:35:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121D9C061353
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2020 15:35:33 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIJXv-0002Tb-40; Wed, 16 Sep 2020 00:35:31 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 08/37] can: softing: update dead link
Date:   Wed, 16 Sep 2020 00:34:58 +0200
Message-Id: <20200915223527.1417033-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915223527.1417033-1-mkl@pengutronix.de>
References: <20200915223527.1417033-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Diego Elio Pettenò <flameeyes@flameeyes.com>

BerliOS has not been operating for more than five years. linux-can moved to
GitHub.

Signed-off-by: Diego Elio Pettenò <flameeyes@flameeyes.com>
Link: https://lore.kernel.org/r/20200413170241.13207-1-flameeyes@flameeyes.com
[mkl: split into two patches - handle softing part here]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/softing/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/softing/Kconfig b/drivers/net/can/softing/Kconfig
index 9edc73b13014..8afd7d0a1000 100644
--- a/drivers/net/can/softing/Kconfig
+++ b/drivers/net/can/softing/Kconfig
@@ -24,7 +24,7 @@ config CAN_SOFTING_CS
 	  Support for PCMCIA cards from Softing Gmbh & some cards
 	  from Vector Gmbh.
 	  You need firmware for these, which you can get at
-	  http://developer.berlios.de/projects/socketcan/
+	  https://github.com/linux-can/can-firmware
 	  This version of the driver is written against
 	  firmware version 4.6 (softing-fw-4.6-binaries.tar.gz)
 	  In order to use the card as CAN device, you need the Softing generic
-- 
2.28.0

