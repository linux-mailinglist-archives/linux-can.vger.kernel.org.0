Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855783AC733
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 11:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFRJS1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Jun 2021 05:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhFRJS1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 05:18:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48136C061574
        for <linux-can@vger.kernel.org>; Fri, 18 Jun 2021 02:16:18 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1luAbo-0000kh-LE; Fri, 18 Jun 2021 11:16:16 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:e7d0:b47e:7728:2b24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CC51B63EBA7;
        Fri, 18 Jun 2021 09:16:15 +0000 (UTC)
Date:   Fri, 18 Jun 2021 11:16:14 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Harald Mommer <hmo@opensynergy.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: MSG_CONFIRM RX messages with SocketCAN known as unreliable under
 heavy load?
Message-ID: <20210618091614.nqcvvmtf4wo4aejm@pengutronix.de>
References: <c3fc258b-2f62-74ba-ca41-e6f839930020@opensynergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="edj7l6pp5fcku3ti"
Content-Disposition: inline
In-Reply-To: <c3fc258b-2f62-74ba-ca41-e6f839930020@opensynergy.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--edj7l6pp5fcku3ti
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.06.2021 14:22:03, Harald Mommer wrote:
> we are currently in the process of developing a draft specification for
> Virtio CAN. In the scope of this work I am developing a Virtio CAN Linux
> driver and a Virtio CAN Linux device

Oh that sounds interesting. Please keep the linux-can mailing list in
the loop. Do you have a first draft version for review, yet?

> running on top of our hypervisor solution.
>=20
> The Virtio CAN Linux device forwards an existing SocketCAN CAN device
> (currently vcan) via Virtio to the Virtio driver guest so that the virtual
> driver guest can send and receive CAN frames via SocketCAN.
>=20
> What was originally planned (probably with too much AUTOSAR CAN driver
> semantics in my head and too few SocketCAN knowledge) is to mark a
> transmission request as used (done) when it's sent finally on the CAN bus
> (vs. when it's given to SocketCAN not really done but still pending
> somewhere in the protocol stack).

Makes sense.

> Thought this was doable with some implementation effort using
>=20
> setsockopt(..., SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS, ...) and evaluatiing =
the
> MSG_CONFIRM bit on received messages.

Where does that code run? Would that be part of qemu running on the host
of an open source solution?

Can you sketch a quick block diagram showing guest, host, Virtio device,
Virtio driver, etc...

> This works fine with
>=20
> cangen -g 0 -i can0
>=20
> on the driver side sending CAN messages to the device guest. No confirmat=
ion
> is lost testing for several minutes.

Where's the driver side? On the host or the guest?

> Adding now on the device side a
>=20
> cangen -g 0 -i vcan0
>=20
> sending messages like crazy from the device side guest to the driver side
> guest in parallel I'm loosing TX confirmations in the Linux CAN stack. Se=
ems
> also there is no other error indication (CAN_ERR_FLAG) that something like

CAN_ERR_FLAG are only for real CAN errors on the bus or controller
problems. The vcan interface doesn't generate any.

> this happened. The virtio CAN device gets out of resources and TX will
> become stuck. Which is not really acceptable even for such a heavy load
> situation (-g0 on both sides).
>=20
> Is CAN_RAW_RECV_OWN_MSGS / MSG_CONFIRM known as being unreliable (means
> MSG_CONFIRM messages are dropped) under extreme load situations? If so, is
> there a way to detect reliably that this happened so that somehow a recov=
ery
> mechanism for the pending TX acknowledgements could be implemented?

Have you activated SO_RXQ_OVFL?
With recvmsg() you get the number of dropped messages in the socket.
Have a look at:
https://github.com/linux-can/can-utils/blob/master/cansequence.c

> I'm aware that "normal" RX messages from other nodes may be dropped due to
> overload. No problem with this.
>=20
> The timing requirement originally set (done when sent on CAN bus) has to =
be
> weakened or put under a feature flag when it's not reliably implementable=
 in
> all environments.

Even if the Linux Kernel doesn't drop any messages, not all CAN
controllers support that feature. On the Linux side we try our best, but
some USB attached devices don't report a TX complete event back, so the
driver triggers the CAN echo skb after the USB transfer has been
completed.

We don't have a feature flag to query if the Linux driver support proper
CAN echo on TX complete notification.

> But before declaring as "not reliably implementable with
> Linux SocketCAN" I would like to be sure that it's really that way and
> absolutely nothing can be done about it. Could even be that I missed an
> additional setting I'm not aware of. But the observed behavior may as well
> be something which is known to everyone except me.
>=20
> Of course it can be that there is still a bug in my software but checked
> this carefully and I'm now convinced that under heavy load situations
> MSG_CONFIRM messages are lost somewhere in the Linux SocketCAN protocol
> stack. If there's no way to recover from this situaton I've to weaken the
> next draft Virtio CAN draft specification regarding the TX ACK timing. As
> this has some additional impact on the specification before doing so I wo=
uld
> like to be really sure that the TX ACK timing cannot be done reliably the
> way it was originally planned.

Do you have some code available yet?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--edj7l6pp5fcku3ti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDMZFwACgkQqclaivrt
76mqOAf9ECq/Xm2hH05vTwX0QwAXmaGyDNffaoc5Ty3cSlTx6skMeh2kTOg1WBNh
bAro9cOkeuXNUyHPar4huluLLIHXYfCW0bRTIm1T8wlDvLYG+JqwKY2F2ua+95Wk
O2Lp9SzxX9OT2IWj7LJNqe//pKl5sasqiO2orPiAvXE3GvwnkM7hoXzoraqqOJz7
fN9a5x5SUq30lAwvwbF1KQmvfkt2pRXjNuSFfsYOdPMT3juD0voxvHHx2XYZOCOo
Jhot2g5Y1zfTmcVU1OATScwAyMl2txrHhX/zShJgzc0lbfOCWEsroPChAiQd83l3
baW3C1JFd8VmV3hyxdLxDaT8NGZBsA==
=zLHV
-----END PGP SIGNATURE-----

--edj7l6pp5fcku3ti--
