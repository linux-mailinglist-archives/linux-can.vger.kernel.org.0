Return-Path: <linux-can+bounces-1465-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E29B8973F14
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 19:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77F8CB212C7
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535351B78F6;
	Tue, 10 Sep 2024 17:15:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605BE1B150C
	for <linux-can@vger.kernel.org>; Tue, 10 Sep 2024 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988545; cv=none; b=n0b/cW0WqbdRSkRFrr4sumVoMiK5u4KunFPDHgb2A7995cZUNA03RZaCuS8dcjysGnBuLYltz7MKBbECNTc8EmwPAsMwK8NP8l0V45quGTO1xW5dWlVOV6ZVpFTElycKQk98XGzzaNtTrDjhNGohw/9uxJhghXZNdESudLe8T04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988545; c=relaxed/simple;
	bh=0VZgj2CgMTbCPm/gqb6HfvZ06CufUB57ijC0stdDmPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=drHQCecrJTZbMKQB+F+p6nsdfSoAUOQ6i5OgfEhfF6zbcYOCYTZuajlDFGtDfr7g4FZLNWc6Zyj/voOpgHFhJfx8Et/7/PLZq4A1eGkiXvjv0RmWXFc+mmaGDEARClxheeecfgxn0FTqsL/6knQWrTqDvNXIKZgDbLuzuqU5cRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1so4So-0005CC-5b
	for linux-can@vger.kernel.org; Tue, 10 Sep 2024 19:15:38 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1so4Sn-006wTy-Hu
	for linux-can@vger.kernel.org; Tue, 10 Sep 2024 19:15:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 41FC1337A38
	for <linux-can@vger.kernel.org>; Tue, 10 Sep 2024 17:15:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C88F0337A1A;
	Tue, 10 Sep 2024 17:15:34 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7f6c8a39;
	Tue, 10 Sep 2024 17:15:34 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 10 Sep 2024 19:15:28 +0200
Subject: [PATCH can v3 1/2] can: m_can: enable NAPI before enabling
 interrupts
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-can-m_can-fix-ifup-v3-1-6c1720ba45ce@pengutronix.de>
References: <20240910-can-m_can-fix-ifup-v3-0-6c1720ba45ce@pengutronix.de>
In-Reply-To: <20240910-can-m_can-fix-ifup-v3-0-6c1720ba45ce@pengutronix.de>
To: Jake Hamby <Jake.Hamby@Teledyne.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Dong Aisheng <b29396@freescale.com>, Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-88a27
X-Developer-Signature: v=1; a=openpgp-sha256; l=3272; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=mbVDCRapSOpKHRR55fz8X1zmXSNQUHiv00j4qnpIfCw=;
 b=owGbwMvMwMWoYbHIrkp3Tz7jabUkhrQHdZttF/r0xgi4Mm+fsyH7F7eXT8vB2y1fxU/zx84P8
 IryPVfeyWjMwsDIxSArpsgS4LCr7cE2lruae+ziYQaxMoFMYeDiFICJmOlyMLQuPHSUt96lUm97
 8RR28ddcc40Fzzl/mz03OnNj7KTQxYHPD3u0aqZWJvNsfbu2qX85j0HSv/OfXr50WvFynfsjjd6
 pZs38FyL+OnnuX+P23VyKvbo73W6VEkNFdZ6Bk64yowSjbqFB9buS9qVfj7dppkU2SgvY3ruVZH
 4kdJnByTzdl7XH5/5cz3r2k9YmqZt/lTYErLf7N1F81x/16munogWnMzeedfNNnp7okRsTLH7is
 rLd112Tt79tPjorPZbjwIFmr02vHscs9r0cGbIubEdNRlrx7Jt94rl2DAatFx/kO8yU8Jk+Vdbr
 nJsO7xMe4Tvvjuzr8mXq0HKQKr3+rkdV2WELy7QG3chgAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Jake Hamby <Jake.Hamby@Teledyne.com>

If an interrupt (RX-complete or error flag) is set when bringing up
the CAN device, e.g. due to CAN bus traffic before initializing the
device, when m_can_start() is called and interrupts are enabled,
m_can_isr() is called immediately, which disables all CAN interrupts
and calls napi_schedule().

Because napi_enable() isn't called until later in m_can_open(), the
call to napi_schedule() never schedules the m_can_poll() callback and
the device is left with interrupts disabled and can't receive any CAN
packets until rebooted.

This can be verified by running "cansend" from another device before
setting the bitrate and calling "ip link set up can0" on the test
device. Adding debug lines to m_can_isr() shows it's called with flags
(IR_EP | IR_EW | IR_CRCE), which calls m_can_disable_all_interrupts()
and napi_schedule(), and then m_can_poll() is never called.

Move the call to napi_enable() above the call to m_can_start() to
enable any initial interrupt flags to be handled by m_can_poll() so
that interrupts are reenabled. Add a call to napi_disable() in the
error handling section of m_can_open(), to handle the case where later
functions return errors.

Also, in m_can_close(), move the call to napi_disable() below the call
to m_can_stop() to ensure all interrupts are handled when bringing
down the device. This race condition is much less likely to occur.

Tested on a Microchip SAMA7G54 MPU. The fix should be applicable to
any SoC with a Bosch M_CAN controller.

Signed-off-by: Jake Hamby <Jake.Hamby@Teledyne.com>
Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 012c3d22b01dd3d8558f2a40448770ca1da1aa1e..c1a07013433eb7b863eee072b959f46c1d5b008d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1763,9 +1763,6 @@ static int m_can_close(struct net_device *dev)
 
 	netif_stop_queue(dev);
 
-	if (!cdev->is_peripheral)
-		napi_disable(&cdev->napi);
-
 	m_can_stop(dev);
 	m_can_clk_stop(cdev);
 	free_irq(dev->irq, dev);
@@ -1776,6 +1773,8 @@ static int m_can_close(struct net_device *dev)
 		destroy_workqueue(cdev->tx_wq);
 		cdev->tx_wq = NULL;
 		can_rx_offload_disable(&cdev->offload);
+	} else {
+		napi_disable(&cdev->napi);
 	}
 
 	close_candev(dev);
@@ -2030,6 +2029,8 @@ static int m_can_open(struct net_device *dev)
 
 	if (cdev->is_peripheral)
 		can_rx_offload_enable(&cdev->offload);
+	else
+		napi_enable(&cdev->napi);
 
 	/* register interrupt handler */
 	if (cdev->is_peripheral) {
@@ -2063,9 +2064,6 @@ static int m_can_open(struct net_device *dev)
 	if (err)
 		goto exit_start_fail;
 
-	if (!cdev->is_peripheral)
-		napi_enable(&cdev->napi);
-
 	netif_start_queue(dev);
 
 	return 0;
@@ -2079,6 +2077,8 @@ static int m_can_open(struct net_device *dev)
 out_wq_fail:
 	if (cdev->is_peripheral)
 		can_rx_offload_disable(&cdev->offload);
+	else
+		napi_disable(&cdev->napi);
 	close_candev(dev);
 exit_disable_clks:
 	m_can_clk_stop(cdev);

-- 
2.45.2



