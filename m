Return-Path: <linux-can+bounces-1311-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3A79698BF
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 11:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6B3B2513A
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 09:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506C1D47AC;
	Tue,  3 Sep 2024 09:22:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9E1D0942
	for <linux-can@vger.kernel.org>; Tue,  3 Sep 2024 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355373; cv=none; b=uENCs2d0/CLVvpjWvdhPImRGrZhsa7O28KQybWSGTcyxxxVo5LV557ipYQ30cFOQUkAcDW67DNAI8aZgt5XTyQ+OecOxbvLCE/2MJctVByWuSlwjkTk0RZXRYwcj1QI4Ur+nckAc9i036P1lZ1W0dCeGDCbHvDYiSSTb+BE8qlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355373; c=relaxed/simple;
	bh=xBf38Ut6AgnO7QgvTyCBnMcJKvzVlajQK72PcBHWEdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GdF0HL1wZuZUMs/Ols8IiEK4zxhu4ELG1WuoAMyC69AKFfyg6cWAyA5oSFo3+LU7F/LpbwpAXhQxVUD6/pCB9rp7GRPGuWaQyhOI4pN6UnT5cFdW4eQSqn4aZbLILL8UFUizXk2sV+QDC4Vz0USvNYVuStbA7jH2U1sAfDBt2wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slPkO-00011a-9O
	for linux-can@vger.kernel.org; Tue, 03 Sep 2024 11:22:48 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slPkJ-0059ds-0d
	for linux-can@vger.kernel.org; Tue, 03 Sep 2024 11:22:43 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id ACA8A33122E
	for <linux-can@vger.kernel.org>; Tue, 03 Sep 2024 09:22:42 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E89D3331058;
	Tue, 03 Sep 2024 09:22:28 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0e0f9e38;
	Tue, 3 Sep 2024 09:22:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 03 Sep 2024 11:22:02 +0200
Subject: [PATCH can-next v4 20/20] can: rockchip_canfd: add support for
 CAN_CTRLMODE_BERR_REPORTING
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-rockchip-canfd-v4-20-1dc3f3f32856@pengutronix.de>
References: <20240903-rockchip-canfd-v4-0-1dc3f3f32856@pengutronix.de>
In-Reply-To: <20240903-rockchip-canfd-v4-0-1dc3f3f32856@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2401; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=xBf38Ut6AgnO7QgvTyCBnMcJKvzVlajQK72PcBHWEdY=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm1tVQiQp+j+OqiA0mt4Iexhlt5/BQlDfLganII
 aOyMjPsFWOJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtbVUAAKCRAoOKI+ei28
 b0VNB/9lOlxzq6+lE9hwe+k5Np+JDGTU1Dhp5cfdd4BHExiHW79kau2NtxoLIVUylw0CF+mJ4C/
 cY5taheVh2jHD78mCV0MoefwClLkFGMa4k1htACx6b3KQFi35es/2VgSxpka/pyatGKC64KC3xz
 QocNDmvOhm3EAjJ0JLXM+jPONXhYIVDe093EugcSM7nfCwkcG3J/hlvP9w/GcAHv7mb76Tq9kLM
 tgQkYMMHut8lqk8mEVmokynS/XuXcoq0W3nQ/Gy4J4l0m/bzXGLrsq73FNZCVVwRqFTf/3F3pQP
 A6LkOR8uKpavMT5Lw/IxC75V8LP99l2L9V3B5W9d72EAQh8B
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Add support for Bus Error Reporting.

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 8853f6a135da..6883153e8fc1 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -293,6 +293,12 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 		RKCANFD_REG_INT_OVERLOAD_INT |
 		RKCANFD_REG_INT_TX_FINISH_INT;
 
+	/* Do not mask the bus error interrupt if the bus error
+	 * reporting is requested.
+	 */
+	if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
+		priv->reg_int_mask_default |= RKCANFD_REG_INT_ERROR_INT;
+
 	memset(&priv->bec, 0x0, sizeof(priv->bec));
 
 	rkcanfd_chip_fifo_setup(priv);
@@ -533,14 +539,16 @@ static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
 	if (!reg_ec)
 		return 0;
 
-	skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
-	if (cf) {
-		struct can_berr_counter bec;
+	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
+		skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
+		if (cf) {
+			struct can_berr_counter bec;
 
-		rkcanfd_get_berr_counter_corrected(priv, &bec);
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR | CAN_ERR_CNT;
-		cf->data[6] = bec.txerr;
-		cf->data[7] = bec.rxerr;
+			rkcanfd_get_berr_counter_corrected(priv, &bec);
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR | CAN_ERR_CNT;
+			cf->data[6] = bec.txerr;
+			cf->data[7] = bec.rxerr;
+		}
 	}
 
 	rkcanfd_handle_error_int_reg_ec(priv, cf, reg_ec);
@@ -899,7 +907,8 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	priv->can.clock.freq = clk_get_rate(priv->clks[0].clk);
 	priv->can.bittiming_const = &rkcanfd_bittiming_const;
 	priv->can.data_bittiming_const = &rkcanfd_data_bittiming_const;
-	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+		CAN_CTRLMODE_BERR_REPORTING;
 	if (!(priv->devtype_data.quirks & RKCANFD_QUIRK_CANFD_BROKEN))
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 	priv->can.do_set_mode = rkcanfd_set_mode;

-- 
2.45.2



