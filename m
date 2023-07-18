Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C70758061
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 17:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjGRPGH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 11:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjGRPGG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 11:06:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ADF10F1
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 08:06:05 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLmH5-0003aG-I4
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 17:06:03 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B83E01F4368
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 15:06:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id F25801F435C;
        Tue, 18 Jul 2023 15:06:01 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 579e990d;
        Tue, 18 Jul 2023 15:06:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 18 Jul 2023 17:05:49 +0200
Subject: [PATCH v2 2/3] can: rx-offload: add
 can_rx_offload_get_echo_skb_queue_tail()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-gs_usb-rx-offload-v2-2-716e542d14d5@pengutronix.de>
References: <20230718-gs_usb-rx-offload-v2-0-716e542d14d5@pengutronix.de>
In-Reply-To: <20230718-gs_usb-rx-offload-v2-0-716e542d14d5@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2893; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=5ETi2Qe+AiH4EnZHcFNk/HBG7Lj+/2jPeFnqBiQ9zNQ=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktqpUJCcdxCECSVbP/xKh9BA1oAFChHcYW/HjA
 HXBM97c5EuJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLaqVAAKCRC+UBxKKooE
 6FCmB/9oxzoCeuPGf8hB6iY1HHIV/nwGKw49nuJtZcmP+mpayRpSI6FtqRn5ga0jDkttdBZ1kqK
 t8K1ztglY83RFtlAFRAuUdYoTc2MCHUvrdKjCO3IjdJnntQiXIAWgMa2gQRi2Af5d7i6Gs9NsrB
 24m2T8Z5AepIkh+ZgK25Uj1uigmm/d3/V4CIq8NJAit2bPWeLau4OdliSlgKW5ui6wLIaoxtk6i
 0tCsPgPVpGjonOlBLruphlRZzPJLUGEFSlEFdspiVDrhx1nyBcyZ2SJsqfifpOVIG59zfCdv73F
 ISDqpzSSkWZ3EpcRyo384qKJVyx6r1V14k4/L0Kpqr6sEHcA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add can_rx_offload_get_echo_skb_queue_tail(). This function addds the
echo skb at the end of rx-offload the queue. This is intended for
devices without timestamp support.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/rx-offload.c | 27 ++++++++++++++++++++++++++-
 include/linux/can/rx-offload.h   |  5 ++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index 6e87ad908346..77091f7d1fa7 100644
--- a/drivers/net/can/dev/rx-offload.c
+++ b/drivers/net/can/dev/rx-offload.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2014      Protonic Holland,
  *                         David Jander
- * Copyright (C) 2014-2021 Pengutronix,
+ * Copyright (C) 2014-2021, 2023 Pengutronix,
  *                         Marc Kleine-Budde <kernel@pengutronix.de>
  */
 
@@ -280,6 +280,31 @@ int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_queue_tail);
 
+unsigned int
+can_rx_offload_get_echo_skb_queue_tail(struct can_rx_offload *offload,
+				       unsigned int idx,
+				       unsigned int *frame_len_ptr)
+{
+	struct net_device *dev = offload->dev;
+	struct net_device_stats *stats = &dev->stats;
+	struct sk_buff *skb;
+	unsigned int len;
+	int err;
+
+	skb = __can_get_echo_skb(dev, idx, &len, frame_len_ptr);
+	if (!skb)
+		return 0;
+
+	err = can_rx_offload_queue_tail(offload, skb);
+	if (err) {
+		stats->rx_errors++;
+		stats->tx_fifo_errors++;
+	}
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_tail);
+
 void can_rx_offload_irq_finish(struct can_rx_offload *offload)
 {
 	unsigned long flags;
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index e3b4199732c6..d29bb4521947 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -3,7 +3,7 @@
  * linux/can/rx-offload.h
  *
  * Copyright (c) 2014 David Jander, Protonic Holland
- * Copyright (c) 2014-2017 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
+ * Copyright (c) 2014-2017, 2023 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
  */
 
 #ifndef _CAN_RX_OFFLOAD_H
@@ -49,6 +49,9 @@ unsigned int can_rx_offload_get_echo_skb_queue_timestamp(struct can_rx_offload *
 							 unsigned int *frame_len_ptr);
 int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 			      struct sk_buff *skb);
+unsigned int can_rx_offload_get_echo_skb_queue_tail(struct can_rx_offload *offload,
+						    unsigned int idx,
+						    unsigned int *frame_len_ptr);
 void can_rx_offload_irq_finish(struct can_rx_offload *offload);
 void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload);
 void can_rx_offload_del(struct can_rx_offload *offload);

-- 
2.40.1


