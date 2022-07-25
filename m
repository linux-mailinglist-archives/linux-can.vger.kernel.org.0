Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4838257FFE2
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiGYNcq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbiGYNcn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:32:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB5713DFF
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so10323204pjl.0
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANLQk4vxgJewmU0Z6/bajjUaSU7cB9OV1gijaGMAOOg=;
        b=SUJBEl/LPOhzRs7aXlNqzwBoNxTkVxomwj1Ixx9C4nFc8aRcHZIQ1NYbnZmK1XtNd/
         53RPIcWhmccg89aSWUBYgh5Q2BkjSNrDIqJ88Sjj/E9ti9ZmBJ9cTZqHl6jFmbh4YIhn
         GH6lPKTXUfmqaSMHPktEmaAidN02CqcL6cg8+baLH3fIgJO8vnll/sFixvL0L00J32K0
         8EhWr3/PRx74aOSf3k51I/7BV3H99i3uMgEdUGmBLLVP3OnpI5IYqXwYi9kA2X5OxOAh
         lGubC4P4/H3rfdQXrcxYT8kdQBdokZwVh732zpw/MSPiFg7H4+0KJuDpS3594yg+Jk48
         uq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ANLQk4vxgJewmU0Z6/bajjUaSU7cB9OV1gijaGMAOOg=;
        b=agtbb3szm/KUKgi9BeXiNe+JdoKoE8yiMsWhxaupu3CsagtNIQJCkXCvocuUvCCYf8
         2jmeZzrpR5DJsWI85/ROZnxMut5WVOAp375ns2cIj3MMVZMGlIxeBso29Jy7apRDBnyO
         tgsGQ3Yk8eECWG019oKTf39575w8rv1dCnXoaljiD/jZfvVWpuMAdVcIyQRbHTre3kmr
         osRbWSmA1WCiR4TORD7Urv7r2mVXTrV+qS0cVqJinAQc3wMLgmXG04+lycdehAl3cg5s
         kTteARE14aqXyV6WGQZPKSyJxHe+/BXL3tfIYAFpZkYZf4NpvxoPRP/qz29U8YCKwQCr
         f2Xg==
X-Gm-Message-State: AJIora/ysl6d8uJhviXzT2UFbGmKiBachaaiLWegDi29wjABexL2/QOh
        e9NqNw2Igl0DPL48OXsqMihLatPt6LDQ1Q==
X-Google-Smtp-Source: AGRyM1u0Tp9afPsYL1Bx05jCPIkC24F799tPbYmpvg0O3wjRdf/EpkdonTJBAB4xmpBNoqDBUI4uiA==
X-Received: by 2002:a17:90a:ce0c:b0:1f2:72eb:4d11 with SMTP id f12-20020a17090ace0c00b001f272eb4d11mr12505576pju.93.1658755959376;
        Mon, 25 Jul 2022 06:32:39 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:39 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Frank Jungclaus <frank.jungclaus@esd.eu>
Subject: [PATCH v1 05/24] can: esd_usb: use KBUILD_MODNAME instead of hard coded name
Date:   Mon, 25 Jul 2022 22:31:49 +0900
Message-Id: <20220725133208.432176-6-mailhol.vincent@wanadoo.fr>
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

