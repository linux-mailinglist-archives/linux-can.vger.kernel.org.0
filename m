Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C256757A1F2
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 16:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239590AbiGSOkg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 10:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbiGSOkH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 10:40:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCB0E99
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:11 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 17so3371176pfy.0
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pdimTSsBcdX/uHs4tiV7k0VxwvUhCLhYDAuFITW0R40=;
        b=CwW+cQgPWdixPqk3xBjFWKqip6ELuf19oIRpy+jfc+RbsMH/n3lxFD+th1yPsAKmqX
         3Wlpy9QCJkpQdXIt4GCeS51BmuNu2WVAl+RooeaBcKTURdQarNg9+b3EMLkmQ7ohywdT
         u6nLAX+1cIQ9lHJGSyhCFHyhSB7HaoaPWIGYBZrZ9e2n04kG34lkAFp0niOS1y3RR56M
         RfYiwpG7ARXaBXx9wWpXXkhl9ONtQZLAvjVm9qvWcBqtgRtJEkiP/s8PPDXGawt3pJ6I
         etUgl5EiUSPz1t4UJekw1cR6t1GhPdmA04PszVc1FSePBFhY6+uYI4krnfHkDRDyo3Ai
         hc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pdimTSsBcdX/uHs4tiV7k0VxwvUhCLhYDAuFITW0R40=;
        b=iaz+aeD5rFiX4ZjIwK5+yzgfAiEkMWKAUR1jozM2uoUjbqmBnhgTf2CjvevcAYyy33
         BrwkGpbYJ5Xwvo1drIglS2fd+Bqhju+ERKtSy5riAtUhA/vzecRnO4y1tJ3qPGWHAooi
         AyHmSaL9n+AVNqzSQo03rflJkWn9Uy5LJsaYe8wZh0GrQS18Ect/DtGbo4L7d+dDxxa0
         ekvGK+w7s2hiblAnrCjhAsKYjrk+DnaIKpQuM6xulhU5KyKa7YX+NhkL4zC184EX37Nn
         ZeODTn1BAlisb/Up3DoMDtjLjVc/FjjmbktTNHwJaJ5DruVge/Z+OXbTp/0pjPjbgozl
         OQfg==
X-Gm-Message-State: AJIora/soqBCCTgl0QyT086tprZEDFuABkcsDemow7xCHONvGKcpkVVg
        FS7mVLDsbPeUr1uirUl3AFNDUWWAEVorgg==
X-Google-Smtp-Source: AGRyM1treTfLJaQ9EW/YNp/8zIqUFo6N5nPWQqneH2YuyPeQwbIwaa3erzqX9QbfX9oHcRdw61ohEQ==
X-Received: by 2002:a63:5cd:0:b0:412:b163:b7e1 with SMTP id 196-20020a6305cd000000b00412b163b7e1mr30078010pgf.451.1658241370318;
        Tue, 19 Jul 2022 07:36:10 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d75-20020a621d4e000000b0052896629f66sm11562516pfd.208.2022.07.19.07.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:36:10 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: [PATCH v2 04/12] can: slcan: do not report txerr and rxerr during bus-off
Date:   Tue, 19 Jul 2022 23:35:42 +0900
Message-Id: <20220719143550.3681-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220719143550.3681-1-mailhol.vincent@wanadoo.fr>
References: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
 <20220719143550.3681-1-mailhol.vincent@wanadoo.fr>
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

