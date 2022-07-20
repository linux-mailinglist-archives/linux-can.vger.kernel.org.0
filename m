Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A157457B18B
	for <lists+linux-can@lfdr.de>; Wed, 20 Jul 2022 09:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiGTHR1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Jul 2022 03:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiGTHRX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Jul 2022 03:17:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C45266BB5
        for <linux-can@vger.kernel.org>; Wed, 20 Jul 2022 00:17:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oE3xP-0001Rq-R9; Wed, 20 Jul 2022 09:17:19 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 91C73B5458;
        Wed, 20 Jul 2022 07:17:18 +0000 (UTC)
Date:   Wed, 20 Jul 2022 09:17:17 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Stefan =?utf-8?B?TcOkdGpl?= <Stefan.Maetje@esd.eu>
Subject: Re: [PATCH v2 00/12] can: error: set of fixes and improvement on
 txerr and rxerr reporting
Message-ID: <20220720071717.q7egrzu2fjc2c64i@pengutronix.de>
References: <20220719143550.3681-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ltdqtqampmjbhso5"
Content-Disposition: inline
In-Reply-To: <20220719143550.3681-1-mailhol.vincent@wanadoo.fr>
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


--ltdqtqampmjbhso5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.07.2022 23:35:38, Vincent Mailhol wrote:
> This series is a collection of patches targeting the CAN error
> counter. The series is split in three blocks (with small relation to
> each other).
>=20
> Several drivers uses the data[6] and data[7] fields (both of type u8)
> of the CAN error frame to report those values. However, the maximum
> size an u8 can hold is 255 and the error counter can exceed this value
> if bus-off status occurs. As such, the first nine patches of this
> series make sure that no drivers try to report txerr or rxerr through
> the CAN error frame when bus-off status is reached.
>=20
> can_frame::data[5..7] are defined as being "controller
> specific". Controller specific behaviors are not something desirable
> (portability issue...) The tenth patch of this series specifies how
> can_frame::data[5..7] should be use and remove any "controller
> specific" freedom. The eleventh patch adds a flag to notify though
> can_frame::can_id that data[6..7] were populated (in order to be
> consistent with other fields).
>=20
> Finally, the twelfth and last patch add three macro values to specify
> the different error counter threshold with so far was hard-coded as
> magic numbers in the drivers.
>=20
> N.B.:
>   * patches 1 to 10 are for net (stable).
>   * patches 11 and 12 are for net-next (but depends on patches 1 to 10).

IMHO the patches 1..10 are not so critical that they need to go upstream
via net. Especially that we're already at -rc7. I'll take all via
can-next, OK?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ltdqtqampmjbhso5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLXq/oACgkQrX5LkNig
011EVwf+M8+JFtCgTyh3dy8Tg5rNG7pg8u38Lvf7o3MSkgkUuS2LCeA7JSID69kE
epAapSnOjb1jYJ5HBeBU8i5yCQsubz0Zml/YAYNb6J5uo4ixDwhK2xBfExeTKZ43
BkY5jiKCP9c/ZG/eia0EiXxXXtsPC+DLIJxHBj7Ym5soQ7oFGgm2FSDMphfHwzU9
gzU9e4APRUqABvnaesr//CaT9JXpqp66KHrxEp0+ZIzFM0Eok5O9YV8FBfJyzLnn
L16g7fPlwt5igjdaE8D9q+aGjwJVPWQYBYiura5PyuxVKj+trqgR+GFHgXIVnJzG
DDvgo/SZnREr7xd6vLc4l4r0oxnGHQ==
=+VKX
-----END PGP SIGNATURE-----

--ltdqtqampmjbhso5--
