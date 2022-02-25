Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3472A4C4B7D
	for <lists+linux-can@lfdr.de>; Fri, 25 Feb 2022 17:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243368AbiBYQ5C (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Feb 2022 11:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243370AbiBYQ5B (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Feb 2022 11:57:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AFE1EE9D8
        for <linux-can@vger.kernel.org>; Fri, 25 Feb 2022 08:56:28 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nNdtK-0004Ey-O1
        for linux-can@vger.kernel.org; Fri, 25 Feb 2022 17:56:26 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id CFA093D889
        for <linux-can@vger.kernel.org>; Fri, 25 Feb 2022 16:56:23 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7E8CE3D872;
        Fri, 25 Feb 2022 16:56:23 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 81f2b6aa;
        Fri, 25 Feb 2022 16:56:23 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 3/3] can: rcar_canfd: rcar_canfd_channel_probe(): register the CAN device when fully ready
Date:   Fri, 25 Feb 2022 17:56:22 +0100
Message-Id: <20220225165622.3231809-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225165622.3231809-1-mkl@pengutronix.de>
References: <20220225165622.3231809-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Register the CAN device only when all the necessary initialization is
completed. This patch makes sure all the data structures and locks are
initialized before registering the CAN device.

Link: https://lore.kernel.org/all/20220221225935.12300-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index b7dc1c32875f..acd74725831f 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1715,15 +1715,15 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 
 	netif_napi_add(ndev, &priv->napi, rcar_canfd_rx_poll,
 		       RCANFD_NAPI_WEIGHT);
+	spin_lock_init(&priv->tx_lock);
+	devm_can_led_init(ndev);
+	gpriv->ch[priv->channel] = priv;
 	err = register_candev(ndev);
 	if (err) {
 		dev_err(&pdev->dev,
 			"register_candev() failed, error %d\n", err);
 		goto fail_candev;
 	}
-	spin_lock_init(&priv->tx_lock);
-	devm_can_led_init(ndev);
-	gpriv->ch[priv->channel] = priv;
 	dev_info(&pdev->dev, "device registered (channel %u)\n", priv->channel);
 	return 0;
 
-- 
2.34.1


