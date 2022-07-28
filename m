Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9377583C0E
	for <lists+linux-can@lfdr.de>; Thu, 28 Jul 2022 12:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiG1KbD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 28 Jul 2022 06:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbiG1KbA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Jul 2022 06:31:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BEE65D8
        for <linux-can@vger.kernel.org>; Thu, 28 Jul 2022 03:30:40 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oH0mt-0007nY-9l; Thu, 28 Jul 2022 12:30:39 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8FABBBCC33;
        Thu, 28 Jul 2022 10:30:38 +0000 (UTC)
Date:   Thu, 28 Jul 2022 12:30:37 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC PATCH v6 3/7] can: set CANFD_FDF flag in all CAN FD frame
 structures
Message-ID: <20220728103037.iax4rqw4pip6fbr6@pengutronix.de>
References: <20220724074402.117394-1-socketcan@hartkopp.net>
 <20220724074402.117394-4-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bzuoopjwnpzgjkqd"
Content-Disposition: inline
In-Reply-To: <20220724074402.117394-4-socketcan@hartkopp.net>
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


--bzuoopjwnpzgjkqd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.07.2022 09:43:58, Oliver Hartkopp wrote:
> To simplify the testing in user space all struct canfd_frame's provided by
> the CAN subsystem of the Linux kernel now have the CANFD_FDF flag set in
> canfd_frame::flags.
>=20
> NB: Handcrafted ETH_P_CANFD frames introduced via PF_PACKET socket might
> not set this bit correctly.

Can you add a fixup for PF_PACKET to can_skb_headroom_valid()?

Or better move the "if (skb->ip_summed =3D=3D CHECKSUM_NONE)" into a
separate function first e.g. can_skb_fixup_pf_packet() first.

| static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff=
 *skb)
| {
| 	/* af_packet creates a headroom of HH_DATA_MOD bytes which is fine */
| 	if (WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct can_skb_priv)))
| 		return false;
|=20
| 	/* af_packet does not apply CAN skb specific settings */
| 	if (skb->ip_summed =3D=3D CHECKSUM_NONE) {
| 		/* init headroom */
| 		can_skb_prv(skb)->ifindex =3D dev->ifindex;
| 		can_skb_prv(skb)->skbcnt =3D 0;
|=20
| 		skb->ip_summed =3D CHECKSUM_UNNECESSARY;
|=20
| 		/* perform proper loopback on capable devices */
| 		if (dev->flags & IFF_ECHO)
| 			skb->pkt_type =3D PACKET_LOOPBACK;
| 		else
| 			skb->pkt_type =3D PACKET_HOST;
|=20
| 		skb_reset_mac_header(skb);
| 		skb_reset_network_header(skb);
| 		skb_reset_transport_header(skb);
| 	}
|=20
| 	return true;
| }

And call can_skb_fixup_pf_packet() from can_dropped_invalid_skb().

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--bzuoopjwnpzgjkqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLiZUoACgkQrX5LkNig
012InQf/bRdAdiZmcidlK/O645jRKLOq4TSNzmNnkrEjsgO8ANMehScaLTDHlWoN
7H7PUAazbyALof/rOgemu3btda1sqshmie9tQ+KHP25+GZJ/R0/wpXe+JXluWZvU
Q5MWDtJVA5go1ASiygxT0xNFAt0A7gsUJZKZ7UWvaCS+esOYQlN3F5DD8xKvd7bn
qLnOOURFQWgz2+30vIU4/nSaU6bJ0MIQhYyQ3ta0rMyueDWNAVK7CpNg4XPoD/0u
W8C5B/1eWKqcOhBW1EgK/sdy1Hc/5QGCUPUhdL8nxsH2BOs2Lfhhsjb+l0Ej0GAL
lS6d2BjxPcXm7lxkcYykk/yP9vO13A==
=ERoe
-----END PGP SIGNATURE-----

--bzuoopjwnpzgjkqd--
