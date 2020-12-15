Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FAF2DAAF5
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 11:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgLOKd0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 05:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgLOKd0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 05:33:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A29C0617B0
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 02:32:44 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kp7dL-0006LP-HL
        for linux-can@vger.kernel.org; Tue, 15 Dec 2020 11:32:43 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id AC7B55ADD1B
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 10:32:41 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8630F5ADD0B;
        Tue, 15 Dec 2020 10:32:40 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5e9472fb;
        Tue, 15 Dec 2020 10:32:39 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-rfc 2/2] can: tcan4x5x: fix bittiming const, use common bittiming from m_can driver
Date:   Tue, 15 Dec 2020 11:32:38 +0100
Message-Id: <20201215103238.524029-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215103238.524029-1-mkl@pengutronix.de>
References: <20201215103238.524029-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

According to the TCAN4550 datasheet "SLLSF91 - DECEMBER 2018" the tcan4x5x has
the same bittiming constants as a m_can revision 3.2.x/3.3.0.

The tcan4x5x chip I'm using identifies itself as m_can revision 3.2.1, so
remove the tcan4x5x specific bittiming values and rely on the values in the
m_can driver, which are selected according to core revision.

Fixes: 5443c226ba91 ("can: tcan4x5x: Add tcan4x5x driver to the kernel")
Cc: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 7347ab39c5b6..f726c5112294 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -129,30 +129,6 @@ struct tcan4x5x_priv {
 	int reg_offset;
 };
 
-static struct can_bittiming_const tcan4x5x_bittiming_const = {
-	.name = DEVICE_NAME,
-	.tseg1_min = 2,
-	.tseg1_max = 31,
-	.tseg2_min = 2,
-	.tseg2_max = 16,
-	.sjw_max = 16,
-	.brp_min = 1,
-	.brp_max = 32,
-	.brp_inc = 1,
-};
-
-static struct can_bittiming_const tcan4x5x_data_bittiming_const = {
-	.name = DEVICE_NAME,
-	.tseg1_min = 1,
-	.tseg1_max = 32,
-	.tseg2_min = 1,
-	.tseg2_max = 16,
-	.sjw_max = 16,
-	.brp_min = 1,
-	.brp_max = 32,
-	.brp_inc = 1,
-};
-
 static void tcan4x5x_check_wake(struct tcan4x5x_priv *priv)
 {
 	int wake_state = 0;
@@ -479,8 +455,6 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	mcan_class->dev = &spi->dev;
 	mcan_class->ops = &tcan4x5x_ops;
 	mcan_class->is_peripheral = true;
-	mcan_class->bit_timing = &tcan4x5x_bittiming_const;
-	mcan_class->data_timing = &tcan4x5x_data_bittiming_const;
 	mcan_class->net->irq = spi->irq;
 
 	spi_set_drvdata(spi, priv);
-- 
2.29.2


