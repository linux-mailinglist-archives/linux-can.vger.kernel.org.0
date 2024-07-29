Return-Path: <linux-can+bounces-1054-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF1C93F673
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 15:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7218B1C22B71
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555E6188CDE;
	Mon, 29 Jul 2024 13:07:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4A188CCF
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258449; cv=none; b=EKgeZCZb6f4I8rVscWT1sXQShp/3EJt4IC91RnprPFDOP8o4dDGc290vyb8M9S4T/E3Cpupb9BAZ7FA+7JD8SLa2VzxH6k/2cVR+N0hk1QhhMGSxao1DATevFlkuGz494x7x6zc5/LBtbHc1GEc+bjpU4t2JNh6JnPik3h6TiOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258449; c=relaxed/simple;
	bh=vj7Ls7jCRCtXFhfLfleCHH6m4nXF2gN6Ht4YwgQI5gA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FOWCBPENCnXiBv8tmmGe8x12zXS4cMs072ZZRUSif+yXZwOtBzM/47wknsrWCoLAsZdqGjrKyieOAs2hH0qe9yPE+ddnaO0/NN1IRfL7KCJ8jvrJchHVPJqz9/deUIuU0mNfX0GyWvkNMRnRGU3EXNvuMfTk/N/pCjYt9cmC+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ62-00019E-6C
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:26 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ61-0033O2-6e
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:25 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D62CB310F52
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:24 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 82313310E8E;
	Mon, 29 Jul 2024 13:07:13 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 00b86238;
	Mon, 29 Jul 2024 13:06:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 29 Jul 2024 15:05:51 +0200
Subject: [PATCH can-next 20/21] can: rockchip_canfd: add support for
 CAN_CTRLMODE_LOOPBACK
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-rockchip-canfd-v1-20-fa1250fd6be3@pengutronix.de>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
In-Reply-To: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2085; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=vj7Ls7jCRCtXFhfLfleCHH6m4nXF2gN6Ht4YwgQI5gA=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmp5PTFjE4VNk8hauLl/4C/dg98zTZFZUcufx/p
 hyn+nCUQG+JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqeT0wAKCRAoOKI+ei28
 b3GqB/9rfouBUKd00UkwSdaiipS2AyGB2wvM7XgU9uX9FTrh5wr2Lf+uwhGjPxMJLU7GGxgYpRT
 j6Ucw27UqhbU8n/RBZrZnGSFu86XbBESWvAUAW15eSvjdu5PK7crEkb0QixGUH53fmihDdHhnYe
 OiDIfcaxXcaXLNhJMuw14Y8M12B9N1d4H5x1wvqY/QELjwOxT4V8I+7K5pvxjVc7hwJdkcWv5Fb
 t1D0ZZWMFq2+d9jCNmhPAon7r2NEhivRcpPl+lm2B+SnKi9Jd4vrCcVpxavWT2Jv7ArUTUg6rik
 6ViAP4yCp6j+xlxQ3tLPm4An3oZHqiyqqCRC5H2P/KJQMcIw
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Add support for loopback mode.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 7 ++++++-
 drivers/net/can/rockchip/rockchip_canfd-rx.c   | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index acbbfdd4cb69..2d6eca8d23be 100644
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
@@ -897,7 +902,7 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	priv->can.clock.freq = clk_get_rate(priv->clks[0].clk);
 	priv->can.bittiming_const = &rkcanfd_bittiming_const;
 	priv->can.data_bittiming_const = &rkcanfd_data_bittiming_const;
-	priv->can.ctrlmode_supported = 0;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK;
 	if (!(priv->devtype_data.quirks & RKCANFD_QUIRK_CANFD_BROKEN))
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 	priv->can.do_set_mode = rkcanfd_set_mode;
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 411b0cf5487a..d89a9bf36690 100644
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
2.43.0



