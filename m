Return-Path: <linux-can+bounces-5052-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B91BA86EE
	for <lists+linux-can@lfdr.de>; Mon, 29 Sep 2025 10:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0F0174F4F
	for <lists+linux-can@lfdr.de>; Mon, 29 Sep 2025 08:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8392765ED;
	Mon, 29 Sep 2025 08:41:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C531276028
	for <linux-can@vger.kernel.org>; Mon, 29 Sep 2025 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135269; cv=none; b=KECcOe9v+MUhaRTjp6opr2aSC6mr/bXNhvwoDtHniJmb9sOIiU5aAHOIlMLJHwMBEKJRkG/FFkiKsiLf6G1GCeZGUoioFGI+wxrrtrkP+0oBMseaJBc7WQ+oy1uiEEnSczWtSn9zmaEcaIdiT83RjRY/7pVfrDfuKiDsUJwPBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135269; c=relaxed/simple;
	bh=q6vViRSlfIttEHpbJ08wgxm1w4flYky5nmoyGpoOhAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JadJDnGllKBTTrRxrRz9UpB2oT/UYmJ+V3eJTPAux8/6Q58N9lZCsoTu1bLq64dlG/Rb4WrzuUU/LRO4WZPss9IGnsAhmnEnzSIYdf3ZI+QqfEfGWOeLP33CsOPoMvi0ZeGSHBpn+laxF708FCBwYKgQ14mLu3WZcP2aYwoDR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v39R0-0001cv-7U; Mon, 29 Sep 2025 10:40:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v39Qy-0012zK-2B;
	Mon, 29 Sep 2025 10:40:36 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4B17047C3A7;
	Mon, 29 Sep 2025 08:40:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 29 Sep 2025 10:40:13 +0200
Subject: [PATCH v4 1/4] can: m_can: m_can_plat_remove(): add missing
 pm_runtime_disable()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-m_can-fix-state-handling-v4-1-682b49b49d9a@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=q6vViRSlfIttEHpbJ08wgxm1w4flYky5nmoyGpoOhAU=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo2kX85EfbJDTHU2P/N1tRuFYmhTRUEMRsNnRn3
 Jfrxnkb/LCJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaNpF/AAKCRAMdGXf+ZCR
 nN++CACAPtkYiDnV6qq9lhWNHHjniDCxGy5o5FiuWuHF8B6mnARUUknI9g55DwDKSkeazsVV0qr
 VR/H8pyUAmZ1LKcArqKWJgvkvJeGpSuAaSgYHXlvbghDC9KZftsRflX/swj0DctuzJozAhqS+vh
 KaAo/3K3OZswB1M5tjV518UGdJbRCUTWY+tEG9YHRAg2I9Vz/SPkvVXtUceByf1u2DFBbAWuRWW
 GRQw70eXgoLP7M47vySr50H4C3NxOHoUBCN/FQNHyvv1jXI298ujWdqDz2u4kXI1jx8VpADObFG
 VyQFvPse66Mo9SqSxfKiwE05tVUt4TxxynQDLOlPqh/FPS/J
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


