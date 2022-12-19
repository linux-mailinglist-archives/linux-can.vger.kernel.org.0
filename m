Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40218650F94
	for <lists+linux-can@lfdr.de>; Mon, 19 Dec 2022 16:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiLSP6e (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Dec 2022 10:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiLSP6C (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Dec 2022 10:58:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD47212758
        for <linux-can@vger.kernel.org>; Mon, 19 Dec 2022 07:56:54 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1p7IVW-0002w5-DS; Mon, 19 Dec 2022 16:56:50 +0100
Received: from pengutronix.de (hardanger-4.fritz.box [IPv6:2a03:f580:87bc:d400:7364:f246:2657:e234])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1AB3A14324F;
        Mon, 19 Dec 2022 15:56:46 +0000 (UTC)
Date:   Mon, 19 Dec 2022 16:56:45 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        speakup@linux-speakup.org, linux-can@vger.kernel.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 ca39c4daa6f7f770b1329ffb46f1e4a6bcc3f291
Message-ID: <20221219155645.b7oklerzvqq54htm@pengutronix.de>
References: <639c8c39./q+QZSDrWluXOpoJ%lkp@intel.com>
 <20221216155639.wp2t6wqtcfzw3ov2@pengutronix.de>
 <490c3e2d-5f84-d045-416e-9138464a58e6@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="36f6djdrk7ttv2st"
Content-Disposition: inline
In-Reply-To: <490c3e2d-5f84-d045-416e-9138464a58e6@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--36f6djdrk7ttv2st
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.12.2022 15:13:55, Chen, Rong A wrote:
>=20
>=20
> On 12/16/2022 11:56 PM, Marc Kleine-Budde wrote:
> > On 16.12.2022 23:18:17, kernel test robot wrote:
> > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/lin=
ux-next.git master
> > > branch HEAD: ca39c4daa6f7f770b1329ffb46f1e4a6bcc3f291  Add linux-next=
 specific files for 20221216
> > >=20
> > > Error/Warning reports:
> > >=20
> > > https://lore.kernel.org/oe-kbuild-all/202211180516.dtOWIlEo-lkp@intel=
=2Ecom
> > > https://lore.kernel.org/oe-kbuild-all/202211180955.UiXgTkeu-lkp@intel=
=2Ecom
> > > https://lore.kernel.org/oe-kbuild-all/202211190207.Rf66o1j0-lkp@intel=
=2Ecom
> > > https://lore.kernel.org/oe-kbuild-all/202211242120.MzZVGULn-lkp@intel=
=2Ecom
> > > https://lore.kernel.org/oe-kbuild-all/202212020520.0OkMIno3-lkp@intel=
=2Ecom
> > > https://lore.kernel.org/oe-kbuild-all/202212051759.cEv6fyHy-lkp@intel=
=2Ecom
> > > https://lore.kernel.org/oe-kbuild-all/202212142121.vendKsOc-lkp@intel=
=2Ecom
> > >=20
> > > Error/Warning: (recently discovered and may have been fixed)
> > I think none of these Errors/Warnings are linux-can related, am I
> > missing something?

> There's a warning related to linux-can:
>=20
>   Documentation/networking/devlink/etas_es58x.rst: WARNING: document isn'=
t included in any toctree

Doh! Fixed with my latest pull request:
https://lore.kernel.org/all/20221219155210.1143439-2-mkl@pengutronix.de/

> and here is the report: https://lore.kernel.org/oe-kbuild-all/CAMZ6RqL23h=
bqNsMk8F8wjN5fEs2wwRBwO++FQu=3DGEFRQWPO0Dw@mail.gmail.com/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--36f6djdrk7ttv2st
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmOgibsACgkQrX5LkNig
0131lQf9HFSteXnNsZq/8KXaZKNFI1c3lye1zbVrqpqOsDtWCwpmQ3CQYIkie+OS
j++KvsJKm8asRhoWlAGp0MkzGGhE5m+1D2xzHDOZCOORgMSGxRSkidv6Hoc2yoI1
QK/VdEDmk1j4ziyFfdv6peK4+HrZ3LtPZr5LzqYvOVpOJDMp9Ad+0RdYmGOndG6a
Lmb7K2XW/nI6CaqRF7SIcEHuszxm/AOgU2CPDipaqmjNiDfPSf7/1f2nvsp6rM/6
sVWuuijYjFQA5KycPU1N9Pvej+i1Qi6oAFp6QkPNgA2RsVB7cUZdJGH9aiymqKI7
F5ErgH6vN04m8OpcVGVXnHxCSDzAhg==
=wHM2
-----END PGP SIGNATURE-----

--36f6djdrk7ttv2st--
