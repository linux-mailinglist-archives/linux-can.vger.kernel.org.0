Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4311174812D
	for <lists+linux-can@lfdr.de>; Wed,  5 Jul 2023 11:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjGEJkb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jul 2023 05:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjGEJkX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jul 2023 05:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F221711
        for <linux-can@vger.kernel.org>; Wed,  5 Jul 2023 02:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B319614CF
        for <linux-can@vger.kernel.org>; Wed,  5 Jul 2023 09:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D704C433CB;
        Wed,  5 Jul 2023 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688550020;
        bh=wMKKvQrPkMzoRIpdV6P/Uisc8DsH/BV9Wpmiee/Wkyk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=AUsx8zPooXjl1nGMAbLvnwR8c2UCg3I11zI392r66m9DGIvidmAMOHV5drO6iLjJN
         a32hwYAARb0Aa1DKN4bfhjGTF+TeuxYuNvJuFTuOOlUM+hNkTieNPYa4dap8pYwV2V
         4sK4f98YVs0xhVyBv8tFWMs/4J4UNSwqjdGQWvwLU51N++8Xox+6uW0jTMyIyFi+sK
         +6SdAP9aoXaQHAMASpfOIqFggbEMpYGNHVFR8odPKmlvZEkxYp2lDMv+dEG13RsMI0
         zcWV3kWeBcmG/fy0HgV4JyvoD9twCQhXe4Xra0GdRAUHw1SCcXIS8LpS/Z9Ix0IEYj
         h63y3BH+LV+iw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 68C83C001E0;
        Wed,  5 Jul 2023 09:40:20 +0000 (UTC)
From:   Marc Kleine-Budde via B4 Relay 
        <devnull+mkl.pengutronix.de@kernel.org>
Date:   Wed, 05 Jul 2023 11:39:54 +0200
Subject: [PATCH 3/6] can: gs_usb: gs_usb_receive_bulk_callback(): count RX
 overflow errors also in case of OOM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-gs_usb-rx-offload-v1-3-8e7e46e40137@pengutronix.de>
References: <20230705-gs_usb-rx-offload-v1-0-8e7e46e40137@pengutronix.de>
In-Reply-To: <20230705-gs_usb-rx-offload-v1-0-8e7e46e40137@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1185; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=GKQzem9MCaDKD+CYo1F0A0x3ZO3+aBNF5BxFuvgp1OY=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBkpTp3cRLRpgNiG9gLwrJE1zS/P2EDYgoac7SWK
 rl877uNZ8CJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZKU6dwAKCRC+UBxKKooE
 6MjIB/9Z08jmbD52uWLUn/3UXHeHa5K2hubho2WWgmuQvUQt5bqeAGmAZ0lnU7ZHFwIEpiAjZ0v
 tqiLsbtnwwv33ujIeTLKnjDOlGlagxeeyqhr9iJa2j5LdUKZmraDhXFe/H9mdO+EyETBBG0nHKY
 kFXpGV8uzjQQFbwWvFEfTxs7cMkd6bcLUz0bB9Y3lQOD/xMN5dnbXDHBJUxdn0JK8MKmNONXZ22
 kpOHG19/NMm4J4LHMoNqlwvZSvwhJ6ZB+ZUhEF0Z2lgmIzNt5kMJ8h6cjqzy1524cNJMKG5GF4/
 N0Ezo/F0zY+FDcbbRczNprn71oNRGDfQO8G+Yo1HYVKaVYtf
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-Endpoint-Received: by B4 Relay for mkl@pengutronix.de/default with auth_id=52
X-Original-From: Marc Kleine-Budde <mkl@pengutronix.de>
Reply-To: <mkl@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

In case of an RX overflow error from the CAN controller and an OOM
where no skb can be allocated, the error counters are not incremented.

Fix this by first incrementing the error counters and then allocate
the skb.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index d476c2884008..a60153f4cf1d 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -628,6 +628,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+
 		skb = alloc_can_err_skb(netdev, &cf);
 		if (!skb)
 			goto resubmit_urb;
@@ -635,8 +638,6 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->len = CAN_ERR_DLC;
 		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
-		stats->rx_over_errors++;
-		stats->rx_errors++;
 		netif_rx(skb);
 	}
 

-- 
2.40.1

