Return-Path: <linux-can+bounces-8017-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PfmlIRkzTGqZhgEAu9opvQ
	(envelope-from <linux-can+bounces-8017-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 00:58:33 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7DA716319
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 00:58:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YJRnNPgG;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8017-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8017-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03EFF3030484
	for <lists+linux-can@lfdr.de>; Mon,  6 Jul 2026 22:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED28386435;
	Mon,  6 Jul 2026 22:58:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C82EBDDE
	for <linux-can@vger.kernel.org>; Mon,  6 Jul 2026 22:58:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378706; cv=none; b=uvkxd07Ir2dLODzaTfxNMxvil/JYgGkjkZLKBr+WUM1XotaYKY0hos84AtEBXUYLW3Z2h8QlrS2whRpV3dr7k3gfL+ypcGC5J1rKQwM7KBKqpfyU46c8hwc8LCg1Zn8x6pU7A15IOWrsPZY51Vl0GsVa/51PXWEBEH2FVOV1NSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378706; c=relaxed/simple;
	bh=PBFw+QpPUgs3r+cNCqDkxyp6h0a1Elth6TcS2KHj9W0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bxgs7pSRjb1v0aKA8d2QinxT0rw6oHxvCLKqdQZP2phYKYk7SEIVgsnKeQRgeTwsnVIkhHFQSHsUO9GA84E8w0CoAr/YgHUtzs9LFVBuNwHpousnq/1LBm3VCimMQtcQ3Wch7GAR/4/OfL7zAb6aplN4WLJaFhOl/QHO8eyE6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJRnNPgG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6EB1F000E9;
	Mon,  6 Jul 2026 22:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783378705;
	bh=Do1L/oX4PFzY5m0KboU5zR7bxQrf3M4nCqc8hU7OTEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YJRnNPgG+3sgmHzZcg2CbR/s6T2RdVDagCUcLQo0hPmEwjKPOBaqt8ZqhRSB8vumn
	 BLoD4iPxmuj8GfZAzfCRd+2XPEgzLdtkY1issIDKURs8j5Rfe7TYJjwZ4Kp/7e96Dq
	 gJ00qtV80xe6JbmTli8eJPM7TT/4vw+5QJ+UxOc0geZlvFzZLQCUYAd0hw9lnTE/5x
	 2+2/zVJUO602PXpHIGYbo5+YAWqqQZxIvc1L15/F02jSVfm93iel1KuOdOprLzPqv+
	 7M2YH5fkVmx90Z2ZMaNl5c4aNOvHW8eY3idFUzTPhHgMRQzoFuXOOoxO4IFcHDzVmY
	 iLFdEP/yK3H7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] j1939: restrict amount of consecutive
 retransmission requests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGFuZGVyIEjDtmx6bA==?= <alexander.hoelzl@gmx.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260706224548.100451-1-alexander.hoelzl@gmx.net>
References: <20260706224548.100451-1-alexander.hoelzl@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 22:58:24 +0000
Message-Id: <20260706225824.ED6EB1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexander.hoelzl@gmx.net,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-8017-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.net];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B7DA716319

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Flawed retransmit tracking logic causes both spurious connection a=
borts and counter resets.
- [High] CTS hold messages bypass the retransmit limit, enabling indefinite=
 connection persistence (DoS).
--

--- Patch [1]: [PATCH v4 1/3] j1939: restrict amount of consecutive retrans=
mission requests ---
commit e2e0a35fca4d64ebcdd174aa2094ae405f7ecced
Author: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>

j1939: restrict amount of consecutive retransmission requests

This commit introduces a retransmit counter and aborts the segmented
data transfer if the retransmit limit is reached.

> diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
> index 81f58924b4acd..16867d8030922 100644
> --- a/net/can/j1939/j1939-priv.h
> +++ b/net/can/j1939/j1939-priv.h
[ ... ]
> @@ -285,6 +285,8 @@ struct j1939_session {
>  		unsigned int block;
>  		/* dpo - ETP.CM_DPO, Data Packet Offset */
>  		unsigned int dpo;
> +		/* retransmits - amount of received retransmit requests (including hol=
ds) */
> +		unsigned int retransmits;

[Severity: High]
If this counter is intended to include holds, will they actually be counted?

Looking at j1939_xtp_rx_cts_one() in transport.c, if j1939_cts_is_hold(skb)
is true, the function sets the hold timeout and returns early:

	if (j1939_cts_is_hold(skb)) {
		...
		j1939_tp_set_rxtimeout(session, J1939_CTS_HOLD_TIMEOUT_MS);
		return;
	}

Because this early return bypasses the new retransmits tracking logic,
could a peer keep a session open indefinitely by continuously sending
CTS hold messages?

>  	} pkt;
>  	struct hrtimer txtimer, rxtimer;
>  };
> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index df93d57907da7..6f999b18bbca5 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
[ ... ]
> @@ -1457,6 +1465,19 @@ j1939_xtp_rx_cts_one(struct j1939_session *session=
, struct sk_buff *skb)
>  	else if (dat[1] > session->pkt.block /* 0xff for etp */)
>  		goto out_session_cancel;
> =20
> +	/* If the 'next packet number to be sent' in the CTS is smaller or
> +	 * equal to an already sent packet it is a retransmit request.
> +	 */
> +	if (session->pkt.tx >=3D pkt) {
> +		session->pkt.retransmits++;

[Severity: High]
Does this logic reliably track retransmits, given that session->pkt.tx
is updated asynchronously by txtimer?

If a peer drops a packet and requests the next one (forward progress),
but txtimer has already sent past that requested packet number, wouldn't
session->pkt.tx >=3D pkt evaluate to true? This seems like it could
spuriously increment the counter and abort valid transfers over lossy links.

Conversely, if a peer sends a duplicate CTS request before txtimer has sent
the newly requested packet, session->pkt.tx would still be pkt - 1. Wouldn't
that evaluate to false and cause the else block to reset the retransmits
counter to 0?

> +		if (session->pkt.retransmits >=3D J1939_CTS_MAX_NUM_TRANSMITS) {
> +			err =3D J1939_XTP_ABORT_FAULT;
> +			goto out_session_cancel;
> +		}
> +	} else {
> +		session->pkt.retransmits =3D 0;
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706224548.1004=
51-1-alexander.hoelzl@gmx.net?part=3D1

