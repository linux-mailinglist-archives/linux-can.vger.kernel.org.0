Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003F060DCD7
	for <lists+linux-can@lfdr.de>; Wed, 26 Oct 2022 10:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiJZIOk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Oct 2022 04:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiJZIOj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Oct 2022 04:14:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD070D2FA
        for <linux-can@vger.kernel.org>; Wed, 26 Oct 2022 01:14:36 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1onbYY-0003nd-Gx; Wed, 26 Oct 2022 10:14:34 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EFB4B10A02E;
        Wed, 26 Oct 2022 08:14:32 +0000 (UTC)
Date:   Wed, 26 Oct 2022 10:14:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Anssi Hannula <anssi.hannula@bitwise.fi>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH can-next v5 01/11] can: kvaser_usb: Fix possible
 completions during init_completion
Message-ID: <20221026081432.5lrzl5tkcfp7gzxj@pengutronix.de>
References: <20221010185237.319219-1-extja@kvaser.com>
 <20221010185237.319219-2-extja@kvaser.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="btmyderg6ldficmi"
Content-Disposition: inline
In-Reply-To: <20221010185237.319219-2-extja@kvaser.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--btmyderg6ldficmi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.10.2022 20:52:27, Jimmy Assarsson wrote:
> From: Anssi Hannula <anssi.hannula@bitwise.fi>
>=20
> kvaser_usb uses completions to signal when a response event is received
> for outgoing commands.
>=20
> However, it uses init_completion() to reinitialize the start_comp and
> stop_comp completions before sending the start/stop commands.
>=20
> In case the device sends the corresponding response just before the
> actual command is sent, complete() may be called concurrently with
> init_completion() which is not safe.
>=20
> This might be triggerable even with a properly functioning device by
> stopping the interface (CMD_STOP_CHIP) just after it goes bus-off (which
> also causes the driver to send CMD_STOP_CHIP when restart-ms is off),
> but that was not tested.
>=20
> Fix the issue by using reinit_completion() instead.

Looks like this should go to net instead of net-next.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--btmyderg6ldficmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNY7GQACgkQrX5LkNig
012pkAgAspVKyK2hF+HokTPyPeT3WKx2xgduyJjgjPS3b4FWc01C6VG6JXHWp4XK
zLYKDadi4lR1UmBFp618uLI5TeI2Ax1Gf+0dNCn661mYMt6dz1+JdFdwgSEQ5LHg
yU/TOig+oXmwH0nhEQTHZN/CNypjq0dSQEyTlB94ZUyTcXuJGzGWxnGW0V3elgxF
ED7EeV465BqlL1H49uYigEmH7O4gdtdT3Olb2XIAnb/tFTVxZ6dBXSxo0QqOoejk
TLHlS+dQ0TL6Kb1+4ds9AYFCxNDyNrXe7mGkAIsPz04D4A1WPmMmkN5p/tKUWPNI
BhDJ+TUFxWMSoyGGckIELrH1VZMGEA==
=2fTK
-----END PGP SIGNATURE-----

--btmyderg6ldficmi--
