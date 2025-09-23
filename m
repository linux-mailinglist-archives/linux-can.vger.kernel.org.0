Return-Path: <linux-can+bounces-4898-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80241B95351
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 11:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5025F4831AF
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6044A30FF36;
	Tue, 23 Sep 2025 09:18:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA83D309EEE
	for <linux-can@vger.kernel.org>; Tue, 23 Sep 2025 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619088; cv=none; b=BrUepXtspus41Iokz1EjG999LaDfO0n9wjPW2l6EJLDNBFST5iGNTyHBWFXiHPD39NOsxlssViOSucuIUWj8NszpXwN27pYZRU00FZTVwJTEOw1Bg23n2nH6ymhGmZPfuiy8fAoQpoOZFvc1yzh0rNQosVJ1pH/RSY2/gkAFNeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619088; c=relaxed/simple;
	bh=pv9kYrbhw+CDKK8+ROa6YTWkAs77R5ppbR36x4idA1w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bDrqbMVrIffly8gJLZSRZ+WBWj4ln++MHjClYRb+D+4Yw+X+u9Kf70wYUjZPcNX5k+z0VfgvyK4Nugn3bbp6RFDuhMIOJaD95zckJtEshC/vAdgm47VmB9OfwUzRaj0XQFv2CYf6N0jP1Z+L+M3FFgbdzxAxuXZp4bCkFQXCLHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z9e-0006XX-2d; Tue, 23 Sep 2025 11:17:46 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0z9c-0004AG-1c;
	Tue, 23 Sep 2025 11:17:44 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 204D8477C02;
	Tue, 23 Sep 2025 09:17:44 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 0/6] can: m_can: fix pm_runtime and CAN state handling
Date: Tue, 23 Sep 2025 11:17:13 +0200
Message-Id: <20250923-m_can-fix-state-handling-v3-0-06d8baccadbf@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJpl0mgC/33N0QrCIBQG4FcJrzPUrTW76j0i4qhnm1BuqMli7
 N1zg+gi6vI//P93JhLQWwzkuJmIx2SD7V0OxXZDdAeuRWpNzkQwsWc15/R+1eBoY0caIkSkuWR
 u1rWUKSiVgUqrGkmeDx5za6XPl5w7G2Lvn+unxJfrGxW/0cQpo+pQSGSVZlCo04CufUTfOzvuD
 JJFTuKjSSb/aCJr0MgGRMlUVcOXNs/zC633OXgTAQAA
X-Change-ID: 20250811-m_can-fix-state-handling-0ba4bda6cb8e
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Patrik Flykt <patrik.flykt@linux.intel.com>, 
 Dong Aisheng <b29396@freescale.com>, Varka Bhadram <varkabhadram@gmail.com>, 
 Wu Bo <wubo.oduw@gmail.com>, Markus Schneider-Pargmann <msp@baylibre.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=2535; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=pv9kYrbhw+CDKK8+ROa6YTWkAs77R5ppbR36x4idA1w=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo0mWhULxaNxGfm6TZH2N8j7RbtxPuCoE+lYs3h
 1WIke49p+yJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaNJloQAKCRAMdGXf+ZCR
 nLsqCACCJQiVHxDCrcmL7fgIBphF6AaW+wuAIpYdnGVkYF65gseSY6D5wmfEegAPmPhMUsWP0rJ
 61ruXhP/MXSBKcgDFEFp+5NmEjm+xviXCkIC5G+dFhPBTnWSKdT0lePvrz8XCg3EmagVjsB61Jt
 EUtnQqsOyeqkVjL89DdU4JTcahP5wGsbNOZxvAJwuTted/MAYR9nle8Ev73AVxgrBC2N1+mszb4
 JHZyuaHXG8GaO1K6WT2OHfSwqzQ1iL6P+dojYfhlhWUTwgLh5agUaEnSxAEc6jbAFxPLfyRmgZj
 5arW9e9+wSA5RYekU8ecSc7+pkOjewZbIRmWJGQeTF1GVW/l
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The first patch fixes a pm_runtime imbalance in the m_can_platform
driver.

The rest of this series fixes the CAN state handling in the m_can
driver:
- add the missing state transition from "Error Warning" back to "Error
  Active" (patch 2)
- address the fact that in some SoCs (observed on the STM32MP15) the
  M_CAN IP core keeps the CAN state and CAN error counters over an
  internal reset cycle. Set the correct CAN state during ifup and
  system resume (patches 3+4)
- add support for optional shared external reset, to properly reset
  the IP core (patches 5+6)

The update of the DT binding for the reset property is upstream:
https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git/commit/?h=stm32-next&id=cfd856da6cf561f7e1dc6b16f3453814cde1058e

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v3:
- 2: drop patch
- 3: add Markus's R-b
- 4: add Markus's R-b
- 7: add dev_err_probe() to error path (thanks Markus)
- Link to v2: https://patch.msgid.link/20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de

Changes in v2:
- cover: added link to DT bindings update (thanks Philipp)
- 1: add Markus's R-b
- 2: always mask active interrupts (thanks Markus)
- 3: remove not needed comments (thanks Markus)
- 3: rename m_can_can_state_get_by_psr() -> m_can_state_get_by_psr() (thanks Markus)
- 3: read PSR inside m_can_state_get_by_psr() (thanks Markus)
- 5: add Markus's R-b
- 7: fix typo (thanks Philipp)
- 7: rename struct m_can_classdev::rsts -> rst (thanks Philipp)
- Link to v1: https://patch.msgid.link/20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de

---
Marc Kleine-Budde (6):
      can: m_can: m_can_plat_remove(): add missing pm_runtime_disable()
      can: m_can: m_can_handle_state_errors(): fix CAN state transition to Error Active
      can: m_can: m_can_chip_config(): bring up interface in correct state
      can: m_can: fix CAN state in system PM
      can: m_can: m_can_get_berr_counter(): don't wake up controller if interface is down
      can: m_can: add optional support for reset

 drivers/net/can/m_can/m_can.c          | 95 +++++++++++++++++++++++-----------
 drivers/net/can/m_can/m_can.h          |  1 +
 drivers/net/can/m_can/m_can_platform.c |  2 +-
 3 files changed, 67 insertions(+), 31 deletions(-)
---
base-commit: b65678cacc030efd53c38c089fb9b741a2ee34c8
change-id: 20250811-m_can-fix-state-handling-0ba4bda6cb8e

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


