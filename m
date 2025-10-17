Return-Path: <linux-can+bounces-5211-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D57BE986F
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 17:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C05B1AA3B42
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAC932E147;
	Fri, 17 Oct 2025 15:08:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2732C95E
	for <linux-can@vger.kernel.org>; Fri, 17 Oct 2025 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713718; cv=none; b=dIbe81yl0sPIbSRXqUqrxXTKiynW5FHTicQo2ByQDYLS86ZhMTY5UmMOUVRDmJsZcmm78EYiW/rODaH4GJYjTPnhwaxEEy6m0/hX/bjyWA40HSV75QAQsmdIsSf1fVJZiu/JCOQzwAEHz9ngXUrtVLizMYrzseHHBpJNDc4JYRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713718; c=relaxed/simple;
	bh=MqwY1f71HV4MQYkm9sC8OJmjO7tDWOavvgdZJ2JhYGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huLZSCC6sM3zHJzYkK58nekfgSZSLyyWQGwHKuEQPj90JkDBHKJs9eo+kiQM9atdObikAELtZ49aEFHWTqg2Hgv+z+tLqgNsTusmgBSnoFRLySSJk8C55+xgm3D6ReL3xQp8sanBwL8Pndu5w1w90UhL4YkWynAim62Ba83Y+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4E-0003NM-2R; Fri, 17 Oct 2025 17:08:30 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4D-00450h-2U;
	Fri, 17 Oct 2025 17:08:29 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 75B004892B7;
	Fri, 17 Oct 2025 15:08:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	"Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 06/13] can: m_can: Support pinctrl wakeup state
Date: Fri, 17 Oct 2025 17:04:14 +0200
Message-ID: <20251017150819.1415685-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017150819.1415685-1-mkl@pengutronix.de>
References: <20251017150819.1415685-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>

TI AM62x SoC requires a wakeup flag being set in pinctrl when mcan pins
act as a wakeup source. Add support to select the wakeup state if WOL
is enabled.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
Link: https://patch.msgid.link/20251001-topic-mcan-wakeup-source-v6-12-v10-4-4ab508ac5d1e@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 69 ++++++++++++++++++++++++++++++++++-
 drivers/net/can/m_can/m_can.h |  3 ++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 10b5862b4880..8569596ae830 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2265,7 +2265,26 @@ static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 		return ret;
 	}
 
+	if (!IS_ERR_OR_NULL(cdev->pinctrl_state_wakeup)) {
+		if (wol_enable)
+			ret = pinctrl_select_state(cdev->pinctrl, cdev->pinctrl_state_wakeup);
+		else
+			ret = pinctrl_pm_select_default_state(cdev->dev);
+
+		if (ret) {
+			netdev_err(cdev->net, "Failed to select pinctrl state %pE\n",
+				   ERR_PTR(ret));
+			goto err_wakeup_enable;
+		}
+	}
+
 	return 0;
+
+err_wakeup_enable:
+	/* Revert wakeup enable */
+	device_set_wakeup_enable(cdev->dev, !wol_enable);
+
+	return ret;
 }
 
 static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
@@ -2393,6 +2412,42 @@ int m_can_class_get_clocks(struct m_can_classdev *cdev)
 }
 EXPORT_SYMBOL_GPL(m_can_class_get_clocks);
 
+static bool m_can_class_wakeup_pinctrl_enabled(struct m_can_classdev *class_dev)
+{
+	return device_may_wakeup(class_dev->dev) && class_dev->pinctrl_state_wakeup;
+}
+
+static int m_can_class_parse_pinctrl(struct m_can_classdev *class_dev)
+{
+	struct device *dev = class_dev->dev;
+	int ret;
+
+	class_dev->pinctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(class_dev->pinctrl)) {
+		ret = PTR_ERR(class_dev->pinctrl);
+		class_dev->pinctrl = NULL;
+
+		if (ret == -ENODEV)
+			return 0;
+
+		return dev_err_probe(dev, ret, "Failed to get pinctrl\n");
+	}
+
+	class_dev->pinctrl_state_wakeup =
+		pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
+	if (IS_ERR(class_dev->pinctrl_state_wakeup)) {
+		ret = PTR_ERR(class_dev->pinctrl_state_wakeup);
+		class_dev->pinctrl_state_wakeup = NULL;
+
+		if (ret == -ENODEV)
+			return 0;
+
+		return dev_err_probe(dev, ret, "Failed to lookup pinctrl wakeup state\n");
+	}
+
+	return 0;
+}
+
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 						int sizeof_priv)
 {
@@ -2434,7 +2489,15 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	m_can_of_parse_mram(class_dev, mram_config_vals);
 	spin_lock_init(&class_dev->tx_handling_spinlock);
 
+	ret = m_can_class_parse_pinctrl(class_dev);
+	if (ret)
+		goto err_free_candev;
+
 	return class_dev;
+
+err_free_candev:
+	free_candev(net_dev);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
 
@@ -2563,7 +2626,8 @@ int m_can_class_suspend(struct device *dev)
 		cdev->can.state = CAN_STATE_SLEEPING;
 	}
 
-	pinctrl_pm_select_sleep_state(dev);
+	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
+		pinctrl_pm_select_sleep_state(dev);
 
 	return ret;
 }
@@ -2575,7 +2639,8 @@ int m_can_class_resume(struct device *dev)
 	struct net_device *ndev = cdev->net;
 	int ret = 0;
 
-	pinctrl_pm_select_default_state(dev);
+	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
+		pinctrl_pm_select_default_state(dev);
 
 	if (netif_running(ndev)) {
 		ret = m_can_clk_start(cdev);
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 7b7600697c6b..f2f89687bbd2 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -129,6 +129,9 @@ struct m_can_classdev {
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 
 	struct hrtimer hrtimer;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_state_wakeup;
 };
 
 struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);
-- 
2.51.0


