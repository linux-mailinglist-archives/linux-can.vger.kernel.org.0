Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CC15801EF
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiGYPcW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiGYPcV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:32:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F85FB4A3
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y15so10708537plp.10
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eiSy0bY0fVZv6nkBrpDYPylvmztj2ygYvbb0kfDadlI=;
        b=gZa0vWX5j5ImtNy4QJjNA1o0NFKVm+SMEKVuh0oWVc/d/oVEeiS7NCzwpaO4yQhyAX
         sDxDivKRyiaYauCc9+UZEtFL0RG7t1Suu68swMtAw2XaBUR1jUg037Cci1hl7YgFMOSu
         aw0fzAdvodYcJ9ozTzWsBsOs+S3vHXQ88hbNs3gmF+O0InuvEKgcGUXOyKkucPetv5/8
         GSvTb8C19iamymNvMmJyQK/wWh+rOiNpuASphdVp8NuTH/Qkad74RsXaWmNRypvkiCYZ
         uSaiGqN3fp6iAHm22mlQCqEjuDMMUpIqVOjcotteHu2TcoeyqcUsSAMwCdSDM+HKXLi+
         H+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eiSy0bY0fVZv6nkBrpDYPylvmztj2ygYvbb0kfDadlI=;
        b=MwuDiaMDs/ZHEX10KZRM8x/zAyqPU/Ah2w8HNoPwe1L4LExkldv8WAEl1fQTJ7bnOk
         AJEmZEjQTy7AJGqNQFk2WfqcUowtOMJnkFNQgQp6hROwIVqtOJd7vc9uHyMl88yym7lr
         rJibdCpAhRT6rQ7RhYCWHo2G0GB+Rn0aBARWRW4ooR8DYs+YERcyQUADlcNp9sbQUf0V
         7Zm4VMVP2pXmhYR1IgHAZQqtipPN+70GUmOoA9ce66OSb+pwIb9Hn24LWzPuEmiQsXJ8
         f+IFsFvQh1znWffafaFD6d844QPvCS5iryXwSjuRy3YqcGAEfii9Kc3XRW1tJN2QSFhP
         JKDg==
X-Gm-Message-State: AJIora83Yw4OjEUHda9LjXi1C0OOiPioN8UIImu6kQ4mifQooi+XnWCS
        B8We3wRMiA8pCKmpQbHHxk7/lbUGqT74+w==
X-Google-Smtp-Source: AGRyM1sdl0Nm4hAYHsriLptl3doZR6KVO583sYYl4ZlsaM5yYtz9wQf8ypu+RHdABekcaKNYY2ft9g==
X-Received: by 2002:a17:903:1c4:b0:16c:4e45:38a3 with SMTP id e4-20020a17090301c400b0016c4e4538a3mr12425629plh.41.1658763139524;
        Mon, 25 Jul 2022 08:32:19 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id m1-20020a62a201000000b005289ef6db79sm9745477pff.32.2022.07.25.08.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:32:19 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 9/9] can: etas_es58x: remove DRV_VERSION
Date:   Tue, 26 Jul 2022 00:31:24 +0900
Message-Id: <20220725153124.467061-10-mailhol.vincent@wanadoo.fr>
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

