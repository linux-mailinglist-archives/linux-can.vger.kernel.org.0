Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078DD57A1F5
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 16:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiGSOkr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 10:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbiGSOkO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 10:40:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE1C217
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so15950680pjf.2
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dXkn3+hceEZAYMXVqW3G/Ijdf6tSDcThRCh8BsisDI=;
        b=c/eQ4qwSw6AV9jtfAkTJbAUWt5LBzCHx7/Nz6CMKlhXfxe5pYG0mbQpAjvGHjdgkY0
         sHzOHKKUsTJsGawXIfNukiaHASTm3xVzy8ap7Nd7VG7NzXEOe2szjoGy0rkMBfLml5bY
         3l3D27d/0kqe1ThK1xQt0qBHomIiIizn49M6WFjFFaHSKF/1EwoK8nbZF1q0MWB1KyM3
         Vcsqz3m2uLEhfhEbhuz2ywjuRP7uHdtORo/Sjx7EivKEoP7/1pengij3/JR3gW3+LJuJ
         x5CatqHAnEC5wMHdgtzCQssn+BFVFeaBD8EZwCdJVo77y3brzHLmAbCf8CCgU5GyP/9f
         dQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2dXkn3+hceEZAYMXVqW3G/Ijdf6tSDcThRCh8BsisDI=;
        b=ku1CDTIkoWvrvX+FLLYCJxETMu9ZSikXXdwQAy9iXR5T4I2qgs2x2gT3UxzCA+Yo5+
         iyvvE680HKfkeP7hRxJkJ9HQr4BBJoMAarBTyCZ+PmG+VEMwfhR7TrH/dGYMbGunMek1
         wr+F4CfRSf4PMjsTXkHPk5BrzWvkoEh04xu6ayTVCQ00y2GutvoSIXmhlBRELhy2zseq
         80yE87hOLTrNnDWP3TnWNtizeibPjTwET960ydCfoLnWRln0JOb3NgLLXIZpe3u2qVyZ
         1qcsiFY2nDQGTQh6TRD9NDrYHbSluGjjxz/+wEM///h9bGx3jv2f/LJM0+pNOh87njjb
         yKNg==
X-Gm-Message-State: AJIora/O52i7cvpwzs0o/GRxqp7ONqaVJCewlkgkGme6+WHnvEa/ytCI
        r7GJm+H9YpQ7xVwFJo05UEm71z9BUYIEZw==
X-Google-Smtp-Source: AGRyM1vH6nIHtHEGadkvMeH1P7iV4ABvXL0acTa/x60+58e267+2v9sHL0uKbCv/C+m75MkON39iBw==
X-Received: by 2002:a17:902:d543:b0:16c:3150:9ba1 with SMTP id z3-20020a170902d54300b0016c31509ba1mr34384544plf.13.1658241376019;
        Tue, 19 Jul 2022 07:36:16 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d75-20020a621d4e000000b0052896629f66sm11562516pfd.208.2022.07.19.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:36:15 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 07/12] can: kvaser_usb_hydra: do not report txerr and rxerr during bus-off
Date:   Tue, 19 Jul 2022 23:35:45 +0900
Message-Id: <20220719143550.3681-8-mailhol.vincent@wanadoo.fr>
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

