Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAE45BC012
	for <lists+linux-can@lfdr.de>; Sun, 18 Sep 2022 23:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIRVbp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 18 Sep 2022 17:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRVbo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 18 Sep 2022 17:31:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D742D13E2E
        for <linux-can@vger.kernel.org>; Sun, 18 Sep 2022 14:31:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oa1t4-0003aH-Br; Sun, 18 Sep 2022 23:31:38 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:9e88:da4f:2587:9741])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5F947E572D;
        Sun, 18 Sep 2022 21:31:34 +0000 (UTC)
Date:   Sun, 18 Sep 2022 23:31:26 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Rhett Aultman <rhett.aultman@samsara.com>
Cc:     linux-can@vger.kernel.org,
        Vasanth Sadhasivan <vasanth.sadhasivan@samsara.com>
Subject: Re: [PATCH 1/1] can: gs_usb: remove dma allocations
Message-ID: <20220918213126.jl3vqvn6yjwrltj7@pengutronix.de>
References: <20220913204110.89730-1-rhett.aultman@samsara.com>
 <20220913204110.89730-2-rhett.aultman@samsara.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h7ikseqjnxdguhub"
Content-Disposition: inline
In-Reply-To: <20220913204110.89730-2-rhett.aultman@samsara.com>
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


--h7ikseqjnxdguhub
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.09.2022 16:41:10, Rhett Aultman wrote:
> From: Vasanth Sadhasivan <vasanth.sadhasivan@samsara.com>
>=20
> DMA allocated buffers are a precious resource. If there is no need for DMA
> allocations, then it might be worth to use non-dma allocated buffers.
> After testing the gs_usb driver with and without DMA allocation, there
> does not seem to be a significant change in latency or cpu utilization
> either way. Therefore, DMA allocation is not necessary and removed.
>=20
> Co-developed-by: Rhett Aultman <rhett.aultman@samsara.com>
> Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
> Signed-off-by: Vasanth Sadhasivan <vasanth.sadhasivan@samsara.com>
> ---
>  drivers/net/can/usb/gs_usb.c | 38 ++++++++++--------------------------
>  1 file changed, 10 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index baf749c8cda3..1bfc775c62c5 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -269,7 +269,6 @@ struct gs_can {
>  	struct usb_anchor tx_submitted;
>  	atomic_t active_tx_urbs;
>  	void *rxbuf[GS_MAX_RX_URBS];
> -	dma_addr_t rxbuf_dma[GS_MAX_RX_URBS];
>  };
> =20
>  /* usb interface struct */
> @@ -587,9 +586,7 @@ static void gs_usb_xmit_callback(struct urb *urb)
> =20
>  	if (urb->status)
>  		netdev_info(netdev, "usb xmit fail %u\n", txc->echo_id);
> -
> -	usb_free_coherent(urb->dev, urb->transfer_buffer_length,
> -			  urb->transfer_buffer, urb->transfer_dma);
> +	devm_kfree(&urb->dev->dev, urb->transfer_buffer);

Consider using the URB_FREE_BUFFER flag:

| https://elixir.bootlin.com/linux/v5.19/source/include/linux/usb.h#L1330

and standard kmalloc() (i.e. not devm_kmalloc()). The USB stack will
take care of kfree()ing the buffer associated with each URB.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--h7ikseqjnxdguhub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMnjisACgkQrX5LkNig
012o2Af7BV8xNLmDJszUyclJ8V3EraunjPIzKUqxyD8c9BRe/gswq+/vGb0Wj1K5
8WudGhXuEwbW3UMudigKIKTPlBc4YXpItGch0ZKv6K2MncWOsmSGQIWAlMx97bmk
DPvzHV8txDEZcKk6LAjW5QP5/yTbxT2qe4842uooAznvHovamsa/1s9+k3j8jd4F
Ruib6mpR2/mehkXc9ET2Y1nBV0LGNWzJsAhrcf/dIOm5LXG4sFsOfX6spL2suq1y
7iYnsve4EcuiUCMn1t3ZQ5cp934HbfYYzR64cyiGsJyv22KNvwAalm+qDyYeMKu5
BnOvfR0OhICc3EVk8Kih8ElW9IPu7g==
=eu0n
-----END PGP SIGNATURE-----

--h7ikseqjnxdguhub--
