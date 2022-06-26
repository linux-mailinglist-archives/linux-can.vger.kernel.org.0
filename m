Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4579655B0D1
	for <lists+linux-can@lfdr.de>; Sun, 26 Jun 2022 11:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiFZJXN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Jun 2022 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiFZJXL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2022 05:23:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A998B7D3
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 02:23:09 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o5OU0-0000wa-2X; Sun, 26 Jun 2022 11:23:08 +0200
Received: from pengutronix.de (p200300ea0f229100c1f120485ffcf4df.dip0.t-ipconnect.de [IPv6:2003:ea:f22:9100:c1f1:2048:5ffc:f4df])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2F41A9F7DD;
        Sun, 26 Jun 2022 09:23:07 +0000 (UTC)
Date:   Sun, 26 Jun 2022 11:23:06 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Max Staudt <max@enpas.org>, linux-can <linux-can@vger.kernel.org>
Subject: Re: Thanks for reviewing can327!
Message-ID: <20220626092306.ewufhfpf6mdketwy@pengutronix.de>
References: <20220614222811.1a18e19b.max@enpas.org>
 <CAMZ6RqKAOSKcdY2PJqSHR0fBaJ8k+9Fw3jcP5nD3xg+PbF11Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vvev533pq3lugerz"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKAOSKcdY2PJqSHR0fBaJ8k+9Fw3jcP5nD3xg+PbF11Sg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--vvev533pq3lugerz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.06.2022 17:44:36, Vincent MAILHOL wrote:
> On Wed. 15 Jun. 2022 at 05:28, Max Staudt <max@enpas.org> wrote:
> > Hi Vincent,
> >
> > Thank you so much for the thorough review of can327!

Thank you for staying on the ball and not being deterred. Hopefully
you'll receive such a thankful message from some contributor in the
future!

> > (the word "relentless" comes to mind, even if it doesn't really fit...)
> >
> >
> > You went above and beyond anything I could ever have dreamed of for
> > something that has started as a hobby curiosity, and now likely powers
> > several projects more curious than itself. No idea why you did, but I'm
> > grateful.
>=20
> I can answer you. Several reasons but the strongest one is that less
> than two years ago, I was in your shoes.
> I posted my first message on the linux-can mailing list in September
> 2020 with the patches for the etas_es58x driver.
>=20
> I did mistakes similar to what you did, for example I also had a
> memory leak in my code:
> https://lore.kernel.org/linux-can/45c0b0cc-bfd6-5180-7ad9-51eebc9de3c9@gm=
ail.com/
> (thanks again to Jimmy for spotting that).
>=20
> My patch reached v15 and took half a year before being finally
> accepted. All the comments and mentoring I received back then from
> Marc, Oliver and the others turned out to be my best learning
> experience in the last few years.
> In some way, my review is a way to give back to the community what I rece=
ived.

=2E..and Vincent has given plenty! A proper TDC framework, thousands of
patch reviews, and most recently the can-dev/Kconfig cleanups.

> > Please remind me to buy you a beer or other drink the nex^H^H^Hfirst
> > time we meet.
>=20
> I live in Tokyo, if you have plans to visit, it would be my pleasure
> to share a beer.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vvev533pq3lugerz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmK4JXcACgkQrX5LkNig
013Wugf9HxWjwYk68Ki+4A3fSsEPlwJwogWbm0nO+ALuK5FKDXpp477xsb2LZgxg
QwUB57p0yVK+veTblJhHJxhExV0R8OPr5mh+G8o4mJ93je05WrZ86G3LgYlWL4te
CS/4hH3xREcNApw2P2HAQcGZT/fEA4He4EvGSdPcp+ad9nejMdS9PSjXJ9sNsDCv
kUbY4KcwwVQyfxYd2lMf8R3lhtrysJue6CwduxyoHxTp9oUku9r3mMpzS0Hp4Yiz
Z5LzQb8mbIyC/60GdZm2TMxJfVrSPAR5YukOEgYcDcozr0bjdOPTWnnhfMLJoB5j
nuOHCe9VwzFzwgks8f7XJoV5Eu6GPQ==
=Zpw1
-----END PGP SIGNATURE-----

--vvev533pq3lugerz--
