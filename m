Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B310155E110
	for <lists+linux-can@lfdr.de>; Tue, 28 Jun 2022 15:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiF0J3G (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 27 Jun 2022 05:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiF0J3G (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Jun 2022 05:29:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F82025DB
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 02:29:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o5l3H-0000wJ-1u
        for linux-can@vger.kernel.org; Mon, 27 Jun 2022 11:29:03 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 1430AA010B
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 09:29:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 874CDA0105;
        Mon, 27 Jun 2022 09:29:01 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id baa6b7a1;
        Mon, 27 Jun 2022 09:29:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2] can: mcp251xfd: mcp251xfd_register_get_dev_id(): fix endianness conversion
Date:   Mon, 27 Jun 2022 11:28:59 +0200
Message-Id: <20220627092859.809042-1-mkl@pengutronix.de>
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

In mcp251xfd_register_get_dev_id() the device ID register is read with
handcrafted SPI transfers. As all registers, this register is in
little endian. Further it is not naturally aligned in struct
mcp251xfd_map_buf_nocrc::data. However after the transfer the register
content is converted from big endian to CPU endianness not taking care
of being unaligned.

Fix the conversion by converting from little endian to CPU endianness
taking the unaligned source into account.

Side note: So far the register content is 0x0 on all mcp251xfd
compatible chips, and is only used for an informative printk.

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Reviewed-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

just noticed, that buf_rx->data is not naturally aligned if
interpreting it as a 32 bit value.

regards,
Marc

changes since v1:
- use get_unaligned_le32() instead of be32_to_cpup()

 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 3160881e89d9..aa17e437585a 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1787,7 +1787,7 @@ mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
 	if (err)
 		goto out_kfree_buf_tx;
 
-	*dev_id = be32_to_cpup((__be32 *)buf_rx->data);
+	*dev_id = get_unaligned_le32(buf_rx->data);
 	*effective_speed_hz_slow = xfer[0].effective_speed_hz;
 	*effective_speed_hz_fast = xfer[1].effective_speed_hz;
 
-- 
2.35.1


