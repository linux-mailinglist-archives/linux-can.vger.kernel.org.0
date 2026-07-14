Return-Path: <linux-can+bounces-8411-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YDyUEGwgVmoczgAAu9opvQ
	(envelope-from <linux-can+bounces-8411-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 13:41:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE2C753FB8
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 13:41:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i3vb3Xne;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8411-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8411-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70F2C301F335
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 11:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17D937DAAE;
	Tue, 14 Jul 2026 11:40:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ACE20ADF8
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 11:40:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029247; cv=none; b=N0Wk+vTZGH7dx7xQXg125XhC2j8ecgdL9Xj811mBuNmDGQKiS6Ah49dA04TgZ6RojJPJQGEL5xPtL93Zm6UR6x3G5vHNgIWPNp6ZZA/+lrwng+4eS2xa+7PtHH/U10PD7c8NdLIyTDnPx635lfim/3OT1wx+JNt4bmIBpng27kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029247; c=relaxed/simple;
	bh=ENsdtZSKHTfAoa9s+JaTJrTD88sKIr6RAUrJukVxHOA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RdjlvJSI0t7fF+4iyD1xJYkgX73WiWcAA7EM+MCcd3ZMCZI2DTczxSk7tT6F5sOvF852SCAUnSbANJd+kvDxlxmmGJ+MaNzpTib/tNsjcAhwJoCFNGgk8226yWuX60okzW7zQ9eTIxkN1jWP3yMrLgMv0OCNeeQREPojm4t3kZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3vb3Xne; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D621F000E9;
	Tue, 14 Jul 2026 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784029246;
	bh=K1/CcdGefQFNvNAlnbbdXz2fcR+Ue3a2/0lKEtLdKLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i3vb3XneWzvR0tg0zixrVLJWoKGU6Mc9LMK9Cs14Nt/tJ7t0RtsAeI563MK5Gy5ZK
	 N8ItWBPIO+Z2ieOCuJFv+R7FoVhDL+EfL8QiRsVp/I7orsB/rXSTmBhaIk7L2StSBO
	 klxTpZVhNdzoLyoyx//B06FujqL2ns+oY/Kz8d0SsV8by8OBwdPHzIZe/+lYiMKGl9
	 L5uYxqdUvUjY39yUstatON5owLz/YTes1f4AVpfz8lo4KEbf3Z9Pe7/gdfRRAu7Ad6
	 Hj/St7cyZG4wiPEPHhQ2YEQFESyCn3jutKDFqNSHxMckKYJQ2hPI9zfAGS84JGrCo5
	 niaj4KUAru50A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 05/11] can: bcm: add missing rcu list annotations
 and operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260714-bcm_fixes-v14-5-867a4be60a61@hartkopp.net>
References: <20260714-bcm_fixes-v14-0-867a4be60a61@hartkopp.net>
 <20260714-bcm_fixes-v14-5-867a4be60a61@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:40:45 +0000
Message-Id: <20260714114045.D2D621F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8411-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CE2C753FB8

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Calling `list_add_rcu()` on an existing `bcm_op` structure causes =
list corruption when an existing RX operation is re-registered.
- [High] Missing `list_del_rcu()` on the error path causes an existing `bcm=
_op` to be freed while still in the socket's list.
--

--- Patch [5]: [PATCH v14 05/11] can: bcm: add missing rcu list annotations=
 and operations ---
commit c7e6469266e632779d9cd09483b591c4201b8a0d
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing rcu list annotations and operations

This commit updates bcm_rx_setup() and bcm_tx_setup() to use list_add_rcu()
when adding operations, ensuring the bcm_op structure is properly initializ=
ed
before traversal. It also updates bcm_release() to correctly unlink ops usi=
ng
list_del_rcu() before freeing them.

Link: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 38c3f690c1cd0..940cd9df1cca3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1431,10 +1432,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  					      bcm_rx_handler, op, "bcm", sk);
>  		if (err) {
>  			/* this bcm rx op is broken -> remove it */
> -			list_del_rcu(&op->list);
>  			bcm_remove_op(op);
>  			return err;
>  		}

[Severity: High]
Does removing this list_del_rcu() introduce a use-after-free if an existing
operation fails to re-register?

If a virtual CAN interface is unregistered, the netdev notifier sets
op->rx_reg_dev to NULL but keeps the op in bo->rx_ops. If the socket updates
the RX operation while the interface is still gone, bcm_rx_setup() sets
do_rx_register =3D 1. If dev_get_by_index() then fails and returns an error,
this path is taken.

Since list_del_rcu() was removed, bcm_remove_op() will free the operation
via call_rcu() while it is still linked in bo->rx_ops, which could lead to
a crash during subsequent RCU list traversals.

> +
> +		/* add this bcm_op to the list of the rx_ops */
> +		list_add_rcu(&op->list, &bo->rx_ops);

[Severity: High]
Does this unconditionally add the operation to the list, even if it is an
existing operation that is already linked?

Similar to the previous case, if an existing op is being updated and needs =
to
be re-registered because op->rx_reg_dev was cleared by a netdev unregister
event, do_rx_register is true.=20

If the registration succeeds, will this call list_add_rcu() on an op that
is already in bo->rx_ops, overwriting its list pointers and corrupting the
list?

>  	}
> =20
>  	return msg_head->nframes * op->cfsiz + MHSIZ;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v14-0-867a4be60a61@hartkopp.net?part=3D5

