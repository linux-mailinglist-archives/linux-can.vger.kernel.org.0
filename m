Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB07632C5AA
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 02:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380742AbhCDAYB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447752AbhCCPQV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 10:16:21 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D0AC0611A3
        for <linux-can@vger.kernel.org>; Wed,  3 Mar 2021 06:44:32 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id 7so23980676wrz.0
        for <linux-can@vger.kernel.org>; Wed, 03 Mar 2021 06:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sTCwzn3oKxMCf1Fn/+EFMRYBOCtivaEMQs5qlcJpOJw=;
        b=Am2myAUUVowOyKE7h8Ucqpa5z1rtl4V8Vz8ZCF7zai8asJOtWuhXkYmfHgqN8YLEHA
         q7RA80olYy3BEwXz+Xr/BNnJDBFYKDmMfj8FwtkevHQpqiaWhJ4ksdSxpSFOdaiJdEiQ
         0BA6mgZz384Kdf0fWAlfhctBX4UiAuTnunHjAWqv1dwakBsM7S/ZRzQfqWWnvAYzrb3R
         G4FZiK7mHSYUSVubbllXFYeaj1My/Asoit8XYzVdXKygyWqtgndOL8eFe3SeU6E4DKyZ
         eOvImfpeRj8HQzckhqk0lqESpLAYzqmyGfEy6KulTaNSmQzSyVVrH4IFtIjWdPT2fmv7
         r8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sTCwzn3oKxMCf1Fn/+EFMRYBOCtivaEMQs5qlcJpOJw=;
        b=fV/K2mlPhb0nwtQg0iAUiAiWkDklHUGbPLK+cg4e/mPfkPmuYmmPKK/tbwx+ME5a4g
         yc7B0Yql4YEurMqXbeaOawHM4WhHbV4pyx0NgM02d7gXjFLVmGXpy+UB+NBiZfbllfmZ
         qcKIqZp1J/ylVKOrI2MniBZ3piGiiZ35nyOBERsc6g49XUnyBOU0VmlyDfYMYD8S9Fc2
         k8H10Of/aESattUp62KuHmD45R3DXHfh+R5w6JH5bIXvGBkBtP9lcyS2/uGOs8aMkl/g
         kgJ7a8h6V00CSPcvRGR2tJjhrzYde+SBAcbxn1qGiIU/ayqeCDeVw179jOOPPmxNhLQE
         lWag==
X-Gm-Message-State: AOAM530t/NwqQ4AitCUlJ7cNJYi18b8vRKqXthgI5Ibtvs/cX4SKKhhK
        aUrKxdPi2Wby2aoCNO/WHrOOPOXiX2VUmw==
X-Google-Smtp-Source: ABdhPJzOFw4oEsrLPp157vd2hR5M3qLawnbmyZRQxR/dUVGiJc95RVpNf+kjAb5SDkO0b6y/GDjQtg==
X-Received: by 2002:a5d:5047:: with SMTP id h7mr17048718wrt.111.1614782671305;
        Wed, 03 Mar 2021 06:44:31 -0800 (PST)
Received: from localhost.localdomain (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id h20sm5877480wmp.38.2021.03.03.06.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:44:31 -0800 (PST)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     mkl@pengutronix.de, Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH] can: m_can: m_can_rx_peripheral: fix RX being blocked by errors
Date:   Wed,  3 Mar 2021 14:43:51 +0000
Message-Id: <20210303144350.4093750-1-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

For M_CAN peripherals, m_can_rx_handler was called with quota = 1, which
caused any error handling to block RX from taking place until the next
time the IRQ handler is called. This had been observed to cause RX to be
blocked indefinitely in some cases.

This is fixed by calling m_can_rx_handler with a sensibly high quota.

Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/m_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 3752520a7d4b..1f265895bf87 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -876,7 +876,7 @@ static int m_can_rx_peripheral(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 
-	m_can_rx_handler(dev, 1);
+	m_can_rx_handler(dev, M_CAN_NAPI_WEIGHT);
 
 	m_can_enable_all_interrupts(cdev);
 
-- 
2.30.1

