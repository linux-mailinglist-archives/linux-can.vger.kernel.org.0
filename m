Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1378931C992
	for <lists+linux-can@lfdr.de>; Tue, 16 Feb 2021 12:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhBPLUc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Feb 2021 06:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBPLUO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Feb 2021 06:20:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958BFC06174A
        for <linux-can@vger.kernel.org>; Tue, 16 Feb 2021 03:19:33 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lByOC-0005Dw-77; Tue, 16 Feb 2021 12:19:32 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:c976:249:a7:a1bb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5AD4F5E2311;
        Tue, 16 Feb 2021 11:19:31 +0000 (UTC)
Date:   Tue, 16 Feb 2021 12:19:30 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
Message-ID: <20210216111930.pcg4e7cildzuri6d@hardanger.blackshift.org>
References: <602651f9.1c69fb81.302a5.647d@mx.google.com>
 <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
 <CAALJrqgrmzGHZX+iiMYwMkVMpxtf_3fWYkVA-iMdPOxpGzrCRQ@mail.gmail.com>
 <20210215174408.eea3okssfzjsqrly@hardanger.blackshift.org>
 <CAALJrqj=QC1to9ja0CeL76JxVF1iwjsW7YJHs18VbXea=PvBGg@mail.gmail.com>
 <c47647cd-01c1-a924-263d-72c84b36b2e0@pengutronix.de>
 <CAALJrqiAFR7bacR3eB40OU0fbM1QOc-xnvDtts5tDh5cE+3rrw@mail.gmail.com>
 <20210216102835.v5goqyksqsu6h6xr@hardanger.blackshift.org>
 <CAALJrqiVdmLQr7q2ijbWq70RD6PTD8PtVX_zmLW9=uNdc57WqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sw4ibksoaz3ccdrq"
Content-Disposition: inline
In-Reply-To: <CAALJrqiVdmLQr7q2ijbWq70RD6PTD8PtVX_zmLW9=uNdc57WqA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--sw4ibksoaz3ccdrq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please keep the mailing list on Cc.

On 16.02.2021 11:11:34, Torin Cooper-Bennun wrote:
> On Tue, 16 Feb 2021 at 10:28, Marc Kleine-Budde <mkl@pengutronix.de> wrot=
e:
> > You might not, but the driver does :)
>=20
> Indeed, on closer inspection I can see that!
>=20
> > If the process repeats infinitely then the CAN controller doesn't go
> > into bus-off, which means the CAN bus is terminated correctly.
> >
> > With your setup of only one node on the bus and correct termination, I
> > too think the frame should be send until the ACK field. I suggest to
> > first create a working CAN bus setup and then add the tcan to it.
>=20
> I have to thank you for mentioning termination, because it turned out
> I had not used correct termination at all. How embarrassing! With that
> fixed, the transceiver is happy and I have working TX and RX.

\o/

> Mostly working RX, anyway. When putting the interface down and then
> back up (but allowing a second node to continue attempting TX in the
> meantime) I see some blank frames...
>=20
> can0  001   [8]  00 01 02 03 04 05 06 07
> can0  001   [8]  00 01 02 03 04 05 06 07
> can0  001   [8]  00 01 02 03 04 05 06 07
> can0  000   [0]
> can0  000   [0]
> can0  001   [8]  00 01 02 03 04 05 06 07
> can0  001   [8]  00 01 02 03 04 05 06 07
> etc.
>=20
> (where the 8-byte frame is what the bus is actually seeing.)

Where do you see these blank frames? On the sending rpi with candump? An
on the bus (with a second system) you only see the full 8 byte long
frames?

Use "candump any,0~0,#FFFFFFFF -extA" to get RX/TX annotation.
Use "cangen -Ii -L8 -D000102030405060708 -g100 can0" to get increasing
CAN-IDs, so you can figure out if a CAN frame got lost.

Seems I have to add the TX path to the list of broken things...

The mcp251xfd driver can be used as a template for the tcan4x5x driver.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--sw4ibksoaz3ccdrq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmArqj8ACgkQqclaivrt
76nBbAf/eqPnwn84XC6I6/gaGRhlz+sKUOxKNIVvztV60LAPkLGDLZFUXSEJ4MIy
FJeCeoPxFSPVEy+VNqKiy0f150rLhOcu26TPszEJZ90Slg+ldFDmu56UsmJdG3q8
sC+80c4EcsEACb+9Sif8Yaqv2rh1quICZgOBv0xgmCzJnO8qTomWJm1JM4O2aWQM
qtzte/d4hPWZKI29lbnj0iRv6JNiCFVrBkMbyvC1XA66P/ZB5IIj2eHK2IJIrflH
FzJJo3j6jIOdwfIJHH5MKan4xiqUQ+Db2zII1zpD+ERpGHTrmbd556w5q/cCd2v6
vZtmFIKhIxi/Mk+xSTsJfvzOvN5R8g==
=He2Z
-----END PGP SIGNATURE-----

--sw4ibksoaz3ccdrq--
