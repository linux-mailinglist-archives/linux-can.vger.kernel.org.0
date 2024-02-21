Return-Path: <linux-can+bounces-337-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4AE85D83E
	for <lists+linux-can@lfdr.de>; Wed, 21 Feb 2024 13:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122BA1F229B1
	for <lists+linux-can@lfdr.de>; Wed, 21 Feb 2024 12:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EDB4F88B;
	Wed, 21 Feb 2024 12:49:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C53C493
	for <linux-can@vger.kernel.org>; Wed, 21 Feb 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519778; cv=none; b=s+nMAn5KjOHZOIQ4xjTrH5J/YiLs7Cuu47SNH4OMR7SiHiycH6AV0xPnzMZxZ5j7PMxMjujjEHatYe73/sHk8dTP91peTlyJ5TTEwmpW9Ph3ouXf/x8cGwQu3c8BRXESj57j0lACeU3fNLTkW036XCJVv3BBbCH+5qpeQdDOy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519778; c=relaxed/simple;
	bh=XBm4TaRLRz4XuYV7Qs5odTcANtQ/W+o7MC8oDHfmzgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCC/n3Ww1I8dk0mvDa6IpQeS4Mp29EHJsEApj2qsRnSGaDT5HrwSYNq+9hsqCDPDyFu7pxb6fS4KVcmTIL38SuVfH4CDwxH8iEGfnRnNwKfjUF46V93hijlooo9dplT0oDHhAbghgYH5pFiabrJ5SH2zaqrjPJZaFYeByy75fbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcm2W-0004fN-Qa; Wed, 21 Feb 2024 13:49:32 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcm2V-0022jS-QS; Wed, 21 Feb 2024 13:49:31 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 76237294A94;
	Wed, 21 Feb 2024 12:49:31 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:49:31 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org, 
	Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [virtio-comment] [RFC PATCH v3] virtio-can: Device specification.
Message-ID: <20240221-acts-decade-76d3d69e8e4d-mkl@pengutronix.de>
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
 <ZdXShopKyMYPTUva@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n6fbgss6kbbxpo54"
Content-Disposition: inline
In-Reply-To: <ZdXShopKyMYPTUva@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--n6fbgss6kbbxpo54
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.02.2024 11:37:58, Matias Ezequiel Vara Larsen wrote:
> > > +The length of the \field{sdu} is determined by the \field{length}.
> > > +
> > > +The type of a CAN message identifier is determined by \field{flags}.=
 The
> > > +3 most significant bits of \field{can_id} do not bear the information
> > > +about the type of the CAN message identifier and are 0.
> > > +
> > > +The device MUST reject any CAN frame type for which support has not =
been
> > > +negotiated with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST =
NOT
> > > +schedule the message for transmission. A CAN frame with an undefined=
 bit
> > > +set in \field{flags} is treated like a CAN frame for which support h=
as
> > > +not been negotiated.
> > > +
> > > +The device MUST reject any CAN frame for which \field{can_id} or
> > > +\field{sdu} length are out of range or the CAN controller is in an
> > > +invalid state with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MU=
ST
> > > +NOT schedule the message for transmission.
> > > +
> I am not very familiar with CAN but how does the device figure out that
> the can_id is out of range?

In classical CAN we have the standard CAN frames, which have an 11 bit
ID, and there are extended CAN frames, which have 29 bits ID. Extended
frames are signaled with VIRTIO_CAN_FLAGS_EXTENDED set.

So if a standard frame uses more than 11 Bits of CAN-ID, it's considered
out of range.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--n6fbgss6kbbxpo54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXV8VgACgkQKDiiPnot
vG9Dfwf/fB9BsfKlNrhf0m0/Ym50ssSYlC9p4UdBqBli+D4CQQbFhKXuJIc5pbsF
cxMDyo3aayKdXskeVJWiBys8wBI52EY/gRFuwM/OuBLsaN3WS+nLVrINT+EniPHn
mu1yPVoYWPfFjQKi3sPZkQUluJ8O1KUbL3m77jUVPJ93SAoQM6nQrIwsQvPIg7Ct
gsmpD1UruWsbNGWzvPK6BoQ+tNfYkCcuMwn5y6BUyOX2GFAQhaDaqRjATyjlfJDC
DbytEO1tE0lWW+Z1UxaTamF0r7hLIcNKmEP5gD5J+qSCE60NOotPcgbimBJ973Aq
8E8oGG6CFa5E5oyEam1M4qulavwknQ==
=SERR
-----END PGP SIGNATURE-----

--n6fbgss6kbbxpo54--

