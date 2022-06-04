Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023A753D747
	for <lists+linux-can@lfdr.de>; Sat,  4 Jun 2022 16:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiFDOmX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 4 Jun 2022 10:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiFDOmV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 4 Jun 2022 10:42:21 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF149BF7B;
        Sat,  4 Jun 2022 07:42:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n18so8851892plg.5;
        Sat, 04 Jun 2022 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xuhHnGOa3PV9wf1kMGLYlcNacDeXkrL2NEPeM30ETF4=;
        b=GwcshBEiueBOnbz8zKcCDT45AtMqn74HNbrKtmc88JARiS1Nahxn9HVGSg5xRZvLDF
         jCxmVQPEt+0XyNu47MovllRx4YJpWgl37tGz/XkpcoNCFogpfkjS5WgK8WWJyIlYhj+M
         9ewstyDqU6K2mX2YsGSj0kPXl83OImcF8t1L/EdZhsN/SzdsO4324cf7YqOLBfXN4k+W
         mccLec1yiORNn9g8SuqivjKPNt/H01ScJcyFaa5Si99pY47bDqO58eVmCL5FVOK/tQAB
         8og35oZEj0/mgvID8VtlXYW+mbMUWI2Rcw2Bzvnm/vNVOq4m+QiPFqBjDX+irOLXYizY
         tT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xuhHnGOa3PV9wf1kMGLYlcNacDeXkrL2NEPeM30ETF4=;
        b=TZFileihYcxPqhNJjkxCslS5DiZspeiZ5G/9In+uV88I4vtrHOCuG+hQ9Qpmu55PSq
         sYZ5Om9oyrDhg62EvcQffn+sZ2YbTtgydHKnMi6rLLQwjkAvB2ECll2daz0AMdiGIgrR
         g2N3eWA8CryILdGjWa5Iy1et+xGbTVeywwjcODsUW6eNddwkWORtxQUjcQ23wDjos0Uo
         cPfjSag3qGlBsZxf0/WjP63Gr/Udk3BrF+L2Kk4ZAQrHDlqmDZiTrdqS/PfEIkjA+NU+
         c+cRcAtQgR0Uionx7ToxFL7ZacsNE+6xRIIYA25Blg37dmNgH/p6mmu1Z+9sadq43k4Z
         d5cg==
X-Gm-Message-State: AOAM531hp2nUXHkHgofvhn9JLQGgu4Jk0a+aAKnvIlnwpa6B5zuUZoG9
        wipOZlsy0rm1AOMq2tfHqCQEEVf1IFVSqA==
X-Google-Smtp-Source: ABdhPJzAMZM0oN/zBSbDuHL0LXLPMNuvIwwHrKLD0RD8oVV1CuzZuoJ9XRZfn9NaMAVKSYAa49jgog==
X-Received: by 2002:a17:902:da87:b0:167:5517:e97e with SMTP id j7-20020a170902da8700b001675517e97emr5628742plx.91.1654353739158;
        Sat, 04 Jun 2022 07:42:19 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090340c900b0015ed003552fsm1415543pld.293.2022.06.04.07.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 07:42:18 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Rhett Aultman <rhett.aultman@samsara.com>
Cc:     wg@grandegger.com, Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-can@vger.kernel.org, linux-usb@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH] USB: core: urb: add new transfer flag URB_FREE_COHERENT
Date:   Sat,  4 Jun 2022 23:41:57 +0900
Message-Id: <20220604144157.208849-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <alpine.DEB.2.22.394.2206041003320.1657582@thelappy>
References: <alpine.DEB.2.22.394.2206041003320.1657582@thelappy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When allocating URB memory with kmalloc(), drivers can simply set the
URB_FREE_BUFFER flag in urb::transfer_flags and that way, the memory
will be freed in the background when calling killing the URB (for
example with usb_kill_anchored_urbs()).

However, there are no equivalent mechanism when allocating DMA memory
(with usb_alloc_coherent()).

This patch adds a new flag: URB_FREE_COHERENT. Setting this flag will
cause the kernel to automatically call usb_free_coherent() when the
URB is killed, similarly to how URB_FREE_BUFFER triggers a call to
kfree().

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Hi Rhett Aultman,

I put the code snippet I previously sent into a patch. It is not
tested (this is why I post it as RFC). Please feel free to add this to
your series.
---
 drivers/usb/core/urb.c | 3 +++
 include/linux/usb.h    | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 33d62d7e3929..1460fdac0b18 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -22,6 +22,9 @@ static void urb_destroy(struct kref *kref)
 
 	if (urb->transfer_flags & URB_FREE_BUFFER)
 		kfree(urb->transfer_buffer);
+	else if (urb->transfer_flags & URB_FREE_COHERENT)
+		usb_free_coherent(urb->dev, urb->transfer_buffer_length,
+				  urb->transfer_buffer, urb->transfer_dma);
 
 	kfree(urb);
 }
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 60bee864d897..2200b3785fdb 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1328,6 +1328,7 @@ extern int usb_disabled(void);
 #define URB_NO_INTERRUPT	0x0080	/* HINT: no non-error interrupt
 					 * needed */
 #define URB_FREE_BUFFER		0x0100	/* Free transfer buffer with the URB */
+#define URB_FREE_COHERENT	0x0400  /* Free DMA memory of transfer buffer */
 
 /* The following flags are used internally by usbcore and HCDs */
 #define URB_DIR_IN		0x0200	/* Transfer from device to host */
-- 
2.35.1

