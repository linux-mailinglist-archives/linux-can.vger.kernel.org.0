Return-Path: <linux-can+bounces-8228-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cRpcJMrmT2rZpwIAu9opvQ
	(envelope-from <linux-can+bounces-8228-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:22:02 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B87E734351
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:22:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Kb/dta3j";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8228-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8228-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91F54301BA73
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 18:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8662399887;
	Thu,  9 Jul 2026 18:21:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06C44DC532
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 18:21:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621302; cv=none; b=DJKsr3dpWp0SIb/Hm5k///mPJFqr1NwzBXAF7yeqPuZhHBWnzIt1BsHRigy2Y0QApDeBogeTmC25jJ60lRguXWB2MNBChw2BxmmQjP2F/8cWIvIldi2WBoGgDfdajE9ZkUU9v8CFyxabZuXDpKLkG8j6Kzz3CM/ZTh0ZV9kwB5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621302; c=relaxed/simple;
	bh=0gbFFJsnFMr06uD2J+LQpuC66hmHiENzJ0GUs8Ma8Cs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FefUhMDMjd2/13OUMzqQEXjbCcm1aJyOEf/a+cyr2x8/jNglCeQBMGZJBF78BhIa8pXOi9474VYoBnQuR14yXy649lIq1nOjZs7cSaq4BAYaVvg3j57x4QutawOstEpq1A2wEAXYsSA5JUBZk9Fi+06ii894ziN1s/1D9KJjZKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb/dta3j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066701F000E9;
	Thu,  9 Jul 2026 18:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783621301;
	bh=gCIyOT/JiY2QnHEc6yDV+XNz2BBaJUA4pV8LM9aaNIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kb/dta3j6pL0kBaa9LnXjziZQupxsdbfHsJt7IV+xt5OMGCgnl1D2znKKZpRBj2aP
	 Wvic8sXtnA1ekuwUYnY+KS86irZ82ajGFYIxy+QGITE3uAC7tpBYlVMm1VyAJ3kHwd
	 FGeOH3/CJVT6/tZeNtJmj0nz6S1QSV0XJWKxMjV4i3khu6pq7sgArNTlUCaiixS60x
	 AZtBfVMSr+I57Wx0cm9NI76hzeLjtKaEKvJx515bBSTzZdBZrWvRyUJphGrI9OtQRz
	 5QlmnCDOteZZvg7UnRGQdh7Q6BLKdXQ5BBbd4vgTDpUKltYsMBElqsAEi1aTK3Auq6
	 zp6o/emNa35gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 05/11] can: bcm: add missing rcu list annotations
 and operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260709-bcm_fixes-v11-5-067ba11bec5c@hartkopp.net>
References: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
 <20260709-bcm_fixes-v11-5-067ba11bec5c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:21:40 +0000
Message-Id: <20260709182141.066701F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8228-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto,hartkopp.net:email,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 8B87E734351

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsynchronized reads of 64-bit ktime_t and struct bcm_timeval valu=
es cause torn reads on 32-bit systems, leading to corrupted hrtimer expirat=
ions.
--

--- Patch [5]: [PATCH v11 05/11] can: bcm: add missing rcu list annotations=
 and operations ---
commit c261663cca88ad03b64923cce2abd1bd069a9797
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing rcu list annotations and operations

This commit adds missing list_add_rcu() calls in bcm_tx_setup() and
bcm_rx_setup() to ensure proper initialization when bcm_proc_show()
traverses the operations under rcu_read_lock(). It also fixes a list
removal issue in bcm_release() by unlinking each operation with
list_del_rcu() before removing.

Closes: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.=
kernel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 38c3f690c1cd0..940cd9df1cca3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1173,6 +1173,10 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
>  		op->flags |=3D TX_ANNOUNCE;
>  	}
> =20
> +	/* add this bcm_op to the list of the tx_ops? */
> +	if (add_op_to_list)
> +		list_add_rcu(&op->list, &bo->tx_ops);
> +
>  	if (op->flags & TX_ANNOUNCE)
>  		bcm_can_tx(op, NULL);
> =20

[Severity: High]
This is a pre-existing issue, but can the 64-bit ktime_t timer interval
reads tear on 32-bit systems?

In bcm_tx_setup(), the timer interval values are updated under the lock:

net/can/bcm.c:bcm_tx_setup() {
    ...
    if (op->flags & SETTIMER) {
        spin_lock_bh(&op->bcm_tx_lock);
        ...
        op->kt_ival1 =3D bcm_timeval_to_ktime(msg_head->ival1);
        op->kt_ival2 =3D bcm_timeval_to_ktime(msg_head->ival2);
        spin_unlock_bh(&op->bcm_tx_lock);
    ...
}

However, when the timer fires, bcm_tx_timeout_handler() and its callee
bcm_tx_set_expiry() appear to read these 64-bit values locklessly:

net/can/bcm.c:bcm_tx_set_expiry() {
    ...
    if (op->kt_ival1 && op->count)
        ival =3D op->kt_ival1;
    else if (op->kt_ival2)
        ival =3D op->kt_ival2;
    ...
}

If the softirq handler observes a torn read on a 32-bit system, could it
result in corrupted timer expiration values and lead to an immediate
re-arming loop or stalled transmission?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v11-0-067ba11bec5c@hartkopp.net?part=3D5

