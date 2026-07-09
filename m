Return-Path: <linux-can+bounces-8240-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EraRL7HqT2riqAIAu9opvQ
	(envelope-from <linux-can+bounces-8240-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:38:41 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7875734575
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:38:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=khAZxsUm;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8240-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8240-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA8E13004D16
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108023CB2F0;
	Thu,  9 Jul 2026 18:38:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABBA4DB572
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 18:38:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622314; cv=none; b=CGPFBpPzj53llaYTHKPp+lVZ7n7YUk6HiTNMMqvDh3MIQIq75X+K0dc36KzcwfjBfxA86TsajNSoyA1UG0735lfYtaKM2J81UaODW0Fai0Q7v8skESK8L9vqMFA6wfSIb4I8WrhY42FPMDAMj409X/TSwYkO3KTU7KCkiVxjJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622314; c=relaxed/simple;
	bh=VoI6QBB1ms3u096FaHhmeIA4sw4rkprCpVMpkJVxrag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XxHPt56EZoB+w614YmmrhVcTANsPvyHIlFJbzriAAUZUjehNdhl/BCsDJJKoO18kZgSLJ35GsiBi90nJmudYI0Q0bHyZuKKFZ6kGbyKu489Ka8qXO3wJquu5Obhf4QtGJ4AP4732bsoMt7QWM0GAFYMJU4d7x0ghp39MhIAqA6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khAZxsUm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22521F000E9;
	Thu,  9 Jul 2026 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622311;
	bh=7+mHsds+4ppVUIu5p3fBC7L1SRY0ulpQRBrl7GMEzAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=khAZxsUm4ITyCNHyqoXjDoY4wZ9joyvSRcIOlCHJDmIB2onCP0YMu5WmF150CmRSu
	 9DT6pQuDf1HSLSz+MGDNKHWI+xoR6AqSCrIdmm9prmqQrdph+XUiQfxPUaM7hm91bV
	 17VDRjm7p95Whxuu847x7+VLCVcr0fiKWPA0YBV6ktDw+o1tPqxvjupt/DKQI8G5L/
	 2a57U5LVMmRWBIBsaBgUKxggTSyZ5krR67USb4aJRnWTWm5ftzpJlKUZtnwA0hOnwW
	 xiIwsAT/c2UNg0sF5h+y8xUe7AcNkdERsVeJyyFxZEYKWAN6G9cfT0iC6PBDatGfC1
	 s56tKo2iREkJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 10/11] can: bcm: fix data race on
 rx_stamp/rx_ifindex in bcm_rx_handler()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260709-bcm_fixes-v11-10-067ba11bec5c@hartkopp.net>
References: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
 <20260709-bcm_fixes-v11-10-067ba11bec5c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:38:30 +0000
Message-Id: <20260709183830.E22521F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8240-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: B7875734575

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional overwrite of `op->rx_stamp` corrupts timestamp metad=
ata for throttled or multiplexed CAN frames.
--

--- Patch [10]: [PATCH v11 10/11] can: bcm: fix data race on rx_stamp/rx_if=
index in bcm_rx_handler() ---
commit 962a73c290cc743e31470d3c9ed820b166d58a79
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()

This commit moves the update of rx_stamp and rx_ifindex under the
bcm_rx_update_lock to prevent concurrent writers from racing each
other, avoiding torn stores on 32-bit platforms. It also ensures
metadata is bundled correctly with the frame content delivered to
userspace.

Link: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index fbf1cbb7c99fe..10a883b50fc63 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -815,6 +810,14 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
>  			traffic_flags |=3D RX_OWN;
>  	}
> =20
> +	/* save rx timestamp and originator for recvfrom() under lock.
> +	 * For an op subscribed on all interfaces (ifindex =3D=3D 0)
> +	 * bcm_rx_handler() can run concurrently on different CPUs so
> +	 * the CAN content and the meta data must be bundled correctly.
> +	 */
> +	op->rx_stamp =3D skb->tstamp;
> +	op->rx_ifindex =3D skb->dev->ifindex;

[Severity: High]
This is a pre-existing issue, but does this unconditional update of
op->rx_stamp corrupt the timestamp metadata for throttled or multiplexed
CAN frames?

The commit message states that bcm_send_to_user() must report the timestamp
and ifindex of the very same frame whose content it is delivering. However,=
 if
a BCM RX op is configured with a throttle timer, a CAN frame might match a
mask and get queued by the timer. If a second CAN frame arrives on the same
interface, it will unconditionally overwrite the shared op->rx_stamp here
before checking if the frame matches any multiplex index or if it will be
throttled.

When the throttle timer later flushes the first frame:

net/can/bcm.c:bcm_rx_thr_flush() {
    ...
    for (i =3D 1; i < op->nframes; i++)
        updated +=3D bcm_rx_do_flush(op, i);
    ...
}

will all notifications use the single, overwritten op->rx_stamp from the
subsequent frame, rather than the timestamp of the frame actually being
delivered?

> +
>  	if (op->flags & RX_FILTER_ID) {
>  		/* the easiest case */
>  		bcm_rx_update_and_send(op, op->last_frames, rxframe,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v11-0-067ba11bec5c@hartkopp.net?part=3D10

