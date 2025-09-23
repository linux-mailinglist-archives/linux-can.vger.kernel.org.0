Return-Path: <linux-can+bounces-4897-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A81B95348
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 11:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3505C19012A8
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE982F39B9;
	Tue, 23 Sep 2025 09:18:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B690A30F959
	for <linux-can@vger.kernel.org>; Tue, 23 Sep 2025 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619084; cv=none; b=gof0+4ysc6cYzeW0THY1dB5KyIQavCcRGsxBA0xec213pznEIm6v3U8UGLPSMLtUT2zgbep1KPIPYDWCAOppq2JjxLdUQxUaOJCNYd9+0Znn0sSIfsqaZtYTGYhZ6Cq5bt3DhcR87Qnmebaqa3cC2r+EUa2PvIkFOfUwbkIEYIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619084; c=relaxed/simple;
	bh=/HNzMsstKctC8PB7quDVBrjlyGwlmAE7o10zajY1uBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DpwT76CpGvJfig5KX6JgpKx4ru7ckhluSH8vwBl+MF/e5Zw2lkZWNJL30GJ4wQQ108MpNkHRVOu+gHcMeJGaCPUQoBMAxLPoZwyZoF0yVgT7okTVc7snq+xJkFAH2hXqvm8+mUsK8kcBrFEv4ookUop2qlKq3rbw4MmrR2b35sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z9e-0006Xb-2d; Tue, 23 Sep 2025 11:17:46 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z9c-0004AP-2e;
	Tue, 23 Sep 2025 11:17:44 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7DC3E477C07;
	Tue, 23 Sep 2025 09:17:44 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 23 Sep 2025 11:17:18 +0200
Subject: [PATCH v3 5/6] can: m_can: m_can_get_berr_counter(): don't wake up
 controller if interface is down
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-m_can-fix-state-handling-v3-5-06d8baccadbf@pengutronix.de>
References: <20250923-m_can-fix-state-handling-v3-0-06d8baccadbf@pengutronix.de>
In-Reply-To: <20250923-m_can-fix-state-handling-v3-0-06d8baccadbf@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Patrik Flykt <patrik.flykt@linux.intel.com>, 
 Dong Aisheng <b29396@freescale.com>, Varka Bhadram <varkabhadram@gmail.com>, 
 Wu Bo <wubo.oduw@gmail.com>, Markus Schneider-Pargmann <msp@baylibre.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=892; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=/HNzMsstKctC8PB7quDVBrjlyGwlmAE7o10zajY1uBc=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo0mW0Gx+8yDyXRsre2uTwIuFV1HyaNU3hCibGu
 YzD7uRHhYiJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaNJltAAKCRAMdGXf+ZCR
 nDpOCACNx8p0eOZ/ZSGx6y09aqc6fPLNu3NASN1rngk+vgqGILeE8vCTmASoB/p0/4Ql8tsar/j
 a4iALcQtSJiE0Y2EjMpu0FhF6dkOD/XjxvwAaarBwTrGX1x9RsIO0SbjJlBO3Wy05E9PjxC1HNm
 sj9/OsaFZIrT1sZLT3HOJQfIRHvbExhSxKQTkMDUNkn5xkG2moeH18Cb/dsLaCj8N3uQX1rSXJt
 86aAJzbFPPanoypvshetgMXHB0cNAtN2paQay1WH0QZ1z9jgj1+S8pwy6KOLgM/aSnHllvNsWpd
 Sm5b8XFkJmwRIQMSTTZQnNIkd0RsO0CsqOw7it8wP+NQsV8Q
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
index c82ea6043d40..afbab6ca5833 100644
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


