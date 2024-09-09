Return-Path: <linux-can+bounces-1451-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D3A971C8D
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 16:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1553A1F23797
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 14:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7842A1BA889;
	Mon,  9 Sep 2024 14:29:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203121BA286
	for <linux-can@vger.kernel.org>; Mon,  9 Sep 2024 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892193; cv=none; b=ec0IZ52XvsDeK1zZK4bJhlCJ/tBnWov1GlIxCpKUzu77bn7CAkEttPfDgC4TwWLPHv7ITbSsGFgTM99iehGbuJLZuCn9kMgb//zoRheJgrUmbzvjCbydTZQtytER25uZZXNGXYjrC0Ax9XPPUUU3c9bqu9MwGryQKTnvnCEEjq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892193; c=relaxed/simple;
	bh=4eZXYXgUSsLCVtVURyK9jTQpUUPi57sHvLt8I7wOtFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sy2LEzErla71CIaiZOf6YFOiDX7dz7pW2x2k4LuBJr/rBmOeSOgpTp1AJY8dGocTLzuUPmuswGffMi07XEiszlwo5pbbCgJwA0S4ojEv1fR0j5kq+rqZ6PJvGeIuZrHJ0RzrOueTh8idoLJS20/3SbJCGS1Nw5fxpF92rBoR1xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1snfOm-00026u-FJ
	for linux-can@vger.kernel.org; Mon, 09 Sep 2024 16:29:48 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1snfOm-006g3M-1f
	for linux-can@vger.kernel.org; Mon, 09 Sep 2024 16:29:48 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id AD7B2336B31
	for <linux-can@vger.kernel.org>; Mon, 09 Sep 2024 14:29:47 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 1606F336B10;
	Mon, 09 Sep 2024 14:29:45 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2a700a89;
	Mon, 9 Sep 2024 14:29:44 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 09 Sep 2024 16:29:35 +0200
Subject: [PATCH can v2 1/2] can: m_can: enable NAPI before enabling
 interrupts
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-can-m_can-fix-ifup-v2-1-2b35e624a089@pengutronix.de>
References: <20240909-can-m_can-fix-ifup-v2-0-2b35e624a089@pengutronix.de>
In-Reply-To: <20240909-can-m_can-fix-ifup-v2-0-2b35e624a089@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
 Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 "Hamby, Jake (US)" <Jake.Hamby@Teledyne.com>
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3348; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=GDyc89fVl7oa+JYqYaRz+Un6+0wGGF0q6aJsOmqnDdU=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm3wZTU4h3sWvs6kHz3rqg7zmCoQvF8jHgmRIn/
 XYtpbcfTlCJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZt8GUwAKCRAoOKI+ei28
 bzdzB/0cO2B27Rl6A+H+zuDccyF+7crS3R1DHhLJnRv27bnR8PJBJ2dTABQ51PCragyyspOb5pk
 609qx9OND2OVx75ilgrsyMDqX6otpEP6LfALPwkJCIN4of9pBIBlnv6DCWMPgCRzj+PPXZEVpBB
 cG0aP4ImBRtiYPjvVXUa0mkIheA1LKuwEGq6cEgpoTp2z7cNuBaL5gAIdG4TUtO3lCrQKrsisUo
 G3CAAcKHsGV5v7Mnlm2adG5tMxwjbY2cM9oSUIzwQV0033d5E0BSv7Q+gCcAGoGbTuwZI5mWrZo
 jTWJ/gstgCxPQibugqtqWtYZrvctAEoNIXuLpmVkJTNA82ET
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: "Hamby, Jake (US)" <Jake.Hamby@Teledyne.com>

If any error flags are set when bringing up the CAN device, e.g. due
to CAN bus traffic before initializing the device, when m_can_start()
is called and interrupts are enabled, m_can_isr() is called
immediately, which disables all CAN interrupts and calls
napi_schedule().

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
enable any initial interrupt flags to be handled by m_can_pol() so
that interrupts are reenabled. Add a call to napi_disable() in the
error handling section of m_can_open(), to handle the case where later
functions return errors.

Also, in m_can_close(), move the call to napi_disable() below the call
to m_can_stop() to ensure all interrupts are handled when bringing
down the device. This race condition is much less likely to occur.

Tested on a Microchip SAMA7G54 MPU. The fix should be applicable to
any SoC with a Bosch M_CAN controller.

Not-Signed-off-by: Hamby, Jake (US) <Jake.Hamby@Teledyne.com>
Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 012c3d22b01dd3d8558f2a40448770ca1da1aa1e..7754dd2d4cb110eee5b83885f5381aed9c67ce03 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1763,13 +1763,14 @@ static int m_can_close(struct net_device *dev)
 
 	netif_stop_queue(dev);
 
-	if (!cdev->is_peripheral)
-		napi_disable(&cdev->napi);
-
 	m_can_stop(dev);
 	m_can_clk_stop(cdev);
 	free_irq(dev->irq, dev);
 
+	/* disable NAPI after disabling interrupts */
+	if (!cdev->is_peripheral)
+		napi_disable(&cdev->napi);
+
 	m_can_clean(dev);
 
 	if (cdev->is_peripheral) {
@@ -2031,6 +2032,10 @@ static int m_can_open(struct net_device *dev)
 	if (cdev->is_peripheral)
 		can_rx_offload_enable(&cdev->offload);
 
+	/* enable NAPI before enabling interrupts */
+	if (!cdev->is_peripheral)
+		napi_enable(&cdev->napi);
+
 	/* register interrupt handler */
 	if (cdev->is_peripheral) {
 		cdev->tx_wq = alloc_ordered_workqueue("mcan_wq",
@@ -2063,9 +2068,6 @@ static int m_can_open(struct net_device *dev)
 	if (err)
 		goto exit_start_fail;
 
-	if (!cdev->is_peripheral)
-		napi_enable(&cdev->napi);
-
 	netif_start_queue(dev);
 
 	return 0;
@@ -2077,6 +2079,8 @@ static int m_can_open(struct net_device *dev)
 	if (cdev->is_peripheral)
 		destroy_workqueue(cdev->tx_wq);
 out_wq_fail:
+	if (!cdev->is_peripheral)
+		napi_disable(&cdev->napi);
 	if (cdev->is_peripheral)
 		can_rx_offload_disable(&cdev->offload);
 	close_candev(dev);

-- 
2.45.2



