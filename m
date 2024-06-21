Return-Path: <linux-can+bounces-811-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 475AF911E10
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C0AB24B14
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAB0171E41;
	Fri, 21 Jun 2024 08:02:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F50171096
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956935; cv=none; b=eh1aBCaqFAiek4rFxn6hAmr80bxI0GdsEQProI+cDuSeCSFkuaS7Se2iJHl+46x9XwG90kAe0OmCCYPefDSDB8aSRZ8otpWeXMxAN15f7gmSvHdm2DGDorVo+GKHYA97JQAgnQtXASUoaPraY8hrIDFZLsTqczviyMX9ki/woi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956935; c=relaxed/simple;
	bh=doOXYwfMirPzWda1p+ei3bi3f/RzkjzS1xON7WhnMDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZOT2hKqVlvOcLnJEnfPJkysHA7nIVNQsjbXGXJEX/vuPO0bhiHshKm0H1A++Y5Y36V2e6OxFzN5MojWx80i8MCRfQFG+xtlYLBuyWGSND7vZfH5+QvCEJIffqpXzWe5D4GxTp4pJks8z9UXMOLjGImdjbJoRAgG0wPLHYTD//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDm-00044t-Rp
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:10 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDi-003tJl-S2
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 4B1142EE40B
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 9948E2EE3A9;
	Fri, 21 Jun 2024 08:02:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3fad7fca;
	Fri, 21 Jun 2024 08:02:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Martin Jocic <martin.jocic@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 13/24] can: kvaser_pciefd: Skip redundant NULL pointer check in ISR
Date: Fri, 21 Jun 2024 09:48:33 +0200
Message-ID: <20240621080201.305471-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621080201.305471-1-mkl@pengutronix.de>
References: <20240621080201.305471-1-mkl@pengutronix.de>
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

From: Martin Jocic <martin.jocic@kvaser.com>

This check is already done at the creation of the net devices in
kvaser_pciefd_setup_can_ctrls called from kvaser_pciefd_probe.

If it fails, the driver won't load, so there should be no need to
repeat the check inside the ISR. The number of channels is read
from the FPGA and should be trusted.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
Link: https://lore.kernel.org/all/20240614151524.2718287-3-martin.jocic@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index fa205091aafe..4832a93d34de 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1701,12 +1701,6 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 		kvaser_pciefd_receive_irq(pcie);
 
 	for (i = 0; i < pcie->nr_channels; i++) {
-		if (!pcie->can[i]) {
-			dev_err(&pcie->pci->dev,
-				"IRQ mask points to unallocated controller\n");
-			break;
-		}
-
 		/* Check that mask matches channel (i) IRQ mask */
 		if (board_irq & irq_mask->kcan_tx[i])
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
-- 
2.43.0



