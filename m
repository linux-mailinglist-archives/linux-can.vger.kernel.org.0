Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D8B373179
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 22:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhEDUhO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 16:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhEDUhN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 16:37:13 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7C5C06138E
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 13:36:17 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b21so12806601ljf.11
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flodin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVZGRUnLTF2ujsME2GvskilHwBjffJIH9l/zY7blY+k=;
        b=lk6a1HUIdGsM/bQVsENvrSvdkW+3O7gTMZWK3Jnmj6/ULj3S1buH7yU5tfYKbsd3PL
         EiV8q/K1oYRmRDDxGnOzdMpMhe51rFQpOamWVUvFwvkX1LIGp4jpUD4ISiJ635QLzqfJ
         Vo1vgi/hDwn36ARlKK3tKQ9evGvDgKzuhDMiBsd12C3UX5Oq40mv9/qfTg7Tsbyu50nj
         EsX4PGMJu9oLzJz9ZGHJjsU92AKyJAleyZ54H+YgaEdZLwmoU7VwMBjGM9nijPnLHgj0
         qGK0emtAOJx7pEkUXkHmKF/FU7TD1G/7GuxSB0oAC00Kf7iQfixjJWT2BomSx3/ZYuG0
         q35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVZGRUnLTF2ujsME2GvskilHwBjffJIH9l/zY7blY+k=;
        b=pOzv2hsMtpi7Qk3kxkcK3ZSHg+5dg+z1tM+9g9cYHUOskbHx3J8/DZeWOG3YrmIX8a
         Ct1CrAT5Oh3BTGmuu1IwvcIXimujpANYwtywItb7OH2oHTpcqmhdCSOhABX0XVvlb0fh
         4zDs25oadAjgXIX3Q9UeV4PfGI4M+9EpgGkMha4g2iX3E+QMxyM3Mqodsg3RPnDdHVBW
         FH3vreK53bNar9Z5in5v1ZJ49WEF/ct0kU5pWFswKGrHDM0NZaOYvh6OUcq9DKKuZmTz
         sXCXHuu5u3XIGeoqf/mUJOy8Ow177UgI/5SBa2/q1f7K+lJg2XS7Y3Qiw4cUG0P7loKM
         JzxQ==
X-Gm-Message-State: AOAM5309n3MrcXRHmRGkeVK4uGUGYWXB9NGcvGywXHqj1g0eaQGZLLTg
        CL1/oZdf5cRNaxazWDNiglge1w==
X-Google-Smtp-Source: ABdhPJxUoJpdWIrynpc1QosXAoFSxzQgX0GUa9XVdBfz1+dnSK88qo2t9eZJJ3MaMdZAJvkU3vddxQ==
X-Received: by 2002:a2e:a365:: with SMTP id i5mr10860264ljn.344.1620160576339;
        Tue, 04 May 2021 13:36:16 -0700 (PDT)
Received: from trillian.bjorktomta.lan (h-158-174-77-132.NA.cust.bahnhof.se. [158.174.77.132])
        by smtp.gmail.com with ESMTPSA id v1sm1792222ljj.77.2021.05.04.13.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 13:36:15 -0700 (PDT)
From:   Erik Flodin <erik@flodin.me>
To:     socketcan@hartkopp.net, mkl@pengutronix.de
Cc:     davem@davemloft.net, kuba@kernel.org, corbet@lwn.net,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, Erik Flodin <erik@flodin.me>
Subject: [PATCH v2 2/2] can: raw: add CAN_RAW_RECV_OWN_MSGS_ALL socket option
Date:   Tue,  4 May 2021 22:35:46 +0200
Message-Id: <20210504203546.115734-3-erik@flodin.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210504203546.115734-1-erik@flodin.me>
References: <20210504203546.115734-1-erik@flodin.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

CAN_RAW_RECV_OWN_MSGS_ALL works as CAN_RAW_RECV_OWN_MSGS with the
difference that all sent frames are received as no filtering is applied
on the socket's own frames in this case.

Signed-off-by: Erik Flodin <erik@flodin.me>
---
 Documentation/networking/can.rst |  7 +++
 include/uapi/linux/can/raw.h     | 18 ++++---
 net/can/raw.c                    | 91 +++++++++++++++++++++++++++-----
 3 files changed, 95 insertions(+), 21 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index f34cb0e4460e..80c70357cd33 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -611,6 +611,13 @@ demand:
 Note that reception of a socket's own CAN frames are subject to the same
 filtering as other CAN frames (see :ref:`socketcan-rawfilter`).
 
+RAW socket option CAN_RAW_RECV_OWN_MSGS_ALL
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Identical to CAN_RAW_RECV_OWN_MSGS except that all sent messages are
+received. I.e. reception is not subject to filtering.
+
+
 .. _socketcan-rawfd:
 
 RAW Socket Option CAN_RAW_FD_FRAMES
diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
index 3386aa81fdf2..6e29b2b145e2 100644
--- a/include/uapi/linux/can/raw.h
+++ b/include/uapi/linux/can/raw.h
@@ -53,15 +53,17 @@ enum {
 	SCM_CAN_RAW_ERRQUEUE = 1,
 };
 
-/* for socket options affecting the socket (not the global system) */
-
+/* For socket options affecting the socket (not the global system).
+ * Options default to off unless noted otherwise.
+ */
 enum {
-	CAN_RAW_FILTER = 1,	/* set 0 .. n can_filter(s)          */
-	CAN_RAW_ERR_FILTER,	/* set filter for error frames       */
-	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
-	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
-	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
-	CAN_RAW_JOIN_FILTERS,	/* all filters must match to trigger */
+	CAN_RAW_FILTER = 1,	   /* set 0 .. n can_filter(s)          */
+	CAN_RAW_ERR_FILTER,	   /* set filter for error frames       */
+	CAN_RAW_LOOPBACK,	   /* local loopback (default on)       */
+	CAN_RAW_RECV_OWN_MSGS,	   /* receive my own msgs w/ filtering  */
+	CAN_RAW_FD_FRAMES,	   /* allow CAN FD frames               */
+	CAN_RAW_JOIN_FILTERS,	   /* all filters must match to trigger */
+	CAN_RAW_RECV_OWN_MSGS_ALL, /* receive my own msgs w/o filtering */
 };
 
 #endif /* !_UAPI_CAN_RAW_H */
diff --git a/net/can/raw.c b/net/can/raw.c
index acfbae28d451..79c29942b0be 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -86,6 +86,7 @@ struct raw_sock {
 	struct notifier_block notifier;
 	int loopback;
 	int recv_own_msgs;
+	int recv_own_msgs_all;
 	int fd_frames;
 	int join_filters;
 	int count;                 /* number of active filters */
@@ -122,7 +123,7 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	unsigned int *pflags;
 
 	/* check the received tx sock reference */
-	if (!ro->recv_own_msgs && oskb->sk == sk)
+	if (!ro->recv_own_msgs && !ro->recv_own_msgs_all && oskb->sk == sk)
 		return;
 
 	/* do not pass non-CAN2.0 frames to a legacy socket */
@@ -132,7 +133,8 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
 	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
-		if (ro->join_filters) {
+		if (ro->join_filters &&
+		    (!ro->recv_own_msgs_all || oskb->sk != sk)) {
 			this_cpu_inc(ro->uniq->join_rx_count);
 			/* drop frame until all enabled filters matched */
 			if (this_cpu_ptr(ro->uniq)->join_rx_count < ro->count)
@@ -145,8 +147,10 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 		this_cpu_ptr(ro->uniq)->skbcnt = can_skb_prv(oskb)->skbcnt;
 		this_cpu_ptr(ro->uniq)->join_rx_count = 1;
 		/* drop first frame to check all enabled filters? */
-		if (ro->join_filters && ro->count > 1)
+		if (ro->join_filters && ro->count > 1 &&
+		    (!ro->recv_own_msgs_all || oskb->sk != sk)) {
 			return;
+		}
 	}
 
 	/* clone the given skb to be able to enqueue it into the rcv queue */
@@ -214,6 +218,18 @@ static int raw_enable_errfilter(struct net *net, struct net_device *dev,
 	return err;
 }
 
+static int raw_enable_ownfilter(struct net *net, struct net_device *dev,
+				struct sock *sk, bool recv_own_msgs_all)
+{
+	int err = 0;
+
+	if (recv_own_msgs_all)
+		err = can_rx_register(net, dev, 0, MASK_ALL, true, raw_rcv,
+				      sk, "raw", sk);
+
+	return err;
+}
+
 static void raw_disable_filters(struct net *net, struct net_device *dev,
 				struct sock *sk, struct can_filter *filter,
 				int count)
@@ -236,6 +252,13 @@ static inline void raw_disable_errfilter(struct net *net,
 				  false, raw_rcv, sk);
 }
 
+static void raw_disable_ownfilter(struct net *net, struct net_device *dev,
+				  struct sock *sk, bool recv_own_msgs_all)
+{
+	if (recv_own_msgs_all)
+		can_rx_unregister(net, dev, 0, MASK_ALL, true, raw_rcv, sk);
+}
+
 static inline void raw_disable_allfilters(struct net *net,
 					  struct net_device *dev,
 					  struct sock *sk)
@@ -244,6 +267,7 @@ static inline void raw_disable_allfilters(struct net *net,
 
 	raw_disable_filters(net, dev, sk, ro->filter, ro->count);
 	raw_disable_errfilter(net, dev, sk, ro->err_mask);
+	raw_disable_ownfilter(net, dev, sk, ro->recv_own_msgs_all);
 }
 
 static int raw_enable_allfilters(struct net *net, struct net_device *dev,
@@ -253,13 +277,19 @@ static int raw_enable_allfilters(struct net *net, struct net_device *dev,
 	int err;
 
 	err = raw_enable_filters(net, dev, sk, ro->filter, ro->count);
-	if (!err) {
-		err = raw_enable_errfilter(net, dev, sk, ro->err_mask);
-		if (err)
-			raw_disable_filters(net, dev, sk, ro->filter,
-					    ro->count);
-	}
+	if (err)
+		goto out;
+	err = raw_enable_errfilter(net, dev, sk, ro->err_mask);
+	if (err)
+		goto out_disable;
+	err = raw_enable_ownfilter(net, dev, sk, ro->recv_own_msgs_all);
+	if (!err)
+		goto out;
 
+	raw_disable_errfilter(net, dev, sk, ro->err_mask);
+out_disable:
+	raw_disable_filters(net, dev, sk, ro->filter, ro->count);
+out:
 	return err;
 }
 
@@ -323,10 +353,11 @@ static int raw_init(struct sock *sk)
 	ro->count            = 1;
 
 	/* set default loopback behaviour */
-	ro->loopback         = 1;
-	ro->recv_own_msgs    = 0;
-	ro->fd_frames        = 0;
-	ro->join_filters     = 0;
+	ro->loopback          = 1;
+	ro->recv_own_msgs     = 0;
+	ro->recv_own_msgs_all = 0;
+	ro->fd_frames         = 0;
+	ro->join_filters      = 0;
 
 	/* alloc_percpu provides zero'ed memory */
 	ro->uniq = alloc_percpu(struct uniqframe);
@@ -495,6 +526,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 	can_err_mask_t err_mask = 0;
 	int count = 0;
 	int err = 0;
+	int old_val;
 
 	if (level != SOL_CAN_RAW)
 		return -EINVAL;
@@ -639,6 +671,33 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case CAN_RAW_RECV_OWN_MSGS_ALL:
+		if (optlen != sizeof(ro->recv_own_msgs_all))
+			return -EINVAL;
+
+		old_val = ro->recv_own_msgs_all;
+		if (copy_from_sockptr(&ro->recv_own_msgs_all, optval, optlen))
+			return -EFAULT;
+
+		lock_sock(sk);
+
+		if (ro->bound && ro->ifindex)
+			dev = dev_get_by_index(sock_net(sk), ro->ifindex);
+
+		if (ro->bound) {
+			if (old_val && !ro->recv_own_msgs_all)
+				raw_disable_ownfilter(sock_net(sk), dev, sk, true);
+			else if (!old_val && ro->recv_own_msgs_all)
+				err = raw_enable_ownfilter(sock_net(sk), dev, sk, true);
+		}
+
+		if (dev)
+			dev_put(dev);
+
+		release_sock(sk);
+
+		break;
+
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -718,6 +777,12 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 		val = &ro->join_filters;
 		break;
 
+	case CAN_RAW_RECV_OWN_MSGS_ALL:
+		if (len > sizeof(int))
+			len = sizeof(int);
+		val = &ro->recv_own_msgs_all;
+		break;
+
 	default:
 		return -ENOPROTOOPT;
 	}
-- 
2.31.1

