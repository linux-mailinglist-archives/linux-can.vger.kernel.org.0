Return-Path: <linux-can+bounces-1481-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 247569763EB
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 10:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9625EB21045
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 08:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC10189B88;
	Thu, 12 Sep 2024 08:06:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695818F2DD
	for <linux-can@vger.kernel.org>; Thu, 12 Sep 2024 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128376; cv=none; b=WECcLVHj7bsP0Vb9UiC+VHTsSt4Q49awKcDuiVKXBp/L6NtLEWESZX8wboPqZRoRhPLXQgYsh/NMk2zsCGpTxLBu/oBuiySP0aaFEDKdIuxFxdLSQMcUpBRPy5k21/PpvXmfXufeU0eL1PGo64luyERdP+zHPDz6IwD+G5oMrM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128376; c=relaxed/simple;
	bh=Y1+lzNAoIYOBrI8kuq5jm2NZrMM2pB0inmdyMbuhvkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K0Dr5dxRJDM6Df7tnB/mPKND7aya3AFMzXolgN4U9q6dUp7tZYd4lch8N6/0siIE6g484emYeS+U9x4uNu8B5XTUomXV+HVDzXWmivJHU5eJPENioh44MAO+HvKQXDqBJEZGd2DRMvrDbN0dGEb9cx3W0Dilb3gyAsEcAiauxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq7-00048F-F6
	for linux-can@vger.kernel.org; Thu, 12 Sep 2024 10:06:07 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq6-007Kfd-GV
	for linux-can@vger.kernel.org; Thu, 12 Sep 2024 10:06:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 25A88338E22
	for <linux-can@vger.kernel.org>; Thu, 12 Sep 2024 07:58:07 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 32577338E04;
	Thu, 12 Sep 2024 07:58:06 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f00a1166;
	Thu, 12 Sep 2024 07:58:05 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/5] pull-request: can 2024-09-12
Date: Thu, 12 Sep 2024 09:50:49 +0200
Message-ID: <20240912075804.2825408-1-mkl@pengutronix.de>
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

this is a pull request of 5 patches for net/master.

Kuniyuki Iwashima's patch fixes an incomplete bug fix in the CAN BCM
protocol, which was introduced during v6.11.

A patch by Stefan Mätje removes the unsupported CAN_CTRLMODE_3_SAMPLES
mode for CAN-USB/3-FD devices in the esd_usb driver.

The next patch is by Martin Jocic and enables 64-bit DMA addressing
for the kvaser_pciefd driver.

The last two patches both affect the m_can driver. Jake Hamby's patch
activates NAPI before interrupts are activated, a patch by me moves
the stopping of the clock after the device has been shut down.

regards,
Marc

---

The following changes since commit 6513eb3d3191574b58859ef2d6dc26c0277c6f81:

  net: tighten bad gso csum offset check in virtio_net_hdr (2024-09-11 20:43:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.11-20240912

for you to fetch changes up to 717338e2b23309470e218f0c58177ece62b8d458:

  Merge patch series "can: m_can: fix struct net_device_ops::{open,stop} callbacks under high bus load" (2024-09-12 09:47:36 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.11-20240912

----------------------------------------------------------------
Jake Hamby (1):
      can: m_can: enable NAPI before enabling interrupts

Kuniyuki Iwashima (1):
      can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().

Marc Kleine-Budde (2):
      can: m_can: m_can_close(): stop clocks after device has been shut down
      Merge patch series "can: m_can: fix struct net_device_ops::{open,stop} callbacks under high bus load"

Martin Jocic (1):
      can: kvaser_pciefd: Enable 64-bit DMA addressing

Stefan Mätje (1):
      can: esd_usb: Remove CAN_CTRLMODE_3_SAMPLES for CAN-USB/3-FD

 drivers/net/can/kvaser_pciefd.c |  3 +++
 drivers/net/can/m_can/m_can.c   | 14 +++++++-------
 drivers/net/can/usb/esd_usb.c   |  6 +-----
 net/can/bcm.c                   |  4 +++-
 4 files changed, 14 insertions(+), 13 deletions(-)


