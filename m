Return-Path: <linux-can+bounces-1349-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB05696B43B
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 10:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3101F276DD
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 08:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AD2192D7D;
	Wed,  4 Sep 2024 08:13:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B42193093
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437632; cv=none; b=pOYG0UoSrTJGM9g+H8V6Jz1KkuAmsLnI5z2T7sxd0xvblcmFTW2v2IntoIboABMJe2gyHGqJil125zxO+njFVt4Nzrvj35pt/VMy8fgfVaxPveO5XfBodV+G5tYfXVVR9F/zGneo/fs1VNMLHdGiI/CemNu7T++e7p9JAftSx7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437632; c=relaxed/simple;
	bh=44NzGtqpU5BxdFed4h+jxAkMAchbCULQjVzky0gCZl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGXoDY9ceJcaiFkQA9+l6wXLb0knXSLhfUEsYvjHFk/rI6FQ8efrRuNTnh1QWcCUGgT3oNLvgMGGRidPz7Rrc65IaMUHbwhgGXqx890Ql6MoYLwn+tvBqQOu4s2MqgihatJI3LPPOTTv7xtXxXIjbsoOk5/gpX4TI9SJ035chEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sll98-0007xh-DU
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 10:13:46 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sll90-005P5c-Di
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 10:13:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 14CC2332117
	for <linux-can@vger.kernel.org>; Wed, 04 Sep 2024 08:13:38 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E9357331F87;
	Wed, 04 Sep 2024 08:13:23 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3cef0a87;
	Wed, 4 Sep 2024 08:13:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 04 Sep 2024 10:13:03 +0200
Subject: [PATCH can-next v5 19/20] can: rockchip_canfd: add support for
 CAN_CTRLMODE_LOOPBACK
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-rockchip-canfd-v5-19-8ae22bcb27cc@pengutronix.de>
References: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
In-Reply-To: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
To: kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=2135; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=44NzGtqpU5BxdFed4h+jxAkMAchbCULQjVzky0gCZl8=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm2BadeF4wYM0v1GnxVO8JzlK/Z9JuUo4J9b/jb
 8J03wALg4KJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtgWnQAKCRAoOKI+ei28
 bz4RB/4rKhe5OxFZIGDiu6nbR7cur2sbZftGM/dtkfELIjE6CpeIf3duGAb78E2K2DwZcw3Ojys
 3hcJoYaXFkEum4QrZmw+upc1uXifqkOF/0tmNt7te4yHz80jchIJDCiAtiOomgULfZEqjgwrDSb
 7gZW/MAF+sJ6Q8J9KMTuZQBBU2L0/TJvaIrTAX1h2rZkGYL3z2pJLA2fgt0tlt8VLwDmkyD5G6i
 xLzGeHX3eGV9CL4gtQWQyQKzwsSLHNPdKSyoUe46sSjuBvDLuVkHAvciE1Or1tQ187kPoaHxycR
 GjdAx3mdBWdGNf9r3BCNZUoceHt2dPNTCHR1ESEMqtKGlFzO
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Add support for loopback mode.

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 7 ++++++-
 drivers/net/can/rockchip/rockchip_canfd-rx.c   | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 015623314e88..8853f6a135da 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -276,6 +276,11 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 		RKCANFD_REG_MODE_RXSTX_MODE |
 		RKCANFD_REG_MODE_WORK_MODE;
 
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
+		priv->reg_mode_default |= RKCANFD_REG_MODE_LBACK_MODE |
+			RKCANFD_REG_MODE_SILENT_MODE |
+			RKCANFD_REG_MODE_SELF_TEST;
+
 	/* mask, i.e. ignore:
 	 * - TIMESTAMP_COUNTER_OVERFLOW_INT - timestamp counter overflow interrupt
 	 * - TX_ARBIT_FAIL_INT - TX arbitration fail interrupt
@@ -894,7 +899,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	priv->can.clock.freq = clk_get_rate(priv->clks[0].clk);
 	priv->can.bittiming_const = &rkcanfd_bittiming_const;
 	priv->can.data_bittiming_const = &rkcanfd_data_bittiming_const;
-	priv->can.ctrlmode_supported = 0;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK;
 	if (!(priv->devtype_data.quirks & RKCANFD_QUIRK_CANFD_BROKEN))
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 	priv->can.do_set_mode = rkcanfd_set_mode;
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index d862116840eb..475c0409e215 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -243,7 +243,7 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 		err = rkcanfd_rxstx_filter(priv, cfd, header->ts, &tx_done);
 		if (err)
 			return err;
-		if (tx_done)
+		if (tx_done && !(priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK))
 			return 0;
 	}
 

-- 
2.45.2



