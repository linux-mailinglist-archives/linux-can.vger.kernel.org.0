Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6515A58111B
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 12:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiGZKZg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 06:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbiGZKZe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 06:25:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA3C101C2
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:31 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p1so4407827plr.11
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3OAyAclI8gDeKRzlzTjGfCuF1/4VXKJq5MDqz3fHHbI=;
        b=VRRLn296HtqB2lIHuaq+TPdQLUfwvh714cUnvqlKdDTigaXnMc5CCM6/pXdSlPa43Z
         jM0UQtPpLnxbmz/5yNyeCZYv97iYyjAcGTW8v2yZrBv21oi+HQNSZ/lvfyti/HTtBKMp
         dLp1nAT3v9brgoDtsegTe6rGXQkRirc5LuY/pHfUfEIcVmhUo2wtjgKyCoEk8SnSPAuR
         /+0ntN9xvCNGzPvOebbUxhelYM9RPOWYGDhg3Hs4lDF+V6EfXhJ4Vb/bXGwth/F9eYIq
         0vHWv1xo0MUjwVS82pi6mbDnyYoOKw+O9YBJLHTFWKI/f/xHV2yX/rXZyZNYqDD33L8J
         DInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3OAyAclI8gDeKRzlzTjGfCuF1/4VXKJq5MDqz3fHHbI=;
        b=xQNha1hgiTkZQ1JQ6JaSZFE7vcrMuYrPgTtiwqeU1BHhDp4QcjRsrO/88hS33qVMhR
         0XRGr0gJM1M2w5UTaweAvNY6W5z8SK2Fgz98Id6wwQHm0WAoYZmm1FGJgsigOWzzxw8Q
         CYqgLStyJjZpZ+UTAzP545VkZQY6c91n916FjwlXb1JhmeEhWmQwJvydxDRmCY9f/R7A
         MOaF1iVrbpRv0utrfi+RCpIJsCnyQtaQudntc5INsuuGGpUmDMxTzIbhIU5tOMxVIfpO
         Rxw8Vj/K/cMKInRNjqhZVYj/YUdkoUJzlGZQWErsBXlu7jZIzI4nLS1jBRAsTAcd3UTi
         Q67A==
X-Gm-Message-State: AJIora8r1zY4fHOFpsuUX0TgRhLZEPaU65y5uzdaWcBpXMi0+m6ZytrE
        yx8NQOE7ps7a8y9LneMXXawcEYmvl6HFlg==
X-Google-Smtp-Source: AGRyM1v2qDrrkUUeqqpBjYfZDbT3MOWmQjeBI8/g41AKLHr6Y08s/BMWZDp8UZ6tMT507h5OBalhmA==
X-Received: by 2002:a17:902:e88c:b0:16d:4364:2c37 with SMTP id w12-20020a170902e88c00b0016d43642c37mr16273703plg.69.1658831130802;
        Tue, 26 Jul 2022 03:25:30 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y6-20020a655b46000000b00411bbcdfbf7sm9869894pgr.87.2022.07.26.03.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:25:30 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 04/14] can: v(x)can: add software tx timestamps
Date:   Tue, 26 Jul 2022 19:24:44 +0900
Message-Id: <20220726102454.95096-5-mailhol.vincent@wanadoo.fr>
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
index a15619d883ec..4a363cfcf97c 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -99,6 +99,8 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
 	/* set flag whether this packet has to be looped back */
 	loop = skb->pkt_type == PACKET_LOOPBACK;
 
+	skb_tx_timestamp(skb);
+
 	if (!echo) {
 		/* no echo handling available inside this driver */
 		if (loop) {
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 577a80300514..61b6eca383f8 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -53,6 +53,8 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
 		goto out_unlock;
 	}
 
+	skb_tx_timestamp(oskb);
+
 	skb = skb_clone(oskb, GFP_ATOMIC);
 	if (skb) {
 		consume_skb(oskb);
-- 
2.35.1

