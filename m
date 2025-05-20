Return-Path: <linux-can+bounces-3591-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73737ABD2F5
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 11:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28B38A633A
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 09:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3CA2676DA;
	Tue, 20 May 2025 09:14:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA1266EEF
	for <linux-can@vger.kernel.org>; Tue, 20 May 2025 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732474; cv=none; b=ave3x1/a5arO8Bg8kps4w9CtVQUv08cL/fr6gJM5XGFYT0S6AHwELiozbEcPcFHF0WpeVK1u42XYSPHtrEAI/wolGUkjavGLq7JjgdopOasmVt/0PF/isQNjKNwaAmH/Iwa9kKuaslxl5W/msRmowA4QPsvv3g8IWNsV56iO8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732474; c=relaxed/simple;
	bh=6CMZ4PTrmwYmYOwUo7w1DlR3hRPvxU9uzteAgA6RAos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSRaxbcyzC++wto17mD5zb0mJ6ygh0GxSJpwzUnbVxkn5F4UKIXSMRw01qYuDuHAAKrFvOEhcLnFrGxAsDD+EDKMpkw/s2T3b3WSXzNZlW310v9r1frsKF2UOfZcG8hHAv0neYayT4uar5I5Nu1RjtLrUhts6MZrPyLdlzR9sr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uHJ3N-0007kO-25
	for linux-can@vger.kernel.org; Tue, 20 May 2025 11:14:29 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uHJ3M-000O4x-2i
	for linux-can@vger.kernel.org;
	Tue, 20 May 2025 11:14:28 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 82530415A29
	for <linux-can@vger.kernel.org>; Tue, 20 May 2025 09:14:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 55531415A22;
	Tue, 20 May 2025 09:14:27 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a8c96f24;
	Tue, 20 May 2025 09:14:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/3] pull-request: can 2025-05-20
Date: Tue, 20 May 2025 11:11:00 +0200
Message-ID: <20250520091424.142121-1-mkl@pengutronix.de>
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

this is a pull request of 3 patches for net/main.

The 1st patch is by Rob Herring, and fixes the $id path in the
microchip,mcp2510.yaml device tree bindinds documentation.

The last 2 patches are from Oliver Hartkopp and fix a use-after-free
read and an out-of-bounds read in the CAN Broadcast Manager (BCM)
protocol.

regards,
Marc

---

The following changes since commit 239af1970bcb039a1551d2c438d113df0010c149:

  llc: fix data loss when reading from a socket in llc_ui_recvmsg() (2025-05-19 12:12:54 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.15-20250520

for you to fetch changes up to 8283fd51e6ea7d0420bd93055761a5b38fe2be9b:

  Merge patch series "can: bcm: add locking for bcm_op runtime updates" (2025-05-19 17:09:33 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.15-20250520

----------------------------------------------------------------
Marc Kleine-Budde (1):
      Merge patch series "can: bcm: add locking for bcm_op runtime updates"

Oliver Hartkopp (2):
      can: bcm: add locking for bcm_op runtime updates
      can: bcm: add missing rcu read protection for procfs content

Rob Herring (Arm) (1):
      dt-bindings: can: microchip,mcp2510: Fix $id path

 .../bindings/net/can/microchip,mcp2510.yaml        |  2 +-
 net/can/bcm.c                                      | 79 +++++++++++++++-------
 2 files changed, 55 insertions(+), 26 deletions(-)


