Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1B6577F4A
	for <lists+linux-can@lfdr.de>; Mon, 18 Jul 2022 12:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiGRKFQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Jul 2022 06:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiGRKFP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Jul 2022 06:05:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B76B1C115
        for <linux-can@vger.kernel.org>; Mon, 18 Jul 2022 03:05:14 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oDNcm-0003fk-BU; Mon, 18 Jul 2022 12:05:12 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 354F8B2F71;
        Mon, 18 Jul 2022 10:05:11 +0000 (UTC)
Date:   Mon, 18 Jul 2022 12:05:10 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: [linux-next:master] BUILD REGRESSION
 4662b7adea50bb62e993a67f611f3be625d3df0d
Message-ID: <20220718100510.mcxiwbbqljoyvsav@pengutronix.de>
References: <62cf77c3.3T/sxYUjJq0ImGp4%lkp@intel.com>
 <2d6d9627-bc98-07e9-dbcb-5f317913f5aa@hartkopp.net>
 <CABGWkvqNSgweoLoeOwhEdz27pqYVBH32TLTeEwNRiXhncUeB3g@mail.gmail.com>
 <93511e4e-acad-90ea-cd37-7256f328909e@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lch73jejqmncxhg2"
Content-Disposition: inline
In-Reply-To: <93511e4e-acad-90ea-cd37-7256f328909e@hartkopp.net>
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


--lch73jejqmncxhg2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.07.2022 09:05:35, Oliver Hartkopp wrote:
> Hi Dario,
>=20
> On 18.07.22 08:52, Dario Binacchi wrote:
> > Hi Oliver,
> >=20
> > On Sun, Jul 17, 2022 at 3:58 PM Oliver Hartkopp <socketcan@hartkopp.net=
> wrote:
> > >=20
> > > Hi Dario,
> > >=20
> > > did you see this build regression too?
> > >=20
> > > On 14.07.22 03:56, kernel test robot wrote:
> > > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/l=
inux-next.git master
> > > > branch HEAD: 4662b7adea50bb62e993a67f611f3be625d3df0d  Add linux-ne=
xt specific files for 20220713
> > > >=20
> > > > Error/Warning reports:
> > >=20
> > > (..)
> > >=20
> > > > drivers/net/can/slcan/slcan-core.c:601:14: sparse:    void *
> > > > drivers/net/can/slcan/slcan-core.c:601:14: sparse:    void [noderef=
] __rcu *
> > > > drivers/net/can/slcan/slcan-core.c:601:14: sparse: sparse: incompat=
ible types in comparison expression (different address spaces):
> > >=20
> >=20
> > IMHO I think that adding '__rcu' annotation would remove the warning:
> >=20
> > diff --git a/include/linux/tty.h b/include/linux/tty.h
> > index 7b0a5d478ef6..278b84f04d20 100644
> > --- a/include/linux/tty.h
> > +++ b/include/linux/tty.h
> > @@ -239,7 +239,7 @@ struct tty_struct {
> >          wait_queue_head_t write_wait;
> >          wait_queue_head_t read_wait;
> >          struct work_struct hangup_work;
> > -       void *disc_data;
> > +       void __rcu *disc_data;
> >          void *driver_data;
> >          spinlock_t files_lock;
> >          struct list_head tty_files;
> >=20
> > But in the paragraph "SPARSE CHECKING OF RCU-PROTECTED POINTERS" of
> > Documentation/RCU/rcu_dereference.rst
> > we read:
> > ...
> > Unfortunately, these sorts of bugs can be extremely hard to spot during
> > review.  This is where the sparse tool comes into play, along with the
> > "__rcu" marker.  If you mark a pointer declaration, whether in a struct=
ure
> > or as a formal parameter, with "__rcu", which tells sparse to complain =
if
> > this pointer is accessed directly.  It will also cause sparse to compla=
in
> > if a pointer not marked with "__rcu" is accessed using rcu_dereference()
> > and friends.
> > ...
> > Use of "__rcu" is opt-in.  If you choose not to use it, then you should
> > ignore the sparse warnings.
> > ...
> >=20
> > So, I think that by adding the '__rcu' annotation we would have new
> > warnings in all those points
> > where disc_data is accessed directly (which are many more than those
> > where rcu_dereference() is used).
> >=20
> > If I'm not mistaken, the warning also refers to code that my series
> > hasn't touched. Also, in the 'BUILD REGRESSION'
>=20
> Oh, I didn't check that myself.
>=20
> So some old code just came into focus :-/
>=20
> > report, the slcan warning is found under the 'Unverified Error /
> > Warning (likely false positive, please contact us if interested)'
> > section.
> >=20
> > So, can it be okay to think about leaving everything as it is, and
> > then not apply any patches to remove this warning?
>=20
> Yes. With this this background leaving the code as-is seems to be
> appropriate too. Thanks for the explanation!
>=20
> Maybe Marc has another opinion. So let's wait for his feedback ...

This is not a regression, so leave as is for now.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--lch73jejqmncxhg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLVMFQACgkQrX5LkNig
012engf/cWx4GwjkKkPHPdALLVV7W5raZQf89iDvZNlEpZfJN82ikaeuG08Ua3PE
ysqgL0p3VpcWwlw07JHLQvY6UzIgONBIGK13sTspc4IeGbCDQJ2L8OlLx+e6k35i
g66xUkpo8zaedwNxQeKiXCa+5A38LvIjhi8t0aSDy24FjS9sQicgbuwG5NnR04sl
RtOMfYrnubCjI/eDtv9H0h75woGX8BevP7AZRvGAAvrO32CFg6ZBBzQsUW+wgOCH
aMcQlTbAHmbU1IweiIBHB5tHWYvQsUb95CPFhxe35GLewetJmbLgbPJpVABNwE01
G/CJoc4kNroTn15wJTEIueQmL6uCgg==
=ld9d
-----END PGP SIGNATURE-----

--lch73jejqmncxhg2--
