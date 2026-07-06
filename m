Return-Path: <linux-can+bounces-8016-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5E86NgkzTGqUhgEAu9opvQ
	(envelope-from <linux-can+bounces-8016-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 00:58:17 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6612671630D
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 00:58:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Xwtprn4x;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8016-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8016-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE1653021CAD
	for <lists+linux-can@lfdr.de>; Mon,  6 Jul 2026 22:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813F9386435;
	Mon,  6 Jul 2026 22:58:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541452EBDDE
	for <linux-can@vger.kernel.org>; Mon,  6 Jul 2026 22:58:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378694; cv=none; b=UjYHFt5VtdkVkY5XZ+AsnjUSdtS+Nc0cutIzvsQHO46YZoUEAhKDkWh27j0BkEmCBp0rRxzaRdRX13LG9t+G/QZkIR7cUa+Hno6db3LOgz4j5bjR6s9wQnB1srMpsqPPbr4WIXu7r38wuKBZbScLXI23KRfYrlNHSujHlFbK9BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378694; c=relaxed/simple;
	bh=VNrwfRnG6HHsO3hjg/yGCGPpYRQdv3wgFypqga4fArY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gpktfbyFlH79gbVJnCIh5w+Y/eZ0nm2tZ1xB8onIu4D7q15m/yYK4WpujJmeDmM0lccjiIaSZxVMXEpEpVratJkvmZB9yA5p3ruKNJAUvdPnYvcZM0XwKw7qirym7vHNL3Gyu7dIMNlSiIBhIDT/EuBU0wtZry0q9EtjeQLIsiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xwtprn4x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EC41F000E9;
	Mon,  6 Jul 2026 22:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783378692;
	bh=fMpiJtTgb2ztSJBrzB8UJSn9JjbO6CrdCcMUEFklpt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xwtprn4xCJOyIi8SLBOIFL0PXY4CO+2UR2sWnF3z8+4GI8aEZ/1HPL595ipt7v4t2
	 0k1d6HGYBcJEq7aLySOLQ9zGr2JF8xVBOnvdDw8U8S5bD6fCTWrhZxbdrq/itHzgxm
	 kOmMPN1uRzgXD9Z2VMWlcW5ICx1AOUeFywpwfMp5S4TPYJXQtCB4407CRZmsdjyzoj
	 7Wirra3eA4sP9OHpjJOokDtt+7AjGIBY0tgDgqwBbO/85qt3qP31YctKclcpfDh4sB
	 I9Dc6FuI292hKyYdaJ+68vAobrs+BOSL/+3pZ2wNsiGuI102x0IRajF74dHFm1Wecd
	 LoNBYgZ61dPzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] j1939: fix implementation not handling holds
 correctly
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGFuZGVyIEjDtmx6bA==?= <alexander.hoelzl@gmx.net>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260706224548.100451-2-alexander.hoelzl@gmx.net>
References: <20260706224548.100451-1-alexander.hoelzl@gmx.net>
 <20260706224548.100451-2-alexander.hoelzl@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 22:58:11 +0000
Message-Id: <20260706225811.C3EC41F000E9@smtp.kernel.org>
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
	FORGED_RECIPIENTS(0.00)[m:alexander.hoelzl@gmx.net,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-8016-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url];
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
X-Rspamd-Queue-Id: 6612671630D

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprotected concurrent access and modification of J1939 session st=
ate variables (`pkt.tx`) between the RX softirq and the TX timer softirq, l=
eading to potential silent data corruption.
--

--- Patch [2]: [PATCH v4 2/3] j1939: fix implementation not handling holds =
correctly ---
commit eff7a7e71fc39cb6fe94b38a7c7c2264d3d9f7e4
Author: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>

j1939: fix implementation not handling holds correctly

This commit modifies the behavior of j1939_xtp_rx_cts_one to allow the
handling of a hold message. It cancels the TX timer and sets the RX
timeout properly while adding a check against requests of already
transferred and acked packets.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 6f999b18bbca5..ae0dc0a0168aa 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -1488,19 +1530,13 @@ j1939_xtp_rx_cts_one(struct j1939_session *sessio=
n, struct sk_buff *skb)
>  	/* TODO: do not set tx here, do it in txtimer */
>  	session->pkt.tx =3D session->pkt.tx_acked;

[Severity: High]
This is a pre-existing issue, but I have a question about the concurrent
access to session->pkt.tx.

Can modifying session->pkt.tx here in the RX softirq context race with
readers in the TX timer softirq context?

If the TX timer executes j1939_session_tx_dat() concurrently, it reads
session->pkt.tx multiple times within its transmission loop without locking
or READ_ONCE():

    dat[0] =3D session->pkt.tx - session->pkt.dpo + 1;
    offset =3D (session->pkt.tx * 7) - se_skcb->offset;

Because these softirqs can run concurrently on different CPUs, might the
compiler reload session->pkt.tx between the two statements?=20

If the RX path overwrites pkt.tx in that microscopic window, could
j1939_session_tx_dat() transmit a frame containing the payload data of one
packet but the sequence number of another, leading to silent data corruption
on the CAN network?

> -	session->last_cmd =3D dat[0];
> -	if (dat[1]) {
> -		j1939_tp_set_rxtimeout(session, 1250);
> -		if (session->transmission) {
> -			if (session->pkt.tx_acked)
> -				j1939_sk_errqueue(session,
> -						  J1939_ERRQUEUE_TX_SCHED);
> -			j1939_session_txtimer_cancel(session);
> -			j1939_tp_schedule_txtimer(session, 0);
> -		}
> -	} else {
> -		/* CTS(0) */
> -		j1939_tp_set_rxtimeout(session, 550);
> +	j1939_tp_set_rxtimeout(session, 1250);
> +	if (session->transmission) {
> +		if (session->pkt.tx_acked)
> +			j1939_sk_errqueue(session,
> +						J1939_ERRQUEUE_TX_SCHED);
> +		j1939_session_txtimer_cancel(session);
> +		j1939_tp_schedule_txtimer(session, 0);
>  	}
>  	return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706224548.1004=
51-1-alexander.hoelzl@gmx.net?part=3D2

