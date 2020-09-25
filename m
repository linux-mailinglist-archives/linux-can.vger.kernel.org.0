Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3212780FF
	for <lists+linux-can@lfdr.de>; Fri, 25 Sep 2020 08:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgIYG4K (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Sep 2020 02:56:10 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:12443 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgIYG4I (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Sep 2020 02:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601016968; x=1632552968;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c2eL6lWq3qeb5BW4EwOrO3QyfkpFqiS4/Qj9++T0PpA=;
  b=vCmoN2BdA+OAONsSJwkRkAxSEPcYqd/RMnBwOiO4q8+a+aPSZSMOivVa
   ASE5C1+KxvUBsCBThEyVNt5sZlE2D/oYJ6F6jZAXh2huTZt45caJH/iMa
   hyutr7jX44SoHurGqcUx2qVZ1fHKId8Jzi6cISPVmxp6+1CV3eVEZSpJC
   tEbSHdISSDV+puYBDB0MCEKsnDgPLdqO0CE2/0Jto/QxltZlSmRD14IZE
   7NQJioBZ62093FqwbM7LEdXH/6bzEEz7R/bZosa42Cofsl80Ht3OD/pZs
   YIuRajjk8lsi6uEL0Ldt8AQQdTEluPdHTCPl1MnOc9Hk3jnckz3qvJW2v
   Q==;
IronPort-SDR: 3oxG6wi8aGeBIQ8CG0l+bDMvP1WYAdAvquna5NWViO4b7AwM4VyffG2Wn2SeGz4K/O3o9YX1F5
 v/8F0EO+RAZxzYFD4ODbWtTsVTdLUsdik0BKS/qmDF+Bze+7lybEu2xYo0jmZmZCxzqtWrWGo3
 nkm5WWX91uZfQ/v4ApWU6s1WbID6eg8ALU6irW6NbQhvxC0bHa6HVDX+zVjfKOHkQ6TImEkpxT
 Nt+DKifHdY39fYL5xEVYTZ61cdKVYnVRbklUIglAi3LVFJv0zaSWrhzC+Im+VxU1/7AS3JPbHY
 dgQ=
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="93151217"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2020 23:56:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 24 Sep 2020 23:55:36 -0700
Received: from HNO-LT-M43677A.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 24 Sep 2020 23:56:06 -0700
From:   Thomas Kopp <thomas.kopp@microchip.com>
To:     <linux-can@vger.kernel.org>
CC:     <thomas.kopp@microchip.com>, <mkl@pengutronix.de>,
        <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] can: mcp25xxfd: Add explanation for SPI clk limit, Reference to ECC errata
Date:   Fri, 25 Sep 2020 08:56:06 +0200
Message-ID: <20200925065606.358-1-thomas.kopp@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Reference the MCP2517FD and MCP2518FD erratasheets and paste the
explanation.
The single error correction does not always work, so just indicate that
a single error occurred.

Signed-off-by: Thomas Kopp <thomas.kopp@microchip.com>
---
 .../net/can/spi/mcp25xxfd/mcp25xxfd-core.c    | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
index 96901fb47bde..5557b2d1e774 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
@@ -1943,6 +1943,17 @@ mcp25xxfd_handle_eccif_recover(struct mcp25xxfd_priv *priv, u8 nr)
 	return mcp25xxfd_chip_set_normal_mode(priv);
 }
 
+	/* Errata Reference:  DS80000789B, DS80000792C
+	 * ECC single error correction does not work in
+	 * all cases:
+	 * Fix/Work Around:
+	 * Enable single error correction and double error
+	 * detection interrupts by setting SECIE and
+	 * DEDIE. Handle SECIF as a detection interrupt
+	 * and do not rely on the error correction. Instead,
+	 * handle both interrupts as a notification that the
+	 * RAM word at ERRADDR was corrupted.
+	 */
 static int
 mcp25xxfd_handle_eccif(struct mcp25xxfd_priv *priv, bool set_normal_mode)
 {
@@ -1974,7 +1985,7 @@ mcp25xxfd_handle_eccif(struct mcp25xxfd_priv *priv, bool set_normal_mode)
 		return err;
 
 	if (ecc_stat & MCP25XXFD_REG_ECCSTAT_SECIF)
-		msg = "Single ECC Error corrected at address";
+		msg = "Single ECC Error detected at address";
 	else if (ecc_stat & MCP25XXFD_REG_ECCSTAT_DEDIF)
 		msg = "Double ECC Error detected at address";
 	else
@@ -2815,8 +2826,18 @@ static int mcp25xxfd_probe(struct spi_device *spi)
 	/* According to the datasheet the SPI clock must be less or
 	 * equal SYSCLOCK / 2.
 	 *
-	 * It turns out, that the Controller is not stable at this
-	 * rate. Known good and bad combinations are:
+	 * Errata Reference:  DS80000789B, DS80000792C
+	 * The SPI can write corrupted data to the RAM
+	 * at fast SPI speeds:
+	 * Simultaneous activity on the CAN bus while
+	 * writing data to RAM via the SPI interface, with
+	 * high SCK frequency, can lead to corrupted data
+	 * being written to RAM.
+	 * Fix/Work Around:
+	 * Ensure that FSCK is less than or equal to
+	 * 0.85 * (FSYSCLK/2).
+	 *
+	 * Known good and bad combinations are:
 	 *
 	 * MCP	ext-clk	SoC			SPI			SPI-clk		max-clk	parent-clk	Status	config
 	 *
@@ -2829,7 +2850,6 @@ static int mcp25xxfd_probe(struct spi_device *spi)
 	 * 2517 40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	 82.00%	 82000000 Hz	good	default
 	 * 2518 40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	 82.00%	 82000000 Hz	good	default
 	 *
-	 * Limit SPI clock to 85% of SYSCLOCK / 2 for now.
 	 */
 	priv->spi_max_speed_hz_orig = spi->max_speed_hz;
 	spi->max_speed_hz = min(spi->max_speed_hz, freq / 2 / 1000 * 850);
-- 
2.25.1

