Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75542C5528
	for <lists+linux-can@lfdr.de>; Thu, 26 Nov 2020 14:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389788AbgKZNVx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 26 Nov 2020 08:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389790AbgKZNVw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 26 Nov 2020 08:21:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CA2C061A47
        for <linux-can@vger.kernel.org>; Thu, 26 Nov 2020 05:21:52 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kiHDa-000179-O9
        for linux-can@vger.kernel.org; Thu, 26 Nov 2020 14:21:50 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 78E5E59C40B
        for <linux-can@vger.kernel.org>; Thu, 26 Nov 2020 13:21:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E828059C3F6;
        Thu, 26 Nov 2020 13:21:46 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 450cee75;
        Thu, 26 Nov 2020 13:21:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next v2 4/5] can: mcp251xfd: move struct mcp251xfd_tef_ring definition
Date:   Thu, 26 Nov 2020 14:21:43 +0100
Message-Id: <20201126132144.351154-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126132144.351154-1-mkl@pengutronix.de>
References: <20201126132144.351154-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch moves the struct mcp251xfd_tef_ring upwards, so that the union
mcp251xfd_write_reg_buf and struct spi_transfer can be made members of it.

Tested-by: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 76585a40d16e..299dbf72e24b 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -459,14 +459,6 @@ struct mcp251xfd_hw_rx_obj_canfd {
 	u8 data[sizeof_field(struct canfd_frame, data)];
 };
 
-struct mcp251xfd_tef_ring {
-	unsigned int head;
-	unsigned int tail;
-
-	/* u8 obj_num equals tx_ring->obj_num */
-	/* u8 obj_size equals sizeof(struct mcp251xfd_hw_tef_obj) */
-};
-
 struct __packed mcp251xfd_buf_cmd {
 	__be16 cmd;
 };
@@ -506,6 +498,14 @@ struct mcp251xfd_tx_obj {
 	union mcp251xfd_tx_obj_load_buf buf;
 };
 
+struct mcp251xfd_tef_ring {
+	unsigned int head;
+	unsigned int tail;
+
+	/* u8 obj_num equals tx_ring->obj_num */
+	/* u8 obj_size equals sizeof(struct mcp251xfd_hw_tef_obj) */
+};
+
 struct mcp251xfd_tx_ring {
 	unsigned int head;
 	unsigned int tail;
-- 
2.29.2


