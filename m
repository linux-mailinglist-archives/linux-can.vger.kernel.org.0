Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1098D756B52
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 20:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGQSJv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 14:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGQSJt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 14:09:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408F410C0
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 11:09:47 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLSfJ-00088A-IJ
        for linux-can@vger.kernel.org; Mon, 17 Jul 2023 20:09:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 123911F3974
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 18:09:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C32611F394B;
        Mon, 17 Jul 2023 18:09:41 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bb67d14e;
        Mon, 17 Jul 2023 18:09:40 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Fedor Ross <fedor.ross@ifm.com>,
        Marek Vasut <marex@denx.de>, stable@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 5/5] can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll timeout
Date:   Mon, 17 Jul 2023 20:09:38 +0200
Message-Id: <20230717180938.230816-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717180938.230816-1-mkl@pengutronix.de>
References: <20230717180938.230816-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Fedor Ross <fedor.ross@ifm.com>

The mcp251xfd controller needs an idle bus to enter 'Normal CAN 2.0
mode' or . The maximum length of a CAN frame is 736 bits (64 data
bytes, CAN-FD, EFF mode, worst case bit stuffing and interframe
spacing). For low bit rates like 10 kbit/s the arbitrarily chosen
MCP251XFD_POLL_TIMEOUT_US of 1 ms is too small.

Otherwise during polling for the CAN controller to enter 'Normal CAN
2.0 mode' the timeout limit is exceeded and the configuration fails
with:

| $ ip link set dev can1 up type can bitrate 10000
| [  731.911072] mcp251xfd spi2.1 can1: Controller failed to enter mode CAN 2.0 Mode (6) and stays in Configuration Mode (4) (con=0x068b0760, osc=0x00000468).
| [  731.927192] mcp251xfd spi2.1 can1: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
| [  731.938101] A link change request failed with some changes committed already. Interface can1 may have been left with an inconsistent configuration, please check.
| RTNETLINK answers: Connection timed out

Make MCP251XFD_POLL_TIMEOUT_US timeout calculation dynamic. Use
maximum of 1ms and bit time of 1 full 64 data bytes CAN-FD frame in
EFF mode, worst case bit stuffing and interframe spacing at the
current bit rate.

For easier backporting define the macro MCP251XFD_FRAME_LEN_MAX_BITS
that holds the max frame length in bits, which is 736. This can be
replaced by can_frame_bits(true, true, true, true, CANFD_MAX_DLEN) in
a cleanup patch later.

Fixes: 55e5b97f003e8 ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20230717-mcp251xfd-fix-increase-poll-timeout-v5-1-06600f34c684@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 10 ++++++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h      |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 68df6d4641b5..eebf967f4711 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -227,6 +227,8 @@ static int
 __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
 			  const u8 mode_req, bool nowait)
 {
+	const struct can_bittiming *bt = &priv->can.bittiming;
+	unsigned long timeout_us = MCP251XFD_POLL_TIMEOUT_US;
 	u32 con = 0, con_reqop, osc = 0;
 	u8 mode;
 	int err;
@@ -246,12 +248,16 @@ __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
 	if (mode_req == MCP251XFD_REG_CON_MODE_SLEEP || nowait)
 		return 0;
 
+	if (bt->bitrate)
+		timeout_us = max_t(unsigned long, timeout_us,
+				   MCP251XFD_FRAME_LEN_MAX_BITS * USEC_PER_SEC /
+				   bt->bitrate);
+
 	err = regmap_read_poll_timeout(priv->map_reg, MCP251XFD_REG_CON, con,
 				       !mcp251xfd_reg_invalid(con) &&
 				       FIELD_GET(MCP251XFD_REG_CON_OPMOD_MASK,
 						 con) == mode_req,
-				       MCP251XFD_POLL_SLEEP_US,
-				       MCP251XFD_POLL_TIMEOUT_US);
+				       MCP251XFD_POLL_SLEEP_US, timeout_us);
 	if (err != -ETIMEDOUT && err != -EBADMSG)
 		return err;
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 7024ff0cc2c0..24510b3b8020 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -387,6 +387,7 @@ static_assert(MCP251XFD_TIMESTAMP_WORK_DELAY_SEC <
 #define MCP251XFD_OSC_STAB_TIMEOUT_US (10 * MCP251XFD_OSC_STAB_SLEEP_US)
 #define MCP251XFD_POLL_SLEEP_US (10)
 #define MCP251XFD_POLL_TIMEOUT_US (USEC_PER_MSEC)
+#define MCP251XFD_FRAME_LEN_MAX_BITS (736)
 
 /* Misc */
 #define MCP251XFD_NAPI_WEIGHT 32
-- 
2.40.1


