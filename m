Return-Path: <linux-can+bounces-7808-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id csDgMlwvKWplSAMAu9opvQ
	(envelope-from <linux-can+bounces-7808-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 11:33:16 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C57DD667E03
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 11:33:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="UQov/3FO";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7808-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-7808-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8A663006217
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 09:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70C43B9920;
	Wed, 10 Jun 2026 09:16:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACFF306749
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 09:16:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083001; cv=none; b=G8DXo4iZDRafXIkMwdqiN8IWNGhAUEtPMexckPB33WpI2h37qZdVrNhBz+h5c5ZkgBWFxRIaypjBwmvg6xUuY8wnD2HdBBxtcxTB5Aio8aWE2ASr+DtLpG/ES8CSZNvIVlu+6SCLK8JpkwloqnRNduKsrWI+IVVejpNpSGER9qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083001; c=relaxed/simple;
	bh=uED2d8gmGck1OQzdeN3Ge33hXR37r09soIZdigtnMSY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fqJ/Nx65HP+xiAHlU7H4bKOC4emMAoyq/s9VTx5yB7CkjXI6fVfYEpT67psyzktMbU+7V8RVsStCuj2dg+Ui6QsDi4PLXMxLKyQeicOhmpJP02yCCuseSxezDULILsl5mnuriV8FFiUHsCVBa06d8roUSeLOD0nu/vCV9MXq53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQov/3FO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7861F00893;
	Wed, 10 Jun 2026 09:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781082998;
	bh=I/3K0t74On8CHvQ2dbj10zKr1EGrtqWL1GRYQWKrE1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQov/3FODBDpfAYJC9E0PEiGBRAlD4tqCfeUYOz6vWRfb/WRMFL+pAZgkSjJef4F8
	 PPjh3+UmMAXUOilLYTP6JM10ACnQVuURUdbGb1J9GxMW+uc+wzHQsH8eWJ2u8FGLcv
	 FiclWoLtsR+L07xbOmcToofaZuVRzuyDJ9xgsQqxGTBLtYs8PeiZGkd0TMLoAcnBK4
	 70uX/PuhowcMvSooWXQVm3K8WYaUTQlsqfATKgKo7twf14UZO6/8szC10sN9J9XkoC
	 uXfW9PHKTq8d5y1vFiz8COvks9aYcrWoN07QUi0P8oFc5uKpVkxR4taIv5GsKRp34Q
	 F8PSPaPPuzwGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: j1939: fix potential race condition in BAM
 segmentation
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGFuZGVyIEjDtmx6bA==?= <alexander.hoelzl@gmx.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260610090619.70626-1-alexander.hoelzl@gmx.net>
References: <20260610090619.70626-1-alexander.hoelzl@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 09:16:38 +0000
Message-Id: <20260610091638.5E7861F00893@smtp.kernel.org>
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexander.hoelzl@gmx.net,m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7808-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.net];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C57DD667E03

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Remote-triggerable reference count leak of `j1939_session` due to =
un-cancelled `txtimer` when receiving duplicate or spoofed BAM data loopbac=
k frames.
--

commit d4773792dedead1d2a7d20d129ec0234fba6902b
Author: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>

can: j1939: fix potential race condition in BAM segmentation

This commit addresses a potential race condition in segmented messages using
the BAM protocol. It moves the TX timer scheduling so the timer is only
scheduled when the TX acknowledgment is received.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index df93d57907da7..d00f0c158bb8e 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -1948,6 +1960,10 @@ static void j1939_xtp_rx_dat_one(struct j1939_sess=
ion *session,
>  	} else if (remain) {
>  		if (!session->transmission)
>  			j1939_tp_set_rxtimeout(session, 750);
> +		else if (j1939_cb_is_broadcast(&session->skcb)) {
> +			j1939_tp_schedule_txtimer(session, J1939_TP_BAM_FRAME_SPACING_MS);

[Severity: High]
Does this unconditionally leak a j1939_session reference if a duplicate or
spoofed BAM loopback frame arrives while the timer is already active?

If a duplicate DAT loopback frame is received, the code detects it and falls
through to the remain =3D true block, calling j1939_tp_schedule_txtimer() a=
gain:

net/can/j1939/transport.c:j1939_tp_schedule_txtimer() {
	j1939_session_get(session);
	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
		      HRTIMER_MODE_REL_SOFT);
}

Since j1939_tp_schedule_txtimer() takes a session reference without cancell=
ing
any existing timer, and the timer callback will only fire once, won't the e=
xtra
references permanently leak and prevent the session from being freed?

> +			j1939_tp_set_rxtimeout(session, J1939_TP_BAM_ECHO_TIMEOUT_MS);
> +		}
>  	} else if (do_cts_eoma) {
>  		j1939_tp_set_rxtimeout(session, 1250);
>  		if (!session->transmission)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610090619.7062=
6-1-alexander.hoelzl@gmx.net?part=3D1

