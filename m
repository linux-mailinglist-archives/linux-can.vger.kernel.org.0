Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56066580EED
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 10:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbiGZI1i (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 04:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiGZI1e (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 04:27:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2467E2FFE9
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b9so12620760pfp.10
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=md0tQsL1ZNHQ4M3Zn4NDjT9DmJPbncdatH5dXgV1S4Q=;
        b=TDAHLTbDqPqa9rFt9e25+Eqd6HYjLpE/MTGHltVBzx9AWz2ZZQ3vRLUhFs4RxZN2hW
         l00pojkqiM+K6FTJh8R1p2eMF30Kw5Nvy2c0KBuSh/us6hqwHYeQP5vLh6XX2+MtX9Wy
         sQK2qDCP9eTVEbyuUcUG0xfqG70wN1/VEbiWTTInQIlh5tVKgrtj7C7nS9F24MNwbHl9
         yp+2XwkSVeEGrkSM9Gp1TYEGvC0jmvxx9NxVjsv9B1lIqMbuLhydUxKA8VEVci8TJbin
         7gRFF3/bzp7eYCAoNL6iar3XMVZ0qI8pEJoZRyAWMa3YBxy+FtfUMj/BRFPEVGk4Dxgc
         nQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=md0tQsL1ZNHQ4M3Zn4NDjT9DmJPbncdatH5dXgV1S4Q=;
        b=RIjFeA6LFGgnVXHGKrjG21tC5wpaNG/SD20r3BL2hFyOXMSH59CO34Y7v+genGgHz0
         dl5fC4N8aHMpZYBxmBpcapR6ho0iGcQsPqj+G0BRP7bnC0iKEFiznV3sAxWWwk+nGf4C
         dDZQbhIBxSbqhU4laPFVZmAYh2YCEQ0zYCpKNfhfwrkJtITG/+e/ipmP2XfMX6pFAmbm
         lRgHgE65O5yNtlSR2kfsAMShrKaCBzZ4Mtmi+qifH5twzLdkgg30Km4i3IXKV8PzgoQ9
         LZZdzmHjCVRqkw1xuYKm5D1XwzF8L6z05WzsUS5Mg0S+WlD108Qgfc/Oga6Q9qh6Ignn
         9UHQ==
X-Gm-Message-State: AJIora9zK+NggQFZKrGcM81wWuHnm4pLYg4V77/oAtyBkEnKN53VT6w6
        EnwUtxKxWkZn1BA9nsAlKskUs37fNxq5Nw==
X-Google-Smtp-Source: AGRyM1tlW+11teQQQ+lUQIiXsveD9sEc5d7Xlwz9/ENdiGvAI5VyaTXnZijd+6ninQh6ypQULi/S+A==
X-Received: by 2002:a63:86c2:0:b0:415:cb:e12 with SMTP id x185-20020a6386c2000000b0041500cb0e12mr14172225pgd.144.1658824053441;
        Tue, 26 Jul 2022 01:27:33 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e1d100b0016bf10203d9sm10689751pla.144.2022.07.26.01.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 01:27:33 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 08/10] can: ubs_8dev: use KBUILD_MODNAME instead of hard coded names
Date:   Tue, 26 Jul 2022 17:27:05 +0900
Message-Id: <20220726082707.58758-9-mailhol.vincent@wanadoo.fr>
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

