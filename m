Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CD15801EC
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiGYPcR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiGYPcP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:32:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EE4B4A3
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:15 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ru18so4927734pjb.0
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rxh8NIn7rEkySjE7yYsznT2BkKzwISLwPSxvkW2bKk4=;
        b=U7EIWmzFPKAocfTbnNvor8H1+kfTM9I+fy6OKhHifCQyn0j5hABps+AlK+/9E1aav0
         TQ8iO7DY3IpHLehgAGh3kOgbPWP7473TDIPcVhD+z+Ra2CdDy30OXdKod9RzFPYZKWff
         975GKFe32NtlbZ0+4tCcb6XwPPon3UX3kLeQQhvqf7QuqVs4LE8N6+ZI7w5NcOdsEDVi
         Afx6pJPNhfGNyO69DXTpVBb/10PGMWqCI/tR/I1tRtvsIimbfefkr+RwK7saIKKZxyup
         SNb9h3/kBRMbQnL0ARvGLTbD6FxqmaBGHbcFn0Bwq3hr0cLZBwnjNo+supAV2BVRKlwT
         9YiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rxh8NIn7rEkySjE7yYsznT2BkKzwISLwPSxvkW2bKk4=;
        b=HPT2qctAh8khznKqJ/jF5lJZOhUZXg9El7tAn8fdDXCMm0RAZqjvGJ/IvNzfOi0uW1
         PLukIxToFdVetfpkSkbqdrEMoGxgcI7lurSTOSVrvMHVWD16T7dSXq+/kPj43kIPNW/m
         uGAG65sQNmptuB7i1csuiqish9lZjWjyLlv1Iv6ForNz+QbFzgl3q4jKgQFsiUIlEubK
         cXGND26mX+kk38xMbtk8GSVQX9x+4tf2Z5S728XyqlJZ0KgpMlS8rWcQiIZgLGqSNgv0
         CBr14cgpHpKE4bNtlqHPrIwf83wx9kqLmquxvRUw69iNg2tDWfM+caOCItlBNC2o3r5j
         IE6A==
X-Gm-Message-State: AJIora89EcS6EhrdSPdX9x3bS/2aa6u0asLlOCyzrhFtsqEFmskUPR29
        QuV3jHpYFWw5SVFOX67skzUVh19M5xLszw==
X-Google-Smtp-Source: AGRyM1vQ/ygKuCuaBkbGYi+uXJh42tNSnUxbrrRQQZ7/bGdvWri/QW6t/0qP+zmZAk6ob6UfOdwXRA==
X-Received: by 2002:a17:902:b497:b0:16d:1280:ebe5 with SMTP id y23-20020a170902b49700b0016d1280ebe5mr12717340plr.70.1658763134431;
        Mon, 25 Jul 2022 08:32:14 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id m1-20020a62a201000000b005289ef6db79sm9745477pff.32.2022.07.25.08.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:32:14 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 6/9] can: gs_ubs: use KBUILD_MODNAME instead of hard coded name
Date:   Tue, 26 Jul 2022 00:31:21 +0900
Message-Id: <20220725153124.467061-7-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
References: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
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

The driver uses the string "gs_usb" to populate usb_driver::name,
can_bittiming_const::name and
can_data_bittiming_const::name. KBUILD_MODNAME evaluates to
"gs_ubs". Use KBUILD_MODNAME and get rid on the hardcoded string
names.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/gs_usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index d3a658b444b5..fd239b523c42 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -993,7 +993,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	netdev->flags |= IFF_ECHO; /* we support full roundtrip echo */
 
 	/* dev setup */
-	strcpy(dev->bt_const.name, "gs_usb");
+	strcpy(dev->bt_const.name, KBUILD_MODNAME);
 	dev->bt_const.tseg1_min = le32_to_cpu(bt_const->tseg1_min);
 	dev->bt_const.tseg1_max = le32_to_cpu(bt_const->tseg1_max);
 	dev->bt_const.tseg2_min = le32_to_cpu(bt_const->tseg2_min);
@@ -1100,7 +1100,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 			return ERR_PTR(rc);
 		}
 
-		strcpy(dev->data_bt_const.name, "gs_usb");
+		strcpy(dev->data_bt_const.name, KBUILD_MODNAME);
 		dev->data_bt_const.tseg1_min = le32_to_cpu(bt_const_extended->dtseg1_min);
 		dev->data_bt_const.tseg1_max = le32_to_cpu(bt_const_extended->dtseg1_max);
 		dev->data_bt_const.tseg2_min = le32_to_cpu(bt_const_extended->dtseg2_min);
@@ -1270,7 +1270,7 @@ static const struct usb_device_id gs_usb_table[] = {
 MODULE_DEVICE_TABLE(usb, gs_usb_table);
 
 static struct usb_driver gs_usb_driver = {
-	.name = "gs_usb",
+	.name = KBUILD_MODNAME,
 	.probe = gs_usb_probe,
 	.disconnect = gs_usb_disconnect,
 	.id_table = gs_usb_table,
-- 
2.35.1

