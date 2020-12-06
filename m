Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B5E2D02AE
	for <lists+linux-can@lfdr.de>; Sun,  6 Dec 2020 11:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgLFKTP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 6 Dec 2020 05:19:15 -0500
Received: from mail-am6eur05on2117.outbound.protection.outlook.com ([40.107.22.117]:49376
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726356AbgLFKTN (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 6 Dec 2020 05:19:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvMhzSflZbjbDx6d9KrDPOkoJOGOTkMwtQCTVhB0xOLdZJpaagSnA6oKs4Qx70BzuZi21bW4X0vavdwxQYJTGxJI54uqG2EEG1z+8FtojEZkDDAkVGWyddvQj/aonrfJxMnj+cmkV8AkLlp2PNygeTuKFmsTxUfSJvL86ou3KGJ3XhDofXa7q77MNao5NalrCYZpQjJmG956YGxhyQ5r5Fyb5CDZyGwMkjaj6QMzdHak4DErTrhivn6Lhtch2wW2sCPSWx+vuTYz0TgvFmLGe/vB1+oH4HGbybzWZyWDhNNR4AveRtDIPc4/EJ8gdQov0lymf8UxLWVi8oAguZH+Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTRy8C+ZjYDOjRT7vJFEtt6sn7g2DTAGgeeXjg9XEjY=;
 b=jFWV2sqg90m55eKibBJiHsPaX+Vu5gU54XNZjQfnQ8K/XBk1AwivRyFnJLecLh+s1HFGoN3VQXeHHIrB9dTK9vcT9s6/PLxWi7mcsCw6kWOKaLjWoPMd+y8ggDUTfSr/QoWV3XCDZ07jcg4vNWYBEU3LgvEoM/diw7pk9owbv8l6zwk+l0NdXROMm1UZhXlO34KzFhTfwXEhFoYGxhpLiX4xozIxTGJW5huiUB5c4D8riDQswAUiDy37IHNq2SutXmzFTlchNbDp9OvuxfgxUScfBd6+ajJYEQlPE1X5FG+LW52eH7fd8NoVcrOsO0NkifR7qksfdUipJ8JHqRaDBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTRy8C+ZjYDOjRT7vJFEtt6sn7g2DTAGgeeXjg9XEjY=;
 b=lytsCScXwZIQBTPYlIRz77Pvw43VshBr2hXQOCdijMSft2aHVbMYctnMiYWNNQgFaMpQ9a30kd+YkSc7CurRV8YAshGHnQl0gm0Ve+bVX8ln2hXvt7vhu8obgcfcXt54J5gpvBVt+fIS/SXkK/exyxOBo+k7WuUxGPtwNY9yDkc=
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:12d::21)
 by DB6P190MB0247.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:3d::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Sun, 6 Dec 2020 10:18:23 +0000
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::14dd:59d7:acaf:be4a]) by DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::14dd:59d7:acaf:be4a%4]) with mapi id 15.20.3632.023; Sun, 6 Dec 2020
 10:18:23 +0000
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: mcp251xfd No Oscillator (clock) defined
Thread-Topic: mcp251xfd No Oscillator (clock) defined
Thread-Index: AdbLuKAjW6Ey/8Z7T1qzpJx8c3rFuw==
Date:   Sun, 6 Dec 2020 10:18:23 +0000
Message-ID: <DB8P190MB0634231494D3D788E87DCE54D9CF0@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=schleissheimer.de;
x-originating-ip: [62.153.209.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31525c6e-7a60-4754-6d83-08d899d04345
x-ms-traffictypediagnostic: DB6P190MB0247:
x-microsoft-antispam-prvs: <DB6P190MB024764CCAF493E40B2FAF283D9CF0@DB6P190MB0247.EURP190.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TSpUIxkeo6Ji8Y8Oa5GTj1mKW/+dRDWm/UT1j2r0fqO1seoHkon+yOGBMDi/Fugzl4jPQ1ufgjwvKBejcgN9pasQvsptknyzA7JC4AQYrlKIeVijnJd6EKNg04zJKsLSE+RJJJ/75b4/ymBr5vj691q/LPm/mgCNXq7uL84P37qSxYucMLHrO/jibzITlrFcVtJa5o0fRLoUIXlx1iuAQXG41j+AVWfUKQAGI7E4muQwGP+bRSnom+cte36Rn9d1/B/i8fqa7CnvyVbKJDiSq4ovapBCIaDQvwha94pv5Ej8dZ+ItVrkqGFfHJzwhUakcqZltFBfOp0Lr2ITI1jzzMSWS4vXHgecDqYzxVyQDf3WgI3HXXCyKBJWEwkV9HJU7fkD29WfnrPGta62jesnjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P190MB0634.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39830400003)(376002)(346002)(966005)(316002)(5660300002)(8676002)(71200400001)(8936002)(6506007)(6916009)(26005)(186003)(478600001)(76116006)(7696005)(64756008)(55016002)(9686003)(66946007)(45080400002)(66476007)(83380400001)(2906002)(66574015)(33656002)(66446008)(52536014)(86362001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?/ItVay/w4hlEvHBWmFOjSUJf+RC7ypbKRR8KQ0cMCUj6YK70tDG0TuMZWk?=
 =?iso-8859-1?Q?x/2hhIUvubDwYby74T4C8OgT+VNma/6hp442jne6uzRuCId52XB8fcLOvz?=
 =?iso-8859-1?Q?k2qUf/N4dIQ+j1c2KdxKf2Cw3LvmUkj6aMaTKV0ANnnkT3AxRf3jSVEX8p?=
 =?iso-8859-1?Q?o6pUTPfq19ccZb3fNyWkHZJzvdaY2FQM194LT3u3VtuFNRMCxdgxjdczZV?=
 =?iso-8859-1?Q?gw2aVGFba2MTVJumwslHUPF2x5oY9zJRaF6addh76ug1cPkdh87xHgvM2C?=
 =?iso-8859-1?Q?6g/fJ5ixaX6Eez8+9rFSAYYYs7QkaylYlXhLwrlyk/vjkvBNBlAYbgfK/z?=
 =?iso-8859-1?Q?EXmzmvQCIZmugelo/zpWx8QshuzNaYfTDbLOAY10GKdZ+dK+wnT5REcyJf?=
 =?iso-8859-1?Q?ImvTdCSA2ZRYMfu4+B9apC0IiXeuSYHW9cIr+k4F8vbw7hlYSvv/mrm7Y5?=
 =?iso-8859-1?Q?eZ0u5SBAEYbaYZmeSrec2/joajbBcQqz0rqj20WoV2hWBuBvWKVVH74q7R?=
 =?iso-8859-1?Q?7AWeNzskPj2FuYQTWDXBHMIUb0xgGsZCGBWLLC84BufrV7ta49sXgviygp?=
 =?iso-8859-1?Q?2IVEBDLAMVF3tiDFk06reLgL2/PRHPW6P8TAh9BkXbN0bhMzx9f2fLt6N5?=
 =?iso-8859-1?Q?RzaKZsTfFHnnB0ptln26hxmA6g33aGgi7tq9hCiu8udXNxWDYSdi4LZFFF?=
 =?iso-8859-1?Q?ZqjRN8JcMAWH/mcLBLKdRrCrKKsgrzA8A7RFLWspAaWEXPuVTOMHfhjnzo?=
 =?iso-8859-1?Q?tXy5Z+DfN1vObe52CMrWZqdRm87xRlYs+9hRWrJuP0NiP1OD269Z62g7QA?=
 =?iso-8859-1?Q?u0Dz9uNMd6iNTqh+Rb7aLFCpXrKImStHgRu2eAjKIotGAu9ZGUv3S/SgVk?=
 =?iso-8859-1?Q?YkcL3Mu7kEeSHoxs1B/YbwhLM9Uw39+5b/VKe/s3TGU4N0aj4JOU1DYFyL?=
 =?iso-8859-1?Q?1yTEsryTfhpjlSslV6lMrwObs79MmjMgUY7J/tsR+3qnkMaIUqImacPLoG?=
 =?iso-8859-1?Q?QvspxgBLLXG5yoDNk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 31525c6e-7a60-4754-6d83-08d899d04345
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2020 10:18:23.3158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZWunLeNgkJTDlhGbXinJKVtErJir/CKZWxmrckniIqBV+36qDbH60Ry6Zu24Ac6/geKV2oqGI+HhX+ZHlJuKBfmt+VPkKTaBMJU0JTf2Ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6P190MB0247
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,
I am new to the list so sorry for any errors.

I want to get Seeed "2 Channel CAN BUS FD Shield for Raspberry Pi"=20
https://wiki.seeedstudio.com/2-Channel-CAN-BUS-FD-Shield-for-Raspberry-Pi/
get to work on a Raspberry Pi Compute Module 4 IO Board
https://www.raspberrypi.org/products/compute-module-4-io-board

I have installed the Raspberry Pi OS with Raspberry Pi Imager

$ uname -a
Linux raspberrypi 5.4.79-v7l+ #1373 SMP Mon Nov 23 13:27:40 GMT 2020 armv7l=
 GNU/Linux

without any changes. Therefore I tried the following commands to load the o=
verlay=20

$ sudo dtoverlay spi0-1cs cs0_pin=3D24
$ sudo dtoverlay mcp251xfd spi0-1 oscillator=3D40000000 speed=3D20000000 in=
terrupt=3D18

then dmesg shows me this:
[  175.674317] spi spi0.1: setting up native-CS1 to use GPIO
[  175.733692] CAN device driver interface
[  175.737453] mcp251xfd spi0.1: No Oscillator (clock) defined.

Can anyone help me to setup the Oscillator?

I already tried to enable "dtparam=3Dspi=3Don" in /boot/config.txt but this=
 does not change anything.

I also tried the second CAN interface to run on SPI1 with
$ sudo dtoverlay spi1-1cs cs0_pin=3D12
$ sudo dtoverlay mcp251xfd spi1-1 oscillator=3D40000000 speed=3D20000000 in=
terrupt=3D22

but then kernel seems to crash

[  226.615817] ------------[ cut here ]------------
[  226.615842] kernel BUG at mm/slub.c:4010!
[  226.615860] Internal error: Oops - BUG: 0 [#1] SMP ARM
[  226.615878] Modules linked in: spi_bcm2835aux mcp251xfd can_dev binfmt_m=
isc sha256_generic libsha256 cfg80211 rfkill 8021q garp stp llc spidev rasp=
berrypi_hwmon vc4 cec drm_kms_helper v3d gpu_sched bcm2835_codec(C) drm snd=
_soc_core snd_bcm2835(C) bcm2835_isp(C) drm_panel_orientation_quirks bcm283=
5_v4l2(C) snd_compress v4l2_mem2mem bcm2835_mmal_vchiq(C) videobuf2_dma_con=
tig videobuf2_vmalloc snd_pcm_dmaengine videobuf2_memops videobuf2_v4l2 vid=
eobuf2_common snd_pcm snd_timer syscopyarea snd sysfillrect videodev sysimg=
blt rpivid_mem fb_sys_fops mc vc_sm_cma(C) spi_bcm2835 uio_pdrv_genirq uio =
ip_tables x_tables ipv6
[  226.616079] CPU: 0 PID: 631 Comm: dtoverlay Tainted: G         C        =
5.4.79-v7l+ #1373
[  226.616101] Hardware name: BCM2711
[  226.616131] PC is at kfree+0x240/0x290
[  226.616154] LR is at free_overlay_changeset+0x84/0xa8
[  226.616172] pc : [<c03f5fa0>]    lr : [<c08ff00c>]    psr: 40000013
[  226.616191] sp : d6e8ddb0  ip : d6e8dde0  fp : d6e8dddc
[  226.616208] r10: c1204fc8  r9 : d7047a00  r8 : d7047a00
[  226.616225] r7 : d61b8000  r6 : c08ff00c  r5 : 00000000  r4 : dc0e5280
[  226.616244] r3 : c12a11a8  r2 : 00000030  r1 : 00000000  r0 : d61b8000
[  226.616264] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 user
[  226.616284] Control: 30c5383d  Table: 17047600  DAC: fffffffd
[  226.616304] Process dtoverlay (pid: 631, stack limit =3D 0x8d6d8885)
[  226.616323] Stack: (0xd6e8ddb0 to 0xd6e8e000)
[  226.616341] dda0:                                     dc0e5280 00000002 =
d6e8ddf4 d7047c40
[  226.616367] ddc0: d7047c40 ffffffea d61b8584 d7047a00 d6e8ddf4 d6e8dde0 =
c08ff00c c03f5d6c
[  226.616392] dde0: d7047c40 d61b8000 d6e8de6c d6e8ddf8 c08ffbd8 c08fef94 =
00000000 c03f734c
[  226.616416] de00: d7047c44 c1204fc8 d7047c40 d7047c60 c12927f4 c1368484 =
d682503c c0e40498
[  226.616441] de20: d6158000 ffffffea d6825000 d61b8000 d6158174 d6826000 =
f0851000 449c3aea
[  226.616466] de40: d7047700 00001862 d6825000 d6824000 00000000 d7047700 =
00000008 d41ba4c8
[  226.616491] de60: d6e8de8c d6e8de70 c08f8fa8 c08ffac8 d6ce6380 d6fc4b40 =
d41ba4c8 d7047704
[  226.616516] de80: d6e8deb4 d6e8de90 c04ac400 c08f8f50 d6fc4b40 d41ba4c8 =
000d801e ef97a610
[  226.616540] dea0: d55382a8 00000008 d6e8def4 d6e8deb8 c040e3e4 c04ac384 =
00000000 00000000
[  226.616565] dec0: c020ce54 d6fc4b48 d682d170 d6fc4b40 00000000 d682cc40 =
d682d19c c12b9d54
[  226.616590] dee0: d682d170 c1204fc8 d6e8df04 d6e8def8 c040e59c c040e34c =
d6e8df2c d6e8df08
[  226.616614] df00: c02433f8 c040e590 ffffe000 d6e8dfb0 c02011c4 00000004 =
fffffe30 5ac3c35a
[  226.616639] df20: d6e8dfac d6e8df30 c020ce54 c0243350 d6e8df4c d6e8df40 =
5ac3c35a c1204fcc
[  226.616664] df40: d6e8df6c d6e8df50 c0407de8 c040eb18 00000003 d6864800 =
d686484c 00000000
[  226.616688] df60: d6e8df94 d6e8df70 c042fcc0 c0407d84 00173198 b6ecbb1c =
00000000 449c3aea
[  226.616713] df80: c02011c4 00173198 b6ecbb1c 00000000 00000006 c02011c4 =
d6e8c000 00000006
[  226.616738] dfa0: 00000000 d6e8dfb0 c0201034 c020c8cc 00000000 00000444 =
b6ecb6d8 b6deb864
[  226.616762] dfc0: 00173198 b6ecbb1c 00000000 00000006 001743a0 00000000 =
00000000 00174268
[  226.616787] dfe0: 0000006c bed894d0 b6ded088 b6e50f74 20000010 00000003 =
00000000 00000000
[  226.616807] Backtrace:
[  226.616833] [<c03f5d60>] (kfree) from [<c08ff00c>] (free_overlay_changes=
et+0x84/0xa8)
[  226.616859]  r8:d7047a00 r7:d61b8584 r6:ffffffea r5:d7047c40 r4:d7047c40
[  226.616886] [<c08fef88>] (free_overlay_changeset) from [<c08ffbd8>] (of_=
overlay_fdt_apply+0x11c/0x990)
[  226.616909]  r5:d61b8000 r4:d7047c40
[  226.616932] [<c08ffabc>] (of_overlay_fdt_apply) from [<c08f8fa8>] (cfs_o=
verlay_item_dtbo_write+0x64/0xa4)
[  226.616958]  r10:d41ba4c8 r9:00000008 r8:d7047700 r7:00000000 r6:d682400=
0 r5:d6825000
[  226.616980]  r4:00001862
[  226.617004] [<c08f8f44>] (cfs_overlay_item_dtbo_write) from [<c04ac400>]=
 (configfs_release_bin_file+0x88/0xb0)
[  226.617030]  r7:d7047704 r6:d41ba4c8 r5:d6fc4b40 r4:d6ce6380
[  226.617055] [<c04ac378>] (configfs_release_bin_file) from [<c040e3e4>] (=
__fput+0xa4/0x244)
[  226.617081]  r9:00000008 r8:d55382a8 r7:ef97a610 r6:000d801e r5:d41ba4c8=
 r4:d6fc4b40
[  226.617108] [<c040e340>] (__fput) from [<c040e59c>] (____fput+0x18/0x1c)
[  226.617129]  r10:c1204fc8 r9:d682d170 r8:c12b9d54 r7:d682d19c r6:d682cc4=
0 r5:00000000
[  226.617150]  r4:d6fc4b40
[  226.617174] [<c040e584>] (____fput) from [<c02433f8>] (task_work_run+0xb=
4/0xd4)
[  226.617202] [<c0243344>] (task_work_run) from [<c020ce54>] (do_work_pend=
ing+0x594/0x59c)
[  226.617227]  r9:5ac3c35a r8:fffffe30 r7:00000004 r6:c02011c4 r5:d6e8dfb0=
 r4:ffffe000
[  226.617254] [<c020c8c0>] (do_work_pending) from [<c0201034>] (slow_work_=
pending+0xc/0x20)
[  226.617276] Exception stack(0xd6e8dfb0 to 0xd6e8dff8)
[  226.617294] dfa0:                                     00000000 00000444 =
b6ecb6d8 b6deb864
[  226.617319] dfc0: 00173198 b6ecbb1c 00000000 00000006 001743a0 00000000 =
00000000 00174268
[  226.617343] dfe0: 0000006c bed894d0 b6ded088 b6e50f74 20000010 00000003
[  226.617365]  r10:00000006 r9:d6e8c000 r8:c02011c4 r7:00000006 r6:0000000=
0 r5:b6ecbb1c
[  226.617386]  r4:00173198
[  226.617405] Code: 1a000003 e5943008 e3130001 1a000000 (e7f001f2)
[  226.617428] ---[ end trace cd616810d13be5e4 ]---

Sven =20

--
Sven Schuchmann
Schlei=DFheimer Soft- und
Hardwareentwicklung GmbH
Am Kalkofen 10
61206 Nieder-W=F6llstadt
GERMANY
Phone: +49 6034 9148 711
Fax: +49 6034 9148 91
Email: schuchmann@schleissheimer.de
