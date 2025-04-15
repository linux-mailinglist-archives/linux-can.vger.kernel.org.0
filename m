Return-Path: <linux-can+bounces-3403-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED7A89A5C
	for <lists+linux-can@lfdr.de>; Tue, 15 Apr 2025 12:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7DD3B2A61
	for <lists+linux-can@lfdr.de>; Tue, 15 Apr 2025 10:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4468288C84;
	Tue, 15 Apr 2025 10:34:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F35A27587B
	for <linux-can@vger.kernel.org>; Tue, 15 Apr 2025 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713247; cv=none; b=ggltX0wCJ3tdzxVDpa/yXqYBF+VYHwk0JdLv730lxdCIATspXNAE1sTj58IyJqagtOk8F+uTcL5gN5EsE0cWgF4QOwQSMoeokeRAou3RxCCuWJ/JdopVW2wxHx78wNrxVxp/I0RgIm8APCp0DCNvWslCyFTIAx7cqdBn9Zfp9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713247; c=relaxed/simple;
	bh=pvCGRuiwKHZ718fvgfTNfRB3Ue0d3+1Y6Bi/DOHk4h4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPubKEdh1dTAzqP9FA218XY+tsp/wGo2S/xgt5J3PJo6pqF0idpP7TzwQlxnHIoHyVYkldE6TT07QZ8W2SKeOY7ueKHvMKYlPwEjLvU7Hl8TUy4K9vGuEq2zGuiKbWswQ9wAjgeZeQgmBDsCb61nLZac9Xn6m88/Ij6l2JmVQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4dcC-0006Ns-L8
	for linux-can@vger.kernel.org; Tue, 15 Apr 2025 12:34:04 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4dcC-000P4W-1P
	for linux-can@vger.kernel.org;
	Tue, 15 Apr 2025 12:34:04 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1AB153F9BDF
	for <linux-can@vger.kernel.org>; Tue, 15 Apr 2025 10:34:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 1AB253F9BD3;
	Tue, 15 Apr 2025 10:34:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 59bfd8af;
	Tue, 15 Apr 2025 10:34:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/2] pull-request: can 2025-04-15
Date: Tue, 15 Apr 2025 12:31:43 +0200
Message-ID: <20250415103401.445981-1-mkl@pengutronix.de>
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

this is a pull request of 2 patches for net/main.

The first patch is by Davide Caratti and fixes the missing derement in
the protocol inuse counter for the J1939 CAN protocol.

The last patch is by Weizhao Ouyang and fixes a broken quirks check in
the rockchip CAN-FD driver.

regards,
Marc

---
The following changes since commit 65d91192aa66f05710cfddf6a14b5a25ee554dba:

  net: openvswitch: fix nested key length validation in the set() action (2025-04-14 16:15:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.15-20250415

for you to fetch changes up to 6315d93541f8a5f77c5ef5c4f25233e66d189603:

  can: rockchip_canfd: fix broken quirks checks (2025-04-15 12:23:10 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.15-20250415

----------------------------------------------------------------
Davide Caratti (1):
      can: fix missing decrement of j1939_proto.inuse_idx

Weizhao Ouyang (1):
      can: rockchip_canfd: fix broken quirks checks

 drivers/net/can/rockchip/rockchip_canfd-core.c | 7 ++++---
 net/can/j1939/socket.c                         | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)


