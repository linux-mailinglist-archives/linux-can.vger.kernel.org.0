Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F6C581112
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 12:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiGZKZ3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 06:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiGZKZ3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 06:25:29 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC02E2655F
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:26 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p1so4407683plr.11
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oBR2q0qE1t01X0e8u8RxP/CYSHsiBL5TzPp+O6mig+4=;
        b=OW5NMFXLT2jTrT52oFKl3dhKlyyxdUVN8DqogeURJEUXmSGJEXnkZ/pJh5Nj6k0e7I
         C2Rz0lgZR4IqM4d/0H2RRCC6A/aM+e32rkH4qIHE1Q7pOXGSuSP5RuadtPktGct3h0j1
         0PiDB6w/YHi3ukxrSEXaQRnHfF5dVkyACCVY2f21foH0gRn/YJk3xetJ0YIpq3oDS31Z
         sWASAXLfbBNlDMIXgR4k17WqBODMANjzIixlXgcu7seCNw/h9u5jnaNgsuq46kNjRUu/
         tJcvQdHzuQY9fs0IXvNZTuQFmoPT6pmuqmzAXP87sZLiih8MAVOHMwlh+Ga3F8mWwhW2
         Ozyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oBR2q0qE1t01X0e8u8RxP/CYSHsiBL5TzPp+O6mig+4=;
        b=CdAFrCtHmFU1TclCGjeVXyunGVtOd+eRG4J1bSDF6Op+jfQXWaLBnh64C7V3vhPb49
         x2n6gt1shMiTC8DaFd6mOX0M/TejgHqemzkfg3SLIA9lrdtyxIESlnUEdZaRuTLiozHc
         O92TizzXdc2skBf0MQGIGDZKlJSkB2rd7XW4z0LvcIdnzDkYChWsv8tA2vtiOemMgC2F
         kPiVDSNx3QxtuSC887FwteTOTcfgp9DxwCPhZMNaigyABvVX9ANaWpF9Yb75/n3sPMOk
         pR9JQ7o/WJTt+anDBmlFJOi2Ic/jBQNptMQE0dUrJcRTWZd6WtXz9YWKzVJ+HDFY3/54
         Aeaw==
X-Gm-Message-State: AJIora8sFWOzgOHPlxxD3u4IMDy8YpMwsKIc/dosCe+KCN+mfiY5dAuj
        qYiGAIr8Yohymqg0Su8nsY3qX6EQStScxQ==
X-Google-Smtp-Source: AGRyM1vbKHJ/uPMYVf+8E8Qwm9ert3Z/gTeVwWWpkofApQWmCGDG7tOq3VM7pRZg9U9ZHa1fjkYrTA==
X-Received: by 2002:a17:903:2352:b0:16d:80f0:c8a4 with SMTP id c18-20020a170903235200b0016d80f0c8a4mr7170893plh.89.1658831125995;
        Tue, 26 Jul 2022 03:25:25 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y6-20020a655b46000000b00411bbcdfbf7sm9869894pgr.87.2022.07.26.03.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:25:25 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 02/14] can: janz-ican3: add software tx timestamp
Date:   Tue, 26 Jul 2022 19:24:42 +0900
Message-Id: <20220726102454.95096-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
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
modules in [1]. However, janz-ican3 does not rely on that function but
instead implements its own echo_skb logic. As such it does not offer
TX timestamping.

Add a call to skb_tx_timestamp() in the ican3_put_echo_skb() function
so that the module now supports TX software timestamps.

[1] commit 741b91f1b0ea ("can: dev: can_put_echo_skb(): add software
tx timestamps")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=741b91f1b0ea34f00f6a7d4539b767c409291fcf

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/janz-ican3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index ccb5c5405224..78d9190a4220 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1277,6 +1277,8 @@ static void ican3_put_echo_skb(struct ican3_dev *mod, struct sk_buff *skb)
 	if (!skb)
 		return;
 
+	skb_tx_timestamp(skb);
+
 	/* save this skb for tx interrupt echo handling */
 	skb_queue_tail(&mod->echoq, skb);
 }
-- 
2.35.1

