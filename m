Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB45632C59E
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 02:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242420AbhCDAXz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhCCKeZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 05:34:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38AEC06178B
        for <linux-can@vger.kernel.org>; Wed,  3 Mar 2021 02:32:24 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u14so23085165wri.3
        for <linux-can@vger.kernel.org>; Wed, 03 Mar 2021 02:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KHwI4AfrPjuo0n4ZH2dJrqUU8X8ytqygtf48RpSX/B4=;
        b=U6kb5/EQkyHOK7MJvCW7dMBe86cJdd+HYRx1PBYyCWbeVP3x6KnJlLpWhNC/SFS6qZ
         314k5+njSC6HGJ0ZxqMSmlLpVV2eDzqDUKavT0b1265pZBJaK8yuTwWPPNGbI+DZ57pg
         oAzpbIra9sGvN77JsyiIsROAhFevwt2q6SehBC6Jdc7QQJ8yAwnS+4ng8KhMor4QgvS1
         2mg9Y7e95r7bcR0rWpoL6RqyThj8x5l6OdKK56XXXWCeOPI17nXM8J4ziuLeasPsJ7aG
         6JrP3Q0oBlhG9gtFFJIdJA2sCv2amkOx7cV5fDJwymad1Zf71Shz+Aw9ES59nA7UGbPl
         i4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KHwI4AfrPjuo0n4ZH2dJrqUU8X8ytqygtf48RpSX/B4=;
        b=WOeeXnsxIqgVolbhDmuohvCEytsbs0SEFSxh4JxZJGPD+O2csgNFFp2z3Ny3YuyH9E
         PGmdMeKahvtj6PKhGVP7zNKXFPQMerXVz47s30aO3j7BPqRLvd+YuPEqn5n088nWWWbP
         6iytrBnfbqidYEHnwwgnjfzrepMx2D9XgQhjo/dqydEjDpGA++DGehnVKZqxwjfPuhhW
         B8aaQXDxFRUpkERU5fh9dcjn+MB4V/UueOcF4JSKhzNnCfeHWWamY9mgVauznVpQzpT9
         nPddklqoHvet1f8zLWjAd0P1++fxUiljWKNCXil1IZCwLyaTUcctQMK0sWGJy5Sy21/G
         jaMw==
X-Gm-Message-State: AOAM530oTJo3JTVffzEZ0GBYV395ZmdJ7xXpD6yUZjo/l1Tm6RtmOd0b
        Mc4XenLLVG/LCr2uvF4b4YJYSleDq2sh4Q==
X-Google-Smtp-Source: ABdhPJylXVDqCG+AOvwsry2XZykbZpY263bjsMA6zROuf2x06H+Q9t20Q6FTaxlEb5Ske1x0BC8mDw==
X-Received: by 2002:adf:a2c2:: with SMTP id t2mr26286883wra.47.1614767543434;
        Wed, 03 Mar 2021 02:32:23 -0800 (PST)
Received: from localhost.localdomain (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id y62sm7431153wmy.9.2021.03.03.02.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 02:32:23 -0800 (PST)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     mkl@pengutronix.de, Torin Cooper-Bennun <torin@maxiluxsystems.com>,
        Mariusz Madej <mariusz.madej@xtrack.com>
Subject: [PATCH] can: m_can: m_can_do_rx_poll(): fix extraneous msg loss warning
Date:   Wed,  3 Mar 2021 10:31:52 +0000
Message-Id: <20210303103151.3760532-1-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Message loss from RX FIFO 0 is already handled in m_can_handle_lost_msg,
with netdev output included.

Removing this warning also improves driver performance under heavy load,
where m_can_do_rx_poll may be called many times before this interrupt is
cleared, causing this message to be output many times (thanks Mariusz
Madej for this report).

Cc: Mariusz Madej <mariusz.madej@xtrack.com>
Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/m_can.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 3752520a7d4b..d783c46cac16 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -501,9 +501,6 @@ static int m_can_do_rx_poll(struct net_device *dev, int quota)
 	}
 
 	while ((rxfs & RXFS_FFL_MASK) && (quota > 0)) {
-		if (rxfs & RXFS_RFL)
-			netdev_warn(dev, "Rx FIFO 0 Message Lost\n");
-
 		m_can_read_fifo(dev, rxfs);
 
 		quota--;
-- 
2.30.1

