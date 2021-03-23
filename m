Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F40345997
	for <lists+linux-can@lfdr.de>; Tue, 23 Mar 2021 09:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhCWIYe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Mar 2021 04:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCWIYU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Mar 2021 04:24:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D86C061574
        for <linux-can@vger.kernel.org>; Tue, 23 Mar 2021 01:24:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lOcKj-0003QS-AO; Tue, 23 Mar 2021 09:24:13 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:c81e:25b5:b851:4b31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BDA3B5FDC97;
        Tue, 23 Mar 2021 08:24:09 +0000 (UTC)
Date:   Tue, 23 Mar 2021 09:24:09 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] can: uapi: can.h: mark union inside struct can_frame
 packed
Message-ID: <20210323082409.rakcci75aqodp66l@pengutronix.de>
References: <20210322102814.402850-1-mkl@pengutronix.de>
 <61ef8390-6c08-8fcc-4753-5294483ec41a@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ecsxf7t3x2jz7sqb"
Content-Disposition: inline
In-Reply-To: <61ef8390-6c08-8fcc-4753-5294483ec41a@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ecsxf7t3x2jz7sqb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.03.2021 17:27:38, Oliver Hartkopp wrote:
>=20
>=20
> On 22.03.21 11:28, Marc Kleine-Budde wrote:
> > In commit ea7800565a12 ("can: add optional DLC element to Classical
> > CAN frame structure") the struct can_frame::can_dlc was put into an
> > anonymous union with another u8 variable.
> >=20
> > For various reasons some members in struct can_frame and canfd_frame
> > including the first 8 byes of data are expected to have the same
> > memory layout. This is enforced by a BUILD_BUG_ON check in af_can.c.
> >=20
> > Since the above mentioned commit this check fails on at least one compi=
ler
> > (arm-linux-gnueabi-gcc (GCC) 9.3.0). Rong Chen analyzed the problem
> > and found that the union in struct can_frame takes 4 bytes instead of
> > the expected 1:
> >=20
> > | struct can_frame {
> > |          canid_t                    can_id;               /* 0     4 =
*/
> > |          union {
> > |                  __u8               len;                  /* 4     1 =
*/
> > |                  __u8               can_dlc;              /* 4     1 =
*/
> > |          };                                               /* 4     4 =
*/
> > |          __u8                       __pad;                /* 8     1 =
*/
> > |          __u8                       __res0;               /* 9     1 =
*/
> > |          __u8                       len8_dlc;             /* 10     1=
 */
> > |
> > |          /* XXX 5 bytes hole, try to pack */
> > |
> > |          __u8                       data[8]
> > | __attribute__((__aligned__(8))); /*    16     8 */
> > |
> > |          /* size: 24, cachelines: 1, members: 6 */
> > |          /* sum members: 19, holes: 1, sum holes: 5 */
> > |          /* forced alignments: 1, forced holes: 1, sum forced holes: =
5 */
> > |          /* last cacheline: 24 bytes */
> > | } __attribute__((__aligned__(8)));
> >=20
> > Marking the union as packed fixes the problem.
>=20
> Is this a proper answer to this issue?

With the affected compiler, yes. This patch makes the union 1 byte long,
as expected. This effectively fixes compiling.

I'm glad that the build bug triggered, which avoids having a broken
running kernel.

> Shouldn't this problem cause the developer to update the compiler?

The question is, are the other silent corruptions with a similar union
somewhere? Maybe we should escalate this problem to the linux-arm-kernel
ML.

Rong Chen, can I download the compiler you're using somewhere?

> https://lore.kernel.org/linux-can/f8075a19-10e1-abf9-6d59-1a46454b74b1@ha=
rtkopp.net/T/#u

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ecsxf7t3x2jz7sqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBZpaUACgkQqclaivrt
76loiwf+Ivo40/yU6q8ayQG2wUDRZwJVdgHCPmPmOTZKMn2DIU/i9CGOiTGif/cx
IQJd3K5k0V0DXzgulYRIy2SSKaG624juLDZeVu51bL0zelk+GgD7of49rixnuZs/
67DnW3WvhmbxjZjoWZUV8wPZU1oDhP8A3S4vWXrYGtAdxbED/42uSnNhGKPj8Y4c
Rpum+voX54apxzBlYWD4I+msxHtMCkjTy+yVZ2qn9nPxfW5kCe3H1VU54U25ahhE
Zgm1GBNskOdMrigJAfyeuwtqPnmipMRLPynjb0t5kkRADd5GIWvXc8mvi5pPul5w
tvbNcPD7taa+9V3SUBc7YouISyD7mA==
=vfNT
-----END PGP SIGNATURE-----

--ecsxf7t3x2jz7sqb--
