Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18DD3B663D
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbhF1P5l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 11:57:41 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:21480 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbhF1P5G (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 11:57:06 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d35 with ME
        id Nfu82501E0zjR6y03fubuH; Mon, 28 Jun 2021 17:54:37 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 28 Jun 2021 17:54:37 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 4/6] can: etas_es58x: add es58x_free_netdevs() to factorize code
Date:   Tue, 29 Jun 2021 00:54:18 +0900
Message-Id: <20210628155420.1176217-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
References: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Both es58x_probe() and es58x_disconnect() use a similar code snippet
to release the netdev resources. Factorize it in an helper function
named es58x_free_netdevs().

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 46 +++++++++++----------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index d2bb1b56f962..dbc4f75336a1 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -2107,6 +2107,25 @@ static int es58x_init_netdev(struct es58x_device *es58x_dev, int channel_idx)
 	return ret;
 }
 
+/**
+ * es58x_free_netdevs() - Release all network resorces of the device.
+ * @es58x_dev: ES58X device.
+ */
+static void es58x_free_netdevs(struct es58x_device *es58x_dev)
+{
+	int i;
+
+	for (i = 0; i < es58x_dev->num_can_ch; i++) {
+		struct net_device *netdev = es58x_dev->netdev[i];
+
+		if (!netdev)
+			continue;
+		unregister_candev(netdev);
+		es58x_dev->netdev[i] = NULL;
+		free_candev(netdev);
+	}
+}
+
 /**
  * es58x_get_product_info() - Get the product information and print them.
  * @es58x_dev: ES58X device.
@@ -2240,18 +2259,11 @@ static int es58x_probe(struct usb_interface *intf,
 
 	for (ch_idx = 0; ch_idx < es58x_dev->num_can_ch; ch_idx++) {
 		ret = es58x_init_netdev(es58x_dev, ch_idx);
-		if (ret)
-			goto cleanup_candev;
-	}
-
-	return ret;
-
- cleanup_candev:
-	for (ch_idx = 0; ch_idx < es58x_dev->num_can_ch; ch_idx++)
-		if (es58x_dev->netdev[ch_idx]) {
-			unregister_candev(es58x_dev->netdev[ch_idx]);
-			free_candev(es58x_dev->netdev[ch_idx]);
+		if (ret) {
+			es58x_free_netdevs(es58x_dev);
+			return ret;
 		}
+	}
 
 	return ret;
 }
@@ -2266,21 +2278,11 @@ static int es58x_probe(struct usb_interface *intf,
 static void es58x_disconnect(struct usb_interface *intf)
 {
 	struct es58x_device *es58x_dev = usb_get_intfdata(intf);
-	struct net_device *netdev;
-	int i;
 
 	dev_info(&intf->dev, "Disconnecting %s %s\n",
 		 es58x_dev->udev->manufacturer, es58x_dev->udev->product);
 
-	for (i = 0; i < es58x_dev->num_can_ch; i++) {
-		netdev = es58x_dev->netdev[i];
-		if (!netdev)
-			continue;
-		unregister_candev(netdev);
-		es58x_dev->netdev[i] = NULL;
-		free_candev(netdev);
-	}
-
+	es58x_free_netdevs(es58x_dev);
 	es58x_free_urbs(es58x_dev);
 	usb_set_intfdata(intf, NULL);
 }
-- 
2.31.1

