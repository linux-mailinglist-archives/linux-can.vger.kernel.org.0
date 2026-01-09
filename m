Return-Path: <linux-can+bounces-6060-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9431D08335
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 10:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45BBF3010073
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 09:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0807323C4F3;
	Fri,  9 Jan 2026 09:29:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578493590CF
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767950993; cv=none; b=NOvi0qLGwH66koj7YPzRbjkSugr8KuFhDrs12Z+9RD/akob/mBOL1/gIphlvsXXnwfx6D0gHxSDVfWSxCQTbZgeXSLAFcPiMFJiYewx9DA7yxg9XSH1iyHGE6COPd02f8cq4wPBKrja821Jexnk8i7Gi7v2RGJCyXS4JdXQDnOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767950993; c=relaxed/simple;
	bh=jGN7WQMTJxcRXWa1jHVB+YIWtTRRJlVT37rx86C0LWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WshJ8gsLitBzBBtFwrdnC4wJVxYhpVCaTK6jvKHicEIqGzGksnQ26p2+5SaZmM/kDQOIY13uDOuJrqDETmYIPujrbKhbdod5fDzLJiB+EyCSKbv+pEyl7VGYsHHaghprPv34FgLjPuUZISDFJcxMVye5bmBjrEg7Oqr0kQO0XXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ve8oQ-0005bE-8S; Fri, 09 Jan 2026 10:29:42 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ve8oO-009p19-1l;
	Fri, 09 Jan 2026 10:29:40 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B9F994C96AE;
	Fri, 09 Jan 2026 09:29:39 +0000 (UTC)
Date: Fri, 9 Jan 2026 10:29:39 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Pavel Pisa <pisa@fel.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>, 
	linux-can@vger.kernel.org, David Laight <david.laight.linux@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Andrea Daoud <andreadaoud6@gmail.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Jiri Novak <jnovak@fel.cvut.cz>
Subject: Re: [PATCH v2] can: ctucanfd: fix SSP_SRC in cases when bit-rate is
 higher than 1 MBit.
Message-ID: <20260109-robust-clay-falcon-2f3ecb-mkl@pengutronix.de>
References: <20260105111620.16580-1-pisa@fel.cvut.cz>
 <c5851986-837b-4ffb-9bf7-3131cf9c05d1@kernel.org>
 <202601060153.21682.pisa@fel.cvut.cz>
 <c3dd8234-3a7e-4277-89cf-1f4ccb2c0317@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kajmwe2ui45oud4a"
Content-Disposition: inline
In-Reply-To: <c3dd8234-3a7e-4277-89cf-1f4ccb2c0317@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kajmwe2ui45oud4a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: ctucanfd: fix SSP_SRC in cases when bit-rate is
 higher than 1 MBit.
MIME-Version: 1.0

On 06.01.2026 23:14:47, Vincent Mailhol wrote:
> > thanks for pointing to Transmission Delay Compensation
> > related code introduced in 5.16 kernel. I have noticed it
> > in the past but not considered it yet and I think
> > that we need minimal fixes to help users and
> > allow change to propagate into stable series now.

How to proceed. Take this fix now an (hopefully) port to the mainline
TDC framework later?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kajmwe2ui45oud4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlgyn8ACgkQDHRl3/mQ
kZygXAf+J3b58p/qaUtzbNEkN8F9XjMhCuAi5+c1PYcGxm5N5dRA/0AREiS3t7j2
QTNGx6hhmNJDjYg10ok03pYObngeGoXiMW57tJzPrz4MY2JySCNOfkR9pIC1obpw
/m/CJt+X1FJjIYStMGDlEkokYn47Q/IAqQiVvGI2h18eSTSuH5A/HG7LMkEVyWdy
tInItu5z3TLhRFH2Go8f9fpJDALd/SB+0Bx0zNwKlwNybD9gY0+c08dBMnUPN2ZR
J6lVv51fUtuw7qb7hT8jVzJLn6ZWZtp0gfGOFO59TvAfMGN5moE4JIObVqBUURpF
cSsCDXbjx+9bHXQg/5FOA7POvG8Tvw==
=Yt5B
-----END PGP SIGNATURE-----

--kajmwe2ui45oud4a--

