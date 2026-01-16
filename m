Return-Path: <linux-can+bounces-6193-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B95D3865F
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 21:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 215923005EB9
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE1B31D371;
	Fri, 16 Jan 2026 20:03:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65312222D0
	for <linux-can@vger.kernel.org>; Fri, 16 Jan 2026 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768593814; cv=none; b=S3olVgimYtvPrOJMDW6mksZS2LXYi9gT7hvhd1y8CoSP9eCHzfugz2oY/veRNDlQfiSJfHLUEMaS11xuFS2V6LUBeggJD9ztuWv6Eq3KQTcMbVkjV5b7vFbSITGCzQUTtjOicpa9gjB3Nq39lssgUY4JDLopN2NeHMTactzK35M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768593814; c=relaxed/simple;
	bh=Kg/HL0DIcEo6Kdm/4d/Ulff5pRm6FkGEjw2pz5OC22Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cm56JdwveUpHaxJ9iRCRDxZDtOH1WKAX6YHMjqDr7UKpnil+cVA7FI+PCGQuIU6gf4f5iQHEZy+6jvA4wMLnTq5due0vbWqYSb8kzu6ZvvhUpq26cUlPTY+jhIyr/sMQ2UF3LPe1jVXZHEGdvGhdzKQlJz8f/r0iJ0vorfC27Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgq2Z-00049A-IG; Fri, 16 Jan 2026 21:03:27 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgq2Z-000yMQ-2O;
	Fri, 16 Jan 2026 21:03:27 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CBA544CEF6D;
	Fri, 16 Jan 2026 20:03:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/7] pull-request: can 2026-01-16
Date: Fri, 16 Jan 2026 20:55:46 +0100
Message-ID: <20260116200323.366877-1-mkl@pengutronix.de>
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

this is a pull request of 7 patches for net/main.

The first patch is by me and sets the missing CAN device default
capabilities in the CAN device layer.

The next patch is by me, target the gs_usb driver and adds the missing
unanchor URB on usb_submit_urb() error.

The last 5 patches are also from me and fix the same USB-URB leak (as
in the gs_usb driver) in the affected CAN-USB driver: ems_usb,
esd_usb, kvaser_usb, mcba_usb and usb_8dev.

regards,
Marc

---

The following changes since commit a74c7a58ca2ca1cbb93f4c01421cf24b8642b962:

  net: freescale: ucc_geth: Return early when TBI PHY can't be found (2026-01-15 20:04:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.19-20260116

for you to fetch changes up to 70458a363d7cf1a6b019685d44ad5932264f8a29:

  Merge patch series "can: usb: fix URB memory leaks" (2026-01-16 20:41:17 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.19-20260116

----------------------------------------------------------------
Marc Kleine-Budde (8):
      can: dev: alloc_candev_mqs(): add missing default CAN capabilities
      can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb() error
      can: ems_usb: ems_usb_read_bulk_callback(): fix URB memory leak
      can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory leak
      can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix URB memory leak
      can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB memory leak
      can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB memory leak
      Merge patch series "can: usb: fix URB memory leaks"

 drivers/net/can/dev/dev.c                        | 1 +
 drivers/net/can/usb/ems_usb.c                    | 8 +++++++-
 drivers/net/can/usb/esd_usb.c                    | 9 ++++++++-
 drivers/net/can/usb/gs_usb.c                     | 7 +++++++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 9 ++++++++-
 drivers/net/can/usb/mcba_usb.c                   | 8 +++++++-
 drivers/net/can/usb/usb_8dev.c                   | 8 +++++++-
 7 files changed, 45 insertions(+), 5 deletions(-)

