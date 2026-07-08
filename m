Return-Path: <linux-can+bounces-8161-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id elceBYyMTmrnPAIAu9opvQ
	(envelope-from <linux-can+bounces-8161-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 19:44:44 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A4D7294F5
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 19:44:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jMmEuAhQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8161-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8161-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C4E6303DAF8
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 17:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364DD4A138B;
	Wed,  8 Jul 2026 17:43:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027144B8DF5
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 17:43:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532593; cv=none; b=m8ajqLImk4ahOr1q63ALNPqX6lM++R3fDCyN2mBPFtAauniBpVJKoypw/TtUcwp+/tn5GGv/7mIboJKjToxCYJr/PjfRuACdRiN6vnSZVG1dgEvdxBrkbLq+ToKpT3Cm/Dg9n9VRPxFl93kIX4Lp8fA0FPer5pZk9NNcdZD1dYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532593; c=relaxed/simple;
	bh=QR/E1zMtMhakF9OEowxqmTvFxtDz9nZs8zd10Ht5i2I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KqKAFlKeUsZbP2hW778GwNsM+QAy8fQcLvvGzhqyHEOIXQI2JjnpB5kTSrJfsPLxQkfXSOGvB7W+nh2jrWJIBwriWJcGDtTf16k4j0iUY+PzdbBgtVn6+tCnuVzs10j0Ke1KurjnC6YnSX+eZl3ffhnEzMDspD3Alt8pMRRS0SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMmEuAhQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771841F00A3A;
	Wed,  8 Jul 2026 17:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783532591;
	bh=1XHkJX/gznCFmttO3vFBRCRiVQShkR2QPa/l8AXFlvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jMmEuAhQ8K0pSGLDicbHtuSYhEtMSGasiTgFx6GFea3U4EebW6IaxRSu0xPa937Z1
	 fE4DZz5ZVWk/Scax+EQaST+MnnjBcOVzU3/2b2ouDCdV+rO5HBafLoQi3ZhXdNhM4D
	 23BUjIlbVs6E0W4vADB5WYU8mXwH78VQihPmquO4+QP/tQPAQ8Ul4qR7crBfA5ppOJ
	 spCpzVGTzm0PobPCBp6roLN3I44uUKeeAMjNRNPruMTLiDEBYjRizcZ7SWRWjPxt5T
	 oDDzXzhbRa+xOWvOI2UugMQEiHpM0dTAbB1up1Iw+1eckvMuhyzF8Kp7tbipZnFWoU
	 h95eplp5SJFEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/10] can: bcm: add missing rcu list annotations and
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260708-bcm_fixes-v8-5-8c2f5f3bc212@hartkopp.net>
References: <20260708-bcm_fixes-v8-0-8c2f5f3bc212@hartkopp.net>
 <20260708-bcm_fixes-v8-5-8c2f5f3bc212@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 17:43:11 +0000
Message-Id: <20260708174311.771841F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8161-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,vger.kernel.org:from_smtp,hartkopp.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 70A4D7294F5

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The timer callback `bcm_tx_timeout_handler()` reads `op->kt_ival1`=
, `op->kt_ival2`, and `op->count` locklessly, risking torn reads and incons=
istent state.
--

--- Patch [5]: [PATCH v8 05/10] can: bcm: add missing rcu list annotations =
and operations ---
commit 328ac2042a77c92625995c774ca6b37b5d654ec7
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing rcu list annotations and operations

This commit fixes missing RCU list annotations for bcm_op additions and
removals to ensure procfs safely traverses the structures under
rcu_read_lock(). It also moves list additions to the end of the setup code
and fixes the removal path in bcm_release().

Closes: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.=
kernel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 340b7fc89744e..fca7c714cc52f 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1163,6 +1163,10 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
>  		op->flags |=3D TX_ANNOUNCE;
>  	}
> =20
> +	/* add this bcm_op to the list of the tx_ops? */
> +	if (add_op_to_list)
> +		list_add_rcu(&op->list, &bo->tx_ops);
> +

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the context
around bcm_tx_setup(), I noticed a potential problem with how the timer
variables are synchronized.

Although bcm_tx_setup() safely updates op->kt_ival1, op->kt_ival2, and
op->count under op->bcm_tx_lock, the timer callback bcm_tx_timeout_handler()
and bcm_tx_set_expiry() appear to read them locklessly:

net/can/bcm.c:bcm_tx_timeout_handler() {
        ...
        if (op->kt_ival1 && (op->count > 0)) {
                bcm_can_tx(op, NULL);
        ...
}

net/can/bcm.c:bcm_tx_set_expiry() {
        ...
        if (op->kt_ival1 && op->count)
                ival =3D op->kt_ival1;
        else if (op->kt_ival2)
                ival =3D op->kt_ival2;
        ...
}

Could this result in torn reads of the 64-bit ktime_t variables on 32-bit
platforms, or reading an inconsistent combination of count and interval
values?

If a user calls sendmsg() with SETTIMER (but without STARTTIMER) on an
active cyclic TX operation, could the already-running hrtimer execute
concurrently in softirq context and be rearmed with an incorrect
expiration time?

>  	if (op->flags & TX_ANNOUNCE)
>  		bcm_can_tx(op, NULL);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v8-0-8c2f5f3bc212@hartkopp.net?part=3D5

