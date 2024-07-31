Return-Path: <linux-can+bounces-1083-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394CE942AD1
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 11:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3E31C2431E
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C2B1AED55;
	Wed, 31 Jul 2024 09:38:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB51AE850
	for <linux-can@vger.kernel.org>; Wed, 31 Jul 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418690; cv=none; b=YmiuWUKLJdLWlrXTQOnC03VbtEJ9rTN919L3VNCOJdfenil014Rt7BLfOBk6Sf3Fj1A3ZeFbjpFFA6mVRu5lvsjB/Diy4QfmoFiLfEA8uZljFjf/slLI+hcXiMb3h4f9qxG4FERkGPqLsAl4eWSIUF07nt4yg884rPgzI/slE/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418690; c=relaxed/simple;
	bh=71zf/MNfEu3gRqn5xXuWHDmR5jq4HnnTZs6zICou+pI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MmIIJ5NVgs3YsTc/fDz6rDUrZkIT2nL6Y/fhomM9KVxi69qFezFx1argCi4MjZytxuj+MrQ6Ini+WAUKYQKFtGOs6Jr5DXcs26QTVGT34XibXsnUNGHKS9cxD51ehsmVxlaW/nSyNEnZRxUkYH6vaLC6PEt2QJ92d32lgEjEmkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ5mX-0005gx-NE
	for linux-can@vger.kernel.org; Wed, 31 Jul 2024 11:38:05 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ5mP-003Upj-Jj
	for linux-can@vger.kernel.org; Wed, 31 Jul 2024 11:37:57 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 342C63128C3
	for <linux-can@vger.kernel.org>; Wed, 31 Jul 2024 09:37:57 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 2C86D31280B;
	Wed, 31 Jul 2024 09:37:51 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 06dbfc81;
	Wed, 31 Jul 2024 09:37:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 31 Jul 2024 11:37:10 +0200
Subject: [PATCH can-next v2 08/20] can: rockchip_canfd: add notes about
 known issues
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-rockchip-canfd-v2-8-d9604c5b4be8@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=71zf/MNfEu3gRqn5xXuWHDmR5jq4HnnTZs6zICou+pI=;
 b=owGbwMvMwMWoYbHIrkp3Tz7jabUkhrRVrBenl67kKfvcoy7hoMDhKBZXfHCGcrxm8sV11n8rD
 63oOfa7k9GYhYGRi0FWTJElwGFX24NtLHc199jFwwxiZQKZwsDFKQATmW3D/leI94G07MH8grvu
 Cz/NWJqsMKOBWeHAhqMqt+LU47YeVNHw3ywzJdSfeY1Z8mmldBnL20dStxtybVWyZjBjW1cw8bK
 pou7ynFjOpbxteldWWFbKdbXN/i2kXL/jXtCaY0KF4Q8cHdOk8+9dYVmZccqPhzVgfXjylcxvRT
 eeF4R3cFd9P5kUKyfvsj2agVV+YfbheKsTSYzZUjF7pgXOaOb7yxvxTGW5sPeTCfEa8wqm3zzw+
 oto84tf/4LFEqXeqWu1hojsqvNKq7Py7eDUY/Bbyj8pKfnkCcZb9byycxb3q37Z43f3hf76M/dc
 XTZxBUW9Kfyv2nNjxUrXg4bRCnFqvky7NbwuXMrfeHgLAA==
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
2.43.0



