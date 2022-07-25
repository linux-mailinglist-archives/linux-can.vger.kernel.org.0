Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1009D57FFEE
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbiGYNdC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiGYNcy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:32:54 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86A7DE96
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:49 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q16so10386102pgq.6
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eiSy0bY0fVZv6nkBrpDYPylvmztj2ygYvbb0kfDadlI=;
        b=FY510l+mWbkTs/eXWobtrLBomslLVVvxDPmKjtLbo/QopUsgxpNvyv/KGdW2IlrYGY
         2AmAsFrLYR+7AzNPpcvBBY2yfr6GOTIw1x7tn1keTiHjG++KFFaLdvwZNrukgP9Um2yC
         yGq9mvAmvh5qPH3MiS+CIyewjaZsIP4FigMTv9R0iiSReo5rtEHeWLbOJChRtGOWlywt
         uPZn6V+bBmPnXxYnoQxby32Xquw82aB+fpmj0lGKtVFrLXICDZLixDG2XeJQf32LUOcn
         N3AF7EoupaLu8rhw4wxq23UzU5mVJ/Zuc0ScBjDmyp4BbnkYaExpbzy84VIBUgL9X/nw
         Z7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eiSy0bY0fVZv6nkBrpDYPylvmztj2ygYvbb0kfDadlI=;
        b=rbJN2ia2WomT5plYs1N+81GlWre1hSuWxFJ2flfh4BvOygPFt/F3fZN6UKoqF1QhSb
         J0jizy46k13Kw3Gvb01pwf8Wl+PqsGCvaD551DVXVQHZ4F1Zc0nyHZ9OpP1NfinRs2/8
         HL857WLk/BgONboz/b30oN2/FJqU+9N0q5dAGvn2TmaHzmjz1LQ9ByqpUJPGWkDGEBPz
         ph9g3SA32cSBdTXighUsaFclohpNSNUD06OQX1M1hqbpOsWx6hw0NQ/W6nObybLFFpUK
         NYVcOeK/OIEg7/ahbF7GUqLNvojPZDOZICc/NPSyVdJ6a7DxCTHBJZ1HEF0gDmqF5d0H
         jOuw==
X-Gm-Message-State: AJIora8QJmMY1jTPU60Ds15jvjV+cttNP5WyYVs7v2KdhqXIN8Z2TI61
        9AQgusJ0N86GC+FDeXuwU2FGy2Xoysv3hQ==
X-Google-Smtp-Source: AGRyM1sqyHVcD+++7bXwAtogNeNa7amJGjjBdZXSmoxOU4F9HAqwab2R4egVu8e21rPJE/L7f05t/A==
X-Received: by 2002:a05:6a00:2181:b0:51b:560b:dd30 with SMTP id h1-20020a056a00218100b0051b560bdd30mr12963228pfi.44.1658755968268;
        Mon, 25 Jul 2022 06:32:48 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:48 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 09/24] can: etas_es58x: remove DRV_VERSION
Date:   Mon, 25 Jul 2022 22:31:53 +0900
Message-Id: <20220725133208.432176-10-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
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

DRV_VERSION is a leftover from when the driver was an out of tree
module. The driver version was never incremented despite of the
numerous changes made since it was mainstreamed. Keeping an
unmaintained driver version number makes no sense. Remove it and rely
on the kernel version instead.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 7353745f92d7..3f51488bd649 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -18,11 +18,9 @@
 
 #include "es58x_core.h"
 
-#define DRV_VERSION "1.00"
 MODULE_AUTHOR("Vincent Mailhol <mailhol.vincent@wanadoo.fr>");
 MODULE_AUTHOR("Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>");
 MODULE_DESCRIPTION("Socket CAN driver for ETAS ES58X USB adapters");
-MODULE_VERSION(DRV_VERSION);
 MODULE_LICENSE("GPL v2");
 
 #define ES58X_MODULE_NAME "etas_es58x"
@@ -2181,9 +2179,8 @@ static struct es58x_device *es58x_init_es58x_dev(struct usb_interface *intf,
 	struct usb_endpoint_descriptor *ep_in, *ep_out;
 	int ret;
 
-	dev_info(dev,
-		 "Starting %s %s (Serial Number %s) driver version %s\n",
-		 udev->manufacturer, udev->product, udev->serial, DRV_VERSION);
+	dev_info(dev, "Starting %s %s (Serial Number %s)\n",
+		 udev->manufacturer, udev->product, udev->serial);
 
 	ret = usb_find_common_endpoints(intf->cur_altsetting, &ep_in, &ep_out,
 					NULL, NULL);
-- 
2.35.1

