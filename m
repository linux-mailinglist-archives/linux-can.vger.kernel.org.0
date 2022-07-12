Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23B9571F48
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 17:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiGLPch (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 11:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiGLPch (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 11:32:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7813A9FE14
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:35 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o15so7948597pjh.1
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dXkn3+hceEZAYMXVqW3G/Ijdf6tSDcThRCh8BsisDI=;
        b=ELQgm10xBn3GrF7WQrPcdpGo3wNBCIHKb+rXMxoiTZgTuIUW8oWtN3duwdAadpJ4my
         4GdpEQkqB5raluPXpo1KEHigjm4znxI/qBNGbqDQjewCJHyHZGqHk0ltnh9s+b6I9Fso
         Z4E09jUk8yKHOoAjV+TYr4IBFn44a3tXRW5p2g042oHWSXgpM1dLOtL5jNGIQqn/9ZuN
         wqVUAUzRerXM4X4jrUJhwtMUdpw3DJQmNlHRnd2QHgiexMWmPu22XATkgWYc4SkezTq/
         Zw9TEiX39F2Jd9bOI1AhY4b90/zUhyINOvjbP3vapHTTkmoG5w7OX5yu/ax/gGH98JUy
         JKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2dXkn3+hceEZAYMXVqW3G/Ijdf6tSDcThRCh8BsisDI=;
        b=7h+wCxzK064hPkYZdVe5DKnab6bie1E9Ctspr/oFn0AfQRYmnGwfHGbCxThicSv0Rf
         XOD4IodShuSnUF2ctBCGzeHxPasVADsIs00b1Bi/EWokejiF6Sjr2BpxO/IChq6mwcsn
         4pt0GULvA/X6A8mfTAMCdt3tHnpO7ft+QGx9cK1FTgtFqEc5gO+V2Zdger0+wz7GZ9A5
         BRi3ztshVvDcWwWDuxvO8EqEtJnYNqHauMjMMGZmsvsd8FinxInZU06Ab9l9CKHqWBVW
         bGdJ789Qp3GOpOCTs/Za23Z1LFkUIFwGk+x91v33D+hSBuDWOTjMlAfr+IVQph0IfGVl
         HCrQ==
X-Gm-Message-State: AJIora/2x7+8XnpvHxLA/DpwGXzcqwJ9e+ghqW1mffcSZOuMF9hP/LN3
        lRaV6Tuo90dYKRjXU29AvsWq3mcfiIMp4w==
X-Google-Smtp-Source: AGRyM1vffYveGqSazC+nnKKIb9zQIjIvTZKnIgrGrtZY0aK+gpjx+G1ab/hGnbPC4YeazRE5UAE12A==
X-Received: by 2002:a17:903:124f:b0:16b:8167:e34e with SMTP id u15-20020a170903124f00b0016b8167e34emr24308034plh.52.1657639954973;
        Tue, 12 Jul 2022 08:32:34 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id c131-20020a621c89000000b005252defb016sm6891483pfc.122.2022.07.12.08.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:32:34 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v1 07/12] can: kvaser_usb_hydra: do not report txerr and rxerr during bus-off
Date:   Wed, 13 Jul 2022 00:31:52 +0900
Message-Id: <20220712153157.83847-8-mailhol.vincent@wanadoo.fr>
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

Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
CC: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index a26823c5b62a..af27f0f9aca2 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -917,8 +917,10 @@ static void kvaser_usb_hydra_update_state(struct kvaser_usb_net_priv *priv,
 	    new_state < CAN_STATE_BUS_OFF)
 		priv->can.can_stats.restarts++;
 
-	cf->data[6] = bec->txerr;
-	cf->data[7] = bec->rxerr;
+	if (new_state != CAN_STATE_BUS_OFF) {
+		cf->data[6] = bec->txerr;
+		cf->data[7] = bec->rxerr;
+	}
 
 	netif_rx(skb);
 }
@@ -1069,8 +1071,10 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_net_priv *priv,
 	shhwtstamps->hwtstamp = hwtstamp;
 
 	cf->can_id |= CAN_ERR_BUSERROR;
-	cf->data[6] = bec.txerr;
-	cf->data[7] = bec.rxerr;
+	if (new_state != CAN_STATE_BUS_OFF) {
+		cf->data[6] = bec.txerr;
+		cf->data[7] = bec.rxerr;
+	}
 
 	netif_rx(skb);
 
-- 
2.35.1

