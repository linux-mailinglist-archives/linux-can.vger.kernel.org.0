Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E7B2B8E76
	for <lists+linux-can@lfdr.de>; Thu, 19 Nov 2020 10:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgKSJMi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Nov 2020 04:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgKSJMi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Nov 2020 04:12:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F3BC0613CF
        for <linux-can@vger.kernel.org>; Thu, 19 Nov 2020 01:12:38 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kffzY-00070r-MF; Thu, 19 Nov 2020 10:12:36 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:d2a0:42c2:7db3:b10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A24CD595FBB;
        Thu, 19 Nov 2020 09:12:35 +0000 (UTC)
Date:   Thu, 19 Nov 2020 10:12:33 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr
Subject: Re: [PATCH net-next v2] can: gw: support modification of Classical
 CAN DLCs
Message-ID: <20201119091233.p4rsay26gta6tb74@hardanger.blackshift.org>
References: <20201119084921.2621-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5mq5oxy3q6kpcv3h"
Content-Disposition: inline
In-Reply-To: <20201119084921.2621-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--5mq5oxy3q6kpcv3h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2020 at 09:49:21AM +0100, Oliver Hartkopp wrote:
> Add support for data length code modifications for Classical CAN.
>=20
> The netlink configuration interface always allowed to pass any value
> that fits into a byte, therefore only the modification process had to be
> extended to handle the raw DLC represenation of Classical CAN frames.
>=20
> When a DLC value from 0 .. F is provided for Classical CAN frame
> modifications the 'len' value is modified as-is with the exception that
> potentially existing 9 .. F DLC values in the len8_dlc element are moved
> to the 'len' element for the modification operation by mod_retrieve_ccdlc=
().
>=20
> After the modification the Classical CAN frame DLC information is brought
> back into the correct format by mod_store_ccdlc() which is filling 'len'
> and 'len8_dlc' accordingly.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> ---
> v2: remove unnecessary mod_retrieve_ccdlc() for 'set' modification

Added to linux-can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5mq5oxy3q6kpcv3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+2Nv8ACgkQqclaivrt
76nZmAgAqQ+0SaJHZLh0bx0kNu0y4k4ZW5/lhmoyPNXAFBTKNZPrIsZZOcy0ehXI
5k1RGwsmls5h76/RwyHvsDRwsP8y4uyxPo59MVwqaJuVRKJa/GGpXCQYdCYNInrG
BfjgvPbY0EtyF6jQ0QIpexhTQQpkhg4dONhggGNGtWp0NTiErqM5g92Dkw99Xoid
0oX49NkR1fRPhNDKnsElv+XgGsJ0Qa0RI5GIy1exXekGzDIaLdtvoow+oUoI0a7C
oZBKmORFb3NDDIV2GUWtiw0d9ZUCVJVGWouIP/ixFzKMJNitSS81vtKE58NLmsZS
bUq8Qysq4wzDP2x7giCqv/zJ/Jl4yA==
=wC6b
-----END PGP SIGNATURE-----

--5mq5oxy3q6kpcv3h--
