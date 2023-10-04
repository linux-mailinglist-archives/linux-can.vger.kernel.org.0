Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E4B7B7BF4
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjJDJY2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjJDJYW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:24:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B72C6
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:24:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny77-0005SC-BU
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:17 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny75-00AznF-8B
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:15 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E6BF622EB99
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:24:14 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id F091A22EB86;
        Wed,  4 Oct 2023 09:24:13 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0fa1ab0f;
        Wed, 4 Oct 2023 09:24:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:23:44 +0200
Subject: [PATCH 25/27] can: at91_can: at91_irq_err_line(): send error
 counters with state change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-at91_can-rx_offload-v1-25-c32bf99097db@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
In-Reply-To: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=931; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=/oFRRZWxRREU3fRYUaUyvU5sCBt2nmKgpU1wxOhzQ0k=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS82KIiDnIWgqNhmImXG/peOOFQk2v84j4y8r
 CEAi6X2CeaJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0vNgAKCRC+UBxKKooE
 6NdWCACZE1nm7CMuL/e0qzmQqgW2OvEoYvaCJ3MlHLIp11Fd09q9KUKEQOeNEQfBpAAOa5BycU7
 fouJLXo7eJlkVqpCzFJskBCsjQ1P5LMw00t1YEVnUY0gFYXyjYP6W/r2KcyMZ5twxFHx+Af9q+R
 XxVbTrmvI6foh7x9Nt32TpuuYGgh9+yGxrfWqBN4HyccQ0oTOrA9afcK0dVSsQz+2ARIRn1TjHN
 dQ28Lu+nnohJX9IaPvqVZY2GcotBPMVeCSsKTYq6Ravf3IW+ZmKnezBr+1t7ZMWvo3bOo7HxFCh
 G7sblfRa2kEFy1fkjJ/G0uFxkUxthptnFYqIPum8yTGmN/Wx
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

Since 3e5c291c7942 ("can: add CAN_ERR_CNT flag to notify availability
of error counter") there is a dedicated flag to inform the user space,
that there are CAN error counters in the CAN error frame.

In case the device is not in bus off mode, send the error counters to
user space and set CAN_ERR_CNT.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index a413589109b2..d5e1d1b2cdd1 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -884,6 +884,11 @@ static void at91_irq_err_line(struct net_device *dev, const u32 reg_sr)
 	if (unlikely(!skb))
 		return;
 
+	if (new_state != CAN_STATE_BUS_OFF) {
+		cf->can_id |= CAN_ERR_CNT;
+		cf->data[6] = bec.txerr;
+		cf->data[7] = bec.rxerr;
+	}
 
 	netif_rx(skb);
 }

-- 
2.40.1


