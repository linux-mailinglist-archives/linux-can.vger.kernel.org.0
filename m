Return-Path: <linux-can+bounces-3638-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700B2AC0758
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 10:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A42A3AFD15
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F7D27C869;
	Thu, 22 May 2025 08:41:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C72629D
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903296; cv=none; b=YIhW21OH4MvjwhdbkggpKIW4n52TGWXzuPbesOv6r5r3tg4povC5Iq9uXOSTliG3f4qjC8smV6wapyqe0OtTa9S+FNfxXdJsqGCiSKUMY1ktuVyXjFRMwBdGrujhdoV+taTfIH7s05ILFctTg5HzYExDzchnBjohZvQcXRi1lm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903296; c=relaxed/simple;
	bh=J5BFGUS43VKTwi71YLxalIno4vgHjqJYdMJl3T7xBY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bd7Vp58H4RCxW0acZ7zxdkTqYEqVtaIZAz7kX0L0bszf6KYiwinoeo+8Te/97GxqJeEsy67tYTLlGrXsQY9Ofce66vZzg9K4ZotC45GC7PES+k0qM50Q3ighyaa4sqC5GKPvEsTgRu6caqALEh3NOKPIVOY07BqF0DocXZ25DyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Ua-0005wn-IK
	for linux-can@vger.kernel.org; Thu, 22 May 2025 10:41:32 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Ua-000hgp-1A
	for linux-can@vger.kernel.org;
	Thu, 22 May 2025 10:41:32 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 090B74172A4
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D800741729D;
	Thu, 22 May 2025 08:41:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3f3ab177;
	Thu, 22 May 2025 08:41:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/22] pull-request: can-next 2025-05-22
Date: Thu, 22 May 2025 10:36:28 +0200
Message-ID: <20250522084128.501049-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
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

this is a pull request of 22 patches for net-next/main.

The series by Biju Das contains 19 patches and adds RZ/G3E CANFD
support to the rcar_canfd driver.

The patch by Vincent Mailhol adds a struct data_bittiming_params to
group FD parameters as a preparation patch for CAN-XL support.

Felix Maurer's patch imports tst-filter from can-tests into the kernel
self tests and Vincent Mailhol adds support for physical CAN
interfaces.

regards,
Marc

---
The following changes since commit 9ab0ac0e532afd167b3bec39b2eb25c53486dcb5:

  octeontx2-pf: Add tracepoint for NIX_PARSE_S (2025-05-20 12:37:37 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.16-20250522

for you to fetch changes up to 3e20585abf2233da5212e6fb2f7c7ea0f337cd09:

  selftests: can: test_raw_filter.sh: add support of physical interfaces (2025-05-21 18:05:11 +0200)

----------------------------------------------------------------
linux-can-next-for-6.16-20250522

----------------------------------------------------------------

Biju Das (19):
      dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
      dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
      can: rcar_canfd: Use of_get_available_child_by_name()
      can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC macro
      can: rcar_canfd: Update RCANFD_GERFL_ERR macro
      can: rcar_canfd: Drop the mask operation in RCANFD_GAFLCFG_SETRNC macro
      can: rcar_canfd: Add rcar_canfd_setrnc()
      can: rcar_canfd: Update RCANFD_GAFLCFG macro
      can: rcar_canfd: Add rnc_field_width variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add max_aflpn variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add max_cftml variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add {nom,data}_bittiming variables to struct rcar_canfd_hw_info
      can: rcar_canfd: Add ch_interface_mode variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add shared_can_regs variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add struct rcanfd_regs variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add sh variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add external_clk variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Enhance multi_channel_irqs handling
      can: rcar_canfd: Add RZ/G3E support

Felix Maurer (1):
      selftests: can: Import tst-filter from can-tests

Marc Kleine-Budde (1):
      Merge patch series "Add support for RZ/G3E CANFD"

Vincent Mailhol (2):
      can: dev: add struct data_bittiming_params to group FD parameters
      selftests: can: test_raw_filter.sh: add support of physical interfaces

 .../bindings/net/can/renesas,rcar-canfd.yaml       | 171 ++++++---
 MAINTAINERS                                        |   2 +
 drivers/net/can/ctucanfd/ctucanfd_base.c           |   8 +-
 drivers/net/can/dev/dev.c                          |  12 +-
 drivers/net/can/dev/netlink.c                      |  74 ++--
 drivers/net/can/flexcan/flexcan-core.c             |   4 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c              |  10 +-
 drivers/net/can/kvaser_pciefd.c                    |   6 +-
 drivers/net/can/m_can/m_can.c                      |   8 +-
 drivers/net/can/peak_canfd/peak_canfd.c            |   6 +-
 drivers/net/can/rcar/rcar_canfd.c                  | 280 ++++++++++----
 drivers/net/can/rockchip/rockchip_canfd-core.c     |   4 +-
 .../net/can/rockchip/rockchip_canfd-timestamp.c    |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |  10 +-
 drivers/net/can/usb/esd_usb.c                      |   6 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c        |   4 +-
 drivers/net/can/usb/etas_es58x/es58x_fd.c          |   6 +-
 drivers/net/can/usb/gs_usb.c                       |   8 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h        |   2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |   6 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |   6 +-
 drivers/net/can/xilinx_can.c                       |  16 +-
 include/linux/can/dev.h                            |  28 +-
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/net/can/.gitignore         |   2 +
 tools/testing/selftests/net/can/Makefile           |  11 +
 tools/testing/selftests/net/can/test_raw_filter.c  | 405 +++++++++++++++++++++
 tools/testing/selftests/net/can/test_raw_filter.sh |  45 +++
 28 files changed, 922 insertions(+), 221 deletions(-)
 create mode 100644 tools/testing/selftests/net/can/.gitignore
 create mode 100644 tools/testing/selftests/net/can/Makefile
 create mode 100644 tools/testing/selftests/net/can/test_raw_filter.c
 create mode 100755 tools/testing/selftests/net/can/test_raw_filter.sh


