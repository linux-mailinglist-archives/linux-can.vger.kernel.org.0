Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8B9577F34
	for <lists+linux-can@lfdr.de>; Mon, 18 Jul 2022 12:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiGRKCV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Jul 2022 06:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRKCV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Jul 2022 06:02:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB1E1A825
        for <linux-can@vger.kernel.org>; Mon, 18 Jul 2022 03:02:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oDNZu-0002s9-P2; Mon, 18 Jul 2022 12:02:14 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 577DBB2F62;
        Mon, 18 Jul 2022 10:02:13 +0000 (UTC)
Date:   Mon, 18 Jul 2022 12:02:12 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     linux-can@vger.kernel.org,
        Matej Vasilevski <matej.vasilevski@seznam.cz>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        David Miller <davem@davemloft.net>,
        Carsten Emde <c.emde@osadl.org>,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>
Subject: Re: [PATCH v1 1/1] can: ctucanfd: Update CTU CAN FD IP core
 registers to match version 3.x.
Message-ID: <20220718100212.albs3uormsppr3wz@pengutronix.de>
References: <cover.1658136506.git.pisa@cmp.felk.cvut.cz>
 <b426389bd3c6c4032b4bb6c234ccfe981e6d3860.1658136506.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ucgxtwlcb7ncsaau"
Content-Disposition: inline
In-Reply-To: <b426389bd3c6c4032b4bb6c234ccfe981e6d3860.1658136506.git.pisa@cmp.felk.cvut.cz>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ucgxtwlcb7ncsaau
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.07.2022 11:55:18, Pavel Pisa wrote:
> The update is compatible/pure extension of 2.x IP core version
>=20
>  - new option for 2, 4, or 8 Tx buffers option during synthesis.
>    The 2.x version has fixed 4 Tx buffers. 3.x version default
>    is 4 as well
>  - new REG_TX_COMMAND_TXT_BUFFER_COUNT provides synthesis
>    choice. When read as 0 assume 2.x core with fixed 4 Tx buffers.
>  - new REG_ERR_CAPT_TS_BITS field to provide most significant
>    active/implemented timestamp bit. For 2.x read as zero,
>    assume value 63 is such case for 64 bit counter.
>  - new REG_MODE_RXBAM bit which controls automatic advance
>    to next word after Rx FIFO register read. Bit is set
>    to 1 by default after the core reset (REG_MODE_RST)
>    and value 1 has to be preserver for the normal ctucanfd
                           preserved?
>    Linux driver operation. Even preceding driver version
>    resets core and then modifies only known/required MODE
>    register bits so backward and forward compatibility is
>    ensured.
>=20
> See complete datasheet for time-triggered and other
> updated capabilities
>=20
>   http://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/doc/Datasheet.pdf
>=20
> The fields related to ongoing Ondrej Ille's work
> on fault tolerant version with parity protected buffers
> and FIFOs are not included for now. Their inclusion will
> be considered when design is settled and tested.
>=20
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ucgxtwlcb7ncsaau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLVL6IACgkQrX5LkNig
010dBAgAgByipXrQk/tv8SicdNIMYB/mabTbdiWC9vrxe6KPQcr2oFji5fJXveNT
ZLFzgLsoL2ZrWAfhVorDE7BDLYyDvJGsHMHG2fxyJkkXOW8T8LZZan/FowdzdM8P
LepMt9sypboya4/Jb0eNumTfkB96V/bMKgJ9YMJIhb+jMD259NAAD/PyYFU4rffW
qZRKsmV/80i52EtedfS7145+3fOsXUu+Rks8CNr5qXRflfL6gHH2n7qTG7PCfc15
kI++H8OhsGCntIEV2ksJbZ5ouA/xZUpa5Mx5rAVuQFRV86ai7/Lt+F2JcCBMGunH
E45h9xzgmrFIneVR83zl8SE3ougA8g==
=HhSQ
-----END PGP SIGNATURE-----

--ucgxtwlcb7ncsaau--
