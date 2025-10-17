Return-Path: <linux-can+bounces-5213-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C48BE9A45
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 17:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3702E509481
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 15:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7239732E155;
	Fri, 17 Oct 2025 15:08:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F11E32E121
	for <linux-can@vger.kernel.org>; Fri, 17 Oct 2025 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713719; cv=none; b=Gr2A4hSAP/xmlf1KLqGWj3R3PGgCho1BbR8ftLUGlpQ6yVZp1nDqeKlP2Me8tyN73B8u4YfThUgfvR83jqLJ99UE5xmjdDNmaKlLfcUzAT/OSyo0E4Ez6BQ9nmk7FmlVt/GJQBkhpbqt+SsoLee8pZ+vysVhEZxhFpaeG+cJ94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713719; c=relaxed/simple;
	bh=PgAVlU0p78/Y0TsSgUE3KhKk5RF1WmvQ0WRjSSHkvOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErIl8XaUUWKRxk+TGurYwAAFZsC30abgreQB2Pg1HVWsFhAPit7/JdtniNol2FBHzeK7nQXaZA2vuoz6u2fJF5qXAZ/rHJkwMWwBfAuwxIiIRb0Ltego3CL78CnTvnDv1LW4oXxC4krwN9GJXwVYn8455Njmd55o3F5D4wCJuX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4E-0003NO-2L; Fri, 17 Oct 2025 17:08:30 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4D-00450k-2i;
	Fri, 17 Oct 2025 17:08:29 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 95F084892B9;
	Fri, 17 Oct 2025 15:08:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/13] can: m_can: hrtimer_callback(): rename to m_can_polling_timer()
Date: Fri, 17 Oct 2025 17:04:16 +0200
Message-ID: <20251017150819.1415685-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017150819.1415685-1-mkl@pengutronix.de>
References: <20251017150819.1415685-1-mkl@pengutronix.de>
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

The original use of struct m_can_classdev::hrtimer was to support polling
for devices without IRQ, with the timer function called hrtimer_callback().

Commit 07f25091ca02 ("can: m_can: Implement receive coalescing") uses the
hrtimer for software-supported IRQ coalescence, with the timer function
called m_can_coalescing_timer().

To improve the readability of the driver, rename hrtimer_callback() to
m_can_polling_timer(), which better describes the functionality.

Link: https://patch.msgid.link/20251008-m_can-cleanups-v1-2-1784a18eaa84@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9f4002f3481e..110cfd54b669 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2058,7 +2058,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
-static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
+static enum hrtimer_restart m_can_polling_timer(struct hrtimer *timer)
 {
 	struct m_can_classdev *cdev = container_of(timer, struct
 						   m_can_classdev, hrtimer);
@@ -2545,7 +2545,7 @@ int m_can_class_register(struct m_can_classdev *cdev)
 
 	if (!cdev->net->irq) {
 		dev_dbg(cdev->dev, "Polling enabled, initialize hrtimer");
-		hrtimer_setup(&cdev->hrtimer, &hrtimer_callback, CLOCK_MONOTONIC,
+		hrtimer_setup(&cdev->hrtimer, m_can_polling_timer, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_PINNED);
 	} else {
 		hrtimer_setup(&cdev->hrtimer, m_can_coalescing_timer, CLOCK_MONOTONIC,
-- 
2.51.0


