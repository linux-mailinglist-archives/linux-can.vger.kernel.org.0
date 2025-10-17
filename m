Return-Path: <linux-can+bounces-5210-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C877BE9A06
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 17:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C0F9583E14
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 15:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CE932C92B;
	Fri, 17 Oct 2025 15:08:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943FA33710B
	for <linux-can@vger.kernel.org>; Fri, 17 Oct 2025 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713716; cv=none; b=qw5mf3V+RstxJ96127CG5TC+SnSqcIeBG5NNA5Ml3+hw1cRz0kmMKxWUJoLqUm7t0x1/iY1u5RQvgPtmqBkUrRMgD97hNcfFhnXqqq1Vlr8WDEi02mS/3t7omB585kc/HMGJi6ZHgqSRX0x6tH2dzm2JbtMmdfq5XLnWK2cGJdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713716; c=relaxed/simple;
	bh=usb4dRiFLvjbM3q6c6DenTpAsRJFcg4O5Ag2iVo/emo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nuIz/KBEUPtqAjfa516+vYyT8mVmCH2GNjYFGkHF4TvBniHwOAG0K3KxXLA/aUDF/D8UIO92Eg/pgqIExbo7OJmSDY9R0n01c1IF8gOXbiLPFT9S5QkeZBsT7z8idt+hk5vCqU/ikH67EF1svakoAw+IsAq9GFGfkh4cJXt35sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4E-0003Mv-2Q; Fri, 17 Oct 2025 17:08:30 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9m4D-00450U-0o;
	Fri, 17 Oct 2025 17:08:29 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E97A94892B1;
	Fri, 17 Oct 2025 15:08:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/13] pull-request: can-next 2025-10-17
Date: Fri, 17 Oct 2025 17:04:08 +0200
Message-ID: <20251017150819.1415685-1-mkl@pengutronix.de>
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

this is a pull request of 13 patches for net-next/main.

The first patch is by me and adds support for an optional reset to the
m_can drivers.

Vincent Mailhol's patch targets all drivers and removes the
can_change_mtu() function, since the netdev's min and max MTU are
populated.

Markus Schneider-Pargmann contributes 4 patches to the m_can driver to
add am62 wakeup support.

The last 7 patches are by me and provide various cleanups to the m_can
driver.

regards,
Marc

---

The following changes since commit 7e0d4c111369ed385ec4aaa6c9c78c46efda54d0:

  Merge branch 'net-macb-various-cleanups' (2025-10-16 16:59:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.19-20251017

for you to fetch changes up to e41287a079224dcb49da5c8f710e9cb88763a71c:

  Merge patch series "can: m_can: various cleanups" (2025-10-17 15:18:25 +0200)

----------------------------------------------------------------
linux-can-next-for-6.19-20251017

----------------------------------------------------------------
Marc Kleine-Budde (10):
      can: m_can: add support for optional reset
      Merge patch series "can: m_can: Add am62 wakeup support"
      can: m_can: m_can_init_ram(): make static
      can: m_can: hrtimer_callback(): rename to m_can_polling_timer()
      net: m_can: convert dev_{dbg,info,err} -> netdev_{dbg,info,err}
      can: m_can: m_can_interrupt_enable(): use m_can_write() instead of open coding it
      can: m_can: m_can_class_register(): remove error message in case devm_kzalloc() fails
      can: m_can: m_can_tx_submit(): remove unneeded sanity checks
      can: m_can: m_can_get_berr_counter(): don't wake up controller if interface is down
      Merge patch series "can: m_can: various cleanups"

Markus Schneider-Pargmann (TI.com) (4):
      dt-bindings: can: m_can: Add wakeup properties
      can: m_can: Map WoL to device_set_wakeup_enable
      can: m_can: Return ERR_PTR on error in allocation
      can: m_can: Support pinctrl wakeup state

Vincent Mailhol (1):
      can: treewide: remove can_change_mtu()

 .../devicetree/bindings/net/can/bosch,m_can.yaml   |  25 ++
 drivers/net/can/at91_can.c                         |   1 -
 drivers/net/can/bxcan.c                            |   1 -
 drivers/net/can/c_can/c_can_main.c                 |   1 -
 drivers/net/can/can327.c                           |   1 -
 drivers/net/can/cc770/cc770.c                      |   1 -
 drivers/net/can/ctucanfd/ctucanfd_base.c           |   1 -
 drivers/net/can/dev/dev.c                          |  38 ---
 drivers/net/can/esd/esd_402_pci-core.c             |   1 -
 drivers/net/can/flexcan/flexcan-core.c             |   1 -
 drivers/net/can/grcan.c                            |   1 -
 drivers/net/can/ifi_canfd/ifi_canfd.c              |   1 -
 drivers/net/can/janz-ican3.c                       |   1 -
 drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c |   1 -
 drivers/net/can/m_can/m_can.c                      | 256 +++++++++++++++------
 drivers/net/can/m_can/m_can.h                      |   5 +-
 drivers/net/can/m_can/m_can_pci.c                  |   4 +-
 drivers/net/can/m_can/m_can_platform.c             |   4 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |   4 +-
 drivers/net/can/mscan/mscan.c                      |   1 -
 drivers/net/can/peak_canfd/peak_canfd.c            |   1 -
 drivers/net/can/rcar/rcar_can.c                    |   1 -
 drivers/net/can/rcar/rcar_canfd.c                  |   1 -
 drivers/net/can/rockchip/rockchip_canfd-core.c     |   1 -
 drivers/net/can/sja1000/sja1000.c                  |   1 -
 drivers/net/can/slcan/slcan-core.c                 |   1 -
 drivers/net/can/softing/softing_main.c             |   1 -
 drivers/net/can/spi/hi311x.c                       |   1 -
 drivers/net/can/spi/mcp251x.c                      |   1 -
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |   1 -
 drivers/net/can/sun4i_can.c                        |   1 -
 drivers/net/can/ti_hecc.c                          |   1 -
 drivers/net/can/usb/ems_usb.c                      |   1 -
 drivers/net/can/usb/esd_usb.c                      |   1 -
 drivers/net/can/usb/etas_es58x/es58x_core.c        |   1 -
 drivers/net/can/usb/f81604.c                       |   1 -
 drivers/net/can/usb/gs_usb.c                       |   1 -
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |   1 -
 drivers/net/can/usb/mcba_usb.c                     |   1 -
 drivers/net/can/usb/nct6694_canfd.c                |   1 -
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |   1 -
 drivers/net/can/usb/ucan.c                         |   1 -
 drivers/net/can/usb/usb_8dev.c                     |   1 -
 drivers/net/can/xilinx_can.c                       |   1 -
 include/linux/can/dev.h                            |   1 -
 45 files changed, 222 insertions(+), 152 deletions(-)

