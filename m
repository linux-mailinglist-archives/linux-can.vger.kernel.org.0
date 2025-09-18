Return-Path: <linux-can+bounces-4731-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B08B83367
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 08:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49778623901
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 06:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC7F2EA170;
	Thu, 18 Sep 2025 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CZHo36Yx"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA112EA472
	for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 06:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178183; cv=none; b=Fu3V7fgyGuSGlq14ornyarf8N2EbOMgvta5IRSGcXd3Pyun4x7ovoCYo1kkmUxrUhFohdkQb3xuWGhhgzxtOv81cKqpi5uvW0k8gDefLYamWU9fJQ1m4p106+oHiZ9FDTTr5Yl42H6XQEW+xuHsfgOtXDcjvHzzCG//xO2g92zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178183; c=relaxed/simple;
	bh=XIJvWvHW265ZfnWJtSD3436SgEvIMakFTAgcB9nrvZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oAZ5exyL6KMOlFA/XjHONjTLmoXwaV+RiobZZNw3aNR7nkEzaHdW0kx0s7VRXTVlw8I2+GCOkD/8bZ0LN2FFP2NAfdCMmPMSZ20E2Xapkmijl/58WO9XCH8g+21vT006fpEzb1oaL/5AWKb7fG8S2DRjvTmb9oxF7oKJhakT0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CZHo36Yx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3tGq4026799
	for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 06:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EjJ+nnIxrqR
	5U0oBFkYaeQwZN8leUg0wI1FoS7e/7j8=; b=CZHo36YxDNt8oUP8IW9a5qXsH2L
	GlCj8YQMU/hCXAybjfUkQP+zi1Ab3YpRqW/BeifoPYvcC4WP2Uz81fbSCtq6Ag0K
	8fGFrT3fubWzX0BJWk/R6ksv8XmywqnB8JyclZeqiTJ9hkymBnZXs7ozVPePUWwK
	/60/OCLaE/HbfoaYJCK8FO7WYAtK6dF2FHoaYCNQu/L5kct1mzBFNQAMZcbWYKmF
	Rjt+9jrRl2OyfFnBAe4PCKaI64pATICbZPSunAxFKoXU2YT922HRmlTp65zAYk5h
	N288XdndfnKFzVr2YxPqYTtOEO8g6oNr5Kog6k7KlhH9EKy+xNchkvWh8eA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt59m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Thu, 18 Sep 2025 06:49:41 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77b73bddbdcso743539b3a.1
        for <linux-can@vger.kernel.org>; Wed, 17 Sep 2025 23:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758178180; x=1758782980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjJ+nnIxrqR5U0oBFkYaeQwZN8leUg0wI1FoS7e/7j8=;
        b=U/HQfAMNLGLMCwb1QuuEfNpvczPMRin1Rw3U9bGHxEbg+E6HszN5+HGfdPQqrzcJqN
         PHtDJRBH7GI+fyA8ZXnc0c56yKoh2HquNbsPVXgJjSytVmakF/CqWGa7syIzb8ksMbCB
         bvGphbB6audLtrkTWRjvuBCizwYSNd7G4AN3HaeSK8er7b5an27VoSW2VyYa8hwENYx9
         DyVBtkmmASxpEVF1dQMQIBYDgFQkqRyekuXbqOiNo4IAmfxthHxD/k7262AoP0gTtaS7
         vuxjLmx6e3MUQG8dPEOCGN+X8rfvA4tcqIZ2uW7lsyEEM1SpA8sooRSpyJ2RlHR0CsFz
         R6eg==
X-Forwarded-Encrypted: i=1; AJvYcCV75t5Y5f6wCCn7dxv/4ATXhoKRdlgRitWON4gVh2/su23BtvRfsySElCd5Wipsi2vsHue/KW6Pla4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaDYNYu98734KkdDkakSNrktVatK2BRe+e9RkJApCPjHJq+Z90
	JnHQBcZ+xGONGmIP9pEZPm8CAm8JopY4cADeFrYL4DR6wgTMwFxKZD20ax3HgnkmAXbumjQv10I
	PqJmsH+A1sSzsqyoHKg9p5Z4QoVOLtSZo8XLGobClYEXrC4XDUK2MLUQqYzOwQs4=
X-Gm-Gg: ASbGncuMxDwwk/0kzrnx6bWr2O+C4kXm0dM8kuBs/lRr9sbNeMyXfpYl85h1oBsEln0
	PKujDHwLoB69QT0tGE0rC6KX8RGiMEPgrB6/RU9ka6esaKvt+gf3z0g6NaVPKoMgDenDYCdU9dO
	VxdnekJdCM9VL6VkJRChBDXShxYkrxg0uMsV85sWJXq57ZXJ6dzL7NOVa0i6rLUZgQf5h8SeojX
	XM+8j6QED/ya2TYqVuBwHsYrBXanSTB5by1hU36eMpG37V6w5I8qgR3mgajzbXkieuLdBU3gRN7
	EF46FmUUmr1VgZN2iB1lrRHs/DZ4aoF6/Hg5qzblCIMXD25mm4GpRur4zB3VKXjdKLGUZQ+ymh5
	V
X-Received: by 2002:a05:6a00:8708:b0:772:348b:8883 with SMTP id d2e1a72fcca58-77ce2166ec6mr1811608b3a.13.1758178180494;
        Wed, 17 Sep 2025 23:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCn+8s4q7iimDMW0J/cJw8W6sXaW8w/rvJ/tsR4OfgkpNVdbOMi9w5wb9ge8YKF8CbH3WuYQ==
X-Received: by 2002:a05:6a00:8708:b0:772:348b:8883 with SMTP id d2e1a72fcca58-77ce2166ec6mr1811587b3a.13.1758178180013;
        Wed, 17 Sep 2025 23:49:40 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff22bdb5sm1356789b3a.94.2025.09.17.23.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 23:49:39 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com,
        mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v4 5/6] can: mcp251xfd: add gpio functionality
Date: Thu, 18 Sep 2025 12:19:02 +0530
Message-Id: <20250918064903.241372-6-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XwXab5ESdEuSS-es9G01jPEAD8x903XM
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68cbab85 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=8f9FM25-AAAA:8 a=EUspDBNiAAAA:8 a=tLDx1KCooYQGmN993QAA:9
 a=IoOABgeZipijB_acs4fv:22 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/escRqOFxLOj
 uJFhkJc/JGgo5QRIlCx+PVSAVxbPaUrOiOSqPpI47f6eoT2J1z+oMs+GTFf9zDlFE/uguNVf6U9
 nLIK0O9NLFZFfJ0b7ugRDCIKIYGl6c3HkzYgXXS+3qtoiqsgJsSV1PzrRfTAvJbvw3PQCwGNWvp
 6OVKE8u27CwEKxLJD63Ly6iX2dkXGPpDWiHf50i3KkD5HyEYG55wahP0pEJ5RyGVMf/h5er9uHS
 cc9eGkgUe0VdudnrTJzN8ozjuyI+NdoryR01qspSZG8Hb38Y4Xh0OWKioHLTWMET5ES5xAeRO/O
 cNTNQdilvf52+0c4xUniiBRBo+wYsszrlt/i7UN8X8+qA6GyHDyHoskMa4PmDzaSDohlq/vmLsR
 4WY7SL6z
X-Proofpoint-ORIG-GUID: XwXab5ESdEuSS-es9G01jPEAD8x903XM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

From: Gregor Herburger <gregor.herburger@ew.tq-group.com>

The mcp251xfd devices allow two pins to be configured as gpio. Add this
functionality to driver.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Tested-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 179 ++++++++++++++++++
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   4 +
 2 files changed, 183 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index ea41f04ae1a6..8c253091f498 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -16,6 +16,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/gpio/driver.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
@@ -1797,6 +1798,178 @@ static int mcp251xfd_register_check_rx_int(struct mcp251xfd_priv *priv)
 	return 0;
 }
 
+#ifdef CONFIG_GPIOLIB
+static const char * const mcp251xfd_gpio_names[] = { "GPIO0", "GPIO1" };
+
+static int mcp251xfd_gpio_request(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 pin_mask = MCP251XFD_REG_IOCON_PM(offset);
+	int ret;
+
+	if (priv->rx_int && offset == 1) {
+		netdev_err(priv->ndev, "Can't use GPIO 1 with RX-INT!\n");
+		return -EINVAL;
+	}
+
+	ret = pm_runtime_resume_and_get(priv->ndev->dev.parent);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				  pin_mask, pin_mask);
+}
+
+static void mcp251xfd_gpio_free(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+
+	pm_runtime_put(priv->ndev->dev.parent);
+}
+
+static int mcp251xfd_gpio_get_direction(struct gpio_chip *chip,
+					unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 mask = MCP251XFD_REG_IOCON_TRIS(offset);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
+	if (ret)
+		return ret;
+
+	if (mask & val)
+		return GPIO_LINE_DIRECTION_IN;
+
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int mcp251xfd_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 mask = MCP251XFD_REG_IOCON_GPIO(offset);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
+	if (ret)
+		return ret;
+
+	return !!(mask & val);
+}
+
+static int mcp251xfd_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
+				       unsigned long *bit)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->map_reg, MCP251XFD_REG_IOCON, &val);
+	if (ret)
+		return ret;
+
+	*bit = FIELD_GET(MCP251XFD_REG_IOCON_GPIO_MASK, val) & *mask;
+
+	return 0;
+}
+
+static int mcp251xfd_gpio_direction_output(struct gpio_chip *chip,
+					   unsigned int offset, int value)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 dir_mask = MCP251XFD_REG_IOCON_TRIS(offset);
+	u32 val_mask = MCP251XFD_REG_IOCON_LAT(offset);
+	u32 val;
+
+	if (value)
+		val = val_mask;
+	else
+		val = 0;
+
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				  dir_mask | val_mask, val);
+}
+
+static int mcp251xfd_gpio_direction_input(struct gpio_chip *chip,
+					  unsigned int offset)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 dir_mask = MCP251XFD_REG_IOCON_TRIS(offset);
+
+	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				  dir_mask, dir_mask);
+}
+
+static void mcp251xfd_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			       int value)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 val_mask = MCP251XFD_REG_IOCON_LAT(offset);
+	u32 val;
+	int ret;
+
+	if (value)
+		val = val_mask;
+	else
+		val = 0;
+
+	ret = regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				 val_mask, val);
+	if (ret)
+		dev_err(&priv->spi->dev, "Failed to set GPIO %u: %d\n",
+			offset, ret);
+}
+
+static void mcp251xfd_gpio_set_multiple(struct gpio_chip *chip, unsigned long *mask,
+					unsigned long *bits)
+{
+	struct mcp251xfd_priv *priv = gpiochip_get_data(chip);
+	u32 val;
+	int ret;
+
+	val = FIELD_PREP(MCP251XFD_REG_IOCON_LAT_MASK, *bits);
+
+	ret = regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
+				 MCP251XFD_REG_IOCON_LAT_MASK, val);
+	if (ret)
+		dev_err(&priv->spi->dev, "Failed to set GPIOs %d\n", ret);
+}
+
+static int mcp251fdx_gpio_setup(struct mcp251xfd_priv *priv)
+{
+	struct gpio_chip *gc = &priv->gc;
+
+	if (!device_property_present(&priv->spi->dev, "gpio-controller"))
+		return 0;
+
+	gc->label = dev_name(&priv->spi->dev);
+	gc->parent = &priv->spi->dev;
+	gc->owner = THIS_MODULE;
+	gc->request = mcp251xfd_gpio_request;
+	gc->free = mcp251xfd_gpio_free;
+	gc->get_direction = mcp251xfd_gpio_get_direction;
+	gc->direction_output = mcp251xfd_gpio_direction_output;
+	gc->direction_input = mcp251xfd_gpio_direction_input;
+	gc->get = mcp251xfd_gpio_get;
+	gc->get_multiple = mcp251xfd_gpio_get_multiple;
+	gc->set = mcp251xfd_gpio_set;
+	gc->set_multiple = mcp251xfd_gpio_set_multiple;
+	gc->base = -1;
+	gc->can_sleep = true;
+	gc->ngpio = ARRAY_SIZE(mcp251xfd_gpio_names);
+	gc->names = mcp251xfd_gpio_names;
+
+	return devm_gpiochip_add_data(&priv->spi->dev, gc, priv);
+}
+#else
+static inline int mcp251fdx_gpio_setup(struct mcp251xfd_priv *priv)
+{
+	return 0;
+}
+#endif
+
 static int
 mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
 			      u32 *effective_speed_hz_slow,
@@ -1930,6 +2103,12 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
 
 	mcp251xfd_ethtool_init(priv);
 
+	err = mcp251fdx_gpio_setup(priv);
+	if (err) {
+		dev_err_probe(&priv->spi->dev, err, "Failed to register gpio-controller.\n");
+		goto out_runtime_disable;
+	}
+
 	err = register_candev(ndev);
 	if (err)
 		goto out_runtime_disable;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index bd28510a6583..fd9e005708e4 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -15,6 +15,7 @@
 #include <linux/can/dev.h>
 #include <linux/can/rx-offload.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/regmap.h>
@@ -676,6 +677,9 @@ struct mcp251xfd_priv {
 
 	struct mcp251xfd_devtype_data devtype_data;
 	struct can_berr_counter bec;
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gc;
+#endif
 };
 
 #define MCP251XFD_IS(_model) \
-- 
2.34.1


