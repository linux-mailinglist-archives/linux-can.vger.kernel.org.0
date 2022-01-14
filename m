Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E542E48EBAD
	for <lists+linux-can@lfdr.de>; Fri, 14 Jan 2022 15:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiANO3x (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 Jan 2022 09:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiANO3w (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Jan 2022 09:29:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AE3C061574
        for <linux-can@vger.kernel.org>; Fri, 14 Jan 2022 06:29:52 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n8NaQ-0002bZ-Or; Fri, 14 Jan 2022 15:29:50 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1F29718ACD;
        Fri, 14 Jan 2022 14:29:50 +0000 (UTC)
Date:   Fri, 14 Jan 2022 15:29:46 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michael Anochin <anochin@photo-meter.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can: m_can: m_can_read_fifo, can_fd_dlc2len returns sometimes
 cf->len=0
Message-ID: <20220114142946.ozv3vzjkuss4rj72@pengutronix.de>
References: <5215c43f-d208-4bc6-5bd3-3425bc4f107a@photo-meter.com>
 <20211112130744.gqnnkn67oxwumczq@pengutronix.de>
 <88ddcee3-65b6-4b4e-332c-6f23ad39c35f@photo-meter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="izgkihktravkdgpe"
Content-Disposition: inline
In-Reply-To: <88ddcee3-65b6-4b4e-332c-6f23ad39c35f@photo-meter.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--izgkihktravkdgpe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,

On 12.11.2021 19:38:26, Michael Anochin wrote:
> (in context of 5.15.1 Kernel)
>=20
> 1. I confirm the crashes with the command "cansend canX abc#" on each
> can-if, which resulting in
>=20
> [ 9563.137691] tcan4x5x spi0.0 can0: FIFO write returned -22
> [ 9573.577950] tcan4x5x spi4.0 can1: FIFO write returned -22
> [ 9658.948552] tcan4x5x spi6.0 can2: FIFO write returned -22

I setup a tcan4x5x and reproduced the problem. My proposed patch fixes
the problem.

> 2. After applying of your Path the system is spammed until death with
> messages (I have cut out the repeating):

How to reproduce this problem:

> [  755.039082] tcan4x5x spi4.0 can1: ack error
> [  755.040039] tcan4x5x spi4.0 can1: ack error
> [  755.040071] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
> [  755.040358] tcan4x5x spi4.0 can1: ack error
> [  755.040677] tcan4x5x spi4.0 can1: ack error
> [  755.040709] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
> [  755.040997] tcan4x5x spi4.0 can1: ack error
> [  755.041029] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
> [  755.041315] tcan4x5x spi4.0 can1: ack error
> [  755.041347] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
> [  755.041635] tcan4x5x spi4.0 can1: ack error
> [  755.041667] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
> [  755.041954] tcan4x5x spi4.0 can1: ack error
> [  755.041986] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail
> [  755.042017] tcan4x5x spi4.0 can1: __skb_queue_add_sort: pos=3D0x000000=
00,
> new=3D0x00000000, diff=3D         0, queue_len=3D1
> [  755.042288] tcan4x5x spi4.0 can1: ack error
> [  755.042320] tcan4x5x spi4.0 can1: Protocol error in Arbitration fail

I was not able to reproduce this problem.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--izgkihktravkdgpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHhiNcACgkQqclaivrt
76mPEAf/ULnmopXUWwX9ugOB5dQjaC5uldZJdfAS/P5Hb4nvYBu7dHrXoqoez2ky
/zSRarU8x90Ax+tPfHJTZzMcJCmFlPn5h5JyiM2ELot54DE8XrQb2D1PzNVyrTB8
oxreqnmwzfy+dxFPwdEsFm7meN0UxjYyFaMshG9FnLHJiFyLTP2CQqhyc0hh0Ws8
VsOuLXz6EKbMYISLCJQJ8RnOmUNKRjb0Le5btfnWk4zVAHXMUWAOzN3Og6QqBUY4
giQtkFxUvhrOLGpLz4c5c4xTyWhI3hJ6sHOUzNQBY5TWRDWfDRsL+I2mCjf/MDDr
mKMdbgzuIzzEATmJe9l10MH5YINxzQ==
=jP9p
-----END PGP SIGNATURE-----

--izgkihktravkdgpe--
