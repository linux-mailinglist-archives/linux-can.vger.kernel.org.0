Return-Path: <linux-can+bounces-1567-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A63E19876B7
	for <lists+linux-can@lfdr.de>; Thu, 26 Sep 2024 17:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF921F250C5
	for <lists+linux-can@lfdr.de>; Thu, 26 Sep 2024 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EFD14D6F6;
	Thu, 26 Sep 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="diax/OwG"
X-Original-To: linux-can@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022129.outbound.protection.outlook.com [40.107.149.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4201D14831C
	for <linux-can@vger.kernel.org>; Thu, 26 Sep 2024 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365344; cv=fail; b=d31VdmQ/kP2FYE11rTAlD5bqxiYFzN2FXtcecB/Z+Cp3xCY8MvfYX6mMGEaWuk0ocDTsOVGJZ9HX9p3OId1RMpLnEcmJfMdDbL21EA68+du5xhYPnXxBJPBb9ELazQDaslOGUq6FYZK8zzUYk3/0QroAJmUFrRTZmCotvY+nEiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365344; c=relaxed/simple;
	bh=4afV3CvyBzD1Yibo+qJcZh/+CygujxnojClnqHUe594=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HKtYwqVnnG18LiAcCpwWNpLWw4jkBsagsF3yTIEohJSVJEyuPgDbezT7m1S1QROLDf8S/Y5/yo14Hm0Emkdf5/0xL4wkP15a5HRW5SATsGq/9Q2Qrhdmfb1bn4Nhf/fVt4d0l0u8mhyMCSCErpiu2q6zbQ1N2OmbsLFfaNK2vwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=diax/OwG; arc=fail smtp.client-ip=40.107.149.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1xQ4t3TRVz2vayFVP3Wg/ik6tTsTcPc4ne37PcFDDzJ3479QNzNGGMysqAoSzqnonQuTFcKpwqrcY+Ka52O7bJOk2cWwn9CIco61MZj7e8VwrkoeDryMbhyykZFIaD+1OvXZaWxgglozFEyCrzu2uJdm9J5X4UxImFkHbQmp52WojzSybp3pGLSSAgNXA3Vv4grICvTRe6AeMzjom8aBCw/8Ynz5rDw8NolEte1ovarO6qw7A/iRbFHOeyV5nQMZg60xMV7A4MuH+OnJ9rj25DmEHPoB62VamKHjSAdQ4ArLX7dWaGh1fis1l+P8gifph2LHzDX2G4/ydL9BYwS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKPeQ5H7jmUXW5RXaLOj3H4loON0qn3PbMUmXdkkUy8=;
 b=p91fC5pS2tqzK8iwsQIEi/vbNpOXeLxIhft9PMNsIm5PN3K8woXaLdURHA9xvNDQ1yGXllxLmJzMdhml5aQE5WTr8cjpCNQpmyTxMAdo2ca6SJa3EFHQvmoqbmp4JLv1g8Lsz7Jspc0JlaFx2Z9lO5V+WOULMA8FIYkdM7aebvQOfZehv2CG/DkjAe2WBOUAKv3nymVLd2nhJeFk61ylIEGZ/pHZnooEqyD5VJYWUmkwzzzg5moZxYUnMl2q0dBAycfPaiLG3m89tZYqqKAhQnC/VXQ6k1AiK0qdvo+ukolLV9c3n+un39GJ3lnnY7JdOtH+M3Tc4pwwsRVEaHIKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKPeQ5H7jmUXW5RXaLOj3H4loON0qn3PbMUmXdkkUy8=;
 b=diax/OwG6w+oEvQctMiFESnDYfW25B0J3p12UqFLr5ah31HCOJl3Fj+ZwMtBskcq3z6vZ3UJNChcw+17PsR4IXNW3H+zX6p1NTyQoHg9lDs1CG6LW72AbT/5MxZ2a2e/w/Y4lLRDiA6mzQctJ+YHezO1UPJJLriUWl/bbETG2m8=
Received: from FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6d::6) by
 FR0P281MB1434.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:81::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Thu, 26 Sep 2024 15:42:17 +0000
Received: from FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fba4:515d:ba88:16dd]) by FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fba4:515d:ba88:16dd%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 15:42:17 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: IRQ handler mcp251xfd_handle_tefif() returned -22
Thread-Topic: IRQ handler mcp251xfd_handle_tefif() returned -22
Thread-Index: AQHbDxyIwLNmNNZaPEKJQg5t9sHOZbJokYSAgAGdlPs=
Date: Thu, 26 Sep 2024 15:42:17 +0000
Message-ID:
 <FR3P281MB15522178FE612C6B5B728C2BD96A2@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
References:
 <FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM>
 <20240925-simple-nondescript-porcupine-d66a23-mkl@pengutronix.de>
In-Reply-To: <20240925-simple-nondescript-porcupine-d66a23-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1552:EE_|FR0P281MB1434:EE_
x-ms-office365-filtering-correlation-id: 3839011c-8fdc-404d-f9a6-08dcde41cd50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?c8pH4Dy9v3jBrY8jsH0BBuLMKPF11mdGFZA0hV3ypjwrCS5PkmlTBMExKD?=
 =?iso-8859-1?Q?9OalWpG3PWpz3LRi0RbXkx0lhZ7fDS70C/UmdjqUT9oXVmnNEsMDwV0nlI?=
 =?iso-8859-1?Q?/i2bDpR3/MhVMmQ10Q1BUAfJLtE6+5LTkQkSd1yjAlia05KXCi+/UkKQBu?=
 =?iso-8859-1?Q?OR91/aaDMLY6vsTBP/wn8TinmfjNW4UqorcwXo39MRDkkEl6VUze4/47xw?=
 =?iso-8859-1?Q?9ZMR36eyFEJTn8JUpIKz1t9Y201tJ67FtSpHbKXaYssWYalFPg/sVKQHga?=
 =?iso-8859-1?Q?b/+Hu6xhslcnP6OPvfIFrNqZGdrUSynyfhQdGN0UyS9Dcwb9RUlnW8z4rV?=
 =?iso-8859-1?Q?l4cNfBbENk9RvwVSTGQxTTn7nNfidPjeVc2KTfn4E/DzFulG8gGGa1BBjj?=
 =?iso-8859-1?Q?rL8W/ZOZL5J37judOLo3ieyVSQ8MwtZOvwfh93UwYq835DVEo5iOqelhTk?=
 =?iso-8859-1?Q?CGKiJBcPm+FP4kVL0XMSeLmnyZpmaJWaDrhOXDW9xHRzpNQ3j7f5+96shQ?=
 =?iso-8859-1?Q?6u60S66vYbuWBAXTDKssViYcUdhvxzvAhLkQePwfyLkFeljGTeIpdQanod?=
 =?iso-8859-1?Q?ES34hw++uuUGgAtjUUwJym45T08237zGyNyWMXkKDg1qO7BMJVh/QyqEbR?=
 =?iso-8859-1?Q?cbbcwtumfgS3iJo7VBZ7ddLpMLbT0QQqlqI/Z+BxTFarzhbKhLeJYrKPBK?=
 =?iso-8859-1?Q?QF9s4Nw4yBH2iuFrPfOQPqYQlG9jEuZvd9q49KmA3Es9oogTTiJC4F8KnI?=
 =?iso-8859-1?Q?emFhaF1G7xBcribGsJ8oyUcyfKr0BrxzCdePcuylF56YtwynwcXNZE3jfi?=
 =?iso-8859-1?Q?H9MWGcfECfvxEFOWFmrIx4OdyC+Ibb/LudqWQJkaYM1whrVtwbEIlz2J4D?=
 =?iso-8859-1?Q?m5/UgNVLW9ghshNn/UtMLh8mXpkDRG3x2qsIy/AHkHaPs1BdRDCyMHealX?=
 =?iso-8859-1?Q?gC++BzD3MvwA5gRcS2xGU2miMwCWtZxTPwquUb8UWyhkc2eJJAzcOvHnO4?=
 =?iso-8859-1?Q?nlZUawAlrW1ddBrMm8F7x1AiKap59xRtI8fIu9BrobM0vYANcOIAQtcXtc?=
 =?iso-8859-1?Q?03JvX5V2kLDwTbzMiUukMGG7Sq1wpb4ehmq1waI3CZKeXryXc5Iqy+kxBu?=
 =?iso-8859-1?Q?GlJ5RrlVib0UHO2bJx07tEsj8eg1tQWyv6xrJpZ8DQmO+cdebZRix3fLNY?=
 =?iso-8859-1?Q?PYBcRs6Krb16vpsCXkjNFw4fyoi2HWocmevDI2xs3rhw7U5gHo3PLhejdM?=
 =?iso-8859-1?Q?spr27NIsEDUEzlD+YgYaYR1TIVKXWExIR9vP7mbyGfCQTnQH5Kx+/4SYN+?=
 =?iso-8859-1?Q?Xh1iLsoMRP59P1/jkme8s3WA8Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RTJRwiLR7QMx3sWIi0kWwyzrdZ5szPYB4kTyuQxawRfZZFtfqZPfhvqdQ8?=
 =?iso-8859-1?Q?HK6+QruKFFfQzwbNfjjRgkuPsnjKRqU0COJjeOaHWcUu/4SgZl3tNf3yy6?=
 =?iso-8859-1?Q?LrvKihCBjDBgD1orHgrk9VMBNTJIy/VhXq0CZIIBrPWKxVNNPqgIBP8PXS?=
 =?iso-8859-1?Q?2kCdPps9dv3HPNlcXhHRnBec38ndrWyyRpMZqkj1IEVIuyaoNI7VHJRJi6?=
 =?iso-8859-1?Q?Nc6O/btMQqESniPT/ElYD7r4KHVLlvnJbdpL8Q34iVHHqkXBNINkiH8l0V?=
 =?iso-8859-1?Q?MJYYRny6+qNTV4Ur8pnUrTKuPYNjyqNvn1V+DeErRUkcJd2tD4oriOYPjQ?=
 =?iso-8859-1?Q?aMbTPi7MlsDNHlMnhWT9c1G0oQH9ZlBe8/MUOReKesnq7n2K3g7rtgXelM?=
 =?iso-8859-1?Q?OIsMIDXyPJCXiYLBImFqBDdjOGRs7raMGeAg1D+BnPr5fVR4nwHG+w353B?=
 =?iso-8859-1?Q?m6fdNuv6Yb+FqA8+tahrcRZ0KuvZj/bZYN21zfVEhH9sKHlkvALIxOGiGG?=
 =?iso-8859-1?Q?3iGSK16/7KNlCXosNY8vS1PuZ3NVvzcz/1J44BZ+KvTPQetRnHUl37AwS+?=
 =?iso-8859-1?Q?p59bFWWQFcaCPelwrdrg4h4UYDg5C0tURP2Xs43tOM9I4r6k2D7UlYT/0X?=
 =?iso-8859-1?Q?n6n94KS9DBX4HbjdyvT/MMVjfZ9rL+pc3eRQu9yZhKxZ6Ct7WNzSm+lIUM?=
 =?iso-8859-1?Q?7XLw4k7Q3Bxk/9kkJbYzJTR1NpKfe7X74w38mLe2CwKzmb2+o1VclS0Xun?=
 =?iso-8859-1?Q?Aop0KuIvAEJuM3gHLvj8gUYmSarJR+WAOF+2m+BxqNyRlZaeeFVoGKUSqc?=
 =?iso-8859-1?Q?HzdGhmRMqTidccMNDtJGjnlYMBVUlddAdKhS+hOmEb8VmL90KC3IJhioLa?=
 =?iso-8859-1?Q?s/qr25zSirI5kpcnNKnlUWARCRH2R68cLzmzf410FEkZqFHsdnbBJPmQwi?=
 =?iso-8859-1?Q?KK2vCQ135u+hlJJq7l/ZI6bkG4NYA/aaC34je+TbyXtB6pUJpLuNPnr6SC?=
 =?iso-8859-1?Q?p9UcNq4HvxgilW4qDPyr6ju5F02sUh+8wzzP5Tazqq6rHocQ03E7YEasYX?=
 =?iso-8859-1?Q?vP3en7MtYCdxXV2iT0rwXPtRBXe/Ti2pwF/91Q3PxphZCX1Dlq2Fadjkdt?=
 =?iso-8859-1?Q?i8AWiTVKp8kr/zFNV6GKsh2asa24FDRVK7z1MOZf118AQIF4cqH7lLhM4O?=
 =?iso-8859-1?Q?Otf2kCLlXTYoTNQ7AgAnjMcGsjiyK49mABJWT5oyu2Tglq0zEPeb6HVUL2?=
 =?iso-8859-1?Q?+MGDnRbS3arau2a7ZOt2DjafDPW+w4KKY6+66+z6NcUQS5Fk232yx13Qi5?=
 =?iso-8859-1?Q?bIOm53msqNxvrnbDk+3tm0apRmm8MN00IIz5a0RzWYtFsHGOR6yeEVj2xI?=
 =?iso-8859-1?Q?f/xWWwNVv0kMmjlLw0N1pfxVtVKJbxO9bpfWWLQm9I80n/wbJkFa+LvnAR?=
 =?iso-8859-1?Q?SvXEtQdzjDClUPBpW/gIc9qD3Eq/39gP6XH60f6QIkv+ejbVgGCKyqc3Ym?=
 =?iso-8859-1?Q?fu/GBSJJL+KesauCMXvpk/ud/DFxZgi96QYAoQwGsMdwlZBlzJxXFuQhjB?=
 =?iso-8859-1?Q?Z9xv4ABKAEkt1j1j7nm9l53OJhFbhO60T3vvER8a3nRZGjcFStaEJwbAhE?=
 =?iso-8859-1?Q?9mD0ht9GFYJcJCqH3SB0MYdSSiHoC9UhLiai/S1b+yk2D/qgyv6OTJMw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3839011c-8fdc-404d-f9a6-08dcde41cd50
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 15:42:17.8138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozt2BXYHh/UJaJTRjCAECtsOdLeuWZCxaTbJGYnFYuTzxcWS8H8VxOFgg+m+0K0J7+2NiGUOnMgNOo9ZvoKfjYOWGV5vvev1i+Lt9E1O4/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1434

Hello Marc,=0A=
=0A=
just a short update on this. We are using the Raspberry Pi Kernel.=0A=
So I tested with Kernel 6.6.45 which is:=0A=
https://github.com/raspberrypi/linux/tree/209e8a3e6646f25abb352fd5a8a4c2e85=
5b1e952=0A=
and over there, there is no problem (IRQ handler mcp251xfd_handle_tefif() r=
eturned -22).=0A=
=0A=
My Initial finding was in Kernel 6.6.47:=0A=
https://github.com/raspberrypi/linux/tree/8beb6891489c3c99618a7390578109aad=
fdf8901=0A=
So it seems that one of these introduced the problem:=0A=
https://github.com/raspberrypi/linux/commit/1333fd55d12edf973b72010c63bfe6b=
334c76b49=0A=
https://github.com/raspberrypi/linux/commit/759822a3300cff86d8ea5391173dd55=
7b2d1c7e3=0A=
=0A=
Now I tried to add the debug stuff you suggested and for that I used todays=
 kernel which is 6.6.51=0A=
https://github.com/raspberrypi/linux/tree/0fb3c83a9fa3011cb735ec011b7582d47=
49957b2=0A=
=0A=
But with this one I get:=0A=
[ 2028.554168] Unable to handle kernel NULL pointer dereference at virtual =
address 0000000000000000=0A=
[ 2028.569440] Mem abort info:=0A=
[ 2028.572479]   ESR =3D 0x0000000096000005=0A=
[ 2028.576432]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits=0A=
[ 2028.583165]   SET =3D 0, FnV =3D 0=0A=
[ 2028.586269]   EA =3D 0, S1PTW =3D 0=0A=
[ 2028.589540]   FSC =3D 0x05: level 1 translation fault=0A=
[ 2028.596251] Data abort info:=0A=
[ 2028.599356]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000=0A=
[ 2028.605216]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0=0A=
[ 2028.610617]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0=0A=
[ 2028.616241] user pgtable: 4k pages, 39-bit VAs, pgdp=3D00000000e8e25000=
=0A=
[ 2028.627701] [0000000000000000] pgd=3D0000000000000000, p4d=3D00000000000=
00000, pud=3D0000000000000000=0A=
[ 2028.638875] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP=0A=
[ 2028.645160] Modules linked in: can_raw can xt_nat xt_tcpudp veth xt_conn=
track xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo xt_a          =
            ddrtype nft_compat br_netfilter bridge stp llc nft_reject_ipv4 =
nf_reject_ipv4 nft_reject nft_ct nft_masq nft_chain_nat nf_tables nfnetlink=
 n                      f_nat_h323 nf_conntrack_h323 nf_nat_pptp nf_conntra=
ck_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_sip nf_conntrack_sip nf_nat_ir=
c nf_conntrack                      _irc nf_nat_ftp nf_conntrack_ftp nf_nat=
 nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 overlay ina2xx_adc kfifo_buf in=
dustrialio leds_lp50xx mcp                      251xfd ina2xx led_class_mul=
ticolor can_dev rtc_bq32k regmap_i2c dp83tc811 brcmfmac_wcc brcmfmac brcmut=
il cfg80211 binfmt_misc rfkill bcm2835                      _v4l2(C) bcm283=
5_isp(C) bcm2835_codec(C) rpivid_hevc(C) bcm2835_mmal_vchiq(C) dwc2 i2c_mux=
_pinctrl v4l2_mem2mem snd_bcm2835(C) videobuf2_vma                      llo=
c snd_pcm videobuf2_dma_contig videobuf2_memops snd_timer videobuf2_v4l2 ra=
spberrypi_hwmon videodev i2c_mux snd videobuf2_common vc_sm_cm             =
         a(C) mc spi_bcm2835 i2c_bcm2835 raspberrypi_gpiomem=0A=
[ 2028.645357]  spi_bcm2835aux gpio_keys nvmem_rmem uio_pdrv_genirq uio drm=
 fuse drm_panel_orientation_quirks dm_mod backlight ip_tables x_t          =
            ables ipv6=0A=
[ 2028.748326] CPU: 1 PID: 2977 Comm: ip Tainted: G         C         6.6.5=
1-genipi-v8+ #1=0A=
[ 2028.756329] Hardware name: Raspberry Pi Compute Module 4 Rev 1.1 (DT)=0A=
[ 2028.762763] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)=0A=
[ 2028.769721] pc : timecounter_read+0x20/0x80=0A=
[ 2028.773905] lr : mcp251xfd_ring_init+0x1a0/0x500 [mcp251xfd]=0A=
[ 2028.779575] sp : ffffffc08195b420=0A=
[ 2028.782881] x29: ffffffc08195b420 x28: ffffff8064e6a000 x27: 00000000000=
00001=0A=
[ 2028.790018] x26: 0000000000000000 x25: ffffff8064e6a040 x24: ffffff80420=
d2940=0A=
[ 2028.797154] x23: 0000000000000000 x22: 0000000000000430 x21: 00000000000=
00001=0A=
[ 2028.804289] x20: ffffff80420d0940 x19: ffffff80420d38b0 x18: ffffffc0814=
53d78=0A=
[ 2028.811425] x17: 0000000000000000 x16: ffffffda4b153b58 x15: 0000007f600=
20fff=0A=
[ 2028.818560] x14: 0000000000000001 x13: 0000000000000000 x12: 00000000000=
00000=0A=
[ 2028.825694] x11: 000000000000010a x10: 0000000000000001 x9 : ffffffd9d00=
2ea30=0A=
[ 2028.832829] x8 : 0000000000000001 x7 : 0000000000000000 x6 : 00000000000=
0000a=0A=
[ 2028.839963] x5 : 0000000000000001 x4 : ffffffd9d00329c8 x3 : 00000000000=
00000=0A=
[ 2028.847098] x2 : 000000000000005c x1 : 0000000000002f70 x0 : 00000000000=
00000=0A=
[ 2028.854233] Call trace:=0A=
[ 2028.856673]  timecounter_read+0x20/0x80=0A=
[ 2028.860506]  mcp251xfd_ring_init+0x1a0/0x500 [mcp251xfd]=0A=
[ 2028.865823]  mcp251xfd_chip_start+0x234/0x2a0 [mcp251xfd]=0A=
[ 2028.871224]  mcp251xfd_open+0x94/0x2a8 [mcp251xfd]=0A=
[ 2028.876016]  __dev_open+0x120/0x218=0A=
[ 2028.879502]  __dev_change_flags+0x194/0x218=0A=
[ 2028.883680]  dev_change_flags+0x2c/0x80=0A=
[ 2028.887511]  do_setlink+0x28c/0xef8=0A=
...=0A=
=0A=
Which as far as I understood because these two are not in:=0A=
51b2a7216122 ("can: mcp251xfd: properly indent labels")=0A=
a7801540f325 ("can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into=
 mcp251xfd_chip_start/stop()")=0A=
=0A=
I tried to apply them,  but actually a7801540f325 does not apply out of the=
 box.=0A=
=0A=
I think I will do the tests you suggested in 6.6.47 and come back to you...=
.=0A=
=0A=
Thanks, Sven=0A=
=0A=
________________________________________=0A=
Von:=A0Marc Kleine-Budde=0A=
Gesendet:=A0Mittwoch, 25. September 2024 16:33=0A=
Bis:=A0Sven Schuchmann=0A=
Cc:=A0linux-can@vger.kernel.org=0A=
Betreff:=A0Re: IRQ handler mcp251xfd_handle_tefif() returned -22=0A=
=0A=
=0A=
On 25.09.2024 07:38:12, Sven Schuchmann wrote:=0A=
=0A=
> I am using Kernel 6.6.47 and sometimes I see this in kernel logs:=0A=
=0A=
>=0A=
=0A=
> [=A0 355.728634] mcp251xfd spi0.0 canfd0: IRQ handler mcp251xfd_handle_te=
fif() returned -22.=0A=
=0A=
> [=A0 355.728672] mcp251xfd spi0.0 canfd0: IRQ handler returned -22 (intf=
=3D0xbf1a0016).=0A=
=0A=
>=0A=
=0A=
> After that the complete CAN is down.=0A=
=0A=
=0A=
=0A=
Yes, the interface is shut down intentionally in case of errors.=0A=
=0A=
=0A=
=0A=
> ifconfig canfd0 down and up fixes the problem.=0A=
=0A=
=0A=
=0A=
That's intentional, too :)=0A=
=0A=
=0A=
=0A=
> We are using two CANs (both mcp251xfd) at the same time in canfd mode.=0A=
=0A=
> We are sending about 9 Frames each 10ms on=A0 both CANs (bus load of abou=
t 35% per CAN).=0A=
=0A=
>=0A=
=0A=
> Top shows about 10% of CPU Load on the SPIs:=0A=
=0A=
>=0A=
=0A=
>=A0=A0=A0=A0 PID USER=A0=A0=A0=A0=A0 PR=A0 NI=A0=A0=A0 VIRT=A0=A0=A0 RES=
=A0=A0=A0 SHR S=A0 %CPU=A0 %MEM=A0=A0=A0=A0 TIME+ COMMAND=0A=
=0A=
>=A0=A0=A0 5620 root=A0=A0=A0=A0 -51=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0 0 S=A0 11.9=A0=A0 0.0=A0=A0 0:45.33 irq/45-spi0.0=
=0A=
=0A=
>=0A=
=0A=
> Anyone an idea on this?=0A=
=0A=
=0A=
=0A=
Can you add "dev_err(&spi->dev, ... );" and print interesting things in=0A=
=0A=
mcp251xfd-regmap.c where it returns -EINVAL. Maybe add an additionally=0A=
=0A=
"dump_stack();"=0A=
=0A=
=0A=
=0A=
Have you enabled CONFIG_CAN_MCP251XFD_SANITY? If not, please do.=0A=
=0A=
Please also add "#define DEBUG" in mcp251xfd-tef.c before all "#includes".=
=0A=
=0A=
=0A=
=0A=
regards,=0A=
=0A=
Marc=0A=
=0A=
=0A=
=0A=
--=0A=
=0A=
Pengutronix e.K.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | Marc Kle=
ine-Budde=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=0A=
=0A=
Embedded Linux=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | http=
s://www.pengutronix.de=A0|=0A=
=0A=
Vertretung N=FCrnberg=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | Phone: +49-5=
121-206917-129 |=0A=
=0A=
Amtsgericht Hildesheim, HRA 2686 | Fax:=A0=A0 +49-5121-206917-9=A0=A0 |=0A=
=0A=

