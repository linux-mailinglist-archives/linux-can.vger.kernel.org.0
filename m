Return-Path: <linux-can+bounces-7871-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7gEtBV9bMmoRzAUAu9opvQ
	(envelope-from <linux-can+bounces-7871-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2026 10:31:27 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BC46978FC
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2026 10:31:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.de header.s=amazoncorp2 header.b=HZ4ADbBd;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7871-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7871-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7450E3065366
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2026 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2709238736E;
	Wed, 17 Jun 2026 08:28:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2AC380FCF;
	Wed, 17 Jun 2026 08:28:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684891; cv=none; b=WM8/jtEtTGH+9cV0zDN9AHko57yAW38Tzn7r7nOs/nGJi7D1DhC8553phxCYtbsD/YZcxCk8318E+g30s8sCeQhaAf8eC/NFt6/FMyEU6whEjOxD+DR5BqH3ndKIXFP1y3TD3V4UZF4WWDcOvJ7HA3qGpJSsAWG5c1V7awq79Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684891; c=relaxed/simple;
	bh=RSZzWjXkPh2qWrxycJ/AEFxf0WaPV0g6SYdonukY4C4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=otHOML1k2ceXSQZyjNDymI4ryJSdAbl+7jNlRKOlDlDYxiYckdMfW7LZ3bI8VkjK8Wt6Oay3BWlXy/b9LhWMP/s87jGHIkZkK/KuZR7WtIudQpzNvuTsZsNxh8C7FVFVasZp8Ds7HnjQ7QRfVO3+c6QFbqRcwqm35DtC6non2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=HZ4ADbBd; arc=none smtp.client-ip=52.35.192.45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781684889; x=1813220889;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t12xmcDgKdGHIyBUSp6XH4cwbusTZoYgT23w3rCQ89U=;
  b=HZ4ADbBd6aIk9QgzEjZ2O32fvUpFzBza/JiUtMfB1/Y1wTqfQ5PC0MQC
   w6wPsuJUYtylYeZ/KNxW3r/7qZAMrHVxd9E/3+X07XZ4Tk3Hmy1sar09G
   wnCL6Rg2Y9Yhz34sJyxGhP8DATQ+TGj8mr0aisptP2z0TxvkX2xyr4xH3
   gRfxF29Bl19io+hKaMgKt0xo+N820xHxBtEpI0khKkfgDOZ1cEEing/0Z
   yJCK1zJJt+g06BjtQluCUkAxUfU0RcgVsOlrnC24SRAEATcDWrVbra16j
   //Aip1omgDGBrnnnXFUhfr8AbaTDWk7XIWaNXgAbY8qyigw0tY41xmyes
   g==;
X-CSE-ConnectionGUID: cek8SUr5Rbqg6EHysoU5NQ==
X-CSE-MsgGUID: 0zu5w3lCQLGLzo2ad8UcDw==
X-IronPort-AV: E=Sophos;i="6.24,209,1774310400"; 
   d="scan'208";a="21709201"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 08:28:06 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:13715]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.151:2525] with esmtp (Farcaster)
 id 2c888740-3098-4a22-a09f-ec0f9de1c90c; Wed, 17 Jun 2026 08:28:06 +0000 (UTC)
X-Farcaster-Flow-ID: 2c888740-3098-4a22-a09f-ec0f9de1c90c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 17 Jun 2026 08:28:06 +0000
Received: from dev-dsk-mheyne-1b-8cc83676.eu-west-1.amazon.com (10.13.235.223)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 17 Jun 2026 08:28:04 +0000
From: Maximilian Heyne <mheyne@amazon.de>
To: <stable@vger.kernel.org>
CC: Maximilian Heyne <mheyne@amazon.de>, Wolfgang Grandegger
	<wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Eric W.
 Biederman" <ebiederm@aristanetworks.com>, Eric Dumazet
	<eric.dumazet@gmail.com>, <linux-can@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5.10.y] net: add missing ns_capable check for peer netns
Date: Wed, 17 Jun 2026 08:27:39 +0000
Message-ID: <20260617-thaws-enid-af4ad67d@mheyne-amazon>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[amazon.de:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7871-lists,linux-can=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amazon.de:dkim,amazon.de:email,amazon.de:from_mime,mheyne-amazon:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:mheyne@amazon.de,m:wg@grandegger.com,m:mkl@pengutronix.de,m:davem@davemloft.net,m:kuba@kernel.org,m:ebiederm@aristanetworks.com,m:eric.dumazet@gmail.com,m:linux-can@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mheyne@amazon.de,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[amazon.de,grandegger.com,pengutronix.de,davemloft.net,kernel.org,aristanetworks.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mheyne@amazon.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95BC46978FC

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
index 1bfede407270d..05fcbfacc3433 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -198,6 +198,11 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
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
index 743716ebebdb9..bda3add65c76e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1341,6 +1341,11 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
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


