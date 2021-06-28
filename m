Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6FF3B663A
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 17:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhF1P5U (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 11:57:20 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:55524 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbhF1P4t (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 11:56:49 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d35 with ME
        id Nfu82501E0zjR6y03fuLqu; Mon, 28 Jun 2021 17:54:22 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 28 Jun 2021 17:54:22 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 1/6] can: etas_es58x: fix three typos in author name and documentation
Date:   Tue, 29 Jun 2021 00:54:15 +0900
Message-Id: <20210628155420.1176217-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
References: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Change the author name from "lastname firstname" to "firstname
lastname".

Fix a typo in a variable name in the documentation of struct
es58x_parameters::fifo_mask.

Fix a typo in the title of the datasheet (E701 -> E70) and re-indent
the comments.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c |  2 +-
 drivers/net/can/usb/etas_es58x/es58x_core.h |  2 +-
 drivers/net/can/usb/etas_es58x/es58x_fd.c   | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 8e9102482c52..4758f793627a 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -19,7 +19,7 @@
 #include "es58x_core.h"
 
 #define DRV_VERSION "1.00"
-MODULE_AUTHOR("Mailhol Vincent <mailhol.vincent@wanadoo.fr>");
+MODULE_AUTHOR("Vincent Mailhol <mailhol.vincent@wanadoo.fr>");
 MODULE_AUTHOR("Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>");
 MODULE_DESCRIPTION("Socket CAN driver for ETAS ES58X USB adapters");
 MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.h b/drivers/net/can/usb/etas_es58x/es58x_core.h
index fcf219e727bf..826a15871573 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.h
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.h
@@ -287,7 +287,7 @@ struct es58x_priv {
  * @rx_urb_cmd_max_len: Maximum length of a RX URB command.
  * @fifo_mask: Bit mask to quickly convert the tx_tail and tx_head
  *	field of the struct es58x_priv into echo_skb
- *	indexes. Properties: @fifo_mask = echos_skb_max - 1 where
+ *	indexes. Properties: @fifo_mask = echo_skb_max - 1 where
  *	echo_skb_max must be a power of two. Also, echo_skb_max must
  *	not exceed the maximum size of the device internal TX FIFO
  *	length. This parameter is used to control the network queue
diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
index 15652132e315..f19022ca8f25 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
@@ -463,9 +463,9 @@ static int es58x_fd_get_timestamp(struct es58x_device *es58x_dev)
 }
 
 /* Nominal bittiming constants for ES582.1 and ES584.1 as specified in
- * the microcontroller datasheet: "SAM E701/S70/V70/V71 Family"
- * section 49.6.8 "MCAN Nominal Bit Timing and Prescaler Register"
- * from Microchip.
+ * the microcontroller datasheet: "SAM E70/S70/V70/V71 Family" section
+ * 49.6.8 "MCAN Nominal Bit Timing and Prescaler Register" from
+ * Microchip.
  *
  * The values from the specification are the hardware register
  * values. To convert them to the functional values, all ranges were
@@ -484,8 +484,8 @@ static const struct can_bittiming_const es58x_fd_nom_bittiming_const = {
 };
 
 /* Data bittiming constants for ES582.1 and ES584.1 as specified in
- * the microcontroller datasheet: "SAM E701/S70/V70/V71 Family"
- * section 49.6.4 "MCAN Data Bit Timing and Prescaler Register" from
+ * the microcontroller datasheet: "SAM E70/S70/V70/V71 Family" section
+ * 49.6.4 "MCAN Data Bit Timing and Prescaler Register" from
  * Microchip.
  */
 static const struct can_bittiming_const es58x_fd_data_bittiming_const = {
@@ -501,9 +501,9 @@ static const struct can_bittiming_const es58x_fd_data_bittiming_const = {
 };
 
 /* Transmission Delay Compensation constants for ES582.1 and ES584.1
- * as specified in the microcontroller datasheet: "SAM
- * E701/S70/V70/V71 Family" section 49.6.15 "MCAN Transmitter Delay
- * Compensation Register" from Microchip.
+ * as specified in the microcontroller datasheet: "SAM E70/S70/V70/V71
+ * Family" section 49.6.15 "MCAN Transmitter Delay Compensation
+ * Register" from Microchip.
  */
 static const struct can_tdc_const es58x_tdc_const = {
 	.tdcv_min = 0,
-- 
2.31.1

