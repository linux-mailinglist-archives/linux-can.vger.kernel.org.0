Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B82D7B9DD4
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 15:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjJENzz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 09:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243822AbjJENt0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 09:49:26 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F087EE9
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7j-0001LT-A5
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:19 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7g-00BDOA-P7
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:16 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7769622F7F0
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:16 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C941E22F7DD;
        Thu,  5 Oct 2023 07:50:15 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9bd3f49f;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:53 +0200
Subject: [PATCH v2 25/27] can: at91_can: at91_irq_err_line(): send error
 counters with state change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-25-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=931; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=/oFRRZWxRREU3fRYUaUyvU5sCBt2nmKgpU1wxOhzQ0k=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmqwmhMzBXGWyZclCbDGIgtPPEo4UkAQpJdAd
 lbZ3YnKfgmJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qsAAKCRC+UBxKKooE
 6NGyCACsPTHohgFvSxbBf5v54DkVr17Yi2RUmvJEInNN6Qj9tb1+QOqp8NtA/BDNtEcpoKD8gtt
 1DvSy3BrL388MGD4t9bMFt323DbBsNz9GeGg45rgJqy2ur56Mk+VT34JuVNacub978JoZgrrY2z
 +RbbmDaBcMuxv+pjCr/3tYrIXtysY/ezU1Zh+hK9mi/eHnFvGPQ8YzPenU6GumYycWWFlaxsCSZ
 39duLlna5XsW51Q7iPMeEeNCYbvLJrVEtCiY7oTslPDL8by3B1qNQCNs+3EGq+DsAZheOdwaGhb
 pbdocFjZ0lSJxaggj0WQXWhHWmCdW3tAPZBmFsXXWmnrR8HZ
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


