Return-Path: <linux-can+bounces-6078-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3177ED0A819
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 14:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3385E300500E
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A415135CB80;
	Fri,  9 Jan 2026 13:53:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3076C335BCD
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767966802; cv=none; b=hhG3pNikfXbFE8xnD996mIQupVjXumDQqasrp9n2eO1IN9VVcXc43WYGRoHMdxK9hmEFnpsSwAUyU+njKilZ7sJPWi+uiNQCPlclz8ttcPQAXCLJd1d3i+FdbbC1hHpOUizNsSftW7pnfSW4JUXlxWJ/ITVoLwL39O2bIZisrFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767966802; c=relaxed/simple;
	bh=sGqrxt7zRG0LJG7mo5vOXYADyr1bptC07ZO4l+9SEgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRmllY99XKf3Foyt76HZsX2f3S3IfIMAwbgCDv1dpK3Euh0IvlKpblydN2CrZFZYGhSXxTukc5uZFSi4mOoJi5VKrdQTetLydHev8xpU6suVe9/NFsFmh/ZX9usw+l5M/8BHq8EdQbjeXZ2Z2le4RFJbTWgQ3KZMfmuSQvW23Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1veCvU-0002dl-0x; Fri, 09 Jan 2026 14:53:16 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1veCvS-009r4J-2O;
	Fri, 09 Jan 2026 14:53:14 +0100
Received: from blackshift.org (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2E96A4C9996;
	Fri, 09 Jan 2026 13:53:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/3] pull-request: can 2026-01-09
Date: Fri,  9 Jan 2026 14:46:09 +0100
Message-ID: <20260109135311.576033-1-mkl@pengutronix.de>
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

this is a pull request of 3 patches for net/main.

The first patch is by Szymon Wilczek and fixes a potential memory leak
in the etas_es58x driver.

The 2nd patch is by me, targets the gs_usb driver and fixes an URB
memory leak.

Ondrej Ille's patch fixes the transceiver delay compensation in the
ctucanfd driver, which is needed for bit rates higher than 1 Mbit/s.

regards,
Marc

---

The following changes since commit 872ac785e7680dac9ec7f8c5ccd4f667f49d6997:

  ipv4: ip_tunnel: spread netdev_lockdep_set_classes() (2026-01-08 18:02:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.19-20260109

for you to fetch changes up to e707c591a139d1bfa4ddc83036fc820ca006a140:

  can: ctucanfd: fix SSP_SRC in cases when bit-rate is higher than 1 MBit. (2026-01-09 14:26:29 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.19-20260109

----------------------------------------------------------------
Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak

Ondrej Ille (1):
      can: ctucanfd: fix SSP_SRC in cases when bit-rate is higher than 1 MBit.

Szymon Wilczek (1):
      can: etas_es58x: allow partial RX URB allocation to succeed

 drivers/net/can/ctucanfd/ctucanfd_base.c    | 2 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c | 2 +-
 drivers/net/can/usb/gs_usb.c                | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

