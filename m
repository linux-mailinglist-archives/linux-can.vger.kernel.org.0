Return-Path: <linux-can+bounces-1433-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08936970DDC
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 08:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B81282B78
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 06:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60221AD3E1;
	Mon,  9 Sep 2024 06:27:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B759618DF75
	for <linux-can@vger.kernel.org>; Mon,  9 Sep 2024 06:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725863223; cv=none; b=d+ic+cYNPyREXS1+SZhxcx/epyPXZ7yK4PPl8+VA1QbGZnCTo7p7tsfuvRVkBbb/MeJgFug+yzdP5yS9SiNC+jGLy4bSNIqVihQrLc374v8BvRN+7vG3Itg8dzQqt3OgKNKpMyyg4WKQ/A4Ti8LzEQ8SA80XWpApCYQ+ypfT3vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725863223; c=relaxed/simple;
	bh=jOLl/YUfN9Kib9erf2YkpEcSGJdS+XScDgfrk4H3TZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VTWTdYvsgqjwj3evruWKZDdFoX1nUxOydvve45zhYWZ2VRTMeLjZjFG9bPpLzYqPHS6wnWy2C0d09AjDDfVmujB8qmguyQzeoAwb84Xk87IiiaaP+2zgnBGcGfRSinP3zWDH63298O/ZoiXULxLjQVrR9trkYwqNxnuljkOQ33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1snXrW-0002GI-CI
	for linux-can@vger.kernel.org; Mon, 09 Sep 2024 08:26:58 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1snXrV-006aOR-PM
	for linux-can@vger.kernel.org; Mon, 09 Sep 2024 08:26:57 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C6C6C33616F
	for <linux-can@vger.kernel.org>; Mon, 09 Sep 2024 06:21:56 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 395B333615A;
	Mon, 09 Sep 2024 06:21:54 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id fcd9152b;
	Mon, 9 Sep 2024 06:21:53 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 09 Sep 2024 08:21:49 +0200
Subject: [PATCH] can: rockchip_canfd: rkcanfd_timestamp_init(): fix 64 bit
 division on 32 bit platforms
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-can-rockchip_canfd-fix-64-bit-division-v1-1-2748d9422b00@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAPyT3mYC/yXN0QqDMAyF4VeRXBvoRB31VYaIJukMQpVWRBDff
 WFefnD4zwVZkkqGrrggyaFZ12h4lQXQPMavoLIZKlfVzjuPNEZMKy006zYYAmPQE9saJ92R9Ul
 gE5q3D8wykQeLbUls9j/69Pf9A3YqY8R4AAAA
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=jOLl/YUfN9Kib9erf2YkpEcSGJdS+XScDgfrk4H3TZw=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm3pP+A1YrjAv0lzrha1Nz9rc4vPQQl58ocRltf
 dWB5/nQhB6JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZt6T/gAKCRAoOKI+ei28
 b9sKB/wKSh1HQddIfxdzPaV1MxLN0kLc2tvUQTxavUh6omqbZfw2yaAVlBUj2NVOPcI/hHqO47Z
 XDdE8vzNyHfdKYtbQb7ln4iNMxoHMiGlnZGcilapFzBQOPlQnbkGhum9fMpdnPHLodtasuwc2s6
 cf6RDW0xEQ+ZVpG5nSOZWK8/wbYYUrZubzk+rs9rW7BM0VCWe4VNwsCz9o/LLLrfiU8ohC6Z8pd
 VsunCw84awq9wjDRWReZH0h5/1QoRgjvGPDPBEYASO26WSQ4hAWc+K1wgkm9PPZsHZ6xtYh3ykE
 KHMnTOeUz94vn6b6YvtZaCaHho8PjQgTD40zKPZ9JP8O98JR
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On some 32-bit platforms (at least on parisc), the compiler generates
a call to __divdi3() from the u32 by 3 division in
rkcanfd_timestamp_init(), which results in the following linker
error:

| ERROR: modpost: "__divdi3" [drivers/net/can/rockchip/rockchip_canfd.ko] undefined!

As this code doesn't run in the hot path, a 64 bit by 32 bit division
is OK, even on 32 bit platforms. Use an explicit call to div_u64() to
fix linking.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409072304.lCQWyNLU-lkp@intel.com/
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-timestamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
index 81cccc5fd838..fb1a8f4e6217 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -71,7 +71,7 @@ void rkcanfd_timestamp_init(struct rkcanfd_priv *priv)
 
 	max_cycles = div_u64(ULLONG_MAX, cc->mult);
 	max_cycles = min(max_cycles, cc->mask);
-	work_delay_ns = clocksource_cyc2ns(max_cycles, cc->mult, cc->shift) / 3;
+	work_delay_ns = div_u64(clocksource_cyc2ns(max_cycles, cc->mult, cc->shift), 3);
 	priv->work_delay_jiffies = nsecs_to_jiffies(work_delay_ns);
 	INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);
 

---
base-commit: c259acab839e57eab0318f32da4ae803a8d59397
change-id: 20240909-can-rockchip_canfd-fix-64-bit-division-5f579fddebc9

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



