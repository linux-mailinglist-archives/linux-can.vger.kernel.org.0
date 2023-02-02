Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211AF6884BD
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 17:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBBQpu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 11:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBBQpt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 11:45:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609EC6B378
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 08:45:48 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNciW-0006oc-Ea; Thu, 02 Feb 2023 17:45:44 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:fff9:bfd9:c514:9ad9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BEDBF16D885;
        Thu,  2 Feb 2023 16:45:42 +0000 (UTC)
Date:   Thu, 2 Feb 2023 17:45:34 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Lukas Magel <lukas.magel@posteo.net>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [RESEND PATCH v3 0/8] can: peak_usb: Introduce configurable CAN
 channel ID
Message-ID: <20230202164534.736my4ckllpm6f5f@pengutronix.de>
References: <20230116200932.157769-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tm47popglchxdgmt"
Content-Disposition: inline
In-Reply-To: <20230116200932.157769-1-lukas.magel@posteo.net>
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


--tm47popglchxdgmt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.01.2023 20:09:24, Lukas Magel wrote:
> This series of patches introduces the CAN channel ID for the PEAK USB
> CAN interfaces. The id can be read/written via ethtool and is exposed as
> a read-only attribute via sysfs. This allows users to set the id via
> ethtool and write udev rules to match against the sysfs attribute.
>=20
> Part of the patches were originally introduced by St=C3=A9phane Grosjean =
and
> were modified. See the following threads for the original patches:
>=20
> * https://lore.kernel.org/linux-can/20220128150157.1222850-1-s.grosjean@p=
eak-system.com/T/#mad8014c9f1c89a50d5944a50ae0a585edec79eab
> * https://lore.kernel.org/linux-can/20211117150132.37056-1-s.grosjean@pea=
k-system.com/T/#mbf1d7db8433734a1fe08868d79f9927a04fe7ffe

[...]

> Hi Marc,
>=20
> a happy late new year!

Even later happy new year! :)

> I noticed that the patch order in my first v3
> submission got messed up, so I'm sending it again. I hope that with the
> v3 changes the patch series now finds the approval of you and the netdev
> list.

Applied to linux-can-next. It will be included in my next pull request,
let's see what the netdev people say.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--tm47popglchxdgmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmPb6KsACgkQvlAcSiqK
BOh7bwgAqu1CvakLXc1Pf7fmjZ/PUjDo2lICGFJbTTWkljrmaK6nXFFOHwhngXxP
nxoi1P7IdegI+WjbuMVwsMOR6PgqqHqXMABULLsQfSvRAvi5AYW5xy0lMIeQI2BE
kWxEB08atnLVHR93naGyt6Als/MzHBMAKFjoZeEKQ/zg2fUFqgQczGW76EQcz1sI
iwf6J+1yqWnWl80nysZ3aM0PimOAvJmRrjXUXZ2+BNyrrMZIBu0F98Ti0AAPXtns
lEqAHVbY0zWRhtIk43dyBTZY54I6cbqP1o8sZVae2/F8V3WX2KaFAxgCuE2ov7Hk
oC9lytmxJ/1mF5n8IdXkHTxdc8C5og==
=/V+8
-----END PGP SIGNATURE-----

--tm47popglchxdgmt--
