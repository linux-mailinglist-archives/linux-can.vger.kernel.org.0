Return-Path: <linux-can+bounces-7869-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7NVaH/FaMmrxywUAu9opvQ
	(envelope-from <linux-can+bounces-7869-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2026 10:29:37 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCD26978DF
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2026 10:29:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.de header.s=amazoncorp2 header.b=aJCXoq1S;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7869-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7869-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF033301224C
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2026 08:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA5338736E;
	Wed, 17 Jun 2026 08:28:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FB437FF5E;
	Wed, 17 Jun 2026 08:28:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684881; cv=none; b=CGBpyiSHUuOeUPwOSJANE5blOPzUkXT0ohCl3jtvi/1yzQnzm8fyjmSSkFx+JEX9oh7iX9or+3LLbiRzCCpL9bs7RVnkmDg+1uyuTbriIL8Rj7JDk+GIky1Vfh+E8u36Q5Mm58FtTJajvAR9DbnhZHQjKGOrX0PQY3Ne+u/1Xw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684881; c=relaxed/simple;
	bh=UcJOorZnS9GtSC7O8fCuBKyC87j3VM6VYrblIL3Q0uA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o5lfX1NIbMdCu0c9Bq+esZuVZlj9r1lmPlkJCeUdzFfRBSSYAC8Pxu52BZIemDAS3PqfL1erz+uyt0RLUXLXSUk92Orm53VRo4JXvx6PgI+fh2DUiemAx4ixpkc6ObpTYLUM9ZcxIpAr5i2hiO/soBCil+6o30iLd4el8e4kJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=aJCXoq1S; arc=none smtp.client-ip=35.162.73.231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781684880; x=1813220880;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+gfbE8/PRlfzjkNkV2VDVmqaPimFYzuuEjnAZBwf+LU=;
  b=aJCXoq1SqP0iy67w+BDtM/HxTcORykljOcCDePE0CgUpf8XDYBFIuYH4
   20RJ5f7Tl867ZjSIFHVnefJhuv+ey5uzL8aaHPz/1+VUhX3Yke+GpSNDt
   UkPxyKQ79sRjcYgOhHAxXefKqlEbiqynVU+pV2OPSiWZqMxf7n2/kpOEF
   j6oQ7ajw1NbcgolndyjzgNT+SkheLTq93HRRPzyq/iOPUQgDg2ru8HgnY
   f5EPE/Bp67T/E7Vql0FShzyioBgB4BEqNlX7bDff+vjG95NL6eeC+BDWW
   chOI9s1wWXxODOjjWYDlNikD89+DmURNspmYHMg8CQZlWDgoazNv0ttKP
   g==;
X-CSE-ConnectionGUID: kDrtkTd6T662P5H47eQEkA==
X-CSE-MsgGUID: PkXRpYb1SwS3VdkTP8cE4g==
X-IronPort-AV: E=Sophos;i="6.24,209,1774310400"; 
   d="scan'208";a="21726777"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 08:27:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:16347]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.145:2525] with esmtp (Farcaster)
 id 8630db9a-550c-4d3a-9513-30d77e2aa6ef; Wed, 17 Jun 2026 08:27:57 +0000 (UTC)
X-Farcaster-Flow-ID: 8630db9a-550c-4d3a-9513-30d77e2aa6ef
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 17 Jun 2026 08:27:56 +0000
Received: from dev-dsk-mheyne-1b-8cc83676.eu-west-1.amazon.com (10.13.235.223)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 17 Jun 2026 08:27:54 +0000
From: Maximilian Heyne <mheyne@amazon.de>
To: <stable@vger.kernel.org>
CC: Maximilian Heyne <mheyne@amazon.de>, Wolfgang Grandegger
	<wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric W.
 Biederman" <ebiederm@aristanetworks.com>, <linux-can@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6.1.y] net: add missing ns_capable check for peer netns
Date: Wed, 17 Jun 2026 08:27:35 +0000
Message-ID: <20260617-keyed-dude-3493dbdb@mheyne-amazon>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[amazon.de:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:mheyne@amazon.de,m:wg@grandegger.com,m:mkl@pengutronix.de,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ebiederm@aristanetworks.com,m:linux-can@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amazon.de:dkim,amazon.de:email,amazon.de:from_mime,mheyne-amazon:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[mheyne@amazon.de,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7869-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mheyne@amazon.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBCD26978DF

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
 drivers/net/veth.c      | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 98c669ad51414..da4affff65476 100644
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
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index e1e8c825483aa..dac8cc5a79f5a 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1707,6 +1707,11 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
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


