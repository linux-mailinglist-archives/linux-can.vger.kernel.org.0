Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB56057A1FA
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbiGSOkp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 10:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbiGSOkS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 10:40:18 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8FE2706
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j12so12137443plj.8
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7lGPj1IZ4XsbIy/pVjASYgwH8VREWUtoj4U/sQCQ6Uo=;
        b=LZT+0bKrQt+i3q25xyUzydDg/fc2Cu4vKEvq41TJxkppF5sPDmZpJidz+4owTOBApH
         ogyysIiJaMm/S/rmThwo1yzDf1qVb5WGryneagpm2M6CCktK4DLJg+7XryhP96UaqCaJ
         39aYG+cYaRR39VnG7B8NJwKWl32dGGdCk5HSsC0EqEp8DcQ71sZJrLaE/+u8I+Nf/8JJ
         a6h31cm/gTgKwoLJ1dsw9y0f6YqTdVoT/agiBCCmZqbO6hxOLnZZq5ZWnc9+zFZxEY7u
         d2EMZLkgtIhqvby44ed4fltmiOZrzFByTr3HNc3iSxEzj3WmWyH7QA+kbv6lL6/oJpBM
         FDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7lGPj1IZ4XsbIy/pVjASYgwH8VREWUtoj4U/sQCQ6Uo=;
        b=i8wf3jEJHh0Z4zE5wiUBzYgNwn+hi5x/AYUYkDu7vDG//EQqQkrwrnN5k0KTbBdO1X
         flMqVj8D9n0gIPtEpKEW+56zJB7vlGLGsNEGxh6DaBTdRFMo4P4pqOVFYuQej5hCPLqw
         drvx+d8pTgq+hE4mLfTMBMVeEGvsBbkJxYwI8nyrTUGJO1HK7bT1/3dPTVUxTC1MOUMO
         HZ6V1lKwZndjwSg/AMLtpuvaPYC3KOpVjs+A5/zD8ebW+NpPFh3p1CFhU5ypB+vISSYj
         CTksb2MJoyb1NC+RAjLh94N2XbbRZZ+TbuPXzqy3MuHD7NVbqFXFWYlGxug74MDe0gDD
         ydlw==
X-Gm-Message-State: AJIora8Cbr0WgOqmhFiexKdR0K1Y1pN4T5yVkvVzBi/9qk/nKkkcXIXF
        dAuosGXrXapgDlDs52LUU4SzQ1QGZrpKtA==
X-Google-Smtp-Source: AGRyM1sbtKCjt6cPGnobi/A9yjsRM8HCHKY5Hi1kT+PWfgPf7YVKrKjRVCwGvdz8S6yuJSOYgWyvJA==
X-Received: by 2002:a17:90b:4c4b:b0:1f0:21c3:652a with SMTP id np11-20020a17090b4c4b00b001f021c3652amr39187670pjb.231.1658241379546;
        Tue, 19 Jul 2022 07:36:19 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d75-20020a621d4e000000b0052896629f66sm11562516pfd.208.2022.07.19.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:36:19 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 09/12] can: usb_8dev: do not report txerr and rxerr during bus-off
Date:   Tue, 19 Jul 2022 23:35:47 +0900
Message-Id: <20220719143550.3681-10-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220719143550.3681-1-mailhol.vincent@wanadoo.fr>
References: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
 <20220719143550.3681-1-mailhol.vincent@wanadoo.fr>
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

During bus off, the error count is greater than 255 and can not fit in
a u8.

Fixes: 0024d8ad1639 ("can: usb_8dev: Add support for USB2CAN interface from 8 devices")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/usb_8dev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index f3363575bf32..4d38dc90472a 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -438,9 +438,10 @@ static void usb_8dev_rx_err_msg(struct usb_8dev_priv *priv,
 
 	if (rx_errors)
 		stats->rx_errors++;
-
-	cf->data[6] = txerr;
-	cf->data[7] = rxerr;
+	if (priv->can.state != CAN_STATE_BUS_OFF) {
+		cf->data[6] = txerr;
+		cf->data[7] = rxerr;
+	}
 
 	priv->bec.txerr = txerr;
 	priv->bec.rxerr = rxerr;
-- 
2.35.1

