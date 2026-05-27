Return-Path: <linux-can+bounces-7711-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIF6EKZKFmrZkQcAu9opvQ
	(envelope-from <linux-can+bounces-7711-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 27 May 2026 03:36:38 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 960265DE43A
	for <lists+linux-can@lfdr.de>; Wed, 27 May 2026 03:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55B13301B3C2
	for <lists+linux-can@lfdr.de>; Wed, 27 May 2026 01:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD792C08CF;
	Wed, 27 May 2026 01:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="HBeGFSMw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KLJvTvaG"
X-Original-To: linux-can@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0AF2F12CE;
	Wed, 27 May 2026 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779845791; cv=none; b=oKSBlWJq/B3it+4PmcSBQOna2mYv6SWtn3+YkW5yMTBi0VwV+aoI6mBY45D/2yCpaLQJe1BB/ijrHE3rcGeKjK2O8q1K1BKNosya0om8QvCNjrPbc4F2+Y7pwrlJUNeoU3NzmEaI+AQtHBU+JUcMNOdeHhxEkE25iNENcOtoL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779845791; c=relaxed/simple;
	bh=u8qYhEUFDkREIGNYiBLN4Glvu0JLRGv+4bRKviZv5HA=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=BMMOsd920qZstWUr8io+ofkVkNOJIufPbWugO0VVoPkys4tCm0S1jF+9n4Fzwue2eqILZ4UfoyYC+Zi6eC+LtusHlqK2a3EAEsFS47HRzLcXTDwfVmJl3aG6HAYqJY5FJEdleJNmd95ZxoVCNvavE0B7BH7JQeBChcPdGMWPknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=HBeGFSMw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KLJvTvaG; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F5F6EC0349;
	Tue, 26 May 2026 21:36:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 26 May 2026 21:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1779845786; x=1779932186; bh=/6wOTQuOX0LWCqoT3f5b7
	8tgherqXlA1fyPgmwwBvuc=; b=HBeGFSMwwkjCU2eQcPtfYvkY5QTyDCzw+Y8Xe
	WagNjudmmUk/5Jcx/nmSIRPoYVehJJLhFYrFBCSt7U6A9grH3YVI0MMxdNQ1nyCZ
	ec/Zfb30UE+bd02DLr1WRIejD1jFlmRUfrcZ27K3/oG6vLHqEmim8avWPPShw6g8
	6svBkpULiT7gzhGkDMuNjs4NidRMZN0NwYwKUwEmzaOicASPjVGA07+1n7WzM+JR
	9rE2xwY5tadq3bSuQmuACeK3NK1pwGKX9fIOOX5xeRbMlNboCr/aWcOKYWphX9Wh
	Gncu1z52DwZ3j0+99VDEP06x+fw4VVjLuz9S/VqudfHY4sx3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779845786; x=1779932186; bh=/6wOTQuOX0LWCqoT3f5b78tgherqXlA1fyP
	gmwwBvuc=; b=KLJvTvaGvqYqSUOGilHwI1gcJ8Zs0IG+ozuqRvfKxibnnSPQmio
	ltjIcTHqtEpfNWko771L4/DBjx8Dfxt9fQ1CaSZMZx9rFQc9BWHSbUcOzdHqYjO+
	w7BVXaXInj6jBwn7ghZZHUpK0nRdkpDI0pXCzq8XR3UJMqSLmcQpzA+slYQqErRl
	Cm6jJ0ex0kMugM3e+Ru9B7gJSjl/Iuat6p7KaCVMyk24Tge5ZNDtww1TqwRZ+3va
	xIFBLeOLMvwbw+6yzTU7XlHwdty1roxwKs/nqtWzCHOM/msJL8Mbuu+pL2cRrTi0
	FBUSn/ENb+POOsWUuFLkiA3JIjMozJ4H4cA==
X-ME-Sender: <xms:mUoWarN4OACkZ3Gg_m3Up2_N6omCS6qWTbUBTXegXXRW1PF4IP7c4g>
    <xme:mUoWauJG8hX4yV6G322Sd2WpVLcVGnvXtEKPYJy8Da8nwXw2uv13lBCS7xpIURe8w
    25lPFFZEuBYNKWXZZle7PHzimTpBfD8fLyAalkpIUCTWMGQIW99fylk>
X-ME-Received: <xmr:mUoWal38qeGi34n22VfgYC61Yd6tY1LvmH6KlCnBFB6rsRi1KlBbbBK2fvcnZLLufqkxOg>
X-ME-Proxy-Cause: dmFkZTGWujYF18Na0c7RNwkMtPja/qE0NDzaMthAkU+0jo0emL5xul7umzhSM7OqaSVmLW
    mGH1Oo3jBI4k3KDwVRQnkRby2lHsqOdGEECiD2FeMECiq0/3iufZUxmrBfsXBfYzwO4dxv
    vt524QMrHu17Uyjt+0hY4oUj+te7RG5o0ppDwxOh1hZ8r2kI7hWG7q1hVXgTFs/TFlPCJe
    8230RHm2PF611UAbuz7Qz+ZJ3uqn/iOtZ8u9ShWwM/IOTZpnp6WUCW3yz2Ns0gt8k1kcCR
    OYNp4Tnz3jcOcQIDge4Aa1RBTbSBP8QlQq4wzenfmeN2s7RC+lx/KGvQFGG2+WvYo233NR
    Hf9xTKs9lBKGNFJuh/zuZRSs66SgEwPeo6wiHeI3WpH1mnXEAq82f7pQAMX71Y6p7k2W0b
    1t2gQZ5dd3U7AfPX8fboGsjKG4otLGHhyf7vllzkzjs4D6I8vn9dK2I4aLB/r3fgGwMQi+
    KK8rahgEEmXD/s6ZLS5AvX8Oa9nAAYFaPgoO3Dhae2vayAs7Cbv55kORlJEVN1qu0VrYoF
    G8W+JRyVis0smpJtz71ZYu3yeXnnFhVumOCACD3oJR7CjxX/q/VLhUyOwFGzIKGcZ49Kvy
    YV53vZcV6UVH4zkB1nrzGhSR1JqwC+ZnCpIZ7OYzLKvjxgkHVTB7VSQZ2DLQ
X-ME-Proxy: <xmx:mUoWaqWHUHzZyG5HeCEyEUJ1hqPF7GIB1LlD9eIbIJHBUFg14RaUQg>
    <xmx:mUoWavNCkmFHVd8Zcd8OhF4TaDbZqdLnd20rGFxdxhpozunlfRRwpg>
    <xmx:mUoWal2mVVyEzkTfRV4USxjno_vP-ufSeBCTeBpksiC9gxdT6ld9MQ>
    <xmx:mUoWarR-dhfBAtf94EcS3ewcQaikn-5y0AKmjW-wQsgZIZqvQ4g_3A>
    <xmx:mkoWak82A5tMCPfaGioARUeOFCHDgVVeo3qzYgi42LvzKchaFcN-Kw7i>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 21:36:25 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 2B8859FC59; Tue, 26 May 2026 18:36:24 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 28A689FC50;
	Tue, 26 May 2026 18:36:24 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Oliver Hartkopp <socketcan@hartkopp.net>
cc: Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
    syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
Subject: Re: [PATCH] bonding: refuse to enslave CAN devices
In-reply-to: <20260526-bonding-candev-v1-1-ba1df400918a@hartkopp.net>
References: <20260526-bonding-candev-v1-1-ba1df400918a@hartkopp.net>
Comments: In-reply-to Oliver Hartkopp <socketcan@hartkopp.net>
   message dated "Tue, 26 May 2026 21:33:19 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <387284.1779845784.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 18:36:24 -0700
Message-ID: <387285.1779845784@famine>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7711-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,netdev,8ed98cbd0161632bce95];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 960265DE43A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Oliver Hartkopp <socketcan@hartkopp.net> wrote:

>syzbot reported a kernel paging request crash in
>can_rx_unregister() inside net/can/af_can.c. The crash occurs
>because a virtual CAN device (vxcan) is being enslaved to a
>bonding master.
>
>During the enslavement process, the bonding driver mutates
>and modifies the network device states to fit an Ethernet-like
>aggregation model. However, CAN devices operate on a completely
>different Layer 2 architecture, relying on the CAN mid-layer
>private data structure (can_ml_priv) instead of standard
>Ethernet structures. Since bonding does not initialize or
>maintain these CAN structures, subsequent operations on the
>half-enslaved interface (such as closing associated sockets
>via isotp_release) lead to a null-pointer dereference when
>accessing the CAN receiver lists.
>
>Bonding CAN interfaces is architecturally invalid as CAN lacks
>MAC addresses, ARP capabilities, and standard Ethernet
>link-layer mechanisms. While generic loopback devices are
>blocked globally in net/core/dev.c, virtual CAN devices
>bypass this check because they do not carry the IFF_LOOPBACK
>flag, despite acting as local software-loopbacks.
>
>Fix this by explicitly blocking network devices of type
>ARPHRD_CAN from being enslaved at the very beginning of
>bond_enslave(). This prevents illegal state mutations,
>eliminates the resulting KASAN crashes, and avoids potential
>memory leaks from incomplete socket cleanups.
>
>As the CAN support has been added a long time after bonding
>the Fixes-tag points to the introduction of ARPHRD_CAN that
>would have needed a specific handling in bonding_main.c.
>
>Fixes: cd05acfe65ed ("[CAN]: Allocate protocol numbers for PF_CAN")
>Reported-by: syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=3D8ed98cbd0161632bce95
>Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Acked-by: Jay Vosburgh <jv@jvosburgh.net>

>---
> drivers/net/bonding/bond_main.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index af82a3df2c5d..82e779f7916b 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -1888,10 +1888,16 @@ int bond_enslave(struct net_device *bond_dev, str=
uct net_device *slave_dev,
> 	const struct net_device_ops *slave_ops =3D slave_dev->netdev_ops;
> 	struct slave *new_slave =3D NULL, *prev_slave;
> 	struct sockaddr_storage ss;
> 	int res =3D 0, i;
> =

>+	if (slave_dev->type =3D=3D ARPHRD_CAN) {
>+		BOND_NL_ERR(bond_dev, extack,
>+			    "CAN devices cannot be enslaved");
>+		return -EPERM;
>+	}
>+
> 	if (slave_dev->flags & IFF_MASTER &&
> 	    !netif_is_bond_master(slave_dev)) {
> 		BOND_NL_ERR(bond_dev, extack,
> 			    "Device type (master device) cannot be enslaved");
> 		return -EPERM;
>
>---
>base-commit: d60ec36cab338dfe2ae40d73e9c8d6c4af70d2b8
>change-id: 20260526-bonding-candev-f4a0cf2eee9b
>
>Best regards,
>--  =

>Oliver Hartkopp <socketcan@hartkopp.net>

---
	-Jay Vosburgh, jv@jvosburgh.net



