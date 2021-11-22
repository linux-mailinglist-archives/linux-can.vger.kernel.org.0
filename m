Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F27D458ECE
	for <lists+linux-can@lfdr.de>; Mon, 22 Nov 2021 13:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbhKVNAF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Nov 2021 08:00:05 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33668 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbhKVNAE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Nov 2021 08:00:04 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AMCuls8116345;
        Mon, 22 Nov 2021 06:56:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637585807;
        bh=eVWmINi4lrTAVn2s9bs20xrtU+Q+mEUZO+xNmE4+t6I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=y1yvVryoYzJrK7Rmy9jxlGw6WFPs4QALqtfqOk//IDdtrZ1JZ+/jttiZNDfRsBPm+
         5cvDIUsLqCz92Ct7I81GUebWqHquPcN8uZm8TchIN3noAFPk+Ky9xoafpqd3244g/R
         GztTF93h+DgeLVrROU9e7ebO7Ea1h/7MfbqFVato=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AMCulL3066716
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Nov 2021 06:56:47 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 22
 Nov 2021 06:56:46 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 22 Nov 2021 06:56:46 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AMCuQi2109786;
        Mon, 22 Nov 2021 06:56:43 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH RFC v2 3/4] mux: Add support for reading mux enable state from DT
Date:   Mon, 22 Nov 2021 18:26:23 +0530
Message-ID: <20211122125624.6431-4-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122125624.6431-1-a-govindraju@ti.com>
References: <20211122125624.6431-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In some cases, we might need to provide the state of the mux to be set for
the operation of a given peripheral. Therefore, pass this information using
the second argument of the mux-controls property.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

Notes:
- The function mux_control_get() always return the mux_control for a single
  line. So, control for mutiple lines cannot be represented in the
  mux-controls property.
- For representing multiple lines of control, multiple entries need to be
  used along with mux-names for reading them.
- If a device uses both the states of the mux line then #mux-control-cells
  can be set to 1 and enable_state will not be set in this case.

 drivers/mux/core.c           | 20 ++++++++++++++++++--
 include/linux/mux/consumer.h |  1 +
 include/linux/mux/driver.h   |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 22f4709768d1..51140748d2d6 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -294,6 +294,18 @@ unsigned int mux_control_states(struct mux_control *mux)
 }
 EXPORT_SYMBOL_GPL(mux_control_states);
 
+/**
+ * mux_control_enable_state() - Query for the enable state.
+ * @mux: The mux-control to query.
+ *
+ * Return: State to be set in the mux to enable a given device
+ */
+unsigned int mux_control_enable_state(struct mux_control *mux)
+{
+	return mux->enable_state;
+}
+EXPORT_SYMBOL_GPL(mux_control_enable_state);
+
 /*
  * The mux->lock must be down when calling this function.
  */
@@ -481,8 +493,7 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 	if (!mux_chip)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	if (args.args_count > 1 ||
-	    (!args.args_count && (mux_chip->controllers > 1))) {
+	if (!args.args_count && mux_chip->controllers > 1) {
 		dev_err(dev, "%pOF: wrong #mux-control-cells for %pOF\n",
 			np, args.np);
 		put_device(&mux_chip->dev);
@@ -500,6 +511,11 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (args.args_count == 2) {
+		mux_chip->mux[controller].enable_state = args.args[1];
+		mux_chip->mux[controller].idle_state = !args.args[1];
+	}
+
 	return &mux_chip->mux[controller];
 }
 EXPORT_SYMBOL_GPL(mux_control_get);
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index 7a09b040ac39..cb861eab8aad 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -16,6 +16,7 @@ struct device;
 struct mux_control;
 
 unsigned int mux_control_states(struct mux_control *mux);
+unsigned int mux_control_enable_state(struct mux_control *mux);
 int __must_check mux_control_select_delay(struct mux_control *mux,
 					  unsigned int state,
 					  unsigned int delay_us);
diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
index 18824064f8c0..7db378dabdb2 100644
--- a/include/linux/mux/driver.h
+++ b/include/linux/mux/driver.h
@@ -48,6 +48,7 @@ struct mux_control {
 	int cached_state;
 
 	unsigned int states;
+	unsigned int enable_state;
 	int idle_state;
 
 	ktime_t last_change;
-- 
2.17.1

