Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAAA570AC8
	for <lists+linux-can@lfdr.de>; Mon, 11 Jul 2022 21:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiGKTec (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jul 2022 15:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGKTeb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jul 2022 15:34:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037F5101E2
        for <linux-can@vger.kernel.org>; Mon, 11 Jul 2022 12:34:29 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oAzAp-00039G-IR; Mon, 11 Jul 2022 21:34:27 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-959c-1f3c-38b0-6980.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:959c:1f3c:38b0:6980])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 92F97AE0A8;
        Mon, 11 Jul 2022 19:34:26 +0000 (UTC)
Date:   Mon, 11 Jul 2022 21:34:26 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] can: canxl: introduce ETH_P_CANXL ethernet
 protocol handling
Message-ID: <20220711193426.p5eh26efho2pim4o@pengutronix.de>
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-3-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="waogqdo6yeb5ujfz"
Content-Disposition: inline
In-Reply-To: <20220711183426.96446-3-socketcan@hartkopp.net>
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


--waogqdo6yeb5ujfz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.07.2022 20:34:23, Oliver Hartkopp wrote:
> Enable the PF_CAN infrastructure to handle CAN XL frames. A new ethernet
> protocol type ETH_P_CANXL is defined to tag skbuffs containing the CAN XL
> frame data structure.
>=20
> As the length information is now a uint16 value for CAN XL a new helper
> function can_get_data_len() is introduced to retrieve the data length
> from all types of CAN frames.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/linux/can/skb.h       | 14 ++++++++++
>  include/uapi/linux/if_ether.h |  1 +
>  net/can/af_can.c              | 49 +++++++++++++++++++++++++++++------
>  3 files changed, 56 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index 182749e858b3..d043bc4afd6d 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -101,6 +101,20 @@ static inline bool can_is_canfd_skb(const struct sk_=
buff *skb)
>  {
>  	/* the CAN specific type of skb is identified by its data length */
>  	return skb->len =3D=3D CANFD_MTU;
>  }
> =20
> +/* get data length inside of CAN frame for all frame types */
> +static inline unsigned int can_get_data_len(struct sk_buff *skb)
> +{
> +	if(skb->len =3D=3D CANXL_MTU) {
         ^^^ add space

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--waogqdo6yeb5ujfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLMez8ACgkQrX5LkNig
012bIAf/Yli3VhhKADRGu8M9UtSpPQ5X1qkj7Kqs05UUvXO9tgCEGv2zUB3VdIoU
Q71pivjRZ8/z6V4jWqg1hi/XkKk5LTHu3AUfRtcKX8qEXPmwjXEPvO3Kz199w2jJ
jhaVmot2IOWUATzusPxL9ijYr7xrFbASo9WQohZQ6vSptG2PoSJgz6naq/m1GPAk
BfzssMazQnDC0WSZLNxECE/p6RMqbS7RbaUvAgcNlQBbsyjJkGEbFrq26X/7HDnK
OppgFcvEs6ThGyrHJqv1J8M5ojIVrgbpCCUunkmwzF5uvq+tAA02xkMdalqD8kDO
XCfDERPqHGC3ruTtMrzcAI4FZInrpA==
=aznY
-----END PGP SIGNATURE-----

--waogqdo6yeb5ujfz--
