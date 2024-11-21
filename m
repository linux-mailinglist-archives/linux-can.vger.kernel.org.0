Return-Path: <linux-can+bounces-2162-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E02F9D4F75
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 16:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228C61F21D71
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2024 15:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD621D959E;
	Thu, 21 Nov 2024 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="disLpdCS"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AADAD2C;
	Thu, 21 Nov 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201854; cv=none; b=mI4U3f7GiTxIz6R+G5oZFmBtQhLVe4lqLKNRBKZW8w1ljoVx6QMtOSOg9Hp1Dg+pyI6i8bezt/aIcGzWaGFuh7oGPud6bb6M2cHxPf5bKvIzPT5lFJZ5qok0L1nlY4XOhvqyOf7yS8i2MUk86Tb9ttPCpDl9VaVtL2EZr2oyKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201854; c=relaxed/simple;
	bh=Fsv+ibVAuy4YeC1yXQYyMt16jEc4zoDQgrkmeHJTbNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DArIpTfbEzz00Mj618qEDWdQkKlOQM/+4d1ZHA4Zpj709TqmbY6a2ofGYfg0Qi6pCv5zYU+qo87xAgUGUo7xkMCiUxyLcPMWtPqaBf8j2g5AYpDMRHLrdJ6YCLYBgvCjWuQjxX8sFPMrIdrutEbPI6toZkC6oI3fFLGCuUZwo3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=disLpdCS; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 854D7A0924;
	Thu, 21 Nov 2024 16:02:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1732201360; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=WrO4T4UVI2X+bB9SyM1ptlkOM20Ma2hyAUKzkpwbjGc=;
	b=disLpdCSl9nyHwdEoL9yrVRamZLn97XS/sHafhyRi5rIFK8wBb681+mh71xTeFr401/3V3
	8NaeyErTILWi4Wbu4rOVhxitVkVMGSawvQDTG7XJKmXhVKaCKtqkcBodG4Q5AR/a4Y9QHQ
	IR5MrOlnAOMIoPQAolkiinbJJkc6xRrdqn9ApZoGfZEwFjEorRq3YfP3LUeMpIhLvQSR3B
	tH21WbrhEeDCk/8HwluPkdU4DZ7/lLdK9uhAGG5t8hlRhUKMZV1nh8GJhzYc5HDWrO7TB0
	rjFfjtJKrWhrz/wzTEpHOOFHLnIYJBYejJZy4756pqVqg5wN/nObEOhW+nADJA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: n.buchwitz@kunbus.com,
	l.sanfilippo@kunbus.com,
	p.rosenberger@kunbus.com,
	stable@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: dev: can_set_termination(): Allow gpio sleep
Date: Thu, 21 Nov 2024 16:02:09 +0100
Message-Id: <20241121150209.125772-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The current implementation of can_set_termination() sets the GPIO in a
context which cannot sleep. This is an issue if the GPIO controller can
sleep (e.g. since the concerning GPIO expander is connected via SPI or
I2C). Thus, if the termination resistor is set (eg. with ip link),
a warning splat will be issued in the kernel log.

Fix this by setting the termination resistor with
gpiod_set_value_cansleep() which instead of gpiod_set_value() allows it to
sleep.

Cc: stable@vger.kernel.org
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/can/dev/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 6792c14fd7eb..681643ab3780 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -468,7 +468,7 @@ static int can_set_termination(struct net_device *ndev, u16 term)
 	else
 		set = 0;
 
-	gpiod_set_value(priv->termination_gpio, set);
+	gpiod_set_value_cansleep(priv->termination_gpio, set);
 
 	return 0;
 }
-- 
2.39.5


