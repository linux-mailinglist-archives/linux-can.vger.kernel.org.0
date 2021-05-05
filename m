Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2173739BB
	for <lists+linux-can@lfdr.de>; Wed,  5 May 2021 13:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhEEL5Y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 May 2021 07:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhEEL5Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 May 2021 07:57:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0604CC061574
        for <linux-can@vger.kernel.org>; Wed,  5 May 2021 04:56:28 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1leG8g-0001nL-K0; Wed, 05 May 2021 13:56:26 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:96db:da04:b018:e517])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8656361D1FF;
        Wed,  5 May 2021 11:56:25 +0000 (UTC)
Date:   Wed, 5 May 2021 13:56:24 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: Improving TX for m_can peripherals
Message-ID: <20210505115624.7qhbit4olyvpfkf4@pengutronix.de>
References: <20210505103049.gboat4dr3zvdm4s6@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="juwt55rgvk4vt7r3"
Content-Disposition: inline
In-Reply-To: <20210505103049.gboat4dr3zvdm4s6@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--juwt55rgvk4vt7r3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.05.2021 11:30:49, Torin Cooper-Bennun wrote:
> I've been testing the TCAN4550 recently with proper kit (no more jumper
> wires, hooray!) and I'm happy to say the RX path is fixed in v5.12 with
> the latest patches, and even with heavy load I see no missed frames or
> errors.

\o/

> However, TX still needs work. It's easy to break the driver due to the
> following logic in m_can_start_xmit():
>=20
> | 	if (cdev->tx_skb) {
> | 		netdev_err(dev, "hard_xmit called while tx busy\n");
> | 		return NETDEV_TX_BUSY;
> | 	}
>=20
> Regardless of your netif TX queue length or the number of TX buffers
> allocated in the M_CAN core, if you try to transmit too quickly, you
> will hit this. For the application I'm working on, I run into this very
> quickly with real-world scenarios.
>=20
> Also, the queue is always stopped before the tx work is queued in
> m_can_start_xmit(), which seems wrong and clearly doesn't solve the
> problem:

The simple approach is to stop the tx queue in ndo_start_xmit() and to
restart it if the skb has been send. If the above error message is
triggered I suppose there's a race condition in the driver, cdev->tx_skb
is cleared _after_ the queue has been restarted.

I think it's somewhere here:

| static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
| {
[...]
| 		/* Enable TX FIFO element to start transfer  */
| 		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));

TX complete IRQ can come after this...

| 		/* stop network queue if fifo full */
| 		if (m_can_tx_fifo_full(cdev) ||

This is a SPI transfer and may take a lot of time....

| 		    m_can_next_echo_skb_occupied(dev, putidx))
| 			netif_stop_queue(dev);
[...]
| }

| static void m_can_tx_work_queue(struct work_struct *ws)
| {
| 	struct m_can_classdev *cdev =3D container_of(ws, struct m_can_classdev,
| 						   tx_work);
|=20
| 	m_can_tx_handler(cdev);

=2E.. here the tx_skb is set to NULL

| 	cdev->tx_skb =3D NULL;
| }

I've send a patch (compile time tested, only!) to fix the probem.

> | 	/* Need to stop the queue to avoid numerous requests
> | 	 * from being sent.  Suggested improvement is to create
> | 	 * a queueing mechanism that will queue the skbs and
> | 	 * process them in order.
> | 	 */
> | 	cdev->tx_skb =3D skb;
> | 	netif_stop_queue(cdev->net);
> | 	queue_work(cdev->tx_wq, &cdev->tx_work);
>=20
>=20
> So - I'd like to fix this. The comment in the snippet above suggests a
> queueing mechanism. It would be good to hear your take on this, Marc -
> AFAIU you have written a similar mechanism for mcp251xfd. :)

For easier queuing, get rid of the worker. Directly send the can_frame
=66rom the xmit handler. The problem is, you cannot sleep inside it. This
means, you cannot use regmap(), the only thing that works is
spi_async(). And as it's async, you can only write data via SPI, reading
doesn't make sense.

Have a look at the mcp251xfd_start_xmit() function. All data structures
for the SPI messages are prepared in beforehand in
mcp251xfd_tx_ring_init_tx_obj(). The xmit function looks up the correct
data structure, converts the skb to the chip's format
mcp251xfd_tx_obj_from_skb() and then sends the data over spi. Special
care is taken of the handling of the head and tail pointers and the
stopping of the queue to avoid race conditions - see
mcp251xfd_get_tx_free(), mcp251xfd_tx_busy(), netif_stop_queue(),
netif_wake_queue().

Hope that helps,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--juwt55rgvk4vt7r3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCSh+YACgkQqclaivrt
76lwOgf+O28I2pWgb9O00K/LkQzeV99Rhjk8azOZ4Jrg5zspxjfXkOYdObAzUFYQ
2slkncbegNluw86Is8WHlFJ8erqvjOpEjg4TMEC/nNR+i4g7f7VNl9AWTOzeqPRH
4coj/mDkgmK6/Uwmtos6l3K6/c0dn9tS+KEzh3gENwyMa1rpi+ucjjCf2KOBwj3v
MDZAeGKy7eCJ2T5U+FgFBkcRmPSD+s1KGKtmp4IejcYKbC3xXbYROfdjdzK5WOJL
wPz9vlwPNUwRX7fwKyhnIBlaUohde/z9bVSzZ6Hsvyofxbm446BrH0u5I2NFjOvQ
JVnqrRowIMwQ6FB4eIOUz0dyzbU4YQ==
=c2uk
-----END PGP SIGNATURE-----

--juwt55rgvk4vt7r3--
