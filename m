Return-Path: <linux-can+bounces-669-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB008CC302
	for <lists+linux-can@lfdr.de>; Wed, 22 May 2024 16:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D0A285A54
	for <lists+linux-can@lfdr.de>; Wed, 22 May 2024 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84058146D4A;
	Wed, 22 May 2024 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="lFtsb/Wl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="NLQqK0JK"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BEC146A8C;
	Wed, 22 May 2024 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387393; cv=none; b=T5ndl4pSS4MIi8RYNYiRMYu5PP70ErItRKk/U0j9n2ZUw9UHJJ/bAmervYE0Q/Tp7w0PaEXkavbb5s26hBsMZRdoI6j7A3YE7mcb7rvBKqRxthEyKyf5ST/A8oYmfSAKhiEwuqyGzSoHQTW9lLWIosKZ0It0RPS8Sx4RUf0QKEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387393; c=relaxed/simple;
	bh=mf/CGYkyirFDBPKbl4n8JhxTVrOxLzFxQVdyF1vHoXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YYSzyZQB5phOyiD7hNLGENg4W0UGMsYuyR4TpQOgxtOFgX8Sn5znmMPYZ46zu4FPsRfnK6DG5RzWxc7BwS0KdP3vvEVO8Mq+wvXBQPIJXRKcEk1nt0KbLWIgcp/CgXADxCgVsu4ppWav2xSJctwfl+1PZoiPx1c+sYnenEHVbFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=lFtsb/Wl; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=NLQqK0JK reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716387391; x=1747923391;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=bAwCIewDMxhFmEXjo8ADUs6sgpX8lVhiY2kOZnU4Jyk=;
  b=lFtsb/WldAjTmPCPOKwuLyeEaupKfwCpsGwYR/CJzQGCZ0mbzZtDcSQ6
   dsboZQ2kqtCw7ERxbrpMmNoxskk0Y4wbFGxdkKtyOobhRJkyPfT7LsZzA
   oyjCBtQIBcWHLog4e16g2G0dEGS2+sZXVHQZqCgebcgieAiulptwjr1oO
   JxT7L93zc+gRpjCMlfH8q3qe8ID/xmrppugF6hGv+jglg2QZQsmd6+YJY
   j3o+f7S8vbTeTeMGg26b3F3AkzqNRqbHEwuv3my92it/fsUtqieLMUNsH
   lv25hgFUSkVRT7yQxb50Afr/e3wnJATbMkTJR8h9xlS5UC8BqzL7Cddks
   A==;
X-CSE-ConnectionGUID: H/r8w5X6Q0e7ml8/06LvGA==
X-CSE-MsgGUID: P4ELlkFETf6RsCXot6FPxA==
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="37017672"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 May 2024 16:16:30 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 641A716F04E;
	Wed, 22 May 2024 16:16:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716387386;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bAwCIewDMxhFmEXjo8ADUs6sgpX8lVhiY2kOZnU4Jyk=;
	b=NLQqK0JK9f4G5Wiy5qTL9qxoxwyytkOvXOGGKqsId+HE5fQleNJRJmDXh2vxf/FKKcv+93
	8GaM7SpW3NESuEc5SCAwDMGdagWKqWO9DSkg+sFMFqut2XwHCyLBSI7t0euV75kF7ZMoI8
	mn4dF9HhuTKiQgWZPwqvfUj/ejp6LBvqlX5SS/G7kr8WtYadA+d3Wi2Zas7FAY6aTT6LhX
	og5DWWKFP6yPf9dZhPIA5nJoVzwEWeLpyWykVAL+EaBm7p8uNyL1whlz/8XoTqM8gR0ErU
	y+qTEy8S36a9Vr7bQ2ZAdDvJSUFacxqvp9nV9A1z9E5Ho00nFXFXIc7S7CZg4A==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Wed, 22 May 2024 16:15:23 +0200
Subject: [PATCH RESEND v3 6/8] can: mcp251xfd: only configure PIN1 when
 rx_int is set
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-mcp251xfd-gpio-feature-v3-6-8829970269c5@ew.tq-group.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716387339; l=3721;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=mf/CGYkyirFDBPKbl4n8JhxTVrOxLzFxQVdyF1vHoXE=;
 b=o7F9KbZMWXtI+HqeK7JmVXbKLq6z4uAArE/bRDOgaWDsetiWX3ZdMfdYer+/dIOVjvnUg5cO5
 X6r7EYIq2PEDFOcJMwPEyaGxlAvK0N8N4CjJF+tXUjS3p0aDK/zsBN2
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

When rx_int is used th mcp251xfd_chip_rx_int_enable and
mcp251xfd_chip_rx_int_disable function configure both PIN0 and PIN1. To
prepare the support of the GPIOS only configure PIN1 with
regmap_update_bits.

This way PIN0 can be used as GPIO while PIN1 is used as rx_int
interrupt.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 22 ++++++++--------------
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h      |  6 ++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 4739ad80ef2a..d8d936576c94 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -586,23 +586,21 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 
 static int mcp251xfd_chip_rx_int_enable(const struct mcp251xfd_priv *priv)
 {
-	u32 val;
+	u32 val, mask;
 
 	if (!priv->rx_int)
 		return 0;
 
-	/* Configure GPIOs:
-	 * - PIN0: GPIO Input
-	 * - PIN1: GPIO Input/RX Interrupt
+	/* Configure PIN1 as RX Interrupt:
 	 *
 	 * PIN1 must be Input, otherwise there is a glitch on the
 	 * rx-INT line. It happens between setting the PIN as output
 	 * (in the first byte of the SPI transfer) and configuring the
 	 * PIN as interrupt (in the last byte of the SPI transfer).
 	 */
-	val = MCP251XFD_REG_IOCON_PM0 | MCP251XFD_REG_IOCON_TRIS1 |
-		MCP251XFD_REG_IOCON_TRIS0;
-	return regmap_write(priv->map_reg, MCP251XFD_REG_IOCON, val);
+	val = MCP251XFD_REG_IOCON_TRIS(1);
+	mask = MCP251XFD_REG_IOCON_TRIS(1) | MCP251XFD_REG_IOCON_PM(1);
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON, mask, val);
 }
 
 static int mcp251xfd_chip_rx_int_disable(const struct mcp251xfd_priv *priv)
@@ -612,13 +610,9 @@ static int mcp251xfd_chip_rx_int_disable(const struct mcp251xfd_priv *priv)
 	if (!priv->rx_int)
 		return 0;
 
-	/* Configure GPIOs:
-	 * - PIN0: GPIO Input
-	 * - PIN1: GPIO Input
-	 */
-	val = MCP251XFD_REG_IOCON_PM1 | MCP251XFD_REG_IOCON_PM0 |
-		MCP251XFD_REG_IOCON_TRIS1 | MCP251XFD_REG_IOCON_TRIS0;
-	return regmap_write(priv->map_reg, MCP251XFD_REG_IOCON, val);
+	/* Configure PIN1 as GPIO Input */
+	val = MCP251XFD_REG_IOCON_PM(1) | MCP251XFD_REG_IOCON_TRIS(1);
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON, val, val);
 }
 
 static int mcp251xfd_chip_ecc_init(struct mcp251xfd_priv *priv)
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 75d5a8a25415..78637223dbc8 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -335,13 +335,19 @@
 #define MCP251XFD_REG_IOCON_TXCANOD BIT(28)
 #define MCP251XFD_REG_IOCON_PM1 BIT(25)
 #define MCP251XFD_REG_IOCON_PM0 BIT(24)
+#define MCP251XFD_REG_IOCON_PM(n) (MCP251XFD_REG_IOCON_PM0 << (n))
 #define MCP251XFD_REG_IOCON_GPIO1 BIT(17)
 #define MCP251XFD_REG_IOCON_GPIO0 BIT(16)
+#define MCP251XFD_REG_IOCON_GPIO(n) (MCP251XFD_REG_IOCON_GPIO0 << (n))
+#define MCP251XFD_REG_IOCON_GPIO_MASK GENMASK(17, 16)
 #define MCP251XFD_REG_IOCON_LAT1 BIT(9)
 #define MCP251XFD_REG_IOCON_LAT0 BIT(8)
+#define MCP251XFD_REG_IOCON_LAT(n) (MCP251XFD_REG_IOCON_LAT0 << (n))
+#define MCP251XFD_REG_IOCON_LAT_MASK GENMASK(9, 8)
 #define MCP251XFD_REG_IOCON_XSTBYEN BIT(6)
 #define MCP251XFD_REG_IOCON_TRIS1 BIT(1)
 #define MCP251XFD_REG_IOCON_TRIS0 BIT(0)
+#define MCP251XFD_REG_IOCON_TRIS(n) (MCP251XFD_REG_IOCON_TRIS0 << (n))
 
 #define MCP251XFD_REG_CRC 0xe08
 #define MCP251XFD_REG_CRC_FERRIE BIT(25)

-- 
2.34.1


