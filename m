Return-Path: <linux-can+bounces-667-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5D68CC2FA
	for <lists+linux-can@lfdr.de>; Wed, 22 May 2024 16:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01184B23A1E
	for <lists+linux-can@lfdr.de>; Wed, 22 May 2024 14:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199F0146013;
	Wed, 22 May 2024 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="RJu7k80+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="YJZOxvI2"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F2145FF1;
	Wed, 22 May 2024 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387384; cv=none; b=XzATpeP/+XEhUiOIp2aYUpPzCgZUPiEvr8czuNq9tW6/hwNehi1KkuQ//SomQ14tOOxZ95ruA/G5O95D1kgszh88MhqDTUkidPkHExkg9an3vNoRZDzFCtl9UFLuaAUtz/+dB8JPyRdQSjimQBYoCn+Qowsn2rzaO1cnf1UrbM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387384; c=relaxed/simple;
	bh=WUDnbgqAvpWR8Ti/wgoSUXFBiUxJpBw6tjbcut5TlGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8p5ORjJtB6COGxRsIdASOeTVZmaspfG76n0Ick6p5nf/yin25hJXaFPLG5neIasbqdBeTWzk6lAOuE5tssvVQELbjZ1GfF5w8BLmnARYpR8xghhI8q8ab9KWrL0GIV0/RHWx2UAb4ZXIjk7OSpkVQURKfNkJ7b6CJt1p/n8gBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=RJu7k80+; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=YJZOxvI2 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716387382; x=1747923382;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rzepJck8+C7lNecC3vnm+MnvVLZ2fVwhClk7KlqvqWE=;
  b=RJu7k80+lVIhLD5RtdVzP6Lk0I6ecC7RJ8948Wlq/Fm2Sb122z09yp3j
   KiF7HAwTWFjRp5DIU+XphD2go+akp1bWqGHCej12yUGHFwtR/rI6/qFpF
   tKtpqCE3Knzf9YxIRhc2ecX3RrB1GDdLEX3aftEAvTNDTr7GGuE0+squ5
   zu0ClvK/4IBlZ98GXolPWfC2l7RaPPrRTMKikjxPxk2S222RNeR4G9mAY
   4PcCZqz9A6C1tQ2njfIsDyRMmM2Q6/3srGImLFlcOxVjP/VzTNp561rDw
   529742a8NwLFnIt1hNO4G9BTAyNVwmZx7x5Po0fW4I75mnunChlMxg0t3
   w==;
X-CSE-ConnectionGUID: ynj+34u5Ty2bhcn2Gt1ypQ==
X-CSE-MsgGUID: rlDAJqMhSla8lY4fLjm07A==
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="37017667"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 May 2024 16:16:20 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BB5816EB45;
	Wed, 22 May 2024 16:16:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716387376;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rzepJck8+C7lNecC3vnm+MnvVLZ2fVwhClk7KlqvqWE=;
	b=YJZOxvI28o83WJQNc9vM3hxUZvDYHb39Y6X1k4Dh+AjqeBhOaAqi/6vV040pdkwAVuetwY
	q1uFf95q2Tnui7K3aD1403bFG++GP3iJt8vLAwWLIv2gUcVs2ZwQ1i8gkX/rUHxpY/BoaB
	NSeZdckTGxONsKYjWNZumCLI6njAOBJiziSA18Q2SHVvXMp9k1ikjh9Z/Gv5s3VSdh0Ajt
	4btbT7oGzOeufjc6DPhRpWltb5R19nUYYh1ATT+D5m/+/3ctzOCeIw8+CfCM1rJcI1MJT6
	xhvZmcWUxeISDycMUH/b4bIE7uaOGyFFz4QuFw6L+HmDZBr1fohBxcFT6OQ3lA==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Wed, 22 May 2024 16:15:21 +0200
Subject: [PATCH RESEND v3 4/8] can: mcp251xfd: utilize gather_write
 function for all non-CRC writes
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-mcp251xfd-gpio-feature-v3-4-8829970269c5@ew.tq-group.com>
References: <20240522-mcp251xfd-gpio-feature-v3-0-8829970269c5@ew.tq-group.com>
In-Reply-To: <20240522-mcp251xfd-gpio-feature-v3-0-8829970269c5@ew.tq-group.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716387339; l=2559;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=WUDnbgqAvpWR8Ti/wgoSUXFBiUxJpBw6tjbcut5TlGw=;
 b=be6nTv875q0qjAV37wG3UKmtra4sSACMsCe8jSDvxjqPSK0nwRK1DLLMVDdUc/GdBC0uRL9cQ
 45tDSfIdWYaBjAanof2Tygo151tEnyDBbPteK9Fd92IJcvm2ldV6btl
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

This is a preparation patch to add errata workaround for non crc writes.

Currently for non-crc writes to the chip can go through the
.gather_write, .write or the reg_update_bits callback.

To allow the addition of the errata fix at a single location use
mcp251xfd_regmap_nocrc_gather_write for all non-CRC write instructions,
similar to the crc regmap.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c | 25 ++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 65150e762007..52716cce73ec 100644
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
2.34.1


