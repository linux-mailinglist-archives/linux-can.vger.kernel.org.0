Return-Path: <linux-can+bounces-4585-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7A6B504B2
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 19:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A6B7A77F1
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F935CEB6;
	Tue,  9 Sep 2025 17:53:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E583570D5
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440430; cv=none; b=r0mDUDgPf1ES8SxBdDdN4Vjxfvgu6blrz7PNC1dQUoVlbcF1npguXGGIGIw7zoJHQWenaQtcKOwuIcaKeXzNTVDa11CikE1qUvDhR0bFPvXFlLt/I8695tJvZy1Ej9L1Yh+ayACchScFRpWZoUsuG7Hj1fviWtQbp8q1RvS4B30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440430; c=relaxed/simple;
	bh=51tr54JnhZakrnoQo/rT0O+jc3YyZDKaoBKsy55zljc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WhVfBfAVpP3oiwVDZZd9oYKLhg/zXF20CDvvUUq9r/WALvbrUhOlMwuJN2D0SFp4660+f3P1s4hxruQSRVW0VVfRV2VCpeMK1e+lC4t5e2/+RCp2hyOOKgGY2/I2i/c5YGDDYnC2zzxZLa+4ce5vbZfG/l/svhk/g3EpLiV8a/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uw2XI-0006iH-Na
	for linux-can@vger.kernel.org; Tue, 09 Sep 2025 19:53:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uw2XI-000SbP-05
	for linux-can@vger.kernel.org;
	Tue, 09 Sep 2025 19:53:44 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B31FE46A3D1
	for <linux-can@vger.kernel.org>; Tue, 09 Sep 2025 17:53:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 4B5BD46A39D;
	Tue, 09 Sep 2025 17:53:41 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2ce24846;
	Tue, 9 Sep 2025 17:53:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 09 Sep 2025 19:53:19 +0200
Subject: [PATCH v2 3/7] can: m_can: m_can_handle_state_errors(): fix CAN
 state transition to Error Active
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-m_can-fix-state-handling-v2-3-af9fa240b68a@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3774; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=51tr54JnhZakrnoQo/rT0O+jc3YyZDKaoBKsy55zljc=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBowGmbq9JfvnPrkj4xY32meikqqA8cz29Dpo5b3
 NbTPAhd3HiJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaMBpmwAKCRAMdGXf+ZCR
 nIfrB/9Vp+XgN8RRlTxXeO2f0OJSZzTQJITFK/q9XVUEHqnVTUSudtRUhiCfrFSdnJ+tImmLKrz
 toKTBrYpmyAUHGiMAwt65f/CywS4qAL9vDw/D3QddbY4tVAR4ZpjxIuxLo1ECa1S6VGQrU0Y9B0
 u9edz5VUQa9vN3pKU8GO+lihrkZuECJnU4YmylbVtAErLUwcU6CbY8Hfy4igDhtzzSQfG6af5NN
 Tjm1NWI38y+1rEKXB2PmJzFlPpx2P4JZvAayUNSU8jXsoz93Hm7W7w2/81Glrr4KvZjc9ohIBfd
 g7dGpfheJeTChAwL7AhE9zYRDX6TejIDJulA6L1QfAeVnpUu
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
 drivers/net/can/m_can/m_can.c | 55 ++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16b38e6c3985..3edf01b098a4 100644
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



