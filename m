Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE41053D934
	for <lists+linux-can@lfdr.de>; Sun,  5 Jun 2022 04:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245003AbiFECQJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 4 Jun 2022 22:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiFECQJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 4 Jun 2022 22:16:09 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7CA186E2;
        Sat,  4 Jun 2022 19:16:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s12so9652071plp.0;
        Sat, 04 Jun 2022 19:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7HCq/JX0wzy3/jD50x+yfjA7pAVtCDavxjeNjonqrU=;
        b=o5sCfVjc37aJds4agqc1B3n5KuciOVffY31uoJd5gU1Sfnl6qdrrDnYnCww66MZokX
         ZZxgeu1m4epiJhqvz5USL6BFuxN1/8zyv8Z5ALYB7dgS30JOtfkToYm9oPIBDY59G36t
         rDme279dqhpU8jJ8G5q753i0dkbG1XollJ4yIkLda34Yxg2uu0IwMbzqKLkw8bLWsTqa
         WQEgVcNJCiJriUYVomcwCWIiQIL1oHTrOJAA/Qni+LN41UCPvfdRIXkM9tTpgachcPjz
         +eVnAj0gOfU7JRZG57ujvmKm2j4mwEIJEGNRfX3ake/tVl62ZrrXbsGIRDz2tkvXBSxH
         tPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=x7HCq/JX0wzy3/jD50x+yfjA7pAVtCDavxjeNjonqrU=;
        b=Bi8Gh0v0XguVr/N6Dry0In4wIJJPj4dxEbOTKPv/RCHaa913f72DF8sAkIejeJG4QC
         /0n5VMEt2oA0gqqiG3eBwJ7ZVOrKc/nbl9dUZ+9gaCacPz3qIVDn5VTIHoYxFmr0MAe2
         +DvROddG1NMBa6vY3ybQKabqPBO6aj2Ix7kpjA5W3miGhsh4zo6uk24mMiIR9qq7gbd3
         3im18DuYzgU4XSOAzarYBu4YGhoFThUKenzXb39rt39oDdNG6HkQbQIo1ycHCe995rYm
         Tu2AZ9eNOD1xQSLCDhwI9BOqbu8VyHZo3eT9JF6uuCIPaT9qvh+fmd69dsbsDTD1ISZt
         D1IA==
X-Gm-Message-State: AOAM533jYntdZAHxWt6H4tdCMpKjzSO2odCb3iBV4fTGVhKHWAFyrYxp
        eKHDAyvQgDixFeKXnZobGgY=
X-Google-Smtp-Source: ABdhPJwWoDh3ZZrWn22Cih3ALuvTEMd/QoWYb5Kq1Z+/wWVJ/oEFFoCAZQbNeblMfYwud4pMR1gGow==
X-Received: by 2002:a17:90a:4a03:b0:1df:4583:cb26 with SMTP id e3-20020a17090a4a0300b001df4583cb26mr53675859pjh.173.1654395368012;
        Sat, 04 Jun 2022 19:16:08 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c20600b0016211344809sm7934506pll.72.2022.06.04.19.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 19:16:07 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Rhett Aultman <rhett.aultman@samsara.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, wg@grandegger.com,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-can@vger.kernel.org, linux-usb@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH v2] usb: urb: add new transfer flag URB_FREE_COHERENT
Date:   Sun,  5 Jun 2022 11:15:55 +0900
Message-Id: <20220605021555.214346-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220604144157.208849-1-mailhol.vincent@wanadoo.fr>
References: <20220604144157.208849-1-mailhol.vincent@wanadoo.fr>
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
will be freed in the background when killing the URB (for example with
usb_kill_anchored_urbs()).

However, there are no equivalent mechanism when allocating DMA memory
(with usb_alloc_coherent()).

This patch adds a new flag: URB_FREE_COHERENT. Setting this flag will
cause the kernel to automatically call usb_free_coherent() on the
transfer buffer when the URB is killed, similarly to how
URB_FREE_BUFFER triggers a call to kfree().

In order to have all the flags in numerical order, URB_DIR_IN is
renumbered from 0x0200 to 0x0400 so that URB_FREE_COHERENT can reuse
value 0x0200.

CC: Alan Stern <stern@rowland.harvard.edu>
CC: Rhett Aultman <rhett.aultman@samsara.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Hi Rhett Aultman,

I put the code snippet I previously sent into a patch. It is not
tested (this is why I post it as RFC). Please feel free to add this to
your series.

** Changelog **

v1 -> v2:

  * Renumber URB_DIR_IN for 0x0200 to 0x0400 in order to keep all the
    flags in numerical order.
---
 drivers/usb/core/urb.c | 3 +++
 include/linux/usb.h    | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

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
index 60bee864d897..945d68ea1d76 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1328,9 +1328,10 @@ extern int usb_disabled(void);
 #define URB_NO_INTERRUPT	0x0080	/* HINT: no non-error interrupt
 					 * needed */
 #define URB_FREE_BUFFER		0x0100	/* Free transfer buffer with the URB */
+#define URB_FREE_COHERENT	0x0200  /* Free DMA memory of transfer buffer */
 
 /* The following flags are used internally by usbcore and HCDs */
-#define URB_DIR_IN		0x0200	/* Transfer from device to host */
+#define URB_DIR_IN		0x0400	/* Transfer from device to host */
 #define URB_DIR_OUT		0
 #define URB_DIR_MASK		URB_DIR_IN
 
-- 
2.35.1

