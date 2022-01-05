Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C854854DB
	for <lists+linux-can@lfdr.de>; Wed,  5 Jan 2022 15:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbiAEOoR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jan 2022 09:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbiAEOoQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jan 2022 09:44:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D98C061784
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 06:44:15 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n57WQ-000445-6r
        for linux-can@vger.kernel.org; Wed, 05 Jan 2022 15:44:14 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 687BB6D1AF7
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 14:44:08 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 0EB266D1ABF;
        Wed,  5 Jan 2022 14:44:05 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 77da45af;
        Wed, 5 Jan 2022 14:44:04 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 05/15] can: sja1000: sp_probe(): use platform_get_irq() to get the interrupt
Date:   Wed,  5 Jan 2022 15:43:52 +0100
Message-Id: <20220105144402.1174191-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105144402.1174191-1-mkl@pengutronix.de>
References: <20220105144402.1174191-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

It is preferred that drivers use platform_get_irq() instead of
irq_of_parse_and_map(), so replace.

Link: https://lore.kernel.org/all/20211221200016.13459-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000_platform.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index d7c2ec529b8f..f9ec7bd8dfac 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -17,7 +17,6 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_irq.h>
 
 #include "sja1000.h"
 
@@ -234,13 +233,15 @@ static int sp_probe(struct platform_device *pdev)
 	if (!addr)
 		return -ENOMEM;
 
-	if (of)
-		irq = irq_of_parse_and_map(of, 0);
-	else
+	if (of) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0)
+			return irq;
+	} else {
 		res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-
-	if (!irq && !res_irq)
-		return -ENODEV;
+		if (!res_irq)
+			return -ENODEV;
+	}
 
 	of_id = of_match_device(sp_of_table, &pdev->dev);
 	if (of_id && of_id->data) {
-- 
2.34.1


