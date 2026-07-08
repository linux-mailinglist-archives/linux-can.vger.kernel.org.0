Return-Path: <linux-can+bounces-8126-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FFnAE10cTmrMDQIAu9opvQ
	(envelope-from <linux-can+bounces-8126-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 11:46:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E6D723DBA
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 11:46:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CRhJFIce;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8126-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8126-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A96503016276
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC43C420883;
	Wed,  8 Jul 2026 09:45:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27D71F130B
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 09:45:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503938; cv=none; b=MzOob4HL2Kszbjp0YQsZ1uiP9gLKIg32cuf40SYbSqP8O6ieRTEIVKExiRXHc4Inl++Dm4PUDlZM/QWPTmL/ULhZ5L+cn4rPKRVU3ETMJXhyn0uAqibYI2El/HytyIFe7z4b+FM/JE9n2BEUBa1CfqAklhF5sMJPyhP2/8FWShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503938; c=relaxed/simple;
	bh=oxauLrqwmmKWSdHWAAND9Tk3oSclpM4uoFn3N5gTRu4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ELp+jDLKjDngXqm/5TrhQL+iOWSj1ZmE75h7FFAksAIvdA+FDdbsoRkJyu/GSGnqy4SaabcQ93nfhKY5myT9yOZkEAog25zNTwYlhR/+UWnmrfTunBdVUcL+B248grybQZawaakgTPeEjFkXL2wrEoV5ziV3mg8QxXeiLjVBnHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRhJFIce; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF821F00A3A;
	Wed,  8 Jul 2026 09:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783503937;
	bh=3HLWmzuY/2+UztgxPcEMcvrEI/wmAE9RAYgDJSyq/+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CRhJFIceEzYYcB0840fDXTQFZRXXYXfD9VMsKKG4EXh0Y39Rg0R3NynILMe/313wt
	 YgLLMI9SbTtr82e7cF7jnTJufrYk5AHMr8A4S/9cUb7m2ewB8nYvvBKtcTj5YlWLiA
	 NoSDxCj9f5/tzuyTFexwMwnPMOLYrtIMoaQGfWrXM8xZhWoWCmmmujZCxjntc5tWzo
	 xHGuaJduPzTIyppsgAB4gboRTrLcP6T8UCMmmKh+ooZ+7ISUvUbh6SDHbtGoaZbC5i
	 ECQ6W/VeCPGXWjn0A1UWLgoIMJKcmXugN/ib12krBXJKK8nAMkV66X8FwSXuq5ESPw
	 Fn3CcHcl6EUQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/9] can: bcm: add missing device refcount for CAN
 filter removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260708-bcm_fixes-v6-8-80710a2bc398@hartkopp.net>
References: <20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net>
 <20260708-bcm_fixes-v6-8-80710a2bc398@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:45:36 +0000
Message-Id: <20260708094536.DDF821F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8126-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:email];
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
X-Rspamd-Queue-Id: A9E6D723DBA

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] BCM TX operations (tx_ops) are not cleaned up during NETDEV_UNREGI=
STER, causing continuous timer firing and potential cross-device traffic in=
jection upon ifindex reuse.
- [Medium] Updating an existing BCM RX filter after device recreation silen=
tly fails to re-register the CAN receiver.
--

--- Patch [8]: [PATCH v6 8/9] can: bcm: add missing device refcount for CAN=
 filter removal ---
commit e5a4c52c71d52a19d27614862f641c4332b115e5
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing device refcount for CAN filter removal

This patch fixes a CAN filter removal issue where a concurrent=20
NETDEV_UNREGISTER can cause a lookup failure for a device by ifindex.
It prevents skipping can_rx_unregister() by holding a netdev reference on
op->rx_reg_dev from filter registration until unregistration, rather than
looking up the device by index again.

Link: https://sashiko.dev/#/patchset/20260707094716.63578-1-socketcan@hartk=
opp.net

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 300f1f88c4d2c..4bdca72f9327f 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1455,7 +1454,17 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
>  						      bcm_rx_handler, op,
>  						      "bcm", sk);
> =20
> -				op->rx_reg_dev =3D dev;
> +				/* keep a tracked reference so that a later
> +				 * unregister can safely reach the device even
> +				 * if a concurrent NETDEV_UNREGISTER has
> +				 * already unlisted it by ifindex
> +				 */
> +				if (!err) {
> +					op->rx_reg_dev =3D dev;
> +					netdev_hold(dev,
> +						    &op->rx_reg_dev_tracker,
> +						    GFP_KERNEL);
> +				}
>  				dev_put(dev);

[Severity: Medium]
This is a pre-existing issue, but does updating an existing BCM RX filter
after a device recreation silently fail to re-register the CAN receiver?

Looking at bcm_rx_setup():

    op =3D bcm_find_op(&bo->rx_ops, msg_head, ifindex);
    if (op) {
        ...
        /* Only an update -> do not call can_rx_register() */
        do_rx_register =3D 0;

Updates to existing ops unconditionally skip CAN registration, even if the
previous registration was torn down by a NETDEV_UNREGISTER event leaving
op->rx_reg_dev as NULL.

Could this cause the application to silently drop incoming frames?

[ ... ]
> @@ -1832,16 +1841,14 @@ static int bcm_release(struct socket *sock)
>  			 * Only remove subscriptions that had not
>  			 * been removed due to NETDEV_UNREGISTER
>  			 * in bcm_notifier()
> +			 *
> +			 * op->rx_reg_dev is a tracked reference taken
> +			 * when the subscription was registered, so it
> +			 * stays valid here even if a concurrent
> +			 * NETDEV_UNREGISTER already unlisted the device.
>  			 */
> -			if (op->rx_reg_dev) {
> -				struct net_device *dev;
> -
> -				dev =3D dev_get_by_index(net, op->ifindex);
> -				if (dev) {
> -					bcm_rx_unreg(dev, op);
> -					dev_put(dev);
> -				}
> -			}
> +			if (op->rx_reg_dev)
> +				bcm_rx_unreg(op->rx_reg_dev, op);

[Severity: High]
This isn't a bug introduced by this patch, but are TX operations properly
cleaned up during NETDEV_UNREGISTER?

When looking at bcm_notify():

    case NETDEV_UNREGISTER:
        lock_sock(sk);

        /* remove device specific receive entries */
        list_for_each_entry(op, &bo->rx_ops, list)
            if (op->rx_reg_dev =3D=3D dev)
                bcm_rx_unreg(dev, op);

Only rx_ops are cleaned up upon NETDEV_UNREGISTER. The tx_ops appear to be
completely ignored, and op->ifindex is never cleared to halt transmissions.

This seems to allow the timer to fire endlessly in bcm_tx_timeout_handler():

    } else if (tx_ival2) {
        bcm_can_tx(op, NULL);
    }

    return bcm_tx_set_expiry(op, &op->timer) ?
        HRTIMER_RESTART : HRTIMER_NORESTART;

The timer handler continues to restart the timer even when the underlying
device has been destroyed. In bcm_can_tx(), dev_get_by_index() silently fai=
ls,
allowing the loop to continue endlessly.

Could this lead to cross-device traffic injection if the removed ifindex is
later reused by a new CAN interface?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v6-0-80710a2bc398@hartkopp.net?part=3D8

