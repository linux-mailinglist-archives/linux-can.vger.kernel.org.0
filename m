Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2172D584D28
	for <lists+linux-can@lfdr.de>; Fri, 29 Jul 2022 10:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiG2IJ1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Jul 2022 04:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiG2IJ1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 29 Jul 2022 04:09:27 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73277E336
        for <linux-can@vger.kernel.org>; Fri, 29 Jul 2022 01:09:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 70so4011954pfx.1
        for <linux-can@vger.kernel.org>; Fri, 29 Jul 2022 01:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QIkMIOL20VKXb8u6UVb/rzfY49Vwr/7vVaxPhCSs0mU=;
        b=SmQ9IrTfphbsWW4tW4E70WauJ8aXZCxHyykbcvkZiYQ1WxwmyxV2HNBcNOh78BTTdN
         ENtLIwtFe00ne6xIlb2SJKRG8od2kNNiCBxGdd7Yjs9enB/XTvASen6hP03JBs48A87B
         GIqqAJDzms36oNGOM7etIMtpwzEc0rIW9knUm7hyf7B1St/tXmTqQcXTTbzDkKJpb2kU
         ZZo+skiBkDCQTFhONvrSDcl4Y6/m5FaXGKAJL9cKD8tMfPBlvE4vKYhX4v5frlBhKj95
         myBveyiGEO2wjCmFKWRrBM9md3atkKZCdAhCTuLHZlxQ10meG0zCeJ4BnxY1fHb8T1MQ
         T2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QIkMIOL20VKXb8u6UVb/rzfY49Vwr/7vVaxPhCSs0mU=;
        b=nR9FV6h7xEQzX7QCqo3q2TviB6i59/I7eJbI2Cs8/aY2eyYq8S9wSxvEs956PmT7PY
         Ubf9nFEgLLTCG2oJdl6MWQ2VXHHSmKB0r1ja5+GQ3Osu43IIZQM1CGIhcxIYzjvexU+W
         V/XP0kKetwtQpq9EjXmE5uLNTC3S6EJaLoa9RvrvqHVwta56qG0VAMLgBITR3rMCpzID
         mEgT+f+t/ayp2fYH41BVQoxfQ/VZtep67EgAMqKGKVTbmPmaPcDyP3f1Hf75jN5jKVHj
         Wym+V4zMyh6idegrGkXfO56FrOr32bIEk+quOEvUvL7ZOanFWU/OG9ImTyjyhw8E3v8Z
         sDPg==
X-Gm-Message-State: AJIora8IM/HhCgVYkfjxaMA9uCBYeb0sQ1dEPN7Dm5JPt/bJqFcwG6PG
        o7DO5NjF3WWNv6chVsLrCd04ZWeh5+k=
X-Google-Smtp-Source: AGRyM1vRvc7BC0hjYOvCRddwtSrIoSvstHvBTO4tFnz+1WIJSdnsOmBNMAwjguGbPpjq21Jz1lfFeA==
X-Received: by 2002:a63:1246:0:b0:41a:58f:9fee with SMTP id 6-20020a631246000000b0041a058f9feemr1982154pgs.413.1659082165115;
        Fri, 29 Jul 2022 01:09:25 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id o11-20020a62cd0b000000b0052add461d2esm2145575pfg.103.2022.07.29.01.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:09:24 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] can: etas_es58x: remove useless calls to usb_fill_bulk_urb()
Date:   Fri, 29 Jul 2022 17:09:02 +0900
Message-Id: <20220729080902.25839-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
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

Aside of urb->transfer_buffer_length and urb->context which might
change in the TX path, all the other URB parameters remains constant
during runtime. So, there is no reasons to call usb_fill_bulk_urb()
each time before submitting an URB.

Make sure to initialize all the fields of the URB at allocation
time. For the TX branch, replace the call usb_fill_bulk_urb() by an
assignment of urb->context. urb->urb->transfer_buffer_length is
already set by the caller functions, no need to set it again. For the
RX branch, because all parameters are unchanged, simply remove the
call to usb_fill_bulk_urb().

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 3b949e979583..51294b717040 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1460,10 +1460,6 @@ static void es58x_read_bulk_callback(struct urb *urb)
 	}
 
  resubmit_urb:
-	usb_fill_bulk_urb(urb, es58x_dev->udev, es58x_dev->rx_pipe,
-			  urb->transfer_buffer, urb->transfer_buffer_length,
-			  es58x_read_bulk_callback, es58x_dev);
-
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
 	if (ret == -ENODEV) {
 		for (i = 0; i < es58x_dev->num_can_ch; i++)
@@ -1597,7 +1593,8 @@ static struct urb *es58x_get_tx_urb(struct es58x_device *es58x_dev)
 			return NULL;
 
 		usb_fill_bulk_urb(urb, es58x_dev->udev, es58x_dev->tx_pipe,
-				  buf, tx_buf_len, NULL, NULL);
+				  buf, tx_buf_len, es58x_write_bulk_callback,
+				  NULL);
 		return urb;
 	}
 
@@ -1630,9 +1627,7 @@ static int es58x_submit_urb(struct es58x_device *es58x_dev, struct urb *urb,
 	int ret;
 
 	es58x_set_crc(urb->transfer_buffer, urb->transfer_buffer_length);
-	usb_fill_bulk_urb(urb, es58x_dev->udev, es58x_dev->tx_pipe,
-			  urb->transfer_buffer, urb->transfer_buffer_length,
-			  es58x_write_bulk_callback, netdev);
+	urb->context = netdev;
 	usb_anchor_urb(urb, &es58x_dev->tx_urbs_busy);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
 	if (ret) {
-- 
2.35.1

