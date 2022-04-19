Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA975065D8
	for <lists+linux-can@lfdr.de>; Tue, 19 Apr 2022 09:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349373AbiDSHaw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Apr 2022 03:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241889AbiDSHav (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Apr 2022 03:30:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C754331DDB
        for <linux-can@vger.kernel.org>; Tue, 19 Apr 2022 00:28:09 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ngiHQ-0004v2-96
        for linux-can@vger.kernel.org; Tue, 19 Apr 2022 09:28:08 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 3E26265BB5
        for <linux-can@vger.kernel.org>; Tue, 19 Apr 2022 07:28:07 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D61A265BA8;
        Tue, 19 Apr 2022 07:28:06 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b3b31aa6;
        Tue, 19 Apr 2022 07:28:06 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>, kernel@pengutronix.de,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: [PATCH 2/2] can: mcp251xfd: add support for mcp251863
Date:   Tue, 19 Apr 2022 09:28:05 +0200
Message-Id: <20220419072805.2840340-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419072805.2840340-1-mkl@pengutronix.de>
References: <20220419072805.2840340-1-mkl@pengutronix.de>
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

The MCP251863 device is a CAN-FD controller (MCP2518FD) with an
integrated Transceiver (ATA6563). This patch add support for the new
device.

Cc: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 19 +++++++++++++++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     | 12 +++++++-----
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 230ec60003fc..b21252390216 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -37,6 +37,12 @@ static const struct mcp251xfd_devtype_data mcp251xfd_devtype_data_mcp2518fd = {
 	.model = MCP251XFD_MODEL_MCP2518FD,
 };
 
+static const struct mcp251xfd_devtype_data mcp251xfd_devtype_data_mcp251863 = {
+	.quirks = MCP251XFD_QUIRK_CRC_REG | MCP251XFD_QUIRK_CRC_RX |
+		MCP251XFD_QUIRK_CRC_TX | MCP251XFD_QUIRK_ECC,
+	.model = MCP251XFD_MODEL_MCP251863,
+};
+
 /* Autodetect model, start with CRC enabled. */
 static const struct mcp251xfd_devtype_data mcp251xfd_devtype_data_mcp251xfd = {
 	.quirks = MCP251XFD_QUIRK_CRC_REG | MCP251XFD_QUIRK_CRC_RX |
@@ -75,6 +81,8 @@ static const char *__mcp251xfd_get_model_str(enum mcp251xfd_model model)
 		return "MCP2517FD";
 	case MCP251XFD_MODEL_MCP2518FD:
 		return "MCP2518FD";
+	case MCP251XFD_MODEL_MCP251863:
+		return "MCP251863";
 	case MCP251XFD_MODEL_MCP251XFD:
 		return "MCP251xFD";
 	}
@@ -1259,7 +1267,8 @@ mcp251xfd_handle_eccif_recover(struct mcp251xfd_priv *priv, u8 nr)
 	 * - for mcp2518fd: offset not 0 or 1
 	 */
 	if (chip_tx_tail != tx_tail ||
-	    !(offset == 0 || (offset == 1 && mcp251xfd_is_2518(priv)))) {
+	    !(offset == 0 || (offset == 1 && (mcp251xfd_is_2518FD(priv) ||
+					      mcp251xfd_is_251863(priv))))) {
 		netdev_err(priv->ndev,
 			   "ECC Error information inconsistent (addr=0x%04x, nr=%d, tx_tail=0x%08x(%d), chip_tx_tail=%d, offset=%d).\n",
 			   addr, nr, tx_ring->tail, tx_tail, chip_tx_tail,
@@ -1697,7 +1706,7 @@ static int mcp251xfd_register_chip_detect(struct mcp251xfd_priv *priv)
 	else
 		devtype_data = &mcp251xfd_devtype_data_mcp2517fd;
 
-	if (!mcp251xfd_is_251X(priv) &&
+	if (!mcp251xfd_is_251XFD(priv) &&
 	    priv->devtype_data.model != devtype_data->model) {
 		netdev_info(ndev,
 			    "Detected %s, but firmware specifies a %s. Fixing up.\n",
@@ -1929,6 +1938,9 @@ static const struct of_device_id mcp251xfd_of_match[] = {
 	}, {
 		.compatible = "microchip,mcp2518fd",
 		.data = &mcp251xfd_devtype_data_mcp2518fd,
+	}, {
+		.compatible = "microchip,mcp251863",
+		.data = &mcp251xfd_devtype_data_mcp251863,
 	}, {
 		.compatible = "microchip,mcp251xfd",
 		.data = &mcp251xfd_devtype_data_mcp251xfd,
@@ -1945,6 +1957,9 @@ static const struct spi_device_id mcp251xfd_id_table[] = {
 	}, {
 		.name = "mcp2518fd",
 		.driver_data = (kernel_ulong_t)&mcp251xfd_devtype_data_mcp2518fd,
+	}, {
+		.name = "mcp251863",
+		.driver_data = (kernel_ulong_t)&mcp251xfd_devtype_data_mcp251863,
 	}, {
 		.name = "mcp251xfd",
 		.driver_data = (kernel_ulong_t)&mcp251xfd_devtype_data_mcp251xfd,
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 9cb6b5ad8dda..1d43bccc29bf 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -586,7 +586,8 @@ struct mcp251xfd_regs_status {
 enum mcp251xfd_model {
 	MCP251XFD_MODEL_MCP2517FD = 0x2517,
 	MCP251XFD_MODEL_MCP2518FD = 0x2518,
-	MCP251XFD_MODEL_MCP251XFD = 0xffff,	/* autodetect model */
+	MCP251XFD_MODEL_MCP251863 = 0x251863,
+	MCP251XFD_MODEL_MCP251XFD = 0xffffffff,	/* autodetect model */
 };
 
 struct mcp251xfd_devtype_data {
@@ -659,12 +660,13 @@ struct mcp251xfd_priv {
 static inline bool \
 mcp251xfd_is_##_model(const struct mcp251xfd_priv *priv) \
 { \
-	return priv->devtype_data.model == MCP251XFD_MODEL_MCP##_model##FD; \
+	return priv->devtype_data.model == MCP251XFD_MODEL_MCP##_model; \
 }
 
-MCP251XFD_IS(2517);
-MCP251XFD_IS(2518);
-MCP251XFD_IS(251X);
+MCP251XFD_IS(2517FD);
+MCP251XFD_IS(2518FD);
+MCP251XFD_IS(251863);
+MCP251XFD_IS(251XFD);
 
 static inline bool mcp251xfd_is_fd_mode(const struct mcp251xfd_priv *priv)
 {
-- 
2.35.1


