Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0025E5B273E
	for <lists+linux-can@lfdr.de>; Thu,  8 Sep 2022 21:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiIHT5k (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 8 Sep 2022 15:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiIHT5g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Sep 2022 15:57:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6B1FF0A4
        for <linux-can@vger.kernel.org>; Thu,  8 Sep 2022 12:57:28 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oWNeJ-0002iF-Ix; Thu, 08 Sep 2022 21:57:19 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:e7f2:6448:cd86:7374])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 93C03DDA92;
        Thu,  8 Sep 2022 19:57:17 +0000 (UTC)
Date:   Thu, 8 Sep 2022 21:57:16 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas.Kopp@microchip.com
Cc:     linux-can@vger.kernel.org, mark@baggywrinkle.co.uk
Subject: Re: [PATCH 5/5] can: bittiming: can_calc_bittiming(): use Phase Seg2
 / 2 as default for SJW
Message-ID: <871qsmt3mq.fsf@hardanger.blackshift.org>
References: <20220907103845.3929288-1-mkl@pengutronix.de>
 <20220907103845.3929288-6-mkl@pengutronix.de>
 <BL3PR11MB64844BD45DE7FDE94BDE47BCFB419@BL3PR11MB6484.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s6nxcslj6in4m26q"
Content-Disposition: inline
In-Reply-To: <BL3PR11MB64844BD45DE7FDE94BDE47BCFB419@BL3PR11MB6484.namprd11.prod.outlook.com>
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


--s6nxcslj6in4m26q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thomas,

On 07.09.2022 19:19:42, Thomas.Kopp@microchip.com wrote:
> > In other words this means the SJW parameter controls the tolerance of
> > the CAN controller against the frequency error compared to other CAN
> > controllers.
> >
> > If the user space doesn't provide a SJW parameter, the kernel chooses
> > a default value of 1. This proved to be a good default value for CAN
> > controllers, but not anymore with modern controllers.
> >
> > To get the same oscillator tolerances on controllers with wide bit
> > timing registers, choose a default SJW value of Phase Seg2 / 2. This
> > results in the following bit timing parameters:
>
> Thanks for your work on this! May I ask why Phase Seg2 / 2 is chosen?

According to "Combining CANopen and SAE J1939 networks" [2], CANopen and
J1939 use a SJW of 1:

"The CANopen standard CiA 301 allows various bitrates in the range from
 10 kBit/s to 1 MBit/s. The J1939-11 specification stipulates 250 kBit/s
 and is used in the majority of applications. The J1939-14 standard
 specifies 500 kBit/s for the physical layer.

 Thereby the bitrate for a shared physical layer is limited to the
 bitrates 250 kBit/s and 500 kBit/s. Fortunately both standards define
 the same sample point location at 87,5 % together with a SJW value of
 1."

I think this is why we implemented a default SJW of 1 in the kernel.

As discussed in my patch description a SJW of 1 for controllers that
were common at the time these standard were written, with narrow bit
timing registers, equals "Phase Seg2 / 2".

In "The Configuration of the CAN Bit Timing" [3] the following criteria
for the Oscillator Tolerance Range was given:

"The tolerance range df for an oscillator=E2=80=99s frequency f_osc around =
the
 nominal frequency f_nom with:

 (1 - df) * f_nom <=3D f_osc <=3D (1 + df) * f_nom

 depends on the proportions of Phase_Seg1, Phase_Seg2, SJW, and the bit
 time. The maximum tolerance df is the defined by two conditions (both
 shall be met):

              min(Phase_Seg1, Phase_Seg2)
 I:  df <=3D --------------------------------
           2 * (13 * bit_time - Phase_Seg2)

                SJW
 II: df <=3D -------------
           20 * bit_time
"

The 2nd criteria (see "df2" column) is influenced by SJW, so of
interest. Here a sja1000 controller:

| Bit timing parameters for sja1000 with 8.000000 MHz ref clock using algo =
'v5.19'
|                     _----+--------------=3D> TSeg1: 1 =E2=80=A6   16
|                    /    /     _---------=3D> TSeg2: 1 =E2=80=A6    8
|                   |    |     /    _-----=3D> SJW:   1 =E2=80=A6    4
|                   |    |    |    /    _-=3D> BRP:   1 =E2=80=A6   64 (inc=
: 1)
|                   |    |    |   |    /
|  nominal          |    |    |   |   |     real  Bitrt    nom   real   Sam=
pP
|  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP   Err=
or   df1    df2   BTR0 BTR1
|  1000000    125   2    3    2   1   1  1000000   0.0%  75.0%  75.0%   0.0=
%   9.8=E2=80=B0   6.2=E2=80=B0   0x00 0x14
|   800000    125   3    4    2   1   1   800000   0.0%  80.0%  80.0%   0.0=
%   7.8=E2=80=B0   5.0=E2=80=B0   0x00 0x16
|   666666    125   4    4    3   1   1   666666   0.0%  80.0%  75.0%   6.2=
%   9.8=E2=80=B0   4.2=E2=80=B0   0x00 0x27
|   500000    125   6    7    2   1   1   500000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.1=E2=80=B0   0x00 0x1c
|   250000    250   6    7    2   1   2   250000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.1=E2=80=B0   0x01 0x1c
|   125000    500   6    7    2   1   4   125000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.1=E2=80=B0   0x03 0x1c
|   100000    625   6    7    2   1   5   100000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.1=E2=80=B0   0x04 0x1c
|    83333    750   6    7    2   1   6    83333   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.1=E2=80=B0   0x05 0x1c
|    50000   1250   6    7    2   1  10    50000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.1=E2=80=B0   0x09 0x1c
|    33333   1875   6    7    2   1  15    33333   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.1=E2=80=B0   0x0e 0x1c
|    20000   3125   6    7    2   1  25    20000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.1=E2=80=B0   0x18 0x1c
|    10000   6250   6    7    2   1  50    10000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.1=E2=80=B0   0x31 0x1c

"df2" is 3.1=E2=80=B0 for 500kbit/s or slower.

In contrast the mcp251xfd with the current mainline bit timing algorithm
(SJW=3D1):

| Bit timing parameters for mcp251xfd with 40.000000 MHz ref clock (CIA rec=
ommendation) using algo 'v5.19'
|                     _----+--------------=3D> TSeg1: 2 =E2=80=A6  256
|                    /    /     _---------=3D> TSeg2: 1 =E2=80=A6  128
|                   |    |     /    _-----=3D> SJW:   1 =E2=80=A6  128
|                   |    |    |    /    _-=3D> BRP:   1 =E2=80=A6  256 (inc=
: 1)
|                   |    |    |   |    /
|  nominal          |    |    |   |   |     real  Bitrt    nom   real   Sam=
pP
|  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP   Err=
or   df1    df2       NBTCFG
|  1000000     25  14   15   10   1   1  1000000   0.0%  75.0%  75.0%   0.0=
%   9.8=E2=80=B0   1.2=E2=80=B0   0x001c0900
|   800000     25  19   20   10   1   1   800000   0.0%  80.0%  80.0%   0.0=
%   7.8=E2=80=B0   1.0=E2=80=B0   0x00260900
|   666666     25  23   24   12   1   1   666666   0.0%  80.0%  80.0%   0.0=
%   7.8=E2=80=B0   0.8=E2=80=B0   0x002e0b00
|   500000     25  34   35   10   1   1   500000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   0.6=E2=80=B0   0x00440900
|   250000     25  69   70   20   1   1   250000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   0.3=E2=80=B0   0x008a1300
|   125000     50  69   70   20   1   2   125000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   0.3=E2=80=B0   0x018a1300
|   100000     50  87   87   25   1   2   100000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   0.2=E2=80=B0   0x01ad1800
|    83333     50 104  105   30   1   2    83333   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   0.2=E2=80=B0   0x01d01d00
|    50000    100  87   87   25   1   4    50000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   0.2=E2=80=B0   0x03ad1800
|    33333    125 104  105   30   1   5    33333   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   0.2=E2=80=B0   0x04d01d00
|    20000    250  87   87   25   1  10    20000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   0.2=E2=80=B0   0x09ad1800
|    10000    500  87   87   25   1  20    10000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   0.2=E2=80=B0   0x13ad1800

for slow bit rates "df2" drops to 0.2=E2=80=B0.

Here the mcp251xfd with the updated algorithm (SJW =3D Phase Seg2 / 2):

| Bit timing parameters for mcp251xfd with 40.000000 MHz ref clock (CIA rec=
ommendation) using algo 'next'
|                     _----+--------------=3D> TSeg1: 2 =E2=80=A6  256
|                    /    /     _---------=3D> TSeg2: 1 =E2=80=A6  128
|                   |    |     /    _-----=3D> SJW:   1 =E2=80=A6  128
|                   |    |    |    /    _-=3D> BRP:   1 =E2=80=A6  256 (inc=
: 1)
|                   |    |    |   |    /
|  nominal          |    |    |   |   |     real  Bitrt    nom   real   Sam=
pP
|  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP   Err=
or   df1    df2       NBTCFG
|  1000000     25  14   15   10   5   1  1000000   0.0%  75.0%  75.0%   0.0=
%   9.8=E2=80=B0   6.2=E2=80=B0   0x001c0904
|   800000     25  19   20   10   5   1   800000   0.0%  80.0%  80.0%   0.0=
%   7.8=E2=80=B0   5.0=E2=80=B0   0x00260904
|   666666     25  23   24   12   6   1   666666   0.0%  80.0%  80.0%   0.0=
%   7.8=E2=80=B0   5.0=E2=80=B0   0x002e0b05
|   500000     25  34   35   10   5   1   500000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.1=E2=80=B0   0x00440904
|   250000     25  69   70   20  10   1   250000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.1=E2=80=B0   0x008a1309
|   125000     50  69   70   20  10   2   125000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.1=E2=80=B0   0x018a1309
|   100000     50  87   87   25  12   2   100000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.0=E2=80=B0   0x01ad180b
|    83333     50 104  105   30  15   2    83333   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.1=E2=80=B0   0x01d01d0e
|    50000    100  87   87   25  12   4    50000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.0=E2=80=B0   0x03ad180b
|    33333    125 104  105   30  15   5    33333   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.1=E2=80=B0   0x04d01d0e
|    20000    250  87   87   25  12  10    20000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.0=E2=80=B0   0x09ad180b
|    10000    500  87   87   25  12  20    10000   0.0%  87.5%  87.5%   0.0=
%   4.9=E2=80=B0   3.0=E2=80=B0   0x13ad180b

The "df2" stays at ~3.1=E2=80=B0

[2] http://web.archive.org/https://www.can-cia.org/fileadmin/resources/docu=
ments/proceedings/2013_mmc_koppe2.pdf
[3] http://web.archive.org/http://www.oertel-halle.de/files/cia99paper.pdf


And I tested with SJW=3Dmax from mcp251x (not the mcp251xfd) with SJA=3Dmax
to a peak USB adapter with SJW=3D1 - the peak adapter fails to receive CAN
frames:

| 5: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode D=
EFAULT group default qlen 10
|     link/can  promiscuity 0 minmtu 0 maxmtu 0
|     can state ERROR-ACTIVE restart-ms 1000
|           bitrate 500000 sample-point 0.850
|           tq 100 prop-seg 8 phase-seg1 8 phase-seg2 3 sjw 3 brp 1
|           mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp_inc 1
|           clock 10000000
|           re-started bus-errors arbit-lost error-warn error-pass bus-off
|           0          0          0          2          2          0       =
  numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 parentb=
us spi parentdev spi1.1

| 97: peakfd0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mo=
de DEFAULT group default qlen 10
|     link/can  promiscuity 0 minmtu 0 maxmtu 0
|     can <FD> state ERROR-PASSIVE (berr-counter tx 0 rx 136) restart-ms 10=
00
|           bitrate 500000 sample-point 0.875
|           tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1 brp 1
|           pcan_usb_fd: tseg1 1..256 tseg2 1..128 sjw 1..128 brp 1..1024 b=
rp_inc 1
|           dbitrate 2000000 dsample-point 0.750
|           dtq 12 dprop-seg 14 dphase-seg1 15 dphase-seg2 10 dsjw 1 dbrp 1
|           pcan_usb_fd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..1024 =
dbrp_inc 1
|           clock 80000000
|           re-started bus-errors arbit-lost error-warn error-pass bus-off
|           0          0          0          1          2          0       =
  numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 gro_max=
_size 65536 parentbus usb parentdev 2-2.2:1.0

|  (1970-01-01 02:41:33.856148)  peakfd0  RX - -  20000004   [8]  00 04 00 =
00 00 00 00 00   ERRORFRAME
|         controller-problem{rx-error-warning}
|  (1970-01-01 02:41:33.857168)  peakfd0  RX - -  20000004   [8]  00 10 00 =
00 00 00 00 00   ERRORFRAME
|         controller-problem{rx-error-passive}

With SJW =3D Phase Seg2 / 2, it works.

> In general the recommendation is to chose SJW as big as possible.
> Here's an excerpt from the CiA 601-3 (Unfortunately I can't share the
> entire document)

CiA 301 and J1939 seem to have a different opinion...=20

> "Recom2: Choose sjwA as large as possible.
> - The maximum possible value is sjwA =3D min(ps1A, ps2A).
> - During arbitration phase, a large sjwA allows a CAN node to resynchroni=
ze quickly on the leading transmitting node.
> - If the CAN controller does not allow configuring the maximum possible s=
jwA
> because the value range for sjwA is limited in the CAN controller, then c=
onsider
> increasing BRPA. This allows configuring a larger sjwA, unless this can i=
mpact
> phase error tolerance in an unwanted way, see Recom4."
>
> I think we discussed this a while ago already and the biggest
> reasoning against maxing SJW was breaking "compatibility" to old
> kernel versions.

ACK

> The compatibility in this is not being able to sync
> though... Now, if a change to a larger default values is agreed upon
> we might as well chose min(phaseseg1, phaseseg2) directly to maximize
> robustness for the user that doesn't set it explicitly. Given that
> most of the getting started with Socketcan results on your favorite
> Search engine don't even mention SJW that's probably a significant
> portion of the users. From a pure communication standpoint I can't see
> any downside to doing this, the only hypothetical case would be if a
> CAN controller had an erratum about higher SJWs and the driver not
> handling it.
>
> So, in essence, I'd propose to use min(p1,p2).

NACK - as I have a setup that doesn't work anymore when mixing an old
and a new kernel.

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--s6nxcslj6in4m26q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMaSRkACgkQrX5LkNig
010BHwgAoHkCRHCtQJpkNU4s7wx6iNDQNL+yMG0MXCGPdhQIZi3jz8nO4tiVYxp/
0Tl4SfQUHJaB/wmI/1TfzvH4/WDqsJMTjz3J6KNLZwQz6wuEQktxlLBM/MDr2hwo
cGRGXQn/GBJqWBR7rVNFHM/7KYk/Fib0o8DgYKpHpT4HfApM6MyJ4ilByckKJTFI
W0GWLDT25wJXXm6/mmVftlqVepKJZSglrjqVkDWLwJ5RNcYMKT2aVBl8nphk3sET
YwyLAjxYcP3yPSlVGw4/oOKo+wSd/yPQ72B92Et4nf6TMUkQY9dcZD+UrRO3CYgy
keeQBjH7VDoinp2phjZl9wqt0Yxy8g==
=X9io
-----END PGP SIGNATURE-----

--s6nxcslj6in4m26q--
