Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68F7580EEF
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 10:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbiGZI1k (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 04:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiGZI1i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 04:27:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F012FFFC
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y24so12671770plh.7
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wH9rAtH2U01Aq3S/XuM7/wflzikjjWxl/tkad6WUtq4=;
        b=TTKBIz2QQKuLfo/rgS5+0zIp89ILR0vCzYLW3Bp/4WZ+juDGxvzNwVdFfpC2+rBUTM
         iEw0SVgMbq2sP9B+uuFn3aZe6dy55x9BNVq5Vd4SPHP28X6M6jTv14QINR8DSIKMJ0me
         yYx4rdC6vOLEcWXcGW8jn+hkrOF8e5UFatjYOrZ0D57BNY7wNDk6yPRijHz33XBuZb8x
         Hu3STIkODqZxZp6u0i8KIL2Ou6D6vDmIIcLrZqYiQiqWtaHcY7K34PCbEsy27ycE3/FY
         oVdl0TxqWC58QOjreBoUTr760JI72QuHZABqYdXZS32uFumi/XwJq/S9p5hjE32aYQd1
         njPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wH9rAtH2U01Aq3S/XuM7/wflzikjjWxl/tkad6WUtq4=;
        b=YpygO2fVFF7lQ1YUOTC1ap1NmIfH6BfyhupWiZCR7L6PtcUUKZALRe3BdVGJmrXG7d
         Ya//YVB6ymZWoISYeC+MhMwBwRE3DTb9YirSzP6dGdbheijWWg3nAWJeK4rcd4iI+/y5
         ymKbFS0glD5FnmOsaa0aLfmp/mlDQ5PGerlMNTakOwc6gfy+BuVphDEIPh1dmhLsSb5a
         CF+Pj6xoy3Hg16YGs5kb79iGO4YEwzSCvpl9GtAPpljqvIFXQViUGLgnD2gqcMAaVJq9
         nHxDRxwLSOxfK+Vx/7TN5puHTlUFVZLXHN4quDH78mK4rxOX/kgX4urJ7cDku8dLbGNq
         Srag==
X-Gm-Message-State: AJIora/HIe1QGw5XKki+QFZ2SCOlZ7bsWeHNSdy0l6x3o4NCsiHy27To
        55TNUtnrwecbOtsz6kdLtzTLLlKY13VC8w==
X-Google-Smtp-Source: AGRyM1saTLq4QgVuFVyCWSzVeV/8wJzj8LQzNBzIRAefSdP3kjqCuswkW3Olegf0c/+PG527ve+flw==
X-Received: by 2002:a17:90b:3c44:b0:1f2:4e5d:506f with SMTP id pm4-20020a17090b3c4400b001f24e5d506fmr21125966pjb.200.1658824056843;
        Tue, 26 Jul 2022 01:27:36 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e1d100b0016bf10203d9sm10689751pla.144.2022.07.26.01.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 01:27:36 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 10/10] can: etas_es58x: remove DRV_VERSION
Date:   Tue, 26 Jul 2022 17:27:07 +0900
Message-Id: <20220726082707.58758-11-mailhol.vincent@wanadoo.fr>
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
index ade0a650e0ed..c22e989d42ff 100644
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
 
 #define ES58X_VENDOR_ID 0x108C
@@ -2180,9 +2178,8 @@ static struct es58x_device *es58x_init_es58x_dev(struct usb_interface *intf,
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

