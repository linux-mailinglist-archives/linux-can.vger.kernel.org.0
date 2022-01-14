Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759D948EBB0
	for <lists+linux-can@lfdr.de>; Fri, 14 Jan 2022 15:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbiANObT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 Jan 2022 09:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiANObT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Jan 2022 09:31:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF9CC061574
        for <linux-can@vger.kernel.org>; Fri, 14 Jan 2022 06:31:18 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n8Nbp-0002sv-Fx; Fri, 14 Jan 2022 15:31:17 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 02C0D18AD5;
        Fri, 14 Jan 2022 14:31:16 +0000 (UTC)
Date:   Fri, 14 Jan 2022 15:31:13 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Maik =?utf-8?B?QWxsZ8O2d2Vy?= <maik@llgoewer.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: can-isotp: TX stmin violations
Message-ID: <20220114143113.zapz2oszjzfq6p7r@pengutronix.de>
References: <20220103155254.3htprmrdjur3ke3l@ganymed>
 <d54c6374-bdf4-dfe8-9e9c-5547a743afdb@hartkopp.net>
 <27389f5f-1681-7440-15bd-3c67e4e5daa9@posteo.de>
 <c20468e2-0f9f-bcca-da0f-f3f6470d91be@hartkopp.net>
 <6175074d-6562-91c9-3dce-22ca99815910@posteo.de>
 <19adffae-443c-78bc-fb8c-61ec792a7b6d@hartkopp.net>
 <20220114141929.mz34evi65cgurgek@ganymed>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5tdal2fawxhxrv2u"
Content-Disposition: inline
In-Reply-To: <20220114141929.mz34evi65cgurgek@ganymed>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--5tdal2fawxhxrv2u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.01.2022 14:19:29, Maik Allg=C3=B6wer wrote:
> On 22-01-05 08:36, Oliver Hartkopp wrote:
> >=20
> > In fact the discussion hits a valid point. On the one side you might th=
ink
> > about a time slotted receive task that might only be able to process a =
frame
> > inside this slot. At least in the 'very early' days of CAN transport
> > protocols I've heard about such weird implementations.
> >=20
> > On the other side (as we can see from the jitter in Maiks's original
> > question) we face different requirements in todays implementations. Her=
e an
> > *average* result makes sense. But this is no implementation requirement=
 but
> > a testing requirement to relax the STmin timing checks then.
>=20
> I did some more testing and the issue seems not to be related to the isot=
p driver.
>=20
> The system we are using is an i.MX-based one and we have three CANs.
> Two of those are flexcan, the third is a mcp2518fd (mcp251xfd).
>=20
> I can not reproduce the timing issue on the flexcans, only on the MCP.

The flexcan uses a single TX buffer, while the mcp251xfd uses 8 for
classical CAN and 4 for CAN-FD.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5tdal2fawxhxrv2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHhiS8ACgkQqclaivrt
76m1lAf9GrSmMU0MsgH4sUgEN5qJDQ+J9I35yoUiWmZPCNdL2h8dFSDGDw9UR8Ww
vIiQ3d5I4UhbHbrhNp2rEbNXl+nBZGIxIM4X60UYVakaBA4f8Pre6b08RRq4t1Zf
7GERfaPLH7kEQbBlmDSLYtVKoVClLNOb5+T+ck2kNO475ggRXVbDTORzaA7u30UY
EI9eGa9lm/GEPTsD75UrQcu1jq/rSV28aeXEopxF2fKzV1+PITkOWgCUt9N1XFlQ
HO9cjL1Xt/yUzIAgixbqpuZ3zqtg9tEmXl9J3R5sdWSdAtTxKKX6bpsL5qKxICKt
MsDgD6c00NpouM8g8V+9cPxa5kLm0Q==
=Dpwt
-----END PGP SIGNATURE-----

--5tdal2fawxhxrv2u--
