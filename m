Return-Path: <linux-can+bounces-8318-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bx+wKhldUWq9DAMAu9opvQ
	(envelope-from <linux-can+bounces-8318-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:59:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 273D273E8A8
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:59:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XpmtKCk9;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8318-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8318-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84BC9300A516
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 20:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E23635C1A6;
	Fri, 10 Jul 2026 20:58:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080F380FCA
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 20:58:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717111; cv=none; b=mqx+5Wd2F9dF3WGOQAxZjJM8heKUjhsA9i0tjSNRwijPh94DM7DhDhrlhH/DQDLziJswCY9AGr3jO+RJ5exSIkiIgQPkSCl3szKhKqOwutIzrLg13zgL/vw3rMQh7gk79IUbCxkUGcQ+rtNsd2CGAGkeB19YzX9JSKtRD1jokJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717111; c=relaxed/simple;
	bh=xwZ1HrP0Qs9Lflg4igSsoJ4ckPpO1p3MxU6FrPk01kA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gXfm4UJoycS9jnkw48XI28KCwqEv4MiW87nLG/OKH+Lox1jBTCdFpDpGtIYncDFJZdzbQSsgx79axmxDtERGoLrMjUrwaH1hn8yHfiuEAkeDeQSZrcLbV5wRLSdOFFVfDzEiLc1g+a3AtJ1ldCaO3ZzakDGo+Y8LOg2vicqvfBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpmtKCk9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9411F000E9;
	Fri, 10 Jul 2026 20:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717110;
	bh=QRxlOoDy/Z0zVAmMeS7Z6lI1l6e6Tfs5VwdJgz5fVt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XpmtKCk993GaWL+8mRqfX1smFwPs6+UR0ha50BGICgfS7aeUFweiA7SvggQ7Fo5AC
	 9pb34i+QvrkaFp8ui0WxM1+n962Mli2aOpJ4NCVZQjCU6k5jlhc120UtGWQleAAixo
	 J5mDEXFlFhV6ORc664/wj5LRahi3I1vg1aIaBfQkSV4ZKdd4VhEd2QFpIWZQYBE6Lg
	 7dwI68pWaiMLCfAX/K3jYJnvP9WkcfCHUEhOnhBTWc0RnLzxWX2WB/KLKbco8nRulq
	 c5CP2jL96Z14iDPnTHgx+HCykMXrG+Vw44JTNHyVtkNtwX+VN48EcbNHwbQHwXbYAM
	 0gNzdgN6pQfuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] can: isotp: use unconditional synchronize_rcu()
 in isotp_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260710-isotp-fixes-v6-1-a13c2539093d@hartkopp.net>
References: <20260710-isotp-fixes-v6-0-a13c2539093d@hartkopp.net>
 <20260710-isotp-fixes-v6-1-a13c2539093d@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 20:58:29 +0000
Message-Id: <20260710205829.9B9411F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8318-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:email,smtp.kernel.org:mid,sashiko.dev:url,trendmicro.com:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 273D273E8A8

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race conditions between isotp_release/isotp_bind and NETDEV_UNREGI=
STER cause CAN filters to be leaked, leading to a Use-After-Free of the soc=
ket.
--

--- Patch [1]: [PATCH v6 1/5] can: isotp: use unconditional synchronize_rcu=
() in isotp_release() ---
commit 9e3b5ef819dd616609004db7956c6318a9ae781a
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: use unconditional synchronize_rcu() in isotp_release()

isotp_notify() unregisters the (RCU) CAN filters via can_rx_unregister()
and clears so->bound without waiting for a grace period. isotp_release()
uses so->bound to decide whether it needs to call synchronize_rcu()
before cancelling so->rxtimer, so when NETDEV_UNREGISTER runs first it
skips that synchronize_rcu() and can cancel the timer while an
in-flight isotp_rcv() is still executing and about to re-arm it via
isotp_send_fc(), leading to a use-after-free timer callback on the
freed socket.

sakisho-bot remarked a problem with rtnl_lock held in isotp_notify(),
therefore make isotp_release() always call synchronize_rcu() before
cancelling the timers, regardless of so->bound. This still closes the
original race (isotp_notify() clearing so->bound without waiting for
in-flight isotp_rcv() callers before isotp_release() cancels the RX
timer) without adding any RCU wait to the netdevice notifier path.

Fixes: 14a4696bc311 ("can: isotp: isotp_release(): omit unintended hrtimer =
restart on socket release")
Closes: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.=
kernel.org/
Reported-by: Nico Yip <zdi-disclosures@trendmicro.com> (ZDI-CAN-31764)

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

[Severity: High]
This is a pre-existing issue, but can race conditions between isotp_release=
()
or isotp_bind() and NETDEV_UNREGISTER cause CAN filters to be leaked,
potentially leading to a use-after-free of the socket?

If a user creates a CAN interface, binds an ISOTP socket, and concurrently
unregisters the interface while closing the socket, isotp_release() removes
the socket from the notifier list:

net/can/isotp.c:isotp_release() {
        ...
        list_del(&so->notifier);
        spin_unlock(&isotp_notifier_lock);
       =20
        lock_sock(sk);
        ...
}

This blinds the NETDEV_UNREGISTER notifier. If isotp_release() executes bef=
ore
isotp_notify(), the notifier skips the socket. When isotp_release() then tr=
ies
to clean up the filters, if the netdevice is already unlisted, it might skip
the can_rx_unregister() call. The socket would then be freed, but the active
CAN filter could still point to it.

A similar window exists in isotp_bind(), where the filters are registered
before so->ifindex is updated:

net/can/isotp.c:isotp_bind() {
        ...
        if (isotp_register_rxid(so))
                can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id), ...);
       =20
        can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id), ...);
        dev_put(dev);
       =20
        /* switch to new settings */
        so->ifindex =3D ifindex;
        so->rxid =3D rx_id;
        ...
}

If a concurrent NETDEV_UNREGISTER runs during this window, isotp_notify()
ignores the socket because it locklessly checks if (so->ifindex !=3D dev->i=
findex),
bypassing the unregister and leaking the filter when the socket is later
released.

Could this allow a local unprivileged user utilizing virtual CAN (vcan)
devices to trigger a use-after-free?

>  	hrtimer_cancel(&so->txfrtimer);
>  	hrtimer_cancel(&so->txtimer);
>  	hrtimer_cancel(&so->rxtimer);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v6-0-a13c2539093d@hartkopp.net?part=3D1

