Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90BC766614
	for <lists+linux-can@lfdr.de>; Fri, 28 Jul 2023 10:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjG1IAG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 28 Jul 2023 04:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbjG1H7g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 28 Jul 2023 03:59:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334833AB3
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 00:59:03 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qPIMw-0008N7-N5
        for linux-can@vger.kernel.org; Fri, 28 Jul 2023 09:58:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id DC4871FD220
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 07:56:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C86BD1FD1A6;
        Fri, 28 Jul 2023 07:56:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8cb7fdcb;
        Fri, 28 Jul 2023 07:56:16 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Peter Seiderer <ps.report@gmx.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 06/21] can: peak_usb: remove unused/legacy peak_usb_netif_rx() function
Date:   Fri, 28 Jul 2023 09:55:59 +0200
Message-Id: <20230728075614.1014117-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728075614.1014117-1-mkl@pengutronix.de>
References: <20230728075614.1014117-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
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

From: Peter Seiderer <ps.report@gmx.net>

Remove unused/legacy peak_usb_netif_rx() function (not longer used
since commit 28e0a70cede3 ("can: peak_usb: CANFD: store 64-bits hw
timestamps").

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
Link: https://lore.kernel.org/all/20230721180758.26199-1-ps.report@gmx.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 13 -------------
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  2 --
 2 files changed, 15 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index d881e1d30183..24ad9f593a77 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -214,19 +214,6 @@ void peak_usb_get_ts_time(struct peak_time_ref *time_ref, u32 ts, ktime_t *time)
 	}
 }
 
-/*
- * post received skb after having set any hw timestamp
- */
-int peak_usb_netif_rx(struct sk_buff *skb,
-		      struct peak_time_ref *time_ref, u32 ts_low)
-{
-	struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
-
-	peak_usb_get_ts_time(time_ref, ts_low, &hwts->hwtstamp);
-
-	return netif_rx(skb);
-}
-
 /* post received skb with native 64-bit hw timestamp */
 int peak_usb_netif_rx_64(struct sk_buff *skb, u32 ts_low, u32 ts_high)
 {
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 980e315186cf..f6cf84bb718f 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -142,8 +142,6 @@ void peak_usb_init_time_ref(struct peak_time_ref *time_ref,
 void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
 void peak_usb_set_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
 void peak_usb_get_ts_time(struct peak_time_ref *time_ref, u32 ts, ktime_t *tv);
-int peak_usb_netif_rx(struct sk_buff *skb,
-		      struct peak_time_ref *time_ref, u32 ts_low);
 int peak_usb_netif_rx_64(struct sk_buff *skb, u32 ts_low, u32 ts_high);
 void peak_usb_async_complete(struct urb *urb);
 void peak_usb_restart_complete(struct peak_usb_device *dev);
-- 
2.40.1


