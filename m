Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796A02C57AF
	for <lists+linux-can@lfdr.de>; Thu, 26 Nov 2020 15:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391187AbgKZOzb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 26 Nov 2020 09:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391185AbgKZOza (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 26 Nov 2020 09:55:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76260C0613D4
        for <linux-can@vger.kernel.org>; Thu, 26 Nov 2020 06:55:30 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kiIgC-0004B9-Ep
        for linux-can@vger.kernel.org; Thu, 26 Nov 2020 15:55:28 +0100
Received: from [IPv6:2a03:f580:87bc:d400:6c67:6373:f43a:c656] (unknown [IPv6:2a03:f580:87bc:d400:6c67:6373:f43a:c656])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A8C7959C585
        for <linux-can@vger.kernel.org>; Thu, 26 Nov 2020 14:55:27 +0000 (UTC)
Received: from bjornoya.blackshift.org
        by bjornoya with LMTP
        id uYbLIxTBv1/QSwAAs6a69A
        (envelope-from <petter@ka-long.de>)
        for <mkl-all@blackshift.org>; Thu, 26 Nov 2020 14:52:04 +0000
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6CEED59C571
        for <mkl-all@blackshift.org>; Thu, 26 Nov 2020 14:52:04 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4B15759C570
        for <ptx@kleine-budde.de>; Thu, 26 Nov 2020 14:52:04 +0000 (UTC)
Received: from dd33904.kasserver.com ([85.13.151.39])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <petter@ka-long.de>)
        id 1kiIcs-0003nY-CH
        for mkl@pengutronix.de; Thu, 26 Nov 2020 15:52:02 +0100
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
Date:   Thu, 26 Nov 2020 15:52:00 +0100
Message-ID: <005701d6c403$b25c0790$171416b0$@ka-long.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AQDpjI9xnGlyQsqdEW/2+aQPnFgOLKu07hww
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        metis.ext.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=4.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.2
Subject: AW: [net] can: mcp251xfd: mcp251xfd_probe(): bail out if no IRQ was given
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: ptx@kleine-budde.de
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
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



