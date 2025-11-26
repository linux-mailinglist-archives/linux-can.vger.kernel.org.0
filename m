Return-Path: <linux-can+bounces-5699-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1ABC89A1C
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 13:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A030B4E23C0
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4489BEED8;
	Wed, 26 Nov 2025 12:01:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF025227B8E
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158477; cv=none; b=G5wqrQp74p5LkzAqnZYblBvCA70BpCaUyLkv33AySfXVlAqBnXP/Zi94dcLRnMx7Gidu1Pj2N11MJquZgdgKXgVoR2gSJ2sK67MW40xkarO7wcI4r/ViW4HAMwo5rCIWqvnSLahGyJOMi3nS2nGwXH8nC6R9icJCNyeED9wrrDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158477; c=relaxed/simple;
	bh=LKIJSEs2I9JNnBn845A75HVIJEY1JXRS3Y1bQn29h9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqoY9sTFDO3L3rmS0YjbteYtnWP1fRHncP4iMPsZ43Z6nR2VWXKmld5uBT++yJR8KiNYP9k1QtJfW5vovOwWJUEoYAPejbfCIjUCsJn9GAeJRLoBgO57Qp8Uso8EjTnkr3mXvFImnBZzdFwaM56xXq/Z8QS64nQBtGiugdCwmj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOECs-0004Ss-F3; Wed, 26 Nov 2025 13:01:10 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOECr-002bE7-18;
	Wed, 26 Nov 2025 13:01:09 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EC0DF4A8A8B;
	Wed, 26 Nov 2025 12:01:08 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/27] pull-request: can-next 2025-11-26
Date: Wed, 26 Nov 2025 12:56:49 +0100
Message-ID: <20251126120106.154635-1-mkl@pengutronix.de>
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

this is a pull request of 27 patches for net-next/main.

The first 17 patches are by Vincent Mailhol and Oliver Hartkopp and
add CAN XL support to the CAN netlink interface.

Geert Uytterhoeven and Biju Das provide 7 patches for the rcar_canfd
driver to add suspend/resume support.

The next 2 patches are by Markus Schneider-Pargmann and add them as
the m_can maintainer.

Conor Dooley's patch updates the mpfs-can DT bindungs.

regards,
Marc

---

The following changes since commit ab084f0b8d6d2ee4b1c6a28f39a2a7430bdfa7f0:

  drivers: net: fbnic: Return the true error in fbnic_alloc_napi_vectors. (2025-11-25 19:52:58 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.19-20251126

for you to fetch changes up to 9aea35eb98a6560daf85a2ae9cbd482a66e4d076:

  dt-bindings: can: mpfs: document resets (2025-11-26 11:30:37 +0100)

----------------------------------------------------------------
linux-can-next-for-6.19-20251126

----------------------------------------------------------------
Biju Das (1):
      can: rcar_canfd: Use devm_clk_get_optional() for RAM clk

Conor Dooley (1):
      dt-bindings: can: mpfs: document resets

Geert Uytterhoeven (6):
      can: rcar_canfd: Invert reset assert order
      can: rcar_canfd: Invert global vs. channel teardown
      can: rcar_canfd: Extract rcar_canfd_global_{,de}init()
      can: rcar_canfd: Invert CAN clock and close_candev() order
      can: rcar_canfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
      can: rcar_canfd: Add suspend/resume support

Marc Kleine-Budde (3):
      Merge patch series "can: netlink: add CAN XL support"
      Merge patch series "Add R-Car CAN-FD suspend/resume support"
      Merge patch series "MAINTAINERS: Add myself as m_can maintainer"

Markus Schneider-Pargmann (2):
      MAINTAINERS: Add myself as m_can maintainer
      MAINTAINERS: Simplify m_can section

Oliver Hartkopp (4):
      can: dev: can_get_ctrlmode_str: use capitalized ctrlmode strings
      can: dev: can_dev_dropped_skb: drop CC/FD frames in CANXL-only mode
      can: raw: instantly reject unsupported CAN frames
      can: dev: print bitrate error with two decimal digits

Vincent Mailhol (13):
      can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
      can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
      can: netlink: add CAN_CTRLMODE_RESTRICTED
      can: netlink: add initial CAN XL support
      can: netlink: add CAN_CTRLMODE_XL_TMS flag
      can: bittiming: add PWM parameters
      can: bittiming: add PWM validation
      can: calc_bittiming: add PWM calculation
      can: netlink: add PWM netlink interface
      can: calc_bittiming: replace misleading "nominal" by "reference"
      can: calc_bittiming: add can_calc_sample_point_nrz()
      can: calc_bittiming: add can_calc_sample_point_pwm()
      can: add dummy_can driver

 .../bindings/net/can/microchip,mpfs-can.yaml       |   5 +
 MAINTAINERS                                        |   8 +-
 drivers/net/can/Kconfig                            |  17 ++
 drivers/net/can/Makefile                           |   1 +
 drivers/net/can/dev/bittiming.c                    |  63 ++++
 drivers/net/can/dev/calc_bittiming.c               | 114 ++++++--
 drivers/net/can/dev/dev.c                          |  42 ++-
 drivers/net/can/dev/netlink.c                      | 319 +++++++++++++++++++--
 drivers/net/can/dummy_can.c                        | 285 ++++++++++++++++++
 drivers/net/can/rcar/rcar_canfd.c                  | 246 +++++++++++-----
 include/linux/can/bittiming.h                      |  81 +++++-
 include/linux/can/dev.h                            |  68 +++--
 include/uapi/linux/can/netlink.h                   |  34 +++
 net/can/raw.c                                      |  54 +++-
 14 files changed, 1166 insertions(+), 171 deletions(-)
 create mode 100644 drivers/net/can/dummy_can.c

