Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DE9355184
	for <lists+linux-can@lfdr.de>; Tue,  6 Apr 2021 13:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbhDFLGc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Apr 2021 07:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbhDFLGb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Apr 2021 07:06:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443FFC06174A
        for <linux-can@vger.kernel.org>; Tue,  6 Apr 2021 04:06:24 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lTjXK-0007pY-Rk
        for linux-can@vger.kernel.org; Tue, 06 Apr 2021 13:06:22 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id EB5EC6086CD
        for <linux-can@vger.kernel.org>; Tue,  6 Apr 2021 11:06:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 300816086BC;
        Tue,  6 Apr 2021 11:06:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 65d87bc9;
        Tue, 6 Apr 2021 11:06:18 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: [can-next-rfc 3/4] can: mcp251xfd: mcp251xfd_regmap_crc_read_one(): Factor out crc check into separate function
Date:   Tue,  6 Apr 2021 13:06:16 +0200
Message-Id: <20210406110617.1865592-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406110617.1865592-1-mkl@pengutronix.de>
References: <20210406110617.1865592-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch factors out the crc check into a separate function. This is
preparation for the next patch.

Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 30 ++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 314f868b3465..35557ac43c03 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -232,13 +232,31 @@ mcp251xfd_regmap_crc_write(void *context,
 						 count - data_offset);
 }
 
+static int
+mcp251xfd_regmap_crc_read_check_crc(const struct mcp251xfd_map_buf_crc * const buf_rx,
+				    const struct mcp251xfd_map_buf_crc * const buf_tx,
+				    unsigned int data_len)
+{
+	u16 crc_received, crc_calculated;
+
+	crc_received = get_unaligned_be16(buf_rx->data + data_len);
+	crc_calculated = mcp251xfd_crc16_compute2(&buf_tx->cmd,
+						  sizeof(buf_tx->cmd),
+						  buf_rx->data,
+						  data_len);
+	if (crc_received != crc_calculated)
+		return -EBADMSG;
+
+	return 0;
+}
+
+
 static int
 mcp251xfd_regmap_crc_read_one(struct mcp251xfd_priv *priv,
 			      struct spi_message *msg, unsigned int data_len)
 {
 	const struct mcp251xfd_map_buf_crc *buf_rx = priv->map_buf_crc_rx;
 	const struct mcp251xfd_map_buf_crc *buf_tx = priv->map_buf_crc_tx;
-	u16 crc_received, crc_calculated;
 	int err;
 
 	BUILD_BUG_ON(sizeof(buf_rx->cmd) != sizeof(__be16) + sizeof(u8));
@@ -248,15 +266,7 @@ mcp251xfd_regmap_crc_read_one(struct mcp251xfd_priv *priv,
 	if (err)
 		return err;
 
-	crc_received = get_unaligned_be16(buf_rx->data + data_len);
-	crc_calculated = mcp251xfd_crc16_compute2(&buf_tx->cmd,
-						  sizeof(buf_tx->cmd),
-						  buf_rx->data,
-						  data_len);
-	if (crc_received != crc_calculated)
-		return -EBADMSG;
-
-	return 0;
+	return mcp251xfd_regmap_crc_read_check_crc(buf_rx, buf_tx, data_len);
 }
 
 static int
-- 
2.30.2


