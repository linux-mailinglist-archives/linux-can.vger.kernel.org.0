Return-Path: <linux-can+bounces-4903-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFE5B9535D
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 11:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96F419004D3
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B29F258CF9;
	Tue, 23 Sep 2025 09:18:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC12745E
	for <linux-can@vger.kernel.org>; Tue, 23 Sep 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619119; cv=none; b=NJqnBCZPh33165djmfe80z6bw1WI1p9GX0zLyLlFz3a2uSv++Blyo8H+lBCjQTnQ6wQJWUOPKC1ex8Ac3ArR8m91aONdmJmKfoeaQgNKkWQi+evY+UH5bphS4+OO21HKoI5sxZ9N/EUWwoOSFk0EYCQMbNXbPje4Gp7Q8tmQrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619119; c=relaxed/simple;
	bh=q6vViRSlfIttEHpbJ08wgxm1w4flYky5nmoyGpoOhAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KhV4+7qQ4wkxEgML7GIkD5W3jEBzaCSXbNSjhCs1pqFo3Rn+rBsythNQJn1LslQHieTxjV15Twzb/z7mzSOvnqGoZMjPq44mwZyBG2zdfISwYcTD+JtOEFYVvWvhSgw6QXqproVIbFZ+FcO9ZMImP70u2cypPxMIyKX6C8GefWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z9e-0006XY-2d; Tue, 23 Sep 2025 11:17:46 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z9c-0004AH-1q;
	Tue, 23 Sep 2025 11:17:44 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 37910477C03;
	Tue, 23 Sep 2025 09:17:44 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 23 Sep 2025 11:17:14 +0200
Subject: [PATCH v3 1/6] can: m_can: m_can_plat_remove(): add missing
 pm_runtime_disable()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-m_can-fix-state-handling-v3-1-06d8baccadbf@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=q6vViRSlfIttEHpbJ08wgxm1w4flYky5nmoyGpoOhAU=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo0mWsMnOweCE9ScR3z9LWmW1AxxNxs+39OSBqc
 fl3O733+E6JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaNJlrAAKCRAMdGXf+ZCR
 nGSTCACTTjrIJp5HBeubVzq1dRU/yUGV/hlWOBJ3P3PsOXLC3V7EoDyeFIeGR/Pj3AdcvruaDwF
 2JXMLRE71srWOLS3zidm9Tkry/zu+YZ4RzbGZmgo6otVmRqaivg26MhOYd1GyNeQeEjOBB/Ze1U
 SCIMETmr1t5qdU0zXK+Awtf+zdLzGlUHxARYIuRQZusP3o5R2kuYXkBhJwvVCSbuOrPvgLn8sCP
 I7UEkpE1Eo/IdfMVr6SqMHcfEXJCYRVxjViuBJdQRxB81g12u/jR9pCUrtbo/qJxHy3dLmS24Fw
 a4G7n+hTxa41XfcWwgdCLzM6GISFSCX6kQhJxicEcV4Ye0u2
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Commit 227619c3ff7c ("can: m_can: move runtime PM enable/disable to
m_can_platform") moved the PM runtime enable from the m_can core
driver into the m_can_platform.

That patch forgot to move the pm_runtime_disable() to
m_can_plat_remove(), so that unloading the m_can_platform driver
causes an "Unbalanced pm_runtime_enable!" error message.

Add the missing pm_runtime_disable() to m_can_plat_remove() to fix the
problem.

Cc: Patrik Flykt <patrik.flykt@linux.intel.com>
Fixes: 227619c3ff7c ("can: m_can: move runtime PM enable/disable to m_can_platform")
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index b832566efda0..057eaa7b8b4b 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -180,7 +180,7 @@ static void m_can_plat_remove(struct platform_device *pdev)
 	struct m_can_classdev *mcan_class = &priv->cdev;
 
 	m_can_class_unregister(mcan_class);
-
+	pm_runtime_disable(mcan_class->dev);
 	m_can_class_free_dev(mcan_class->net);
 }
 

-- 
2.51.0


