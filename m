Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839CF4A4954
	for <lists+linux-can@lfdr.de>; Mon, 31 Jan 2022 15:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiAaObJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 Jan 2022 09:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbiAaObI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 31 Jan 2022 09:31:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D127C061714
        for <linux-can@vger.kernel.org>; Mon, 31 Jan 2022 06:31:08 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nEXhz-00066Z-2g; Mon, 31 Jan 2022 15:31:07 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7951D286C1;
        Mon, 31 Jan 2022 14:31:06 +0000 (UTC)
Date:   Mon, 31 Jan 2022 15:31:03 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined
 flashed device number
Message-ID: <20220131143103.nmp6fquyidsapw2l@pengutronix.de>
References: <PA4PR03MB6797AFA0F9FD103718D7C3FDD6259@PA4PR03MB6797.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vlg6a4ql6emroxv6"
Content-Disposition: inline
In-Reply-To: <PA4PR03MB6797AFA0F9FD103718D7C3FDD6259@PA4PR03MB6797.eurprd03.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--vlg6a4ql6emroxv6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.01.2022 14:25:28, St=C3=A9phane Grosjean wrote:
> >> +     u32 devid;
> >>
> >> +             memcpy(data, (u8 *)&devid + eeprom->offset, eeprom->len);
> >
> > cast not needed.
> >
>=20
> We need to cast the u32 * into a u8 * because eeprom->offset is a count o=
f bytes, isn't it?

Doh! right.

What about endianness? I think it's better to use an array of bytes
everywhere.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vlg6a4ql6emroxv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmH38qQACgkQqclaivrt
76nLpwf/RjIfRKUCvoHcH71eEXtdjPuxe6vHcTGnJVr+0h0RSjg1K4JOIGOu80gK
yz/PDQv1r+DlMeBEtV9PE2lGOcBYvtHMHF2zMpro6SrdFvD8njdl7Zj1kwQe9Lhq
1boorzCf2WjMqVlyim2qrUYpAWDi51xWVRoG+R6E5SmbmH5gp7EVhZ+OW4bdaDHZ
Ju5kTZnqKe9MvuOGiPr5z9K4+9w2vPa02ySzjhRP4VVkbRg3jiAGsl+ZbMiy0xpV
PptX5M4Es2abnYXPYlHwWhfVWjtMafZZ4twBEsp+AjLWyXbpkdNcTkgzSdrVxHDb
ot1RWyL/VavyoZvWyppA5w04qfFkcQ==
=kSHO
-----END PGP SIGNATURE-----

--vlg6a4ql6emroxv6--
