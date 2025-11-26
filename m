Return-Path: <linux-can+bounces-5740-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13539C8AC5A
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 16:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB1024ED120
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D7833CE91;
	Wed, 26 Nov 2025 15:57:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2529333BBD3
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172648; cv=none; b=V5w3Y5c20BKpjYtMyPeUsFdvQ4Zl6mNOtsdRz6o+vtCgPL8U7JFqsJBUWQEZBw8vo1DYZLUT+57nNJZqxmPHpG/8S8VOLftokuJQU7hNSLvqztu5Yz518BtlBD4HD4UDZ4nPEj2/DFAD67M2AjkAPGqX4jx5miK6I9sN0sOVyd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172648; c=relaxed/simple;
	bh=5K2shWIi4ZIOaKtu/+d9B6vxPEUqBRi9MTPtHlXZErU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=On1jp5qv7Nyy9Pj8OxtM+sQ/bTLRUCejGya3T5yRw/hipbB//u8ftk5n/gK7HHqYY3RiKWHjYjwzDOKodSa48xVpXc2GTLCT+/ITdeacUqZgFXLaqPuTYKNBz8szHoBKrj7kcBKP/PI4MsvLUrapL9aj4A7rHvDP4b723hE2xPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOHtP-000654-EM; Wed, 26 Nov 2025 16:57:19 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOHtO-002dLl-0R;
	Wed, 26 Nov 2025 16:57:18 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D8A284A8E36;
	Wed, 26 Nov 2025 15:57:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	stable@vger.kernel.org,
	=?UTF-8?q?Thomas=20M=C3=BChlbacher?= <tmuehlbacher@posteo.net>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH net 6/8] can: sun4i_can: sun4i_can_interrupt(): fix max irq loop handling
Date: Wed, 26 Nov 2025 16:41:16 +0100
Message-ID: <20251126155713.217105-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126155713.217105-1-mkl@pengutronix.de>
References: <20251126155713.217105-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Reading the interrupt register `SUN4I_REG_INT_ADDR` causes all of its bits
to be reset. If we ever reach the condition of handling more than
`SUN4I_CAN_MAX_IRQ` IRQs, we will have read the register and reset all its
bits but without actually handling the interrupt inside of the loop body.

This may, among other issues, cause us to never `netif_wake_queue()` again
after a transmission interrupt.

Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Kernel module")
Cc: stable@vger.kernel.org
Co-developed-by: Thomas Mühlbacher <tmuehlbacher@posteo.net>
Signed-off-by: Thomas Mühlbacher <tmuehlbacher@posteo.net>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Link: https://patch.msgid.link/20251116-sun4i-fix-loop-v1-1-3d76d3f81950@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sun4i_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 53bfd873de9b..0a7ba0942839 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -657,8 +657,8 @@ static irqreturn_t sun4i_can_interrupt(int irq, void *dev_id)
 	u8 isrc, status;
 	int n = 0;
 
-	while ((isrc = readl(priv->base + SUN4I_REG_INT_ADDR)) &&
-	       (n < SUN4I_CAN_MAX_IRQ)) {
+	while ((n < SUN4I_CAN_MAX_IRQ) &&
+	       (isrc = readl(priv->base + SUN4I_REG_INT_ADDR))) {
 		n++;
 		status = readl(priv->base + SUN4I_REG_STA_ADDR);
 
-- 
2.51.0


