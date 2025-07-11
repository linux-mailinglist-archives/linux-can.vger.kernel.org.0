Return-Path: <linux-can+bounces-3965-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25426B019A3
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 12:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871CE16A7FE
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060D8280CFC;
	Fri, 11 Jul 2025 10:24:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A967280332
	for <linux-can@vger.kernel.org>; Fri, 11 Jul 2025 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229497; cv=none; b=u0Mzm6SEp4G8FLIvDW7yvdTeEgXGAKd0KNBG2qXDG7Ug6b9iSaoAUVncTFrd3JQNi6ePkhF6LqIiIZ4ab/DgL2ini+elEisFrn6Q/YfeOQLLhbZ/66E3VMrpB8IX8mQiXVr4PAs3baXvwYE7DdemjvSLqsQ3seLzmeG3scLrZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229497; c=relaxed/simple;
	bh=WVTaq4mylO4lr8zueh6RySDNRy59AUv6bZdoG2NxLUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnYCj9rpZJQ1c9bWhlfs7shW72l0n+gyY0IJ+yqViQQ3nXjUbqx3rsBb6QqUMqiYlJ1sdvETYGwchHviqADYowU+DZsnWc0rbSqXBe3xA2na7nsdOqAgqBRONlIhsLaGhf8AUgz5ABwiT5uuR+Garzwajbyk6HN53whTZ7Mr5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaAw2-0001Ir-Ov
	for linux-can@vger.kernel.org; Fri, 11 Jul 2025 12:24:54 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaAw2-007uBl-1m
	for linux-can@vger.kernel.org;
	Fri, 11 Jul 2025 12:24:54 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3BAA443C81B
	for <linux-can@vger.kernel.org>; Fri, 11 Jul 2025 10:24:54 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5526443C813;
	Fri, 11 Jul 2025 10:24:53 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d95165d8;
	Fri, 11 Jul 2025 10:24:52 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/1] pull-request: can 2025-07-11
Date: Fri, 11 Jul 2025 12:22:27 +0200
Message-ID: <20250711102451.2828802-1-mkl@pengutronix.de>
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

Sean Nyekjaer's patch targets the m_can driver and demotes the "msg
lost in rx" message to debug level to prevent flooding the kernel log
with error messages.

regards,
Marc

---

The following changes since commit 47c84997c686b4d43b225521b732492552b84758:

  selftests: net: lib: fix shift count out of range (2025-07-10 18:11:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.16-20250711

for you to fetch changes up to 58805e9cbc6f6a28f35d90e740956e983a0e036e:

  can: m_can: m_can_handle_lost_msg(): downgrade msg lost in rx message to debug level (2025-07-11 12:18:58 +0200)

----------------------------------------------------------------
linux-can-fixes-for-6.16-20250711

----------------------------------------------------------------
Sean Nyekjaer (1):
      can: m_can: m_can_handle_lost_msg(): downgrade msg lost in rx message to debug level

 drivers/net/can/m_can/m_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


