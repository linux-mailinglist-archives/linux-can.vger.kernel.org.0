Return-Path: <linux-can+bounces-8070-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MXWRE6bZTGprqwEAu9opvQ
	(envelope-from <linux-can+bounces-8070-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:49:10 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED571A9DD
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:49:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UXFFhOOV;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8070-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8070-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D2DE30B0E58
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 10:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1573ED5DB;
	Tue,  7 Jul 2026 10:42:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848FC3DA7F8
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 10:42:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420972; cv=none; b=iEpf5huVCjnZLJSEQ/iwh9qqs/84W4vB9EipT3ode88oaVdK0HYYWPBk/FIavnP5QFqxWUQ0e4/V76rL3Lw+JasCKw5k7pjUoGxEozLrK4zqpdjxIcVdaoQ8Upc+WEMsHG/YcAPvEtpYh3ITWKl2BCd1aL6h4+j/fXOwbVK/nEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420972; c=relaxed/simple;
	bh=BDveb5kexBdcvG/N0fqIBzfZ1VoTJ3gdOzFqTvc+dIo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kCo+8UggMAJG/Zd7jVIOyJPtqZAnQYGs7kbj8F454VWmwp2OCxOZi2uSLAjVhja8wMLzzxMaQmfnCPPiex6XYx/bdHoMOq6GuEdwYfAQTZf7p4NMWtb0aAFgnvjJjAaBHtfTmdJkaeV0AacNwPDOGygyxKkHMUIi7ehSbW8uTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXFFhOOV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE571F00AC4;
	Tue,  7 Jul 2026 10:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420971;
	bh=+FhMZZ/zRKMJaaRa5wy591xZ6coP05DeQ6w7+rVbCBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UXFFhOOVTmLE1Sj54r7F8xX7z+pkpOPETHQGshnAIZawrhkJyQFUjQlYVRE0IDerO
	 d4lflEd765T3IJaakHN5/nZeopooQw8nwHq+wFuBwKnkxTgp03FBH5sOeI8Xpkncp1
	 A668wJQctorqgBuiXRj9KN65M5eDbloFvVaF8Y4uulpW4vYY5WhMDIyAAiWW8vU6Wk
	 kTgr9q0yJZCbDqUiJcVp417sC9sSFIxsdB+t53QAiDb7qD+GfOX9ME8rYHrjMqzLx4
	 q82Bfikv7EzUHSP3mL5IKXQw6IctiwlYw6is7KFBZo3npdegrTbdFic7CfdzkuaOmp
	 a27/dW34dZsjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] can: bcm: add missing rcu list annotations and
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260707-bcm_fixes-v3-5-84600ca6d889@hartkopp.net>
References: <20260707-bcm_fixes-v3-0-84600ca6d889@hartkopp.net>
 <20260707-bcm_fixes-v3-5-84600ca6d889@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:42:50 +0000
Message-Id: <20260707104250.BEE571F00AC4@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8070-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBED571A9DD

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless reads of 64-bit ktime_t values and TOCTOU races on op->co=
unt in bcm_tx_timeout_handler
--

--- Patch [5]: [PATCH v3 5/7] can: bcm: add missing rcu list annotations an=
d operations ---
commit 8310d786e9cc8e49f889c95c47438e852dd137cc
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing rcu list annotations and operations

This commit moves list_add_rcu() calls to the end of the setup code to cover
initial settings and fixes the missing list_del_rcu() before bcm_remove_op()
in bcm_release().

Link: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 0378e31ea10ed..f21d48d99aab6 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1159,6 +1159,10 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
>  		op->flags |=3D TX_ANNOUNCE;
>  	}
> =20
> +	/* add this bcm_op to the list of the tx_ops? */
> +	if (add_op_to_list)
> +		list_add_rcu(&op->list, &bo->tx_ops);
> +

[Severity: High]
This is a pre-existing issue, but I have a question about concurrent access
to the timer and count values in bcm_tx_timeout_handler().

When a userspace application continuously updates a BCM TX op via TX_SETUP,
bcm_tx_setup() updates the op's timer and count values.

Concurrently, if the timer fires, bcm_tx_timeout_handler() reads them
locklessly in softirq context:

net/can/bcm.c:bcm_tx_timeout_handler() {
    ...
    if (op->kt_ival1 && (op->count > 0)) {
        bcm_can_tx(op, NULL);
        if (!op->count && (op->flags & TX_COUNTEVT)) {
    ...
}

Can this lead to torn reads on 64-bit ktime_t variables (kt_ival1, kt_ival2)
on 32-bit platforms, resulting in a bogus timeout value that breaks cyclic
CAN frame transmission?

Additionally, could a TOCTOU race on op->count cause the handler to
incorrectly miss sending a TX_EXPIRED notification to userspace?

It appears a similar issue for RX_SETUP was previously addressed by adding
locking in commit "can: bcm: add locking when updating filter and timer
values", but the TX_SETUP side might still be exposed.

>  	if (op->flags & TX_ANNOUNCE)
>  		bcm_can_tx(op, NULL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v3-0-84600ca6d889@hartkopp.net?part=3D5

