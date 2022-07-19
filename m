Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F04E57A1FC
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 16:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbiGSOko (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 10:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbiGSOkJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 10:40:09 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E073E55B4
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:14 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s27so13624879pga.13
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iTFeGABwo+oSJhgr4wQEyOTGftixNOV6Hxu50l9MYsk=;
        b=ZsaA6uyp3T5FFmQ3YCXSg8U4LKpFjBidYjbtnRkxMLtwY9+EjkdyxEU0yTtEYOD1y0
         6jgDeDLEVbmczIsfcAYVHu4qn6L0J0uKRmDBPfIJkjDQjiY1xnZgvmRtgohZdgl0eQRE
         80P0szoBgbgfEA/yyhOn0ceH7091FGmKmVXVT6A5VtjgVZN9M5beFjywEmG4RAUsiQjU
         U7HiIkh9KBnObuMMeSbks0YXK3rPrSz7NC5QspFdIE+E7Xt6tBkxn1TtfhV+DG5+rO0y
         RrmK6J1wcMdh0oqppYRSrfFSMW3w8aoQTOOQv/LALapc7Lon8dk79rKadCOQlks0Qnvc
         Q72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iTFeGABwo+oSJhgr4wQEyOTGftixNOV6Hxu50l9MYsk=;
        b=oHPnEFaM+fUoYvRTSxCMaDHZTwci/LXdJmf2X8q9LEvczjiznWYtXRs0qHtFAdmLUe
         Xn/yLKg8iCk2rQgnaHtLHuIhQZgeDl2NMYz9kt+y6xb6eqzj+e/10g3hBtzJSXUSV2pK
         xbgsVoj+P0a0DLj3e6iF3LcLwgzON3sEFBYpy7C6b4v6KQaEiBvO57RHTtMJ3MbBd1JY
         fH0OhFnHbwdZc0MEKaUOCHJyrUEYBaA8A+7qJ+nJ+SEOfNXKTCz4WGM9IEI/UpYD9wPP
         LtUsdi9iBLFIhfZqGKV5BSBjMq6j+i5gvQuuL/kDIYQioRy26GLQH46qf70bWgVL0l8d
         +Pvw==
X-Gm-Message-State: AJIora/cEOCud+S6EBhBX6KGey5u9RyMi/rmKGBM5EC9aJFlyhHRVS8v
        KmwN0rQRHhTjpFJtN8jJPSXVk0jBIC+Jhg==
X-Google-Smtp-Source: AGRyM1vcEBbcCy2b7OIHw1rvawdlqCKY8OinnabVXaRk2DjO5LfkJpxBGXgv5HDDIdhTkgkYNLSMMg==
X-Received: by 2002:a05:6a00:1496:b0:52a:c3fb:8ec7 with SMTP id v22-20020a056a00149600b0052ac3fb8ec7mr33747159pfu.25.1658241374043;
        Tue, 19 Jul 2022 07:36:14 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d75-20020a621d4e000000b0052896629f66sm11562516pfd.208.2022.07.19.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:36:13 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 06/12] can: sun4i_can: do not report txerr and rxerr during bus-off
Date:   Tue, 19 Jul 2022 23:35:44 +0900
Message-Id: <20220719143550.3681-7-mailhol.vincent@wanadoo.fr>
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

