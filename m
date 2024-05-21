Return-Path: <linux-can+bounces-658-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECF38CAEEE
	for <lists+linux-can@lfdr.de>; Tue, 21 May 2024 15:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246E5282A9C
	for <lists+linux-can@lfdr.de>; Tue, 21 May 2024 13:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8AC7E591;
	Tue, 21 May 2024 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="VIbEiAwb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="s5yt05v5"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680437E0FF;
	Tue, 21 May 2024 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296755; cv=none; b=CCT2hJ2yF8n/CkIIbj4l2SQP9s9y8xpXXlv4xSc5YkkhrB5ISKZMd5WTr2/FOXHAtlZTOMfF3OJaB+chCF7ou/fQkW/ApBuGzoZYA4zJWG901iKXVoLnRWjwHsJ7wOlyT1j5bgq+pb8UQpnujAPGwDNYs+7DEtX6lUkwXx3vAhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296755; c=relaxed/simple;
	bh=mf/CGYkyirFDBPKbl4n8JhxTVrOxLzFxQVdyF1vHoXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bTSG9ibn8/afdkRhQJHI3o0Rj8mP8xmwJjgOPO1lZm+aNz0hTEHi/uDUw9cmsInfYMv6ie5NpWi/Sw3o1mVRZskM40bdxGJ/fCzdPIHxAmkPAf3ZSe9Zc36tfAHtmuK5oQT7OcuXlHiWxpaXqXv/pphag8FyHG9rLvXjtvn1XBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=VIbEiAwb; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=s5yt05v5 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716296753; x=1747832753;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=bAwCIewDMxhFmEXjo8ADUs6sgpX8lVhiY2kOZnU4Jyk=;
  b=VIbEiAwbBu7vduK4ACRKGLE04VEcYPJ934uAU84Ko+wcTYW9m3TA9Se2
   G/ioxJyCC6EZ+l/UR7fmUbx7T6tM3AzuXYbRjPECgYzSRSJIkAq0s6iWe
   9NRvYd84XQJloh83O8Pw1Lszp8KjjmVFmx6jwNrtp2I+aHG8pKpleNIEI
   x/wR1LooQzvFbSJhxst2Xni5VKIIO4ffIsTOjRKB0zUWkxtUpZkkkS/FK
   YiCA1BE9Isnmffm1NK/55MY7OC3xOrnSGftJtHcuZzbbzRRQtcXKlH2zj
   Sfc6XRK7OBwfJHZgI3/3gmsK2NcSfiUZxIfJKx5NVpkpbkYlzfB0SRk5m
   A==;
X-CSE-ConnectionGUID: qfXycsu1TjaST4XR9sDU0Q==
X-CSE-MsgGUID: V3Kn/y2GRqmTJDes6iXTbw==
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; 
   d="scan'208";a="36993985"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 May 2024 15:05:51 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 229DB17225D;
	Tue, 21 May 2024 15:05:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716296747;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bAwCIewDMxhFmEXjo8ADUs6sgpX8lVhiY2kOZnU4Jyk=;
	b=s5yt05v5PGDwaNtugk873AR3BJV/RZuwe/tuNIHO+DxlBmgzq9RhSk+QnATr21JDGWgxTX
	Xd6TBVLAoUVE7SIaHZxZqe8eXV9coXL55arH/diUoi6Lp1PPfmj3I2vQxwZlGGI93K98vH
	qlY1ROEwL1YthQrH8DFFkKba16lQx+sXXJRMSDVcpw2rV84LQmCvrta9SiDzMxbunmEtBh
	VYuL3yT8r9Aq4iKatxGRxW/OiJwCn+lruZpMreYWWw24vrS+fV0oBCtCh/qax4aN7VraaR
	mSm/OTcWzfjG6CNieUlH5XQtFbdsK5gSxLqoEaRXnTJGoZVpv2aQaTe8FAuwWA==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Tue, 21 May 2024 15:04:56 +0200
Subject: [PATCH v3 6/8] can: mcp251xfd: only configure PIN1 when rx_int is
 set
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-mcp251xfd-gpio-feature-v3-6-7f829fefefc2@ew.tq-group.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716296697; l=3721;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=mf/CGYkyirFDBPKbl4n8JhxTVrOxLzFxQVdyF1vHoXE=;
 b=mIOfW3kIkMg3TlbSGMuAxzkE9FtK5tQ1GS0AYyIn3aopul0Mwafs8Rvps2tkh5+cSO0UTbiau
 a4KDTKgtm8+CtCEnvMnd9LDBgI5BmUyJlYCg5FBetdfEcCubOfyD/t7
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


