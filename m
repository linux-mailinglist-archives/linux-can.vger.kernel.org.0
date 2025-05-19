Return-Path: <linux-can+bounces-3577-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D8EABBE5B
	for <lists+linux-can@lfdr.de>; Mon, 19 May 2025 14:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD9C189AF99
	for <lists+linux-can@lfdr.de>; Mon, 19 May 2025 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D881E7C2E;
	Mon, 19 May 2025 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="r38Kgj9P";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hCK4SnHd"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8239278E44
	for <linux-can@vger.kernel.org>; Mon, 19 May 2025 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659246; cv=pass; b=jsR4ggiGeaOOmJM3b7eQL623J2jhJx1VR5nBbXNz7X+NgGnUiKY8u9x9iArac+Oc8TieEBMkczoxaywE8S/jj9E5UuppXHIdTvuq+ojkNYGzqKOBWzZYIMbLqPqQq5q49C6yOl8T4ZrIQRRHja3/XpjiVoEgnxwZgJo+XovDAME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659246; c=relaxed/simple;
	bh=x4mdLk0wrSkSbFIbMa/YmOGtCmi2JvuW8mZaQqIv3vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWfjDORIVR6x3nXwmadSaEMag1StVayBJeAds4xLi282Gd6m6y8A2eNZmBpBwW5+Wx8PBt7V8zlOF9Ky7mGuP+Towr2IWdV4oZbufVgCkx38HvMjYR76BFhKdPQGcWCQWdVVkAnjj5GqF3F3NrC0QMQkL5m0uv1zmQFmt+bXJiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=r38Kgj9P; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hCK4SnHd; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1747659052; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UUIsFqX4oPRhMGubsQivMooRwlGkh/aJuJFTeU9/VHJE8XoOGtQS2eooHupvRijX7q
    IXSnqOXqyx5wrE84rKHwteEBUi5fls0yoJ4Ep7F/mabUwplWJg+xNCxP2AZ+sfRudA0c
    GuKGY/uwLWqPn7hkT+kkhNAfepzWN7nUxv0mkZUdsmUJXHRd03ZllvRPWPNTnBvj+yoY
    e9/2N4yecItEjMDHmD4s596mHe9N3W1Q2sRogDUfRPYNqC+YcDpL2Z/Rp+rDK3PTSDT0
    UqdNuHIyHlH7F5wHLpBqb+xK7+cA5f5wbhQao9+h1BAXMMfxDlTpgKich/MEJZjoqyZt
    2BgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1747659052;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=w2aB+VTIrm0FM0pXMYUib8yJxYkEEVq6WpMV4SP4aVg=;
    b=nInjW/HhQR89jwixG+YcHhtBQu2hEmZ1ddNXLAweDoI5tsSlCfe2OADG8WSPM4/cR1
    A3YQGjXNv0hpey6jHlIJj7s0Facbm0uQNnShC9E9jEaBDI8yEejM9+ZnepQVACDoJ9aP
    jAS6h3ypCqVkkUgO5d+u0nUG6OfyADVskXiauxSIwcaq1EhTH3M5aButyeaeh7TyxXi1
    eeAsQFIO6D8dj5XT+9wLRGWdLTkyktbwrvmMMWsZMIQkZ556PrI4/1FXKvhP1DVYuDfl
    c82pQsePkrJK5dheD6Hea8eowtSflId+QrPitWRA7uQHDjAJeJXGuMDEL5zRJc8T39Ns
    UIEQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1747659052;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=w2aB+VTIrm0FM0pXMYUib8yJxYkEEVq6WpMV4SP4aVg=;
    b=r38Kgj9PUANRk2LYgHKbBfWTNzDu2FHVM6AzEmJZV0Cb2zz9tVoGFw81dYjQoyiQMs
    SIAd+z3rEJN+9yqsbeql9cRn/TagCw59Mk0I/OPZHf+kdYpnwkrkridxHqOtSEgJu/QO
    ezSHbRUwMijsll90UnzZ49Fq9R4ydDSzmGXCKRTtZCKRa2y8oScuTlHsr+lbgosNpB/L
    zIjUhbbBhgoLNH+7YNmT3nu9qfA5ePypCC3+6sa8xVXPbejTwUJIxj6/7YX1y1sW6/vU
    Oc2u2FU1Ifinf+/aeKr+PERa5czR/CV5MIAViZqal7n3iM4N6RRzoBdaf0/Xpl2JoYmU
    TrZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1747659052;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=w2aB+VTIrm0FM0pXMYUib8yJxYkEEVq6WpMV4SP4aVg=;
    b=hCK4SnHdYsWZxepzK2+k4F7gnDcbsRWc+/FOcVoJRcruSmtUp1pWe8mhG5eUEV948u
    epmiCN1sINzYpPKByCCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514JCoqDpo
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 May 2025 14:50:52 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Anderson Nascimento <anderson@allelesecurity.com>
Subject: [PATCH 2/2] can: bcm: add missing rcu read protection for procfs content
Date: Mon, 19 May 2025 14:50:27 +0200
Message-ID: <20250519125027.11900-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250519125027.11900-1-socketcan@hartkopp.net>
References: <20250519125027.11900-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

When the procfs content is generated for a bcm_op which is in the process
to be removed the procfs output might show unreliable data (UAF).

As the removal of bcm_op's is already implemented with rcu handling this
patch adds the missing rcu_read_lock() and makes sure the list entries
are properly removed under rcu protection.

Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()") # >= 5.4
Reported-by: Anderson Nascimento <anderson@allelesecurity.com>
Suggested-by: Anderson Nascimento <anderson@allelesecurity.com>
Tested-by: Anderson Nascimento <anderson@allelesecurity.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 871707dab7db..6bc1cc4c94c5 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -217,11 +217,13 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 	seq_printf(m, " / bo %pK", bo);
 	seq_printf(m, " / dropped %lu", bo->dropped_usr_msgs);
 	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
 	seq_printf(m, " <<<\n");
 
-	list_for_each_entry(op, &bo->rx_ops, list) {
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
 
 		unsigned long reduction;
 
 		/* print only active entries & prevent division by zero */
 		if (!op->frames_abs)
@@ -273,10 +275,13 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 				   (long long)ktime_to_us(op->kt_ival2));
 
 		seq_printf(m, "# sent %ld\n", op->frames_abs);
 	}
 	seq_putc(m, '\n');
+
+	rcu_read_unlock();
+
 	return 0;
 }
 #endif /* CONFIG_PROC_FS */
 
 /*
@@ -856,11 +861,11 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 				can_rx_unregister(sock_net(op->sk), NULL,
 						  op->can_id,
 						  REGMASK(op->can_id),
 						  bcm_rx_handler, op);
 
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return 1; /* done */
 		}
 	}
 
@@ -876,11 +881,11 @@ static int bcm_delete_tx_op(struct list_head *ops, struct bcm_msg_head *mh,
 	struct bcm_op *op, *n;
 
 	list_for_each_entry_safe(op, n, ops, list) {
 		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex) &&
 		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return 1; /* done */
 		}
 	}
 
@@ -1294,11 +1299,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			err = can_rx_register(sock_net(sk), NULL, op->can_id,
 					      REGMASK(op->can_id),
 					      bcm_rx_handler, op, "bcm", sk);
 		if (err) {
 			/* this bcm rx op is broken -> remove it */
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return err;
 		}
 	}
 
-- 
2.47.2


