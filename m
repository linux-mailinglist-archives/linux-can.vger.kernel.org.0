Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3D457DF0D
	for <lists+linux-can@lfdr.de>; Fri, 22 Jul 2022 12:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbiGVJ7C (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 22 Jul 2022 05:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbiGVJ7B (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Jul 2022 05:59:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549963FA13
        for <linux-can@vger.kernel.org>; Fri, 22 Jul 2022 02:59:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oEpQv-000595-Da; Fri, 22 Jul 2022 11:58:57 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7B821B76BA;
        Fri, 22 Jul 2022 09:58:56 +0000 (UTC)
Date:   Fri, 22 Jul 2022 11:58:53 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
Message-ID: <20220722095853.jb3ko4qsktud5uob@pengutronix.de>
References: <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net>
 <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
 <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net>
 <20220721075309.l6uusnyk7xjkqd4g@pengutronix.de>
 <CAMZ6RqJTZ4o3dsaYG2s9boJ4By7QC55-N+0RszT9LNxRp3bYuA@mail.gmail.com>
 <ea8ffea6-1065-8526-4774-16d088ec7bf1@hartkopp.net>
 <CAMZ6Rq+NWFc4KmhCCpJ2LzTt8ap1U_FLrQ1L1RQgYNT0BD3w_Q@mail.gmail.com>
 <20220722072731.s3s7bkfn33zzzeni@pengutronix.de>
 <CAMZ6RqJcUtSyYbYnqAE87hrwL1G+cxGLKAZ_E4kvSW3Mq43tYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kegxnr6o2bnomam6"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJcUtSyYbYnqAE87hrwL1G+cxGLKAZ_E4kvSW3Mq43tYg@mail.gmail.com>
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


--kegxnr6o2bnomam6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.07.2022 17:33:08, Vincent Mailhol wrote:
> On Fri. 22 Jul. 2022 at 16:27, Marc Kleine-Budde <mkl@pengutronix.de> wro=
te:
> > On 22.07.2022 12:20:43, Vincent Mailhol wrote:
> > > I do not buy your argument that you can not do sizeof(struct
> > > canxl_frame) because of naming.
> > >
> > > With a flexible array member, I can do:
> > >
> > > struct canxl_frame {
> > >          canid_t prio;  /* 11 bit priority for arbitration (canid_t) =
*/
> > >          __u8    flags; /* additional flags for CAN XL */
> > >          __u8    sdt;   /* SDU (service data unit) type */
> > >          __u16   len;   /* frame payload length in byte */
> > >          __u32   af;    /* acceptance field */
> > >          __u8    data[];
> > > };
> > >
> > > void foo (int s)
> > > {
> > >          struct canxl_frame cxl_hdr =3D { 0 };
> > >          struct canxl_frame *cxl1, *cxl2;
> > >          size_t cxl2_data_len, cxl2_frame_len;
> > >
> > >          /* read header */
> > >          assert(read(s, &cxl_hdr, sizeof(cxl_hdr)) =3D=3D sizeof(cxl_=
hdr));
> > >          cxl1 =3D malloc(sizeof(*cxl1) + cxl_hdr.len);
> > >          memcpy(cxl1, &cxl_hdr, sizeof(cxl_hdr));
> > >          /* read remaining data */
> > >          assert(read(s, cxl1->data, cxl1->len) =3D=3D cxl1->len);
> >
> > For performance reasons you probable don't want to split the read of a
> > single CAN frame over 2 read() syscalls.
>=20
> ACK. I wrote the code to illustrate how to do header manipulations.
> The goal of this example was not to be optimal but to show off how
> sizeof(struct canxl_frame) could be used. Sorry if the example was not
> natural and a bit too forced.
>=20
> > Also the CAN_RAW doesn't
> > support "split"-read now, but could be extended.
>=20
> Interesting! I naively thought that split read() was handled at a
> higher level of the socket API. I did not know that it was per
> protocol.

The CAN_RAW protocol implements raw_recvmsg():

| https://elixir.bootlin.com/linux/latest/source/net/can/raw.c#L843

> It could make sense to allow such split read() for CANXL.

Then we have to track the number of already read bytes inside the
socket. The POSIX API offers some interesting flags to recvmsg(). With
MSG_PEEK you can read but not remove the read data from the queue and/or
MSG_TRUNC to get the total size of the CAN frame.

I have not tested these flags, but I think support for them has to be
implemented in CAN_RAW, too.

Also, we should have a look at the UDP code.

> One example
> I can directly think of is the Packet API. Correct me if I am wrong
> but if writing generic code to dump packets on any interfaces, you do
> not know in advance the MTU. And so, I guess you have to provide a
> buffer of an arbitrary size. A generic program using a buffer of, let
> say, 2048 bytes (one page) will not be enough to get a CANXL frame in
> one single shot.

Nitpick: the page size is arch and/or kernel config dependent and the
smallest page size that Linux supports is 4k.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--kegxnr6o2bnomam6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLadNsACgkQrX5LkNig
013uhgf/ddvvA7iGxxSV+5vO3duSSSe6UQQjuFE5+dBxnKicYC78YNVlUMP4r7mI
LnWWltfrpVkWty2nU0oUF2fFkNuYL1DYAuTxSJVvOZviC0PcdfQ/WOiupoInA8f+
uQQ/ZigKtgyZFSJbJBSudOlvEo4IxAa8yd4VPF1gkpTKB6N8HmwWi+ywoa/07ZHV
1+wv+e5+0s9emICYYcsQxqABZfLpFYzcgP70x29wbI52YasckrEn5mz0DUZMlBFQ
WFR/i3hV0GrW9pQq/SoVEN/MwrOpAmfuDUh08ouHrIwhCtq5LqyUTCq5HKaubLuh
yyXN6HyGfyBEYbRogRnQZbQMReg7BQ==
=pSgM
-----END PGP SIGNATURE-----

--kegxnr6o2bnomam6--
