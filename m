Return-Path: <linux-can+bounces-5445-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D85C617CC
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 16:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B603B6599
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 15:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDE830C60E;
	Sun, 16 Nov 2025 15:56:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CE11FD4
	for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763308560; cv=none; b=jCRoWH9DQGAlaklknDVJ+bUUNVi7mYSY3R50eYHE5u47moDq23xZ2tIRlCYWoS/4bewtwLa3xZZz9POTOIKHEiDYmyymbYGCmp7BUvkKweqYtLg6CYJHPZxyIgCg3JHLDCQIYvjbvvVVIRkr+XlD4fVXxyNuBpfSBEIUWP2PiyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763308560; c=relaxed/simple;
	bh=piiZABcIkPvCH85m5XqijCtUq+SBcVfDPS3VKibeIzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gIkkmna6RPQz96YAg0BYZpflSxIJVckpz3OPanE11StVP6drOkuVPPQ1b51ihpAoswCoJ5G97I680uBG0G20Ydweae4UTeP5iJs30qNif/XhhtuaHOn/UshzciPcGTCYc47yo22ClSEI4xxW3QdgWPtKLXUE7E7d/yLQcIJwUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vKf6H-0006Dx-Vl; Sun, 16 Nov 2025 16:55:37 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vKf6G-000lfs-22;
	Sun, 16 Nov 2025 16:55:36 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 514694A0D69;
	Sun, 16 Nov 2025 15:55:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 16 Nov 2025 16:55:26 +0100
Subject: [PATCH can] can: sun4i_can: sun4i_can_interrupt(): fix max irq
 loop handling
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251116-sun4i-fix-loop-v1-1-3d76d3f81950@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAO7zGWkC/x2MQQqAIBAAvyJ7bqGVFOor0cFsq4XQUIpA+nvSc
 RhmCmROwhkGVSDxLVliqECNAr+7sDHKUhl0qw0RWcxX6ARXefCI8cRVW2M1zdb1PdToTFzdPxz
 BuwDT+36eMwq4ZQAAAA==
X-Change-ID: 20251116-sun4i-fix-loop-f265621b6a99
To: Vincent Mailhol <mailhol@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, 
 Maxime Ripard <mripard@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_M=C3=BChlbacher?= <tmuehlbacher@posteo.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=piiZABcIkPvCH85m5XqijCtUq+SBcVfDPS3VKibeIzs=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpGfP1O2x1G+zpjpRJjKaXo54TmBgwthKqzmzGq
 fbf/sJiZTiJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaRnz9QAKCRAMdGXf+ZCR
 nJaoB/4rjKBfJJSDQ4zQgHs1guSEV6YizBk5eiUmnvir8afm7j3J8t8qoG8bzJM8kaQ41q21AtI
 7NqTPanSTdclNme3HWvizX4SWZFi4TRxMIy4Mw+3sO3nuXCtVN+vwr6pBKhqQZELQ8fPrOMvZli
 xmK/aJhJKiPZp2vm8raNr5WhWDPrTtVkftP2TM8MnYCLbNG2aCPbxjb55KPpc4EMxvQUkdjdyCp
 eNzWiqHIMRpjXWSwVtqhAy1IUqjm/m03ywNMA+kar6PQCgEwsSGgTBDD9Vg/hbQMWp/42Z5QDTT
 K81IIXmX1yuSs0lberkstH0VPRbX/9FvRoIE8RPdQ23NC+89
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
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
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
I've ported the fix from the sja1000 driver to the sun4i_can, which based
on the sja1000 driver.
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
 

---
base-commit: 5442a9da69789741bfda39f34ee7f69552bf0c56
change-id: 20251116-sun4i-fix-loop-f265621b6a99

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


