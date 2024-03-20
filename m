Return-Path: <linux-can+bounces-413-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 116A18810D1
	for <lists+linux-can@lfdr.de>; Wed, 20 Mar 2024 12:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C649B23002
	for <lists+linux-can@lfdr.de>; Wed, 20 Mar 2024 11:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD5A3C460;
	Wed, 20 Mar 2024 11:21:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A03BBE0
	for <linux-can@vger.kernel.org>; Wed, 20 Mar 2024 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933712; cv=none; b=LoXXpIs1zolVA3fFLXTfiRwWxz9cqfRi5CLDGc63eJQJfvWwyeEmevnaGrkvJ5aF9KjI2m+cnxsJizJelLcPBtqOA+Q90Qshr6jwTDCOfpsbuMaQh2HYnAy6IKW/9Kq7sXYSUpeQPV39bJjFSPTWgwKzeAPKAYWUyjapcSgvZhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933712; c=relaxed/simple;
	bh=56+XN9Gm3MPNwwzg6kROpfaR0TLddtGJb7+YQi6bQrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VCXxT8soevVac1yWPvelAjxo63qBqzBUOjYlKqrNt/D9yWMVLi8TBst4wSrh/3um7v++2XFVh3xZGx2dAM6HcNhMYLs108QD2xO5tB9n+QlKpEhaFGVhCj4Mj7pwYvevjWXx6feTefmMvXSg3lZw62lJSTI4dhA2lqOg9Zr0akg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rmu0y-0007lH-0k
	for linux-can@vger.kernel.org; Wed, 20 Mar 2024 12:21:48 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rmu0x-007SJ7-K5
	for linux-can@vger.kernel.org; Wed, 20 Mar 2024 12:21:47 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 4AB532A8247
	for <linux-can@vger.kernel.org>; Wed, 20 Mar 2024 11:21:47 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 66AF12A823F;
	Wed, 20 Mar 2024 11:21:46 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id fffd2902;
	Wed, 20 Mar 2024 11:21:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net 0/1] pull-request: can 2024-03-20
Date: Wed, 20 Mar 2024 11:50:25 +0100
Message-ID: <20240320112144.582741-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
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

this is a pull request of 1 patch for net/master.

Martin Jocić contributes a fix for the kvaser_pciefd driver, so that
up to 8 channels on the Xilinx-based adapters can be used. This issue
has been introduced in net-next for v6.9.

regards,
Marc

---

The following changes since commit e54e09c05c00120cbe817bdb037088035be4bd79:

  net: remove {revc,send}msg_copy_msghdr() from exports (2024-03-14 16:48:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-6.9-20240319

for you to fetch changes up to af1752ecdc9c665b72fbe2cef9035a6cba34b473:

  can: kvaser_pciefd: Add additional Xilinx interrupts (2024-03-19 15:26:01 +0100)

----------------------------------------------------------------
linux-can-fixes-for-6.9-20240319

----------------------------------------------------------------
Martin Jocić (1):
      can: kvaser_pciefd: Add additional Xilinx interrupts

 drivers/net/can/kvaser_pciefd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


