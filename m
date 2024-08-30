Return-Path: <linux-can+bounces-1270-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5250C966B63
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 23:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA10F1F22FB6
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 21:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C11BF800;
	Fri, 30 Aug 2024 21:44:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54743175D5E
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054258; cv=none; b=afCKIKbw4uTAab2hEfgnNSZlcpAfQ+7sIX6+FvDnIZkSww2yD9lwTJ4cTNS8/FF3cIaq75aN7B7zJTdmWShlUrp8Ap+EpMMU9G1M96xd7oFQbuZWmczQYjwpi5OSM6qE0K/yRDhxeWE8SDW2dstJ1FNRCkU8VD0V+076FEuf7JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054258; c=relaxed/simple;
	bh=SYSPKd1FX3isAQY6cZ0XVJ9SBnBlfCy0OA0fZkaxGVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ntUNHXSFZDc2N9bB+ZPjABY3NTsmC/F5YUxEOXhZcce1M2wIopdPqkU82GTTNo8H/mOvsftvWg8Ygyf3AuwN3AFCxouxq+nZz1GQEY5ux+YuxDm9IgyjeDaH9LGx2CiGsljfNmRQCz7H284boRzf+uGpIMt1Liu1xZfohNiajI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9Ph-0002ab-Fa
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:44:13 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9Ph-004FLw-01
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:44:13 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B13AA32E461
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:44:12 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B86FD32E44E;
	Fri, 30 Aug 2024 21:44:11 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f2fabb05;
	Fri, 30 Aug 2024 21:44:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/6] pull-request: can-next 2024-08-30
Date: Fri, 30 Aug 2024 23:34:33 +0200
Message-ID: <20240830214406.1605786-1-mkl@pengutronix.de>
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

this is a pull request of 6 patches for net-next/master.

The first patch is by Duy Nguyen and document the R-Car V4M support in
the rcar-canfd DT bindings.

Frank Li's patch converts the microchip,mcp251x.txt DT bindings
documentation to yaml.

A patch by Zhang Changzhong update a comment in the j1939 CAN
networking stack.

Stefan Mätje's patch updates the CAN configuration netlink code, so
that the bit timing calculation doesn't work on stale
can_priv::ctrlmode data.

Martin Jocic contributes a patch for the kvaser_pciefd driver to
convert some ifdefs into if (IS_ENABLED()).

The last patch is by Yan Zhen and simplifies the probe() function of
the kvaser USB driver by using dev_err_probe().

regards,
Marc

---


The following changes since commit cff69f72d33318f4ccfe7d5ff6c5616d00dd45a7:

  ethtool: pse-pd: move pse validation into set (2024-08-30 12:14:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.12-20240830

for you to fetch changes up to 0315c0b5ed253853a7b07dc97487522345110548:

  can: kvaser_usb: Simplify with dev_err_probe() (2024-08-30 22:40:23 +0200)

----------------------------------------------------------------
linux-can-next-for-6.12-20240830

----------------------------------------------------------------
Duy Nguyen (1):
      dt-bindings: can: renesas,rcar-canfd: Document R-Car V4M support

Frank Li (1):
      dt-bindings: can: convert microchip,mcp251x.txt to yaml

Martin Jocic (1):
      can: kvaser_pciefd: Use IS_ENABLED() instead of #ifdef

Stefan Mätje (1):
      can: netlink: avoid call to do_set_data_bittiming callback with stale can_priv::ctrlmode

Yan Zhen (1):
      can: kvaser_usb: Simplify with dev_err_probe()

Zhang Changzhong (1):
      can: j1939: use correct function name in comment

 .../bindings/net/can/microchip,mcp2510.yaml        |  70 ++++++++++++++
 .../bindings/net/can/microchip,mcp251x.txt         |  30 ------
 .../bindings/net/can/renesas,rcar-canfd.yaml       |  22 +++--
 drivers/net/can/dev/netlink.c                      | 102 ++++++++++-----------
 drivers/net/can/kvaser_pciefd.c                    |  26 +++---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |  42 ++++-----
 net/can/j1939/transport.c                          |   8 +-
 7 files changed, 170 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt


