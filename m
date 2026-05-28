Return-Path: <linux-can+bounces-7724-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJd3B5xCGGoEiAgAu9opvQ
	(envelope-from <linux-can+bounces-7724-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 15:26:52 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C785F2B28
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 15:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDAB3300B180
	for <lists+linux-can@lfdr.de>; Thu, 28 May 2026 13:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430193BD224;
	Thu, 28 May 2026 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="cF/gRSvW"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5573F44D1
	for <linux-can@vger.kernel.org>; Thu, 28 May 2026 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974796; cv=none; b=KbjJ7eSTfW8ji7ItNXyxoXtKNhUrd3zezI0HMWi4gqJxOoNr8Ivs4v9HSmjXqQqxUYCVzW1jD+bKg5U4OUlVlboCTLBpNIYH+4f0E01SBEvtOBVVqNkhq+qKW6vk0YXPhchLsBchy6R/jsrtjNM/CnMdnDk/ZxRyQgdgGsQTcJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974796; c=relaxed/simple;
	bh=03lGqlF+0BEi21i0yMRj08s+nfpxN0o2kGLw0gW00Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXyzBAIedJCuGFAaM7b49LNlVIgzk1vncmE1mlK7A1NiRw2266zgnodjE1Wr26cO4wcJm1NsXXeTi2iuktuIcOPZcgYLvQThfeYNf4go1voaBPGxgh2ZYRHtesYiExF9I7+b/dglKDVjM8LVtbsKgZeyEGeY5iHfbzh95UDq5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=cF/gRSvW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4905529b933so44134405e9.0
        for <linux-can@vger.kernel.org>; Thu, 28 May 2026 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779974790; x=1780579590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=03lGqlF+0BEi21i0yMRj08s+nfpxN0o2kGLw0gW00Qg=;
        b=cF/gRSvWYOcnUuySM6zK2mqeZnGtBhlzDFBp0mZ6yw6xRWo33OtS38fGI9xHngN+e0
         jdgKmjdeSe2c/rzjIEGggAw03TCaLAiVD9jBqVbRSLB5HEeRheF/VqaHi2vEgZVHZDE3
         ydLyQ0du3WrMe+ePTSPXHRUr/zMIwyBz56mJDJ7t7mOW2UQ908qIfwninBo+NZ5aHFwT
         6471RsMQc4uVxXA6Iw9x01aPUMTTxS4p7jYK7VUF2/ysdP1t+VgaFarCPlH2tR0vGZJ3
         HPkJVs1zXv6fMK/AAEDM8++uTFwCajH1CpsEp3tM16hMhCYN8ipBwA3Tuq2nceB2NSH6
         1yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779974790; x=1780579590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03lGqlF+0BEi21i0yMRj08s+nfpxN0o2kGLw0gW00Qg=;
        b=ankogbg1gdIINxOZ+tTwhgIHA1wblkqXSvQx8brBeYmGh6gb/003HiCUj9pMJBsElI
         sxO0c7jbDu4KMoEMpQyQgeJ2+16vU7G7x+/vafBBq+L6/IeYneDJvDvhWVtBFcIeCmJT
         IbPwPugPuKs9BCCMezf9Vhp0a4cwjwTtBOdWnu6dq+33Hr56T78pqDt3gMypkNlO7LGu
         eeLt9alNru5ovY3K/I+PKW1g9OXaS8jlnJPgxOxey7gW7Hx4HPGwrnAsqD1Xg0GtDwEG
         4XFimEtEEi1rza1dracfYhWK8ZmPHS3kX9H+BQ/WA6WIm4Yx0CXqDAqJ3Fw9wah9I4ie
         XNUg==
X-Forwarded-Encrypted: i=1; AFNElJ8jXXZ6HQ14NXHq59JRoMCDYfhm9vUkvjxXtk4cbCP7Q/Sxgf2W7WXr4nNjrhR3V3O5wJ/3aRGvsaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFjqnrmA/bHHlSgPfZr6YeMp1vIjRRiBA8PR8S+DB8v/q3WsDz
	NuHesemSmCJcNXf1BWewBssZzvhDrj8XihaVDfxlSSvGd5QFXCfDk3Db7ld+zZoc3HHPqykA5Oe
	roNIOH5Q=
X-Gm-Gg: Acq92OF5Piw1GFpgrHuYtzo8lQw+zpbl0q++oyzLFWieRijLN8F5nmo6GbbGnm/n2++
	CDC9IWr/BV7goDEcV96mrui7co+BKjrR64Vt631U+4LQXhkQp1txYljdpCC+3facP6mAHXZtkfb
	Lss8jTf8VAmph1/P1z9srF2j0e2XSjOYzFuBf06wziu2rYjyJe1fCHbkn5y/B5dFQZTAaYtDeP1
	dl6U5rsfkR+l4HG3Vgv8aAlOap8ls/kETazkxg/WnoTC3Q9m2R/riZQTx1fhE5xnL4JVQ8/ta7d
	KlQiEzMlRCpJ2SCL/Bo1lBrhVG5TG2diO9PSPFUhKivasDr/fpJkdjCivGLS76ySE820ESz/xjP
	SKjv3fG7lXedRgoG8X8iZcjL7tdAtpYH+40RcS0Opivg7zoA1lh5UUVFHhMPLFOh0cZZzXdkoIO
	B+p3Gds4Bbqi7jvcWp82EAUaebF+krlpNqdH6dzsG9PtNQ2r44c90g6Gf11LELZpiej3CfZgEB0
	45j26Af69SKm977XWH41U/5Zw==
X-Received: by 2002:a05:600c:8210:b0:490:4663:691b with SMTP id 5b1f17b1804b1-490466369f4mr444171865e9.7.1779974789615;
        Thu, 28 May 2026 06:26:29 -0700 (PDT)
Received: from localhost (p200300f65f47db04e567da92d09b3dda.dip0.t-ipconnect.de. [2003:f6:5f47:db04:e567:da92:d09b:3dda])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49092a82ea2sm71703465e9.9.2026.05.28.06.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:26:28 -0700 (PDT)
Date: Thu, 28 May 2026 15:26:27 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH v1] can: flexcan: Drop unused platform driver data
Message-ID: <ahhAhZ76nLc-eZg8@monoceros>
References: <20260528094540.1867783-2-u.kleine-koenig@baylibre.com>
 <20260528-fluorescent-sage-ladybug-43261b-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jr5ezym2bbxklprz"
Content-Disposition: inline
In-Reply-To: <20260528-fluorescent-sage-ladybug-43261b-mkl@pengutronix.de>
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7724-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B3C785F2B28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--jr5ezym2bbxklprz
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] can: flexcan: Drop unused platform driver data
MIME-Version: 1.0

Hello Marc,

On Thu, May 28, 2026 at 01:00:15PM +0200, Marc Kleine-Budde wrote:
> On 28.05.2026 11:45:39, Uwe Kleine-K=F6nig (The Capable Hub) wrote:
> > No function in the flexcan driver ever accesses the .driver_data member
> > of its .id_table array as device_get_match_data() returns NULL for
> > non-of platform devices. So drop that unused assignment.
> >
> > While touching that array, drop the trailing comma after the terminator
> > entry.
>=20
> Does this mean that commit 5e6c3454b405 ("net: can: Use
> device_get_match_data()") introduced a regression?

Yes, I'd claim that this commit introduces a null pointer exception when
mcf_flexcan0 (defined in arch/m68k/coldfire/device.c) probes.

Best regards
Uwe

--jr5ezym2bbxklprz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoYQm0ACgkQj4D7WH0S
/k6P5Af/RigOk1qBi0phQGZoqolZBtvjNCOPhXdtTXZsPHFrRSQHlnNNrCwumgF4
gXsU30alRevFmOywvJQjR20jiQdfyqOz/Lh4rLmTP3/I7kfhEHsQHe35v2Rartas
20cbq4rj8aeF1jFaHth7acd0i0vpLMDS228PzL2qlnNTam51AZWKBqj6GoOzGsmt
00cRVpIB3ZYd8S5sI5g1go5xSeDGFaUgtPMYzzZoBrhzAsqYb+ypG/qSNLvDgn5l
6D4LUQLaDD+Ds6gwzkFPPXfAEmxMQwnT07u6+PQCfPbuGmSNye7H4KEFgdStSD95
6tdn5MsdA99T+oswj7W1DmgD27Gbwg==
=UgOY
-----END PGP SIGNATURE-----

--jr5ezym2bbxklprz--

