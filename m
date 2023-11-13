Return-Path: <linux-can+bounces-10-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1741C7E9CD1
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 14:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA031F20F30
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5C51EA78;
	Mon, 13 Nov 2023 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="g+OD8oGt"
X-Original-To: linux-can@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341601DFC0;
	Mon, 13 Nov 2023 13:15:08 +0000 (UTC)
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB4BD6C;
	Mon, 13 Nov 2023 05:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QoR+0MAbswc0cnUW5kdtSbxerOqcrsBhnVTI88VG04s=; b=g+OD8oGtKgeRWsTcOzwcjt14ob
	+N43H0Qt7Az9Xb4qx5Xxw1bzIxvBqAm7QOSx0P5Kus97wfPWhifN0ffIoAuQKgtO3qj9gWC4PNN25
	OU5btfV4K+Tkt+dRCrMBQiQ3fEOkeTQpQNIWhM9TAmUtC4ieQrnm5nSImEoHJN+qK4nTF9hQ9XACF
	F+3kaOrjdwdJlJm+lQ8gb0ttecJOTnz4MtDuhDh70OVXqvn2w3IznKRcynbUwL5vAICUtgUOIO5eC
	0M/k/AT4WkhNKxwcfMwaJq0y75xWVpPiC4GF5Hs/FM3kIF5RsZSpWbItFTxFakOnd7ABe583Liflo
	N20f1iyw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin@geanix.com>)
	id 1r2WmF-0007Gb-Ns; Mon, 13 Nov 2023 14:14:55 +0100
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <martin@geanix.com>)
	id 1r2WmF-000XPJ-55; Mon, 13 Nov 2023 14:14:55 +0100
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH v3 1/3] can: m_can: allow keeping the transceiver running in suspend
Date: Mon, 13 Nov 2023 14:14:50 +0100
Message-ID: <20231113131452.214961-2-martin@geanix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231113131452.214961-1-martin@geanix.com>
References: <20231113131452.214961-1-martin@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27092/Mon Nov 13 09:38:20 2023)

Add a flag to the device class structure that leaves the chip in a
running state with rx interrupt enabled, so that an m_can device driver
can configure and use the interrupt as a wakeup source.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---

Change in v3:
 * Replaced the added function parameter with a property in
   struct m_can_classdev.

Changes in v2:
 * Fixed comment formatting
 * Updated m_can_class_{suspend,resume} calls in m_can_pci.c too
 * Skipped calling m_can_start() when resuming a wake-source device

 drivers/net/can/m_can/m_can.c          | 22 +++++++++++++++++-----
 drivers/net/can/m_can/m_can.h          |  1 +
 drivers/net/can/m_can/m_can_pci.c      |  1 +
 drivers/net/can/m_can/m_can_platform.c |  1 +
 drivers/net/can/m_can/tcan4x5x-core.c  |  1 +
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index b351597f594b..55df50580480 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2392,7 +2392,15 @@ int m_can_class_suspend(struct device *dev)
 	if (netif_running(ndev)) {
 		netif_stop_queue(ndev);
 		netif_device_detach(ndev);
-		m_can_stop(ndev);
+
+		/* leave the chip running with rx interrupt enabled if it is
+		 * used as a wake-up source.
+		 */
+		if (cdev->pm_wake_source)
+			m_can_write(cdev, M_CAN_IE, IR_RF0N);
+		else
+			m_can_stop(ndev);
+
 		m_can_clk_stop(cdev);
 	}
 
@@ -2419,11 +2427,15 @@ int m_can_class_resume(struct device *dev)
 		ret = m_can_clk_start(cdev);
 		if (ret)
 			return ret;
-		ret  = m_can_start(ndev);
-		if (ret) {
-			m_can_clk_stop(cdev);
 
-			return ret;
+		if (cdev->pm_wake_source) {
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
index 2986c4ce0b2f..3a9edc292593 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -97,6 +97,7 @@ struct m_can_classdev {
 	u32 irqstatus;
 
 	int pm_clock_support;
+	int pm_wake_source;
 	int is_peripheral;
 
 	// Cached M_CAN_IE register content
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index f2219aa2824b..45400de4163d 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -125,6 +125,7 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	mcan_class->dev = &pci->dev;
 	mcan_class->net->irq = pci_irq_vector(pci, 0);
 	mcan_class->pm_clock_support = 1;
+	mcan_class->pm_wake_source = 0;
 	mcan_class->can.clock.freq = id->driver_data;
 	mcan_class->ops = &m_can_pci_ops;
 
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index ab1b8211a61c..df0367124b4c 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -139,6 +139,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	mcan_class->net->irq = irq;
 	mcan_class->pm_clock_support = 1;
+	mcan_class->pm_wake_source = 0;
 	mcan_class->can.clock.freq = clk_get_rate(mcan_class->cclk);
 	mcan_class->dev = &pdev->dev;
 	mcan_class->transceiver = transceiver;
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 8a4143809d33..870ab4aef610 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -411,6 +411,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	priv->spi = spi;
 
 	mcan_class->pm_clock_support = 0;
+	mcan_class->pm_wake_source = 0;
 	mcan_class->can.clock.freq = freq;
 	mcan_class->dev = &spi->dev;
 	mcan_class->ops = &tcan4x5x_ops;
-- 
2.42.0


