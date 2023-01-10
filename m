Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDA9664B79
	for <lists+linux-can@lfdr.de>; Tue, 10 Jan 2023 19:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjAJSpc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Jan 2023 13:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbjAJSpJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2023 13:45:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B459C9087E
        for <linux-can@vger.kernel.org>; Tue, 10 Jan 2023 10:40:05 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pFJXW-0005sw-Ti; Tue, 10 Jan 2023 19:40:02 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7a66:5fec:540b:6f91])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7695C153986;
        Tue, 10 Jan 2023 18:40:00 +0000 (UTC)
Date:   Tue, 10 Jan 2023 19:39:52 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas.Kopp@microchip.com
Cc:     Stefan.Althoefer@janztec.com, linux-can@vger.kernel.org
Subject: Re: RE: AW: AW: mcp251xfd: Bad message receiption (1/2)
Message-ID: <20230110183952.pvtuw5gudefnnyv5@pengutronix.de>
References: <20221222130219.xrfnm54g6lfjozvs@pengutronix.de>
 <FR0P281MB19666A63278AAA9D20B6989297E99@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20221224155705.l6qx3xu34nmo3ehn@pengutronix.de>
 <FR0P281MB196615471DB16E566528E7F097F09@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966783A50BDAD455BBC7F1A97F69@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966543302DB6485C49F8A2E97F59@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966801F8A7BCC540D40A4DE97FE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64849F53D129B61D79952538FBFF9@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230110145322.4bqwlw3owesc5myj@pengutronix.de>
 <20230110170857.5ejgppyjnoc2adji@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="md6a2rqbswz35na2"
Content-Disposition: inline
In-Reply-To: <20230110170857.5ejgppyjnoc2adji@pengutronix.de>
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


--md6a2rqbswz35na2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Another failure, it looks similar:

| do_rxif_analyze: ct=3D0x0a ch=3D0x0b cd=3D0x01 rt=3D0x000000fa rh=3D0x000=
000fb rd=3D0x01
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag
| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0b ch=3D0x0c cd=3D0x01 rt=3D0x000000fb rh=3D0x000=
000fc rd=3D0x01
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag
| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0c ch=3D0x0f cd=3D0x03 rt=3D0x000000fc rh=3D0x000=
000ff rd=3D0x03
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag
| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0f ch=3D0x0e cd=3D0x0f rt=3D0x000000ff rh=3D0x000=
0010e rd=3D0x0f
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF   x            Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag
| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0e ch=3D0x0e cd=3D0x10 rt=3D0x0000010e rh=3D0x000=
0011e rd=3D0x10
|         TFERFFIF   x            Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF   x            Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag
| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0e ch=3D0x0f cd=3D0x01 rt=3D0x0000011e rh=3D0x000=
0011f rd=3D0x01
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag
| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0f ch=3D0x00 cd=3D0x01 rt=3D0x0000011f rh=3D0x000=
00120 rd=3D0x01
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag

| BDIAG1: bdiag1(0x03c)=3D0x00000100
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
|          NACKERR                Transmitted message was not acknowledged=
=20
|         NBIT1ERR                Bit1 Error
|         NBIT0ERR                Bit0 Error
|         EFMSGCNT =3D 0x0100       Error Free Message Counter

| TX-0 Object: 0x03 (0xaf8)
|               id =3D 0x000002a5
|            flags =3D 0x0001fe08
|    SEQ_MCP2517FD =3D 0x00007f             Sequence (MCP2517)
|    SEQ_MCP2518FD =3D 0x0000ff             Sequence (MCP2518)
|             data =3D 00 03 72 e4  78 54 d6 ed

The correct message counter is 0x100, the wrong one 0x120. That's 2x
FIFO size. I'd like to know when the FIFO head is wrong for the first
time, one that results in a data transfer where "old" FIFO contents is
read. I haven't dumped any data yet.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--md6a2rqbswz35na2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmO9sPUACgkQrX5LkNig
0118/ggAhwhoCn8PXHbEhvFyBTyNLoAOhNO/hF8vN9I9L+E7npPMDxU6hWEUr6jH
dK60h6HKdjM5uJSO7uHL8GVMnddIztIgy2RPL0I1oFTSbIhXYCDNClh+zIYyTcU7
Utk2yeiZh88sO3WEqatlj/WF2rTyir8GP5BRE2CR/IwOGzL3BfbZaNjR7Qlke9QF
1t9NX/ek3gpRHlbx1YTF9xnww28M33r1M38EbiI6dqLJPKEucqS2JsfZF6+/x9W7
6fTEm6EMsu4b2Vcf17ozsVusA+y97LTuCYwxXDcwnhahENNV7wZqFGH3hEnVwklN
J/odsIntydFOwd0yy8II6kqnhXa+9g==
=fzUv
-----END PGP SIGNATURE-----

--md6a2rqbswz35na2--
