Return-Path: <linux-can+bounces-4155-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A4CB12188
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31201CC14CF
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1432EF9B3;
	Fri, 25 Jul 2025 16:13:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECEF1F4CB6
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460016; cv=none; b=Bq1Qp4y7MBspIKzBEp0/n0+LzOUsns2Mi1+8rt97ZdKaQcqaRCwBi0z/ywp8VOxlsYGjydFP8cytkuN1QJcPsg5N/NqHXkJxKF4kXqGTpR/T7pEHMn4gwHCHBW7CR3u93ldI4t6EC0eAz6mvJeloItci7zqS1+4X1uDBjaCHyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460016; c=relaxed/simple;
	bh=j82L5eJM8xAEdPCDnX3eC/lwWwMZcc06Zi4yUAoh3ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m1RK4UiVEuCqt1P0RwPqT668nWuEXC+dMM4EPFvpCaopiFnmZ82ly4Zi+JwqqesY4X2kkyw3Vq005BxPb9Upts23njaaZzgCG6A7OfwWRUgHjt55ZpNlvdZhJfZkCcBI4zX/hdPvyWQXad6m5A29Bs2FePAd2UP6S1xcWeA2J9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL35-0006TT-7K
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 18:13:31 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL34-00AFUB-35
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:30 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A3222449821
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B4DFC449805;
	Fri, 25 Jul 2025 16:13:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id db26adcb;
	Fri, 25 Jul 2025 16:13:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/27] pull-request: can-next 2025-07-25
Date: Fri, 25 Jul 2025 18:05:10 +0200
Message-ID: <20250725161327.4165174-1-mkl@pengutronix.de>
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

this is a pull request of 27 patches for net-next/main.

The first patch is by Khaled Elnaggar and converts the janz-ican3
driver's fwinfo_show() to sysfs_emit().

Vincent Mailhol contributes 3 patches that first fix a warning in the
ti_hecc driver and then add missing COMPILE_TEST more compile
coverage to the ti_hecc and tscan1 driver.

Randy Dunlap's patch let's the tscan1 driver depend on PC104.

A patch by Luis Felipe Hernandez fixes a kernel-doc error in the
ctucanfd driver.

Jimmy Assarsson contributes 10 patches for the kvaser_pciefd and 11
for the kvaser_usb driver. Both series simplify the identification of
physical the CAN interfaces and add devlink support to get information
about the running firmware.

regards,
Marc

---

The following changes since commit 06baf9bfa6ca8db7d5f32e12e27d1dc1b7cb3a8a:

  Merge branch 'tcp-receiver-changes' (2025-07-14 18:41:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.17-20250725

for you to fetch changes up to ecd82dfb4ccdfab7ecafcdb02b3b388dbaff4396:

  Merge patch series "can: kvaser_usb: Simplify identification of physical CAN interfaces" (2025-07-25 18:01:25 +0200)

----------------------------------------------------------------
linux-can-next-for-6.17-20250725

----------------------------------------------------------------
Jimmy Assarsson (21):
      can: kvaser_pciefd: Add support to control CAN LEDs on device
      can: kvaser_pciefd: Add support for ethtool set_phys_id()
      can: kvaser_pciefd: Add intermediate variable for device struct in probe()
      can: kvaser_pciefd: Store the different firmware version components in a struct
      can: kvaser_pciefd: Store device channel index
      can: kvaser_pciefd: Split driver into C-file and header-file.
      can: kvaser_pciefd: Add devlink support
      can: kvaser_pciefd: Expose device firmware version via devlink info_get()
      can: kvaser_pciefd: Add devlink port support
      Documentation: devlink: add devlink documentation for the kvaser_pciefd driver
      can: kvaser_usb: Add support to control CAN LEDs on device
      can: kvaser_usb: Add support for ethtool set_phys_id()
      can: kvaser_usb: Assign netdev.dev_port based on device channel index
      can: kvaser_usb: Add intermediate variables
      can: kvaser_usb: Move comment regarding max_tx_urbs
      can: kvaser_usb: Store the different firmware version components in a struct
      can: kvaser_usb: Store additional device information
      can: kvaser_usb: Add devlink support
      can: kvaser_usb: Expose device information via devlink info_get()
      can: kvaser_usb: Add devlink port support
      Documentation: devlink: add devlink documentation for the kvaser_usb driver

Khaled Elnaggar (1):
      can: janz-ican3: use sysfs_emit() in fwinfo_show()

Luis Felipe Hernandez (1):
      docs: Fix kernel-doc error in CAN driver

Marc Kleine-Budde (3):
      Merge patch series "can: Kconfig: add missing COMPILE_TEST"
      Merge patch series "can: kvaser_pciefd: Simplify identification of physical CAN interfaces"
      Merge patch series "can: kvaser_usb: Simplify identification of physical CAN interfaces"

Randy Dunlap (1):
      can: tscan1: CAN_TSCAN1 can depend on PC104

Vincent Mailhol (3):
      can: ti_hecc: fix -Woverflow compiler warning
      can: ti_hecc: Kconfig: add COMPILE_TEST
      can: tscan1: Kconfig: add COMPILE_TEST

 Documentation/networking/devlink/index.rst         |   2 +
 Documentation/networking/devlink/kvaser_pciefd.rst |  24 ++++
 Documentation/networking/devlink/kvaser_usb.rst    |  33 +++++
 drivers/net/can/Kconfig                            |   3 +-
 drivers/net/can/Makefile                           |   2 +-
 drivers/net/can/ctucanfd/ctucanfd_base.c           |  11 +-
 drivers/net/can/janz-ican3.c                       |   2 +-
 drivers/net/can/kvaser_pciefd/Makefile             |   3 +
 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h      |  96 ++++++++++++++
 .../kvaser_pciefd_core.c}                          | 144 ++++++++++-----------
 .../net/can/kvaser_pciefd/kvaser_pciefd_devlink.c  |  60 +++++++++
 drivers/net/can/sja1000/Kconfig                    |   2 +-
 drivers/net/can/ti_hecc.c                          |   2 +-
 drivers/net/can/usb/Kconfig                        |   1 +
 drivers/net/can/usb/kvaser_usb/Makefile            |   2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h        |  33 ++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   | 139 ++++++++++++++------
 .../net/can/usb/kvaser_usb/kvaser_usb_devlink.c    |  87 +++++++++++++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  |  65 +++++++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   |  75 ++++++++++-
 20 files changed, 655 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/networking/devlink/kvaser_pciefd.rst
 create mode 100644 Documentation/networking/devlink/kvaser_usb.rst
 create mode 100644 drivers/net/can/kvaser_pciefd/Makefile
 create mode 100644 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
 rename drivers/net/can/{kvaser_pciefd.c => kvaser_pciefd/kvaser_pciefd_core.c} (96%)
 create mode 100644 drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
 create mode 100644 drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c


