Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2C06B64D0
	for <lists+linux-can@lfdr.de>; Sun, 12 Mar 2023 11:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCLKR0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 12 Mar 2023 06:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCLKRZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 12 Mar 2023 06:17:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B2C36FE7
        for <linux-can@vger.kernel.org>; Sun, 12 Mar 2023 03:17:20 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pbIlQ-0001NS-NQ; Sun, 12 Mar 2023 11:17:17 +0100
Received: from pengutronix.de (unknown [IPv6:2a00:20:4047:f0aa:709:fab:bab8:4a48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5164C18F87F;
        Sun, 12 Mar 2023 10:13:43 +0000 (UTC)
Date:   Sun, 12 Mar 2023 11:13:42 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "Fink, Peter" <pfink@christ-es.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Ben Evans <benny.j.evans92@gmail.com>,
        Christoph =?utf-8?Q?M=C3=B6hring?= <cmoehring@christ-es.de>,
        "Schartner, Alexander" <aschartner@christ-es.de>,
        Eric Evenchick <eric@evenchick.com>,
        Venelin Efremov <ghent360@iqury.us>
Subject: Re: AW: candlelight CAN-FD TX echo
Message-ID: <20230312101342.oez4ciqx7lrg2cpd@pengutronix.de>
References: <20230217153233.m2k4qcecux2up22k@pengutronix.de>
 <24224723ec0a48a8bde8abf682da7d31@christ-es.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ytgneeercykhbchy"
Content-Disposition: inline
In-Reply-To: <24224723ec0a48a8bde8abf682da7d31@christ-es.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ytgneeercykhbchy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.03.2023 15:54:37, Fink, Peter wrote:
> > I'm currently adding CAN-FD support to the Candlelight firmware and loo=
king
> > at the TX echo message from the CAN device to Linux. In your firmware f=
or
> > CAN-FD frames, are you echoing the whole CAN FD structure gs_host_frame
> > with 64 byte data, or the classic CAN gs_host_frame with 8 byte data?
>=20
> In our firmware the whole 64 byte data is echoed back.

Thanks for the info.

> > The Candlelight I use only works in full-speed USB (12 Mbit/s) max, whi=
ch
> > means that the maximum transmission size is 64, which results in a TX e=
cho
> > consisting of 2 USB transmissions. The Linux driver makes no use of the=
 data
> > in the TX echo frame, so a classic CAN TX echo would suffice.
>=20
> Our device supports USB high-speed USB (480Mbit/s).

With 480 Mbit/s it should be less of a problem than with 12 Mbit/s. If
we run into performance and/or throughput issues, we could introduce an
optional "shallow echo" where only the index and the timestamp will be
send back.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ytgneeercykhbchy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQNpdMACgkQvlAcSiqK
BOhdJQgAlmUcQL6jrfSrBsTfZvam5XWgA1uSy0W91JcBkfq9ojxZ6ERo7D1IH4jq
4uVsdBZP0frnu4nzLIn2yy7iJu6BAS5JAB0C4WysJ/2A2hSVrLdxUCccEH4M4klE
FpSVHYsm4u3EocxRVMA79ALaHxVeiidwjxOZ3gApn6kbLprXWh5cT4S4SgFGCkxk
uCq74PUSvGTOQbb3q3UfkuVH+8y2k2jE/09q/1tkssExhSfwhE/XPCQ2/cv/hCbY
gcJcH7ewIfJgkB7YYVdZdTlGGxWJrpUyZXFNWoAbDvDaSmdH/DFuIy/8pz5uyk1V
oL0HvIDP+EzTYACLlnmXkn2H1H/lhg==
=gEtk
-----END PGP SIGNATURE-----

--ytgneeercykhbchy--
