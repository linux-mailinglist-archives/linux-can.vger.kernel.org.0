Return-Path: <linux-can+bounces-1437-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93463970DF5
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 08:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF89B1C21DE3
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D1E1AD401;
	Mon,  9 Sep 2024 06:37:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF361B658
	for <linux-can@vger.kernel.org>; Mon,  9 Sep 2024 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725863825; cv=none; b=cvBQOo5W2SL27gWRZCMATXKIIkfuzmWcrOg/+m5st+SAiaPz5K9q5/adieB9T31ggsGZI6kQPbkYYxmDqzD3Uh6MLKMYkmgmTBedRp10sGTLy2y5A5FrfnMf0bFS7ok7qlhpX+ooPyu7nWA4Mg+sAu7InEeYuiwfH2THN6aSbbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725863825; c=relaxed/simple;
	bh=+zgF4uNcAQMh95mWDEU/AcQrEU97jmnE0I/Ycih2gdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EcH9oME+Z0bmkYUTOfSiNtKvr8c4kbNXvdTqJGtiWsY98KccZlPT9uqwsXy7sm3RdNEUzM6plcBOqoPSK8geUH2KoAZ93VzeGGKaJuTtVVmxQ/996zMV68I/l880JuddUhE2Dpa/LWcy5DmMtwnJzNSMVTls/LyanbVk3KVAXUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1snY1F-0005tc-Kw
	for linux-can@vger.kernel.org; Mon, 09 Sep 2024 08:37:01 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1snY1F-006aWi-7A
	for linux-can@vger.kernel.org; Mon, 09 Sep 2024 08:37:01 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E1361336448
	for <linux-can@vger.kernel.org>; Mon, 09 Sep 2024 06:37:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F3A52336438;
	Mon, 09 Sep 2024 06:36:59 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7b61023f;
	Mon, 9 Sep 2024 06:36:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/3] pull-request: can-next 2024-09-09
Date: Mon,  9 Sep 2024 08:33:52 +0200
Message-ID: <20240909063657.2287493-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
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

this is a pull request of 3 patches for net-next/master.

The first patch is by Rob Herring and simplifies the DT parsing in the
cc770 driver.

The next 2 patches both target the rockchip_canfd driver added in the
last pull request to net-next. The first one is by Nathan Chancellor
and fixes the return type of rkcanfd_start_xmit(), the second one is
by me and fixes a 64 bit division on 32 bit platforms in
rkcanfd_timestamp_init().

regards,
Marc

---

The following changes since commit c259acab839e57eab0318f32da4ae803a8d59397:

  ptp/ioctl: support MONOTONIC{,_RAW} timestamps for PTP_SYS_OFFSET_EXTENDED (2024-09-08 18:40:33 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.12-20240909

for you to fetch changes up to 9c100bc3ec13914f9911a937ec5b38182a5c3d64:

  can: rockchip_canfd: rkcanfd_timestamp_init(): fix 64 bit division on 32 bit platforms (2024-09-09 08:31:02 +0200)

----------------------------------------------------------------
linux-can-next-for-6.12-20240909

----------------------------------------------------------------
Marc Kleine-Budde (1):
      can: rockchip_canfd: rkcanfd_timestamp_init(): fix 64 bit division on 32 bit platforms

Nathan Chancellor (1):
      can: rockchip_canfd: fix return type of rkcanfd_start_xmit()

Rob Herring (Arm) (1):
      net: can: cc770: Simplify parsing DT properties

 drivers/net/can/cc770/cc770_platform.c             | 30 ++++++++--------------
 .../net/can/rockchip/rockchip_canfd-timestamp.c    |  2 +-
 drivers/net/can/rockchip/rockchip_canfd-tx.c       |  2 +-
 drivers/net/can/rockchip/rockchip_canfd.h          |  2 +-
 4 files changed, 13 insertions(+), 23 deletions(-)


