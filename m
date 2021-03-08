Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E8B330B1C
	for <lists+linux-can@lfdr.de>; Mon,  8 Mar 2021 11:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhCHK33 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 Mar 2021 05:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhCHK3D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 Mar 2021 05:29:03 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F538C06175F
        for <linux-can@vger.kernel.org>; Mon,  8 Mar 2021 02:29:03 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l11so7446659wrp.7
        for <linux-can@vger.kernel.org>; Mon, 08 Mar 2021 02:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7cBgGrdm/7j0D0RT/pcw3ql99adkZuMxr1LrqYEXRU=;
        b=aiHJnt9ONv4bC8xE/sqEN8mvQgYcKG1dd7FdrNioXXHXExu3ZVgoBtFWPAaD40m2Rp
         QkbuCG2+hLjmWOTwV6wPIKw1k2i4yF2HmHspoyflPZYIxYFkbeod3u6Va0e73peJggOn
         fprDqVtrKKDq8UTZcovvIcvZzlo8VFnwTd728bsBvUKVloghDmBZYXLl+E00C4vGrqQV
         keIOX2iorxEaCkg13/uMosTppY2XdE7CM3oFkASbD6W2TOiGFUv1w/tF6dn+6mHe7zoF
         CRsylWg9WvdInOGDHR4nsITO6IjxksaXsHGMgg5FcV51THCYrcb72ZpRdUFo7FZFaSl5
         0BoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7cBgGrdm/7j0D0RT/pcw3ql99adkZuMxr1LrqYEXRU=;
        b=fLxCleWNxpxT0SqozrZ6HcTGub8msmdSk7T2tKaCDEwbCfOBSTl1i0Uvc4t7WAUWou
         Ysxs54pg+y61ZYDKsJNTAkY0SiSZRYEZHcx259ovobO9Ml5bq1aO9Zgoyw99xk0KSoS/
         2JdLriXXySTNrZuYZs3VV8UTUBugZ7AdhLt3lyJepFoNUJHLVmwFUgs2rLYfWNC9O36z
         3Ny0Jws1IqpBAVcLayZZzDAgdOh1pU/58hGShRVrc41SSFNgfVrzbMD3MMXgkjvmCfWh
         XjiQIJm7kro8C1F+9L26fwgjxg02aabWWeHPsB+eyV6O1etQnhW210pDv0uGCZ91pGUe
         UuXg==
X-Gm-Message-State: AOAM532aWoGFsm3YpO/mn5tFcCUIazYJPbG5/fsAe/qSGuMhSt2QuEPo
        fc7JtRWP8RYwmPE2IF7O7/PNoomvuxNA3SpS
X-Google-Smtp-Source: ABdhPJx4nWdLz8qVcpdc8nTckaSbMbgS/QG1F7wr6O6bsRWkMEBE1ig2D18/QTpCADKf/DLScai1/A==
X-Received: by 2002:adf:e60a:: with SMTP id p10mr22511455wrm.291.1615199342186;
        Mon, 08 Mar 2021 02:29:02 -0800 (PST)
Received: from localhost.localdomain (92.41.6.207.threembb.co.uk. [92.41.6.207])
        by smtp.gmail.com with ESMTPSA id i17sm6416455wrp.77.2021.03.08.02.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 02:29:01 -0800 (PST)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Pankaj Sharma <pankj.sharma@samsung.com>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH v2 2/3] can: m_can: m_can_chip_config(): enable and configure internal timestamps
Date:   Mon,  8 Mar 2021 10:24:27 +0000
Message-Id: <20210308102427.63916-3-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308102427.63916-1-torin@maxiluxsystems.com>
References: <20210308102427.63916-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is a prerequisite for transitioning the m_can driver to rx-offload,
which works best with TX and RX timestamps.

The timestamps provided by M_CAN are 16-bit, timed according to the
nominal bit timing, and may be prescaled by a multiplier up to 16. We
choose the highest prescalar so that the timestamp wraps every 2^20 bit
times, or 209 ms at a bus speed of 5 Mbit/s. Timestamps will have a
precision of 16 bit times.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/m_can.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index ce1fef95d34b..e61b7e186d80 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1138,6 +1138,7 @@ static int m_can_set_bittiming(struct net_device *dev)
  *		- >= v3.1.x: TX FIFO is used
  * - configure mode
  * - setup bittiming
+ * - configure timestamp generation
  */
 static void m_can_chip_config(struct net_device *dev)
 {
@@ -1249,6 +1250,10 @@ static void m_can_chip_config(struct net_device *dev)
 	/* set bittiming params */
 	m_can_set_bittiming(dev);
 
+	/* enable internal timestamp generation, with a prescalar of 16. The
+	 * prescalar is applied to the nominal bit timing */
+	m_can_write(cdev, M_CAN_TSCC, FIELD_PREP(TSCC_TCP_MASK, 0xf));
+
 	m_can_config_endisable(cdev, false);
 
 	if (cdev->ops->init)
-- 
2.30.1

