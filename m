Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ED47295B7
	for <lists+linux-can@lfdr.de>; Fri,  9 Jun 2023 11:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241792AbjFIJoB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Jun 2023 05:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbjFIJno (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Jun 2023 05:43:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C713AAF
        for <linux-can@vger.kernel.org>; Fri,  9 Jun 2023 02:38:23 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1q7YZA-00036g-4M; Fri, 09 Jun 2023 11:37:56 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E92151D56B2;
        Fri,  9 Jun 2023 09:37:54 +0000 (UTC)
Date:   Fri, 9 Jun 2023 11:37:54 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Harald Mommer <harald.mommer@opensynergy.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        virtio-comment@lists.oasis-open.org,
        virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
        Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
Subject: Re: [virtio-dev] Re: [virtio-comment] [RFC PATCH v2 1/1] virtio-can:
 Device specification - 2nd RFC draft.
Message-ID: <20230609-greasily-jolliness-6b5bde46f390-mkl@pengutronix.de>
References: <20220825133410.18367-1-harald.mommer@opensynergy.com>
 <87o7tj2bgd.fsf@redhat.com>
 <7f10427c-cad4-6eeb-31f0-e39ccdbc38ab@opensynergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gvutexvarpe3wb7n"
Content-Disposition: inline
In-Reply-To: <7f10427c-cad4-6eeb-31f0-e39ccdbc38ab@opensynergy.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--gvutexvarpe3wb7n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.06.2023 15:45:33, Harald Mommer wrote:
> > > - Removal of priorities and config space. Priorities cannot be suppor=
ted
> > >    using SocketCAN, the information delivered in the config space can=
not
> > >    be determined using SocketCAN. Support of different priorities was
> > >    anyway too much for a first version of a specification. If priorit=
ies
> > >    are supported in a future version there will probably be only 2
> > >    different priorities, normal and high. In a future version of the
> > >    specification high priority messages may either be supported by us=
ing
> > >    a flag bit in the TX message but most probably the better solution
> > >    will be to add add a dedicated 2nd TX queue for high priority mess=
ages
> > >    in a review comment. But as already said priorities are not for no=
w.
> > Please keep the change log separate from the description.
> >=20
> > [Most people add a S-o-b, although we don't enforce DCO.]
>=20
> I understand neither "S-o-b" nor "DCO". Neither Wikipedia nor Google are
> helpful, nothing fits.

S-o-b: Signed-off-by
DCO: Developer's Certificate of Origin

See https://elixir.bootlin.com/linux/v6.3/source/Documentation/process/subm=
itting-patches.rst#L379

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gvutexvarpe3wb7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSC8u8ACgkQvlAcSiqK
BOjAlQgAmmmSbo1/9cD9bXx+ZSW2cq7d4S8RUeOOeCyiEurgasFP9EtVZqplvTlb
yJ4CFh4HLb+6qdZYtVlEn284rTqGRpdUER3CqJmjIpXggzqKhpgObrYNoGZpDJM4
SIo5xbQtE6nNsLAQB4t6QeLbbQSw6q+UmUsgFZxTaMzkh7/uZlrZ1j1VeZaj3RqM
6yHvZrzmvBHUHqLa1ptjOqRGe2VwFE1K9bclsMTKyGXGvQr+WxthP0m2ZRDGBoNm
97mh4jE8EZ95JFnKPeBogQxZxXA7XExCCOU2fPzJwqnjnnqcz4dQobD/JMUMtLvO
SdrlMuCpfVjbAIUo8kVPQyozFsWTcg==
=L29k
-----END PGP SIGNATURE-----

--gvutexvarpe3wb7n--
