Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB47B7BE2
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241094AbjJDJYV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjJDJYS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:24:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0917CAC
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:24:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny73-0005M4-51
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:13 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny72-00AzjJ-DJ
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:12 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 20AFF22EB3C
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:24:12 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5BBCD22EB2B;
        Wed,  4 Oct 2023 09:24:11 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f5902a97;
        Wed, 4 Oct 2023 09:24:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:23:20 +0200
Subject: [PATCH 01/27] can: dev: add can_state_get_by_berr_counter() to
 return the CAN state based on the current error counters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-at91_can-rx_offload-v1-1-c32bf99097db@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
In-Reply-To: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=3Y6/gLFq92iV3eUCWYPgvbVRrkD6RcYBBCsR40WL6ws=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS8S/p5xq8xdjKVEN67GIej6icInFxmYya4UH
 ojYFCEirhiJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0vEgAKCRC+UBxKKooE
 6LJeCAClA/9/IiToHpClivj43FvJ9/ap9e7KtxmKC6ppafyXREKuvN2mwu89TTitAaiOerRKL/P
 Xw41u3ZYUMy3XhFr13quzBli/Q2bNCMs7tW+5ezLIi7enkVH++fv8dxTVzrobhDm8KnqoNE55wM
 2k3KEdCk+aFKurPD+qobitN7JSIKe/KAiJpiN6d4FIxvvG7RVZuRb95zrKAve2AjlhEA/KSLt4F
 chxFC06uzv43eBeOvUF1Af3B1KvU5VUxUHlgsCs6RcEotUv+VtHNV0wEO+rrsM+LnxfuX4T5OC2
 8OSN+9aNSPtd+eXjWFg3xm+d5ux2rmHiM5nlchaVVQpvHiPO
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
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

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 22 ++++++++++++++++++++++
 include/linux/can/dev.h   |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 7f9334a8af50..6242424fadbc 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -90,6 +90,28 @@ const char *can_get_state_str(const enum can_state state)
 }
 EXPORT_SYMBOL_GPL(can_get_state_str);
 
+static enum can_state can_state_err_to_state(u16 err)
+{
+	if (err < 96)
+		return CAN_STATE_ERROR_ACTIVE;
+	if (err < 128)
+		return CAN_STATE_ERROR_WARNING;
+	if (err < 256)
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


