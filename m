Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528FD57FFE7
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiGYNcw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbiGYNct (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:32:49 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C28713DFF
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:47 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d7so10390155plr.9
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=md0tQsL1ZNHQ4M3Zn4NDjT9DmJPbncdatH5dXgV1S4Q=;
        b=ecw/xyDTzwF4bTp52Tpyjg/rCIXF26YdiTQ3aO1qL58mLQ2QSooT0yE0xucBZmiBAx
         55YPyBvGQliR9g8CqftPLpMng+b/9voKUDRm6HzbQELYnnj7TkrW832aK3s/zXCPSR4d
         reZxcB8tu/BIh9l42sQm1v8APDGma6xEwSlus/UZJhLv450PYbPwLsTc6TqRLY+YF+YN
         a1t4KXiwZNlb6d4coVd9tz10N4xfau+3+JiuJ5OM6ZyaHLhDUEHeBm9b7m8VJBZ4ipNc
         Hpsx7xl4719ntduJumvi4WpZBpI6n5ZK8hCKNO3pi4p8gCB8L9P5e2lDotXCqdPhx/UP
         YpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=md0tQsL1ZNHQ4M3Zn4NDjT9DmJPbncdatH5dXgV1S4Q=;
        b=dc7IiiRoGBN/FlTTfJ/7yb2seRnCrbQxYB6Xbl6NO8+uLYuUfYiaO06vHsuhhrmoWc
         401ACZFvNky0vcVuikfH8ngUU3cnjG2myjLtLpPTJChvLXVmp779qcL8jE8T80zE23uV
         Tu43RuRUGgKPhpJDYg/02BZ8RNnSSypt5Qn7E7kV5/zYX3ZN3rMLNEQuHxo6Rnhb0FXD
         FKbo8fRa6MX4IySA7l9o2amCQuCXJNleIV56TMxestMhWeBNirP/gazEPXtRFeJD6i01
         +CpmSNdaqtGjhBT/VkWSHCCJuiKbdAyPqbjRGCGm3ZRFBxkhTeQ8sx5b00MO5qI4WLo7
         rPVw==
X-Gm-Message-State: AJIora8FpSU0cMJuQQI1SbLCJPvIUnwrV8UcadxYCGaMu0Lm8sjHH8OA
        KCaKk0uGBg8ubSdDQW1c0mdiYuT7eNgw7A==
X-Google-Smtp-Source: AGRyM1s+r8vMlGjGrnZdJJqD5GCtWxnrMPky7DNa8QYV6znaUXdbRYrtXmwzfsV0RH412FW69OJ6Dg==
X-Received: by 2002:a17:90b:1d81:b0:1f0:c03a:6500 with SMTP id pf1-20020a17090b1d8100b001f0c03a6500mr32748737pjb.50.1658755966048;
        Mon, 25 Jul 2022 06:32:46 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:32:45 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 08/24] can: ubs_8dev: use KBUILD_MODNAME instead of hard coded name
Date:   Mon, 25 Jul 2022 22:31:52 +0900
Message-Id: <20220725133208.432176-9-mailhol.vincent@wanadoo.fr>
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

