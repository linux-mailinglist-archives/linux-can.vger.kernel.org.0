Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C98571F43
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 17:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiGLPca (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 11:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiGLPc3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 11:32:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2299FE06
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y9so7746022pff.12
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQPY0V/qlPRYSc71/C3QyqsaJHrCXDE5XW8cNsLL7VA=;
        b=UoYu6SWFVZBPosb0bTB3WaX8NGWPAxWEaXVfo5KBF2FkJhbPM/+8f9a4B9qlP2s3iq
         s394JdRBXmcBtJ3n62Gb7DSe7ltcd+ELwwiho+cQif2W/8GWz6gJ+SRHxwRAgw4Jn//x
         sBuVckXU4JCEwc/R6pfew4UgaHiUwYY33eveJ1481elUzp9eMbQSD65mGnHTtJ3kaljW
         EK2kILrpmfOoF7SwL4py8+TZwhJxuqaimqMsdgpp9thRD4kLPvkU479LN47ZCLWv+6kg
         zXFSvMs35iNkDb1nFMWSSGXLcABUf9r++1eVQZMOs6Gdybs1HlgHKVlEO7M9uL4C9+vq
         2kNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QQPY0V/qlPRYSc71/C3QyqsaJHrCXDE5XW8cNsLL7VA=;
        b=Uhqm8vj+IRlV8eawLzagIa8qYp9uZjttJi7eAeuRTfNKznwZP22YCttmQMtYqZ9Xq5
         6gAX/crEPvkGdK4LH72Gk77dyl1bW+Y6swgTVYnyKvzNK8J0lSlp/3gkQRyg+jYEl6GE
         RZuU+QOF0Rg7vkWxwD2yGMP+iQT4VpEZYGgofYbstsKOBRWJItxJXGJLVF3N5m+j49vP
         bZFBdXv49Hax0AXdT1TasTNAjGY4NFe0C1z3ck6L7SVRB3D9/vNpURCiFGKBIXmR58D0
         Bc1nshxqUqKMc3VtMRIUEUy3U0c25sjnm3BUyUJy78eCAKyeNXmt7wUrX6/yaV89GTq+
         jzzA==
X-Gm-Message-State: AJIora/4EVVlBYfE7ivgUpRgOBD4pnz/pT/LaROxwdpc+6BhOuJ3cj8A
        ozvBX+JY65IxB3ub3iWlXTIIwxg+VyGzVA==
X-Google-Smtp-Source: AGRyM1vCM8ZgC/dz4usOaIYwmr204f1v+FJy+k/2xz1iHVH4KJgcBY31fHXP01wiBQM8JqXu7POvYg==
X-Received: by 2002:a63:dd43:0:b0:416:8be5:94d6 with SMTP id g3-20020a63dd43000000b004168be594d6mr5947882pgj.450.1657639948067;
        Tue, 12 Jul 2022 08:32:28 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id c131-20020a621c89000000b005252defb016sm6891483pfc.122.2022.07.12.08.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:32:27 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 03/12] can: sja1000: do not report txerr and rxerr during bus-off
Date:   Wed, 13 Jul 2022 00:31:48 +0900
Message-Id: <20220712153157.83847-4-mailhol.vincent@wanadoo.fr>
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

Fixes: 215db1856e83 ("can: sja1000: Consolidate and unify state change handling")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/sja1000/sja1000.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 2e7638f98cf1..84adf8b5945e 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -402,9 +402,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	txerr = priv->read_reg(priv, SJA1000_TXERR);
 	rxerr = priv->read_reg(priv, SJA1000_RXERR);
 
-	cf->data[6] = txerr;
-	cf->data[7] = rxerr;
-
 	if (isrc & IRQ_DOI) {
 		/* data overrun interrupt */
 		netdev_dbg(dev, "data overrun interrupt\n");
@@ -426,6 +423,10 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		else
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
+	if (state != CAN_STATE_BUS_OFF) {
+		cf->data[6] = txerr;
+		cf->data[7] = rxerr;
+	}
 	if (isrc & IRQ_BEI) {
 		/* bus error interrupt */
 		priv->can.can_stats.bus_error++;
-- 
2.35.1

