Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C75A55B43B
	for <lists+linux-can@lfdr.de>; Mon, 27 Jun 2022 00:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiFZV4b (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Jun 2022 17:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiFZV4a (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2022 17:56:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D132DC8
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 14:56:29 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o5aF1-00052r-Cx
        for linux-can@vger.kernel.org; Sun, 26 Jun 2022 23:56:27 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 983199FB68
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 21:56:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 273269FB5F;
        Sun, 26 Jun 2022 21:56:26 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f9d99e30;
        Sun, 26 Jun 2022 21:56:25 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Pavel Modilaynen <pavel.modilaynen@volvocars.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] can: mcp251xfd: mcp251xfd_regmap_crc_read(): improve workaround handling for mcp2517fd
Date:   Sun, 26 Jun 2022 23:56:19 +0200
Message-Id: <20220626215619.780296-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220626215619.780296-1-mkl@pengutronix.de>
References: <20220626215619.780296-1-mkl@pengutronix.de>
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

Measurements on the mcp2517fd show that the workaround is applicable
not only of the lowest byte is 0x00 or 0x80, but also if 3 least
significant bits are set.

Update check on 1st data byte and workaround description accordingly.

[1] mcp2517fd: DS80000792C: "Incorrect CRC for certain READ_CRC commands"
[2] mcp2518fd: DS80000789C: "Incorrect CRC for certain READ_CRC commands"

Link: https://lore.kernel.org/all/DM4PR11MB53901D49578FE265B239E55AFB7C9@DM4PR11MB5390.namprd11.prod.outlook.com
Fixes: c7eb923c3caf ("can: mcp251xfd: mcp251xfd_regmap_crc_read(): work around broken CRC on TBC register")
Reported-by: Pavel Modilaynen <pavel.modilaynen@volvocars.com>
Signed-off-by: Thomas Kopp <thomas.kopp@microchip.com>
[mkl: split into 2 patches, update patch description and documentation]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index af3903dabdb4..92b7bc7f14b9 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -334,10 +334,12 @@ mcp251xfd_regmap_crc_read(void *context,
 		 * register. It increments once per SYS clock tick,
 		 * which is 20 or 40 MHz.
 		 *
-		 * Observation shows that if the lowest byte (which is
-		 * transferred first on the SPI bus) of that register
-		 * is 0x00 or 0x80 the calculated CRC doesn't always
-		 * match the transferred one.
+		 * Observation on the mcp2518fd shows that if the
+		 * lowest byte (which is transferred first on the SPI
+		 * bus) of that register is 0x00 or 0x80 the
+		 * calculated CRC doesn't always match the transferred
+		 * one. On the mcp2517fd this problem is not limited
+		 * to the first byte being 0x00 or 0x80.
 		 *
 		 * If the highest bit in the lowest byte is flipped
 		 * the transferred CRC matches the calculated one. We
@@ -345,7 +347,8 @@ mcp251xfd_regmap_crc_read(void *context,
 		 * data.
 		 */
 		if (reg == MCP251XFD_REG_TBC &&
-		    (buf_rx->data[0] == 0x0 || buf_rx->data[0] == 0x80)) {
+		    ((buf_rx->data[0] & 0xf8) == 0x0 ||
+		     (buf_rx->data[0] & 0xf8) == 0x80)) {
 			/* Flip highest bit in lowest byte of le32 */
 			buf_rx->data[0] ^= 0x80;
 
-- 
2.35.1


