Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B60F7B7EA4
	for <lists+linux-can@lfdr.de>; Wed,  4 Oct 2023 14:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjJDMFp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Oct 2023 08:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjJDMFo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Oct 2023 08:05:44 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15037A1
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 05:05:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qo0dH-0004YV-JF; Wed, 04 Oct 2023 14:05:39 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qo0dG-00B1Hz-Un; Wed, 04 Oct 2023 14:05:38 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A254922EE32;
        Wed,  4 Oct 2023 12:05:38 +0000 (UTC)
Date:   Wed, 4 Oct 2023 14:05:38 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH 4/5] can: dev: can_restart(): update debug and error
 messages
Message-ID: <20231004-goes-pulse-0ed144520edd-mkl@pengutronix.de>
References: <20231004-can-dev-fix-can-restart-v1-0-2e52899eaaf5@pengutronix.de>
 <20231004-can-dev-fix-can-restart-v1-4-2e52899eaaf5@pengutronix.de>
 <CAMZ6Rq+=iaRCroX7kQT5f-+qq5iBv3kFX_sytV8BmF0BcrtX2g@mail.gmail.com>
 <20231004-unengaged-monkhood-a2031eac6013-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2sxhl5xs5pw7puje"
Content-Disposition: inline
In-Reply-To: <20231004-unengaged-monkhood-a2031eac6013-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--2sxhl5xs5pw7puje
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.10.2023 13:33:59, Marc Kleine-Budde wrote:
> On 04.10.2023 19:44:15, Vincent Mailhol wrote:
> > On Wed. 4 Oct. 2023, 18:18, Marc Kleine-Budde <mkl@pengutronix.de> wrot=
e:
> > >
> > > Update the debug message from "restarted" to "Attempting restart", as
> > > it is actually printed _before_ restarting the CAN device, and that
> > > restart may fail.
> > >
> > > Also update the error message from printing the error number to
> > > printing symbolic error names.
> > >
> > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > ---
> > >  drivers/net/can/dev/dev.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> > > index 9014256c486a..8e4054e2abcc 100644
> > > --- a/drivers/net/can/dev/dev.c
> > > +++ b/drivers/net/can/dev/dev.c
> > > @@ -147,14 +147,14 @@ static void can_restart(struct net_device *dev)
> > >                 netif_rx(skb);
> > >         }
> > >
> > > -       netdev_dbg(dev, "restarted\n");
> > > +       netdev_dbg(dev, "Attempting restart\n");
> > >         priv->can_stats.restarts++;

What about that counter? Also move it into the no-error case?

Marc

> > >
> > >         /* Now restart the device */
> > >         netif_carrier_on(dev);
> > >         err =3D priv->do_set_mode(dev, CAN_MODE_START);
> > >         if (err) {
> > > -               netdev_err(dev, "Error %d during restart", err);
> > > +               netdev_err(dev, "Restart failed, error %pe\n", ERR_PT=
R(err));
> > >                 netif_carrier_off(dev);
> > >         }
> >=20
> >=20
> > Nitpick: I would rather remove the first message and print the
> > affirmative: "restarted"
> >=20
> >         if (err) {
> >                 netdev_err(dev, "Restart failed, error %pe\n", ERR_PTR(=
err));
> >                 netif_carrier_off(dev);
> >         } else {
> >                 netdev_dbg(dev, "Restarted\n");
> >         }

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2sxhl5xs5pw7puje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUdVQ8ACgkQvlAcSiqK
BOjVKAgAsESKaG2pAbt3m46EgzbFzZmvLD+S1i4xKUQLFV+RxNcNPtgti5VVnHdo
+BvyENcNC3/eL8gjzB5NDnFP7gg7P2pXC2KvMqcVhmLUkkNvSkVACcd7TE+cnHoc
rySXU0cQmI7ZOXcwkCC9Rhuk7C2U/GoZ7RabnQxxEPSSaOrQfEpd2OqH1VRf1wec
5sh6H8mhOdM1TpITA3yYcP5BMfbwiOBpM+De3i7dDSONMa52SFYa/BSTh/t87AtF
UaV8GFBdPYGMuQvhRYcDr47JSvJvggvRY5toVf64Jy2m274VMUvK4PLvqCIpi2Dc
U/WttlBm4ltGPXBgCsNelugR4bhqqA==
=tw9k
-----END PGP SIGNATURE-----

--2sxhl5xs5pw7puje--
