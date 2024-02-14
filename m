Return-Path: <linux-can+bounces-273-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C76856173
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 12:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E661B30E74
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BB912C813;
	Thu, 15 Feb 2024 10:44:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03912C801
	for <linux-can@vger.kernel.org>; Thu, 15 Feb 2024 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993889; cv=none; b=iFvLMhcwhXb8652TUU3UHtMVodNaz/TXXB1EPDZkQ9+wD+cmAfOkvLSUiJr5zXLINeG8Vq2HwR3Ex7KUFog4eDW+qeXetHE5vdIgkqcTnbkdJRFmAmaTMa22Mnd+MiLFgog+ygxeBr4sJO1/nPwmHoS+h+0ns/Vs0umxTsgsFsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993889; c=relaxed/simple;
	bh=6u0zaawu921PYoRktG0AkOrLSXxVA0vuxFk7pyZy/eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8atHyNio/hOj6ioTCp4uS/bR2VMdna2af3JNms4bQpyPLyXKkr7xAblZi5jKIj3LE8gbpiiSl9G9rnMR2+NouHOtKssbv0PcChS14uhke/ACFu/sKoslsJascZLQ4APgLx7Ot5KzKjM+w9QRu3QtBgaC429C7ayv2AjvLuvMAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1raZET-0000pB-Mz
	for linux-can@vger.kernel.org; Thu, 15 Feb 2024 11:44:45 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1raZES-000rm9-Hr
	for linux-can@vger.kernel.org; Thu, 15 Feb 2024 11:44:44 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id EAE1A28E556
	for <linux-can@vger.kernel.org>; Wed, 14 Feb 2024 14:03:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 0048928E53E;
	Wed, 14 Feb 2024 14:03:49 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3a82421e;
	Wed, 14 Feb 2024 14:03:49 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/3] pull-request: can 2024-02-14
Date: Wed, 14 Feb 2024 14:59:04 +0100
Message-ID: <20240214140348.2412776-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
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

this is a pull request of 3 patches for net/master.

the first patch is by Ziqi Zhao and targets the CAN J1939 protocol, it
fixes a potential deadlock by replacing the spinlock by an rwlock.

Oleksij Rempel's patch adds a missing spin_lock_bh() to prevent a
potential Use-After-Free in the CAN J1939's
setsockopt(SO_J1939_FILTER).

Maxime Jayat contributes a patch to fix the transceiver delay
compensation (TDCO) calculation, which is needed for higher CAN-FD bit
rates (usually 2Mbit/s).

regards,
Marc

---

The following changes since commit 858b31133dbec88465bcc0a006f4dc43173662b8:

  octeontx2-af: Remove the PF_FUNC validation for NPC transmit rules (2024-02-14 09:31:44 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.8-20240214

for you to fetch changes up to 2aa0a5e65eae27dbd96faca92c84ecbf6f492d42:

  can: netlink: Fix TDCO calculation using the old data bittiming (2024-02-14 13:53:03 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.8-20240214

----------------------------------------------------------------
Maxime Jayat (1):
      can: netlink: Fix TDCO calculation using the old data bittiming

Oleksij Rempel (1):
      can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)

Ziqi Zhao (1):
      can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

 drivers/net/can/dev/netlink.c |  2 +-
 net/can/j1939/j1939-priv.h    |  3 ++-
 net/can/j1939/main.c          |  2 +-
 net/can/j1939/socket.c        | 46 ++++++++++++++++++++++++++++---------------
 4 files changed, 34 insertions(+), 19 deletions(-)


