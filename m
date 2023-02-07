Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244E068E1C9
	for <lists+linux-can@lfdr.de>; Tue,  7 Feb 2023 21:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjBGUTJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Feb 2023 15:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBGUTI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Feb 2023 15:19:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769D522A31
        for <linux-can@vger.kernel.org>; Tue,  7 Feb 2023 12:19:07 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pPUQe-00070M-1F; Tue, 07 Feb 2023 21:19:00 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1929:cbfc:e29:aaab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4386B172C16;
        Tue,  7 Feb 2023 20:18:59 +0000 (UTC)
Date:   Tue, 7 Feb 2023 21:18:50 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-can@vger.kernel.org
Subject: Re: [mkl-can-next:testing 42/51]
 drivers/net/can/dev/bittiming.c:79:24: error: too many arguments to function
 'can_calc_bittiming'
Message-ID: <20230207201850.ayya2ehn4vzx7cmj@pengutronix.de>
References: <202302080358.PGPjdXwE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xtpwsodwfe3rblpf"
Content-Disposition: inline
In-Reply-To: <202302080358.PGPjdXwE-lkp@intel.com>
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


--xtpwsodwfe3rblpf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.02.2023 04:00:53, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-nex=
t.git testing
> head:   3dafbe5cc1409dd2e3fc2955b0026c1ba7dfa323
> commit: 286c0e09e8e07de0f116a01aa234b05d9956dcf5 [42/51] can: bittiming: =
can_changelink() pass extack down callstack
> config: parisc-randconfig-r026-20230205 (https://download.01.org/0day-ci/=
archive/20230208/202302080358.PGPjdXwE-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-n=
ext.git/commit/?id=3D286c0e09e8e07de0f116a01aa234b05d9956dcf5
>         git remote add mkl-can-next https://git.kernel.org/pub/scm/linux/=
kernel/git/mkl/linux-can-next.git
>         git fetch --no-tags mkl-can-next testing
>         git checkout 286c0e09e8e07de0f116a01aa234b05d9956dcf5
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dparisc olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dparisc SHELL=3D/bin/bash drivers/net/can/dev/
>=20
> If you fix the issue, kindly add following tag where applicable

Good Bot!

> | Reported-by: kernel test robot <lkp@intel.com>

Done: here's a fix:
https://lore.kernel.org/20230207201734.2905618-1-mkl@pengutronix.de

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xtpwsodwfe3rblpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmPisicACgkQvlAcSiqK
BOh7MAgArURMS14YdkwSHs3jOrMji9PE4FopG6sctystZI4/MXf/e2Ps/pF6OGw3
rPPKVH6/TyFhwklN22NizH/PG+YFWCxniMbNS20bHp6YgADICOUk7NG550BJsTV+
r5Xc5b3hywyLGGoe/qfRcdCqEs+TIWnzxyWZb60bX1PUYkP9EWsr+ym86+tJOBpw
kkKM5SUt8F29eXnEMYhVXiqJby7mYYkRmaMxlQmcEQza8bMkLE80udaOXVo8efP7
o4CitSpPspnTHl1LWkOXPyWBe4GMyEz8H6MPdSx7cG6l9aiTI5fcMeGtj4w/U4WJ
amgYIBszBVmRen/L7WB4ipuq6xHb5w==
=HY00
-----END PGP SIGNATURE-----

--xtpwsodwfe3rblpf--
