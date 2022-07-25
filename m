Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3480B5801E8
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiGYPcJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiGYPcJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:32:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB5060D2
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l14-20020a17090a72ce00b001f20ed3c55dso10592982pjk.5
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fTa7OsMXcYPDCK9jKiHBhfkvwsCQRjXn4io9LECecbQ=;
        b=CMitsUt5YB92aAbnHSqfjQi6pNAulJ+bo2/n01dMft16X4d+neDtIeOOUTmfi+lhe9
         vwhXrw0eaKNRyi4S7CttSNbJ7Qw2Y9AvfANMqJcb6MeDMF2r2HNH1tVeyGi4D/dRSwV2
         ba2cCGNwobX7eda6JKafovt++ayrRFYbdZkt6FqkGGwxc9yc5CGdT7TcSW7mgXgTpem1
         NQRGMoqYimWCcVBXVbMTU4zUBnEjctqNEBKgedLWtv0prR4r/CM8LV0pypevtuq26Ffx
         2yYms/BkTp7RqGIgU7OKnQAo9iXv0rOBTxIGOAuZbeUtvovG0J2LD2WDw1D1EHx0HHkc
         ngIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fTa7OsMXcYPDCK9jKiHBhfkvwsCQRjXn4io9LECecbQ=;
        b=iyj+ytyiSReOAIItIOKsj9QOTbI83RTAhcp8IrNXLKKcrwVU8B6fEuXHLKPWYV2MVn
         d0cvfefiepSOQMg2Ct7C33FZAXNhpxLsT/W9W4U9m5n0BV8FXpgN3I5TsFIkIe86uycR
         ptxj2YEVFyW8AfGnnBDw22b6lOhuKnNTwNmANLDPHuxhInrd0T1FhiqqqqwIzUU1wJZF
         xvv5VGFMw+Un9A+lHZN641zjYasExqskBBm3+FPD8xKWfc80fM9RwP7RU03dYtD2nY40
         vqgqssVQvrB7P36INGcB78oBdP5utd0tBSyMHN1mOAtJyRCmStlX37vPzSu9X398RDyR
         rnAw==
X-Gm-Message-State: AJIora8gww3IaLZQ1brzDzQGc8Akb9Zr67NGOjUxRxR3VHeYG0vAe5Bz
        xrkj88AISpIQv2w7G8pEZvf5EJSLOVKV9Q==
X-Google-Smtp-Source: AGRyM1t2B6hvzTC93tI+G0y6uagpdbfBhduKUOwPGhuZDHaWFOb0aJjV9iQKZyAhRoqvD5oOszU+RQ==
X-Received: by 2002:a17:90a:5e0f:b0:1f2:2a36:d593 with SMTP id w15-20020a17090a5e0f00b001f22a36d593mr15418631pjf.232.1658763127539;
        Mon, 25 Jul 2022 08:32:07 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id m1-20020a62a201000000b005289ef6db79sm9745477pff.32.2022.07.25.08.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:32:07 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 2/9] can: ems_ubs: use KBUILD_MODNAME instead of hard coded name
Date:   Tue, 26 Jul 2022 00:31:17 +0900
Message-Id: <20220725153124.467061-3-mailhol.vincent@wanadoo.fr>
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

