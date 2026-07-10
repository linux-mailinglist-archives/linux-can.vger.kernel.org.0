Return-Path: <linux-can+bounces-8307-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OQXHGhspUWrqAAMAu9opvQ
	(envelope-from <linux-can+bounces-8307-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 19:17:15 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C78E773CFBE
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 19:17:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Nhz+Jh5t;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8307-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8307-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C8AC303AFA6
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340F51E520A;
	Fri, 10 Jul 2026 17:05:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E4372073
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 17:05:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703110; cv=none; b=t8ArfM226ZEE3VTEIwE0aGEvbVAw6mOZ7l1aZMfDzRgNUkSPnwjgW05nLaqLw9PmhuCxgq/1F6UeT6E/vY0yMtkMAPA2SuFePq4IupMU18SKUT7jlgghq9V1i56sS6P5gaImZkChveUP8zzye8ZGq3l/QGVh5xLXRge7TTi/iZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703110; c=relaxed/simple;
	bh=pbcOR0HnkAgeBC8lVdQ32MOTBCVblOVSBVj7Qja2MHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W5L5Q/Q5OPMMGMP8spDZIGMCgvL63+hWirtzZ1t1kHWzyI6Aj8UttW8GcEt3kSzDwWkxinl2VwCge2ulc6gpP0j1r/gX0BX3ZmfVerfDG65tBiv2WpIzmhZ1fM+/FptXblqtUXKFjEfH3Mz4BhUYdV7ZxHr9X3N6kguZdJ5w1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nhz+Jh5t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F70A1F000E9;
	Fri, 10 Jul 2026 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783703108;
	bh=9FQI0R4O/oBQ//veQcQISTrg7XibI6WWzCBzNkcJ6CA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nhz+Jh5tZkmgi+NAXUm0O0AhjqBsqYibFlt9+870CnY6E2AxqAaOqDs9+db6Hwu8W
	 PRIHdppkHxUqCnSy7zI2jJu6BFGTM2ztAK/mjHoAsfUlBfJN4MnQ5v3U2vSJ0x65fR
	 KZ3RXA2UcHKqDWYyPVfjnfu24RxGFVzD0iHk0d77AuRxWi974GKxhtCyrjE7pVw2uH
	 R7VsbPJYI36+LA26ARCeDba2orHq08G3Tk9VQ9hsdc3F5iII8JDqPpNW06pPsc6IqX
	 KoLx1hYRVGvtpJ1TvrsHTPNUlQUTcpSIoz3LvU0SDcXNkuf7tXWEMZ/7XkC7xrV3au
	 MGMMXgDmGM4Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] can: isotp: use unconditional synchronize_rcu()
 in isotp_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260710-isotp-fixes-v5-1-15174d82d6f1@hartkopp.net>
References: <20260710-isotp-fixes-v5-0-15174d82d6f1@hartkopp.net>
 <20260710-isotp-fixes-v5-1-15174d82d6f1@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 17:05:07 +0000
Message-Id: <20260710170508.5F70A1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8307-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url,hartkopp.net:email,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: C78E773CFBE

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A race condition between `isotp_release()` and a device network na=
mespace move (or unregistration) causes `isotp_release()` to skip calling `=
can_rx_unregister()`. This leaves a dynamically allocated `struct receiver`=
 linked in the CAN device's `dev_rcv_lists`, holding a dangling pointer to =
the socket `sk` which is subsequently freed. When the device receives packe=
ts in the new network namespace, this triggers a use-after-free on the sock=
et.
--

--- Patch [1]: [PATCH v5 1/4] can: isotp: use unconditional synchronize_rcu=
() in isotp_release() ---
commit f75831bce5f2c912b988e63e3d43f06bda5b25c6
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: use unconditional synchronize_rcu() in isotp_release()

isotp_notify() unregisters the CAN filters and clears so->bound without wai=
ting
for a grace period. This commit updates isotp_release() to always call
synchronize_rcu() before cancelling timers to prevent a use-after-free timer
callback on a freed socket.

Closes: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.=
kernel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297e..d30937345bcdc 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1237,11 +1237,18 @@ static int isotp_release(struct socket *sock)
>  						  SINGLE_MASK(so->txid),
>  						  isotp_rcv_echo, sk);
>  				dev_put(dev);

[Severity: High]
This is a pre-existing issue, but does this code have a race condition when=
 a
device is moved to another network namespace?

If a CAN device is moved to a new namespace, dev_get_by_index() called
earlier in isotp_release() will return NULL:

    dev =3D dev_get_by_index(net, so->ifindex);
    if (dev) {
        if (isotp_register_rxid(so))
            can_rx_unregister(net, dev, so->rxid, ...

This causes isotp_release() to silently skip calling can_rx_unregister().

At the same time, isotp_release() prematurely removes the socket from
isotp_notifier_list. As a result, the notifier iteration skips the socket:

isotp_notifier() {
    ...
    list_for_each_entry(isotp_busy_notifier, &isotp_notifier_list, notifier=
) {
        spin_unlock(&isotp_notifier_lock);
        isotp_notify(isotp_busy_notifier, msg, dev);
    ...
}

This prevents the fallback unregistration in isotp_notify().

This leaves a dynamically allocated struct receiver linked in the CAN
device's dev_rcv_lists with a dangling pointer to the socket, which is
subsequently freed.

When the device receives packets in the new network namespace, could this
trigger a use-after-free on the socket?

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
>  	hrtimer_cancel(&so->txfrtimer);
>  	hrtimer_cancel(&so->txtimer);
>  	hrtimer_cancel(&so->rxtimer);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v5-0-15174d82d6f1@hartkopp.net?part=3D1

