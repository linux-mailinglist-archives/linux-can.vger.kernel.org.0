Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E5F756B03
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 19:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjGQRxz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 13:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGQRxy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 13:53:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A7FE43
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 10:53:51 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLSPt-0005XX-GD
        for linux-can@vger.kernel.org; Mon, 17 Jul 2023 19:53:49 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id DB8DD1F3916
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 17:53:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 6297D1F3910;
        Mon, 17 Jul 2023 17:53:47 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 28e38c67;
        Mon, 17 Jul 2023 17:53:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Mon, 17 Jul 2023 19:53:42 +0200
Subject: [PATCH v5] can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase
 poll timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-mcp251xfd-fix-increase-poll-timeout-v5-1-06600f34c684@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIACaAtWQC/5WNSw6CMBRFt2I69pl+QNCR+zAMoLzCS6Bt2kIwh
 L1b2YHDc3Nzzs4iBsLInpedBVwpkrMZyuuF6bG1AwL1mZnkUvFKVDBrL0uxmR4MbUBWB2wjgnf
 TBIlmdEsCYaTqOJbi0XGWTT5gPp+Vd5N5pJhc+JzRtfit//nXAgTcK1XXRmnFefvyaIclBWdpu
 /XImuM4vkVxInzbAAAA
To:     linux-can@vger.kernel.org
Cc:     Fedor Ross <fedor.ross@ifm.com>, Marek Vasut <marex@denx.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=5111; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=gl7EgphQ0Pan0Uvzhe7KDOVqRQFZwc8HR1hoCIfCXzk=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktYAndqQENl7T15Sma9Jq5E7G1CfDNGxOB1FXj
 pVvtxy5j1mJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLWAJwAKCRC+UBxKKooE
 6BpOB/sEAp7vjm9MXSxMF0Cjoo4eiI1W2wW6U4oQDpcmyEtxhTBA/fq9I+t/AQ4ssuQmUs3y/5m
 pGd3OGgGqEf6+nrrx0ZcUJ3yFIoIDFC+eLjiw+KZvLJc/1GmGXseThEVTabHt40AEKt26gZgrs5
 eNqYvKZZC5oNUMq0wVzd2npRVytm5AdHkPPC+3qeZ/jZPMzPJACNZnU0XmY6pAN8OSYR3s6S3LY
 xpTcGL/f+xp0XCgCW9hD6ni/1WXKIszTPUwHeLEkzpSjBjJiF0ROF0w8PGXz1WFDmiQHjSSVGiy
 pKA45FAXKOb24e3nc9tr24hmKU9o4hqZiZDMBHCo9WpkWYEM
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
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
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

picking up Fedor's and Marek's work. I decided to make it a minimal
patch and add stable on Cc. The mentioned cleanup patch that replaces
736 by can_frame_bits() can be done later and will go upstream via
can-next.

regards,
Marc
---
Changes in v5:
- use max_t() instead of max() to fix compilation on arm64
- Link to v4: https://lore.kernel.org/all/20230717-mcp251xfd-fix-increase-poll-timeout-v4-1-67388f3c300a@pengutronix.de

Changes in v4:
- fix division by 0, if bit rate is not set yet
- Link to v3: https://lore.kernel.org/all/20230717100815.75764-1-mkl@pengutronix.de

Changes in v3: 
- use 736 as max CAN frame length, calculated by Vincent Mailhol's
  80a2fbce456e ("can: length: refactor frame lengths definition to add size in bits")
- update commit message
- drop patch 2/2
- Link to v2: https://lore.kernel.org/all/20230505222820.126441-1-marex@denx.de

Changes in v2: 
- Add macros for CAN_BIT_STUFFING_OVERHEAD and CAN_IDLE_CONDITION_SAMPLES
  (thanks Thomas, but please double check the comments)
- Update commit message
- Link to v1: https://lore.kernel.org/all/20230504195059.4706-1-marex@denx.de
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

---
base-commit: 0dd1805fe498e0cf64f68e451a8baff7e64494ec
change-id: 20230717-mcp251xfd-fix-increase-poll-timeout-1f23b0e519b0

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>


