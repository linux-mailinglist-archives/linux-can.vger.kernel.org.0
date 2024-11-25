Return-Path: <linux-can+bounces-2209-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E6D9D83F7
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 12:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C94168E72
	for <lists+linux-can@lfdr.de>; Mon, 25 Nov 2024 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B811953B0;
	Mon, 25 Nov 2024 11:00:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7526D1632F6
	for <linux-can@vger.kernel.org>; Mon, 25 Nov 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532430; cv=none; b=LVPJWIXpbIKY6chqVdXWk3wHEHv5k+TSCuoE7xd6usH/UbLxVt4cNo6ts24QTJU/KXxBk5Z5Otg1MyaEkEF7jCG+5z/E2hlaap6dz8rbV70MNRA8yOezgbR8NNC5Ve2+O/LTxzGWFWnARVkFh/vS0PAQiQltFkJ/0ZlPHZ9nfCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532430; c=relaxed/simple;
	bh=/0gO+9PPZBmpTRgBKiYQA8NcqskyWMNhhrizpwhdH0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZQy2ddLU4T5gDXET92ZnrYesc+bH04Azs2715ER+0CaIy/GAP24GWqK5I2wLanB5+IxcN07TdWqSOsywqvzdHESAXPAhi+Wz6Q8sjwOaMoI+nIDLmLJU6QA9YEvLffO88KSFCu9G3HpLTejTJN6Zh5oXj4f60KASKvyqKqhFeV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFWpN-0005o3-OH
	for linux-can@vger.kernel.org; Mon, 25 Nov 2024 12:00:25 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFWpM-00048Q-2U
	for linux-can@vger.kernel.org;
	Mon, 25 Nov 2024 12:00:25 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3CC5437CB94
	for <linux-can@vger.kernel.org>; Mon, 25 Nov 2024 11:00:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id DD4DD37CB8E;
	Mon, 25 Nov 2024 11:00:23 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 09a3b8e0;
	Mon, 25 Nov 2024 11:00:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 25 Nov 2024 12:00:16 +0100
Subject: [PATCH RFC can] can: mcp251xfd: mcp251xfd_get_tef_len(): fix
 length calculation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-mcp251xfd-fix-length-calculation-v1-1-974445b5f893@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAL9YRGcC/x2NQQrCMBBFrxJm7UAntIJuBQ/gtrgYJpM2EGNJq
 hRK7+7g8sF//+3QtCZtcHU7VP2mlt7FgE4OZOYyKaZgDL7zPREN+JLFD7TFgDFtmLVM64zCWT6
 ZV5Pxcg49dxqIooLdLFVt+U+M8LjfnHCB53H8APHd5YV7AAAA
X-Change-ID: 20241115-mcp251xfd-fix-length-calculation-96d4a0ed11fe
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>, stable@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3857; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=/0gO+9PPZBmpTRgBKiYQA8NcqskyWMNhhrizpwhdH0g=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnRFjDWYzc9I9kEdGkvs5QqeR/D65CdWi6/fFKU
 KmEcgnfAluJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZ0RYwwAKCRAoOKI+ei28
 b+0jB/41neInK9Mf0znPyauvf5DXxmk8o5zRado0ezQm/M0SR+ADlJulxgHbdUcxPExqJ7yKVwE
 jTHgqrjrF2Tbf9qpiAs1frqFykS+r8ii5ATBk2+eG6ii2X1R1tqdSBSaZNoKU03nBgQ3dz1jzBk
 YbQqorhc3fmlK0zRkioN+owulZAE84oWKwwCr8bPekSpfYS9X4D17dERynktMZ0AMVdVyRRkmdX
 mkV3uwQfGgWOgUDGA6kiHyhvX7XdexDMXWccEbON6ASvUOHgGQD13nxko4hERG+dqXjrHzUrrlZ
 Jk8x9tfvx+gERFLsWt/tGooOzhwLiUZ+HmcYzgLWHEasqDSq
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
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
Not-yet-Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 29 ++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index d3ac865933fdf6c4ecdd80ad4d7accbff51eb0f8..e94321849fd7e69ed045eaeac3efec52fe077d96 100644
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

---
base-commit: fcc79e1714e8c2b8e216dc3149812edd37884eef
change-id: 20241115-mcp251xfd-fix-length-calculation-96d4a0ed11fe

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



