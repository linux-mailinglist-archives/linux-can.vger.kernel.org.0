Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBE45801ED
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbiGYPcS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiGYPcR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:32:17 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4101B4A3
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:16 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 6so10650658pgb.13
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KFb+Lxn2QAveZvycS7BVRM08wBe518/EAzYNsl0q83M=;
        b=Jrq+rUCdhVN67K0wUD4ePY0kAUnw32R1/1USq7u4yAeM0++CLotEqdI5Kh1dfvexw4
         NyPD44MGbPaLvjI431EkNr2YrdYTHBCcMrUeClnPB9ViOKWTQ/He+4ai5uGtGt7tTvxk
         3lSR7o5FLodmXloXBohoMh5xX0PLY+ldNGg8mFIjqwWQzb0Tj5rFrWvisc6btVs2y/jy
         SzeDMVYESOOXv86ru+ZWHUEvseONiPcM12TP8/3vXddJEQNzyYZaIzo5flCLFjXCa7W0
         4WWBZotNeNjM4X84OOq0ghJPzILIsJAR3ajmATFqh6TcN8NXrA1RoQYhEb3XVVShBxNa
         qpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KFb+Lxn2QAveZvycS7BVRM08wBe518/EAzYNsl0q83M=;
        b=Y/pz85+Jsc2hMunG3QVv2ES3FA2HSNaxRa2M4rymcgigsXlgwlr2JXJz9SCTx7I91p
         g8NbOCTDCAMT21oE7x6vAFZLt8UpP5xBv6MdZX9wzaEB/phtDxItbi78jInnemYN/jQI
         0ISs9ETiabQP4BKkOBa5zNwZ9IM4X8Hy2ejpVu1M2w+hdzQWWGX3G0v4uZJPsmh5e2xN
         8gd0dygQGhrFgUYUICNuzGpdWVCQ2henN7lQEOs90L0vv/r40DZHOYFF0sx0n8K0BXce
         QLV/kPJ955NU42y/r7Mkwx4p0xgUaq/d1IU3ZYPPlEkslEL9a2McujG5R5ql2TGq78CD
         Nb4g==
X-Gm-Message-State: AJIora+lzMBgE3FQv1RWTPn8B93nBauSUWNW/1mzb94RBaMFQvECIL74
        lgWcUym1cJRwFPNIR2nOcnF/a8mslriZpQ==
X-Google-Smtp-Source: AGRyM1tbulGQdc2a9KI9uvBLzg0KiJWE6gim0tOPOJBsvMXCqBUWHfxZn1eg/4qDm4awL/8AZv03XQ==
X-Received: by 2002:aa7:8318:0:b0:528:c331:e576 with SMTP id bk24-20020aa78318000000b00528c331e576mr13563892pfb.58.1658763136174;
        Mon, 25 Jul 2022 08:32:16 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id m1-20020a62a201000000b005289ef6db79sm9745477pff.32.2022.07.25.08.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:32:15 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 7/9] can: softing: add DRV_NAME to replace hardcoded names
Date:   Tue, 26 Jul 2022 00:31:22 +0900
Message-Id: <20220725153124.467061-8-mailhol.vincent@wanadoo.fr>
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

The driver uses the string "kvaser_usb" to populate
usb_driver::name. Add a new macro DRV_NAME which evaluates to
"ems_ubs" and then use DRV_NAME and to get rid on the hardcoded string
names.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index f211bfcb1d97..a6cff8da5a41 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -29,6 +29,8 @@
 
 #include "kvaser_usb.h"
 
+#define DRV_NAME "kvaser_usb"
+
 /* Kvaser USB vendor id. */
 #define KVASER_VENDOR_ID			0x0bfd
 
@@ -869,7 +871,7 @@ static void kvaser_usb_disconnect(struct usb_interface *intf)
 }
 
 static struct usb_driver kvaser_usb_driver = {
-	.name = "kvaser_usb",
+	.name = DRV_NAME,
 	.probe = kvaser_usb_probe,
 	.disconnect = kvaser_usb_disconnect,
 	.id_table = kvaser_usb_table,
-- 
2.35.1

