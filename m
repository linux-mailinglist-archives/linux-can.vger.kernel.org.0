Return-Path: <linux-can+bounces-1882-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B022D9BBE6F
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 21:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CDA28241F
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 20:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2C41D5141;
	Mon,  4 Nov 2024 20:01:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E91D365C
	for <linux-can@vger.kernel.org>; Mon,  4 Nov 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750491; cv=none; b=I050tMdoS9rI6R4uxjB1gU/0xs/rw/ZqmgZ60ePbNg6ZvWzweMNVpuxaHKLzVd+dwOGdG/d296KUU+r2Rgdb1jCID4Ayf6ql1RKGEKUOr7ePiqtlZZ5D+PE+nX4fUhCuZuQ/zExrehz6/4mqs9THeOxd1S4rjnG29wi7dyDLI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750491; c=relaxed/simple;
	bh=OfjEopnqbStbp4O45I56Ve4VGUhVQwKE7+txzTy/qPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emH827PQmJyJS8BAV3q4AFZbtWIzI1euTYS0WwYZ5M8zp6HRgBQ15Ksy3wDho7nmWynzWFsNmisn62q91A4SpkK1w5q/ij2ZhDTZMWcuieDfRXCokPX/zDagjrCjtQ3BJdTxePxwTFcjAPtJjLkiBIVN4Vv46RTNP9S9JWcAw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t83GR-0001co-C9
	for linux-can@vger.kernel.org; Mon, 04 Nov 2024 21:01:27 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t83GQ-00226S-12
	for linux-can@vger.kernel.org;
	Mon, 04 Nov 2024 21:01:26 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 06B70367FA8
	for <linux-can@vger.kernel.org>; Mon, 04 Nov 2024 20:01:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C6DEA367F6E;
	Mon, 04 Nov 2024 20:01:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e89cdeda;
	Mon, 4 Nov 2024 20:01:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sven Schuchmann <schuchmann@schleissheimer.de>,
	stable@vger.kernel.org
Subject: [PATCH net 8/8] can: mcp251xfd: mcp251xfd_get_tef_len(): fix length calculation
Date: Mon,  4 Nov 2024 20:53:31 +0100
Message-ID: <20241104200120.393312-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104200120.393312-1-mkl@pengutronix.de>
References: <20241104200120.393312-1-mkl@pengutronix.de>
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

As the TEF has no head pointer, the driver uses the TX FIFO's tail
pointer instead, assuming that send frames are completed. However the
check for the TEF being full was not correct. This leads to the driver
stop working if the TEF is full.

Fix the TEF full check by assuming that if, from the driver's point of
view, there are no free TX buffers in the chip and the TX FIFO is
empty, all messages must have been sent and the TEF must therefore be
full.

Reported-by: Sven Schuchmann <schuchmann@schleissheimer.de>
Closes: https://patch.msgid.link/FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
Fixes: b8e0ddd36ce9 ("can: mcp251xfd: tef: prepare to workaround broken TEF FIFO tail index erratum")
Tested-by: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20241104-mcp251xfd-fix-length-calculation-v3-1-608b6e7e2197@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index f732556d233a..d3ac865933fd 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -16,9 +16,9 @@
 
 #include "mcp251xfd.h"
 
-static inline bool mcp251xfd_tx_fifo_sta_full(u32 fifo_sta)
+static inline bool mcp251xfd_tx_fifo_sta_empty(u32 fifo_sta)
 {
-	return !(fifo_sta & MCP251XFD_REG_FIFOSTA_TFNRFNIF);
+	return fifo_sta & MCP251XFD_REG_FIFOSTA_TFERFFIF;
 }
 
 static inline int
@@ -122,7 +122,11 @@ mcp251xfd_get_tef_len(struct mcp251xfd_priv *priv, u8 *len_p)
 	if (err)
 		return err;
 
-	if (mcp251xfd_tx_fifo_sta_full(fifo_sta)) {
+	/* If the chip says the TX-FIFO is empty, but there are no TX
+	 * buffers free in the ring, we assume all have been sent.
+	 */
+	if (mcp251xfd_tx_fifo_sta_empty(fifo_sta) &&
+	    mcp251xfd_get_tx_free(tx_ring) == 0) {
 		*len_p = tx_ring->obj_num;
 		return 0;
 	}
-- 
2.45.2



