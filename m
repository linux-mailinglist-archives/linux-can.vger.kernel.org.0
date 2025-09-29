Return-Path: <linux-can+bounces-5049-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9DABA86E8
	for <lists+linux-can@lfdr.de>; Mon, 29 Sep 2025 10:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48AB3C485B
	for <lists+linux-can@lfdr.de>; Mon, 29 Sep 2025 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A581C275B12;
	Mon, 29 Sep 2025 08:41:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0A2279351
	for <linux-can@vger.kernel.org>; Mon, 29 Sep 2025 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135266; cv=none; b=LZGDlP94GpKwAzJ4aMnipZ1eY0ECTud3qqXYyzdKbWvNv54hl420Z5hj5pFZ01Ehnkd3dyXEqYbYAtdJk51uw2WkzQ3BQRqWJFILZnTm9se2l6y3rtWIE0qev8bCgPZm4xUWsH76B/LEEKnsY0fLEBDDccXIUUZvesD8FN54DcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135266; c=relaxed/simple;
	bh=WHlUPc8b7xfsCCg6Kcy0K+SCE3IVlHkuVD2yF7KSBJQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JBfuzOdCotjUkluO4dzqaKiztwvZtE7cQ8VapgbaT0wb+UwRkeBV06p5N7ciN1b42vjm7G+zb0NkkBKhiB6B44JSH1hiUDFUAJi8/vC3KMNaxh5VMENkDywo09tFdR2Nx9C+KNAOLJu7EnYgLoDFmWeoTSPNCYwR/hKTm8fYEvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v39R0-0001cu-7U; Mon, 29 Sep 2025 10:40:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v39Qy-0012zJ-1t;
	Mon, 29 Sep 2025 10:40:36 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 36F9047C3A6;
	Mon, 29 Sep 2025 08:40:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 0/4] can: m_can: fix pm_runtime and CAN state handling
Date: Mon, 29 Sep 2025 10:40:12 +0200
Message-Id: <20250929-m_can-fix-state-handling-v4-0-682b49b49d9a@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOxF2mgC/33N0QqCMBQG4FeJXbc4bmbaVe8REWfb0QY1ZTMxx
 HdvClFQefkf/v87AwvkLQW2Xw3MU2eDrV0M6XrF9AVdRdyamJkAsYU8SfjtrNHx0vY8tNgSjyV
 zta7ioDBVBjOtcmJx3niKrZk+nmK+2NDW/jF/6pLp+kLFf7RLOHC1kwVBpgGlOjTkqnvra2f7j
 SE2yZ14awUUC5qIGpZFiSIFleX4U5MfmpALmowaZCZXqDUaVX5p4zg+AWChSqlhAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2392; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=WHlUPc8b7xfsCCg6Kcy0K+SCE3IVlHkuVD2yF7KSBJQ=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo2kXy+anY+ZFyRXJMxAt2UcE9lff15CtN2bEav
 coIM8u71oiJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaNpF8gAKCRAMdGXf+ZCR
 nFrnB/9Ds1wuqheuDPLbFvtbNujFTnmETJ8fRu3dp49+e14TTlUqmX09XA1CRZ1Jm7UMNIjeewH
 1N8FsQFg8xmfRUH2V71djh+F8mo0UERWPUwOuONp76Kn9XzCw/z2xEhp3C/EzQFgLH1v4sOw/T5
 tSGcjTOVNuoyJ9hrRne1UFAWtalcNmNuRGmBI/4l+szCQauWiyW7vgyBTX31Pw+qNnhG5VlQ3aH
 6RzsyvJCR0auUzz8IHur8BqWVI1ks3qvIxM2F6JzUvGPknoh6TZUoVEDvFSoDNO/5SxIx7DjsAH
 OGiEvFpf2mgVWVCF5/szm7FLmcrL+joPkNSccGuqiJ9fqz1w
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

The update of the DT binding for the reset property is upstream:
https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git/commit/?h=stm32-next&id=cfd856da6cf561f7e1dc6b16f3453814cde1058e

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v4:
- 5+6: drop patch
- Link to v3: https://patch.msgid.link/20250923-m_can-fix-state-handling-v3-0-06d8baccadbf@pengutronix.de

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
Marc Kleine-Budde (4):
      can: m_can: m_can_plat_remove(): add missing pm_runtime_disable()
      can: m_can: m_can_handle_state_errors(): fix CAN state transition to Error Active
      can: m_can: m_can_chip_config(): bring up interface in correct state
      can: m_can: fix CAN state in system PM

 drivers/net/can/m_can/m_can.c          | 64 ++++++++++++++++++++--------------
 drivers/net/can/m_can/m_can_platform.c |  2 +-
 2 files changed, 38 insertions(+), 28 deletions(-)
---
base-commit: 012ea489aedab1a4c08efbd936bb7be91a06d236
change-id: 20250811-m_can-fix-state-handling-0ba4bda6cb8e

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


