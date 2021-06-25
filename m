Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0173B40B1
	for <lists+linux-can@lfdr.de>; Fri, 25 Jun 2021 11:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFYJld (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Jun 2021 05:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFYJlc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Jun 2021 05:41:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E10C061574
        for <linux-can@vger.kernel.org>; Fri, 25 Jun 2021 02:39:11 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lwiIn-00072v-S3; Fri, 25 Jun 2021 11:39:09 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6633:1401:6bbf:57ef])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CECEC6436E1;
        Fri, 25 Jun 2021 09:39:08 +0000 (UTC)
Date:   Fri, 25 Jun 2021 11:39:08 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Harald Mommer <hmo@opensynergy.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: MSG_CONFIRM RX messages with SocketCAN known as unreliable under
 heavy load?
Message-ID: <20210625093908.tqcm6p25kinkarm6@pengutronix.de>
References: <c3fc258b-2f62-74ba-ca41-e6f839930020@opensynergy.com>
 <20210618091614.nqcvvmtf4wo4aejm@pengutronix.de>
 <8c76c15d-6252-8af5-01d1-71752cd0cb7b@opensynergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jawqjv2idcfirhu7"
Content-Disposition: inline
In-Reply-To: <8c76c15d-6252-8af5-01d1-71752cd0cb7b@opensynergy.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--jawqjv2idcfirhu7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.06.2021 17:21:15, Harald Mommer wrote:
> Hello,
>=20
> Am 18.06.21 um 11:16 schrieb Marc Kleine-Budde:
> > On 17.06.2021 14:22:03, Harald Mommer wrote:
> > > we are currently in the process of developing a draft specification f=
or
> > > Virtio CAN. In the scope of this work I am developing a Virtio CAN Li=
nux
> > > driver and a Virtio CAN Linux device
> > Oh that sounds interesting. Please keep the linux-can mailing list in
> > the loop. Do you have a first draft version for review, yet?
>=20
> First draft went to virtio-comment@lists.oasis-open.org and
> virtio-dev@lists.oasis-open.org.
>=20
> https://markmail.org/search/?q=3Dvirtio-can&q=3Dlist%3Aorg.oasis-open.lis=
ts.virtio-comment#query:virtio-can%20list%3Aorg.oasis-open.lists.virtio-com=
ment+page:1+mid:hdxj35fsthypllkt+state:results
>=20
> Link should reveal the short conversation. Currently working on the next
> draft which incorporates the review comments I got so far but the next dr=
aft
> will also address the "TX ACK" problem we are discussing here.
>=20
> In the future I will put the Linux-CAN list in the loop.
>=20
> > > running on top of our hypervisor solution.
> > >=20
> > > The Virtio CAN Linux device forwards an existing SocketCAN CAN device
> > > (currently vcan) via Virtio to the Virtio driver guest so that the vi=
rtual
> > > driver guest can send and receive CAN frames via SocketCAN.
> > >=20
> > > What was originally planned (probably with too much AUTOSAR CAN driver
> > > semantics in my head and too few SocketCAN knowledge) is to mark a
> > > transmission request as used (done) when it's sent finally on the CAN=
 bus
> > > (vs. when it's given to SocketCAN not really done but still pending
> > > somewhere in the protocol stack).
> > Makes sense.
>=20
> Reading the "Makes sense". But reading also the rest of the E-Mail (and t=
he
> thread) it makes the impression that making this timing requirement
> mandatory using SocketCAN is calling for trouble.

It makes sense to have a TX done notification. You probably need this
for proper queue handling and throttling.

> - Could remove the timing requirement. This is the easy solution. But the=
re
> is the "Makes sense".
>=20
> - The original strict timing requirement becomes an option so it's not a
> mandatory requirement.
>=20
> 2nd is my favorite (but I tend to do over engineering in the first shot so
> the option before may be indeed the better one).
>=20
> Not having this timing behavior has the implication that in the next virt=
io
> draft spec some other things have to be changed and this means now
> simplified.
>=20
> > > Thought this was doable with some implementation effort using
> > >=20
> > > setsockopt(..., SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS, ...) and evaluati=
ing the
> > > MSG_CONFIRM bit on received messages.

> > Where does that code run? Would that be part of qemu running on the host
> > of an open source solution?

> The device application is closed source, runs under the COQOS hypervisor
> which is also closed source.

Ok

> A qemu device implementation is not planned as of now. The virtio CAN
> driver is a Linux device driver and will be open sourced at some point
> in time in the hope to get it upstreamed in a more far away future.

I suggest to post the code as early as possible, probably along with the
next round of virio-can spec RFC.

> Currently the driver is on an internal development branch, outsiders
> cannot see it (still better for everyone)

I doubt that :) I think the Linux community has seen a lot of code that
has been cooking for too long before trying to bring it mainline.

> and the colleagues are reviewing helping to bring it into an
> acceptable shape.

You have to pass the review here anyways :D

> > Can you sketch a quick block diagram showing guest, host, Virtio device,
> > Virtio driver, etc...
>=20
> I hope this arrives on the list as is been sent and not garbled:
>=20
>      Guest 2                    | Guest3
> ----------------                | ----------------
> ! cangen,      !                | ! cangen,      !
> ! candump,     !                | ! candump,     !
> ! cansend      !                | ! cansend      !
> ! using vcan0  !                | ! using can0   !
> ----------------                | ----------------
>  ^                              |             ^
>  !  ---------------------       |             !
>  !  ! Service process   !       |             !
>  !  ! in user space     !       |             !

Oliver has already commented on this :) Getting feedback from the
community early could have saved you some work :)

>  !  ! virtio-can device !       |             !
>  !  ! forwarding vcan0  !       |             !
>  !  ---------------------       |             !
>  !    ^               ^         |             !
>  !    !               !         |             !
> --------------------------------------------------
>  !    !   Device side ! kernel  | Driver side ! kernel
>  v    v               v         |             v
> ---------------- -------------- | ----------------
> ! Device Linux ! ! HV support ! | ! Driver Linux !
> !    VCan      ! !   module   ! | !  Virtio CAN  !
> !    vcan0     ! ! on device  ! | !     can0     !
> !              ! !   side     ! | !              !
> ---------------- -------------- | ----------------
>        ^               ^        |        ^
>        !               !        |        !
> --------------------------------------------------
>        !               !                 ! Hypervisor
>        v               v                 v
> --------------------------------------------------
> !                     COQOS-HV                   !
> --------------------------------------------------
>=20
> > > This works fine with
> > >=20
> > > cangen -g 0 -i can0
> > >=20
> > > on the driver side sending CAN messages to the device guest. No confi=
rmation
> > > is lost testing for several minutes.
>
> > Where's the driver side? On the host or the guest?
>=20
> Both sides are guests of the hypervisor in our architecture. There is no
> host in this sense, COQOS-HV is a type 1 hypervisor. The hypervisor does =
not
> provide devices directly on its own, the devices are provided with the
> support of a device (provider) guest which is also only a guest of the
> hypervisor.

IC - as I'm not interested in closed source solution I'd focus on the
qemu use case. Good thing is, the virtio-can must handle both use cases
anyways.

> > Have you activated SO_RXQ_OVFL?
> > With recvmsg() you get the number of dropped messages in the socket.
> > Have a look at:
> > https://github.com/linux-can/can-utils/blob/master/cansequence.c
>=20
> I had no idea about SO_RXQ_OVFL. This looks to be useful to implement an
> emergency recovery mechanism not to get stuck. If detecting loss of recei=
ved
> frames and the controller is still active and TX messages are pending for=
 a
> too long time then marking the pending TX messages as used (done) to cope
> with the situation and not getting stuck (for too long). Might be accepta=
ble
> if this was something which normally does not happen besides in really
> exceptional situations.

Your user space bridge is the wrong solution here.....See Oliver's mail.

> Nothing which should be done now, getting far too complicated for a 1st s=
hot
> to implement a Virtio CAN device.
>=20
> > We don't have a feature flag to query if the Linux driver support proper
> > CAN echo on TX complete notification.
>=20
> Not so nice. But the device integrator should know which backend is used =
and
> having a command line option for the device application the issue can be
> handled. Need the command line switch anyway now to do experiments.

If needed we can add flags to the CAN drivers so that they are
introspectable, maybe via the ethtool interface.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jawqjv2idcfirhu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDVpDkACgkQqclaivrt
76lwWgf+IplpD+QPkvURzlrcOHqtM2hFgam63TxrhriscJq4wdQ0YikiTWUYrl/x
YaH/7qmKtIzP2rPIK1oQabzKX2IxzJYCzMqj9HqI/iGSeV6V+NTuWs8BI9z1/L2O
GBv7CALiyAmB+Mg9b+Z+/lDwcgssoAyWigAdaNiGJmhxGAYrk67niVTyW5zPeV6/
c7Kut2UndGqbsuiQ1WLJ+hk7mKiLKNDUEb490aZKJ5T5AMpVEl0aRaH1v6mUWdyO
qPVJWRVH4+6b62AFjDDaOmEhW3yvQ2oQOCHF+MonEkoSF5c/yKY2ErU0TzlQxxRG
vF0NzYsjZ9Pnz33SG2a4c6aZQtET9A==
=50GQ
-----END PGP SIGNATURE-----

--jawqjv2idcfirhu7--
