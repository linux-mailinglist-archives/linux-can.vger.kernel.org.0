Return-Path: <linux-can+bounces-4208-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A82B22F3F
	for <lists+linux-can@lfdr.de>; Tue, 12 Aug 2025 19:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA05E7B6E1A
	for <lists+linux-can@lfdr.de>; Tue, 12 Aug 2025 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0930D2FDC58;
	Tue, 12 Aug 2025 17:37:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06E2FDC32
	for <linux-can@vger.kernel.org>; Tue, 12 Aug 2025 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020245; cv=none; b=I13YGRMDuYNCMB1ndzQ3ZacvG1WnkMirWKCcgMgJLC8atKN1GeIDiSzYrPLISvKmmS3T26Lq720d2b9vrhGwKRABsFkH7wqt6Q+FfvArJC38KPNe7xaYx5jnYvKNlCzQYT8DWeJliyNUbOe7uoM9XKRZyouizcNlvq/t3f3Vc4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020245; c=relaxed/simple;
	bh=TCD8jGdv4Nc/9HzPm+XD/Qj5PPIOwkt4iWL2Yi8+gMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gA++iKfQgdUMKmIOKrpDbwi/RY7l06Ll419cEmMsscB+Wk9FCmB951/tvSCCZY24J5xEY9DL9tciqDWuXY/IdHpqcZFMl1sH0/anShj94frdew08njOtqFcQAABpnzj3arLotmwqa9HhkVeQ/m2mU44N6ahziIfaaOf46b63dxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ulsw5-0008E3-Mk
	for linux-can@vger.kernel.org; Tue, 12 Aug 2025 19:37:21 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ulsw4-00DEaA-1Q
	for linux-can@vger.kernel.org;
	Tue, 12 Aug 2025 19:37:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1F43845623D
	for <linux-can@vger.kernel.org>; Tue, 12 Aug 2025 17:37:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3903D4561F9;
	Tue, 12 Aug 2025 17:37:17 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d7f62ba5;
	Tue, 12 Aug 2025 17:37:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 12 Aug 2025 19:36:53 +0200
Subject: [PATCH 3/7] can: m_can: m_can_handle_state_errors(): fix CAN state
 transition to Error Active
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-m_can-fix-state-handling-v1-3-b739e06c0a3b@pengutronix.de>
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
In-Reply-To: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Patrik Flykt <patrik.flykt@linux.intel.com>, 
 Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
 Varka Bhadram <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=3308; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=TCD8jGdv4Nc/9HzPm+XD/Qj5PPIOwkt4iWL2Yi8+gMY=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBom3vCLOJL1Q+1fbX9qPxVmTwz+3kT5uTwqXss9
 MJ+MkcfIrCJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaJt7wgAKCRAMdGXf+ZCR
 nFVdCAC3XUXdHgHMvVncs6lpmFjy+bpx4y73RuKMBMaXfWDpo9ruWiZ6GGfXwocAIsCD4Zq5Ei6
 bRdSmpNniJ2Y0thZpgtj1n1lNGAnXWx5YbOEn6VnUK9NGoDpWBo61Rq2QEBnNbFnVGw0YpRbC6w
 Y9KBXgrcxLKLR8UnjF7VAiiihwSbyE7nsKOsX4XmoYAR4TUWyM2EjZ4zBcJuEEnF6eEC6wpPHzr
 4xEtiYIxnMvijiMFkMax8wWc12iSBAkYuJaaoqpqqZqp4b8c2se0MsPUoMYgaXaIfU7Et1/5VBQ
 qwMFXbEgWHghtMvbr1A7c/L5bORdUTs8zbPFkJJzH92P8qxp
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
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
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 48 ++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a51dc0bb8124..b485d2f3d971 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -812,6 +812,10 @@ static int m_can_handle_state_change(struct net_device *dev,
 	u32 timestamp = 0;
 
 	switch (new_state) {
+	case CAN_STATE_ERROR_ACTIVE:
+		/* error active state */
+		cdev->can.state = CAN_STATE_ERROR_ACTIVE;
+		break;
 	case CAN_STATE_ERROR_WARNING:
 		/* error warning state */
 		cdev->can.can_stats.error_warning++;
@@ -841,6 +845,13 @@ static int m_can_handle_state_change(struct net_device *dev,
 	__m_can_get_berr_counter(dev, &bec);
 
 	switch (new_state) {
+	case CAN_STATE_ERROR_ACTIVE:
+		/* error active state */
+		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
+		cf->data[1] = CAN_ERR_CRTL_ACTIVE;
+		cf->data[6] = bec.txerr;
+		cf->data[7] = bec.rxerr;
+		break;
 	case CAN_STATE_ERROR_WARNING:
 		/* error warning state */
 		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
@@ -877,30 +888,29 @@ static int m_can_handle_state_change(struct net_device *dev,
 	return 1;
 }
 
+static enum can_state
+m_can_can_state_get_by_psr(const u32 psr)
+{
+	if (psr & PSR_BO)
+		return CAN_STATE_BUS_OFF;
+	if (psr & PSR_EP)
+		return CAN_STATE_ERROR_PASSIVE;
+	if (psr & PSR_EW)
+		return CAN_STATE_ERROR_WARNING;
+
+	return CAN_STATE_ERROR_ACTIVE;
+}
+
 static int m_can_handle_state_errors(struct net_device *dev, u32 psr)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
-	int work_done = 0;
+	enum can_state new_state;
 
-	if (psr & PSR_EW && cdev->can.state != CAN_STATE_ERROR_WARNING) {
-		netdev_dbg(dev, "entered error warning state\n");
-		work_done += m_can_handle_state_change(dev,
-						       CAN_STATE_ERROR_WARNING);
-	}
+	new_state = m_can_can_state_get_by_psr(psr);
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

-- 
2.50.1



