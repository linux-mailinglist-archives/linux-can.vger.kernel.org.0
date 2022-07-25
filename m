Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D02657FFF7
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiGYNdQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbiGYNdL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:33:11 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282F213F25
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:04 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bh13so10392121pgb.4
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AxjWx6wqgIco2TQFNPCVmq77ltivpPoWUErAafGdsR0=;
        b=Av8DhivSnpVHcVslMcAQaaf+hRrBnmNLyBB32P5eXgxhx3OhrEm2GuJfYikBSKqdqY
         e9CIR9yG47ZM4n/RMFLS4tIwlbISz/7Zx4YifbqwAXL3/L+qI1iMhPcs1erDvVzlk3cR
         aB7CElxknjFncgRvayQhhPsnM/NzVcOiJETEkdffDhBRVPvA66QB5CkPsRjp2mScZWMW
         aZ2NNOmKCrUc9PvijDtFzfEA6qmGIt4dTSWRIUx0nBC2pNBW5GSGp611N/6m4dY3DhdX
         tT0KxOjCIO9Kdef0Jm3NO+Nwq2UXRRjZSPj0NbH9blX8G1tg/r1eR0RjYgJtvjgpbJPP
         82XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AxjWx6wqgIco2TQFNPCVmq77ltivpPoWUErAafGdsR0=;
        b=HeWwh3Km7/vx0RbR/GYpET6iOiOsP5TlwbAtkc+8B06m35As+IG05SZVGdCMQqfo1s
         GulgzxgcfxeyrYsAppKPaSmTj0s9Msj3Gck/qfEWh4SuDIw+VZ2wKabYCQ4J7DHkUrTS
         YaYj9Gnf6bx5TyQPIddqTLoSOpmFHnNRBd9x3atb0nye+trgJlNfzMQB/0EkrouSH84i
         +qPqEiGYZmOTfT0WBM6NA2SqTspKCq/zbVXLCGHw6GSh0mOp1aC1BU8sSvyh/X3swsHV
         96itbriuLFZGGiY4MR90rhVjZocdY+qWQhJ2/pJ5eZFRErrI/UO3+2z7ZIGFduU8bGc7
         rzAg==
X-Gm-Message-State: AJIora93iK/spiTjivKq60q5akjRUun3dHOo6sVjt4+ogxXOzfGIp5uP
        5tIctOQ+fLdlnVBG1F/dhbpx2YAHRFmRCw==
X-Google-Smtp-Source: AGRyM1tIZFDTYE7E5mwafyzvsIjwR5J6pb5a/aLbbF/Cx0qB5mqWn8DAHUXnvnB+1tSjJ18vjgOrCA==
X-Received: by 2002:a05:6a00:2307:b0:52a:d2aa:2a9c with SMTP id h7-20020a056a00230700b0052ad2aa2a9cmr13052854pfh.11.1658755984208;
        Mon, 25 Jul 2022 06:33:04 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:33:04 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 16/24] can: dev: add hardware TX timestamp
Date:   Mon, 25 Jul 2022 22:32:00 +0900
Message-Id: <20220725133208.432176-17-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Because of the loopback feature of socket CAN, hardware TX timestamps
are nothing else than the hardware RX timespamp of the corresponding
loopback packet. This patch simply reuses the hardware RX timestamp.

The rationale to clone this timestamp value is that existing tools
which rely of libpcap (such as tcpdump) expect support for both TX and
RX hardware timestamps in order to activate the feature (i.e. no
granular control to activate either of TX or RX hardware timestamps).

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/skb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 8bb62dd864c8..07e0feac8629 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -72,6 +72,9 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		/* save frame_len to reuse it when transmission is completed */
 		can_skb_prv(skb)->frame_len = frame_len;
 
+		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+
 		skb_tx_timestamp(skb);
 
 		/* save this skb for tx interrupt echo handling */
@@ -107,6 +110,9 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
 		struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
 		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 
+		if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS)
+			skb_tstamp_tx(skb, skb_hwtstamps(skb));
+
 		/* get the real payload length for netdev statistics */
 		if (cf->can_id & CAN_RTR_FLAG)
 			*len_ptr = 0;
-- 
2.35.1

