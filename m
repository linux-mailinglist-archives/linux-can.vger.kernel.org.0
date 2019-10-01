Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C49C2E4C
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2019 09:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfJAHkz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Oct 2019 03:40:55 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:60043 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733081AbfJAHkz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Oct 2019 03:40:55 -0400
X-ASG-Debug-ID: 1569915652-0a7b8d53c1e3e2b0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.18.adsl.dyn.edpnet.net [77.109.119.18]) by relay-b02.edpnet.be with ESMTP id hrSdpCE9mEexqrkG; Tue, 01 Oct 2019 09:40:52 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Apparent-Source-IP: 77.109.119.18
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id E7121A1D9D1;
        Tue,  1 Oct 2019 09:40:51 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     dev.kurt@vandijck-laurijssen.be, jhofstee@victronenergy.com
Subject: [PATCH 3/3] net can c_can: make single isr when force_irqthreads
Date:   Tue,  1 Oct 2019 09:40:38 +0200
X-ASG-Orig-Subj: [PATCH 3/3] net can c_can: make single isr when force_irqthreads
Message-Id: <1569915638-4605-4-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1569915638-4605-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1569915638-4605-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Start-Time: 1569915652
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1730
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8601 1.0000 2.8104
X-Barracuda-Spam-Score: 2.81
X-Barracuda-Spam-Status: No, SCORE=2.81 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76991
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
index 95de8e9..a4098a0 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -1101,6 +1101,16 @@ static irqreturn_t c_can_isr(int irq, void *dev_id)
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
@@ -1117,8 +1127,17 @@ static int c_can_open(struct net_device *dev)
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

