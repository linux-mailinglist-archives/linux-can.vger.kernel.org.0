Return-Path: <linux-can+bounces-5241-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A937BF2171
	for <lists+linux-can@lfdr.de>; Mon, 20 Oct 2025 17:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05E918C0483
	for <lists+linux-can@lfdr.de>; Mon, 20 Oct 2025 15:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4FA264A97;
	Mon, 20 Oct 2025 15:25:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C1B268C40
	for <linux-can@vger.kernel.org>; Mon, 20 Oct 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973928; cv=none; b=m3glxATxQIGTuF3g9l6bUu4QsMhjyMZsSNGoaIFQCZmfAet4NXL+L0uRhxeJdHWs64w2X4A5tf9W1+PzkJMOJTayOYbpj/2aPiZoULq5UxRCj7ZLdIbPlGLtn8xnx5WrbYff+nFH2PUPCPNiih08XhUeXTIZe/PMryRI8rbik0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973928; c=relaxed/simple;
	bh=qxm53sqAQ1YP5kM3q6760h0jQq14Lb5gX9n2ss8yOk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uGiKGLN87yF9sisxe0rqHgzSeQAWa6WItq4U00r83vVfaUWCR+w/ZtANQ9rHoyO5XthsuY0dUFgDYQNk/UGsRWnrSTOqQR+l7I/k/GT1RrtyyFPLesPbmn49UqiI4Sw7fGrzBH5YYCDJsBaY3rxoc1E2RZvy7JPqdwq0KnYFVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vArlC-0005Ac-8S; Mon, 20 Oct 2025 17:25:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vArlB-004ZUF-0d;
	Mon, 20 Oct 2025 17:25:21 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D7F1A48B598;
	Mon, 20 Oct 2025 15:25:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/4] pull-request: can 2025-10-20
Date: Mon, 20 Oct 2025 17:22:21 +0200
Message-ID: <20251020152516.1590553-1-mkl@pengutronix.de>
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

this is a pull request of 4 patches for net/main.

All patches are by me. The first 3 update the bxcan, esd and rockchip
driver to drop skbs in xmit of the device is in listen only mode.

The last patch targets the CAN netlink implementation to allow the
disabling of automatic restart after Bus-Off, even if the a driver
doesn't implement that callback.

regards,
Marc

---
The following changes since commit ffff5c8fc2af2218a3332b3d5b97654599d50cde:

  net: phy: realtek: fix rtl8221b-vm-cg name (2025-10-17 16:34:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.18-20251020

for you to fetch changes up to 8e93ac51e4c6dc399fad59ec21f55f2cfb46d27c:

  can: netlink: can_changelink(): allow disabling of automatic restart (2025-10-20 17:20:12 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.18-20251020

----------------------------------------------------------------
Marc Kleine-Budde (5):
      can: bxcan: bxcan_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      can: esd: acc_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      can: rockchip-canfd: rkcanfd_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      Merge patch series "can: drivers: drop skb in xmit if device is in listen only mode"
      can: netlink: can_changelink(): allow disabling of automatic restart

 drivers/net/can/bxcan.c                      | 2 +-
 drivers/net/can/dev/netlink.c                | 6 ++++--
 drivers/net/can/esd/esdacc.c                 | 2 +-
 drivers/net/can/rockchip/rockchip_canfd-tx.c | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

