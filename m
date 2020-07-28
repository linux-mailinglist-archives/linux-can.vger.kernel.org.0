Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BDE2304B7
	for <lists+linux-can@lfdr.de>; Tue, 28 Jul 2020 09:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgG1Hxh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 Jul 2020 03:53:37 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:28674
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728037AbgG1Hxg (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 28 Jul 2020 03:53:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTVZn4QI0Wf0bbqE14CeZReIoPzcmE5PtpaVepSRKnkiu1cdjc60USAKcCAjiiRfrFi1sfjDDD+HwgIGlw/4mJsvXzW5c9cedNR8QoTUgGuq9UOCUnJVDeC/MMqqDmpwfaS6GDKQJCQn3qqjmbC5PhH5fxzzM9rzLEZJkhirGBm9ujFBhEiK6JP+WNZZYkjLEw9EUszEdcCL7BKsGhgf13lpnit8Fm5rPEzVOLhIPXBEH0c313eOl/xRckLr50FTwJbokOUTi42YaFxWbaJwqBzB5dyfi5I1t4iCJ1cJsg2/yOkD5WkjlvNjHlpGbkCiD7u+e/a85JEvg7kBfFu2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVf3TijvzGfTi2LEKmlvGNKp2nyvTuZ7/llJa24Dg5c=;
 b=BE267lAKDJ2v/ILTb85NBfzEYAJU4B9m2RXMUjzd5h/A9cNjJy8qSBgqoApyQgNuTfmgKibTN660oBfQMz+GHSqGeci1b1cFCjr2xcddFuQQgIBcAxKbtGXBnKLEuYxlKu7iaLYcQT0fmKovYt0es+kNOfFjjiRQmKT9OA+1lX5HdNeY8dOr/eKJAUKMbmbXY6Ivu9d/KEOE5dX40Q7p/xFre1OZAsEsktyatmeJqOaL5UHTjqjYhT0w1HAuP4KandpcODdkbe4hiuZvZBcUQcy4HGZUiZaAEvt5mCflv9dzYjDUzjLXMbuaVHdEs6JLyK1YrWNKJRS0Z515mH+t1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVf3TijvzGfTi2LEKmlvGNKp2nyvTuZ7/llJa24Dg5c=;
 b=gE+OLGz7eK425t6rFC1ghJaYuznJfQGlq0NzGfYPOCb9Fc1FHOTFmLd6TdK515FcHX0ZMd4A+tllGxVUrbg909zufUSJfrNoQd/KHLGlQbrbesV5ekiY3vlWYLwV9EQ1uy/G7Lc/dNFMMnpbnItpEAYOUWKgIjMGVmzf+aVk1s8=
Received: from VI1PR03MB5053.eurprd03.prod.outlook.com (2603:10a6:803:bb::18)
 by VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 07:53:33 +0000
Received: from VI1PR03MB5053.eurprd03.prod.outlook.com
 ([fe80::6816:82a2:7f79:f1a9]) by VI1PR03MB5053.eurprd03.prod.outlook.com
 ([fe80::6816:82a2:7f79:f1a9%5]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 07:53:33 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: About sysfs usage by socket-can drivers
Thread-Topic: About sysfs usage by socket-can drivers
Thread-Index: AQHWZLI52WvlNJVPV0OWEb9/IDLcbQ==
Date:   Tue, 28 Jul 2020 07:53:33 +0000
Message-ID: <VI1PR03MB5053BD184B309045AD7336D2D6730@VI1PR03MB5053.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=peak-system.com;
x-originating-ip: [89.158.154.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef00a123-3aa9-4131-5214-08d832cb53aa
x-ms-traffictypediagnostic: VE1PR03MB5246:
x-microsoft-antispam-prvs: <VE1PR03MB5246D7FCEE917CB98D73EAB4D6730@VE1PR03MB5246.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bt96eOa0hQZoWW6HxKTnXG26Mn71p+cUWUoT+W6Qn8UVgKxaG6gowhtZDninlBdloxHNGaRQV8rJbdMcfMtN+bWdFUD4h9r5OiCHyk1sc5m03hA9/tRztJgHy2KzdeH08KUVjVDlt1RU7ld91J2LhvlejWK1jaTRZW9Ic2urVQkjI8K7QfZ01Q/JAyL0EVJ1MxRytvyfld0hq+CaY46Bf080d4pC1LOfAUehAF0hUy5RbTYWuzFSfbttmHu09ckPqottb4trIHuLR0l8KCSUHdluCkivW91WBF2WtbQOpWNIDRv7N0IvBfCSYK/0jez4CPTatRN3Swh1Z0qPMFxYrGeoxQeJiIThSe64SrlLOGM0hxKtsUaR/lS1n/1nDsfP9ABjyleiv9Z5hJ6EqrgeIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB5053.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(396003)(136003)(376002)(39840400004)(966005)(316002)(508600001)(8936002)(15974865002)(83380400001)(4326008)(6916009)(55016002)(66574015)(8676002)(83080400001)(2906002)(26005)(7696005)(186003)(52536014)(71200400001)(33656002)(53546011)(5660300002)(76116006)(66446008)(64756008)(66556008)(66476007)(86362001)(91956017)(66946007)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2tTfvz0IY0+56LME/1KJ6KUciBLunJTCvbHK7T9IZZ+t3o1vw9ooE8Do4I4nHF1P+MEHRWj6EF191n4UYVqnxIeONNsoUOtX+i84OT2OFfK37yGn3uoI9fkWmEEqiHp9w68PAsziBMNKKnxa6jNPhAn7Ut2j76WfRLmRrno9hFhYkbTWYwsGOwpqI4sXhKdpInVLhV8ZzkmHbdYlc6Bw8lYh8LTQUa9Zf50ba7wkFBZHMN26LkifBRMa1zvBGQ3NcoPFV7/+trGcw2QoTlXoqHdsunSbaMGMOU4Zt8MVdXUjIV32kqpA+XjCyarktH5WAaZUHajSDCGnJ9pEC74dq8CZCwtRtBdFvQYeGgMf45oWMemB8fqz+S8RO+pIytpJkikdp26XeRWASvNEdTWiaGTiJBqTjCkRoZPcHR+fYeFSv9r15cCudYtkqMnlq6s8MoqseqH6ZIBy1GD3JxJLobM5S0ROicQh1bT8NXT2j9Etj92HrwTrocCbWha3gmpg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB5053.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef00a123-3aa9-4131-5214-08d832cb53aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 07:53:33.5236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2HYMRzYGZGcTLdpZHEVX1/UtoQj9WHktUkOuI4lUmd9P5ZWbdUAzvTHaH6jEgXMsJ9UTxJ3md7Jfqi7Pqs/5r2lCV/fM/5qFTSuSd++dus0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5246
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> Can you query the possible clock rates? Either add to ethtool

Yes the available clock rates list can be provided (by the driver). How to =
do that through ethtool please?

> or make it a CAN specific callback.

Do you propose to extend "struct can_priv" so that the clock could be selec=
tect from netlink?

-- St=E9phane




            De: Marc Kleine-Budde
Envoy=E9: Jeudi 23 juillet 2020 22:13
=C0: St=E9phane Grosjean
Cc: linux-can@vger.kernel.org
Objet: Re: About sysfs usage by socket-can drivers




On 7/23/20 9:39 PM, St=E9phane Grosjean wrote:

>>> - changing the default clock value,

>

>> The input clock rate for the CAN IP Core?

> Yes



Can you query the possible clock rates? Either add to ethtool or make it a =
CAN

specific callback.



>>> - reading the bus load value,

>> ..as calculated by the USB device?

>

> or by the IP core, yes.



maybe we can add this to ethtool's stats, otherwise to the CAN stats.



>>> - using a flashed device id. to better control the can interface number=
,

>

>> Can you make use of dev_id/dev_port

>> https://elixir.bootlin.com/linux/latest/source/include/linux/netdevice.h=
#L1687

>

> Ok. I'll check that, thanks.

>

>

>>> - identifying the (USB) channel

>

>> Does udev offer all needed information? E.g.:

>

> Sorry, nope: identify the USB adapter <=3D> flash the LED (which USB devi=
ce corresponds to which canX)



Use ethtool's set_phys_id for this:



https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/gs_usb.c=
#L762



You can either implement a "activate blink", "deactivate blink" or "switch =
LED

on", "switch LED off" (and I think the core will take care of blinking).



Marc



--

Pengutronix e.K.                 | Marc Kleine-Budde           |

Embedded Linux                   | https://www.pengutronix.de  |

Vertretung West/Dortmund         | Phone: +49-231-2826-924     |

Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |






--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
