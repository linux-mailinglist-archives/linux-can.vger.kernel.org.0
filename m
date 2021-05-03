Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2370B371364
	for <lists+linux-can@lfdr.de>; Mon,  3 May 2021 12:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhECKJP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 3 May 2021 06:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhECKJG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 3 May 2021 06:09:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD3EC06174A
        for <linux-can@vger.kernel.org>; Mon,  3 May 2021 03:08:13 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ldVUp-0004Ag-VW; Mon, 03 May 2021 12:08:12 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1b0:e062:be12:b9c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EDD0F61B002;
        Mon,  3 May 2021 10:08:10 +0000 (UTC)
Date:   Mon, 3 May 2021 12:08:10 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can <linux-can@vger.kernel.org>
Cc:     kayoub5@live.com
Subject: Re: More flags for logging
Message-ID: <20210503100810.cacbmdfmpjipgoka@pengutronix.de>
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ge533tvkoliurzfr"
Content-Disposition: inline
In-Reply-To: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ge533tvkoliurzfr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.05.2021 12:02:46, Marc Kleine-Budde wrote:
> The SocketCAN API is a great initiative for standardizing the CAN
> interface API. This request tries to extend this initiative for more use
> cases.
>=20
> Context:
>=20
> The SocketCAN was adopted by libpcap and tcpdump as the standard format
> for logging CAN Frames in PCAP and PCAP-NG. See:
>=20
> https://www.tcpdump.org/linktypes/LINKTYPE_CAN_SOCKETCAN.html
> https://github.com/wireshark/wireshark/blob/master/epan/dissectors/packet=
-socketcan.c
> https://www.wireshark.org/docs/dfref/c/can.html
>=20
> Problem:
> Applications that perform logging, usually need more details that normal
> applications, for the sake of debugging later on. Flags needs to be
> reserved/allocated in the SocketCAN API, so that logging applications
> can make use of them in the PCAP format. The flags does not need
> necessary need to be implemented by SocketCAN, they just need to be
> marked as reserved for such use case.
>=20
> Needed Flags:
> FDF Flag
> - Since CAN Frames and CAN-FD frames can co-exist in the same bus,
>   logging application needs to know if a normal CAN Frame was
>   transmitted on a CAN-FD bus, namely was the FDF bit set or not.

I think someone asked for that some time ago. But that was never
mainlined. I'll look for that old mail.

> ACK bit in data frame
> - Some logging hardware can act as a "spy", meaning that it records CAN
>   Frames, but does not set the ACK bit
> - A way to know for a given frame (FD or not), was the ACK bit set or
>   not.
> - Current API allow detecting missing ACK, but it does not report what
>   Frame had a missing ACK.

This means the driver has to set a flag if it's configured in
listen-only mode. That should be possible.

I think we can make use of flags in the struct canfd_frame for this:

| struct canfd_frame {
| 	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
| 	__u8    len;     /* frame payload length in byte */
| 	__u8    flags;   /* additional flags for CAN FD */
| 	__u8    __res0;  /* reserved / padding */
| 	__u8    __res1;  /* reserved / padding */
| 	__u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
| };

The struct can_frame doesn't have the flags member yet, but we can add
it there.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ge533tvkoliurzfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCPy4cACgkQqclaivrt
76kbiAf/WHUcR0N/XpawCMx6VT/KA7w25OrIP3PPSLdvYqbTymSayiVx9uXBv7ud
0YfgrIxhQYJPWFdVrt+m76+8V6d43BdP9JmA6pOGOFYaaKJpnRHsf8csGaEn7bT0
Iz+jchUbi79NcbkvFmgv4Ui4l1I9PoLmvPJTd7a9bfTO2RSXYwR0VVY/ZS5LXuoi
QcgBz2anIvjIgXR0i0WQMK/mcm1E1bIXaAMXgsq6qv2WR2d62U4xABt10zMJAqZX
qBj6VjGpQMPG2wNrDUF8TiEWOdR7xJxtcIoRmoQLn0MwPv2ZSacLTa8Q573DUEhj
k9lPff8CvSiAfeiuv+y02JORgBNURA==
=qYoD
-----END PGP SIGNATURE-----

--ge533tvkoliurzfr--
