Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC2D279B95
	for <lists+linux-can@lfdr.de>; Sat, 26 Sep 2020 19:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgIZRrM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 26 Sep 2020 13:47:12 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:36872 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgIZRrL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 26 Sep 2020 13:47:11 -0400
Received: from tomoyo.flets-east.jp ([153.230.197.127])
        by mwinf5d89 with ME
        id Yhlm230082lQRaH03hn6A8; Sat, 26 Sep 2020 19:47:10 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Sep 2020 19:47:10 +0200
X-ME-IP: 153.230.197.127
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] USB: cdc-acm: blacklist ETAS ES58X device
Date:   Sun, 27 Sep 2020 02:45:36 +0900
Message-Id: <20200926174542.278166-7-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200926174542.278166-1-mailhol.vincent@wanadoo.fr>
References: <20200926174542.278166-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The ES58X devices are incorrectly recognized as USB Modem (CDC ACM),
preventing the etas-es58x module to load.

Thus, these have been added
to the ignore list in drivers/usb/class/cdc-acm.c

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/usb/class/cdc-acm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 7f6f3ab5b8a6..ed9355094e8c 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1906,6 +1906,17 @@ static const struct usb_device_id acm_ids[] = {
 	.driver_info = IGNORE_DEVICE,
 	},
 
+	/* Exclude ETAS ES58x */
+	{ USB_DEVICE(0x108c, 0x0159), /* ES581.4 */
+	.driver_info = IGNORE_DEVICE,
+	},
+	{ USB_DEVICE(0x108c, 0x0168), /* ES582.1 */
+	.driver_info = IGNORE_DEVICE,
+	},
+	{ USB_DEVICE(0x108c, 0x0169), /* ES584.1 */
+	.driver_info = IGNORE_DEVICE,
+	},
+
 	{ USB_DEVICE(0x1bc7, 0x0021), /* Telit 3G ACM only composition */
 	.driver_info = SEND_ZERO_PACKET,
 	},
-- 
2.26.2

