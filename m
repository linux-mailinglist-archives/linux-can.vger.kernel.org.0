Return-Path: <linux-can+bounces-3734-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD40AC79F2
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 09:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0205F4E6809
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 07:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597E1EF0BB;
	Thu, 29 May 2025 07:53:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6143C01
	for <linux-can@vger.kernel.org>; Thu, 29 May 2025 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748505213; cv=none; b=gYrRpYacie01rp24LwXRw42VEjr99WpRElWqkqN+PwJMif1iwr9F7WWEhb6DZ860Rm5xxak02rjCQraEvm8YSPovMVY2dhxOW7oKOOTIpnHhARl+BbTNWiBfISSv/PwWv8moapNo5sGEem+/kDeJuMS/DHk3lQ0Jg6dMcvQmsEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748505213; c=relaxed/simple;
	bh=6ISgwnkjRIxL/WaKp/MlO1eF4oug1b2X2N1MXZwf95M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f4Qghstayhmb2hGj1JVJ2cThuuK8hcLgimu1ALtOgxIs8a2/SNGgJ5u/72ruLhikkf+5BGgH0JpbLlC/MN2OZQu+ZYV9OkS7bzkgB1Mnaz/+VSIJbN/nMVbuxKO5WS/WwwT2w7oVWMIpIZciGbetvqzLr+ojgZg7Nhh7UNmdvCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKY4t-0006Eh-FU
	for linux-can@vger.kernel.org; Thu, 29 May 2025 09:53:27 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uKY4t-000ifv-0r
	for linux-can@vger.kernel.org;
	Thu, 29 May 2025 09:53:27 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id ECABB41BF08
	for <linux-can@vger.kernel.org>; Thu, 29 May 2025 07:53:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 75B3F41BF04;
	Thu, 29 May 2025 07:53:24 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5f28ef04;
	Thu, 29 May 2025 07:53:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/1] pull-request: can 2025-05-29
Date: Thu, 29 May 2025 09:49:29 +0200
Message-ID: <20250529075313.1101820-1-mkl@pengutronix.de>
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

this is a pull request of 1 patch for net/main.

The patch is by Fedor Pchelkin and fixes a slab-out-of-bounds access
in the kvaser_pciefd driver.

regards,
Marc

---

The following changes since commit 271683bb2cf32e5126c592b5d5e6a756fa374fd9:

  page_pool: Fix use-after-free in page_pool_recycle_in_ring (2025-05-28 19:19:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.16-20250529

for you to fetch changes up to 54ec8b08216f3be2cc98b33633d3c8ea79749895:

  can: kvaser_pciefd: refine error prone echo_skb_max handling logic (2025-05-29 09:45:27 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.16-20250529

----------------------------------------------------------------
Fedor Pchelkin (1):
      can: kvaser_pciefd: refine error prone echo_skb_max handling logic

 drivers/net/can/kvaser_pciefd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)


