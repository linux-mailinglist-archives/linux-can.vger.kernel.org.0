Return-Path: <linux-can+bounces-5369-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91070C53FAD
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 19:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C42C2344994
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 18:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CA9F4F1;
	Wed, 12 Nov 2025 18:43:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB92280325
	for <linux-can@vger.kernel.org>; Wed, 12 Nov 2025 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973035; cv=none; b=FZmC6ATCQdawsjs8bUkq+LuiXW9VqiH5FAW/JGH7eOlP10Sx3mW3Upx/EkHOBguMpQU1XEbNYragECpS0FEsLPbxkpQsMqDDz9K0Dh+RXF5P2u8w9Al++8ov0AxDuUIgwSJ7QIOarCJZFIxVPdDAU4BBuyWXESMeI4LZJ/GlQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973035; c=relaxed/simple;
	bh=mhvf/Bmx2ne85fPfGbJezJxHzvRseqT3RO1gQQvgQrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MReXjoCslJ733GPRl5uDnhVhusVQP/Bmv/y+ZMIiIsw0p264AZ1F4bIyXfKmNALF2woSsjSEg+viCYMtq6bwp+SRqsKkDOzFwX6FHcwVmrqRz5MQ0HQwk375qwo1gdGBp9c7EvhGB8DXj+EAjPSben2dAbwE5uoyMh0aU4QJq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJFor-0006t1-M6; Wed, 12 Nov 2025 19:43:49 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vJFor-0008CT-0k;
	Wed, 12 Nov 2025 19:43:49 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D917549E0C2;
	Wed, 12 Nov 2025 18:43:48 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/11] pull-request: can-next 2025-11-12
Date: Wed, 12 Nov 2025 19:40:19 +0100
Message-ID: <20251112184344.189863-1-mkl@pengutronix.de>
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

this is a pull request of 11 patches for net-next/main.

The first 3 patches are by Vadim Fedorenko and convert the CAN drivers
to use the ndo_hwtstamp callbacks.

Maud Spierings contributes a patch for the mcp251x driver that
converts it to use dev_err_probe().

The next 6 patches target the mcp251xfd driver and are by Gregor
Herburger and me. They add GPIO controller functionality to the
driver.

The final patch is by Chu Guangqing and fixes a typo in the bxcan
driver.

regards,
Marc

---

The following changes since commit ea7d0d60ebc9bddf3ad768557dfa1495bc032bf6:

  Merge branch 'add-cn20k-nix-and-npa-contexts' (2025-10-30 10:44:12 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.19-20251112-2

for you to fetch changes up to b305fbdad4ed7e66b5b3f76b15f71d05fa6af212:

  can: bxcan: Fix a typo error for assign (2025-11-12 19:30:59 +0100)

----------------------------------------------------------------
linux-can-next-for-6.19-20251112-2

----------------------------------------------------------------
Chu Guangqing (1):
      can: bxcan: Fix a typo error for assign

Gregor Herburger (5):
      can: mcp251xfd: utilize gather_write function for all non-CRC writes
      can: mcp251xfd: add workaround for errata 5
      can: mcp251xfd: only configure PIN1 when rx_int is set
      can: mcp251xfd: add gpio functionality
      dt-bindings: can: mcp251xfd: add gpio-controller property

Marc Kleine-Budde (3):
      Merge patch series "convert can drivers to use ndo_hwtstamp callbacks"
      can: mcp251xfd: move chip sleep mode into runtime pm
      Merge patch series "can: mcp251xfd: add gpio functionality"

Maud Spierings (1):
      can: mcp251x: mcp251x_can_probe(): use dev_err_probe()

Vadim Fedorenko (3):
      can: convert generic HW timestamp ioctl to ndo_hwtstamp callbacks
      can: peak_canfd: convert to use ndo_hwtstamp callbacks
      can: peak_usb: convert to use ndo_hwtstamp callbacks

 .../bindings/net/can/microchip,mcp251xfd.yaml      |   5 +
 drivers/net/can/bxcan.c                            |   2 +-
 drivers/net/can/dev/dev.c                          |  45 ++--
 drivers/net/can/esd/esd_402_pci-core.c             |   3 +-
 drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c |   3 +-
 drivers/net/can/peak_canfd/peak_canfd.c            |  35 ++-
 drivers/net/can/spi/mcp251x.c                      |  31 ++-
 drivers/net/can/spi/mcp251xfd/Kconfig              |   1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     | 284 +++++++++++++++++----
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c   | 114 +++++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |   8 +
 drivers/net/can/usb/etas_es58x/es58x_core.c        |   3 +-
 drivers/net/can/usb/gs_usb.c                       |  20 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |   3 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |  35 ++-
 include/linux/can/dev.h                            |   6 +-
 16 files changed, 446 insertions(+), 152 deletions(-)

