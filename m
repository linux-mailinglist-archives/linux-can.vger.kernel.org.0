Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4077A62E4
	for <lists+linux-can@lfdr.de>; Tue, 19 Sep 2023 14:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjISM3R (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Sep 2023 08:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjISM3Q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Sep 2023 08:29:16 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6ECF2
        for <linux-can@vger.kernel.org>; Tue, 19 Sep 2023 05:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=vN6i8leG3BbFYpMDvEA4U0PebMVy5yCn0hB2uGupVuk=; b=B3/PQG8Dp1YdH2aK/EGrjyle2o
        4HMfFFXsARo6ziDsvQxsVup3Q4PbHvq0yGYUOuxcGmu8PzZrHwfKYaKuU5hYjyQuBGHuC9aQsXXrP
        CBnQwdBlMBaWJ87ZzwDIMFN5UX1mskaKbxEujXR4xbGGrkN7OBwxxeUypHOXg2VsRK+17pWz3o6Di
        RyVxk1eIrTN+6YtXi8z6Xl3A9jlH2iQx9yO41akZLGoxw2LmNdJmCjZbgwXogTKJ2Tf+e2zM9tXHz
        GFG0qBe6Z99DEh1o3vfz6U6rb24uL2SvEnAUX1riku0x0QXpj2+bsE7YA+fvjz1ZP89Y0PJi0Silq
        vHzmucpw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martin@geanix.com>)
        id 1qiZqb-00033f-9I; Tue, 19 Sep 2023 14:28:57 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@geanix.com>)
        id 1qiZqa-000GHn-Ng; Tue, 19 Sep 2023 14:28:56 +0200
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Dong Aisheng <b29396@freescale.com>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 1/2] can: m_can: allow keeping the transceiver running in suspend
Date:   Tue, 19 Sep 2023 14:28:32 +0200
Message-ID: <20230919122841.3803289-1-martin@geanix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27036/Tue Sep 19 09:42:31 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add a flag to the suspend class function that leaves the chip in a
running state with rx interrupt enabled, so that m_can device driver can
configure and use the interrupt as a wakeup source.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---

Changes since v1:
 * Fixed comment formatting
 * Updated m_can_class_{suspend,resume} calls in m_can_pci.c too
 * Skipped calling m_can_start() when resuming a wake-source device

 drivers/net/can/m_can/m_can.c          | 26 +++++++++++++++++++-------
 drivers/net/can/m_can/m_can.h          |  4 ++--
 drivers/net/can/m_can/m_can_pci.c      |  4 ++--
 drivers/net/can/m_can/m_can_platform.c |  4 ++--
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16ecc11c7f62..ec345f6fd6b0 100644
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
@@ -2121,7 +2121,15 @@ int m_can_class_suspend(struct device *dev)
 	if (netif_running(ndev)) {
 		netif_stop_queue(ndev);
 		netif_device_detach(ndev);
-		m_can_stop(ndev);
+
+		/* leave the chip running with rx interrupt enabled if it used
+		 * as a wake-up source.
+		 */
+		if (is_wake_source)
+			m_can_write(cdev, M_CAN_IE, IR_RF0N);
+		else
+			m_can_stop(ndev);
+
 		m_can_clk_stop(cdev);
 	}
 
@@ -2133,7 +2141,7 @@ int m_can_class_suspend(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_suspend);
 
-int m_can_class_resume(struct device *dev)
+int m_can_class_resume(struct device *dev, bool is_wake_source)
 {
 	struct m_can_classdev *cdev = dev_get_drvdata(dev);
 	struct net_device *ndev = cdev->net;
@@ -2148,11 +2156,15 @@ int m_can_class_resume(struct device *dev)
 		ret = m_can_clk_start(cdev);
 		if (ret)
 			return ret;
-		ret  = m_can_start(ndev);
-		if (ret) {
-			m_can_clk_stop(cdev);
 
-			return ret;
+		if (is_wake_source) {
+			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
+		} else {
+			ret  = m_can_start(ndev);
+			if (ret) {
+				m_can_clk_stop(cdev);
+				return ret;
+			}
 		}
 
 		netif_device_attach(ndev);
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 520e14277dff..5d86bcf66e83 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -105,6 +105,6 @@ int m_can_class_get_clocks(struct m_can_classdev *cdev);
 int m_can_init_ram(struct m_can_classdev *priv);
 int m_can_check_mram_cfg(struct m_can_classdev *cdev, u32 mram_max_size);
 
-int m_can_class_suspend(struct device *dev);
-int m_can_class_resume(struct device *dev);
+int m_can_class_suspend(struct device *dev, bool is_wake_source);
+int m_can_class_resume(struct device *dev, bool is_wake_source);
 #endif	/* _CAN_M_H_ */
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index f2219aa2824b..7ffbe06d96d0 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -169,12 +169,12 @@ static void m_can_pci_remove(struct pci_dev *pci)
 
 static __maybe_unused int m_can_pci_suspend(struct device *dev)
 {
-	return m_can_class_suspend(dev);
+	return m_can_class_suspend(dev, false);
 }
 
 static __maybe_unused int m_can_pci_resume(struct device *dev)
 {
-	return m_can_class_resume(dev);
+	return m_can_class_resume(dev, false);
 }
 
 static SIMPLE_DEV_PM_OPS(m_can_pci_pm_ops,
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index cdb28d6a092c..e49bef50d52c 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -169,12 +169,12 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 static __maybe_unused int m_can_suspend(struct device *dev)
 {
-	return m_can_class_suspend(dev);
+	return m_can_class_suspend(dev, false);
 }
 
 static __maybe_unused int m_can_resume(struct device *dev)
 {
-	return m_can_class_resume(dev);
+	return m_can_class_resume(dev, false);
 }
 
 static void m_can_plat_remove(struct platform_device *pdev)
-- 
2.42.0

