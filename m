Return-Path: <linux-can+bounces-2336-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2149E3923
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 12:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6274A282473
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 11:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4A71AE863;
	Wed,  4 Dec 2024 11:44:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9B1B4138
	for <linux-can@vger.kernel.org>; Wed,  4 Dec 2024 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312660; cv=none; b=nsMCxT/KcZ1I7iMhsqvOX0gGLMuW5ftGlvM0L2LaFGlnQNStZmX7599l4mWeBQ2AIJMkZ5yn/K6ND2U56x3JgPeHeI0danmkBmqZTAQ81HZttK8GkC5JkCNwnAk3UHkYpSujkLf6+lQ4HnwMJq1oWw8rr0aeIAnkiOSnyJfHQP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312660; c=relaxed/simple;
	bh=RxZZ5atRDlQdSKOx8aXoxGjx/Dqnut4cXinqF8hpOho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJDCphmSDDAM9Zj/mpxZpBWorlA0D1vBM+gRdK93wOSSJaYQ5t64tKYwAOVKRwUD3acKYeJZCAXY3pCeLhexO+ctVW8zsRUraDEneqfmOSfhf/DhrYZOmvAaLunxZl+U38I2JbqoE8RJ2GSHXA067O9b/LrtXEdiHdQcwF5SkuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tInni-00056k-Ub; Wed, 04 Dec 2024 12:44:14 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tInnh-001drj-2d;
	Wed, 04 Dec 2024 12:44:14 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3C5C338564E;
	Wed, 04 Dec 2024 11:44:14 +0000 (UTC)
Date: Wed, 4 Dec 2024 12:44:13 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, Robert Nawrath <mbro1689@gmail.com>
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
Message-ID: <20241204-mauve-asp-of-fortitude-e75174-mkl@pengutronix.de>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <20241110155902.72807-28-mailhol.vincent@wanadoo.fr>
 <20241112-flashy-straight-poodle-9a796d-mkl@pengutronix.de>
 <CAMZ6RqKQLaEtgoLOAa3NHJotyHcAo=7ObXf=7tLh_DJ_QTCKOg@mail.gmail.com>
 <36b1f1cb-c431-43ad-be49-5093a3534b9d@hartkopp.net>
 <20241204-nippy-vivid-mantis-ee1725-mkl@pengutronix.de>
 <8d1cd5de-ae84-455d-8636-7f269bbfe7db@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i5xs7hbjsixnykdc"
Content-Disposition: inline
In-Reply-To: <8d1cd5de-ae84-455d-8636-7f269bbfe7db@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--i5xs7hbjsixnykdc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
MIME-Version: 1.0

On 04.12.2024 12:35:43, Oliver Hartkopp wrote:
> > > > Also, the main reason for not creating the nest was that I thought
> > > > that the current bittiming API was stable. I was not aware of the
> > > > current flaw on how to divide tseg1_min. Maybe we should first disc=
uss
> > > > how to solve this issue for CAN FD?
> > >=20
> > > I like the current way how you added the CAN XL support.
> > > It maintains the known usage pattern - and the way how CAN XL bit tim=
ings
> > > are defined is identical to CAN FD (including TDC).
> > >=20
> > > Is the separation of propseg and tseg1 that relevant?
> > > Does it really need to be exposed to the user?
> >=20
> > There are IIRC at least 2 CAN-FD cores where the prop segment and phase
> > segment 1 for the data bit timing have not the same width. This means we
> > have to change the bittiming_const in the kernel.
> >=20
> > A struct in netlink means we cannot change it.
>=20
> But are we not already in this situation with CAN FD that we can not chan=
ge
> the bittiming (const) in the userspace API?

Yes, we have to support it. But we can add a new nested type that
serializes the individual members of an improved struct bittiming_const.
The old user space tools will just keep working, iproute2 can be updated
to use the new bittiming_const if it's available and fall back to the
existing one.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--i5xs7hbjsixnykdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdQQIoACgkQKDiiPnot
vG9XxAgAkeyRVYrNfK3/0ezUl3kIlQpIxRF/CFphFypnKBj2FCVj7J5caLo6MFkL
gISp0Txd93EnYO+hkzsMcVF4sWaA9wb/vstLNHJTBL528VOlpuKYHQO/Pz6Zzlvx
Cxiu21PmQTe8elDQJ6mEXCNs60jxyy8ud2oNH2rZO8nXBNrI+FnREODMTqSPRoLj
Ka+j0LwdK7oPvx9TMjgFl7KOvG5pELD56md1JS0DxNNe2BzgioQArwKnzUGYAmS+
pvWLsUoHnlLACnI8TcxUs/tVLhl/v+Zr2K+xXAaQQ+sON4iy2RqTca+eY5oQ4Dac
ndL/r2fdgmUSMNNL3sORCz1ErnyMjQ==
=+hOP
-----END PGP SIGNATURE-----

--i5xs7hbjsixnykdc--

