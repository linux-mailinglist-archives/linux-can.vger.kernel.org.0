Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB379CC05
	for <lists+linux-can@lfdr.de>; Tue, 12 Sep 2023 11:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjILJih (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Sep 2023 05:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjILJif (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Sep 2023 05:38:35 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403641BE
        for <linux-can@vger.kernel.org>; Tue, 12 Sep 2023 02:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=6pCekj0zEjPFzNNYE2j9g939WyU4ejIqBrnnyI0eMEQ=; b=pWe2U0dfjxYHfLq1INtePnIjT+
        G7Q0fCDbubQjyzuNvNNObu4l5B5usv3Sd2ZzGSKaZqqA6aUDsNwynSOlX7NpT642Pxo/YVK8PGRmf
        Yy93bK8s/ZXpGOuMYQGCLocyftavECGrWieKca9iM2D6ntLZejoRXDq7F8Q4UE9iZadPTkRi/mQOT
        vr2GgIxIumyghalj+3rpisrnPvmDtI+AdQmMi9zxh1qidMj8xbsx4XIIDZCXxG9HpGc2gLSM/DyW3
        dgofaDHfe1PYqqCTTBk0fuX+i+PX8G3J8HvgFVZ+YdL8xs4A5QdpRrq9FnhTvnaRPTSUQlZxazq0w
        Zxuy3IJw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martin@geanix.com>)
        id 1qfzqk-00041E-O1; Tue, 12 Sep 2023 11:38:26 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@geanix.com>)
        id 1qfzqk-000PsR-EU; Tue, 12 Sep 2023 11:38:26 +0200
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: m_can: allow keeping the transceiver running in suspend
Date:   Tue, 12 Sep 2023 11:38:03 +0200
Message-ID: <20230912093807.1383720-1-martin@geanix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/27029/Tue Sep 12 09:38:51 2023)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add a flag to the suspend class function that leaves the chip in a
running state with rx interrupt enabled, so that m_can device driver can
configure and use the interrupt as a wakeup source.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 drivers/net/can/m_can/m_can.c          | 13 +++++++++++--
 drivers/net/can/m_can/m_can.h          |  2 +-
 drivers/net/can/m_can/m_can_platform.c |  2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16ecc11c7f62..21ac826170f9 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2113,7 +2113,7 @@ void m_can_class_unregister(struct m_can_classdev *cdev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_unregister);
 
-int m_can_class_suspend(struct device *dev)
+int m_can_class_suspend(struct device *dev, bool is_wake_source)
 {
 	struct m_can_classdev *cdev = dev_get_drvdata(dev);
 	struct net_device *ndev = cdev->net;
@@ -2121,7 +2121,16 @@ int m_can_class_suspend(struct device *dev)
 	if (netif_running(ndev)) {
 		netif_stop_queue(ndev);
 		netif_device_detach(ndev);
-		m_can_stop(ndev);
+
+		/*
+		 * leave the chip running with rx interrupt enabled if it used
+		 * as a wake-up source.
+		 */
+		if (is_wake_source)
+			m_can_write(cdev, M_CAN_IE, IR_RF0N);
+		else
+			m_can_stop(ndev);
+
 		m_can_clk_stop(cdev);
 	}
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 520e14277dff..542e8daad578 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -105,6 +105,6 @@ int m_can_class_get_clocks(struct m_can_classdev *cdev);
 int m_can_init_ram(struct m_can_classdev *priv);
 int m_can_check_mram_cfg(struct m_can_classdev *cdev, u32 mram_max_size);
 
-int m_can_class_suspend(struct device *dev);
+int m_can_class_suspend(struct device *dev, bool is_wake_source);
 int m_can_class_resume(struct device *dev);
 #endif	/* _CAN_M_H_ */
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index cdb28d6a092c..bbf6a245a3e0 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -169,7 +169,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 static __maybe_unused int m_can_suspend(struct device *dev)
 {
-	return m_can_class_suspend(dev);
+	return m_can_class_suspend(dev, false);
 }
 
 static __maybe_unused int m_can_resume(struct device *dev)
-- 
2.42.0

