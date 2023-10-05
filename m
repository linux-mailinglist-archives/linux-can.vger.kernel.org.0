Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8097BA04F
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 16:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbjJEOfz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 10:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbjJEOeW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 10:34:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323AC7EEB
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7j-0001Lh-Cc
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:19 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7g-00BDOI-S0
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:16 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8DCA522F7F1
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:16 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id DCF4F22F7E0;
        Thu,  5 Oct 2023 07:50:15 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b4117e18;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:54 +0200
Subject: [PATCH v2 26/27] can: at91_can: at91_alloc_can_err_skb() introduce
 new function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-26-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=jnsZYBG9Ll8sOkZU0cXHfeVV2zlIfJrPwNKGciemiUs=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmqxgn45DrZZDSoDDeS5cVnfxpq/QE5U1iIkk
 luBrZC77wiJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qsQAKCRC+UBxKKooE
 6B25B/9fRNrhoKQX1VgZ+dkthgESMCUng7jhurnPpJ+2nei4iwvRdy82PKM1GDd71MvjT5GJ5jh
 gE5f5Qf7mAxcdep7Ed9Z6+uESDqeJ4iPHof8p82BqZsVBrzlLAJnp5dpE34ykV7GYiP+7xXuVVV
 ZWQoD/To/R//V4FYaQ8/0FyHaBoYNgM+fpc9b8oz7ewhds6jfiXqGT8LidpyTEu1RAlJUnxI+6W
 TdG4bHwu6I91qhbsb2Qa1xSoEyAhJWv4dYjbIVopABQSAzE3cZ/5Sytbwoc9STLGUQusil4h5vq
 bwP7rfjxc/TQbj8XGzzC5gLz9mNLQxOqRHR/f6YILhC/4kgK
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

This is a preparation patch to convert the driver to make use of the
rx-offload helper. With rx-offload the received CAN frames are sorted
by their timestamp. Regular CAN RX'ed and TX'ed CAN frames are
timestamped by the hardware. Error events are not.

Introduce a new function at91_alloc_can_err_skb() the allocates an
error SKB and reads the current timestamp from the controller.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index d5e1d1b2cdd1..ca62aa027e5f 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -576,6 +576,22 @@ static inline void at91_activate_rx_mb(const struct at91_priv *priv,
 	at91_write(priv, AT91_TCR, mask);
 }
 
+static inline u32 at91_get_timestamp(const struct at91_priv *priv)
+{
+	return at91_read(priv, AT91_TIM);
+}
+
+static inline struct sk_buff *
+at91_alloc_can_err_skb(struct net_device *dev,
+		       struct can_frame **cf, u32 *timestamp)
+{
+	const struct at91_priv *priv = netdev_priv(dev);
+
+	*timestamp = at91_get_timestamp(priv);
+
+	return alloc_can_err_skb(dev, cf);
+}
+
 /**
  * at91_rx_overflow_err - send error frame due to rx overflow
  * @dev: net device

-- 
2.40.1


