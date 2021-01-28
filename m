Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA7730740D
	for <lists+linux-can@lfdr.de>; Thu, 28 Jan 2021 11:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhA1Kri (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 28 Jan 2021 05:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhA1Kre (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Jan 2021 05:47:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE74C061574
        for <linux-can@vger.kernel.org>; Thu, 28 Jan 2021 02:46:53 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l54pA-0000qP-8j
        for linux-can@vger.kernel.org; Thu, 28 Jan 2021 11:46:52 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 0ADF65D06C2
        for <linux-can@vger.kernel.org>; Thu, 28 Jan 2021 10:46:49 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 3AF5D5D06A9;
        Thu, 28 Jan 2021 10:46:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e9dec1c3;
        Thu, 28 Jan 2021 10:46:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/8] can: mcp251xfd: mcp251xfd_probe(): fix errata reference
Date:   Thu, 28 Jan 2021 11:46:37 +0100
Message-Id: <20210128104644.2982125-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128104644.2982125-1-mkl@pengutronix.de>
References: <20210128104644.2982125-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch fixes the reference to the errata for both the mcp2517fd
and the mcp2518fd.

Fixes: f5b84dedf7eb ("can: mcp25xxfd: mcp25xxfd_probe(): add SPI clk limit related errata information")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 3638b474d86b..015227422372 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2932,7 +2932,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 			spi_get_device_id(spi)->driver_data;
 
 	/* Errata Reference:
-	 * mcp2517fd: DS80000789B, mcp2518fd: DS80000792C 4.
+	 * mcp2517fd: DS80000792C 5., mcp2518fd: DS80000789C 4.
 	 *
 	 * The SPI can write corrupted data to the RAM at fast SPI
 	 * speeds:
-- 
2.29.2


