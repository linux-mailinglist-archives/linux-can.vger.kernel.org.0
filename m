Return-Path: <linux-can+bounces-2855-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3837A3BC8E
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 12:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E15177532
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E4F1A5BA4;
	Wed, 19 Feb 2025 11:15:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C71B982E
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963754; cv=none; b=I6F+n4R1n3Xs2AVNnnhiqs6qYP5fzXGY/Cnr8kim7Br66zaeMbuFzX5mAYH2u3Rr9TjlanVYPzYY2AvRWSrJLj4iwCDTMqrQSELHU9z78gkRoopC4tlOlbhndPTA9fzsG3zcftCl02DMoOaBwcbfLIDBSetIACFxiXwtonkicAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963754; c=relaxed/simple;
	bh=bOVVUhjugw19Gfrb/l/6mPgJ8c9PnJ9LTdeHOKfiSvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hl3BUXcuBCmCoX+xtgcFw/yQmzh6Dv+VMgKMkCheO0X+oFuHYiGAwbYuw6jNzlefFtyIXLhYdUDrFQjhxgfiBS/GNHfQOp6gzqK5/B5jJBsOjVfNT4PJvrtOYQoNsgjIClVvTvn8U1+OR91kWu7qTcIx8QzTNaFe/UQWp3Z3pik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tki3S-0007ih-ON
	for linux-can@vger.kernel.org; Wed, 19 Feb 2025 12:15:50 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tki3S-001kvJ-1o
	for linux-can@vger.kernel.org;
	Wed, 19 Feb 2025 12:15:50 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 409AB3C68B8
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:15:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 8761B3C68B1;
	Wed, 19 Feb 2025 11:15:48 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6b31c62b;
	Wed, 19 Feb 2025 11:15:47 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 19 Feb 2025 12:15:43 +0100
Subject: [PATCH] can: rockchip_canfd: rkcanfd_chip_fifo_setup(): remove
 duplicated setup of RX FIFO
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-rk3568-canfd-v1-1-453869358c72@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAF69tWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0NL3aJsY1MzC93kxLy0FN1EgzTLZEMDY3NTw1QloJaCotS0zAqwcdG
 xtbUAoxA+Ql4AAAA=
X-Change-ID: 20250219-rk3568-canfd-a0f9c103751e
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Robin van der Gracht <robin@protonic.nl>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=0jv/61mY47TiBPd7dSSwJFiyxZt74jw07+buK5Y0ayc=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBntb1hbnXZkPMz9MY3Cfse6k0cP85QCzJJp31vP
 upyoPxOHZOJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCZ7W9YQAKCRAMdGXf+ZCR
 nDx2B/wMkgexjMLtIBIpBULLQeVoO4zztTTxqk7ktd02LkxjPIUwI38QEVc3Vz6jtzX3glN8l5L
 pJz15GesciFTiuy1BokVMkOHy0Lb7psPmunMBM/MdUSMMRVSh1Nu/Yt653ADtd5mkMi2WrsxndT
 3TCUtUbeHBSeiMwzcs82KOIMnxM06R035C6mOl7B2rL+k2qya2j44KHM9RxOiF4gkla0EeB/MIw
 CygC8fSuYPNLojiahS8Ql9FOEiUlluPhEFivU4g8UBmiEDnXNSyFC77J+PDWUKahmw3RrguWKt5
 5CervoNvuD7w/YeofUArG6ySVl8qwad6AeaB/RnWVt8QusTt
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Robin van der Gracht <robin@protonic.nl>

The rockchip_canfd driver doesn't make use of the TXE FIFO.

Although the comment states that the TXE FIFO is setup, it's actually
a setup of the RX FIFO. The regular setup of the RX FIFO follows.

Remove the duplicated setup of the RX FIFO.

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Signed-off-by: Robin van der Gracht <robin@protonic.nl>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index d9a937ba126c..46201c126703 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -236,11 +236,6 @@ static void rkcanfd_chip_fifo_setup(struct rkcanfd_priv *priv)
 {
 	u32 reg;
 
-	/* TXE FIFO */
-	reg = rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
-	reg |= RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_ENABLE;
-	rkcanfd_write(priv, RKCANFD_REG_RX_FIFO_CTRL, reg);
-
 	/* RX FIFO */
 	reg = rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
 	reg |= RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_ENABLE;

---
base-commit: aefd232de5eb2e77e3fc58c56486c7fe7426a228
change-id: 20250219-rk3568-canfd-a0f9c103751e

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



