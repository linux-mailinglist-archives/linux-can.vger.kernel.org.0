Return-Path: <linux-can+bounces-4883-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A60DB94D3C
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37BE37B4D4B
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D263164CB;
	Tue, 23 Sep 2025 07:42:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8763A316194
	for <linux-can@vger.kernel.org>; Tue, 23 Sep 2025 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613377; cv=none; b=mgrkwuK+H4upyghBianIg+HdBnKrAfjSw4pwF/VLOWPOeXR2BpR3mM9PWNwjjVZHpA2xYULffAglGoXKbh+kM9xGvgR2Ofe1gr8bR8nCoRzQhg640jVatTE+W2AfsnFGm/nqfCMhHYMyWvKjiDuHJZ4vM7S7YCcKS1VYtbPFg50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613377; c=relaxed/simple;
	bh=7+xUfCB1aKwd8F9tPQYDfPP0+KThw87QTnZkmMsFrCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ad1FD70X8uVs0WJb++zUjvD0bC9pAkl1lmz9BkbaZCmXbwC6qGUGrsv1Oa8G2ReS0vHXT2pEmYZjDyH/BDr0skuebaw5TRYk4t0PI5/4Dk1Ukf9UvuzsVIJWZ3fNSUqSWSUAMjx95ywsBE/OVt9BhFRLVvVZRCDPO0sAu7MZVgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0xfg-0003ck-QX; Tue, 23 Sep 2025 09:42:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0xff-0003Nb-3D;
	Tue, 23 Sep 2025 09:42:44 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 94B19477A82;
	Tue, 23 Sep 2025 07:34:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/7] pull-request: can 2025-09-23
Date: Tue, 23 Sep 2025 09:32:46 +0200
Message-ID: <20250923073427.493034-1-mkl@pengutronix.de>
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

this is a pull request of 7 patches for net/main.

The 1st patch is by Chen Yufeng and fixes a potential NULL pointer
deref in the hi311x driver.

Duy Nguyen contributes a patch for the rcar_canfd driver to fix the
controller mode setting.

The next 4 patches are by Vincent Mailhol and populate the
ndo_change_mtu(( callback in the etas_es58x, hi311x, sun4i_can and
mcba_usb driver to prevent buffer overflows.

Stéphane Grosjean's patch for the peak_usb driver fixes a
shift-out-of-bounds issue.

regards,
Marc

---

The following changes since commit cbf658dd09419f1ef9de11b9604e950bdd5c170b:

  Merge tag 'net-6.17-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-18 10:22:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.17-20250923

for you to fetch changes up to c443be70aaee42c2d1d251e0329e0a69dd96ae54:

  can: peak_usb: fix shift-out-of-bounds issue (2025-09-19 19:17:37 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.17-20250923

----------------------------------------------------------------
Chen Yufeng (1):
      can: hi311x: fix null pointer dereference when resuming from sleep before interface was enabled

Duy Nguyen (1):
      can: rcar_canfd: Fix controller mode setting

Marc Kleine-Budde (1):
      Merge patch series "can: populate ndo_change_mtu() to prevent buffer overflow"

Stéphane Grosjean (1):
      can: peak_usb: fix shift-out-of-bounds issue

Vincent Mailhol (4):
      can: etas_es58x: populate ndo_change_mtu() to prevent buffer overflow
      can: hi311x: populate ndo_change_mtu() to prevent buffer overflow
      can: sun4i_can: populate ndo_change_mtu() to prevent buffer overflow
      can: mcba_usb: populate ndo_change_mtu() to prevent buffer overflow

 drivers/net/can/rcar/rcar_canfd.c            |  7 +++---
 drivers/net/can/spi/hi311x.c                 | 34 +++++++++++++++-------------
 drivers/net/can/sun4i_can.c                  |  1 +
 drivers/net/can/usb/etas_es58x/es58x_core.c  |  3 ++-
 drivers/net/can/usb/mcba_usb.c               |  1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  2 +-
 6 files changed, 27 insertions(+), 21 deletions(-)

