Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1585BF827
	for <lists+linux-can@lfdr.de>; Wed, 21 Sep 2022 09:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiIUHrs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Sep 2022 03:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIUHrq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Sep 2022 03:47:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930B87C194
        for <linux-can@vger.kernel.org>; Wed, 21 Sep 2022 00:47:45 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oauSM-0000Wp-Jc; Wed, 21 Sep 2022 09:47:42 +0200
Received: from pengutronix.de (hardanger-2.fritz.box [IPv6:2a03:f580:87bc:d400:f566:9915:77e6:ceb3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D5188E84D1;
        Wed, 21 Sep 2022 07:47:41 +0000 (UTC)
Date:   Wed, 21 Sep 2022 09:47:41 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     dariobin@libero.it
Cc:     Jacob Kroon <jacob.kroon@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Message-ID: <20220921074741.admuodnlv4yexfwr@pengutronix.de>
References: <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
 <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
 <02aeeca7-5958-60f1-3011-fa3aae4ef6b5@gmail.com>
 <541998938.482927.1663745141832@mail1.libero.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z7fiufyloqlggitu"
Content-Disposition: inline
In-Reply-To: <541998938.482927.1663745141832@mail1.libero.it>
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


--z7fiufyloqlggitu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.09.2022 09:25:41, dariobin@libero.it wrote:
> > On 9/16/22 06:14, Jacob Kroon wrote:
> > ...> What I do know is that if I revert commit:
> > >=20
> > > "can: c_can: cache frames to operate as a true FIFO"
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D387da6bc7a826cc6d532b1c0002b7c7513238d5f
> > >=20
> > > then everything looks good. I don't get any BUG messages, and the hos=
t=20
> > > has been running overnight without problems, so it seems to have fixe=
d=20
> > > the network interface lockup as well.
>=20
> Here's what I think:
> If one or more messages are cached, the controller has to transmit more f=
rames=20
> in the unit of time when they can be transmitted (IF_COMM_TXRQST), differ=
ent from
> when the transmission occurs directly on request from the user space. In =
the case=20
> of cached data transmission I therefore think that the controller is more=
 heavily
> loaded. Can this shift the balance ?
>=20
> >=20
> > I ran the kernel *with* the commit above, and also with the following p=
atch:
> >=20
> > > diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_c=
an/c_can_main.c
> > > index 52671d1ea17d..4375dc70e21f 100644
> > > --- a/drivers/net/can/c_can/c_can_main.c
> > > +++ b/drivers/net/can/c_can/c_can_main.c
> > > @@ -1,3 +1,4 @@
> > > +#define DEBUG
> > >  /*
> > >   * CAN bus driver for Bosch C_CAN controller
> > >   *
> > > @@ -469,8 +470,15 @@ static netdev_tx_t c_can_start_xmit(struct sk_bu=
ff *skb,
> > >  	if (c_can_get_tx_free(tx_ring) =3D=3D 0)
> > >  		netif_stop_queue(dev);
> > > =20
> > > -	if (idx < c_can_get_tx_tail(tx_ring))
> > > +	netdev_dbg(dev, "JAKR:%d:%d:%d:%d\n", idx,
> > > +	                                      c_can_get_tx_head(tx_ring),
> > > +	                                      c_can_get_tx_tail(tx_ring),
> > > +	                                      c_can_get_tx_free(tx_ring));
> > > +
> > > +	if (idx < c_can_get_tx_tail(tx_ring)) {
> > >  		cmd &=3D ~IF_COMM_TXRQST; /* Cache the message */
> > > +		netdev_dbg(dev, "JAKR:Caching messages\n");
> > > +	}
> > > =20
> > >  	/* Store the message in the interface so we can call
> > >  	 * can_put_echo_skb(). We must do this before we enable
> >=20
> > and I've uploaded the entire log I could capture from /dev/kmsg, right=
=20
> > up to the hang, here:
> >=20
> > https://pastebin.com/6hvAcPc9
> >=20
> > What looks odd to me right from the start is that sometimes when idx=20
> > rolls over to 0, and *only* when it rolls over to 0, the CAN frame gets=
=20
> > cached because "idx < c_can_get_tx_tail(tx_ring)".
>=20
> If the message were not stored but transmitted, the order of transmission=
=20
> would not be respected.
>=20
> >=20
> > Is it possible there is some difference between c_can and d_can in how=
=20
> > the HW buffers are working, which breaks the driver on my particular HW=
=20
> > setup ?
> >=20
>=20
> I tested the patch on a beaglebone board without encountering any problem=
s.
> There is also a version of the driver I submitted to Xenomai running on a=
 custom
> board without problems. But surely the setup and context is different fro=
m yours.
>=20
> What compatible are you using in your device tree?
> I used "ti,am3352-d_can".

I think Jacob's board has a c_can core, while the beagle bone uses a
d_can. Maybe there's a subtle difference between these cores?

Dario, do you have access to a real c_can core to test?

As reverting 387da6bc7a82 ("can: c_can: cache frames to operate as a
true FIFO") helps to fix Jacob's problem, a temporary solution might be
to only cache frames on d_can cores.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--z7fiufyloqlggitu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMqwZoACgkQrX5LkNig
011UyAf/SHChldw/3w9f8Mq5PyD1xD4aiVszvaO//0CIC6ZmXxHIA8gM6pvGUGKZ
xdVw8xY+Om2cak1p2/F5VrHUf18BEI3MLTdWKcBsGmDm/XUAM+CLniit+SRmKuEf
KVhEeznEGdQEyG5CW50qfpYymY6Ho0gnrsPq3SejC9buUgl5usjjd//cYMEqDBj0
bJdmIdQqzVTT+LzBoiAivSdpHdI540H9yA2HL3juEnMRgvftquT4EjCre095X8e3
W0veXkYDmIwpGN7TJRaSaKspa6An5O4YCC40N+xv6hpGmhCMPyLhg3zsdE5M0u/V
YGMN+Qjl6binNCiNaLrcru5mpkvazg==
=6xZq
-----END PGP SIGNATURE-----

--z7fiufyloqlggitu--
