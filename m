Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D645F6BE8
	for <lists+linux-can@lfdr.de>; Thu,  6 Oct 2022 18:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiJFQiC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Oct 2022 12:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJFQiC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2022 12:38:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFFCCE9BD
        for <linux-can@vger.kernel.org>; Thu,  6 Oct 2022 09:38:01 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ogTsl-0004jt-SP; Thu, 06 Oct 2022 18:37:59 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3967FF6695;
        Thu,  6 Oct 2022 16:37:59 +0000 (UTC)
Date:   Thu, 6 Oct 2022 18:37:57 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: Re: [PATCH 6/6] can: gs_usb: support reading error counters
Message-ID: <20221006163757.whj3q2bavfu6mt4k@pengutronix.de>
References: <20221006162452.200322-1-mkl@pengutronix.de>
 <20221006162452.200322-7-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="acq3eyhv7ujrpalm"
Content-Disposition: inline
In-Reply-To: <20221006162452.200322-7-mkl@pengutronix.de>
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


--acq3eyhv7ujrpalm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.10.2022 18:24:52, Marc Kleine-Budde wrote:
> From: Jeroen Hofstee <jhofstee@victronenergy.com>
>=20
> the format of this message is a bit weird, single bytes would be
> sufficient. At the moment it uses the existing struct gs_device_state.

=46rom my point of view this looks good. The struct gs_device_state wasn't
used at all, yet! This is a good use of it.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--acq3eyhv7ujrpalm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmM/BGMACgkQrX5LkNig
011QRwgAtEa3I7+ILvMiv8XsyjMLwgCwk92EjwR+YYo82B4WCSZujAhrFrGlSK5H
sgNgNRiVydmIYwtEXHKmDxRzTTei1CymTMGXR5LT4eVTf/WhRC7jvdSPNU6wHwIL
J6KficpUfiBadwZO0EV4sEyCf1CHrog8Iqz2hIiD1YfhNL73I2ShUUQTsZVQQWRP
v2BgTw1+at39UWQ4fOwddh5L2FpCnvOf/330oWD9yXqhxMPTAaF6RN2CRbtYe1VT
1n7Lyikj7ZvFgYAy358yDzPgauj1vRnjRUSJOe9msrRExm/R4BXiyKT7Fkg82kJY
y3oRuubhh7KOs82L/NMh+FUk3hvEXw==
=bfwt
-----END PGP SIGNATURE-----

--acq3eyhv7ujrpalm--
