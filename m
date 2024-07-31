Return-Path: <linux-can+bounces-1085-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F28B942AD8
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 11:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6E11F25A47
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 09:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727CA1AB53E;
	Wed, 31 Jul 2024 09:38:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0291AED52
	for <linux-can@vger.kernel.org>; Wed, 31 Jul 2024 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418693; cv=none; b=fY/kyqRjZM92sfRlwA1TxBkDrIHUOVv93kyQ8A9Cd+yel/q8Fl5e4uNplPc3cQlD6zr5J43VZaKfKkYbO8ZVVZvz/xnuQgIn75lGxcWSjZPdbUHakKFvi3lGduxHN4XEr/gVWA/wFupmtDoJHfYJOggpUcsBs7FHSL5RBgvfHZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418693; c=relaxed/simple;
	bh=9x7fBgEKrbnvwSWZMk0h7+xGAdXXEX90CcYIMKJHptE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PilEPBDAWTjheRdkWH7+V9t3TP/JIx3o82+ccMAwoL4ggLwxEtVi0X6pA5wegvxH/hexYnoVNEbVNjZLcxEnvpA8zk9J7uIC2KkATVVYtZ1a8SCXpxUQ1E61JvjPgHGn6C0VdCuKGNyhdbv3qo3bzVZDoLqW3WFTXZz2RhIbxFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ5mZ-0005kG-Nk
	for linux-can@vger.kernel.org; Wed, 31 Jul 2024 11:38:07 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ5mR-003UtC-4T
	for linux-can@vger.kernel.org; Wed, 31 Jul 2024 11:37:59 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C1B9F312904
	for <linux-can@vger.kernel.org>; Wed, 31 Jul 2024 09:37:58 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C6F33312830;
	Wed, 31 Jul 2024 09:37:52 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d274b915;
	Wed, 31 Jul 2024 09:37:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 31 Jul 2024 11:37:12 +0200
Subject: [PATCH can-next v2 10/20] can: rockchip_canfd:
 rkcanfd_register_done(): add warning for erratum 5
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-rockchip-canfd-v2-10-d9604c5b4be8@pengutronix.de>
References: <20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de>
In-Reply-To: <20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
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
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=9x7fBgEKrbnvwSWZMk0h7+xGAdXXEX90CcYIMKJHptE=;
 b=owGbwMvMwMWoYbHIrkp3Tz7jabUkhrRVrFeYRY5cNjoouUzozkq9rV9qv2ZZy/UrOP58FnYgW
 u6N9ZNtnYzGLAyMXAyyYoosAQ672h5sY7mruccuHmYQKxPIFAYuTgG40ZfY/1mbdx878NO+pj5F
 7O1hIXZ7zRMX5z4pcDprWDRvwk5Nq60LysunPd3HptpUI6t73emB3m25iR6MpiZh81adFLxR/Dg
 mzNnT+Oe2LyzV1jpxRpKNU9aUuzBNLtq1XaLa+d59QaMKpu2C8g9DE91cVxolsbWf0XnDsLZLW+
 /jmmfPbnSlV7/Q5vz5d+qrnfr/ZmqsM649Z8FapRHHdseAe8Ex+wlqU4w3qXuJWF8+4/FSNFXsa
 sbMqDRHM07miqbE9EIfscgT/v92nmpwqP2c84x7U2w7c/HbaavbdglrsPUueRJ2LDMmKlnJhkmY
 8d15TUfVDR8XB3Jsr7aN/fo+NMr++6LzhV9n3pK4+uYPAA==
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

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 7b4abf9984af..232bc49b1a48 100644
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
2.43.0



