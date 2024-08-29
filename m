Return-Path: <linux-can+bounces-1221-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9970B964ED7
	for <lists+linux-can@lfdr.de>; Thu, 29 Aug 2024 21:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8541F2432A
	for <lists+linux-can@lfdr.de>; Thu, 29 Aug 2024 19:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2FB1B9B47;
	Thu, 29 Aug 2024 19:29:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2C1B8E92
	for <linux-can@vger.kernel.org>; Thu, 29 Aug 2024 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959798; cv=none; b=AjVznRLZGfOYqG1nvmfdc7NxrKZI5moqoxoy/bnwLhBn7aWXMJE8oHmdCvstcIh2ZsKy5u669/wbe9kceKY7X+w+6ys3A3SYFkjWefLWwaoBCDSfsTY56BLuEgMpZm5u6CFmuzcPYZOzoDu1KTgJF03Qrv4uS2bV0QzCIPiJSMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959798; c=relaxed/simple;
	bh=/MR+HAyAZw+2PiJWvtj6224hPsLRGeEx2v8e3zK20pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRU9NwlHfKwwrKI5Yp01tYX0mrawxESW/XIacz/axgME/2t0gy6NzNj/UL7gZUFfI4702b/egFwkvgyUzR6Z6dUFQD3ApdhkPcCBpnGdnCx+1RnJs69MHdiUoBf6s5Vud9IZIfApTCyqYdFbcLT0ucVD/lFHGRwMBK/jEHPUz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjkqA-00064i-Dk
	for linux-can@vger.kernel.org; Thu, 29 Aug 2024 21:29:54 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjkq9-003ype-PU
	for linux-can@vger.kernel.org; Thu, 29 Aug 2024 21:29:53 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 7391F32D49A
	for <linux-can@vger.kernel.org>; Thu, 29 Aug 2024 19:29:53 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 078CB32D472;
	Thu, 29 Aug 2024 19:29:52 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7cede36d;
	Thu, 29 Aug 2024 19:29:51 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 04/13] can: m_can: Remove coalesing disable in isr during suspend
Date: Thu, 29 Aug 2024 21:20:37 +0200
Message-ID: <20240829192947.1186760-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240829192947.1186760-1-mkl@pengutronix.de>
References: <20240829192947.1186760-1-mkl@pengutronix.de>
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

From: Markus Schneider-Pargmann <msp@baylibre.com>

We don't need to disable coalescing when the interrupt handler executes
while the chip is suspended. The coalescing is already reset during
suspend.

Fixes: 07f25091ca02 ("can: m_can: Implement receive coalescing")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://lore.kernel.org/all/20240805183047.305630-3-msp@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 31991e2f343e..ba416c973e8d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1223,10 +1223,8 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	u32 ir;
 
-	if (pm_runtime_suspended(cdev->dev)) {
-		m_can_coalescing_disable(cdev);
+	if (pm_runtime_suspended(cdev->dev))
 		return IRQ_NONE;
-	}
 
 	ir = m_can_read(cdev, M_CAN_IR);
 	m_can_coalescing_update(cdev, ir);
-- 
2.45.2



