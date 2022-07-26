Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C780B580EEA
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 10:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbiGZI1c (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 04:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238312AbiGZI13 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 04:27:29 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFD32FFED
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d7so12667340plr.9
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 01:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjkZySW62O7GBDAAjF2VPjQ6sD39lmfWQbVtFB1ykZU=;
        b=OW5xsH0zEtntpTicFkdLPZpM4xc7b748BXrVaLIAHKZApOsiYEvpgLhue2nYrxjP8h
         f5VuIsJNUNEXDC9D3TpNd/2X1O6tfaO7Qb45RjrHTRWaxR0BaeaHb5qUi1R5XqftRjdf
         DZsL7zJ7MpfjaI6PgUiW32q0zaQiE6v31QyBnWJWk22SXyjI+mgmK3mTt9LkT1x+0IUC
         2V3WqLn2r3Kp6UXm4EF7szKe6vbeBVGgKEkT9VOb/yDRg7dOGfuG88cYGvOf5i4TyZ2H
         yN8kh8FZvIiXbvF0ty0QD9PQ8OcJiXEC2EgzUdXXaXToBq1RA1GrdFpOwjg/jYnQD+yA
         dhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NjkZySW62O7GBDAAjF2VPjQ6sD39lmfWQbVtFB1ykZU=;
        b=LZ1+3AbJqQaRN8H4iWznti00kCdyg/hMInzs1R/WnEKKdM03PrhKiuSPrAb8enBfBr
         XuEpQMz/8LLa3QGsmW/cHNOgo3HgwoFyb/NAJZ/a8H6EL840Cs92xMB3Nzob74w7sEGg
         oa3CHijKHJto32W9mULI+rILvxsiNWDxPKu246bKDbrBK1nIpfs/LmDOV3qATymDNjys
         AjiEmhYxEn8rgp9l6z7gPhBuRZQIX/UnJy/fcXHU9lZQVLYBe+atT11wvRbCkSNgIUed
         Opx+O+NYn2DvJsHhkiCTI64cvQc/MI2zsvU/IzYu79R+Zk+PwKRIg44ddi2kBSy3lkEg
         kS5w==
X-Gm-Message-State: AJIora83NMSCuw/fX1ASvZAVHZyEdFGHw8bZtDyhcQUUbjPbElfJ2duE
        aAMQi4gSCf+oiqjQvhiwEiclPvghwv7JBg==
X-Google-Smtp-Source: AGRyM1uDIhkhYSOTAiCmZIvIJ9czc5Lnui7GZlkYP3oBk1q1rjgD4XBArTSFUctayajp9B4i9gqNAQ==
X-Received: by 2002:a17:90b:180f:b0:1f2:b472:b8d0 with SMTP id lw15-20020a17090b180f00b001f2b472b8d0mr9609073pjb.170.1658824048387;
        Tue, 26 Jul 2022 01:27:28 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e1d100b0016bf10203d9sm10689751pla.144.2022.07.26.01.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 01:27:28 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Frank Jungclaus <frank.jungclaus@esd.eu>
Subject: [PATCH v2 05/10] can: esd_usb: use KBUILD_MODNAME instead of hard coded names
Date:   Tue, 26 Jul 2022 17:27:02 +0900
Message-Id: <20220726082707.58758-6-mailhol.vincent@wanadoo.fr>
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

The driver uses the string "ems_usb" to populate
usb_driver::name. KBUILD_MODNAME also evaluates to "esd_ubs". Use
KBUILD_MODNAME and get rid on the hardcoded string names.

CC: Frank Jungclaus <frank.jungclaus@esd.eu>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/esd_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

