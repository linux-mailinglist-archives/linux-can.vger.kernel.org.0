Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01AC912CA9E
	for <lists+linux-can@lfdr.de>; Sun, 29 Dec 2019 20:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfL2TVj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 29 Dec 2019 14:21:39 -0500
Received: from relay-b03.edpnet.be ([212.71.1.220]:49946 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfL2TVj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 29 Dec 2019 14:21:39 -0500
X-ASG-Debug-ID: 1577647292-0a881838821e9eb50003-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.251.adsl.dyn.edpnet.net [77.109.105.251]) by relay-b03.edpnet.be with ESMTP id ddLVsluFVPRxLYnx; Sun, 29 Dec 2019 20:21:34 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.251.adsl.dyn.edpnet.net[77.109.105.251]
X-Barracuda-Apparent-Source-IP: 77.109.105.251
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id C716DC02E54;
        Sun, 29 Dec 2019 20:21:33 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-input@vger.kernel.org
Cc:     linux-can@vger.kernel.org,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 6/6] cap11xx: export major chip settings to sysfs
Date:   Sun, 29 Dec 2019 20:21:17 +0100
X-ASG-Orig-Subj: [PATCH 6/6] cap11xx: export major chip settings to sysfs
Message-Id: <1577647277-8298-7-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1577647277-8298-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.105.251.adsl.dyn.edpnet.net[77.109.105.251]
X-Barracuda-Start-Time: 1577647294
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 6389
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 1.0000 1.0000 4.3428
X-Barracuda-Spam-Score: 4.84
X-Barracuda-Spam-Status: No, SCORE=4.84 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_SC0_MV0713, BSF_SC0_MV0713_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78985
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.30 BSF_SC0_MV0713_2       BSF_SC0_MV0713_2
        0.20 BSF_SC0_MV0713         Custom rule MV0713
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/input/keyboard/cap11xx.c | 161 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index cdcc89b9..eb68efc 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -346,6 +346,159 @@ static int cap11xx_init_leds(struct device *dev,
 }
 #endif
 
+/* register attribute:
+ * create a simple way to export properties in the register map
+ */
+struct register_attribute {
+	struct device_attribute dev_attr;
+	int reg;
+	int mask;
+	int shift;
+};
+#define to_reg_attr(_dev_attr) container_of((dev_attr), \
+		struct register_attribute, dev_attr)
+#define to_dev_attr(_attr) container_of(attr, struct device_attribute, attr)
+
+static ssize_t show_reg_attr(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct cap11xx_priv *priv = dev_get_drvdata(dev);
+	struct register_attribute *rattr = to_reg_attr(attr);
+	int ret, value;
+
+	ret = regmap_read(priv->regmap, rattr->reg, &value);
+	if (ret < 0)
+		return ret;
+	return sprintf(buf, "0x%02x\n", (value >> rattr->shift) & rattr->mask);
+}
+
+static ssize_t store_reg_attr(struct device *dev, struct device_attribute * attr,
+		const char *buf, size_t len)
+{
+	struct cap11xx_priv *priv = dev_get_drvdata(dev);
+	struct register_attribute *rattr = to_reg_attr(attr);
+	int ret;
+	long value;
+
+	ret = kstrtoul(buf, 0, &value);
+	if (ret)
+		return ret;
+
+	if (value & ~rattr->mask)
+		return -ERANGE;
+
+	ret = regmap_update_bits(priv->regmap, rattr->reg,
+			rattr->mask << rattr->shift, value << rattr->shift);
+	if (ret)
+		return ret;
+	return len;
+}
+
+#define REG_ATTR(_name, _mode, _reg, _nbits, _shift) \
+	struct register_attribute reg_dev_attr_##_name = { \
+		__ATTR(_name, _mode, show_reg_attr, store_reg_attr), \
+		.reg = _reg, \
+		.mask = (1 << (_nbits)) -1, \
+		.shift = _shift, \
+	}
+#define TO_ATTR(_name) (&(reg_dev_attr_##_name).dev_attr.attr)
+
+static REG_ATTR(gain, 0644, CAP11XX_REG_MAIN_CONTROL, 2, 6);
+static REG_ATTR(delta_sense, 0644, CAP11XX_REG_SENSITIVITY_CONTROL, 3, 4);
+static REG_ATTR(base_shift, 0644, CAP11XX_REG_SENSITIVITY_CONTROL, 4, 0);
+static REG_ATTR(dis_dig_noise, 0644, CAP11XX_REG_CONFIG, 1, 5);
+static REG_ATTR(dis_ana_noise, 0644, CAP11XX_REG_CONFIG, 1, 4);
+static REG_ATTR(max_dur_enable, 0644, CAP11XX_REG_CONFIG, 1, 3);
+static REG_ATTR(cs_en, 0644, CAP11XX_REG_SENSOR_ENABLE, 8, 0);
+static REG_ATTR(max_dur, 0644, CAP11XX_REG_SENSOR_CONFIG, 4, 4);
+static REG_ATTR(avg, 0644, CAP11XX_REG_SAMPLING_CONFIG, 3, 4);
+static REG_ATTR(samp_time, 0644, CAP11XX_REG_SAMPLING_CONFIG, 2, 2);
+static REG_ATTR(cycle_time, 0644, CAP11XX_REG_SAMPLING_CONFIG, 2, 0);
+static REG_ATTR(mulkt_blk_en, 0644, CAP11XX_REG_MT_CONFIG, 1, 7);
+static REG_ATTR(b_mult_t, 0644, CAP11XX_REG_MT_CONFIG, 2, 2);
+static REG_ATTR(mtp_en, 0644, CAP11XX_REG_MT_PATTERN_CONFIG, 1, 7);
+static REG_ATTR(mtp_th, 0644, CAP11XX_REG_MT_PATTERN_CONFIG, 2, 2);
+static REG_ATTR(comp_ptrn, 0644, CAP11XX_REG_MT_PATTERN_CONFIG, 1, 1);
+static REG_ATTR(cs_ptrn, 0644, CAP11XX_REG_MT_PATTERN, 8, 0);
+static REG_ATTR(cs_th1, 0644, CAP11XX_REG_SENSOR_THRESH(0), 8, 0);
+static REG_ATTR(cs_th2, 0644, CAP11XX_REG_SENSOR_THRESH(1), 8, 0);
+static REG_ATTR(cs_th3, 0644, CAP11XX_REG_SENSOR_THRESH(2), 8, 0);
+static REG_ATTR(cs_th4, 0644, CAP11XX_REG_SENSOR_THRESH(3), 8, 0);
+static REG_ATTR(cs_th5, 0644, CAP11XX_REG_SENSOR_THRESH(4), 8, 0);
+static REG_ATTR(cs_th6, 0644, CAP11XX_REG_SENSOR_THRESH(5), 8, 0);
+static REG_ATTR(cs_th7, 0644, CAP11XX_REG_SENSOR_THRESH(6), 8, 0);
+static REG_ATTR(cs_th8, 0644, CAP11XX_REG_SENSOR_THRESH(7), 8, 0);
+static REG_ATTR(cs_bn_th, 0644, CAP11XX_REG_SENSOR_NOISE_THRESH, 2, 0);
+static REG_ATTR(cs_led, 0644, CAP11XX_REG_SENSOR_LED_LINK, 8, 0);
+
+static struct attribute *reg_attrs[] = {
+	TO_ATTR(gain),
+	TO_ATTR(delta_sense),
+	TO_ATTR(base_shift),
+	TO_ATTR(dis_dig_noise),
+	TO_ATTR(dis_ana_noise),
+	TO_ATTR(max_dur_enable),
+	TO_ATTR(cs_en),
+	TO_ATTR(max_dur),
+	TO_ATTR(avg),
+	TO_ATTR(samp_time),
+	TO_ATTR(cycle_time),
+	TO_ATTR(mulkt_blk_en),
+	TO_ATTR(b_mult_t),
+	TO_ATTR(mtp_en),
+	TO_ATTR(mtp_th),
+	TO_ATTR(comp_ptrn),
+	TO_ATTR(cs_ptrn),
+	TO_ATTR(cs_th1),
+	TO_ATTR(cs_th2),
+	TO_ATTR(cs_th3),
+	TO_ATTR(cs_th4),
+	TO_ATTR(cs_th5),
+	TO_ATTR(cs_th6),
+	TO_ATTR(cs_th7),
+	TO_ATTR(cs_th8),
+	TO_ATTR(cs_bn_th),
+	TO_ATTR(cs_led),
+	NULL,
+};
+
+static const struct attribute_group reg_attr_group = {
+	.name = "reg",
+	.attrs = reg_attrs,
+};
+
+/* load register properties from OF */
+static int cap11xx_load_regs_from_of(struct device *dev)
+{
+	struct cap11xx_priv *priv = dev_get_drvdata(dev);
+	struct attribute **attr;
+	struct register_attribute *rattr;
+	char name[32];
+	int ret, value;
+
+	for (attr = reg_attrs; *attr; ++attr) {
+		rattr = to_reg_attr(to_dev_attr(*attr));
+
+		sprintf(name, "reg,%s", rattr->dev_attr.attr.name);
+		ret = of_property_read_u32(dev->of_node, name, &value);
+		if (ret)
+			continue;
+		if (value & ~rattr->mask) {
+			dev_warn(dev, "of %s: value %u, max %u\n",
+					name, value, rattr->mask);
+			continue;
+		}
+		ret = regmap_update_bits(priv->regmap, rattr->reg,
+				rattr->mask << rattr->shift,
+				value << rattr->shift);
+		if (ret) {
+			dev_err(dev, "of %s, regmap returned %i\n", name, ret);
+			return ret;
+		}
+	}
+	return 0;
+}
+
 static int cap11xx_i2c_remove(struct i2c_client *i2c_client)
 {
 	struct cap11xx_priv *priv = i2c_get_clientdata(i2c_client);
@@ -430,6 +583,10 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
 			return error;
 	}
 
+	error = cap11xx_load_regs_from_of(dev);
+	if (error)
+		return error;
+
 	/* Provide some useful defaults */
 	for (i = 0; i < cap->num_channels; i++)
 		priv->keycodes[i] = KEY_A + i;
@@ -491,6 +648,10 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
 	if (error)
 		return error;
 
+	error = devm_device_add_group(dev, &reg_attr_group);
+	if (error)
+		return error;
+
 	irq = irq_of_parse_and_map(node, 0);
 	if (!irq) {
 		if (!of_property_read_bool(node, "linux,irq-poll")) {
-- 
1.8.5.rc3

