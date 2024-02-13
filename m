Return-Path: <linux-can+bounces-242-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23A0852F6C
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 12:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7B6EB2275B
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 11:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EED5374C5;
	Tue, 13 Feb 2024 11:34:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5901C36AFD
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824085; cv=none; b=TehLrXinrq+NRt28xJcL9CmrqrpUc8tecrhI8mZMwYocIFbu3r3zdJnh13taUy7EvmyG9ADLuRvaznESQ2PB9lnGZ43fOHTo9grkdpmXIQ+aBrz07yKUMoW36+2NlM2NBwgy+Lt3x/DWH7Nef58regn5GH7guth1WZ1uxu4caYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824085; c=relaxed/simple;
	bh=VnOj+lN5A4LqeuCIOf0QipWgjppniZNEf+6vtJIg4HI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h22j5Zfl71PgBYkph5mFz6GrPtEUoNwXSapnt3bjBUS9w+Tx35ILlkxgY1CJPnrahMge+4yc3WPgN2ldjVGI4E3lPSKseDS31XMDuIXHjPnppuOfoT4PSBS6j89BIh+laToWFvX2DyKxeVWQ9Fso1ULENouLWMW1v2/oG+WsIuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3g-00013d-Hi
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 12:34:40 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZr3f-000TPl-Vr
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 12:34:40 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 99CAF28D636
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 11:34:39 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 9E5EB28D621;
	Tue, 13 Feb 2024 11:34:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3d7f212e;
	Tue, 13 Feb 2024 11:34:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/23] pull-request: can-next 2024-02-13
Date: Tue, 13 Feb 2024 12:25:03 +0100
Message-ID: <20240213113437.1884372-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
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

this is a pull request of 23 patches for net-next/master.

The first patch is by Nicolas Maier and targets the CAN Broadcast
Manager (bcm), it adds message flags to distinguish between own local
and remote traffic.

Oliver Hartkopp contributes a patch for the CAN ISOTP protocol that
adds dynamic flow control parameters.

Stefan Mätje's patch series add support for the esd PCIe/402 CAN
interface family.

Markus Schneider-Pargmann contributes 14 patches for the m_can to
optimize for the SPI attached tcan4x5x controller.

A patch by Vincent Mailhol replaces Wolfgang Grandegger by Vincent
Mailhol as the CAN drivers Co-Maintainer.

Jimmy Assarsson's patch add support for the Kvaser M.2 PCIe 4xCAN
adapter.

A patch by Daniil Dulov removed a redundant NULL check in the softing
driver.

Oliver Hartkopp contributes a patch to add CANXL virtual CAN network
identifier support.

A patch by myself removes Naga Sureshkumar Relli as the maintainer of
the xilinx_can driver, as their email bounces.

regards,
Marc

---

The following changes since commit 970cb1ceda170a3e583a5f26afdbebdfe5bf5a80:

  Merge branch 'phy-package' (2024-02-10 15:36:20 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.9-20240213

for you to fetch changes up to 73b8f5015889d4b5fbd885fa310ad8905fe50e4f:

  MAINTAINERS: can: xilinx_can: remove Naga Sureshkumar Relli (2024-02-13 11:47:17 +0100)

----------------------------------------------------------------
linux-can-next-for-6.9-20240213

----------------------------------------------------------------
Daniil Dulov (1):
      can: softing: remove redundant NULL check

Jimmy Assarsson (1):
      can: kvaser_pciefd: Add support for Kvaser M.2 PCIe 4xCAN

Marc Kleine-Budde (4):
      Merge patch series "can: esd: add support for esd GmbH PCIe/402 CAN interface"
      Merge patch series "can: m_can: Optimizations for m_can/tcan part 2"
      Merge patch "can network drivers maintainer"
      MAINTAINERS: can: xilinx_can: remove Naga Sureshkumar Relli

Markus Schneider-Pargmann (14):
      can: m_can: Start/Cancel polling timer together with interrupts
      can: m_can: Move hrtimer init to m_can_class_register
      can: m_can: Write transmit header and data in one transaction
      can: m_can: Implement receive coalescing
      can: m_can: Implement transmit coalescing
      can: m_can: Add rx coalescing ethtool support
      can: m_can: Add tx coalescing ethtool support
      can: m_can: Use u32 for putidx
      can: m_can: Cache tx putidx
      can: m_can: Use the workqueue as queue
      can: m_can: Introduce a tx_fifo_in_flight counter
      can: m_can: Use tx_fifo_in_flight for netif_queue control
      can: m_can: Implement BQL
      can: m_can: Implement transmit submission coalescing

Nicolas Maier (1):
      can: bcm: add recvmsg flags for own, local and remote traffic

Oliver Hartkopp (2):
      can: isotp: support dynamic flow control parameters
      can: canxl: add virtual CAN network identifier support

Stefan Mätje (2):
      MAINTAINERS: add Stefan Mätje as maintainer for the esd electronics GmbH PCIe/402 CAN drivers
      can: esd: add support for esd GmbH PCIe/402 CAN interface family

Vincent Mailhol (1):
      can: change can network drivers maintainer

 Documentation/networking/can.rst       |  34 +-
 MAINTAINERS                            |  10 +-
 drivers/net/can/Kconfig                |   2 +
 drivers/net/can/Makefile               |   1 +
 drivers/net/can/esd/Kconfig            |  12 +
 drivers/net/can/esd/Makefile           |   7 +
 drivers/net/can/esd/esd_402_pci-core.c | 514 ++++++++++++++++++++++
 drivers/net/can/esd/esdacc.c           | 764 +++++++++++++++++++++++++++++++++
 drivers/net/can/esd/esdacc.h           | 356 +++++++++++++++
 drivers/net/can/kvaser_pciefd.c        |  55 +++
 drivers/net/can/m_can/m_can.c          | 551 +++++++++++++++++-------
 drivers/net/can/m_can/m_can.h          |  34 +-
 drivers/net/can/m_can/m_can_platform.c |   4 -
 drivers/net/can/softing/softing_fw.c   |   2 +-
 include/uapi/linux/can.h               |   9 +-
 include/uapi/linux/can/isotp.h         |   1 +
 include/uapi/linux/can/raw.h           |  16 +
 net/can/af_can.c                       |   2 +
 net/can/bcm.c                          |  69 ++-
 net/can/isotp.c                        |   5 +-
 net/can/raw.c                          |  93 +++-
 21 files changed, 2348 insertions(+), 193 deletions(-)
 create mode 100644 drivers/net/can/esd/Kconfig
 create mode 100644 drivers/net/can/esd/Makefile
 create mode 100644 drivers/net/can/esd/esd_402_pci-core.c
 create mode 100644 drivers/net/can/esd/esdacc.c
 create mode 100644 drivers/net/can/esd/esdacc.h


