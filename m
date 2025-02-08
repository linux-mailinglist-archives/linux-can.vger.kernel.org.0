Return-Path: <linux-can+bounces-2764-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AADA2D5D8
	for <lists+linux-can@lfdr.de>; Sat,  8 Feb 2025 12:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D0A188D0DB
	for <lists+linux-can@lfdr.de>; Sat,  8 Feb 2025 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13DE2451FF;
	Sat,  8 Feb 2025 11:51:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DB5381C4
	for <linux-can@vger.kernel.org>; Sat,  8 Feb 2025 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739015490; cv=none; b=NYEBKqHJkhkuCep/3srERYGY4C37JjXf9n4qkUsASse7KWZ5OJznEits6VSyHhlZRgxER+Fojr3/anngUw2nirIvFN9EBCEuarPSj7Rl1toQTxBOwCQ9SOeD0nStBhnbcaOnLcXPysM1fk1nNnjUxtfvXF3p5Jki/A8PDqaEpvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739015490; c=relaxed/simple;
	bh=4Umf3FahGxtcKtL0a03UpcioYK88anzb6shEzvG3Fj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nXWHwlLSiYw/FDnnNAwUgr65yxsiIJBUFjmYVOZ4NTENKrkpOTnQo5vKN0eqZZtNg9+8lV7CFbZmev6c2djaKJczPgo/bvS/+oIp4Wu/jYoMyM2eaR2Eg07uziGErtVBS+ltKHSJs5rCefJDml6IL4em5pt7mOVDJ+f96qoTQXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tgjMr-0006cz-Uj
	for linux-can@vger.kernel.org; Sat, 08 Feb 2025 12:51:25 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tgjMr-0048KE-2O
	for linux-can@vger.kernel.org;
	Sat, 08 Feb 2025 12:51:25 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 715D03BCCB0
	for <linux-can@vger.kernel.org>; Sat, 08 Feb 2025 11:51:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 979313BCCAA;
	Sat, 08 Feb 2025 11:51:23 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 37c6c551;
	Sat, 8 Feb 2025 11:51:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/6] pull-request: can 2025-02-08
Date: Sat,  8 Feb 2025 12:45:13 +0100
Message-ID: <20250208115120.237274-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
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

this is a pull request of 6 patches for net/master.

The first patch is by Reyders Morales and fixes a code example in the
CAN ISO15765-2 documentation.

The next patch is contributed by Alexander Hölzl and fixes sending of
J1939 messages with zero data length.

Fedor Pchelkin's patch for the ctucanfd driver adds a missing handling
for an skb allocation error.

Krzysztof Kozlowski contributes a patch for the c_can driver to fix
unbalanced runtime PM disable in error path.

The next patch is by Vincent Mailhol and fixes a NULL pointer
dereference on udev->serial in the etas_es58x driver.

The patch is by Robin van der Gracht and fixes the handling for an skb
allocation error.

regards,
Marc

---

The following changes since commit 1438f5d07b9a7afb15e1d0e26df04a6fd4e56a3c:

  rtnetlink: fix netns leak with rtnl_setlink() (2025-02-06 17:17:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.14-20250208

for you to fetch changes up to f7f0adfe64de08803990dc4cbecd2849c04e314a:

  can: rockchip: rkcanfd_handle_rx_fifo_overflow_int(): bail out if skb cannot be allocated (2025-02-08 12:42:56 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.14-20250208

----------------------------------------------------------------
Alexander Hölzl (1):
      can: j1939: j1939_sk_send_loop(): fix unable to send messages with data length zero

Fedor Pchelkin (1):
      can: ctucanfd: handle skb allocation failure

Krzysztof Kozlowski (1):
      can: c_can: fix unbalanced runtime PM disable in error path

Reyders Morales (1):
      Documentation/networking: fix basic node example document ISO 15765-2

Robin van der Gracht (1):
      can: rockchip: rkcanfd_handle_rx_fifo_overflow_int(): bail out if skb cannot be allocated

Vincent Mailhol (1):
      can: etas_es58x: fix potential NULL pointer dereference on udev->serial

 Documentation/networking/iso15765-2.rst        |  4 ++--
 drivers/net/can/c_can/c_can_platform.c         |  5 +++--
 drivers/net/can/ctucanfd/ctucanfd_base.c       | 10 ++++++----
 drivers/net/can/rockchip/rockchip_canfd-core.c |  2 +-
 drivers/net/can/usb/etas_es58x/es58x_devlink.c |  6 +++++-
 net/can/j1939/socket.c                         |  4 ++--
 net/can/j1939/transport.c                      |  5 +++--
 7 files changed, 22 insertions(+), 14 deletions(-)


