Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40072BBF1F
	for <lists+linux-can@lfdr.de>; Sat, 21 Nov 2020 14:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgKUNCt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 21 Nov 2020 08:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgKUNCs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 21 Nov 2020 08:02:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD17C0613CF
        for <linux-can@vger.kernel.org>; Sat, 21 Nov 2020 05:02:47 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kgSXL-0006lS-Ps; Sat, 21 Nov 2020 14:02:43 +0100
Received: from [IPv6:2a03:f580:87bc:d400:4c1f:9c86:2b81:b0ea] (unknown [IPv6:2a03:f580:87bc:d400:4c1f:9c86:2b81:b0ea])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BB7F35983C1;
        Sat, 21 Nov 2020 13:02:42 +0000 (UTC)
To:     Niels <niels@ka-long.de>, linux-can <linux-can@vger.kernel.org>
References: <20201121094511.9C3AB27C0319@dd33904.kasserver.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: MCP2518FD Treiber
Message-ID: <25aa6faa-fc39-5d4c-844d-2283a232087e@pengutronix.de>
Date:   Sat, 21 Nov 2020 14:02:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201121094511.9C3AB27C0319@dd33904.kasserver.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Wddo4X70YT6Rd7mZ2rjdJ1jUMjUwXlrZX"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wddo4X70YT6Rd7mZ2rjdJ1jUMjUwXlrZX
Content-Type: multipart/mixed; boundary="b0M5NQhicY1bt1MwnlGuJwRP50r0XOGtW";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Niels <niels@ka-long.de>, linux-can <linux-can@vger.kernel.org>
Message-ID: <25aa6faa-fc39-5d4c-844d-2283a232087e@pengutronix.de>
Subject: Re: MCP2518FD Treiber
References: <20201121094511.9C3AB27C0319@dd33904.kasserver.com>
In-Reply-To: <20201121094511.9C3AB27C0319@dd33904.kasserver.com>

--b0M5NQhicY1bt1MwnlGuJwRP50r0XOGtW
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hey Niels,

kennst Du schon die linux-can (linux-can <linux-can@vger.kernel.org>)
Mailingliste? Bitte verwende diese f=C3=BCr Community Anfragen. Wenn Du n=
och fragen
hast, nimm bitte die ML auf Cc und steige auf Englisch um :D

On 11/21/20 10:45 AM, Niels wrote:
> Ich habe Deinen Treiber im offiziellen Kernel gefunden und versuche nun=
 ein
> Projekt mit diesem Baustein umzusetzen. Der MCP (MIKROE 3060:
> https://www.mikroe.com/mcp2518fd-click) ist verbunden mit einem IMX7D v=
on
> NXP.>
> Leider unterst=C3=BCtzt NXP f=C3=BCr den IMX7D als neustes zur Zeit nur=
 den Kernel
> 5.4.47. Auf dem IMX7D l=C3=A4uft ein Debian 10.6. F=C3=BCr den Backport=
 musste
> allerdings nur in rx_offload.c die Funktion can_rx_offload_add_manual (=
aus
> dem master kopiert) hinzugef=C3=BCgt werden und zwei Namen in einer Str=
uktur haben
> sich ge=C3=A4ndert.

Es gibt aus meiner Sicht beim imx7 den Gammelkernel von nxp einzusetzen.

> Sieht eigentlich alles gut aus. Signale auf dem Scope sehen auch richti=
g aus.
> Nur das abschlie=C3=9Fende "ip link can2 up" bzw. "ifconfig can2 up" re=
sultiert in
> "invalid argument".
>
> Ich hab es mit verschiedenen iproute2 Versionen / SPI Frequenzen
> ausprobiert.
>
> Bei der Initialisierung das e: 0.00MHz irritiert mich. Fehlt da beim DT=
 oder
> beim ip link set noch was ?

"e" steht f=C3=BCr effective. Wenn Du auf einen aktuellen Kernel wechsels=
t oder noch
den folgen Patch auf den nxp Kernel wirfst, dann zeigt der Treiber an, we=
lche
clock der SPI Bus tats=C3=A4chlich hat.

"c" ist der externe Oszillator
"m" ist die maximale Frequenz vom DT
"r" ist die angefragte (requested) Frequenz des mcp251xfd
    Treibers an das SPI Framework

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/spi/spi-imx.c?h=3Dv5.10-rc4&id=3Dbf253e6bf6b876a4ce74db7dcf8a13b=
80d84aa5f

> root@cl-debian:~# dmesg | grep mcp
> [   15.716774] mcp251xfd spi1.0: can_rx_offload_init_queue: skb_queue_l=
en_max=3D512
> [   15.756445] mcp251xfd spi1.0 can2: MCP2518FD rev0.0 (+RX_INT -MAB_NO=
_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:4.00MHz r:4.00MHz e:=
0.00MHz) successfully initialized.
>=20
> root@cl-debian:~# ip --details link show can2
> 7: can2: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group d=
efault qlen 10
>     link/can  promiscuity 0 minmtu 0 maxmtu 0=20
>     can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0=20
> 	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1=

> 	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-inc=
 1
> 	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_ma=
x_segs 65535=20
>=20
> root@cl-debian:~# ip link set can2 type can bitrate 500000 dbitrate 100=
0000 fd on
> root@cl-debian:~# ip --details link show can2
> 7: can2: <NOARP,ECHO> mtu 72 qdisc noop state DOWN mode DEFAULT group d=
efault qlen 10
>     link/can  promiscuity 0 minmtu 0 maxmtu 0=20
>     can <FD> state STOPPED (berr-counter tx 0 rx 0) restart-ms 0=20
> 	  bitrate 500000 sample-point 0.875=20
> 	  tq 25 prop-seg 34 phase-seg1 35 phase-seg2 10 sjw 1
> 	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1=

> 	  dbitrate 1000000 dsample-point 0.750=20
> 	  dtq 25 dprop-seg 14 dphase-seg1 15 dphase-seg2 10 dsjw 1
> 	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-inc=
 1
> 	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_ma=
x_segs 65535
>=20
> root@cl-debian:~# ip link set can2 up
> RTNETLINK answers: Invalid argument
>=20
> root@cl-debian:~# dmesg | grep mcp
> [   15.716774] mcp251xfd spi1.0: can_rx_offload_init_queue: skb_queue_l=
en_max=3D512
> [   15.756445] mcp251xfd spi1.0 can2: MCP2518FD rev0.0 (+RX_INT -MAB_NO=
_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:4.00MHz r:4.00MHz e:=
0.00MHz) successfully initialized.
> [  436.792327] mcp251xfd spi1.0 can2: FIFO setup: TEF: 4*12 bytes =3D 4=
8 bytes, TX: 4*72 bytes =3D 288 bytes
> [  436.792344] mcp251xfd spi1.0 can2: FIFO setup: RX-0: 16*76 bytes =3D=
 1216 bytes
> [  436.792353] mcp251xfd spi1.0 can2: FIFO setup: free: 496 bytes
>=20
> root@cl-debian:~# strace ifconfig can2 up
> ioctl(4, SIOCGIFFLAGS, {ifr_name=3D"can2", ifr_flags=3DIFF_NOARP}) =3D =
0
> ioctl(4, SIOCSIFFLAGS, {ifr_name=3D"can2", ifr_flags=3DIFF_UP|IFF_RUNNI=
NG|IFF_NOARP}) =3D -1 EINVAL (Invalid argument)
> dup(2)
>=20
> Device Tree Schnipsel:
>=20
> &ecspi2 {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_ecspi2>;
>         status =3D "okay";
>=20
>         fsl,spi-num-chipselects =3D <1>;
>         cs-gpios =3D <&gpio4 23 0>;
>=20
>         mcp2518fd@0 {
>                 compatible =3D "microchip,mcp2518fd";
>                 reg =3D <0x00>;
>                 microchip,rx-int-gpios =3D <&gpio3 0 GPIO_ACTIVE_LOW>;

Das ist der nRX-INT Pin des MCP, nicht der Interrupt.

>                 spi-max-frequency =3D <4000000>;
>                 clocks =3D <&mcp2518fd_clk>;  // fixed, 40MHz

Hier fehlt der Interrupt, siehe:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml?h=3Dv5.=
10-rc4#n75

Unter der Annahme, dass der gpio3-0 der richtige IRQ ist, dann musst Du d=
ie Zeile

| interrupts-extended =3D <&gpio3 0 IRQ_TYPE_LEVEL_LOW>;

anstatt der

| microchip,rx-int-gpios

verwenden.

Ich schaue mal, ob ich beim laden des Treibers schon feststellen kann, ob=
 der
IRQ fehlt um dann eine Fehlermeldung auszugeben.

Deine Email Adresse w=C3=BCrde ich als "Reported-by: Niels <niels@ka-long=
=2Ede>" unter
den Patch schreiben. Ist das OK?

Gr=C3=BC=C3=9Fe,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--b0M5NQhicY1bt1MwnlGuJwRP50r0XOGtW--

--Wddo4X70YT6Rd7mZ2rjdJ1jUMjUwXlrZX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+5D+0ACgkQqclaivrt
76ko0wgAgXPsTJh0wucnTpnVbQw30bPin1vCcvNb0NbRyVIHltCHPqjIqNNnZ9v/
Y2PpObD9fsoJZJTNXGugCmnxYyJldQP6T3hPKpjxwhR99tzjaSG2+0+dHUzt4L1Y
K7mcOgKeGENAEMVRuAA7NUbU8oDBW//YfWpC4dAdR9tSe2KNXZXqU8DxmMUFZ5lH
H+1Cs2TMUv9auckQCjk5qWPBCsmAks7m8OSN5g8kvzgKs/mCERqD4gpFhF+JMHeR
5S/yBIGOMx4vn57RbZIGo9O9em0J59wCTliLYv7w0yrLiq3EFMzfPz9dhjXZtDd4
50et0OHXCEaMRLmjMANvA07Voa1pDA==
=yG4G
-----END PGP SIGNATURE-----

--Wddo4X70YT6Rd7mZ2rjdJ1jUMjUwXlrZX--
