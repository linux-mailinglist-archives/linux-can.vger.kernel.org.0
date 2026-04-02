Return-Path: <linux-can+bounces-7322-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /O4cBgFLzmmjmgYAu9opvQ
	(envelope-from <linux-can+bounces-7322-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 12:54:57 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F28387F83
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 12:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FBBB30347F9
	for <lists+linux-can@lfdr.de>; Thu,  2 Apr 2026 10:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFDD3921F8;
	Thu,  2 Apr 2026 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHfGpimT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJg0P7ZK"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2603038D684
	for <linux-can@vger.kernel.org>; Thu,  2 Apr 2026 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127295; cv=none; b=s95QBAvyiKrRDPk3kvKOT0Ti14/mtQNfJ75KNvAP/cxRpnk8T7qidghjM1YZLp+0Gqz/PuMNDQtgZlPdhhisjeIJzhFpty50NTWzNGL4y+nng8B9VF3CZT1AXlBSdbdfI3EztuL9KKLuWtlNZO+fr62ttPKkdAtvge+FLTEJKMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127295; c=relaxed/simple;
	bh=MWL5KakW43NgjmJLppq6ALgKn8PLsRiBHbohxq4bs2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IaiUgHAoCKQNhsWTTD3BB9j3VEy5ZMgPr9jlfcD+gXeP3EFRrJW9Uxauq7pRODXDaqYevP9dh2tlln6MEZtL4bcA8XIZf70xmRG4/EvdLgMHmW7BgmjLzpwtA03ZNeVU34PwXHt1cmbslgzlpUWqZ/CxpJRHj59PcEB2bBRer7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHfGpimT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJg0P7ZK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775127293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOsUOnH2zrW01XccUCpU7xyrDbtykYeZguRcpS6mL6A=;
	b=OHfGpimT/7n1nTudWuPn//Gfd8p94Rs5l0owi7SXYPLty+fSbae98KJ720fdqtHPSJjPAN
	NNa2KkhANzI8PYXpAsI36d8oh1q570geP0K3kBvgNJ5DUdoOcI8lgMn7NonfyuDgdBJGYZ
	kzSVyedjw865VFS9EQKSBTobQsKiDuI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-MUiOhyF9PXCWOP_vOZ5i1A-1; Thu, 02 Apr 2026 06:54:52 -0400
X-MC-Unique: MUiOhyF9PXCWOP_vOZ5i1A-1
X-Mimecast-MFC-AGG-ID: MUiOhyF9PXCWOP_vOZ5i1A_1775127291
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48531e6012bso7149165e9.1
        for <linux-can@vger.kernel.org>; Thu, 02 Apr 2026 03:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775127291; x=1775732091; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOsUOnH2zrW01XccUCpU7xyrDbtykYeZguRcpS6mL6A=;
        b=cJg0P7ZK7CsWUzyylDJq3t6LAZNqR5rIl2r1VALWJGVGoBwhl20PVtytPJbmhR4HBM
         vjvlLWvPEMtVrjk4vXvodvp9rOR4ZTTzi+5cYN00BpFdkGhQbMeOhSs0sa0zGGqkcwLm
         82aJRkk0Y90I1BP7k77rs+Bu0vwY0asEegC1Lpldyo/2b53K6UMHlSUG5pF8YOHQuR5d
         ERW3Rxmlhpwdvt4/nSdJn79ROGWj2aqpxOLW1HFD/czGfgRVksOMB3cXt9ukCDpKfmp6
         ti7wIBa5IsWPsQZpf25QZ0VE1lYoaVRkXeQu22/Ckp3XJ0BeHl28Pk7oULjVrrqMGzpb
         9s+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775127291; x=1775732091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tOsUOnH2zrW01XccUCpU7xyrDbtykYeZguRcpS6mL6A=;
        b=cHVGTmuZzP7oNnyPK0IdhBJzqVwqWU3ZndQR/tPjM61VzFwF30tmHxRzns6ooKLLZx
         +EzV2ArAHM/pY3wanmTnCrfG9kWCYOGO8gA4CTSaveMcoVWVOpNCHnH0W5aVNzyGVAbI
         WT8md/JALYDhgi8AXg4zz9cY1+XRmNJG5TEQzwExRB+fPjQzpXcJFFeJyJnRf79TUSBI
         Z+7O9TUkh5eMAh70DS1u18zOzrNoH50bG0e9ZCzKIm2ztyvBJe1zV3SyUPW57JMQCtVY
         ZAGQNQ45SZO8mXTu/d6XJBhVxOmlE+sjzN3ivI6qqy4wzZwf0sdtBiQovTsMVqsWT8Ox
         HpPQ==
X-Gm-Message-State: AOJu0Yw8Z2E+uJl/17bqToMLwZSPdZ3911+h5WEEFUc4IyMDEFldcGZF
	jc+sHPzMr81fMdNX061xtQQVjh6cP0D6wvsBU0cINdUlq6enDk8bL/qyTiXiKODURxoKZdREOxb
	ysi9jFGAYOBxGSpVusHs1IQTLjdG779go14WcxJe607s9QLTIDS9MiHu4YILCTg==
X-Gm-Gg: ATEYQzyFkOmeqOs7yesK4T7bonNMS5TG7unTLevGdmQ8iz+A1JsuXDOxciq8K61pqnv
	4qJZQYukTuvRD0DSrjH6ReeleUg1sd6QSrieW3TDODPpukJcTd0pb7IxTDJRMgKeCuQe9Uh1nJL
	/eEUzgKYXMY+YBWcmg88ytHtb9XMigPPweDFzqB5BaME+jqUXfpw5QJrur5GUCVFpoA9nhqfLOU
	SqZTxKtuz1a7BTMu2ZNNLS8JURvPXzvkziKEb4CV6BPnIz+wceIeYUoaUScz5ElMoqx5Z6iPXfH
	cSBNaTnuK5FFTRm2Sqfe8uPTOlf3MvBCPhm0xfK2EhB9/EqsLjhYOpUP0lYj9mEoO+Rryks2b+b
	OeKPlD9c3mqeVV8nV93Gq/+dWDwTWfW/CtOFzJsmKQcknFaUNc735I6OeEOmdgdM1t9jehIXzmv
	3b/gab8uquSDwqGottJg==
X-Received: by 2002:a05:600c:8718:b0:487:1c2:6a4f with SMTP id 5b1f17b1804b1-488835c0534mr139100435e9.31.1775127290656;
        Thu, 02 Apr 2026 03:54:50 -0700 (PDT)
X-Received: by 2002:a05:600c:8718:b0:487:1c2:6a4f with SMTP id 5b1f17b1804b1-488835c0534mr139100045e9.31.1775127290169;
        Thu, 02 Apr 2026 03:54:50 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb (net-2-34-60-62.cust.vodafonedsl.it. [2.34.60.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887a630922sm234489435e9.0.2026.04.02.03.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 03:54:49 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Date: Thu, 02 Apr 2026 12:54:04 +0200
Subject: [PATCH RFC can-next 3/3] can: add can diag interface
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-feat-can-diag-v1-3-245b56434c1b@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-7322-lists,linux-can=lfdr.de];
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
X-Rspamd-Queue-Id: D3F28387F83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the can_diag interface for querying sockets from userspace.
ss(8) tool can use this interface to list open sockets.

The userspace ABI is defined in <linux/can_diag.h> and includes
netlink request and response structs.  The request queries open
can sockets and the response contains socket information fields
including the interface index for bound sockets, inode number,
transport protocol etc.

Support can be added later by extending can_diag_dump().

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Filippo Storniolo <fstornio@redhat.com>
---
 MAINTAINERS                   |   1 +
 include/uapi/linux/can_diag.h |  43 ++++++++++++
 net/can/Kconfig               |  10 +++
 net/can/Makefile              |   2 +
 net/can/can-diag.c            | 153 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 209 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2ffd9d37d57c0db59e602eeffc2e2f09b613d9..f338ef2380a634a671d06f27bb4dac6f45f4d2a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5730,6 +5730,7 @@ F:	include/linux/can/skb.h
 F:	include/net/can.h
 F:	include/net/netns/can.h
 F:	include/uapi/linux/can.h
+F:	include/uapi/linux/can_diag.h
 F:	include/uapi/linux/can/bcm.h
 F:	include/uapi/linux/can/gw.h
 F:	include/uapi/linux/can/isotp.h
diff --git a/include/uapi/linux/can_diag.h b/include/uapi/linux/can_diag.h
new file mode 100644
index 0000000000000000000000000000000000000000..e63d79f1ab3803a5778407e07d485732a112745a
--- /dev/null
+++ b/include/uapi/linux/can_diag.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI__CAN_DIAG_H__
+#define _UAPI__CAN_DIAG_H__
+
+#include <linux/types.h>
+#include <linux/can.h>
+
+/* Request */
+struct can_diag_req {
+	__u8	sdiag_family;	/* must be AF_CAN */
+	__u8	sdiag_protocol; /* for future filtering of transport protocols */
+	__u16	pad;
+	__u32	cdiag_states;
+	__u32	cdiag_ino;
+	__u32	cdiag_show;
+	__u32	cdiag_cookie[2];
+};
+
+enum {
+	CAN_DIAG_UNSPEC,
+	CAN_DIAG_UID,
+
+	__CAN_DIAG_MAX,
+};
+
+#define CAN_DIAG_MAX (__CAN_DIAG_MAX - 1)
+
+/* Response */
+struct can_diag_msg {
+	__u8	cdiag_family;	/* AF_CAN */
+	__u8	cdiag_state;
+	__u16	cdiag_protocol;
+	__u16	cdiag_type;
+	__u16	pad16;
+	__u32	cdiag_ino;
+	canid_t cdiag_tx_id; /* meaningful only for ISO-TP */
+	canid_t cdiag_rx_id; /* meaningful only for ISO-TP */
+	__s32	cdiag_ifindex;
+	__u32	cdiag_cookie[2];
+};
+
+#endif /* _UAPI__CAN_DIAG_H__ */
diff --git a/net/can/Kconfig b/net/can/Kconfig
index abbb4be7ad2152c66abd2e28dbbd5282ec45d065..ed210d62da7c28798d2f6f1967739e1621093cbf 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -70,4 +70,14 @@ config CAN_ISOTP
 	  as needed e.g. for vehicle diagnosis (UDS, ISO 14229) or IP-over-CAN
 	  traffic.
 
+config CAN_DIAG
+	tristate "CAN socket monitoring interface"
+	depends on CAN
+	default m
+	help
+	  Support for CAN socket monitoring interface used by the ss tool.
+	  If unsure, say Y.
+
+	  Enable this module so userspace applications can query open sockets.
+
 endif
diff --git a/net/can/Makefile b/net/can/Makefile
index 58f2c31c1ef377ef8c5385211e7182d42ac2225a..76a3247aa97c982b864914f7aaa3a5b0e96a2e82 100644
--- a/net/can/Makefile
+++ b/net/can/Makefile
@@ -20,3 +20,5 @@ obj-$(CONFIG_CAN_J1939)	+= j1939/
 
 obj-$(CONFIG_CAN_ISOTP)	+= can-isotp.o
 can-isotp-y		:= isotp.o
+
+obj-$(CONFIG_CAN_DIAG) += can-diag.o
diff --git a/net/can/can-diag.c b/net/can/can-diag.c
new file mode 100644
index 0000000000000000000000000000000000000000..77e1fe66e4a6513ff640d0c19c688dcd2e3970ee
--- /dev/null
+++ b/net/can/can-diag.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *
+ * Copyright (C) 2026 Red Hat
+ * Author: Filippo Storniolo <fstornio@redhat.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/net.h>
+#include <net/netlink.h>
+#include <linux/sock_diag.h>
+#include <linux/can.h>
+#include <linux/can_diag.h>
+#include <net/net_namespace.h>
+#include <net/sock.h>
+#include <linux/netdevice.h>
+#include <linux/percpu.h>
+#include <linux/user_namespace.h>
+
+static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
+			struct can_diag_req *req,
+			struct user_namespace *user_ns,
+			u32 portid, u32 seq, u32 flags, int sk_ino)
+{
+	struct sockaddr_can can_addr;
+	struct can_diag_msg *rep;
+	struct nlmsghdr *nlh;
+	uid_t uid;
+	int err;
+
+	nlh = nlmsg_put(skb, portid, seq, SOCK_DIAG_BY_FAMILY, sizeof(*rep), flags);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	rep = nlmsg_data(nlh);
+	memset(rep, 0, sizeof(struct can_diag_msg));
+
+	rep->cdiag_family = AF_CAN;
+	rep->cdiag_type = sk->sk_type;
+	rep->cdiag_ino = sk_ino;
+	rep->cdiag_protocol = sk->sk_protocol;
+	rep->cdiag_state = READ_ONCE(sk->sk_state);
+	sock_diag_save_cookie(sk, rep->cdiag_cookie);
+
+	uid = from_kuid_munged(user_ns, sk_uid(sk));
+	err = nla_put(skb, CAN_DIAG_UID, sizeof(uid_t), &uid);
+	if (err < 0) {
+		nlmsg_cancel(skb, nlh);
+		return err;
+	}
+
+	memset(&can_addr, 0, sizeof(can_addr));
+
+	err = kernel_getsockname(sk->sk_socket, (struct sockaddr *)&can_addr);
+	if (err < 0) {
+		/* Some protocols (e.g. CAN_BCM) do not implement kernel_getsockname().
+		 * No error returned because the netlink message is still valid.
+		 */
+		if (err == -EOPNOTSUPP)
+			goto exit_no_err;
+
+		nlmsg_cancel(skb, nlh);
+		return err;
+	}
+
+	rep->cdiag_ifindex = can_addr.can_ifindex;
+
+	if (sk->sk_protocol == CAN_ISOTP) {
+		rep->cdiag_tx_id = can_addr.can_addr.tp.tx_id;
+		rep->cdiag_rx_id = can_addr.can_addr.tp.rx_id;
+	}
+
+exit_no_err:
+	nlmsg_end(skb, nlh);
+	return 0;
+}
+
+static int can_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	int num = 0, s_num = cb->args[0];
+	struct can_diag_req *req;
+	struct net *net;
+	struct sock *sk;
+
+	net = sock_net(skb->sk);
+	req = nlmsg_data(cb->nlh);
+
+	mutex_lock(&net->can.sklist_lock);
+	sk_for_each(sk, &net->can.sklist) {
+		if (num < s_num)
+			goto next;
+
+		if (sk_diag_fill(sk, skb, req,
+				 sk_user_ns(NETLINK_CB(cb->skb).sk),
+				 NETLINK_CB(cb->skb).portid,
+				 cb->nlh->nlmsg_seq, NLM_F_MULTI,
+				 sock_i_ino(sk)) < 0)
+			goto done;
+next:
+		num++;
+	}
+done:
+	mutex_unlock(&net->can.sklist_lock);
+	cb->args[0] = num;
+
+	return skb->len;
+}
+
+static int can_diag_handler_dump(struct sk_buff *skb, struct nlmsghdr *h)
+{
+	int hdrlen = sizeof(struct can_diag_req);
+	struct net *net = sock_net(skb->sk);
+	struct can_diag_req *req;
+
+	if (nlmsg_len(h) < hdrlen)
+		return -EINVAL;
+
+	req = nlmsg_data(h);
+	if (req->sdiag_protocol)
+		return -EINVAL;
+
+	if (h->nlmsg_flags & NLM_F_DUMP) {
+		struct netlink_dump_control c = {
+			.dump = can_diag_dump
+		};
+		return netlink_dump_start(net->diag_nlsk, skb, h, &c);
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static const struct sock_diag_handler can_diag_handler = {
+	.owner = THIS_MODULE,
+	.family = AF_CAN,
+	.dump = can_diag_handler_dump,
+};
+
+static int __init can_diag_init(void)
+{
+	pr_info("can: diagnostic module\n");
+	return sock_diag_register(&can_diag_handler);
+}
+
+static void __exit can_diag_exit(void)
+{
+	sock_diag_unregister(&can_diag_handler);
+}
+
+module_init(can_diag_init);
+module_exit(can_diag_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CAN socket monitoring via SOCK_DIAG");

-- 
2.51.0


