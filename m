Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E5A757A29
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 13:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjGRLLi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjGRLLe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 07:11:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1296E1BCA
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 04:11:09 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLibj-0006ZP-BG
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 13:11:07 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 710821F40ED
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 11:11:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 6A53F1F40CE;
        Tue, 18 Jul 2023 11:11:04 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 771ec8da;
        Tue, 18 Jul 2023 11:11:03 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 18 Jul 2023 13:10:28 +0200
Subject: [PATCH 06/11] can: gs_usb: gs_usb_receive_bulk_callback(): make
 use of stats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-gs_usb-cleanups-v1-6-c3b9154ec605@pengutronix.de>
References: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
In-Reply-To: <20230718-gs_usb-cleanups-v1-0-c3b9154ec605@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=WEUlvySMcPp+h/n7ZgkFtyDfSWhqkv5oOvs2KpZKWUU=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktnMzdZtmncfuKCptlk6ACN8SWUkSjheemsckv
 DuGOZ+/bPSJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLZzMwAKCRC+UBxKKooE
 6LvcB/0dk4V2INdMi00nysZ9Pd0Cw44MXaWBc1W16n+Ql63pskclBWrANylGQ23mFbNTrsUwgmU
 uJkiGv/j2d02tggTBmAcJ2ATW5rYrmM+RQJ0iy/pK87BQMrGnbC0UjEndNsj1k7TuA2i5ZNGhh7
 Hw65PBeAYe2tljBqlAfpv0Negi8zQQMngMmbdyzWQupiVhQO3VMhgN0un8yPD15nCqnQ0FZQsmH
 OSJRHcFa+MXuZNAD795jaOtbbv1u5gXvB1I01VMRM5+piyglWZz4njVYeCwwoW9pSYASb07CA0Q
 43cRQG9qL+S4wxv0OPnWgfgzgg6PbIsEljsnYXTzY+vHSH69
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Make use the previously assigned variable stats instead of using
netdev->stats.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 04cbe949c290..0d0a3405ba19 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -594,8 +594,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 		gs_usb_set_timestamp(dev, skb, hf);
 
-		netdev->stats.rx_packets++;
-		netdev->stats.rx_bytes += hf->can_dlc;
+		stats->rx_packets++;
+		stats->rx_bytes += hf->can_dlc;
 
 		netif_rx(skb);
 	} else { /* echo_id == hf->echo_id */
@@ -619,9 +619,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		skb = dev->can.echo_skb[hf->echo_id];
 		gs_usb_set_timestamp(dev, skb, hf);
 
-		netdev->stats.tx_packets++;
-		netdev->stats.tx_bytes += can_get_echo_skb(netdev, hf->echo_id,
-							   NULL);
+		stats->tx_packets++;
+		stats->tx_bytes += can_get_echo_skb(netdev, hf->echo_id,
+						    NULL);
 
 		gs_free_tx_context(txc);
 

-- 
2.40.1


