Return-Path: <linux-can+bounces-7819-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vPuEMHieKWr2agMAu9opvQ
	(envelope-from <linux-can+bounces-7819-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 19:27:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AC566BF1A
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 19:27:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=YHE95iQ7;
	dkim=pass header.d=redhat.com header.s=google header.b=bOkLc3Q0;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7819-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7819-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9964930A3C0F
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 17:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC2A342C8B;
	Wed, 10 Jun 2026 17:25:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3B1344029
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 17:25:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112354; cv=none; b=fs2u2nZHQxHfTMaAA26iQPDj2J8P7R0jSR3IcULmiBt/T6sktxbVWs2H7L/F4+4B4HULJp0Yb/TuUJumxymoe96pWyXclxyXI3Lt9LzlH7doPZx2xKcZRd+GJaRBVrdJEX2D5mrkpnA0jSk3fWzI2IVauQzXPtBgsP46dqju5yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112354; c=relaxed/simple;
	bh=+9e/Pz1o2bsa0lWwYogk6/aWnufOJjVRb25UEQoVFo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sFTZdjGMt0wS+hzd4WYxKgWR2trSgEJ5E6v5SEpyy8GVhX74Hfzp7NBFYu5YAY2ZjcJS8yaDrNJyh50d8RKi5NAglYleVuVb0HQGIr5HQTDjhJJp9GdodMOdodzfB6/9yxWQj1MLHp/4T5JS03i4Vp/y+t4s0q80ISoMRNIGxvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHE95iQ7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bOkLc3Q0; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781112352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjAJ3EDbGUOC/7t8kJuzBXHoOIupKuhiVb6ZzLBlJMk=;
	b=YHE95iQ7JlOvcx829W4qAx8se7apG0KBm7/gdbWlOAqJkTBZJs3q59HiqOaebNLx5v6hpJ
	WMzvo4t6sDgVDrWqjuMne62wrmn3R4rgZ3onLvmS/h6Vd9J5GiOEATZE8sOdUTwJbPOrTF
	yu1rpovKGnZm8r5/CGHvKBLMmXdLY1g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-LZ3ULJC3OsuIBh-GagFOtA-1; Wed, 10 Jun 2026 13:25:51 -0400
X-MC-Unique: LZ3ULJC3OsuIBh-GagFOtA-1
X-Mimecast-MFC-AGG-ID: LZ3ULJC3OsuIBh-GagFOtA_1781112350
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-915757be497so1219164985a.2
        for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781112350; x=1781717150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjAJ3EDbGUOC/7t8kJuzBXHoOIupKuhiVb6ZzLBlJMk=;
        b=bOkLc3Q0FrVUThuWmppXWoDIpCjrwarXmwylqHCPxRYxpLjsThuQFvs0yOds4UIk5K
         d2fQENRNNMm2kTUOnVU9Zw/BjnAT+c/8yekzbYKr2Zb9wAs/MNLH5R9zg6E9qks3P+xm
         XeuKV/Gp1fRAEGXAWbpckHKzF1oyGL3G5TjUGb8PJpE1Z2R3Gq/KCGXJwGhhj01lBve0
         eHC9qJlUlgR5mXJtuXoESxkLl21Kz1CudsGjfr1Pw//G2G82iX1Vc5IVjDyPGr1ThQ6M
         BOiEb+mOeQQx+l7eTfTbTlDWZssBt9QfF1l/U0zNqC7sbsb/vTJOsXDNkrURuUZknR4A
         vGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781112350; x=1781717150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZjAJ3EDbGUOC/7t8kJuzBXHoOIupKuhiVb6ZzLBlJMk=;
        b=SNiZ+Ex6m9tVQdrHp/61NVKUASw8ij0B5QlgkRBgG8yxL4DcJ2fsiIUQ+aG430h1+R
         uvSX/BwLHerqyij31SgMUm+Cm4hdZ5oNWn+5QDVo396v+xnUWO81YdJmbJnaLcdctLUL
         Kr1nrE6iXcc37fIeBypkpaYUJHY0M3PhO9U9Uo6oP0q7kF4OJ9pTqEuR3ogc4n0EDoaC
         qMs6b/9O0RvxM2U9TiUWbyxNI913SxjXUKE9hu8+I9PwI4MTNqeGDaFUiQ6fqed9yFBF
         5HO0zuB3wfCw4CP/lL9yxeyuXzylQLpgRIf7aeO4FSxSHBWYCf4SBZQdXLQOWITtaSHQ
         bXFw==
X-Gm-Message-State: AOJu0Yw+BPM0Dm5rD5S6wF6QbAFLT+LH5T9Y3AsyeA4WuKmcbfmwzjvU
	7Ms1eObYCL0Xm7cdSdR05nAk/3gdbKnyGxxLn0SeCo70qbjGLZYiWxs15wNuG4UIFN/wDHrCgvc
	rygrmrw3NsNjpzwXr8visWXqfziZaW73+q6k+4wlBI3qtI1jFGPTYXjjaegyNCg==
X-Gm-Gg: Acq92OGO0mrWBTCv5cmsoLyPqBVAlrUHxnqlR5pQ7zngFMbDF4h3YLyBF0x25Fo2vAk
	8/hbJuEUmHdGcLJPnCEotF80xTPviQbqgUsYpQE+Bz91b/zg4SNQ9Aq5VNeeHaTrkdNIS15jc5Y
	PckkXewubnk4BliM831Gab+Ce/0f6N0ppvZ6vEthbGilOpKyF7thr5NFuIx0S4F5Czo1v6zR5tI
	fJlAZyLclvrwyKJCX4fqnh0GAickz9qQF2hwI6sYv4hYo86RUdUHBnp7e8C1y+/5U84cL3J0zLW
	vOBhGUHp+J/SB9bWu2Ox92hd7NGoulnYdkBFhO86Rk/xjGbJFHIlceO9j0nybXRk40M2wTq/FbP
	alxTt5LhRyZ94taPdFwtfXLninQaEr+YSHgys8mkH0UaOs3iFTlskYE1CEkZGY9yZA/k1aCoeTL
	3CgVMPm8U5l3km1xJB0Vh8CS8QBGxO+EWHUMQC
X-Received: by 2002:a05:620a:4009:b0:8da:e62d:888f with SMTP id af79cd13be357-915a9de47e0mr4264511285a.53.1781112350332;
        Wed, 10 Jun 2026 10:25:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4009:b0:8da:e62d:888f with SMTP id af79cd13be357-915a9de47e0mr4264503585a.53.1781112349638;
        Wed, 10 Jun 2026 10:25:49 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb (net-93-66-125-181.cust.vodafonedsl.it. [93.66.125.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a381abfsm2532946085a.27.2026.06.10.10.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:25:49 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Date: Wed, 10 Jun 2026 19:24:45 +0200
Subject: [PATCH can-next 2/3] af_can: store socket pointers in struct
 netns_can
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-feat-can-diag-v1-2-021e3f1631a0@redhat.com>
References: <20260610-feat-can-diag-v1-0-021e3f1631a0@redhat.com>
In-Reply-To: <20260610-feat-can-diag-v1-0-021e3f1631a0@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Urs Thuermann <urs.thuermann@volkswagen.de>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, Filippo Storniolo <fstornio@redhat.com>
X-Mailer: b4 0.14.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7819-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fstornio@redhat.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:robin@protonic.nl,m:o.rempel@pengutronix.de,m:kernel@pengutronix.de,m:urs.thuermann@volkswagen.de,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-can@vger.kernel.org,m:fstornio@redhat.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fstornio@redhat.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32AC566BF1A

AF_CAN sockets need to be stored in the netns_can structure
in order to be retrieved by the CAN diagnostic module when
a netlink request message is issued by the userspace.

On socket creation (`can_create()`), add the pointer to the
new socket to `netns_can::sk_list`. During socket release
(`isotp_release()`, `raw_release()`, `j1939_release()`,
`bcm_release()`), remove the corresponding pointer from
this list.

Since this is a prerequisite of the CAN diagnostic module,
deletes and insert operations are conditioned by
IS_ENABLED(CONFIG_CAN_DIAG).

Signed-off-by: Filippo Storniolo <fstornio@redhat.com>
---
 include/linux/can/core.h |  9 +++++++++
 include/net/netns/can.h  |  6 ++++++
 net/can/af_can.c         | 37 +++++++++++++++++++++++++++++++++++++
 net/can/bcm.c            |  2 ++
 net/can/isotp.c          |  2 ++
 net/can/j1939/socket.c   |  2 ++
 net/can/raw.c            |  2 ++
 7 files changed, 60 insertions(+)

diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 3287232e3cad92b8514bdad996fbaa02c8fe53fe..0c658ee4aab286e48eb5815640fedbd98a90b92a 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -61,4 +61,13 @@ extern int can_send(struct sk_buff *skb, int loop);
 void can_set_skb_uid(struct sk_buff *skb);
 void can_sock_destruct(struct sock *sk);
 
+/* function prototypes for the CAN diag module */
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+void can_add_sock_sklist(struct sock *sk);
+void can_remove_sock_sklist(struct sock *sk);
+#else
+#define can_add_sock_sklist(sk)
+#define can_remove_sock_sklist(sk)
+#endif
+
 #endif /* !_CAN_CORE_H */
diff --git a/include/net/netns/can.h b/include/net/netns/can.h
index 48b79f7e6236d9b4cf4bd57655f89e161faff05d..bcafff5e66697faf065b4a6b4ab009ce0c62dee7 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -36,6 +36,12 @@ struct netns_can {
 
 	/* CAN GW per-net gateway jobs */
 	struct hlist_head cgw_list;
+
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+	/* CAN diag support */
+	struct mutex		sklist_lock;
+	struct hlist_head	sklist;
+#endif
 };
 
 #endif /* __NETNS_CAN_H__ */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 65af259469854fc19cda0d7dd01c7b4da2ec0f4c..8e1be301fa0ca9dba4cbf1bbd27bfc62ddb19f18 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -111,6 +111,32 @@ static inline void can_put_proto(const struct can_proto *cp)
 	module_put(cp->prot->owner);
 }
 
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+void can_add_sock_sklist(struct sock *sk)
+{
+	struct net *net;
+
+	net = sock_net(sk);
+
+	mutex_lock(&net->can.sklist_lock);
+	sk_add_node(sk, &net->can.sklist);
+	mutex_unlock(&net->can.sklist_lock);
+}
+EXPORT_SYMBOL(can_add_sock_sklist);
+
+void can_remove_sock_sklist(struct sock *sk)
+{
+	struct net *net;
+
+	net = sock_net(sk);
+
+	mutex_lock(&net->can.sklist_lock);
+	sk_del_node_init(sk);
+	mutex_unlock(&net->can.sklist_lock);
+}
+EXPORT_SYMBOL(can_remove_sock_sklist);
+#endif
+
 static int can_create(struct net *net, struct socket *sock, int protocol,
 		      int kern)
 {
@@ -174,6 +200,8 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 		sock_put(sk);
 		sock->sk = NULL;
 	} else {
+		can_add_sock_sklist(sk);
+
 		sock_prot_inuse_add(net, sk->sk_prot, 1);
 	}
 
@@ -821,6 +849,11 @@ static int can_pernet_init(struct net *net)
 		can_init_proc(net);
 	}
 
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+	mutex_init(&net->can.sklist_lock);
+	INIT_HLIST_HEAD(&net->can.sklist);
+#endif
+
 	return 0;
 
  out_free_pkg_stats:
@@ -842,6 +875,10 @@ static void can_pernet_exit(struct net *net)
 	kfree(net->can.rx_alldev_list);
 	kfree(net->can.pkg_stats);
 	kfree(net->can.rcv_lists_stats);
+
+#if IS_ENABLED(CONFIG_CAN_DIAG)
+	WARN_ON_ONCE(!hlist_empty(&net->can.sklist));
+#endif
 }
 
 /* af_can module init/exit functions */
diff --git a/net/can/bcm.c b/net/can/bcm.c
index a4bef2c48a559cf7b0fa1d00d1fb1187e31359d8..63515306f499a602a58f7d1f103ff3a95f239e0a 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1594,6 +1594,8 @@ static int bcm_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	can_remove_sock_sklist(sk);
+
 	net = sock_net(sk);
 	bo = bcm_sk(sk);
 
diff --git a/net/can/isotp.c b/net/can/isotp.c
index c48b4a818297e2a1348a2b64016d0f4ff613e683..91736b28e7bfbed3e915666a2ae9d60ac0cec193 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1201,6 +1201,8 @@ static int isotp_release(struct socket *sock)
 	so = isotp_sk(sk);
 	net = sock_net(sk);
 
+	can_remove_sock_sklist(sk);
+
 	/* wait for complete transmission of current pdu */
 	while (wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0 &&
 	       cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) != ISOTP_IDLE)
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index ccd43ff5519c72f209b53bf74b833acd6ffe9728..cbfd0b8887680b48f4b941b851080f69b465433e 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -641,6 +641,8 @@ static int j1939_sk_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	can_remove_sock_sklist(sk);
+
 	lock_sock(sk);
 	jsk = j1939_sk(sk);
 
diff --git a/net/can/raw.c b/net/can/raw.c
index a26942e78e688721c9306f4e3fcbf25cd395a127..6cf47c53eb5336d15b4303612a960a833c62eade 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -418,6 +418,8 @@ static int raw_release(struct socket *sock)
 	ro = raw_sk(sk);
 	net = sock_net(sk);
 
+	can_remove_sock_sklist(sk);
+
 	spin_lock(&raw_notifier_lock);
 	while (raw_busy_notifier == ro) {
 		spin_unlock(&raw_notifier_lock);

-- 
2.53.0


