Return-Path: <linux-can+bounces-5733-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A78B5C8AC33
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 16:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91FF14E27F4
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5527D330D29;
	Wed, 26 Nov 2025 15:57:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06D2FF169
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172644; cv=none; b=nlur+u7EtbrXBQd2bwuOnTRDLscGGCdnoxEgeptWFPRV/1dlqLBhcMbj7SXU4Jx6F1NHJSdv3kGfO+SgylClP4Z8M9hHyr0uU6mxb5rxUGcx0Cvji9cjTZEOZ4VNtCf1ijjs8pyuOJQNm/pd9GZ9V/syTTid25/Tn2tcJ+X9PNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172644; c=relaxed/simple;
	bh=+2IUbJFe90zvO9QyeJeFt5wDFsL5jkdQGMdFqcO7YR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lgjwaU+zYyHRMWF4RFmhigYoUROrg9DyRo/Y815R4sDinA5i63vZOb4PzLRELUPwSmq0Tu65sh0rfpyybcabKmNl67CBzvzVz0S+dw8zCjUCtd7gbDSYLiOOFAzAbbLLv30wEHy/w3kwXuAPWwEqyPJPC6pgO+ZTo7kOnlGM+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOHtO-00064y-Fb; Wed, 26 Nov 2025 16:57:18 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOHtN-002dLc-2g;
	Wed, 26 Nov 2025 16:57:17 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 83BAD4A8E30;
	Wed, 26 Nov 2025 15:57:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/8] pull-request: can 2025-11-26
Date: Wed, 26 Nov 2025 16:41:10 +0100
Message-ID: <20251126155713.217105-1-mkl@pengutronix.de>
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

this is a pull request of 8 patches for net/main.

Seungjin Bae provides a patch for the kvaser_usb driver to fix a
potential infinite loop in the USB data stream command parser.

Thomas Mühlbacher's patch for the sja1000 driver IRQ handler's max
loop handling, that might lead to unhandled interrupts.

3 patches by me for the gs_usb driver fix handling of failed transmit
URBs and add checking of the actual length of received URBs before
accessing the data.

The next patch is by me and is a port of Thomas Mühlbacher's patch
(fix IRQ handler's max loop handling, that might lead to unhandled
interrupts.) to the sun4i_can driver.

Biju Das provides a patch for the rcar_canfd driver to fix the CAN-FD
mode setting.

The last patch is by Shaurya Rane for the em_canid filter to ensure
that the complete CAN frame is present in the linear data buffer
before accessing it.

regards,
Marc

---

The following changes since commit 5442a9da69789741bfda39f34ee7f69552bf0c56:

  veth: more robust handing of race to avoid txq getting stuck (2025-11-14 18:16:53 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.18-20251126

for you to fetch changes up to 0c922106d7a58d106c6a5c52a741ae101cfaf088:

  net/sched: em_canid: fix uninit-value in em_canid_match (2025-11-26 16:28:10 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.18-20251126

----------------------------------------------------------------
Biju Das (1):
      can: rcar_canfd: Fix CAN-FD mode as default

Marc Kleine-Budde (5):
      can: gs_usb: gs_usb_xmit_callback(): fix handling of failed transmitted URBs
      can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing header
      can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing data
      Merge patch series "can: gs_usb: fix USB bulk in and out callbacks"
      can: sun4i_can: sun4i_can_interrupt(): fix max irq loop handling

Seungjin Bae (1):
      can: kvaser_usb: leaf: Fix potential infinite loop in command parsers

Shaurya Rane (1):
      net/sched: em_canid: fix uninit-value in em_canid_match

Thomas Mühlbacher (1):
      can: sja1000: fix max irq loop handling

 drivers/net/can/rcar/rcar_canfd.c                |  53 +++++++-----
 drivers/net/can/sja1000/sja1000.c                |   4 +-
 drivers/net/can/sun4i_can.c                      |   4 +-
 drivers/net/can/usb/gs_usb.c                     | 102 +++++++++++++++++++----
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c |   4 +-
 net/sched/em_canid.c                             |   3 +
 6 files changed, 128 insertions(+), 42 deletions(-)

