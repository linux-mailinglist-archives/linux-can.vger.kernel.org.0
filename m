Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30FF6F7F3A
	for <lists+linux-can@lfdr.de>; Fri,  5 May 2023 10:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjEEIkW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 May 2023 04:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjEEIkV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 May 2023 04:40:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D6E18875
        for <linux-can@vger.kernel.org>; Fri,  5 May 2023 01:40:19 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1puqyp-0001ch-D5; Fri, 05 May 2023 10:39:55 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 076671BE64B;
        Fri,  5 May 2023 08:39:53 +0000 (UTC)
Date:   Fri, 5 May 2023 10:39:52 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas.Kopp@microchip.com
Cc:     marex@denx.de, linux-can@vger.kernel.org, fedor.ross@ifm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        lgirdwood@gmail.com, mani@kernel.org, broonie@kernel.org,
        pabeni@redhat.com, wg@grandegger.com
Subject: Re: RE: RE: [PATCH] can: mcp251xfd: Increase poll timeout
Message-ID: <20230505-stardust-bride-d79d1338413e-mkl@pengutronix.de>
References: <20230504195059.4706-1-marex@denx.de>
 <20230505-kilt-exclusion-fd2a2423deb1-mkl@pengutronix.de>
 <BL3PR11MB64846C83ACD04E9330B0FE66FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230505-unhearing-paragraph-9b5b994f185f-mkl@pengutronix.de>
 <BL3PR11MB648479549F7120050ED93740FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="psstx2rjhiaghmqb"
Content-Disposition: inline
In-Reply-To: <BL3PR11MB648479549F7120050ED93740FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
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


--psstx2rjhiaghmqb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.05.2023 08:21:36, Thomas.Kopp@microchip.com wrote:
> > On 05.05.2023 07:07:03, Thomas.Kopp@microchip.com wrote:
> > > > The datasheet "MCP25xxFD Family Reference Manual" says it needs an =
idle
> > > > bus.
> > >
> > > Technically what's needed is an idle condition on the bus as specified
> > > in the ISO. i.e. 11 consecutive sampled recessive bits after a full
> > > frame (if one is currently in transmission).
> >=20
> > Right. What happens if another CAN frames comes before there are 11
> > consecutive sampled recessive bits? The IFS for CAN is 3 bits?
>=20
> Not quite. Between the Frames is an IFS that's correct but the IFS
> consists of an Intermission which is 3 bits long + a bus idle
> condition of 11 bits. Regular frames have to wait for the IFS to
> elapse BUT there's an exception for error frames and overload frames.
> EF may be up to 12 bit, OF are 8 dominant + 8 recessive bits, browsing
> through the spec I think only 2 OFs can happen consecutively. Adding
> another 32 bits to the formula should cover this.
>=20
> > > > > diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > > > b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > > > > index 68df6d4641b5c..9908843798cef 100644
> > > > > --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > > > > +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > > > > @@ -227,6 +227,7 @@ static int
> > > > >  __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
> > > > >  			  const u8 mode_req, bool nowait)
> > > > >  {
> > > > > +	const struct can_bittiming *bt =3D &priv->can.bittiming;
> > > > >  	u32 con =3D 0, con_reqop, osc =3D 0;
> > > > >  	u8 mode;
> > > > >  	int err;
> > > > > @@ -251,7 +252,8 @@ __mcp251xfd_chip_set_mode(const struct
> > > > mcp251xfd_priv *priv,
> > > > >
> > > > FIELD_GET(MCP251XFD_REG_CON_OPMOD_MASK,
> > > > >  						 con) =3D=3D mode_req,
> > > > >  				       MCP251XFD_POLL_SLEEP_US,
> > > > > -				       MCP251XFD_POLL_TIMEOUT_US);
> > > > > +				       max(MCP251XFD_POLL_TIMEOUT_US,
> > > > > +					   576 * USEC_PER_SEC / bt->bitrate));
> > > >
> > > > Let's use CANFD_FRAME_LEN_MAX * BITS_PER_BYTE instead of 576. I can
> > fix
> > > > this while applying.
> > > >
> > > So, I'd suggest CANFD_FRAME_LEN_MAX * BITS_PER_BYTE + 11 + stuffbits,
> > > as far as I can tell the CANFD_FRAME_LEN_MAX ignores stuffbits, so as
> > > an overapproximation something like (CANFD_FRAME_LEN_MAX *
> > > BITS_PER_BYTE) * 1.2 + 11.
> >=20
> > ..and a define for the 11 and a comment for the * 1.2
> >=20
> Right, I think definitions for the 11 and the 1.2 make sense in the
> include/linux/can/length.h anyway.

Sounds good, make this a separate patch.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--psstx2rjhiaghmqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRUwNUACgkQvlAcSiqK
BOioOAgAmLib19cFrxmRwP7i+ExXX7Oq/XmgrKBIc9qHnqKNCgjyLX21wsOztRVE
nshtvgQ1ojtm8veNawgy2Qd6Eirol3QRygw8Z7/PEObBKqF656z1oytdE9tGD3T6
lwc9kGBABInJiqroKAhdn8SG+hxD7dGzU49BuqgXO8pZjdWVOageQW5rs2sB4Q1Z
F58aXgtYbQ+juajX6c0cTU1WWS58VMCPVdPdvifYCsOWbG/Xq7i7MSaamTCtNp28
AIqeiEItt3jKejLdUlJ/UMyA7QZ+oYjqm1pVXu0lED+S2oqGc6nfnX5CgVmCOAxa
3BhG+SelUB0vxtc7w8y2KfqDZqZ8ag==
=QTnq
-----END PGP SIGNATURE-----

--psstx2rjhiaghmqb--
