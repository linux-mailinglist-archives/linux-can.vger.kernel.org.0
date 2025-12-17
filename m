Return-Path: <linux-can+bounces-5867-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5087BCC7046
	for <lists+linux-can@lfdr.de>; Wed, 17 Dec 2025 11:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F96130206A7
	for <lists+linux-can@lfdr.de>; Wed, 17 Dec 2025 10:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0EE33B6D9;
	Wed, 17 Dec 2025 09:46:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA18033BBA8
	for <linux-can@vger.kernel.org>; Wed, 17 Dec 2025 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964785; cv=none; b=bWDapBPvaeCNWE2CXH8r4LUdo0DWKeFRFjU+hRYpyyiUN0+td/+XaURresHwh1F3CaMOkJr0hyM8jQ5UHHvhaMjEmO3NpIUwHl0FUOKXol897UDbMAe189tJOBWkM2QmIvis0ABpQIvFy6g/GY+dNrPmd2NIyEC2opPx8gN/CdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964785; c=relaxed/simple;
	bh=q8OoYiqggd5kDtsfmWbZRSKAxyXqat3PC+dPKtYgzI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pDHae0ebwoaPSdobIZYeC60BeLgZxfN6FcEl/jr+lOSTRzaYxSzQ7HiPC4gcKZ20/LBRxiMTFaBF5m9quWZGH/vSY1Q9Y01P7WnFnVVEvUReG+lScE4H3r2dWGqW2O7W8R/u/dgzHwGFEegpVlcvJcMqlgJBGJ2hwtxHDyoCBWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vVo6d-0000BV-Ks; Wed, 17 Dec 2025 10:46:03 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vVo6c-0065ht-1g;
	Wed, 17 Dec 2025 10:46:02 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3EDF24B7715;
	Wed, 17 Dec 2025 09:46:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 17 Dec 2025 10:45:53 +0100
Subject: [PATCH can] can: fix build dependency
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-can-fix-dependency-v1-1-fd2d4f2a2bf5@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIANB7QmkC/yWMQQ7CMAwEv1LtGUs4KID4CuLQxgbMwVQJRaCqf
 8fAcVazM6NpNW04dDOqPq3Z3QN41aFce78omQQjrVPmxDsqvdPZXiQ6qot6edN2wznLXgZOgji
 OVcP4RY8IH6f/2KbhpuXxzWFZPn4OXjd7AAAA
X-Change-ID: 20251217-can-fix-dependency-63155d8db12d
To: Vincent Mailhol <mailhol@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2252; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=q8OoYiqggd5kDtsfmWbZRSKAxyXqat3PC+dPKtYgzI0=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpQnvXgjQE3g9c/QU6HSfM24lXY0KibH2Qa4dkj
 ZvKBRpDWOmJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaUJ71wAKCRAMdGXf+ZCR
 nGNxB/sGmtPNi3HFXgxJLpQ2KU4z8X8yvSpTihMxlnSfQ87mcn8LsuN039DZEJ7mW/pcMv3Wrym
 3Wx59611nHplr/6p3/KxbPMXPjNDnFtCvO7I/QOExMLPNH/ns19Bykg6DVI3WgKdA7wYA30MVuN
 gHmOwC3h7mhciB9hQ5oAKDRpO8qpjzrSirZqDK+bB5EBdeEbwtmuFz0PN/+QLDVW6e0sFhKHduv
 N4wHMoUDsv6/+ydIyH357zBABCwiG675DTL3RLyW5zSqCAxp960sVuDK4THxZ9ATniADfLghuJq
 1gPz3KvKE8nuWF9hPu2iNwBBtqjWQo/Y/iQ7jWnxzns3v9b4
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
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
Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/all/7427949a-ea7d-4854-9fe4-e01db7d878c7@app.fastmail.com/
Fixes: 6abd4577bccc ("can: fix build dependency")
Fixes: cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default")
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

---
base-commit: 885bebac9909994050bbbeed0829c727e42bd1b7
change-id: 20251217-can-fix-dependency-63155d8db12d

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


