Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F29A580EE6
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 10:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiGZI1Y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 04:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbiGZI1W (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 04:27:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106F72FFE2
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so16616228pjq.4
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WgKZK1ryW7n8FfY8HQ02RysHFRJf9yfLai6BH3I1/14=;
        b=JWZvqqX+1AvpcJjfw60PucwvTWG04XosgMfvh/gsNbuR1/mDaTdsxfwD9e9VPtEhoj
         jDSaB+XmxtUMUAjfvlDXpw38qQ0QJszIP+kU6LejnGm7SqztyhTyQM1Aws0yU/VaCadt
         usULcJzVUA7pEEtR5g7dXvOPc3WH+1N2yrKsMsyk9dybvcEG63hL8Kb1ztYbv47xJIu7
         O7t8ucMXmJtzHfMENQlfQWfF0jE0zFzkKrx0kjtUkmZ3IPyHFYs31hCMmTkTgtADYekb
         vj2fxR1G/s1A+defimhjXep/ufoyNSFwcOldhVQWU6xa47BP/rjKrgvorlREhxB8zZRy
         aQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WgKZK1ryW7n8FfY8HQ02RysHFRJf9yfLai6BH3I1/14=;
        b=mrh4dHjuHvh1udGq71gx4TebxSCGMHGYcMEpMZrNk4rBR08bhJa6xEQ/DtmgeXT3JW
         MfyS44igGLR2gtPCryYcmGXglKWrBjEV3GHJWZcwmjxw/DS9GEDrf/JyC3yi5EN9rFHd
         kymSMyyQjh36rO3McPnj1g54Gy2+4EIWaHpxcBBJiN/vDhJR74xE1bcMaWixC5XqRdlF
         /xDyFRJe2APbkZwKi44/AoDeWAVWPVLMCRVjSK4P4he+ee4gOcKaVyJsziZPgCr3UE11
         ydaxsO1sVT9e8w+rGeTHXPe1MGWmAMe9n29wze+oGrN0Ib1k5BUqa14y/Mzf89OR+H5p
         lCyw==
X-Gm-Message-State: AJIora/f8p1a7LR+7i74xeGBW3TtP//vKnwuCcYfzpExU41t2y4qF4sc
        P9Giy2cnmFkyI227zD9I56RZYKeIiuLhuQ==
X-Google-Smtp-Source: AGRyM1vnEKmpk3oRrVle4NbaJrNCthfDw0ZRmtkyasnWuUsT3POJHJBL+FFnT9wo192ZDUvNScnhEw==
X-Received: by 2002:a17:90a:f285:b0:1f2:620b:d9d8 with SMTP id fs5-20020a17090af28500b001f2620bd9d8mr16477473pjb.24.1658824041376;
        Tue, 26 Jul 2022 01:27:21 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e1d100b0016bf10203d9sm10689751pla.144.2022.07.26.01.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 01:27:21 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 01/10]  can: can327: use KBUILD_MODNAME instead of hard coded names
Date:   Tue, 26 Jul 2022 17:26:58 +0900
Message-Id: <20220726082707.58758-2-mailhol.vincent@wanadoo.fr>
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

The driver uses the string "can327" to populate
tty_ldisc_ops::name. KBUILD_MODNAME also evaluates to "can327". Use
KBUILD_MODNAME and get rid on the hardcoded string names.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/can327.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 5da7778d92dc..bf0cce2dbb40 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -10,7 +10,7 @@
  *                   Fred N. van Kempen <waltje@uwalt.nl.mugnet.org>
  */
 
-#define pr_fmt(fmt) "can327: " fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -1100,7 +1100,7 @@ static int can327_ldisc_ioctl(struct tty_struct *tty, unsigned int cmd,
 
 static struct tty_ldisc_ops can327_ldisc = {
 	.owner = THIS_MODULE,
-	.name = "can327",
+	.name = KBUILD_MODNAME,
 	.num = N_CAN327,
 	.receive_buf = can327_ldisc_rx,
 	.write_wakeup = can327_ldisc_tx_wakeup,
-- 
2.35.1

