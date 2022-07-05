Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F08B5664A4
	for <lists+linux-can@lfdr.de>; Tue,  5 Jul 2022 10:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiGEHut (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Jul 2022 03:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiGEHur (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Jul 2022 03:50:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F96411168
        for <linux-can@vger.kernel.org>; Tue,  5 Jul 2022 00:50:46 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o8dKS-0007qE-Kz; Tue, 05 Jul 2022 09:50:40 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-a082-c20a-3b95-9158.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:a082:c20a:3b95:9158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 93DABA84CD;
        Tue,  5 Jul 2022 07:50:38 +0000 (UTC)
Date:   Tue, 5 Jul 2022 09:50:38 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Rhett Aultman <rhett.aultman@samsara.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Message-ID: <20220705075038.mde4ojctqz5l2s7s@pengutronix.de>
References: <YrLjsAOlsizMc/1c@kroah.com>
 <CAMZ6Rq+e+i0xGuWeMaGyTVyLJy=q2vQZqXjYoACws=T_B-FOGQ@mail.gmail.com>
 <YrMJ0vXR84cISTse@kroah.com>
 <CAMZ6RqJZKYOTtLpiM3ie3fNOBm8i7d8yr8n7S=yAm6twbuhGrQ@mail.gmail.com>
 <99ac782c-46e7-bbef-8f54-cf2fd67acdc@samsara.com>
 <CAMZ6Rq+FSzy5ijQZhYyVJrbe86U9faD5aPFO4cezNkN9G-USzQ@mail.gmail.com>
 <337d5316-82bb-e048-2014-b0634fadf8@samsara.com>
 <CAMZ6Rq+hPC4N=_jGioUyaG0ezTE2qM8gDZic3ETESm0P=vkU9Q@mail.gmail.com>
 <20220704130249.lqpqstjxaz2773zp@pengutronix.de>
 <alpine.DEB.2.22.394.2207041133330.535975@thelappy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ncu3bgm3htbtdnj7"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2207041133330.535975@thelappy>
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


--ncu3bgm3htbtdnj7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.07.2022 11:35:52, Rhett Aultman wrote:
>=20
>=20
> On Mon, 4 Jul 2022, Marc Kleine-Budde wrote:
>=20
> > On 28.06.2022 10:09:16, Vincent MAILHOL wrote:
> > > > In light of this, while I remain committed to helping work the prob=
lem, I
> > > > can't help but wonder if it's worth it to consider my original patc=
h in a
> > > > new light?
> > >
> > > Yes, it makes sense to take your initial patch.
> >
> > done
>=20
> Thanks.  At this point, is there anything more needed from me on that
> patch?  Addition of Reviewed-by: lines or similar?

No need to, it's already mainline :)

> > > I will reiterate that
> > > I do not like the way it is done but you are fixing a memory leak and
> > > delaying the fix furthermore is not good.
>=20
> As an addendum, I think I might have found a way to scare up resources
> and time for that benchmarking work, so while I don't want to start making
> promises, there's a reasonable chance we might be able to do this in the
> next few weeks.

Nice!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ncu3bgm3htbtdnj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLD7UsACgkQrX5LkNig
010ptQf+Mt4mYuPXFANxCclVKL2yCFu8iRHCpLKGWTCoi6H6qO/8y0VSlFbEqHbt
hI2zvuJMr2RLuefeJvq9GXe34yz/Q68zUcYqjfIf8WTN+qZVFuME+DuVCkEG/Is7
xRLpU42wBekvW6iRHBusDk+c8KVJaRpDVl+SOFa6plc3PT8AtH4kgtzQ2o6uaY9h
yhQv2gwc1g06RvC6ooc3uruXl32cI17uXim8prVY2Ijah0rKFiB690VPg3cgatEM
wId2Ff66T/Cqwq/LsAfMHqbsYG4rEFwqWbV2WP+4Q7Tfb81tsDKUb6UeJDo4OmpR
KaSpn1HKgcXGN+99xYWgLFp+HtnNaQ==
=rvt9
-----END PGP SIGNATURE-----

--ncu3bgm3htbtdnj7--
