Return-Path: <linux-can+bounces-1535-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BAD97E9EE
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 12:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582CD1C2109B
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4EE6D1B4;
	Mon, 23 Sep 2024 10:30:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A24194ACF
	for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727087434; cv=none; b=MWStPBwevu8OMjLx7ru/SxinIWI2Wlru5x2rS6rh1ZDE/DSpu4NYwRK8YcvYo3KGoqV933JR8GDv7QLsb6AJfmnxZ8iE5emFo/IL17/tlIGvPaqomnnsmrbrgRmGLJW/aM+i38SkBgXGdU19kPx0gOV00flNW6QKUSdptrD2gAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727087434; c=relaxed/simple;
	bh=8dZsC/z1fMQbYexIgLc8zjH4UGq8HP65+IHViLScZqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3fozD8IE7vB8F/tDYVFg9PrBe/MhrK8661MH1zAnxQ8DKVOj6HuJGopewpfHzJVdQd/UaY7wHMSXqEh07bcCtr0+YcL2og6P/M4jmys3tSQ/sb4Foxe+SjuvFct421jmXdIWUdPAPk1dficdARpS+wlJb1Qz1GD3SsFpPtPCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssgKf-0003Dz-5x; Mon, 23 Sep 2024 12:30:17 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssgKc-000w1m-JI; Mon, 23 Sep 2024 12:30:14 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 12E11341073;
	Mon, 23 Sep 2024 10:30:13 +0000 (UTC)
Date: Mon, 23 Sep 2024 12:30:12 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, "Felipe Balbi (Intel)" <balbi@kernel.org>, 
	Raymond Tan <raymond.tan@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 2/2] can: m_can: fix missed interrupts with m_can_pci
Message-ID: <20240923-tricky-bird-of-symmetry-68519b-mkl@pengutronix.de>
References: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726745009.git.matthias.schiffer@ew.tq-group.com>
 <861164dfe6d95fd69ab2f82528306db6be94351a.1726745009.git.matthias.schiffer@ew.tq-group.com>
 <lfxoixj52ip25ys5ndhsn4jhoruucpavstwvwzygsvkmld2vxw@d7yiwmz3jb4y>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3svslzepdnjbffwt"
Content-Disposition: inline
In-Reply-To: <lfxoixj52ip25ys5ndhsn4jhoruucpavstwvwzygsvkmld2vxw@d7yiwmz3jb4y>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--3svslzepdnjbffwt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.09.2024 10:03:24, Markus Schneider-Pargmann wrote:
> Hi Matthias,
>=20
> On Thu, Sep 19, 2024 at 01:27:28PM GMT, Matthias Schiffer wrote:
> > The interrupt line of PCI devices is interpreted as edge-triggered,
> > however the interrupt signal of the m_can controller integrated in Intel
>=20
> I have a similar patch though for a different setup (I didn't send it
> yet). I have a tcan chip wired to a pin that is only capable of edge
> interrupts.

Can you post your patch for completeness?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3svslzepdnjbffwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbxQzEACgkQKDiiPnot
vG8YNgf/U9xHuZQm+cUJbDUWXlcxzuK1BbWiMAxbnuxl9I8ImpAasQ/9enhn4R0V
/mf8yhBfFBRYjKyOGn3LVxiPGAgzvGAMYLb9EE+38AVRAFyMxo9dSB6Vmq8SjuRm
zPpq6hu9NQS58ESmZnMxP28BPOv/DjG84l7UmFNEKpggS0BgAKpqu9uUczv2TrmG
+tphZrazuNXew2JodXhLRrANFs2YyEymBWYwmq2kjiZ9/Md2jw1C+YEKqJ+x0ZBd
R79vJQ5YZ30wQajHI+uBFG2XyJo56spI2e2x8PoccURmLY0ojyVytgzNZxRM4ghS
JfJ3mW5O1lHvfLzyXcHDrEjPuSPSoQ==
=9KL2
-----END PGP SIGNATURE-----

--3svslzepdnjbffwt--

