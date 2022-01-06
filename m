Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50825485D2B
	for <lists+linux-can@lfdr.de>; Thu,  6 Jan 2022 01:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343798AbiAFAaX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jan 2022 19:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343870AbiAFAaJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jan 2022 19:30:09 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D029C061245
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 16:30:09 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m13so832282pji.3
        for <linux-can@vger.kernel.org>; Wed, 05 Jan 2022 16:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluerivertech.com; s=google;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=sItKhyjYiBTIjJbWyCsjJdRLFFEaR2+GFLFbvvEQQ8g=;
        b=sXNtGJJAQGNGLYM3ZJbRzUrX2NXrOAoLBfdN4Zp/iPp+uusm2oqybEc5NfQC0PYgQB
         969nm4Al16dFnS7Wft0RHUI16jeFwBlHYSb8qqmIvNqghC7HPdYonl/mblupKnoB2B+G
         IEEGJKBhKx5I9IkutugK1JWF5SG9EAGZ56w/Xyb739WkGNw8CT/tzGwWBq9XWRSTeM8o
         oXeS3kqDTqY66tlG1Mkl4b7HpuFpAyTzIU/DNL/IifBxjlURL8dlUqIRinnQdRXFvuj+
         FXRExsJkRjEkb1FkLxTIYhxVukUdVhjiP9inogL1PaCE7I86KU3lIDFbaHPQFL34fwV8
         bF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=sItKhyjYiBTIjJbWyCsjJdRLFFEaR2+GFLFbvvEQQ8g=;
        b=ikcrF+E3LbSsuqs1EwavCi4ZiB7wkN1ppO1S3fqvIzKYQlNuyeM5flWraVufAv9Ht1
         GkZS0RvRmifIzzBWrHBy4aDa25QsKQZ0x7m5JDjZKGLhlMa52Fbx+6Y9PzgU5H2WlFE4
         p4n3wQkMFM8731uXiuueuxjMgqR14B7ENnYjXlYEfd/yVxbTNcgPWSOcN2eA2JICTppQ
         IWI3fA9brpp9Dv7Ny2lPmSfwpyZG8qGP4If+IfSe5wH489NlxALzm56hyVffQ67jelPl
         397TJPW6FkZzUlQYGnpBYS//mlLCpuApmNpqNsXhV49/qLdpbyM+3vNFcxtLVlyHBlzI
         G2tg==
X-Gm-Message-State: AOAM532FKGFMcbw2Si7WRcafDo1/Veh2as0SRbHfHGo4XseycigAWPa/
        yrC2zbzlZOOvrox4gLjpvB0XMw==
X-Google-Smtp-Source: ABdhPJxTyCrS99bXEs/Aq31tycZyMFH9/2cuo3exypyaTaOHipoMZ+y1Metycy+IFqMStfXLdiR+Rg==
X-Received: by 2002:a17:90b:1c91:: with SMTP id oo17mr7104592pjb.58.1641429009060;
        Wed, 05 Jan 2022 16:30:09 -0800 (PST)
Received: from localhost.localdomain (c-73-231-33-37.hsd1.ca.comcast.net. [73.231.33.37])
        by smtp.gmail.com with ESMTPSA id x19sm162272pgi.19.2022.01.05.16.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 16:30:08 -0800 (PST)
From:   Brian Silverman <brian.silverman@bluerivertech.com>
Cc:     Brian Silverman <bsilver16384@gmail.com>,
        Brian Silverman <brian.silverman@bluerivertech.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org (open list:CAN NETWORK DRIVERS),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] can: gs_usb: Zero-initialize flags
Date:   Wed,  5 Jan 2022 16:29:50 -0800
Message-Id: <20220106002952.25883-1-brian.silverman@bluerivertech.com>
X-Mailer: git-send-email 2.20.1
Reply-To: Brian Silverman <bsilver16384@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

No information is deliberately sent here in host->device communications,
but the open-source candleLight firmware echoes it back, which can
result in the GS_CAN_FLAG_OVERFLOW flag being set and generating
spurious ERRORFRAMEs.

Signed-off-by: Brian Silverman <brian.silverman@bluerivertech.com>
---
 drivers/net/can/usb/gs_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 1b400de00f51..cc4ad8d59bd7 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -507,6 +507,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 
 	hf->echo_id = idx;
 	hf->channel = dev->channel;
+	hf->flags = 0;
 
 	cf = (struct can_frame *)skb->data;
 

base-commit: d2f38a3c6507b2520101f9a3807ed98f1bdc545a
-- 
2.20.1

