Return-Path: <linux-can+bounces-656-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA928CAEE5
	for <lists+linux-can@lfdr.de>; Tue, 21 May 2024 15:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67F21F230A3
	for <lists+linux-can@lfdr.de>; Tue, 21 May 2024 13:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646297CF1A;
	Tue, 21 May 2024 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="kMXh1blV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="JbQhqt83"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE4678C76;
	Tue, 21 May 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296746; cv=none; b=XtVR86nG6JWhve+KyQ8Ay45LDGUOA/bxg+UnS8O6wYXslLclp9LmjD1CMky0pFabOgft0mYQFQBhddjDrnTQrPyhHdn2IL3oBY/f/+o3kwM/ChrYFW+Vfji7YGTS4h84xT7n93bP9VIuF8fkE6zNKuOl9bDHakhLRYJqqm3X3WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296746; c=relaxed/simple;
	bh=WUDnbgqAvpWR8Ti/wgoSUXFBiUxJpBw6tjbcut5TlGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISCu0zUJB8AXrKuhvS0MPriVZntRMP4vU+EQ8+iKZWWmsCNu8lPJH9eAg0xoYIpNGfHfFIRKqspyK57vw3FumgL0Ve8pQ+g2oSyl26QycRvL64A9uzQIoiLXbj2USKcTh2J+cs4VK2NbYDRSP4YZgrM3i4HE0kxxvFG0DUX+vIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=kMXh1blV; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=JbQhqt83 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716296744; x=1747832744;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rzepJck8+C7lNecC3vnm+MnvVLZ2fVwhClk7KlqvqWE=;
  b=kMXh1blVxsas6FOoCo4/ueI3bhB+ZvSRMHMS1ifhFLAk8814PVRFupSt
   LUQ/fPhIdUJV0YE5ai6X7Ma/nvt/SPJmflO0BAzZ1v7rboNAwuXJhkbPn
   c1j0ysTeA272l6z0WpGZavg5lZTxbDRJw9eB8Z7vlXenE/cZ1wkysY+1x
   WY5qc+qGRh1/f9tJG/O+qx9qda9ny+bA04NC2/AkHWJL4VDK/5xNNJQmD
   kMGFWd/xlaxeiTkx7ExGIdo5mhztYNZ25JJgOfBai13J6UC4psbWvYrqi
   3goYEH4+JeyHpvcEGmX8r/fNbb3h0iPeCDOiUlxPDffQDlgDdMnfPp3am
   Q==;
X-CSE-ConnectionGUID: QCYYvlhaR/WE5/XF/xh+3w==
X-CSE-MsgGUID: ZKGZRVCmTReLd7IaYc9Mhw==
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; 
   d="scan'208";a="36993976"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 May 2024 15:05:42 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA21617303E;
	Tue, 21 May 2024 15:05:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716296738;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rzepJck8+C7lNecC3vnm+MnvVLZ2fVwhClk7KlqvqWE=;
	b=JbQhqt830W+97PaAXqiI55gK89reCSWrdB2F2oOgmipB4vxEG+2A/9PiyUPjNZ3N5XxW1C
	gy5f/99l9KhQM/oCu3UHiGAg/9VfEdpW+ncIeJo3Jlm0AOupaXMRQZKP8lOgAxf8S24nYd
	LeuaC88d4mU0/il+gd6wrJ0dB1ZLeZi42z4K7WRJDohnCNVr5xUrlWD+CzMPvl2ya6d51y
	v7A2j7vQ2cWrl8TylVGqadHX2pYCEVhCKeVe5JSyC6iPw69FUR2VCzj3Imgg0EvbnXc3pL
	ndV5ff4p24wzeKlpscK7LmDYUho3NUF49HPw0wjEZufm49G0O+aeSD6kUttu3Q==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Tue, 21 May 2024 15:04:54 +0200
Subject: [PATCH v3 4/8] can: mcp251xfd: utilize gather_write function for
 all non-CRC writes
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-mcp251xfd-gpio-feature-v3-4-7f829fefefc2@ew.tq-group.com>
References: <20240521-mcp251xfd-gpio-feature-v3-0-7f829fefefc2@ew.tq-group.com>
In-Reply-To: <20240521-mcp251xfd-gpio-feature-v3-0-7f829fefefc2@ew.tq-group.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716296697; l=2559;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=WUDnbgqAvpWR8Ti/wgoSUXFBiUxJpBw6tjbcut5TlGw=;
 b=EM/zi6aZLtflH9pjBoYCpypaAlUa/cnneLfS68vOWvKfXS3h4XzV2v+4cMaKaExJBhmger6px
 XQYQ0aYYnbvC/i85inIMy88Sb9eFfBhePTH5lf8wbgWStpfHkWaK1eq
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


