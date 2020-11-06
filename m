Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A139D2A9A81
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgKFRLX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:11:23 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:33435 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgKFRLW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:11:22 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 4A810FF614
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 17:03:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3gO4KkK2fjhu for <linux-can@vger.kernel.org>;
        Fri,  6 Nov 2020 18:03:01 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 02/17] can: ems_usb: Added defines and product id needed for CPC-USB/FD
Date:   Fri,  6 Nov 2020 18:01:51 +0100
Message-Id: <20201106170206.32162-3-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index c6ea82b01418..50736e031eb2 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -40,6 +40,7 @@ MODULE_LICENSE("GPL v2");
 #define CPC_MSG_TYPE_OVERRUN         21 /* overrun events */
 #define CPC_MSG_TYPE_CAN_FRAME_ERROR 23 /* detected bus errors */
 #define CPC_MSG_TYPE_ERR_COUNTER     25 /* RX/TX error counter */
+#define CPC_MSG_TYPE_CANFD_FRAME     26 /* CAN FD frame */
 
 /* Messages from the PC to the CPC interface  */
 #define CPC_CMD_TYPE_CAN_FRAME     1   /* CAN data frame */
@@ -49,6 +50,7 @@ MODULE_LICENSE("GPL v2");
 #define CPC_CMD_TYPE_CAN_STATE     14  /* CAN state message */
 #define CPC_CMD_TYPE_EXT_CAN_FRAME 15  /* Extended CAN data frame */
 #define CPC_CMD_TYPE_EXT_RTR_FRAME 16  /* Extended CAN remote frame */
+#define CPC_CMD_TYPE_CANFD_FRAME   26  /* CAN FD frame */
 #define CPC_CMD_TYPE_CAN_EXIT      200 /* exit the CAN */
 
 #define CPC_CMD_TYPE_INQ_ERR_COUNTER 25 /* request the CAN error counters */
@@ -56,6 +58,7 @@ MODULE_LICENSE("GPL v2");
 #define CPC_CMD_TYPE_CLEAR_CMD_QUEUE 28 /* clear CPC_CMD queue */
 
 #define CPC_CC_TYPE_SJA1000 2 /* NXP CAN controller */
+#define CPC_CC_TYPE_GENERIC 6 /* GENERIC CAN controller */
 
 #define CPC_CAN_ECODE_ERRFRAME 0x01 /* Ecode type */
 
@@ -77,6 +80,7 @@ MODULE_LICENSE("GPL v2");
 #define USB_CPCUSB_VENDOR_ID 0x12D6
 
 #define USB_CPCUSB_ARM7_PRODUCT_ID 0x0444
+#define USB_CPCUSB_FD_PRODUCT_ID   0x0544
 
 /* Mode register NXP LPC2119/SJA1000 CAN Controller */
 #define SJA1000_MOD_NORMAL 0x00
-- 
2.26.2

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
