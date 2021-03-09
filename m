Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CCB3323CF
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 12:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCILUf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 06:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhCILUN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 06:20:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ABEC06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 03:20:13 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJaPM-0006I2-4N; Tue, 09 Mar 2021 12:20:12 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4699:faa8:8510:ac25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 57D915F16B8;
        Tue,  9 Mar 2021 11:20:11 +0000 (UTC)
Date:   Tue, 9 Mar 2021 12:20:10 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 1/3] can/peak_usb: add support of ethtool set_phys_id()
Message-ID: <20210309112010.t7reyqjkfkj6jtjp@pengutronix.de>
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
 <20210309082128.23125-2-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jkpgaw4eor6d3ado"
Content-Disposition: inline
In-Reply-To: <20210309082128.23125-2-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--jkpgaw4eor6d3ado
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2021 09:21:26, Stephane Grosjean wrote:
> This patch makes it possible to specifically flash the LED of a CAN port
> of the CAN-USB interfaces of PEAK-System.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Added this one to linux-can-next/testing.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jkpgaw4eor6d3ado
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBHWegACgkQqclaivrt
76kKrQf+IKNlwtSrZWQ3WDcMu3ehQShtPd/JnUzyjOBOwYUM9d9+vvZvreSHYHkt
CYG/EEtsuBimZXrk9CuF2vzb0YJe7L/1ZybE045jL69HLblS0AwL9yf5SXGtVdKH
f6tH3BWh7jCLtovxotQVtC0AfILGGSSJPfRECAAIfMDDeRXqhJw5Ifm7018E1lpT
5cOKKBOrUdhYnxWreccyYBENlH8vZWPj8uaCHyfVP4WwsNCrWEHfG1kBPRRJcoYl
FXiPWXPG5INrc7rhAo5Q2udJfPwYxJlA5aLoDRS6WyF3zmfaP4wuk3i+PCAVVcFM
SYtn9hVxo4vfRotn//kPIzpcrHEKaA==
=UeaS
-----END PGP SIGNATURE-----

--jkpgaw4eor6d3ado--
