Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712217BA6C8
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 18:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjJEQlk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 12:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjJEQkO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 12:40:14 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C0A7EC8
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:48:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ60-0000ah-PY
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:48:32 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ60-00BDJO-7c
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:48:32 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id EAC2822F765
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:48:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id DFB5E22F755;
        Thu,  5 Oct 2023 07:48:30 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 432a306b;
        Thu, 5 Oct 2023 07:48:29 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:48:22 +0200
Subject: [PATCH v2 5/5] can: dev: can_put_echo_skb(): don't crash kernel if
 can_priv::echo_skb is accessed out of bounds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-can-dev-fix-can-restart-v2-5-91b5c1fd922c@pengutronix.de>
References: <20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de>
In-Reply-To: <20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=pD2o4xnKwQcBKweVju9ZVPt70FvlUBkyOOnK2hgeGDc=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmpMr1YKu2T3dewvLOGJQ7a4wQdA6AL1Fa28+
 nSf7PPN1bWJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qTAAKCRC+UBxKKooE
 6C38CACme5CZE9KGdDsGcw0LvVJbWNdQMhW2Z8lOh1y1av8/5lBuvcspRrclhK1axiXClSNgRR1
 OQeR0hXQFyw1tma3+mUqO07dCXQGgOaFtmowxqQDy6a8Eu2vYQ5y7uzgp3UPFs4eErzyJtpO2qC
 jLWRPX57uM4xwGEtZ+0GHyDgrWT3bDM2Om8lj/XJB3R13nSws/Hd7aX8drBz8u1ZI3nioOXw9Y1
 Zu/PrPvof3WPCNIU76062LYbej6WP8twVpgWbWKHKO19w7ABd1DE/B/hx5x65UZ4ySVdWQHeVs8
 amBxhCFSNirTDpppZRhJkz0mj8u7Rp+C2gYEGPbUMGzXoUPI
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

If the "struct can_priv::echoo_skb" is accessed out of bounds, this
would cause a kernel crash. Instead, issue a meaningful warning
message and return with an error.

Fixes: a6e4bc530403 ("can: make the number of echo skb's configurable")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/skb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index f6d05b3ef59a..3ebd4f779b9b 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -49,7 +49,11 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 {
 	struct can_priv *priv = netdev_priv(dev);
 
-	BUG_ON(idx >= priv->echo_skb_max);
+	if (idx >= priv->echo_skb_max) {
+		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
+			   __func__, idx, priv->echo_skb_max);
+		return -EINVAL;
+	}
 
 	/* check flag whether this packet has to be looped back */
 	if (!(dev->flags & IFF_ECHO) ||

-- 
2.40.1


