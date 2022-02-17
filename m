Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C134B9D53
	for <lists+linux-can@lfdr.de>; Thu, 17 Feb 2022 11:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbiBQKit (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Feb 2022 05:38:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbiBQKiq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 05:38:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7613284D1A
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 02:38:32 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nKeBD-0003cE-1Q
        for linux-can@vger.kernel.org; Thu, 17 Feb 2022 11:38:31 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 77A01362BB
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 10:38:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 43E59362A4;
        Thu, 17 Feb 2022 10:38:28 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b2ad4031;
        Thu, 17 Feb 2022 10:38:27 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 5/8] can: mcp251xfd: ring: mcp251xfd_ring_init(): checked RAM usage of ring setup
Date:   Thu, 17 Feb 2022 11:38:23 +0100
Message-Id: <20220217103826.2299157-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217103826.2299157-1-mkl@pengutronix.de>
References: <20220217103826.2299157-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With this patch the usage of the on-chip RAM is checked. In the
current driver the FIFO setup is fixed and always fits into the RAM.

With an upcoming patch series the ring and FIFO setup will be more
dynamic. Although using more RAM than available should not happen, but
add this safety check, just in case.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c |  4 +++-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c | 14 ++++++++++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h      |  2 +-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index e5641696cdc2..2d033d12cdbb 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -760,7 +760,9 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 	if (err)
 		goto out_chip_stop;
 
-	mcp251xfd_ring_init(priv);
+	err = mcp251xfd_ring_init(priv);
+	if (err)
+		goto out_chip_stop;
 
 	err = mcp251xfd_chip_fifo_init(priv);
 	if (err)
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index 9657dbf251b0..8126f88d57d7 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -207,9 +207,9 @@ mcp251xfd_ring_init_rx(struct mcp251xfd_priv *priv, u16 *base, u8 *fifo_nr)
 	}
 }
 
-void mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
+int mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 {
-	u16 base = 0;
+	u16 base = 0, ram_used;
 	u8 fifo_nr = 1;
 
 	netdev_reset_queue(priv->ndev);
@@ -217,6 +217,16 @@ void mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 	mcp251xfd_ring_init_tef(priv, &base);
 	mcp251xfd_ring_init_rx(priv, &base, &fifo_nr);
 	mcp251xfd_ring_init_tx(priv, &base, &fifo_nr);
+
+	ram_used = base - MCP251XFD_RAM_START;
+	if (ram_used > MCP251XFD_RAM_SIZE) {
+		netdev_err(priv->ndev,
+			   "Error during ring configuration, using more RAM (%u bytes) than available (%u bytes).\n",
+			   ram_used, MCP251XFD_RAM_SIZE);
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 void mcp251xfd_ring_free(struct mcp251xfd_priv *priv)
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 8ee959890aea..58e76064cf9e 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -882,7 +882,7 @@ u16 mcp251xfd_crc16_compute2(const void *cmd, size_t cmd_size,
 			     const void *data, size_t data_size);
 u16 mcp251xfd_crc16_compute(const void *data, size_t data_size);
 int mcp251xfd_regmap_init(struct mcp251xfd_priv *priv);
-void mcp251xfd_ring_init(struct mcp251xfd_priv *priv);
+int mcp251xfd_ring_init(struct mcp251xfd_priv *priv);
 void mcp251xfd_ring_free(struct mcp251xfd_priv *priv);
 int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv);
 int mcp251xfd_handle_rxif(struct mcp251xfd_priv *priv);
-- 
2.34.1


