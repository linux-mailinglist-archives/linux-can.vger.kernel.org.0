Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3020580EEB
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 10:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiGZI1e (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 04:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbiGZI1b (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 04:27:31 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E201E2FFF6
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id bh13so12573083pgb.4
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rxh8NIn7rEkySjE7yYsznT2BkKzwISLwPSxvkW2bKk4=;
        b=miSjtPpP+S+27IfcN0Q7deTONdCMwNyhFYptEB4pDbY54187hjyse31Ac7r49yw7Ci
         7Czt8nBJ51sqfoY8fThM0FIfAvdsA/5k8j8PkDZkRHu8weBKxIf+xmuqx2N9ccEw95fL
         K9nzC5lTTaU85W9Hw7AUKjFTXBiIHJzyUrWoSzMEcgZimKVrxtFjH9wNwloaKaikfrbX
         A8AQh+U1xa7y5EM66xsrZdwqs+H7QuDerUiJETm4jvwpPL2DOLDVBdaLMLH+3xn5QKHn
         jooDRxki9bExSRihnn0gsflftvPqfBc+aIFY9ZKXtMaera8I8acECUg/FzmqL9SZcDik
         ZFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rxh8NIn7rEkySjE7yYsznT2BkKzwISLwPSxvkW2bKk4=;
        b=X5RbE5udl81UeU841jdwbmyhLN3xQB0jhI4sm2FhmfzQq++6pXO2ToJ6+5nC1fU/by
         EvfFHNpPRcjyri6/BcldxmuZEIdO5qVzWMI7pf+jz/N6oDR2jDbLQU7zyeskPeZz7oBU
         MfFQXB7FEgFPFrwunpgFhEZPOc+peM1IdydCR3VBVz1iO9LTFYyL7jm3+SuGgP5EyHKF
         /G+8443fxP/uEAGDBafaYh1LAHN/BP2r4jGu6h9xeUBRchNNtsNsKW4yesqbdQ+HwoXu
         zyBipkMTvsbMFDuvBR/slQCOlquW/ZI/Ng1+C5gu7QRPWV9EIAHcjVgW/F3TjLqwFsz0
         xynA==
X-Gm-Message-State: AJIora8YtRUdJKSPjuRJwaecX7eR6PLPrWwdAwQyuWOsS/XMBYmnuB3V
        0mq73swxHG29TaaqsARKISK5WcLRFhDX0g==
X-Google-Smtp-Source: AGRyM1uGtK/hAZbhbQJ+/6D6Zp6GRkoCHz2ZDfxkgLmwHiijsZkheJybUWJtGsR059qdaQVCaNhspQ==
X-Received: by 2002:a05:6a00:e85:b0:52b:5db8:f3df with SMTP id bo5-20020a056a000e8500b0052b5db8f3dfmr16424198pfb.14.1658824050122;
        Tue, 26 Jul 2022 01:27:30 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e1d100b0016bf10203d9sm10689751pla.144.2022.07.26.01.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 01:27:29 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 06/10] can: gs_ubs: use KBUILD_MODNAME instead of hard coded names
Date:   Tue, 26 Jul 2022 17:27:03 +0900
Message-Id: <20220726082707.58758-7-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
References: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
 <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
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

