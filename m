Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA132380955
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 14:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhENMVJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 08:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhENMVI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 08:21:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EB7C061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 05:19:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z17so10784670wrq.7
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 05:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HlAY5Zd+0Pe+2YxItZfWI8EDZZYxmDX41wQKt3lyrqU=;
        b=l9qKfC7MFx0TCGwHHydmxbSTkOcekj9e69+zyEVJykNzHRb5eRFmVpvDG5Fj6bfABf
         q5Tb1o2qC8i4B2GxC64oVfMdDseIAxPW1RXzuPBonRhbWqOeadhsC2QpjTD+wS0uI7/2
         Gnsf3xtOnQvQdIAbEusxlt7tvz6rjXzibuFn1sbFPxfuyWh47v4rF1IGSSD5nBeth+bv
         d4CKvnKy8GNy3HNQQCYDilZ80EjDXAfVHu0RefYk9cNEepHVCxlKk1o+pnmmmCcRP0lH
         2vtxwg+MAXH+iZ6/kALe1CCUCCGlmgyOXRe0+zyXJbdomc9fNB+IM/3QKVo8iqlky3M5
         VR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HlAY5Zd+0Pe+2YxItZfWI8EDZZYxmDX41wQKt3lyrqU=;
        b=ruRjk8N9Ou5mCVYCmaRygXNAkmBAYmHEc953uVPAAOzbWkehgG/GgxJq2dwMfYf1kZ
         WH4MX7kyu30SMSankz6JHnSRh4PHpbc5kH+0LA3PHy4tiKR4inHHpR+6OzW9CKYl6HdW
         /SyWzt6PgISTpi1DAivcvs/sq7WQeYJmkTxZ1p+n+MEQVXOtbimJyyvDiaaTNXacAHGn
         dXVd+s7RpcOX8JuG6UanGUCfhY2dWwzY1fpEUdqniuO2feIH3ROjSDNvzpRnoaS+DsVq
         V1U1dCs1UD6ryftjbh5DpeI2b5E/4PN6KkiJcyshu+cabjo6R98aBr3km1Mc2S38+17M
         RfCw==
X-Gm-Message-State: AOAM5313An+T9KCKzuaZPjDHVdp6sbWpvICAWG+fi+BdjB3JUmkhQUAR
        +qaGaunHzkYsbzgFd3KzuQk7bVSvu7i0/g==
X-Google-Smtp-Source: ABdhPJwF81UZ20/ER6GjjTgnP/rohQXY/76yma1s0lRw0+AFBiHTjHbXICvo6oCNBSINxulOifWpBg==
X-Received: by 2002:a05:6000:1549:: with SMTP id 9mr58110034wry.367.1620994795644;
        Fri, 14 May 2021 05:19:55 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.182.threembb.co.uk. [92.41.10.182])
        by smtp.gmail.com with ESMTPSA id r11sm15103wrp.46.2021.05.14.05.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:19:55 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH RFC can-next 1/3] can: m_can: add handle_dev_interrupts callback to m_can_ops
Date:   Fri, 14 May 2021 13:19:44 +0100
Message-Id: <20210514121946.2344901-2-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210514121946.2344901-1-torin@maxiluxsystems.com>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This callback will allow M_CAN-based devices, e.g. TI TCAN4550, to
handle device-specific interrupts which are not part of the M_CAN core,
but are signaled on the same interrupt pin.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/m_can.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index ace071c3e58c..99203a37f9cc 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -28,6 +28,7 @@
 #include <linux/iopoll.h>
 #include <linux/can/dev.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/irqreturn.h>
 
 /* m_can lec values */
 enum m_can_lec_type {
@@ -62,6 +63,7 @@ struct m_can_classdev;
 struct m_can_ops {
 	/* Device specific call backs */
 	int (*clear_interrupts)(struct m_can_classdev *cdev);
+	irqreturn_t (*handle_dev_interrupts)(struct m_can_classdev *cdev);
 	u32 (*read_reg)(struct m_can_classdev *cdev, int reg);
 	int (*write_reg)(struct m_can_classdev *cdev, int reg, int val);
 	u32 (*read_fifo)(struct m_can_classdev *cdev, int addr_offset);
-- 
2.30.2

