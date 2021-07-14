Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7670A3C91D6
	for <lists+linux-can@lfdr.de>; Wed, 14 Jul 2021 22:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbhGNULe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 14 Jul 2021 16:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243492AbhGNUKn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Jul 2021 16:10:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A84C0613DB
        for <linux-can@vger.kernel.org>; Wed, 14 Jul 2021 12:56:43 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m3kzo-0000ut-Eo; Wed, 14 Jul 2021 21:56:40 +0200
Date:   Wed, 14 Jul 2021 21:56:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-can@vger.kernel.org
Subject: Re: [mkl-can-next:testing 5/28] net/can/j1939/transport.c:811:25:
 error: 'skcb' undeclared
Message-ID: <20210714195635.fys4qsrxf7477uvy@pengutronix.de>
References: <202106282235.1qQJIrzU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lntyjxsddjdx3xd7"
Content-Disposition: inline
In-Reply-To: <202106282235.1qQJIrzU-lkp@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--lntyjxsddjdx3xd7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.06.2021 22:34:42, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-nex=
t.git testing
> head:   ca9280f6324bf09ec5d3667579f7dd3f7567e809
> commit: a2ea50608a02ac48371a9fab0167c1b44457913e [5/28] can: j1939: j1939=
_session_tx_dat(): use consistent name se_skcb for session skb control buff=
er
> config: i386-randconfig-a011-20210628 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=3D1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-n=
ext.git/commit/?id=3Da2ea50608a02ac48371a9fab0167c1b44457913e
>         git remote add mkl-can-next https://git.kernel.org/pub/scm/linux/=
kernel/git/mkl/linux-can-next.git
>         git fetch --no-tags mkl-can-next testing
>         git checkout a2ea50608a02ac48371a9fab0167c1b44457913e
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         make W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from include/net/sock.h:46,
>                     from include/linux/can/skb.h:17,
>                     from net/can/j1939/transport.c:11:
>    net/can/j1939/transport.c: In function 'j1939_session_tx_dat':
> >> net/can/j1939/transport.c:811:25: error: 'skcb' undeclared (first use =
in this function)
>      811 |      __func__, session, skcb->offset,
>          |                         ^~~~
>    include/linux/netdevice.h:5255:36: note: in definition of macro 'netde=
v_level_once'
>     5255 |   netdev_printk(level, dev, fmt, ##__VA_ARGS__); \
>          |                                    ^~~~~~~~~~~
>    net/can/j1939/transport.c:809:4: note: in expansion of macro 'netdev_e=
rr_once'
>      809 |    netdev_err_once(priv->ndev,
>          |    ^~~~~~~~~~~~~~~
>    net/can/j1939/transport.c:811:25: note: each undeclared identifier is =
reported only once for each function it appears in
>      811 |      __func__, session, skcb->offset,
>          |                         ^~~~
>    include/linux/netdevice.h:5255:36: note: in definition of macro 'netde=
v_level_once'
>     5255 |   netdev_printk(level, dev, fmt, ##__VA_ARGS__); \
>          |                                    ^~~~~~~~~~~
>    net/can/j1939/transport.c:809:4: note: in expansion of macro 'netdev_e=
rr_once'
>      809 |    netdev_err_once(priv->ndev,
>          |    ^~~~~~~~~~~~~~~

Fixed, thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--lntyjxsddjdx3xd7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDvQXAACgkQqclaivrt
76m8lggAi2zeVruh7rp6H4BbwZ0ntLGhaTCOdTIyvpjLwYx0LR92T1gE3HvEBfkm
zZSaOeKPJBPE8JnIEhWY5kSxODDZV8kRf1svRyJ/Acb4yS8aDYFrwvxPOVglbCmW
J7K49xBG4OFZX0MTwz8Ik1wXDp7sZOavULcozgMkLWJgmjnZUS7WdZiJReZ/seuj
/zjHX7FgabkKupFNywHdHp+yr3mOpxSfARagSVTkGrUd8P5uF2l9j+i+nefaridu
fXIzEIjuChnuEYEY7vth30KJh412VsTx6AWOKYQS1jmhSp1waFVzdZFwqGJTzucC
HxDln6OilZZ1jI9Ac8tP74Os+jQECQ==
=qSVz
-----END PGP SIGNATURE-----

--lntyjxsddjdx3xd7--
