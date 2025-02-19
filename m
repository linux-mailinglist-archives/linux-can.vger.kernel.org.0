Return-Path: <linux-can+bounces-2867-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A077EA3BCF9
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 12:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9DD3AD31F
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F971E1021;
	Wed, 19 Feb 2025 11:34:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6761DFDBE
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964848; cv=none; b=GVl8RueXiSIVsyWYCYpeOCK+gisBoE8bAKH5/I0ygBm3ZTbK5q4L9qCKaaDpfJN95ATj4fHUv3pi+OLroFvuNI5sXxWHr2mKzxxoQtJZmyoD3pJ/SUxU8NrNPdlb8eFVPT1ajfjCB0W2BOA5uxli6vDPajiwJjJRTVBpd3SV4Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964848; c=relaxed/simple;
	bh=Ev1sOu42cLM5jkWChK+VnNjHOcGc/P+KMG1k3VTaxh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtNyg1tugXvYllAUcwjbYg7misVEypbR9fiQBPLV7ssTK+JuEbWlL1H29wETC7T2INjNy5//82ho4vafC1ogugqrdTi6AIoqAC3vdgFVIf96BI0UsM+g2Pa9leMpHiMg1v4mUv+dTOvfxu7NLvZwix0NtlLROkzDuzBOpO1Nc40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL5-0001aw-I6
	for linux-can@vger.kernel.org; Wed, 19 Feb 2025 12:34:03 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL3-001l2O-1b
	for linux-can@vger.kernel.org;
	Wed, 19 Feb 2025 12:34:01 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id DAB6E3C693B
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:34:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 283003C68F3;
	Wed, 19 Feb 2025 11:33:58 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f43059fb;
	Wed, 19 Feb 2025 11:33:57 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Robin van der Gracht <robin@protonic.nl>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 12/12] can: rockchip_canfd: rkcanfd_chip_fifo_setup(): remove duplicated setup of RX FIFO
Date: Wed, 19 Feb 2025 12:21:17 +0100
Message-ID: <20250219113354.529611-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219113354.529611-1-mkl@pengutronix.de>
References: <20250219113354.529611-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Link: https://patch.msgid.link/20250219-rk3568-canfd-v1-1-453869358c72@pengutronix.de
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
-- 
2.47.2



