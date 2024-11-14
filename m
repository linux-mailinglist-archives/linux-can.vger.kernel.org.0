Return-Path: <linux-can+bounces-2028-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05E79C8548
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10FA281396
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 08:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273BB1F7578;
	Thu, 14 Nov 2024 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WbxPf46+"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578B71EB9FD;
	Thu, 14 Nov 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574377; cv=none; b=NcX9SGB6hSvTqO4aQQg1KDLjA1b3ooPxIUf6TcVpReEF8iWSINesE4f1Ky1frLHvEEOUjSokY22faYdANJSY4ZekrqEqQWg2YV683JUMh8W5HGRW9pxAuA6PcutxyPuQA/e2TadViMkMXKgSRCPV0NASzJGtV9WWqtDXRdefx+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574377; c=relaxed/simple;
	bh=q2cOUuiLGngjUuk8QBci36+qeumQw7O5yHr8slg/tj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IlbP2xbM3n1dfEjLfjZPOiRWlqR0P1e39S6qeNKgav+X/xFwiErUS+bNzyUIgfNVDWAyvr0BEYDehOpfwEX1X8M16HLMr8xubkZOrGxtBACuuaislQ1GGPpMhYK5jvAthJLz0Z04LWo3MxDF8UDy/jQ61AjWOyzXMrpJ1//6Slw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WbxPf46+; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=KIsnWeyBTVfbOCqVgFdSiZBe382iDOroBXop3Ggcstg=; b=WbxPf46+NuqmCfTagT1G1TMiSZ
	Y6dzkLaChn/IZKvS+v8o2GNtp3Ri710oVvw/s1eXp5PqnUJwAz904lVX9dR/+bdjGyq8aR8hExur7
	kN+fOEn3h66QT2ue/DF6UPomKlCUVrokMm4OK5pxeaM4Ie9819y5lYAXeJOQ9W/OBkoevvorhsGJh
	2n+RNVMcexPv9GzBhFARlCZDeY9DoHoVVGEfIbMh1iSv93V7zE8rG4oz+6j4OVmPh+5iiUn5HfSP2
	GTPRB/xC+xfTyO4RLGkRKwoAFcsqXxWXIPnxHDBa1TL+p+eiQHkc/+C3CmHNpiX7PPcw1anYHhw9U
	3YuQowpA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBVan-000CeW-TZ; Thu, 14 Nov 2024 09:52:45 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBVan-000CcT-0e;
	Thu, 14 Nov 2024 09:52:45 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 14 Nov 2024 09:52:22 +0100
Subject: [PATCH can-next v4 2/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-tcan-wkrqv-v4-2-f22589d67fb1@geanix.com>
References: <20241114-tcan-wkrqv-v4-0-f22589d67fb1@geanix.com>
In-Reply-To: <20241114-tcan-wkrqv-v4-0-f22589d67fb1@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27457/Wed Nov 13 10:35:46 2024)

The nWKRQ pin supports an output voltage of either the internal reference
voltage (3.6V) or the reference voltage of
the digital interface 0-6V (VIO).
Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.

If this property is omitted the reset default, the internal reference
voltage, is used.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 20 ++++++++++++++++++++
 drivers/net/can/m_can/tcan4x5x.h      |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..12a375c653cbd255b5dc85faf2f76de397a644ec 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -92,6 +92,8 @@
 #define TCAN4X5X_MODE_STANDBY BIT(6)
 #define TCAN4X5X_MODE_NORMAL BIT(7)
 
+#define TCAN4X5X_NWKRQ_VOLTAGE_VIO BIT(19)
+
 #define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
 #define TCAN4X5X_DISABLE_INH_MSK	BIT(9)
 
@@ -267,6 +269,13 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
+	if (tcan4x5x->nwkrq_voltage_vio) {
+		ret = regmap_set_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
+				      TCAN4X5X_NWKRQ_VOLTAGE_VIO);
+		if (ret)
+			return ret;
+	}
+
 	return ret;
 }
 
@@ -318,6 +327,15 @@ static const struct tcan4x5x_version_info
 	return &tcan4x5x_versions[TCAN4X5X];
 }
 
+static void tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
+	struct device_node *np = cdev->dev->of_node;
+
+	if (of_property_read_bool(np, "ti,nwkrq-voltage-vio"))
+		tcan4x5x->nwkrq_voltage_vio = true;
+}
+
 static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
 			      const struct tcan4x5x_version_info *version_info)
 {
@@ -453,6 +471,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_power;
 	}
 
+	tcan4x5x_get_dt_data(mcan_class);
+
 	tcan4x5x_check_wake(priv);
 
 	ret = tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_EN, 0);
diff --git a/drivers/net/can/m_can/tcan4x5x.h b/drivers/net/can/m_can/tcan4x5x.h
index e62c030d3e1e5a713c997e7c8ecad4a44aff4e6a..203399d5e8ccf3fd7a26b54d8356fca9d398524c 100644
--- a/drivers/net/can/m_can/tcan4x5x.h
+++ b/drivers/net/can/m_can/tcan4x5x.h
@@ -42,6 +42,8 @@ struct tcan4x5x_priv {
 
 	struct tcan4x5x_map_buf map_buf_rx;
 	struct tcan4x5x_map_buf map_buf_tx;
+
+	bool nwkrq_voltage_vio;
 };
 
 static inline void

-- 
2.46.2


