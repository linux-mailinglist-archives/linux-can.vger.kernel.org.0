Return-Path: <linux-can+bounces-7699-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LhtHXWNFGpcOQcAu9opvQ
	(envelope-from <linux-can+bounces-7699-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 19:57:09 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B85335CD7D8
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 19:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8FEA30157C9
	for <lists+linux-can@lfdr.de>; Mon, 25 May 2026 17:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333EF382F0C;
	Mon, 25 May 2026 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZJx5DOW2";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bgdYCwaI"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E428726E
	for <linux-can@vger.kernel.org>; Mon, 25 May 2026 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779731822; cv=pass; b=cEks24pfinnT9lkBMNQoDPE9WAu3Y9MmIo95wj31xxHQ1LYCPgrzlBI0LmkLpfyHyo4qYozjPxGqgXcjn9FeZYzC2wgdVt5SzsdZ2v6mILtG7cg/euNjEXuYWBx7/R+qoizKFGH9F+G6sqSAvwBBVWx6+4g5iq0bBe7odazo0XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779731822; c=relaxed/simple;
	bh=aVDN3Y9E+T1cU3cqvluZvLjFXci+hHp1dm7+R9kAfuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HDTiZMyjMzreplE5+KpD74yQ3QmzarKelCk93klXvFjIh8cs32k9nmEm39xwN6si953HsK2c3GF99KSKq8eticI8R+PIt+o32heFKML0Ezs28WQK8HoxqG/Ba1pVAPyeZMrA7d1t7PZf1lvt/C3/aPAJE/y7Zva2HPzWOSvWtyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZJx5DOW2; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bgdYCwaI; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779731809; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SlVN4E59S23TclTpTN3r5dTOTYdfkGMvc4hV1L8G7KDvD60tNNwbvFBxvMkITD+Tsp
    Yzk6jZL34DVLL7cnOXJC5Zx7+NZtBWuYA0R8xrYBy0F7Jfyix4HAOTwJD0I6gWExGSPs
    CDF4uVFtjNBpZdDQyp7ji7/LrAyqku1GsIZr4OIjwDHiU/BzTx7bpLEYfqd58YlWHOuC
    D2bYDewSGySa3efWkOQgD4TPNVTDDRIdQ0VN3RW/LrvNvMZ5fpnfjJcyDeiMjyLoxRtI
    SAY1Qrto4n3ArojvbHdvnR4pPBOp1vI5Mf6Z3eTRmWFtA4XCwJ9pZonGzstBHlvs02fa
    YXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779731809;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=oC02WjLpMkUCHQXqdYLjvQfWHgDRX9fv+PutQaw4OQE=;
    b=O53zBUm4KT8iQSsiAPJeVq17a293LDgPSmr+4MYO/uGcgEwX6qA//7wmqcuWbCY28K
    RDk/49OiyNifJCdRXqv8l7SIf5ugoNS6w+ngsimP/bo9ted8bL8GIl6CPPrQvgqqSJb1
    TxMBba1Ms7fJI4cCQ0vqAHTawbsnwvH0CEgxs0+1awD2PFJJ6fe1M5SqlHGAd7l7u7ey
    2OvQaqY48d0w4yYpW3zZLKwyH13pzgAk4UJO9ZGbNARZcato8hzjS8DfkLE+0kL7jhBV
    f+guggUEChzZkd6rbsC6LzHIvUT01aD/7k6zUURAG9iKwG9+h4Sl0jw/xmnjTTmpc2re
    BQjA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779731809;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=oC02WjLpMkUCHQXqdYLjvQfWHgDRX9fv+PutQaw4OQE=;
    b=ZJx5DOW2TerLwJD+fIQKaqbXmPLtAGcVGk+vwJZ5F1MZ+hInfbqIY84fwW+RSbWhQV
    fHDZ5RfkAwQ9hpk89oRcKDO6JP29fJGbIt/GOz47hylFn0zpw6GIzdAhYAtc+i6WiwF/
    F87pOJRSToosOH92iI+2Xsby7mejq5/xcOGo+vDcUKbJnCNZKFdnTPHK5X6kB/AsG+uY
    +B1WIb+T5/MfuhLQCSIUZTwNJurs7PFhvM+7aPjJrLZST+uEu+nbvXW0IyX0n9Jcn1cb
    /m4duuFK+IlJGatxsu5aPvCbnMQCkHcPkBT40ItnXXKOshZYJR9NIhOtPP7zDFA7KJUF
    WJYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779731809;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=oC02WjLpMkUCHQXqdYLjvQfWHgDRX9fv+PutQaw4OQE=;
    b=bgdYCwaIc2XsFj0LCmLzwPY8e0lHqHeQ9FG0AH4cZIKz+VqyBUlw7+odOIc4DxvddR
    oXTBppEIM0TpNtfKEPDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24PHunZ1m
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 25 May 2026 19:56:49 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
Subject: [PATCH] bonding: refuse to enslave CAN devices
Date: Mon, 25 May 2026 19:56:39 +0200
Message-ID: <20260525175639.112492-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7699-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,8ed98cbd0161632bce95];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B85335CD7D8
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
-- 
2.53.0


