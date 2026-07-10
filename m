Return-Path: <linux-can+bounces-8276-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iLaZAzvDUGrN4gIAu9opvQ
	(envelope-from <linux-can+bounces-8276-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 12:02:35 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE5F739644
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 12:02:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JBLoZ5Sy;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8276-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8276-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 926743009834
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 09:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178B33F8706;
	Fri, 10 Jul 2026 09:49:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEDC3F8EB2
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 09:49:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676999; cv=none; b=JSs/jJdA/YPIK/HhA3Plo0huzoun9pGvBHdbQmQslWP676sChiWzWOlVeBG5izSDgfAbAryFMHqUfqTjOz9KCtdBEYJUL6QtkIIemu5uiChtockLl7SH4QG6royEAAoBL881A45jbie7OMpI4wlGzXvzHgi/eaQgYirLy8R//UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676999; c=relaxed/simple;
	bh=PQvhusqomgLA59bF9tbWhuxepmwU8Nx4zrYwgJDUaIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U3cnUJhJ8SEf1tI8ZNp7TZduxBkj9OPKSQo4a62S+KgHxji1sKmb31DRV2X0LFVKPIbvbnt1R6Jr15oNgxHmljwKForGdkphdbE4/WcZ+5CdTuuj+x7Md46CJAt51Hhh3uJ6BjwfBaRNErS5D7Am773vU3A6gizmZ2NI801OGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBLoZ5Sy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A231F000E9;
	Fri, 10 Jul 2026 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676997;
	bh=yyumfNVpiSVghhSbTvoZEZjgfsx1r+cvhAS9cQTbtYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JBLoZ5SyGlXZirIIzqOq1ISMny56K71IqTWb1P7+5FiBlOIzVfau9VmNavU6Cg8n6
	 WmWFJbZ6jfTKoSYYj/Tdr8opVaLXI53hDzvyaK2sa38RnrLfR+rAzLkmAga+eF8Slm
	 KuCgtcVJ03t7dkLNMOuENA83MlLQOIEACF+uxAsLqvdfVZ/7SQbVTWWQgKbeoBQdp5
	 adpd8UGTd0IayEpUF5vr6MJAko/zw3d0Ks3uh4mfRTZfoAYSdmBilOfWFVg5pITYpq
	 7ybMJ8SECBDFxBgpldutN7MT7FPho2OFHeyM5KOQKDc96Z1za6xmKZmQiZxMwC+bqz
	 B1mxKEi8A5e1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] can: isotp: use unconditional synchronize_rcu() in
 isotp_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260710-isotp-fixes-v1-1-75a1d11d7df9@hartkopp.net>
References: <20260710-isotp-fixes-v1-0-75a1d11d7df9@hartkopp.net>
 <20260710-isotp-fixes-v1-1-75a1d11d7df9@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:49:56 +0000
Message-Id: <20260710094957.11A231F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8276-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp.kernel.org:mid,vger.kernel.org:from_smtp,hartkopp.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EE5F739644

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent lockless access to TX state variables leads to buffer c=
orruption and invalid frame transmission.
- [Medium] Concurrent socket release and netdevice unregister skips CAN fil=
ter unregistration, leading to a memory leak.
--

--- Patch [1]: [PATCH 1/2] can: isotp: use unconditional synchronize_rcu() =
in isotp_release() ---
commit fd9ce93db70bc0c54d097a98764dcfab2ecff812
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: use unconditional synchronize_rcu() in isotp_release()

This commit moves the synchronize_rcu() call in isotp_release() to run
unconditionally before timer cancellation. It ensures we always wait for any
in-flight isotp_rcv() callers to finish, preventing a use-after-free timer
callback race when NETDEV_UNREGISTER clears so->bound early.

Link: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297e..d30937345bcdc 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1237,11 +1237,18 @@ static int isotp_release(struct socket *sock)
>  						  SINGLE_MASK(so->txid),
>  						  isotp_rcv_echo, sk);
>  				dev_put(dev);
> -				synchronize_rcu();
>  			}

[Severity: Medium]
This isn't a bug introduced by this patch, but earlier in isotp_release(),
there is a check for dev_get_by_index():

	if (so->bound) {
		if (so->ifindex) {
			struct net_device *dev;

			dev =3D dev_get_by_index(net, so->ifindex);
			if (dev) {
				if (isotp_register_rxid(so))
					can_rx_unregister(net, dev, so->rxid,
							  SINGLE_MASK(so->rxid),
							  isotp_rcv, sk);

If isotp_release() runs concurrently with a NETDEV_UNREGISTER event,
dev_get_by_index() can return NULL. When that happens, does this skip the
can_rx_unregister() calls and permanently leak the CAN filters?

>  		}
>  	}
> =20
> +	/* Always wait for a grace period before touching the timers below.
> +	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
> +	 * filters and cleared so->bound in isotp_notify() without waiting
> +	 * for in-flight isotp_rcv() callers to finish, so this call must not
> +	 * be skipped just because so->bound is already 0 here.
> +	 */
> +	synchronize_rcu();
> +
>  	hrtimer_cancel(&so->txfrtimer);
>  	hrtimer_cancel(&so->txtimer);

[Severity: High]
This is a pre-existing issue, but could there be a lockless state corruption
involving the txtimer?

If isotp_tx_timer_handler() executes on CPU A, it sets
so->tx.state =3D ISOTP_IDLE and wakes up waiters:

	so->tx.state =3D ISOTP_IDLE;
	wake_up_interruptible(&so->wait);

Concurrently, if isotp_rcv_fc() executes on CPU B, it calls hrtimer_cancel(=
):

	hrtimer_cancel(&so->txtimer);

CPU B will spin waiting for the timer handler on CPU A to finish.

While CPU B spins, a blocked task in isotp_sendmsg() on CPU C can wake up,
see ISOTP_IDLE, and successfully execute the state exchange:

	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) !=3D ISOTP_IDLE) {

CPU C will then begin writing into so->tx.buf.

When the timer handler on CPU A finishes, hrtimer_cancel() on CPU B returns.
isotp_rcv_fc() then unconditionally sets the state to ISOTP_SENDING and cal=
ls
isotp_send_cframe():

	case ISOTP_FC_CTS:
		so->tx.bs =3D 0;
		so->tx.state =3D ISOTP_SENDING;
		...
		isotp_send_cframe(so);

Does this lead to isotp_send_cframe() concurrently reading from so->tx.buf
while isotp_sendmsg() is still writing to it?

>  	hrtimer_cancel(&so->rxtimer);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v1-0-75a1d11d7df9@hartkopp.net?part=3D1

