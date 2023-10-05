Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6AE7BAB04
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 21:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjJET6u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 15:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjJET6b (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 15:58:31 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA00114
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 12:58:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUL-0004sT-OG
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:25 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoUUH-00BLMg-32
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 21:58:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D7248230068
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 19:58:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 49BD6230005;
        Thu,  5 Oct 2023 19:58:18 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id adb2caa9;
        Thu, 5 Oct 2023 19:58:15 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 35/37] can: at91_can: at91_irq_err_line(): send error counters with state change
Date:   Thu,  5 Oct 2023 21:58:10 +0200
Message-Id: <20231005195812.549776-36-mkl@pengutronix.de>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-25-9987d53600e0@pengutronix.de
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


