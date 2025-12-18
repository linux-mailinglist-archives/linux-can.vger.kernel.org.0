Return-Path: <linux-can+bounces-5878-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53138CCBCC5
	for <lists+linux-can@lfdr.de>; Thu, 18 Dec 2025 13:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75AC53058E69
	for <lists+linux-can@lfdr.de>; Thu, 18 Dec 2025 12:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473123321DE;
	Thu, 18 Dec 2025 12:31:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690A3314D9
	for <linux-can@vger.kernel.org>; Thu, 18 Dec 2025 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766061113; cv=none; b=jt9MGHSk6FELFOy26ULD16iELIiA36lO4lb/KNpNHN4WVWSiXAZVfT2B7m/zs8+Q+BDA4KQ8c1DiJsi3uCzgG+Ux4nqqDJm0l1bHoUFupEfbeHJ5oyRJVOnP41ErWzjgEuSWGWEBPhrF5fteegIfJ/joepyJOQBkwmRdKtU3YXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766061113; c=relaxed/simple;
	bh=CbSKCaHmzirFzc0h654WTSlpU/IHl6PqJ/BRYl/AApI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaKQvD2qCKvz8HaEMn+i0FagASHXdRQsQh2IqGghC4R5dAwIRotXcpJIuwXPDiadiKCYvTEdelooEfg4+h+kkq3y3xjRlmshQhO8uyDOmRdCX1rKLGCTMBUPno64Z55vZe3pCg7mTvhkOhAfgZ1oAMdBTZePR7ugNqUYE28UvnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vWDAQ-0007wP-Hs; Thu, 18 Dec 2025 13:31:38 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vWDAP-006HQU-01;
	Thu, 18 Dec 2025 13:31:37 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B68D14B8273;
	Thu, 18 Dec 2025 12:31:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH net 3/3] can: fix build dependency
Date: Thu, 18 Dec 2025 10:27:19 +0100
Message-ID: <20251218123132.664533-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218123132.664533-1-mkl@pengutronix.de>
References: <20251218123132.664533-1-mkl@pengutronix.de>
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

Arnd Bergmann's patch [1] fixed the build dependency problem introduced by
bugfix commit cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure
by default"). This ended up as commit 6abd4577bccc ("can: fix build
dependency"), but I broke Arnd's fix by removing a dependency that we
thought was superfluous.

[1] https://lore.kernel.org/all/20251204100015.1033688-1-arnd@kernel.org/

Meanwhile the problem was also found by intel's kernel test robot,
complaining about undefined symbols:

| ERROR: modpost: "m_can_class_unregister" [drivers/net/can/m_can/m_can_platform.ko] undefined!
| ERROR: modpost: "m_can_class_free_dev" [drivers/net/can/m_can/m_can_platform.ko] undefined!
| ERROR: modpost: "m_can_class_allocate_dev" [drivers/net/can/m_can/m_can_platform.ko] undefined!
| ERROR: modpost: "m_can_class_get_clocks" [drivers/net/can/m_can/m_can_platform.ko] undefined!
| ERROR: modpost: "m_can_class_register" [drivers/net/can/m_can/m_can_platform.ko] undefined!

To fix this problem, add the missing dependency again.

Cc: Vincent Mailhol <mailhol@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512132253.vO9WFDJK-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512180808.fTAUQ2XN-lkp@intel.com/
Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/all/7427949a-ea7d-4854-9fe4-e01db7d878c7@app.fastmail.com/
Fixes: 6abd4577bccc ("can: fix build dependency")
Fixes: cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default")
Acked-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20251217-can-fix-dependency-v1-1-fd2d4f2a2bf5@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 460a74ae6923..cfaea6178a71 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -17,7 +17,7 @@ menuconfig CAN_DEV
 	  virtual ones. If you own such devices or plan to use the virtual CAN
 	  interfaces to develop applications, say Y here.
 
-if CAN_DEV
+if CAN_DEV && CAN
 
 config CAN_VCAN
 	tristate "Virtual Local CAN Interface (vcan)"
-- 
2.51.0


