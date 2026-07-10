Return-Path: <linux-can+bounces-8304-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EOSHC9MkUWrA/wIAu9opvQ
	(envelope-from <linux-can+bounces-8304-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 18:58:59 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF0F73CD24
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 18:58:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="JZ8SN/Tc";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8304-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8304-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B4513006080
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791BF369D53;
	Fri, 10 Jul 2026 16:58:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF0A274FD1
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 16:58:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702732; cv=none; b=efxmQDASmpHNak+Gx2VSNMvJ4X8fneWYn1cSKMO8l3l+n9GhjfNtzgBajyzxST68CddotwbS/YZACDFb16MEz1U6iwoWrV3S/L+dC5Oum5Ykcl5fDZzSy+OOPkek7YY6gajHZEo4Obclcb0N3EFP4PLVJbeSLKb1zz1TOzyzQDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702732; c=relaxed/simple;
	bh=iiuA9krYQWNvqjD4mcMGaoxXDuervU+RtefH40/HoM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R8aFHLtVxK8xJC4wBRpPMAuvdPJTdSxce8JVcSh2iLy9W3vQaWYxk2A+IRL7d3cK7+YBxYt2xvZGiBpcIgMnrq9lxBLyav9CMACW2JkEu/UnO/xUP0/0c/epMUuQVA4JqTloLDHolwieERIA75jDsBHdIFcu5p6zRxFzTz1+gnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ8SN/Tc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968E81F000E9;
	Fri, 10 Jul 2026 16:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783702731;
	bh=M+zUIO49tfeRrxs0RUNfXe+8VblvGPlZ/0bFziv0V0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JZ8SN/TczEWtlohxx/32io0Lleir2ez94CBqt4FZS58gorMD3EtBC22iccS4kTY3s
	 vwQn6Zk/+R1q8J5IVRVkwNrTlmE4D5EQM7kquK6jSAKM0AW54WUrhmgARpIhv/Pwnn
	 wUnZA3HsYq7pPFp9zJ7Hf9+Q8D7KY8J3vlbtY9/9dlTc12ouwV1JOuRhTKNz5D06ux
	 jeaoo2tNBwmjJBdPNOfg2NNMtoRWhIjT/QF/s4qY8blsIymaXOmStJaidx5CmAWCLK
	 GS37BW1SWP39cLS/nDmFAgKukpkQ/p1FzM/zXRniE/+Z0enlkOx5aQGwnktrv2pquS
	 2+WWImNZ7suvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] can: isotp: fix use-after-free race with
 concurrent NETDEV_UNREGISTER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260710-isotp-fixes-v5-2-15174d82d6f1@hartkopp.net>
References: <20260710-isotp-fixes-v5-0-15174d82d6f1@hartkopp.net>
 <20260710-isotp-fixes-v5-2-15174d82d6f1@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 16:58:50 +0000
Message-Id: <20260710165850.968E81F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8304-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid,hartkopp.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 2DF0F73CD24

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing rx.state validation in isotp_bind() allows cross-interface=
 data corruption and spurious timeouts.
--

--- Patch [2]: [PATCH v5 2/4] can: isotp: fix use-after-free race with conc=
urrent NETDEV_UNREGISTER ---
commit 84cdeb4490291132fa60d9c7c68c759beafa051d
Author: Oliver Hartkopp <socketcan@hartkopp.net>
can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER

This patch fixes a use-after-free race by holding a tracked reference to
the bound net_device in the socket from bind() onward. It also serializes
bind() and release() with rtnl_lock() and adds a check to reject binding
if the transmission state is not idle.

Link: https://lore.kernel.org/linux-can/20260707101420.47F261F000E9@smtp.ke=
rnel.org/

> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -1317,6 +1327,17 @@ static int isotp_bind(struct socket *sock, struct =
sockaddr_unsized *uaddr, int l
>  		goto out;
>  	}
> =20
> +	/* A transmission that outlived a previous binding (unbound by
> +	 * NETDEV_UNREGISTER) may still be draining; the FC/echo watchdog
> +	 * timers bound how long this takes. Checked together with
> +	 * so->bound in the same lock_sock() section above, so there is no
> +	 * window in which a concurrent isotp_notify() could be missed.
> +	 */
> +	if (so->tx.state !=3D ISOTP_IDLE) {
> +		err =3D -EAGAIN;
> +		goto out;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but should we also validate so->rx.state here?

If a multi-frame ISOTP message is being received (ISOTP_WAIT_DATA state
with rxtimer armed) during a concurrent NETDEV_UNREGISTER, the socket is
unbound but so->rx.state and rxtimer remain active.

If the user quickly re-binds to a new interface, would consecutive CAN fram=
es
on the newly bound interface be erroneously appended to the old buffer from
the deleted interface?

Could this also cause the legacy rxtimer to spuriously set sk_err =3D ETIME=
DOUT
on the new connection?

>  	/* ensure different CAN IDs when the rx_id is to be registered */
>  	if (isotp_register_rxid(so) && rx_id =3D=3D tx_id) {
>  		err =3D -EADDRNOTAVAIL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v5-0-15174d82d6f1@hartkopp.net?part=3D2

