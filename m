Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5135860F4
	for <lists+linux-can@lfdr.de>; Sun, 31 Jul 2022 21:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiGaTWj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 31 Jul 2022 15:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiGaTV5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 31 Jul 2022 15:21:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD95C1182F
        for <linux-can@vger.kernel.org>; Sun, 31 Jul 2022 12:21:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oIEUl-0008G1-Uj
        for linux-can@vger.kernel.org; Sun, 31 Jul 2022 21:20:59 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 77D7BBED2E
        for <linux-can@vger.kernel.org>; Sun, 31 Jul 2022 19:20:41 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id F0509BED12;
        Sun, 31 Jul 2022 19:20:40 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c8824923;
        Sun, 31 Jul 2022 19:20:31 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 36/36] can: can327: fix a broken link to Documentation
Date:   Sun, 31 Jul 2022 21:20:29 +0200
Message-Id: <20220731192029.746751-37-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220731192029.746751-1-mkl@pengutronix.de>
References: <20220731192029.746751-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Since commit 482a4360c56a ("docs: networking: convert netdevices.txt to
ReST"), Documentation/networking/netdevices.txt has been replaced by
Documentation/networking/netdevices.rst.

Update the comment accordingly to avoid a 'make htmldocs' warning.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/all/6a54aff884ea4f84b661527d75aabd6632140715.1659249135.git.christophe.jaillet@wanadoo.fr
Fixes: 43da2f07622f ("can: can327: CAN/ldisc driver for ELM327 based OBD-II adapters")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/can327.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 50a374972ad9..0aa1af31d0fe 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -827,7 +827,7 @@ static netdev_tx_t can327_netdev_start_xmit(struct sk_buff *skb,
 	netif_stop_queue(dev);
 
 	/* BHs are already disabled, so no spin_lock_bh().
-	 * See Documentation/networking/netdevices.txt
+	 * See Documentation/networking/netdevices.rst
 	 */
 	spin_lock(&elm->lock);
 	can327_send_frame(elm, frame);
-- 
2.35.1


