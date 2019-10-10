Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8360D2920
	for <lists+linux-can@lfdr.de>; Thu, 10 Oct 2019 14:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733301AbfJJMSB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Oct 2019 08:18:01 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39041 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbfJJMSB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Oct 2019 08:18:01 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iIXOI-0006Lw-RA; Thu, 10 Oct 2019 14:17:58 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc:     davem@davemloft.net, kernel@pengutronix.de,
        jhofstee@victronenergy.com,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Bernd Krumboeck <b.krumboeck@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 04/29] can: usb_8dev: fix use-after-free on disconnect
Date:   Thu, 10 Oct 2019 14:17:25 +0200
Message-Id: <20191010121750.27237-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010121750.27237-1-mkl@pengutronix.de>
References: <20191010121750.27237-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

The driver was accessing its driver data after having freed it.

Fixes: 0024d8ad1639 ("can: usb_8dev: Add support for USB2CAN interface from 8 devices")
Cc: stable <stable@vger.kernel.org>     # 3.9
Cc: Bernd Krumboeck <b.krumboeck@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/usb_8dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index d596a2ad7f78..8fa224b28218 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -996,9 +996,8 @@ static void usb_8dev_disconnect(struct usb_interface *intf)
 		netdev_info(priv->netdev, "device disconnected\n");
 
 		unregister_netdev(priv->netdev);
-		free_candev(priv->netdev);
-
 		unlink_all_urbs(priv);
+		free_candev(priv->netdev);
 	}
 
 }
-- 
2.23.0

