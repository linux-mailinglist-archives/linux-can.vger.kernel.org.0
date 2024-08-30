Return-Path: <linux-can+bounces-1290-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED55966BF6
	for <lists+linux-can@lfdr.de>; Sat, 31 Aug 2024 00:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2D72836AE
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 22:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BE11C2DB2;
	Fri, 30 Aug 2024 21:59:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C81C1AD9
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725055168; cv=none; b=bw+4lolQhShbF2dZx0/89Yk6dPJHXtw2iQPps435as5mhPjYJfONgE9aZPlZ1NqaWEP+tAbWhDQvnxl0ExQL5kKFXCsN4wpftOtRKZPPJAarZRVUF7QMvnhaNOqm6WNjvF7TJfIHUhrpLr5cvz+t9lH7OTOd4Di3VsXWe+gux7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725055168; c=relaxed/simple;
	bh=QjlpltM6WFPSPXwWxD309mOOafvEIZ88vhL3o9egL0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/7tpM7c0he2EXOccK52BmqYbtmXOnGg0xQQ1hHSvqLl6JtKV0ZQzWUVDMj5A4YR4eEIhueZwxLYbQ55Sj272BNBRMglPmDTCJFpEeMbKGEZkYP20637x8YoAWZNFKLNwgobiFDUe9GE+PTUs3EczRJPU2Ya3bVum7lScuP5IyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eN-0004GZ-9w
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:59:23 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9eL-004FZU-5s
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:59:21 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id DA59B32E540
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:59:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 8837932E4EB;
	Fri, 30 Aug 2024 21:59:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d5b58076;
	Fri, 30 Aug 2024 21:59:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Simon Arlott <simon@octiron.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 12/13] can: mcp251x: fix deadlock if an interrupt occurs during mcp251x_open
Date: Fri, 30 Aug 2024 23:53:47 +0200
Message-ID: <20240830215914.1610393-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830215914.1610393-1-mkl@pengutronix.de>
References: <20240830215914.1610393-1-mkl@pengutronix.de>
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

From: Simon Arlott <simon@octiron.net>

The mcp251x_hw_wake() function is called with the mpc_lock mutex held and
disables the interrupt handler so that no interrupts can be processed while
waking the device. If an interrupt has already occurred then waiting for
the interrupt handler to complete will deadlock because it will be trying
to acquire the same mutex.

CPU0                           CPU1
----                           ----
mcp251x_open()
 mutex_lock(&priv->mcp_lock)
  request_threaded_irq()
                               <interrupt>
                               mcp251x_can_ist()
                                mutex_lock(&priv->mcp_lock)
  mcp251x_hw_wake()
   disable_irq() <-- deadlock

Use disable_irq_nosync() instead because the interrupt handler does
everything while holding the mutex so it doesn't matter if it's still
running.

Fixes: 8ce8c0abcba3 ("can: mcp251x: only reset hardware as required")
Signed-off-by: Simon Arlott <simon@octiron.net>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/4fc08687-1d80-43fe-9f0d-8ef8475e75f6@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 3b8736ff0345..ec5c64006a16 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -752,7 +752,7 @@ static int mcp251x_hw_wake(struct spi_device *spi)
 	int ret;
 
 	/* Force wakeup interrupt to wake device, but don't execute IST */
-	disable_irq(spi->irq);
+	disable_irq_nosync(spi->irq);
 	mcp251x_write_2regs(spi, CANINTE, CANINTE_WAKIE, CANINTF_WAKIF);
 
 	/* Wait for oscillator startup timer after wake up */
-- 
2.45.2



