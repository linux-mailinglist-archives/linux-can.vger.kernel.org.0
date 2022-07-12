Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC632571F44
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 17:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiGLPcb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 11:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiGLPcb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 11:32:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717BF9D514
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o15so7948249pjh.1
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pdimTSsBcdX/uHs4tiV7k0VxwvUhCLhYDAuFITW0R40=;
        b=azpkezrUlPTFXtWebvzx7ADStFoM7wJ+ahWcIuMYchGJcIMURW8aZ+naDn2iQxaffu
         z8Ls/LCy+xaBiUjFOJLnqVGUY/i9if1l2fBH57XJ2900bcgtquVwQ6+3EhnvLGnFuXfR
         amAM1hatnEpCnMSSPc7zGN/uWvH5ZuuK/Uy83sLEi7ZCndfdk/rvjuIXm/ydzyxKapmW
         aj1W6ya24uRSw5Aw0sJIVKsBQilpcrXyREW++8Vj3+eAIik0cPZ+RvsM4vqARd3YuBwq
         MBKQgXRXE/CTSeKkxoROQ8ZDThUh0NAmm+3okPJ5N9eVVmp5mmfI2l5Kny/eYbV0hD4w
         0A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pdimTSsBcdX/uHs4tiV7k0VxwvUhCLhYDAuFITW0R40=;
        b=l0tRotd7U8sE02n3l0SVqTVWYWlRZZVEyZGE260D7qwfs74FV1SC2l6v/qJlkLGvia
         ffVpTLcQaEtS6BrDW69NmVNc6wV2NbBJZw6UQFUkBkpJyoL8fYyvKIWz70hL0J16TMyj
         pxWtsS8GvdxTk9SCAU6xpscORgdXJfk6N4Vg0WCW9gwbwiGKHUm/f9f6IaWxVV9BgqW7
         XFchWDBItZIh8kFAHKkLZfysfpsXs84vkurhm37Xtxr3jAO9fXYWF81dODIZBvHYpaeL
         9KHgN0zlSGgYImDmN+nVec+qn2DlxJHcEmZUCIS5WGJBptRUJPBlqMnthfWhQs2JoAEz
         knpA==
X-Gm-Message-State: AJIora+LDZnpvaOIWm3ZxErWgYvhd7iYFoyxi+MgO3jMUEeFbzOsWTBz
        adV5LS5vbNpvhkoJA7sDT3kKfAbcz10rgA==
X-Google-Smtp-Source: AGRyM1uEzWevquVVbQ4LNM4k0FVuXeGltLPma0yVItbbcjcSISrl1RQOM97DTlkssxAObqJ9yX9pZA==
X-Received: by 2002:a17:90b:1d08:b0:1f0:19c6:d840 with SMTP id on8-20020a17090b1d0800b001f019c6d840mr5059078pjb.192.1657639949828;
        Tue, 12 Jul 2022 08:32:29 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id c131-20020a621c89000000b005252defb016sm6891483pfc.122.2022.07.12.08.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:32:29 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: [PATCH v1 04/12] can: slcan: do not report txerr and rxerr during bus-off
Date:   Wed, 13 Jul 2022 00:31:49 +0900
Message-Id: <20220712153157.83847-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
References: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

During bus off, the error count is greater than 255 and can not fit in
a u8.

alloc_can_err_skb() already sets cf to NULL if the allocation fails [1],
so the redundant cf = NULL assignment gets removed.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/net/can/dev/skb.c#L187

Fixes: 0a9cdcf098a4 ("can: slcan: extend the protocol with CAN state info")
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/slcan/slcan-core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 54d29a410ad5..d4137cd9cd97 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -306,19 +306,17 @@ static void slc_bump_state(struct slcan *sl)
 		return;
 
 	skb = alloc_can_err_skb(dev, &cf);
-	if (skb) {
-		cf->data[6] = txerr;
-		cf->data[7] = rxerr;
-	} else {
-		cf = NULL;
-	}
 
 	tx_state = txerr >= rxerr ? state : 0;
 	rx_state = txerr <= rxerr ? state : 0;
 	can_change_state(dev, cf, tx_state, rx_state);
 
-	if (state == CAN_STATE_BUS_OFF)
+	if (state == CAN_STATE_BUS_OFF) {
 		can_bus_off(dev);
+	} else if (skb) {
+		cf->data[6] = txerr;
+		cf->data[7] = rxerr;
+	}
 
 	if (skb)
 		netif_rx(skb);
-- 
2.35.1

