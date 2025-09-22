Return-Path: <linux-can+bounces-4783-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A96B8FEBF
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 12:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A8A3A396A
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9993C2F39BC;
	Mon, 22 Sep 2025 10:09:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A12AEE4
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535762; cv=none; b=DIe9H0l0++wOKswxeJjfoxR7GsKYzG86O3bfnqORXujx4AeSB/5/ccHTWa1T8X5CmlybAnxFsHR8lO1QUpT1zh3XsczKDrbeLkvFaqGrhyrs6Pj6VzNtyVwNwGKaUYCybayQPbmUWv10d+/i5nXOK+vbFMe6LH7oR04YCRK+lyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535762; c=relaxed/simple;
	bh=bw+WqNchB4ZjZUhbZqcZCfGidO11HCSigkll0DOet6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MxKD+vmvz+FmU4PBEjDKxNX6NegNZHVGIHx0koGqBOFpgDhNzey188gwRih8wfT9HFkzux2ZSaNoDOkfHraMEiJlyXE+Yf4kvGoCihG4YwNXupFg4hbIHPwH82l5hKx+qRSiVWsfATQZelA83wkdYLZjxGTspyquLzplSeQOjwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0dTy-0006tx-MR
	for linux-can@vger.kernel.org; Mon, 22 Sep 2025 12:09:18 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0dTy-002ZTd-0k
	for linux-can@vger.kernel.org;
	Mon, 22 Sep 2025 12:09:18 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D61F4476CF4
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 10:09:17 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B0C76476CDB;
	Mon, 22 Sep 2025 10:09:16 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 524a53d0;
	Mon, 22 Sep 2025 10:09:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/10] pull-request: can 2025-09-22
Date: Mon, 22 Sep 2025 12:07:30 +0200
Message-ID: <20250922100913.392916-1-mkl@pengutronix.de>
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

this is a pull request of 10 patches for net/main.

The 1st patch is by Chen Yufeng and fixes a potential NULL pointer
deref in the hi311x driver.

Duy Nguyen contributes a patch for the rcar_canfd driver to fix the
controller mode setting.

The next 4 patches are by Vincent Mailhol and populate the
ndo_change_mtu(( callback in the etas_es58x, hi311x, sun4i_can and
mcba_usb driver to prevent buffer overflows.

Stéphane Grosjean's patch for the peak_usb driver fixes a
shift-out-of-bounds issue.

The last 3 patches are by Stefan Mätje and fix the version detection
and TX handling of the esd_usb driver.

regards,
Marc

---

The following changes since commit cbf658dd09419f1ef9de11b9604e950bdd5c170b:

  Merge tag 'net-6.17-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-09-18 10:22:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.17-20250922

for you to fetch changes up to 0141811a10a0116e00ece2d0181f8eb8788ce054:

  Merge patch series "can: esd_usb: fixes" (2025-09-22 12:05:14 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.17-20250922

----------------------------------------------------------------
Chen Yufeng (1):
      can: hi311x: fix null pointer dereference when resuming from sleep before interface was enabled

Duy Nguyen (1):
      can: rcar_canfd: Fix controller mode setting

Marc Kleine-Budde (2):
      Merge patch series "can: populate ndo_change_mtu() to prevent buffer overflow"
      Merge patch series "can: esd_usb: fixes"

Stefan Mätje (3):
      can: esd_usb: Fix not detecting version reply in probe routine
      can: esd_usb: Fix handling of TX context objects
      can: esd_usb: Add watermark handling for TX jobs

Stéphane Grosjean (1):
      can: peak_usb: fix shift-out-of-bounds issue

Vincent Mailhol (4):
      can: etas_es58x: populate ndo_change_mtu() to prevent buffer overflow
      can: hi311x: populate ndo_change_mtu() to prevent buffer overflow
      can: sun4i_can: populate ndo_change_mtu() to prevent buffer overflow
      can: mcba_usb: populate ndo_change_mtu() to prevent buffer overflow

 drivers/net/can/rcar/rcar_canfd.c            |   7 +-
 drivers/net/can/spi/hi311x.c                 |  34 +++---
 drivers/net/can/sun4i_can.c                  |   1 +
 drivers/net/can/usb/esd_usb.c                | 174 ++++++++++++++++++++-------
 drivers/net/can/usb/etas_es58x/es58x_core.c  |   3 +-
 drivers/net/can/usb/mcba_usb.c               |   1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |   2 +-
 7 files changed, 155 insertions(+), 67 deletions(-)


