Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058E438099F
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 14:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhENMfc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 08:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhENMfc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 08:35:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA52CC061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 05:34:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lhX1H-0006Y0-Dw; Fri, 14 May 2021 14:34:19 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:ab9e:cb46:9dda:16ff])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 66F5C624336;
        Fri, 14 May 2021 12:34:18 +0000 (UTC)
Date:   Fri, 14 May 2021 14:34:17 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 0/3] m_can: support device-specific
 interrupt handling
Message-ID: <20210514123417.tlm4bvqidwnioesm@pengutronix.de>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z5fwxuo2nitak6py"
Content-Disposition: inline
In-Reply-To: <20210514121946.2344901-1-torin@maxiluxsystems.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--z5fwxuo2nitak6py
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.05.2021 13:19:43, Torin Cooper-Bennun wrote:
> Using the TCAN4550, I've had occasions where the m_can driver has fallen
> over with the "nobody cared" message -- the ISR has returned IRQ_NONE
> upon "99,900 of the previous 100,000 interrupts" (see
> kernel/irq/spurious.c, __report_bad_irq()).
>=20
> While such high numbers certainly indicate some kind of fault,
> presently, device-specific interrupts are totally ignored -- it may be
> that such a fault can be handled with a device-specific action.

Do you know why the tcan4x5x specific interrupts are enabled in the
first place? If no-one is handling them, just mask/disable/etc then....

> Comments are welcome. One thing right off the bat: I'm not sure whether
> the new callback should be added alongside clear_interrupts, or if it
> should replace it.

I don't see why we need two callbacks from the generic interrupt
handler, one should be enough.

> I also need to replicate the fault observed with the TCAN4550 - it's
> unlikely that the handling added in this patchset is effective by
> itself.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--z5fwxuo2nitak6py
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCebkYACgkQqclaivrt
76nLMQf/UhvX35bB3/A+I6Fj1f6vz1mq30njCuo6c7/rW+wR0emthFo4MXfGJD8b
G63tzCUV5957naw3/mbZRvXyF/4Xgf71daSBdOuS1ktpvEdD5PTvmxOrHjmXs3+d
+P7vCvcUOXkps2T3+c/iFKlZhCoGBAiJ5j4e18qR+JqRTv98pgq58tLFS0pZgEkS
3sJbNwCKUuo3eV7pyWd8FXxDvZ1we4USKGfE2YhCh7AohC2R1T2R96UU7yKPzk3U
PABKtGqO9TGODEQXR88zRhJTBlwYwAcFQn0FcW5neKLnq+L+SGcjuxAzpgWQp5g+
DvKvD6YVXaWC5PhQBkXQIZ5YWx/DTg==
=h3Av
-----END PGP SIGNATURE-----

--z5fwxuo2nitak6py--
