Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1436736C7
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 12:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjASL2x (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 06:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjASL2w (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 06:28:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AE36DB33
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 03:28:49 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pIT67-0003st-RB
        for linux-can@vger.kernel.org; Thu, 19 Jan 2023 12:28:47 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id BAAB215D1AA
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 11:28:45 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4DD8115D18B;
        Thu, 19 Jan 2023 11:28:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f29041ab;
        Thu, 19 Jan 2023 11:28:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        =?UTF-8?q?Stefan=20Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 1/5] can: mcp251xfd: setup timestamping before mcp251xfd_ring_init()
Date:   Thu, 19 Jan 2023 12:28:38 +0100
Message-Id: <20230119112842.500709-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119112842.500709-1-mkl@pengutronix.de>
References: <20230119112842.500709-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is a preparation patch.

An upcoming patch needs a valid timestamp in the callstack of
mcp251xfd_ring_init().

Move the initialization of the timestamp into mcp251xfd_chip_start()
before calling mcp251xfd_ring_init(). Move mcp251xfd_timestamp_stop()
accordingly.

Tested-by: Stefan Althöfer <Stefan.Althoefer@janztec.com>
Tested-by: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 68df6d4641b5..4c0e3580efc1 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -736,6 +736,7 @@ static void mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
 {
 	priv->can.state = state;
 
+	mcp251xfd_timestamp_stop(priv);
 	mcp251xfd_chip_interrupts_disable(priv);
 	mcp251xfd_chip_rx_int_disable(priv);
 	mcp251xfd_chip_sleep(priv);
@@ -757,34 +758,38 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 	if (err)
 		goto out_chip_stop;
 
+	mcp251xfd_timestamp_init(priv);
+	
 	err = mcp251xfd_set_bittiming(priv);
 	if (err)
-		goto out_chip_stop;
+		goto out_timestamp_stop;
 
 	err = mcp251xfd_chip_rx_int_enable(priv);
 	if (err)
-		goto out_chip_stop;
+		goto out_timestamp_stop;
 
 	err = mcp251xfd_chip_ecc_init(priv);
 	if (err)
-		goto out_chip_stop;
+		goto out_timestamp_stop;
 
 	err = mcp251xfd_ring_init(priv);
 	if (err)
-		goto out_chip_stop;
+		goto out_timestamp_stop;
 
 	err = mcp251xfd_chip_fifo_init(priv);
 	if (err)
-		goto out_chip_stop;
+		goto out_timestamp_stop;
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	err = mcp251xfd_chip_set_normal_mode(priv);
 	if (err)
-		goto out_chip_stop;
+		goto out_timestamp_stop;
 
 	return 0;
 
+ out_timestamp_stop:
+	mcp251xfd_timestamp_stop(priv);
  out_chip_stop:
 	mcp251xfd_dump(priv);
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
@@ -1608,7 +1613,6 @@ static int mcp251xfd_open(struct net_device *ndev)
 	if (err)
 		goto out_transceiver_disable;
 
-	mcp251xfd_timestamp_init(priv);
 	clear_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
 	can_rx_offload_enable(&priv->offload);
 
@@ -1631,7 +1635,6 @@ static int mcp251xfd_open(struct net_device *ndev)
  out_can_rx_offload_disable:
 	can_rx_offload_disable(&priv->offload);
 	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
-	mcp251xfd_timestamp_stop(priv);
  out_transceiver_disable:
 	mcp251xfd_transceiver_disable(priv);
  out_mcp251xfd_ring_free:
@@ -1656,7 +1659,6 @@ static int mcp251xfd_stop(struct net_device *ndev)
 	mcp251xfd_chip_interrupts_disable(priv);
 	free_irq(ndev->irq, priv);
 	can_rx_offload_disable(&priv->offload);
-	mcp251xfd_timestamp_stop(priv);
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
 	mcp251xfd_transceiver_disable(priv);
 	mcp251xfd_ring_free(priv);
-- 
2.39.0


