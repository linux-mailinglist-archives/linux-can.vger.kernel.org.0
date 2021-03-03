Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF18232C5A0
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 02:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355326AbhCDAXz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239164AbhCCMvz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 07:51:55 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A49C061793
        for <linux-can@vger.kernel.org>; Wed,  3 Mar 2021 04:50:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v15so23556285wrx.4
        for <linux-can@vger.kernel.org>; Wed, 03 Mar 2021 04:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9/Ng2ZRdSTsvGRg2FA/bvFJe+jmS0IAxAzAbkFPyPR0=;
        b=LRddkNQ3Kbn75vozmW1azF82ZNgTGBd7NbROl+o/9UWaHzr09ZMeSsIt7zyDwj+ATG
         LHDR6viAG3Y80xLflqGrIB30CuHcWP7375YEmjWbWXl1nRNMcbCWfHVSyoW8GveBSKja
         ivBW0kiGOYWwyQ/37P3UIzOBZVua0/Cp/IPzn2U1DeEPS/xQygyZnBAu+7G4W7SAZxe5
         gF46rjyKiR20rPFpKnp8D2OwHO0J+qRuPgpgO7I0Zb97UqXC1fusNgbwdjx1CP58NNqZ
         Ow7f9Y9Ac7X+Xskq93kGZB1F83Y86mOKFluUslJCrZaXhQeo4OIXTswHWo2wVR7ZxSjn
         bP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9/Ng2ZRdSTsvGRg2FA/bvFJe+jmS0IAxAzAbkFPyPR0=;
        b=MZSK3yAU6A/L2BXkfX+kgMuhmqF88EEE3GBHU92EKmoKzxFZaH+xw0wRNFdCqNpQQ/
         /PgCl41EL3+td1sLgzr+bgcUfYOTFJ0vh+nehjNG16BaNNuXDjpSM2WS8LhcMEEzKf/v
         2yD/6YIVXtY3N5Oy88HDyCwH+ebU6B5Pq0wKnYJ+ruTbfJZSOaBWC02XGMgmtydBgUH5
         DkO/1ew7WtBsU79PvUjaus70XzaJbqD6ZyTKbZ+nwI8xNTsI7duHkH/VbFCyLWHFAQ4r
         Ta3+ELxUIKuMo1EpSbpNkkJEJSRtxwot9+U/tWbEMW191V8AlH9F8J32bDng7kChhFSj
         C5Rg==
X-Gm-Message-State: AOAM5327PYpvhKR/SQ2mR/TEKJE7gUjX27GX32kH9DrmWQFcHPx6v5EO
        GCBSHv6kWDBnI6jcQ1Oz3aOCJGded8aWGQ==
X-Google-Smtp-Source: ABdhPJxQHerz7Un+83VTt0TML2nd0yND21fNVNrjZ1GVEPaajJYvRu+LmKWJH25B8UrCDe5E8Hb73Q==
X-Received: by 2002:adf:e482:: with SMTP id i2mr27016820wrm.392.1614775823715;
        Wed, 03 Mar 2021 04:50:23 -0800 (PST)
Received: from localhost.localdomain (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id a198sm5949764wmd.11.2021.03.03.04.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 04:50:23 -0800 (PST)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     mkl@pengutronix.de, Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH] can: m_can: m_can_rx_handler(): fix RX in periphs being blocked by error handling
Date:   Wed,  3 Mar 2021 12:49:52 +0000
Message-Id: <20210303124950.3917746-1-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In peripherals, m_can_rx_handler is called with quota = 1 from an ISR
context. If the M_CAN reports a high volume of errors, such as message
loss due to heavy bus traffic, then error handling, which is prioritised
in m_can_rx_handler, fills the quota immediately, and RX does not occur.
This has been observed to cause an indefinite blocking of RX.

The patch fixes this by ensuring that in peripherals, m_can_do_rx_poll
is always called with a quota of at least 1, regardless of any errors
handled.

This has been tested with the TCAN4550 under heavy bus traffic; message
loss is still detected correctly.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/m_can.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 3752520a7d4b..3ec42e613ca1 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -866,8 +866,14 @@ static int m_can_rx_handler(struct net_device *dev, int quota)
 	if (irqstatus & IR_ERR_BUS_30X)
 		work_done += m_can_handle_bus_errors(dev, irqstatus, psr);
 
-	if (irqstatus & IR_RF0N)
-		work_done += m_can_do_rx_poll(dev, (quota - work_done));
+	if (irqstatus & IR_RF0N) {
+		int rx_quota = quota - work_done;
+
+		if (cdev->is_peripheral && (rx_quota <= 0))
+			rx_quota = 1;
+
+		work_done += m_can_do_rx_poll(dev, rx_quota);
+	}
 end:
 	return work_done;
 }
-- 
2.30.1

