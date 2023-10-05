Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E41D7BAAE4
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 21:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjJET6a (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 15:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjJET6Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 15:58:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5EFFF
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 12:58:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUG-0004jd-5m
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:20 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUD-00BLGg-JZ
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:17 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4967422FFCD
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 19:58:17 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 409EF22FF7D;
        Thu,  5 Oct 2023 19:58:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a711694b;
        Thu, 5 Oct 2023 19:58:14 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/37] can: dev: add can_state_get_by_berr_counter() to return the CAN state based on the current error counters
Date:   Thu,  5 Oct 2023 21:57:46 +0200
Message-Id: <20231005195812.549776-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231005195812.549776-1-mkl@pengutronix.de>
References: <20231005195812.549776-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Some CAN controllers do not have a register that contains the current
CAN state, but only a register that contains the error counters.

Introduce a new function can_state_get_by_berr_counter() that returns
the current TX and RX state depending on the provided CAN bit error
counters.

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-1-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 22 ++++++++++++++++++++++
 include/linux/can/dev.h   |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 82b12902fc35..3a3be5cdfc1f 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -90,6 +90,28 @@ const char *can_get_state_str(const enum can_state state)
 }
 EXPORT_SYMBOL_GPL(can_get_state_str);
 
+static enum can_state can_state_err_to_state(u16 err)
+{
+	if (err < CAN_ERROR_WARNING_THRESHOLD)
+		return CAN_STATE_ERROR_ACTIVE;
+	if (err < CAN_ERROR_PASSIVE_THRESHOLD)
+		return CAN_STATE_ERROR_WARNING;
+	if (err < CAN_BUS_OFF_THRESHOLD)
+		return CAN_STATE_ERROR_PASSIVE;
+
+	return CAN_STATE_BUS_OFF;
+}
+
+void can_state_get_by_berr_counter(const struct net_device *dev,
+				   const struct can_berr_counter *bec,
+				   enum can_state *tx_state,
+				   enum can_state *rx_state)
+{
+	*tx_state = can_state_err_to_state(bec->txerr);
+	*rx_state = can_state_err_to_state(bec->rxerr);
+}
+EXPORT_SYMBOL_GPL(can_state_get_by_berr_counter);
+
 void can_change_state(struct net_device *dev, struct can_frame *cf,
 		      enum can_state tx_state, enum can_state rx_state)
 {
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 982ba245eb41..1b92aed49363 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -195,6 +195,10 @@ int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
 
 const char *can_get_state_str(const enum can_state state);
+void can_state_get_by_berr_counter(const struct net_device *dev,
+				   const struct can_berr_counter *bec,
+				   enum can_state *tx_state,
+				   enum can_state *rx_state);
 void can_change_state(struct net_device *dev, struct can_frame *cf,
 		      enum can_state tx_state, enum can_state rx_state);
 
-- 
2.40.1


