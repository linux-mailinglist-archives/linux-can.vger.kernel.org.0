Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F04341904
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 10:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhCSJ6t (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 05:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhCSJ6j (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 05:58:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0F6C06174A
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 02:58:39 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lNBtt-0006s2-PG; Fri, 19 Mar 2021 10:58:37 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7ffa:65dd:d990:c71d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EE5F35FA758;
        Fri, 19 Mar 2021 09:58:36 +0000 (UTC)
Date:   Fri, 19 Mar 2021 10:58:36 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: isotp: tx-path: zero initialize outgoing CAN frames
Message-ID: <20210319095836.7ro3umpaanp5i5ix@pengutronix.de>
References: <20210318100233.1693-1-socketcan@hartkopp.net>
 <20210319082619.hssq4yhkjcxmtkqt@pengutronix.de>
 <06ac59af-faaa-e9a6-0b65-0f70ab2648c2@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ts25h2lptwhz67x3"
Content-Disposition: inline
In-Reply-To: <06ac59af-faaa-e9a6-0b65-0f70ab2648c2@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ts25h2lptwhz67x3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.03.2021 10:55:07, Oliver Hartkopp wrote:
> > What about skb_put_zero(), which I mentioned in my initial cover letter:
>=20
> Yes, that would indeed be more elegant. Will send a v2 patch.
>=20
> > > > Note here the "B" and "E" flags are set. Another possibility is to =
use
> > > > skb_put_zero() instead of skb_put(), but with a bigger overhead. A =
3.
> > > > option is to only memset() the non-data part of the struct canfd_fr=
ame.
> >=20
> > http://lore.kernel.org/r/20210218215434.1708249-1-mkl@pengutronix.de
>=20
> I modified candump in a way that it always prints the entire frame
> independent from can(fd)_frame::len
>=20
> diff --git a/candump.c b/candump.c
> index 7bb854a..9683fc9 100644
> --- a/candump.c
> +++ b/candump.c
> @@ -719,13 +719,13 @@ int main(int argc, char **argv)
>                                 perror("read");
>                                 return 1;
>                         }
>=20
>                         if ((size_t)nbytes =3D=3D CAN_MTU)
> -                               maxdlen =3D CAN_MAX_DLEN;
> +                               frame.len =3D maxdlen =3D CAN_MAX_DLEN;
>                         else if ((size_t)nbytes =3D=3D CANFD_MTU)
> -                               maxdlen =3D CANFD_MAX_DLEN;
> +                               frame.len =3D maxdlen =3D CANFD_MAX_DLEN;
>                         else {
>                                 fprintf(stderr, "read: incomplete CAN
> frame\n");
>                                 return 1;
>                         }
>=20
> And there you can see that in flow-control (FC) frames and consecutive
> frames (CF) especially at the end of the PDU you see uninitialized conten=
t.
>=20
> So it does not help to only clear the non-data part of the struct
> canfd_frame.

Makes sense, my emphasis was on skb_put_zero() instead of skb_put().

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ts25h2lptwhz67x3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBUdckACgkQqclaivrt
76lV/Af/Xytkp3TPReNZ9r/tanqrdTYJfv4mr8a/jJmcuvbzxvXgPapW+0/bPTdj
2eqqMow0qaOR+GB7u31TJuaDntgT7xodjZS7MBj4MEy0fkeD9e8zRm9EHrwHSpXo
L1D8Sc3kePSkmWVl1G49Ji0E63Ewf20vdcG927boPyNzxQFb3G6JL8uQejGSkviJ
tXIR3ta5i85n4Lpas2+bnCbPsxjV6zhLMHcsR7mhHHkQUU85nKV98GxGrT3m0qQc
8+jZG72Pk+qb13GkFUvDeKl8RzHf2sqSZxkqYLnXlRv0KtTbl9I6vszURx3LsKYH
wUR8EVVDzECVD/q4RtVxZQNQnV0abg==
=PlkH
-----END PGP SIGNATURE-----

--ts25h2lptwhz67x3--
