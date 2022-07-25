Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9155801EE
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiGYPcU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiGYPcS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:32:18 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A3660D2
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b133so10763302pfb.6
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=md0tQsL1ZNHQ4M3Zn4NDjT9DmJPbncdatH5dXgV1S4Q=;
        b=WLP6INDnPbhCMR5BwKKna7u2MqFCXRHyZt6f+oOYcruiE5/IDw5YOBZ8ja6xEQqod1
         zx8R8Skt1n8R3hnLlKhGKRVgsx6fZDOWLwIzQ+SYx+HvTa+r/zO2ZAfYM6Mvd1pGlMIb
         M1SYrGtOc2VYWX0flQoAVwHaXC+rd7RVim8v8aWXGo7dDE5vzJUqVMxhIVwMghWBLQPj
         fQY4pnG41E0hBURnUZ4W8fBMvJt2rQjInoD24ogkpNg+0GqOBLz5xi+Icy4l5/DumYgl
         YYOBORkUI5fPiBAm+iNPRGyIGzz9Y0G2MyTQpB8HGSx+6+urY1IzYYeri0ibQvt0FUeG
         iC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=md0tQsL1ZNHQ4M3Zn4NDjT9DmJPbncdatH5dXgV1S4Q=;
        b=2fymaDvA1MxNa+gXVm+olzY2yy4XwGGg6uKV0nLhXetSdet+VulA6TYIczlAkLr9/w
         LVN/4RouFfPr1Sb662lQy+3lsWwbAaswPx8T0ry+rxP3t3udXOl3EUJ/3bY5KCzFghpW
         zO33aaHMrZMmPPVmoMpIoAMTTdzU46md6dsjllhKBT1YEYhpJMfs/qg4ChV2+xA+qPj+
         NQMwLNp7Ks6NHpt4QEoPatlurFbTo2+9xSDT6MM3galc2qAk5285m90mCJImIKGH1Mgw
         uxEXedQvFMj3xT5e2069XWURdkiFrhJbSHDqVc4MS2r81EnNe5vvx5WZhZub506FEg5Z
         0n+Q==
X-Gm-Message-State: AJIora8XUmMJrtVvuQBn37E+bl5XR5NtFkjmIshEoAsbhoekmzHuWp9/
        A8Nz7vhposQRQ4otSzw7QUfiOR4jM4F6gQ==
X-Google-Smtp-Source: AGRyM1sUxLvaa0jb1JsKU+Gc3jlGkFBsd1Kqsh4Upn/asz7YKY/dRL4oB/gTr2v7FyuJ2Clli+t0fQ==
X-Received: by 2002:a65:6bc8:0:b0:412:9b2c:1700 with SMTP id e8-20020a656bc8000000b004129b2c1700mr11434635pgw.8.1658763137872;
        Mon, 25 Jul 2022 08:32:17 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id m1-20020a62a201000000b005289ef6db79sm9745477pff.32.2022.07.25.08.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:32:17 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 8/9] can: ubs_8dev: use KBUILD_MODNAME instead of hard coded name
Date:   Tue, 26 Jul 2022 00:31:23 +0900
Message-Id: <20220725153124.467061-9-mailhol.vincent@wanadoo.fr>
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

The driver uses the string "usb_8dev" to populate usb_driver::name and
can_bittiming_const::name. KBUILD_MODNAME also evaluates to
"ubs_8dev". Use KBUILD_MODNAME and get rid on the hardcoded string
names.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/usb_8dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index 8b7cd69e20b0..6665a66745a7 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -871,7 +871,7 @@ static const struct net_device_ops usb_8dev_netdev_ops = {
 };
 
 static const struct can_bittiming_const usb_8dev_bittiming_const = {
-	.name = "usb_8dev",
+	.name = KBUILD_MODNAME,
 	.tseg1_min = 1,
 	.tseg1_max = 16,
 	.tseg2_min = 1,
@@ -997,7 +997,7 @@ static void usb_8dev_disconnect(struct usb_interface *intf)
 }
 
 static struct usb_driver usb_8dev_driver = {
-	.name =		"usb_8dev",
+	.name =		KBUILD_MODNAME,
 	.probe =	usb_8dev_probe,
 	.disconnect =	usb_8dev_disconnect,
 	.id_table =	usb_8dev_table,
-- 
2.35.1

