Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A842C3CD0
	for <lists+linux-can@lfdr.de>; Wed, 25 Nov 2020 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgKYJrb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Nov 2020 04:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgKYJrb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Nov 2020 04:47:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F160CC0613D4
        for <linux-can@vger.kernel.org>; Wed, 25 Nov 2020 01:47:30 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1khrOb-0004oL-KP
        for linux-can@vger.kernel.org; Wed, 25 Nov 2020 10:47:29 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A778B59B670
        for <linux-can@vger.kernel.org>; Wed, 25 Nov 2020 09:47:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5755F59B66C;
        Wed, 25 Nov 2020 09:47:28 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 95a64aaf;
        Wed, 25 Nov 2020 09:47:27 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org, joe@perches.com,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next v2] can: pcan_usb_core: fix fall-through warnings for Clang
Date:   Wed, 25 Nov 2020 10:47:26 +0100
Message-Id: <20201125094726.4009048-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning by
moving the "default" to the end of the "switch" statement and explicitly adding
a break statement instead of letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: http://lore.kernel.org/r/aab7cf16bf43cc7c3e9c9930d2dae850c1d07a3c.1605896059.git.gustavoars@kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
[mkl: move default to end]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

here the v2, with:

- moved default to the end
- added break to the default

I can take the patch upstream via linux-can-next -> net-next.

regards,
Marc

 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 204ccb27d6d9..251835ea15aa 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -295,15 +295,16 @@ static void peak_usb_write_bulk_callback(struct urb *urb)
 		netif_trans_update(netdev);
 		break;
 
-	default:
-		if (net_ratelimit())
-			netdev_err(netdev, "Tx urb aborted (%d)\n",
-				   urb->status);
 	case -EPROTO:
 	case -ENOENT:
 	case -ECONNRESET:
 	case -ESHUTDOWN:
+		break;
 
+	default:
+		if (net_ratelimit())
+			netdev_err(netdev, "Tx urb aborted (%d)\n",
+				   urb->status);
 		break;
 	}
 
-- 
2.29.2


