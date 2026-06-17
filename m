Return-Path: <linux-can+bounces-7867-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LxjPCJhaMmrlywUAu9opvQ
	(envelope-from <linux-can+bounces-7867-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2026 10:28:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1FA6978B5
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2026 10:28:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.de header.s=amazoncorp2 header.b=Sn7hK+wt;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7867-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7867-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A55243063836
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2026 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF3038A700;
	Wed, 17 Jun 2026 08:27:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F52380FE5;
	Wed, 17 Jun 2026 08:27:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684828; cv=none; b=OknC0UkMkttRxT95WFLhqSLiU6xRpkK8s4YGdfhIZHC0beOQb7s3sMSKZyW8I24eKrqm2BHNiYMOOaZbawGDv0KvQDIgt/Yz3zOGCKkGxwEeBOMuA+GGmZHJpQbPxZ4p9i+QARA60+hB/kQkql354CMeaMZvqH/quCQFCx6kQL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684828; c=relaxed/simple;
	bh=dciUbXNlFRDfCtnn/jpFw7jss/8tXfrIyWa1uwzuLig=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oHX72i20k8+bpJaiPyKx38Ts7+X4/MrtQQL+6vnMiysc1JUFUBEMvMwGHSFsfChVYDR4vB6z5UuJPTc91Fc4YL+UQpP0PVFVxtRBowW5h2acfo8fxYzpfZwfe/1Kf2WRGJOkIZKw7mv6hZYyg3LpUoI4MOYjVi5ykuNlAAgi50s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Sn7hK+wt; arc=none smtp.client-ip=44.246.77.92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781684826; x=1813220826;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9AxRPNtE9tz/kldGZzfKUdGNScYBLFw4xYGMo02Hvw4=;
  b=Sn7hK+wtN/0oCu+EhYXoG+InCEEwXkRJFS0C7T2xTEKF2L1WIt+3X9dN
   +3+yG7gljGESu8kNhV0RGdBD373yBXUp32CPMacXkhl6wA2su4WyPbDSR
   R3MW6BXAhJc6/h6dzr9IfeVUu1Y8PGPhWDewrWQBRY/EB2SomIBQpt+Iy
   41mbFcvAZH33KSJNhRdad809kikaGVojyb+jk8Bxgo82YOi8TejRvS4wN
   2GNO/qSjxV86OttVFqkYHfy/zJe4umR/2Ar85nJB5xVIWsO+4V8glLRty
   c8UNd16SkmLwhbFATIRLzPp5LXK9omT2RjzO+KnwBO8QQjj/ZUfHyC058
   w==;
X-CSE-ConnectionGUID: May9+EmuSqKHRqmOFLj9ww==
X-CSE-MsgGUID: XbGAfCOrRsOtvltPxd5bGw==
X-IronPort-AV: E=Sophos;i="6.24,209,1774310400"; 
   d="scan'208";a="21929506"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 08:27:04 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:11972]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.146:2525] with esmtp (Farcaster)
 id ae6e0019-f869-4a14-9004-f71149edef74; Wed, 17 Jun 2026 08:27:03 +0000 (UTC)
X-Farcaster-Flow-ID: ae6e0019-f869-4a14-9004-f71149edef74
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 17 Jun 2026 08:27:03 +0000
Received: from dev-dsk-mheyne-1b-8cc83676.eu-west-1.amazon.com (10.13.235.223)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 17 Jun 2026 08:27:00 +0000
From: Maximilian Heyne <mheyne@amazon.de>
To: <stable@vger.kernel.org>
CC: Maximilian Heyne <mheyne@amazon.de>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, "Eric W. Biederman"
	<ebiederm@aristanetworks.com>, <linux-can@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH 6.12.y] net: add missing ns_capable check for peer netns
Date: Wed, 17 Jun 2026 08:25:31 +0000
Message-ID: <20260617-pats-coif-316245c6@mheyne-amazon>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[amazon.de:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:mheyne@amazon.de,m:mkl@pengutronix.de,m:mailhol.vincent@wanadoo.fr,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:daniel@iogearbox.net,m:razor@blackwall.org,m:ebiederm@aristanetworks.com,m:linux-can@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7867-lists,linux-can=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mheyne@amazon.de,linux-can@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amazon.de:dkim,amazon.de:email,amazon.de:from_mime,mheyne-amazon:mid,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[amazon.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mheyne@amazon.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amazon.de,pengutronix.de,wanadoo.fr,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,blackwall.org,aristanetworks.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE1FA6978B5

The upstream commit 7b735ef81286 ("rtnetlink: add missing
netlink_ns_capable() check for peer netns") doesn't apply on older
stable kernels due to refactoring. Therefore, this patch is an attempt
to implement the same capability check just directly in the respective
interface types.

Approximate the netlink_ns_capable check with an ns_capable check. As
the newlink operation is synchronous this should result in the same
behavior.

Without this commit, for example, the following command creating a veth
device in network namespace of pid 1 succeeds:

$ unshare -U -r -n -- bash -c '
  ip link add veth0 type veth peer name foobar netns 1
  sleep 60' &
$ ip link show foobar
13: foobar@if2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 96:09:69:92:92:cc brd ff:ff:ff:ff:ff:ff link-netnsid 1

With this patch, it's returning -EPERM.

This fixes CVE-2026-31692

Cc: stable@vger.kernel.org
Fixes: 81adee47dfb6 ("net: Support specifying the network namespace upon device creation.")
Assisted-by: Kiro:claude
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 drivers/net/can/vxcan.c | 5 +++++
 drivers/net/netkit.c    | 5 +++++
 drivers/net/veth.c      | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 9e1b7d41005f8..851c93bf0b310 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -211,6 +211,11 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
 	if (IS_ERR(peer_net))
 		return PTR_ERR(peer_net);
 
+	if (!ns_capable(peer_net->user_ns, CAP_NET_ADMIN)) {
+		put_net(peer_net);
+		return -EPERM;
+	}
+
 	peer = rtnl_create_link(peer_net, ifname, name_assign_type,
 				&vxcan_link_ops, tbp, extack);
 	if (IS_ERR(peer)) {
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index fba2c734f0ec7..e0c42fa0c835c 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -413,6 +413,11 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 	if (IS_ERR(net))
 		return PTR_ERR(net);
 
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN)) {
+		put_net(net);
+		return -EPERM;
+	}
+
 	peer = rtnl_create_link(net, ifname, ifname_assign_type,
 				&netkit_link_ops, tbp, extack);
 	if (IS_ERR(peer)) {
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 77e4b0d1ca557..6ffde7ee2119d 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1854,6 +1854,11 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
 	if (IS_ERR(net))
 		return PTR_ERR(net);
 
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN)) {
+		put_net(net);
+		return -EPERM;
+	}
+
 	peer = rtnl_create_link(net, ifname, name_assign_type,
 				&veth_link_ops, tbp, extack);
 	if (IS_ERR(peer)) {
-- 
2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


