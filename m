Return-Path: <linux-can+bounces-7710-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL4WGav1FWqzfwcAu9opvQ
	(envelope-from <linux-can+bounces-7710-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 21:34:03 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F765DC05D
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 21:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 761043010830
	for <lists+linux-can@lfdr.de>; Tue, 26 May 2026 19:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8EE36E46C;
	Tue, 26 May 2026 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="icMq0wN3";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="3xLllx5+"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AA97E792;
	Tue, 26 May 2026 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824034; cv=pass; b=rljfxtx8+JE6TiwFKRhisJl+NvWPQgf3dOq/nO0GrbxL8zgWLFs/E8yHAUGyD7VK8Be6DQKw0W6Q4e3HZf2celZAVmJm2/qOoMfirTzu5si1KqXlF7GF9YplS4MoItSEHThNPsHAQfNYifWZmTLw5/6L4GoxliQHH28O9704hNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824034; c=relaxed/simple;
	bh=SYsPZs7a9SyuBfEe3D95+YF1+EA2QufZNXEnknDO+TM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kUbv3dYRayDtimK+B9BZAZHNz+pTV7vkRVJfxtCOtlChmn4OmOWxlm0sbv5YrypooGyyoGwAEoyTU+HDT/7Ag2aLpyBEfct4tIPpQi6MfDnm+Vkjm3EYRVaUfgoVoec+gTVn0Cr8T4TY7FWBxSpWWrnfdCfG1LtpulgzZ+/Mzpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=icMq0wN3; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=3xLllx5+; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779824015; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=i5MVm7OwmoD7M70nhAvZckQfB2wY0vbfNKIulTfGqXK8X8K5o+ujqiP+9Xk5C67ikf
    E5C1DTJ8t6uUyKBfT7OT0ilCa7w/VtI+3O7zzSRLfUBMxgSD0NCZgEaFa40DzleSW3oR
    48tczZLldL7Lu3i17B7ze7aP34sjWX3nr1XTGkwUOInrL06nNUq5+p1u0K4tLjCfwPv/
    5nxziUV+NkjpDrcD8RSCB/qRj7aoiNAy96VSMKCUed6hkNzN4HK+kK1WTtOl2T5nSZky
    FSBDENZKIh2DhvE6L+CdZVcurJoZ/y9pNl3KPOgZpIMyZaJF3zxrGwp7ciwJcq4CeNYy
    cPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779824015;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=yrKSjqssC7gr/00PqSV8FsCccDTknFlBMpv6CB0ZYwI=;
    b=ILIUjuQJFx1IUP6LCDn1wcP+FnGdSfDoXyiZ4+DcVucBEY++ExLpOdievGnFtCaNBr
    cknSwmL3d3Z5/M0jdlB5XKaM0P8vHYlvZwMjWWOtsF6WFWeSyPmwIsM8DejU9fWAxolP
    8LTOF2g1sDgVo/EmLgYG3JAFAUswWJeCNeFVJ/a3ZjXjZd7UbjQzrJG4jZ/Uo+OoXUSK
    ma+AvqG9kGMGL7a4CGYjxQXtmVJMZNX5OSKoNzh09YZV0fghu02dFrfwXpO7bKcsywCU
    TIHyUv1xGOyfzFGZugIX2WzzK41KJ951kCE6hfwNWMU7LMNUln1ZhXjEIpFs/43C9QxH
    UYKw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779824015;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=yrKSjqssC7gr/00PqSV8FsCccDTknFlBMpv6CB0ZYwI=;
    b=icMq0wN3eA3rciBQDzBrgiImtbzJEo9yIqJ3I6eKsWc50STpPzyoftpV+I13kf/FEO
    BtdgcSlL730g6zLbV1ZgtzCqCo4XKhoMd6Y1yvaQYtiAj8JEFA0lPK2PmeEztQYiBsQN
    UmNut6iXarMFzGIItE4U+HZ67YgdIYAuRmS7wghL0JIIZ9y6eH1gDgnOCULcjC7L63sL
    /YRNispoeq21Y2S+gosZB1M2+AsTS/yab62iCX5uVsY0IZwNNme9SkZ3MUJaSSOeOGvp
    OncmIVfhbT7V0PJ1R0bXHaoB8Esa5rYjmjzUwaYXJ37+K++bKPAkmXxbfo6hON1HstQ6
    UsIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779824015;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=yrKSjqssC7gr/00PqSV8FsCccDTknFlBMpv6CB0ZYwI=;
    b=3xLllx5+Bsy1kpofotGWpNEtevngMTbRZvYf8qdjqN0Kib4b4PPFDZYx14CA0Iuw9J
    jdrjDP9juST8fWaSJ2Cw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24QJXZedT
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 26 May 2026 21:33:35 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Tue, 26 May 2026 21:33:19 +0200
Subject: [PATCH] bonding: refuse to enslave CAN devices
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-bonding-candev-v1-1-ba1df400918a@hartkopp.net>
X-B4-Tracking: v=1; b=H4sIAH71FWoC/yXMSwqDMBRG4a3IHRuIQQW7FXGQxx97HVxLoiKIe
 29qh9/gnIsyEiPTq7oo4eDMqxQ0dUX+bWWG4lBMRpted6ZXbpXAMitvJeBQsbXaRwNgcFSiT0L
 k8xmO0995dwv89rvQfX8BRdgU5XIAAAA=
X-Change-ID: 20260526-bonding-candev-f4a0cf2eee9b
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-can@vger.kernel.org, 
 syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779824015; l=2929;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=SYsPZs7a9SyuBfEe3D95+YF1+EA2QufZNXEnknDO+TM=;
 b=UywXRtabtOqgKOVcXvRWj/TPgcI73jizoiw2nanEO1TDm9SYNzs5otxERjnIKjSIU7bYvqtpK
 so19BlLEtzAC7hbrNj1n4HkqwWerR6aSEnpZTX6EYIP85ccNJ6bwlqG
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7710-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,netdev,8ed98cbd0161632bce95];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 61F765DC05D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot reported a kernel paging request crash in
can_rx_unregister() inside net/can/af_can.c. The crash occurs
because a virtual CAN device (vxcan) is being enslaved to a
bonding master.

During the enslavement process, the bonding driver mutates
and modifies the network device states to fit an Ethernet-like
aggregation model. However, CAN devices operate on a completely
different Layer 2 architecture, relying on the CAN mid-layer
private data structure (can_ml_priv) instead of standard
Ethernet structures. Since bonding does not initialize or
maintain these CAN structures, subsequent operations on the
half-enslaved interface (such as closing associated sockets
via isotp_release) lead to a null-pointer dereference when
accessing the CAN receiver lists.

Bonding CAN interfaces is architecturally invalid as CAN lacks
MAC addresses, ARP capabilities, and standard Ethernet
link-layer mechanisms. While generic loopback devices are
blocked globally in net/core/dev.c, virtual CAN devices
bypass this check because they do not carry the IFF_LOOPBACK
flag, despite acting as local software-loopbacks.

Fix this by explicitly blocking network devices of type
ARPHRD_CAN from being enslaved at the very beginning of
bond_enslave(). This prevents illegal state mutations,
eliminates the resulting KASAN crashes, and avoids potential
memory leaks from incomplete socket cleanups.

As the CAN support has been added a long time after bonding
the Fixes-tag points to the introduction of ARPHRD_CAN that
would have needed a specific handling in bonding_main.c.

Fixes: cd05acfe65ed ("[CAN]: Allocate protocol numbers for PF_CAN")
Reported-by: syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8ed98cbd0161632bce95
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/bonding/bond_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index af82a3df2c5d..82e779f7916b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1888,10 +1888,16 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	const struct net_device_ops *slave_ops = slave_dev->netdev_ops;
 	struct slave *new_slave = NULL, *prev_slave;
 	struct sockaddr_storage ss;
 	int res = 0, i;
 
+	if (slave_dev->type == ARPHRD_CAN) {
+		BOND_NL_ERR(bond_dev, extack,
+			    "CAN devices cannot be enslaved");
+		return -EPERM;
+	}
+
 	if (slave_dev->flags & IFF_MASTER &&
 	    !netif_is_bond_master(slave_dev)) {
 		BOND_NL_ERR(bond_dev, extack,
 			    "Device type (master device) cannot be enslaved");
 		return -EPERM;

---
base-commit: d60ec36cab338dfe2ae40d73e9c8d6c4af70d2b8
change-id: 20260526-bonding-candev-f4a0cf2eee9b

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>


