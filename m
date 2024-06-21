Return-Path: <linux-can+bounces-839-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166399124F2
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 14:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DEF5B20EFD
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 12:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BB3150991;
	Fri, 21 Jun 2024 12:17:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E8028399
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972268; cv=none; b=OQnH6csQl23ij6TlZJZom5KbmGNw9X67oDFtWObL1xviCb7KvnpBspIP6kZG3+H/gWXblsMZf5z2T0pUVqYNQ9Qi+HPXf1KJWNg2Ag+Pwd66NKgp85pJHwU1avHufuBE9hIEsF26aznJfxH3+X9AfAvo5fmgO5kuExbgwmMrqHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972268; c=relaxed/simple;
	bh=GElVFVjir6tlx3IomxQhnlAiCuQs8MztDTf7aMaEM5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIDljt/z5Ol9b4S5OfuWuAZ9/w0cSpxfNEtz+YTSOAL6StfjRmqRWdoEIaTjWdVxDfDFDkKksXiKW2/BtU2+k5zFApvJOISqy049CD4pkThX0YwEw0lEUNJhEjVhvCaJZE/pR+3+T3yfEIiYVARzqzNL/6ubXp7rXYmSibPYIVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKdD6-0002LP-H5
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 14:17:44 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKdD6-003wDs-3T
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 14:17:44 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id BED362EE81B
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 12:17:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B34D12EE808;
	Fri, 21 Jun 2024 12:17:42 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2b055e58;
	Fri, 21 Jun 2024 12:17:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/5] pull-request: can 2024-06-21
Date: Fri, 21 Jun 2024 13:23:35 +0200
Message-ID: <20240621121739.434355-1-mkl@pengutronix.de>
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

this is a pull request of 5 patches for net/master.

The first patch is by Oleksij Rempel, it enhances the error handling
for tightly received RTS message in the j1939 protocol.

Shigeru Yoshida's patch fixes a kernel information leak in
j1939_send_one() in the j1939 protocol.

Followed by a patch by Oleksij Rempel for the j1939 protocol, to
properly recover from a CAN bus error during BAM transmission.

A patch by Chen Ni properly propagates errors in the kvaser_usb
driver.

The last patch is by Vitor Soares, that fixes an infinite loop in the
mcp251xfd driver is SPI async sending fails during xmit.

regards,
Marc

---

The following changes since commit 8851346912a1fa33e7a5966fe51f07313b274627:

  net: stmmac: Assign configured channel value to EXTTS event (2024-06-20 11:56:03 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.10-20240621

for you to fetch changes up to d8fb63e46c884c898a38f061c2330f7729e75510:

  can: mcp251xfd: fix infinite loop when xmit fails (2024-06-21 10:50:20 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.10-20240621

----------------------------------------------------------------
Chen Ni (1):
      can: kvaser_usb: fix return value for hif_usb_send_regout

Oleksij Rempel (2):
      net: can: j1939: enhanced error handling for tightly received RTS messages in xtp_rx_rts_session_new
      net: can: j1939: recover socket queue on CAN bus error during BAM transmission

Shigeru Yoshida (1):
      net: can: j1939: Initialize unused data in j1939_send_one()

Vitor Soares (1):
      can: mcp251xfd: fix infinite loop when xmit fails

 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c   | 14 +++++-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c     | 55 ++++++++++++++++++++----
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h        |  5 +++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c |  2 +-
 net/can/j1939/main.c                             |  6 +--
 net/can/j1939/transport.c                        | 21 ++++++++-
 6 files changed, 86 insertions(+), 17 deletions(-)


