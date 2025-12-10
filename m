Return-Path: <linux-can+bounces-5837-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4711CB26E0
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 09:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3761D302D4C1
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D511B306490;
	Wed, 10 Dec 2025 08:34:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C34922578D
	for <linux-can@vger.kernel.org>; Wed, 10 Dec 2025 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765355697; cv=none; b=riAPLFED+NoCMRj9uvp2++vG/m6cPuj3fuBSL87+BC3y91VYwJ+qtgiHg7uYKkORY9TTOmgpbI5DH292hRFShkA7j5TMeVHKF5xg4j19MGEH+2l2KGroVxFk+g3E+QfB9+YWIU0TaZZhSen4k/uSorYmqgSnNMYh4EBGDGScNgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765355697; c=relaxed/simple;
	bh=y2rpGwsg8I3wMX4m0DRN6Qta/4zB9uRoDvZ6Mb2z6l0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJ8NSXkNEOf8BEsa5/PLMkgbzakJTgt9weQub6Z0/fFtT3lH8tsRnr7gwVay3WN6Izp5lij9oGppXSHrJtfjbSVfWaB79ln1hHQnf6PWsViBd2AriAD1shzZB/ZGLc725qlOGwck20AWqA553b88goMDNfyd9vPjNENUO3cHtRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vTFet-0007fX-N0; Wed, 10 Dec 2025 09:34:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vTFes-004vMg-23;
	Wed, 10 Dec 2025 09:34:50 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 564AB4B3B23;
	Wed, 10 Dec 2025 08:34:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/2] pull-request: can 2025-12-10
Date: Wed, 10 Dec 2025 09:32:22 +0100
Message-ID: <20251210083448.2116869-1-mkl@pengutronix.de>
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

this is a pull request of 2 patches for net/main.

Arnd Bergmann's patch fixes a build dependency with the CAN protocols
and drivers introduced in the current development cycle.

The last patch is by me and fixes the error handling cleanup in the
gs_usb driver.

regards,
Marc

---

The following changes since commit 186468c67fc687650b7fb713d8c627d5c8566886:

  Merge branch 'mptcp-misc-fixes-for-v6-19-rc1' (2025-12-08 23:54:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.19-20251210

for you to fetch changes up to 3e54d3b4a8437b6783d4145c86962a2aa51022f3:

  can: gs_usb: gs_can_open(): fix error handling (2025-12-10 09:30:31 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.19-20251210

----------------------------------------------------------------
Arnd Bergmann (1):
      can: fix build dependency

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_open(): fix error handling

 drivers/net/can/Kconfig      | 5 +----
 drivers/net/can/Makefile     | 2 +-
 drivers/net/can/dev/Makefile | 5 ++---
 drivers/net/can/usb/gs_usb.c | 2 +-
 net/can/Kconfig              | 1 -
 5 files changed, 5 insertions(+), 10 deletions(-)

