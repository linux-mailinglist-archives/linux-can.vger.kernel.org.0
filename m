Return-Path: <linux-can+bounces-3852-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D02CADE6BB
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 11:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650193BC598
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEA8283CBE;
	Wed, 18 Jun 2025 09:23:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1018460
	for <linux-can@vger.kernel.org>; Wed, 18 Jun 2025 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238623; cv=none; b=g7usR5hV/rQoqosL3x+1G6AC6orDeUM7vjAZN11Ge9d+x/8i8yLdOGZL6QDPmqdVzU+CT0Oi4rzqn022uD3i2wY9fHO6MnyqMjEKgMzHlgT0THxWnc6d9VOCndKYdzNXQmokIrax3y6SuGIpnPOkRyx/FWpYMGSGqIbgRc9l6jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238623; c=relaxed/simple;
	bh=gYsPPMniLSnHxcKO/q3mu5+mWVRkjsol7dy2McIEF2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aruUbKs17AcWvM0bHehOAySvzjQKzW4pPFIt8TcIhDfB+DVxEDrhTsJmmqZf8qFxiO7yDQc+UIt4/v4l+HcocZ4Ji+iowp3HjNe+nhs5wuYBC7mfQhuJ9oEfrDHH3qvDTgzLualatCjYvYZC/jXAZYEk0iHKIlZUp4kSfo+4eAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1A-0006WD-CQ
	for linux-can@vger.kernel.org; Wed, 18 Jun 2025 11:23:40 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1A-004765-06
	for linux-can@vger.kernel.org;
	Wed, 18 Jun 2025 11:23:40 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B3F8042B288
	for <linux-can@vger.kernel.org>; Wed, 18 Jun 2025 09:23:39 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id BAA2742B26F;
	Wed, 18 Jun 2025 09:23:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0d7697fe;
	Wed, 18 Jun 2025 09:23:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/10] pull-request: can-next 2025-06-18
Date: Wed, 18 Jun 2025 11:19:54 +0200
Message-ID: <20250618092336.2175168-1-mkl@pengutronix.de>
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

this is a pull request of 10 patches for net-next/main.

All 10 patches are by Geert Uytterhoeven, target the rcar_canfd
driver, first cleanup/refactor the driver and then add support for
Transceiver Delay Compensation.

regards,
Marc

---
The following changes since commit 6d4e01d29d87356924f1521ca6df7a364e948f13:

  net: Use dev_fwnode() (2025-06-12 18:46:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-6.17-20250618

for you to fetch changes up to 1fee0c61317272dd6807fb38a28ee85d00cd1cb4:

  Merge patch series "can: rcar_canfd: Add support for Transceiver Delay Compensation" (2025-06-13 09:34:11 +0200)

----------------------------------------------------------------
linux-can-next-for-6.17-20250618

----------------------------------------------------------------
Geert Uytterhoeven (10):
      can: rcar_canfd: Consistently use ndev for net_device pointers
      can: rcar_canfd: Remove bittiming debug prints
      can: rcar_canfd: Add helper variable ndev to rcar_canfd_rx_pkt()
      can: rcar_canfd: Add helper variable dev to rcar_canfd_reset_controller()
      can: rcar_canfd: Simplify data access in rcar_canfd_{ge,pu}t_data()
      can: rcar_canfd: Repurpose f_dcfg base for other registers
      can: rcar_canfd: Rename rcar_canfd_setrnc() to rcar_canfd_set_rnc()
      can: rcar_canfd: Share config code in rcar_canfd_set_bittiming()
      can: rcar_canfd: Return early in rcar_canfd_set_bittiming() when not FD
      can: rcar_canfd: Add support for Transceiver Delay Compensation

Marc Kleine-Budde (1):
      Merge patch series "can: rcar_canfd: Add support for Transceiver Delay Compensation"

 drivers/net/can/rcar/rcar_canfd.c | 232 ++++++++++++++++++++++++++------------
 1 file changed, 158 insertions(+), 74 deletions(-)


