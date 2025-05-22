Return-Path: <linux-can+bounces-3632-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDEFAC06EC
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 10:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DF44E3650
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EBC267B1F;
	Thu, 22 May 2025 08:23:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C273221729
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747902237; cv=none; b=bL4do7W/EidMV3mE30cYxmPdrqVplANEnrL+hGEHpQDfV4/McWmSmoXIYjyHd8InkTCAiQAx0q70LDrI9pjW/3exO3w8jsX26OGu0UTzGdcG9+WWD1YTX7qg5elKVVPGeN6Wk/1Qp+mjJ1HzYVMnsGLeZHN6iEKrTeenrfCd3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747902237; c=relaxed/simple;
	bh=0V6LXb62KugowFf1gIo3e2laOPDqvEqJp1sEu3as0aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bd+7ZsjqqGoemn8I3a9FRxnoy+Ijd9w2PDfi11eo1cAwRUyQkxEmXgC5A8ftUTCBUsg5p6HpJKXDii55vGBdcCvJFKZGxeuWGGI7BGKMWGTyGglnx/SH4AhD7fyoJ7b6zuRK2fs2zhJ8mFPOijbluETLIlUCwmXYPVehm5LVOOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1DQ-00028x-3b
	for linux-can@vger.kernel.org; Thu, 22 May 2025 10:23:48 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1DP-000hYE-2v
	for linux-can@vger.kernel.org;
	Thu, 22 May 2025 10:23:47 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8EB294171D7
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:23:47 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 61DB74171D0;
	Thu, 22 May 2025 08:23:46 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c5a9250a;
	Thu, 22 May 2025 08:23:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/4] pull-request: can 2025-05-22
Date: Thu, 22 May 2025 10:01:30 +0200
Message-ID: <20250522082344.490913-1-mkl@pengutronix.de>
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

this is a pull request of 4 patches for net/main.

The first 3 patches are by Axel Forsman and fix a ISR race condition
in the kvaser_pciefd driver.

The last patch is by Carlos Sanchez and fixes the reception of short
error messages in the slcan driver.

regards,
Marc

---

The following changes since commit 9e89db3d847f2d66d2799c5533d00aebee2be4d1:

  Merge tag 'linux-can-fixes-for-6.15-20250520' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can (2025-05-20 15:54:37 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.15-20250521

for you to fetch changes up to ef0841e4cb08754be6cb42bf97739fce5d086e5f:

  can: slcan: allow reception of short error messages (2025-05-21 10:12:05 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.15-20250521

----------------------------------------------------------------
Axel Forsman (3):
      can: kvaser_pciefd: Force IRQ edge in case of nested IRQ
      can: kvaser_pciefd: Fix echo_skb race
      can: kvaser_pciefd: Continue parsing DMA buf after dropped RX

Carlos Sanchez (1):
      can: slcan: allow reception of short error messages

Marc Kleine-Budde (1):
      Merge patch series "can: kvaser_pciefd: Fix ISR race conditions"

 drivers/net/can/kvaser_pciefd.c    | 184 +++++++++++++++++++++----------------
 drivers/net/can/slcan/slcan-core.c |  26 ++++--
 2 files changed, 123 insertions(+), 87 deletions(-)


