Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B1326C17F
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 12:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgIPKIr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Sep 2020 06:08:47 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:48928 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgIPKIi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Sep 2020 06:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600250918; x=1631786918;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fUsYyVBCvRMzwkCtt0ZT12MeRKqsBLBbBCwpmKFTkgM=;
  b=lxgi4dqjCG2/GROzyAh4bY6LpVYz3LDWslDRKa8SdMS0Laj6Sz869Ael
   gfWv8dCo4t+9rl18cLcfjs57WUmLWlp/DFeWGgBMcn4mMddIbTbO3QJvd
   zFIMJY1f5faewfTA7ZK/ocutmNVick/ZAoiBshnhfSJLrv6xgKaxlLKF4
   BzR/+9BvfyBAYorMeoEAOCxN8+bo6saZ5+VQxp9VcfGGTDj0PhDoJNMAi
   y/b+OuYiO7R3KLAmDGN/5DmBDTYSo+IwPMs6gWqZuR4Lev3IMDpKuUrwh
   u02tVYOwtaS3BhHkEiVZh+bkCrux5NzBtz2aOZW3c0EjFo9h7CdZdBkr9
   g==;
IronPort-SDR: yZwP6+9mIhN4OcTXw/VxojJY85b0Q42EgcbHwmuCQHwj45ZSPKWK2Vrucd9VwGYKxgCX9fO0lq
 jD6c9PEVRgm3+IRhd68Hojv+wDsijbb7eLB+WNAKYGCZAUs4rPNCK0mQEtn7/4sb8y9IKSxnNJ
 gDiIp/vbY71tGAdUi4MPTcTNJ4UL12NVVBClPnxsO/RzPD0Z/k4ACGhEeKnXY3y6MgxqoaOLWt
 AoSgIiqira45dlCij945ESBKlbRcVY1bmfcmLeCsIkkUNiYsCC1qeti07C5qc+91g2/amZCjSK
 KhI=
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="91195151"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2020 03:08:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Sep 2020 03:08:09 -0700
Received: from HNO-LT-M43677A.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 16 Sep 2020 03:08:08 -0700
From:   Thomas Kopp <thomas.kopp@microchip.com>
To:     <linux-can@vger.kernel.org>
CC:     <mkl@pengutronix.de>, <kernel@pengutronix.de>,
        <dev.kurt@vandijck-laurijssen.be>,
        <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] can: mcp25xxfd: Limit spiclk to 0.85*(sysclk/2)
Date:   Wed, 16 Sep 2020 12:08:23 +0200
Message-ID: <20200916100823.1105-1-thomas.kopp@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Thomas Kopp <thomas.kopp@microchip.com>
---
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
index 6ffa7af50119..670b7d1e1f46 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
@@ -2821,11 +2821,13 @@ static int mcp25xxfd_probe(struct spi_device *spi)
 	 * 2518	40 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	18750000 Hz	 93.75%	600000000 Hz	bad	assigned-clocks = <&ccu CLK_SPIx>
 	 * 2517	20 MHz	fsl,imx8mm		fsl,imx51-ecspi		 9090909 Hz	 90.09%	 18181819 Hz	good	assigned-clocks = <&clk IMX8MM_CLK_ECSPIx_ROOT>
 	 * 2517	20 MHz	fsl,imx8mm		fsl,imx51-ecspi		 9523809 Hz	 95.34%	 28571429 Hz	bad	assigned-clocks = <&clk IMX8MM_CLK_ECSPIx_ROOT>
+	 * 2517 40 MHz  atmel,sama5d27          atmel,at91rm9200-spi    16400000 Hz      82%     82000000 Hz    good    default
+	 * 2518 40 MHz  atmel,sama5d27          atmel,at91rm9200-spi    16400000 Hz      82%     82000000 Hz    good    default
 	 *
-	 * Limit SPI clock to 92.5% of SYSCLOCK / 2 for now.
+	 * Limit SPI clock to 85% of SYSCLOCK / 2 for now.
 	 */
 	priv->spi_max_speed_hz_orig = spi->max_speed_hz;
-	spi->max_speed_hz = min(spi->max_speed_hz, freq / 2 / 1000 * 925);
+	spi->max_speed_hz = min(spi->max_speed_hz, freq / 2 / 1000 * 850);
 	spi->bits_per_word = 8;
 	spi->rt = true;
 	err = spi_setup(spi);
-- 
2.25.1

