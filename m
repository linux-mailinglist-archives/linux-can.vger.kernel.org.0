Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DC73AE93F
	for <lists+linux-can@lfdr.de>; Mon, 21 Jun 2021 14:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhFUMlg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Jun 2021 08:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhFUMlg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Jun 2021 08:41:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FCBC061574
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 05:39:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lvJCy-0008F1-Qx; Mon, 21 Jun 2021 14:39:20 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3569:1fb5:40be:61fc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0ADF464064B;
        Mon, 21 Jun 2021 12:39:20 +0000 (UTC)
Date:   Mon, 21 Jun 2021 14:39:19 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC]: can-next 2021-06-21: try to fix softirq error from
 threaded IRQs
Message-ID: <20210621123919.3zozhgrxpk2r6zci@pengutronix.de>
References: <20210621123436.2897023-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mw2la6uhbs2h7okq"
Content-Disposition: inline
In-Reply-To: <20210621123436.2897023-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--mw2la6uhbs2h7okq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.06.2021 14:34:28, Marc Kleine-Budde wrote:
> Hello,
>=20
> this series tries to fix the softirq error which occurs if NAPI is
> scheduled from threaded IRQ context [1][2]. Also it fixes a RX-before-TX
> problem seen on the mcp251xfd driver.

please ignore patch 8/8, as this is obviously the DT of my testing board
:)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--mw2la6uhbs2h7okq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDQiHQACgkQqclaivrt
76mDWgf+LcXCxHNZd2r/np03zr7Mi5F727gH1I2mkZyqTOyjjWBPHL9jBZtQqHa5
CLAPrJrdT6HriaDOySQrTi4dMot2A4GSEnBXoO6qZoUeM4US/2E1ddDVO/3c3OqC
uNf5/s9QzGTcYSASNwsHP0zmddm6+8Osn6FNjnQ5Q2qzKsT0vDJsfqOO8OkZrAx4
X6e26Hm3Iu3ZWqVYdwZz5Fc1lDNNVhaAJSu3IW22zuY/T9GTz9DUsyn2ynBMX8iZ
qkIUAQTlX5E8ITVPdTdyd+sIDSOPvb8UJmrUD7hvO81C1bGg20U+Mauz+r7xQS6f
1vhVy3pDgOLZQiEtqLAK51p6QW9mZQ==
=5YG1
-----END PGP SIGNATURE-----

--mw2la6uhbs2h7okq--
