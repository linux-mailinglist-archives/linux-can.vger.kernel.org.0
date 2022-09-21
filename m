Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3365E5412
	for <lists+linux-can@lfdr.de>; Wed, 21 Sep 2022 21:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIUT6O (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Sep 2022 15:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIUT6N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Sep 2022 15:58:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFABA2635
        for <linux-can@vger.kernel.org>; Wed, 21 Sep 2022 12:58:13 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ob5rF-0003mj-LL; Wed, 21 Sep 2022 21:58:09 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6E428E8DFD;
        Wed, 21 Sep 2022 19:58:07 +0000 (UTC)
Date:   Wed, 21 Sep 2022 21:58:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     john@jbrengineering.co.uk
Cc:     linux-can@vger.kernel.org,
        John Whittington <git@jbrengineering.co.uk>
Subject: Re: (No Subject)
Message-ID: <20220921195804.iqiorhtcbehmpolb@pengutronix.de>
References: <20220920100416.959226-1-mkl@pengutronix.de>
 <wRg__4HuO0FuJrZu5M_JEbOd6MvCtxHq_aV86X_Bj-Dgb0YTRaoVO_sr6DpPcvwrhWtnNYwSCCWf0hJ8bCsFEYfon_iTkyctFDZOxOyO3x8=@jbrengineering.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wpsya37h3yh3excq"
Content-Disposition: inline
In-Reply-To: <wRg__4HuO0FuJrZu5M_JEbOd6MvCtxHq_aV86X_Bj-Dgb0YTRaoVO_sr6DpPcvwrhWtnNYwSCCWf0hJ8bCsFEYfon_iTkyctFDZOxOyO3x8=@jbrengineering.co.uk>
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


--wpsya37h3yh3excq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.09.2022 07:07:26, john@jbrengineering.co.uk wrote:
> > while playing around with the hardware timestamping code, I found some
> > issues, which are fixed in this series.
> >=20
> > John, can you test if timestamping still works on your hardware.
>=20
> I've just tested the 3 patches and yes it still works. Thanks for
> picking up on those.

Thanks, can I add your Tested-by?

> I see a potential issue with 3/3: the timer not being stopped if the
> USB start errors but I've replied in that thread.

Fixed, see:

| https://lore.kernel.org/all/20220921081329.385509-1-mkl@pengutronix.de

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wpsya37h3yh3excq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMrbMoACgkQrX5LkNig
011o1Qf/UldGKPfzPE0sVJT2UJBDbFqFWC9mgi/ghVnDL4PkP0v5q1g26a53Jdaj
zT+6ZCr+NnyYwt4nnRPsUPSSvxE53AvUZ4xsA7tkpC6m8QBRlnifsi+0AJpgAR5e
sVnUxft1Ia+6GSh+BQkk/QkoTG16vh98ji3ueaB5gMeiUZ4zjiN9hli92tKcLebx
3bYum4EIjm47bqb8QPxdEGQTV4a5OmtkUy/sFFZgva67xZiFgdV46Dnp01ui9qS4
bLnNxNP7Apu0qh78IdNuN5vt3TM2udtwEdbSy+wrwGM8Cg/0MNP75P5i1gDynfZi
VN9JFVh5tcMIq5YSrehW7eG1efh6Mw==
=Zohm
-----END PGP SIGNATURE-----

--wpsya37h3yh3excq--
