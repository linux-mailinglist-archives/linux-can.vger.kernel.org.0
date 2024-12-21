Return-Path: <linux-can+bounces-2472-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2759F9E22
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 04:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3338E16BEA4
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 03:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6C1DB534;
	Sat, 21 Dec 2024 03:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="YFT1FrBP"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D3C13A244;
	Sat, 21 Dec 2024 03:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734753265; cv=none; b=g2sQU/w0MyCqc4xoyHkJ7kly4QdAxldDoGYXBVqqS/FIlB2nV0skZpHClSUQciB2x90LBkrK+QOUxowynHanGTYYDlthT6p5j8IQI2v0LIWVb4EhZQ3uYHoNXvOxct83Pfe08ACKC8+Fd2CSB27fAuQLqkvbAHL/mc6+V5w894k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734753265; c=relaxed/simple;
	bh=5bbe5a0xi6A1dSp263OkJN9Xatgy4RbzMQ73tu98Lsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NFkIk/eBE684lUwP9altrrhcDXQI8E5T062CcHKkeJBWtseUkwfs1qjI0oevQI1XaTkHJgfaUGLdYXfFULIlyARzSAQJFwk2C2awMr6pd5Pq20rVqCJ1ixF61zoVVcwV6kFc4w9JcoFdf2EET5GKtQbvGo3LXTZw5W3dPDP4mIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=YFT1FrBP; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734753263; x=1766289263;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5bbe5a0xi6A1dSp263OkJN9Xatgy4RbzMQ73tu98Lsk=;
  b=YFT1FrBP1uWH1r5HsNsIcD49bYQ4v9TAX87oyivO3475Z22MuAGo8vBF
   ep6w4SBoFpZwOVWcrGC7M8ZBLdEHCKmn49lm5ki9DOdMzHAz0BXkBxSh6
   Ltg0eRstzWxmCtWQJhmrmmxFZkbBmSU4SAc9EvdJxUUcw0BDDW04XZcsG
   I=;
X-CSE-ConnectionGUID: /KxjEiOjRZmfFDgjSNvPuw==
X-CSE-MsgGUID: gya10eQaSoKMbptgOXW3dA==
X-IronPort-AV: E=Sophos;i="6.12,252,1728943200"; 
   d="scan'208";a="28282874"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 21 Dec 2024 04:54:20 +0100
Received: from localhost.localdomain (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id 51B7E24C9;
	Sat, 21 Dec 2024 04:54:18 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 0/3] broadcom, ethernet/marvell,cx231xx,can/dev: Remove unused values and dead code
Date: Sat, 21 Dec 2024 04:44:14 +0100
Message-ID: <20241221035352.1020228-1-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series clears out the Coverity IDs 1487817, 1561102, 1497123, & 1269153.

Thank you,

Ariel Otilibili (3):
  drivers/firmware/broadcom, ethernet/marvell: Remove unused values
  usb/cx231xx: Remove unused value
  net/can/dev: Remove dead code

 drivers/firmware/broadcom/tee_bnxt_fw.c                   | 2 --
 drivers/media/usb/cx231xx/cx231xx-avcore.c                | 1 -
 drivers/net/can/dev/dev.c                                 | 2 --
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 2 --
 4 files changed, 7 deletions(-)

-- 
2.47.1


