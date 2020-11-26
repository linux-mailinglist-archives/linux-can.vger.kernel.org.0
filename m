Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9112C57B2
	for <lists+linux-can@lfdr.de>; Thu, 26 Nov 2020 15:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391219AbgKZO5u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 26 Nov 2020 09:57:50 -0500
Received: from dd33904.kasserver.com ([85.13.151.39]:41680 "EHLO
        dd33904.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391201AbgKZO5u (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 26 Nov 2020 09:57:50 -0500
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Nov 2020 09:57:49 EST
Received: from MoreBrain (unknown [5.147.49.59])
        by dd33904.kasserver.com (Postfix) with ESMTPSA id EE1D927C2553;
        Thu, 26 Nov 2020 15:52:00 +0100 (CET)
From:   <petter@ka-long.de>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
Cc:     "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>,
        "'Thomas Kopp'" <thomas.kopp@microchip.com>
References: <20201123113522.3820052-1-mkl@pengutronix.de>
In-Reply-To: <20201123113522.3820052-1-mkl@pengutronix.de>
Subject: AW: [net] can: mcp251xfd: mcp251xfd_probe(): bail out if no IRQ was given
Date:   Thu, 26 Nov 2020 15:52:00 +0100
Message-ID: <005701d6c403$b25c0790$171416b0$@ka-long.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AQDpjI9xnGlyQsqdEW/2+aQPnFgOLKu07hww
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch add a check to the mcp251xfd_probe() function to bail out and
give the user a proper error message if no IRQ is specified. Otherwise the
driver will probe just fine but ifup will fail with a meaningless "RTNETLINK
answers:
Invalid argument" error message.

Reported-by: Niels Petter <petter@ka-long.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Acked-by: Niels Petter <petter@ka-long.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 9c215f7c5f81..8a39be076e14 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2738,6 +2738,10 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	u32 freq;
 	int err;
 
+	if (!spi->irq)
+		return dev_err_probe(&spi->dev, -ENXIO,
+				     "No IRQ specified (maybe node
\"interrupts-extended\" in DT 
+missing)!\n");
+
 	rx_int = devm_gpiod_get_optional(&spi->dev, "microchip,rx-int",
 					 GPIOD_IN);
 	if (PTR_ERR(rx_int) == -EPROBE_DEFER)
--
2.29.2


