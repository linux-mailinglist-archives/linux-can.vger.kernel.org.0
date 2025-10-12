Return-Path: <linux-can+bounces-5127-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A32BD03AF
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 16:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD8254E8A59
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 14:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C2F287243;
	Sun, 12 Oct 2025 14:28:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC87287250
	for <linux-can@vger.kernel.org>; Sun, 12 Oct 2025 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279330; cv=none; b=b8nbmbjqJA92aVbwef48YNs9ghzcFTehCAjZuW5r32JoXuWJuQSbPghZgs5Iu9I37gYrLloLxfFba5+nXufdmFiNGdmbXy/OPbdcKFeif7atixO4V5rMzKLhIrSZq2NWWffpMSJ4yOPTQxJvdLyIjoQR+snTlyQ9hDlOsNz5dw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279330; c=relaxed/simple;
	bh=Xdv43s3ud66H3OKIaHVEqrwrvpZRtpKfD5i3rJrg48E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jErNhlR9fPz70f1hZFGb2Y+Gs9I5fIrz0Gl75QUWCw8WmkO8hK5kj0XjEzEhRPwnq7X7AiEJ/PQiwmPawnYLe3xE9FS/5SNhfGbrwZ9cEduYl551QclF6f4Wrb/3CUp8k5Sccn7F7kyjplQEbmpD/awKLWT+t7jW4vRAahGFYt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v7x3w-00044h-8V; Sun, 12 Oct 2025 16:28:40 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v7x3v-003EUi-0v;
	Sun, 12 Oct 2025 16:28:39 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EBD3748405D;
	Sun, 12 Oct 2025 14:28:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/9] pull-request: can 2025-10-12
Date: Sun, 12 Oct 2025 16:20:44 +0200
Message-ID: <20251012142836.285370-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hello netdev-team,

this is a pull request of 9 patches for net/main.

The first 2 paches are by Celeste Liu and target the gS_usb driver.
The first patch remove the limitation to 3 CAN interface per USB
device. The second patch adds the missing population of
net_device->dev_port.

THe next 4 patches are by me and fix the m_can driver. They add a
missing pm_runtime_disable(), fix the CAN state transition back to
Error Active and fix the state after ifup and suspend/resume.

Another patch by me targets the m_can driver, too and replaces Dong
Aisheng's old email address.

The last 2 patches are by Vincent Mailhol and update the CAN
networking Documentation.

regards,
Marc

---

The following changes since commit 2c95a756e0cfc19af6d0b32b0c6cf3bada334998:

  net: pse-pd: tps23881: Fix current measurement scaling (2025-10-07 18:30:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.18-20251012

for you to fetch changes up to 91cb822f98b3438812304d151076dfca9b30d2e0:

  Merge patch series "can: add Transmitter Delay Compensation (TDC) documentation" (2025-10-12 16:18:47 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.18-20251012

----------------------------------------------------------------
Celeste Liu (2):
      can: gs_usb: increase max interface to U8_MAX
      can: gs_usb: gs_make_candev(): populate net_device->dev_port

Marc Kleine-Budde (7):
      can: m_can: m_can_plat_remove(): add missing pm_runtime_disable()
      can: m_can: m_can_handle_state_errors(): fix CAN state transition to Error Active
      can: m_can: m_can_chip_config(): bring up interface in correct state
      can: m_can: fix CAN state in system PM
      Merge patch series "can: m_can: fix pm_runtime and CAN state handling"
      can: m_can: replace Dong Aisheng's old email address
      Merge patch series "can: add Transmitter Delay Compensation (TDC) documentation"

Vincent Mailhol (2):
      can: remove false statement about 1:1 mapping between DLC and length
      can: add Transmitter Delay Compensation (TDC) documentation

 .mailmap                               |  1 +
 Documentation/networking/can.rst       | 67 +++++++++++++++++++++++++++++++--
 drivers/net/can/m_can/m_can.c          | 68 +++++++++++++++++++---------------
 drivers/net/can/m_can/m_can_platform.c |  6 +--
 drivers/net/can/usb/gs_usb.c           | 23 ++++++------
 5 files changed, 117 insertions(+), 48 deletions(-)

