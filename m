Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B4231C8CB
	for <lists+linux-can@lfdr.de>; Tue, 16 Feb 2021 11:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhBPK3U (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Feb 2021 05:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhBPK3T (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Feb 2021 05:29:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D3CC061574
        for <linux-can@vger.kernel.org>; Tue, 16 Feb 2021 02:28:39 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lBxav-0008OL-GG; Tue, 16 Feb 2021 11:28:37 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:c976:249:a7:a1bb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5A67A5E2286;
        Tue, 16 Feb 2021 10:28:36 +0000 (UTC)
Date:   Tue, 16 Feb 2021 11:28:35 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-can@vger.kernel.org
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
Message-ID: <20210216102835.v5goqyksqsu6h6xr@hardanger.blackshift.org>
References: <602651f9.1c69fb81.302a5.647d@mx.google.com>
 <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
 <CAALJrqgrmzGHZX+iiMYwMkVMpxtf_3fWYkVA-iMdPOxpGzrCRQ@mail.gmail.com>
 <20210215174408.eea3okssfzjsqrly@hardanger.blackshift.org>
 <CAALJrqj=QC1to9ja0CeL76JxVF1iwjsW7YJHs18VbXea=PvBGg@mail.gmail.com>
 <c47647cd-01c1-a924-263d-72c84b36b2e0@pengutronix.de>
 <CAALJrqiAFR7bacR3eB40OU0fbM1QOc-xnvDtts5tDh5cE+3rrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6raoxtiysidwj5ze"
Content-Disposition: inline
In-Reply-To: <CAALJrqiAFR7bacR3eB40OU0fbM1QOc-xnvDtts5tDh5cE+3rrw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--6raoxtiysidwj5ze
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.02.2021 09:44:54, Torin Cooper-Bennun wrote:
> > Your mram-cfg looks broken, You don't have any TX Event FIFO entries. P=
lease use
> > this one:
> >
> > bosch,mram-cfg =3D <0x0 0 0 16 0 0 1 1>;
>=20
> Okay, thanks for the tip, I usually don't make use of the TX event
> feature!

You might not, but the driver does :)

> This hasn't fixed the TX behaviour, though. I've verified
> that the frame is loaded into MRAM and requested for TX correctly, but
> the transceiver does this...
>=20
> 1. sends start-of-frame, then 5 bits of ID correctly, at the correct bitr=
ate
> 2. bus then seems to be stuck dominant for 6 bits instead of
> transmitting further ID bits
> 3. bus lines drift back recessive (not a clean edge) over the duration
> of 12 bits
> 4. process repeats
>=20
> Steps 2-3 constitute an error frame, if my understanding is correct.
> Presently the TCAN4550 is not connected to any other CAN nodes; I
> would therefore expect the transmit to at least continue to the ACK
> field.

If the process repeats infinitely then the CAN controller doesn't go
into bus-off, which means the CAN bus is terminated correctly.

With your setup of only one node on the bus and correct termination, I
too think the frame should be send until the ACK field. I suggest to
first create a working CAN bus setup and then add the tcan to it.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--6raoxtiysidwj5ze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmArnlAACgkQqclaivrt
76le1wf/SfMlKR4ATZ3+e9lLCniB2hyMAXVSVSOCnsQToiOZX9ZDmIP2fE0Z370R
DpElUCw6JA1yACbKYGbuoEwJdE19Tz+Ymrkcqa/Vej7JsjFrhwx5Ck7IVOR53rEO
zMWf2DfmbNI+7rCa6I6OdewiVQa3NSHt7ndfhL3pY+v6x+nMngbTojLhy411Z/n5
y6/cOPn/xT/RNNzLpWjS7bTnsaIgREJwDKMA1ZkmADcpf4YXEWdF81Oz5Puy+t8H
dgv8A7AbHPm6qMSecNYVyCrd5anhJ3cCMLnw0TaVVMgWKNs6hkIP0zuj4w79to+o
AQ2QJJs8cDcXkVEk1N3s0YfzACaP4g==
=7lf7
-----END PGP SIGNATURE-----

--6raoxtiysidwj5ze--
