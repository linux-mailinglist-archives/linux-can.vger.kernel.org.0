Return-Path: <linux-can+bounces-8292-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DV8rBCfxUGpq8wIAu9opvQ
	(envelope-from <linux-can+bounces-8292-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 15:18:31 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8292E73B2C3
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 15:18:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Nof3bDNo;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8292-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8292-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D5AF300E171
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E314071C6;
	Fri, 10 Jul 2026 13:18:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7861F875A
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 13:18:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783689487; cv=none; b=Rl1p+ST2J1FEiwBAbvw38ven4X4iMVCMKmcCau9hZl12rohhrGLYpRCDPm8fJhZynUjtcqCcdqAEQFVlUIq0WUjiSHgCgbh5PUwxrT50exIgkDBBJqON+6p3VEELiMcv5g9Cb0XJNQNznAV3Txr39Sg+DSkp+/Wj3SevoO9XwMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783689487; c=relaxed/simple;
	bh=5GjHetTW4hwOYz40PhlSzUcgylji7TyCd1Dwv6YCZYk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ukujmA2m4mN79LQKdKbYypFwCdCAC0e0uxkqZ1bWH5CnjFSxrfXaVuIL5uTHedG7hxXKplnPOZ/i1rRADLSevJK/q1Rgo+kvbrd62apdWTiDv84NzzXhCjBEpgESSG29Y8c87gXQivgTCWrKUmnoYrxPycFImrFqmkhn5gjB7co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nof3bDNo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5861F000E9;
	Fri, 10 Jul 2026 13:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783689485;
	bh=GumaR7j2cCcoNoScYNl6TpWmD7QEAOlyP08KtESVeKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nof3bDNocpcSWoZRy1dAJNG4jISlTEfR367EgLfeMD/+Hj5GCavhbiWflLWW92t0j
	 efmV9rSFPyA/zKkvbD+8s8xCCTyoQ7JBeWSDXp2wGSttIRJxi5oJUSSuHmPFLvJ7VH
	 rLfLFikkYlkFwNfsPilYFzlblzht+Rx3OCJ0Sk8rP6bCfj+3CyxOuP9GafPFJrqkJh
	 zBnDDT1DIFslxK/Msnr5hJGPgSja9z1EdUZR2dKgRCISdULIhlA4fupTEzKhuiR+Ks
	 KrsLNw26T+aE8aNfGZVput9Qg3qh+GqX6lciV0KICTnjxgPuMsVi9u0+jCj47J9ntZ
	 cIu98nCHGhpyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] can: isotp: use unconditional synchronize_rcu()
 in isotp_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260710-isotp-fixes-v3-1-08db68e27d0b@hartkopp.net>
References: <20260710-isotp-fixes-v3-0-08db68e27d0b@hartkopp.net>
 <20260710-isotp-fixes-v3-1-08db68e27d0b@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 13:18:04 +0000
Message-Id: <20260710131805.6E5861F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8292-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,hartkopp.net:email,vger.kernel.org:from_smtp,lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8292E73B2C3

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unconditional `synchronize_rcu()` in `isotp_release()` introduces =
a local Denial of Service vulnerability.

Pre-existing issues:
- [Critical] Race condition between `isotp_release()` and `NETDEV_UNREGISTE=
R` leads to a permanently leaked CAN filter and a critical Use-After-Free.
--

--- Patch [1]: [PATCH v3 1/2] can: isotp: use unconditional synchronize_rcu=
() in isotp_release() ---
commit 1f00ee97fef2fda17e134f34cc9af1db10cbadf6
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: use unconditional synchronize_rcu() in isotp_release()

This commit forces an unconditional synchronize_rcu() in isotp_release()
regardless of whether the socket was bound. This is intended to close a race
condition with NETDEV_UNREGISTER clearing so->bound and cancelling timers
while an in-flight isotp_rcv() is executing.

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
>  		}
>  	}

[Severity: Critical]
This is a pre-existing issue, but can a race condition between isotp_releas=
e()
and namespace migration lead to a leaked CAN filter and a use-after-free?

If a CAN device is moved to a different network namespace while concurrently
closing a bound ISOTP socket, dev_change_net_namespace() calls
unlist_netdevice(dev), synchronize_net(), and then broadcasts
NETDEV_UNREGISTER.

If isotp_release() runs during synchronize_net(), dev_get_by_index() returns
NULL because the device is already unlisted:

dev =3D dev_get_by_index(net, so->ifindex);
if (dev) {
	if (isotp_register_rxid(so))
		can_rx_unregister(...);

This causes isotp_release() to silently skip can_rx_unregister(). When
NETDEV_UNREGISTER is subsequently broadcast, isotp_notify() skips the socket
since it is no longer in the list. Does this leave the CAN filters in the
device's dev_rcv_lists with a dangling pointer to the freed socket, allowing
a received CAN frame to trigger a use-after-free in isotp_rcv() when the
device is brought up in the new netns?


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
>  	hrtimer_cancel(&so->rxtimer);

[Severity: High]
Does moving synchronize_rcu() outside the bound-checking block introduce a
denial of service vector for unbound sockets?

Because the wait is now unconditional, it is executed for every closed
socket. Unbound sockets never arm timers. Could an unprivileged user
trivially write a loop that repeatedly creates and closes unbound CAN_ISOTP
sockets to spam the RCU subsystem with back-to-back grace period requests?

Would skipping this wait via a flag indicating if the socket was ever bound
prevent this performance degradation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v3-0-08db68e27d0b@hartkopp.net?part=3D1

