Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4803D664EEA
	for <lists+linux-can@lfdr.de>; Tue, 10 Jan 2023 23:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbjAJWnZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Jan 2023 17:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjAJWnO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2023 17:43:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67765EC07
        for <linux-can@vger.kernel.org>; Tue, 10 Jan 2023 14:43:13 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pFNKp-00081j-JM; Tue, 10 Jan 2023 23:43:11 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:5d1d:2f90:6e72:2410])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B7681153B79;
        Tue, 10 Jan 2023 22:43:10 +0000 (UTC)
Date:   Tue, 10 Jan 2023 23:43:02 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas.Kopp@microchip.com
Cc:     Stefan.Althoefer@janztec.com, linux-can@vger.kernel.org
Subject: Re: RE: RE: AW: AW: mcp251xfd: Bad message receiption (1/2)
Message-ID: <20230110224302.v2eqqunjo2zhpfrf@pengutronix.de>
References: <FR0P281MB1966783A50BDAD455BBC7F1A97F69@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966543302DB6485C49F8A2E97F59@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966801F8A7BCC540D40A4DE97FE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64849F53D129B61D79952538FBFF9@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230110145322.4bqwlw3owesc5myj@pengutronix.de>
 <20230110170857.5ejgppyjnoc2adji@pengutronix.de>
 <20230110183952.pvtuw5gudefnnyv5@pengutronix.de>
 <BL3PR11MB6484FC468720BAB0660766A8FBFF9@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230110215033.xcz7g3ubonuawqr5@pengutronix.de>
 <20230110223744.mzktwinp54cad6ow@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wwddhzuoku7f3lk7"
Content-Disposition: inline
In-Reply-To: <20230110223744.mzktwinp54cad6ow@pengutronix.de>
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


--wwddhzuoku7f3lk7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.01.2023 23:37:44, Marc Kleine-Budde wrote:
> On 10.01.2023 22:50:33, Marc Kleine-Budde wrote:
> > On 10.01.2023 21:40:16, Thomas.Kopp@microchip.com wrote:
> > > > The correct message counter is 0x100, the wrong one 0x120. That's 2x
> > > > FIFO size. I'd like to know when the FIFO head is wrong for the fir=
st
> > > > time, one that results in a data transfer where "old" FIFO contents=
 is
> > > > read. I haven't dumped any data yet.
> >=20
> > I got a chip-delta =3D=3D 4 error.
>=20
> I have a proof of concept workaround implemented and I'll let it run
> over night.

\o/ The workaround triggered and Stefan's test program continued without
problems \o/

g'night,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wwddhzuoku7f3lk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmO96fMACgkQrX5LkNig
011D2AgAj9Iqz0vrnAsqJ4vkVKQFQAVQ4pVBq1lcso0sGerN2hlKBz3RpNh7dq30
QEdYvZDzI6/cbbT/vlF4tlGawgAY65MPt1iIfbEcf7PjwoPTEZprH705OIuY7gu+
AqZw0X/G24hH4pHJpf7stUJN9qsiwi4Q93ulIdJlRvnGOfzSoXCdKUVVIj2CeEWF
b5ETc25y73XHP/t1VY5qa8iL1FNlqQ6r/afI7fdCybAfkPHifQoO2ZXlZ+vuRoMP
o2HpfiHVMlLRtS8yE+3qTL6YX311W3vmf+e1N1J+FWxJJeG6KF7zBNBdM+JihabN
rAH4MRxlY67/6tDuI1j2UQKJ5Vk7tw==
=A35r
-----END PGP SIGNATURE-----

--wwddhzuoku7f3lk7--
