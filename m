Return-Path: <linux-can+bounces-8090-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dMEpL/AWTWqOuwEAu9opvQ
	(envelope-from <linux-can+bounces-8090-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 17:10:40 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 045FB71D0B0
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 17:10:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WuiYcZu3;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8090-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8090-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1D92324A52B
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3132E3033FE;
	Tue,  7 Jul 2026 14:48:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8430DEB2
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 14:48:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435728; cv=none; b=b64vqh53OTQBjxe1yX0HLOl9MKBcXxOrzG1qcKmmB3XVXbx8GTVK3EMgxqFZcbNk0PGtVopiZ7URgzMyEzg9n2FbYxyHqnt08lyfMYJ05OSnhBPtKvTU8o+oY2sK47GhtZngRtysnc7QGIb+p+FZcBGYemmR1Drmx10EyW0+bd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435728; c=relaxed/simple;
	bh=LrcYt3NqdXItuCTPMKGUKlc2EiAisVDhpbvW0rLXums=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ofkCJSItk02ub6AqCeMuOM9slfy+NfRcrugg3aB1Po55eokaT4iwhXXti45QT8FjiHVOKGDwjrh+Hk+46+Te3hbtVbFIHcJtxlc0Hkw/TWeHBeyRzNnCe9bF+B36DtITOtB9q89LMrR4xR+t/8x99amLPoE+dy4TPcbR3/1ZC4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuiYcZu3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559ED1F00A3D;
	Tue,  7 Jul 2026 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783435726;
	bh=dXZ5+QgzrBacS+qmB3BlLMKzTVlYuQuSlcAVoY/nXO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WuiYcZu36lqo3KY3UflwL+A8nWbi4EH/3m9AKIXOaI/EAkAiDR5KP47LzKEuEdCgw
	 Q+mZaZzWRALTBRWmILvM3GbpbPi7fA3qekNnu96w9ZOGzWxROiHBNb9xmCmWxHS10e
	 KU/jCEPnatCQ9IqdGKWKNcT7xmzO6FhcJ5PZk+rvnDALbo3ADNhutzjrZZMnleKyft
	 gljswTLBFWIkNMy1uzivC5N7Uc6ePmk0F6lV17svrGpX8ac9tWHoHT1mWY7Av3LxRv
	 SSaZthhtwsZuxZp3i41lvT7/lET8ZtXqSlLqvHjl9M6oidYhGdIRwWOaqpvTC3Vt/D
	 OST/Uez2pOkrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] can: bcm: add locking when updating filter and
 timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260707-bcm_fixes-v4-3-aa87b8b9d33f@hartkopp.net>
References: <20260707-bcm_fixes-v4-0-aa87b8b9d33f@hartkopp.net>
 <20260707-bcm_fixes-v4-3-aa87b8b9d33f@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:48:45 +0000
Message-Id: <20260707144846.559ED1F00A3D@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8090-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,hartkopp.net:email,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 045FB71D0B0

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless reads of timer and state variables in `bcm_tx_timeout_han=
dler()` cause torn reads and TOCTOU bugs.
--

--- Patch [3]: [PATCH v4 3/7] can: bcm: add locking when updating filter an=
d timer values ---
commit 59929132ac1eda994b23441375ebf1eecf8fc14d
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add locking when updating filter and timer values

KCSAN detected a simultaneous access to timer values that can be
overwritten in bcm_rx_setup() when updating timer and filter content
while bcm_rx_handler(), bcm_rx_timeout_handler() or bcm_rx_thr_handler()
run concurrently on incoming CAN traffic.

Reported-by: syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE=
@google.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b612135b017d1..b9b6f1b7bb03b 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -461,7 +466,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(st=
ruct hrtimer *hrtimer)
>  	struct bcm_msg_head msg_head;
> =20
>  	if (op->kt_ival1 && (op->count > 0)) {

[Severity: High]
This is a pre-existing issue, but while the patch adds locking to protect
timers in the RX path, it looks like a similar data race might exist here
in the TX path.

Can lockless reads of op->kt_ival1, op->kt_ival2, and op->count in
bcm_tx_timeout_handler() lead to torn reads on 32-bit systems?

Since bcm_tx_setup() updates these 64-bit timer intervals locklessly:

net/can/bcm.c:bcm_tx_setup() {
    ...
    if (op->flags & SETTIMER) {
        ...
        op->kt_ival1 =3D bcm_timeval_to_ktime(msg_head->ival1);
        op->kt_ival2 =3D bcm_timeval_to_ktime(msg_head->ival2);
    }
    ...
}

And bcm_tx_set_expiry() also reads them locklessly:

net/can/bcm.c:bcm_tx_set_expiry() {
    ...
    if (op->kt_ival1 && op->count)
        ival =3D op->kt_ival1;
    else if (op->kt_ival2)
        ival =3D op->kt_ival2;
    ...
}

Would it be possible for the hrtimer softirq context to see torn ktime_t
values if it preempts or runs concurrently with bcm_tx_setup()?

Could this lead to wildly incorrect timer expiry values that might stall
the cyclic transmission, or corrupt user notifications?

> -		bcm_can_tx(op);
> +		bcm_can_tx(op, NULL);
>  		if (!op->count && (op->flags & TX_COUNTEVT)) {
> =20
>  			/* create notification to user */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v4-0-aa87b8b9d33f@hartkopp.net?part=3D3

