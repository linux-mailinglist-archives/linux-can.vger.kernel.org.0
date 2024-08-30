Return-Path: <linux-can+bounces-1282-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6928A966BD8
	for <lists+linux-can@lfdr.de>; Sat, 31 Aug 2024 00:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF920285010
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 22:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF9B1C1ADC;
	Fri, 30 Aug 2024 21:59:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885961C1759
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725055165; cv=none; b=EG9aH9wuLKwF8GqC00QVDbOStqyZ7+THDDiMF6lQT77o1v7ac3JUeAKpv7RY1IBL75J0YxJeIqTCHFxIrz65h7y00v6yM/v6KSULv2hg1u0zDpLbiPzdwMZGrw8uoOh82dzkVRuFMg9xEAjzRrTVmqe/7aQGOv+FzpCgHUO2S1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725055165; c=relaxed/simple;
	bh=+vrFZ/bsF/ac7pfr3aYEdyZAiv7u5jDIM1t4nDMRxX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvrFGYycBqJzzm9qto8QbPYrf9Gye6ampvqRic3gKn6lkznJHVwxtIHR5KNIHNsxdJ5L4DfD4Qs271qFAjLhskFUz8JynEJMO6368ydrT+kYiCSLJbjSPgpRMuX24qGf8TdT7bpph1s/JFyNznk3KDaG/XcmEsS/47ZJnMX7omQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eL-0004De-HQ
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:59:21 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eJ-004FXK-LS
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:59:19 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5A37C32E51C
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:59:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0D49832E4DA;
	Fri, 30 Aug 2024 21:59:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 22626d73;
	Fri, 30 Aug 2024 21:59:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 05/13] can: m_can: Remove m_can_rx_peripheral indirection
Date: Fri, 30 Aug 2024 23:53:40 +0200
Message-ID: <20240830215914.1610393-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830215914.1610393-1-mkl@pengutronix.de>
References: <20240830215914.1610393-1-mkl@pengutronix.de>
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

m_can_rx_peripheral() is a wrapper around m_can_rx_handler() that calls
m_can_disable_all_interrupts() on error. The same handling for the same
error path is done in m_can_isr() as well.

So remove m_can_rx_peripheral() and do the call from m_can_isr()
directly.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://lore.kernel.org/all/20240805183047.305630-4-msp@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index ba416c973e8d..a37ed376de9b 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1037,22 +1037,6 @@ static int m_can_rx_handler(struct net_device *dev, int quota, u32 irqstatus)
 	return work_done;
 }
 
-static int m_can_rx_peripheral(struct net_device *dev, u32 irqstatus)
-{
-	struct m_can_classdev *cdev = netdev_priv(dev);
-	int work_done;
-
-	work_done = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, irqstatus);
-
-	/* Don't re-enable interrupts if the driver had a fatal error
-	 * (e.g., FIFO read failure).
-	 */
-	if (work_done < 0)
-		m_can_disable_all_interrupts(cdev);
-
-	return work_done;
-}
-
 static int m_can_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *dev = napi->dev;
@@ -1250,7 +1234,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 		} else {
 			int pkts;
 
-			pkts = m_can_rx_peripheral(dev, ir);
+			pkts = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, ir);
 			if (pkts < 0)
 				goto out_fail;
 		}
-- 
2.45.2



