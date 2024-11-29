Return-Path: <linux-can+bounces-2260-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6EA9DE661
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 13:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAAFDB234D3
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 12:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12DB19DF4B;
	Fri, 29 Nov 2024 12:27:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634519A28D
	for <linux-can@vger.kernel.org>; Fri, 29 Nov 2024 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732883257; cv=none; b=oVvTJ44cyqV5pvkryPNXBQEmbHFatinNoDDzVTS3WkV+q3lmB4a3R2VHP+npsZX7n+GA6Timu7xi63tyFXffxeKq/QMfJ6V9wIs/UdAU1hDcxGHYjPzM2fK7EaB1X6PjOjFM6bzNMTeidJ8dCTlhyI9hEKrgc/n4LbrmdDqv/nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732883257; c=relaxed/simple;
	bh=BX6dNmRyBmtmvDOVfMug6Id+L2DaIwPG0ClQbElpQKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R2nEF7zw84ilGWYTWbNxa0kpj/pakRVvCwnIHzMZs1JU+BaSztawex4rFpkwZsRcIZ6v5Y1wtiYcUZ+N3bx6eVKpXbvxtOOc37wHAK5MgXp79yVzrzUj5MvsEMFGZcvkQ4rmbmf3HfzOMqE2eiCOQKIxmLqE2VdaNqvD+A9L7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH05r-0007jA-Js
	for linux-can@vger.kernel.org; Fri, 29 Nov 2024 13:27:31 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH05q-000mfo-1s
	for linux-can@vger.kernel.org;
	Fri, 29 Nov 2024 13:27:31 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 06E9238111D
	for <linux-can@vger.kernel.org>; Fri, 29 Nov 2024 12:27:30 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id DA8C6381101;
	Fri, 29 Nov 2024 12:27:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 489071bb;
	Fri, 29 Nov 2024 12:27:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/14] pull-request: can 2024-11-29
Date: Fri, 29 Nov 2024 13:16:47 +0100
Message-ID: <20241129122722.1046050-1-mkl@pengutronix.de>
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

this is a pull request of 14 patches for net/master.

The first patch is by me and allows the use of sleeping GPIOs to set
termination GPIOs.

Alexander Kozhinov fixes the gs_usb driver to use the endpoints
provided by the usb endpoint descriptions instead of hard coded ones.

Dario Binacchi contributes 11 statistics related patches for various
CAN driver. A potential use after free in the hi311x is fixed. The
statistics for the c_can, sun4i_can, hi311x, m_can, ifi_canfd,
sja1000, sun4i_can, ems_usb, f81604 are fixed: update statistics even
if the allocation of the error skb fails and fix the incrementing of
the rx,tx error counters.

The last patch is by me, targets the mcp251xfd driver and fixes the
workaround for erratum DS80000789E 6.

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


