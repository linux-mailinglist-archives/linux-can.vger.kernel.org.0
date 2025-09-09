Return-Path: <linux-can+bounces-4587-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419AEB504B5
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 19:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB367A76CA
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 17:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B728435E4E8;
	Tue,  9 Sep 2025 17:53:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF035A280
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440430; cv=none; b=j7t/4l9lMZlcXEp5wbC2boWfyg8+xUJcmBtTv4R+bnxPWbmtZ2rEvjnO9jro26dgDQ2BO1KyaxiiyzGBpIkk+PdaRxIPxBIzHbwYM4sZn9itfWPIk3afSLpyNtPxyGEDTPOr2sIXJ4katiQJlddWMl0b9sLzYtzUR1mxN9BvDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440430; c=relaxed/simple;
	bh=q6vViRSlfIttEHpbJ08wgxm1w4flYky5nmoyGpoOhAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PBaIf0/d7emabYI9nsevK6/oKJlTHBfJI094iFERKEjQXG7dNc8KtuUII0WU0e/5GUbyj2G7dOL55oOsRPyodvizlysTAciRG8G2TebIdZujIXxsZ1GYkyqk5hQduujzrR46AETAvmyr2pegDQyYsHqhBa2+JHdqp6CVageJEsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uw2XI-0006hx-Hh
	for linux-can@vger.kernel.org; Tue, 09 Sep 2025 19:53:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uw2XH-000SbE-2t
	for linux-can@vger.kernel.org;
	Tue, 09 Sep 2025 19:53:43 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8B1AD46A3CE
	for <linux-can@vger.kernel.org>; Tue, 09 Sep 2025 17:53:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 1144046A39A;
	Tue, 09 Sep 2025 17:53:41 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0f4e6dba;
	Tue, 9 Sep 2025 17:53:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 09 Sep 2025 19:53:17 +0200
Subject: [PATCH v2 1/7] can: m_can: m_can_plat_remove(): add missing
 pm_runtime_disable()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-m_can-fix-state-handling-v2-1-af9fa240b68a@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=q6vViRSlfIttEHpbJ08wgxm1w4flYky5nmoyGpoOhAU=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBowGmXDvcNXC5qdFf2OlBFiXUB6oTAT0G/nwHcY
 LC9iKDIldGJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaMBplwAKCRAMdGXf+ZCR
 nPTdCACnG1IjsFiQIdV0zdCDbNWqUqySz9MNyLUlkMpVuO2Lti6uJtK3VKxTvAQ0oTLowh5whfk
 n41Yh6l93wWe/br5f/WJfwf/aTWeBZijF8Rqpjiu69tV65bK/GmMVNmxHPGw2MZFeqIX1kQapFP
 Iq+ABKs9U8edQnxn+BG5JoadSKacu6q/p/J03j/c4BHTKYrPJTQVqZwHpUhcELyCRaFNbA43QnU
 gKFVOuMJmCyzbN396jZSPkyQu6oeU6a8voyoLOlh1xYqT7zzpyry15/8tsr0S6X0q1/lAIr5w3c
 H0TJ7BPNp4iAbl5fmFFNXfUK5+Mr2BvNiRc0YxO2DgcVuX9i
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



