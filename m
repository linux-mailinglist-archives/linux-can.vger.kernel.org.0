Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1980580EEC
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 10:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiGZI1h (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 04:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbiGZI1d (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 04:27:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0E72FFE6
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t3-20020a17090a3b4300b001f21eb7e8b0so16046458pjf.1
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NZ657CGWhRGzNIz3aWfBPsO4WqFClMw9m0RrHHpcNDE=;
        b=Ldl48SCJGOBxWCB3zPWyGwFMAXPMLQEQpWMp9AfcuT2qEq0K6N6+0V3RcUQiSSenW7
         9G1s1p1A8qRqM058AQygdCM5k0Fp+DVkEMs6v65f4cI7qFx4OkcDBHG8uMdMDDzEys3L
         0SBvc2iNGniQND3kBEmmjO/4OrQuoTpNZSb4cOIHFiCRI9bcqHjKDk5J6Y7gYkCAgHaL
         5aJGSjZ8M+9f6SKZiSgcwnGE+KjSJYDCnsptZgUxHB0l9UYbVJLchIyYt59DzMFgK4nf
         zbMExHP8BYEv5Fg0woz/VtVdXkbmLxkw2BKyV+kdT4EqmSy5FTiHkmCM5h8GlsRwBtYB
         bUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NZ657CGWhRGzNIz3aWfBPsO4WqFClMw9m0RrHHpcNDE=;
        b=seTTiK/06nnHECkKRaXrx7w2guTv254K+Imkf1y8rxnAaEKbCLmW0ttpEX4K9rc7/r
         dHLMbzEeeogPdlrdDcEu5UBlDAK7EJoylqh//YEf9NhGoEs3AqpY6KtDeyRsGGNvpfNy
         sFyFAlWROrVwLLHfku2RbLxSyEsaTr80dGTOyKuDH/4SQ5229JrpcPMUR8SFu115fV6W
         mY3hy6a0sj2v6oZY40AlDB9RRmpFeh82FXgMDYdLAGsKsADhmhwAVRXcbOH5YvlCkTXi
         Ixbq8b6m3K2l17N6bvzt5XHVSu0E0d6fxwbBe2uI69l5mqbRwKlwJOsTEo4fBdX2UpXn
         7foA==
X-Gm-Message-State: AJIora+AV3joMwGuy0poRUzPxjh6qfEr/M0RFLwkreXnvi3D2METwoOB
        fjLYyFoGiBq9hrU1wSI0UYcbbApcY+2piQ==
X-Google-Smtp-Source: AGRyM1tpq5zxwo8U/dnBy5OdOMZdPfzXYnLXq5YCWElIHbNyPRtzkaNwF4/8cS0RlWadkuoTRL+Fmw==
X-Received: by 2002:a17:90b:3b90:b0:1ef:eb4a:fbd with SMTP id pc16-20020a17090b3b9000b001efeb4a0fbdmr18660081pjb.2.1658824051809;
        Tue, 26 Jul 2022 01:27:31 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e1d100b0016bf10203d9sm10689751pla.144.2022.07.26.01.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 01:27:31 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 07/10] can: kvaser_usb: use KBUILD_MODNAME instead of hard coded names
Date:   Tue, 26 Jul 2022 17:27:04 +0900
Message-Id: <20220726082707.58758-8-mailhol.vincent@wanadoo.fr>
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

The driver uses the string "kvaser_usb" to populate
usb_driver::name. KBUILD_MODNAME also evaluates to "kvaser_ubs". Use
KBUILD_MODNAME and get rid on the hardcoded string names.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index f211bfcb1d97..ce60b16ac8ee 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -869,7 +869,7 @@ static void kvaser_usb_disconnect(struct usb_interface *intf)
 }
 
 static struct usb_driver kvaser_usb_driver = {
-	.name = "kvaser_usb",
+	.name = KBUILD_MODNAME,
 	.probe = kvaser_usb_probe,
 	.disconnect = kvaser_usb_disconnect,
 	.id_table = kvaser_usb_table,
-- 
2.35.1

