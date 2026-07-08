Return-Path: <linux-can+bounces-8143-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9KeXOcVyTmrmMwIAu9opvQ
	(envelope-from <linux-can+bounces-8143-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 17:54:45 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAD0728529
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 17:54:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JCf7yuVR;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8143-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8143-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35E333191FF5
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 15:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057CD3F12E7;
	Wed,  8 Jul 2026 15:35:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21EC3F12E4
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 15:35:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524917; cv=none; b=Ox04nuTUuvSy6uRRhjbXI5R8/4nUY7SVr+CL491TMH9fSeTjjfQ4WwdIt81TvAhB4D7OpVAAxY0COhDDJXYOovqhKevXsTXMLnFcKOdQq8cQte+j2h4s1Qr9zvy+NhpwO2/ykY5bltlabsPkyP/jCZYRLqcHqorlSw5VMQzzxI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524917; c=relaxed/simple;
	bh=oLaIky9XW89SJk3jq7Dvu+21SViBWDbI6q4XWXzu8ic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HLxB/ZKlK1ekPthuUXt7fLcnYg6iDet6FvPXENF+gBZD/ma5eq9+LFP9tPPNXFs2pW+9x7BFv/hkTse6wgd4EnGuDEfP+hDd43jWQr3GCXcQmQBw3duQUj4WBVhfg78qpbXhr4X7HNk9qqy0iip/1R7k8EYktjNaGOG0DMtqWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCf7yuVR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4726C1F000E9;
	Wed,  8 Jul 2026 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783524916;
	bh=1KSm3p+RtlH9lsARXvLWlucKFsb8uLLXmLBGvDmxOH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JCf7yuVRLbK0apYvxRVmgwcldiPKswrzPEoUR61Hc5WDNQ7koaAl0O5LhVkqRcnpo
	 meX05pm/nj7l0CAPA9YW/nKoIjZ4xYUaR+y9l49V2zi78seWtXg1lmWPEZ+6Cy2IyI
	 5OwO5wZMY51iHmCZ6Ai/ax3BTGRkY87CYpMgqt3T7nfGGnbyx34WI2HCqY5O735hEz
	 CkhrWDPU0Zo9quG0kM3oUnsviFHrAdu4UhcOCsWAuu2fP/uSinolkNU9bx0nhDjSn0
	 k7/8iG34jhy7BbUNdzPj9dE16GnykkNhkrf34run5Ui4WlTa1bwFVVxWUDfK7DbSKv
	 cRWFGuAmHmkkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/10] can: bcm: add missing rcu list annotations and
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260708-bcm_fixes-v7-5-c78896b342e4@hartkopp.net>
References: <20260708-bcm_fixes-v7-0-c78896b342e4@hartkopp.net>
 <20260708-bcm_fixes-v7-5-c78896b342e4@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 15:35:15 +0000
Message-Id: <20260708153516.4726C1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8143-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lists.linux.dev:replyto,hartkopp.net:email,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 5BAD0728529

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unlocked 64-bit `ktime_t` assignments allow torn reads on 32-bit s=
ystems, causing incorrect timer expiries.
--

--- Patch [5]: [PATCH v7 05/10] can: bcm: add missing rcu list annotations =
and operations ---
commit 356a7e056868b1df56b247c6708d4c5bdd80c8f0
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing rcu list annotations and operations

This commit adds missing list_add_rcu() calls in bcm_tx_setup() and
bcm_rx_setup() to ensure bcm_op structures are properly initialized
before being traversed by bcm_proc_show() under rcu_read_lock(). It
also fixes the mirroring removal side in bcm_release() by properly
unlinking operations with list_del_rcu() before freeing them via
bcm_remove_op().

Link: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.ke=
rnel.org/

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
This is a pre-existing issue, but while reviewing this setup code I noticed
a potential torn read problem on 32-bit systems.

Earlier in bcm_tx_setup(), the 64-bit ktime_t values are written under
bcm_tx_lock:

	spin_lock_bh(&op->bcm_tx_lock);
	op->ival1 =3D msg_head->ival1;
	op->ival2 =3D msg_head->ival2;
	op->kt_ival1 =3D bcm_timeval_to_ktime(msg_head->ival1);
	op->kt_ival2 =3D bcm_timeval_to_ktime(msg_head->ival2);
	spin_unlock_bh(&op->bcm_tx_lock);

However, if the hrtimer fires on another CPU concurrently,
bcm_tx_timeout_handler() reads these 64-bit values without acquiring
bcm_tx_lock:

	if (op->kt_ival1 && (op->count > 0)) {
		bcm_can_tx(op, NULL);
		// ...
	} else if (op->kt_ival2) {

And bcm_tx_set_expiry() also reads them unlocked to set the timer expiry:

	if (op->kt_ival1 && op->count)
		ival =3D op->kt_ival1;
	else if (op->kt_ival2)
		ival =3D op->kt_ival2;

Could an unlocked concurrent read of op->kt_ival1 or op->kt_ival2 cause a
torn read on 32-bit systems, resulting in a corrupted or negative timer
expiry?

If this corrupted value is passed to hrtimer_set_expires(), might it schedu=
le
the timer in the past and lead to an immediate expiration and subsequent
softirq storm for repeating cyclic timers?

>  	if (op->flags & TX_ANNOUNCE)
>  		bcm_can_tx(op, NULL);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v7-0-c78896b342e4@hartkopp.net?part=3D5

