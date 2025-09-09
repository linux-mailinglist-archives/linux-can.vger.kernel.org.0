Return-Path: <linux-can+bounces-4584-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BB5B504B0
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 19:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DFB1C25574
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 17:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1835235CED7;
	Tue,  9 Sep 2025 17:53:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FF835A29B
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757440429; cv=none; b=MC3qhcT904SdRWNSuuwMU0zjn2ar46BnDGCB2X66QzhRsOjuUxhNT8U3TZ6M6wIAtW2eW3uEJr8EU67FPne/AbQCVUe2Adyp5IrWm4rA3zbEsWgIlVmxuutRftTms2BWTiuoqvz/cdpFjkmHVRByBxW5Fs4iK+gGuhOJ4w2oVs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757440429; c=relaxed/simple;
	bh=ZdovXMiSeThfoRNRGSvylnqx77lLh3txUa8eYqsZvKU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R0zKEaVEi6Xm0X5IpGVSnJceQxa0YtDA0D87aoxrGeYvptllRNV3302C3KSmMSMH6p6OEhJk2RCu+yD9Irs+sURbIIdgfXJLBolXyKikd5aJ+q/ryd9ACnDRA9lAJfslcHoDSKGT9GT7c+FrmloTDXLsAOqmQMRLa2fX+33IgUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uw2XI-0006he-CJ
	for linux-can@vger.kernel.org; Tue, 09 Sep 2025 19:53:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uw2XH-000SbA-2h
	for linux-can@vger.kernel.org;
	Tue, 09 Sep 2025 19:53:43 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8665C46A3CD
	for <linux-can@vger.kernel.org>; Tue, 09 Sep 2025 17:53:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E959646A399;
	Tue, 09 Sep 2025 17:53:40 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 75e9cefd;
	Tue, 9 Sep 2025 17:53:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 0/7] can: m_can: fix pm_runtime and CAN state handling
Date: Tue, 09 Sep 2025 19:53:16 +0200
Message-Id: <20250909-m_can-fix-state-handling-v2-0-af9fa240b68a@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIxpwGgC/3WNzQ6CMBCEX4Xs2TVtUUROvochpj8rbKKFtJVgC
 O9uJfHo8ZvMfLNApMAUoSkWCDRx5MFnULsCbK99R8guMyihjqKWEp83qz3eecaYdCLMJfdg36E
 w+mCcrqypCfJ8DJRbm/raZu45piG8t6dJftOfVP2XThIFmlN5JlFZoUtzGcl3rxQGz/PeEbTru
 n4A6MUsTcUAAAA=
X-Change-ID: 20250811-m_can-fix-state-handling-0ba4bda6cb8e
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Patrik Flykt <patrik.flykt@linux.intel.com>, 
 Dong Aisheng <b29396@freescale.com>, Varka Bhadram <varkabhadram@gmail.com>, 
 Wu Bo <wubo.oduw@gmail.com>, Markus Schneider-Pargmann <msp@baylibre.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=2345; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ZdovXMiSeThfoRNRGSvylnqx77lLh3txUa8eYqsZvKU=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBowGmVDD0ID79aIfxKXM/x+bvJmDMsGkm1LbyxX
 Ut5wg7+1i+JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaMBplQAKCRAMdGXf+ZCR
 nEjyCACqJ5vMzoOe2ZDnFijROWH9W3eAIh7fouDf9DSkpbTkUwby/BRvB6VmFq2cD/l3D6fYgOy
 3p9MsIKqPaOKFM+na06wLgOhO46tp/zBe84xEtjsduokifoDvyI2gFoFR30Fm6Zc+jjARw1D7iF
 8nSAUktWuPZhZf7TROcndYX45MnUU773ucG+cEZv3dazAfilPxQFKNxiy3VHovai8f2hiWfQqDP
 qVFYEaEPllQOUgaPiFiLKSBKdcFglewLed2J9HDPyu4P4fOvTZU6gGv9/VkcpBG8lHT25E0DMUD
 TZRl3U4EIGMsO+kHVKp2LLXbvWF7d6NGoIasLjk42NHlS45f
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
- add the missing state transition from from Error Warning back to
  Error Active (Patches 2+3)
- address the fact that in some SoCs (observed on the STM32MP15) the
  M_CAN IP core keeps the CAN state and CAN error counters over an
  internal reset cycle. Set the correct CAN state during ifup and
  system resume (Patches 4+5)
- add support for optional shared external reset, to properly reset
  the IP core (Patches 6+7)

The update of the DT binding for the reset property is upstream:
https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git/commit/?h=stm32-next&id=cfd856da6cf561f7e1dc6b16f3453814cde1058e

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
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
Marc Kleine-Budde (7):
      can: m_can: m_can_plat_remove(): add missing pm_runtime_disable()
      can: m_can: only handle active interrupts
      can: m_can: m_can_handle_state_errors(): fix CAN state transition to Error Active
      can: m_can: m_can_chip_config(): bring up interface in correct state
      can: m_can: fix CAN state in system PM
      can: m_can: m_can_get_berr_counter(): don't wake up controller if interface is down
      can: m_can: add optional support for reset

 drivers/net/can/m_can/m_can.c          | 97 +++++++++++++++++++++++-----------
 drivers/net/can/m_can/m_can.h          |  1 +
 drivers/net/can/m_can/m_can_platform.c |  2 +-
 3 files changed, 69 insertions(+), 31 deletions(-)
---
base-commit: d3b28612bc5500133260aaf36794a0a0c287d61b
change-id: 20250811-m_can-fix-state-handling-0ba4bda6cb8e

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>



