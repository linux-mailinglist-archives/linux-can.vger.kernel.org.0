Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FF63551BF
	for <lists+linux-can@lfdr.de>; Tue,  6 Apr 2021 13:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhDFLQt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Apr 2021 07:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbhDFLQm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Apr 2021 07:16:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC15C061760
        for <linux-can@vger.kernel.org>; Tue,  6 Apr 2021 04:16:32 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lTjh9-0000wy-9V
        for linux-can@vger.kernel.org; Tue, 06 Apr 2021 13:16:31 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 428E7608722
        for <linux-can@vger.kernel.org>; Tue,  6 Apr 2021 11:16:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id EF5E3608702;
        Tue,  6 Apr 2021 11:16:23 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a7d6ff42;
        Tue, 6 Apr 2021 11:16:23 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next-rfc 04/10] can: peak_usb: remove write only variable struct peak_usb_adapter::ts_period
Date:   Tue,  6 Apr 2021 13:16:16 +0200
Message-Id: <20210406111622.1874957-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406111622.1874957-1-mkl@pengutronix.de>
References: <20210406111622.1874957-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The variable struct peak_usb_adapter::ts_period is only ever written
to. This patch removes it from the driver.

Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      | 1 -
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 1 -
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 4 ----
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 1 -
 4 files changed, 7 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index e23049c81159..38bee69ff48a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -1050,7 +1050,6 @@ const struct peak_usb_adapter pcan_usb = {
 
 	/* timestamps usage */
 	.ts_used_bits = 16,
-	.ts_period = 24575, /* calibration period in ts. */
 	.us_per_ts_scale = PCAN_USB_TS_US_PER_TICK, /* us=(ts*scale) */
 	.us_per_ts_shift = PCAN_USB_TS_DIV_SHIFTER, /*  >> shift     */
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 64c4c22bb296..b00a4811bf61 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -73,7 +73,6 @@ struct peak_usb_adapter {
 	u8 ep_msg_in;
 	u8 ep_msg_out[PCAN_USB_MAX_CHANNEL];
 	u8 ts_used_bits;
-	u32 ts_period;
 	u8 us_per_ts_shift;
 	u32 us_per_ts_scale;
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 6f62b6f51051..b11eabad575b 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -1081,7 +1081,6 @@ const struct peak_usb_adapter pcan_usb_fd = {
 
 	/* timestamps usage */
 	.ts_used_bits = 32,
-	.ts_period = 1000000, /* calibration period in ts. */
 	.us_per_ts_scale = 1, /* us = (ts * scale) >> shift */
 	.us_per_ts_shift = 0,
 
@@ -1156,7 +1155,6 @@ const struct peak_usb_adapter pcan_usb_chip = {
 
 	/* timestamps usage */
 	.ts_used_bits = 32,
-	.ts_period = 1000000, /* calibration period in ts. */
 	.us_per_ts_scale = 1, /* us = (ts * scale) >> shift */
 	.us_per_ts_shift = 0,
 
@@ -1231,7 +1229,6 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 
 	/* timestamps usage */
 	.ts_used_bits = 32,
-	.ts_period = 1000000, /* calibration period in ts. */
 	.us_per_ts_scale = 1, /* us = (ts * scale) >> shift */
 	.us_per_ts_shift = 0,
 
@@ -1306,7 +1303,6 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 
 	/* timestamps usage */
 	.ts_used_bits = 32,
-	.ts_period = 1000000, /* calibration period in ts. */
 	.us_per_ts_scale = 1, /* us = (ts * scale) >> shift */
 	.us_per_ts_shift = 0,
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index ecb08359f719..589ba797fb33 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -1058,7 +1058,6 @@ const struct peak_usb_adapter pcan_usb_pro = {
 
 	/* timestamps usage */
 	.ts_used_bits = 32,
-	.ts_period = 1000000, /* calibration period in ts. */
 	.us_per_ts_scale = 1, /* us = (ts * scale) >> shift */
 	.us_per_ts_shift = 0,
 
-- 
2.30.2


