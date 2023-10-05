Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE4C7BA09A
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 16:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbjJEOiT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 10:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbjJEOfn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 10:35:43 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0B7ED3
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7f-0001ES-Lr
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:15 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7e-00BDKj-K0
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5655C22F7A0
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:14 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id A3BFB22F78B;
        Thu,  5 Oct 2023 07:50:13 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 17d958ea;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:32 +0200
Subject: [PATCH v2 04/27] can: at91_can: BR register: convert to
 FIELD_PREP()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-4-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=NmW0ieJ2d2XYfANsNo7n3HdFZiEmryL8Ut0Kdl5ClkQ=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmqQ275XKv5yUH8GiokoYONK1IFlPb5ZxXTHm
 q2WxqLmo+OJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qkAAKCRC+UBxKKooE
 6CAAB/4sXe1AHA30T2tM2wjUlnyQnrelNRyg2t8MF73nRhCnkgPX8Dr51XDZS2B9kJYwJbRyS1i
 /gyX/bJQz8j6JwljPRP2ypKKmjfhsxCzSW6qiLlluIYEp7dLB+zdPvJ2imvosuVZApItCrn1Ddo
 jkN51bDZ0paxR1nJCtDsCID9yuK3G8Ygkr4McqrY/VImejqepaH97Dkz7hsHtNGoj/1zqaAciuv
 Gr/CaLrMyQP+TGpWJ3Yg2pvfn9TwbNT6dANbGFpndL9OF2cZUtJnzafD195AMoFLbCV+dvPYcNn
 /m/3MsYi69OEcEhC8hj0V55Tiaj9sJCSSGi3XnWO5NsU5f8x
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

Use FIELD_PREP() to access the individual fields of the BR register.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 966980d4b5dd..79eb78b9f8ae 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -6,6 +6,7 @@
  * (C) 2008, 2009, 2010, 2011 by Marc Kleine-Budde <kernel@pengutronix.de>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/ethtool.h>
@@ -64,6 +65,13 @@ enum at91_reg {
 
 #define AT91_SR_RBSY BIT(29)
 
+#define AT91_BR_PHASE2_MASK GENMASK(2, 0)
+#define AT91_BR_PHASE1_MASK GENMASK(6, 4)
+#define AT91_BR_PROPAG_MASK GENMASK(10, 8)
+#define AT91_BR_SJW_MASK GENMASK(13, 12)
+#define AT91_BR_BRP_MASK GENMASK(22, 16)
+#define AT91_BR_SMP BIT(24)
+
 #define AT91_MMR_PRIO_SHIFT (16)
 
 #define AT91_MID_MIDE BIT(29)
@@ -353,12 +361,16 @@ static int at91_set_bittiming(struct net_device *dev)
 {
 	const struct at91_priv *priv = netdev_priv(dev);
 	const struct can_bittiming *bt = &priv->can.bittiming;
-	u32 reg_br;
+	u32 reg_br = 0;
 
-	reg_br = ((priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES) ? 1 << 24 : 0) |
-		((bt->brp - 1) << 16) | ((bt->sjw - 1) << 12) |
-		((bt->prop_seg - 1) << 8) | ((bt->phase_seg1 - 1) << 4) |
-		((bt->phase_seg2 - 1) << 0);
+	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		reg_br |= AT91_BR_SMP;
+
+	reg_br |= FIELD_PREP(AT91_BR_BRP_MASK, bt->brp - 1) |
+		FIELD_PREP(AT91_BR_SJW_MASK, bt->sjw - 1) |
+		FIELD_PREP(AT91_BR_PROPAG_MASK, bt->prop_seg - 1) |
+		FIELD_PREP(AT91_BR_PHASE1_MASK, bt->phase_seg1 - 1) |
+		FIELD_PREP(AT91_BR_PHASE2_MASK, bt->phase_seg2 - 1);
 
 	netdev_info(dev, "writing AT91_BR: 0x%08x\n", reg_br);
 

-- 
2.40.1


