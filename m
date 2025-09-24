Return-Path: <linux-can+bounces-4910-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310DDB98CA0
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4544C238D
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9AB276058;
	Wed, 24 Sep 2025 08:21:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD92248A5
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702099; cv=none; b=J6Nx+/OIgUjYEOkUcsXAbu8Lz4uk+AcdzvzzfQY3t5MM9S6qUaEym6gh3zjO/ITUPayck2cVgfKVuFrEFS0/553SKLOwjJOvPDaxV2T3sDUaHD0MYuKcP2VTv9Ia2yV12kekWMPm/IksarrNAI4404k3wQGq4FR4q0lOytfRVaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702099; c=relaxed/simple;
	bh=JlyXssYgEtRDZhJcS5px0wvZRj+USk6czJCt67m/bgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GdOk+kKIlv3qX4yCP0Cq/XlsKKnsl+zme1bExV85HZU/8j3dPqVu4sRzj3ozL9B5CY6uYk0k6uuv32eWzgaLZqQFW5j9rIT7fKZ28mqdiYg4RC2K+2USuWdJSRno5GoRito41oQMRe3fVBXgrzMIta6sF/wdopi1UKeXP2uAdEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkf-0001GQ-5B; Wed, 24 Sep 2025 10:21:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-000DwN-1o;
	Wed, 24 Sep 2025 10:21:23 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B3056478864;
	Wed, 24 Sep 2025 08:21:06 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/48] pull-request: can-next 2025-09-24
Date: Wed, 24 Sep 2025 10:06:17 +0200
Message-ID: <20250924082104.595459-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
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

this is a pull request of 48 patches for net-next/main.

The 1st patch is by Xichao Zhao and converts ns_to_ktime() to
us_to_ktime() in the m_can driver.

Vincent Mailhol contributes 2 patches: Updating the MAINTAINERS and
mailmap files to Vincent's new email address and sorting the includes
in the CAN helper library alphabeticaly.

Stéphane Grosjean's patch modifies all peak CAN drivers and the
mailmap to reflect Stéphane's new email address.

4 patches by Biju Das update the CAN-FD handling in the rcar_canfd
driver.

Followed by 11 patches by Geert Uytterhoeven updating and improving
the rcar_can driver.

Stefan Mätje contributes 2 patches for the esd_usb driver updating the
error messages.

The next 3 patch series are all by Vincent Mailhol: 3 patches to
optimize the size of struct raw_sock and struct uniqframe. 4 patches
which rework the CAN MTU logic as preparation for CAN-XL interfaces.
And finally 20 patches that prepare and refactor the CAN netlink code
for the upcoming CAN-XL support.

regards,
Marc

---

The following changes since commit fc006f5478fcf07d79b35e9dcdc51ecd11a6bf82:

  net: phy: micrel: Update Kconfig help text (2025-09-12 17:34:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.18-20250923

for you to fetch changes up to 4219e551c831111dcaba226c8d633bfe90c07f1e:

  Merge patch series "can: netlink: preparation before introduction of CAN XL step 3/3" (2025-09-23 10:10:28 +0200)

----------------------------------------------------------------
linux-can-next-for-6.18-20250923

----------------------------------------------------------------
Biju Das (4):
      can: rcar_canfd: Update bit rate constants for RZ/G3E and R-Car Gen4
      can: rcar_canfd: Update RCANFD_CFG_* macros
      can: rcar_canfd: Simplify nominal bit rate config
      can: rcar_canfd: Simplify data bit rate config

Geert Uytterhoeven (11):
      can: rcar_can: Consistently use ndev for net_device pointers
      can: rcar_can: Add helper variable dev to rcar_can_probe()
      can: rcar_can: Convert to Runtime PM
      can: rcar_can: Convert to BIT()
      can: rcar_can: Convert to GENMASK()
      can: rcar_can: CTLR bitfield conversion
      can: rcar_can: TFCR bitfield conversion
      can: rcar_can: BCR bitfield conversion
      can: rcar_can: Mailbox bitfield conversion
      can: rcar_can: Do not print alloc_candev() failures
      can: rcar_can: Convert to %pe

Marc Kleine-Budde (6):
      Merge patch series "can: rcar_canfd: R-Car CANFD Improvements"
      Merge patch series "can: rcar_can: Miscellaneous cleanups and improvements"
      Merge patch series "can: esd_usb: Fixes and improvements"
      Merge patch series "can: raw: optimize the sizes of struct uniqframe and struct raw_sock"
      Merge patch series "can: rework the CAN MTU logic (CAN XL preparation step 2/3)"
      Merge patch series "can: netlink: preparation before introduction of CAN XL step 3/3"

Stefan Mätje (2):
      can: esd_usb: Rework display of error messages
      can: esd_usb: Avoid errors triggered from USB disconnect

Stéphane Grosjean (1):
      can: peak: Modification of references to email accounts being deleted

Vincent Mailhol (29):
      MAINTAINERS: update Vincent Mailhol's email address
      can: dev: sort includes by alphabetical order
      can: raw: reorder struct uniqframe's members to optimise packing
      can: raw: use bitfields to store flags in struct raw_sock
      can: raw: reorder struct raw_sock's members to optimise packing
      can: annotate mtu accesses with READ_ONCE()
      can: dev: turn can_set_static_ctrlmode() into a non-inline function
      can: populate the minimum and maximum MTU values
      can: enable CAN XL for virtual CAN devices by default
      can: dev: move struct data_bittiming_params to linux/can/bittiming.h
      can: dev: make can_get_relative_tdco() FD agnostic and move it to bittiming.h
      can: netlink: document which symbols are FD specific
      can: netlink: refactor can_validate_bittiming()
      can: netlink: add can_validate_tdc()
      can: netlink: add can_validate_databittiming()
      can: netlink: refactor CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
      can: netlink: remove useless check in can_tdc_changelink()
      can: netlink: make can_tdc_changelink() FD agnostic
      can: netlink: add can_dtb_changelink()
      can: netlink: add can_ctrlmode_changelink()
      can: netlink: make can_tdc_get_size() FD agnostic
      can: netlink: add can_data_bittiming_get_size()
      can: netlink: add can_bittiming_fill_info()
      can: netlink: add can_bittiming_const_fill_info()
      can: netlink: add can_bitrate_const_fill_info()
      can: netlink: make can_tdc_fill_info() FD agnostic
      can: calc_bittiming: make can_calc_tdco() FD agnostic
      can: dev: add can_get_ctrlmode_str()
      can: netlink: add userland error messages

Xichao Zhao (1):
      can: m_can: use us_to_ktime() where appropriate

 .mailmap                                      |   3 +
 MAINTAINERS                                   |   4 +-
 drivers/net/can/dev/calc_bittiming.c          |  10 +-
 drivers/net/can/dev/dev.c                     |  81 +++-
 drivers/net/can/dev/netlink.c                 | 628 ++++++++++++++++----------
 drivers/net/can/m_can/m_can.c                 |   6 +-
 drivers/net/can/peak_canfd/peak_canfd.c       |   4 +-
 drivers/net/can/peak_canfd/peak_canfd_user.h  |   4 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c |   6 +-
 drivers/net/can/rcar/rcar_can.c               | 290 ++++++------
 drivers/net/can/rcar/rcar_canfd.c             |  84 ++--
 drivers/net/can/sja1000/peak_pci.c            |   6 +-
 drivers/net/can/sja1000/peak_pcmcia.c         |   8 +-
 drivers/net/can/usb/esd_usb.c                 |  64 ++-
 drivers/net/can/usb/peak_usb/pcan_usb.c       |   6 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  |   6 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h  |   4 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c    |   3 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c   |   4 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h   |   4 +-
 drivers/net/can/vcan.c                        |   2 +-
 drivers/net/can/vxcan.c                       |   2 +-
 include/linux/can/bittiming.h                 |  48 +-
 include/linux/can/dev.h                       |  66 +--
 include/linux/can/dev/peak_canfd.h            |   4 +-
 include/uapi/linux/can/netlink.h              |  14 +-
 net/can/af_can.c                              |   2 +-
 net/can/isotp.c                               |   2 +-
 net/can/raw.c                                 |  67 +--
 29 files changed, 848 insertions(+), 584 deletions(-)

