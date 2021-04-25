Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEC936A722
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 14:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhDYMYw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 08:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhDYMYw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Apr 2021 08:24:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D54C061574
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 05:24:12 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lado2-0004Q5-Ku
        for linux-can@vger.kernel.org; Sun, 25 Apr 2021 14:24:10 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 824F0616973
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 12:24:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7E6E661694A;
        Sun, 25 Apr 2021 12:24:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 068bf980;
        Sun, 25 Apr 2021 12:24:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 04/14] can: mcp251xfd: mcp251xfd_reg_invalid(): rename from mcp251xfd_osc_invalid()
Date:   Sun, 25 Apr 2021 14:23:50 +0200
Message-Id: <20210425122400.3276975-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210425122400.3276975-1-mkl@pengutronix.de>
References: <20210425122400.3276975-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch renames mcp251xfd_osc_invalid() to mcp251xfd_reg_invalid(),
as it will be used for other registers than the "osc" register in a
later patch.

This patch also moves this function to more towards the beginning of
the file, to be available for other functions, too.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 1d267dfedead..45850521000c 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -504,6 +504,11 @@ static int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 	return 0;
 }
 
+static inline bool mcp251xfd_reg_invalid(u32 reg)
+{
+	return reg == 0x0 || reg == 0xffffffff;
+}
+
 static inline int
 mcp251xfd_chip_get_mode(const struct mcp251xfd_priv *priv, u8 *mode)
 {
@@ -567,11 +572,6 @@ mcp251xfd_chip_set_mode_nowait(const struct mcp251xfd_priv *priv,
 	return __mcp251xfd_chip_set_mode(priv, mode_req, true);
 }
 
-static inline bool mcp251xfd_osc_invalid(u32 reg)
-{
-	return reg == 0x0 || reg == 0xffffffff;
-}
-
 static int mcp251xfd_chip_clock_enable(const struct mcp251xfd_priv *priv)
 {
 	u32 osc, osc_reference, osc_mask;
@@ -600,7 +600,7 @@ static int mcp251xfd_chip_clock_enable(const struct mcp251xfd_priv *priv)
 				       (osc & osc_mask) == osc_reference,
 				       MCP251XFD_OSC_STAB_SLEEP_US,
 				       MCP251XFD_OSC_STAB_TIMEOUT_US);
-	if (mcp251xfd_osc_invalid(osc)) {
+	if (mcp251xfd_reg_invalid(osc)) {
 		netdev_err(priv->ndev,
 			   "Failed to detect %s (osc=0x%08x).\n",
 			   mcp251xfd_get_model_str(priv), osc);
-- 
2.30.2


