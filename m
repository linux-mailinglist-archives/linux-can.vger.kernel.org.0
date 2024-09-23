Return-Path: <linux-can+bounces-1534-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E24097E9CB
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 12:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DC01C20403
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72B51974F4;
	Mon, 23 Sep 2024 10:18:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA719580F
	for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086687; cv=none; b=amSe+/FeciX4A/FkD+1PDWhi+o1ljoK/tnjo30DyXil+lPMc+FU/9/xNrLP99vp/BXSbIJzayMrOPvmWxlMat9voK1SQDKaomLKtgSoeMNiwUNBUA39GpQBRQP6PK1x3JDDW8htrnAP/jZy8heVAkpZIge4gOExboSmuEywalJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086687; c=relaxed/simple;
	bh=fnGOKInTAhOp+GV97i2VYgezakm03+dQugDqppd1DkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBDv1KcCeqyVewQYyvTW+OfIobtjvjEUeyomyru/ckVCLInTBfefzR756ghpM+GhYeesn0Ip4c6aSWW4aUvIUCGaGvUrC64epVK1h0RaqgOo12L+aNqeoO36zlCtwBygctYzmzhF+kTAJEL4hnxAZBjBijPu/1wsIp9dsOx68B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssg8U-0001YE-Gs; Mon, 23 Sep 2024 12:17:42 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1ssg8S-000vzX-7C; Mon, 23 Sep 2024 12:17:40 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0D78C341059;
	Mon, 23 Sep 2024 10:17:38 +0000 (UTC)
Date: Mon, 23 Sep 2024 12:17:38 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, "Felipe Balbi (Intel)" <balbi@kernel.org>, 
	Raymond Tan <raymond.tan@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com, lst@pengutronix.de
Subject: Re: [PATCH v2 2/2] can: m_can: fix missed interrupts with m_can_pci
Message-ID: <20240923-honored-ant-of-ecstasy-f7edae-mkl@pengutronix.de>
References: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726745009.git.matthias.schiffer@ew.tq-group.com>
 <861164dfe6d95fd69ab2f82528306db6be94351a.1726745009.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ekqu47z3b5kakgtd"
Content-Disposition: inline
In-Reply-To: <861164dfe6d95fd69ab2f82528306db6be94351a.1726745009.git.matthias.schiffer@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ekqu47z3b5kakgtd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.09.2024 13:27:28, Matthias Schiffer wrote:
> The interrupt line of PCI devices is interpreted as edge-triggered,
> however the interrupt signal of the m_can controller integrated in Intel
> Elkhart Lake CPUs appears to be generated level-triggered.
>=20
> Consider the following sequence of events:
>=20
> - IR register is read, interrupt X is set
> - A new interrupt Y is triggered in the m_can controller
> - IR register is written to acknowledge interrupt X. Y remains set in IR
>=20
> As at no point in this sequence no interrupt flag is set in IR, the
> m_can interrupt line will never become deasserted, and no edge will ever
> be observed to trigger another run of the ISR. This was observed to
> result in the TX queue of the EHL m_can to get stuck under high load,
> because frames were queued to the hardware in m_can_start_xmit(), but
> m_can_finish_tx() was never run to account for their successful
> transmission.
>=20
> To fix the issue, repeatedly read and acknowledge interrupts at the
> start of the ISR until no interrupt flags are set, so the next incoming
> interrupt will also result in an edge on the interrupt line.
>=20
> Fixes: cab7ffc0324f ("can: m_can: add PCI glue driver for Intel Elkhart L=
ake")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

My coworker Lucas pointed me to:

| https://wiki.linuxfoundation.org/networking/napi#non-level_sensitive_irqs

On the other hand, I would also like to convert the !peripteral part of
the driver to rx-offload. However, I am still looking for potential
customers for this task. I have talked to some TI and ST people at LPC,
maybe they are interested.

I think let's first fix edge sensitive IRQs, then rework the driver to
rx-offload.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ekqu47z3b5kakgtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbxQD4ACgkQKDiiPnot
vG/y8Qf/QkdsR/kI8NBZPDV69bGXrC6yCjLd8PUWOuSqWxNBzXAxlQq9cU3HTYCz
k3QUmftS1Jx2WuyrjLISVpUs14eJVHeckU7lVuyAYxMy6sCE5H1JeaiifS/0YQOV
dZcalCoLBt+Z9GI9vWtddEluP4YhTI7vehVjzg9jBGOAn3WoIGadyLr/6pMoxHXs
cqzJLy/7oN28HcVL9RtxHpOOpCE5yVJp2FV/axKFQ7NlIfMxP2Lqiebm4MkDXsBb
huS0eCO/pOhjbzdQGw7BGA4Ct5p2UwhLceTihU52EO0VcLUxaym22Fbb1/reXx7e
T21qCnN1F67cDBzG99z5qH8JKEGpAA==
=I1Nn
-----END PGP SIGNATURE-----

--ekqu47z3b5kakgtd--

