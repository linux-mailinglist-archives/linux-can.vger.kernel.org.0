Return-Path: <linux-can+bounces-2989-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E25A548E7
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C7C7A5425
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 11:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4689220AF6C;
	Thu,  6 Mar 2025 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D+8WF7UZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0FE204F6E
	for <linux-can@vger.kernel.org>; Thu,  6 Mar 2025 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259763; cv=none; b=XC8pBt4rc66dQkVhHpwlDAuu8ycV0fIK69x3Q872Pv6x+BEmkhA55/wDW7b6/9eozPYtNMJXR0YwoWLP3wMRKWoFyd7ItMqEOBLDEzHYP+d54jWRAraE4GcS7PCjfv89X5QiyOzNazjhdvyRDjEZMBRFcWWTLsWYO5tl/xBUsXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259763; c=relaxed/simple;
	bh=MCR8mlvD+LHlMEDeTvlAn1OwnFD8ckM/crgbFzyaGVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QSPG2BnbreQvDx0jPqHjKZXzu+VJGYjIRVeEN2dWIiWaSdJJ9TuDH0pNqLT/+OHYwhgp/a1nkiB2TVEfDh3b6lIHhmNmpq7XUteheDd1KXlTQ3qJhUjzU+RYH5Y0fGt1hymcJvEGsuKeAnJBoe/hLZnfdhUmtr3LsfEf/f7tyc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D+8WF7UZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac0b6e8d96cso76959766b.0
        for <linux-can@vger.kernel.org>; Thu, 06 Mar 2025 03:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741259759; x=1741864559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVEl7GGxVsvJAydmpEAK0z7cXYry+D3ir8zQb7r/A3k=;
        b=D+8WF7UZka1i7DyasrGnr2TKF8wsFOk8Zi4YftQwuEP3wWJZ0P9G7uYrVw92hcuPrV
         GJj/OT7WCEDK1exdL/Fb6HCr/qXbNQkDkusG77bF5xbaONFD7Dx7KyLFfNbQiaQYvjGE
         WeQd/9/vJn/A0AgWjd/nqpM1j8RjnpWHjssmUeOM9xhLBQrRr7s90RVhY5IpE4uQOdxv
         V/4+Dy8gqZrofAe2AKXhfBHPoG5nqQI6UO3qnZsSJcs+1RSMSWJihKV36xaCw2WKJOxW
         hB3nsQZFGD8Hl37lcuEYlyV3a93oId7F4QMP6bXNoTGdCrO4pdGs0KMqim2R0QgyiCAJ
         4ecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259759; x=1741864559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVEl7GGxVsvJAydmpEAK0z7cXYry+D3ir8zQb7r/A3k=;
        b=mgiL+U8ZOq5XIhFcmsTy53Hd+8psvz7EoP2xhstq2ipZ/vN6v5ryUprW7NVc7DNki2
         sOB/3Aa3Uj0WYQNyczcapjKkakBNLG7o9AA/+yfYPsvHoVYiUTJnpO+bUUcWSDL+jEf6
         sTrw/knmIHa3aQgfr/Y0/Fl0Xk1g0DkQ4Vq6s5Z92t12h0M/W01RnTaGd+pllqOAckv4
         6bsIaWeKv1/YpeMIzt66ZMK9qZAVYHGrtPTH/PHwYnQSjKAks/Kf8nrIeuLuXlXvNDN5
         74L1ImDRWasNzNAEDcmq0kS2IA8gEtHnN1h4v/Iud6LaXoEoRjqEXEzEP0ccqxyuT4NW
         czPg==
X-Forwarded-Encrypted: i=1; AJvYcCUOWMyXbRHU56S+uCU545t1yf3PWowl5SHRXD++Wsg1qjmGH572zBbHEu/ichquq58iUrvE4HQE+Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDIhPcdk/PH6EsL1elN0DVYtKZ26iQQqFWplblErRrjRGXiyO4
	X/ww98t6+B8TnHGeVV+WruloX2zTRzxtaNFlXlyG/3BTlz9B+Cl9sSVaqnflP68=
X-Gm-Gg: ASbGncs33KIZAMkO6fJO6hRGxJbZ/8skSbUq5qKwmGROp+NX+5csTFuvKXkicSNOylR
	1VDqmqxy3GEFuqwEPaYlguW+OZqEIEVPwAY1GkRBAr+mj70XwonSIXa8zY77B6naSySs77DGCru
	C+32Jp8Y2EvXTvYl9BxGDDo1hbdMfxsjMbaod7eqWjO7K/q2k2M/1X9er2ssEiGN9hvlo4XfJdx
	Ob+y9tJ2d0ySJvO3RiX/5eN/LhW/cvusllXiAYcW/QLBHxveu46g11hhNjwcZOtxRy4qoWPDoJr
	TaOl0+D53MBiOVeyXVNshHQB3WW9/xSgLahUlpOEdQ==
X-Google-Smtp-Source: AGHT+IF3a3lHfhfzXs+A5h2hqn+LCqXVZ/19bMhntk0ZUTM1sIl49L5vTk6C51T88uqw26ghNIwGUw==
X-Received: by 2002:a17:907:388b:b0:ac1:d878:f877 with SMTP id a640c23a62f3a-ac20dafe79cmr723201666b.49.1741259758456;
        Thu, 06 Mar 2025 03:15:58 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:80ad:8144:3b07:4679])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac239481685sm80632766b.58.2025.03.06.03.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:15:58 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 06 Mar 2025 12:14:40 +0100
Subject: [PATCH v5 02/13] firmware: ti_sci: Partial-IO support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-am62-partialio-v6-12-b4-v5-2-f9323d3744a2@baylibre.com>
References: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
In-Reply-To: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Kendall Willis <k-willis@ti.com>, 
 linux-can@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6749; i=msp@baylibre.com;
 h=from:subject:message-id; bh=MCR8mlvD+LHlMEDeTvlAn1OwnFD8ckM/crgbFzyaGVA=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJPNm+++XbfPBn+sy/Ws3dYFvO8jai5cWtJzOGfKfafT
 l8L/neAraOUhUGMg0FWTJHl7oeF7+rkri+IWPfIEWYOKxPIEAYuTgGYyBUGRobFLZYHpb+/Ml52
 9Mq2kkx2E+G/Il4b//7MuOMtk/h93+UfDP8rpvWvMvF4w+S5eYphollgrvuKwv4k1jjF4P01LNv
 EXrMCAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add support for Partial-IO poweroff. In Partial-IO pins of a few
hardware units can generate system wakeups while DDR memory is not
powered resulting in a fresh boot of the system. These hardware units in
the SoC are always powered so that some logic can detect pin activity.

If the system supports Partial-IO as described in the fw capabilities, a
sys_off handler is added. This sys_off handler decides if the poweroff
is executed by entering normal poweroff or Partial-IO instead. The
decision is made by checking if wakeup is enabled on all devices that
may wake up the SoC from Partial-IO.

The possible wakeup devices are found by checking which devices
reference a "Partial-IO" system state in the list of wakeup-source
system states. Only devices that are actually enabled by the user will
be considered as an active wakeup source. If none of the wakeup sources
is enabled the system will do a normal poweroff. If at least one wakeup
source is enabled it will instead send a TI_SCI_MSG_PREPARE_SLEEP
message from the sys_off handler. Sending this message will result in an
immediate shutdown of the system. No execution is expected after this
point. The code will wait for 5s and do an emergency_restart afterwards
if Partial-IO wasn't entered at that point.

A short documentation about Partial-IO can be found in section 6.2.4.5
of the TRM at
  https://www.ti.com/lit/pdf/spruiv7

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 127 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h |   5 ++
 2 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 09d11e75e14e6a6a82f6d99ab1852c142aeb7e5f..a4b7869134779c58f4ef381a940455dea1f86153 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -6,6 +6,7 @@
  *	Nishanth Menon
  */
 
+#include "linux/stddef.h"
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/bitmap.h>
@@ -3742,6 +3743,111 @@ static const struct dev_pm_ops ti_sci_pm_ops = {
 #endif
 };
 
+/*
+ * Enter Partial-IO, which disables everything including DDR with only a small
+ * logic being active for wakeup.
+ */
+static int ti_sci_enter_partial_io(struct ti_sci_info *info)
+{
+	struct ti_sci_msg_req_prepare_sleep *req;
+	struct ti_sci_xfer *xfer;
+	struct device *dev = info->dev;
+	int ret = 0;
+
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_PREPARE_SLEEP,
+				   TI_SCI_FLAG_REQ_GENERIC_NORESPONSE,
+				   sizeof(*req), sizeof(struct ti_sci_msg_hdr));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+
+	req = (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
+	req->mode = TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO;
+	req->ctx_lo = 0;
+	req->ctx_hi = 0;
+	req->debug_flags = 0;
+
+	dev_info(dev, "Entering Partial-IO because a powered wakeup-enabled device was found.\n");
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(dev, "Mbox send fail %d\n", ret);
+		goto fail;
+	}
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
+/*
+ * Iterate all device nodes that have a wakeup-source property and check if one
+ * of the possible phandles points to a Partial-IO system state. If it
+ * does resolve the device node to an actual device and check if wakeup is
+ * enabled.
+ */
+static bool ti_sci_partial_io_wakeup_enabled(struct ti_sci_info *info)
+{
+	struct device_node *wakeup_node = NULL;
+
+	for_each_node_with_property(wakeup_node, "wakeup-source") {
+		struct of_phandle_iterator it;
+		int err;
+
+		of_for_each_phandle(&it, err, wakeup_node, "wakeup-source", NULL, 0) {
+			struct platform_device *pdev;
+			bool may_wakeup;
+
+			if (of_property_match_string(it.node, "idle-state-name", "Partial-IO"))
+				continue;
+
+			pdev = of_find_device_by_node(wakeup_node);
+			if (!pdev)
+				continue;
+
+			may_wakeup = device_may_wakeup(&pdev->dev);
+			put_device(&pdev->dev);
+
+			if (may_wakeup) {
+				dev_dbg(info->dev, "%pOF identified as wakeup source for Partial-IO\n",
+					wakeup_node);
+				of_node_put(it.node);
+				of_node_put(wakeup_node);
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
+static int ti_sci_sys_off_handler(struct sys_off_data *data)
+{
+	struct ti_sci_info *info = data->cb_data;
+	bool enter_partial_io = ti_sci_partial_io_wakeup_enabled(info);
+	int ret;
+
+	if (!enter_partial_io)
+		return NOTIFY_DONE;
+
+	ret = ti_sci_enter_partial_io(info);
+
+	if (ret) {
+		dev_err(info->dev,
+			"Failed to enter Partial-IO %pe, trying to do an emergency restart\n",
+			ERR_PTR(ret));
+		emergency_restart();
+	}
+
+	mdelay(5000);
+	emergency_restart();
+
+	return NOTIFY_DONE;
+}
+
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3885,6 +3991,19 @@ static int ti_sci_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	if (info->fw_caps & MSG_FLAG_CAPS_LPM_PARTIAL_IO) {
+		ret = devm_register_sys_off_handler(dev,
+						    SYS_OFF_MODE_POWER_OFF,
+						    SYS_OFF_PRIO_FIRMWARE,
+						    ti_sci_sys_off_handler,
+						    info);
+		if (ret) {
+			dev_err(dev, "Failed to register sys_off_handler %pe\n",
+				ERR_PTR(ret));
+			goto out;
+		}
+	}
+
 	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
 		 info->handle.version.abi_major, info->handle.version.abi_minor,
 		 info->handle.version.firmware_revision,
@@ -3894,7 +4013,13 @@ static int ti_sci_probe(struct platform_device *pdev)
 	list_add_tail(&info->node, &ti_sci_list);
 	mutex_unlock(&ti_sci_list_mutex);
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "platform_populate failed %pe\n", ERR_PTR(ret));
+		goto out;
+	}
+	return 0;
+
 out:
 	if (!IS_ERR(info->chan_tx))
 		mbox_free_channel(info->chan_tx);
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 053387d7baa064498e6a208daa7f70040ef87281..dec9e20cbe5da8f6d9393d56bb9a1e73cb083a42 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -592,6 +592,11 @@ struct ti_sci_msg_resp_get_clock_freq {
 struct ti_sci_msg_req_prepare_sleep {
 	struct ti_sci_msg_hdr	hdr;
 
+/*
+ * When sending perpare_sleep with MODE_PARTIAL_IO no response will be sent,
+ * no further steps are required.
+ */
+#define TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO				0x03
 #define TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED				0xfd
 	u8			mode;
 	u32			ctx_lo;

-- 
2.47.2


