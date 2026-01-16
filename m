Return-Path: <linux-can+bounces-6182-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F43D33B56
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 18:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37DB930EF61A
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 17:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA26C3A35C7;
	Fri, 16 Jan 2026 17:03:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1ED3A0B1E
	for <linux-can@vger.kernel.org>; Fri, 16 Jan 2026 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583027; cv=none; b=HrzAY7slmYcnPkUgvuR/57WZoAlcdPDXBk78UTy5RlI4C23aKjWYohbWPbiE1c2rP7SWN9RqFrhk/loXzwJB5cJDv73VCxP8J0fRSL8F9K87BcNrnGQJS0CyIUg3rK+HV+yPcH6h0L7KQ/1XY8ayeTtXm2AWjNnB0tKVVY+wvfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583027; c=relaxed/simple;
	bh=pCvU5B6xRDbFTTWcKdr7/y4qtL2V1ahEC7uL5GUdRlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s96TDiD9jWNZqhbif6Dkmlt1zSkc5VBy6FsKXMxxv3T0OY9SBq+kfmMtqbdjwpPn32JSZjigU2ixY+RkvtfICghSR8thei9wETBsWPBhje5OT7gbFfJPN939UzAC1iM7rnm85GqA3ilJdP7SpY7j7NaZCFic/MAhFQ11WXTExoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgnEa-0006D6-E8; Fri, 16 Jan 2026 18:03:40 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgnEa-000xLY-2u;
	Fri, 16 Jan 2026 18:03:40 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 05F9E4CED57;
	Fri, 16 Jan 2026 17:03:40 +0000 (UTC)
Date: Fri, 16 Jan 2026 18:03:39 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net 0/4] pull-request: can 2026-01-15
Message-ID: <20260116-romantic-hog-of-saturation-743692-mkl@pengutronix.de>
References: <20260115090603.1124860-1-mkl@pengutronix.de>
 <20260115185110.6c4de645@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ljgor4nyqorjel3l"
Content-Disposition: inline
In-Reply-To: <20260115185110.6c4de645@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ljgor4nyqorjel3l
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/4] pull-request: can 2026-01-15
MIME-Version: 1.0

On 15.01.2026 18:51:10, Jakub Kicinski wrote:
> Hi Marc!
>
> Was the AI wrong here
> https://lore.kernel.org/all/20260110223836.3890248-1-kuba@kernel.org/
> or that fix is still in the works?

AI was correct, the proposed fix was correct. The patch will be included
in my next PR:

| https://lore.kernel.org/all/20260116-can_usb-fix-reanchor-v1-1-9d74e72892=
25@pengutronix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ljgor4nyqorjel3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlqb2gACgkQDHRl3/mQ
kZwiyQgArjKmsyWOlZ1lFAKv0+dgW9PIPQqADsJ6p/vTztYrtJTryvrq8gLTBS9y
m47a4zEM9KvBqz7v3ORaAFhrE5+Xl9mf2IkgwzoyO5XlM8oWuZ/BZaE6ZmhUj0+k
Y6jy7A6Duj/khrwRMYRIDv1XKdRrj46YxhGJgj2SvCXV+v1TKLkXGV8GXdAxqLtO
7FPwLweU9YsGa8DZHnzkuHZ6t9lAELnSeNohDuGHeq6qZLddGawA8VnipocHcLg2
pG5YBa7bk1cheHG1hxIllo0O9MP8sw9Sa9/FxT1lS4D468elf2RPle5x3VDT0Mso
AseNCrvrgmMiyZiI2WqP4HMPgzRgUg==
=XeT4
-----END PGP SIGNATURE-----

--ljgor4nyqorjel3l--

