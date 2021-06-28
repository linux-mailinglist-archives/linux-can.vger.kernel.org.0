Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2CF3B663B
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 17:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhF1P5Z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 11:57:25 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:34056 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbhF1P4y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 11:56:54 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d35 with ME
        id Nfu82501E0zjR6y03fuSrg; Mon, 28 Jun 2021 17:54:28 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 28 Jun 2021 17:54:28 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 2/6] can: etas_es58x: use error pointer during device probing
Date:   Tue, 29 Jun 2021 00:54:16 +0900
Message-Id: <20210628155420.1176217-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
References: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Make es58x_init_es58x_dev return a pointer to the allocated structure
instead of returning an integer. Errors are handled through the helper
function ERR_PTR and IS_ERR.

This slightly simplifies the code.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 23 +++++++++------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 4758f793627a..7650e349cae1 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -2152,14 +2152,13 @@ static int es58x_get_product_info(struct es58x_device *es58x_dev)
 /**
  * es58x_init_es58x_dev() - Initialize the ES58X device.
  * @intf: USB interface.
- * @p_es58x_dev: pointer to the address of the ES58X device.
  * @driver_info: Quirks of the device.
  *
- * Return: zero on success, errno when any error occurs.
+ * Return: pointer to an ES58X device on success, error pointer when
+ *	any error occurs.
  */
-static int es58x_init_es58x_dev(struct usb_interface *intf,
-				struct es58x_device **p_es58x_dev,
-				kernel_ulong_t driver_info)
+static struct es58x_device *es58x_init_es58x_dev(struct usb_interface *intf,
+						 kernel_ulong_t driver_info)
 {
 	struct device *dev = &intf->dev;
 	struct es58x_device *es58x_dev;
@@ -2176,7 +2175,7 @@ static int es58x_init_es58x_dev(struct usb_interface *intf,
 	ret = usb_find_common_endpoints(intf->cur_altsetting, &ep_in, &ep_out,
 					NULL, NULL);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
 	if (driver_info & ES58X_FD_FAMILY) {
 		param = &es58x_fd_param;
@@ -2188,7 +2187,7 @@ static int es58x_init_es58x_dev(struct usb_interface *intf,
 
 	es58x_dev = kzalloc(es58x_sizeof_es58x_device(param), GFP_KERNEL);
 	if (!es58x_dev)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	es58x_dev->param = param;
 	es58x_dev->ops = ops;
@@ -2213,9 +2212,7 @@ static int es58x_init_es58x_dev(struct usb_interface *intf,
 					     ep_out->bEndpointAddress);
 	es58x_dev->rx_max_packet_size = le16_to_cpu(ep_in->wMaxPacketSize);
 
-	*p_es58x_dev = es58x_dev;
-
-	return 0;
+	return es58x_dev;
 }
 
 /**
@@ -2232,9 +2229,9 @@ static int es58x_probe(struct usb_interface *intf,
 	struct es58x_device *es58x_dev;
 	int ch_idx, ret;
 
-	ret = es58x_init_es58x_dev(intf, &es58x_dev, id->driver_info);
-	if (ret)
-		return ret;
+	es58x_dev = es58x_init_es58x_dev(intf, id->driver_info);
+	if (IS_ERR(es58x_dev))
+		return PTR_ERR(es58x_dev);
 
 	ret = es58x_get_product_info(es58x_dev);
 	if (ret)
-- 
2.31.1

