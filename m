Return-Path: <linux-can+bounces-1255-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8FF9669A6
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 21:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F723B249F5
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 19:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E171C1737;
	Fri, 30 Aug 2024 19:27:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178E1BF819
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046031; cv=none; b=iaRdVoexojyng63Zm+lT/E3ugpJJKQc0kSgFusAj4DeHe0DqjSND6UL/I0zEUjSNLNxn65AjikoovG432RQJZ9+7Joh+5QXYQh1SfDih/qPDECxzu/3BishS40aL0YvmwWSjYnTtxk/ltT5S310sAIpFEbKog2aOWiCWi5koYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046031; c=relaxed/simple;
	bh=L9Nl19jQ0rlZqgQunUAoISdoYkyHWfdsG+IX7vgSjoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3k25DHWYSdCbFEPQ9zktu9S7YDOjOib+YA582nxry2qTvBPAFaR0BnlEUsHn4Nm+HKeMgXcRklo8aOQWQg+amgIw/TA87p546u28ca80GMf9vazrhrCQBLbCm9IUgTGc/Oi/W7lmGbQTZrUZrbHUggYukElalsZ/UVSS3MXf90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gz-0006JE-16
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 21:27:05 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7Gq-004DoN-Eh
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 21:26:56 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D92CD32E21F
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 19:26:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C65BD32E100;
	Fri, 30 Aug 2024 19:26:46 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6919bcdd;
	Fri, 30 Aug 2024 19:26:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 30 Aug 2024 21:26:05 +0200
Subject: [PATCH can-next v3 08/20] can: rockchip_canfd: add notes about
 known issues
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-rockchip-canfd-v3-8-d426266453fa@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=L9Nl19jQ0rlZqgQunUAoISdoYkyHWfdsG+IX7vgSjoA=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm0hzhwYzVlZ5wgnyOhhah5zZi7aL0R3v/KCscT
 //i1+bUVYGJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtIc4QAKCRAoOKI+ei28
 bzgDB/95axjXMh3uhwLCVlXLIf/5saGkNkJg7v8r5K6zFqEcBDYC4ezeGNsieKXdZypu6o3ShZb
 zS7fkisKxMrhMHi+Wxd9FL8zbh2QllzbzVUtI0h1sLQptrcCT/pA8CRU1RgOndN8UNEb6XU6AOY
 dVU6jGkZeeVMCmM5uJ1Ni1Ec3a0UYdWk7RXHhCWy2AYbrNxsvxXYW5pAY4FA2td01CfmXIAHHJb
 Yzq6iK5VtkGLzSyp94y4FpV8PC6EaA3Id15mtbTwWidbaPvx448qPLpemWWy2BUpqBa6Jk9sl4C
 TDOkcS625UYVwPZykUbKY3IuxW3LZ+94Agb4C0ns6V3RYzE2
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Even the rk3568v3 has some known issues. Document them together with a
reproducer.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 9b446331fbd0..3dafb5e68dc5 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -370,6 +370,26 @@
  */
 #define RKCANFD_QUIRK_CANFD_BROKEN BIT(12)
 
+/* known issues with rk3568v3:
+ *
+ * - Overload situation during high bus load
+ *   To reproduce:
+ *   host:
+ *     # add a 2nd CAN adapter to the CAN bus
+ *     cangen can0 -I 1 -Li -Di -p10 -g 0.3
+ *     cansequence -rve
+ *   DUT:
+ *     cangen can0 -I2 -L1 -Di -p10 -c10 -g 1 -e
+ *     cansequence -rv -i 1
+ *
+ * - TX starvation after repeated Bus-Off
+ *   To reproduce:
+ *   host:
+ *     sleep 3 && cangen can0 -I2 -Li -Di -p10 -g 0.0
+ *   DUT:
+ *     cangen can0 -I2 -Li -Di -p10 -g 0.05
+ */
+
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
 	RKCANFD_MODEL_RK3568V3 = 0x35683,

-- 
2.45.2



