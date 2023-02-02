Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1982687D10
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 13:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBBMRe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 07:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBBMRd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 07:17:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20578626E
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 04:17:32 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNYWv-0000Nt-P5; Thu, 02 Feb 2023 13:17:29 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:fff9:bfd9:c514:9ad9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 062A316D481;
        Thu,  2 Feb 2023 12:17:29 +0000 (UTC)
Date:   Thu, 2 Feb 2023 13:17:20 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>,
        kernel@pengutronix.de, Mark Bath <mark@baggywrinkle.co.uk>
Subject: Re: [PATCH v2 00/17] can: bittiming: cleanups and rework SJW handling
Message-ID: <20230202121720.klhoxrur3r45cpy3@pengutronix.de>
References: <20230202110854.2318594-1-mkl@pengutronix.de>
 <CAMZ6Rq+LkkjBb+F8gfVCFcCJG4BU0aFTikvaZhR8TdYeEP8=hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="chxi44zghiwnatio"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+LkkjBb+F8gfVCFcCJG4BU0aFTikvaZhR8TdYeEP8=hg@mail.gmail.com>
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


--chxi44zghiwnatio
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.02.2023 21:05:23, Vincent Mailhol wrote:
> I finished a first quick review and sent my nitpicks. Really great
> work, thank you!
>=20
> On Thu. 2 Feb 2023 at 20:08, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > Hello,
> >
> > several people noticed that on modern CAN controllers with wide bit
> > timing registers the default SJW of 1 can result in unstable or no
> > synchronization to the CAN network. See Patch 14/17 for details.
>=20
> If this series addresses an actual issue, should it be backported to
> stable branches?

Hmmm, the changes are quite big so I want to have it tested a bit more
before it hits mainline. If there's interest in/need for back porting we
can think about it.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--chxi44zghiwnatio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmPbqc0ACgkQvlAcSiqK
BOhQYQf9Fyh/ifY4e7sio+2ebmr7WVZinz1eTGvAsBiN5DVr+VIOeoRZamMQA6E8
peEAdpkU8PPPMz9UNvLwhFC7MXnHIIDIQzzisXZtyQwO5KOzSgIFTP+40Ow0nlWO
9vajTjiL+91bBrzX4bf8aXRzisjgrrLVTajYJfDEuLtDoLFogPqSqaNCDH85l/Yi
vL+U+eG1qd0FmLYh8XfIYlD0kbAsXaqDzT7d6OKc+zdzmKJYrOHaAA/GUNbKCe9p
fFidHWEw3lMXe+9uqmIs1crN58YhII9KEh9VFTn6x1DoTcl2AfaJgUC83IZu1msE
xV7NJwItA154t64Q1tH4ciL5hQVUzA==
=OqrN
-----END PGP SIGNATURE-----

--chxi44zghiwnatio--
