Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3259432F109
	for <lists+linux-can@lfdr.de>; Fri,  5 Mar 2021 18:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbhCERVu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Mar 2021 12:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCERVc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Mar 2021 12:21:32 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7DDC061756
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 09:21:32 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h98so2879011wrh.11
        for <linux-can@vger.kernel.org>; Fri, 05 Mar 2021 09:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JW5c1u4SWQMGxSS5sSyhEtgIh0KGdGvIu4dU/YzXaFI=;
        b=TpIa+mC2wALaSayznTKWnoZgxozg4My/Lh3/UkMzo/4qP6KYgew+vLAZZSXXlTQMDU
         SOyGbimZ3aKzTwiSwVTbot07LN9qzdFfzUVyGZRyson+khvVFuKNhDKkDh2gJD3H8Kaj
         Miw9dvXOx8XKaf322gNbWixCefjHTBtKxLYt2jS6/4Obay0J6Ns9cXhw1WxEcRU+gyh5
         6ZXW5VB/UWsuUyifaZ7yuTNDo4ZOK+OFYqeoV7+jV33884hX8sQ5GqkXLrmn+zeQ7vcr
         bFZjobyiNkO3MX1SOHl+CUH5/mnUt+HlM1IpPmMlePsuBmhttt/5rOydso4HbzWwPMxq
         XhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JW5c1u4SWQMGxSS5sSyhEtgIh0KGdGvIu4dU/YzXaFI=;
        b=PIPxQ0jjkJ1ZknxNntMKOAIgVyuS1OedTv5xDMk+v6+JunV7JtWcc2quEgwc6na/7Z
         HXJI0WB3D0CPtaGXUzw6OPGKB4Itc2TEv887f5i/gpwcSa45HeMLmoImSlZoPjFRQOzb
         /N82IOMSvy3fqQhvcY/xsSDriby7IeEKzSNhACZNqjTirFV91hxkfleQvqkFktbV/ekJ
         zh615C5jfmadfeCYVxx/e2d63+5+1lJeCVNJa/71KBxeIaSbVxO4Nas2UaonFwRTA4b0
         uIGq5JA7jc/wrq0/XurUDzHMr64TA3vR21mZF3mzbfhU22fcPYutFRnpbAsQfKlwZMLh
         974g==
X-Gm-Message-State: AOAM5314dtlaLPx33reyix/DhVLc0K9tfAMZN3WEPnTTBOce4CbF+JnS
        FKNud5I30GGfasGNjzOGvlzssfnJCbfWxw==
X-Google-Smtp-Source: ABdhPJxN5P3iS9P+8WdVPKBmf9ekunOIMhY2g/QJB6R1nVYuC97uXZgd/s8XsWBCO8xzL2PN5cwxgQ==
X-Received: by 2002:adf:fd48:: with SMTP id h8mr10464693wrs.229.1614964890998;
        Fri, 05 Mar 2021 09:21:30 -0800 (PST)
Received: from localhost.localdomain ([185.69.145.254])
        by smtp.gmail.com with ESMTPSA id c9sm5174926wmb.33.2021.03.05.09.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:21:30 -0800 (PST)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Pankaj Sharma <pankj.sharma@samsung.com>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH 2/3] can: m_can: m_can_chip_config(): enable and configure internal timestamps
Date:   Fri,  5 Mar 2021 17:20:14 +0000
Message-Id: <20210305172015.1506525-3-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305172015.1506525-1-torin@maxiluxsystems.com>
References: <20210305172015.1506525-1-torin@maxiluxsystems.com>
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
 drivers/net/can/m_can/m_can.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index ea79cf0640a8..83a673417e7c 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1139,6 +1139,7 @@ static int m_can_set_bittiming(struct net_device *dev)
  *		- >= v3.1.x: TX FIFO is used
  * - configure mode
  * - setup bittiming
+ * - configure timestamp generation
  */
 static void m_can_chip_config(struct net_device *dev)
 {
@@ -1250,6 +1251,11 @@ static void m_can_chip_config(struct net_device *dev)
 	/* set bittiming params */
 	m_can_set_bittiming(dev);
 
+	/* enable internal timestamp generation, with a prescalar of 16. The
+	 * prescalar is applied to the nominal bit timing */
+	m_can_write(cdev, M_CAN_TSCC,
+		    (0xf << TSCC_TCP_SHIFT) | TSCC_TSS_INTERNAL);
+
 	m_can_config_endisable(cdev, false);
 
 	if (cdev->ops->init)
-- 
2.30.1

