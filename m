Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF0055B43A
	for <lists+linux-can@lfdr.de>; Mon, 27 Jun 2022 00:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiFZV4b (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Jun 2022 17:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiFZV4a (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2022 17:56:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686EB2DC5
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 14:56:29 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o5aF0-00052Y-Qn
        for linux-can@vger.kernel.org; Sun, 26 Jun 2022 23:56:26 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 3F13E9FB63
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 21:56:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id AD5559FB5D;
        Sun, 26 Jun 2022 21:56:25 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1c9a392d;
        Sun, 26 Jun 2022 21:56:24 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: mcp251xfd: mcp251xfd_regmap_crc_read(): update workaround broken CRC on TBC register
Date:   Sun, 26 Jun 2022 23:56:18 +0200
Message-Id: <20220626215619.780296-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
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

From: Thomas Kopp <thomas.kopp@microchip.com>

The mcp251xfd compatible chips have an erratum ([1], [2]), where the
received CRC doesn't match the calculated CRC. In commit
c7eb923c3caf ("can: mcp251xfd: mcp251xfd_regmap_crc_read(): work
around broken CRC on TBC register") the following workaround was
implementierend.

- If a CRC read error on the TBC register is detected and the first
  byte is 0x00 or 0x80, the most significant bit of the first byte is
  flipped and the CRC is calculated again.
- If the CRC now matches, the _original_ data is passed to the reader.
  For now we assume transferred data was OK.

New investigations and simulations indicate that the CRC send by the
device is calculated on correct data, and the data is incorrectly
received by the SPI host controller.

Use flipped instead of original data and update workaround description
in mcp251xfd_regmap_crc_read().

[1] mcp2517fd: DS80000792C: "Incorrect CRC for certain READ_CRC commands"
[2] mcp2518fd: DS80000789C: "Incorrect CRC for certain READ_CRC commands"

Link: https://lore.kernel.org/all/DM4PR11MB53901D49578FE265B239E55AFB7C9@DM4PR11MB5390.namprd11.prod.outlook.com
Fixes: c7eb923c3caf ("can: mcp251xfd: mcp251xfd_regmap_crc_read(): work around broken CRC on TBC register")
Signed-off-by: Thomas Kopp <thomas.kopp@microchip.com>
[mkl: split into 2 patches, update patch description and documentation]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 217510c12af5..af3903dabdb4 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -341,9 +341,8 @@ mcp251xfd_regmap_crc_read(void *context,
 		 *
 		 * If the highest bit in the lowest byte is flipped
 		 * the transferred CRC matches the calculated one. We
-		 * assume for now the CRC calculation in the chip
-		 * works on wrong data and the transferred data is
-		 * correct.
+		 * assume for now the CRC operates on the correct
+		 * data.
 		 */
 		if (reg == MCP251XFD_REG_TBC &&
 		    (buf_rx->data[0] == 0x0 || buf_rx->data[0] == 0x80)) {
@@ -356,10 +355,8 @@ mcp251xfd_regmap_crc_read(void *context,
 								  val_len);
 			if (!err) {
 				/* If CRC is now correct, assume
-				 * transferred data was OK, flip bit
-				 * back to original value.
+				 * flipped data is OK.
 				 */
-				buf_rx->data[0] ^= 0x80;
 				goto out;
 			}
 		}
-- 
2.35.1


