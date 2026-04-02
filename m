Return-Path: <linux-can+bounces-7321-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAheLP9KzmmgmgYAu9opvQ
	(envelope-from <linux-can+bounces-7321-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 12:54:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D61F387F7B
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 12:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A786B301D6DA
	for <lists+linux-can@lfdr.de>; Thu,  2 Apr 2026 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F2635E95A;
	Thu,  2 Apr 2026 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dx+jUTbX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gw2SdUgC"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B19318B96
	for <linux-can@vger.kernel.org>; Thu,  2 Apr 2026 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127294; cv=none; b=Lvk975yQsbe0kOlbe+3Qkg33wLryegzAOi+H0K0KYmCZBox37862uBgPnLhzeJ2LWDhY3/PvPM7Gtn6Mnqgz9C6Pb2ny2nkNGifcTbQOWbX2AbuSNNwXkVXcbaUTDZxdaxPWZQdNFeDuqjdE9rOhg6DoEMrlPpMeORCi6db39p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127294; c=relaxed/simple;
	bh=KnbxA4/ZS/K4w/uuNjnLIAhWXLC6xG/uEcjmra27Dy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VqQSLCLhLGzOIXR8kXhwL7jBBO+91yhMZk37JQSwkpU4PAy8SgXZJrhmsAJmBsmvrdJJQ5bVQAMYsUv23sfG8T4W7hJw3vJ1ZHpg5HjIw3yrKRYx4OVPy7riRtZwb89LK2gbjS3Ixxc/UXHKrJZQEgyb10EZOxfk9sKS4FPDH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dx+jUTbX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gw2SdUgC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775127291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSMTpx5ccLlUf6NiBECXHZe9nnV3VH2VyAm3RFtFFF8=;
	b=dx+jUTbXfFdYqKhjzPZ0N5E1IdEJIE7lx1a2Fx7kkB9bDrKIFkujAYpxuuanp6T86xMWHf
	0DcdPyv+vq1lNdtyHE1M+2YznvV/D+51OhIoaKl2gDKXd4HoN0yGD/Qw5CAu4OTryOnDRb
	y97dtBF1tpdaKzQN2mwwtHLT3qhD6jc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-NftOhSzpPXKXTmb2OsRofg-1; Thu, 02 Apr 2026 06:54:50 -0400
X-MC-Unique: NftOhSzpPXKXTmb2OsRofg-1
X-Mimecast-MFC-AGG-ID: NftOhSzpPXKXTmb2OsRofg_1775127290
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48531e6012bso7149065e9.1
        for <linux-can@vger.kernel.org>; Thu, 02 Apr 2026 03:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775127290; x=1775732090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSMTpx5ccLlUf6NiBECXHZe9nnV3VH2VyAm3RFtFFF8=;
        b=gw2SdUgCSrgLgTByWVgu6YJuBgu9N5/vKXvYPsHZv65kE11f1J3WH8KwdqZlZNvWZx
         Pum52pVRtKRmixdG8dBKYN+Ip7RZZUYwyjBu0eVahXIOQRJYA+bDPHeX3qfeuK1nIGWA
         NUn5u2xce8wQKwqwqf0r/RPNn9Ccdi7yVuq4VjRiv3vXQi6RLwfQGQ3CPgsurC+YrIIu
         1ZBdBVkWOhUNZau+hES4pEy8+UQ4m9FHljWG0hxu/m2ernjU3hZUX3QYYlRfEDHVk/6d
         FQ9cpBH1BNuU2rjE2Z0+FT2/8SOmsWIFQ8ajzC0KfhY1x+7uuXI8ayoId2omv/NVTnbm
         zMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775127290; x=1775732090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NSMTpx5ccLlUf6NiBECXHZe9nnV3VH2VyAm3RFtFFF8=;
        b=hmncy4q9F/quAACMx5cFjg+mG18Sve9wOsv/NWaZgEgL83h1yKCfK0VF5zUiJuwnIB
         S/cI2fZejsX6NGFz9VUvXyEIzi5pAeP5gVbs4b+0wCiexrejqk3Z9gQKHzoWvtLjAIL6
         lI1SMQfFTtZdLq9EaEixdnMdTacowVWwh2hDSnHB01YhppJhfmqCl+mvYie8P0zuiOuy
         pKO4e2qVNGqaBVwR35crckOxM8yr+udFLuQhszvOa+1BfiYcGtH2P7sa40cyRCxAZTNl
         O3RwX9dPAJI3hmen852at8wZnQa8izlY3y/U6eJGHLDUxy9TsSDCTZTGcmKJAkc+KK4t
         3/8Q==
X-Gm-Message-State: AOJu0YwGWLZn5XzKgQQ++6ncv5xUaFsoRJWDGCO7OuCbw8CP1Nj9ZU+m
	XnvQP3sHaTn9baBXE443E0HZZTmTVAi80uXuU3qM0IEWlUAralDJ4NktePqjCG0TbajYXqiBfWX
	NovNpj0h1ry31hJVripzPnkR+Ep07mZrmU/FyA6vbRkpeDlohq7vXC6Z1HiAkqg==
X-Gm-Gg: ATEYQzzoxtQpsN7igZPdXa8EJM4IrO/f1EMAZ6aO75J6SE7vpabhqcW5qqdpnR5JKFQ
	B1Sv44gNXh/lVXRaT7KHLmLOAD0vCqcXFo0r4EsZvzSsZm7EwzXd8CL1bQc3yIjuLQ+S0kwZbfQ
	X4c37Dv12umSNgqtZdQlfsTZ9pppEmN/ehyUW4nBMIFtWH1qgLPA+BV4vYxgQNMpH7GlCEN4fsG
	YhgWzMpP/oEU4PseH2UBILc8xV36Veo8OfzU8u41Li5VJA06p7S3AdcqmfyVWwREH8YWeN30oB9
	cN8ccyrQtyg91Sxh2nwtb8GVCrbTHXRkdlEs3FB1fPUl8e1sftn8KXVF9BK2nn5auiIk1cv9Ova
	FdBOqSnZH2Qc063il9AW5n+ra6CRvoifhLI+L6GjOcJtrsHr5Ftaou4Fs2qL79oQgj4cb2x0Nqv
	Qn1BeEHtcoFIT0tdQ6CA==
X-Received: by 2002:a05:600c:1d16:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-488835a58cdmr118245255e9.25.1775127289524;
        Thu, 02 Apr 2026 03:54:49 -0700 (PDT)
X-Received: by 2002:a05:600c:1d16:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-488835a58cdmr118244675e9.25.1775127289000;
        Thu, 02 Apr 2026 03:54:49 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb (net-2-34-60-62.cust.vodafonedsl.it. [2.34.60.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887a630922sm234489435e9.0.2026.04.02.03.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 03:54:48 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Date: Thu, 02 Apr 2026 12:54:03 +0200
Subject: [PATCH RFC can-next 2/3] af_can: store socket pointers in struct
 netns_can
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-feat-can-diag-v1-2-245b56434c1b@redhat.com>
References: <20260402-feat-can-diag-v1-0-245b56434c1b@redhat.com>
In-Reply-To: <20260402-feat-can-diag-v1-0-245b56434c1b@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 "David S. Miller" <davem@davemloft.net>, 
 Urs Thuermann <urs.thuermann@volkswagen.de>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Radu Rendec <rrendec@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Filippo Storniolo <fstornio@redhat.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-7321-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fstornio@redhat.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D61F387F7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index fd9fa072881e22ced725fa77dd096dea07fb73a6..20c2b9b82c42ca920b803510d16ecfbbe6bd414a 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1595,6 +1595,8 @@ static int bcm_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	can_remove_sock_sklist(sk);
+
 	net = sock_net(sk);
 	bo = bcm_sk(sk);
 
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 2770f43f4951884658d54ac90bd1e0ae21c24102..0fe00b3e99cd6484843923480a10f7bb58c67bb5 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1200,6 +1200,8 @@ static int isotp_release(struct socket *sock)
 	so = isotp_sk(sk);
 	net = sock_net(sk);
 
+	can_remove_sock_sklist(sk);
+
 	/* wait for complete transmission of current pdu */
 	while (wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0 &&
 	       cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) != ISOTP_IDLE)
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index f07394d44cdc97a09a4f7b0769b493b31ad6f4e3..ed0afe319033ba13e6bc2480962c7d16ad7f7fa1 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -640,6 +640,8 @@ static int j1939_sk_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	can_remove_sock_sklist(sk);
+
 	lock_sock(sk);
 	jsk = j1939_sk(sk);
 
diff --git a/net/can/raw.c b/net/can/raw.c
index eee244ffc31ecc0e1cc1aae29cd1d13a4e6b54ca..5c4168860e48f7caea3378607f44b9b498fcff87 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -407,6 +407,8 @@ static int raw_release(struct socket *sock)
 	ro = raw_sk(sk);
 	net = sock_net(sk);
 
+	can_remove_sock_sklist(sk);
+
 	spin_lock(&raw_notifier_lock);
 	while (raw_busy_notifier == ro) {
 		spin_unlock(&raw_notifier_lock);

-- 
2.51.0


