Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BA156B926
	for <lists+linux-can@lfdr.de>; Fri,  8 Jul 2022 14:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbiGHL6A (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 07:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbiGHL54 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 07:57:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB889B180
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 04:57:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bf9so12724293lfb.13
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 04:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eL/cKpri1oCFa8FeZmteVd/MODKb6+yD4JH3+1p6hkU=;
        b=DI1eOSyncvATepKDEk28U7+GHhGADbtJidQ6RRo1oru4PdTQTGGjo1Eqme3wVSMidt
         KIrKD30JbIWXsYb2n9dipgLirCXnmABAlaBRcTpNoFENo+nn+NWNkfbI0aEz5e6cekgw
         k5s9paRFtlYh9rPOeCtlUMMxudqdGVKWOryYkxgHTvEEwX+IowL84HrgZqyZTVwQf6pB
         4xj98IosWUIXvukuk45qyDkOiLpucfs6jf+fD6qk51NMJaxKUmKga5pe5OO6DDmtoSiz
         lfK01EbwoD9/k0aI09g+uD8z9iNkQOhTeZ8pFkaDyqQKR4oVUcdzhGSyZD907snqw9Z/
         aAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eL/cKpri1oCFa8FeZmteVd/MODKb6+yD4JH3+1p6hkU=;
        b=FFVc0rXJ7BYPcs5IBk7Q8CEND+Sooa+kZTdR9yIFnYvmCbBRY35cf2ctfWPsyHNdYt
         9wgzzyF4COhYbQ6CkzPEqzH5LahC5vjrrWAmMXZOgvFEl/FfhOIMbaOyKKBjOXiEvRAZ
         foNAMh6Iw6l4AGdAUtgv2aIgaaCKlqR2ORXoeHPeqANhb8CptTGx4PZWwH8yivWNqO0I
         WwdRmwzwqhwein5fnSmNuLvsCBOwBZi8peR0NDf18xykApgO14ln1lg9x/RwArbjWvAJ
         If432ENNBY9KJVNiriGT0LMbzSMO3XZ7aoFMMeesKu/NpFzIfJrE17+nsZwJui3Hpwux
         0C5w==
X-Gm-Message-State: AJIora/I2JRNqhFrLjWIjNi/LK6EpzxTSj4SInAUL5dYp3QjNazCWLSt
        px8RUhEPqCwKDivYZKfu98WC9s8noFjwew==
X-Google-Smtp-Source: AGRyM1uaJGQfLnTXtSAfvHRKKfyiMyM+es9zqTmtX37GjQDgDVrBNRAc2Fiy55CtIT6j3nP8iCm5Dw==
X-Received: by 2002:a05:6512:1112:b0:488:e0ac:fb41 with SMTP id l18-20020a056512111200b00488e0acfb41mr2353184lfg.456.1657281471440;
        Fri, 08 Jul 2022 04:57:51 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id h7-20020a2e9ec7000000b0025a724f2935sm7336199ljk.137.2022.07.08.04.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:57:51 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 13/15] can: kvaser_usb_leaf: Fix bogus restart events
Date:   Fri,  8 Jul 2022 13:57:07 +0200
Message-Id: <20220708115709.232815-14-extja@kvaser.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708115709.232815-1-extja@kvaser.com>
References: <20220708115709.232815-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Anssi Hannula <anssi.hannula@bitwise.fi>

When auto-restart is enabled, the kvaser_usb_leaf driver considers
transition from any state >= CAN_STATE_BUS_OFF as a bus-off recovery
event (restart).

However, these events may occur at interface startup time before
kvaser_usb_open() has set the state to CAN_STATE_ERROR_ACTIVE, causing
restarts counter to increase and CAN_ERR_RESTARTED to be sent despite no
actual restart having occurred.

Fix that by making the auto-restart condition checks more strict so that
they only trigger when the interface was actually in the BUS_OFF state.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
Changes in v2:
  - Rebased on b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")

 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index dee3ae45a972..5e325bf40c84 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -901,7 +901,7 @@ static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
 	context = &priv->tx_contexts[tid % dev->max_tx_urbs];
 
 	/* Sometimes the state change doesn't come after a bus-off event */
-	if (priv->can.restart_ms && priv->can.state >= CAN_STATE_BUS_OFF) {
+	if (priv->can.restart_ms && priv->can.state == CAN_STATE_BUS_OFF) {
 		struct sk_buff *skb;
 		struct can_frame *cf;
 
@@ -1018,7 +1018,7 @@ kvaser_usb_leaf_rx_error_update_can_state(struct kvaser_usb_net_priv *priv,
 	}
 
 	if (priv->can.restart_ms &&
-	    cur_state >= CAN_STATE_BUS_OFF &&
+	    cur_state == CAN_STATE_BUS_OFF &&
 	    new_state < CAN_STATE_BUS_OFF)
 		priv->can.can_stats.restarts++;
 
@@ -1111,7 +1111,7 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 		}
 
 		if (priv->can.restart_ms &&
-		    old_state >= CAN_STATE_BUS_OFF &&
+		    old_state == CAN_STATE_BUS_OFF &&
 		    new_state < CAN_STATE_BUS_OFF) {
 			cf->can_id |= CAN_ERR_RESTARTED;
 			netif_carrier_on(priv->netdev);
-- 
2.36.1

