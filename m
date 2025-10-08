Return-Path: <linux-can+bounces-5113-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD55BC66A0
	for <lists+linux-can@lfdr.de>; Wed, 08 Oct 2025 21:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9BC19E40A9
	for <lists+linux-can@lfdr.de>; Wed,  8 Oct 2025 19:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA43C2C21C0;
	Wed,  8 Oct 2025 19:08:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B62BF007
	for <linux-can@vger.kernel.org>; Wed,  8 Oct 2025 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950491; cv=none; b=uKQaIh7g7VQxku+pXu0ke5EnmizgtTEPsait1UQrrZLXiQz8x06t3yF3jDuNBlMpP5kvZKG8UoE/VLbDlYnG4Gp/Z88x5rtZI41VH1ddPGRf6nOrYd1fEk40bC6mSJviJvWQKEJVE21cROUQZO5F94ajFu7BwX1wbxKMmnF9w3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950491; c=relaxed/simple;
	bh=hzA4W5PP1Ls+GF+uTBdAca8Z5agnj5TYXh+X09PjVIo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ocq1vxlUTG5yO4S2PMWSpftc3Mj1TIsltY/Bsfk99D2JdnSKPNWV2T+mFbotdc8KZCCqK+6N0QNgdqKvridAxLlu0ygwoBxVd60QMvWfPFlS7IIm37b3PPYduKWkqDy4BkLWcO5pnFs69enCKlfqRFaLNf5oLI5lMKEbOBYB+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW4-0003RL-3P; Wed, 08 Oct 2025 21:08:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW3-002cDC-0B;
	Wed, 08 Oct 2025 21:07:59 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B10EE4821F4;
	Wed, 08 Oct 2025 19:07:58 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/7] can: m_can: various cleanups
Date: Wed, 08 Oct 2025 21:07:35 +0200
Message-Id: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHe25mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyNj3dz45MQ83eSc1MS80oJi3RQDE2Oz5BRjQ8NEUyWgpoKi1LTMCrC
 B0bG1tQCAxPwUYAAAAA==
X-Change-ID: 20250923-m_can-cleanups-d0436cd311a5
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-92513
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=hzA4W5PP1Ls+GF+uTBdAca8Z5agnj5TYXh+X09PjVIo=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo5rZ/KwN18YhSJY1WXSLh1kZHfhlhTP12dT8VS
 3CgV13iPqaJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaOa2fwAKCRAMdGXf+ZCR
 nDXlB/9AUe3FBCIuwgsGZHjYRXr6/Wp4umaWzSGQfz8D0U0p7+G5+ZB13Tl7yZQxF9wZWDMcQr+
 R0aD4NWu1PRuGBxwjayaGcScphade7CArhczXchOGKgE+Pryh+O/gk7BrCBsl70Q0Yy2c3/4S+2
 +BtOeiiBf4XmTo9Nd/RGawSY7Gd1ywzjtqcFYjJ9eNVInB6LC4ZC7YQFUc0f5cCohOeb6+Mf6/H
 v4em5D/yHqVI7Vtp7dIVkf0YvkCfNcvg6QTkUg7O9bFW3K5aUO1qw7XjVa2aW754DcHygP2mz27
 FQU428+dPDVWracHD1fkpAUCE+2Ln+KuFLgqNgJcCRuTr+CO
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

While working on the m_can driver, I created several cleanups commits, make
m_can_init_ram() static, rename hrtimer function, convert debugging and
error output to netdev_(), replace open coded register write by
m_can_write(), remove not needed error messages and sanity checks and don't
wake up hte controller during m_can_get_berr_counter() if the interface is
down.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (7):
      can: m_can: m_can_init_ram(): make static
      can: m_can: hrtimer_callback(): rename to m_can_polling_timer()
      net: m_can: convert dev_{dbg,info,err} -> netdev_{dbg,info,err}
      can: m_can: m_can_interrupt_enable(): use m_can_write() instead of open coding it
      can: m_can: m_can_class_register(): remove error message in case devm_kzalloc() fails
      can: m_can: m_can_tx_submit(): remove unneeded sanity checks
      can: m_can: m_can_get_berr_counter(): don't wake up controller if interface is down

 drivers/net/can/m_can/m_can.c | 116 ++++++++++++++++++++----------------------
 drivers/net/can/m_can/m_can.h |   1 -
 2 files changed, 56 insertions(+), 61 deletions(-)
---
base-commit: 07fdad3a93756b872da7b53647715c48d0f4a2d0
change-id: 20250923-m_can-cleanups-d0436cd311a5

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


