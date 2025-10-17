Return-Path: <linux-can+bounces-5209-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 931C3BE973C
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 17:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A8335679EF
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 15:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4CD32C95E;
	Fri, 17 Oct 2025 15:00:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279C2F12DB
	for <linux-can@vger.kernel.org>; Fri, 17 Oct 2025 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713240; cv=none; b=LA/dYZ5fSgs8zMvfhGc65MTe6vn/TCUkV1DGeIBhYPqSTc1ajTnnKRqrbBam8f2oLyJK3pMZd/ibztxOB1by1xHemc/q8jtpJvEG3jXEVRvxClz47S6vfodIj7gq7NGcSN27xbcvt0tDuWFm4lVNqFe1Ow8p22r7xWt91vKLwOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713240; c=relaxed/simple;
	bh=F4a/XMUroicMRAYsm6IQd8Sb7/zo6UMhiCf/jB5UKcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=urWuVBA2CBqUgzh54ZgxdxDBsFlL7h1o4wH9CZvhxBlYgCQkNR6MUBu58GPoriJPeBk9ziZw5X6nZJ+4YNRXR9uMvim9rvK1PvLyNyhCQ5G4yapHGarCXaR4UWkgAQDy3WUWJ/Fe97wJgngOtpYueHfREjzFVE+/2f+vb1RFaK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9lwJ-00028E-Pd; Fri, 17 Oct 2025 17:00:19 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9lwJ-0044jY-08;
	Fri, 17 Oct 2025 17:00:19 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B1B9848928A;
	Fri, 17 Oct 2025 15:00:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 17 Oct 2025 17:00:00 +0200
Subject: [PATCH can 2/3] can: esd: acc_start_xmit(): use
 can_dev_dropped_skb() instead of can_dropped_invalid_skb()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-fix-skb-drop-check-v1-2-556665793fa4@pengutronix.de>
References: <20251017-fix-skb-drop-check-v1-0-556665793fa4@pengutronix.de>
In-Reply-To: <20251017-fix-skb-drop-check-v1-0-556665793fa4@pengutronix.de>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 =?utf-8?q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>, socketcan@esd.eu, 
 Heiko Stuebner <heiko@sntech.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-2196b
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=F4a/XMUroicMRAYsm6IQd8Sb7/zo6UMhiCf/jB5UKcA=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo8ln+Ky5PD8g/b+iC8YlHzgku2aPt+KmkZSjxG
 LCPwGfVZs6JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaPJZ/gAKCRAMdGXf+ZCR
 nD9OB/9HSM0rxxe1NUTauClQoPA95TEmusUCxgUDXWHYlfwjPJbSmhlwYpj03L3MfQLS3w7Q4g/
 fzMGbdGgTLb7xxkcRWKXU2N+vK3s1mgp12/OExQuOrX78mqlI06dexI3qvDpyMxQ65ImqN+gDEh
 hOMuJsXIkPoCNP+VY+iYETzZf8TLyvCzyP2v5nA1WEgcgMq6sQyAHW2QczVT8isqVFNoeEF274z
 ZFOdYCyVkmvhwDwAmCp0+yEbYH8o03ipDv5RHQhaiuPO/uUNgSsahn71LzCUfPIBCYwxOyh9pgY
 IKX027FSBam3ZCgx2ewbUT70+Xg+QUz6BvrxehjH9kWagBft
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

In addition to can_dropped_invalid_skb(), the helper function
can_dev_dropped_skb() checks whether the device is in listen-only mode and
discards the skb accordingly.

Replace can_dropped_invalid_skb() by can_dev_dropped_skb() to also drop
skbs in for listen-only mode.

Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Closes: https://lore.kernel.org/all/20251017-bizarre-enchanted-quokka-f3c704-mkl@pengutronix.de/
Fixes: 9721866f07e1 ("can: esd: add support for esd GmbH PCIe/402 CAN interface family")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/esd/esdacc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
index c80032bc1a52..73e66f9a3781 100644
--- a/drivers/net/can/esd/esdacc.c
+++ b/drivers/net/can/esd/esdacc.c
@@ -254,7 +254,7 @@ netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	u32 acc_id;
 	u32 acc_dlc;
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
 	/* Access core->tx_fifo_tail only once because it may be changed

-- 
2.51.0


