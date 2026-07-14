Return-Path: <linux-can+bounces-8438-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VI7pLSRsVmof5QAAu9opvQ
	(envelope-from <linux-can+bounces-8438-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:04:36 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBBE75731A
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:04:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MltQ6Ony;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8438-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8438-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A268C3006210
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 17:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B20839CCE7;
	Tue, 14 Jul 2026 17:04:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FA639CCE2
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 17:04:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048671; cv=none; b=ZoSmAti9PlaHGtRTvw3aCsCdKBIhKEGYAuu7GOyNGQRtMomF7obtHxATfR2WYVsrdOoA1TnFxY8RufG3bu8sor9gM9jdS355mNmytN36+29xQh6M9t83a+A06mG4QD+3kOYyZ6BG+1zOVQeOzkXLVzJlDWBccIiNpk6kMM/Hzdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048671; c=relaxed/simple;
	bh=MVYwxMlzDUbRE8lmw+EJN4xTbF3uPufbnOoBNqoqRIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=joa1CzgINKVMnGGiTMvI6Qfw0rNhi3m8LXBfaO3hQkTCEf3KvCFe9hoqcdxA+lxuveg20+CsgXarftpeLSrQ7OAdFGjzF4b/p08Hp8MDkOfwWW7gOJWrJWR39XJyYFAbLC+7gjQ2dTCf5frPW1Y7BubnuN5S+kP1Ww9+IoNFLNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MltQ6Ony; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2FA1F000E9;
	Tue, 14 Jul 2026 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784048669;
	bh=FQ/g0U41HM16G9qFNPwrGaimidD5rT0BkpfjF0wPpoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MltQ6OnyuZ3wQqIVxgZBnAz8NPomZ6lhwL+XAO4rRAqTO+rIBG8l6WM99n3uZTmgn
	 R9g7zYYpWCjBMGikLOd8YRLa2L1IFNZQngGdZ6/a08CjrsGErPPoyceHpSJH5z3Qyd
	 kMh22+IhY2lh46hE+3M0AX587sSaHD5pHzDZL4G5GXMaE4IFT8yGwlVa26Qq8FQ6z4
	 6InvIzvF352cyE20+esbBJnnMdesE8k7iN/sIRAOrzpMJzADvqIDFbilWVsxwlgYBB
	 9T6gV95g/kubS9DTaVvd09nM1NMWkENCQOgJkcSPB5iljAfB9/md5hSttXUIIF8zDc
	 x486LNhRhIPDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 05/11] can: bcm: add missing rcu list annotations
 and operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260714-bcm_fixes-v15-5-562f7e3e42da@hartkopp.net>
References: <20260714-bcm_fixes-v15-0-562f7e3e42da@hartkopp.net>
 <20260714-bcm_fixes-v15-5-562f7e3e42da@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 17:04:28 +0000
Message-Id: <20260714170429.6F2FA1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8438-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lists.linux.dev:replyto,hartkopp.net:email,smtp.kernel.org:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABBBE75731A

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Unconditional `list_add_rcu()` on the success path in `bcm_rx_=
setup()` corrupts the list for existing operations.
- [Critical] Removing `list_del_rcu()` from the registration error path in =
`bcm_rx_setup()` causes a Use-After-Free for existing operations.
--

--- Patch [5]: [PATCH v15 05/11] can: bcm: add missing rcu list annotations=
 and operations ---
commit 493e1bc1997871e18b09125c187a88444720b12c
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing rcu list annotations and operations

This commit updates the broadcast manager (BCM) to use proper RCU list
operations when adding and removing operations. It addresses missing
list_add_rcu() calls in setup functions and ensures ops are unlinked
before being handed to bcm_remove_op().

Closes: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.=
kernel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 03c98e4cc677d..5c1e83eeb4ff3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1449,10 +1450,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  					      bcm_rx_handler, op, "bcm", sk);
>  		if (err) {
>  			/* this bcm rx op is broken -> remove it */
> -			list_del_rcu(&op->list);
>  			bcm_remove_op(op);
>  			return err;
>  		}

[Severity: Critical]
Does removing this list_del_rcu() cause a use-after-free for existing
operations?

If a user updates an existing BCM RX operation for a specific device that
was unregistered, the op remains in the list but op->rx_reg_dev is cleared.

If the update occurs and the interface is gone, dev_get_by_index() fails,
and this error path is taken.

Since bcm_remove_op() frees the operation via call_rcu(), removing
list_del_rcu() leaves a freed operation linked in bo->rx_ops. Any
subsequent operation traversing the list, such as bcm_release() or procfs
reads, would then dereference freed memory.

> +
> +		/* add this bcm_op to the list of the rx_ops */
> +		list_add_rcu(&op->list, &bo->rx_ops);
>  	}

[Severity: Critical]
Could this unconditional list_add_rcu() corrupt the list if the operation
is already linked?

When updating an existing operation that needs to be re-registered (for
example, if the interface was unregistered and a new device reuses the
ifindex), do_rx_register will be 1 for an operation that is already linked
in bo->rx_ops.

Calling list_add_rcu() on a node that is already part of the list corrupts
the list pointers, which could lead to an infinite loop or panic during RCU
traversal.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v15-0-562f7e3e42da@hartkopp.net?part=3D5

