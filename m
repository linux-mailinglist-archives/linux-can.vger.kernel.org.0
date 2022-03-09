Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951394D2DD6
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 12:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiCILUg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Mar 2022 06:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiCILUf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2022 06:20:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BBC13DFE
        for <linux-can@vger.kernel.org>; Wed,  9 Mar 2022 03:19:36 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nRuLr-0008TC-7g; Wed, 09 Mar 2022 12:19:31 +0100
Received: from pengutronix.de (unknown [IPv6:2a02:908:393:af61:11a6:6968:f87e:ee79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 86C5B46A72;
        Wed,  9 Mar 2022 11:19:30 +0000 (UTC)
Date:   Wed, 9 Mar 2022 12:19:29 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-can@vger.kernel.org
Subject: Re: [mkl-can-next:mcp251xfd-coalesce 13/13]
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c:15: warning: "DEBUG"
 redefined
Message-ID: <20220309111929.cirh6ylavshx7zih@pengutronix.de>
References: <202203091937.M6ZzGYRk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p4h773sr7efcpufc"
Content-Disposition: inline
In-Reply-To: <202203091937.M6ZzGYRk-lkp@intel.com>
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


--p4h773sr7efcpufc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2022 19:14:46, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-nex=
t.git mcp251xfd-coalesce
> head:   031271d0164fc7de0efbc0afa8d4fada3197b30e
> commit: 031271d0164fc7de0efbc0afa8d4fada3197b30e [13/13] can: mcp251xfd: =
mcp251xfd-ring: enable DEBUG for now to print FIFO configuration overview d=
uring ifup
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220=
309/202203091937.M6ZzGYRk-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-n=
ext.git/commit/?id=3D031271d0164fc7de0efbc0afa8d4fada3197b30e
>         git remote add mkl-can-next https://git.kernel.org/pub/scm/linux/=
kernel/git/mkl/linux-can-next.git
>         git fetch --no-tags mkl-can-next mcp251xfd-coalesce
>         git checkout 031271d0164fc7de0efbc0afa8d4fada3197b30e
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cro=
ss O=3Dbuild_dir ARCH=3Dalpha SHELL=3D/bin/bash drivers/net/can/spi/mcp251x=
fd/
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
> >> drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c:15: warning: "DEBUG" re=
defined
>       15 | #define DEBUG
>          |=20
>    <command-line>: note: this is the location of the previous definition

Good Bot!

It's branch is for testing, but I've wrapped this in a #ifndef...#endif
to fix this warning.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--p4h773sr7efcpufc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIojT8ACgkQrX5LkNig
011Slwf+IaOeOJWNALxSxGTIGZy9FI69svssslu1dgjIwSIps3cMUWZAUEbur1Z7
TZ7MrEVUVHvi0Aa8qQyGvSQ47+rr+o/+x1FNoZna1Cy2ZFBf6NllXpEXzrQhoPAF
XRQJdAtDVPFV68gA8lD3QurrMjaIAMOjImgT9NlP3tbD3GpUvNpOUQaa5US3E+Eq
82Iv4yzMrIuFKUTkgnNzGjG4CnR2pk/A2goR2q58idGIyiZh2U0lkK+9S9tR/p2K
TK67HA93JP3ywoQzTqZbXPYyBfIUFuiJiHw3SDlokkp1X8lflnvxZ35WBMAlodDM
IrYST64qACV8Wgr5N5nlY8N5glQhGA==
=uNyS
-----END PGP SIGNATURE-----

--p4h773sr7efcpufc--
