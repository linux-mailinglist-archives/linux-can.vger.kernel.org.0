Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3844E2F64BD
	for <lists+linux-can@lfdr.de>; Thu, 14 Jan 2021 16:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbhANPfg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Jan 2021 10:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbhANPff (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Jan 2021 10:35:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748A8C061757
        for <linux-can@vger.kernel.org>; Thu, 14 Jan 2021 07:34:55 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l04eE-0004W3-1V
        for linux-can@vger.kernel.org; Thu, 14 Jan 2021 16:34:54 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 1DE635C3C69
        for <linux-can@vger.kernel.org>; Thu, 14 Jan 2021 15:34:51 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id F0E6B5C3C56;
        Thu, 14 Jan 2021 15:34:49 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 67196e80;
        Thu, 14 Jan 2021 15:34:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/6] can: mcp251xfd: mcp251xfd_tx_obj_from_skb(): clean up padding of CAN-FD frames
Date:   Thu, 14 Jan 2021 16:34:44 +0100
Message-Id: <20210114153448.1506901-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114153448.1506901-1-mkl@pengutronix.de>
References: <20210114153448.1506901-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

CAN-FD frames have only specific frame length (0, 1, 2, 3, 4, 5, 6, 7, 8, 12,
16, 20, 24, 32, 48, 64). A CAN-FD frame provided by user space might not cover
the whole CAN-FD frame. To avoid sending garbage over the CAN bus the driver
pads the CAN frame with 0x0 (if MCP251XFD_SANITIZE_CAN is activated).

This patch cleans up the pad len calculation. Rounding to full u32 brings no
benefit, in case of CRC transfers, the hw_tx_obj->data is not aligned to u32
anyway.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 73e048607223..a8470e081ff0 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2300,7 +2300,7 @@ mcp251xfd_tx_obj_from_skb(const struct mcp251xfd_priv *priv,
 	union mcp251xfd_tx_obj_load_buf *load_buf;
 	u8 dlc;
 	u32 id, flags;
-	int offset, len;
+	int pad_len, len;
 
 	if (cfd->can_id & CAN_EFF_FLAG) {
 		u32 sid, eid;
@@ -2348,13 +2348,14 @@ mcp251xfd_tx_obj_from_skb(const struct mcp251xfd_priv *priv,
 	put_unaligned_le32(id, &hw_tx_obj->id);
 	put_unaligned_le32(flags, &hw_tx_obj->flags);
 
-	/* Clear data at end of CAN frame */
-	offset = round_down(cfd->len, sizeof(u32));
-	len = round_up(can_fd_dlc2len(dlc), sizeof(u32)) - offset;
-	if (MCP251XFD_SANITIZE_CAN && len)
-		memset(hw_tx_obj->data + offset, 0x0, len);
+	/* Copy data */
 	memcpy(hw_tx_obj->data, cfd->data, cfd->len);
 
+	/* Clear unused data at end of CAN frame */
+	pad_len = can_fd_dlc2len(dlc) - cfd->len;
+	if (MCP251XFD_SANITIZE_CAN && pad_len)
+		memset(hw_tx_obj->data + cfd->len, 0x0, pad_len);
+
 	/* Number of bytes to be written into the RAM of the controller */
 	len = sizeof(hw_tx_obj->id) + sizeof(hw_tx_obj->flags);
 	if (MCP251XFD_SANITIZE_CAN)
-- 
2.29.2


