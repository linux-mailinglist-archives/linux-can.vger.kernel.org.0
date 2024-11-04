Return-Path: <linux-can+bounces-1875-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528F99BBE62
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 21:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765CF1C210E1
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 20:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E641D4146;
	Mon,  4 Nov 2024 20:01:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24111CDFCA
	for <linux-can@vger.kernel.org>; Mon,  4 Nov 2024 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750489; cv=none; b=S9k0ri7OHjHBURTCqxyrvh9Nz2g/KIXksK55yXs4wPeRMSIFpA6RhX962brhzwR8oDUR5YP0ri+j1k8FOQTudt60cL3iGMOPyhNrKbnd2pdDQdTsZvVz5K168wPo4K4z31oAsw8YK/gZV9o85hjy1D2Mwpr5O7oQEEqdnXx5lH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750489; c=relaxed/simple;
	bh=eN6yMsFrtsKmQ8EIPxXbpSyqyXM43tLF4wJxRtSMsgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K7opllDnqj34Xf3AIng2wIXkCXQPerOS4nHk2FqbdZ+CIEy2GFYHTFC+yPi02dRdMMcT0oj7+M0zOwuYbprR15xxC4ErXGMFClYomiWiGb/QmX8DneCHrABXYddwWkqflfVbNYUAwOpSvZyGoTL7hUWnvQzmjGDoHfBwuHzK9Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t83GN-0001WV-S9
	for linux-can@vger.kernel.org; Mon, 04 Nov 2024 21:01:23 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t83GN-00223N-1j
	for linux-can@vger.kernel.org;
	Mon, 04 Nov 2024 21:01:23 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 34A6D367F77
	for <linux-can@vger.kernel.org>; Mon, 04 Nov 2024 20:01:23 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3D0A8367F5F;
	Mon, 04 Nov 2024 20:01:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id aeb109b5;
	Mon, 4 Nov 2024 20:01:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/8] pull-request: can 2024-11-04
Date: Mon,  4 Nov 2024 20:53:23 +0100
Message-ID: <20241104200120.393312-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hello netdev-team,

this is a pull request of 8 patches for net/master.

Alexander Hölzl contributes a patch to fix an error in the CAN j1939
documentation.

Thomas Mühlbacher's patch allows building of the {cc770,sja1000}_isa
drivers on x86_64 again.

A patch by me targets the m_can driver and limits the call to
free_irq() to devices with IRQs.

Dario Binacchi's patch fixes the RX and TX error counters in the c_can
driver.

The next 2 patches target the rockchip_canfd driver. Geert
Uytterhoeven's patch lets the driver depend on ARCH_ROCKCHIP. Jean
Delvare's patch drops the obsolete dependency on COMPILE_TEST.

The last 2 patches are by me and fix 2 regressions in the mcp251xfd
driver: fix broken coalescing configuration when switching CAN modes
and fix the length calculation of the Transmit Event FIFO (TEF) on
full TEF.

regards,
Marc

---

The following changes since commit 5ccdcdf186aec6b9111845fd37e1757e9b413e2f:

  net: xilinx: axienet: Enqueue Tx packets in dql before dmaengine starts (2024-11-03 14:35:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.12-20241104

for you to fetch changes up to 3c1c18551e6ac1b988d0a05c5650e3f6c95a1b8a:

  can: mcp251xfd: mcp251xfd_get_tef_len(): fix length calculation (2024-11-04 18:01:07 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.12-20241104

----------------------------------------------------------------
Alexander Hölzl (1):
      can: j1939: fix error in J1939 documentation.

Dario Binacchi (1):
      can: c_can: fix {rx,tx}_errors statistics

Geert Uytterhoeven (1):
      can: rockchip_canfd: CAN_ROCKCHIP_CANFD should depend on ARCH_ROCKCHIP

Jean Delvare (1):
      can: rockchip_canfd: Drop obsolete dependency on COMPILE_TEST

Marc Kleine-Budde (3):
      can: m_can: m_can_close(): don't call free_irq() for IRQ-less devices
      can: mcp251xfd: mcp251xfd_ring_alloc(): fix coalescing configuration when switching CAN modes
      can: mcp251xfd: mcp251xfd_get_tef_len(): fix length calculation

Thomas Mühlbacher (1):
      can: {cc770,sja1000}_isa: allow building on x86_64

 Documentation/networking/j1939.rst             |  2 +-
 drivers/net/can/c_can/c_can_main.c             |  7 ++++++-
 drivers/net/can/cc770/Kconfig                  |  2 +-
 drivers/net/can/m_can/m_can.c                  |  3 ++-
 drivers/net/can/rockchip/Kconfig               |  3 ++-
 drivers/net/can/sja1000/Kconfig                |  2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c |  8 +++++---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c  | 10 +++++++---
 8 files changed, 25 insertions(+), 12 deletions(-)


