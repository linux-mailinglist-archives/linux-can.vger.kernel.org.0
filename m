Return-Path: <linux-can+bounces-1045-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755DE93F64F
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 15:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC4BB2374F
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 13:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA5915D5B8;
	Mon, 29 Jul 2024 13:07:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4644915B97B
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258432; cv=none; b=fZAcyLFTShljJiJGC7QBbWiMf0RbUcNhLRbd89txktnPxsyy77ICKQX9oKwp6ekWedQQt42+15qADap8KAE5RLNm2FqTB3Ewc8PW3LSdDrMvB5fFH9TbySCwOzhX26ZDgDdAz4jYQ0iKFPREq2pnOhYxg4mEhjiCVQL7YvY2VUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258432; c=relaxed/simple;
	bh=1XWJpInOSJYfSn9gvuOumPtPkOkpESW8X/dfF8N2utQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f42k3EdAG1BWUiwBe3Ojs3etgGWMnbRWPTeGCHi5t2jZMlYK534J9adcUigDb+ZMAK9tV54yDUXeogdvaUtAr3ylpy9aONzZjq2cjxWUAmPxTxlgbzBwwD5wHkHtp4eKue3/puQJXlOKDYTpqQOPWXbDTJVud+/H1tBsKerGNC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5l-0000aI-Jw
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:09 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5k-0033C2-Km
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:08 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 53766310E50
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:08 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B5D8A310DD0;
	Mon, 29 Jul 2024 13:06:57 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7c555dbe;
	Mon, 29 Jul 2024 13:06:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 29 Jul 2024 15:05:41 +0200
Subject: [PATCH can-next 10/21] can: rockchip_canfd:
 rkcanfd_register_done(): add warning for erratum 5
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-rockchip-canfd-v1-10-fa1250fd6be3@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=1XWJpInOSJYfSn9gvuOumPtPkOkpESW8X/dfF8N2utQ=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmp5PDgH/m43aFZWL6N1zIcs8X24z2NwIZCq8S8
 qx0Fz9S/eaJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqeTwwAKCRAoOKI+ei28
 b9thB/4iCYZQaVbL/nbhFnTYFM/xF8iUvuuWjpYozO9IQ6mpUEF4vr32qegeLyKJNE+T34u1K8/
 KUsfE6uPSodk19+Ix7M7HGhvZdn76X0YK5DPNmHnh4fKOGVdsTN5GkMtRi1Lrwyige8AfoWffia
 5zPneInmZMiihJP9BYH/xJh2kWQR2+JR6WRDOGXvTXIGw4f3mvQNRAyYir2SRzi2MZigdHVB39/
 dEmTg6OP9cvFXjae5mUixTlT8vA7+PBjQeItgh5plTI2juwVjXPvxwPYxI1aCN0z8jg40/lfhl3
 cPCpYMShepAQw6JjQv5N/b8sMUjamOFJAPpYLavuZFqWBIov
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
index cd4e951f56d6..02291bd77deb 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -741,6 +741,13 @@ static void rkcanfd_register_done(const struct rkcanfd_priv *priv)
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



