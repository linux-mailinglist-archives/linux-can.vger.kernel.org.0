Return-Path: <linux-can+bounces-7140-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK+AEJDquml0dAIAu9opvQ
	(envelope-from <linux-can+bounces-7140-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 19:10:24 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DFB2C1052
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 19:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2B8B311A9D9
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7790030BBBF;
	Wed, 18 Mar 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="IB4JbHsB";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="qbA9qZKm"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C485130F92E
	for <linux-can@vger.kernel.org>; Wed, 18 Mar 2026 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855267; cv=pass; b=e/N9EABrZoJqf964nKuQv5e+WlyepcW0aiUUQ5AgMNxhImdPxBbQhWje8SFh2TBdVv8o1tG9rjFLxEbZO+6LZWiqllLUEITlImoYZYKBQvAoOjQnb8RR9x8NAToda+L9xOZAD35xRBUPij+7xOikCjXBm9faMISDt0AAJHVj/P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855267; c=relaxed/simple;
	bh=dLAoRxSCbPire0zXwYPqE+BQ1d+tA7PkHWqDOMTZgJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aJq814eUTjDZKo6skrN6MGGEKVgj6WGonqKZz0pZmS8Z33ddxj+cMLFtFE/HRhJfV0T6rLsG//+25/wGGBrOfpaSaqOE4erPyZXBp1hJWUtUnkwjnPXVwJXzK3rA13Y9IUDRLzwlyHNdgXqjaM9dQ0djSXQEVYf9q/mqn+yYZk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=IB4JbHsB; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=qbA9qZKm; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1773855261; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PcmJ1AzbNp5aCGs1i6qXeBGZJbCeW7XOUF3uiLs1d7zwJnyRfpwL1oS9fRBZxmDdbe
    cQ4LreJC7EFYQlFEbWfzME8Gji+Dj0oi0/7oNyBOTGcm10QwstQKIXpbS+RI/VkQZhtu
    1JC1pqX9tM4WK5sXiMI3Wn73Zbda8x1Wf251hCjbfZFm3v9p9PYQ6qYdDYW3Bf4bjtbM
    c4uedAcIGqPKNSQfRsX7GxsotywNFi/TPBbvXhjSL12FwhkdCIVMUpxXwmdG/HA7/X4G
    CYZHKUcQQvuOfxdFfC9qIYhTThFRLlsHXnOVufyeWjCV6kKqeXJoYPW/k//WLjmv9Rjv
    2Yfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1773855261;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=K13GPOGK2TPvHMISmizaQcGGMPVSHrkMMqBbdrkpYkw=;
    b=qgadUiUE+I65bwFboQ95SIm+4+He8RoPRyY1NdTykxg6VSZJZolSgKf1Xg1YeawupE
    6JndHzyde49gJyB2X9yjlxiojaEbZI3xT6Mh897ZP2ALLC4p8q8SaCzAz48eg+bd96V7
    jFs24Nll4FNyvmEcyGS8Hqv30KBKXomqVKI2xlVZC78bYZZEtORaFNxqGpHpWMc35vdO
    wuKFEAWFEI3B05K59GkAwPcFMwyI7JAH3P+MR3esRnG9CABo4ETF9AAXKLC9cWKrVYZp
    3nFTxrIT17ikc0gd5QLGxLs/ia3+o6y2GmwGQIc88vzj/sNrGQl1LAoqLsu+k6/qEP6L
    dj8w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1773855261;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=K13GPOGK2TPvHMISmizaQcGGMPVSHrkMMqBbdrkpYkw=;
    b=IB4JbHsBAdUDvObd/7+9gFuvibqnWY7WsiFtmJ5N6M9N9LThJ3Hns2W3R3vSkepxy/
    Ri25SiGRLs2PXnV/37Xyky4bUDay9dSIz6lSb7bAKXqFeIdjW/sDIgl+YY9dA17a34be
    kmRoNWMtK9PiOTSYj4ajFm9KLSbAopAQnRmLF4ZcWeutSog72DqESvygKK1MMU4Z2ZUR
    89bQj9oH/mYsP6UpHAGHVGiq03PPPQTk53tCoI9GDoGxNVXltrAtSll03C8c9WI8djdS
    ujKcYf09Y6ln3iQVbIhA5N0qN1ijhkWtda/5VbCuMbzGTsihVL2elv3WZiiaXd8eboLa
    XKBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1773855261;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=K13GPOGK2TPvHMISmizaQcGGMPVSHrkMMqBbdrkpYkw=;
    b=qbA9qZKm/XKOIjoJ7t1n9dKCLWegrnQhXSQPbU5HCqX/VjnMJUt/rOEPZgO++ryF2U
    ZX2ekygMg4VWc1E0eHCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d22IHYLp4G
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 18 Mar 2026 18:34:21 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2] can: statistics: add missing atomic access in hot path
Date: Wed, 18 Mar 2026 18:34:13 +0100
Message-ID: <20260318173413.28235-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7140-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hartkopp.net:dkim,hartkopp.net:email,hartkopp.net:mid]
X-Rspamd-Queue-Id: 50DFB2C1052
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 80b5f90158d1 ("can: statistics: use atomic access in hot path")
fixed a KCSAN issue in can_receive() but missed to convert the 'matches'
variable used in can_rcv_filter().

Fixes: 80b5f90158d1 ("can: statistics: use atomic access in hot path")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/af_can.c | 4 ++--
 net/can/af_can.h | 2 +-
 net/can/proc.c   | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index f70e2ba0aadc..7bc86b176b4d 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -467,11 +467,11 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
 	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
 	rcv->can_id = can_id;
 	rcv->mask = mask;
-	rcv->matches = 0;
+	atomic_long_set(&rcv->matches, 0);
 	rcv->func = func;
 	rcv->data = data;
 	rcv->ident = ident;
 	rcv->sk = sk;
 
@@ -571,11 +571,11 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 EXPORT_SYMBOL(can_rx_unregister);
 
 static inline void deliver(struct sk_buff *skb, struct receiver *rcv)
 {
 	rcv->func(skb, rcv->data);
-	rcv->matches++;
+	atomic_long_inc(&rcv->matches);
 }
 
 static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buff *skb)
 {
 	struct receiver *rcv;
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 22f3352c77fe..87887014f562 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -50,11 +50,11 @@
 
 struct receiver {
 	struct hlist_node list;
 	canid_t can_id;
 	canid_t mask;
-	unsigned long matches;
+	atomic_long_t matches;
 	void (*func)(struct sk_buff *skb, void *data);
 	void *data;
 	char *ident;
 	struct sock *sk;
 	struct rcu_head rcu;
diff --git a/net/can/proc.c b/net/can/proc.c
index 0938bf7dd646..de4d05ae3459 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -194,11 +194,12 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
 		char *fmt = (r->can_id & CAN_EFF_FLAG)?
 			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
 			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
 
 		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
-				r->func, r->data, r->matches, r->ident);
+			   r->func, r->data, atomic_long_read(&r->matches),
+			   r->ident);
 	}
 }
 
 static void can_print_recv_banner(struct seq_file *m)
 {
-- 
2.51.0


