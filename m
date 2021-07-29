Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC0D3DA19F
	for <lists+linux-can@lfdr.de>; Thu, 29 Jul 2021 12:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhG2Kzq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 29 Jul 2021 06:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbhG2Kzp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Jul 2021 06:55:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E31CC061765
        for <linux-can@vger.kernel.org>; Thu, 29 Jul 2021 03:55:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m93hU-0007wt-PK; Thu, 29 Jul 2021 12:55:40 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:f664:c769:c9a5:5ced])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0878F65AD80;
        Thu, 29 Jul 2021 10:55:39 +0000 (UTC)
Date:   Thu, 29 Jul 2021 12:55:39 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     thomas@the-wagner.de
Cc:     linux-can@vger.kernel.org
Subject: Re: Write canfd_frame to can interface
Message-ID: <20210729105539.ppi7rm6uglwbpyov@pengutronix.de>
References: <006401d78461$0b868b60$2293a220$@the-wagner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ybt65sfda4vr663a"
Content-Disposition: inline
In-Reply-To: <006401d78461$0b868b60$2293a220$@the-wagner.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ybt65sfda4vr663a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.07.2021 12:03:56, thomas@the-wagner.de wrote:
> I have been working on getting my device compatible with both, CAN and
> CAN FD.
>=20
> For receiving this is working straight forward. My physical interface
> is CAN FD capable and no matter whether I set it up as
>   ip link set can0 type can bitrate 500000 fd off
> or
>   ip link set can0 type can bitrate 500000 fd dbitrate 2000000 off
> in code I can always just use the canfd_frame struct and set the
> CAN_RAW_FD_FRAMES option. Doing this I can receive CAN and CAN FD
> frames in both modes without having to fall back to the can_frame
> struct (as explained in the docs).
>=20
> For sending I expected a similar behavior. I set the CAN_RAW_FD_FRAMES
> option and always sent using the canfd_frame struct. Sadly, this fails
> while writing on the interface when it is not in FD-mode with an
> Invalid Argument error. To make this work without falling back to the
> can_frame struct I just do
>   write(sock, &canfdf, sizeof(struct can_frame));
> where canfdf is a canfd_frame. Not setting CAN_RAW_FD_FRAMES when the
> interface is in CAN mode but sending using the full canfd_frame won't
> work too.
>=20
> Is this expected behavior?

Yes.

> Shouldn't the error only be returned if the
> canfd_frame I pass has more than 8 bytes when the interface is not in
> FD-mode?

A CAN-2.0 frame with 8 bytes is something different than a CAN-FD frame
with 8 bytes. The kernel uses the length of the frame to decide if it is
a CAN-2.0 or CAN-FD frame. If your CAN controller has switched CAN-FD
off, it cannot send CAN-FD frames, thus you get an error.

Does that make sense?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ybt65sfda4vr663a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmECiSgACgkQqclaivrt
76mrEwf/a7GUhO6/R+xEp3mlI5lKR4iAB7o3yKs71Cnf5k/atW2Ap0xBTEghm2Ky
JdLRRVLlsmeT2L5kN0/o7GbmBafFY0Yg/6GcC2BaB0cEiuT36BuKJpeO/DOohsaq
5PuanLX0fAdwIC3fNJnvP8fzCo8SjR33nVAfCNwexUg31ur0EW5s5ZJQkGujjrNS
rboF7AGxpggPNkBjEnBbm8LqDE2cSsLyi1Ux+mHaOUuQ4ubnkth3mUzIXauWBDWb
oOT+v2wPpfzEpweVjEOKSaGjQA0neA/uZBPxanadV5pZnNSjEEkvwBa35pSRtqGk
5kDToUrY3TrJtfYaEnpVHs57kPdrGg==
=bqaQ
-----END PGP SIGNATURE-----

--ybt65sfda4vr663a--
