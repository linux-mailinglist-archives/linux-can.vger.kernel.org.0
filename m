Return-Path: <linux-can+bounces-3071-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3999A61208
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92CCD7AB73B
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 13:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0561FF609;
	Fri, 14 Mar 2025 13:09:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766631F4722
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957760; cv=none; b=RmqwQRtvBDvg4qejVnk+SZzVuJYI/PUOUgf0KZpo9p2czifQ7ed2RKefe36FnlFj74c3VI64YrTAD1UL9u9NavaSGfafcVqzG6lfQ1NOLrKmKxHw3TeGbBJp0qwJ0hxaPLj0yciwTZI+SP3PTVWIGmiq8zf48kiRGGf5EJlNK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957760; c=relaxed/simple;
	bh=UdlBpjCL0yOdV5RNuEd50EerxPApVUtnjwjZrYiOxm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uuGPcCJ9s4iSWDxhmqmDR2ykksJvfqKNp4+kMixJG7Q1xlob2y9rPRw4z8vQlUI98KW02rygYJ511e2KmgImm8kRCE3Ok8nHAedgQdZjuBb58dOj4nIMUyu8qqCNdSQZmEt0+3MZsKOL0MG8QDLHwID9XmgR+rkoQGBnAh7UDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt4mp-0007JS-Rr
	for linux-can@vger.kernel.org; Fri, 14 Mar 2025 14:09:15 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt4mp-005hnE-1w
	for linux-can@vger.kernel.org;
	Fri, 14 Mar 2025 14:09:15 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1BD9B3DBB61
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 13:09:15 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id DC7313DBB4B;
	Fri, 14 Mar 2025 13:09:13 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 69402960;
	Fri, 14 Mar 2025 13:09:12 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/6] pull-request: can 2025-03-14
Date: Fri, 14 Mar 2025 14:03:59 +0100
Message-ID: <20250314130909.2890541-1-mkl@pengutronix.de>
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

this is a pull request of 6 patches for net/main.

The first patch is by Vincent Mailhol and fixes an out of bound read
in strscpy() in the ucan driver.

Oliver Hartkopp contributes a patch for the af_can statistics to use
atomic access in the hot path.

The next 2 patches are by Biju Das, target the rcar_canfd driver and
fix the page entries in the AFL list.

The 2 patches by Haibo Chen for the flexcan driver fix the suspend and
resume functions.

regards,
Marc

---

The following changes since commit 4003c9e78778e93188a09d6043a74f7154449d43:

  Merge tag 'net-6.14-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-03-13 07:58:48 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.14-20250314

for you to fetch changes up to 52d48a3d67e9288c6c51589e3a05040f57ccaa89:

  Merge patch series "can: flexcan: only change CAN state when link up in system PM" (2025-03-14 13:26:04 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.14-20250314

----------------------------------------------------------------
Biju Das (2):
      dt-bindings: can: renesas,rcar-canfd: Fix typo in pattern properties for R-Car V4M
      can: rcar_canfd: Fix page entries in the AFL list

Haibo Chen (2):
      can: flexcan: only change CAN state when link up in system PM
      can: flexcan: disable transceiver during system PM

Marc Kleine-Budde (2):
      Merge patch series "R-Car CANFD fixes"
      Merge patch series "can: flexcan: only change CAN state when link up in system PM"

Oliver Hartkopp (1):
      can: statistics: use atomic access in hot path

Vincent Mailhol (1):
      can: ucan: fix out of bound read in strscpy() source

 .../bindings/net/can/renesas,rcar-canfd.yaml       |  2 +-
 drivers/net/can/flexcan/flexcan-core.c             | 18 +++++++--
 drivers/net/can/rcar/rcar_canfd.c                  | 28 ++++++-------
 drivers/net/can/usb/ucan.c                         | 43 +++++++++-----------
 net/can/af_can.c                                   | 12 +++---
 net/can/af_can.h                                   | 12 +++---
 net/can/proc.c                                     | 46 +++++++++++++---------
 7 files changed, 84 insertions(+), 77 deletions(-)


