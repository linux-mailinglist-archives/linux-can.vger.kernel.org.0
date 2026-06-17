Return-Path: <linux-can+bounces-7868-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WIRQO4NaMmrcywUAu9opvQ
	(envelope-from <linux-can+bounces-7868-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2026 10:27:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9DF697895
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2026 10:27:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.de header.s=amazoncorp2 header.b=mtiF7WeN;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7868-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7868-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03788300B1FA
	for <lists+linux-can@lfdr.de>; Wed, 17 Jun 2026 08:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A1A387361;
	Wed, 17 Jun 2026 08:27:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F337FF5E;
	Wed, 17 Jun 2026 08:27:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684864; cv=none; b=oCXVo+Xm46bhLNSxVY9l3R2M1rSuP2h97nPS2eO5d9y1zAY6cdlWgLctXnPUj7WPWX35uO2a+nlX6O77Idl3iRlr0yeWilkwny3UkOcAJAEiCYS3eVvpDYWmJDBKVQT/4onVcw3npzthvfYoZKnuPvsLKN/B05BdIhtoUqOUhBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684864; c=relaxed/simple;
	bh=r9sZeaxe3pUr++wmb/xiaI0IEYYWb6Q9ehEWideg4KE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=doJLK6G3Rg9Q4pULJOS/4r9wHEdmwdDWOO6u82kDIXSaGJf0rXvgXQw2WwvocekP00Aokxk3SpzgxwSYHSYEhOdKt/3Fx/2eJD8yUjvXJaq3/cLHrGkpN/LtonCL29Oc2L5l+CdNZ3Gyb90533MNTKX54SWNnuKsKbL5JYBSloo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=mtiF7WeN; arc=none smtp.client-ip=52.34.181.151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781684863; x=1813220863;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8NJV7Az5hC42zPnR51skcbv2YcBqt0VqPNdlpHb48g4=;
  b=mtiF7WeNrEQIkcdmAqBgTyxj6WcQNPi0ab5IH6hCcFNPW/f7vXMAhEyQ
   R8jZJArMkSyoxpHe3iKz12OZdpDiR6kE4hCZ7GwW92QTWwaoeSQK2pVw6
   d3SveGn0szgKTER55EOU0tkpi2MxU0QWvN9/jJlAB95KVObFKw25gIh7G
   BaaKc52I1V4R4yKauzzgW7T11ofUVADEHBoe9NLrnRi6g1KFPMdAPI9Zw
   dj21cf7G+ihs+k8SpbjJl0PfKAIU+LoTKbgbB+ynReF4JEX69fOVcIkWb
   SAFHY5RDSSZzfsAKe6RCl/jPeg4kqDh+Fp//YI9sUhxnbSKMtU6ZssORv
   Q==;
X-CSE-ConnectionGUID: yHR+nAmTTHiGdapWCzHD8w==
X-CSE-MsgGUID: x3/lea4XS6yxcvLcm665lw==
X-IronPort-AV: E=Sophos;i="6.24,209,1774310400"; 
   d="scan'208";a="21919695"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 08:27:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:2850]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.226:2525] with esmtp (Farcaster)
 id 3e271752-6c9d-4c64-8acf-ffcd776a0a3f; Wed, 17 Jun 2026 08:27:38 +0000 (UTC)
X-Farcaster-Flow-ID: 3e271752-6c9d-4c64-8acf-ffcd776a0a3f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 17 Jun 2026 08:27:38 +0000
Received: from dev-dsk-mheyne-1b-8cc83676.eu-west-1.amazon.com (10.13.235.223)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 17 Jun 2026 08:27:36 +0000
From: Maximilian Heyne <mheyne@amazon.de>
To: <stable@vger.kernel.org>
CC: Maximilian Heyne <mheyne@amazon.de>, Wolfgang Grandegger
	<wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric W.
 Biederman" <ebiederm@aristanetworks.com>, <linux-can@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6.6.y] net: add missing ns_capable check for peer netns
Date: Wed, 17 Jun 2026 08:26:39 +0000
Message-ID: <20260617-sprain-dye-86c242ac@mheyne-amazon>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[amazon.de:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:mheyne@amazon.de,m:wg@grandegger.com,m:mkl@pengutronix.de,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ebiederm@aristanetworks.com,m:linux-can@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,amazon.de:dkim,amazon.de:email,amazon.de:from_mime,mheyne-amazon:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[mheyne@amazon.de,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7868-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mheyne@amazon.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A9DF697895

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
index 2b3b0beb55c88..ba4ca6c6bc9d8 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1857,6 +1857,11 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
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


