Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E1C57FFF4
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiGYNdL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiGYNdH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:33:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D58812757
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id y1so2330298pja.4
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qe1PtrtxEq1oHqwcuahzpUkB3r9Wi3Wx0PHajE2akhk=;
        b=YcSy8Jehytw+bq8fxf/ilGPJ5ORsvNzFzA+gFqTGvHvUfbaTsgeuQPoIckEPPf6rZ+
         uZTqiLXIUnw9bZEcJ+CV0G8/+zU5MRtHCe1VjGei7aBbiI8CP3b7WSLwIhM5oC1flCbo
         VRl3Gur6H7duHXfxVnY69T2QAf7nKMgtlkzxMylD2r3v3dy3qxpvqj76234pH6aaCv1b
         zCcqNpkZd49tOgTJ5V90G28z6gBy8KTacwddJdo7huf160yeJeH6NVocJsgJMngXiwdM
         oeSOZ3Oep3iB9xridBUlF10p3xMcqdKY6IXB/RJ+wzTHJvQK7uHXi0FIcGTDIGciHPOT
         OKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Qe1PtrtxEq1oHqwcuahzpUkB3r9Wi3Wx0PHajE2akhk=;
        b=Tbkb0rhiWpSb0FK7p+DsP+K4dtMfpwTx0nNZY3PRJogy+GBNIjK+QyZn1n1CQkxEBF
         7OUVxM3qSGJ/6UzJ+ZpR7sV2XywNkVmcRsbCr7dm9Gdl5sqar0GkDNKyvqYPJf0CGHNp
         xhtQsYROEGfKqGmANp8k/0vLMBMOjNjZr3BEV4AJXCjwYaHifnz52AuMcBWO2TmPEzIk
         7wtkkROApM+zI01DHswKlkogJK+u4YVwwQvEa8VgZ+EJbAtiEAlZbAcsZFKhK/eWaWlP
         lkp5avTpydNLjvCLoUKa99umwb32LJan9qf2I9XevPcyfQSf+VLH3UFTlzIPNGiNA7Zb
         PzmA==
X-Gm-Message-State: AJIora8ZcdrAEg+97H3PXpB/REayTdC129t4hd3mYk1QmZeDKph4jnZB
        3GczuKW+O/GdRPDIIN+F7MCB/TpC9/1V4A==
X-Google-Smtp-Source: AGRyM1t21G1fqX6gJa6YoZzh75xfkfZVGQUhvfmwPy7c8nhAwNCSKfGDkzGc/seub2A7oP0jIjT3ng==
X-Received: by 2002:a17:90b:1a8b:b0:1f0:817:3afc with SMTP id ng11-20020a17090b1a8b00b001f008173afcmr32595092pjb.213.1658755979828;
        Mon, 25 Jul 2022 06:32:59 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:59 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 14/24] can: v(x)can: add software tx timestamps
Date:   Mon, 25 Jul 2022 22:31:58 +0900
Message-Id: <20220725133208.432176-15-mailhol.vincent@wanadoo.fr>
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

TX timestamps were added to the can_put_echo_skb() function of can_dev
modules in [1]. However, vcan and vxcan do not rely on that function
and as such do not offer TX timestamping.

While it could be arguable whether TX timestamps are really needed for
virtual interfaces, we prefer to still add it so that all CAN dirvers,
without exception supports the TX software timestamps.

Add a call to skb_tx_timestamp() in the vcan_tx() and vxcan_xmit()
functions so that the modules now support TX software timestamps.

[1] commit 741b91f1b0ea ("can: dev: can_put_echo_skb(): add software
tx timestamps")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=741b91f1b0ea34f00f6a7d4539b767c409291fcf

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/vcan.c  | 2 ++
 drivers/net/can/vxcan.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index 6827c717af44..e820b2621e53 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -100,6 +100,8 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 	/* set flag whether this packet has to be looped back */
 	loop = skb->pkt_type == PACKET_LOOPBACK;
 
+	skb_tx_timestamp(skb);
+
 	if (!echo) {
 		/* no echo handling available inside this driver */
 		if (loop) {
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index a221c00fe660..aedeb9766996 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -54,6 +54,8 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
 		goto out_unlock;
 	}
 
+	skb_tx_timestamp(oskb);
+
 	skb = skb_clone(oskb, GFP_ATOMIC);
 	if (skb) {
 		consume_skb(oskb);
-- 
2.35.1

