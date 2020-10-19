Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEB5292E18
	for <lists+linux-can@lfdr.de>; Mon, 19 Oct 2020 21:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbgJSTFe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Oct 2020 15:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731030AbgJSTFe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2020 15:05:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53ADC0613D0
        for <linux-can@vger.kernel.org>; Mon, 19 Oct 2020 12:05:33 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kUaTM-0005v5-56; Mon, 19 Oct 2020 21:05:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-rfc 04/16] can: dev: can_get_len():  add a helper function to get the correct length of Classical frames
Date:   Mon, 19 Oct 2020 21:05:12 +0200
Message-Id: <20201019190524.1285319-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019190524.1285319-1-mkl@pengutronix.de>
References: <20201019190524.1285319-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

In classical CAN, the length of the data (i.e. CAN payload) is not
always equal to the DLC! If the frame is a Remote Transmission Request
(RTR), data length is always zero regardless of DLC value and else, if
the DLC is greater than 8, the length is 8. Contrary to common belief,
ISO 11898-1 Chapter 8.4.2.3 (DLC field) do allow DLCs greater than 8
for Classical Frames and specifies that those DLCs shall indicate that
the data field is 8 bytes long.

Above facts are widely unknown and so many developpers uses the "len"
field of "struct canfd_frame" to get the length of classical CAN
frames: this is incorrect!

This patch introduces function get_can_len() which can be used in
remediation. The function takes the SKB as an input in order to be
able to determine if the frame is classical or FD.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/r/20201002154219.4887-4-mailhol.vincent@wanadoo.fr
[mkl: renamed get_can_len() -> can_get_len()]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/dev.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 41ff31795320..2bb132fc6d88 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -192,6 +192,29 @@ u8 can_dlc2len(u8 can_dlc);
 /* map the sanitized data length to an appropriate data length code */
 u8 can_len2dlc(u8 len);
 
+/*
+ * can_get_len(skb) - get the length of the CAN payload.
+ *
+ * In classical CAN, the length of the data (i.e. CAN payload) is not
+ * always equal to the DLC! If the frame is a Remote Transmission
+ * Request (RTR), data length is always zero regardless of DLC value
+ * and else, if the DLC is greater than 8, the length is 8. Contrary
+ * to common belief, ISO 11898-1 Chapter 8.4.2.3 (DLC field) do allow
+ * DLCs greater than 8 for Classical Frames and specifies that those
+ * DLCs shall indicate that the data field is 8 bytes long.
+ */
+static inline u8 can_get_len(const struct sk_buff *skb)
+{
+	const struct canfd_frame *cf = (const struct canfd_frame *)skb->data;
+
+	if (can_is_canfd_skb(skb))
+		return min_t(u8, cf->len, CANFD_MAX_DLEN);
+	else if (cf->can_id & CAN_RTR_FLAG)
+		return 0;
+	else
+		return min_t(u8, cf->len, CAN_MAX_DLEN);
+}
+
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 				    unsigned int txqs, unsigned int rxqs);
 #define alloc_candev(sizeof_priv, echo_skb_max) \
-- 
2.28.0

