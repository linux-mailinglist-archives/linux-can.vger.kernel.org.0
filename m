Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF10B653E51
	for <lists+linux-can@lfdr.de>; Thu, 22 Dec 2022 11:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbiLVKaj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Dec 2022 05:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbiLVKab (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Dec 2022 05:30:31 -0500
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2061.outbound.protection.outlook.com [40.107.135.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465DD1A214
        for <linux-can@vger.kernel.org>; Thu, 22 Dec 2022 02:30:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LH2MfN93gzuWqVLXUUVT66yumTHkqoOo/Fgc1URXL4dkLuJi9Oev4FbzofaSusLpYSzcGa3v+kdQ/pDoC29e02d3c8A03eGbUIEm/h88Gn1DEFKY8suvShrHPPDkUtaehLg5ADQGGUbl60SSiURurzrXp+hDFcN3C2PZ8+14RPxqF6/xnRa8LW7kffjwyANi9+RQyw70AzPAl3NBcpmgz+00eNwbwRF3Q+C4/24LtGgP+BxkGopr5mgK4kPIfFVUDreHK2R0rp91J0QNWJ47seNdbBltfMWFuEhKSYsAPBEGtfmyV9OPwybZjR+85nLfGopET2eKIDA0JxK3zaX16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjKuwhFBdTD+HC7O1GQVbyzg86TllVI97uAgFEakNGw=;
 b=ePoafqA8FPRoK0kVEr5R1FWUVVy5cwiDOpB+dx5PRqA0F6uHZnCMbUoKxe2iXFZeQ+K68dEsl2ZrtqsIqvzXKiasoOXFaYtgTDuCmUA/fUILaPAw0baDBj5uWGjV8zJIf5Q9iFRG8HdVPlh9ovvmgZIySNVwDeEMUKnesitQc7LaEW3Idmc2Ay48s0wPO0sD5qoqJWAlgo8RxlhewUbkQ52pGjzka5Jt3h1Z+XYfx8mj1fRuMvyMesXoCuiMZC1kadBUib/oSrFq1a8SJF28zHe55JuqZoOJatjy+oS5FqKlt7bJJn3RioCgOcPlilDgy8x8s3C6a4wrT9nrXL0T5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=janztec.com; dmarc=pass action=none header.from=janztec.com;
 dkim=pass header.d=janztec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janzag.onmicrosoft.de;
 s=selector1-janzag-onmicrosoft-de;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjKuwhFBdTD+HC7O1GQVbyzg86TllVI97uAgFEakNGw=;
 b=RXny1XsaIrW/ptR4GDjS30/T7axuQP1i4SUW2fwd+b5thV/iBH9prjhkUD2wpawR0KcEXipruscr9ufWYGKnsOEsYEnrvztHKwZFVsHQ0jtVYM+j+Z73ofITWBTD4g+DbeY3go+OKMVcGnyGJThuiM6TT7nQJNTVS4nkzIetMH8=
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:26::13)
 by FR2P281MB1509.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 10:30:22 +0000
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba]) by FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba%7]) with mapi id 15.20.5944.006; Thu, 22 Dec 2022
 10:30:22 +0000
From:   =?iso-8859-1?Q?Stefan_Alth=F6fer?= <Stefan.Althoefer@janztec.com>
To:     "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: mcp251xfd: Bad message receiption
Thread-Topic: mcp251xfd: Bad message receiption
Thread-Index: AdkV11/b5jjJzAvBRy6q2itnF0vApwACBsqgAAPYs3A=
Date:   Thu, 22 Dec 2022 10:30:22 +0000
Message-ID: <FR0P281MB1966CA0C12ED24574368A36E97E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
References: <FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <PH7PR11MB6498DA4A162106BD4ACB7551FBE89@PH7PR11MB6498.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB6498DA4A162106BD4ACB7551FBE89@PH7PR11MB6498.namprd11.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=janztec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1966:EE_|FR2P281MB1509:EE_
x-ms-office365-filtering-correlation-id: ad33c041-e5cf-456e-a9a0-08dae40787cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PyKMGBclzhGprSBsUm9+XhQmB9Oyj0g6IT7ETMmZSPzIbedW5CncFR0tkCXzKJGk6oc8uE3e+LBZFEyY5uCpC61FOGpJgFNSb3DbKvt2D/VwHXU6s4454JtslZ3+kMjEnyrYLChl4eMi3eGMu6xMI985xvsuF4OsAjFOPZi3a6XvglX/jIwNpen+Viyly+kROukjlTE4k48sp+HyplM/If08uFr/CM8wccz54+FouUcB3U4msMz3tRHMq3/2zuQAvGh/IaI3IJwhAWUQLtB6gXfwCxCt+vfRYTxLf7mw2B6Ej8u1Oo1WzTSGYppeQwO9k1shY8YStgIQj6mvehWi8Q6hbMc/tO7iHnV+7TBqTUrU1MiUps+yVs545uk5UPDXik9wU8a/+KyOme/PoWg6k3rVRRfGBhn7Ylc6TvQg4xNkvqLnD2QS3DdXQKt+ISqKeFwSIkNia6zJ79sK6XQg7B0DhRtrrapwNIZZ7Xl9aXjpNN6EyJbOMu6MWTNM9oZXV8nx0YDrDrX4AqCtybf4IKNlzofi3UfAiWOPoPu9RdilnEJCP/tWW3dqjBVacMTz+2iZr2b4mJyvKRZztayRM2iVQZiK847zxb/Wa0Rs9QUmgRIsNXxFbwigemiZPjKf0zIvuB2fgx6KQXZ2/HcLZMukiSRvZtD/xh97QPcahsGY18CXmpeVQIOkenys9smigVg6GzrgTcZLHMNtsUPpDUzpnHRbuBwWLpr5d4SVNeI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(39830400003)(396003)(451199015)(478600001)(33656002)(7696005)(316002)(186003)(9686003)(76116006)(55016003)(26005)(71200400001)(6916009)(66556008)(86362001)(66476007)(64756008)(66446008)(66946007)(15650500001)(122000001)(8676002)(41300700001)(38100700002)(8936002)(83380400001)(66574015)(966005)(6506007)(38070700005)(2906002)(5660300002)(4326008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ybqzPfMelyamWRtV5YzOmYP2gSuMVWdiobieEEORZJy4bu1kNytAEljBIH?=
 =?iso-8859-1?Q?CO6NOMEaEbjhdUiBqm3Hvwr76R4IKdZ8cZX7crKg3OcvG4Kxga7rc/8rbe?=
 =?iso-8859-1?Q?pRGzKI95Ykltuaw1EyKywpE1HMO1M8gAyp6nHiAauII/NKXyH6nrGEDBQX?=
 =?iso-8859-1?Q?57hVl8z+jT9on2h48HheOfYYOFWt7VRWNKxC6DQmDqKQfOf1rF3hGIWIik?=
 =?iso-8859-1?Q?d524npa4WapaP4ckC15O5mx1+N9D6XhR1i2DdzPgRmL4IZuPFG4aXQ9AWN?=
 =?iso-8859-1?Q?C6yC50iHGL6WAO+M/ccCVsqEpPhLKjfENEHOLyWlq1Bp4idIBwsZN/f/cu?=
 =?iso-8859-1?Q?b4LEGoS1aOzC7h4rpnxU1ANV07s3mF3Vm0uDAUKU1QpchFmVZWSaifh4Gq?=
 =?iso-8859-1?Q?LSBi93aoVrC2yGc4Y9gNXIl1FKtxteMyMTCrENK3Xb3v8UimcyJ4ULgIJ3?=
 =?iso-8859-1?Q?0ibwb84pLsuoj456CqOrqlkG35Nq8GAlg98zNdcyVpZg/jEkxcI14TXfs4?=
 =?iso-8859-1?Q?dzwKyCYmaMD3y4o6zodnf0L1+h1gBEPAuzqXbuP4jET73hfudyMhgozdF0?=
 =?iso-8859-1?Q?UKSIfP05rMgYiHx94ZuZ42UX1Bzb1spNq10KLnK9mF55Y+LxLOKSKKgNrz?=
 =?iso-8859-1?Q?bh6R7Pz1ShMgvRP+aElZ0Mk40g+r4rv4IEMP5dFTtT8VXQhr8iyUeL6HBj?=
 =?iso-8859-1?Q?lzxYOQloggPAmqbIP1wVVIo3rQ2pYWaUF+gozG3/raOHfB3BwJ3Flaj7mj?=
 =?iso-8859-1?Q?vt4y0vpiBdqDf1N8HhlZAPtQ4FG8p9Y5Y+176yTQJp9Sw7YXTiYPSKTkeA?=
 =?iso-8859-1?Q?EX+sH6Kt6J8/pdeHoKCdECAXH/ilGT7pqNBrPjfjBMOK0wmMHQL69/ncXR?=
 =?iso-8859-1?Q?1FC9Hj3j4DwKWGCFTDuV2b4JyDJ6zNRlmvcoEeISpZlmpEyMY/X36KOd8M?=
 =?iso-8859-1?Q?soENHDJfVZ6+M2+0EsN+qrJxXdVuGLn6QvjFx2YUWxBqOhdIF1QIMFG193?=
 =?iso-8859-1?Q?MuhM+U0Jdcfrh61HIl0vBHmLO0qWHgAT03pLJsuuMEpFtfy+++RBCnWscv?=
 =?iso-8859-1?Q?Xm/OEH8lPrHdkh/YJy98K7/HXQNfS+k1t2npk6Dcm51MnmB59IO8doE7RJ?=
 =?iso-8859-1?Q?Zq4354lcNTl5dW98N+Nu4YVAYtXgPFcYR+eyhK12j9DL3DQKrlNgGSSuAx?=
 =?iso-8859-1?Q?+WlgC+q4GuNbwiwk6WLg52xxwMSeoCSD1Ky76C0B+Blo3A3DkWZsa9Sg6D?=
 =?iso-8859-1?Q?2/jn4iuZJNcxH/id6ouicu8g402Mxvjz1y6mr05ST/RMc6D+/ipgnuYBqF?=
 =?iso-8859-1?Q?/aZle8W6SbEJVOvvAKydugb95NfEvZ9A7g5Ua5+F3WVfB3ZlGaqIAx2Q02?=
 =?iso-8859-1?Q?DpqAlCeD5H5JFd+/hVZdvscSjDzE2uihS0qzjHXwhT6L/evj2M+FWtxrvv?=
 =?iso-8859-1?Q?H/5SSGNfA1r0ZBAxV0Aq8R02kbDFCUiSQOHIcH5DbyzJuiSyvPX6jClivl?=
 =?iso-8859-1?Q?fk7JOFLZ179xKExn4flDVtkr3IxrQ8U9cPf4calKjqzhBNBeKQjcRyFSZj?=
 =?iso-8859-1?Q?QckYzO7GtZVTCYC1mYp2LHZvf1VZ9wj0GrFOgXmPI4B7e9hkDwyJ7sG9rc?=
 =?iso-8859-1?Q?yUCbufaZakW4k2Y3nhupcxNOWaq1dAfl1BRZ8HjOknDj5iMWB9u8z7xA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: janztec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ad33c041-e5cf-456e-a9a0-08dae40787cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 10:30:22.0274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c1dae847-7bcf-493f-b143-af65743cbb23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lB6wsQiU0WJRSNlrcZ9imdr6Y418XuMekYtDq8Qsd/wEUsTjKlY14hiUBK9nZ4FmULeb1XrWCx23AULzbePUHJDkODZcAHnEPFpkMAambLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1509
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Thomas,

> Do I read the pdf correctly (based on the /var/log stuff) that you have t=
wo MCP2518FD connected to a Pi4B and=20
> both of them are running in internal/external loopback mode no interactio=
n between them and the SPIs are separate?

Yes. For the loopback test the CANs are separate. Errors also occur when se=
nding messages between
the controllers, but I think that is more difficult to analyze.

root@raspberrypi:~# ip -d -s a s can0
4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP group de=
fault qlen 1000
    link/can  promiscuity 0 minmtu 0 maxmtu 0
    can <LOOPBACK,BERR-REPORTING,FD> state ERROR-ACTIVE (berr-counter tx 0 =
rx 0) restart-ms 0
          bitrate 1000000 sample-point 0.800
          tq 25 prop-seg 15 phase-seg1 16 phase-seg2 8 sjw 6
          mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-in=
c 1
          dbitrate 4000000 dsample-point 0.800
          dtq 25 dprop-seg 3 dphase-seg1 4 dphase-seg2 2 dsjw 2
          mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-=
inc 1
          clock 40000000
          re-started bus-errors arbit-lost error-warn error-pass bus-off
          0          0          0          0          0          0         =
numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
    RX: bytes  packets  errors  dropped missed  mcast
    3097429872 2517466658 0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    3696197680 1258733264 0       0       0       0
root@raspberrypi:~# ip -d -s a s can1
5: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP group de=
fault qlen 1000
    link/can  promiscuity 0 minmtu 0 maxmtu 0
    can <LOOPBACK,BERR-REPORTING,FD> state ERROR-ACTIVE (berr-counter tx 0 =
rx 0) restart-ms 0
          bitrate 1000000 sample-point 0.800
          tq 25 prop-seg 15 phase-seg1 16 phase-seg2 8 sjw 6
          mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-in=
c 1
          dbitrate 4000000 dsample-point 0.800
          dtq 25 dprop-seg 3 dphase-seg1 4 dphase-seg2 2 dsjw 2
          mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-=
inc 1
          clock 40000000
          re-started bus-errors arbit-lost error-warn error-pass bus-off
          0          112256     0          1          3          1         =
numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
    RX: bytes  packets  errors  dropped missed  mcast
    2590649888 773910314 3       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    3442619696 386944310 112254  12      0       0

This is the SPI setup for the dual CAN PI:

dtparam=3Dspi=3Don
dtoverlay=3Dspi6-1cs
# mcp251xfd DTS for RPI4 default CAN on SPI6.0
dtoverlay=3Dmcp251xfd-spi6-0,interrupt_pin=3D25,oscillator=3D40000000
# mcp251xfd DTS for RPI4 CAN extension on SPI0.0
dtoverlay=3Dmcp251xfd,spi0-0,interrupt=3D16,oscillator=3D40000000

Or did you mean something else with "script"?

I'll try the register dump when I suffer the next error ;-)

Mfg
Stefan

-----Urspr=FCngliche Nachricht-----
Von: Thomas.Kopp@microchip.com <Thomas.Kopp@microchip.com>=20
Gesendet: Donnerstag, 22. Dezember 2022 10:07
An: Stefan Alth=F6fer <Stefan.Althoefer@janztec.com>
Cc: linux-can@vger.kernel.org
Betreff: RE: mcp251xfd: Bad message receiption

Hi Stefan,

> I have reduced my test case to a simple single thread self-receipt test:
>     * TX two messages
>     * Wait for RX and send out a new message on every receipt
>     * TX for messages in total
>=20
> Refer to the attached PDF for some error cases. Last send frames are=20
> at the top of the logs. You can see that wrong messages appear in the=20
> RX queue, which have been successfully transmitted in previous test=20
> loop. The data that is actually sent out is correct however (checked=20
> with an external logger for some cases).

Do I read the pdf correctly (based on the /var/log stuff) that you have two=
 MCP2518FD connected to a Pi4B and both of them are running in internal/ext=
ernal loopback mode no interaction between them and the SPIs are separate?
What are your CAN interface settings? Would it be possible to share the scr=
ipt?


> I see infrequent mcp251xfd CRC read errors. I think those are due to=20
> the 2518 SPI errata. However they don't occur at the time when the=20
> wrong messages are received (refer to the PDF).
Correct, this shouldn't be related to your problem.

=20
> - Any suggestion how I can step further in fixing this issue.
One thing would be to dump the RAM i.e. the content of the fifos itself to =
see whether the device actually has the incorrect frames. Marc wrote a tool=
 to dump registers and RAM via debugfs:
https://github.com/linux-can/can-utils/blob/master/mcp251xfd/mcp251xfd-dump=
.c

For this debugfs needs to be enabled and mounted (e.g. $mount -t debugfs no=
ne /sys/kernel/debug)

Now the registers can be dumped like this: cat /sys/kernel/debug/regmap/spi=
0.0-crc/registers

So I'd suggest to abort the script after the first error occurred and then =
dump registers/ram to find the RX fifo in question and check the content.

Best Regards,
Thomas
