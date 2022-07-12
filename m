Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BFB571F46
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 17:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiGLPcg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 11:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiGLPce (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 11:32:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033059FE14
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fz10so7943898pjb.2
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iTFeGABwo+oSJhgr4wQEyOTGftixNOV6Hxu50l9MYsk=;
        b=YzL3bVGELBLfLogHb2nC/OgE4z60OaShqZn48+KoS+5Z7Wa+Fbe20V89lX45Rni/TM
         n5Gte59Ng7RsNLq7eM+qsZVJxUYcKCATlskzeAKf+oWTg0VZ4Euhveo+jYIZY90uCnhN
         Wk3ByAhefeRCiQvJCLlj+PDmC9TPTWxRq4TLbvfQqyBMJqkzWy2ZHuicrOszuf0Ctnwy
         Dfps/1IdBaEbZOvRW6M3vQ3PTtZZUyDQRippx2pwjRzLrd/tPxztSVkygNO7RqZL2mey
         DUa2MuWGBg8wpstYGFnwSua339JZG02JKkkQeyex+n/UStf9FXQepgevVfc9qG3+SG/W
         6BTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iTFeGABwo+oSJhgr4wQEyOTGftixNOV6Hxu50l9MYsk=;
        b=nZGqzZC+ea02CegBz8DglPr9/Z6Ba/IWZWdYBDqWJPqHudqtZu/0u6kv685iJ3l2Eh
         CAL59fMnGNt+hS2P+MoJDGETH40/Jifk1HHicF0gXQv9PpjO/+SLGM4/pLwUe25cvpGg
         SsM2hTUvGMVg7udohIKK2KJVzyCcPmLoR/TG4qcOEwXO0UE+6T0hpcf/kxc7/rQ9b6jX
         Qnupn+iB8Elc3vgOu49EM6XJUj0hXuZeMLGBtelSQB7v2y8EWSEDjM2yu5LXfFE+6b2t
         Zk07YQ+JPTHXqtIGXwU5yetRBbigU8DzhJ9R7GAY7zaOfabq50+tBX7d8gUN4ZJ0Q8Xl
         q5TQ==
X-Gm-Message-State: AJIora8KicEa4kHQyW8+KHRKPB1agUWTeVJz5G3QghwCSHGi5pFtGmJc
        c954qr++dE3H+xWshrbzcsyuGR71ui7KTg==
X-Google-Smtp-Source: AGRyM1sX56jRbrXGX8B2ukLep+QsxsvganLqrABeVN4JSnB5/4cfV6NNnvJ5roWIypxhr6PmZCtDDQ==
X-Received: by 2002:a17:903:32d0:b0:16c:eb4:ad8 with SMTP id i16-20020a17090332d000b0016c0eb40ad8mr25198772plr.54.1657639953213;
        Tue, 12 Jul 2022 08:32:33 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id c131-20020a621c89000000b005252defb016sm6891483pfc.122.2022.07.12.08.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:32:32 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v1 06/12] can: sun4i_can: do not report txerr and rxerr during bus-off
Date:   Wed, 13 Jul 2022 00:31:51 +0900
Message-Id: <20220712153157.83847-7-mailhol.vincent@wanadoo.fr>
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

Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Kernel module")
CC: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/sun4i_can.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 155b90f6c767..afe9b541f037 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -535,11 +535,6 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 	rxerr = (errc >> 16) & 0xFF;
 	txerr = errc & 0xFF;
 
-	if (skb) {
-		cf->data[6] = txerr;
-		cf->data[7] = rxerr;
-	}
-
 	if (isrc & SUN4I_INT_DATA_OR) {
 		/* data overrun interrupt */
 		netdev_dbg(dev, "data overrun interrupt\n");
@@ -570,6 +565,10 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 		else
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
+	if (skb && state != CAN_STATE_BUS_OFF) {
+		cf->data[6] = txerr;
+		cf->data[7] = rxerr;
+	}
 	if (isrc & SUN4I_INT_BUS_ERR) {
 		/* bus error interrupt */
 		netdev_dbg(dev, "bus error interrupt\n");
-- 
2.35.1

