Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D413D4872
	for <lists+linux-can@lfdr.de>; Sat, 24 Jul 2021 17:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhGXPLK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 24 Jul 2021 11:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGXPLJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 24 Jul 2021 11:11:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ED2C061575
        for <linux-can@vger.kernel.org>; Sat, 24 Jul 2021 08:51:41 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m7Jw7-0003Ng-LY
        for linux-can@vger.kernel.org; Sat, 24 Jul 2021 17:51:35 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B2C5A65695A
        for <linux-can@vger.kernel.org>; Sat, 24 Jul 2021 15:51:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4AA93656956;
        Sat, 24 Jul 2021 15:51:34 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d9ea2ddf;
        Sat, 24 Jul 2021 15:51:33 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: mcp251xfd: mcp251xfd_irq(): stop timestamping worker in case error in IRQ
Date:   Sat, 24 Jul 2021 17:51:31 +0200
Message-Id: <20210724155131.471303-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In case an error occurred in the IRQ handler, the chip status is
dumped via devcoredump and all IRQs are disabled, but the chip stays
powered for further analysis.

The chip is in an undefined state and will not receive any CAN frames,
so shut down the timestamping worker, which reads the TBC register
regularly, too. This avoids any CRC read error messages if there is a
communication problem with the chip.

Fixes: efd8d98dfb90 ("can: mcp251xfd: add HW timestamp infrastructure")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 47c3f408a799..9ae48072b6c6 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2300,6 +2300,7 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
 		   err, priv->regs_status.intf);
 	mcp251xfd_dump(priv);
 	mcp251xfd_chip_interrupts_disable(priv);
+	mcp251xfd_timestamp_stop(priv);
 
 	return handled;
 }
-- 
2.30.2


