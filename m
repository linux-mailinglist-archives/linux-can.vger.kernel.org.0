Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D986341D1B
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 13:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhCSMmQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 08:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhCSMlw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 08:41:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B69CC06174A
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 05:41:52 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lNERq-000334-U0
        for linux-can@vger.kernel.org; Fri, 19 Mar 2021 13:41:50 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 77FD05FA981
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 12:41:47 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id BA1635FA969;
        Fri, 19 Mar 2021 12:41:44 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4f61e125;
        Fri, 19 Mar 2021 12:41:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, mailhol.vincent@wanadoo.fr,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v13 05/11] can: etas_es58x: remove setting of dql.min_limit for now
Date:   Fri, 19 Mar 2021 13:41:35 +0100
Message-Id: <20210319124141.247844-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319124141.247844-1-mkl@pengutronix.de>
References: <20210319124141.247844-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 5 -----
 drivers/net/can/usb/etas_es58x/es58x_core.h | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 89a4051afc82..d6a114a7e090 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -2150,11 +2150,6 @@ static int es58x_init_netdev(struct es58x_device *es58x_dev, int channel_idx)
 	netdev_dbg(netdev, "%s: Registered channel %s\n",
 		   es58x_dev->udev->product, netdev->name);
 
-#ifdef CONFIG_BQL
-	netdev_get_tx_queue(netdev, 0)->dql.min_limit =
-	    es58x_dev->param->dql_limit_min;
-#endif
-
 	return ret;
 }
 
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.h b/drivers/net/can/usb/etas_es58x/es58x_core.h
index 71f278e6e85c..ba6cdb9dfcf4 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.h
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.h
@@ -306,9 +306,6 @@ struct es58x_parameters {
 	u16 tx_urb_cmd_max_len;
 	u16 rx_urb_cmd_max_len;
 	u16 fifo_mask;
-#ifdef CONFIG_BQL
-	u16 dql_limit_min;
-#endif
 	u8 tx_bulk_max;
 	u8 urb_cmd_header_len;
 	u8 rx_urb_max;
-- 
2.30.2


