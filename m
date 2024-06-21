Return-Path: <linux-can+bounces-833-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350F0911F2F
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6606C1C22480
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAE982D89;
	Fri, 21 Jun 2024 08:46:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7016D4E8
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959594; cv=none; b=s1L/L4bOGxDSJUXxN8eBz4dnJm0urpVDOuXBSOhGfGh5K8nxtbKOLctl91VzX898/PA9xnQQl25ik4nXhgLBqxI/iCBXEoVuWDVzXljSK705EOdoWDZbAhTlicSAuunIQ801UQHi4yJPembFSmZEgsYeCZUsjA+NvXML7we5x+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959594; c=relaxed/simple;
	bh=JBA97vHqUcrYOqs1UJsb2QIBrtsaj8MberWuOGafYoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehVJBffvGI+11MNGj76pfMkzMNaj3MbL5TBX2+Xn3iMm6s/VpzzB2qBxGflfko9hHhkwbYl/4lSefeOvJAVOrGTyCGUxNL0a7cItHxc8bwtvKN/gtNe3Uf0X9SR0WaMjKyLDafRYWerfkrcFHP4JgwTNJUT0eckcV11ma4M1YlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZuZ-0001RS-G9; Fri, 21 Jun 2024 10:46:23 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZuY-003tx4-Ed; Fri, 21 Jun 2024 10:46:22 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 211C62EE5B2;
	Fri, 21 Jun 2024 08:46:22 +0000 (UTC)
Date: Fri, 21 Jun 2024 10:46:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vitor Soares <ivitro@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vitor Soares <vitor.soares@toradex.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6] can: mcp251xfd: fix infinite loop when xmit fails
Message-ID: <20240621-wise-thistle-hound-49a307-mkl@pengutronix.de>
References: <20240517134355.770777-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5dpitlhc7bwdsspr"
Content-Disposition: inline
In-Reply-To: <20240517134355.770777-1-ivitro@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--5dpitlhc7bwdsspr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.05.2024 14:43:55, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> When the mcp251xfd_start_xmit() function fails, the driver stops
> processing messages, and the interrupt routine does not return,
> running indefinitely even after killing the running application.
>=20
> Error messages:
> [  441.298819] mcp251xfd spi2.0 can0: ERROR in mcp251xfd_start_xmit: -16
> [  441.306498] mcp251xfd spi2.0 can0: Transmit Event FIFO buffer not empt=
y. (seq=3D0x000017c7, tef_tail=3D0x000017cf, tef_head=3D0x000017d0, tx_head=
=3D0x000017d3).
> ... and repeat forever.
>=20
> The issue can be triggered when multiple devices share the same
> SPI interface. And there is concurrent access to the bus.
>=20
> The problem occurs because tx_ring->head increments even if
> mcp251xfd_start_xmit() fails. Consequently, the driver skips one
> TX package while still expecting a response in
> mcp251xfd_handle_tefif_one().
>=20
> This patch resolves the issue by starting a workqueue to write
> the tx obj synchronously if err =3D -EBUSY. In case of another error,
> it decrements tx_ring->head, removes skb from the echo stack, and
> drops the message.
>=20
> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD =
SPI CAN")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

I've reworked the last sentence for a bit and applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5dpitlhc7bwdsspr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ1PdsACgkQKDiiPnot
vG/3Jwf/Q7/WWQa/V0JIjwsh++Q42TCZN2oOvdIDCEeKutISQF4MybxEk09tyNLy
8P2q4KyB1Vb1IG/pWNQQD3TWs/05UcYEzxUSx6ciiGlzf6cyCra8CDmtLegxWOcW
IAwTuXv6bBK7H1Hhpy8Bx6pOpYoQUuJ2DSuqMcdUoLDctm6mvhpWugICpxZEY5FG
AsUwLGpwg+PXV/2UE0ivdwfvEb7/P4iJVbiaQgg80550rLaE1zGSTaOoaY+N/OWM
5kU63kScoE1veTrCR1QPAxWOMLWl+EoVkrSTHaCC8Qcp/L0MwPBilsQV5sJf+uv5
eFH428lDYCgthJkveWj8tOiOaHaMDA==
=AosI
-----END PGP SIGNATURE-----

--5dpitlhc7bwdsspr--

