Return-Path: <linux-can+bounces-4586-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A68B504B4
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 19:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFCF1C251DD
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 17:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9A335E4D2;
	Tue,  9 Sep 2025 17:53:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0C35AAB5
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440430; cv=none; b=oGEIpFoN7ymPxeKTahz+oVLlhCjnaKpo4gGSGkM2r8h9aDBNWU7hrZrM5LmittY8qIkkbTAzYZeb8yVhjwjaqjPi5LqwSuUhgSsX8oYQ65Cp+3azy0z3urgTEYD9oGPZ33hUr7+5LtkQUDCfZkuzHqTTmBEac25g6Vb/D8jRHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440430; c=relaxed/simple;
	bh=ntfi2QKEOJsC2qe0j2SXYrKvCvXrdcla5ZixxYLHtCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TqDk03ZMoAeMOGNtg5iMBipob9G/6tmTD/rpkWd6pdjMSkDDlOcCZ94CTOoVLacQcYTiIaGzbZblRKV4kcUhOIFD+aFNj8RqZGlaZ/6tHnvKJvutGYeF6hm+HljvyCUw3W7gbSCHyhBbOFq4QhfDL7UsH4L32THybOL6nMGf1Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uw2XI-0006ii-N7
	for linux-can@vger.kernel.org; Tue, 09 Sep 2025 19:53:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uw2XI-000Sbe-0d
	for linux-can@vger.kernel.org;
	Tue, 09 Sep 2025 19:53:44 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D822646A3D4
	for <linux-can@vger.kernel.org>; Tue, 09 Sep 2025 17:53:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 6458046A39F;
	Tue, 09 Sep 2025 17:53:41 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 47a02140;
	Tue, 9 Sep 2025 17:53:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 09 Sep 2025 19:53:20 +0200
Subject: [PATCH v2 4/7] can: m_can: m_can_chip_config(): bring up interface
 in correct state
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-m_can-fix-state-handling-v2-4-af9fa240b68a@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ntfi2QKEOJsC2qe0j2SXYrKvCvXrdcla5ZixxYLHtCk=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBowGmcRC89fQtXDrlgDRCgx8MSXcF2dzuS/ApuJ
 n3MjrRjuJ+JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaMBpnAAKCRAMdGXf+ZCR
 nLVDCACHgC4i1jr4+NNrxU8F7d+zc7GIEsRhw6AFWOGCUzKwFccE+svVKNG/kYNzXYNmN2JHnoX
 J3e19JeXfGIzDwnPRmKy/fb1MXJfS/JYCMW+CZ6VAVFPIsFzIdAfaY2wifyS9o57Xtza41JRXTP
 HIZ5SBtGziDAk2DuVwP1Dpw5GQgOESbb5QwYsGgXwYhb2j4UK6MY9QPf8tkDeXoeO0Y41pR6gnA
 kniqw68XZmJwzbFF3ISTMAR/sJvtjZiz5j0x39kNHd5ErAnMg8vLr3ix5+jjtQSGsowguuAZkHl
 jHukizB0A0RGWie7Juwf6Vcp1KVKZiHpH4Tmaze9UejhF/cr
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
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 3edf01b098a4..efd9c23edd4a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1620,7 +1620,7 @@ static int m_can_start(struct net_device *dev)
 	netdev_queue_set_dql_min_limit(netdev_get_tx_queue(cdev->net, 0),
 				       cdev->tx_max_coalesced_frames);
 
-	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
+	cdev->can.state = m_can_state_get_by_psr(cdev);
 
 	m_can_enable_all_interrupts(cdev);
 

-- 
2.51.0



