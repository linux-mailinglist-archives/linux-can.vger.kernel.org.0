Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC8558E800
	for <lists+linux-can@lfdr.de>; Wed, 10 Aug 2022 09:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiHJHpj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 Aug 2022 03:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiHJHph (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 Aug 2022 03:45:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48AD4B0C1
        for <linux-can@vger.kernel.org>; Wed, 10 Aug 2022 00:45:35 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oLgPF-0007D9-Es; Wed, 10 Aug 2022 09:45:33 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 823D9C65F4;
        Wed, 10 Aug 2022 07:45:32 +0000 (UTC)
Date:   Wed, 10 Aug 2022 09:45:30 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     David Boles <me@davidbol.es>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: PCAN and SocketCAN Questions
Message-ID: <20220810074530.or6oecnm7obmm7rh@pengutronix.de>
References: <CAMgOUGpGEUQgLgAQmYbn-UdWXCkC7kRqdhW-mfg=e2gq9QfqRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="clenp44uq56g3y3q"
Content-Disposition: inline
In-Reply-To: <CAMgOUGpGEUQgLgAQmYbn-UdWXCkC7kRqdhW-mfg=e2gq9QfqRQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--clenp44uq56g3y3q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.08.2022 19:35:09, David Boles wrote:
> Hello everyone, I'm new to both SocketCAN and mailing lists so please
> let me know if I'm making any faux pas or haven't correctly RTFMed! I
> heard this was the correct place to ask questions and I have a few
> that I haven't been able to find answers to.
>=20
> All my testing so far has been done on Ubuntu 20.04 with
> 5.15.0-43-generic and PCAN-USB( Pro) dongles and PCAN-PCI Express
> cards.
>=20
> Question 1: I've noticed that frames can get silently lost if my
> application doesn't read from the socket frequently enough. This also
> happens if I'm simultaneously dumping frames with candump (the "lost"
> frames do show up in candump's output). Increasing the socket receive
> buffer size with SO_RCVBUF allows more frames to be stored before new
> ones start getting lost. Is there a recommended way to detect this
> happening so that my program can fail noisily?

See candump's "-d" command line option.

| -d     (monitor dropped CAN frames)

> Question 2: I'd like to be able to send frames without other receivers
> on the bus to acknowledge them. The one-shot option seems to allow me
> to do this with my USB dongles. What's the difference between the
> one-shot and presume-ack options?

In one shot mode the controller only sends the frame once, there's no
automatic retransmission in case of an error, i.e. missing ACK. This
means in the error case the error counters are incremented as usual and
if enabled and supported by the driver you receive a CAN error frame on
the socket.

Refer to the m_can user manual
(https://github.com/hartkopp/M_CAN-User-Manual-History):

| Disabled Automatic Retransmission
|=20
| According to the CAN Speci=EF=AC=81cation (see ISO 11898-1:2015, 8.3.4 Re=
covery
| Management), the M_CAN provides means for automatic retransmission of
| frames that have lost arbitration or that have been disturbed by errors
| during transmission. By default automatic retransmission is enabled. To
| support time-triggered communication as described in ISO 11898-1:2015,
| chapter 9.2, the automatic retransmission may be disabled via CCCR.DAR.

Presume ACK, tells the hardware to presume the CAN frame was ACKed, this
results in no error and thus no retransmission.

> Question 3: I'd like to have as little latency as possible and I'm
> assuming using PCIe cards would be beneficial over USB.

ACK

> Unfortunately
> my PCAN-PCI Express card doesn't seem to support either one-shot or
> presume-ack; is that a hardware limitation or a driver limitation?

Maybe Stephane (Cc'ed) can answer this.

> If
> it's a hardware limitation, would anyone be able to recommend a
> low-latency, full-featured option for CAN on traditional x86/64
> desktops?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--clenp44uq56g3y3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLzYhcACgkQrX5LkNig
010ihAf/UgynHuDXLVw6IPUANth6d4bBCUv+y5UgLynt7rvxgx/mfJZTY08MP+1/
bU2OgvTakplYROq29Um9SQAP88EAMirhTpasUy8vyzKduXWW7B/ivW9cXdCRI+BV
iWDXwOJ7rRSHyvD+kOC0VGLPZmWXHcCFF1pN7t/o5hZCGvhICokiFamud3IvsEMY
Bh2AlO1ewe9hFa2wEqD+4z/aa4AaGiTcU7ELIFgc/k2k7LFrBGkjIfHM7uWNiCry
fkmzaq47CR/uEO/pWftNCenK0NZFIwbagQZwDLEPFPWuhET1qcJLqADQgwdxIqPA
eQfpYi/roLIfdjGez2jauhK9mP+2cg==
=u+37
-----END PGP SIGNATURE-----

--clenp44uq56g3y3q--
