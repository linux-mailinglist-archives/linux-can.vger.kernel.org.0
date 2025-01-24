Return-Path: <linux-can+bounces-2692-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3451FA1B33A
	for <lists+linux-can@lfdr.de>; Fri, 24 Jan 2025 11:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE4F57A1165
	for <lists+linux-can@lfdr.de>; Fri, 24 Jan 2025 10:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6CC207A03;
	Fri, 24 Jan 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKeyW3Bu"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9061B87C3;
	Fri, 24 Jan 2025 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737712934; cv=none; b=uQUrpWvKtbFPD1JTSVH8ovAtZAd0FG14B86ZMMDWFuN3LjS5O1ZsKgy2LYcy44o9TJo5dgPH32/31LXuo8BVNt7YF1gUExRC00/8ea/G8Oah8dUmHcbnJUNO9Yw0ctWTX7YOfK4bPs7Toae3ErsEVDzLx+QyFwA4df2j6i/T1DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737712934; c=relaxed/simple;
	bh=PG23KZ1AsMgT8M/17mcYN8E0tAr2zJOi9ro3SOQzCO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxU/1qbgKUYVqt5tnkAYAhQdRP2JBpluOJLF6zVn9rUcxyG3IgSpiX2/vBJfoQFk4CoyEcQ+gOM4Dd9+ViZK+3/saj4n9AB/HXSW1BdnyfKhFdFhRpzdm7GcW7brOEiKR/HAMB3bSjERL/NLqSaWIS5UHFd/cE6rAMJ85POWQxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKeyW3Bu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216728b1836so31000885ad.0;
        Fri, 24 Jan 2025 02:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737712932; x=1738317732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kV9nRSQ8mieKAHPZA8dj6zBQSRCNZwPWiGP+2xORqJM=;
        b=TKeyW3BuaPtJedRv+usdgSiBA+rYALKtvqu0e3ZF8Cv8LygXx7yfJfXtF+rVfZoYaU
         BrhBUqmcT/4imvBDSKKTVJIPA0njpQXZfdkKNBsEn7hQJgLaEzwW2oNqJ8oSw8uA/ep7
         t5pbjErLJBZeaDYg1WgnyDZ89z/CS6PcvDdu9GZkKwcCmiTV0Z6bBX6brbkXZHxC72Sy
         URdYCEruhPpOlNuL/pTKgr1Ic63USxuV5XRAMPC6edIukbmfZk4oT+HB1JUD3F5bhs5z
         Ewltz1jP4v614VkSkeL6n2H8rCuIdBlkUknfhvirN+3mvBxLPRB05/LeUvSR5+lBquTD
         ZCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737712932; x=1738317732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV9nRSQ8mieKAHPZA8dj6zBQSRCNZwPWiGP+2xORqJM=;
        b=UgG5w8L62Ogb6GmDaSXIUMlGJq4QYPaKoQom/3s38CJd4pLenMGOaD898Tut6DKdqh
         uPD8Dok0BdzSZ1Pn7FyOdyeqV+S2PXw1b3NF+duNxrDmcmWLTtIqj/uzyKMIe90dB/R4
         uOTLyD1yXRvUrRM5iGEB2XV5MtzO+FOWBpIxOYaoXWS3/95GIsNGvFyWuwYQjsn5lsxb
         /zNI0foYb9i9v7Q3xlSV5fdAULPpeyhhKU1yVHCyYypaBNWspefiFyVGA84NZEnZ0e1D
         NOov7jrULNvvktLhjLAzQlk4FdGWPQMAvlw9rka6e4ZfbttoLCBJr/SHmMIDldkr2MSW
         1upw==
X-Forwarded-Encrypted: i=1; AJvYcCUzwlM880hw8pBsLldS5jx25inEv1iigxr4gqid0ie7c3N5h9xExrJvvsK0ox/OOsdBDS0TFj7Pkwc=@vger.kernel.org, AJvYcCV9QoTv7lRlWP5C7YCwAg/Sa4ASCvJuT5e7w2ebS77RuEkGATsQDfWlW+6ifwymLfQ+ohKLcyetVlEVAsCg7+Mtkl9uSw4=@vger.kernel.org, AJvYcCVgNKD/OocfBbjXh+b8/qPQiqaWlTTmiZTkf2pIQikv1nrpYoLvziVQT+56+/dQDL7KH6Z9akTBRBcN@vger.kernel.org, AJvYcCWedpV/1M4RqWjRC3jfJID98xpXl6S1FoOdRQ6oiTmc4s8hEwTKM8BVyGkdoOjwU2VfVDq6PRNt@vger.kernel.org, AJvYcCXzd4q5l/+iw4IKBJajS59cKkB2Vd8cAi58plbp7PaNxbhgyx7fNayzLHa/4xOwlzqngTSAHv44N5htok3J@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OliOfMhra/zepv8Dlib8AGBDBO/oxA1tFo40t6sDMUiO6gol
	os8zGstZvd45QlGxHXgoUit9hVinwiNmDPV0nQ7ZodlYz5x4bcED
X-Gm-Gg: ASbGncu9sf4PbUnREUpqJwHHFIllvT6dD9yovAgfRg9cjcRIRQyAzjJ6EC6UUNMjarP
	tI4LdG9bcABO7uNmbRgg7LYYdyYFJLIpD0YX8HUMVykTLIz/trmQ3OHE/kWkdL8wt+Y7gVl1UEv
	mYKjZAVYfPSY+K/gdIciFObFA3qFLQeSHywLylKfxp0ASqLtGfBzPPuqpYqxrYOLFDFiuO4IEEV
	0sxtUF9udllLm2tHOQGHBSZVyIBICS4WFDuUB0lxVinUYzE7qGB5lIaRMPaj4onP0aMxhUQzAeS
	mf/g
X-Google-Smtp-Source: AGHT+IFpze+Oipqpvmu3woguMJEQZi5aiMU334eCqZkGSKbDvO1CQlvlX3d34GhPBDzAyRbhLOtiaw==
X-Received: by 2002:a17:902:cf01:b0:215:94e0:17 with SMTP id d9443c01a7336-21c35530228mr460939765ad.23.1737712932200;
        Fri, 24 Jan 2025 02:02:12 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9e6ffsm12750515ad.35.2025.01.24.02.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 02:02:11 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id B8E514208FB7; Fri, 24 Jan 2025 17:02:02 +0700 (WIB)
Date: Fri, 24 Jan 2025 17:02:02 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>, socketcan@hartkopp.net,
	mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net
Cc: shuah@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@vger.kernel.org
Subject: Re: [PATCH] documentation: networking: fix spelling mistakes
Message-ID: <Z5NlGsZlsoqSBzX9@archie.me>
References: <20250123082521.59997-1-khaledelnaggarlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RD0+TQNC+QTzLiQX"
Content-Disposition: inline
In-Reply-To: <20250123082521.59997-1-khaledelnaggarlinux@gmail.com>


--RD0+TQNC+QTzLiQX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 10:25:20AM +0200, Khaled Elnaggar wrote:
> diff --git a/Documentation/networking/can.rst b/Documentation/networking/=
can.rst
> index 62519d38c58b..b018ce346392 100644
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -699,10 +699,10 @@ RAW socket option CAN_RAW_JOIN_FILTERS
>=20
>  The CAN_RAW socket can set multiple CAN identifier specific filters that
>  lead to multiple filters in the af_can.c filter processing. These filters
> -are indenpendent from each other which leads to logical OR'ed filters wh=
en
> +are independent from each other which leads to logical OR'ed filters when
>  applied (see :ref:`socketcan-rawfilter`).
>=20
> -This socket option joines the given CAN filters in the way that only CAN
> +This socket option joins the given CAN filters in the way that only CAN
>  frames are passed to user space that matched *all* given CAN filters. The
>  semantic for the applied filters is therefore changed to a logical AND.
>=20
> diff --git a/Documentation/networking/napi.rst b/Documentation/networking=
/napi.rst
> index 6083210ab2a4..f970a2be271a 100644
> --- a/Documentation/networking/napi.rst
> +++ b/Documentation/networking/napi.rst
> @@ -362,7 +362,7 @@ It is expected that ``irq-suspend-timeout`` will be s=
et to a value much larger
>  than ``gro_flush_timeout`` as ``irq-suspend-timeout`` should suspend IRQ=
s for
>  the duration of one userland processing cycle.
>=20
> -While it is not stricly necessary to use ``napi_defer_hard_irqs`` and
> +While it is not strictly necessary to use ``napi_defer_hard_irqs`` and
>  ``gro_flush_timeout`` to use IRQ suspension, their use is strongly
>  recommended.
>=20

Looks OK, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--RD0+TQNC+QTzLiQX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ5NlEgAKCRD2uYlJVVFO
ozOLAQCl8xjCksO/2hOyEX/nGCgfpFYnbhfVD89Xy4RfQ3zL2wD/bEYRoZX0basl
rcYvHQtEYowEqXnopSLl7qJ7DEDkCw0=
=t2bA
-----END PGP SIGNATURE-----

--RD0+TQNC+QTzLiQX--

