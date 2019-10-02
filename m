Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3778DC4870
	for <lists+linux-can@lfdr.de>; Wed,  2 Oct 2019 09:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfJBH21 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Oct 2019 03:28:27 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:55345 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJBH21 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Oct 2019 03:28:27 -0400
X-ASG-Debug-ID: 1570001304-0a88186e2244892e0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.18.adsl.dyn.edpnet.net [77.109.119.18]) by relay-b03.edpnet.be with ESMTP id 6csYkaPw1S4kF248 for <linux-can@vger.kernel.org>; Wed, 02 Oct 2019 09:28:24 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Apparent-Source-IP: 77.109.119.18
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 7BB6DA234B3;
        Wed,  2 Oct 2019 09:28:23 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH] can-rx-offload: free echo_skb when not queued
Date:   Wed,  2 Oct 2019 09:28:07 +0200
X-ASG-Orig-Subj: [PATCH] can-rx-offload: free echo_skb when not queued
Message-Id: <1570001287-32420-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
X-Barracuda-Connect: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Start-Time: 1570001304
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 589
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6929 1.0000 1.3158
X-Barracuda-Spam-Score: 4.42
X-Barracuda-Spam-Status: No, SCORE=4.42 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_SC0_MV0249, MARKETING_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77026
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.60 MARKETING_SUBJECT      Subject contains popular marketing words
        2.50 BSF_SC0_MV0249         Custom rule MV0249
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/rx-offload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index e6a668e..a8acb2a 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -238,6 +238,7 @@ unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
 
 	err = can_rx_offload_queue_sorted(offload, skb, timestamp);
 	if (err) {
+		kfree_skb(skb);
 		stats->rx_errors++;
 		stats->tx_fifo_errors++;
 	}
-- 
1.8.5.rc3

