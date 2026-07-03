Return-Path: <linux-can+bounces-7994-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ito5JgTqR2oKhgAAu9opvQ
	(envelope-from <linux-can+bounces-7994-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 18:57:40 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4659070471E
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 18:57:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=oyxLaysk;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7994-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7994-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C62433027B41
	for <lists+linux-can@lfdr.de>; Fri,  3 Jul 2026 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A4C307481;
	Fri,  3 Jul 2026 16:53:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5E2E62B4
	for <linux-can@vger.kernel.org>; Fri,  3 Jul 2026 16:53:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097600; cv=none; b=j3b3zJKicjrZibmmRM/oi5aIG6GPtxED6P3nT8D4cNZmZqxgB0lthsjl2L3FL03D9J8BEyY61fbYIUXLWjFjEQqT96n5OiSPfDSYs3M/j2D9AYTVMw44kIJMR+dMX4n4S5ehepGEKzmm3ZtnrizDdWGbSA5w0dPqfpm7P/gJpMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097600; c=relaxed/simple;
	bh=sUpzvAtostE3MW8LT1/9LROV5+uUUmRdE1s1QLaacSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzxKq9HZR8qyzipMLxDtV8aSoRd+sfA9Xr46/No9JaGBY8j6C/K5FKSTzDW+0ilxi2dTzP8hZQW0AId+VzKyFXY7CpN4FtxTasqpcqwg1Dqzw8BjGtbUrcGAvG7xgZdcJxM45MOgGIH1837l1kpTMKkmtOhZoIjiUto0oYwkqek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=oyxLaysk; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-472326ca506so518302f8f.2
        for <linux-can@vger.kernel.org>; Fri, 03 Jul 2026 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783097596; x=1783702396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUpzvAtostE3MW8LT1/9LROV5+uUUmRdE1s1QLaacSw=;
        b=oyxLayskjViGd7jUQJQx2RZW1oVQ2C9KtokSIXV/oVxB5oWfrq/MbR/S+/hltkROqt
         e8cC+KiREAbxogh96+PEYpnKHnlmkP2TgTQgiVkhWSHFqUY5/isoFquV+lAImZ95P/gZ
         6F5LBqWcyFX4ezemS2eIhZtDO68vCPvuf5f63xGanYnOavLK2UXZHOxDEfuvEYyw73Qu
         LALfbTinr5zM7uK+RwJPktW6cPMngP9OiHQn/N9z6+PmmTELMPD5tKwWvDl7MceAiZWB
         jaEAneuhPL08ioclF8iyg6j3aZUqX99T3KhuGcKMYlRK2YvJPmK4xInu7+qod8AnKxvo
         Xa6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783097596; x=1783702396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUpzvAtostE3MW8LT1/9LROV5+uUUmRdE1s1QLaacSw=;
        b=QtJVhtgGwrk9VzthmCJmUjiYo2cZFeaeqqN8kxDPid6JO0rxqEUy1T+ncVDdxGSHkm
         DYVj5clnqnMAoGbLMTR0D5CvU3SoGOALa0tMQBgQafaZ63xzZE67GGGW5aMXaLzhyg2c
         qXImQOdeUZvi04q5X3DtknxvFkoq4Tq/AD2KlOIDfUIUI0f1t1pOqCYc1YD8Vf8CBr1M
         uIPF3DZo04kuowGuysr6YNpKzLL67OYN2jnOeNj2Rw/ZgeMbzQNEANCPC8HMQzvTYeBM
         8aoMFhxDXeKW2hDI1GAnhDK/HUhEVcXnHa26AdhTJEJ4rfyzKhhrI4Kk59372PmxsdRP
         mtWw==
X-Forwarded-Encrypted: i=1; AHgh+Rq4rsNm8AAz2qeUtZF7JaWaqEhLbII4E9EIPjYf2eav33Vbh+2QWO0Vc8TGXZTtG0oMe7sbns0m7cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyixPL2G/GzwKcECfcAsIsyVgLyxux+GIwsFFWqDjLKAuOpYSF
	y02WqnylcZKU08YsOzckbkfOrfSNAdN6yGikFsj3o6TFlUFER8vNKLwv53f+mDLG+TA=
X-Gm-Gg: AfdE7cn3NP+q0aY+GK+sG9bc6x0zvL6u2J3PSVFs4dTl1AQjCQJWJ7QtRwhdovqP+dn
	I7+iBnb2G8wzv2fsMcNTtpNkAJ9TXk+oVL2UxPKZVdMDSnuY2YN87/cvvNImizzBooQdltl77Tf
	BqnFO+e2wp7o3q76IBxzWESnHqF6+FXCN1hwvXnFufoy/cnQeppJGs+JWN+PBIeJXIHT4WHulE8
	n72Ebd0Wr7OfUBUhboWbzRWcTxuIQR/Do0vPU26+nCv1Dcnp1kLjgigwksdlcJTozSiteGayWo0
	nVTvGxkFkS0KPDWtbo2JRtXpCgioJy3BLzQGf0nCEj0a4Vu/Ucj1PbzXg7FngyEY8a7XlZzyWUS
	OU0986J4DdI1cs2aOE9K2K4QCOVMrZwi1c6GfAz8ACkloqomeR8BrhxiUBaxmeT1TtzTUDAH6/E
	4XWdJO9KcHwVgSlZkNlObpNqf2VLhCXLUcWwoDCEjpdVOWecBF6/0cBq8wbgKN1n+ro1IUiVmEw
	1Dt
X-Received: by 2002:a5d:4b4f:0:b0:477:80fa:f480 with SMTP id ffacd0b85a97d-47aae8884e8mr113189f8f.39.1783097595912;
        Fri, 03 Jul 2026 09:53:15 -0700 (PDT)
Received: from localhost (p200300f65f47db0472e4f1e98703de96.dip0.t-ipconnect.de. [2003:f6:5f47:db04:72e4:f1e9:8703:de96])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47aa0f214d2sm586590f8f.33.2026.07.03.09.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 09:53:15 -0700 (PDT)
Date: Fri, 3 Jul 2026 18:53:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
Message-ID: <akfoYuyHMAxIfalD@monoceros>
References: <20260618140147.142489-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="esqz4aktzsx7daht"
Content-Disposition: inline
In-Reply-To: <20260618140147.142489-2-u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:jeanmichel.hautbois@yoseli.org,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-7994-lists,linux-can=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:from_mime,baylibre.com:email,baylibre.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4659070471E


--esqz4aktzsx7daht
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
MIME-Version: 1.0

Hello Marc,

On Thu, Jun 18, 2026 at 04:01:47PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> When determining the device details was reworked in commit 5e6c3454b405
> ("net: can: Use device_get_match_data()") there was no replacement for
> the previous handling of non-of instantiated devices via the device's
> id_entry which then results in a NULL pointer exception. The only
> in-tree provider of such a device is arch/m68k/coldfire/device.c.
>=20
> Given the id_table only contains a single entry just hardcode the result
> of `platform_get_device_id(pdev)->driver_data` and drop the unused
> assignment to .driver_data from the table.
>=20
> While touching the id table, drop the unusual comma after the terminator
> entry.
>=20
> Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

Given this fixes a crash (NULL pointer exception), it would be great to
get this applied. The issue is already old (Sept 2023, v6.8-rc1), so
there is probably no urge to get this in before 7.2, but getting it into
next and then 7.3-rc1 would be good.

Best regards
Uwe

--esqz4aktzsx7daht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpH6PYACgkQj4D7WH0S
/k7a6QgAnxYTK/BkhslqdnK7jFa+bO/4zfBNv8zZHBfWsjNBgC6PagZ6dTO9aU27
PuZuqpeyfCAYrR0UbOXwydKQdz4S3PJHIFJ/viESSkokiqOp6sFh7uE5KZUQPbtp
bV069rZ7oE+nWgzTLIRJzWu6P8/jZ85PJ3k+qJ0hod1q0W9BON/WQJbqE6RsDvN9
Wuy/aUKVZNClY1kSRuQ0c/BoGijynyoc7HNsDxKVw8iPUApQeJVxGxH2gBQ2syGX
xxVujC+EZXguh/yNKsAgy7TusChDYrd/kfPZpuXlA/NnLqfDcO6te4++6NiXePzp
JxobVAOorXtBr6DJ+nL/IUDOfKP8Kw==
=oQW0
-----END PGP SIGNATURE-----

--esqz4aktzsx7daht--

