Return-Path: <linux-can+bounces-5377-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1142FC53FE6
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 19:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569A33B5554
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 18:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DB830C364;
	Wed, 12 Nov 2025 18:44:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327E348899
	for <linux-can@vger.kernel.org>; Wed, 12 Nov 2025 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973047; cv=none; b=JUKIy2B65W0p73YYuhe4IqXJvbSlMYtMXIEUiXFy+4x4fu0njL+mFRIdnfI2OgGegL9lIPA7rqxDvXfSwAsI0jsd3hWAdOpXjUcW1AX9bu5nL18weLmr84PjoRwKBN2Wn5Qgsf7FsAZVJXADcxegrDt5VBmdXyghT1Wh6L6CYDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973047; c=relaxed/simple;
	bh=e9q/DXjN/b4dCjtBvvpqQ1JR+MgtPisyQN5gCDgUTO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwhrvJK9d9oL0DVnBAps8KFFX0GTsAmE0FBwj99BdpD4JB17/V+qRJWzxiM0rZXWkD5iQhv2p836ejpxeh0rBttCZ6UjWbPd1dKCrnWs6zyxjxf2An8SvbaxIPX8bzeIcnKBtLAgpmM53qXzLrSprBq4Yt/HohBqgCkdHoQabL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJFos-0006t8-Dc; Wed, 12 Nov 2025 19:43:50 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJFor-0008Ce-22;
	Wed, 12 Nov 2025 19:43:49 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5378849E0C8;
	Wed, 12 Nov 2025 18:43:49 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 06/11] can: mcp251xfd: utilize gather_write function for all non-CRC writes
Date: Wed, 12 Nov 2025 19:40:25 +0100
Message-ID: <20251112184344.189863-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112184344.189863-1-mkl@pengutronix.de>
References: <20251112184344.189863-1-mkl@pengutronix.de>
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

From: Gregor Herburger <gregor.herburger@ew.tq-group.com>

This is a preparation patch to add errata workaround for non crc writes.

Currently for non-crc writes to the chip can go through the
.gather_write, .write or the reg_update_bits callback.

To allow the addition of the errata fix at a single location use
mcp251xfd_regmap_nocrc_gather_write for all non-CRC write instructions,
similar to the crc regmap.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Tested-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20251001091006.4003841-3-viken.dadhaniya@oss.qualcomm.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-regmap.c  | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 8c5be8d1c519..e61cbd209955 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -12,14 +12,6 @@
 
 static const struct regmap_config mcp251xfd_regmap_crc;
 
-static int
-mcp251xfd_regmap_nocrc_write(void *context, const void *data, size_t count)
-{
-	struct spi_device *spi = context;
-
-	return spi_write(spi, data, count);
-}
-
 static int
 mcp251xfd_regmap_nocrc_gather_write(void *context,
 				    const void *reg, size_t reg_len,
@@ -47,6 +39,15 @@ mcp251xfd_regmap_nocrc_gather_write(void *context,
 	return spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
 }
 
+static int
+mcp251xfd_regmap_nocrc_write(void *context, const void *data, size_t count)
+{
+	const size_t data_offset = sizeof(__be16);
+
+	return mcp251xfd_regmap_nocrc_gather_write(context, data, data_offset,
+						   data + data_offset, count - data_offset);
+}
+
 static inline bool
 mcp251xfd_update_bits_read_reg(const struct mcp251xfd_priv *priv,
 			       unsigned int reg)
@@ -64,6 +65,7 @@ mcp251xfd_update_bits_read_reg(const struct mcp251xfd_priv *priv,
 	case MCP251XFD_REG_CON:
 	case MCP251XFD_REG_OSC:
 	case MCP251XFD_REG_ECCCON:
+	case MCP251XFD_REG_IOCON:
 		return true;
 	default:
 		mcp251xfd_for_each_rx_ring(priv, ring, n) {
@@ -139,10 +141,9 @@ mcp251xfd_regmap_nocrc_update_bits(void *context, unsigned int reg,
 	tmp_le32 = orig_le32 & ~mask_le32;
 	tmp_le32 |= val_le32 & mask_le32;
 
-	mcp251xfd_spi_cmd_write_nocrc(&buf_tx->cmd, reg + first_byte);
-	memcpy(buf_tx->data, &tmp_le32, len);
-
-	return spi_write(spi, buf_tx, sizeof(buf_tx->cmd) + len);
+	reg += first_byte;
+	mcp251xfd_spi_cmd_write_nocrc(&buf_tx->cmd, reg);
+	return mcp251xfd_regmap_nocrc_gather_write(context, &buf_tx->cmd, 2, &tmp_le32, len);
 }
 
 static int
-- 
2.51.0


