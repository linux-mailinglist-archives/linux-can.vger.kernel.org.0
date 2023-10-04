Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DCE7B7BF8
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbjJDJYa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241780AbjJDJYW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:24:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19878C4
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:24:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny77-0005Rm-7K
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:17 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny74-00Azmt-Vd
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:15 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A2E9B22EB95
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:24:14 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id B0B6C22EB7D;
        Wed,  4 Oct 2023 09:24:13 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 84903172;
        Wed, 4 Oct 2023 09:24:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:23:42 +0200
Subject: [PATCH 23/27] can: at91_can: at91_irq_err_line(): take reg_sr into
 account for bus off
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-at91_can-rx_offload-v1-23-c32bf99097db@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
In-Reply-To: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2820; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=zgfoSThHFFtm5JgJ/2vr2LqaSw1lapiP8CL75Id9TCM=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS8zOA49DokwMlLOCzaU9dqSZvTFe8zPUuZm/
 Pjbt5H+U4KJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0vMwAKCRC+UBxKKooE
 6IIIB/4gY9JslA4zWVLlNjeh0PrwjeqU3vRbzlpppgRLhyLs4eaRgEG6/4aGMGz2KChItjMhtFs
 RThTXdHp5QkJD3J6Hixep4BROWJ6Omb38Wx1YxBYwWgz7hr8MdMmuwetir6+lxaipFrDWGDVm85
 dKFenBRUh14yhxkdhmKBboCRUXufOspd7G8QiTDlkF45QHCXYEY16KYzn+/1vbjP/0zzs8N5OQR
 uooV0wo60tIRK0q6BpbeP10gB2Za/h/8toeYLrZBfLxlFHeORZETxV3szmBiLkpsomkKUGXoqUc
 h49EIkkwA8UFN/Du2KtdVqUbZo2zkD+Wt0mO6rfb6aOV7WeB
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

The at91 CAN controller automatically recovers from bus-off after 128
occurrences of 11 consecutive recessive bits.

After an auto-recovered bus-off, the error counters no longer reflect
this fact. On the sam9263 the state bits in the SR register show the
current state (based on the current error counters), while on sam9x5
and newer SoCs these bits are latched.

Take any latched bus-off information from the SR register into account
when calculating the CAN new state, to start the standard CAN bus off
handling.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 68b611d0fa6c..fbe58a1a1989 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -437,6 +437,11 @@ static void at91_chip_start(struct net_device *dev)
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
+	/* Dummy read to clear latched line error interrupts on
+	 * sam9x5 and newer SoCs.
+	 */
+	at91_read(priv, AT91_SR);
+
 	/* Enable interrupts */
 	reg_ier = get_irq_mb_rx(priv) | AT91_IRQ_ERRP | AT91_IRQ_ERR_FRAME;
 	at91_write(priv, AT91_IER, reg_ier);
@@ -932,7 +937,7 @@ static void at91_irq_err_state(struct net_device *dev,
 	at91_write(priv, AT91_IER, reg_ier);
 }
 
-static void at91_irq_err_line(struct net_device *dev)
+static void at91_irq_err_line(struct net_device *dev, const u32 reg_sr)
 {
 	enum can_state new_state, rx_state, tx_state;
 	struct at91_priv *priv = netdev_priv(dev);
@@ -942,6 +947,23 @@ static void at91_irq_err_line(struct net_device *dev)
 
 	at91_get_berr_counter(dev, &bec);
 	can_state_get_by_berr_counter(dev, &bec, &tx_state, &rx_state);
+
+	/* The chip automatically recovers from bus-off after 128
+	 * occurrences of 11 consecutive recessive bits.
+	 *
+	 * After an auto-recovered bus-off, the error counters no
+	 * longer reflect this fact. On the sam9263 the state bits in
+	 * the SR register show the current state (based on the
+	 * current error counters), while on sam9x5 and newer SoCs
+	 * these bits are latched.
+	 *
+	 * Take any latched bus-off information from the SR register
+	 * into account when calculating the CAN new state, to start
+	 * the standard CAN bus off handling.
+	 */
+	if (reg_sr & AT91_IRQ_BOFF)
+		rx_state = CAN_STATE_BUS_OFF;
+
 	new_state = max(tx_state, rx_state);
 
 	/* state hasn't changed */
@@ -1050,7 +1072,7 @@ static irqreturn_t at91_irq(int irq, void *dev_id)
 	if (reg_sr & get_irq_mb_tx(priv))
 		at91_irq_tx(dev, reg_sr);
 
-	at91_irq_err_line(dev);
+	at91_irq_err_line(dev, reg_sr);
 
 	/* Frame Error Interrupt */
 	if (reg_sr & AT91_IRQ_ERR_FRAME)

-- 
2.40.1


