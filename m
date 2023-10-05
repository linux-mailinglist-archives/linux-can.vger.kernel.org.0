Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DDC7B9F50
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 16:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjJEOVd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 10:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjJEOTo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 10:19:44 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E52A7ED1
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7e-0001Dq-W9
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:15 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7e-00BDKH-A2
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 08EA722F795
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 51C1022F784;
        Thu,  5 Oct 2023 07:50:13 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 284343d8;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:29 +0200
Subject: [PATCH v2 01/27] can: dev: add can_state_get_by_berr_counter() to
 return the CAN state based on the current error counters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-1-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2265; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=/n+//jbEFVntgX6pMIGgucvZBSKnsOh7NM80s7w5zZY=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmqLGTTNzyf6DZVIR3WAUiFzicaBns8/eRSyz
 i7Mx5PtMOWJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qiwAKCRC+UBxKKooE
 6E/BB/9QQOKoUuYpIwrj7ELV3dhrUG4sXWD7fUFKFl2Ax8AtTw6qpGaqoLrSScBQuLicBLgYGiM
 p6ffyym1YWOPDsGQA7jtvFFGSosPywCcgucutEffIgkKEP3mUQE0kt1eclwGd+UlJLUMx359iWh
 q9DBYX+q6yMEgiZxWeV6kKhN60RCj6VlZQfBCXQftVKWY7lct1zJWv88sq/YQ8KkgGZC/Sm7jiT
 S6DdYijA4W3iv0UwsmEI5QGlJCPFMWUiqVZN+7ZFZ1fK/rvB04dx/mfhsk+NGCX+9NaohaFrXK+
 QRtHjI13FPrPWyXWToygPzeUicSRhyJ8ENt1FyD5reyN9Ytt
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
index 7f9334a8af50..a0db1f78d61d 100644
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


