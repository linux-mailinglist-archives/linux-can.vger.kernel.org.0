Return-Path: <linux-can+bounces-2306-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C3D9DFC9D
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 10:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1892B21593
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 09:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226931FAC5D;
	Mon,  2 Dec 2024 09:00:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C01FA82B
	for <linux-can@vger.kernel.org>; Mon,  2 Dec 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130056; cv=none; b=sUKXj2zLn2zgkwcroG0VH5L90yDXZE43LoeggaIhoP6jL0ZeqiC66eKSLZ9G4p9JZ9Ta83iDziNnVqbjUXHldrAmUDklPMJiCNN1+lrbNsEvxtySsfz0Rp7JsgBh+uiYQ3DqrmyR49PiVbtesB4pTiefOuaMBZBgikVE4/i3/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130056; c=relaxed/simple;
	bh=4B/grfdRZksUaVgQ+aqcxxM8Hc1yJgtng+6chgMP+hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gISxgJkXFXV4C3xstorKUELKbCiNSwag2Mih5BbExl4mlXfBkS/Cs+9iEsZn0cmQPfQWw0nKfyJo3NsdIv37llUyBEvb9zbu6/9JbARbJTWK/1kqCjnlvPn2w3hdHfi0qgbEgkqbI3uy2O18Ldi+5dPbASuJK5gBwehvfVsNX/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IV-0007hT-Kf
	for linux-can@vger.kernel.org; Mon, 02 Dec 2024 10:00:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IS-001GcB-1O
	for linux-can@vger.kernel.org;
	Mon, 02 Dec 2024 10:00:49 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id DCA87383397
	for <linux-can@vger.kernel.org>; Mon, 02 Dec 2024 09:00:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 14CCB38333E;
	Mon, 02 Dec 2024 09:00:46 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 47080273;
	Mon, 2 Dec 2024 09:00:44 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>,
	stable@vger.kernel.org
Subject: [PATCH net 14/15] can: mcp251xfd: mcp251xfd_get_tef_len(): work around erratum DS80000789E 6.
Date: Mon,  2 Dec 2024 09:55:48 +0100
Message-ID: <20241202090040.1110280-15-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202090040.1110280-1-mkl@pengutronix.de>
References: <20241202090040.1110280-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Commit b8e0ddd36ce9 ("can: mcp251xfd: tef: prepare to workaround
broken TEF FIFO tail index erratum") introduced
mcp251xfd_get_tef_len() to get the number of unhandled transmit events
from the Transmit Event FIFO (TEF).

As the TEF has no head index, the driver uses the TX-FIFO's tail index
instead, assuming that send frames are completed.

When calculating the number of unhandled TEF events, that commit
didn't take mcp2518fd erratum DS80000789E 6. into account. According
to that erratum, the FIFOCI bits of a FIFOSTA register, here the
TX-FIFO tail index might be corrupted.

However here it seems the bit indicating that the TX-FIFO is
empty (MCP251XFD_REG_FIFOSTA_TFERFFIF) is not correct while the
TX-FIFO tail index is.

Assume that the TX-FIFO is indeed empty if:
- Chip's head and tail index are equal (len == 0).
- The TX-FIFO is less than half full.
  (The TX-FIFO empty case has already been checked at the
   beginning of this function.)
- No free buffers in the TX ring.

If the TX-FIFO is assumed to be empty, assume that the TEF is full and
return the number of elements in the TX-FIFO (which equals the number
of TEF elements).

If these assumptions are false, the driver might read to many objects
from the TEF. mcp251xfd_handle_tefif_one() checks the sequence numbers
and will refuse to process old events.

Reported-by: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
Closes: https://patch.msgid.link/CAJ7t6HgaeQ3a_OtfszezU=zB-FqiZXqrnATJ3UujNoQJJf7GgA@mail.gmail.com
Fixes: b8e0ddd36ce9 ("can: mcp251xfd: tef: prepare to workaround broken TEF FIFO tail index erratum")
Tested-by: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20241126-mcp251xfd-fix-length-calculation-v2-1-c2ed516ed6ba@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index d3ac865933fd..e94321849fd7 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -21,6 +21,11 @@ static inline bool mcp251xfd_tx_fifo_sta_empty(u32 fifo_sta)
 	return fifo_sta & MCP251XFD_REG_FIFOSTA_TFERFFIF;
 }
 
+static inline bool mcp251xfd_tx_fifo_sta_less_than_half_full(u32 fifo_sta)
+{
+	return fifo_sta & MCP251XFD_REG_FIFOSTA_TFHRFHIF;
+}
+
 static inline int
 mcp251xfd_tef_tail_get_from_chip(const struct mcp251xfd_priv *priv,
 				 u8 *tef_tail)
@@ -147,7 +152,29 @@ mcp251xfd_get_tef_len(struct mcp251xfd_priv *priv, u8 *len_p)
 	BUILD_BUG_ON(sizeof(tx_ring->obj_num) != sizeof(len));
 
 	len = (chip_tx_tail << shift) - (tail << shift);
-	*len_p = len >> shift;
+	len >>= shift;
+
+	/* According to mcp2518fd erratum DS80000789E 6. the FIFOCI
+	 * bits of a FIFOSTA register, here the TX-FIFO tail index
+	 * might be corrupted.
+	 *
+	 * However here it seems the bit indicating that the TX-FIFO
+	 * is empty (MCP251XFD_REG_FIFOSTA_TFERFFIF) is not correct
+	 * while the TX-FIFO tail index is.
+	 *
+	 * We assume the TX-FIFO is empty, i.e. all pending CAN frames
+	 * haven been send, if:
+	 * - Chip's head and tail index are equal (len == 0).
+	 * - The TX-FIFO is less than half full.
+	 *   (The TX-FIFO empty case has already been checked at the
+	 *    beginning of this function.)
+	 * - No free buffers in the TX ring.
+	 */
+	if (len == 0 && mcp251xfd_tx_fifo_sta_less_than_half_full(fifo_sta) &&
+	    mcp251xfd_get_tx_free(tx_ring) == 0)
+		len = tx_ring->obj_num;
+
+	*len_p = len;
 
 	return 0;
 }
-- 
2.45.2



