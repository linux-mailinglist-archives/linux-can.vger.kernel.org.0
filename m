Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0FA4883F9
	for <lists+linux-can@lfdr.de>; Sat,  8 Jan 2022 15:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiAHOd1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 8 Jan 2022 09:33:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229717AbiAHOd1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 8 Jan 2022 09:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641652406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OTEoDAXesUBrrz0y7VX933AG7BpNKcC+21DOjfav4eQ=;
        b=N8zW4mVxz9x85I2DTig0IFp+9D5JB7bbiXl86u1vWUY1oN9e53DGCRn1ZvjmbCHBCS3QY3
        T86ENFsag5dSAYFydtWmWngPtrmi/plN8ehPnv5+gFt4lt/vDREbrKUbpd/hEq3Jo/7Dxe
        MLsojwuUDHbPIkePTvRMFXkCW68k4gg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-2QiQ-qBqPLes5XBGUIPIYg-1; Sat, 08 Jan 2022 09:33:25 -0500
X-MC-Unique: 2QiQ-qBqPLes5XBGUIPIYg-1
Received: by mail-oo1-f72.google.com with SMTP id r2-20020a4a3702000000b002daa363a4faso5983567oor.17
        for <linux-can@vger.kernel.org>; Sat, 08 Jan 2022 06:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OTEoDAXesUBrrz0y7VX933AG7BpNKcC+21DOjfav4eQ=;
        b=c9vdQA4N93nKgT65NAO9vxp3P2pGrbKWvw6HR92cL2Q0c7ErYWizMMWneOq3Ko1BhM
         mjTwRbSmVESjDYJbZsEEAeJVOSEAOtpVZaC7PU4FFLY3l0vbF9fGMvVp+baOUz7Thcmz
         5s4Jr8I9RWXdOC6VzM0fx6FO7FGBAB/68PFiOs6a4c4DnLAPIwgDHaTO8URFaTinEPCc
         +h5UfaCrkT2FDSkwkCnJn2ms8z57yzjaq0bzbTWbt/RNLEa22w5Y5qPob6P5k3lAiz02
         s3r8g2E/GHJPRbfBsVOT/iCT1qxUsUYc/y3cAi+venhzUUQvPf++INOypUN58Mt9D9x4
         B4cw==
X-Gm-Message-State: AOAM531uGWNG2AslP69qQGD4U8QKFIsWqdGPcqolOGNL1auss625uUtx
        fui7DudlSMBpVj5XZ8l8xKLKb3pGD05gKiovP3EjF4r5Jn0Om9KbE28wqRdkoox6Y33qqn1zr0y
        peH82k+j3n/Uwf8nriSn6
X-Received: by 2002:a9d:d68:: with SMTP id 95mr46520897oti.188.1641652404334;
        Sat, 08 Jan 2022 06:33:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrzTGEeaVMK49HTR2/2D3npJiXwy7xQHcIPlSumyPxfb0SUfpPiLi4GiaG2GrUwzY6o8mW7Q==
X-Received: by 2002:a9d:d68:: with SMTP id 95mr46520883oti.188.1641652404104;
        Sat, 08 Jan 2022 06:33:24 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id r37sm353568otv.54.2022.01.08.06.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 06:33:23 -0800 (PST)
From:   trix@redhat.com
To:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        kuba@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        mailhol.vincent@wanadoo.fr, stefan.maetje@esd.eu
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] can: janz-ican3: initialize dlc variable
Date:   Sat,  8 Jan 2022 06:33:19 -0800
Message-Id: <20220108143319.3986923-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this problem
janz-ican3.c:1311:2: warning: Undefined or garbage value returned to caller
        return dlc;
        ^~~~~~~~~~

dlc is only set with this conditional
	if (!(cf->can_id & CAN_RTR_FLAG))
		dlc = cf->len;

But is always returned.  So initialize dlc to 0.

Fixes: cc4b08c31b5c ("can: do not increase tx_bytes statistics for RTR frames")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/can/janz-ican3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 5b677af5f2a41..808c105cf8f7e 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1285,7 +1285,7 @@ static unsigned int ican3_get_echo_skb(struct ican3_dev *mod)
 {
 	struct sk_buff *skb = skb_dequeue(&mod->echoq);
 	struct can_frame *cf;
-	u8 dlc;
+	u8 dlc = 0;
 
 	/* this should never trigger unless there is a driver bug */
 	if (!skb) {
-- 
2.26.3

