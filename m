Return-Path: <linux-can+bounces-2039-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C149C85CF
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC3728320D
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EFD1EABD2;
	Thu, 14 Nov 2024 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="YSWblcRW"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725BA1DED77;
	Thu, 14 Nov 2024 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575705; cv=none; b=U/KMw7JgkojN3m2wiOtXiB74IBXLTAJibJube2d+Kf8LSiaRpVaDMWUilQHx1359fXqqtT2zOBH3JsGqJ6O35wq1wXas+V3V4U9NetmDRJF5iKwbuhfi9FDgSHyBkvMRHGjXfa/uTi+mj2+wabFMfTzcsAMPCC+z7haUJh5CE68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575705; c=relaxed/simple;
	bh=jzWTpYJz24a44FUX0mEO0YWQk7Jp/KE7nx4V481kjFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/eqqEe1evWFCerFezzm4DQOV/iGUo9t6RUXYBSlfnJPxrp6OAVrFhNx0LZ8hmgZQGGD2xcGsA+eSJjy9YdsVfeQDwFkREy4sSdspFhEd/3yfoZ5tPUhLBck29F7LHQmWdiBMCHCWzduOJE+I5Q7D9of0ThLo7Qfr0lCFK3VLQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=YSWblcRW; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FDaufgvy61yUd6ZQRB7ftiwz9ak15hKnp/pEeNv/3j8=; b=YSWblcRWB4PW+iIA1IO+54himq
	SZyHONoBel+3JEGexK1bKOwYZSJF8hRomBOlqF5pIdtktZ86VHGFvWbemStcO6Y66SMXxVqHKFYUW
	abYoUGRrrxvoRO0jWIxVuxvYKmcZWBVoP13BKf3Rw9utvC7Rjc0BLoPiBtb0WVmp0wGodORoByoad
	OdP9bfKnKeDIvLQVSXD1w1/mng9HAlfcFUsUmPhTU/sQGNY5hAPPbYn761lC1f6Qs84m2sawPyY3d
	uZXXh8VeSvI042ls3DUa/KNe0AhtIOUPYJ7KytF/Dm4CdvcF9/x4wF2W+DRS+V1eTINcNC310xpwB
	QrBcOtzA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBVwL-000HFu-Hn; Thu, 14 Nov 2024 10:15:01 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBVwK-000EOg-2d;
	Thu, 14 Nov 2024 10:15:00 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 14 Nov 2024 10:14:50 +0100
Subject: [PATCH can-next v5 2/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-tcan-wkrqv-v5-2-a2d50833ed71@geanix.com>
References: <20241114-tcan-wkrqv-v5-0-a2d50833ed71@geanix.com>
In-Reply-To: <20241114-tcan-wkrqv-v5-0-a2d50833ed71@geanix.com>
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
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 20 ++++++++++++++++++++
 drivers/net/can/m_can/tcan4x5x.h      |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..7213d9894c82d079bf92f1ec62d4eebb500cdfa4 100644
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
+	tcan4x5x->nwkrq_voltage_vio =
+		of_property_read_bool(cdev->dev->of_node, "ti,nwkrq-voltage-vio");
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


