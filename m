Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB41275648
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 12:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIWK0u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 06:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWK0t (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 06:26:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B14C0613CE
        for <linux-can@vger.kernel.org>; Wed, 23 Sep 2020 03:26:49 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kL1z5-0005Gw-Tb; Wed, 23 Sep 2020 12:26:48 +0200
Received: from [IPv6:2a03:f580:87bc:d400:8d0c:cfd0:3f99:a545] (unknown [IPv6:2a03:f580:87bc:d400:8d0c:cfd0:3f99:a545])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B938E567B25;
        Wed, 23 Sep 2020 10:26:46 +0000 (UTC)
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-can@vger.kernel.org
References: <20200923095447.GA1464378@mwanda>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [bug report] can: mcp25xxfd: add driver for Microchip MCP25xxFD
 SPI CAN
Message-ID: <6b4ce720-7208-24b5-1057-613eedc0fd6d@pengutronix.de>
Date:   Wed, 23 Sep 2020 12:26:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923095447.GA1464378@mwanda>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NbkifFIjf0GNYRln5hWmxoMvqqoIPpcFA"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NbkifFIjf0GNYRln5hWmxoMvqqoIPpcFA
Content-Type: multipart/mixed; boundary="wllwJnWBxFjJYjnFMDUdeZCs7MwjJacGK";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-can@vger.kernel.org
Message-ID: <6b4ce720-7208-24b5-1057-613eedc0fd6d@pengutronix.de>
Subject: Re: [bug report] can: mcp25xxfd: add driver for Microchip MCP25xxFD
 SPI CAN
References: <20200923095447.GA1464378@mwanda>
In-Reply-To: <20200923095447.GA1464378@mwanda>

--wllwJnWBxFjJYjnFMDUdeZCs7MwjJacGK
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 9/23/20 11:54 AM, Dan Carpenter wrote:
> Hello Marc Kleine-Budde,
>=20
> The patch 55e5b97f003e: "can: mcp25xxfd: add driver for Microchip
> MCP25xxFD SPI CAN" from Sep 18, 2020, leads to the following static
> checker Smatch warning:
>=20
> drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:2271 mcp25xxfd_tx_obj_fr=
om_skb() warn: user controlled 'len' cast to postive rl =3D '(-249)-(-1),=
1-67'
> drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:2272 mcp25xxfd_tx_obj_fr=
om_skb() error: 'memcpy()' 'hw_tx_obj->data' too small (64 vs 255)
> drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:2272 mcp25xxfd_tx_obj_fr=
om_skb() error: 'memcpy()' 'cfd->data' too small (64 vs 255)
> drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:2272 mcp25xxfd_tx_obj_fr=
om_skb() error: 'cfd->len' from user is not capped properly
>=20
> (Only one of these checks is published and it's disabled unless you
> run with the --spammy flag).

=46rom my point of view they look like false positive, let's see:

> drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
>   2208  static void
>   2209  mcp25xxfd_tx_obj_from_skb(const struct mcp25xxfd_priv *priv,
>   2210                            struct mcp25xxfd_tx_obj *tx_obj,
>   2211                            const struct sk_buff *skb,
>   2212                            unsigned int seq)
>   2213  {
>   2214          const struct canfd_frame *cfd =3D (struct canfd_frame *=
)skb->data;
>                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^
> Smatch distrusts all skb->data information.

We do neither.

The function in question is only called from mcp25xxfd_tx_obj_from_skb():=


> static netdev_tx_t mcp25xxfd_start_xmit(struct sk_buff *skb,
> 					struct net_device *ndev)
> {
> 	struct mcp25xxfd_priv *priv =3D netdev_priv(ndev);
> 	struct mcp25xxfd_tx_ring *tx_ring =3D priv->tx;
> 	struct mcp25xxfd_tx_obj *tx_obj;
> 	u8 tx_head;
> 	int err;
>=20
> 	if (can_dropped_invalid_skb(ndev, skb))
            ^^^^^^^^^^^^^^^^^^^^^^^
> 		return NETDEV_TX_OK;
>=20
> 	if (mcp25xxfd_tx_busy(priv, tx_ring))
> 		return NETDEV_TX_BUSY;
>=20
> 	tx_obj =3D mcp25xxfd_get_tx_obj_next(tx_ring);
> 	mcp25xxfd_tx_obj_from_skb(priv, tx_obj, skb, tx_ring->head);
[...]
> }

can_dropped_invalid_skb() checks if the skb is valid and consistent:

> static inline bool can_dropped_invalid_skb(struct net_device *dev,
> 					  struct sk_buff *skb)
> {
> 	const struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
>=20
> 	if (skb->protocol =3D=3D htons(ETH_P_CAN)) {
> 		if (unlikely(skb->len !=3D CAN_MTU ||
> 			     cfd->len > CAN_MAX_DLEN))
                             ^^^^^^^^^^^^^^^^^^^^^^^
=2E..here we check for cfd->len...

> 			goto inval_skb;
> 	} else if (skb->protocol =3D=3D htons(ETH_P_CANFD)) {
> 		if (unlikely(skb->len !=3D CANFD_MTU ||
> 			     cfd->len > CANFD_MAX_DLEN))
                             ^^^^^^^^^^^^^^^^^^^^^^^^^
=2E..here we check for cfd->len...

> 			goto inval_skb;
> 	} else
> 		goto inval_skb;
>=20
> 	if (!can_skb_headroom_valid(dev, skb))
> 		goto inval_skb;
>=20
> 	return false;
>=20
> inval_skb:
> 	kfree_skb(skb);
> 	dev->stats.tx_dropped++;
> 	return true;
> }

=2E..and the limits are defined as:

> #define CAN_MAX_DLEN 8
> #define CANFD_MAX_DLEN 64

>   2215          struct mcp25xxfd_hw_tx_obj_raw *hw_tx_obj;
>   2216          union mcp25xxfd_tx_obj_load_buf *load_buf;
>   2217          u8 dlc;
>   2218          u32 id, flags;
>   2219          int offset, len;
>   2220 =20
>   2221          if (cfd->can_id & CAN_EFF_FLAG) {
>   2222                  u32 sid, eid;
>   2223 =20
>   2224                  sid =3D FIELD_GET(MCP25XXFD_REG_FRAME_EFF_SID_M=
ASK, cfd->can_id);
>   2225                  eid =3D FIELD_GET(MCP25XXFD_REG_FRAME_EFF_EID_M=
ASK, cfd->can_id);
>   2226 =20
>   2227                  id =3D FIELD_PREP(MCP25XXFD_OBJ_ID_EID_MASK, ei=
d) |
>   2228                          FIELD_PREP(MCP25XXFD_OBJ_ID_SID_MASK, s=
id);
>   2229 =20
>   2230                  flags =3D MCP25XXFD_OBJ_FLAGS_IDE;
>   2231          } else {
>   2232                  id =3D FIELD_PREP(MCP25XXFD_OBJ_ID_SID_MASK, cf=
d->can_id);
>   2233                  flags =3D 0;
>   2234          }
>   2235 =20
>   2236          /* Use the MCP2518FD mask even on the MCP2517FD. It doe=
sn't
>   2237           * harm, only the lower 7 bits will be transferred into=
 the
>   2238           * TEF object.
>   2239           */
>   2240          dlc =3D can_len2dlc(cfd->len);
>   2241          flags |=3D FIELD_PREP(MCP25XXFD_OBJ_FLAGS_SEQ_MCP2518FD=
_MASK, seq) |
>   2242                  FIELD_PREP(MCP25XXFD_OBJ_FLAGS_DLC, dlc);
>   2243 =20
>   2244          if (cfd->can_id & CAN_RTR_FLAG)
>   2245                  flags |=3D MCP25XXFD_OBJ_FLAGS_RTR;
>   2246 =20
>   2247          /* CANFD */
>   2248          if (can_is_canfd_skb(skb)) {
>   2249                  if (cfd->flags & CANFD_ESI)
>   2250                          flags |=3D MCP25XXFD_OBJ_FLAGS_ESI;
>   2251 =20
>   2252                  flags |=3D MCP25XXFD_OBJ_FLAGS_FDF;
>   2253 =20
>   2254                  if (cfd->flags & CANFD_BRS)
>   2255                          flags |=3D MCP25XXFD_OBJ_FLAGS_BRS;
>   2256          }
>   2257 =20
>   2258          load_buf =3D &tx_obj->buf;
>   2259          if (priv->devtype_data.quirks & MCP25XXFD_QUIRK_CRC_TX)=

>   2260                  hw_tx_obj =3D &load_buf->crc.hw_tx_obj;
>   2261          else
>   2262                  hw_tx_obj =3D &load_buf->nocrc.hw_tx_obj;
>   2263 =20
>   2264          put_unaligned_le32(id, &hw_tx_obj->id);
>   2265          put_unaligned_le32(flags, &hw_tx_obj->flags);
>   2266 =20
>   2267          /* Clear data at end of CAN frame */
>   2268          offset =3D round_down(cfd->len, sizeof(u32));
>   2269          len =3D round_up(can_dlc2len(dlc), sizeof(u32)) - offse=
t;
>=20
> Smatch thinks that "cfd->len" can be more than 64 which leads to settin=
g
> "len" negative.
>=20
>   2270          if (MCP25XXFD_SANITIZE_CAN && len)
>   2271                  memset(hw_tx_obj->data + offset, 0x0, len);
>                                                               ^^^
> Which would corrupt memory.
>=20
>   2272          memcpy(hw_tx_obj->data, cfd->data, cfd->len);
>                                                    ^^^^^^^^
> Smatch thinks this can be more than 64.
>=20
>   2273 =20
>   2274          /* Number of bytes to be written into the RAM of the co=
ntroller */
>   2275          len =3D sizeof(hw_tx_obj->id) + sizeof(hw_tx_obj->flags=
);
>=20
> regards,
> dan carpenter
>=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--wllwJnWBxFjJYjnFMDUdeZCs7MwjJacGK--

--NbkifFIjf0GNYRln5hWmxoMvqqoIPpcFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl9rIuIACgkQqclaivrt
76n1Ngf/cPYtfNWDHUaDr/DIG4TfgVEzQ0v/ahggGkc7UkZ/ENh8EUEaRK7EL1dh
mrZvTFXXlPn+vInfMSupz6OrHGE3l8kLv3xPQlD6xaOHZEIfZht04Sc7mvpU1Dm/
CGfD7E1SDrvX+mAS7GlC73n35qhI0tDGlGFkDvZwVO53LtQkuIZBuZvTVZHbHXRS
eoxWlASsjISCLiV1IZzpnPyfujbm0wclAC2cQ/4hFzUVYeRnCycP4whC23fykheN
3IbEM71pTuM9dns0N39D3yrVR8JEU6HO7upDXww4pa1H0WMbsvCaakWGF5OLhStg
cX36fMqaaAORZf/hgRR6RDKq/1Fx6A==
=Hz6f
-----END PGP SIGNATURE-----

--NbkifFIjf0GNYRln5hWmxoMvqqoIPpcFA--
