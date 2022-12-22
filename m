Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD1F653D49
	for <lists+linux-can@lfdr.de>; Thu, 22 Dec 2022 10:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiLVJHS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Dec 2022 04:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiLVJHR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Dec 2022 04:07:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C9320341
        for <linux-can@vger.kernel.org>; Thu, 22 Dec 2022 01:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671700035; x=1703236035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DypwT4diw9IiBgb8H+W4OQ8g7z3/4UVeEjOP0dlkxo4=;
  b=zD/4DEOsIYod+kNz6dcVZHFgomPROjGiPZHAIEdORmiV3WSaG6iGHyV7
   c5ySb1hQMxogd9hBNlONDz2sd+gxNnwzuuiTsXa66FoEHJXpho9Av/6XA
   HPTmfxphNMyFdATV4wnZhi4h/B1a5MaZlHaMk6r3p1oTR/uoXkmGAwewc
   s/7OVygSLp/Zopb2/d+1hVxLGflsaE/ZFkpiSnau49hDp3wbcHrAgQPFw
   GgITHxMheE9fzYNQVepkWjfkGcPVa29UNIhsJg2IA1M/sfuxu1jvnxBFt
   KejC8OOtzvFcdmVjmdDCC60U3dPaKbQjeYJDD1FhrPE381JIGRUApg7gS
   w==;
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="192828631"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Dec 2022 02:07:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 22 Dec 2022 02:07:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 22 Dec 2022 02:07:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkdmStPJjn77OXi/j7uJN1l/+h1jAKWNdTriymUy66clKcAvJ23HnWAwadDk5calzHUga1fg9QIg0UhHfQF2IWD/YJqXeJujiq37vWdgCyVGSQp6rS3vPyO9V4GS/AO4rY1AyfNNMm1E4OvJk++28knN8mibLmDKXr2yoNvKhkJZb6Z7W8kBY69neQDq50gDYxRC0Cm099PdB9ymZsVbw21SyNFdAlRDrNH49nSi++rYSkahz3fHrYM4/IpYLCgt3Sk+ecK9jWgEEgkhh12PqBSmG8s+Fj7CLMa0YpdyXoipiww4I4QkKaoNJxSndmPocCuLiKd3xtFs8BITQrKTLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cf2CA6lZ6CbC1fskfeGYZoxAC+kLXRedKjITXDJngk=;
 b=Edhpj1w5TDX3SfwFburRaO3Xbylmwd3WDKiyvdV8SBl5WpCAxYBQT8RAT/4+QTibeTo9YIXAiyTi0MooObQE1/iw0EEYnbU6uUdSdIlby27op3w0i4Lld1PNQVWYIGKY+lu4OAr6gZtkq+0MgkHNj3IEu8jkemTHkGdpus5rDkv0PnI87m8uOCH7twP6g28LB/PNl0RpmRFjdZI+oW2GeIFNiUnltlyyFvYV4Qj8NVHNL2I9PHFTy8FRUQAUYo+SbTHGu0Ek65GcqaYewl5n/eEXJXewdUIGYD7aCa5Gkb19y7thx6XmcSg/5l4NRIcuqQRgu4DQvO4oGs8AYzy8BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cf2CA6lZ6CbC1fskfeGYZoxAC+kLXRedKjITXDJngk=;
 b=Ndsqa6fFw31LF0GdFDk1l9/tp+13DMBhaWYUC58y7xbng1JksPCiCQxtJFi/AA0Pe4QXZj6HYttVCa+/hX7OW5yvAnPhy24cLSv4h9XPZwEEOndJjt/LBxHin5k1vI3XLh4NpcUe6gb/1HQCqTgphMUtUvrNbVR0dtQi8OizN7M=
Received: from PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21)
 by IA1PR11MB8199.namprd11.prod.outlook.com (2603:10b6:208:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 22 Dec
 2022 09:07:09 +0000
Received: from PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::483a:282a:7e53:37fe]) by PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::483a:282a:7e53:37fe%3]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 09:07:08 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <Stefan.Althoefer@janztec.com>
CC:     <linux-can@vger.kernel.org>
Subject: RE: mcp251xfd: Bad message receiption
Thread-Topic: mcp251xfd: Bad message receiption
Thread-Index: AdkV11/b5jjJzAvBRy6q2itnF0vApwACBsqg
Date:   Thu, 22 Dec 2022 09:07:08 +0000
Message-ID: <PH7PR11MB6498DA4A162106BD4ACB7551FBE89@PH7PR11MB6498.namprd11.prod.outlook.com>
References: <FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6498:EE_|IA1PR11MB8199:EE_
x-ms-office365-filtering-correlation-id: 71ecea36-deb6-4a5a-462c-08dae3fbe7a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S0LWK+9zI5IyGr04QAyIGHeEgwaZY0uZb8GBY2KePL92j8BCZsdH5Td7qozAf+nuAcLn+zi3n+XxUhK0vRTDS/2B6jL86lMB3090iUDfVwlepgN7z5WTy0/RafRq8wbMfmDcBWA4MRACnDS0JIu4CXQzFps7N7HvjM7p8gugHN2DywrW7BFG+H6+bHSGCFsqBjea8ziUpkUY+Mx5XaGUEGeqx0z1JcvE4Tq7i7Er37XYp+N53P7L9yTuJciKD8gBCXfYFYjHgtlx8aGza0phVAezjjkJlqch89qJCDnnj2HVSBDoh6WETKWRhAHC0/Dgl3Ic/YwmDPDHGaZarsKks9+gGd71Dlk9F+jsV8cqIgvimQul52p80RJUAb5jvNTRjV37koos45uswSxLsihZIiU2cIIPcWerJ5DXj955skpJLOPMjKQEkV3FPZBo29wWz3RB6BEZoxFOKZxVFOh1+ov1vhxY5JRsxuuQu4g4CtIhOW78IPVmnrZco7fRhSM/CcPMEqKpAshpJELCSbDfaOrudz/J9qJrMTBCdpnYRFXQRG4bmTUKOu4ffVqAAfIcjHmkC1xMNKFPu9hzSfj15ZO3EXE48UYnjFXTCxeopXrTRw0nAgscquiF8ZcfWk6AgvyR/KrEIUao/aJ7h3i8Q7ws/WvsJCZ1SzKMH318OwIwge/0tYu1JV3RPyDpbllVGSWDPfdW/vs73ERtuhVddybjtnM65erNAcvIMJ/fvtI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6498.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(33656002)(86362001)(55016003)(41300700001)(4326008)(8676002)(64756008)(66476007)(66446008)(76116006)(83380400001)(66946007)(5660300002)(52536014)(66556008)(8936002)(966005)(6506007)(7696005)(71200400001)(478600001)(6916009)(316002)(26005)(9686003)(186003)(38070700005)(15650500001)(122000001)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8yiBGA9FBt2dkndvt+TE2FilOYRXUKdMKj2wrmW1vTYmfHQdrhya3vCs7m?=
 =?iso-8859-1?Q?Nur+seveO30viYxHrxZZyM+vj7QWZ7mopbvMMwUFruckeFft8R4XUvV+th?=
 =?iso-8859-1?Q?p5e3pKo8TZ3FyfkY3IuIICaf309s2P9cU4o8FmyyNewnsI3nIL5rAioKHx?=
 =?iso-8859-1?Q?FlDSzcoPK8dDTLGB73OdHd8qs8h6hddHcxAffuSQl4HFID6CPJvEHPXKxr?=
 =?iso-8859-1?Q?KlzvIcSuEdAnM5buGJmWsBeLZ6L2OoAbLx3FFNmLMDj7lBADCzZdajhKef?=
 =?iso-8859-1?Q?+KuwkTuX58gd8HEJpTf3A/5+H0hl0ZFOu0KKGyT/Sxu1MgEM0R+gimQ3k0?=
 =?iso-8859-1?Q?juKswpRqERkGbVARpcyxqGjwetwvVi5o1awWPJrYguYUZ2u2yfx4hEcpjt?=
 =?iso-8859-1?Q?SNR9xXQkeebUSwxx7/c/IuvrnNVPJ2IFr9VwsFB2qF5Vn1pzWAm0uA5To3?=
 =?iso-8859-1?Q?vRbmSNEduMIQC42aVkzwAd/lz4esJrDxH3vfduGU6aIFnaj0gAwdyyrIJ2?=
 =?iso-8859-1?Q?Y23VfGHP1+bPl6/3/DMk323l2Cbe6bgRzNs42mEJ4wU1MX+EGXJEdlVTN6?=
 =?iso-8859-1?Q?97YiYknbZYB5QY94t8yPn2WoBaHRtq37nSfBVt0BODYDu8lFLHJ3AgBbKc?=
 =?iso-8859-1?Q?sD73uZGzAFQHoyYs83AgRL1UiAb0Xg+3sDo/M+wN61siyRBs3uNUAZuKK3?=
 =?iso-8859-1?Q?LkaMqHIimOnaI29T1cDMGdspBbeT0Gnh8PwN5eQVFkNrQq6V7fuimTIPKH?=
 =?iso-8859-1?Q?zgBdudHyNrZz/MVbhZeL5BG6CWCKuSep6EPdftLQlwVa3xJIRD+NkweYWI?=
 =?iso-8859-1?Q?wRkv9XBzwC2+t25guybZJhPEvZExg1sv4ClxQatl186XTAC69ehs2DDp5y?=
 =?iso-8859-1?Q?Yfa8nkRpu1g3k5Oy1o44ukX3EaNsz7T4Fot4czjD+7tJtTa764zcHXNsfv?=
 =?iso-8859-1?Q?ZCTd9m+OyQaaqm5u9FowLJxovi8rU1q08UPmPyyuIGby0I9fJ3k6Khxw22?=
 =?iso-8859-1?Q?9/2L3tHgBgGo2tMpKyM1HJ5ehO8da/drl3r8xc0lTFFAcM722PrDAFIvN+?=
 =?iso-8859-1?Q?QA2Qe3h6HVqdK/oqWCb3T3FWrpbUAfF/o1wdnhQy/HXC1Tcux9wNNKcSCs?=
 =?iso-8859-1?Q?fTNBV793eQTXWyge1r5sXe4eazvsut+Z2swyTxQmYSMKFMLgovI8+B5TiO?=
 =?iso-8859-1?Q?mI4eXhJRvDUyaXChJwBRSUlRyU2BCJqgbZO6J2Blxs2pAV/loKC8UiANiO?=
 =?iso-8859-1?Q?zXTph9aGJ/AqBE9opZOjKq3OZJjuq74af36/mOQv2KewPyUQwXxabXrdAW?=
 =?iso-8859-1?Q?uOYAvDdEa33wEFLExV5yyCS9ZYqb32W7RmX841uO1RdeWNGcl78Ycz+PHK?=
 =?iso-8859-1?Q?Jc2pxo0sW6BxvgehorX+bMqgfZbf7OQOy3x6Nkr+0GRZWI7dP06oLiA9OC?=
 =?iso-8859-1?Q?CpwxmOGinJMDFXmP+n7LmUdfmTPdSuqQ1mYMEd0lkwTKnVRktjfihOvKEb?=
 =?iso-8859-1?Q?+ujFGqRh0AqpSFXtrXaa5hpWqh4YfkH6pFbc+KsU5PLe+tPwIclGeo9754?=
 =?iso-8859-1?Q?3A9qZf9y9WJpbjpNrylxISIfJ8vK14lETfGKwuUwviCMfX2xLVlC4Gr9Jy?=
 =?iso-8859-1?Q?HofUKUo3UL25hTA+/fxe+xkX4s6MSDkaCA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ecea36-deb6-4a5a-462c-08dae3fbe7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 09:07:08.8370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gIifdBMuX6pxacTvanNhaqsn+mzCt15kAbyp2ezeJyYEJBhRovJpyspuOlQ62/VuRv13MWTbNg0hFz63Lpfq+wHuGDITSWuAeHcRGHbWAyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8199
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Stefan,

> I have reduced my test case to a simple single thread self-receipt test:
>     * TX two messages
>     * Wait for RX and send out a new message on every receipt
>     * TX for messages in total
>=20
> Refer to the attached PDF for some error cases. Last send frames are at t=
he
> top of the logs. You can see that wrong
> messages appear in the RX queue, which have been successfully transmitted
> in previous test loop. The data that is actually sent
> out is correct however (checked with an external logger for some cases).

Do I read the pdf correctly (based on the /var/log stuff) that you have two=
 MCP2518FD connected to a Pi4B and both of them are running in internal/ext=
ernal loopback mode no interaction between them and the SPIs are separate?
What are your CAN interface settings? Would it be possible to share the scr=
ipt?


> I see infrequent mcp251xfd CRC read errors. I think those are due to the =
2518
> SPI errata. However they don't
> occur at the time when the wrong messages are received (refer to the PDF)=
.
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
