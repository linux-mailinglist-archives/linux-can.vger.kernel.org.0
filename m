Return-Path: <linux-can+bounces-1127-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611FD948A64
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 09:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B941C230EB
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 07:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D47A1BC9FC;
	Tue,  6 Aug 2024 07:47:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00B13C909
	for <linux-can@vger.kernel.org>; Tue,  6 Aug 2024 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930465; cv=none; b=k7wD3/RyZQ+kW1ce77UL3QuJzYTcDxzs6cht43AOmhqzq2Yn0XstFbg9vPRLGz5gRoekggLoJ1X+qk74JCDZf4WZpoGt0clZ4SMF2JGevqFOPJaxlg9Jmju4BpK8E/krDicFVdKvqgWRv2v2t7vQiWYgo224PFTWaDBY4ngm4vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930465; c=relaxed/simple;
	bh=Da3kVtIjlALHgMjCzc1vZivGXeRyeYrKqXkq3NEXIUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qrRI3rzZg55M41LCdy0ybAulnNHhpQ8gaXMrP0ShsJIpHn6JMsCEHurUW5ZxbE4DKKzX4P5/2gKZ/MNz1k3nNrkbXaEYlVYUne9mClO8tIVXuCjaYXgPS/sA7qUrKo+qc03MFNCom2VGi4SiDzmlwaZ3MU6fwwKuyKr1I669Hh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEut-00041U-96
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:35 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEus-004toZ-Ov
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 74E61317986
	for <linux-can@vger.kernel.org>; Tue, 06 Aug 2024 07:47:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 7E23031796B;
	Tue, 06 Aug 2024 07:47:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ce9302f2;
	Tue, 6 Aug 2024 07:47:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/20] pull-request: can-next 2024-08-06
Date: Tue,  6 Aug 2024 09:41:51 +0200
Message-ID: <20240806074731.1905378-1-mkl@pengutronix.de>
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

this is a pull request of 20 patches for net-next/master.

The first patch is by Frank Li and adds the can-transceiver property
to the flexcan device-tree bindings.

Haibo Chen contributes 2 patches for the flexcan driver to add wakeup
support for the imx95.

The 2 patches by Stefan Mätje for the esd_402_pci driver clean up the
driver and add support for the one-shot mode.

The last 15 patches are by Jimmy Assarsson and add hardware timestamp
support for all devices covered by the kvaser_usb driver.

regards,
Marc

---
The following changes since commit 3608d6aca5e793958462e6e01a8cdb6c6e8088d0:

  Merge branch 'dsa-en7581' into main (2024-08-04 15:22:31 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.12-20240806

for you to fetch changes up to fa3c40b9d540948884a7ae2205c247729e9f9f8f:

  Merge patch series "can: kvaser_usb: Add hardware timestamp support to all devices" (2024-08-05 17:39:05 +0200)

----------------------------------------------------------------
linux-can-next-for-6.12-20240806

----------------------------------------------------------------
Frank Li (1):
      dt-bindings: can: fsl,flexcan: add common 'can-transceiver' for fsl,flexcan

Haibo Chen (2):
      dt-bindings: can: fsl,flexcan: move fsl,imx95-flexcan standalone
      can: flexcan: add wakeup support for imx95

Jimmy Assarsson (15):
      can: kvaser_usb: Add helper functions to convert device timestamp into ktime
      can: kvaser_usb: hydra: kvaser_usb_hydra_ktime_from_rx_cmd: Drop {rx_} in function name
      can: kvaser_usb: hydra: Add struct for Tx ACK commands
      can: kvaser_usb: hydra: Set hardware timestamp on transmitted packets
      can: kvaser_usb: leaf: Add struct for Tx ACK commands
      can: kvaser_usb: leaf: Assign correct timestamp_freq for kvaser_usb_leaf_imx_dev_cfg_{16,24,32}mhz
      can: kvaser_usb: leaf: Replace kvaser_usb_leaf_m32c_dev_cfg with kvaser_usb_leaf_m32c_dev_cfg_{16,24,32}mhz
      can: kvaser_usb: leaf: kvaser_usb_leaf_tx_acknowledge: Rename local variable
      can: kvaser_usb: leaf: Add hardware timestamp support to leaf based devices
      can: kvaser_usb: leaf: Add structs for Tx ACK and clock overflow commands
      can: kvaser_usb: leaf: Store MSB of timestamp
      can: kvaser_usb: leaf: Add hardware timestamp support to usbcan devices
      can: kvaser_usb: Remove KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP
      can: kvaser_usb: Remove struct variables kvaser_usb_{ethtool,netdev}_ops
      can: kvaser_usb: Rename kvaser_usb_{ethtool,netdev}_ops_hwts to kvaser_usb_{ethtool,netdev}_ops

Marc Kleine-Budde (3):
      Merge patch series "can: fsl,flexcan: add imx95 wakeup"
      Merge patch series "can: esd_402_pci: Do cleanup; Add one-shot mode"
      Merge patch series "can: kvaser_usb: Add hardware timestamp support to all devices"

Stefan Mätje (2):
      can: esd_402_pci: Rename esdACC CTRL register macros
      can: esd_402_pci: Add support for one-shot mode

 .../devicetree/bindings/net/can/fsl,flexcan.yaml   |   8 +-
 drivers/net/can/esd/esd_402_pci-core.c             |   5 +-
 drivers/net/can/esd/esdacc.c                       |  55 +++++-----
 drivers/net/can/esd/esdacc.h                       |  36 ++++---
 drivers/net/can/flexcan/flexcan-core.c             |  50 +++++++--
 drivers/net/can/flexcan/flexcan.h                  |   2 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h        |  26 ++++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |  21 +---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  |  41 +++++---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   | 114 ++++++++++++++++++---
 10 files changed, 255 insertions(+), 103 deletions(-)


