Return-Path: <linux-can+bounces-1226-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B79F8964EE2
	for <lists+linux-can@lfdr.de>; Thu, 29 Aug 2024 21:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623F01F243B4
	for <lists+linux-can@lfdr.de>; Thu, 29 Aug 2024 19:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC851BA88A;
	Thu, 29 Aug 2024 19:30:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C62E1BA286
	for <linux-can@vger.kernel.org>; Thu, 29 Aug 2024 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959801; cv=none; b=MfQ4QrQGzUryeuAn0BN9wOc0TPZB6LcpvD+B4b6DTnrK1ze8Ryu74ZRdXcQTrC+6xo61Z6bO/s8/sViObRs3jKXD9TFC8xzJQw9ojNBooRmvnAPRHj+miLXsFsP3sJ/XZorvIBCJIotmJw9emgahwR5/OL8FiHfqQ/fk+56wPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959801; c=relaxed/simple;
	bh=IMZ0eD/ZSny3SMyy1OVx/YAci7MJ5yQn0pZ+5ZmZ4Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjrJt+0a2Ev3I8/gDc0fEsIXKnnvqxtLmqkizonnCTsn+H4o4GePOMLelx7zk1HXkwAtD2DTR901hsTePVDaTwFQEGqM2qQjQCEtCuTBjmFBCJVmleAJZjJo2NnoGhLhJu1V/CR0TLxhjXK1C/Yy5xjd297fIedYAi3O3wDVjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjkqD-00067F-O8
	for linux-can@vger.kernel.org; Thu, 29 Aug 2024 21:29:57 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjkqB-003ysO-DD
	for linux-can@vger.kernel.org; Thu, 29 Aug 2024 21:29:55 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 120C732D4CD
	for <linux-can@vger.kernel.org>; Thu, 29 Aug 2024 19:29:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 40D7932D47A;
	Thu, 29 Aug 2024 19:29:52 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 811f5751;
	Thu, 29 Aug 2024 19:29:51 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 08/13] can: m_can: Reset cached active_interrupts on start
Date: Thu, 29 Aug 2024 21:20:41 +0200
Message-ID: <20240829192947.1186760-9-mkl@pengutronix.de>
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

To force writing the enabled interrupts, reset the active_interrupts
cache.

Fixes: 07f25091ca02 ("can: m_can: Implement receive coalescing")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://lore.kernel.org/all/20240805183047.305630-7-msp@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 68bd4a00ecca..67c4c740c416 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1541,6 +1541,7 @@ static int m_can_chip_config(struct net_device *dev)
 		else
 			interrupts &= ~(IR_ERR_LEC_31X);
 	}
+	cdev->active_interrupts = 0;
 	m_can_interrupt_enable(cdev, interrupts);
 
 	/* route all interrupts to INT0 */
-- 
2.45.2



