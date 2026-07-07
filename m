Return-Path: <linux-can+bounces-8091-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HR5SDckYTWovvAEAu9opvQ
	(envelope-from <linux-can+bounces-8091-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 17:18:33 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAFC71D2D1
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 17:18:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FSsRJPml;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8091-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8091-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFE43303102B
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660C330AABE;
	Tue,  7 Jul 2026 14:49:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5803054C7
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 14:49:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435789; cv=none; b=IeIMm9Xkyw9Es3zJaViC/hIqZQ7P5suh0/Hl4whVZS9rZuLqNjRKquUpLtrZmiJCzEmBkjx0YunmszIMOX7H6r5IMCll1jDoUnDOMuCrDadHOOCflx4BlmZblFroRqedtOMv2ibHZHPIVYepfvIpA2vY4M54myqh26KX5ETTPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435789; c=relaxed/simple;
	bh=ljj6xgXza4V5LCnGbJfUTAujcE0TQ7aPG1k/7lXNDXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jKGXQS1kgkmJ2jMGPw6znbKomjp0yF32qPHP7BQeOUV5sPKJ65/fPU01NjOjcObQF497utuiaRRbJ1dIv4/MHQDLAtjfbxpNbQXSPZvx21CPF5sTGbGU9xQOIeRcdyuWTuw4YqnajqJpy5deXIH5INPleWkLPv1mOqTHqjXk1KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSsRJPml; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE0D1F000E9;
	Tue,  7 Jul 2026 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783435788;
	bh=IiK0o+agFu+163Uoo3kZtxQMRCEP0/PadvmuPu1gLl8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FSsRJPmlrAp2WQqABW9dPbjpXjuytBI40hPkUwlO1wko3KwHdfcjBh2eUfZBr2xhr
	 UpNmubm7jkVlIH7FFSGpoE11/WzAjo8+BNOhyEBk14+0JDooOlwHVxfAMs/4cloiBc
	 hFCLw4HXXgqc15Abrn3a78omqmsu+HUimbKrahCei/BKmrenDaMxClK+Hay7ztoJz8
	 SWQOoZtrVgUudLUZods3TAnw9LHofZl3gCUFBr1u9BMYVgNevJj82gS68u1tRaZrSd
	 eXpoTXPZCwQZ7QPhsTiNQ0fCfapujT3OzVuPt4qLI5oXQdyFtG/MCDbfOTlJuEXZVg
	 1m9OydMiy79Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] can: bcm: add missing rcu list annotations and
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260707-bcm_fixes-v4-5-aa87b8b9d33f@hartkopp.net>
References: <20260707-bcm_fixes-v4-0-aa87b8b9d33f@hartkopp.net>
 <20260707-bcm_fixes-v4-5-aa87b8b9d33f@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:49:46 +0000
Message-Id: <20260707144947.1BE0D1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8091-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,hartkopp.net:email,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EAFC71D2D1

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Updating an existing TX operation in `bcm_tx_setup()` directly mod=
ifies `op->frames` and 64-bit timers without holding `op->bcm_tx_lock`, cre=
ating a data race and potential state corruption.
--

--- Patch [5]: [PATCH v4 5/7] can: bcm: add missing rcu list annotations an=
d operations ---
commit 2ff2c9594c9d6ef4f6013f749b0066b1081603e0
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing rcu list annotations and operations

This patch adds missing list_add_rcu() and list_del_rcu() operations
when setting up or releasing BCM operations. It ensures proper
RCU list initialization to safely support bcm_proc_show() traverses.

Link: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 0b53dbb64dd19..5ca684cd08194 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1143,8 +1144,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
>  		hrtimer_setup(&op->thrtimer, hrtimer_dummy_timeout, CLOCK_MONOTONIC,
>  			      HRTIMER_MODE_REL_SOFT);
> =20
> -		/* add this bcm_op to the list of the tx_ops */
> -		list_add(&op->list, &bo->tx_ops);
> +		add_op_to_list =3D true;
> =20
>  	} /* if ((op =3D bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex))) =
*/
> =20

[Severity: High]
This is a pre-existing issue, but does bcm_tx_setup() safely update
existing TX operations?

It appears that bcm_tx_setup() updates existing operations by directly
overwriting live CAN frames (op->frames) via memcpy_from_msg() without
holding op->bcm_tx_lock:

net/can/bcm.c:bcm_tx_setup() {
    ...
		err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);

		if (op->flags & CAN_FD_FRAME) {
			if (cf->len > 64)
				err =3D -EINVAL;
		} else {
			if (cf->len > 8)
				err =3D -EINVAL;
		}

		if (err < 0)
			return err;
    ...
}

If the updated data violates CAN constraints (e.g., cf->len > 64 or a memcpy
failure), it returns early. However, the existing active op continues to
run and transmit via bcm_tx_timeout_handler(). Can this lead to the blind
cyclic broadcast of corrupted or oversized CAN frames on the bus?

Additionally, 64-bit timers are updated without locking right below this
block, which could cause data races and torn reads on 32-bit platforms
with bcm_tx_timeout_handler():

net/can/bcm.c:bcm_tx_setup() {
    ...
		op->ival1 =3D msg_head->ival1;
		op->ival2 =3D msg_head->ival2;
		op->kt_ival1 =3D bcm_timeval_to_ktime(msg_head->ival1);
		op->kt_ival2 =3D bcm_timeval_to_ktime(msg_head->ival2);
    ...
}

Could these updates be guarded by op->bcm_tx_lock to prevent state
corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v4-0-aa87b8b9d33f@hartkopp.net?part=3D5

