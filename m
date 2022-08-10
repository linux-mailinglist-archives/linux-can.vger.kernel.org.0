Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C4F58F362
	for <lists+linux-can@lfdr.de>; Wed, 10 Aug 2022 22:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiHJUBA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 Aug 2022 16:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiHJUA7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 Aug 2022 16:00:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB72A7C19F
        for <linux-can@vger.kernel.org>; Wed, 10 Aug 2022 13:00:57 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oLrsl-0003ge-AB; Wed, 10 Aug 2022 22:00:47 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 532F4C6D1A;
        Wed, 10 Aug 2022 20:00:45 +0000 (UTC)
Date:   Wed, 10 Aug 2022 22:00:43 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     linux-can@vger.kernel.org,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>,
        Jaroslav Beran <jara.beran@gmail.com>,
        Petr Porazil <porazil@pikron.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v8 3/7] can: ctucanfd: add support for CTU CAN FD
 open-source IP core - bus independent part.
Message-ID: <20220810200043.pcpkbiq7f47cmi6t@pengutronix.de>
References: <cover.1647904780.git.pisa@cmp.felk.cvut.cz>
 <1906e4941560ae2ce4b8d181131fd4963aa31611.1647904780.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bnldsk37nxlo64jj"
Content-Disposition: inline
In-Reply-To: <1906e4941560ae2ce4b8d181131fd4963aa31611.1647904780.git.pisa@cmp.felk.cvut.cz>
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


--bnldsk37nxlo64jj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was about to convert these macros into static inline bool functions
and thinking the naming can be improved a bit:

On 22.03.2022 00:32:30, Pavel Pisa wrote:
> +#define CTU_CAN_FD_TXTNF(priv) (!!FIELD_GET(REG_STATUS_TXNF, ctucan_read=
32(priv, CTUCANFD_STATUS)))
> +#define CTU_CAN_FD_ENABLED(priv) (!!FIELD_GET(REG_MODE_ENA, ctucan_read3=
2(priv, CTUCANFD_MODE)))

[...]

The common prefix for functions seems to be "ctucan_", so if I convert
CTU_CAN_FD_ENABLED -> ctucan_fd_enabled() the unfamiliar reader might
think this functions tests if the controller is in FD mode.

As far as I understand the code, the test is if the controller is
enabled at all. This is done via the ctucan_chip_start() function and
undone via ctucan_chip_stop(). So a better function names might be:
- ctucan_chip_started()
- ctucan_chip_is_started()
- ctucan_chip_enabled()
- ctucan_chip_is_enabled()

> +/**
> + * ctucan_set_btr() - Sets CAN bus bit timing in CTU CAN FD
> + * @ndev:	Pointer to net_device structure
> + * @bt:		Pointer to Bit timing structure
> + * @nominal:	True - Nominal bit timing, False - Data bit timing
> + *
> + * Return: 0 - OK, -%EPERM if controller is enabled
> + */
> +static int ctucan_set_btr(struct net_device *ndev, struct can_bittiming =
*bt, bool nominal)
> +{
> +	struct ctucan_priv *priv =3D netdev_priv(ndev);
> +	int max_ph1_len =3D 31;
> +	u32 btr =3D 0;
> +	u32 prop_seg =3D bt->prop_seg;
> +	u32 phase_seg1 =3D bt->phase_seg1;
> +
> +	if (CTU_CAN_FD_ENABLED(priv)) {
> +		netdev_err(ndev, "BUG! Cannot set bittiming - CAN is enabled\n");

I would want to replace "CAN" with "Chip" or "Controller".

> +		return -EPERM;
> +	}
> +
> +	if (nominal)
> +		max_ph1_len =3D 63;
> +
> +	/* The timing calculation functions have only constraints on tseg1, whi=
ch is prop_seg +
> +	 * phase1_seg combined. tseg1 is then split in half and stored into pro=
g_seg and phase_seg1.
> +	 * In CTU CAN FD, PROP is 6/7 bits wide but PH1 only 6/5, so we must re=
-distribute the
> +	 * values here.
> +	 */
> +	if (phase_seg1 > max_ph1_len) {
> +		prop_seg +=3D phase_seg1 - max_ph1_len;
> +		phase_seg1 =3D max_ph1_len;
> +		bt->prop_seg =3D prop_seg;
> +		bt->phase_seg1 =3D phase_seg1;
> +	}
> +
> +	if (nominal) {
> +		btr =3D FIELD_PREP(REG_BTR_PROP, prop_seg);
> +		btr |=3D FIELD_PREP(REG_BTR_PH1, phase_seg1);
> +		btr |=3D FIELD_PREP(REG_BTR_PH2, bt->phase_seg2);
> +		btr |=3D FIELD_PREP(REG_BTR_BRP, bt->brp);
> +		btr |=3D FIELD_PREP(REG_BTR_SJW, bt->sjw);
> +
> +		ctucan_write32(priv, CTUCANFD_BTR, btr);
> +	} else {
> +		btr =3D FIELD_PREP(REG_BTR_FD_PROP_FD, prop_seg);
> +		btr |=3D FIELD_PREP(REG_BTR_FD_PH1_FD, phase_seg1);
> +		btr |=3D FIELD_PREP(REG_BTR_FD_PH2_FD, bt->phase_seg2);
> +		btr |=3D FIELD_PREP(REG_BTR_FD_BRP_FD, bt->brp);
> +		btr |=3D FIELD_PREP(REG_BTR_FD_SJW_FD, bt->sjw);
> +
> +		ctucan_write32(priv, CTUCANFD_BTR_FD, btr);
> +	}
> +
> +	return 0;
> +}

[...]

> +/**
> + * ctucan_start_xmit() - Starts the transmission
> + * @skb:	sk_buff pointer that contains data to be Txed
> + * @ndev:	Pointer to net_device structure
> + *
> + * Invoked from upper layers to initiate transmission. Uses the next ava=
ilable free TXT Buffer and
> + * populates its fields to start the transmission.
> + *
> + * Return: %NETDEV_TX_OK on success, %NETDEV_TX_BUSY when no free TXT bu=
ffer is available,
> + *         negative return values reserved for error cases
> + */
> +static netdev_tx_t ctucan_start_xmit(struct sk_buff *skb, struct net_dev=
ice *ndev)
> +{
> +	struct ctucan_priv *priv =3D netdev_priv(ndev);
> +	struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
> +	u32 txtb_id;
> +	bool ok;
> +	unsigned long flags;
> +
> +	if (can_dropped_invalid_skb(ndev, skb))
> +		return NETDEV_TX_OK;
> +
> +	if (unlikely(!CTU_CAN_FD_TXTNF(priv))) {

I'm also looking for nicer names for "CTU_CAN_FD_TXTNF".
What about ctucan_txt_buffer_full() and reverse the logic?

> +		netif_stop_queue(ndev);
> +		netdev_err(ndev, "BUG!, no TXB free when queue awake!\n");
> +		return NETDEV_TX_BUSY;
> +	}

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--bnldsk37nxlo64jj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmL0DmMACgkQrX5LkNig
011v2Qf8DZoxOGUtGkVSBwdNgddqdumdwkr7HfRHyklwaKAkGOHveWxAeDzZNhpt
N+p43FFmpPqbQDVBYoHWEOaQHhSDXSqN3LDYM8IiazmNe0Ns95gYWkf59Emxj9YY
4DagR2vUnuf5ZozmAh6q8dl+6+fT/BEyXPhrOn6pOt5IF8vznBfLhmaOKGQqamzF
fGyb35FAUDnfzt92dzRaAZql4VTkp+Wh+ndv7QgRxHqSsTXmrAeTnAPNv3VowEJf
WEOz+z89fPytIDWbaoQzqPBppRrHR3BKsOpdya9e3phWt6wpwRUKZW063SYRVQGn
tZ63KqrJYcO9aTn+N72fvG4CuJd+wA==
=/0te
-----END PGP SIGNATURE-----

--bnldsk37nxlo64jj--
