Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B82D4F95D1
	for <lists+linux-can@lfdr.de>; Fri,  8 Apr 2022 14:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiDHMeN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Apr 2022 08:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbiDHMeK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Apr 2022 08:34:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557AA3150F
        for <linux-can@vger.kernel.org>; Fri,  8 Apr 2022 05:32:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ncnmW-0007Pc-Sd; Fri, 08 Apr 2022 14:32:04 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-9b8b-dab7-394c-98e8.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:9b8b:dab7:394c:98e8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D0BC35E840;
        Fri,  8 Apr 2022 12:32:03 +0000 (UTC)
Date:   Fri, 8 Apr 2022 14:32:03 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Wouter van Herpen <wouter.van.herpen@prodrive-technologies.com>
Cc:     mkl@pengutronix.de,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: PROBLEM: tcan4x5x nINT stays asserted under high RX/TX interrupt
 load
Message-ID: <20220408123203.ildoi6jbz7w43qpy@pengutronix.de>
References: <AM0PR02MB592368F53A7BEA4154D24A87EAE09@AM0PR02MB5923.eurprd02.prod.outlook.com>
 <20220403105730.fnurim5vnnuxb7s5@pengutronix.de>
 <AM0PR02MB59236CF6507DD614F60D078FEAE49@AM0PR02MB5923.eurprd02.prod.outlook.com>
 <20220405120959.qwtmcafby2jjxc26@pengutronix.de>
 <AM0PR02MB59238FFE89994FBA392A33E6EAE99@AM0PR02MB5923.eurprd02.prod.outlook.com>
 <20220408104139.n4mmqdeidraad2oc@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="htaalgt5kjgnu6lt"
Content-Disposition: inline
In-Reply-To: <20220408104139.n4mmqdeidraad2oc@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--htaalgt5kjgnu6lt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.04.2022 12:41:39, Marc Kleine-Budde wrote:
> On 08.04.2022 10:29:38, Wouter van Herpen wrote:
> > > Feel free to send the patch against v5.4.24, please mention this in t=
he patch itself to avoid confusion.
> >=20
> > For completeness, I submitted a patch on 05-04-2022 with subject:
> > [PATCH] can: m_can: m_can_isr(): disable mcan interrupts during tefn ha=
ndling
>=20
> What's the Message-ID?
>=20
> > (I noticed the patch is not listed on the archive mirror and I'm not
> > sure if this is because it needs processing or if I did not submit
> > correctly)
>=20
> Can you re-send the patch, adding me on Cc?

Just got you mail directly, not via the mailing list yet.

Once it was processed by the mailing list, it should show up here, too:

| https://lore.kernel.org/all/fe3c7a7ae0f16db0bac87c72faa4e91d0041fda3.1649=
414934.git.wouter.van.herpen@prodrive-technologies.com

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--htaalgt5kjgnu6lt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJQK0AACgkQrX5LkNig
012UFgf+IGv9aUFi6Yys3cVfILIU7F2n6CeTzFjD3JwmLsLgW+7tVK/CNkgFtGzz
7jisWoo8CUVWM0yr9MIzbtsV4hRduSyHkjA63DnUjE4vsqSBQ+LwkQ0kj3+NhU/w
SeGph9wTqob4QBcCbEPCd6kxuETc+Jxt481Yxf2vjHPdobEgx7lgYN1oZgB3fl96
eEU8AdCYb6YhaL+HokTY6DewrVat+H7rTZUnCM2wBX0dRM8E7Nz5yI/I//BEDEO0
kj+Tx+3TRHdC6Yr0dnAorkuZOm/SQKZxdhkfTYuyMNCCLyhsRlTmzDmKxd1Q5Izm
Z5Vn4/gN8f7TNUyBI79+pMgqU28TUA==
=60tm
-----END PGP SIGNATURE-----

--htaalgt5kjgnu6lt--
