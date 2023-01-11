Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5D0665AEA
	for <lists+linux-can@lfdr.de>; Wed, 11 Jan 2023 12:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbjAKL7N (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Jan 2023 06:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238957AbjAKL6m (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2023 06:58:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B926F14081
        for <linux-can@vger.kernel.org>; Wed, 11 Jan 2023 03:54:53 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pFZgx-0004Wg-IY; Wed, 11 Jan 2023 12:54:51 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4be9:1924:f18c:263c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 755001544A7;
        Wed, 11 Jan 2023 11:54:50 +0000 (UTC)
Date:   Wed, 11 Jan 2023 12:54:41 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas.Kopp@microchip.com
Cc:     Stefan.Althoefer@janztec.com, linux-can@vger.kernel.org
Subject: Re: RE: RE: AW: AW: mcp251xfd: Bad message receiption (1/2)
Message-ID: <20230111115441.zzrw5xdjierqyn4e@pengutronix.de>
References: <FR0P281MB1966801F8A7BCC540D40A4DE97FE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64849F53D129B61D79952538FBFF9@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230110145322.4bqwlw3owesc5myj@pengutronix.de>
 <20230110170857.5ejgppyjnoc2adji@pengutronix.de>
 <20230110183952.pvtuw5gudefnnyv5@pengutronix.de>
 <BL3PR11MB6484FC468720BAB0660766A8FBFF9@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230110215033.xcz7g3ubonuawqr5@pengutronix.de>
 <20230110223744.mzktwinp54cad6ow@pengutronix.de>
 <20230110224302.v2eqqunjo2zhpfrf@pengutronix.de>
 <20230111081725.6s5tnjku3ximif3k@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r6tvbhbvry5247a3"
Content-Disposition: inline
In-Reply-To: <20230111081725.6s5tnjku3ximif3k@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
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


--r6tvbhbvry5247a3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.01.2023 09:17:25, Marc Kleine-Budde wrote:
> On 10.01.2023 23:43:02, Marc Kleine-Budde wrote:
> > On 10.01.2023 23:37:44, Marc Kleine-Budde wrote:
> > > On 10.01.2023 22:50:33, Marc Kleine-Budde wrote:
> > > > On 10.01.2023 21:40:16, Thomas.Kopp@microchip.com wrote:
> > > > > > The correct message counter is 0x100, the wrong one 0x120. That=
's 2x
> > > > > > FIFO size. I'd like to know when the FIFO head is wrong for the=
 first
> > > > > > time, one that results in a data transfer where "old" FIFO cont=
ents is
> > > > > > read. I haven't dumped any data yet.
> > > >=20
> > > > I got a chip-delta =3D=3D 4 error.
> > >=20
> > > I have a proof of concept workaround implemented and I'll let it run
> > > over night.
> >=20
> > \o/ The workaround triggered and Stefan's test program continued without
> > problems \o/
>=20
> Still running. The workaround triggered more than 45x this night.

I think the same problem occurs with the TEF, too. It's easier to
detect, as the TEF has sequence numbers.

The driver already implements a workaround. It limits the TEF head to TX
head [1] and it refuses to handle TEF objects with wrong sequence
numbers [2] and UINCs only the correctly handled ones.

However it doesn't roll back the "wrong" internal TEF head. The problem
occurs (on Linux) only during high TX load situations, so eventually
there will the enough finished TX frames and the internal TEF head will
be correct again.

regards,=20
Marc

[1] https://elixir.bootlin.com/linux/v6.1.4/source/drivers/net/can/spi/mcp2=
51xfd/mcp251xfd-tef.c#L141
[2] https://elixir.bootlin.com/linux/v6.1.4/source/drivers/net/can/spi/mcp2=
51xfd/mcp251xfd-tef.c#L106

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--r6tvbhbvry5247a3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmO+o34ACgkQrX5LkNig
012KsAgAlFIS89BCNCauzGy8oTHHWuKYER/I7pA9u9UOUP3b6LNheATfFISvHj8W
Vs14sBrwcWCilAAYzBPNNEdNf6CNNOvL3XKQUryD+uggpH6cO9+ylCSETKncUJOc
EdkKQ0LPmQ8VGGI+w3agmJi8oUIdqQlJgXZn5g7Ennz5Y7pgi9VKjQbEbCQxkWyO
hrPPDPzGiaKpfJrxcGFj4LCpaczMfqUKkAWtMwb5dLKdr3z9KbwfwVrmS3conuQx
NZVjdB8569S5j2Zs1Iw/FRZ13wvGi5ApEjvHlvJMP+b740UK/YiXi7gIicJGdw3j
83/b7LLR2GaGWBgwEg2q+fZcnGwDbQ==
=8ZG3
-----END PGP SIGNATURE-----

--r6tvbhbvry5247a3--
