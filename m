Return-Path: <linux-can+bounces-3847-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 918D4ADD3D1
	for <lists+linux-can@lfdr.de>; Tue, 17 Jun 2025 18:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DF01897A15
	for <lists+linux-can@lfdr.de>; Tue, 17 Jun 2025 15:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292312EA165;
	Tue, 17 Jun 2025 15:51:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF52E92C8
	for <linux-can@vger.kernel.org>; Tue, 17 Jun 2025 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175491; cv=none; b=LSmNIOHkp3TK0+XHxzJByybxoE7JYp7HkGtoPeQK+/k54twJ8PxtL8UDIvu1sOSh7eSDF0D0i85NjamReJPTmdoADYOPRiU/sPZMJ/aoeF3CXIP+SISrOzr1fY3ufscZxtCE5m96LQcjWG3Az911D1xbV6Fz5W2cf9b7GpiqKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175491; c=relaxed/simple;
	bh=0BjGnUhLaXjDi4sHL9RsikZRgrtCv5xTvU7xtyhM8TY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwCBnuv67BGIWr/RC107UsZAGaqDTB0dQ8/gIpe3Kg+yKCX9PnNd5aloyR7nlLvPv6oOfykazsuQKvY9vaPHqFIzNnsC1pE2fVAZYW+5tlU0YQeQNjiYxtEc6MWZ3Xr2nF3Gx1omqoLECoLSbbsixSc9O2ROTsAnTpHnTpv0stU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRYas-0000KS-Uh
	for linux-can@vger.kernel.org; Tue, 17 Jun 2025 17:51:26 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRYas-003zmz-2P
	for linux-can@vger.kernel.org;
	Tue, 17 Jun 2025 17:51:26 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 67C1042AAAC
	for <linux-can@vger.kernel.org>; Tue, 17 Jun 2025 15:51:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 8AE6D42AAA4;
	Tue, 17 Jun 2025 15:51:25 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5be434d1;
	Tue, 17 Jun 2025 15:51:24 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/1] pull-request: can 2025-06-17
Date: Tue, 17 Jun 2025 17:50:01 +0200
Message-ID: <20250617155123.2141584-1-mkl@pengutronix.de>
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

The patch is by Brett Werling, and fixes the power regulator retrieval
during probe of the tcan4x5x glue code for the m_can driver.

regards,
Marc

---

The following changes since commit 7b4ac12cc929e281cf7edc22203e0533790ebc2b:

  openvswitch: Allocate struct ovs_pcpu_storage dynamically (2025-06-17 14:47:46 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.16-20250617

for you to fetch changes up to db22720545207f734aaa9d9f71637bfc8b0155e0:

  can: tcan4x5x: fix power regulator retrieval during probe (2025-06-17 17:47:23 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.16-20250617

----------------------------------------------------------------
Brett Werling (1):
      can: tcan4x5x: fix power regulator retrieval during probe

 drivers/net/can/m_can/tcan4x5x-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)


