Return-Path: <linux-can+bounces-5050-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8263EBA86E5
	for <lists+linux-can@lfdr.de>; Mon, 29 Sep 2025 10:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC73C189902E
	for <lists+linux-can@lfdr.de>; Mon, 29 Sep 2025 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF39279355;
	Mon, 29 Sep 2025 08:41:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FCB27932B
	for <linux-can@vger.kernel.org>; Mon, 29 Sep 2025 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135266; cv=none; b=t9mDfznQRaudjgD8jxhLEoviDXJD2AkksrUvbG3H/uIfze1IlByykSmlOWYLSlCCGpNTfRc8csXa34uOesf+VL6dNAxGxZGrFtBWru7khSDG4QZIrFzyBPrAK+i6QQXBKaa9V+mQRIrlAhTYf47K13DkewK6eP9UbhSGM1Wvh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135266; c=relaxed/simple;
	bh=JuZ2sQVZ5U0NcbyILvYjnvWJalOP1B3psMOrSEjvwA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HMM3A6W5V0ECJ7pXS6wOV6WIJBCo4LUWlfVyQfwgErEaVVNYoWayIHFsFXcYT5Y3wB82z269B/8WMyUp7awwjgF0YpOvjqDXZKL2pJ7V8S47QInwumaWh1jyxe2SQRH3vyk1E0k6YtCxMkFugmIw8aJfAzK4+iztPfEbueepbq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v39R0-0001cx-7U; Mon, 29 Sep 2025 10:40:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v39Qy-0012zO-2j;
	Mon, 29 Sep 2025 10:40:36 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6B4E847C3A9;
	Mon, 29 Sep 2025 08:40:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 29 Sep 2025 10:40:15 +0200
Subject: [PATCH v4 3/4] can: m_can: m_can_chip_config(): bring up interface
 in correct state
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-m_can-fix-state-handling-v4-3-682b49b49d9a@pengutronix.de>
References: <20250929-m_can-fix-state-handling-v4-0-682b49b49d9a@pengutronix.de>
In-Reply-To: <20250929-m_can-fix-state-handling-v4-0-682b49b49d9a@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Patrik Flykt <patrik.flykt@linux.intel.com>, 
 Dong Aisheng <b29396@freescale.com>, Varka Bhadram <varkabhadram@gmail.com>, 
 Wu Bo <wubo.oduw@gmail.com>, Markus Schneider-Pargmann <msp@baylibre.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=JuZ2sQVZ5U0NcbyILvYjnvWJalOP1B3psMOrSEjvwA8=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo2kYAC4egeAycRrzEhqV9TG5NUuiRpuaQI9uBd
 KIhTTZ7mCiJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaNpGAAAKCRAMdGXf+ZCR
 nBzkCACIOEy0uPyu685MrGK69aWxu2HlJwTOWoaHunUym66wx/iHQNL8PDZ6baDDE2V7xs5esAD
 4JTYtTA7uQCTM8RkzS+kqi5h20o397JJrwAnuld/4WciR5RBF0L1DuuILNjJkuw3BojL+bbdjvs
 BAYQlZuE+5pJRSKBx/9LNT+e0uOxpgjW/tCVDOWk5iT92GdpMTmzNIhREF/81goVfEuUD9HQ8bS
 Y6md4k506KBztnY4zYa+1uu4t4y3yyC/pvcPCzofXKA6BlO3GRc6f1ppQHF4KsSlMtbue5S91Qm
 Gh6jES51g7A0PAp7m1bVrP/GAwXCSiWKR1czvBxi6e5NYCx1
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

In some SoCs (observed on the STM32MP15) the M_CAN IP core keeps the
CAN state and CAN error counters over an internal reset cycle. An
external reset is not always possible, due to the shared reset with
the other CAN core. This caused the core not always be in Error Active
state when bringing up the controller.

Instead of always setting the CAN state to Error Active in
m_can_chip_config(), fix this by reading and decoding the Protocol
Status Regitser (PSR) and set the CAN state accordingly.

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 4826b8dcad0f..9eafd135fcb4 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1617,7 +1617,7 @@ static int m_can_start(struct net_device *dev)
 	netdev_queue_set_dql_min_limit(netdev_get_tx_queue(cdev->net, 0),
 				       cdev->tx_max_coalesced_frames);
 
-	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
+	cdev->can.state = m_can_state_get_by_psr(cdev);
 
 	m_can_enable_all_interrupts(cdev);
 

-- 
2.51.0


