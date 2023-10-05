Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D1C7BA8F4
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 20:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjJESUd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 14:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjJESUc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 14:20:32 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C93793
        for <linux-can@vger.kernel.org>; Thu,  5 Oct 2023 11:20:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoSxY-0006r4-VV; Thu, 05 Oct 2023 20:20:28 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qoSxY-00BKMw-Br; Thu, 05 Oct 2023 20:20:28 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 13DFF22FED9;
        Thu,  5 Oct 2023 18:20:28 +0000 (UTC)
Date:   Thu, 5 Oct 2023 20:20:27 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 0/5] can: dev: fix can_restart() and replace BUG_ON()
 by error handling
Message-ID: <20231005-tasting-filtrate-6c40a3d5aad1-mkl@pengutronix.de>
References: <20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de>
 <CAMZ6Rq+QpPEoYp=Cis5a3fuFFZmRMjAZqNTJ2j-B3r4jdwNNhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p5mv7hh7pbp4ycax"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+QpPEoYp=Cis5a3fuFFZmRMjAZqNTJ2j-B3r4jdwNNhg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--p5mv7hh7pbp4ycax
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.10.2023 01:07:33, Vincent Mailhol wrote:
> On Thu. 5 Oct. 2023 at 23:36, Marc Kleine-Budde <mkl@pengutronix.de> wrot=
e:
> > There are 2 BUG_ON() in the CAN dev helpers. During the update/test of
> > the at91_can driver to rx-offload the one in can_restart() was
> > triggered, due to a race condition in can_restart() and a hardware
> > limitation of the at91_can IP core.
> >
> > This series fixes the race condition, replaces BUG_ON() with an error
> > message, and does some cleanup. Finally, the BUG_ON() in
> > can_put_echo_skb() is also replaced with error handling.
> >
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Notwithstanding of my nitpick on patch 4/5:
>=20
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>=20
> Side note, I did not received patch 1/5, 3/5 and 5/5 from this v2 and
> I do not see them either on
> https://lore.kernel.org/linux-can/20231005-can-dev-fix-can-restart-v2-0-9=
1b5c1fd922c@pengutronix.de/T/#me6e1b1ced8ceca1a3bc27b9b36b582a286fd259a
> Note sure if this is a send error on your end or some congestion on
> the mailing list.

It took me quite a long time to get these messages and there were also
some messages missing (don't remember which ones). But if you download
them with:

| b4 mbox 20231005-can-dev-fix-can-restart-v2-0-91b5c1fd922c@pengutronix.de

you get the whole series.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--p5mv7hh7pbp4ycax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUe/mgACgkQvlAcSiqK
BOjaXwgAqWjqZQzNUYn08TglJI7qpXcccgiWMvlgVeHggmuCvneL2ICxip016KM6
/qnOMt1eCvkYiMbCmaNhEQmO2z4eXDD6dXCYW5IDTyi+ey5nwtEyqmD+QkoPesLJ
RmQmdx1JA6WHO1C5n+YKhyrB/uVZqY6Gat+Or2UIH3Ho66NdtpRFrQpCFl6lTg8N
9fEqQ9MEwrWnMDpFS4B1w8qdE+iiwXGmUi6TuzGJqA13x9u9M5uIvI8uVoJywUnL
tbSIKPEgVDh2cXaLLyYons3+7T7jF0Jx3nprjn+snbit2tTbqRayfK8Vxecd3aB+
EIWxOnIudAUHbVrd3Gq9/+RulgHuug==
=z6Ay
-----END PGP SIGNATURE-----

--p5mv7hh7pbp4ycax--
