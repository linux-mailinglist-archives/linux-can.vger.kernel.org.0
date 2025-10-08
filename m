Return-Path: <linux-can+bounces-5112-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 804CBBC669A
	for <lists+linux-can@lfdr.de>; Wed, 08 Oct 2025 21:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34232403FE2
	for <lists+linux-can@lfdr.de>; Wed,  8 Oct 2025 19:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A01E2C15B8;
	Wed,  8 Oct 2025 19:08:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53B2C0F89
	for <linux-can@vger.kernel.org>; Wed,  8 Oct 2025 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950491; cv=none; b=E+xiWnjTDq7d4CiRn+cwNJzGHD6my18FxcO1pyXRj3x9JbpKAeCOa19NRCPIROfCcXvoth+cIu2fzroByLN1I6H8mf5zKMNEpkMevjwXg3MBreN1ufrlH5S/1LJLXXEPHWOxCMDZQvGiP7FQ7NiV5GgbOUuU6UOfeGdyDYOsCrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950491; c=relaxed/simple;
	bh=bBKRrEXx8JJJK8wlE7K+f3tK2jXUQ6RCR6KNQGtJDFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bN5vbHFt6SNlTc+wZ1lhCKdrJNuqWoO7a7Yj3Jq2wCW/ODtAg82jfvdxy3fpfNXfG9FeAaNe1ye1Z0xUifPcKvYjasKh9PnvQisXorzSUXMFqfvwjVl6fpNR2qjii9zDxWpdnfWCSB+MwcBFq4KEmvG47wINaFAtZdZSenE1XcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW4-0003RO-3Q; Wed, 08 Oct 2025 21:08:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW3-002cDH-0v;
	Wed, 08 Oct 2025 21:07:59 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D80794821F7;
	Wed, 08 Oct 2025 19:07:58 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 08 Oct 2025 21:07:38 +0200
Subject: [PATCH 3/7] net: m_can: convert dev_{dbg,info,err} ->
 netdev_{dbg,info,err}
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-m_can-cleanups-v1-3-1784a18eaa84@pengutronix.de>
References: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
In-Reply-To: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-92513
X-Developer-Signature: v=1; a=openpgp-sha256; l=6136; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=bBKRrEXx8JJJK8wlE7K+f3tK2jXUQ6RCR6KNQGtJDFs=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo5raFUKqQVuUoN2ac3mD3SI5wJ9jHVVUEKGWNj
 gR7HIcT8m6JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaOa2hQAKCRAMdGXf+ZCR
 nLImCACCJMg+rxiEUcDeXu5hDgZnACQOaEqMFQ1vf3iHS3s43aQr5W7yBHn30AhycyTIXZUfvbh
 JX4j3PWnnjaMoLmNTFtXNj7njOYWR+Rfyj8OXfXz8jJj0cvy93NzQ3nYGPExOEp3vwX1ISrVPWW
 PrnaKJ06jX8o4xeXYmxFp4LiYkMlUzLv/HfIaot3yLPb13lA4h+u7nkU6Fr0HVjmSPLpyS8bJYy
 h0K7axWeYZJO+dRjzDpCVdiahyvgDsIyu5FrE9wBRhaw5X6KNqR1Cobg/andDQcUB311R47qwPQ
 0YsquORm7PRsOXaCv+VAcOYFJwEQZJPQb0cQYYX9mMsBuaoI
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

To ease debugging use the netdev_{dbg,info,err}() functions instead of
dev_{dbg,info,err}.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 54 +++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index d4aa46b236ea..4ca84f9a2734 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -386,8 +386,8 @@ static int m_can_cccr_update_bits(struct m_can_classdev *cdev, u32 mask, u32 val
 	size_t tries = 10;
 
 	if (!(mask & CCCR_INIT) && !(val_before & CCCR_INIT)) {
-		dev_err(cdev->dev,
-			"refusing to configure device when in normal mode\n");
+		netdev_err(cdev->net,
+			   "refusing to configure device when in normal mode\n");
 		return -EBUSY;
 	}
 
@@ -469,7 +469,7 @@ static void m_can_coalescing_disable(struct m_can_classdev *cdev)
 static inline void m_can_enable_all_interrupts(struct m_can_classdev *cdev)
 {
 	if (!cdev->net->irq) {
-		dev_dbg(cdev->dev, "Start hrtimer\n");
+		netdev_dbg(cdev->net, "Start hrtimer\n");
 		hrtimer_start(&cdev->hrtimer,
 			      ms_to_ktime(HRTIMER_POLL_INTERVAL_MS),
 			      HRTIMER_MODE_REL_PINNED);
@@ -485,7 +485,7 @@ static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
 	m_can_write(cdev, M_CAN_ILE, 0x0);
 
 	if (!cdev->net->irq) {
-		dev_dbg(cdev->dev, "Stop hrtimer\n");
+		netdev_dbg(cdev->net, "Stop hrtimer\n");
 		hrtimer_try_to_cancel(&cdev->hrtimer);
 	}
 }
@@ -1474,7 +1474,7 @@ static int m_can_chip_config(struct net_device *dev)
 
 	err = m_can_init_ram(cdev);
 	if (err) {
-		dev_err(cdev->dev, "Message RAM configuration failed\n");
+		netdev_err(dev, "Message RAM configuration failed\n");
 		return err;
 	}
 
@@ -1704,7 +1704,7 @@ static int m_can_niso_supported(struct m_can_classdev *cdev)
 	/* Then clear the it again. */
 	ret = m_can_cccr_update_bits(cdev, CCCR_NISO, 0);
 	if (ret) {
-		dev_err(cdev->dev, "failed to revert the NON-ISO bit in CCCR\n");
+		netdev_err(cdev->net, "failed to revert the NON-ISO bit in CCCR\n");
 		return ret;
 	}
 
@@ -1723,8 +1723,8 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 	m_can_version = m_can_check_core_release(cdev);
 	/* return if unsupported version */
 	if (!m_can_version) {
-		dev_err(cdev->dev, "Unsupported version number: %2d",
-			m_can_version);
+		netdev_err(cdev->net, "Unsupported version number: %2d",
+			   m_can_version);
 		return -EINVAL;
 	}
 
@@ -1782,8 +1782,8 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 			cdev->can.ctrlmode_supported |= CAN_CTRLMODE_FD_NON_ISO;
 		break;
 	default:
-		dev_err(cdev->dev, "Unsupported version number: %2d",
-			cdev->version);
+		netdev_err(cdev->net, "Unsupported version number: %2d",
+			   cdev->version);
 		return -EINVAL;
 	}
 
@@ -2277,8 +2277,8 @@ int m_can_check_mram_cfg(struct m_can_classdev *cdev, u32 mram_max_size)
 	total_size = cdev->mcfg[MRAM_TXB].off - cdev->mcfg[MRAM_SIDF].off +
 			cdev->mcfg[MRAM_TXB].num * TXB_ELEMENT_SIZE;
 	if (total_size > mram_max_size) {
-		dev_err(cdev->dev, "Total size of mram config(%u) exceeds mram(%u)\n",
-			total_size, mram_max_size);
+		netdev_err(cdev->net, "Total size of mram config(%u) exceeds mram(%u)\n",
+			   total_size, mram_max_size);
 		return -EINVAL;
 	}
 
@@ -2313,15 +2313,15 @@ static void m_can_of_parse_mram(struct m_can_classdev *cdev,
 	cdev->mcfg[MRAM_TXB].num = mram_config_vals[7] &
 		FIELD_MAX(TXBC_NDTB_MASK);
 
-	dev_dbg(cdev->dev,
-		"sidf 0x%x %d xidf 0x%x %d rxf0 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
-		cdev->mcfg[MRAM_SIDF].off, cdev->mcfg[MRAM_SIDF].num,
-		cdev->mcfg[MRAM_XIDF].off, cdev->mcfg[MRAM_XIDF].num,
-		cdev->mcfg[MRAM_RXF0].off, cdev->mcfg[MRAM_RXF0].num,
-		cdev->mcfg[MRAM_RXF1].off, cdev->mcfg[MRAM_RXF1].num,
-		cdev->mcfg[MRAM_RXB].off, cdev->mcfg[MRAM_RXB].num,
-		cdev->mcfg[MRAM_TXE].off, cdev->mcfg[MRAM_TXE].num,
-		cdev->mcfg[MRAM_TXB].off, cdev->mcfg[MRAM_TXB].num);
+	netdev_dbg(cdev->net,
+		   "sidf 0x%x %d xidf 0x%x %d rxf0 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
+		   cdev->mcfg[MRAM_SIDF].off, cdev->mcfg[MRAM_SIDF].num,
+		   cdev->mcfg[MRAM_XIDF].off, cdev->mcfg[MRAM_XIDF].num,
+		   cdev->mcfg[MRAM_RXF0].off, cdev->mcfg[MRAM_RXF0].num,
+		   cdev->mcfg[MRAM_RXF1].off, cdev->mcfg[MRAM_RXF1].num,
+		   cdev->mcfg[MRAM_RXB].off, cdev->mcfg[MRAM_RXB].num,
+		   cdev->mcfg[MRAM_TXE].off, cdev->mcfg[MRAM_TXE].num,
+		   cdev->mcfg[MRAM_TXB].off, cdev->mcfg[MRAM_TXB].num);
 }
 
 int m_can_class_get_clocks(struct m_can_classdev *cdev)
@@ -2332,7 +2332,7 @@ int m_can_class_get_clocks(struct m_can_classdev *cdev)
 	cdev->cclk = devm_clk_get(cdev->dev, "cclk");
 
 	if (IS_ERR(cdev->hclk) || IS_ERR(cdev->cclk)) {
-		dev_err(cdev->dev, "no clock found\n");
+		netdev_err(cdev->net, "no clock found\n");
 		ret = -ENODEV;
 	}
 
@@ -2417,7 +2417,7 @@ int m_can_class_register(struct m_can_classdev *cdev)
 	}
 
 	if (!cdev->net->irq) {
-		dev_dbg(cdev->dev, "Polling enabled, initialize hrtimer");
+		netdev_dbg(cdev->net, "Polling enabled, initialize hrtimer");
 		hrtimer_setup(&cdev->hrtimer, m_can_polling_timer, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_PINNED);
 	} else {
@@ -2431,15 +2431,15 @@ int m_can_class_register(struct m_can_classdev *cdev)
 
 	ret = register_m_can_dev(cdev);
 	if (ret) {
-		dev_err(cdev->dev, "registering %s failed (err=%d)\n",
-			cdev->net->name, ret);
+		netdev_err(cdev->net, "registering %s failed (err=%d)\n",
+			   cdev->net->name, ret);
 		goto rx_offload_del;
 	}
 
 	of_can_transceiver(cdev->net);
 
-	dev_info(cdev->dev, "%s device registered (irq=%d, version=%d)\n",
-		 KBUILD_MODNAME, cdev->net->irq, cdev->version);
+	netdev_info(cdev->net, "device registered (irq=%d, version=%d)\n",
+		    cdev->net->irq, cdev->version);
 
 	/* Probe finished
 	 * Stop clocks. They will be reactivated once the M_CAN device is opened

-- 
2.51.0


