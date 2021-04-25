Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9136A721
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 14:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhDYMYw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 08:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhDYMYv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Apr 2021 08:24:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BA9C06175F
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 05:24:11 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lado1-0004PB-T4
        for linux-can@vger.kernel.org; Sun, 25 Apr 2021 14:24:09 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 2946561696B
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 12:24:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 66A15616948;
        Sun, 25 Apr 2021 12:24:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a5297635;
        Sun, 25 Apr 2021 12:24:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 03/14] can: mcp251xfd: mcp251xfd_regmap_crc_read(): ignore CRC error only if solely OSC register is read
Date:   Sun, 25 Apr 2021 14:23:49 +0200
Message-Id: <20210425122400.3276975-4-mkl@pengutronix.de>
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

MCP251XFD_REG_OSC is the first ever reg we read from. The chip may be
in deep sleep and the SPI transfer (i.e. the assertion of the CS) will
wake the chip up. This takes about 3ms. The CRC of this transfer is
wrong, or there isn't a chip at all, in this case the CRC will be
wrong, too. The driver ignores the CRC error and returns the read data
to the caller.

To avoid any confusion, this patch changes the
mcp251xfd_regmap_crc_read() function to only ignore the CRC error if
solely the OSC register is read. So when reading multiple registers at
once the CRC is returned.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 297491516a26..e026247812aa 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -369,7 +369,7 @@ mcp251xfd_regmap_crc_read(void *context,
 		 * to the caller. It will take care of both cases.
 		 *
 		 */
-		if (reg == MCP251XFD_REG_OSC) {
+		if (reg == MCP251XFD_REG_OSC && val_len == sizeof(__le32)) {
 			err = 0;
 			goto out;
 		}
-- 
2.30.2


