Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FC426878C
	for <lists+linux-can@lfdr.de>; Mon, 14 Sep 2020 10:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgINIun (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Sep 2020 04:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgINIuK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Sep 2020 04:50:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA15C061355
        for <linux-can@vger.kernel.org>; Mon, 14 Sep 2020 01:50:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so17783552wrm.2
        for <linux-can@vger.kernel.org>; Mon, 14 Sep 2020 01:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rOuDYNhd1Y5ud5FTj27+NxJ3Of7Hu1ANeTXNQ89wUxQ=;
        b=l/EV8WRl7sWHYBy73eHItd5zdjECPLnliI92dOSvSWvYDUnU2cuYVi0rvxl66FDh2T
         tuSNqz+Nx4xXRwhHEsu1GPbA74Up1shUnObJksSEr/dQpVdVmOxAbuDl5E5F1Tzobag3
         wTMrdA7YOeMlTq3wo5ZEAkrpMgvYh80QQKE0Ok5ieV9RowZb851bamiBwqJhGeceA2wj
         b9513TZMaIymzFcWSnqe2rlozdi5Sqqh1h8oOul1JfUlsu00KOSPQAMMlKBiFqjj7340
         9b9dNLMXOC4XGSzx7LTw25QyLIbr/e8wOq4i3aag4hjbAB7UTj1wLAhVC8zs2MVUBmbb
         jpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rOuDYNhd1Y5ud5FTj27+NxJ3Of7Hu1ANeTXNQ89wUxQ=;
        b=XI/tXx35copYHDSpaZyTcwpE2abvtz8FxW/nU0GzHqiDXHflNXAXsEHSPTGE33+Bw3
         E8Tj6AS/Y6KBOuuw1KDxCA+kcgMBLcgtPreYjHqWi72X6QrTxq37HkMCYVg+bVs1jY/c
         PmHf3vUEqKTqNRbGqaeYuVVwBCbPkrKRaf993bKn/x5lCjiX11FCitxVG4sbG61SCA39
         Xv57YCj/MnroxQEWXxHGIFe4QDBcyr9cGYi8P4oYY2CN+8JudZoz5EccfUCHIjraeUMe
         A0wSErqtmXnZY21Nto6UIaPURncFwYhOrKT8o4bZjxQIdJx4sTWr6jHw8+DuNMoYFnKe
         MNsw==
X-Gm-Message-State: AOAM533rYwPAhvW92pI9H3NKti+tQg2Eyk1KNDoIgXEsQjMkwGb3/rg9
        EKC8Lvqf/Ti3ibvPWYTisKCGtw==
X-Google-Smtp-Source: ABdhPJwF07/4H0OMXhAy5gL+VhoH+7Eb+10EYNtSdmKWyBjS7M08xEGD/WQEM0cG9zdKo4oUX5hI2w==
X-Received: by 2002:a5d:620e:: with SMTP id y14mr16069452wru.371.1600073408285;
        Mon, 14 Sep 2020 01:50:08 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id o4sm19305669wru.55.2020.09.14.01.50.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Sep 2020 01:50:07 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 3/3] can: xilinx_can: Fix incorrect variable and initialize with a default value
Date:   Mon, 14 Sep 2020 10:49:58 +0200
Message-Id: <0651544d22f3c25893ca9d445b14823f0dfddfc8.1600073396.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600073396.git.michal.simek@xilinx.com>
References: <cover.1600073396.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Srinivas Neeli <srinivas.neeli@xilinx.com>

Some variables with incorrect type were passed to "of_property_read_u32"
API, "of_property_read_u32" API was expecting an "u32 *" but the formal
parameter that was passed was of type "int *". Fixed the issue by
changing the variable types from "int" to "u32" and initialized with a
default value. Fixed sparse warning.

Addresses-Coverity: "incompatible_param"
Addresses-Coverity: "UNINIT(Using uninitialized value)"
Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/net/can/xilinx_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 3393e2a73e15..46c04b6390f8 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1671,7 +1671,7 @@ static int xcan_probe(struct platform_device *pdev)
 	void __iomem *addr;
 	int ret;
 	int rx_max, tx_max;
-	int hw_tx_max, hw_rx_max;
+	u32 hw_tx_max = 0, hw_rx_max = 0;
 	const char *hw_tx_max_property;
 
 	/* Get the virtual base address for the device */
@@ -1724,7 +1724,7 @@ static int xcan_probe(struct platform_device *pdev)
 	 */
 	if (!(devtype->flags & XCAN_FLAG_TX_MAILBOXES) &&
 	    (devtype->flags & XCAN_FLAG_TXFEMP))
-		tx_max = min(hw_tx_max, 2);
+		tx_max = min(hw_tx_max, 2U);
 	else
 		tx_max = 1;
 
-- 
2.28.0

