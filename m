Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A693E4B3E
	for <lists+linux-can@lfdr.de>; Mon,  9 Aug 2021 19:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhHIRwY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Aug 2021 13:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbhHIRwX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Aug 2021 13:52:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E113FC0613D3
        for <linux-can@vger.kernel.org>; Mon,  9 Aug 2021 10:52:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mD9RR-0003Bo-1T; Mon, 09 Aug 2021 19:52:01 +0200
Received: from pengutronix.de (unknown [IPv6:2a02:810a:8940:aa0:b60e:a8cd:6ec5:c321])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C85D166374C;
        Mon,  9 Aug 2021 17:51:59 +0000 (UTC)
Date:   Mon, 9 Aug 2021 19:51:58 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?TcOkdGpl?= <Stefan.Maetje@esd.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH] mailmap: update email address of Matthias Fuchs
Message-ID: <20210809175158.5xdkqeemjo3hqwcw@pengutronix.de>
References: <20210806104833.102081-1-mkl@pengutronix.de>
 <10024d316c23d7be2ce6037f7994aa2af033208f.camel@esd.eu>
 <20210809072414.syapcl2v7urytygg@pengutronix.de>
 <1b5875759dc9d68f2379cde389b1bf5595ee3964.camel@esd.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4npq6zt2evq5dz2z"
Content-Disposition: inline
In-Reply-To: <1b5875759dc9d68f2379cde389b1bf5595ee3964.camel@esd.eu>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--4npq6zt2evq5dz2z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.08.2021 17:22:51, Stefan M=C3=A4tje wrote:
> > Speaking of that patch. Can you please create an entry in the
> > MAINTAINERS file, too? I suggest to add yourself as M: and the
> > socketcan@e.u as R:. The change in the MAINTAINERS file will be a second
> > patch in that series. Just include it the next iteration of that series.
>=20
> Do you think of something like the patch below?

ACK

> I'm curious. Shouldn't there be similar entries for the drivers from
> Vincent (drivers/net/can/usb/etas_es58x/) and the PEAK driver family
> (drivers/net/can/peak_canfd/)? Why are they not there?

They haven't included a MAINTAINERS entry in the patch series and I
forgot to enforce it :)

> Have I misunderstood something?
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41fcfdb24a81..f25e3f79b392 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4111,6 +4111,14 @@ F:       include/uapi/linux/can/error.h
>  F:     include/uapi/linux/can/netlink.h
>  F:     include/uapi/linux/can/vxcan.h
> =20
> +CAN NETWORK DRIVERS ESD HARDWARE

This usually starts with the company's name or the driver name, so
something like "ESD PCIe/402 CAN DRIVER" and a separate entry for the
USB driver or "ESD CAN NETWORK DRIVERS" if you want to have a single
entry.

> +M:     Stefan M=C3=A4tje <stefan.maetje@esd.eu>
> +R:     socketcan@esd.eu
> +L:     linux-can@vger.kernel.org
> +S:     Maintained
> +F:     drivers/net/can/esd/
> +F:     drivers/net/can/usb/esd_usb2.c
> +
>  CAN NETWORK LAYER
>  M:     Oliver Hartkopp <socketcan@hartkopp.net>
>  M:     Marc Kleine-Budde <mkl@pengutronix.de>
>=20
>=20
> > > and his email address shows up in MODULE_AUTHOR() macro. He also left
> > > our company already.
> >=20
> > In newly added changes, it makes sense that all email addresses are
> > working. :D
>=20
> So I'll remove his stale email address together with the
> MODULE_AUTHOR() macro and file the authorship credits in a changed
> copyright history at the top of the source files.

Yes, his name but with the socketcan@e.u email in MODULE_AUTHOR().
Regarding the top of the file's copyright information, the last patch
only mentions 2 iterations of "esd" but no "real" people nor email
addresses. I don't know what's you company's policy for the copyright
line is, I don't mind adding Thomas, but use the socketcan@e.u email.
People tend to look at the source file in case of problems, so better
have working addresses there.

Regarding the Co-Developed and Signed-off-by: Thomas posted the patches
back in 2015 with his email address, so use it for the Co-Developed and
Signed-off-by in your patch, too. This seems (or is) a bit inconsistent,
but the S-o-b's should record the history of the patch.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--4npq6zt2evq5dz2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmERazoACgkQqclaivrt
76lbNwf/SeGraxyc0PhmVTWSfrTGmtMfvS4mj1CV+c7sC3NZrvT4U2x5/xCnAP2I
lN1211fXcGvQ+cAyxag8ngc3sJmWJqwGH9nLqaUdbT2Al5gkFVim4Y/S7mp/jRTx
d9rr+5cHLL73I8i69iBlPAvIgZoqotn03gWRfCmXYJPwwznYWkeWXihHxPSat0J6
E/TdupDkKzjB0h2Z+Vh2ZXTleaNLh4eRTtZF1p4NP1aaSfp9XkV0v4er5Qj2QLBi
l8AaSreAoWAE7PHdLee/0EJQwZhgS0u/EuXx789XfjWZ5VFNxikgJABQVde0WdWR
s935wqKa8PkB3LPCzsNq6sZGuPIl2g==
=RsLV
-----END PGP SIGNATURE-----

--4npq6zt2evq5dz2z--
