Return-Path: <linux-can+bounces-2229-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AED9D95B3
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 11:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0EEB220C6
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 10:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220E81B6CE6;
	Tue, 26 Nov 2024 10:39:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C78342AB4
	for <linux-can@vger.kernel.org>; Tue, 26 Nov 2024 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617543; cv=none; b=QijE5272X3+WPFNSFAozFQDC6+3NmMaO9EvdLnfLNArz9HbP3f7Wxzd7QugpPwYZ3jm0TKAq47dI1/fQY5Ju3ECMI4NgB0weB/OKVQL/LtWOgdfjXvtT6X9krcdlXR+B8RV7X5kfoEJMBalqE1j+It2Hc7X5YHpdsQAZVdlyHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617543; c=relaxed/simple;
	bh=sAOxah2M5O3VTEF5UaDJHeSJKF6SfSuYOQ5/5muWQ1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LNdpWoR4GXevAEKNbDQSx7MFV5p2sStXvF4brz43hTN7nCX8e1RoPJQqSuBwrkLheoEbBQ6lJy4y3XwtYwlThyUn2FXWeRTZR68sSvyGz/ql5hyWyPLLDPvqC1jL2To/UlsYtOqRJK8DJc5bZufFfcQXY9CnxCEhFeolFIzIS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFsy5-000406-IG
	for linux-can@vger.kernel.org; Tue, 26 Nov 2024 11:38:53 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFsy4-000EXF-1t
	for linux-can@vger.kernel.org;
	Tue, 26 Nov 2024 11:38:53 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0AC8E37D8E4
	for <linux-can@vger.kernel.org>; Tue, 26 Nov 2024 10:38:52 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B55DB37D8DE;
	Tue, 26 Nov 2024 10:38:51 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 10e92ff8;
	Tue, 26 Nov 2024 10:38:51 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 26 Nov 2024 11:38:48 +0100
Subject: [PATCH can v2] can: mcp251xfd: mcp251xfd_get_tef_len(): work
 around erratum DS80000789E 6.
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-mcp251xfd-fix-length-calculation-v2-1-c2ed516ed6ba@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIADelRWcC/42NSw6CMBCGr2Jm7RimtiquvIdhUdspNMFC2kIwh
 Lvb4AVc/s9vhcTRc4L7YYXIs09+CEWI4wFMp0PL6G3RICohiUjh24xC0eIsOr9gz6HNHRrdm6n
 XuYyxvlipK7ZEjqHcjJFLc0c8wegATTE7n/IQPzt2pj36EcQfhJmQsL5KKdVLuVt9foylNOU4B
 L+cLEOzbdsXanR7H9oAAAA=
X-Change-ID: 20241115-mcp251xfd-fix-length-calculation-96d4a0ed11fe
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>, stable@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4137; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=sAOxah2M5O3VTEF5UaDJHeSJKF6SfSuYOQ5/5muWQ1E=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnRaU4VE3meW5Zsi1lA7QVHV7mV/CwFhODfSuU/
 mOLDljU3FmJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZ0WlOAAKCRAoOKI+ei28
 by3CB/4xjcVguRSVVlhQ883UYhPw4qi2dLUgQYoPUvulrvOWYCLbNkNGa93IPRLCsuzYB5dy+wW
 454nGuNm5IEM8TzvfIShINk9dZR+9a4fZZ55Yu61CUkcDD9+1BZJ/lUPCKqLIqICu4SjGvgsVOU
 xswjLUMABYqHYhDpagV8A+NjiNDJbhWkyD5TQotGV79cY9ErLec/zMER4WoEzyJH+PFJpIpPN7P
 tLwA9eJ6wu8r6MftyBjFpbgqZPCxPfGdXVrpH4trhufwl63u1V5c49ZDSTgkUCw9rcPwNjaVeKo
 3NRJXlrWGvet4E9OQnDGIOUTDhx+N8obleTpptFlZe/vSBcT
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
Tested-by: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- adjusted patch subject
- added stable on Cc
- added Renjaya Raga Zenta's Tested-by
- Link to RFC: https://patch.msgid.link/20241125-mcp251xfd-fix-length-calculation-v1-1-974445b5f893@pengutronix.de
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
base-commit: 9bb88c659673003453fd42e0ddf95c9628409094
change-id: 20241115-mcp251xfd-fix-length-calculation-96d4a0ed11fe

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



