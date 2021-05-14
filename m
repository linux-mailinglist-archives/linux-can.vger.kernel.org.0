Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730E5380956
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 14:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhENMVJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 08:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhENMVJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 08:21:09 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C034FC061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 05:19:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h4so29834875wrt.12
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 05:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y3lXNEYaBNa/4IeVDd6BryoEyZvx72q53Q9emXliudQ=;
        b=vaBLMXowYJRRuKLDO/C7CBnvol7FUr4PzFOBBpsslTRF5KnfacZ2nkgpxYoor7/ryF
         VODckp5L5VNcp5em6MJwC5BB8TdEh792kAB+vKSragQNOh+x6Cq6sdHd+f1yiwI1hgZC
         vgexSH/9Lpxe7kcNNtpNX+nsKSzoTMrNr+dthkxphwnFICgGkHDfGCggOAe9cuQzVp6U
         8kSuLZ9J6z0LA+fIx/+M+wv2z32BlK686Yu+k0SpdCcqnqljN5Op1c5wVWzuBIRL4968
         nDTBLbvH5rpGKXQY+6JErZ49HMMntrnkN4iXBETyarhpQP4+1FEMjE0CQXsH44Fjnr04
         l0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y3lXNEYaBNa/4IeVDd6BryoEyZvx72q53Q9emXliudQ=;
        b=pXWN+lsG/S6eDdnVhj2SCnnbTvOT4u2JJYEnesZY8gmen0Tq2bc6k9ht5iwG+3vjkT
         h5QTCgqvGH98efTKVX9r8VVPntsOMaA7vAI0ZDK6uxCAEOz4ml6gdPCN6IL9azS2DUsZ
         Yz6DNeMF+AfuRBQTC/o1+l9MXsoTouLctm1c1znIQJDu6XWisddCj/ELpblbk9MwCzZF
         aletdjVXIwpTg3gdMHX0VN/wsDRBTprpyhQulYR/35t9o18lh4X9AQtwA89lWkXALl94
         +Bw5D5B/Z956RnTbP+ni6c/BGX/oZwrqGv8pLvwv03Cgi3uJWiAeWXMhTY/bqQNEgzuE
         ZBmA==
X-Gm-Message-State: AOAM531f9R5GPMy/lTHufmXFSS1NgXHhdAVdbjLFSfMY+gHSf1NPx18r
        Hn45hNLTdI2eXaEia6vD9Qnpv6XKmSUd5w==
X-Google-Smtp-Source: ABdhPJxkfcqx6sxQO+GcYjOU4eY9sgfXod+lTtXJw0gVrtdVvHJLUf9qttFY0MUb9cF0cIaXqq0riQ==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr2814694wrq.356.1620994796357;
        Fri, 14 May 2021 05:19:56 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.182.threembb.co.uk. [92.41.10.182])
        by smtp.gmail.com with ESMTPSA id r11sm15103wrp.46.2021.05.14.05.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:19:56 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH RFC can-next 2/3] can: m_can: m_can_isr(): handle device-specific interrupts
Date:   Fri, 14 May 2021 13:19:45 +0100
Message-Id: <20210514121946.2344901-3-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210514121946.2344901-1-torin@maxiluxsystems.com>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Device-specific interrupts are handled, if applicable (and if no M_CAN
interrupts were handled in this ISR call).

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/m_can.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 34073cd077e4..af63dd4b8cd5 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1033,20 +1033,31 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	u32 ir;
+	irqreturn_t ret = IRQ_NONE;
 
 	if (pm_runtime_suspended(cdev->dev))
 		return IRQ_NONE;
+
 	ir = m_can_read(cdev, M_CAN_IR);
 	if (!ir)
-		return IRQ_NONE;
+		ret = IRQ_NONE;
 
 	/* ACK all irqs */
 	if (ir & IR_ALL_INT)
 		m_can_write(cdev, M_CAN_IR, ir);
 
+	/* If we have no M_CAN interrupts to handle, we can assume
+	 * device-specific interrupt(s) need handling.
+	 */
+	if (!ir && cdev->ops->handle_dev_interrupts)
+		ret = cdev->ops->handle_dev_interrupts(cdev);
+
 	if (cdev->ops->clear_interrupts)
 		cdev->ops->clear_interrupts(cdev);
 
+	if (!ir)
+		return ret;
+
 	/* schedule NAPI in case of
 	 * - rx IRQ
 	 * - state change IRQ
-- 
2.30.2

