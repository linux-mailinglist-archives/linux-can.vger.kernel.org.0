Return-Path: <linux-can+bounces-1877-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB76E9BBE66
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 21:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50881C2161E
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 20:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F011D4325;
	Mon,  4 Nov 2024 20:01:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7518D63C
	for <linux-can@vger.kernel.org>; Mon,  4 Nov 2024 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750489; cv=none; b=SotR+OCUU/1PANQIIN4IIIsOSce0NnXd/Gu3L9tHbtMviMqpSjcjRXHgEk+WlqmR9zNXEVx4ughXjS2DB4xNQGtsEBT87NqRq9poA1OHs5HxPPsVVlmiN34IgZDsUMLi0K8RIjoKCSiEo7sDSF8uaZt3wjlGn6lXh4yk5HGN6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750489; c=relaxed/simple;
	bh=GZI/NOPHCzzHFVbi9dE9r52MjUL+Q82WO7D92MTiLbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ft4UcyY7ovxgZrdp4s+FmOsAsfi2XTYkMmxljEuVIECJXcCtVX6r/mOOf59Vb4hqC3wl468Mk+pPh7/tr3aOamEEXgaQAb4RQY4pzLlrrKvdedFErHMa+8np6Wu5psT/qlO4TaBFDp5GBknvhnAfb00JSebhAXqiLn5hXB9LjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t83GP-0001YY-8i
	for linux-can@vger.kernel.org; Mon, 04 Nov 2024 21:01:25 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t83GO-00224e-1t
	for linux-can@vger.kernel.org;
	Mon, 04 Nov 2024 21:01:24 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 44116367F8B
	for <linux-can@vger.kernel.org>; Mon, 04 Nov 2024 20:01:24 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 6BC09367F63;
	Mon, 04 Nov 2024 20:01:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 22a48971;
	Mon, 4 Nov 2024 20:01:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	stable@vger.kernel.org
Subject: [PATCH net 3/8] can: m_can: m_can_close(): don't call free_irq() for IRQ-less devices
Date: Mon,  4 Nov 2024 20:53:26 +0100
Message-ID: <20241104200120.393312-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104200120.393312-1-mkl@pengutronix.de>
References: <20241104200120.393312-1-mkl@pengutronix.de>
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

In commit b382380c0d2d ("can: m_can: Add hrtimer to generate software
interrupt") support for IRQ-less devices was added. Instead of an
interrupt, the interrupt routine is called by a hrtimer-based polling
loop.

That patch forgot to change free_irq() to be only called for devices
with IRQs. Fix this, by calling free_irq() conditionally only if an
IRQ is available for the device (and thus has been requested
previously).

Fixes: b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://patch.msgid.link/20240930-m_can-cleanups-v1-1-001c579cdee4@pengutronix.de
Cc: <stable@vger.kernel.org> # v6.6+
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a978b960f1f1..16e9e7d7527d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1765,7 +1765,8 @@ static int m_can_close(struct net_device *dev)
 	netif_stop_queue(dev);
 
 	m_can_stop(dev);
-	free_irq(dev->irq, dev);
+	if (dev->irq)
+		free_irq(dev->irq, dev);
 
 	m_can_clean(dev);
 
-- 
2.45.2



