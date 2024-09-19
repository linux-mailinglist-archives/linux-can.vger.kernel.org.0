Return-Path: <linux-can+bounces-1511-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3510697C62A
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2024 10:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1311C210E4
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2024 08:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72D91991D4;
	Thu, 19 Sep 2024 08:47:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0911922DF
	for <linux-can@vger.kernel.org>; Thu, 19 Sep 2024 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735663; cv=none; b=tnzecKYPCet8aNC+Ee46e6Qu4IMb7eXh1NwQAMx9x3N0tu+Sf1EAVIPkI6YSwyxZ2hY0k0bdqWJ+GqsFFRUvljLL+ciWspuPniGkmRII0RA0MYHihCCCHXaLC572tw/pmw8j1aLegED/Patn/phhiRZlK6u+cTkz6PUW3SPibQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735663; c=relaxed/simple;
	bh=TnRMX5yJakpY8P+dQ6zqeHJ/lVmJygHLklt+pllkci0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6iI6j1DDdrrznoZWoIiPQvTYTJ8MuFtIhm2AdFvOZI0wQFdfSbS8bs5GM+/ZpG9kFqw57cibdziaBZf1eMm+aTLrCBBx67Fn/zm4m1FuymW1vot9GsOYfR/HYB4yXapLrjRnzHmK9A96TCJ5Sl8wuGKiw/84JXYepUZgUNr6u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1srCoh-0006Y7-9E; Thu, 19 Sep 2024 10:47:11 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1srCod-0090ny-RA; Thu, 19 Sep 2024 10:47:07 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 38DD733F566;
	Thu, 19 Sep 2024 08:47:07 +0000 (UTC)
Date: Thu, 19 Sep 2024 10:47:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, "Felipe Balbi (Intel)" <balbi@kernel.org>, 
	Raymond Tan <raymond.tan@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com
Subject: Re: [PATCH 2/2] can: m_can: fix missed interrupts with m_can_pci
Message-ID: <20240919-tourmaline-jaguar-of-reverence-4875d2-mkl@pengutronix.de>
References: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726669005.git.matthias.schiffer@ew.tq-group.com>
 <f6155510fbea33b0e18030a147b87c04395f7394.1726669005.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="znxmzativoaydeg7"
Content-Disposition: inline
In-Reply-To: <f6155510fbea33b0e18030a147b87c04395f7394.1726669005.git.matthias.schiffer@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--znxmzativoaydeg7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.09.2024 16:21:54, Matthias Schiffer wrote:
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
> ---
>  drivers/net/can/m_can/m_can.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 47481afb9add3..363732517c3c5 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1207,20 +1207,28 @@ static void m_can_coalescing_update(struct m_can_=
classdev *cdev, u32 ir)
>  static int m_can_interrupt_handler(struct m_can_classdev *cdev)
>  {
>  	struct net_device *dev =3D cdev->net;
> -	u32 ir;
> +	u32 ir =3D 0, ir_read;
>  	int ret;
> =20
>  	if (pm_runtime_suspended(cdev->dev))
>  		return IRQ_NONE;
> =20
> -	ir =3D m_can_read(cdev, M_CAN_IR);
> +	/* For m_can_pci, the interrupt line is interpreted as edge-triggered,
> +	 * but the m_can controller generates them as level-triggered. We must
> +	 * observe that IR is 0 at least once to be sure that the next
> +	 * interrupt will generate an edge.
> +	 */
> +	while ((ir_read =3D m_can_read(cdev, M_CAN_IR)) !=3D 0) {
> +		ir |=3D ir_read;
> +
> +		/* ACK all irqs */
> +		m_can_write(cdev, M_CAN_IR, ir);
> +	}

This probably causes a measurable overhead on peripheral devices, think
about limiting this to !peripheral devices or introduce a new quirk that
is only set for the PCI devices.

Marc

> +
>  	m_can_coalescing_update(cdev, ir);
>  	if (!ir)
>  		return IRQ_NONE;
> =20
> -	/* ACK all irqs */
> -	m_can_write(cdev, M_CAN_IR, ir);
> -
>  	if (cdev->ops->clear_interrupts)
>  		cdev->ops->clear_interrupts(cdev);
> =20
> --=20
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> https://www.tq-group.com/
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--znxmzativoaydeg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbr5QcACgkQKDiiPnot
vG+OZwf/c88bKRbuevnUCUCzn6Eot1L8rix8rbMXHOwiY50+e07UK+ux/Z50J94y
1xBVkCAD1MZu9/ftH13Ye/gWrMlBv49LzDScetl0vZy7A+kbmg3/+l3wGTqo3zQS
NUqSxKlzFZP8b7vDPOjm/HxrAhx4WQbf28BcrcQ/AQA26+EH/nq6Z1agJBUV0s14
3vOi0zwIm/plTKxEBR5Mu+4RUofHWa7wwwopDuQcgGEzWaBwr1Zxfe/sllmGcxQw
Nd+Gs7XXYKQETfkHJ49bqYq8gxFwFztZBjAyfenuCOYQG0W21pxQn6EyAB05VTmC
6VevDqOIWuvRdNdCaUVoEPXdnNl7eg==
=iUnT
-----END PGP SIGNATURE-----

--znxmzativoaydeg7--

