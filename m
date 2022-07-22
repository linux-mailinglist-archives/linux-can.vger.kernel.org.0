Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9611C57DB40
	for <lists+linux-can@lfdr.de>; Fri, 22 Jul 2022 09:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiGVH1i (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 22 Jul 2022 03:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVH1h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Jul 2022 03:27:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C144D93C39
        for <linux-can@vger.kernel.org>; Fri, 22 Jul 2022 00:27:35 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oEn4P-000298-Ej; Fri, 22 Jul 2022 09:27:33 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 490DEB7526;
        Fri, 22 Jul 2022 07:27:32 +0000 (UTC)
Date:   Fri, 22 Jul 2022 09:27:31 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
Message-ID: <20220722072731.s3s7bkfn33zzzeni@pengutronix.de>
References: <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com>
 <f8ec078d-44c9-9f8c-800f-058e4c735003@hartkopp.net>
 <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net>
 <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
 <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net>
 <20220721075309.l6uusnyk7xjkqd4g@pengutronix.de>
 <CAMZ6RqJTZ4o3dsaYG2s9boJ4By7QC55-N+0RszT9LNxRp3bYuA@mail.gmail.com>
 <ea8ffea6-1065-8526-4774-16d088ec7bf1@hartkopp.net>
 <CAMZ6Rq+NWFc4KmhCCpJ2LzTt8ap1U_FLrQ1L1RQgYNT0BD3w_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a5ympcbchnqgbvhx"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+NWFc4KmhCCpJ2LzTt8ap1U_FLrQ1L1RQgYNT0BD3w_Q@mail.gmail.com>
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


--a5ympcbchnqgbvhx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.07.2022 12:20:43, Vincent Mailhol wrote:
> I do not buy your argument that you can not do sizeof(struct
> canxl_frame) because of naming.
>=20
> With a flexible array member, I can do:
>=20
> struct canxl_frame {
>          canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>          __u8    flags; /* additional flags for CAN XL */
>          __u8    sdt;   /* SDU (service data unit) type */
>          __u16   len;   /* frame payload length in byte */
>          __u32   af;    /* acceptance field */
>          __u8    data[];
> };
>=20
> void foo (int s)
> {
>          struct canxl_frame cxl_hdr =3D { 0 };
>          struct canxl_frame *cxl1, *cxl2;
>          size_t cxl2_data_len, cxl2_frame_len;
>=20
>          /* read header */
>          assert(read(s, &cxl_hdr, sizeof(cxl_hdr)) =3D=3D sizeof(cxl_hdr)=
);
>          cxl1 =3D malloc(sizeof(*cxl1) + cxl_hdr.len);
>          memcpy(cxl1, &cxl_hdr, sizeof(cxl_hdr));
>          /* read remaining data */
>          assert(read(s, cxl1->data, cxl1->len) =3D=3D cxl1->len);

For performance reasons you probable don't want to split the read of a
single CAN frame over 2 read() syscalls. Also the CAN_RAW doesn't
support "split"-read now, but could be extended.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--a5ympcbchnqgbvhx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLaUWAACgkQrX5LkNig
012yBwf/WzhfRbzteN8UJZUSB2AgXk+z9vuug8AITqZkJg6oevJ7a8rhiC4emSbp
jiSHE/eBnhZW3w3ch+/gFC+D6DD9/n7zU6ZzI75GTME29hfixgryZjenkA2xmqov
hE3tHiCo9a25Ha+t/7bxIdrYq3r/Q77gJ3dWXfuWr+FcetI0Q45npgNrLHfWulp3
0t5YK16HKRmKgOcMQnDWdb/VaOrfR9xOZ4+z5NtaIeFGEOs30B/iN8r/Q9b7nhrJ
Vqd0dTDELkZsTv1VR61zo0ClZE2mfOLIxxHuBZlZ73SN8QiLAL2YEbPpAmGpqOM5
3DGQbMUm3KxnMXiK0Q38eBuGb+FShg==
=19Uo
-----END PGP SIGNATURE-----

--a5ympcbchnqgbvhx--
