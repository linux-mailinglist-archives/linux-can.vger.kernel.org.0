Return-Path: <linux-can+bounces-7821-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QW6MCL2gKWqmawMAu9opvQ
	(envelope-from <linux-can+bounces-7821-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 19:37:01 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482066BFE7
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 19:37:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Vswz6qp7;
	dkim=pass header.d=redhat.com header.s=google header.b=DQqcZmlx;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7821-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7821-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADE663262401
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 17:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FED2344029;
	Wed, 10 Jun 2026 17:25:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD743349AE6
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 17:25:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112357; cv=none; b=RI+d7rBBff3mHxktfbjvmzW5rZutDSKINpfSnZ8G6lZvPqQK2VT35SLyx8Z2EgtNPh8tDIA1paCkswBw+WihUTMNGYMDuTaCKQze0Bo9zgKkKT9/izuCwnofzpgDMlemIywy0gnCqAnwMXYV2WYMEPOi1EYy5Ql6c/6drqYlmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112357; c=relaxed/simple;
	bh=/VZkXcluAzI+7Yqr2R1WnGqM4TQthCe8lnrvMjoGqVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WBJATXbuyM0G3VCanZxzLH4/ON22pz1BSBxEfZThFE91KJPg61OLOkZ2nQibUGE08SLwdFRgZ9MFnq3xT2FuD9fNmL0IzBXDUAstg/UIYvUymDKEwtqn4ZmmNGR82suD6R/ycxrrsoKM5NFukFVKmG0fluq3xPhbfGxEPv5lPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vswz6qp7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQqcZmlx; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781112354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3t4/nWe1xx3491q+SOYYvUNq0qJE7edSpldPeOSLvM=;
	b=Vswz6qp7Z7DxiEhSJX+FYvsAB5l3BM0YrUrScQ5Xu88P3INL76WdSkNnLUcKNC65suw+Ef
	mnVLxKifJZ2FP5FkG5znd2fQJS9wWTXppRWA/sH1MiMZ+aIE7FVx5V9WhH84h6ibZtfImc
	+S1RuH+8GYvOJi8aQmnoD4b4YW7dTeA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-N3D4oKPSO_aEkn0ehIupfg-1; Wed, 10 Jun 2026 13:25:53 -0400
X-MC-Unique: N3D4oKPSO_aEkn0ehIupfg-1
X-Mimecast-MFC-AGG-ID: N3D4oKPSO_aEkn0ehIupfg_1781112352
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-915b9dd020cso1068251985a.3
        for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 10:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781112352; x=1781717152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3t4/nWe1xx3491q+SOYYvUNq0qJE7edSpldPeOSLvM=;
        b=DQqcZmlxKUA2Sw/seVFhmW7jSzjB3OzEDI0I6WAkfDXdtpIim2KSEXsqDKe0DhbsKB
         nJScxRHcbO/ZR/C5GIfyScAXbr+Z/d3SU/M3p/DMtuIKJu1xtDbisui4Il/oUGDP3lF3
         tnsGtDkWGegIqZXWC//QvXHGWRHDmBjbuThNJvEtCLdXTxouls9YQtASUCOsSCaG5RFO
         RQj+KaMtwKzsWC/EAspgJ+QmUgXDV09QULnenIoSZFndGzHqL7FqAsC7U68V4mb5KtR1
         3xcOudLWZbSfY6vr3fAGBkhUF+6c97qMaKUmW/PX0Zu4B2HjTqp9/vaDNOakm9+JvHiH
         ApKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781112352; x=1781717152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L3t4/nWe1xx3491q+SOYYvUNq0qJE7edSpldPeOSLvM=;
        b=J1++XIxYMP6jFoF8VJEGGkVs2DlQZBUra6mxLRmZh2bvkVu0Y+VPtnHS2KOYKPcmNI
         /MnA5wBUrjtVrMpL72lKyhEcmZqft6Ta5N/BlLub3S39av/oG+3YJW5TxiWMrTdFcqSP
         oLD4byKXtfswy8g++XkRO3cB6P9FUYKfUbRlNWITRgWz660oeFP/AHpmjt4EDQybHKzH
         q1KA3pJcnTZIcwPEgrKQ1+1sA9mowvFLH+F8oorAT1r6pUgMm6+epnHLiP1DW/r354eL
         lVKB5yMg61VD1+kp3yZE+himUIAamKt0K+GecrJ5ktUevhlwJ1NRBv99ZOrx7gssNfSP
         3/8A==
X-Gm-Message-State: AOJu0Ywdl7v9vNBH15CSYiH6H3EnO/6zFLyRJRsToyZv+sZBOvgezoAv
	cFxsFMEDetkDSj/Pz4WSzuXSx/XPwPSDK1E1ab/ovDEDK+3e7ZZL0c1TRn9X7OkDf3NpPtgaqqP
	rrx/7OIfOFN2IONGx7c7pVcx9N0isn6QobeUVF35uUBxD9jHftBJIO3xi+fhPQw==
X-Gm-Gg: Acq92OFSKptT0egw5yrHTue4wLPxPSi6Axk/fWED/zRKy2gGKWvjjp0zzuBj+4MsKhz
	nfnmZaopmifHliZVHVfkcPEFU0fY/CLLAHlrCPcPFjyPKlm7sAhaAVYNiG7JmZEqj4jjeaiitbD
	yToL0OhNYc3DKesxEDlcICd/5UPK1dfa2XCQro6zDk8HcnMCmvmfLaAZKhTh9+nW3RVp43uZPki
	UDFsNy5VAcP8L4Yw5A3K5Xh71pFrZubSnMDbBaaGrwTHSVgaOWzn+xl7StDk7HHO528W/3N/DDu
	NBHnIv3njXG5W6PYEfAI5tGR33UjR/uSlZKVFPbixCGWM5SgpG51/gfHbhPPlzmlccVEZy+a2MF
	niE59AcMscOa4hIlFs748HxJPwWEl216ARegYgfIiOkYl50QEFC44BL+6gpLzNdiQlkUfZ+rXXY
	VhMrrbrrhWtcWbura+BUdRkZOzupT5Lj9/dCBn
X-Received: by 2002:a05:620a:480a:b0:914:9218:f075 with SMTP id af79cd13be357-915a9c35847mr4481204485a.13.1781112352397;
        Wed, 10 Jun 2026 10:25:52 -0700 (PDT)
X-Received: by 2002:a05:620a:480a:b0:914:9218:f075 with SMTP id af79cd13be357-915a9c35847mr4481195985a.13.1781112351663;
        Wed, 10 Jun 2026 10:25:51 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb (net-93-66-125-181.cust.vodafonedsl.it. [93.66.125.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a381abfsm2532946085a.27.2026.06.10.10.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:25:51 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Date: Wed, 10 Jun 2026 19:24:46 +0200
Subject: [PATCH can-next 3/3] can: add can diag interface
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-feat-can-diag-v1-3-021e3f1631a0@redhat.com>
References: <20260610-feat-can-diag-v1-0-021e3f1631a0@redhat.com>
In-Reply-To: <20260610-feat-can-diag-v1-0-021e3f1631a0@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Urs Thuermann <urs.thuermann@volkswagen.de>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, Filippo Storniolo <fstornio@redhat.com>, 
 Davide Caratti <dcaratti@redhat.com>
X-Mailer: b4 0.14.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7821-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fstornio@redhat.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:robin@protonic.nl,m:o.rempel@pengutronix.de,m:kernel@pengutronix.de,m:urs.thuermann@volkswagen.de,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-can@vger.kernel.org,m:fstornio@redhat.com,m:dcaratti@redhat.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fstornio@redhat.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,j1939_addr.name:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7482066BFE7

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
 include/uapi/linux/can/diag.h |  55 +++++++++++++
 net/can/Kconfig               |  10 +++
 net/can/Makefile              |   3 +
 net/can/diag.c                | 184 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 253 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ca6c7425b45f74830612896d01eb397e2529f43b..6c1342cee5067717518add8a0d85e82b8e2b781e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5736,6 +5736,7 @@ F:	include/net/can.h
 F:	include/net/netns/can.h
 F:	include/uapi/linux/can.h
 F:	include/uapi/linux/can/bcm.h
+F:	include/uapi/linux/can/diag.h
 F:	include/uapi/linux/can/gw.h
 F:	include/uapi/linux/can/isotp.h
 F:	include/uapi/linux/can/raw.h
diff --git a/include/uapi/linux/can/diag.h b/include/uapi/linux/can/diag.h
new file mode 100644
index 0000000000000000000000000000000000000000..7f99f85c42425062e69f961693da17965a49e7ab
--- /dev/null
+++ b/include/uapi/linux/can/diag.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI_CAN_DIAG_H_
+#define _UAPI_CAN_DIAG_H_
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
+	CAN_DIAG_ISOTP_ADDR,
+	CAN_DIAG_J1939_ADDR,
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
+	__u32	cdiag_cookie[2];
+	__s32	cdiag_ifindex;
+	__u32	pad32;
+	__u64	cdiag_ino;
+};
+
+struct can_diag_isotp_addr {
+	canid_t tx_id;
+	canid_t rx_id;
+};
+
+struct can_diag_j1939_addr {
+	__u64	name;
+	__u32	pgn;
+	__u8	addr;
+};
+
+#endif /* _UAPI_CAN_DIAG_H_ */
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
index 58f2c31c1ef377ef8c5385211e7182d42ac2225a..c0ddeb9a012c8200468be01015da71ec25e96b66 100644
--- a/net/can/Makefile
+++ b/net/can/Makefile
@@ -20,3 +20,6 @@ obj-$(CONFIG_CAN_J1939)	+= j1939/
 
 obj-$(CONFIG_CAN_ISOTP)	+= can-isotp.o
 can-isotp-y		:= isotp.o
+
+obj-$(CONFIG_CAN_DIAG) += can-diag.o
+can-diag-y		:= diag.o
diff --git a/net/can/diag.c b/net/can/diag.c
new file mode 100644
index 0000000000000000000000000000000000000000..eb623ed118af57d260a86a18106bb838503ec76c
--- /dev/null
+++ b/net/can/diag.c
@@ -0,0 +1,184 @@
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
+#include <linux/can/diag.h>
+#include <net/net_namespace.h>
+#include <net/sock.h>
+#include <linux/netdevice.h>
+#include <linux/user_namespace.h>
+
+static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
+			struct can_diag_req *req, /* will be used for filtering */
+			struct user_namespace *user_ns,
+			u32 portid, u32 seq, u32 flags, u64 sk_ino)
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
+	if (err < 0)
+		goto cancel_nlmsg_err;
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
+		goto cancel_nlmsg_err;
+	}
+
+	rep->cdiag_ifindex = can_addr.can_ifindex;
+
+	switch (sk->sk_protocol) {
+	case CAN_ISOTP:
+	{
+		struct can_diag_isotp_addr isotp_addr;
+
+		memset(&isotp_addr, 0, sizeof(isotp_addr));
+
+		isotp_addr.tx_id = can_addr.can_addr.tp.tx_id;
+		isotp_addr.rx_id = can_addr.can_addr.tp.rx_id;
+
+		err = nla_put(skb, CAN_DIAG_ISOTP_ADDR, sizeof(struct can_diag_isotp_addr),
+			      &isotp_addr);
+	}
+		break;
+	case CAN_J1939:
+	{
+		struct can_diag_j1939_addr j1939_addr;
+
+		memset(&j1939_addr, 0, sizeof(j1939_addr));
+
+		j1939_addr.name = can_addr.can_addr.j1939.name;
+		j1939_addr.pgn = can_addr.can_addr.j1939.pgn;
+		j1939_addr.addr = can_addr.can_addr.j1939.addr;
+
+		err = nla_put(skb, CAN_DIAG_J1939_ADDR, sizeof(struct can_diag_j1939_addr),
+			      &j1939_addr);
+	}
+		break;
+	default:
+		break;
+	}
+
+	if (err < 0)
+		goto cancel_nlmsg_err;
+
+exit_no_err:
+	nlmsg_end(skb, nlh);
+	return 0;
+
+cancel_nlmsg_err:
+	nlmsg_cancel(skb, nlh);
+	return err;
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
+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, AF_CAN);

-- 
2.53.0


