Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA3D348BA8
	for <lists+linux-can@lfdr.de>; Thu, 25 Mar 2021 09:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhCYIiT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Mar 2021 04:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhCYIiA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Mar 2021 04:38:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF25C06174A
        for <linux-can@vger.kernel.org>; Thu, 25 Mar 2021 01:38:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lPLV8-0002BN-MI; Thu, 25 Mar 2021 09:37:58 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:f5fd:792d:c506:d37f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C93BA5FF8AC;
        Thu, 25 Mar 2021 08:37:57 +0000 (UTC)
Date:   Thu, 25 Mar 2021 09:37:56 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: CAN Testing with Docker Image?
Message-ID: <20210325083756.lc367z5fscppmvmh@pengutronix.de>
References: <2a2f2f06-00ed-7418-b5b6-ea7eb729d4f5@posteo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uoxtu5h6r7unlq7r"
Content-Disposition: inline
In-Reply-To: <2a2f2f06-00ed-7418-b5b6-ea7eb729d4f5@posteo.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--uoxtu5h6r7unlq7r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.03.2021 07:52:58, Patrick Menschel wrote:
> Hi all,
>=20
> I'd like to ask if anybody is using a Docker Image for testing CAN Bus
> and what Image is recommended?
>=20
> I'm currently setting up a gitlab CI pipeline for my python3 unit tests
> and did not find any docker image with built-in CAN support.

There was a talk in German at Chemnitzer Linux-Tage:

https://chemnitzer.linux-tage.de/2021/en/programm/beitrag/210

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--uoxtu5h6r7unlq7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBcS+IACgkQqclaivrt
76nvfwf/eZ/Q6Szp06My87hU+3YxfVKSmSgNCN1SRt2ZRTNcwIZDiKMEueRMDEFQ
lVWPbXgZWAMWW3QAASTv04KfYC9IZwiDzzxw5aPA+pkmxXYk8wLgp1QmmClbAxcg
Ym2LbopPbS8UUXlbSxXd/6glZBuIx7d77+nFYvLWFR0DBqNjSE/MmixhMYg+Qzbf
q9RiAJbkKBt/zBz2Pq4emcmKRosQeaesCkXj734J2vQEdchMcssPQmmXLF2sRSI/
HKDspqpE4rlxkLFkBU74CMQmsT2Gp82uPsqeIuqJ+tVe9JdlzX/brmDCYbFBkOud
F19m470/K2h7AGTWzlM/hLA4FyXbMw==
=dbTA
-----END PGP SIGNATURE-----

--uoxtu5h6r7unlq7r--
