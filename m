Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1886B3726C8
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 09:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhEDHth (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 03:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhEDHtg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 03:49:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC83C061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 00:48:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ldpnJ-00078f-2B; Tue, 04 May 2021 09:48:37 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4880:7cee:6dec:c8f9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2627D61B97B;
        Tue,  4 May 2021 07:48:35 +0000 (UTC)
Date:   Tue, 4 May 2021 09:48:34 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Ayoub Kaanich <kayoub5@live.com>,
        linux-can <linux-can@vger.kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: mcp251xfd receiving non ACKed frames (was: Re: More flags for
 logging)
Message-ID: <20210504074834.tki7gzr6wz2le6o3@pengutronix.de>
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
 <20210503100810.cacbmdfmpjipgoka@pengutronix.de>
 <CAMZ6RqLKp981zBus9K1RiLL14zC0B2BGp0U+xuQGvj1fjDMF1g@mail.gmail.com>
 <DBBPR03MB70828377F51A1747B4E9E6529D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
 <20210503154749.q3nrfjveixsqp3uj@pengutronix.de>
 <DBBPR03MB7082F029173018680E5D869C9D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
 <CAMZ6RqJ0t91e-e9LwzaLWTY6G9MY7mosos9-DEs=pc0mWRf86Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lvk43m5ldgx4vi4i"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJ0t91e-e9LwzaLWTY6G9MY7mosos9-DEs=pc0mWRf86Q@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--lvk43m5ldgx4vi4i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.05.2021 06:46:17, Vincent MAILHOL wrote:
> > And even on the mcp251xfd, where I receive the CAN frame, there's no way
> > to tell if this frame has been acked or not.

The test setup is:

                    flexcan (listen only)
                             |
                             |
   PEAK PCAN-USB FD ---------+--------- mcp2518fd (listen only)
        (sender)             |
                             |
               candlelight (going to be unplugged)

pcan-usb: sending CAN frames
flexcan: receiving CAN frames - but controller in listen only mode
mcp2518fd: receiving CAN frames - but controller in listen only mode
candlelight: receiving CAN frames - first attached, then detached

> The mcp251xfd behavior is interesting. Do you also receive the ACK
> error flag?

In my tests from yesterday neither the flexcan nor the mcp2518fd had bus
error reporting enabled. So I haven't noticed any ACK errors on the
mcp2518fd nor the flexcan.

I just repeated the test with bus error reporting enabled:

On the flexcan I receive _only_ these errors (repeating) with
candlelight detached:

| (2021-05-04 09:00:30.407709)        can0  RX - -  20000088   [8]  00 00 0=
8 00 00 00 00 00   ERRORFRAME
|        protocol-violation{{tx-dominant-bit-error}{}}
|        bus-error


On the mcp2518fd I see these errors:

| (2021-05-04 09:05:00.594321)  mcp251xfd0  RX - -  222   [8]  4A 00 00 00 =
00 00 00 00
| (2021-05-04 09:05:01.094418)  mcp251xfd0  RX - -  222   [8]  4B 00 00 00 =
00 00 00 00
| (2021-05-04 09:05:01.594577)  mcp251xfd0  RX - -  222   [8]  4C 00 00 00 =
00 00 00 00
=2E..unplug candlelight here...
| (2021-05-04 09:05:02.094878)  mcp251xfd0  RX - -  20000088   [8]  00 00 0=
2 00 00 00 00 00   ERRORFRAME
|        protocol-violation{{frame-format-error}{}}
|        bus-error
| (2021-05-04 09:05:02.095589)  mcp251xfd0  RX - -  20000088   [8]  00 00 0=
2 00 00 00 00 00   ERRORFRAME
|        protocol-violation{{frame-format-error}{}}
|        bus-error
| (2021-05-04 09:05:02.096263)  mcp251xfd0  RX - -  20000088   [8]  00 00 0=
2 00 00 00 00 00   ERRORFRAME
|        protocol-violation{{frame-format-error}{}}
|        bus-error
| (2021-05-04 09:05:02.096934)  mcp251xfd0  RX - -  20000088   [8]  00 00 0=
2 00 00 00 00 00   ERRORFRAME
|        protocol-violation{{frame-format-error}{}}
|        bus-error
| (2021-05-04 09:05:02.097596)  mcp251xfd0  RX - -  20000088   [8]  00 00 0=
2 00 00 00 00 00   ERRORFRAME
|        protocol-violation{{frame-format-error}{}}
|        bus-error
| (2021-05-04 09:05:02.098261)  mcp251xfd0  RX - -  20000088   [8]  00 00 0=
2 00 00 00 00 00   ERRORFRAME
|        protocol-violation{{frame-format-error}{}}
|        bus-error
| (2021-05-04 09:05:02.099035)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 =
00 00 00 00
| (2021-05-04 09:05:02.099054)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 =
00 00 00 00
| (2021-05-04 09:05:02.099603)  mcp251xfd0  RX - -  20000088   [8]  00 00 0=
0 00 00 00 00 00   ERRORFRAME
|        protocol-violation{{}{}}
|        bus-error

=66rom here now only RX frames, no error frames

| (2021-05-04 09:05:02.100540)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 =
00 00 00 00
| (2021-05-04 09:05:02.100570)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 =
00 00 00 00
| (2021-05-04 09:05:02.100583)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 =
00 00 00 00
| (2021-05-04 09:05:02.100593)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 =
00 00 00 00
| (2021-05-04 09:05:02.101326)  mcp251xfd0  RX - -  222   [8]  4D 00 00 00 =
00 00 00 00

=2E.. and repeating.


Here a short dump of the mcp2518fd registers:

| INT: intf(0x01c)=3D0xbf1a0806
|                 IE      IF      IE & IF
|         IVMI    x                       Invalid Message Interrupt
|         WAKI                            Bus Wake Up Interrupt
|         CERRI   x                       CAN Bus Error Interrupt
|         SERRI   x                       System Error Interrupt
|         RXOVI   x       x       x       Receive FIFO Overflow Interrupt
|         TXATI   x                       Transmit Attempt Interrupt
|         SPICRCI x                       SPI CRC Error Interrupt
|         ECCI    x                       ECC Error Interrupt
|         TEFI    x                       Transmit Event FIFO Interrupt
|         MODI    x                       Mode Change Interrupt
|         TBCI            x               Time Base Counter Interrupt
|         RXI     x       x       x       Receive FIFO Interrupt
|         TXI                             Transmit FIFO Interrupt

Note: there is no invalid message interrupt pending

| TREC: trec(0x034)=3D0x00000000
|             TXBO                Transmitter in Bus Off State
|             TXBP                Transmitter in Error Passive State
|             RXBP                Receiver in Error Passive State
|           TXWARN                Transmitter in Error Warning State
|           RXWARN                Receiver in Error Warning State
|            EWARN                Transmitter or Receiver is in Error Warni=
ng State
|              TEC =3D   0          Transmit Error Counter
|              REC =3D   0          Receive Error Counter
|=20
| BDIAG0: bdiag0(0x038)=3D0x00000010
|         DTERRCNT =3D   0          Data Bit Rate Transmit Error Counter
|         DRERRCNT =3D   0          Data Bit Rate Receive Error Counter
|         NTERRCNT =3D   0          Nominal Bit Rate Transmit Error Counter
|         NRERRCNT =3D  16          Nominal Bit Rate Receive Error Counter
|=20
| BDIAG1: bdiag1(0x03c)=3D0x0000dd4b
|            DLCMM                DLC Mismatch
|              ESI                ESI flag of a received CAN FD message was=
 set
|          DCRCERR                Data CRC Error
|         DSTUFERR                Data Bit Stuffing Error
|         DFORMERR                Data Format Error
|         DBIT1ERR                Data BIT1 Error
|         DBIT0ERR                Data BIT0 Error
|          TXBOERR                Device went to bus-off (and auto-recovere=
d)
|          NCRCERR                CRC Error
|         NSTUFERR                Bit Stuffing Error
|         NFORMERR                Format Error
|          NACKERR                Transmitted message was not acknowledged
|         NBIT1ERR                Bit1 Error
|         NBIT0ERR                Bit0 Error
|         EFMSGCNT =3D 56651                Error Free Message Counter

> Does the controller retry to send the frame until it gets
> acknowledged?

Yes - as it should.

> Are you still able to send frames and receive the echo if there is a
> single node on the network?

No - But the peak driver/hw has some limitations:

The peak driver doesn't have TX complete signaling, it send the echo
after sending the TX CAN frame via USB. And the peak controller seems to
buffer quite a lot TX CAN frames, so it looks for the first ~72 frames
like the bus is still working.

Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--lvk43m5ldgx4vi4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCQ/E8ACgkQqclaivrt
76lkVwf9Fk1xzoBGfqD0f6a9mEBiPwMOBThEAn2eFEUMIzoRDE2/z7JULQzGmrRa
Be1nv0bcAoHf9ZjqSN6kqwhOX+qf/qA2gA+U7Cau9FV71vAoXbmqBSXkUoIGRGx5
m6P+kFyKNjG/lpDZRWIMZYEQYgELx5/dzpg6wwfqrLYEbAvllNJtmz5cM4TuE7T+
jnapOtjboC+z5WRz8dgImF5YGiFwVkEYDj2dNpgxlj4+RQIneTj2hzMO72GbGy77
OeJAkQj3BZgNjrfj5RXrTUvZfWeUmPBFBvMWterOegDzhwYSBa7w/7Un24VmvCQ+
vGhKWNNwi5GmgjvQCWQrDVTO7GKffw==
=A/v7
-----END PGP SIGNATURE-----

--lvk43m5ldgx4vi4i--
