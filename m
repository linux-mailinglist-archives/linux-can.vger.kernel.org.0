Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22244C2706
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2019 22:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfI3UpG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 30 Sep 2019 16:45:06 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:50533 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbfI3UpG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 30 Sep 2019 16:45:06 -0400
X-ASG-Debug-ID: 1569871853-0a88186e22435ca60002-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.18.adsl.dyn.edpnet.net [77.109.119.18]) by relay-b03.edpnet.be with ESMTP id FKhx1UbNS7a4FWOh for <linux-can@vger.kernel.org>; Mon, 30 Sep 2019 21:30:54 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Apparent-Source-IP: 77.109.119.18
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 651CFA1A58A;
        Mon, 30 Sep 2019 21:30:53 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     dev.kurt@vandijck-laurijssen.be
Subject: [PATCH 3/3] net can c_can: make single isr when force_irqthreads
Date:   Mon, 30 Sep 2019 21:30:43 +0200
X-ASG-Orig-Subj: [PATCH 3/3] net can c_can: make single isr when force_irqthreads
Message-Id: <1569871843-28655-4-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1569871843-28655-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1569871843-28655-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Start-Time: 1569871854
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1730
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 1.0000 1.0000 4.3430
X-Barracuda-Spam-Score: 4.34
X-Barracuda-Spam-Status: No, SCORE=4.34 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76973
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When force_irqthreads is true, the top halve is already threaded.
There's no need to spread the work over 2 threads in such case.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/c_can/c_can.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index d25a0b7..3dea83e 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -1099,6 +1099,16 @@ static irqreturn_t c_can_isr(int irq, void *dev_id)
 	return IRQ_WAKE_THREAD;
 }
 
+static irqreturn_t c_can_isr_force_threaded(int irq, void *dev_id)
+{
+	irqreturn_t result;
+
+	result = c_can_isr(irq, dev_id);
+	if (result == IRQ_WAKE_THREAD)
+		result = c_can_thrd(irq, dev_id);
+	return result;
+}
+
 static int c_can_open(struct net_device *dev)
 {
 	int err;
@@ -1115,8 +1125,17 @@ static int c_can_open(struct net_device *dev)
 	}
 
 	/* register interrupt handler */
-	err = request_threaded_irq(dev->irq, &c_can_isr, c_can_thrd,
-			IRQF_SHARED, dev->name, dev);
+	if (force_irqthreads)
+		/* in case of forced irq threading, the top-halve is already
+		 * a thread, so the bottom halve could be appended directly.
+		 * For code re-use, the combined handler calls top & bottom
+		 * rather than recoding everything from scratch
+		 */
+		err = request_threaded_irq(dev->irq, &c_can_isr_force_threaded,
+				NULL, IRQF_SHARED, dev->name, dev);
+	else
+		err = request_threaded_irq(dev->irq, &c_can_isr,
+				c_can_thrd, IRQF_SHARED, dev->name, dev);
 	if (err < 0) {
 		netdev_err(dev, "failed to request interrupt\n");
 		goto exit_irq_fail;
-- 
1.8.5.rc3

