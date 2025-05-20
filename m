Return-Path: <linux-can+bounces-3594-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD15ABD2FC
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 11:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9546A4A7310
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 09:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64F2267B6F;
	Tue, 20 May 2025 09:14:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10F267385
	for <linux-can@vger.kernel.org>; Tue, 20 May 2025 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732474; cv=none; b=ErAHcsrFAr0SMFTZyhF4/DUKsa+2IlcYwbDWGbZzwmEJJ6GtxeC9mvVs8xTCfcM/S+kzy6WgI0NUgzkSBGvxOHv2lBpdSsvMdTMfMCYfcGRAXa8cneT8PzZ++vncvVpivKlaDrUVH8OANcN/9KKCRPBwG9GiFzzGdE1flJNuW+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732474; c=relaxed/simple;
	bh=3tzRD9W56FMabCX5VW4Sp5jloX5lFKn6kDuCC3ehpNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKdAxxOwfASbMbCj9UN+g93yYK+LCj8/1+X0EJY8Kxxt+GsxUosk4K012M7bsNoxPrDMjgtCBH/Qs1mzE0O4Dbq4LHN4AfLzAXNcF+x+iZknvyXpAXkVFTQvguV8f20r5hXbIciRNDcbrDHpLBNfZdMkdJQZwj9Q3Ld0zZBl73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uHJ3P-0007qh-Ix
	for linux-can@vger.kernel.org; Tue, 20 May 2025 11:14:31 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uHJ3P-000O6V-10
	for linux-can@vger.kernel.org;
	Tue, 20 May 2025 11:14:31 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 030E0415A42
	for <linux-can@vger.kernel.org>; Tue, 20 May 2025 09:14:30 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E0045415A2C;
	Tue, 20 May 2025 09:14:28 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9f47aa23;
	Tue, 20 May 2025 09:14:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Anderson Nascimento <anderson@allelesecurity.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 3/3] can: bcm: add missing rcu read protection for procfs content
Date: Tue, 20 May 2025 11:11:03 +0200
Message-ID: <20250520091424.142121-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250520091424.142121-1-mkl@pengutronix.de>
References: <20250520091424.142121-1-mkl@pengutronix.de>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

When the procfs content is generated for a bcm_op which is in the process
to be removed the procfs output might show unreliable data (UAF).

As the removal of bcm_op's is already implemented with rcu handling this
patch adds the missing rcu_read_lock() and makes sure the list entries
are properly removed under rcu protection.

Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
Reported-by: Anderson Nascimento <anderson@allelesecurity.com>
Suggested-by: Anderson Nascimento <anderson@allelesecurity.com>
Tested-by: Anderson Nascimento <anderson@allelesecurity.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20250519125027.11900-2-socketcan@hartkopp.net
Cc: stable@vger.kernel.org # >= 5.4
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/bcm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 871707dab7db..6bc1cc4c94c5 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -219,7 +219,9 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
 	seq_printf(m, " <<<\n");
 
-	list_for_each_entry(op, &bo->rx_ops, list) {
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
 
 		unsigned long reduction;
 
@@ -275,6 +277,9 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 		seq_printf(m, "# sent %ld\n", op->frames_abs);
 	}
 	seq_putc(m, '\n');
+
+	rcu_read_unlock();
+
 	return 0;
 }
 #endif /* CONFIG_PROC_FS */
@@ -858,7 +863,7 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 						  REGMASK(op->can_id),
 						  bcm_rx_handler, op);
 
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return 1; /* done */
 		}
@@ -878,7 +883,7 @@ static int bcm_delete_tx_op(struct list_head *ops, struct bcm_msg_head *mh,
 	list_for_each_entry_safe(op, n, ops, list) {
 		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex) &&
 		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return 1; /* done */
 		}
@@ -1296,7 +1301,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 					      bcm_rx_handler, op, "bcm", sk);
 		if (err) {
 			/* this bcm rx op is broken -> remove it */
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return err;
 		}
-- 
2.47.2



