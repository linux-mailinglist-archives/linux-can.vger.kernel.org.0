Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C686252CD04
	for <lists+linux-can@lfdr.de>; Thu, 19 May 2022 09:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiESH3I (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 May 2022 03:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiESH24 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 May 2022 03:28:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2008AE6F
        for <linux-can@vger.kernel.org>; Thu, 19 May 2022 00:28:53 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nraaa-0006de-6D; Thu, 19 May 2022 09:28:52 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 694E381D2F;
        Thu, 19 May 2022 07:20:15 +0000 (UTC)
Date:   Thu, 19 May 2022 09:20:14 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH can-next] can: can-dev: remove obsolete CAN LED support
Message-ID: <20220519072014.pofabnlsnq3vcewq@pengutronix.de>
References: <20220518154527.29046-1-socketcan@hartkopp.net>
 <CAMZ6RqLSSUkqSQBE+bYzvKfp2=bAn8jk+byXQS5cM_7VrJj2-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhdtrkltmfauagkt"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLSSUkqSQBE+bYzvKfp2=bAn8jk+byXQS5cM_7VrJj2-Q@mail.gmail.com>
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


--zhdtrkltmfauagkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.05.2022 16:15:48, Vincent MAILHOL wrote:
> On Tue. 19 May 2022 at 00:52, Oliver Hartkopp <socketcan@hartkopp.net> wr=
ote:
> > Since commit 30f3b42147ba6f ("can: mark led trigger as broken") the
> > CAN specific LED support was disabled and marked as BROKEN. As the comm=
on
> > LED support with CONFIG_LEDS_TRIGGER_NETDEV should to this work now the
> > code can be removed as preparation for a CAN netdevice Kconfig rework.
> >
> > Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> [...]
> >  struct net_device *alloc_c_can_dev(int msg_obj_num)
> >  {
> > @@ -1376,12 +1367,11 @@ int register_c_can_dev(struct net_device *dev)
> >         dev->flags |=3D IFF_ECHO; /* we support local echo */
> >         dev->netdev_ops =3D &c_can_netdev_ops;
> >         c_can_set_ethtool_ops(dev);
> >
> >         err =3D register_candev(dev);
> > -       if (!err)
> > -               devm_can_led_init(dev);
> > +
> >         return err;
>=20
> I think we can remove the variable err and simply do:
>=20
> return register_candev(dev);

Updated.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--zhdtrkltmfauagkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKF76wACgkQrX5LkNig
013WRQf9H4Jaw+XfOiqz6XmpNVfg7vH5po0LlLGJi37AhDNovgANJWT6MiYzdr2Q
FI9wnpAA6DwW/AGmkcVfTgiWUCGi9dYBQdLInlA4gMXAKrrESkSL6LYGcpGMPUWg
kgRChl/qFaE0bTAp6meMlgbxciWzsoL+/FzwUpzWl7q4OigcgLWodUONO7fAQdJI
wFk0AkeAAs5DAZ8AgB7U7n6sO8xGpMzNFeUgSDDHei3i6xrv6HfIDTo3UiUI+yHQ
BchqHEHvGP9uZ/bSshEqec9oMjEtbn6PcQ2o8ERg0BwGxQAzUkfKEcHGv0ha0nWv
hJxbL/f+84eZC5fwZIffYOMg4/oBXg==
=xIqp
-----END PGP SIGNATURE-----

--zhdtrkltmfauagkt--
