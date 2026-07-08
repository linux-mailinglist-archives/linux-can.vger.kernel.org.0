Return-Path: <linux-can+bounces-8123-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cwm/NAEbTmqADQIAu9opvQ
	(envelope-from <linux-can+bounces-8123-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 11:40:17 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E494723D52
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 11:40:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ju50rrjM;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8123-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8123-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B2F6300C3BE
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 09:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA3E383985;
	Wed,  8 Jul 2026 09:39:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1353E3290DE
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 09:39:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503594; cv=none; b=j1BZEdmO3ojTH/w2Ke4JYHlOCXRQ1bA9BSHBEWgY/4p6Hj40nU/Gq58/b4r37oLJ1EE5uVH8BVyc2HzEX4xiqRPnljJfxJoKD2x8VZ5aYiC+nNxG3p+Ef2dpWxbf3JIt3IOjnL9MM1OgsiRiYtfAZLCpgrbMtd6OZD8Ewkh2shU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503594; c=relaxed/simple;
	bh=y7ZYdBOSlLBpxKF6oE/ni4NBT7rVSSjY/f70O9fmnZM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wc5CNehlLB6y8bEu1DNkH4Nl/ymp31lDOCDP+/Em4JO1ccXQeoCW97XyO51W9bMjuDGOmxgG16VhhvAI3nQw+XBu1N09yob46NeGnIQpAVUm+YjFM+iVSlhV7VQnHPvUGp5Hm/89Tl2AeHojJvA3rovtB8QY00YJv+ZSGm+UEcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju50rrjM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9692A1F000E9;
	Wed,  8 Jul 2026 09:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783503593;
	bh=21QEGmqUHMfYdxT3fXlX+lrrnI3V7DpNpFtIzOvCxw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ju50rrjMQvqlhoqCiJre95JJxSjZFepRgseuyCP8zIuMIeaoDTtmb1i5p6BMClYCy
	 MrzhXhZhXgwbAuGhfj6Wl4vL3j6LnIlxjGbbC+iNr3fl08GXJxsowW9tdf/i+QMZtF
	 I+PlBlbaQUpewCqQwR4vSSEjC4QbcKqEHBDWYU2NKk4fHMyGqLp/SsL0Yf6+1bh6AH
	 aoCFEI0i6XI/R64+8dXOO7DDJ9/f2Sqs8aRKvPwshnEcdAEtnE8B7fnqj7U/HOTqpz
	 V//pt3qQ+0+KjyM/gBmyUypGXAMaicML0oapyygOwDCk4bqGeYZb/8lT21vydsHjBH
	 5uYuhLz23WcEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/9] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260708-bcm_fixes-v6-2-80710a2bc398@hartkopp.net>
References: <20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net>
 <20260708-bcm_fixes-v6-2-80710a2bc398@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:39:52 +0000
Message-Id: <20260708093952.9692A1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8123-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto,hartkopp.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E494723D52

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless, non-RCU iteration of the tx_ops and rx_ops lists in bcm_=
proc_show() races with concurrent list mutations, leading to list corruptio=
n and crashes.
- [High] bcm_release() leaks CAN receiver hooks and causes a Use-After-Free=
 if the network device is unregistered concurrently.
- [Medium] bcm_rx_setup() silently fails to register the CAN RX hook when u=
pdating an existing operation for a recreated device.
- [Medium] bcm_notify() accesses bo->ifindex locklessly during NETDEV_DOWN,=
 contradicting the patch's assumption and risking missed notifications.
--

--- Patch [2]: [PATCH v6 2/9] can: bcm: fix lockless bound/ifindex race and=
 silent RX_SETUP failure ---
commit 216efa99603464dc19876367ec3eb7d6e1414515
Author: Oliver Hartkopp <socketcan@hartkopp.net>
Date:   Wed Jul 8 09:22:28 2026 +0000

    can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure

This commit fixes a lockless race condition between bcm_sendmsg() and
functions that mutate bo->bound and bo->ifindex by re-validating the
state under the socket lock. It also addresses a silent failure in
bcm_rx_setup() when the target device is removed concurrently.

Link: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_p=
V3At4g=3Dh1kVEtyhA@mail.gmail.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index bdf53241bd7b3..b612135b017d1 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1323,6 +1323,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
> =20
>  				op->rx_reg_dev =3D dev;
>  				dev_put(dev);
> +			} else {
> +				/* the requested device is gone - do not
> +				 * silently succeed without registering
> +				 */
> +				err =3D -ENODEV;
>  			}
> =20
>  		} else

[Severity: Medium]
This is a pre-existing issue, but can bcm_rx_setup() silently fail to
register the CAN RX hook when updating an existing operation?

If a socket is bound to 'any' interface and a user issues an RX_SETUP
for a specific device that was previously removed and recreated, it
appears do_rx_register remains 0:

bcm_rx_setup() {
    ...
    if (op) {
        ...
        /* Only an update -> do not call can_rx_register() */
        do_rx_register =3D 0;
    }
}

Since bcm_notify() unregisters the hook and sets op->rx_reg_dev =3D NULL
when the device is removed, updating the dormant bcm_op without
registering the hook again leaves the socket unable to receive frames.

[ ... ]

> @@ -1535,7 +1564,12 @@ static void bcm_notify(struct bcm_sock *bo, unsign=
ed long msg,
>  				bo->bcm_proc_read =3D NULL;
>  			}
>  #endif
> -			bo->bound   =3D 0;
> +			/* Paired with the lockless fast-path check in
> +			 * bcm_sendmsg(); bo->ifindex itself is only ever
> +			 * accessed under lock_sock() so it needs no
> +			 * annotation.
> +			 */
> +			WRITE_ONCE(bo->bound, 0);
>  			bo->ifindex =3D 0;
>  			notify_enodev =3D 1;
>  		}

[Severity: Medium]
This is a pre-existing issue, but the new comment states bo->ifindex is
only ever accessed under lock_sock(). Is this accurate?

Looking at NETDEV_DOWN handling in bcm_notify(), it accesses bo->ifindex
locklessly:

bcm_notify() {
    ...
    case NETDEV_DOWN:
        if (bo->bound && bo->ifindex =3D=3D dev->ifindex) {
            sk->sk_err =3D ENETDOWN;
            ...
        }
}

Could a concurrent bcm_connect() cause this to read a stale bo->ifindex
and miss sending the ENETDOWN notification?

[ ... ]

> @@ -1676,7 +1710,7 @@ static int bcm_release(struct socket *sock)
> =20
>  	/* remove device reference */
>  	if (bo->bound) {
> -		bo->bound   =3D 0;
> +		WRITE_ONCE(bo->bound, 0);
>  		bo->ifindex =3D 0;
>  	}

[Severity: High]
This is a pre-existing issue, but does bcm_release() risk leaking CAN
receiver hooks if the network device is unregistered concurrently?

When a CAN socket is closed, bcm_release() relies on dev_get_by_index()
to find the device and unregister the hook:

bcm_release() {
    ...
    dev =3D dev_get_by_index(net, op->ifindex);
    if (dev) {
        bcm_rx_unreg(dev, op);
        dev_put(dev);
    }
}

If the device is being unregistered concurrently, it is removed from the
network namespace index by unlist_netdevice(), so dev_get_by_index()
returns NULL. This causes bcm_release() to skip calling bcm_rx_unreg(),
leaving a dangling pointer in the CAN core's dev_rcv_lists that can lead
to a use-after-free.

[ ... ]

> @@ -1746,7 +1780,10 @@ static int bcm_connect(struct socket *sock, struct=
 sockaddr_unsized *uaddr, int
>  	}
>  #endif /* CONFIG_PROC_FS */
> =20
> -	bo->bound =3D 1;
> +	/* bo->ifindex above is fully assigned before this point; pairs
> +	 * with the lockless fast-path check in bcm_sendmsg()
> +	 */
> +	WRITE_ONCE(bo->bound, 1);
> =20
>  fail:
>  	release_sock(sk);

[Severity: Medium]
This is a pre-existing issue, but does this lack the necessary memory
barriers to enforce ordering?

Because bcm_notify() can read these fields locklessly during a NETDEV_DOWN
event, doesn't WRITE_ONCE() alone fail to guarantee that the store to
bo->ifindex is visible to other CPUs before bo->bound =3D 1 without an
explicit smp_wmb()?

[Severity: High]
This isn't a bug introduced by this patch, but is there a race condition
between lockless list iteration in bcm_proc_show() and list mutations?

When a user reads /proc/net/can-bcm/*, bcm_proc_show() iterates over
bo->tx_ops and bo->rx_ops holding only the rcu_read_lock():

bcm_proc_show() {
    ...
    list_for_each_entry(op, &bo->tx_ops, list) {
        ...
    }
}

However, when adding elements, the writers appear to use list_add() instead
of list_add_rcu(), which fails to emit the necessary smp_store_release()
barriers:

bcm_tx_setup() {
    ...
    list_add(&op->list, &bo->tx_ops);
}

Can weakly-ordered CPUs make the new node's next pointer visible to the
lockless reader before the node itself is fully initialized, causing a
crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v6-0-80710a2bc398@hartkopp.net?part=3D2

