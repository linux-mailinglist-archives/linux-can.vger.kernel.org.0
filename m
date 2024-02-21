Return-Path: <linux-can+bounces-339-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE0F85DA74
	for <lists+linux-can@lfdr.de>; Wed, 21 Feb 2024 14:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16C428623E
	for <lists+linux-can@lfdr.de>; Wed, 21 Feb 2024 13:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D2E7EF0C;
	Wed, 21 Feb 2024 13:28:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A8D69D2E
	for <linux-can@vger.kernel.org>; Wed, 21 Feb 2024 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522095; cv=none; b=VDDE+b2D7BvudpIwT9wzGSrmmuIkr+heikO+6+HHYmWmL5Xgi2Je3HotJJj+3KY+XJVshrIj6UrNSWUuiPJYKHm+rvunmMHdYR7ruJMnWpiIBqn5R6w24O5YzoPvSzZ70W3rXsevV/67DwRPE1c2Br79tV4LXvSn3aWO1dXRVvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522095; c=relaxed/simple;
	bh=03bjJnGFugjklFVd7F0yF0Of3vNbzH7KF4fjzEHz8I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgo7uNwV0oQh5au7c0xVixylB0LbE7LD3ZMlr3ITPPKCAbUGNrYeIjn2pdhxvgjfFlLvJN/Ydbsaa9oG50vldASesZxUJaWDYiDmaRyjyy+WuKF7PTZXo93v/DyPeI4vmKAR2eFcW/GlwkPxuKi4CCjGta7KlG3zGY7Zr2hxIyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcmdv-0003dY-AO; Wed, 21 Feb 2024 14:28:11 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcmdu-00238Z-HC; Wed, 21 Feb 2024 14:28:10 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 32CBC294B12;
	Wed, 21 Feb 2024 13:28:10 +0000 (UTC)
Date: Wed, 21 Feb 2024 14:28:09 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org, 
	Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [virtio-dev] Re: [virtio-comment] [RFC PATCH v3] virtio-can:
 Device specification.
Message-ID: <20240221-juggling-uproar-9518b4901f41-mkl@pengutronix.de>
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
 <ZdXShopKyMYPTUva@fedora>
 <20240221-acts-decade-76d3d69e8e4d-mkl@pengutronix.de>
 <ZdX3xgM36iOVhr3V@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kvtavsos5g6wyacj"
Content-Disposition: inline
In-Reply-To: <ZdX3xgM36iOVhr3V@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kvtavsos5g6wyacj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.02.2024 14:16:54, Matias Ezequiel Vara Larsen wrote:
> On Wed, Feb 21, 2024 at 01:49:31PM +0100, Marc Kleine-Budde wrote:
> > On 21.02.2024 11:37:58, Matias Ezequiel Vara Larsen wrote:
> > > > > +The length of the \field{sdu} is determined by the \field{length=
}.
> > > > > +
> > > > > +The type of a CAN message identifier is determined by \field{fla=
gs}. The
> > > > > +3 most significant bits of \field{can_id} do not bear the inform=
ation
> > > > > +about the type of the CAN message identifier and are 0.
> > > > > +
> > > > > +The device MUST reject any CAN frame type for which support has =
not been
> > > > > +negotiated with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and M=
UST NOT
> > > > > +schedule the message for transmission. A CAN frame with an undef=
ined bit
> > > > > +set in \field{flags} is treated like a CAN frame for which suppo=
rt has
> > > > > +not been negotiated.
> > > > > +
> > > > > +The device MUST reject any CAN frame for which \field{can_id} or
> > > > > +\field{sdu} length are out of range or the CAN controller is in =
an
> > > > > +invalid state with VIRTIO_CAN_RESULT_NOT_OK in \field{result} an=
d MUST
> > > > > +NOT schedule the message for transmission.
> > > > > +
> > > I am not very familiar with CAN but how does the device figure out th=
at
> > > the can_id is out of range?
> >=20
> > In classical CAN we have the standard CAN frames, which have an 11 bit
> > ID, and there are extended CAN frames, which have 29 bits ID. Extended
> > frames are signaled with VIRTIO_CAN_FLAGS_EXTENDED set.
> >=20
> > So if a standard frame uses more than 11 Bits of CAN-ID, it's considered
> > out of range.

Another option would be an extended frame (VIRTIO_CAN_FLAGS_EXTENDED
set) and using more than 29 bits.

> Thanks Marc for the explanation. Do you think that it would be
> worthwhile to add that to the spec at some point?

Yes that makes sense as it clarifies what's meant by out of range for
CAN-IDs, for the valid length a reference to
\item[VIRTIO_CAN_F_CAN_CLASSIC (0)] and \item[VIRTIO_CAN_F_CAN_FD (1)]
might be added.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kvtavsos5g6wyacj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXV+mYACgkQKDiiPnot
vG+1gAf/bbPgj+CwAhBtLIyNrjsdOP99lOBPcCVZsU0cUwrKZPWaNzoCjqS/VGB3
qaul/sD23a1RhOGYrL3e5xNZJTAOYW1BFNzoa8IvUKu6J7J3ccZ0inNV+I97XcBi
fyMGpHIQRX/HuLVJYScH58/xbErWGnyDQbkR5YX4UhmfLfxH0Z2fCJcWXH5L1/on
ELByICVhXNG5J2NF7O0jnROcH1S4mTJKwHLkZf0DQp2rP12jT86/yTkJKIBJeUse
VN3WmkDJE6GAR50kZ4hFDChSBnMDvJSxN+dVFJhvdtTK8u0MXUjJ/ZUIb+yNPBVw
KHODp0wB1BzP2AKYYm1l2/qJCMiI5Q==
=l3gq
-----END PGP SIGNATURE-----

--kvtavsos5g6wyacj--

