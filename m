Return-Path: <linux-can+bounces-2356-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77CC9E9BFC
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2024 17:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F301625C0
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2024 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BAA145B18;
	Mon,  9 Dec 2024 16:43:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C95142E6F
	for <linux-can@vger.kernel.org>; Mon,  9 Dec 2024 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762604; cv=none; b=usV+qrmqvWJqPMnJtukbcKHhujKghXwvjOAtWX/JjLD7HvOUasUCWK2nfjSxJ9JNvjmxSnwzATBhIpJig/G7vU0JhiMRRtmfNcFJ1NllpIXD/PTG9c/T6WLo+1p66nY3hIQ6CDEXSP+Ed6JU3tscZUdC8ODLOnVWGJuCmCW8C+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762604; c=relaxed/simple;
	bh=Ve3+6QZYxnpV995EYuHauNiqyLGm6tJyq8MPibx8DJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H539sQUnekkMu8MAL9rLNfgWUfXJZzMkQ7/GISPh3x1wlpZG077qpTMbVYSUywk7RlzFBgcdqe5LFobB/0C34YE7EvMXlFULa0RbF63hNI3iKYGKnhmFQ68Se4IQI8iMIZr3LFz2RvE8Qe+6ZGFMFyFZrTlkTE8rj2RBcfRjBXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKgqs-0005pF-BZ; Mon, 09 Dec 2024 17:43:18 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKgqq-002Xvc-34;
	Mon, 09 Dec 2024 17:43:17 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 63AAE389D46;
	Mon, 09 Dec 2024 16:43:17 +0000 (UTC)
Date: Mon, 9 Dec 2024 17:43:17 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefano Offredi <stefano.offredi@gmail.com>
Cc: linux-can@vger.kernel.org, 
	Stefano Offredi <stefano.offredi@daosgroup.it>
Subject: Re: ACPI compatible mcp251xfd driver
Message-ID: <20241209-quiet-steady-rottweiler-976abf-mkl@pengutronix.de>
References: <CA+VHkVF89EZOtnqWFGfS4JFtuLdkX2uJNwY7vicJ=i3RiZtbZw@mail.gmail.com>
 <20241202-organic-caracal-of-skill-4faeac-mkl@pengutronix.de>
 <CA+VHkVHhE5tT6D60MJadVvJ1nvM9gK2kMmZYD_MRP6iJF89pYg@mail.gmail.com>
 <20241203-frisky-badger-of-fury-8c68c2-mkl@pengutronix.de>
 <CAOv6HECSnL-pqo9e9i-_90LHzipcz+Q7e7J+H=ZA8c8rtQUTEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dljpqbhfh7lzeqfw"
Content-Disposition: inline
In-Reply-To: <CAOv6HECSnL-pqo9e9i-_90LHzipcz+Q7e7J+H=ZA8c8rtQUTEA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--dljpqbhfh7lzeqfw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: ACPI compatible mcp251xfd driver
MIME-Version: 1.0

On 09.12.2024 17:01:42, Stefano Offredi wrote:
> Hi Marc,
> > Can you share the modifications with us?
>=20
> Yes, Now I will send the patch I have done and tested on kernel
> version 5.15 that  I have on my SOM.
>=20
> > > Now I'm dealing with a problem in bringing UP the can0 interface with:
> > > ip link set can0 type can bitrate 1000000
> > > ip link set up can0
> > > RTNETLINK answers: Invalid argument
> > > ..I'm debugging it.
> >
> > anything of interest in demsg?
> >
>=20
> yes at the end it was a problem with my rx-int gpio, that was handled
> not directly by intel chip, but with a gpio controller in the middle.
> Now I'm able to bring the can0 interface UP.

The RX-int GPIO is purely optional.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dljpqbhfh7lzeqfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdXHiEACgkQKDiiPnot
vG/ZSgf8Cb7TI+PQFcP0BtaS9c4IEgnNBoixpgVRIcULIc3aRvArg8akJCkefR5C
9up6lI/ltG3S5xOdt8D0CnTwqQCtlfyi/ae1RbxWg10rFhIjL+gz1t2XZ/jLvlUy
ipBVVXVbEU71gcV5Dx+ggEqrbmrWcrKFyIhujx2Tz1GALWUzxEhqfevpSJzs6s7z
KVyvi4uBCwcNsP9mUiFNWdDE8kjaCmLl/CRj2cgubrw5fedAC5P/u3AzUrdwMBTz
130wEXiQJqg7YKvIh8sBgpZLUC5XAjTCoBlTlDxQwNqucyR1vUUxqDz0xbSFzqWv
PzHaVerLdL9oRpc0H/SzQUxpu3D6nw==
=if7B
-----END PGP SIGNATURE-----

--dljpqbhfh7lzeqfw--

