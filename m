Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C123674812E
	for <lists+linux-can@lfdr.de>; Wed,  5 Jul 2023 11:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjGEJkb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jul 2023 05:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjGEJk2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jul 2023 05:40:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036AC1722
        for <linux-can@vger.kernel.org>; Wed,  5 Jul 2023 02:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B1EB614DC
        for <linux-can@vger.kernel.org>; Wed,  5 Jul 2023 09:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F1ABC433CD;
        Wed,  5 Jul 2023 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688550020;
        bh=Isig/f3mkF+AbNk8+veeTyosJs+bzP+8ewKn3ma75Bs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=MP+sWC2zU1CWdMh4jVEbVqPZJK0dFpUu1wcDicIlRrbiGbMiffmZ8Er39AFWvmh/j
         YlLPW1xr3S8W7axPr6A/Cp2ZwpoJ1pEgIplmEGnBpvfDqQKEYVrhG6CmYAUNfA/3wD
         fZ43GjHD753jaXjQ608Bf07Gy4a7S3VLWlBGY+TLb9sm1WHCBy/4W1C8Z991M7Kf2k
         9N1BZRxoUKdOsIYaixFQBZGkQEbOtJi22cZYZnDLUF01oviU3BJ2Tazir1dz0gT7rA
         kMDprEQoCOOdtinPbbkfp0+sDpp5/neA7lY8q3ZBzYmtYhOWSVsgOqvPMXr+rqE9TM
         Q0yRlu6v2i/YQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9C2EB64DD;
        Wed,  5 Jul 2023 09:40:20 +0000 (UTC)
From:   Marc Kleine-Budde via B4 Relay 
        <devnull+mkl.pengutronix.de@kernel.org>
Date:   Wed, 05 Jul 2023 11:39:56 +0200
Subject: [PATCH 5/6] can: gs_usb: gs_usb_receive_bulk_callback(): make use
 of stats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-gs_usb-rx-offload-v1-5-8e7e46e40137@pengutronix.de>
References: <20230705-gs_usb-rx-offload-v1-0-8e7e46e40137@pengutronix.de>
In-Reply-To: <20230705-gs_usb-rx-offload-v1-0-8e7e46e40137@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=KN3xlMkapDK2OZz/dgILcpceIPh3GwGIy1DzYPDL30A=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBkpTp9RMM20RYXYCLHQ27Fa8VYrhKJ0QF4qXgPA
 DVmOv6vmGGJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZKU6fQAKCRC+UBxKKooE
 6F76CACr2zdg7pJISkEtQfIb9bGt8QKJzj0ViMFk4Oe+OMUoVKZqPIhqAcpHG5bOshWI7Ls9EYh
 j+mZYXTArU573ntE+e11g4x5gywnRuVdDCcJTNHLWrVU8PuqD7A4Eh3r4yuFB9eFS0y0NLicyTU
 lZc1JeuYv/bxU5/9waOfJ0bOot/oO67W5E+ggcqr8xpKTxwr2SKZLZFfez56HeCd6AFOfthfqZC
 r6AgJl8AY6AzKcjJyH70TBm4JMDK2ZBFR4BnJdlTVa+wasOIXsoDr08dK9FDXAGyxgZMM5GNIK1
 egwB02NX45juj6QM+1g+mnwnPnHH03yZg6/b4dXlhuo9KA+/
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-Endpoint-Received: by B4 Relay for mkl@pengutronix.de/default with auth_id=52
X-Original-From: Marc Kleine-Budde <mkl@pengutronix.de>
Reply-To: <mkl@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

Make use the previously assigned variable stats instead of using
netdev->stats.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index b66af9d0ce6a..13a6d8b9ba9e 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -591,8 +591,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 		gs_usb_set_timestamp(dev, skb, hf);
 
-		netdev->stats.rx_packets++;
-		netdev->stats.rx_bytes += hf->can_dlc;
+		stats->rx_packets++;
+		stats->rx_bytes += hf->can_dlc;
 
 		netif_rx(skb);
 	} else { /* echo_id == hf->echo_id */
@@ -616,9 +616,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
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

