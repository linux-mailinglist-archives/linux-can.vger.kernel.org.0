Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA0C571F4A
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 17:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbiGLPck (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 11:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiGLPcj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 11:32:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA232A2EC6
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o15so7948805pjh.1
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7lGPj1IZ4XsbIy/pVjASYgwH8VREWUtoj4U/sQCQ6Uo=;
        b=OpMnvNKusg9vfi2V17te0FzouNz1VJZcX9t2UO2yG4LWKAqmDLrM2ECplzYXfpvjN4
         mMmV5mRzbmF2l5yMtkNLsVEP2c7ZKiUqPW9Kl+7muTjoUCj9qzk2jdS7g8Y8Zc5NqY/N
         8CnkIC9YcYp41QRsgHHKf2+xzhv6i7YA6F/mvNTR2LpuI2xs20AJ/ic2AiLvCibOIjkC
         rrkeRfAhtn+221B+ick8PouIuxfbvhSm8k4V/WNMswdFiJLf6ZWhAbakFrHZ5i8HGlHD
         3NhRQgBCfSR579LFDG6T0EsY8WT/CQBmSFlS/og7gS5ix3soCf67tTlerzJksuGqVWac
         zURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7lGPj1IZ4XsbIy/pVjASYgwH8VREWUtoj4U/sQCQ6Uo=;
        b=29/rjQTx0eBqnC1z4FhZJ20K0YQDwTjvrYOODY4OnHG0ZL9+zGzsMAOvRKupu/S+a/
         /KtNJcNdk1Bz4GhrlQrpf0R791tl4TotmKkr5GI3jYElzmOAPgszCqjUBJ6NK+KZatsn
         QHOZm/u822biZHvicGjCgvHRf7EakPAFhHjegBs+gPwa7gZC2mZvOUomqWs4T6Fukm3F
         wwXyyNYFJSvW4dFaOyapwLUpWXxgAVkJg9l8WDsoMNpVBQzIHHMI3dh6XzPEbXJoeOq+
         PQuw58Z4FKGibPPLvdPP2kOnbiHeSHmcC0YOclhLudTUaUMPouqC9+JRLjxMfjxL/E5h
         ArhA==
X-Gm-Message-State: AJIora8wYqG0nUXNK2wPQ71yxJ6hu3vnaUc+v8zTQFy3dhh5dx1UwDCi
        SB1ZNiOWYeNN1VBvEhL6bPpJyy3cfE7Jrw==
X-Google-Smtp-Source: AGRyM1sDTRDcROFFE605NXgqZ1Qahu4JL8MPzHY/tpS7gUjRpVL+n216s7s+fx3Mgg2Btxd8SowxWw==
X-Received: by 2002:a17:90b:3911:b0:1ef:f885:e889 with SMTP id ob17-20020a17090b391100b001eff885e889mr5077305pjb.27.1657639958273;
        Tue, 12 Jul 2022 08:32:38 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id c131-20020a621c89000000b005252defb016sm6891483pfc.122.2022.07.12.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:32:38 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 09/12] can: usb_8dev: do not report txerr and rxerr during bus-off
Date:   Wed, 13 Jul 2022 00:31:54 +0900
Message-Id: <20220712153157.83847-10-mailhol.vincent@wanadoo.fr>
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

Fixes: 0024d8ad1639 ("can: usb_8dev: Add support for USB2CAN interface from 8 devices")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/usb_8dev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index f3363575bf32..4d38dc90472a 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -438,9 +438,10 @@ static void usb_8dev_rx_err_msg(struct usb_8dev_priv *priv,
 
 	if (rx_errors)
 		stats->rx_errors++;
-
-	cf->data[6] = txerr;
-	cf->data[7] = rxerr;
+	if (priv->can.state != CAN_STATE_BUS_OFF) {
+		cf->data[6] = txerr;
+		cf->data[7] = rxerr;
+	}
 
 	priv->bec.txerr = txerr;
 	priv->bec.rxerr = rxerr;
-- 
2.35.1

