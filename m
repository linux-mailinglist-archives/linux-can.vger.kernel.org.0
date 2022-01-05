Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71130485618
	for <lists+linux-can@lfdr.de>; Wed,  5 Jan 2022 16:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241632AbiAEPnf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jan 2022 10:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241650AbiAEPnT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jan 2022 10:43:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2CFC06118A
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 07:43:08 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n58RO-0002w2-Rf
        for linux-can@vger.kernel.org; Wed, 05 Jan 2022 16:43:06 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 124CE6D1CAB
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 15:43:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 56C9F6D1C8F;
        Wed,  5 Jan 2022 15:43:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 901892aa;
        Wed, 5 Jan 2022 15:43:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 04/13] can: mcp251xfd: mcp251xfd_open(): open_candev() first
Date:   Wed,  5 Jan 2022 16:42:51 +0100
Message-Id: <20220105154300.1258636-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105154300.1258636-1-mkl@pengutronix.de>
References: <20220105154300.1258636-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch exchanges the order of open_candev() and
pm_runtime_get_sync(), so that open_candev() is called first.

A usual reason why open_candev() fails is missing CAN bit rate
configuration. It makes no sense to resume the device from PM sleep
first just to put it to sleep if the bit rate is not configured.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index bf2ebd46ff83..161e12cdf8e8 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2503,19 +2503,19 @@ static int mcp251xfd_open(struct net_device *ndev)
 	const struct spi_device *spi = priv->spi;
 	int err;
 
+	err = open_candev(ndev);
+	if (err)
+		return err;
+
 	err = pm_runtime_get_sync(ndev->dev.parent);
 	if (err < 0) {
 		pm_runtime_put_noidle(ndev->dev.parent);
-		return err;
+		goto out_close_candev;
 	}
 
-	err = open_candev(ndev);
-	if (err)
-		goto out_pm_runtime_put;
-
 	err = mcp251xfd_ring_alloc(priv);
 	if (err)
-		goto out_close_candev;
+		goto out_pm_runtime_put;
 
 	err = mcp251xfd_transceiver_enable(priv);
 	if (err)
@@ -2551,11 +2551,11 @@ static int mcp251xfd_open(struct net_device *ndev)
 	mcp251xfd_transceiver_disable(priv);
  out_mcp251xfd_ring_free:
 	mcp251xfd_ring_free(priv);
- out_close_candev:
-	close_candev(ndev);
  out_pm_runtime_put:
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
 	pm_runtime_put(ndev->dev.parent);
+ out_close_candev:
+	close_candev(ndev);
 
 	return err;
 }
-- 
2.34.1


