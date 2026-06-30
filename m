Return-Path: <linux-can+bounces-7924-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 06AWBQnzQ2oPmAoAu9opvQ
	(envelope-from <linux-can+bounces-7924-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 18:47:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 662206E6971
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 18:47:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=EQ0HU7Vf;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7924-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7924-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9460308CE5A
	for <lists+linux-can@lfdr.de>; Tue, 30 Jun 2026 16:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEA93CA4B6;
	Tue, 30 Jun 2026 16:43:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471F3BED19
	for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 16:43:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837830; cv=none; b=uPGGZ+hbJN+XW5TvoZCyqG7dK+3h8tl9wpLSmyppNSDZl6RxF6tlAbyIothXyQfljouIexl3lTQoqJJ9gP+O6yDfSOB4Ycsg60mlbUsow6nfaapNuDbwNjaHK9s67cXQm5CfuXA1Os9GJ1JIjZfQlaR1VsMb+IukKsC9OSqqmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837830; c=relaxed/simple;
	bh=p2PeC0nQIU8XGKa3S/8y6V/3/TZusI1x27XJWhQGfSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UC3InY6rghqIwa0C05ZMmrxAfB5IstuQ+RXtWVZR+WtsDIvca+9o091Or+OZaNkiwH0qfTVTdsW/fJqtuUQXrkHVr2t61PHKYqd1rtoPfKBVwuTJNMEV4dk3XtYp2ZP9RZqQYzX3nNcz9f0SxbJG5tsmme/tfIbDDFLuSGdWhH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=EQ0HU7Vf; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493be1b9564so1457705e9.2
        for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782837826; x=1783442626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uGD+GAgzuwfHMyCvb0nP+s7ICmE38JS3rDHMHE5/jc0=;
        b=EQ0HU7Vfu2P0a4q0Xlu2Yl4zBmffwyGvvYkhZ5fRBTokS52WI1kaCFeNc3WoyZkN4y
         yh0Bqp6yvIXYu9zF0mkI5wzXMlhUYUWuTdaQs3UYBHa8LK84Iz7UslbUsmgoQGpK1b08
         H/3X9X9544cClBvnbs1Au//xr0SFKqG18a05whZUHBIvv47C0qYbzSYMH6X8Fiv9aoEM
         90WvKezdE0Deu6joBjQpbhfhrzXHnaw+biA7OcP8BDThVRQbABVU8SnmqySGzOvolwG0
         JZk1UkKH7rxI3IMXkhVPAS1q7QMDOEchT7R5+4BejVBuhwiPZKKpBTmIEQi1e9aho50T
         cRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837826; x=1783442626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGD+GAgzuwfHMyCvb0nP+s7ICmE38JS3rDHMHE5/jc0=;
        b=rSH3yKLsUxgByiQX9QvKs2gDK1CVGAgDyQA4vz4LI0DYO0F26xwS0wXJb0/wVG1L5X
         fyFE/utJe7nZsLl6r0Rc4/dfOcVNYUP7GIldNzB4rGZvC03SyW3vaLE2VzsL76uyvU7v
         w0rrFY49ck3mYW0bCGT0mTkRcmPpxx82mTrsznDFGQp8hVu2xNAy++JcvjQqsCKm7dkm
         9w4vcuJjCDJRPuPC3uyyER/Xw5nes8qNH9St95k/AJeMwjNFzvr1xVfP765mSYvaSZGD
         dWjydm/Xt3Y1KIPvDN8tpgzeiPkOb4EqLxgRGQTu2lfGHQJLIdw9l24IyHnfhiSciu7h
         PBLw==
X-Forwarded-Encrypted: i=1; AFNElJ8XU47/QobORy75eqmXd+qAHjTKyht+XI8Ul2vCcSci6eeS4iAGCzj0SA/w8YqvtVsT1PwON6GuCBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzradvaHHFa4V6GerGvdpE7gBp3Y87MK7oWleVzBm7d6+dbskxh
	SYxW1jfZd8deFNEznXgsuNcQ1lSMs7EgkohP6PLT9RjBj76+K82rEmpeHAg0TUwnc2A=
X-Gm-Gg: AfdE7ckltZilUEJOJIWakLgnzxE+07WawtzjVEikgVjaL4dW9nIFwyT5ubR/a0Xbw7E
	9+7s/47UX1VJot26lozZsObx7hq6DJZCevtrkOmQY8dVwn4/AiljC/IZFqatIauYwMzCpI7s1nW
	qGuCRtoRgu8Gr5nHTQonOMFZA3nM50bWoR7qCl/yr06IlgTcsSR+Rr+1d9RM4HDM9C3myogZM4j
	N83AzMr5yTXDsCzz4QT4PFsUd135G4Z/mir4O3wRumigPY2iqpOtgF9/EuT2ypdvojmo62ukluf
	Bm0SZBgtRjtkJuKxcm+QlmaUcrSaGKYtGtrT1TBDEgHR8WPC1TkYcxmlgPTc1B+u++U2+uPabAw
	7fOydrWXaPiXAKvxXnVuxOsMw8eo/gg3EPSnWg8zijmZIcv7C3EYHEEc8ekqCGH+OUYHL9sCrwk
	DFADl5vtfZwJ6HDbfsxuQ+cVayWWNJRXcJEW0cEoL1RXORuFSGOrgeasaoM72OiHQQ9iI5vlPsa
	c0V09e8WVSjvN4=
X-Received: by 2002:a05:600c:3acf:b0:493:be37:df11 with SMTP id 5b1f17b1804b1-493be37e0bamr9516005e9.16.1782837826181;
        Tue, 30 Jun 2026 09:43:46 -0700 (PDT)
Received: from localhost (p200300f65f47db042a9b551def0a6b94.dip0.t-ipconnect.de. [2003:f6:5f47:db04:2a9b:551d:ef0a:6b94])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493be4c8080sm9026455e9.1.2026.06.30.09.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:43:45 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:43:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] can: c_can: Use platform id data when OF data is
 absent
Message-ID: <akPwf-nq2vTAlITA@monoceros>
References: <20260624054927.22851-1-pengpeng@iscas.ac.cn>
 <20260625054152.68413-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6qvnggh7oh747mz6"
Content-Disposition: inline
In-Reply-To: <20260625054152.68413-1-pengpeng@iscas.ac.cn>
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
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7924-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 662206E6971


--6qvnggh7oh747mz6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: c_can: Use platform id data when OF data is
 absent
MIME-Version: 1.0

Hello,

On Thu, Jun 25, 2026 at 01:41:52PM +0800, Pengpeng Hou wrote:
> The platform driver keeps controller metadata in both the OF match table
> and the platform id table. Probe reads the metadata with
> device_get_match_data(), which does not fall back to platform id-table
> driver_data.
>=20
> When the device is matched through the platform id table, drvdata can
> therefore be NULL before it is dereferenced for msg_obj_num and the
> controller type. Fall back to platform_get_device_id() when firmware
> match data is not available.
>=20
> Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes in v2:
> - Add the Fixes tag requested by Vincent.
> - Scope the platform id variable inside the fallback block.
> - Carry Vincent's Reviewed-by for the requested v2 shape.
>=20
>  drivers/net/can/c_can/c_can_platform.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_c=
an/c_can_platform.c
> index 19c86b94a40e..8a0c88839d24 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -267,6 +267,14 @@ static int c_can_plat_probe(struct platform_device *=
pdev)
>  	struct device_node *np =3D pdev->dev.of_node;
> =20
>  	drvdata =3D device_get_match_data(&pdev->dev);
> +	if (!drvdata) {
> +		const struct platform_device_id *id;
> +
> +		id =3D platform_get_device_id(pdev);
> +		if (!id)
> +			return -ENODEV;
> +		drvdata =3D (const struct c_can_driver_data *)id->driver_data;
> +	}

Given that there are no devices probed via the platform_driver's
id_table (or my grep misses it:

	$ git grep -E '"(c_can_platform|c_can|d_can)"'
	drivers/net/can/c_can/c_can_platform.c:         .name =3D "c_can",
	drivers/net/can/c_can/c_can_platform.c:         .name =3D "d_can",
)

just do:

	if (!drvdata)
		return -ENODEV;

and drop c_can_id_table[].

An error message would be nice, but the other error exits don't have one
either.

Unless I missed something a backport to stable isn't needed then,
either.

Best regards
Uwe

--6qvnggh7oh747mz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpD8jsACgkQj4D7WH0S
/k6YJgf+PebwvZJFAFdp9ZHI6Q+yYUJRHUrdUo3ouDB/rABWQQhmiHzuIcHqqFYU
cKvY/0eH+Fjp0C7wlSGYvbItKyefUNEXT7w+FvkBQVZR4saZw1v2AS8un3YBWq1c
dtkYlQkOizhIHNXtHW/CdBsfjggE66fwWlIL4kLmf/yNdqMNwnVYlWII008iDxFW
lr7ytQPRaoo7DU3pmQcEq86dzTbW4SBZaZocVRznSgl3JI8WWQkDlyYzzIpP+lYp
hVvA4Szln0XbvaHwsX0Ln//Ni9nioUhJby97P74yCkQX7ioGjp6MK1OUsIqQD+ve
rs49kviGKJ/3AGJSjPoajmGNct3/lQ==
=68X8
-----END PGP SIGNATURE-----

--6qvnggh7oh747mz6--

