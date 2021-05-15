Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E53F381AC1
	for <lists+linux-can@lfdr.de>; Sat, 15 May 2021 21:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhEOTSs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 15 May 2021 15:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbhEOTSs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 15 May 2021 15:18:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8492AC061573
        for <linux-can@vger.kernel.org>; Sat, 15 May 2021 12:17:34 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lhzn2-00039D-Ar; Sat, 15 May 2021 21:17:32 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:bbeb:8461:90d8:87f0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BB137624D38;
        Sat, 15 May 2021 19:17:30 +0000 (UTC)
Date:   Sat, 15 May 2021 21:17:29 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Patrick Menschel <menschel.p@posteo.de>
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: J1939 Questions on Intended usage
Message-ID: <20210515191729.ykes5tmwf4mu6lzj@pengutronix.de>
References: <f0d77797-c485-2f88-57e3-b5c7b4953706@posteo.de>
 <20210515122611.GC2387@x1.vandijck-laurijssen.be>
 <38c85980-a569-b714-2643-9623b3dbc973@posteo.de>
 <72aa8b79-5ba9-26ee-3918-09532e0f1eae@posteo.de>
 <20210515184237.GD2387@x1.vandijck-laurijssen.be>
 <ec77447e-5b5b-b476-09fb-3b9947eb813c@posteo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7jbap3gayxtmdc4z"
Content-Disposition: inline
In-Reply-To: <ec77447e-5b5b-b476-09fb-3b9947eb813c@posteo.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--7jbap3gayxtmdc4z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.05.2021 19:00:43, Patrick Menschel wrote:
> that was the trick. But why does it throw a PermissionError ?

So does ipv4:

https://elixir.bootlin.com/linux/v5.12.4/source/net/ipv4/datagram.c#L61

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--7jbap3gayxtmdc4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCgHkMACgkQqclaivrt
76kj0Af+N/lBBqMGOAFm9yOBs3yrzV4YPnI9NGidjS75XifMFiNg1WKgJ+lUl775
Wnw5V2lxPEaEyFEapm/1I7J9gbhdvHz+X6q1JMgyZ4nyQk1lOnuNv3uWTsHda28K
Cd6msGYUXFSO1pc4vQgZjVg0O5Jl7KcA4IpK3zYg9qhSsqOc9Lv0NFd3KrPUqpwZ
1OtIB7JFOF2ky1o7CmoGMPW9CWR+ASnLNmEQdqFyuUPl06vpmigI5+s0elureToU
SF3RZTjzmGuymc/lLgkSJXEGmyFHzjo72ls5yWN+ngr6kWCc6VyaOeTfHHTi2ui4
ok8UKDTFpD1obisYFK9AIjTrsA2b4A==
=svmU
-----END PGP SIGNATURE-----

--7jbap3gayxtmdc4z--
