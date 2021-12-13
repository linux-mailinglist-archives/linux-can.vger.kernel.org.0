Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1705D472D92
	for <lists+linux-can@lfdr.de>; Mon, 13 Dec 2021 14:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbhLMNk0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 13 Dec 2021 08:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbhLMNk0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Dec 2021 08:40:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD253C061574
        for <linux-can@vger.kernel.org>; Mon, 13 Dec 2021 05:40:25 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mwlZ1-0002MU-Ij; Mon, 13 Dec 2021 14:40:23 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-b409-92d7-4137-b1a1.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:b409:92d7:4137:b1a1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 517536C3313;
        Mon, 13 Dec 2021 13:40:22 +0000 (UTC)
Date:   Mon, 13 Dec 2021 14:40:21 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, Peter Fink <pfink@christ-es.de>
Subject: Re: [PATCH] can: gs_usb: detach device on reception of invalid USB
 data
Message-ID: <20211213134021.xn43hhzdnrhnapo4@pengutronix.de>
References: <20211210091158.408326-1-mkl@pengutronix.de>
 <17be229c-eac4-2bee-bc05-484123c99823@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oojggyueffprsfkm"
Content-Disposition: inline
In-Reply-To: <17be229c-eac4-2bee-bc05-484123c99823@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--oojggyueffprsfkm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.12.2021 14:31:22, Oliver Hartkopp wrote:
>=20
>=20
> On 10.12.21 10:11, Marc Kleine-Budde wrote:
> > The received data contains the channel the received data is associated
> > with. If the channel number if bigger than the actual number of
>                               ^^
>=20
> I always have to remind myself to take out the chewing gum before dictati=
ng
> commit messages  :-D

Alexa, fix the commit message! :D

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--oojggyueffprsfkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmG3TUIACgkQqclaivrt
76k/tgf/dcSCLk+d8El7BqPqunuQNuaK5FocWWbsLxWuml8aXB+omgeVExGjeIMd
/0TgQDdOv0+P+yf1G0jUZuVaoqba0QiXuZdW46VbRIza1YGqEne6owzWjvAxVpI4
aXrf6Wm/CU3hrylICBLAejNAxsooyI8WHak0A7ahGLRuPrEHbxyGWtZHJy/R6xvQ
I/RUxOb6lmjUXHdJ3MGM4tLNpTcRVFMTVzn57GQCpVcsVtRqCwE1FG/LXMkwS9/q
FEkfP0KEa8oitd6YgtsDe4ssQg/sCH0qyN3xIrG/KhV7fgQmylkAxTm9DXPoNWtQ
5Q6SnsZ71k2b7scjMb0iXGipDhrvyA==
=hC+z
-----END PGP SIGNATURE-----

--oojggyueffprsfkm--
