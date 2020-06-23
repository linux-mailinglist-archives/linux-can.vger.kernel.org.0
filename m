Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FF2204971
	for <lists+linux-can@lfdr.de>; Tue, 23 Jun 2020 08:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgFWGCF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Jun 2020 02:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbgFWGCF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Jun 2020 02:02:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B1BC061573
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 23:02:04 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jnc0Q-00076r-3i; Tue, 23 Jun 2020 08:02:02 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jnc0P-0000TG-7W; Tue, 23 Jun 2020 08:02:01 +0200
Date:   Tue, 23 Jun 2020 08:02:01 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        dev.kurt@vandijck-laurijssen.be
Subject: Re: [PATCH v41 2/3] dt-binding: can: mcp25xxfd: document device tree
 bindings
Message-ID: <20200623060201.ms2brvzk7s6arnjf@pengutronix.de>
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200622114603.965371-3-mkl@pengutronix.de>
 <20200622165325.GA23113@Mani-XPS-13-9360>
 <89ebabc5-dd88-32ed-65b3-911d3d80237b@pengutronix.de>
 <20200623032635.GG11093@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2syqhncadpimjxuf"
Content-Disposition: inline
In-Reply-To: <20200623032635.GG11093@Mani-XPS-13-9360>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:52:41 up 220 days, 21:11, 215 users,  load average: 0.05, 0.05,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--2syqhncadpimjxuf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2020 at 08:56:35AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jun 22, 2020 at 08:12:58PM +0200, Marc Kleine-Budde wrote:
> > On 6/22/20 6:53 PM, Manivannan Sadhasivam wrote:
> > > Hi,
> > >=20
> > > On Mon, Jun 22, 2020 at 01:46:02PM +0200, Marc Kleine-Budde wrote:
> > >> From: Oleksij Rempel <o.rempel@pengutronix.de>
> > >>
> > >> This patch adds the device-tree binding documentation for the Microc=
hip
> > >> MCP25xxFD SPI CAN controller family.
> > >>
> > >> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > >=20
> > > You need to CC Rob and devicetree list to get a review for this patch.
> >=20
> > Will do for next round.
> >=20
> > >=20
> > >> ---
> > >>  .../bindings/net/can/microchip,mcp25xxfd.yaml | 77 ++++++++++++++++=
+++
> > >>  1 file changed, 77 insertions(+)
> > >>  create mode 100644 Documentation/devicetree/bindings/net/can/microc=
hip,mcp25xxfd.yaml
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp=
25xxfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd=
=2Eyaml
> > >> new file mode 100644
> > >> index 000000000000..4993dd49181c
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.=
yaml
> > >> @@ -0,0 +1,77 @@
> > >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >> +%YAML 1.2
> > >> +---
> > >> +$id: http://devicetree.org/schemas/net/can/microchip,mcp25xxfd.yaml#
> > >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >> +
> > >> +title: Microchip MCP2517/18FD stand-alone CAN controller device tre=
e bindings
> > >> +
> > >=20
> > > MCP251{7/8}FD?
> >=20
> > Which expansion rules should be use for the title? In sh-like shells it=
 would be
> > MCP251{7,8}FD.
> >=20
>=20
> Either one. I was just concerned about the original one which might create
> ambiguity.
>=20
> > >=20
> > >> +maintainers:
> > >> +  - Marc Kleine-Budde <mkl@pengutronix.de>
> > >> +
> > >> +properties:
> > >> +  compatible:
> > >> +    oneOf:
> > >> +      - const: microchip,mcp2517fd
> > >> +        description: for MCP2517FD
> > >> +      - const: microchip,mcp2518fd
> > >> +        description: for MCP2518FD
> > >> +      - const: microchip,mcp25xxfd
> > >> +        description: to autodetect chip variant
> > >> +
> > >=20
> > > Actually what benefit this generic compatible provides? User who is i=
ntegrating
> > > this driver should know the exact controller instance he is playing w=
ith, isn't
> > > it?
> >=20
> > As the chip variant can be autodetected why not do it? It makes device =
tree
> > overlays (e.g. for the rpi much simpler), as you don't have to specify =
the exact
> > chip variant.
> >=20
> > Testing is much easier, as I don't have to change the overlays if swapp=
ing the
> > CAN hat.
> >=20
>=20
> Okay.
>=20
> > >=20
> > >> +  reg:
> > >> +    maxItems: 1
> > >> +
> > >> +  interrupts-extended:
> > >> +    maxItems: 1
> > >> +
> > >=20
> > > Document this just above 'interrupts' property.
> >=20
> > Do you mean I should change the order?
> > - reg:
> > - clocks:
> > - interrupts-extended:
> >=20
>=20
> Sorry, please ignore this comment. You can keep the order as it is.
>=20
> > >=20
> > >> +  clocks:
> > >> +    maxItems: 1
> > >> +
> > >> +  vdd-supply:
> > >> +    description: Regulator that powers the CAN controller.
> > >> +    maxItems: 1
> > >> +
> > >> +  xceiver-supply:
> > >> +    description: Regulator that powers the CAN transceiver.
> > >> +    maxItems: 1
> > >> +
> > >> +  rx-int-gpios:
>=20
> This doesn't look like a standard property. So I think you need to add
> 'microchip' prefix to make it as vendor specific.
>=20
> > >> +    description:
> > >> +      GPIO phandle of GPIO connected to to INT1 pin of the MCP25XXF=
D, which
> > >> +      signals a pending RX interrupt.
> > >> +    maxItems: 1
> > >> +
> > >> +  spi-max-frequency:
> > >> +    description:
> > >> +      Must be half or less of "clocks" frequency.
> > >> +    maximum: 20000000
> > >> +
> > >> +required:
> > >> +  - compatible
> > >> +  - reg
> > >> +  - interrupts-extended
> > >> +  - clocks
> > >> +
> > >=20
> > > The controller is capable of generating clocks and also able to contr=
ol few
> > > GPIOs. So eventually you need to document those properties in binding=
s even
> > > your driver is not supporting all of them atm.
> >=20
> > I'd like to add support for clocks and GPIOs as soon as someone needs t=
hem. DT
> > bindings will go along with that. So far I have no customer that needs =
support
> > for that, do you?
> >=20
>=20
> DT binding should describe what the controller is capable of and not the
> capability of the driver. You can always add functionality to driver but =
binding
> should stay as it is (although there are exceptions...).

Adding binding for not implemented functionality adds more confusion:
- without implementing it, you do not know, how exactly should it be
  done. Should we request gpio as gpio or as irq? This will affect
  actual bindings.
- we need to care about backwards compatibility, implementing binding
  before knowing what they will do, will make driver development even harde=
r.
  You need to care about quirks for bogus binding which was actually
  never used.
- Extending a binding can be always done if needed. Making things "just
  in case" will increase development overhead by reducing quality.

Regards,
Oleksij

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--2syqhncadpimjxuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl7xmtgACgkQ4omh9DUa
UbNS5BAAmGAsOpPE4sdGHtB64CnohP+6GZi8UwloX7+JleUOIvrmsN/Ny6WLuIi2
yYtYh+nR9pRtRlWUO1xUPem/Gkr8cZTBq4bv53IECMgn8kJ3Rk+I36lJ5R5+C3bL
DFKNGwyQdDuBw0Ez6AHjQb2EUr3i33UYoOP3/itrxKP1RimVUdt04iq/JsCiA1PZ
f7a5XfFOGnIdLj1DEcOAyEQ+X8q2mT5BMw/qfrSE+N/jzK6bMRiEEcExrHc8gfyg
5+yn7jJIK/MDYCN3vgIcLrm5YwPon5hwRNOyixHT7WgPa3U2Bulv+4ELQSHo/+X7
J+JmO48mYZNMerf+fbjVLDVCK1Pn87vm78aXRcyPDrv+CpHddzmzwflvVpD+zCkn
WdRsFswqNp7cme1TiWKL+SoQsT13E/5Cqbyes45SR3cZke3pPg7g8CDAl0aod8bJ
xuOE072Qi9RpYQ4LkHUokTDqRY9pXwt4Z7zaTkng1s35bivOJz5ZSSykes7ZPhlp
Od5JfiDiP3kRdTe7bOrxstnXriZ+iL3Qroul1y2XUsXeI/R0sRrcRZ7wV+DlC1l7
MUo6YaKMVJRrv8vzn2d0Ftv9R1ILaQ/fzkK36nwQIORrf7pXPaWIJFQhevuRThYA
s/6MspJz838IEfArFl1PB2mBXG45jrttX1zWYnhvBEJ0Zwst7NE=
=ACgP
-----END PGP SIGNATURE-----

--2syqhncadpimjxuf--
