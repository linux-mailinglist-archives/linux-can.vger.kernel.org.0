Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035B6307411
	for <lists+linux-can@lfdr.de>; Thu, 28 Jan 2021 11:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhA1KsW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 28 Jan 2021 05:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhA1KsT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Jan 2021 05:48:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5F5C061786
        for <linux-can@vger.kernel.org>; Thu, 28 Jan 2021 02:46:56 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l54pC-0000sx-Ta
        for linux-can@vger.kernel.org; Thu, 28 Jan 2021 11:46:54 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E2CF45D06DC
        for <linux-can@vger.kernel.org>; Thu, 28 Jan 2021 10:46:51 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id CE9475D06B1;
        Thu, 28 Jan 2021 10:46:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 78c365f3;
        Thu, 28 Jan 2021 10:46:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 7/8] can: mcp251xfd: mcp251xfd_chip_clock_enable(): simplify return
Date:   Thu, 28 Jan 2021 11:46:43 +0100
Message-Id: <20210128104644.2982125-8-mkl@pengutronix.de>
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

This patch simplifies the return of the mcp251xfd_chip_clock_enable()
function by direct returning the error.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 04870a741792..da5e8e416440 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -596,11 +596,9 @@ static int mcp251xfd_chip_clock_enable(const struct mcp251xfd_priv *priv)
 			   "Timeout waiting for Oscillator Ready (osc=0x%08x, osc_reference=0x%08x)\n",
 			   osc, osc_reference);
 		return -ETIMEDOUT;
-	} else if (err) {
-		return err;
 	}
 
-	return 0;
+	return err;
 }
 
 static int mcp251xfd_chip_softreset_do(const struct mcp251xfd_priv *priv)
-- 
2.29.2


