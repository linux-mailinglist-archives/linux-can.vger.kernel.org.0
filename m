Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E605E79B6
	for <lists+linux-can@lfdr.de>; Fri, 23 Sep 2022 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIWLgr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Sep 2022 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiIWLgp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Sep 2022 07:36:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EBBC8416
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 04:36:43 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1obgz2-000306-M2; Fri, 23 Sep 2022 13:36:40 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EC4F1EB0A5;
        Fri, 23 Sep 2022 11:36:38 +0000 (UTC)
Date:   Fri, 23 Sep 2022 13:36:38 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jacob Kroon <jacob.kroon@gmail.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com, dariobin@libero.it
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Message-ID: <20220923113638.tjnbuvkzdq24c4as@pengutronix.de>
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
 <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
 <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jhwmrckhnwpb7fas"
Content-Disposition: inline
In-Reply-To: <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
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


--jhwmrckhnwpb7fas
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.09.2022 06:14:58, Jacob Kroon wrote:
> What I do know is that if I revert commit:
>=20
> "can: c_can: cache frames to operate as a true FIFO"
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D387da6bc7a826cc6d532b1c0002b7c7513238d5f
>=20
> then everything looks good. I don't get any BUG messages, and the host
> has been running overnight without problems, so it seems to have fixed
> the network interface lockup as well.

Jacob, after this mail, I'll send 2 patches. One tries to disable the
cache feature for C_CAN cores, the other shuts a potential race window.
Please test both patches, but only apply one of them at a time. :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jhwmrckhnwpb7fas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMtmkMACgkQrX5LkNig
0132iggAnHX6BHzzdhth+nj1DS5Q2PEZTlVi6vidPQidMkelxbC00RbJoJ2ZEq/J
TdqA5GOT5/csvoiq+JBJpVhQcXEievY5ZL7sF53dJGCBz30yp5dgYE81XVA7CEJK
lfRiCdQyfUn5QS7rsNstrWb+5AoGM8jwijsd+4Fpp/8W9t+Q/Kd9J/wBMKMtf5nf
Dkh6FdJ46pprrQ7Nx1GslMcMyXV3r7ccw5jZq3hmdjDkBHAygeiwI66AQU2t0wnT
nTbsfZ2Xtc2eM6iR8GJWagxlFEpphr2hdr87tqGs/f22ZEkUjSJ1SPTzu+IgjLzn
J9DUxhhoXDtqaPYObMrHRVVB31e+pA==
=PKwJ
-----END PGP SIGNATURE-----

--jhwmrckhnwpb7fas--
