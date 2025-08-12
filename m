Return-Path: <linux-can+bounces-4210-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA550B22F42
	for <lists+linux-can@lfdr.de>; Tue, 12 Aug 2025 19:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12EEC7B6EE0
	for <lists+linux-can@lfdr.de>; Tue, 12 Aug 2025 17:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93702FE582;
	Tue, 12 Aug 2025 17:37:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA40F2FDC22
	for <linux-can@vger.kernel.org>; Tue, 12 Aug 2025 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020246; cv=none; b=hjOlr5qjv+k7lqNcnD/H5scYAUdRTNZenNDtsX9JHmtoEqoBYCKPN8a3j1Fs+6fi4/6lK1oaoa6aSN8g/FE1O7xrjiDDOPquwERkT+643m7rZbroKXG6ZBwc60SP1bU6tB3WqDBOYbQ+Hv5STsVWmKsLmh7EoOAyMb1y8t5uL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020246; c=relaxed/simple;
	bh=ScYa6iAUvMdq/c7bVBFcUnZXmO/nZjs+Lfs/QDtxXaQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jdrv2aNOYLPN5xb5voeN3QpknqTYdkmmaT381mD0kC4vJLx5OyeHHlJRyybmrL2Afl1cs3P2eYbQh9P3ml9dxNBBZEM3SJKVlBqUuBz6RGZPxR3j2+lbTObSNSeG50THwkDe5bxt/D+Xai83dYwYwjm/4JGcEb4Qr9rdTubVRcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ulsw4-0008DD-OS
	for linux-can@vger.kernel.org; Tue, 12 Aug 2025 19:37:20 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ulsw4-00DEZT-06
	for linux-can@vger.kernel.org;
	Tue, 12 Aug 2025 19:37:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A26FF456232
	for <linux-can@vger.kernel.org>; Tue, 12 Aug 2025 17:37:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id A5C694561F2;
	Tue, 12 Aug 2025 17:37:16 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4e107f7f;
	Tue, 12 Aug 2025 17:37:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/7] can: m_can: fix pm_runtime and CAN state handling
Date: Tue, 12 Aug 2025 19:36:50 +0200
Message-Id: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALJ7m2gC/x2M0QrDIAwAf6XkeQEtW5H9SikjamoDnS1axkD89
 4U9Htxdg8pFuMJzaFD4I1WOrGBvA4SNcmKUqAyjGR/GWYvvV6CMq3yxXnQxqhR3yQmNp7uPNAX
 vGDQ/C6v1X89L7z+4crvzagAAAA==
X-Change-ID: 20250811-m_can-fix-state-handling-0ba4bda6cb8e
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Patrik Flykt <patrik.flykt@linux.intel.com>, 
 Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
 Varka Bhadram <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ScYa6iAUvMdq/c7bVBFcUnZXmO/nZjs+Lfs/QDtxXaQ=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBom3u8uAQp2ZvUHGJ2HZxpeJhg6/kBpfPVi5ToY
 RPl/MT9YR+JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaJt7vAAKCRAMdGXf+ZCR
 nIzoB/wIKeQLxnHo5O5mXWwUqFXrG7ms9mqGlBzp22gYOYuyaDX8SNhvjn+VXkkin4mW2pGGH6I
 MgN1QPyxTBaG/Ovv7mSjEaAn8grPXBIGvmbC+v38s4j1GnjRE9E9UCjH3Af4zB/KCH/tLMDQzl+
 yLt3uCy5z7s2SsNiD3qJqQRliR5cIbG/JvWa9AqiuM/5TlxlvaKnm435ytqRwAgsy7XPGtTeH/3
 hrfXkcAcaINiu4NS8QakwI+KhUpdWXclQUuT33DB4O8iiPuemuQMMZ+1cc+5pUEVKaXsHtCUQ5/
 ZItAiXoVMY4vinkDlDRARPHo+Fs2VVqhTTbIHD5EKmcMg/kM
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

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (7):
      can: m_can: m_can_plat_remove(): add missing pm_runtime_disable()
      can: m_can: m_can_rx_handler(): only handle active interrupts
      can: m_can: m_can_handle_state_errors(): fix CAN state transition to Error Active
      can: m_can: m_can_chip_config(): bring up interface in correct state
      can: m_can: fix CAN state in system PM
      can: m_can: m_can_get_berr_counter(): don't wake up controller if interface is down
      can: m_can: add optional support for reset

 drivers/net/can/m_can/m_can.c          | 93 ++++++++++++++++++++++++----------
 drivers/net/can/m_can/m_can.h          |  1 +
 drivers/net/can/m_can/m_can_platform.c |  2 +-
 3 files changed, 68 insertions(+), 28 deletions(-)
---
base-commit: 89886abd073489e26614e4d80fb8eb70d3938a0b
change-id: 20250811-m_can-fix-state-handling-0ba4bda6cb8e

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>



