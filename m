Return-Path: <linux-can+bounces-4583-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D06B504AE
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 19:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F81367602
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 17:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39E735CEA7;
	Tue,  9 Sep 2025 17:53:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6435A289
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440428; cv=none; b=IGtGLu9BwiBe4wPQSFDk2vRTliJWIGlGO3gX7+Cn5/HxRvNb4QbXYLGP1PufutdirHqFUN7Kyx5G344CQ7WO/lm+Fkv4w7LiiptxdJV5SR7OVt2uF5mTSjDhSfiZ71oDJVdDX3rG6Hgis7rssmC9w704NXX2BHMfxr95vek8QeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440428; c=relaxed/simple;
	bh=0byzwlFpX3uUliiyBljE0GoBt/DbYN9wqAMAHOwqTqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k+WZaON4Sjisd0TCUpK+0uSRK1/Ndeill1hmJWFjNdCeu+eqp6arCQEfiTbPyAgfZviIGlz0P50WnIUFhIFQ7syQLLlX2OQaurDhyZYZlLYtlALluMiyDZb9lE1N0Nf7qpiF0OXgVTLFqpv2ysj8IakKwOdcxvcJkEopQTTAY6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uw2XI-0006iB-JW
	for linux-can@vger.kernel.org; Tue, 09 Sep 2025 19:53:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uw2XH-000SbO-3B
	for linux-can@vger.kernel.org;
	Tue, 09 Sep 2025 19:53:44 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id AB4F546A3D0
	for <linux-can@vger.kernel.org>; Tue, 09 Sep 2025 17:53:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 2C50246A39B;
	Tue, 09 Sep 2025 17:53:41 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3481596a;
	Tue, 9 Sep 2025 17:53:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 09 Sep 2025 19:53:18 +0200
Subject: [PATCH v2 2/7] can: m_can: only handle active interrupts
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-m_can-fix-state-handling-v2-2-af9fa240b68a@pengutronix.de>
References: <20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de>
In-Reply-To: <20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Patrik Flykt <patrik.flykt@linux.intel.com>, 
 Dong Aisheng <b29396@freescale.com>, Varka Bhadram <varkabhadram@gmail.com>, 
 Wu Bo <wubo.oduw@gmail.com>, Markus Schneider-Pargmann <msp@baylibre.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=1416; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=0byzwlFpX3uUliiyBljE0GoBt/DbYN9wqAMAHOwqTqs=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBowGmZORUk+vP0SVB8a7q64+4PJf/xTopuCAsch
 7WBJqhsNbOJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaMBpmQAKCRAMdGXf+ZCR
 nHg2CACFM6/VGR/XRQV48GV6MRSokJwWaGFtgQxsy+hyV2cyy0+4LzFgiWvAilTY1FnT0kyKav3
 V2/JY5vdf2185Yj43+3KUpAeXcrkyybHEMhxIgv0tAwejkOdCnGcxWuEgqGlwJoKfti0cfoUU6e
 xc1vud4T1XSZNrnS7QdaG2XZX1LGtwBK3OJJoVhLVgh5LrIe6KVCaQhpqKvl/noEk6ej7rz+AkB
 qedYS2zomGWikSUCcHfOmT0X8P559FD2REPAm58q7i4maqL3vX35a8/dlGuZUFjWWgG1nfIcGEI
 wdDB8Nov3O/ar+pP4vuLNQKuKd9LQqXoImQEJC5dIEWQ5PvZ
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The M_CAN IP core has an Interrupt Register (IR) and an Interrupt
Enable (IE) register. An interrupt is triggered if at least 1 bit is
set in the bitwise and of IR and IE.

Depending on the configuration not all interrupts are enabled in the
IE register. However the m_can_rx_handler() IRQ handler looks at all
interrupts not just the enabled ones. This may lead to handling of not
activated interrupts.

Fix the problem and mask the irqstatus (IR register) with the
active_interrupts (cached value of IE register).

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index fe74dbd2c966..16b38e6c3985 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1057,6 +1057,7 @@ static int m_can_poll(struct napi_struct *napi, int quota)
 	u32 irqstatus;
 
 	irqstatus = cdev->irqstatus | m_can_read(cdev, M_CAN_IR);
+	irqstatus &= cdev->active_interrupts;
 
 	work_done = m_can_rx_handler(dev, quota, irqstatus);
 
@@ -1243,6 +1244,8 @@ static int m_can_interrupt_handler(struct m_can_classdev *cdev)
 	}
 
 	m_can_coalescing_update(cdev, ir);
+
+	ir &= cdev->active_interrupts;
 	if (!ir)
 		return IRQ_NONE;
 

-- 
2.51.0



