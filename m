Return-Path: <linux-can+bounces-1264-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A99E79669DD
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 21:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6010C2882DB
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 19:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4281BE86B;
	Fri, 30 Aug 2024 19:33:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0DB1BE840
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046397; cv=none; b=OAye+Q+qk4Lq96dnm0/P9tDrlNZohIPd9zgmJyOX7CyOkODvFUfOE7PvZLlWZhn8rwPgq7ANwRMBvfLN+j4pIkQLYOK+Ozp1twJ05ISdsHd6rpR6+l9HDs9SIb0V/sKVIBmEK+qMISqErS1YGv7IJAJLiCMtj/WV17cWorXn8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046397; c=relaxed/simple;
	bh=y0d1r7AKHz0UNb79ePpfEEpNKI/dMUqJeszbCY2XjeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hgEM91V2/NhiFBP2BfAimbxbJgOrqBlNwWj3GPuGXcj4h2yhsVyWBnV5sUooAdp4JRnARjOKSTPIvEcHe8zysBJ3rzKG6x9LGeDyYTWn4ZmjxkUfJsh0K2fELoLpCSwQYnBwK6sTs8+RlfJgbsaaPVf80hu9D9L6WNtZFIgeQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Mv-00066Q-Ob
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 21:33:13 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Mu-004E60-TQ
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 21:33:12 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id DD5B932E221
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 19:26:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 07AA132E107;
	Fri, 30 Aug 2024 19:26:47 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a697fdc8;
	Fri, 30 Aug 2024 19:26:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 30 Aug 2024 21:26:07 +0200
Subject: [PATCH can-next v3 10/20] can: rockchip_canfd:
 rkcanfd_register_done(): add warning for erratum 5
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-rockchip-canfd-v3-10-d426266453fa@pengutronix.de>
References: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
In-Reply-To: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
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
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=y0d1r7AKHz0UNb79ePpfEEpNKI/dMUqJeszbCY2XjeA=;
 b=owGbwMvMwMWoYbHIrkp3Tz7jabUkhrRLMk9WSnI6zdqm+rqubaJv0Hpum/wXK/fkxl9rrD/3x
 C1yxVvjTkZjFgZGLgZZMUWWAIddbQ+2sdzV3GMXDzOIlQlkCgMXpwBMpHIBB8MUlfxqvebQibof
 HCpOrjyp1xLP+rfNSWaNuZ7wI0VvhoQYZ3/+u/flZjR4Giqr6H/mYNV9uCxpPUfX7unP/kRz71V
 /oLHil2p19UP78sJe3Sm3w6XNl71wteHXbixoTjurdE9xUeDKQ3y3nv0XXNKf8V5eYOL6KK8VV2
 Q1nZ/d+P5OYHl6llNR5E/j6fNWNzw6I8i7ZMLmq3HGs89Jt4ctKL7Gtshc/1P+gfB2/cw/j2TUc
 28orzBQuhp9XEJie8HnWhUHc76zYlWZmwwjVu6sXr6vZX8H8wO5FYFvb6vU/a5NMDHRjDu+7mXu
 xSldAYnpq4xrOi17fI+8Weci8/6LxZUIZWPDRu/I633vAQ==
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



