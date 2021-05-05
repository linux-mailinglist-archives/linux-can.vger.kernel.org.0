Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89344373BB0
	for <lists+linux-can@lfdr.de>; Wed,  5 May 2021 14:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhEEMvH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 May 2021 08:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhEEMvG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 May 2021 08:51:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEE1C061574
        for <linux-can@vger.kernel.org>; Wed,  5 May 2021 05:50:10 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1leGye-0000Hd-K4; Wed, 05 May 2021 14:50:08 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:96db:da04:b018:e517])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B90AA61D284;
        Wed,  5 May 2021 12:50:07 +0000 (UTC)
Date:   Wed, 5 May 2021 14:50:07 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC] can: m_can: m_can_tx_work_queue(): fix tx_skb race
 condition
Message-ID: <20210505125007.jr74takrjpyadkxj@pengutronix.de>
References: <20210505114302.1241971-1-mkl@pengutronix.de>
 <20210505120659.bconnblkp5lhd52t@bigthink>
 <20210505123501.np5f2xbx4jwkalv6@pengutronix.de>
 <20210505124614.x2mdkoozvftzynuo@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4izzwyotbkztcvtt"
Content-Disposition: inline
In-Reply-To: <20210505124614.x2mdkoozvftzynuo@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--4izzwyotbkztcvtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.05.2021 13:46:14, Torin Cooper-Bennun wrote:
> On Wed, May 05, 2021 at 02:35:01PM +0200, Marc Kleine-Budde wrote:
> > > Thanks a lot for spotting this Marc, after initial testing this is
> > > working very well. I don't see that error message at all now, even at
> > > very high transmit rates, and dropped frames are reduced considerably.
> > >=20
> > > (Test setup: RPi CM4, TCAN4550, 500 kbit/s CAN-FD.)
> >=20
> > Can I add your Tested-by?

> Yes, please do!

Done.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--4izzwyotbkztcvtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCSlHsACgkQqclaivrt
76l6gAgAtIgIILx2Na7Hwo+RZB7IBsGdP+DeUrE115UcQNceJFue7onhS8j9gyTf
v23kIAwMayBbt1EzW4mESAMRBA1+VEntIiFo7dLxFaXlpuMqz+FpGOH9WHfGvvMW
vsuxstqdHA+nOrNqnQTT7thDtxEXzgrRCRtPwmYmlSmSCZEu/NjGkZbnxC176HqK
QVjzGjXoM+cb8A0rZSlvQZfp1QJJB8+8c6zyrvYNgOWlzN1Ms3bDjx3+WmtGAJQW
YWNlal+GYy6Ae8PA2BfMZTCgqvY3MEgzg739gDtP8h3HrcrreXZM5b2Tr0iet8mw
9G2KrtVkLkjRyPQR4f8vdyecRWWc3g==
=8DVt
-----END PGP SIGNATURE-----

--4izzwyotbkztcvtt--
