Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E9D57FFDA
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiGYNcf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiGYNce (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:32:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F0DDF7E
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ku18so10482122pjb.2
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fTa7OsMXcYPDCK9jKiHBhfkvwsCQRjXn4io9LECecbQ=;
        b=RfCbuuvmrijKOIZftF73BuF+6wOyLVAQy0khb3qK3YXNxn/17dI0MQdjbkQa1oZUkK
         FaLpu/JwD96z+y7cleE1G1TskneGPeMpwmla7ffDIgCQKiXU+ydGUrKL80/pPyCgwHeN
         wcwIsObWtIYiP16us1nQzgkT+Ctn3rpdMefYGDwpF0h75QEK/x+pvHDbCeg6jxQFc+AE
         aQd5ESRLjG1SS+CBZHkYIGaNNvHHfJQwA3ZTzAJCQeXchPEZawmfjJc+h6/MKPnwQMwp
         +xyGfdjJ0HQ0PsN3i9fM1cgOezOx0k6Fwg6eimqr2SbyjwG4p4zCDnmb8WN6zz2OBJwn
         E8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fTa7OsMXcYPDCK9jKiHBhfkvwsCQRjXn4io9LECecbQ=;
        b=Y0O3wHZxVZpZm3IrpY60LoNSVk5WjHvlwOQ5EvnLT85EPK84NXCmBGgcJX7KS7KgkW
         abOVFBJSlaWmUFi/zn8vktm/jJC+V4kqFwCNLIZWcRnndL3RTkHkoyw4ywmZASjHb5xB
         1YIwdiUBIPLIp9fYVBixRJYT7SV7yefNezoDYqkGcHDpr1lL70qr3W4ptLUkPkGhVby1
         SratTiSr2BGpVJ0rOQDLZ2bexRJwuFBG0TcmAVgRwx4Kh60BtaxQZRf4Yo/NAaCnRw3m
         zx+RObJJmrs9Ehw3UvXOUhw0r1TxU3hWCH1EZUuKw6qsoAaNfz2aaumMkb8Wic6FrriI
         L/3g==
X-Gm-Message-State: AJIora9QTRrk8OxDan/rDlUv/27LoBzNitqHXYf9QrZCp4SviFb90XzR
        4NHyNAam8auKLu2wHrEd4B+j7koQ+68VSw==
X-Google-Smtp-Source: AGRyM1uNeb7rcq5hLIFMTi3HG4netLMDPhiuycz4CdQVJcH7OTm3U3hSrGEutjkZRo7n+tIzo0A+fg==
X-Received: by 2002:a17:903:1209:b0:16c:ece7:f68b with SMTP id l9-20020a170903120900b0016cece7f68bmr12305252plh.112.1658755952623;
        Mon, 25 Jul 2022 06:32:32 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:32 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 02/24] can: ems_ubs: use KBUILD_MODNAME instead of hard coded name
Date:   Mon, 25 Jul 2022 22:31:46 +0900
Message-Id: <20220725133208.432176-3-mailhol.vincent@wanadoo.fr>
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

The driver uses the string "ems_usb" to populate usb_driver::name and
can_bittiming_const::name. KBUILD_MODNAME also evaluates to
"ems_ubs". Use KBUILD_MODNAME and get rid on the hardcoded string
names.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/ems_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index bbec3311d893..89a64e05cbd7 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -880,7 +880,7 @@ static const struct net_device_ops ems_usb_netdev_ops = {
 };
 
 static const struct can_bittiming_const ems_usb_bittiming_const = {
-	.name = "ems_usb",
+	.name = KBUILD_NAME,
 	.tseg1_min = 1,
 	.tseg1_max = 16,
 	.tseg2_min = 1,
@@ -1074,7 +1074,7 @@ static void ems_usb_disconnect(struct usb_interface *intf)
 
 /* usb specific object needed to register this driver with the usb subsystem */
 static struct usb_driver ems_usb_driver = {
-	.name = "ems_usb",
+	.name = KBUILD_NAME,
 	.probe = ems_usb_probe,
 	.disconnect = ems_usb_disconnect,
 	.id_table = ems_usb_table,
-- 
2.35.1

