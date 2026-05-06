Return-Path: <linux-can+bounces-7533-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGo6OwQ7+2nUXwMAu9opvQ
	(envelope-from <linux-can+bounces-7533-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 06 May 2026 14:58:44 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 521534DA9D5
	for <lists+linux-can@lfdr.de>; Wed, 06 May 2026 14:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6E6D3008D26
	for <lists+linux-can@lfdr.de>; Wed,  6 May 2026 12:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0C044D6A9;
	Wed,  6 May 2026 12:54:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A13FA5FF
	for <linux-can@vger.kernel.org>; Wed,  6 May 2026 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072060; cv=none; b=bZ4zdk+UPH5b/uiF9nuX7ZDnLPtO1JwXkx2JiJ9nVI0KBSRUX4YFr2xNnHBgRnmP30foACRet5VQ7P6EQeAL+2pSGG1Fl2dDUuBZZCqLCI/BMh9KqnvjcXEpHtNbux+bJ//cCZPi0oK3A1Wl/nQFM6FkXEq0a6kSV7KLoC9tmyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072060; c=relaxed/simple;
	bh=nlaY5ptMktP4M6tZTPq32tLB5OIYy9nZEb0QhVLJvBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+FbWDddtv/zvHmNDftTnIf8Xxieyxx2dIsPPxKTIMdQUCP/rYNe+llbp0xdZT4KA5qfLgVZcqtmVEnFCHkENv8D44qtPVlQkKXIoMo8AM1DzoQtH1hQiSXy7I+o3WR5x7A7hYgSJvWiZKcLIZ2u1SJku7/WoTrDE8DmVClQ68U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKblZ-0007pf-9J; Wed, 06 May 2026 14:54:17 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKblY-000kK5-1Z;
	Wed, 06 May 2026 14:54:16 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 99F1252F67F;
	Wed, 06 May 2026 12:54:16 +0000 (UTC)
Date: Wed, 6 May 2026 14:54:16 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alexander =?utf-8?B?SMO2bHps?= <alexander.hoelzl@gmx.net>
Cc: robin@protonic.nl, o.rempel@pengutronix.de, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: j1939: fix wrong rx timeout for CTS hold messages
Message-ID: <20260506-crouching-precise-peccary-9bfd36-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260421153152.87772-3-alexander.hoelzl@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hjgao4vnvhgi7zkb"
Content-Disposition: inline
In-Reply-To: <20260421153152.87772-3-alexander.hoelzl@gmx.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: 521534DA9D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-7533-lists,linux-can=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.net];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


--hjgao4vnvhgi7zkb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: j1939: fix wrong rx timeout for CTS hold messages
MIME-Version: 1.0

On 21.04.2026 17:31:54, Alexander H=C3=B6lzl wrote:
> In J1939 segmented transport, a CTS message with data byte 2 set to zero =
is interpreted as a hold message.
> This instructs the transmitter of the segmented message to hold the conne=
ction open but to delay sending.
> According to the J1939-21 standard, section 5.10.2.4 the timeout T4 after=
 which an held open session is invalidated is
> 1050 ms, not 550 as implemented currently.
> The 550 ms are problematic if a device uses hold messages and assumes it =
can wait for more than 550 ms before it has
> to resend the hold message.
>
> This patch changes the T4 timeout used in the implementation from 550 ms =
to 1050.
>
> Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>

Applied to linux-can + rewrap long lines in patch description, use
imperative mood in last section.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hjgao4vnvhgi7zkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCafs59gAKCRDMOmT6rpmt
0qJYAQDzaTp76s89A1wA9HkKa489TqAQHcCmErsENmH5FvkEigEA9y4ipqJ5pq0r
zCZy08Eh9KY/eH6KjSrpyWwPRKlKCQ0=
=SfNi
-----END PGP SIGNATURE-----

--hjgao4vnvhgi7zkb--

