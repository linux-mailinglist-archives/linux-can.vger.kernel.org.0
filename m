Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A1580EEE
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 10:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbiGZI1j (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 04:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238312AbiGZI1h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 04:27:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52942FFFE
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g12so12646337pfb.3
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IMpchuLPvI2YU/kz/E0OwyqsknPI2jO8M9kmFwVpvy0=;
        b=ZW9AGTRUgXmWJR3/zoC0XRV5RO0RsIFEeiwPrJCAUHspjL6LlpT5fJVVn1FbOIDp3l
         GgSKQRxwUG/0MRKUXuAeFtpUNUuuSzlTA2X2/XzkaiIq0sRgRBmluhmdCGnMdjDW15lf
         yBc73N3aljB+03ygZ2j950e+tJrv2mmK2KwLhhfYPM2ZL2rPGhZKWC/qaM+2UhCwuktK
         8JKYWsMj6yT2qC1v9mnpMQt30tJ+L2X92oIW6ra0SxUAyVHI+GYG9QXduCfMw1YUlbls
         FdfcXGLawfqQMoa4GfJvsK3vVI7Q2OhdK9gRQbKFgRd/AIksBGqt5JxwhTEn482WNP7k
         aEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IMpchuLPvI2YU/kz/E0OwyqsknPI2jO8M9kmFwVpvy0=;
        b=m34TvNifUgkRm2Acn0oCkmQVPxsbwUwM1ZLUffpLep0W6KDMvkzJKeMz1/913WiL1E
         EAz9sUzHRnDnCvUQrth3B6fiU/LuZNEF7wH2HzGJ+HwbP79+TOOI9WQvdmBpL7NMbTc9
         OY8LpP6ytaFJSvazjls2xKZdFDlv6vtd55LLncQLcvdSVWrUj0waj5ds4IgXHvwxAbY8
         0Eid5gYal9LliIX2CLb+LH1gJKsZyVrgipDiQ5jJnLuKKN9lxZ65fMlzX0q22uSLIxKQ
         Qq+z+SD4Cx8nCB7cZ6EImQ/XAUc9TKod+b80OvjDK4zD8V1ovT++gXuJAlSC6tMcjxHq
         YxNQ==
X-Gm-Message-State: AJIora/hokiGw7/pG7VjlqMtguu+YaHlXfIBzEtRBoXRrISw8gduJPvN
        fFNVtwpPPiQr2GbzYYwvVgC83Wy8PzcTSQ==
X-Google-Smtp-Source: AGRyM1vLCm0++ohzjJnDQ02yuwQPw+7Wwu6aojo941oIXbht+4HA+BQBvHbohpF6XNBK39ko4h4GbA==
X-Received: by 2002:a63:eb03:0:b0:412:b1d6:94ca with SMTP id t3-20020a63eb03000000b00412b1d694camr14115574pgh.468.1658824055098;
        Tue, 26 Jul 2022 01:27:35 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e1d100b0016bf10203d9sm10689751pla.144.2022.07.26.01.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 01:27:34 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 09/10] can: etas_es58x: replace ES58X_MODULE_NAME with KBUILD_MODNAME
Date:   Tue, 26 Jul 2022 17:27:06 +0900
Message-Id: <20220726082707.58758-10-mailhol.vincent@wanadoo.fr>
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

ES58X_MODULE_NAME is set to "etas_es58x". KBUILD_MODNAME also
evaluates to "etas_es58x". Get rid of ES58X_MODULE_NAME and rely on
KBUILD_MODNAME instead.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 7353745f92d7..ade0a650e0ed 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -25,7 +25,6 @@ MODULE_DESCRIPTION("Socket CAN driver for ETAS ES58X USB adapters");
 MODULE_VERSION(DRV_VERSION);
 MODULE_LICENSE("GPL v2");
 
-#define ES58X_MODULE_NAME "etas_es58x"
 #define ES58X_VENDOR_ID 0x108C
 #define ES581_4_PRODUCT_ID 0x0159
 #define ES582_1_PRODUCT_ID 0x0168
@@ -59,11 +58,11 @@ MODULE_DEVICE_TABLE(usb, es58x_id_table);
 
 #define es58x_print_hex_dump(buf, len)					\
 	print_hex_dump(KERN_DEBUG,					\
-		       ES58X_MODULE_NAME " " __stringify(buf) ": ",	\
+		       KBUILD_MODNAME " " __stringify(buf) ": ",	\
 		       DUMP_PREFIX_NONE, 16, 1, buf, len, false)
 
 #define es58x_print_hex_dump_debug(buf, len)				 \
-	print_hex_dump_debug(ES58X_MODULE_NAME " " __stringify(buf) ": ",\
+	print_hex_dump_debug(KBUILD_MODNAME " " __stringify(buf) ": ",\
 			     DUMP_PREFIX_NONE, 16, 1, buf, len, false)
 
 /* The last two bytes of an ES58X command is a CRC16. The first two
@@ -2280,7 +2279,7 @@ static void es58x_disconnect(struct usb_interface *intf)
 }
 
 static struct usb_driver es58x_driver = {
-	.name = ES58X_MODULE_NAME,
+	.name = KBUILD_MODNAME,
 	.probe = es58x_probe,
 	.disconnect = es58x_disconnect,
 	.id_table = es58x_id_table
-- 
2.35.1

