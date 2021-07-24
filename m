Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D473D48D0
	for <lists+linux-can@lfdr.de>; Sat, 24 Jul 2021 19:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhGXQjj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 24 Jul 2021 12:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhGXQjd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 24 Jul 2021 12:39:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1FFC0613CF
        for <linux-can@vger.kernel.org>; Sat, 24 Jul 2021 10:20:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m7LJi-0002V0-Sx
        for linux-can@vger.kernel.org; Sat, 24 Jul 2021 19:20:02 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8BB636569E3
        for <linux-can@vger.kernel.org>; Sat, 24 Jul 2021 17:19:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 762686569B3;
        Sat, 24 Jul 2021 17:19:54 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 27c94318;
        Sat, 24 Jul 2021 17:19:53 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net 6/6] can: mcp251xfd: mcp251xfd_irq(): stop timestamping worker in case error in IRQ
Date:   Sat, 24 Jul 2021 19:19:47 +0200
Message-Id: <20210724171947.547867-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724171947.547867-1-mkl@pengutronix.de>
References: <20210724171947.547867-1-mkl@pengutronix.de>
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
Link: https://lore.kernel.org/r/20210724155131.471303-1-mkl@pengutronix.de
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


