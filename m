Return-Path: <linux-can+bounces-1492-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72D1976403
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 10:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C5F285156
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 08:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FB719047C;
	Thu, 12 Sep 2024 08:06:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537EE190662
	for <linux-can@vger.kernel.org>; Thu, 12 Sep 2024 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128380; cv=none; b=iB6PCr8r69H294y5M86KQR42+lT1TzOqNe+54x1ESlLnTu4h2lFF4PPuaKeirLKkJkFC46yVPTzSm25ubS3V+0j2tm0ww8zN3iorm/aaCzbXJDGyWMe68guDi0oYwgC3OGouodJ0DzbGPf5VcS9UzphF/8gMRusIekMMqxpvBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128380; c=relaxed/simple;
	bh=WZMML2dcit81DVLLfLkTDi0dS2kAPXeGIKMnSp70kcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FXgpm3XJ27BbcKR1cDSZMKHpPlU3CaKxN+hB3DlOoXKfQ2vd0999P4BPYMNOpsDaWJH9hqL7XOwuvuKOm5MN4JehtkhL5Mdk09uUS1jnTvHMOV3a0IimBuGZphGmWCF0OENIdvjhXzVjkzl+HUieRtVomHk6VZGvTcJ98N3kD+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeqA-0004AF-2D
	for linux-can@vger.kernel.org; Thu, 12 Sep 2024 10:06:10 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq7-007Khl-MA
	for linux-can@vger.kernel.org; Thu, 12 Sep 2024 10:06:07 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A69C1338EBF
	for <linux-can@vger.kernel.org>; Thu, 12 Sep 2024 08:04:41 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id AFF5B338E9E;
	Thu, 12 Sep 2024 08:04:40 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 513e8c4a;
	Thu, 12 Sep 2024 08:04:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/5] pull-request: can-next 2024-09-11
Date: Thu, 12 Sep 2024 09:58:57 +0200
Message-ID: <20240912080438.2826895-1-mkl@pengutronix.de>
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

this is a pull request of 5 patches for net-next/master.

The first patch is by Uwe Kleine-König targets all CAN platform driver
and switches back the remove function to struct
platform_driver::remove().

A patch by Stefan Mätje fixes the help text of the ESD USB driver.

Jake Hamby's patch masks an unneeded interrupt in the m_can driver.

The last 2 patches target the rockchip_canfd driver. Arnd Bergmann's
patch reworks the delay calculation for the timekeeping worker, a
patch by me fixes the decoding of the error code register.

regards,
Marc

---

The following changes since commit f3b6129b7d252b2fbdcac2e0005abc6804dc287c:

  Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue (2024-09-10 20:05:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.12-20240911

for you to fetch changes up to 2b2a9a08f8f0b904ea2bc61db3374421b0f944a6:

  Merge patch series "can: rockchip_canfd: rework delay calculation and decoding of error code register" (2024-09-11 10:58:28 +0200)

----------------------------------------------------------------
linux-can-next-for-6.12-20240911

----------------------------------------------------------------
Arnd Bergmann (1):
      can: rockchip_canfd: rkcanfd_timestamp_init(): rework delay calculation

Jake Hamby (1):
      can: m_can: m_can_chip_config(): mask timestamp wraparound IRQ

Marc Kleine-Budde (2):
      can: rockchip_canfd: rkcanfd_handle_error_int_reg_ec(): fix decoding of error code register
      Merge patch series "can: rockchip_canfd: rework delay calculation and decoding of error code register"

Stefan Mätje (1):
      can: usb: Kconfig: Fix list of devices for esd_usb driver

Uwe Kleine-König (1):
      can: Switch back to struct platform_driver::remove()

 drivers/net/can/at91_can.c                          | 2 +-
 drivers/net/can/bxcan.c                             | 2 +-
 drivers/net/can/c_can/c_can_platform.c              | 2 +-
 drivers/net/can/cc770/cc770_isa.c                   | 2 +-
 drivers/net/can/cc770/cc770_platform.c              | 2 +-
 drivers/net/can/ctucanfd/ctucanfd_platform.c        | 2 +-
 drivers/net/can/flexcan/flexcan-core.c              | 2 +-
 drivers/net/can/grcan.c                             | 2 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c               | 2 +-
 drivers/net/can/janz-ican3.c                        | 2 +-
 drivers/net/can/m_can/m_can.c                       | 3 ++-
 drivers/net/can/m_can/m_can_platform.c              | 2 +-
 drivers/net/can/mscan/mpc5xxx_can.c                 | 2 +-
 drivers/net/can/rcar/rcar_can.c                     | 2 +-
 drivers/net/can/rcar/rcar_canfd.c                   | 2 +-
 drivers/net/can/rockchip/rockchip_canfd-core.c      | 4 +---
 drivers/net/can/rockchip/rockchip_canfd-timestamp.c | 4 ++--
 drivers/net/can/sja1000/sja1000_isa.c               | 2 +-
 drivers/net/can/sja1000/sja1000_platform.c          | 2 +-
 drivers/net/can/softing/softing_main.c              | 2 +-
 drivers/net/can/sun4i_can.c                         | 2 +-
 drivers/net/can/ti_hecc.c                           | 2 +-
 drivers/net/can/usb/Kconfig                         | 3 ++-
 drivers/net/can/xilinx_can.c                        | 2 +-
 24 files changed, 27 insertions(+), 27 deletions(-)


