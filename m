Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BED5801E7
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiGYPcI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiGYPcH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:32:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BD2A182
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e1so224275pjl.1
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WgKZK1ryW7n8FfY8HQ02RysHFRJf9yfLai6BH3I1/14=;
        b=TUfGxBSnVANOZ6GLNa8jllbaKFnXYwwlN0L/R741iU91/LGdlfYupZQT5YNZgSonpp
         kfuCApiWB6gfWHhPEl9xUC18sWZkvkCCmxO8vrChxY6gfxICPndly6NX3wzeNHwicUs/
         y8vuMyKCP/XeAESPZfMenOpVYoDUGEDqEXewAQvjqYNWOMGe//+J9k1WSAZcLyh6+ZSB
         9aClYDVUY4yV6D06YqkEbVCXBlyQ+V5PZbkQ/mZmrI6KW8GJ9oSYcdIZGLfDDhM8Wfe1
         G1idA/4MKp6uFgpdkKvmukBRrjvuJN0zf89l4o5ukQg22Iktc7Ifi1PbUr00JPqcTQuw
         qZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WgKZK1ryW7n8FfY8HQ02RysHFRJf9yfLai6BH3I1/14=;
        b=CUaF5vXtPe6k3CVb2UzT/6GsdkZ4CVBw0+P6K6HhAVlMucsEYpxqZDl/VsttXei7hX
         Ma/vQD9+iBKLkBhSVyXDcVpu047OFCEEFlRVBw2OBIUidg31GrWnd9aWdSRTH0910tly
         WrzK8CJ7Vv1oheOYRtoxdEl8/cgd8fofr1eaCgrCQmvBSe3gAeGczjkYmAwURXaZtoLA
         TIJNHiAESSUtBolYg3qrjibdpw3dY/03TyQUClNoxzwMavjLak1PwTrJR4x4RqVJb9Qf
         K3zJ1fiAofO/Ff/PI+ytfpgzZ+oKxuqJNDRs35YtCYinuJ10Qn1njLTYpsSMTrFdtTAT
         s16w==
X-Gm-Message-State: AJIora9RiP3w0NN8g3c1rZgkY/nLPJm4nCrbARfEudcGynR3/ojaslWK
        VgYhyyot4sI5buYVqqpU0QW/WWah0Y6iZg==
X-Google-Smtp-Source: AGRyM1vzmnZoFjtz16/B0g9iUQ4R4o8y2NdokVW3WBvK8/sq7a8FCRZ4uSSproa/mOyvwX3EoZU0oQ==
X-Received: by 2002:a17:90b:4d92:b0:1f1:be59:a60f with SMTP id oj18-20020a17090b4d9200b001f1be59a60fmr33428544pjb.152.1658763125830;
        Mon, 25 Jul 2022 08:32:05 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id m1-20020a62a201000000b005289ef6db79sm9745477pff.32.2022.07.25.08.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:32:05 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 1/9]  can: can327: use KBUILD_MODNAME instead of hard coded name
Date:   Tue, 26 Jul 2022 00:31:16 +0900
Message-Id: <20220725153124.467061-2-mailhol.vincent@wanadoo.fr>
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

