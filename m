Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51F63B4422
	for <lists+linux-can@lfdr.de>; Fri, 25 Jun 2021 15:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhFYNN3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Jun 2021 09:13:29 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:34750 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231524AbhFYNN3 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 25 Jun 2021 09:13:29 -0400
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 7CE005FFA2;
        Fri, 25 Jun 2021 15:10:33 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 3/5] can: peak_usb: pcan_usb_handle_bus_evt(): fix reading rxerr/txerr values
Date:   Fri, 25 Jun 2021 15:09:29 +0200
Message-Id: <20210625130931.27438-4-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210625130931.27438-1-s.grosjean@peak-system.com>
References: <20210625130931.27438-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch fixes an incorrect way of reading error counters in messages
received for this purpose from the PCAN-USB interface. These messages
inform about the increase or decrease of the error counters, whose values
are placed in bytes 1 and 2 of the message data (not 0 and 1).

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 4c86cf58eac3..341ace36570b 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -121,7 +121,8 @@
 #define PCAN_USB_BERR_MASK	(PCAN_USB_ERR_RXERR | PCAN_USB_ERR_TXERR)
 
 /* identify bus event packets with rx/tx error counters */
-#define PCAN_USB_ERR_CNT		0x80
+#define PCAN_USB_ERR_CNT_DEC		0x00	/* counters are decreasing */
+#define PCAN_USB_ERR_CNT_INC		0x80	/* counters are increasing */
 
 /* private to PCAN-USB adapter */
 struct pcan_usb {
@@ -613,11 +614,12 @@ static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 ir)
 
 	/* acccording to the content of the packet */
 	switch (ir) {
-	case PCAN_USB_ERR_CNT:
+	case PCAN_USB_ERR_CNT_DEC:
+	case PCAN_USB_ERR_CNT_INC:
 
 		/* save rx/tx error counters from in the device context */
-		pdev->bec.rxerr = mc->ptr[0];
-		pdev->bec.txerr = mc->ptr[1];
+		pdev->bec.rxerr = mc->ptr[1];
+		pdev->bec.txerr = mc->ptr[2];
 		break;
 
 	default:
-- 
2.25.1

