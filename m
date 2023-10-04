Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419547B7BED
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 11:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjJDJYZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 05:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjJDJYV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 05:24:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37A6A7
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 02:24:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny76-0005QG-4x
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:16 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qny74-00AzlG-0L
        for linux-can@vger.kernel.org; Wed, 04 Oct 2023 11:24:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7288122EB71
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 09:24:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C35FE22EB56;
        Wed,  4 Oct 2023 09:24:12 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id aea3ebf6;
        Wed, 4 Oct 2023 09:24:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed, 04 Oct 2023 11:23:33 +0200
Subject: [PATCH 14/27] can: at91_can: at91_chip_start(): don't disable IRQs
 twice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-at91_can-rx_offload-v1-14-c32bf99097db@pengutronix.de>
References: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
In-Reply-To: <20231004-at91_can-rx_offload-v1-0-c32bf99097db@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=814; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=gSd9/BJPdoW7J7vcURY0RIS4mTLqWcq6uhvw1HGLVbw=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHS8mj285aEFDUjIcM5CmVb90WZDGQ4+WGYLIN
 rGG8fS6SWSJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR0vJgAKCRC+UBxKKooE
 6DssCACfIp82CPlx+jhg8QAJk5zf/a4xVka9WHCaUMiX/2sFe/yhHnaRQja06+WG61fIf6yQ1vQ
 Hx5uCy3+LM4CIGGJHUVbnfLZeZTUZdIswEohlYzFZzMyBTYS1+gHhJu8wsIIUvm0ob8GrsplaEU
 eqa41aZKKGyysftvFivYkCJemCkH5lxfVfjwVJ87wFKFnsjf0Fqy+RNCI31RcZnhmz9c/haCpUZ
 D0a3/aawVz+7W7MAm/zxFNMz6n9+TID6GUJGJ0EZtbN0FJ3lkNNO7t90Qol44Xu3i6G7EvWiwwr
 S3UPMZ8n/J0H1z2vIbMhmM9YHvkD0oFgTtxLtYV1cLxgqNpn
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


