Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F166F8C59
	for <lists+linux-can@lfdr.de>; Sat,  6 May 2023 00:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjEEW2z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 May 2023 18:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjEEW2y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 May 2023 18:28:54 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254683A8C
        for <linux-can@vger.kernel.org>; Fri,  5 May 2023 15:28:48 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C04D085CD8;
        Sat,  6 May 2023 00:28:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683325726;
        bh=+xHphKqE7Z9XmxYoqpJWMjMpLPrQ25LbqV00q+SRyC8=;
        h=From:To:Cc:Subject:Date:From;
        b=UQ1mjylZn7CQEH0DDGyfOcCZxcXHByP2uYdyiZ8UlpWXg5r7adlXbCd/4rcTjIoQE
         M4ja7qSnNt8HweafH1mCbgrZMHWXRmzxMr6n5U+bG77Q8ZVXx0qUJG4sv38QwVJLR5
         SRc3Cqne+SbUeLQZ1c2htJXtejIfrzTrvqHVy9ha8wlyYgQx9lEpvNGByazbSZFZzd
         1sypfApvF0jNAFRz0o0Hol+SaaUSiy0SIPUmFly8jr5z6rGpk4kXu5gv42W2I45H+U
         ZDVGAvj+cOVHtbCroYiy8S7NWJhBssED8LKAo74s770JloBbNU/37yOfmiasH4MmgF
         jCd3p4xLR0X7Q==
From:   Marek Vasut <marex@denx.de>
To:     linux-can@vger.kernel.org
Cc:     Fedor Ross <fedor.ross@ifm.com>, Marek Vasut <marex@denx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH v2 1/2] can: mcp251xfd: Increase poll timeout
Date:   Sat,  6 May 2023 00:28:19 +0200
Message-Id: <20230505222820.126441-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Fedor Ross <fedor.ross@ifm.com>

Make `MCP251XFD_POLL_TIMEOUT_US` timeout calculation dynamic. Use
maximum of 1ms (arbitrarily chosen during driver development) and
bit time of one full CANFD frame including bit stuffing and bus idle
condition sample cycles, at the current bitrate. This seems to be
necessary when configuring low bit rates like 10 Kbit/s for example.
Otherwise during polling for the CAN controller to enter
'Normal CAN 2.0 mode' the timeout limit is exceeded and the
configuration fails with:

$ ip link set dev can1 up type can bitrate 10000
[  731.911072] mcp251xfd spi2.1 can1: Controller failed to enter mode CAN 2.0 Mode (6) and stays in Configuration Mode (4) (con=0x068b0760, osc=0x00000468).
[  731.927192] mcp251xfd spi2.1 can1: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
[  731.938101] A link change request failed with some changes committed already. Interface can1 may have been left with an inconsistent configuration, please check.
RTNETLINK answers: Connection timed out

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Kopp <thomas.kopp@microchip.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org
---
V2: - Add macros for CAN_BIT_STUFFING_OVERHEAD and CAN_IDLE_CONDITION_SAMPLES
      (thanks Thomas, but please double check the comments)
    - Update commit message
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 8 +++++++-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h      | 9 +++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 68df6d4641b5c..207bcd5bf795b 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -227,6 +227,7 @@ static int
 __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
 			  const u8 mode_req, bool nowait)
 {
+	const struct can_bittiming *bt = &priv->can.bittiming;
 	u32 con = 0, con_reqop, osc = 0;
 	u8 mode;
 	int err;
@@ -251,7 +252,12 @@ __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
 				       FIELD_GET(MCP251XFD_REG_CON_OPMOD_MASK,
 						 con) == mode_req,
 				       MCP251XFD_POLL_SLEEP_US,
-				       MCP251XFD_POLL_TIMEOUT_US);
+				       max(MCP251XFD_POLL_TIMEOUT_US,
+					   (unsigned int)(CANFD_FRAME_LEN_MAX *
+					    BITS_PER_BYTE *
+					    CAN_BIT_STUFFING_OVERHEAD +
+					    CAN_IDLE_CONDITION_SAMPLES) *
+					   USEC_PER_SEC / bt->bitrate));
 	if (err != -ETIMEDOUT && err != -EBADMSG)
 		return err;
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 7024ff0cc2c0c..412d58d84fb63 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -432,6 +432,15 @@ static_assert(MCP251XFD_FIFO_RX_NUM <= 4U);
 /* Use Half Duplex SPI transfers */
 #define MCP251XFD_QUIRK_HALF_DUPLEX BIT(5)
 
+/* CAN bit stuffing overhead multiplication factor */
+#define CAN_BIT_STUFFING_OVERHEAD	1.2
+
+/* Number of samples after which an idle condition is present on the bus
+ * as specified in the ISO. This is 11 consecutive sampled recessive bits
+ * after a full frame (if one is currently in transmission).
+ */
+#define CAN_IDLE_CONDITION_SAMPLES	11
+
 struct mcp251xfd_hw_tef_obj {
 	u32 id;
 	u32 flags;
-- 
2.39.2

