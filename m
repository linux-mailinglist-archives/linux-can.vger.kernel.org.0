Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B55371867
	for <lists+linux-can@lfdr.de>; Mon,  3 May 2021 17:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhECPss (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 3 May 2021 11:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhECPsr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 3 May 2021 11:48:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22845C06174A
        for <linux-can@vger.kernel.org>; Mon,  3 May 2021 08:47:53 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ldanX-0004y8-Nt; Mon, 03 May 2021 17:47:51 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1b0:e062:be12:b9c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9BBB361B3E5;
        Mon,  3 May 2021 15:47:50 +0000 (UTC)
Date:   Mon, 3 May 2021 17:47:49 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Ayoub Kaanich <kayoub5@live.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: More flags for logging
Message-ID: <20210503154749.q3nrfjveixsqp3uj@pengutronix.de>
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
 <20210503100810.cacbmdfmpjipgoka@pengutronix.de>
 <CAMZ6RqLKp981zBus9K1RiLL14zC0B2BGp0U+xuQGvj1fjDMF1g@mail.gmail.com>
 <DBBPR03MB70828377F51A1747B4E9E6529D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xqf22ykht4uxsafy"
Content-Disposition: inline
In-Reply-To: <DBBPR03MB70828377F51A1747B4E9E6529D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--xqf22ykht4uxsafy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.05.2021 15:31:34, Ayoub Kaanich wrote:
> For the ack bit, I think we could go with the bit being a =E2=80=9CNO_ACK=
=E2=80=9D
> bit, so a spy listener will set it to 1, if it receives a CAN frame,
> but it does not see any node in the bus acknowledging it. This way we
> preserve backward compatibility.

As Vincent pointed out, the device should not receive the CAN frame that
has not been acked as I do on the flexcan.

And even on the mcp251xfd, where I receive the CAN frame, there's no way
to tell if this frame has been acked or not.

> For the FDF flag, check the MTU is not an option here, since this flag
> is needed to detect normal CAN frames being transmitted on a CAN-FD
> bus (The bus could be configured as CAN-FD, but the received frame
> could be a normal CAN frame)
>=20
> If we are adding flags to can_frame, could we make sure it=E2=80=99s on t=
he
> same byte offset as the flags of can_fd_frame, since PCAP format have
> no concept of MTU or struct size.

Sure - Do struct can_fd_frames have a different ARP header type?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xqf22ykht4uxsafy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCQGyMACgkQqclaivrt
76kGPQgAtApjvF8DhV9uSGiSgLrdDVNjM5apiNFyy3aoKVDVS5HalPBxQSnxKnmy
VOWMRsGLUKlJKdQvLOARjKj/Zq5jrCrE2k8dQCdT2wnDY28tPy0XzVljHPVq3DxB
g2qqabG7DL8Jf1HHY5oLSYDeoScsIY1pEBL6dNxE1HbwIsX3P2pt/80JHLzOMk18
NuCeLd5romewjHRNXRDGvPNo2IopKs9drzlbMSpUZFLyTsjkePTqCrpMuSrit3Vu
W4lOVOwftdWe1X2+fRlDqPMs2wdiHweTTXZ/9r/hAGascgPpQn/jfbKS80nAMO8o
TUuwwWNYXEs1/eKK17gutIfMWjR/fg==
=GCWU
-----END PGP SIGNATURE-----

--xqf22ykht4uxsafy--
