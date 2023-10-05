Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759137B9F12
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 16:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjJEORV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 10:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjJEOPf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 10:15:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C435A7EE5
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 00:50:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7i-0001HY-Ua
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:18 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoJ7f-00BDMs-VQ
        for linux-can@vger.kernel.org; Thu, 05 Oct 2023 09:50:16 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 9B65222F7D5
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 07:50:15 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E9D5622F7BB;
        Thu,  5 Oct 2023 07:50:14 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f56c6f15;
        Thu, 5 Oct 2023 07:50:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Thu, 05 Oct 2023 09:49:45 +0200
Subject: [PATCH v2 17/27] can: at91_can: at91_poll_err(): fold in
 at91_poll_err_frame()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-at91_can-rx_offload-v2-17-9987d53600e0@pengutronix.de>
References: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
In-Reply-To: <20231005-at91_can-rx_offload-v2-0-9987d53600e0@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=F4aisGJRLX6kg2dy9oAyhY90IvE12HbRnfWHMRxnJ/E=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlHmqjtay//zLYvN04shlbkddb8FL7v6M1CQK37
 5uBYQNVej6JATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZR5qowAKCRC+UBxKKooE
 6OHYB/9yJqDshAgyPe+Xwx8QWwFsFTq2F413TV/2d1UH8j89ZlP9SRok8Wd++kU9T0Ig8L7qYjX
 H7MTbQuimVb221F2N+xTL1/fvOF33sfTNrrE5BMnrxGr7wDS94BXeCI0NQ4ajndMc/1egY2AFZ5
 Gdw2XvgZkAgZS5+FfFsYqEKioJ3tO4/299m/AaBMzCewdquPP93I7CS7hsee+p0wDC86KVGYwXp
 RIHroqzWg7JX0nWQJ53C55JyYtCwfEifRG1pcdcSKhNypmmMoNoKrQ+0iWrWwaTHCSQNFY4x0Nc
 lm48M/apNokt444ssaOjvZKtKQHXwdjvxylYwGj8e9i/Zv1d
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

This is a preparation patch for the cleanup of at91_poll_err(). Fold
at91_poll_err_frame() into at91_poll_err() so that it can be easier
modified.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 94e9740c80de..2071011ee812 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -751,10 +751,18 @@ static int at91_poll_rx(struct net_device *dev, int quota)
 	return received;
 }
 
-static void at91_poll_err_frame(struct net_device *dev,
-				struct can_frame *cf, u32 reg_sr)
+static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
 {
 	struct at91_priv *priv = netdev_priv(dev);
+	struct sk_buff *skb;
+	struct can_frame *cf;
+
+	if (quota == 0)
+		return 0;
+
+	skb = alloc_can_err_skb(dev, &cf);
+	if (unlikely(!skb))
+		return 0;
 
 	/* CRC error */
 	if (reg_sr & AT91_IRQ_CERR) {
@@ -797,21 +805,6 @@ static void at91_poll_err_frame(struct net_device *dev,
 		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 		cf->data[2] |= CAN_ERR_PROT_BIT;
 	}
-}
-
-static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
-{
-	struct sk_buff *skb;
-	struct can_frame *cf;
-
-	if (quota == 0)
-		return 0;
-
-	skb = alloc_can_err_skb(dev, &cf);
-	if (unlikely(!skb))
-		return 0;
-
-	at91_poll_err_frame(dev, cf, reg_sr);
 
 	netif_receive_skb(skb);
 

-- 
2.40.1


