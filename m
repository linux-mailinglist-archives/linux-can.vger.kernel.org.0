Return-Path: <linux-can+bounces-1219-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B49F964ED4
	for <lists+linux-can@lfdr.de>; Thu, 29 Aug 2024 21:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA98C281902
	for <lists+linux-can@lfdr.de>; Thu, 29 Aug 2024 19:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC04D1B9B36;
	Thu, 29 Aug 2024 19:29:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A041B86C0
	for <linux-can@vger.kernel.org>; Thu, 29 Aug 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959797; cv=none; b=ZWoJ2GcG8dAkKbPATpp7kd6pF4FT9i/ZqvpJslPpumfQsEeowFQAIiHMQCZ9sIKTIpVM4rnpiDDr0yrSHiFEvBHvGigcLrI7hg54OUqFpymYvqYbsPgeCK/wVWtm9gINyTztb6BU9FwamgwBtx3t/PJG6sJYp+lDY5dmylemA1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959797; c=relaxed/simple;
	bh=VXoQ1owr7pgmYuXyEcU1YFEfS9aybD1xyJUEIjNIywg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raEgpsFLl1MWGRoLUO4tF/S6+eBl/EgcM16MnSJiSq1WjhyG96mXch3x9cqs9UNgqtXKk+q3GJMnVHtV/AvlSjnyYv7kjpOgTeMF1baqm4+V+TvAIhEwn6jVj+U06A4XrTUV4aNCXjoD3Wd+w0HrMcTJPeG3rFJ23H/OUgdQxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjkq9-000638-Hj
	for linux-can@vger.kernel.org; Thu, 29 Aug 2024 21:29:53 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjkq9-003yog-0K
	for linux-can@vger.kernel.org; Thu, 29 Aug 2024 21:29:53 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 96E3D32D486
	for <linux-can@vger.kernel.org>; Thu, 29 Aug 2024 19:29:52 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id AAEBB32D46C;
	Thu, 29 Aug 2024 19:29:51 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d4b88140;
	Thu, 29 Aug 2024 19:29:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/13] pull-request: can 2024-08-29
Date: Thu, 29 Aug 2024 21:20:33 +0200
Message-ID: <20240829192947.1186760-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
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

this is a pull request of 13 patches for net/master.

The first patch is by Kuniyuki Iwashima for the CAN BCM protocol that
adds a missing proc entry removal when a device unregistered.

Simon Horman fixes the cleanup in the error cleanup path of the m_can
driver's open function.

Markus Schneider-Pargmann contributes 7 fixes for the m_can driver,
all related to the recently added IRQ coalescing support.

The next 2 patches are by me, target the mcp251xfd driver and fix ring
and coalescing configuration problems when switching from CAN-CC to
CAN-FD mode.

Simon Arlott's patch fixes a possible deadlock in the mcp251x driver.

The last patch is by Martin Jocic and enables 64-bit DMA to prevent
issues on memory constrained 64 bit platforms.

regards,
Marc

---

The following changes since commit 92c4ee25208d0f35dafc3213cdf355fbe449e078:

  net: bridge: mcast: wait for previous gc cycles when removing port (2024-08-05 16:33:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.11-20240829

for you to fetch changes up to 96b3802c7f57d4ae1ffeed6d4c948899aa93a858:

  can: kvaser_pciefd: Enable 64-bit DMA addressing (2024-08-29 10:44:28 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.11-20240829

----------------------------------------------------------------
Kuniyuki Iwashima (1):
      can: bcm: Remove proc entry when dev is unregistered.

Marc Kleine-Budde (4):
      Merge patch series "can: m_can: Fix polling and other issues"
      can: mcp251xfd: fix ring configuration when switching from CAN-CC to CAN-FD mode
      can: mcp251xfd: mcp251xfd_ring_init(): check TX-coalescing configuration
      Merge patch series "can: mcp251xfd: fix ring/coalescing configuration"

Markus Schneider-Pargmann (7):
      can: m_can: Reset coalescing during suspend/resume
      can: m_can: Remove coalesing disable in isr during suspend
      can: m_can: Remove m_can_rx_peripheral indirection
      can: m_can: Do not cancel timer from within timer
      can: m_can: disable_all_interrupts, not clear active_interrupts
      can: m_can: Reset cached active_interrupts on start
      can: m_can: Limit coalescing to peripheral instances

Martin Jocic (1):
      can: kvaser_pciefd: Enable 64-bit DMA addressing

Simon Arlott (1):
      can: mcp251x: fix deadlock if an interrupt occurs during mcp251x_open

Simon Horman (1):
      can: m_can: Release irq on error in m_can_open

 drivers/net/can/kvaser_pciefd.c                |   4 +
 drivers/net/can/m_can/m_can.c                  | 116 +++++++++++++++----------
 drivers/net/can/spi/mcp251x.c                  |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ram.c  |  11 ++-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c |  34 ++++++--
 net/can/bcm.c                                  |   4 +
 6 files changed, 117 insertions(+), 54 deletions(-)


