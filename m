Return-Path: <linux-can+bounces-1277-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BDB966BC4
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 23:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E212830FC
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 21:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C104D1C1734;
	Fri, 30 Aug 2024 21:59:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5961BF7FD
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725055161; cv=none; b=WKyeHQ28WtYNhdW+Vnsn8iIuDcS0lIwDttcnKlMRtWZt9qWP2oFHInPxCvfxOquAqL35bo/Ak+zf3woo0JbQTBSFJ9eO4YiSUsYUPOYsHNM6zmr8CFT5VA4Rji+lanvv+llku1hEnxQ4jli4HHHMbX+T51hTAiKfNDkuZCIeDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725055161; c=relaxed/simple;
	bh=TAFHUuVSQTZYEI54Px7n4FDkbeVnxXUGN3bZ/yvDhB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBffR8prFS8Ea/kkIoKllQ81j7sriOD9IrRyLR1jfwKQTxGQOgswl8FxFp2+ozVglhu/2Qlv/6Jbj5+dVIxxGYDMCreCb0s4+swDgemXTaL9DyxWCQF207buLE53hZesEPS92Olnlfcodc+bC0FzW4V51++JQpOb7oaOoIq6o5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eI-00049U-GK
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:59:18 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eH-004FUi-VX
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:59:18 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 98DAD32E4ED
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:59:17 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id AA20032E4D3;
	Fri, 30 Aug 2024 21:59:16 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id da6efe6b;
	Fri, 30 Aug 2024 21:59:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/n] pull-request: can 2024-08-30
Date: Fri, 30 Aug 2024 23:53:35 +0200
Message-ID: <20240830215914.1610393-1-mkl@pengutronix.de>
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

The last patch is by Martin Jocic for the kvaser_pciefd driver and
fixes a problem with lost IRQs, which result in starvation, under high
load situations.

regards,
Marc

---

The following changes since commit 92c4ee25208d0f35dafc3213cdf355fbe449e078:

  net: bridge: mcast: wait for previous gc cycles when removing port (2024-08-05 16:33:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.11-20240830

for you to fetch changes up to dd885d90c047dbdd2773c1d33954cbd8747d81e2:

  can: kvaser_pciefd: Use a single write when releasing RX buffers (2024-08-30 23:45:55 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.11-20240830

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
      can: kvaser_pciefd: Use a single write when releasing RX buffers

Simon Arlott (1):
      can: mcp251x: fix deadlock if an interrupt occurs during mcp251x_open

Simon Horman (1):
      can: m_can: Release irq on error in m_can_open

 drivers/net/can/kvaser_pciefd.c                |  18 ++--
 drivers/net/can/m_can/m_can.c                  | 116 +++++++++++++++----------
 drivers/net/can/spi/mcp251x.c                  |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ram.c  |  11 ++-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c |  34 ++++++--
 net/can/bcm.c                                  |   4 +
 6 files changed, 121 insertions(+), 64 deletions(-)


