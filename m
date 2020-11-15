Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2552B3637
	for <lists+linux-can@lfdr.de>; Sun, 15 Nov 2020 17:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgKOQbO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 15 Nov 2020 11:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgKOQbO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 15 Nov 2020 11:31:14 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F71C0613D2
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 08:31:12 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d17so21343570lfq.10
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 08:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vREcVTqf0XnPs3ZnNVPT87eSMZGPx/gxgKBguECzTL0=;
        b=bK0GZ+EsxviPmYiVs9U1W5Rb/R1LRnzbwPAsj/PVpuLdaQ7N0Q7XkpPOcmD4hy+Pfu
         Ec9b5a8RWW7t2FpAGk0OJxBqDRa6su1PZpYZbXtfPYqL9qo1lKxlY3eifYdT2WRz4paO
         X66rzmQX7kpC51mbLj3iYpAp6apvQ/FToZmDeWJuycri1SdXRbPIcd7+v0AzgPVaWLQl
         6VZXd9IJeTJ91zqIDm/BfEXOq5bJVoFjllN9+C7YCEMHGPF12RZ/EOtRhpoKxXBg7oAb
         7agExJ3cw869Z/q9e8hQGot3f01CWyy/oE2s5QnxHbTYzitVUA/K6lBJ41FPRa8rDKg7
         9ClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vREcVTqf0XnPs3ZnNVPT87eSMZGPx/gxgKBguECzTL0=;
        b=MDlEGLrCOk9tJ7kuhFQs3HZiuEeZtRTTe66+8hooTCoD2ZNLyMFSc9p1Iu4NH0osyK
         8uKBtoZ++olDlZalQgzqIMeVe4kjgV41bTY+4wH5ZGoshzpe1Vc6PnQk6CPuyQfZJfIm
         flRmstDhdtxxsgKKozc9dpYbUVMov1xRBJ3KmA5R2JIiEuyVLQLqHljRcFl4ROTXL/5j
         cXNxjqm5+UNBGkZKsHQg3vKyNXPt0xWLM8Xtqth8hd6GE9Ygm1amiDdFa7I8JUWidauZ
         kANwp6sBmvbWfB2iiK1G/xSJ+IV3A2GC7E0vfk7Bwsx6xmrRZhQtI/ZCuEGqMEuYaBHD
         V/Ig==
X-Gm-Message-State: AOAM532Dv3iho8I7yl9hqrX3hBWc4B/iXxusaK7aboqmmpT2G187CgGR
        UlkyjeshJsMo7u7wusdaf7VHenLZnPs=
X-Google-Smtp-Source: ABdhPJyEdTDUntiue8baL9MxzjQb8IhaPWyrqM+7r7TYhYfMytbs+0gQskyhtNMRXgEmvl/NDQr+Hw==
X-Received: by 2002:ac2:5e91:: with SMTP id b17mr3927604lfq.442.1605457870546;
        Sun, 15 Nov 2020 08:31:10 -0800 (PST)
Received: from jimmy-desk-arch.kvaser.se (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b12sm2419462ljj.133.2020.11.15.08.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 08:31:10 -0800 (PST)
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 2/6] can: kvaser_usb: kvaser_usb_hydra: Fix KCAN bittiming limits
Date:   Sun, 15 Nov 2020 17:30:23 +0100
Message-Id: <20201115163027.16851-2-jimmyassarsson@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115163027.16851-1-jimmyassarsson@gmail.com>
References: <20201115163027.16851-1-jimmyassarsson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Use correct bittiming limits for the KCAN CAN controller.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 7ab87a758754..218fadc91155 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -367,7 +367,7 @@ static const struct can_bittiming_const kvaser_usb_hydra_kcan_bittiming_c = {
 	.tseg2_max = 32,
 	.sjw_max = 16,
 	.brp_min = 1,
-	.brp_max = 4096,
+	.brp_max = 8192,
 	.brp_inc = 1,
 };
 
-- 
2.29.2

