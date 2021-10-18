Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676B0431928
	for <lists+linux-can@lfdr.de>; Mon, 18 Oct 2021 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhJRMeU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Oct 2021 08:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhJRMeS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Oct 2021 08:34:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61F8C06161C
        for <linux-can@vger.kernel.org>; Mon, 18 Oct 2021 05:32:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mcRoD-0001TE-UV
        for linux-can@vger.kernel.org; Mon, 18 Oct 2021 14:32:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E18DA696733
        for <linux-can@vger.kernel.org>; Mon, 18 Oct 2021 12:32:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id A60E0696730;
        Mon, 18 Oct 2021 12:32:04 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1a1a9f30;
        Mon, 18 Oct 2021 12:32:04 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [RFC PATCH] can: peak_usb: CANFD: remove unused timestamp infrastructure
Date:   Mon, 18 Oct 2021 14:32:03 +0200
Message-Id: <20211018123203.2234904-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With the support for full 64 bit timestamps the old timestamping
infrastructure is obsolete. This patch removes the left over bits.

Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 13 -----------
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  2 --
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 23 --------------------
 3 files changed, 38 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 6107fef9f4a0..9411a76f315c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -192,19 +192,6 @@ void peak_usb_get_ts_time(struct peak_time_ref *time_ref, u32 ts, ktime_t *time)
 	}
 }
 
-/*
- * post received skb after having set any hw timestamp
- */
-int peak_usb_netif_rx(struct sk_buff *skb,
-		      struct peak_time_ref *time_ref, u32 ts_low)
-{
-	struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
-
-	peak_usb_get_ts_time(time_ref, ts_low, &hwts->hwtstamp);
-
-	return netif_rx(skb);
-}
-
 /* post received skb with native 64-bit hw timestamp */
 int peak_usb_netif_rx_64(struct sk_buff *skb, u32 ts_low, u32 ts_high)
 {
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index daa19f57e742..ffc2be6ef881 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -141,8 +141,6 @@ void peak_usb_init_time_ref(struct peak_time_ref *time_ref,
 void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
 void peak_usb_set_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
 void peak_usb_get_ts_time(struct peak_time_ref *time_ref, u32 ts, ktime_t *tv);
-int peak_usb_netif_rx(struct sk_buff *skb,
-		      struct peak_time_ref *time_ref, u32 ts_low);
 int peak_usb_netif_rx_64(struct sk_buff *skb, u32 ts_low, u32 ts_high);
 void peak_usb_async_complete(struct urb *urb);
 void peak_usb_restart_complete(struct peak_usb_device *dev);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 2770087d4d5d..394f4959a515 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -50,8 +50,6 @@ struct __packed pcan_ufd_fw_info {
 struct pcan_usb_fd_if {
 	struct peak_usb_device	*dev[PCAN_USB_MAX_CHANNEL];
 	struct pcan_ufd_fw_info	fw_info;
-	struct peak_time_ref	time_ref;
-	int			cm_ignore_count;
 	int			dev_opened_count;
 };
 
@@ -642,19 +640,6 @@ static int pcan_usb_fd_decode_overrun(struct pcan_usb_fd_if *usb_if,
 	return 0;
 }
 
-/* handle USB calibration message */
-static void pcan_usb_fd_decode_ts(struct pcan_usb_fd_if *usb_if,
-				  struct pucan_msg *rx_msg)
-{
-	struct pcan_ufd_ts_msg *ts = (struct pcan_ufd_ts_msg *)rx_msg;
-
-	/* should wait until clock is stabilized */
-	if (usb_if->cm_ignore_count > 0)
-		usb_if->cm_ignore_count--;
-	else
-		peak_usb_set_ts_now(&usb_if->time_ref, le32_to_cpu(ts->ts_low));
-}
-
 /* callback for bulk IN urb */
 static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 {
@@ -695,7 +680,6 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 			break;
 
 		case PCAN_UFD_MSG_CALIBRATION:
-			pcan_usb_fd_decode_ts(usb_if, rx_msg);
 			break;
 
 		case PUCAN_MSG_ERROR:
@@ -811,10 +795,6 @@ static int pcan_usb_fd_start(struct peak_usb_device *dev)
 
 	/* opening first device: */
 	if (pdev->usb_if->dev_opened_count == 0) {
-		/* reset time_ref */
-		peak_usb_init_time_ref(&pdev->usb_if->time_ref,
-				       &pcan_usb_pro_fd);
-
 		/* enable USB calibration messages */
 		err = pcan_usb_fd_set_options(dev, 1,
 					      PUCAN_OPTION_ERROR,
@@ -880,9 +860,6 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 		if (!pdev->cmd_buffer_addr)
 			goto err_out_1;
 
-		/* number of ts msgs to ignore before taking one into account */
-		pdev->usb_if->cm_ignore_count = 5;
-
 		err = pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_INFO,
 					    PCAN_USBPRO_INFO_FW,
 					    &pdev->usb_if->fw_info,
-- 
2.33.0


