Return-Path: <linux-can+bounces-5184-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 339FABD9ED0
	for <lists+linux-can@lfdr.de>; Tue, 14 Oct 2025 16:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 785684FB98D
	for <lists+linux-can@lfdr.de>; Tue, 14 Oct 2025 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF4F314D27;
	Tue, 14 Oct 2025 14:10:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A905F314D0F
	for <linux-can@vger.kernel.org>; Tue, 14 Oct 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451031; cv=none; b=Am4ydoXW9X+TUTvrML68ZGfeGqqPgqWpjtHDjv32fb9PLPvIFXBjKKXQ229NXerlc/lzXSsxyUNgY/LSKZo14L5ixX4/RgW5pu6IQT0itPnZ/oiTqOQ6y9LJk0IzEIRHh1QxPJiheZrCnrGoO9p7qACbO1HWNXimAO8hjlzUOqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451031; c=relaxed/simple;
	bh=zNnqGsVKEETVH0mxQ3v4VP2B3kjSL2MM/XttwazR1Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0iLkRb0B6O6PJ+gXCVBya+JTye3qwlEilkzS8aH9XKoIdLtUmZ/N6bRLJY7qPCgjBNhtu+40iENozQittz/3OFsa09q+kcIox+A1EBHjOHTZPLot6tpWB10s4EZj0Jkh3RdXw6WROz2GPye5sSkIBQyMUx05Dh3376uWS+BN5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8fjK-0008II-TY; Tue, 14 Oct 2025 16:10:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8fjK-003ZPw-17;
	Tue, 14 Oct 2025 16:10:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0579E485F18;
	Tue, 14 Oct 2025 14:10:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH net 04/10] can: m_can: m_can_handle_state_errors(): fix CAN state transition to Error Active
Date: Tue, 14 Oct 2025 14:17:51 +0200
Message-ID: <20251014122140.990472-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122140.990472-1-mkl@pengutronix.de>
References: <20251014122140.990472-1-mkl@pengutronix.de>
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

The CAN Error State is determined by the receive and transmit error
counters. The CAN error counters decrease when reception/transmission
is successful, so that a status transition back to the Error Active
status is possible. This transition is not handled by
m_can_handle_state_errors().

Add the missing detection of the Error Active state to
m_can_handle_state_errors() and extend the handling of this state in
m_can_handle_state_change().

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Fixes: cd0d83eab2e0 ("can: m_can: m_can_handle_state_change(): fix state change")
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://patch.msgid.link/20250929-m_can-fix-state-handling-v4-2-682b49b49d9a@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 55 +++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e1d725979685..ac864183a536 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -812,6 +812,9 @@ static int m_can_handle_state_change(struct net_device *dev,
 	u32 timestamp = 0;
 
 	switch (new_state) {
+	case CAN_STATE_ERROR_ACTIVE:
+		cdev->can.state = CAN_STATE_ERROR_ACTIVE;
+		break;
 	case CAN_STATE_ERROR_WARNING:
 		/* error warning state */
 		cdev->can.can_stats.error_warning++;
@@ -841,6 +844,12 @@ static int m_can_handle_state_change(struct net_device *dev,
 	__m_can_get_berr_counter(dev, &bec);
 
 	switch (new_state) {
+	case CAN_STATE_ERROR_ACTIVE:
+		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
+		cf->data[1] = CAN_ERR_CRTL_ACTIVE;
+		cf->data[6] = bec.txerr;
+		cf->data[7] = bec.rxerr;
+		break;
 	case CAN_STATE_ERROR_WARNING:
 		/* error warning state */
 		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
@@ -877,30 +886,33 @@ static int m_can_handle_state_change(struct net_device *dev,
 	return 1;
 }
 
-static int m_can_handle_state_errors(struct net_device *dev, u32 psr)
+static enum can_state
+m_can_state_get_by_psr(struct m_can_classdev *cdev)
+{
+	u32 reg_psr;
+
+	reg_psr = m_can_read(cdev, M_CAN_PSR);
+
+	if (reg_psr & PSR_BO)
+		return CAN_STATE_BUS_OFF;
+	if (reg_psr & PSR_EP)
+		return CAN_STATE_ERROR_PASSIVE;
+	if (reg_psr & PSR_EW)
+		return CAN_STATE_ERROR_WARNING;
+
+	return CAN_STATE_ERROR_ACTIVE;
+}
+
+static int m_can_handle_state_errors(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
-	int work_done = 0;
+	enum can_state new_state;
 
-	if (psr & PSR_EW && cdev->can.state != CAN_STATE_ERROR_WARNING) {
-		netdev_dbg(dev, "entered error warning state\n");
-		work_done += m_can_handle_state_change(dev,
-						       CAN_STATE_ERROR_WARNING);
-	}
+	new_state = m_can_state_get_by_psr(cdev);
+	if (new_state == cdev->can.state)
+		return 0;
 
-	if (psr & PSR_EP && cdev->can.state != CAN_STATE_ERROR_PASSIVE) {
-		netdev_dbg(dev, "entered error passive state\n");
-		work_done += m_can_handle_state_change(dev,
-						       CAN_STATE_ERROR_PASSIVE);
-	}
-
-	if (psr & PSR_BO && cdev->can.state != CAN_STATE_BUS_OFF) {
-		netdev_dbg(dev, "entered error bus off state\n");
-		work_done += m_can_handle_state_change(dev,
-						       CAN_STATE_BUS_OFF);
-	}
-
-	return work_done;
+	return m_can_handle_state_change(dev, new_state);
 }
 
 static void m_can_handle_other_err(struct net_device *dev, u32 irqstatus)
@@ -1031,8 +1043,7 @@ static int m_can_rx_handler(struct net_device *dev, int quota, u32 irqstatus)
 	}
 
 	if (irqstatus & IR_ERR_STATE)
-		work_done += m_can_handle_state_errors(dev,
-						       m_can_read(cdev, M_CAN_PSR));
+		work_done += m_can_handle_state_errors(dev);
 
 	if (irqstatus & IR_ERR_BUS_30X)
 		work_done += m_can_handle_bus_errors(dev, irqstatus,
-- 
2.51.0


