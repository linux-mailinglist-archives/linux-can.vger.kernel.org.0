Return-Path: <linux-can+bounces-8034-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0P/bNC22TGo3ogEAu9opvQ
	(envelope-from <linux-can+bounces-8034-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 10:17:49 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E78B718FDD
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 10:17:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eAtBqWfS;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8034-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8034-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92A7430494DF
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79C72E764D;
	Tue,  7 Jul 2026 08:13:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0592C027B
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 08:13:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411994; cv=none; b=TfWySgARkBto5HzZYldqENM6l5TGgssoNXv14I9digsYZzYfKYNtvZiqI02fK83YHvqbM5rdBSmgj5MxqhigNdXog1EzXlR9LUnHNaJZO+exxbGasF6b52Cfw96cGb+nmqkXMaIpkOSt0G9mkgXLRUx1vCIs/BcRapoNpjgpkoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411994; c=relaxed/simple;
	bh=BEFG4pr7jeYDqKUqTS/WsM8hkug53D/9eyfoUS8RAQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pQoITpePHRCBoNl/W0R50DI9iEBVFe9ClFzeYY61wfZ+h2rsCbtYU6lO65pkDHpmxJs4TyKzLNtIyu7kSupU5fTgVz5qts2o2x8617lCjsP3xCUjxrZS121RA2lCj4TS+HF9+Gd4LXIAflS2Ix2F0tpxPSiz/hdpLH3ONApmnhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAtBqWfS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED2B1F000E9;
	Tue,  7 Jul 2026 08:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783411993;
	bh=N83nEbYBkv2JY37/jO7mlq47mM9Bjy6/ig7UsCN/HCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eAtBqWfSJ+uEvI1SvMmrtstbNvwSI4rQ4sMV4U/wupT0E8pSP4sbFpN661b9qSNdo
	 1ZiFJ0WCKTKlFH/I1HaZaIiU4/uToN6RGQlxcvI1iZxqw1lhf0Akt/ePohVfKH2xZt
	 2184CxfsfJRoTNcLdg+wu3OQNTOPqBOt8y5qRVg09y3Pacz/4dVfrStc3lOWoIFlqF
	 pc8APi+YT3+QJGmmEiDj8MpNVuJv1TLtbAgTCf4Nqh7gXxmeC/7DkR7gsmeWJaLQgw
	 bgsnfObc7A50shvis+nj6HjVJADC89ZfQo0fJPkmQFpndTUSUesHwBXBjF7AtgyX1N
	 PhScclqqm7pig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260707-bcm_fixes-v2-2-96620c534b75@hartkopp.net>
References: <20260707-bcm_fixes-v2-0-96620c534b75@hartkopp.net>
 <20260707-bcm_fixes-v2-2-96620c534b75@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:13:12 +0000
Message-Id: <20260707081313.0ED2B1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8034-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid,hartkopp.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 2E78B718FDD

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe list insertions and non-RCU traversals in BCM operations li=
sts.
- [High] Data Race and Data Corruption due to Lockless Modification of Acti=
ve BCM Operations.
- [High] Corrupted BCM Operation State upon Validation Failure.
- [Medium] Unannotated lockless read of `bo->bound` and `bo->ifindex` in `b=
cm_notify()` during `NETDEV_DOWN`.
--

--- Patch [2]: [PATCH v2 2/6] can: bcm: fix lockless bound/ifindex race and=
 silent RX_SETUP failure ---
commit 0cd66671e00a6a20f593dd001c30f331b9c4d5d8
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure

This commit fixes a race condition between bcm_sendmsg() and device
notification/connection by modifying the lockless fast-path and reading
ifindex under the socket lock. It also fixes a silent failure in
bcm_rx_setup() when the target device disappears.

Link: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_p=
V3At4g=3Dh1kVEtyhA@mail.gmail.com/

> Re-validate under the socket lock: a concurrent bcm_notify()
> may have unbound this socket (device removal) after the
> lockless fast-path check above. bo->ifindex is only ever
> mutated under lock_sock(), so reading it here - instead of
> before taking the lock - guarantees it can't be observed
> torn against bo->bound.

[Severity: Medium]
This is a pre-existing issue, but is the commit message accurate about
bo->ifindex only being accessed under lock_sock()?

Looking at bcm_notify(), when processing NETDEV_DOWN, it reads bo->bound
and bo->ifindex locklessly:

    case NETDEV_DOWN:
        if (bo->bound && bo->ifindex =3D=3D dev->ifindex) {

Since bcm_connect() mutates these while holding lock_sock(sk), could this
cause torn reads?

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

[Severity: High]
This is a pre-existing issue, but are the list insertions for rx_ops and
tx_ops safe for concurrent lockless readers?

bcm_rx_setup() and bcm_tx_setup() insert into bo->rx_ops and bo->tx_ops.
Concurrently, bcm_proc_show() locklessly traverses bo->tx_ops under
rcu_read_lock() using the non-rcu list_for_each_entry() instead of
list_for_each_entry_rcu():

    list_for_each_entry(op, &bo->tx_ops, list) {

Could this lead to observing uninitialized list nodes and a system crash
during procfs traversal?

[Severity: High]
This is a pre-existing issue, but does bcm_rx_setup() safely modify active
filter frames?

When updating an existing bcm operation, it appears to directly overwrite
op->frames using memcpy_from_msg() without synchronizing against softirq
routines:

    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);

Since bcm_rx_handler() reads op->frames in softirq context, can it observe
partially written or torn can frames during the update?

[Severity: High]
This is a pre-existing issue, but what happens if validation fails during
an update?

In bcm_tx_setup() and bcm_rx_setup(), op->frames is directly overwritten.
If a subsequent frame fails validation (such as cf->len > 64 in
bcm_tx_setup()) or memcpy_from_msg() fails, the function returns an error
without reverting the state:

    if (err < 0)
        return err;

Does this leave the operation actively running on a corrupted buffer?

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
This is a pre-existing issue, but the comment here makes the same claim
that bo->ifindex is only accessed under lock_sock().

As noted above, does bcm_notify() read bo->bound and bo->ifindex locklessly
during the NETDEV_DOWN case?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v2-0-96620c534b75@hartkopp.net?part=3D2

