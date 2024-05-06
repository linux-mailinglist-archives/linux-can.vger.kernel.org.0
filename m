Return-Path: <linux-can+bounces-571-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E98BC74D
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 08:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0EA1F21051
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 06:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D181411ED;
	Mon,  6 May 2024 06:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="jfsTUgTg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="TDMTAPzw"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14246140399;
	Mon,  6 May 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714975216; cv=none; b=ruKbrjPb307R8QpTu9HEsh+zB2tzpBNFlXeIv03JcotZCJaR3Sryhqd1FZp8N/KobXW5t6BTTZa1PexZ92xp/imYMR8qWS5BGuQpISQUS5ceAITPwJPx5HtdgZKo3yUguOfv1NNzbmr0eZZzopNcAZpPOCdu4cjqrTvY8+rMj+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714975216; c=relaxed/simple;
	bh=P3Mk5PcWaUP6+Gg05tBidf+kKVuQMiV3cqlnF284O3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHaAu9Rv0Avvz0aDK/s3eZfIVXOy7EU1KF2t6iGT1CK3s04Z2q+O06D70x10ALnf0VOlfvjKq8r1Ad4b//gv2Y/oyIfZ4r6ZSNLJOHv65/xo4twj85Ve+014lMQM0l1PPMZDjBe5yi12C9WF+qgnTsbegRQ7rpFMPq2oRMFMpyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=jfsTUgTg; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=TDMTAPzw reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1714975214; x=1746511214;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SYaQjnkNSCI9zkCW8eSDRCydILiZmUATxYlt6TM0kmc=;
  b=jfsTUgTgpbpLo5441zbj0L0UQV6TqK0hLUid4O2EEJ2xz6luvhON3a/3
   ENzVoUqEkeD2pS6NN9/1Ptsrl1pt+a6QoP7si2rU7xMKzZHUkvRKVyvyc
   Hk1Hejljeuk39lke/A0s6ubhqsXpi5trkO5ETzADOwQP8i9QFlS4M5bS5
   UwbtPFyppsef4P1Ynpb1xARAjrwixpl3aIiW0FngO5l0kma4XSM4L2BZh
   9o6z81bGNtildQCWQjEOPDg+buSOIhjJwdxQ32FQ5EQhXov3q2/OiQrQo
   qmz3/nSzI5S/upy/YrPowWfVF2h424Icrdef0x4kdnVUSoNMqg2dtUqu5
   w==;
X-CSE-ConnectionGUID: U0H5sdNPTtqyvWWgQfGZJw==
X-CSE-MsgGUID: 0NHtdPBoS5ixY7usv3UEgw==
X-IronPort-AV: E=Sophos;i="6.07,257,1708383600"; 
   d="scan'208";a="36751433"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 06 May 2024 08:00:13 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C32511760D9;
	Mon,  6 May 2024 08:00:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1714975209;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SYaQjnkNSCI9zkCW8eSDRCydILiZmUATxYlt6TM0kmc=;
	b=TDMTAPzwXWqGh70t6UEY0kKIWbD4bUcAwXfgyblnhfi7QBnKWJj4feG27xWvB9l+ndvoSM
	QL57IZKc5bR4kYqLyfGvkCyBXVr2sforEzCBLlNEv/Y8xxnJIStjHiiIkF99/2jJ+xvl3I
	9yqWIig1G5k2hPVTIPojkl6loQKFt/0er50B+pt27syNPxpmFAT/8jT7vrHbZttKgz99lL
	LQks9QleslPpuTjoYw3rS0o8tWWh46/DI6e0aSKjzi8JEO37fthsm234q3W3L+DHJDU+gN
	lrY1OCTImjMXTIFsup6MWLWsBxQ3l3rkWucafw6DWYQNiOoySfBjux7HqT8Pvw==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Mon, 06 May 2024 07:59:46 +0200
Subject: [PATCH v2 4/6] can: mcp251xfd: mcp251xfd_regmap_crc_write():
 workaround for errata 5
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-mcp251xfd-gpio-feature-v2-4-615b16fa8789@ew.tq-group.com>
References: <20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com>
In-Reply-To: <20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com>
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
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714975188; l=2328;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=P3Mk5PcWaUP6+Gg05tBidf+kKVuQMiV3cqlnF284O3Q=;
 b=Vl2+Twm8j5RsvrhL+nbEqe4dNJvFb9F3+BQMZkmc/QN5cYeX3C1hsQNvpFTjs0koT7+On0BmO
 DvnZVX1JoZEAeI+Rv2Z1hadEFVlwYA6UDcCTOg1evnmQedPaSSFLtQk
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

According to Errata DS80000789E 5 writing IOCON register using one SPI
write command clears LAT0/LAT1.

Errata Fix/Work Around suggests to write registers with single byte write
instructions. However, it seems that every write to the second byte
causes the overwrite of LAT0/LAT1.

Never write byte 2 of IOCON register to avoid clearing of LAT0/LAT1.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c | 29 +++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 65150e762007..43fcf7f50591 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -229,14 +229,41 @@ mcp251xfd_regmap_crc_gather_write(void *context,
 	return spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
 }
 
+static int mcp251xfd_regmap_crc_write_iocon(void *context, const void *data)
+{
+	u16 reg = MCP251XFD_REG_IOCON;
+
+	/* Never write to bits 16..23 of IOCON register to avoid clearing of LAT0/LAT1
+	 *
+	 * According to Errata DS80000789E 5 writing IOCON register using one
+	 * SPI write command clears LAT0/LAT1.
+	 *
+	 * Errata Fix/Work Around suggests to write registers with single byte
+	 * write instructions. However, it seems that the byte at 0xe06(IOCON[23:16])
+	 * is for read-only access and writing to it causes the clearing of LAT0/LAT1.
+	 */
+
+	/* Write IOCON[15:0] */
+	mcp251xfd_regmap_crc_gather_write(context, &reg, 1, data, 2);
+	reg += 3;
+	/* Write IOCON[31:24] */
+	mcp251xfd_regmap_crc_gather_write(context, &reg, 1, data + 3, 1);
+
+	return 0;
+}
+
 static int
 mcp251xfd_regmap_crc_write(void *context,
 			   const void *data, size_t count)
 {
 	const size_t data_offset = sizeof(__be16) +
 		mcp251xfd_regmap_crc.pad_bits / BITS_PER_BYTE;
+	u16 reg = *(u16 *)data;
 
-	return mcp251xfd_regmap_crc_gather_write(context,
+	if (reg == MCP251XFD_REG_IOCON)
+		return mcp251xfd_regmap_crc_write_iocon(context, data + data_offset);
+	else
+		return mcp251xfd_regmap_crc_gather_write(context,
 						 data, data_offset,
 						 data + data_offset,
 						 count - data_offset);

-- 
2.34.1


