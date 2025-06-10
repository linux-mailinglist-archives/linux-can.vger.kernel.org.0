Return-Path: <linux-can+bounces-3783-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C87AD32B2
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 11:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0E63AD7FB
	for <lists+linux-can@lfdr.de>; Tue, 10 Jun 2025 09:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00D828C2BE;
	Tue, 10 Jun 2025 09:49:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8307C28BA9F
	for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548980; cv=none; b=C9geL8f7xgOUiFjywWY7GvAw0VT9N0DPyp0gfY+iUyHWepzxiOJh0agec4pJhDStqsNMUjKMEte92dWTFb8485DtGdo1Iq7dw/Fzrc0zCS7BLgTlVzFZFUYnQBQyvYgDw7Omcr2Az1ds+vRsoecYW0u2YGxivNSPNKWoSOPmSv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548980; c=relaxed/simple;
	bh=1xA64Sa5xK9ytDTG6xDkLMCa4OcFT8IKpvTjHVigaBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3uzTllTPlJr0WZLzqtTcRX51HanhjujH0BTShBc7oR1/K4JX+rF/iF10W9dWSLOb7S9rg5Na5ZpAjpX3YGoF1o3uZ8xij8zjy5U9VpY59k1ShHgbt+Ul3ICzgYkpILiYWcxTa4le4uaz9yFA/HIBjheZU/1Og4PcK1ovvn4J4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uOvbs-00062R-Pz
	for linux-can@vger.kernel.org; Tue, 10 Jun 2025 11:49:36 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uOvbs-002kbe-1V
	for linux-can@vger.kernel.org;
	Tue, 10 Jun 2025 11:49:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 29210424196
	for <linux-can@vger.kernel.org>; Tue, 10 Jun 2025 09:49:36 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 33C43424180;
	Tue, 10 Jun 2025 09:49:35 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8d1fb4aa;
	Tue, 10 Jun 2025 09:49:34 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/7] pull-request: can-next 2025-06-10
Date: Tue, 10 Jun 2025 11:46:15 +0200
Message-ID: <20250610094933.1593081-1-mkl@pengutronix.de>
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

this is a pull request of 7 patches for net-next/main.

The first 4 patches are by Vincent Mailhol and prepare the CAN netlink
interface for the introduction of CAN XL configuration.

Geert Uytterhoeven's patch updates the CAN networking documentation.

The last 2 patched are by Davide Caratti and introduce skb drop
reasons in the receive path of several CAN protocols.

regards,
Marc

---

The following changes since commit 2c7e4a2663a1ab5a740c59c31991579b6b865a26:

  Merge tag 'net-6.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-05 12:34:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.17-20250610

for you to fetch changes up to af42404179c0e7b590ddfe56c4a753ace39cc1a4:

  Merge patch series "can: add drop reasons in the receive path" (2025-06-10 11:44:18 +0200)

----------------------------------------------------------------
linux-can-next-for-6.17-20250610

----------------------------------------------------------------
Davide Caratti (2):
      can: add drop reasons in the receive path of AF_CAN
      can: add drop reasons in CAN protocols receive path

Geert Uytterhoeven (1):
      documentation: networking: can: Document alloc_candev_mqs()

Marc Kleine-Budde (2):
      Merge patch series "can: netlink: preparation before introduction of CAN XL"
      Merge patch series "can: add drop reasons in the receive path"

Vincent Mailhol (4):
      can: netlink: replace tabulation by space in assignment
      can: bittiming: rename CAN_CTRLMODE_TDC_MASK into CAN_CTRLMODE_FD_TDC_MASK
      can: bittiming: rename can_tdc_is_enabled() into can_fd_tdc_is_enabled()
      can: netlink: can_changelink(): rename tdc_mask into fd_tdc_flag_provided

 Documentation/networking/can.rst          | 11 ++++-------
 drivers/net/can/dev/calc_bittiming.c      |  2 +-
 drivers/net/can/dev/netlink.c             | 26 +++++++++++++-------------
 drivers/net/can/usb/etas_es58x/es58x_fd.c |  2 +-
 drivers/net/can/xilinx_can.c              |  2 +-
 include/linux/can/bittiming.h             |  2 +-
 include/linux/can/dev.h                   |  4 ++--
 include/net/dropreason-core.h             | 18 ++++++++++++++++++
 net/can/af_can.c                          |  6 +++---
 net/can/bcm.c                             |  5 +++--
 net/can/isotp.c                           |  5 +++--
 net/can/j1939/socket.c                    |  5 +++--
 net/can/raw.c                             |  5 +++--
 13 files changed, 56 insertions(+), 37 deletions(-)


