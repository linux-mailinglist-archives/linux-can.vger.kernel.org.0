Return-Path: <linux-can+bounces-2763-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87289A2D5A2
	for <lists+linux-can@lfdr.de>; Sat,  8 Feb 2025 11:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17A1188A58A
	for <lists+linux-can@lfdr.de>; Sat,  8 Feb 2025 10:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910561B4235;
	Sat,  8 Feb 2025 10:40:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B451B85D2
	for <linux-can@vger.kernel.org>; Sat,  8 Feb 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739011226; cv=none; b=O8p5jmoFCz1vNvVc5XnB79CsqQEEtaQVKHF2xNbKbARqfxdwLKoOuSiWcq6GlFrUkhmUX642pqQM9du7MqgpNWGeHuXpZb+dpocsjXUFbD8BDBaLrIUwRwP3+YY9ur3z9ppU5uKa2Vq0kdQRv5g/gHPLhYe/tWdCHJ3PNFwCelg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739011226; c=relaxed/simple;
	bh=86tImnlX82BynRtV2Tzz1EH8dQlhNptEGIZQcPj843k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AL8lrekWxnqXqn9Yj0d6EJVEBMwBoTwt4TamOMCyPVZ6+vz4VMpH5E9XPBMHigv3CS2mBIHRwmhWw1UhPLPkb1qyCyA7bhG0hVpUkCm3LkOPbmY+KH4u8nrs02iDF0xYIvjywKhYNRejzEq4I6WoqZKCne1nHmCKEmx3o8SiYQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tgiG4-0001Tr-Gd
	for linux-can@vger.kernel.org; Sat, 08 Feb 2025 11:40:20 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tgiG4-0047tZ-0w
	for linux-can@vger.kernel.org;
	Sat, 08 Feb 2025 11:40:20 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id F198B3BCC80
	for <linux-can@vger.kernel.org>; Sat, 08 Feb 2025 10:40:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0D0D73BCC79;
	Sat, 08 Feb 2025 10:40:15 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d4e51cb2;
	Sat, 8 Feb 2025 10:40:13 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 08 Feb 2025 11:40:10 +0100
Subject: [PATCH] can: rockchip: rkcanfd_handle_rx_fifo_overflow_int(): bail
 out if skb cannot be allocated
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250208-fix-rockchip-canfd-v1-1-ec533c8a9895@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAIk0p2cC/x2MUQqAIBAFrxL73YKKQXWV6CPWZy2BhUIE0d2TP
 gdm5qGCrCg0Ng9lXFr0SBVs25BsS1rBGiqTM64zzvQc9eZ8yC6bnixLioEFZoCFd15ANTwzqvV
 Pp/l9P3aUMVNkAAAA
X-Change-ID: 20250208-fix-rockchip-canfd-ce09e1e424ce
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Robin van der Gracht <robin@protonic.nl>, 
 stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-33ea6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=PwbCo7t4iBsksyF7q8Utv/uAB57+6RRB9poqEpMgKGU=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBnpzSLeZF041hFWwJznMla/rYHo/Kr6M9ABoeEf
 I30PGx2iY+JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCZ6c0iwAKCRAMdGXf+ZCR
 nK6oB/4/q1HDynZTpdxTvLZh2kNz03joEazK23rP5OaVDdzxMt39NZgK4+AzopoLbD3O8gbIXfl
 QCtWdlnRVwaTcCtmmJqqb0yu8BRJICWoQKbf+ehUfQaztoL4BKL6/o3BYJidhBOyyuzursTjyjk
 mjbs5geqx+qrD5WdFmZ+TUomvekUehuAs5CdXOesMv7B+1L1K992GB0UFt21sb7dz4KncplCeb8
 MVhgA+oKUYX5VF4Cy5f5scDeCs7Mxry4VzUR78A9mhTVsATt1jIoY/JT/zivCTxDZSnlNbM3hra
 yYzEOI+KVXmIsvCfzVzGKSaS3TksIKFye2pf1ocqtWO7zM4I
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Robin van der Gracht <robin@protonic.nl>

Fix NULL pointer check in rkcanfd_handle_rx_fifo_overflow_int() to
bail out if skb cannot be allocated.

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Cc: stable@vger.kernel.org
Signed-off-by: Robin van der Gracht <robin@protonic.nl>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index df18c85fc078..d9a937ba126c 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -622,7 +622,7 @@ rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
 	netdev_dbg(priv->ndev, "RX-FIFO overflow\n");
 
 	skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
-	if (skb)
+	if (!skb)
 		return 0;
 
 	rkcanfd_get_berr_counter_corrected(priv, &bec);

---
base-commit: 1438f5d07b9a7afb15e1d0e26df04a6fd4e56a3c
change-id: 20250208-fix-rockchip-canfd-ce09e1e424ce

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



