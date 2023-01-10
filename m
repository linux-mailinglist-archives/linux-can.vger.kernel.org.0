Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBD9664E4C
	for <lists+linux-can@lfdr.de>; Tue, 10 Jan 2023 22:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjAJVul (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Jan 2023 16:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjAJVuk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2023 16:50:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6F05BA1E
        for <linux-can@vger.kernel.org>; Tue, 10 Jan 2023 13:50:38 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pFMVv-0002X4-G4; Tue, 10 Jan 2023 22:50:35 +0100
Received: from pengutronix.de (hardanger-3.fritz.box [IPv6:2a03:f580:87bc:d400:5d1d:2f90:6e72:2410])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 98B51153B02;
        Tue, 10 Jan 2023 21:50:33 +0000 (UTC)
Date:   Tue, 10 Jan 2023 22:50:33 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas.Kopp@microchip.com
Cc:     Stefan.Althoefer@janztec.com, linux-can@vger.kernel.org
Subject: Re: RE: RE: AW: AW: mcp251xfd: Bad message receiption (1/2)
Message-ID: <20230110215033.xcz7g3ubonuawqr5@pengutronix.de>
References: <20221224155705.l6qx3xu34nmo3ehn@pengutronix.de>
 <FR0P281MB196615471DB16E566528E7F097F09@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966783A50BDAD455BBC7F1A97F69@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966543302DB6485C49F8A2E97F59@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966801F8A7BCC540D40A4DE97FE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64849F53D129B61D79952538FBFF9@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230110145322.4bqwlw3owesc5myj@pengutronix.de>
 <20230110170857.5ejgppyjnoc2adji@pengutronix.de>
 <20230110183952.pvtuw5gudefnnyv5@pengutronix.de>
 <BL3PR11MB6484FC468720BAB0660766A8FBFF9@BL3PR11MB6484.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="22prigflwv2p2al6"
Content-Disposition: inline
In-Reply-To: <BL3PR11MB6484FC468720BAB0660766A8FBFF9@BL3PR11MB6484.namprd11.prod.outlook.com>
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


--22prigflwv2p2al6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.01.2023 21:40:16, Thomas.Kopp@microchip.com wrote:
> > The correct message counter is 0x100, the wrong one 0x120. That's 2x
> > FIFO size. I'd like to know when the FIFO head is wrong for the first
> > time, one that results in a data transfer where "old" FIFO contents is
> > read. I haven't dumped any data yet.

I got a chip-delta =3D=3D 4 error.

> Not sure what you mean. Do you want the message counter at that point
> in time?

I want to know the chip tail where the driver reads the first time old
data. For example in this trace:

| do_rxif_analyze: ct=3D0x07 ch=3D0x08 cd=3D0x01 rt=3D0x00000427 rh=3D0x000=
00428 rd=3D0x01
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag
| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x08 ch=3D0x09 cd=3D0x01 rt=3D0x00000428 rh=3D0x000=
00429 rd=3D0x01
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag
| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x09 ch=3D0x0a cd=3D0x01 rt=3D0x00000429 rh=3D0x000=
0042a rd=3D0x01
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag

chip delta is 1, so probably OK.

| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0a ch=3D0x0e cd=3D0x04 rt=3D0x0000042a rh=3D0x000=
0042e rd=3D0x04
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF                Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag

chip delta is 4. Are all RX objects (0xa, 0xb, 0xc and 0xd) valid data?

| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0e ch=3D0x0c cd=3D0x0e rt=3D0x0000042e rh=3D0x000=
0043c rd=3D0x0e
|         TFERFFIF                Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF   x            Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag

Are the read RX objects are all valid data?

| -------------------------------------------------------------------------=
-------
| do_rxif_analyze: ct=3D0x0c ch=3D0x0c cd=3D0x10 rt=3D0x0000043c rh=3D0x000=
0044c rd=3D0x10
|         TFERFFIF   x            Receive FIFO Full Interrupt Flag=20
|         TFHRFHIF   x            Receive FIFO Half Full Interrupt Flag
|         TFNRFNIF   x            Receive FIFO Not Empty Interrupt Flag

We read the whole FIFO, is everything valid data? Probably not. Which RX
FIFO object is the first "bad" one?

| -------------------------------------------------------------------------=
-------

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--22prigflwv2p2al6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmO93aUACgkQrX5LkNig
012gIAf/dVQMSBsCQPOWRJ3Xm3WbikHvJQ1D/HH51Ps2MBOmDUwzkVbdSO2ZQAjw
WLrkpwFSayXtwYc2/iaTfZaWadguiCSo33QnPw0esl8h/kcVddxaKm5mxwaVqIho
JjbBm7MrswgY0qxhftNWEKknSjFFIcjf7/OGm1OSW0Ddbe2tOmYh38czvE750b2M
+rgCGvC4FmALUOSv1B0t5qR2jz8RCF2m/+DHPT/tncpICJTvk2uPHH+QIFqMLfMw
LT0jKfCmBcIdpvwWxsktTVJQzSNu5Jk2bhfIAnad7aNAHDqLoI9Lq5JdxRl5j2UI
BnerViSTLfwVr5kzT3PDfG5SB5mQug==
=dKpF
-----END PGP SIGNATURE-----

--22prigflwv2p2al6--
