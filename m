Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401D2432EEF
	for <lists+linux-can@lfdr.de>; Tue, 19 Oct 2021 09:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhJSHHa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Oct 2021 03:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbhJSHHa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Oct 2021 03:07:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20938C061765
        for <linux-can@vger.kernel.org>; Tue, 19 Oct 2021 00:05:18 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mcjBU-0004e2-HG; Tue, 19 Oct 2021 09:05:16 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-6267-dd6f-bd00-49b6.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:6267:dd6f:bd00:49b6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 65F66697738;
        Tue, 19 Oct 2021 07:05:15 +0000 (UTC)
Date:   Tue, 19 Oct 2021 09:05:12 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: [PATCH RFC] can: isotp: isotp_sendmsg(): return error on FC
 timeout on TX path
Message-ID: <20211019070512.epqsgeuzjvcbrox5@pengutronix.de>
References: <e9ebf4ab4b1a431eac24a21ab8379894@liebherr.com>
 <20210507125017.hu3rcilzcw4rknof@pengutronix.de>
 <d691ed18-d9d4-bf78-d506-cbd7a74dba6b@hartkopp.net>
 <20210507141842.uu3huooq4gfywacd@pengutronix.de>
 <b3efce9895784f8ab6f5dee8ae03c604@liebherr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c4owwrgujkosfsym"
Content-Disposition: inline
In-Reply-To: <b3efce9895784f8ab6f5dee8ae03c604@liebherr.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--c4owwrgujkosfsym
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.10.2021 04:51:18, Sottas Guillaume (LMB) wrote:
> Hope you are doing fine?

Thanks, yes :)

> I was wondering if this patch were integrated in the mainline? I
> searched around but I've not be able to find it.

Oh, that somehow slipped my fingers. I'm about to send a pull request,
hopefully this patch gets into v5.15.

> Thank you in advance for your feedback,

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--c4owwrgujkosfsym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmFubiUACgkQqclaivrt
76nN0ggAlfO3/BLZFFvtpFoaD0Jf4XM9F9JGlM9bNqjOqr1VPSnjXydsYWqXV9vZ
gIFzBzrl07l4g7wHPHuCR9d5f+rA7F4m0j9QfxMYPRbU14993rdkGQ7XvBgh3xPh
eDd5QOsqRknXNRKwOAz/sbAGIZPaKYSEV76+KLXQt8e09yGtqUspPpflKjs51UT+
bBLRhs4+m7vlCbYo4+z1270wJA453yOmKz3rdwEg0w13mZqomZXXKHVod/2tcSxr
CEPgcEOASjnevRhmvGeNLaVbLjOqreftjgzRQw/7SGztGN8qnHLMGIze2DFLtvKL
LDHy7cKIPSMh75gwyxYFLYNmrsFNPw==
=qOxh
-----END PGP SIGNATURE-----

--c4owwrgujkosfsym--
