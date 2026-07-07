Return-Path: <linux-can+bounces-8039-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TgPlFqO+TGpQpAEAu9opvQ
	(envelope-from <linux-can+bounces-8039-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 10:53:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E5F719655
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 10:53:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DvEgGcLB;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8039-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8039-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B012B3049C22
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7BC2EB87F;
	Tue,  7 Jul 2026 08:52:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219BA33FE2F
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 08:52:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414333; cv=none; b=gWdjJ9fhLhE5V8x0H5ntgI4XLWcmmcf6tqkLJrNm8PA1hSsBuTl/kMEkGldxMCeEwBPGeKqMSioiD78HJx6l+lqQlccNdZXQtYaaPFwSNMf8RBmnUpha38+oGvUgdolRCa9fAHWnyHZ9Okvq8tN7RCmR7HEJmd2AzIKyzFDmx+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414333; c=relaxed/simple;
	bh=vZ2x5LLuYqQbA2RVTQoOW+zhpdCCgacwjsPcmNZri7s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sX3FB8hb8TYMuFhgWKIfsmkcNJgHxO9Y8O39cQOZ3jA8qT8BP9BSLmkBrsddZaPmb+6dRJ9at7uxSLFCaaJSkfpmzQVKUGmNa7RV2D9Jmd4H5YkdiW9+U9erUoTuSn6C5zXKu34ZI2uqueQ+0QWc9n1FvMkQUhDF3KcX6ximnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvEgGcLB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6C01F000E9;
	Tue,  7 Jul 2026 08:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783414330;
	bh=6OqS2cQocPjohWCTM3AJ2Pno7d7Lpg6OH8IetN7Yl+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DvEgGcLBXvbIRAW3fgRarijhL7Io3IYgkTlZ5BPtG8Qu4vyAjd7TnKKcORBRzRuRt
	 EGsNeWIyNYLka5KEEIYvuINDmppZ2VPX//3c5B4l9bR02ccTQX+5OiGIXJJIoqFC8z
	 p1lqR/6WS5CVmSvAcxIDC6MFhJ4W8XehHqeMEq7Bc9adsW1CtlZMsDM99oX9cIqjVa
	 hIY9DFjurJ/fRmUYJtrAedej1/z1b+1M1jcyhfpxVKq5PdBrwGd53Rh/eDS/cbSeFk
	 yU5TRsV5H3wdU3QrErGFweAjDy4nLx5KOsTWU9NpuDMdRjS6FBaxUImf/EJMUTf3bc
	 HVKX3ssbWXgmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: isotp: add missing synchronize_rcu() in
 isotp_notify()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260707083228.47629-1-socketcan@hartkopp.net>
References: <20260707083228.47629-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:52:10 +0000
Message-Id: <20260707085210.6B6C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8039-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,hartkopp.net:email,lists.linux.dev:replyto,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5E5F719655

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] System-wide RTNL lock stall and DoS due to O(N) sequential synchro=
nize_rcu() calls in a netdevice notifier.

Pre-existing issues:
- [High] Race condition in isotp_release() and bcm_release() during concurr=
ent device unregistration leads to skipped filter unregistration, leaking r=
eceiver entries and causing UAF on CAN frame reception.
--

--- Patch [1]: [PATCH] can: isotp: add missing synchronize_rcu() in isotp_n=
otify() ---
commit e2052e358a8bcbb3b1bce1aa1280f280d7e67f64
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: add missing synchronize_rcu() in isotp_notify()

isotp_notify() unregisters the CAN filters without waiting for an RCU grace
period. This commit adds a synchronize_rcu() to wait for in-flight isotp_rc=
v()
callers to finish before clearing so->bound. This prevents a use-after-free
timer callback on a freed socket if isotp_release() skips its own
synchronize_rcu() when NETDEV_UNREGISTER runs first.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297e..008cee5472130 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1575,6 +1575,13 @@ static void isotp_notify(struct isotp_sock *so, un=
signed long msg,
>  			can_rx_unregister(dev_net(dev), dev, so->txid,
>  					  SINGLE_MASK(so->txid),
>  					  isotp_rcv_echo, sk);
> +
> +			/* wait for in-flight isotp_rcv() callers to finish
> +			 * before clearing so->bound, so that isotp_release()
> +			 * cannot observe so->bound =3D=3D 0 and skip its own
> +			 * synchronize_rcu() while a callback is still running
> +			 */
> +			synchronize_rcu();

[Severity: High]
Does this regression introduce an O(N) synchronize_rcu() stall under the
rtnl_lock?

Looking at isotp_notifier(), it loops over all sockets and calls isotp_noti=
fy():

net/can/isotp.c:isotp_notifier() {
    list_for_each_entry(isotp_busy_notifier, &isotp_notifier_list, notifier=
) {
        spin_unlock(&isotp_notifier_lock);
        isotp_notify(isotp_busy_notifier, msg, dev);
        ...
}

Because netdevice notifiers are invoked with the rtnl_lock held, iterating =
over
thousands of sockets bound to the interface will trigger sequential RCU gra=
ce
periods. Can this stall the rtnl_lock for minutes and freeze network
configuration tasks?


[Severity: High]
This is a pre-existing issue, but does a race condition in isotp_release()
also lead to skipped filter unregistration and a use-after-free?

If a socket is closed exactly while the device it is bound to is being
unregistered, dev_get_by_index() can return NULL because unlist_netdevice()
is called before the NETDEV_UNREGISTER notifier fires:

net/core/dev.c:unregister_netdevice_many_notify() {
    ...
    unlist_netdevice(dev);
    ...
    synchronize_net();
    ...
    call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
    ...
}

If isotp_release() executes in this window, it removes the socket from
isotp_notifier_list, then calls dev_get_by_index() which returns NULL:

net/can/isotp.c:isotp_release() {
    ...
    dev =3D dev_get_by_index(net, so->ifindex);
    if (dev) {
    ...
}

As a result, isotp_release() completely skips filter unregistration and the
synchronize_rcu() call. The notifier will subsequently skip this socket
because it is no longer in the list. The CAN receive filter remains active
and points to the socket which is then freed.

Could this cause a use-after-free if an isotp_rcv() callback is currently
in-flight or triggered by pending loopback frames? The same logic flaw
appears to exist in bcm_release().

>  		}
> =20
>  		so->ifindex =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707083228.4762=
9-1-socketcan@hartkopp.net?part=3D1

