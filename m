Return-Path: <linux-can+bounces-1848-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA109B7C17
	for <lists+linux-can@lfdr.de>; Thu, 31 Oct 2024 14:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A8C1F21B9D
	for <lists+linux-can@lfdr.de>; Thu, 31 Oct 2024 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B938619EED2;
	Thu, 31 Oct 2024 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="f1JUEiaR"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0D187864;
	Thu, 31 Oct 2024 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382484; cv=none; b=D2EYdJVX5hKrMwvWdKkHZgZ3jfj3wXcbUlgivk+HJUkNz4AicS2VY0Z8R72kcQMjI/f/Vtvzy8M2b7KYJUw+rit1qp/IY3PFwX2KbSG0gJKoOb22KYL3SylC0mj5O4antD0WiRizjcVKlhp9PenDIVa289o+WdPPSfO+jC/kjMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382484; c=relaxed/simple;
	bh=P8aq+HrtTPGRe6NulJzZWkkCydI6pkQrnnOE2fEBAWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kh+3nYObdZG2w9xymcww0invBWvduqBs7DHee6/wz4qYUArfxLxfI/shIhjGhenreA3h2lR3j4SwD2d9hY+jnESLxWDXcKo8PtlEBA2/QXOkxxaBxKYJO6iiARb89AB44iNw3/t6y5XDb2w4q+bF9i73kKmd8sbUKuVvS3GFWAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=f1JUEiaR; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=hInpEUHJpNi2swX8P3rneq+VBn2Cer+loje2Tu7kAPA=; b=f1JUEiaRjnI5zl3njtOa57KrMi
	fBjzN0lmzu7y6xJhMI5UKmw4BRO/qg+Vwz1TmGpqG7gtz4NQ+EFBIIaKd1tDoyOMWuiwxbgNmqj5R
	LMVJ4hcUH8EwSi/EgLPR6tOJYIAiDhikBT3/q6wrn1LvzIzygIaqr6TLxpRwCiRuitsoKTszla1El
	8uwSPagxwIbKWohrdP2N61bJWAVsiQZDGhSKiPFV+IHdXwxOH/IHGGwXLMZpPNCxV06mm3MUdOkcR
	+YGEW43bCzxRalb9pu7sWNqy7QgzlP3vsDNHnDhkieMmJwM/sutbr76CzApyLil7L+A0kBkXpk1gW
	kmSCkyuA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1t6VAR-0005LS-Ti; Thu, 31 Oct 2024 14:24:51 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1t6VAR-000DTL-1D;
	Thu, 31 Oct 2024 14:24:51 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 31 Oct 2024 14:24:21 +0100
Subject: [PATCH 1/2] can: tcan4x5x: add option for selecting nWKRQ voltage
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-tcan-wkrqv-v1-1-823dbd12fe4a@geanix.com>
References: <20241031-tcan-wkrqv-v1-0-823dbd12fe4a@geanix.com>
In-Reply-To: <20241031-tcan-wkrqv-v1-0-823dbd12fe4a@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27444/Thu Oct 31 09:34:36 2024)

nWKRQ supports an output voltage of either the internal reference voltage
(3.6V) or the reference voltage of the digital interface 0 - 6V.
Add the devicetree option ti,nwkrq-voltage-sel to be able to select
between them.
Default is kept as the internal reference voltage.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/net/can/m_can/tcan4x5x.h      |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..264bba830be50033347056da994102f8b614e51b 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -92,6 +92,8 @@
 #define TCAN4X5X_MODE_STANDBY BIT(6)
 #define TCAN4X5X_MODE_NORMAL BIT(7)
 
+#define TCAN4X5X_NWKRQ_VOLTAGE_MASK BIT(19)
+
 #define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
 #define TCAN4X5X_DISABLE_INH_MSK	BIT(9)
 
@@ -267,6 +269,11 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
+	ret = regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
+				 TCAN4X5X_NWKRQ_VOLTAGE_MASK, tcan4x5x->nwkrq_voltage);
+	if (ret)
+		return ret;
+
 	return ret;
 }
 
@@ -318,6 +325,28 @@ static const struct tcan4x5x_version_info
 	return &tcan4x5x_versions[TCAN4X5X];
 }
 
+static int tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
+	struct device_node *np = cdev->dev->of_node;
+	u8 prop;
+	int ret;
+
+	ret = of_property_read_u8(np, "ti,nwkrq-voltage-sel", &prop);
+	if (!ret) {
+		if (prop <= 1)
+			tcan4x5x->nwkrq_voltage = prop;
+		else
+			dev_warn(cdev->dev,
+				 "nwkrq-voltage-sel have invalid option: %u\n",
+				 prop);
+	} else {
+		tcan4x5x->nwkrq_voltage = 0;
+	}
+
+	return 0;
+}
+
 static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
 			      const struct tcan4x5x_version_info *version_info)
 {
@@ -453,6 +482,12 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_power;
 	}
 
+	ret = tcan4x5x_get_dt_data(mcan_class);
+	if (ret) {
+		dev_err(&spi->dev, "Getting dt data failed %pe\n", ERR_PTR(ret));
+		goto out_power;
+	}
+
 	tcan4x5x_check_wake(priv);
 
 	ret = tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_EN, 0);
diff --git a/drivers/net/can/m_can/tcan4x5x.h b/drivers/net/can/m_can/tcan4x5x.h
index e62c030d3e1e5a713c997e7c8ecad4a44aff4e6a..04ebe5c64f4f7056a62e72e717cb85dd3817ab9c 100644
--- a/drivers/net/can/m_can/tcan4x5x.h
+++ b/drivers/net/can/m_can/tcan4x5x.h
@@ -42,6 +42,8 @@ struct tcan4x5x_priv {
 
 	struct tcan4x5x_map_buf map_buf_rx;
 	struct tcan4x5x_map_buf map_buf_tx;
+
+	u8 nwkrq_voltage;
 };
 
 static inline void

-- 
2.46.2


