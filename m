Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB784563F26
	for <lists+linux-can@lfdr.de>; Sat,  2 Jul 2022 11:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiGBJFI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 2 Jul 2022 05:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBJFG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 2 Jul 2022 05:05:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0B8193F3
        for <linux-can@vger.kernel.org>; Sat,  2 Jul 2022 02:05:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o7Z3S-0004c9-SJ; Sat, 02 Jul 2022 11:04:42 +0200
Received: from pengutronix.de (unknown [IPv6:2a02:810a:8940:62d:ea1:c3c7:ca3e:2a86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 32754A57E4;
        Sat,  2 Jul 2022 09:04:35 +0000 (UTC)
Date:   Sat, 2 Jul 2022 11:04:34 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jeroen Hofstee <jhofstee@victronenergy.com>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org
Subject: Re: [PATCH v5 00/12] can: slcan: extend supported features
Message-ID: <20220702090434.3fvi4sbf4p4336ta@pengutronix.de>
References: <20220628163137.413025-1-dario.binacchi@amarulasolutions.com>
 <cc2e57b8-5b29-11b8-aa7f-fea7ac96d68a@victronenergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oizxvbovvwp4x7sw"
Content-Disposition: inline
In-Reply-To: <cc2e57b8-5b29-11b8-aa7f-fea7ac96d68a@victronenergy.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--oizxvbovvwp4x7sw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.07.2022 18:36:45, Jeroen Hofstee wrote:
> Hello Dario,
>=20
> On 6/28/22 18:31, Dario Binacchi wrote:
> > This series originated as a result of CAN communication tests for an
> > application using the USBtin adapter (https://www.fischl.de/usbtin/).
> > The tests showed some errors but for the driver everything was ok.
> > Also, being the first time I used the slcan driver, I was amazed that
> > it was not possible to configure the bitrate via the ip tool.
> > For these two reasons, I started looking at the driver code and realized
> > that it didn't use the CAN network device driver interface.
> >=20
> > Starting from these assumptions, I tried to:
> > - Use the CAN network device driver interface.
> > - Set the bitrate via the ip tool.
> > - Send the open/close command to the adapter from the driver.
> > - Add ethtool support to reset the adapter errors.
> > - Extend the protocol to forward the adapter CAN communication
> >    errors and the CAN state changes to the netdev upper layers.
> >=20
> > Except for the protocol extension patches (i. e. forward the adapter CAN
> > communication errors and the CAN state changes to the netdev upper
> > layers), the whole series has been tested under QEMU with Linux 4.19.208
> > using the USBtin adapter.
> > Testing the extension protocol patches requires updating the adapter
> > firmware. Before modifying the firmware I think it makes sense to know =
if
> > these extensions can be considered useful.
> >=20
> > Before applying the series I used these commands:
> >=20
> > slcan_attach -f -s6 -o /dev/ttyACM0
> > slcand ttyACM0 can0
> > ip link set can0 up
> >=20
> > After applying the series I am using these commands:
> >=20
> > slcan_attach /dev/ttyACM0
> > slcand ttyACM0 can0
> > ip link set dev can0 down
> > ip link set can0 type can bitrate 500000
> > ethtool --set-priv-flags can0 err-rst-on-open on
> > ip link set dev can0 up
> >=20
> > Now there is a clearer separation between serial line and CAN,
> > but above all, it is possible to use the ip and ethtool commands
> > as it happens for any CAN device driver. The changes are backward
> > compatible, you can continue to use the slcand and slcan_attach
> > command options.
>=20
> Many thanks,
>=20
> For what it is worth, up to "Send the open/close command to the adapter
> from the driver.", I cherry-picked this back to 5.10. That seems to work.

Thanks for testing. Can I add your Tested-by: for these patches?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--oizxvbovvwp4x7sw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLACh8ACgkQrX5LkNig
013U8Af+OF4vYJO8Fig2zQuOB0CKVtoDqakjZ15NS/5vqJKeHK8RZ8jNusi48ZRp
PH1Sc74ckVlo1ibm9TgC90+Ho8bJqrGRLLOcTR69uQrR4uDnde4xcCanQr6Zyr44
rH6VI7lxJjQMUGoah8xL8A4TjjxXuzefidx6qzFD6SxTA+Zi/BhsZh4kJWTNFYEA
9YqVgFhiQ7Won+FmF+KVm3GgULTzvcYoX12YJ3ZlXE7OXuf5DpPWBPwIxvRAfJCc
GtQNM8+1cEt9UUdy4PHpAFfl+2jF2ZJhT+HbR/BYZpTadvRwu5Pj9f5p5NK/B/ZC
S6MLXxHUfqQmNmpgs8hWRWH3myUQrw==
=ebXA
-----END PGP SIGNATURE-----

--oizxvbovvwp4x7sw--
