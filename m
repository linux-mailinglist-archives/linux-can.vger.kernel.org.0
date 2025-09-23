Return-Path: <linux-can+bounces-4899-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DF3B9534B
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 11:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8DB2A2465
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5FB318151;
	Tue, 23 Sep 2025 09:18:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8C430F55A
	for <linux-can@vger.kernel.org>; Tue, 23 Sep 2025 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619088; cv=none; b=fhkeX4cxCXwhbv4oV2tQgVYrKb372bOm2EaLnAPB8ciSEpalBVcEBWHHRXiX0BW09Pt2C2xZo4kYjSN2AulGxs7Au5svWQaW9iej4GJcYRxt0wcGb36UmSbXdIVAZ069tEsZwcpeCn1G/O6mDR30qUSu/SonGYVRwAhkDn6rP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619088; c=relaxed/simple;
	bh=oTrey5OM5PqjGIujOKl30erSe/rCINsN58cYqGn7/G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UzDhj7NjibAspU8GaFha30AdgGlbU6nwdqyrGdeDCp1k5O3f2W7xhM1Mzs47w5wAERzfVwUxOQ18BsrX38fq/lNIlD2IVREMoR7ElXUW5sZqoXpsmt3hjTp9YfTqB+CXFyP8sHfyM1WR+Zg2J4xSArZPtwwK9jjR1fMnajorhUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z9e-0006Xc-2d; Tue, 23 Sep 2025 11:17:46 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z9c-0004AN-2b;
	Tue, 23 Sep 2025 11:17:44 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6CBA6477C06;
	Tue, 23 Sep 2025 09:17:44 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 23 Sep 2025 11:17:17 +0200
Subject: [PATCH v3 4/6] can: m_can: fix CAN state in system PM
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-m_can-fix-state-handling-v3-4-06d8baccadbf@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1835; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=oTrey5OM5PqjGIujOKl30erSe/rCINsN58cYqGn7/G8=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo0mWyppczgHxQfJZ1HdndgBd/QbxRbXgKwxSce
 FDpy5s1rHWJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaNJlsgAKCRAMdGXf+ZCR
 nP+nB/4sX/ke2zTbR37gXnS82+8m98yd8czGa0q0Xcrsm/n0k1WfIKCbTyYmvDtm+7xMFy9k0qu
 XYdYb0Pz9Gr0a29saUUhwvdj5BD+A19MZk6Y16rZ66YtnP//0Qujw7FqkqyFNOTwKwItgDUwJZS
 hsnTM6Bi+u/oDtiFbAly4chsbNtNhkeytb/HyEi68kUyenyqVqmExt7Lt+4q3IXXWsg2jMJ/lNu
 jYylrsPr3i6axg2DBrD6Rw0x7/WwTEfF+9XM1zs/nSq+1CdJjt+x1WoV+ulKR+NtfXPjm9Jq/BG
 XY6u1gFykOK7+W4K6fH0ox5INmzjhfAyE+ay16EAk7cqpi/P
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

A suspend/resume cycle on a down interface results in the interface
coming up in Error Active state. A suspend/resume cycle on an Up
interface will always result in Error Active state, regardless of the
actual CAN state.

During suspend, only set running interfaces to CAN_STATE_SLEEPING.
During resume only touch the CAN state of running interfaces. For
wakeup sources, set the CAN state depending on the Protocol Status
Regitser (PSR), for non wakeup source interfaces m_can_start() will do
the same.

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9eafd135fcb4..c82ea6043d40 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2505,12 +2505,11 @@ int m_can_class_suspend(struct device *dev)
 		}
 
 		m_can_clk_stop(cdev);
+		cdev->can.state = CAN_STATE_SLEEPING;
 	}
 
 	pinctrl_pm_select_sleep_state(dev);
 
-	cdev->can.state = CAN_STATE_SLEEPING;
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(m_can_class_suspend);
@@ -2523,8 +2522,6 @@ int m_can_class_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
-
 	if (netif_running(ndev)) {
 		ret = m_can_clk_start(cdev);
 		if (ret)
@@ -2542,6 +2539,8 @@ int m_can_class_resume(struct device *dev)
 			if (cdev->ops->init)
 				ret = cdev->ops->init(cdev);
 
+			cdev->can.state = m_can_state_get_by_psr(cdev);
+
 			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
 		} else {
 			ret  = m_can_start(ndev);

-- 
2.51.0


