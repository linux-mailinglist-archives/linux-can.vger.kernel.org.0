Return-Path: <linux-can+bounces-8262-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QN8zHNUHUGqbsAIAu9opvQ
	(envelope-from <linux-can+bounces-8262-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 22:43:01 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D370A735806
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 22:43:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Kuxm3l0c;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8262-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8262-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A911303A73D
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 20:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4814499BD;
	Thu,  9 Jul 2026 20:41:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DB03CE0A2
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 20:40:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629660; cv=none; b=fjgcMgGvWC7BveuPrElAFnaEL+hcx84wURTeIiyGupw8OerZHBSNxb/SlMz5dWaawZ5UDHH+5btJ/l7Z97GysM1fI10zJIPXyNMCd+hoh2eRIzUSLtolMH0WZRMrcau+qkKeD3MAPLNR3gAr2scTro6OOeBvRyo9Z87J9PP7VNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629660; c=relaxed/simple;
	bh=/Jr7T+oj2inHrCSTxLhf0pzkP+vIM9+/P6/ly4EeEh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IaPiQ1ib32FUJ7oeF+maOZjoprRurxXbAa4qdcFkTLmgxi6DOS/j+hqX/MUnlZ9axwB45Y9LNca+jHThjlz4JMDF8HIPlYws52oLf+YZ4/AvPAYxC+6JDUg5zwcz2OiRa7jWWQgGVPXlujWw9niqiFh+0KIck+59Eepa9LoP0aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kuxm3l0c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEED1F000E9;
	Thu,  9 Jul 2026 20:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783629658;
	bh=QyAWCbK0kEBNK4vJ+an54HeY6OGMLZA7pn3fuNMDsGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kuxm3l0ciVKmXUG0DlPJ7irdkp721YbYb372BCXUJVce1ZapN4ZHD7nU6+jI1iZ8G
	 wrghlBmUd14S5yBKC4oagljxxZ+1rLOC2P5rETOyPus2E7XNNbnVcrb7sHOek8iQoq
	 qkMBjbp+Z2o6uorrexd0S9KF6FQA3tDXXJBWzoe6W/Wk3QYTq57fVUSH5XEcvotHjd
	 doviGQ5SEzjKPEE0do1WPC6ocKsTvGS+MfWAhU7hl460C+GO1CnhHAm4MCj3FFzNnV
	 Yr3TJDOdWUlfyEy2t3Cx+AZ3gBSbGU9+YnvXdHE/DZ6b5TRCMqa81oH6gpUp5uAh5m
	 3Ab4oKS0D0XTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 09/11] can: bcm: fix stale rx/tx ops after device
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260709-bcm_fixes-v12-9-61c06291bf1c@hartkopp.net>
References: <20260709-bcm_fixes-v12-0-61c06291bf1c@hartkopp.net>
 <20260709-bcm_fixes-v12-9-61c06291bf1c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 20:40:57 +0000
Message-Id: <20260709204058.5BEED1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8262-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,hartkopp.net:email,lists.linux.dev:replyto,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: D370A735806

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bcm_rx_setup() partially updates the state of an existing rx_op =
before returning an error if re-registration fails.
--

--- Patch [9]: [PATCH v12 09/11] can: bcm: fix stale rx/tx ops after device=
 removal ---
commit 284aaee60a085295a0065bd19eaa02386e2787bd
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix stale rx/tx ops after device removal

This commit fixes issues with stale rx/tx ops after device removal by
re-registering RX ops when an update occurs after NETDEV_UNREGISTER,
and by cancelling cyclic TX timers upon device removal.

Link: https://lore.kernel.org/linux-can/20260708094536.DDF821F00A3A@smtp.ke=
rnel.org/
Link: https://lore.kernel.org/linux-can/20260708154039.347ED1F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 5660165cdf0eb..fbf1cbb7c99fe 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1483,18 +1495,27 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  				err =3D -ENODEV;
>  			}
> =20
> -		} else
> +		} else {
>  			err =3D can_rx_register(sock_net(sk), NULL, op->can_id,
>  					      REGMASK(op->can_id),
>  					      bcm_rx_handler, op, "bcm", sk);
> +		}
> +
>  		if (err) {
> -			/* this bcm rx op is broken -> remove it */
> -			bcm_remove_op(op);
> +			/* newly created bcm rx op is broken -> remove it */
> +			if (new_op)
> +				bcm_remove_op(op);
> +
> +			/* an existing op just stays unregistered until the
> +			 * next successful RX_SETUP - it is already part of
> +			 * bo->rx_ops and must not be freed here
> +			 */
>  			return err;

[Severity: Medium]
If re-registration fails for an existing op, an error is returned to usersp=
ace
here. However, does this leave the internal state of the op partially updat=
ed?

Before this code block, bcm_rx_setup() already modifies the frame data, fra=
me
counts, and timer configurations, and may have started timers:

net/can/bcm.c:bcm_rx_setup() {
    ...
		if ((op->flags & STARTTIMER) && op->kt_ival1)
			hrtimer_start(&op->timer, op->kt_ival1,
				      HRTIMER_MODE_REL_SOFT);
    ...
}

Does returning an error without rolling back these state changes or cancell=
ing
the timers leave the operation in an inconsistent state? It appears sendmsg
will return an error to userspace, but the operation might unexpectedly tri=
gger
timeouts based on the partially applied setup.

>  		}
> =20
> -		/* add this bcm_op to the list of the rx_ops */
> -		list_add_rcu(&op->list, &bo->rx_ops);
> +		/* add a new bcm_op to the list of the rx_ops */
> +		if (new_op)
> +			list_add_rcu(&op->list, &bo->rx_ops);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v12-0-61c06291bf1c@hartkopp.net?part=3D9

