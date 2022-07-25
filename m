Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF155801EB
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiGYPcP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiGYPcP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:32:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD4ECE35
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id o12so10737699pfp.5
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANLQk4vxgJewmU0Z6/bajjUaSU7cB9OV1gijaGMAOOg=;
        b=MUhz4j5XzeZDFyUAeHLjcGxchoJIwoyajKFJ5cOz/xRsn9eVPMjvzLlnCpokZbAsxK
         rla6/iX7Dlbr3w2XPQh9xiTnuP7W8frHN1h5P72j166zf9k/95/8D724VnO+gjIGKmQu
         YUsFQiBdfnSlRWGYP8SW1nLdEuwvQPVg4SX03uar/gSkcQjXyXjXEqGRvtKQegoM67GT
         FFMOaqXThvmYDmCyUREsMcQ3dA4rHk1HGSWPGABl/mhAZQRpgNPtQksW76qBcuZApQw4
         XdG3NeM36k6e96GIiIXTIiP7S0ZnbIQUgmPLfIQMwOAJPWWehXHLDGyUbpZPJZa83rAq
         LbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ANLQk4vxgJewmU0Z6/bajjUaSU7cB9OV1gijaGMAOOg=;
        b=7HszKKd7QhM3GkJKD7BjX/OwWFlvLydpgb1EaYpKIEeba8txAdvneYZAx4n4DA0mVn
         eXkK/VAWkosa490QPspfvX4jhh9dbrKbkIT+tullwVmOj+MsiQw6tF/1XxqZOzg+LCCc
         BskK88im2MN1d8E5tGom/guwqlUeHXchszvg4XgIYxTg/XZtKgGCYTvMZZ2kca9ntjCa
         Hm8GT2h6lAABkRGUGa0McJcgGN5nh30VNwRcYAYo2vR9ykfthnZhMnCpVQnnD2E8C41I
         I0lkaQjvzbORaayzjPLzs8qUHBeX/JRpY5ujiGzUHlHxfMLS25tfRNc1WWCBuW5l6e2g
         dqIw==
X-Gm-Message-State: AJIora85b6RSHwjkyPbDRox2M+eXgK01Mcl2bd2Rtx9Eg05Yu60nqBI+
        z6vbwnKIKAhJqekKBhFQymmAoSzinbgE7w==
X-Google-Smtp-Source: AGRyM1udEb6IeAR8UmYKzYxFLQrEPmadD8glLqY6po8PfnXMusPf8ahUFMVg6fOEiweJNh46ydGb9Q==
X-Received: by 2002:a63:31d3:0:b0:412:a9d9:d407 with SMTP id x202-20020a6331d3000000b00412a9d9d407mr11459254pgx.479.1658763132776;
        Mon, 25 Jul 2022 08:32:12 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id m1-20020a62a201000000b005289ef6db79sm9745477pff.32.2022.07.25.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:32:12 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Frank Jungclaus <frank.jungclaus@esd.eu>
Subject: [PATCH 5/9] can: esd_usb: use KBUILD_MODNAME instead of hard coded name
Date:   Tue, 26 Jul 2022 00:31:20 +0900
Message-Id: <20220725153124.467061-6-mailhol.vincent@wanadoo.fr>
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

The driver uses the string "ems_usb" to populate
usb_driver::name. KBUILD_MODNAME also evaluates to "esd_ubs". Use
KBUILD_MODNAME and get rid on the hardcoded string names.

CC: Frank Jungclaus <frank.jungclaus@esd.eu>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/ems_usb.c | 4 ++--
 drivers/net/can/usb/esd_usb.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 89a64e05cbd7..e86a2033db60 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -880,7 +880,7 @@ static const struct net_device_ops ems_usb_netdev_ops = {
 };
 
 static const struct can_bittiming_const ems_usb_bittiming_const = {
-	.name = KBUILD_NAME,
+	.name = KBUILD_MODNAME,
 	.tseg1_min = 1,
 	.tseg1_max = 16,
 	.tseg2_min = 1,
@@ -1074,7 +1074,7 @@ static void ems_usb_disconnect(struct usb_interface *intf)
 
 /* usb specific object needed to register this driver with the usb subsystem */
 static struct usb_driver ems_usb_driver = {
-	.name = KBUILD_NAME,
+	.name = KBUILD_MODNAME,
 	.probe = ems_usb_probe,
 	.disconnect = ems_usb_disconnect,
 	.id_table = ems_usb_table,
diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 177ed33e08d9..7b849bd3cc9c 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -1138,7 +1138,7 @@ static void esd_usb_disconnect(struct usb_interface *intf)
 
 /* usb specific object needed to register this driver with the usb subsystem */
 static struct usb_driver esd_usb_driver = {
-	.name = "esd_usb",
+	.name = KBUILD_MODNAME,
 	.probe = esd_usb_probe,
 	.disconnect = esd_usb_disconnect,
 	.id_table = esd_usb_table,
-- 
2.35.1

