Return-Path: <linux-can+bounces-1343-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF2E96B41D
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 10:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB22A1F26E79
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 08:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564A918951C;
	Wed,  4 Sep 2024 08:13:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C2B189529
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437626; cv=none; b=lsX7hQbHYqaT8dspJ5Aey2VxtxMaOxbi8juBDWajYQ30MLq+kcBqLIa87t19PADytXgmSaBLMzImiFyrh/bogXFKgFSwtk69Y/O2J7tVmqcRjIYc9BnfSMoPx9y8NFNyBymHrGSDWBNeYjZWbE6Q11w+ohAFIq2JLBZgCoqw2bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437626; c=relaxed/simple;
	bh=uUKDz11I4FG9jd59dhVqeNCMQYK0nkVIQAuP/ouFmzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2n1unTrerG/b5hkIOYalIiqKeF4U7HUD9TOYACoZU6Q+3lEC06M25kdxTT/bEztxF6EosfkrzQw0PB99ya8SAwx0cUs0uWunwVUyxAeDO8o28Gge4nsrxoHP5WbarR8b0hA3byVNRixQiMnAZ1xOWtWCjKZxqD8N0RhOMs81Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sll8z-0007hb-IC
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 10:13:37 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sll8u-005Owq-Pn
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 10:13:32 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 6446B332098
	for <linux-can@vger.kernel.org>; Wed, 04 Sep 2024 08:13:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B8CE3331F66;
	Wed, 04 Sep 2024 08:13:22 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 79ffc6d8;
	Wed, 4 Sep 2024 08:13:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 04 Sep 2024 10:12:54 +0200
Subject: [PATCH can-next v5 10/20] can: rockchip_canfd:
 rkcanfd_register_done(): add warning for erratum 5
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-rockchip-canfd-v5-10-8ae22bcb27cc@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=uUKDz11I4FG9jd59dhVqeNCMQYK0nkVIQAuP/ouFmzU=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm2BaQyhOg+Aoik9L37BfiNX7mpgqN0R/8LRz5b
 xnXdOeF7qeJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtgWkAAKCRAoOKI+ei28
 b582CACXJi6oZNgq+ZXtkMveOr+VW68sLq8lNYNFHQK9LPKxhcUQ0g1afCmzynrt0hDQiU1/7WU
 wZgJZSZsBEtPS+aT3wa8TEzdL4zYpA1l3jLzFH3JfzJLkpkH5yGuEUGjHuWkFvu7/5pu6KEh3dj
 WEfIe9yjA32tnczjEsoUTMxxauegAbe4MWLKJrIyCWjaBCk9IHPrijZ7ae3Gq4rig6HNOpVuIN6
 BL2XV8xKUyN396VsTzB4jOsBKD+QG5aty0CJUXpH+Zh4LafzKj83JyhLcu2YZGdVMaU46kAa1LW
 sOK1oXjNfAdGLAjAoF7VF+r1+/DiWjxGyK3yAtHZT3v8OoIU
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Tests on the rk3568v2 and rk3568v3 show that a reduced "baudclk" (e.g.
80MHz, compared to the standard 300MHz) significantly increases the
possibility of incorrect FIFO counters, i.e. erratum 5.

Print an info message if the clock is below the known good value of
300MHz.

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 40911bb63623..d6c0f2fe8d2b 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -738,6 +738,13 @@ static void rkcanfd_register_done(const struct rkcanfd_priv *priv)
 		    FIELD_GET(RKCANFD_REG_RTL_VERSION_MAJOR, dev_id),
 		    FIELD_GET(RKCANFD_REG_RTL_VERSION_MINOR, dev_id),
 		    priv->devtype_data.quirks);
+
+	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_5 &&
+	    priv->can.clock.freq < RKCANFD_ERRATUM_5_SYSCLOCK_HZ_MIN)
+		netdev_info(priv->ndev,
+			    "Erratum 5: CAN clock frequency (%luMHz) lower than known good (%luMHz), expect degraded performance\n",
+			    priv->can.clock.freq / MEGA,
+			    RKCANFD_ERRATUM_5_SYSCLOCK_HZ_MIN / MEGA);
 }
 
 static int rkcanfd_register(struct rkcanfd_priv *priv)

-- 
2.45.2



