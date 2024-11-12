Return-Path: <linux-can+bounces-1991-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E569C5D8B
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 17:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709CCB66DDE
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040E8200111;
	Tue, 12 Nov 2024 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="JTXJ6oHl"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698121FC7DB;
	Tue, 12 Nov 2024 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422411; cv=none; b=kPQAa8FpR+/46Wy49aFeY1B9BoyCwoqU34jrM2yfWMi5+iHyr0QovJCGvBjE8u7qW/e58Aq6DF2KDNzFQm+GK1+Eq5IipJlfj7m1gwloiKEOTonsNkkVcfFvgq732+sXzVEooybUm4+RYfxazGte7Ie7lsWjROxc0LRWaQBQ37U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422411; c=relaxed/simple;
	bh=gvtUBMCirVaKoq+U7tU6P2PLwDSiL/54gyqcWcSGHEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QlX5MkH4HgRyfjPw9T91sxmoHoYmLyPfE+i8xg3Yu4vVRMOhPQkIzHmSSSgyUWusedahDScrk/RQgQwNPFJVW2MIr8vUZL06aQDqN9rezYoBzEVGvk9a4GF0a1YlmDOpr58P4ODckZpn2fuP9y+KB5RwE8rJKipx3IkKNsUqSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=JTXJ6oHl; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8d1EZbd7y4WjyXLi75iKZ6OGz4naUiYLPe5YUge41T8=; b=JTXJ6oHlUXO3gjRzm5rrfreqWi
	gQ9bHFL91zxrPjU923rqKqtfb6ZqGkWje+vjee023fMHw1rw1CYiG9Wg3KB0IOO5sUNsEDzw20dHa
	04JCzRH0TQOHyghdpivWk/S6tzy6aw3mCrg4hMhR1/Tw7NpVaPLK3Mu2BxFbsIFplALkg/jdj1Fcr
	4PfpsHUaRODbBY0+KZPfseDhTpFCj2azJ+BjnwfcZzp9KYMCA27AfYLGsMEjaAV0kDscjEwXmcn8y
	pUvmRWOYZ3MOEQzCRMQFTHD9hK//+xdSsZp2TEafNbS8u6RAM/jN8fDEQ8368jHOfFuF9JYIkf9wW
	uMqyMQmQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tAs3p-000N01-Ko; Tue, 12 Nov 2024 15:40:05 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tAs3o-000GXH-2x;
	Tue, 12 Nov 2024 15:40:04 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Tue, 12 Nov 2024 15:39:40 +0100
Subject: [PATCH can-next v3 2/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-tcan-wkrqv-v3-2-c66423fba26d@geanix.com>
References: <20241112-tcan-wkrqv-v3-0-c66423fba26d@geanix.com>
In-Reply-To: <20241112-tcan-wkrqv-v3-0-c66423fba26d@geanix.com>
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27456/Tue Nov 12 10:49:43 2024)

nWKRQ supports an output voltage of either the internal reference voltage
(3.6V) or the reference voltage of the digital interface 0 - 6V (VIO).
Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.
Unset nWKRQ is kept at internal reference voltage.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
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


