Return-Path: <linux-can+bounces-4589-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE998B504BB
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 19:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9857636858C
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 17:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333CB36209C;
	Tue,  9 Sep 2025 17:53:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8659935CEC1
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440432; cv=none; b=D8LVgTxCbWT4k9581mHBKyJ2l2lr9OPgd54Yc3E+66WxbBLBHC8sD66xZBcDnHmlsy9nD2kVuekAtKaPi45/rzCX69zyUkYlo0hR7+/UITrCYYtlIAbMGgLDnxmVAC6tatQCqxCN+dt1E2J+NPvrpsdYdEi24SN4OEcU5BqhbOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440432; c=relaxed/simple;
	bh=ko64cZOLzYITscm15DfY3Ixy65JrBPp9GIDXs4/Gvns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hK+4EwOzClA7ZTkJjBXXKDtV9wy/EF/La6kElpgHniRpvzm1MEaQ5ICUlCnf77LVdTkosOHyFVLJPaHw5Y9bOm9DqUw2pgVG07R4aKOg4oSy6wA/kGq+XQQfP1BO3AVAvsTB4Y6ZvwO4nqdu0sg+oBrbRGCcZPgzV9LA4rB57qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uw2XL-0006rW-Ty
	for linux-can@vger.kernel.org; Tue, 09 Sep 2025 19:53:47 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uw2XK-000Se9-2k
	for linux-can@vger.kernel.org;
	Tue, 09 Sep 2025 19:53:46 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 834DA46A3FA
	for <linux-can@vger.kernel.org>; Tue, 09 Sep 2025 17:53:46 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 99A0146A3A5;
	Tue, 09 Sep 2025 17:53:41 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id dc66c1a5;
	Tue, 9 Sep 2025 17:53:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 09 Sep 2025 19:53:22 +0200
Subject: [PATCH v2 6/7] can: m_can: m_can_get_berr_counter(): don't wake up
 controller if interface is down
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-m_can-fix-state-handling-v2-6-af9fa240b68a@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=892; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ko64cZOLzYITscm15DfY3Ixy65JrBPp9GIDXs4/Gvns=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBowGmg/eQnGKIR7XS+zOvvbAM9ewU01ERbDaJvm
 GAKPTqj2KaJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaMBpoAAKCRAMdGXf+ZCR
 nJWaCACoJVbnMAqYbEb2rre1Jkg9jtkal9sPN1FbF3Xk1lKCwsgbsXUJ4RHRpswAJhoZPyN5rct
 2Xjv/F1jLv1WPoXiy7czmK3zWqBv2B1a8Am0ddSX2FKBSlbFwslO9cQoe6MwTduxFw8f6qapyb8
 rOO77psS88wv33XlCYqVsd5+TlAN0/aHx/l8KeUyw3tGse+jAd0TpmmK4d5sIubDemNLa5c82g3
 Yyc3pn78R26kVEfuxcY8bYPA5/ebGdI2jCCdE6fHibEvP/R3V+hDd/PL2N1vKWpurey7eikuOKH
 9JFgxHWJUrHSVdLEeh0uL3FGoe+hMMhTlWqxU9fTPJabtUNy
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

If the interface is down, the CAN controller might be powered down,
the clock disabled, and/or it's external reset asserted.

Don't wake up the controller to read the CAN bus error counters, if
the interface is down.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index d44e348f2417..9528af8500af 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -790,6 +790,10 @@ static int m_can_get_berr_counter(const struct net_device *dev,
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	int err;
 
+	/* Avoid waking up the controller if the interface is down */
+	if (!(dev->flags & IFF_UP))
+		return 0;
+
 	err = m_can_clk_start(cdev);
 	if (err)
 		return err;

-- 
2.51.0



