Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9631048639A
	for <lists+linux-can@lfdr.de>; Thu,  6 Jan 2022 12:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiAFLSz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Jan 2022 06:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbiAFLSz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Jan 2022 06:18:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FE8C061245
        for <linux-can@vger.kernel.org>; Thu,  6 Jan 2022 03:18:55 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n5QnC-0007yE-RK; Thu, 06 Jan 2022 12:18:50 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-fd40-da16-8525-0d68.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:fd40:da16:8525:d68])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3B4226D2552;
        Thu,  6 Jan 2022 11:18:48 +0000 (UTC)
Date:   Thu, 6 Jan 2022 12:18:47 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: mcf5441x: flexcan FIFO and mailbox mode (was: Re: [PATCH v5 5/5]
 can: flexcan: add mcf5441x support)
Message-ID: <20220106111847.zjkrghehxr7mrkkt@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zwauvc2xjplx623i"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--zwauvc2xjplx623i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Angelo,

On 02.07.2021 11:48:41, Angelo Dureghello wrote:
> Add flexcan support for NXP ColdFire mcf5441x family.
>=20
> This flexcan module is quite similar to imx6 flexcan module, but
> with some exceptions:
>=20
> - 3 separate interrupt sources, MB, BOFF and ERR,
> - implements 16 mb only,
> - m68k architecture is not supporting devicetrees, so a
>   platform data check/case has been added,
> - ColdFire is m68k, so big-endian cpu, with a little-endian flexcan
>   module.

we're currently discussing the option that the user of a flexcan can
switch between RX-FIFO and RX via mailboxes.

I noticed that the mcf5441x currently is configured for FIFO mode. Have
you tested the driver in mailbox mode?

The reason that some cores use the FIFO mode is, that they cannot
receive RTR CAN frames in mailbox mode. According to the IP core
overview table, the mcf5441x can receive RTR frames.

If the IP core supports reception of RTR frames, mailbox mode should be
used, as it makes use of more buffers (16-2) instead of 6 in FIFO mode.
Should we activate mailbox mode for the mcf5441x?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--zwauvc2xjplx623i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHW0BQACgkQqclaivrt
76nYYgf+L7XNXnaqqxsDKE0fUL2odEuMaMlm+oatg7rgSbA5XBjG6GqTZiF3lCJJ
Ntf2rz4XXoIFlei8QRgC6b08/66La6b/titJUijEEk5R9JB2TXfTQOK0MoOC2xcf
3BmAOpvJ13BmuUYF/be8QwfiXJ2K7Hpfume3JNhelLyYR6sPK6PM3n5HiW7XgkXx
eUpG9rF29c5EHd3W8+DTCMdqmNABs66AfIHKjsB2q0/iEd6jmDkmRDpmPRD9a/vS
zmhj+SjOY25uMEEE/41f+cnT/0Xwt83UyEF1eniZJIEPbTQn7+5eQLh2G8ced7We
BM1DC1tI3Z7O/MbE3greq85bEaM6OQ==
=nAb5
-----END PGP SIGNATURE-----

--zwauvc2xjplx623i--
