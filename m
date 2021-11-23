Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1E3459D82
	for <lists+linux-can@lfdr.de>; Tue, 23 Nov 2021 09:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhKWIQM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Nov 2021 03:16:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51108 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhKWIQJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Nov 2021 03:16:09 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AN8CiV0018369;
        Tue, 23 Nov 2021 02:12:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637655164;
        bh=67aIcOkswqKyrdq+H++ZQwtZJ3cXkK9R7dfy3beKjOU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TMIKs8kbol1j5aZo0E3JOldXLmOnfnvWDiXxFJcvAEGbRzPQuM1AFsAqLeZP1mdAR
         1kwOmpAnEXIkOr1rPmPLwGrtw4HSYiJpBSrCSKegrp3z9dmR7fhCCMI8F7q6PUxUI5
         qQdeYkAhumGVZEhpDTpvxox1sS/Ut1+fCtouFpAQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AN8CijD017209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Nov 2021 02:12:44 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 23
 Nov 2021 02:12:43 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 23 Nov 2021 02:12:43 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AN8CNe1101399;
        Tue, 23 Nov 2021 02:12:39 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH RFC v3 3/4] mux: Add support for reading mux enable state from DT
Date:   Tue, 23 Nov 2021 13:42:20 +0530
Message-ID: <20211123081222.27979-4-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211123081222.27979-1-a-govindraju@ti.com>
References: <20211123081222.27979-1-a-govindraju@ti.com>
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
 drivers/mux/core.c           | 146 ++++++++++++++++++++++++++++++++++-
 include/linux/mux/consumer.h |  19 ++++-
 include/linux/mux/driver.h   |  13 ++++
 3 files changed, 173 insertions(+), 5 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 22f4709768d1..9622b98f9818 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -370,6 +370,29 @@ int mux_control_select_delay(struct mux_control *mux, unsigned int state,
 }
 EXPORT_SYMBOL_GPL(mux_control_select_delay);
 
+/**
+ * mux_state_select_delay() - Select the enable state in mux-state
+ * @mux: The mux-state to request a change of state from.
+ * @delay_us: The time to delay (in microseconds) if the mux state is changed.
+ *
+ * On successfully selecting the enable state, it will be locked until
+ * there is a call to mux_state_deselect(). If the mux-control is already
+ * selected when mux_state_select() is called, the caller will be blocked
+ * until mux_state_deselect() is called (by someone else).
+ *
+ * Therefore, make sure to call mux_state_deselect() when the operation is
+ * complete and the mux-control is free for others to use, but do not call
+ * mux_state_deselect() if mux_state_select() fails.
+ *
+ * Return: 0 when the mux-state has the enable state or a negative
+ * errno on error.
+ */
+int mux_state_select_delay(struct mux_state *mux, unsigned int delay_us)
+{
+	return mux_control_select_delay(mux->mux, mux->enable_state, delay_us);
+}
+EXPORT_SYMBOL_GPL(mux_state_select_delay);
+
 /**
  * mux_control_try_select_delay() - Try to select the given multiplexer state.
  * @mux: The mux-control to request a change of state from.
@@ -405,6 +428,27 @@ int mux_control_try_select_delay(struct mux_control *mux, unsigned int state,
 }
 EXPORT_SYMBOL_GPL(mux_control_try_select_delay);
 
+/**
+ * mux_state_try_select_delay() - Try to select the multiplexer enable state.
+ * @mux: The mux-control to request a change of state from.
+ * @delay_us: The time to delay (in microseconds) if the mux state is changed.
+ *
+ * On successfully selecting the enable state, it will be locked until
+ * mux_state_deselect() called.
+ *
+ * Therefore, make sure to call mux_state_deselect() when the operation is
+ * complete and the mux-control is free for others to use, but do not call
+ * mux_state_deselect() if mux_state_try_select() fails.
+ *
+ * Return: 0 when the mux-control state has the requested state or a negative
+ * errno on error. Specifically -EBUSY if the mux-control is contended.
+ */
+int mux_state_try_select_delay(struct mux_state *mux, unsigned int delay_us)
+{
+	return mux_control_try_select_delay(mux->mux, mux->enable_state, delay_us);
+}
+EXPORT_SYMBOL_GPL(mux_state_try_select_delay);
+
 /**
  * mux_control_deselect() - Deselect the previously selected multiplexer state.
  * @mux: The mux-control to deselect.
@@ -431,6 +475,24 @@ int mux_control_deselect(struct mux_control *mux)
 }
 EXPORT_SYMBOL_GPL(mux_control_deselect);
 
+/**
+ * mux_state_deselect() - Deselect the previously selected multiplexer state.
+ * @mux: The mux-state to deselect.
+ *
+ * It is required that a single call is made to mux_state_deselect() for
+ * each and every successful call made to either of mux_state_select() or
+ * mux_state_try_select().
+ *
+ * Return: 0 on success and a negative errno on error. An error can only
+ * occur if the mux has an idle state. Note that even if an error occurs, the
+ * mux-control is unlocked and is thus free for the next access.
+ */
+int mux_state_deselect(struct mux_state *mux)
+{
+	return mux_control_deselect(mux->mux);
+}
+EXPORT_SYMBOL_GPL(mux_state_deselect);
+
 /* Note this function returns a reference to the mux_chip dev. */
 static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
 {
@@ -442,13 +504,15 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
 }
 
 /**
- * mux_control_get() - Get the mux-control for a device.
+ * mux_get() - Get the mux-control for a device.
  * @dev: The device that needs a mux-control.
  * @mux_name: The name identifying the mux-control.
+ * @enable_state: The variable to store the enable state for the requested device
  *
  * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
  */
-struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
+static struct mux_control *mux_get(struct device *dev, const char *mux_name,
+				   unsigned int *enable_state)
 {
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args args;
@@ -481,8 +545,7 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 	if (!mux_chip)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	if (args.args_count > 1 ||
-	    (!args.args_count && (mux_chip->controllers > 1))) {
+	if (!args.args_count && mux_chip->controllers > 1) {
 		dev_err(dev, "%pOF: wrong #mux-control-cells for %pOF\n",
 			np, args.np);
 		put_device(&mux_chip->dev);
@@ -500,8 +563,25 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (args.args_count == 2)
+		*enable_state = args.args[1];
+
 	return &mux_chip->mux[controller];
 }
+
+/**
+ * mux_control_get() - Get the mux-control for a device.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
+{
+	int state;
+
+	return mux_get(dev, mux_name, &state);
+}
 EXPORT_SYMBOL_GPL(mux_control_get);
 
 /**
@@ -523,6 +603,26 @@ static void devm_mux_control_release(struct device *dev, void *res)
 	mux_control_put(mux);
 }
 
+/**
+ * mux_state_put() - Put away the mux-state for good.
+ * @mux: The mux-state to put away.
+ *
+ * mux_control_put() reverses the effects of mux_control_get().
+ */
+void mux_state_put(struct mux_state *mux_state)
+{
+	mux_control_put(mux_state->mux);
+	kfree(mux_state);
+}
+EXPORT_SYMBOL_GPL(mux_state_put);
+
+static void devm_mux_state_release(struct device *dev, void *res)
+{
+	struct mux_state *mux = *(struct mux_state **)res;
+
+	mux_state_put(mux);
+}
+
 /**
  * devm_mux_control_get() - Get the mux-control for a device, with resource
  *			    management.
@@ -553,6 +653,44 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_mux_control_get);
 
+/**
+ * devm_mux_state_get() - Get the mux-state for a device, with resource
+ *			  management.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ */
+struct mux_state *devm_mux_state_get(struct device *dev,
+				     const char *mux_name)
+{
+	struct mux_state **ptr, *mux_state;
+	struct mux_control *mux_ctrl;
+	int enable_state;
+
+	mux_state = devm_kzalloc(dev, sizeof(struct mux_state), GFP_KERNEL);
+	if (!mux_state)
+		return ERR_PTR(-ENOMEM);
+
+	ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	mux_ctrl = mux_get(dev, mux_name, &enable_state);
+	if (IS_ERR(mux_ctrl)) {
+		devres_free(ptr);
+		return (struct mux_state *)mux_ctrl;
+	}
+
+	mux_state->mux = mux_ctrl;
+	mux_state->enable_state = enable_state;
+	*ptr = mux_state;
+	devres_add(dev, ptr);
+
+	return mux_state;
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get);
+
 /*
  * Using subsys_initcall instead of module_init here to try to ensure - for
  * the non-modular case - that the subsystem is initialized when mux consumers
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index 7a09b040ac39..d0f3242e148d 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -14,33 +14,50 @@
 
 struct device;
 struct mux_control;
+struct mux_state;
 
 unsigned int mux_control_states(struct mux_control *mux);
 int __must_check mux_control_select_delay(struct mux_control *mux,
 					  unsigned int state,
 					  unsigned int delay_us);
+int __must_check mux_state_select_delay(struct mux_state *mux,
+					unsigned int delay_us);
 int __must_check mux_control_try_select_delay(struct mux_control *mux,
 					      unsigned int state,
 					      unsigned int delay_us);
-
+int __must_check mux_state_try_select_delay(struct mux_state *mux,
+					    unsigned int delay_us);
 static inline int __must_check mux_control_select(struct mux_control *mux,
 						  unsigned int state)
 {
 	return mux_control_select_delay(mux, state, 0);
 }
 
+static inline int __must_check mux_state_select(struct mux_state *mux)
+{
+	return mux_state_select_delay(mux, 0);
+}
 static inline int __must_check mux_control_try_select(struct mux_control *mux,
 						      unsigned int state)
 {
 	return mux_control_try_select_delay(mux, state, 0);
 }
 
+static inline int __must_check mux_state_try_select(struct mux_state *mux)
+{
+	return mux_state_try_select_delay(mux, 0);
+}
+
 int mux_control_deselect(struct mux_control *mux);
+int mux_state_deselect(struct mux_state *mux);
 
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
 void mux_control_put(struct mux_control *mux);
+void mux_state_put(struct mux_state *mux);
 
 struct mux_control *devm_mux_control_get(struct device *dev,
 					 const char *mux_name);
+struct mux_state *devm_mux_state_get(struct device *dev,
+				     const char *mux_name);
 
 #endif /* _LINUX_MUX_CONSUMER_H */
diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
index 18824064f8c0..c7236f307fbd 100644
--- a/include/linux/mux/driver.h
+++ b/include/linux/mux/driver.h
@@ -53,6 +53,19 @@ struct mux_control {
 	ktime_t last_change;
 };
 
+/**
+ * struct mux_state -	Represents a mux controller specific to a given device
+ * @mux:		Pointer to a mux controller
+ * @enable_state	State of the mux to be set for enabling a device
+ *
+ * This structure is specific to a device that acquires it and has information
+ * specific to the device.
+ */
+struct mux_state {
+	struct mux_control *mux;
+	unsigned int enable_state;
+};
+
 /**
  * struct mux_chip -	Represents a chip holding mux controllers.
  * @controllers:	Number of mux controllers handled by the chip.
-- 
2.17.1

