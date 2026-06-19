Return-Path: <linux-can+bounces-7889-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t7I1ONl9NWrnxgYAu9opvQ
	(envelope-from <linux-can+bounces-7889-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 19:35:21 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 378A26A7474
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 19:35:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=X1G0bnmJ;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7889-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7889-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED3443057040
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59609380FF9;
	Fri, 19 Jun 2026 17:35:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376833314C5
	for <linux-can@vger.kernel.org>; Fri, 19 Jun 2026 17:35:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781890519; cv=none; b=ce8UU8oOWSQ9tokl35bVq+hSCasb7eW52Q0i1zkXVFiU5/TDn9d48ahnt108gFOzeF6dbKbEhKPRGBDLwQ97k76f+LsPUtkKhYgc9eRzyJ/2YeQuXN2wynl2gMuYuS1NEXsY/u5tVjSL7PH4Y4OawJ94Jj9Wr85UQAyEy+uks/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781890519; c=relaxed/simple;
	bh=3kAluI+OK1a60ua4Ojr4hrMwx6+mT13I2kAsJtMdAl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9edDX7PFxIx9dWwm2rqkEmf9P2JlYA9Cv4k/7znXwiGpCPlxDKmTdgVYijllBu/wV2al4ZaIDNXETpsF0blfTjrnzS0sKDtYrKIc561qA4jjFmveFwEuZieCATdygmy3x0xh5Yb787FXgg89j1UdyBqXfIbqst1Swb7KrK7RuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=X1G0bnmJ; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49222b6e871so19930825e9.3
        for <linux-can@vger.kernel.org>; Fri, 19 Jun 2026 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781890516; x=1782495316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3kAluI+OK1a60ua4Ojr4hrMwx6+mT13I2kAsJtMdAl4=;
        b=X1G0bnmJHWIr7OHKUsa3F20vJ1xC4hGkQhop2Eama9JETLFQATZOcTJjb1sMt9Bwu5
         D6YPYeczcdnvNLJnJryaxhxK5kpSZATTDoosdubEGTcpgPZK/ZgNklzSipluO2j4cEvX
         cCnqh/8kUvUhwVA9Qn3zow65pJs0k7/6q6AXssCjXNUctXZtyvqFwvQghu3GPQtIBqQq
         RW/H4uaYDruBSATUm1a3AYHkbTnPLajw4wR/2CF8wU55AqyYH+4kvk/uwQLxjI3FDBIM
         Wu4lX7LuEedbSoUBrG7xF0TXBj5DkIdM01waqzlr3at0FOv2PcnanXo9Vkfmplj8ayOo
         RYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781890516; x=1782495316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kAluI+OK1a60ua4Ojr4hrMwx6+mT13I2kAsJtMdAl4=;
        b=bJLrUUjuOpxxMEe8YQBisMxtjEWgT1x1GfCzz+J41ThZCY3oNiTWxz7jIc+9IDKazU
         fl8znSU++iDKdakm/iN5TXWMuwlsJKmnVKBnDyny0OpqGgO6ZqchV1J70iQH23rZZWoh
         TDNRuP7n6PgrvrYQHt7o+tuI8+fRsTtr3IUbsKgdIARCBa/giY1pkVPPVHcLkyKFuZdH
         Rih4eRntgV4W3R7DsELkGXcV+NIXYalpGjyOvR7b45wQrEAxL7p3k6g5CHVhqwbnHjXV
         qwdhZl88/HfFfbuBSiPXEEtfDgeNYG+npOyARoBA00zicx8f4Tu/dCsq7sVe2doHipT2
         7peA==
X-Forwarded-Encrypted: i=1; AFNElJ9kTIhGNZ24z29vjMSYHhGhDOLSH/LdqFMc81Gh/jELDahrIl659qosIcaUwrSnDKZsTxXBEgCejx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzztvmPwYHLcAhrFVxIAA0gsheDPpxS1Vh2LXMZjhipQBuwt40K
	pB6NJbkbJISHvP8vL2SAJzgS1iPMR2IdhPIIwCUJ0R0PF45vRT1cdcp2rQAjGGLeei8=
X-Gm-Gg: AfdE7cltrVHujNH6Fa2I2yAKI4mrEp3EACaN2xXNiHFE64Z/aNCAjVpyu73nNRkB6Zl
	m41A2qYFu7fhhcL8OPT9re6OWrguCq25JaxRaP32gRHgamRI4MrruDqcMF/VvbZ2OEhqRsnHwj6
	tdhT3I08k+5KoEdEM3hV5oPlHoMrE7Dkk4pIcL/90NXqtlH61blf32N2WKAUEF/bqfwda7qBbVw
	lojbkonOhz/Mh/LyY6ILX6eblgLxGAEVrlOezc650NJFLQHhNoWPSfLdSrNOtJ5ECwWtf77LIdq
	QIMpq4+lDoBHHfkESRuERBHuuSAnIOy5GAe9IFyQt5FxMODR67QTYcM62NZ/6Pla/V7BBJ8Rf26
	YMyyZ0qkgikpUBEUmDY7oLLRajadT2YMaKW8bUfBBaFekhM+tEnWpO2MCB8mX3QT/vlske60t33
	BIZkFxrgoSMoct2kzQw4mkxTGeOuKWHB+acfapQ8MJnROlJdv3RURvTYhINEMdl/kJQTIeOIooe
	T1VOZyuHNX58w==
X-Received: by 2002:a05:600d:8654:20b0:492:45cd:82d5 with SMTP id 5b1f17b1804b1-49245cd835cmr26779975e9.24.1781890515652;
        Fri, 19 Jun 2026 10:35:15 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-466648c698dsm693532f8f.16.2026.06.19.10.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 10:35:13 -0700 (PDT)
Date: Fri, 19 Jun 2026 19:35:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, 
	Vincent Mailhol <mailhol@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
Message-ID: <ajV9XwYJSsqYiP2J@monoceros>
References: <20260618140147.142489-2-u.kleine-koenig@baylibre.com>
 <20260618141210.11C001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cgshtc6dqvrb74k7"
Content-Disposition: inline
In-Reply-To: <20260618141210.11C001F000E9@smtp.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:socketcan@hartkopp.net,m:sashiko-reviews@lists.linux.dev,s:lists@lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7889-lists,linux-can=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,baylibre.com:dkim,baylibre.com:from_mime,monoceros:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 378A26A7474


--cgshtc6dqvrb74k7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
MIME-Version: 1.0

Hello Marc,

On Thu, Jun 18, 2026 at 02:12:09PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [High] Network device is registered and exposed to userspace before har=
dware and state initialization are complete, leading to race conditions and=
 a PM runtime underflow on probe failure.
> --

given this is a pre-existing issue, I don't expect this to be in the way
for my fix to go in.

FTR: I don't intend to work on the issue that sashiko pointed out. I
don't have a machine with that hardware. So if someone cares, from my
side this patch opportunity is available to be grabbed.

Best regards
Uwe

--cgshtc6dqvrb74k7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmo1fc4ACgkQj4D7WH0S
/k5qXgf9H3duB+br6QFgxRg+6Z8BihknViaOnUHZ7d046No2cNVc8c5KNb8qxiTb
aFKRhQsjTD4m/kQhjYjQNJn2Dyf46JkNBpmGDa6qx+4v0zuiP0qo0BQDo7ML8TcU
odKvV3PkNQJstzzhmRAaHgoh8mrq/nc0qACezd3XckQGSRf1h/virMzA88sDx7cE
4iY1N2IgPfAgd0Hw+rO/ZzynUs+IslT/9DYkE3OvN9lZVy4sUkTjICwrViLw/me1
QbAc0VlIul8gb/ndKVszQQFEkD0mAqDMsZiynSeyCQJ9mLjncxYNeivqK8p9ERKd
9xHzzNtbNL3aS85F1CJOHkwhgz5P9A==
=ADuo
-----END PGP SIGNATURE-----

--cgshtc6dqvrb74k7--

