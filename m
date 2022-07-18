Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21374577F2A
	for <lists+linux-can@lfdr.de>; Mon, 18 Jul 2022 12:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiGRKAX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Jul 2022 06:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiGRKAW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Jul 2022 06:00:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5793E1A81A
        for <linux-can@vger.kernel.org>; Mon, 18 Jul 2022 03:00:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oDNXv-0002Hb-7L; Mon, 18 Jul 2022 12:00:11 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 43A27B2F5B;
        Mon, 18 Jul 2022 10:00:09 +0000 (UTC)
Date:   Mon, 18 Jul 2022 12:00:08 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     linux-can@vger.kernel.org,
        Matej Vasilevski <matej.vasilevski@seznam.cz>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        David Miller <davem@davemloft.net>,
        Carsten Emde <c.emde@osadl.org>,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>
Subject: Re: [PATCH v1 0/1] can: ctucanfd: Update CTU CAN FD IP core
 registers to match version 3.x.
Message-ID: <20220718100008.xz5jfoppt335lkfm@pengutronix.de>
References: <cover.1658136506.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="772slo6xqaqbfhy6"
Content-Disposition: inline
In-Reply-To: <cover.1658136506.git.pisa@cmp.felk.cvut.cz>
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


--772slo6xqaqbfhy6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.07.2022 11:55:17, Pavel Pisa wrote:
> The 3.x CTU CAN FD IP core version provides informative fields
> with number of Tx registers count and most significant active
> (toggling) timestamp base bit.
>=20
> The fields are read as zero for older 2.x IP core version.
> The 4 Tx buffers and bit 63 MSB can be considered in such
> case and compatibility with 2.x core version is preserved.
>=20
> This change allows to update Matej Vasilevski's patch series
>=20
>   [RFC] can: ctucanfd: RX timestamping implementation
>=20
> to work with the platform bus and PCIe core integration
> without need of additional mandatory parameters.
>=20
> Only optional one for timestamp clock frequency can be
> used when bitrate base clock and timestamp clocks differ.
>=20
>   ts-frequency:
>     description: |
>       Frequency of the timestamping counter. Set this if you want to get
>       timestamps, but you didn't set the timestamping clock in clocks pro=
perty.

Can you model this as a standard clock property?

> The information about clocks frequencies on PCIe integration
> has to be provided by other means but we expect that it can
> be directly deduced from Vendor and Device IDs and corresponding
> device table.

Ack, or via ACPI (but that's a different topic).

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--772slo6xqaqbfhy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLVLyYACgkQrX5LkNig
011UEwgAmU1Et6UK/8Nuxif2w82d86k37QZO6SOF5syfdW7tB9LedNzql41nu6DQ
C/XaRP2+uupT/dp9sDrx0F9g5C1REaecf303P3BduDoxqe9vX/rL9MYxoB+uzCH4
gw6WMB0kJwDFkj5TLybP1XB8LiOyQkVTquRW+j+obWyeYp7YnaPw6GY0lJ4OzeIL
L9Bs6Dma2Ve3vAdtxmol7or0f7Jnm+qF0e4KtXmx3HVtiYEXKry6IXlNauFd38QZ
6m8Xo5KM92nQH5cGDUfn3XQlIxoqmpjHViyYJL58DhvqXmP+IkDOR5NGzHhWIIWj
hWxrRwcspVljjhU2VNWeZMBcrHGBFw==
=c9zL
-----END PGP SIGNATURE-----

--772slo6xqaqbfhy6--
