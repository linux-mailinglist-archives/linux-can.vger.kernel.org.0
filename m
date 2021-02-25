Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04339324CD0
	for <lists+linux-can@lfdr.de>; Thu, 25 Feb 2021 10:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbhBYJ1B (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Feb 2021 04:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbhBYJ06 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Feb 2021 04:26:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FB9C061574
        for <linux-can@vger.kernel.org>; Thu, 25 Feb 2021 01:26:17 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lFCuD-0000wy-01; Thu, 25 Feb 2021 10:25:57 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:55fd:a17b:b4ca:d5fb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A63875E8E50;
        Thu, 25 Feb 2021 09:25:51 +0000 (UTC)
Date:   Thu, 25 Feb 2021 10:25:50 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Dario Binacchi <dariobin@libero.it>, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Jakub Kicinski <kuba@kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        linux-can@vger.kernel.org,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Federico Vaga <federico.vaga@gmail.com>
Subject: Re: [PATCH 5/6] can: c_can: prepare to up the message objects number
Message-ID: <20210225092550.7si56liuid4hih3a@pengutronix.de>
References: <20210224225246.11346-6-dariobin@libero.it>
 <202102251401.8hMQFKMw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="33yk2wg3cv3vkv5t"
Content-Disposition: inline
In-Reply-To: <202102251401.8hMQFKMw-lkp@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--33yk2wg3cv3vkv5t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.02.2021 15:14:43, kernel test robot wrote:
> Hi Dario,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on mkl-can-next/testing]
> [also build test ERROR on linux/master net-next/master net/master linus/m=
aster next-20210225]
> [cannot apply to sparc-next/master v5.11]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>=20
> url:    https://github.com/0day-ci/linux/commits/Dario-Binacchi/can-c_can=
-add-support-to-64-messages-objects/20210225-070042
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-nex=
t.git testing
> config: x86_64-randconfig-a006-20210225 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project a921=
aaf789912d981cbb2036bdc91ad7289e1523)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/9bbfc6bc12c1d9a2445413b=
f6e710302f012c1ae
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Dario-Binacchi/can-c_can-add-sup=
port-to-64-messages-objects/20210225-070042
>         git checkout 9bbfc6bc12c1d9a2445413bf6e710302f012c1ae
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross AR=
CH=3Dx86_64=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
> >> drivers/net/can/c_can/c_can_pci.c:152:24: error: too few arguments to =
function call, single argument 'msg_obj_num' was not specified
>            dev =3D alloc_c_can_dev();
>                  ~~~~~~~~~~~~~~~ ^
>    drivers/net/can/c_can/c_can.h:212:20: note: 'alloc_c_can_dev' declared=
 here
>    struct net_device *alloc_c_can_dev(int msg_obj_num);
>                       ^
>    1 error generated.

For now you can use 16, which means no change. I've added Alexander
and Federico to Cc, they added the intel pch and st micro support, maybe
they can help and add the correct size.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--33yk2wg3cv3vkv5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA3bRsACgkQqclaivrt
76lFOggAm3wQHGpK+2bkoQTVZTkItD7BvS22yRyJzelLfoAnWMz49dpD7wsSbiL+
u8pli7iD365Cpa9pJXYHP3bnZx04AMnu68dvuK7X0gz4vT2DfUOEMf2ydZk8TUAx
1GZPLbKnkfp/cp88pIE5uaEuuOZvJOJqyzMj6XwUIZUpandN1FGVKX7dRd8ZoH5K
tqwAwTN/7HbL/lA1G+g/At8A1xGP23b9JoDVF8VA1IkZjR8ogX2/qy6Tj+6a7YRh
cJLYI+QJvEebJ5tq2rL9/EPUAWz+ajp3MdqaIGLFXGO4Ub8xjskrzCp9ydNaOoKh
Mnr8m/jgQDqtlgjzyHwy7LZkO8gHbw==
=rhdl
-----END PGP SIGNATURE-----

--33yk2wg3cv3vkv5t--
