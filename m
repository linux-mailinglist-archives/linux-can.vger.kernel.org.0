Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448E734E509
	for <lists+linux-can@lfdr.de>; Tue, 30 Mar 2021 12:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhC3KER (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 Mar 2021 06:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhC3KEO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 30 Mar 2021 06:04:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF57C061574
        for <linux-can@vger.kernel.org>; Tue, 30 Mar 2021 03:04:14 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lRBEL-0001cn-1H; Tue, 30 Mar 2021 12:04:13 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4ac3:d52e:3d04:f96e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 59575603CBA;
        Tue, 30 Mar 2021 10:04:12 +0000 (UTC)
Date:   Tue, 30 Mar 2021 12:04:11 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [mcp251x] Using MCP2515 with half duplex driver fails on init
Message-ID: <20210330100411.x4syylvj4hjprhe4@pengutronix.de>
References: <7cc4e81bdafd61649ac2b3f628083bd1@gerhard-bertelsmann.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u2iipr755deexwri"
Content-Disposition: inline
In-Reply-To: <7cc4e81bdafd61649ac2b3f628083bd1@gerhard-bertelsmann.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--u2iipr755deexwri
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.03.2021 09:10:10, Gerhard Bertelsmann wrote:
> I'm trying to get a MCP2515 working with an OpenWRT router connected to t=
he
> second SPI channel (CS1). The first one is used by the flash. Here the er=
ror
> message while loading the mcp251x module (Kernel 5.10.26):

Can you try the patch I just send to the mailing list?

https://lore.kernel.org/r/20210330100246.1074375-1-mkl@pengutronix.de

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--u2iipr755deexwri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBi95gACgkQqclaivrt
76mLNAf+IgkHft2PKPAvWTHdEp/BDmGCGSezreA5NMzncjNUE+Uo915Dt+W6q+T4
Qeg6enQssdxvbKLanZHzWiXutWwNRdhn+XqChhPXJL/X/zY3ZbZba1w0Mp+DZyKb
jKK/u58VadcKTw7EZcnrASlqXGsQF9SMFhbANDb1KYDzMEfZlkAIPmBu2xs5mYx9
rwgLDjEBUIkscWuxvgX66HhYXiYMF1WqQ+P/726UVjzAt4WhmEQNKjGdrmGqd+7K
SS1szNeOQSmxJu4d2wUdQWOYMNef81yqGgbaCHuwVChTCSnsQh1UCSGdNcV73Gsl
gg/7KVhjWMJIZPDsWQrKO0uNT871BA==
=M/Mm
-----END PGP SIGNATURE-----

--u2iipr755deexwri--
