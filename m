Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA2566470B
	for <lists+linux-can@lfdr.de>; Tue, 10 Jan 2023 18:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjAJRJL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Jan 2023 12:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjAJRJK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2023 12:09:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F5CB4A
        for <linux-can@vger.kernel.org>; Tue, 10 Jan 2023 09:09:09 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pFI7X-0003eP-2c; Tue, 10 Jan 2023 18:09:07 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7a66:5fec:540b:6f91])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E1C801538AF;
        Tue, 10 Jan 2023 17:09:05 +0000 (UTC)
Date:   Tue, 10 Jan 2023 18:08:57 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas.Kopp@microchip.com
Cc:     Stefan.Althoefer@janztec.com, linux-can@vger.kernel.org
Subject: Re: RE: AW: AW: mcp251xfd: Bad message receiption (1/2)
Message-ID: <20230110170857.5ejgppyjnoc2adji@pengutronix.de>
References: <FR0P281MB1966CA0C12ED24574368A36E97E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20221222130219.xrfnm54g6lfjozvs@pengutronix.de>
 <FR0P281MB19666A63278AAA9D20B6989297E99@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20221224155705.l6qx3xu34nmo3ehn@pengutronix.de>
 <FR0P281MB196615471DB16E566528E7F097F09@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966783A50BDAD455BBC7F1A97F69@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966543302DB6485C49F8A2E97F59@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966801F8A7BCC540D40A4DE97FE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64849F53D129B61D79952538FBFF9@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230110145322.4bqwlw3owesc5myj@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wtwol67v3s7enam4"
Content-Disposition: inline
In-Reply-To: <20230110145322.4bqwlw3owesc5myj@pengutronix.de>
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


--wtwol67v3s7enam4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.01.2023 15:53:22, Marc Kleine-Budde wrote:
> On 10.01.2023 12:50:18, Thomas.Kopp@microchip.com wrote:
> > > For the last case, I attached debugger after the fail an tried to rea=
d from the
> > > socket until read returned -1:
> > >     (gdb) p malloc(72)
> > >     (gdb) p read(sockfd,$1,72)
> > >     (gdb) print fprint_canframe_mtu(stdout, $1, "\n", 4, 72) And surp=
rise
> > > surprise, there were more CAN frames in store. Refer to the log/pdf.
> >=20
> > I was finally able to reproduce the issue and capture a full SPI/CAN
> > log when it happens. At this point it looks like the tail pointer of
> > the FIFO in the MCP2518FD gets corrupted and the driver does what it's
> > supposed to do and reads out lots of frames...
>=20
> You mean the head pointer?

I've reproduced the issue here, too, on a single-core imx6,
net-next/master from end of last year.

I added some tracing to the driver and recoded the following events.

Let me explain how to read this. The "chip" variants are read from the
chip via SPI. The "ring" variants are the cached values in the driver.

                   chip-tail       chip-delta (head-tail)
                     |     chip-head |
                     |       |       |     ring-tail     ring-head     ring=
-delta
                     |       |       |       |             |             | =
(head-tail)
| do_rxif_analyze: ct=3D0x0b ch=3D0x0c cd=3D0x01 rt=3D0x00000c9b rh=3D0x000=
00c9c rd=3D0x01
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag
          ^^^^^^^^
These are the decoded lowest 3 bits of the FIFOSTA register.

The different runs of the rxif handler (mcp251xfd_handle_rxif()) are
separated by a ("----") line.


Now the analysis:

| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x09 ch=3D0x0a cd=3D0x01 rt=3D0x00000c99 rh=3D0x000=
00c9a rd=3D0x01
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag
| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0a ch=3D0x0b cd=3D0x01 rt=3D0x00000c9a rh=3D0x000=
00c9b rd=3D0x01
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag
| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0b ch=3D0x0c cd=3D0x01 rt=3D0x00000c9b rh=3D0x000=
00c9c rd=3D0x01
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag

So far everything looks good. The chip delta ("cd"), i.e. the CAN frames
waiting to be read is 1. The ring delta is 1, too. Meaning 1 CAN frame
has been read.

| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0c ch=3D0x0f cd=3D0x03 rt=3D0x00000c9c rh=3D0x000=
00c9f rd=3D0x03
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag

Now 3 CAN frame are waiting to be read. Thomas told me that he sees 3
CAN frames waiting too, before things go downhill.

| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0f ch=3D0x0e cd=3D0x0f rt=3D0x00000c9f rh=3D0x000=
00cae rd=3D0x0f
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF   x            Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag

This is strange: chip head "jumped" to 0x0e, this means there are 0x0f
CAN frames waiting. However the FIFO flags (FIFO Half Full set, FIFO
Full not set) are consistent with 0x0f waiting CAN frames, the FIFO size
if 0x10.

Note: The chip tail "ct=3D0x0f" is consistent, as the "old" chip head was
      0x0f.

| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0e ch=3D0x0e cd=3D0x10 rt=3D0x00000cae rh=3D0x000=
00cbe rd=3D0x10
|         TFERFFIF   x            Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF   x            Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag

Chip tail is consistent (0x0e) as it equals the old chip head. chip head
is also 0x0e, this means either an empty or a full FIFO, the flags
indicate a full FIFO.

The following events seem to be OK:

| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0e ch=3D0x0f cd=3D0x01 rt=3D0x00000cbe rh=3D0x000=
00cbf rd=3D0x01
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag
| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0f ch=3D0x00 cd=3D0x01 rt=3D0x00000cbf rh=3D0x000=
00cc0 rd=3D0x01
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag
| -------------------------------------------------------------------------=
-------

Final note on the number of send and received CAN frames.

The ring head (in the event above) shows 0x0cc0 received CAN frames.
The sequence number in the register dump shows 0x000c9f, which means a
total of 0x000ca0 CAN frames have been send.

| TX-0 Object: 0x03 (0xaf8)
|               id =3D 0x000002a5
|            flags =3D 0x00193e08
|    SEQ_MCP2517FD =3D 0x00001f             Sequence (MCP2517)
|    SEQ_MCP2518FD =3D 0x000c9f             Sequence (MCP2518)
|             data =3D 00 03 69 df  c5 ee 62 77

The BDIAG1 register gives a total of 0x0ca0 error free messages, looks
consistent, too Thomas is this RX'ed or TX'ed error free messages?

| BDIAG1: bdiag1(0x03c)=3D0x00000ca0
[...]
|         EFMSGCNT =3D 0x0ca0       Error Free Message Counter

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wtwol67v3s7enam4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmO9m6YACgkQrX5LkNig
012leQf+Ljx4dUSQ03U3q8wQdyMLtYWZ6xUBPUe9VaBDkXplSrbr51yopDZ650vD
DtMWMQYKQLmqIE5CvYNKt7QP8HHmQF62C/qf9SP29O1S5tQkpOJk97lVBwg5FWhd
w4MJaT2B4RUMTFam9o7FuaOX/EKURUz7hlDKF9tZhFwTyQyZDIDht9wFoe1f2VsX
wlo3wA49vKaELq2elMEihc8ZoCX4IVNTFmNU/kqpn7klD6XEUV8Z2z29aFD6vDlK
iGCoAJ1xdYL9n5xGXAAHIzDtb+107JPohyC2BxZ7lG9TwGl3lb6JV2yyRwmndONQ
kjPkngikSaKlUebiblMUNOg0QX87Mw==
=yKVt
-----END PGP SIGNATURE-----

--wtwol67v3s7enam4--
