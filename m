Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F5C68C6FB
	for <lists+linux-can@lfdr.de>; Mon,  6 Feb 2023 20:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBFTnN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 6 Feb 2023 14:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjBFTnL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 Feb 2023 14:43:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790AC10AB0
        for <linux-can@vger.kernel.org>; Mon,  6 Feb 2023 11:43:10 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pP7OO-0005wV-RI
        for linux-can@vger.kernel.org; Mon, 06 Feb 2023 20:43:08 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 3E457171C5A
        for <linux-can@vger.kernel.org>; Mon,  6 Feb 2023 19:43:08 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 56FFF171C56;
        Mon,  6 Feb 2023 19:43:07 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 306aa637;
        Mon, 6 Feb 2023 19:43:06 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: proc: properly format table
Date:   Mon,  6 Feb 2023 20:43:05 +0100
Message-Id: <20230206194305.2827376-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The table "/proc/net/can/rcvlist_all" is garbled if the interface
names are longer than 5 characters.

Consider IFNAMSIZ when formatting the table so that it looks like
this:

| receive list 'rx_all':
|   device              can_id   can_mask  function  userdata   matches  ident
|    any                   000   00000000  8e807747  9bc49fd8         0  raw
|   device              can_id   can_mask  function  userdata   matches  ident
|    mcp251xfd0            000   00000000  8e807747  ec6d80a2
|   0  raw

Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/proc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/can/proc.c b/net/can/proc.c
index bbce97825f13..62eeae453544 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -186,12 +186,12 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
 	struct receiver *r;
 
 	hlist_for_each_entry_rcu(r, rx_list, list) {
-		char *fmt = (r->can_id & CAN_EFF_FLAG)?
-			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
-			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
+		const char *fmt = r->can_id & CAN_EFF_FLAG ?
+			"   %-*s   %08x %08x  %pK  %pK  %8ld  %s\n" :
+			"   %-*s      %03x   %08x  %pK  %pK  %8ld  %s\n";
 
-		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
-				r->func, r->data, r->matches, r->ident);
+		seq_printf(m, fmt, IFNAMSIZ, DNAME(dev), r->can_id, r->mask,
+			   r->func, r->data, r->matches, r->ident);
 	}
 }
 
@@ -202,9 +202,9 @@ static void can_print_recv_banner(struct seq_file *m)
 	 *                 .......          0  tp20
 	 */
 	if (IS_ENABLED(CONFIG_64BIT))
-		seq_puts(m, "  device   can_id   can_mask      function          userdata       matches  ident\n");
+		seq_puts(m, "  device              can_id   can_mask      function          userdata       matches  ident\n");
 	else
-		seq_puts(m, "  device   can_id   can_mask  function  userdata   matches  ident\n");
+		seq_puts(m, "  device              can_id   can_mask  function  userdata   matches  ident\n");
 }
 
 static int can_stats_proc_show(struct seq_file *m, void *v)
-- 
2.39.1


