Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C056B2DB7A9
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 01:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgLPABS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 19:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbgLOXZI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 18:25:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BA5C06179C
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 15:17:59 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kpJZt-0002Su-K3
        for linux-can@vger.kernel.org; Wed, 16 Dec 2020 00:17:57 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 15EBF5AE3C5
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 23:17:52 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 092DE5AE39F;
        Tue, 15 Dec 2020 23:17:50 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 05dd763f;
        Tue, 15 Dec 2020 23:17:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 02/16] can: tcan4x5x: beautify indention of tcan4x5x_of_match and tcan4x5x_id_table
Date:   Wed, 16 Dec 2020 00:17:32 +0100
Message-Id: <20201215231746.1132907-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215231746.1132907-1-mkl@pengutronix.de>
References: <20201215231746.1132907-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch beautifies the indention of the tcan4x5x_of_match and
tcan4x5x_id_table.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 1b5f706674af..1b47c9d32c30 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -527,17 +527,20 @@ static int tcan4x5x_can_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id tcan4x5x_of_match[] = {
-	{ .compatible = "ti,tcan4x5x", },
-	{ }
+	{
+		.compatible = "ti,tcan4x5x",
+	}, {
+		/* sentinel */
+	},
 };
 MODULE_DEVICE_TABLE(of, tcan4x5x_of_match);
 
 static const struct spi_device_id tcan4x5x_id_table[] = {
 	{
-		.name		= "tcan4x5x",
-		.driver_data	= 0,
+		.name = "tcan4x5x",
+	}, {
+		/* sentinel */
 	},
-	{ }
 };
 MODULE_DEVICE_TABLE(spi, tcan4x5x_id_table);
 
-- 
2.29.2


