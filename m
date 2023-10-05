Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E047BA6C7
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjJEQlm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjJEQkO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:40:14 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0C67EDB
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7i-0001G8-08
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:18 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7f-00BDMO-KL
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:15 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5740822F7CA
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:15 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id A545F22F7AF;
        Thu,  5 Oct 2023 07:50:14 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e1a72088;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:42 +0200
Subject: [PATCH v2 14/27] can: at91_can: at91_chip_start(): don't disable
 IRQs twice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-14-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=814; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=gSd9/BJPdoW7J7vcURY0RIS4mTLqWcq6uhvw1HGLVbw=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmqfuCkeI2CxE/LD4PgGihIXLN5tpFu6f1BQJ
 oOKDK/45dyJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qnwAKCRC+UBxKKooE
 6NA5B/0RPFIfCB7tbbn5PXI33AG9ulfu3wN28sD5YwWQNiGmC87oGVrVTl0iw3mOQ/pwe/Bj+Qa
 rK2LirpfPS02dnLix/2NvJ/4RDxwzXjzJ1xbKY+K+PGICYVxfVp5RZfxV40oSvIZtTM0flX+dUT
 wm0gYMAjuvKun8dGdwxj4WHigkfUvI8FFxMroyQZOgglgXh2Qgkcn2nSXmlW1yAw9mZkrLD7I9k
 O/Z8kgEmALCLTxf6tUOWiiEMLDjkA/pnhpzEuKqdcdDMq1Zxc9HNePJ0OeWU7I4sr3PLX/8u1j+
 ubvsEaIbmGqZthl4HV2eMpDTtC5tctNdvm2h1Gsqv48WmsHg
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

In at91_chip_start() first all IRQs are disabled, they do not have to
be disabled again at the end of the function before the requested IRQs
are enabled.

Remove the 2nd disable of all IRQs at the end of the function.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index f92d8a75d1b1..3f3c6f2107a8 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -438,7 +438,6 @@ static void at91_chip_start(struct net_device *dev)
 
 	/* Enable interrupts */
 	reg_ier = get_irq_mb_rx(priv) | AT91_IRQ_ERRP | AT91_IRQ_ERR_FRAME;
-	at91_write(priv, AT91_IDR, AT91_IRQ_ALL);
 	at91_write(priv, AT91_IER, reg_ier);
 }
 

-- 
2.40.1


