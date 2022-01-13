Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD02348DEEF
	for <lists+linux-can@lfdr.de>; Thu, 13 Jan 2022 21:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiAMUaM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 13 Jan 2022 15:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiAMUaL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 13 Jan 2022 15:30:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E35C061574
        for <linux-can@vger.kernel.org>; Thu, 13 Jan 2022 12:30:11 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n86jZ-0003lm-Vy; Thu, 13 Jan 2022 21:30:10 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B752C180DC;
        Thu, 13 Jan 2022 20:30:08 +0000 (UTC)
Date:   Thu, 13 Jan 2022 21:30:04 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Neeli <sneeli@xilinx.com>
Cc:     Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: Queries on CAN frame work
Message-ID: <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4xlilptybee4pkqi"
Content-Disposition: inline
In-Reply-To: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--4xlilptybee4pkqi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Srinivas Neeli,

On 13.01.2022 18:14:06, Srinivas Neeli wrote:
> This mail is regarding to understand more on CAN Frame work for CANFD
> networks.

let's discuss this on the CAN mailing list (Cc'ed). Feel free to
subscribe (http://vger.kernel.org/vger-lists.html#linux-can). Please
post non HTML mail.

> Recently we did few experiments with our CANFD network. Stuff error
> observed with different Nominal and Dataphase prescaler configuration
> values, which we get from the frame work.
>=20
>=20
> For lower baud rates separate prescalers are working good, but when we
> switch to high baud rates(like 4Mbps and 5Mbps) observed the BUSOFF
> state(Due to stuff errors) on IP(Xilinx).
>=20
> With shared prescaler(low prescalers) we are not seeing the issue..
>=20
> In Iso spec also mentioned to avoid tolerance, we have to maintain
> common TQ for Nominal and Data phase.
>=20
> Spec: ISO 11898-1:2015(E)  page no :50
>=20
> " If the same time quantum length is used in the nominal bit time and
> in the data bit time and the positions of the sample points in the
> nominal bit time are the same in all CAN nodes of a network, then
> optimum clock tolerance is accomplished for networks using FD frames."
>=20
> CIA:
> https://can-newsletter.org/uploads/media/raw/f6a36d1461371a2f86ef0011a513=
712c.pdf
>=20
> From above CAN-newsletter also suggested the same in recommendation 2 and=
 3.
>=20
> Recommendation 2: Set the BRPA bit-rate prescaler equal BRPB
> Recommendation 3: Choose BRPA and BRPD as low as possible
>=20
> Is there any possibility in framework to use shared prescalars for Nomina=
l and Dataphase?.
>=20
> One more question. How to calculate TDCO ?, is there any generic formula =
for this ?.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--4xlilptybee4pkqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHgi8oACgkQqclaivrt
76lVngf+IEKFg5SXIPdJKnlfO4zPKaXm6xxtpfXLEMNg+b/idvJo3cbclQIbXqeT
tcL7FPERg8qDbR7NpTgmpl1JlbKB6Kiul7LQLZ19sHmIbPCcGbA9RRKX8OLkRMWB
hiIBq0l7GR4RYqTO1sGVE/jYnkRjag+LWYqZE3BAgmN9iFPATw3saFKXTbi7PEoS
yv9x/G7EIBT3tJnID5yLPyVcYnHwQ31ug/Lg8rsvWHv/kFWp1I8ILVJXHao26aLN
2dpiBJX2UAkky9cVWjsPzf0WEh2GytzuZMv+O818dC2C+avfLJpIJdHXYr7psZcw
EE7J8PecWYIJDFWQ0BwzQMYNcwodjw==
=cwDM
-----END PGP SIGNATURE-----

--4xlilptybee4pkqi--
