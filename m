Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE5A4D30EC
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 15:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiCIOVc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 09:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiCIOVa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 09:21:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6A7105AB0
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 06:20:31 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRxAz-0006nb-Di; Wed, 09 Mar 2022 15:20:29 +0100
Received: from pengutronix.de (unknown [IPv6:2a02:908:393:af61:11a6:6968:f87e:ee79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9465C46D92;
        Wed,  9 Mar 2022 14:20:28 +0000 (UTC)
Date:   Wed, 9 Mar 2022 15:20:27 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        Peter Fink <pfink@christ-es.de>
Subject: Re: [can-next-rfc 14/21] can: gs_usb: use union and FLEX_ARRAY for
 data in struct gs_host_frame
Message-ID: <20220309142027.t2gl246zrs4h6bmt@pengutronix.de>
References: <20220309124132.291861-1-mkl@pengutronix.de>
 <20220309124132.291861-15-mkl@pengutronix.de>
 <CAMZ6Rq+R-yxYm4Kk+aoaQXNedKkmq0LbwDSxs0nXdJMn6t+=bw@mail.gmail.com>
 <CAMZ6RqK57zG88ocEqeeyx+bjM9SZH6h0gqXyN0+NTbHmSOYRsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e3jyaye7dtjyovug"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqK57zG88ocEqeeyx+bjM9SZH6h0gqXyN0+NTbHmSOYRsQ@mail.gmail.com>
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


--e3jyaye7dtjyovug
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2022 23:16:14, Vincent Mailhol wrote:
> On Wed. 9 Mar. 2022 at 23:05, Vincent Mailhol <vincent.mailhol@gmail.com>=
 wrote:
> >
> > On Wed. 9 Mar 2022 =C3=A0 22:39, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:
> > > From: Peter Fink <pfink@christ-es.de>
> > >
> > > Modify struct gs_host_frame to make use of a union and
> > > DECLARE_FLEX_ARRAY to be able to store different data (lengths), which
> > > will be added in later commits.
>=20
> I missed that part. You can ignore my previous message.

np :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--e3jyaye7dtjyovug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIot6kACgkQrX5LkNig
013s7Af+Pceb6TrYEDN22oNgM89QEId9c18CNc3pW29e1J5OTqeZPgAMp7zJvSOs
rmCp4xU3UlJISqLcStz15epNBPXjkoDY2PlTbEPQofdriyCDp0bdQVH8gBZoiX2c
Gv9EPz0g/Ry/wU8PeyJjtJhIXYd61As6lGcnU1WgXrveiqe/6meAXyU6VQXAQXPP
cY2Eme3/yJQCCRd6RZiV0L4839SVTwDGq6mxXL8kdlmuv3PhTimOgINL6rJxy77A
ytAhJuLct0uVULtylzP6ddk6HG4YtUpzCwoQBQggsksWhHPXIX8uVNuFm8q0HSgQ
cAl/EY6zoKW8SxeHfgY5ZLTIOv0KWA==
=r6wx
-----END PGP SIGNATURE-----

--e3jyaye7dtjyovug--
