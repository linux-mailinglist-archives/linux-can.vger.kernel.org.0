Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6844D4A4943
	for <lists+linux-can@lfdr.de>; Mon, 31 Jan 2022 15:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiAaOZe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 Jan 2022 09:25:34 -0500
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:12160
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233565AbiAaOZd (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 31 Jan 2022 09:25:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AchE66+qEEgm6OlDLCw3Y3sOIc4qC8qBta41xeb3uft0iL9kIbQp3clzeVVDSvs/tQCy9e1GyY79736OfHrwD0TAV5XXB7DRGaf/aB3N85sLK6mLsqb6ATt4o5H47/c6IjMhxVSL5CvflOdmF5kIDHkILqc+wgNSRo5a0Z87ugINuO4pzbd8VG7VVQO1zO6D3OoAq9UIY40MP66XyEK0WZ6Nel683GaQ/Opgi8+S0JkaVQ7ZL3lbXELCzwzJK46seN+wlo1Bg2qAAsSDxjNxuvW/+ZQFW0kESgvgbg78h0i+YxikFI0GRMFbOvfFILx+1Sqvzj8qhYlRQJuXY8zy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEELXeNTRTrtp8P+/HTos9KAqYhioArKKsWKr9wWVAk=;
 b=FCWByl+9blM4qJQhQ2Ick/ft5htprqBC6765UDJ4leGS+ceKsHPhUG1kNLcVPQZK4Ji65gfGM+9U3hc/Xh3gODeRoUPSfuiznImkLrjqU2CQrYik/G4KHg9y8KG4EIo/JHIUKePZyCMrBxIFnSO8pYZdGmRs3a/S5DN9dYTrS0YbJuOXIc9Rn4/NilT+WfVdckAbCNgYVzxreVs/aIxhKbU2ZUrkmxBLx0mjUabLlOJpf6XCrbeLyW6yisFm9oD+jnAc1+Am+4vCisCx5uAuojAy4kINmfQ/GTwDIpinDYyb5D+i8f8JN0T2eVU00QsOiBU9TjTXPJpEML3PFlxAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEELXeNTRTrtp8P+/HTos9KAqYhioArKKsWKr9wWVAk=;
 b=7sSag2oWh+agZq9WQdFouDn+eT7tsXTHKi4QeKOk+RxW80xmHFZFN6qv9xOXIF+CGbgozgvTeKHrZHEoG2OCM7ZgYeO/gsb2zf6gi4+oPIHuIgIycpAgmoEXPrF9qd5Uji4293eA1Q43ubs5decciA+wotclZ1JlAv9mwMdWD3U=
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com (2603:10a6:102:f1::9)
 by HE1PR0302MB2682.eurprd03.prod.outlook.com (2603:10a6:3:f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Mon, 31 Jan
 2022 14:25:29 +0000
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::6911:8a74:9523:8701]) by PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::6911:8a74:9523:8701%9]) with mapi id 15.20.4930.020; Mon, 31 Jan 2022
 14:25:29 +0000
From:   =?Windows-1252?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: RE: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined
 flashed device number
Thread-Topic: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined
 flashed device number
Thread-Index: AQHYFqlPkWp/rtjd4UacZ0Sxi7BJ5g==
Date:   Mon, 31 Jan 2022 14:25:28 +0000
Message-ID: <PA4PR03MB6797AFA0F9FD103718D7C3FDD6259@PA4PR03MB6797.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 06834909-4bcb-2a22-3fee-587384642439
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=peak-system.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a41919d0-fa93-4050-0db2-08d9e4c58803
x-ms-traffictypediagnostic: HE1PR0302MB2682:EE_
x-microsoft-antispam-prvs: <HE1PR0302MB26821C929346236F33DAAE2BD6259@HE1PR0302MB2682.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R7QH0NINsNgyX1oOs3tgYVVjnexy5iotcPQMdLy/Yuo3vK0Sob8nLeLwfhxrfFIl5RVJGnutR17wOhaHZnvK8lFTkLsTILrepx+POs1GcJwfAl0l2Icd9ZYfpQsCfTBu9UVbEprGaDpV3yekXZB/1sjbqcYquR2mB9yJHap9xKXtcc2W1N849mt1gLyK4v0sCulDP4jSxMBWh3x6K3LQ+Z5aQVFEe+VrXqvw5lHI8c1fzwkqdodKDJiI6eRJuZfNsnwzuiP0TXqSwCSjfFWoIWkTr8fuoxBSSIRUAXdZAiODN+rFRqKYzG9olvO2XsFIgRs3+ie/tttiqJrUU0Gt5O8ADEaGMaKMIrPugjjj1g+P22bX/NefdsJoz/95qYQN88P9/2pMbqiiNLydhHbJk+Wq3WjXj2GmCFqDRt7p68fH9THtur+3l1JQWOSjpWBoyJK6S+lcjrXxfA5bESmhaWUoj6hxRQlJk680vU7+3Et/BcBMrpOIl0grdZjIzUl3qvwJ2WrF2LbOQ6koUQ+Dfsu3758t7MIfdrmpD0aNAj6PvOYC7f8f6z+MJ8NPzlR46K1wB3LF7zUsTfJxgfNrMwiJZHzduAN6s2aLTYMvSrU1cI/YcppVPxEIhteiSg1brz1C2KDab+Lu5hBWvMoi1V4WcSoSHgiJbViNYkdRhOLrwJz7hoqrlg2pjjKTtPYY/R5+4JSzVijkmM4FSr4LYQzJInHsTBo8yzOXcKtrRkd/hqSxlbwp0qgHaXqj47kx4IXCRZS/m7RDMYPBEtLJ+/PT6tQyVPJCQbBMj9PFyzo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB6797.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39840400004)(376002)(366004)(136003)(396003)(346002)(33656002)(8676002)(52536014)(66476007)(66946007)(66446008)(64756008)(4326008)(316002)(76116006)(5660300002)(55016003)(6916009)(2906002)(66556008)(8936002)(15974865002)(9686003)(966005)(71200400001)(7696005)(6506007)(86362001)(508600001)(186003)(26005)(38070700005)(66574015)(83380400001)(122000001)(38100700002)(53546011)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?fIdZGSnGi4aKjU+3VpGDtNCrUcwA26ll3voqCGRwPeEfEXQWyjRgKLDM?=
 =?Windows-1252?Q?APynfQEqQWqONkLMmKZJPnC3PCn9IGZBdyaIcrTxbzBqaOLWyXf2msK0?=
 =?Windows-1252?Q?olO+0Y7xNtoXjK0+54WJeaBNPf+pR90bDjrYv+h3N+wepmnMoLJ2zoET?=
 =?Windows-1252?Q?46TLpH2ktYpzrmT4QZf2wy330NYFqeTyvtqHnZzcvor7/WYkwEmXgboE?=
 =?Windows-1252?Q?aKIWQtCuZlCpg+Aux2r9HUfgezKQKDbvVVZkOrNmRp2XbhpZo0eATScV?=
 =?Windows-1252?Q?ZWMVyBszmww+fOV/if4s2Ytu7NLUPT77xpxCaThmDDrVGo++r2UUdi/Z?=
 =?Windows-1252?Q?jbwF3nJn2aJyhswuOc5LEyc6gja3AuPqtG6IoH61kGVRUi+c5TOD3EfC?=
 =?Windows-1252?Q?4ZEHCJAq7f9XntgYWKgqIMFiUIw7x/DsMFwDlw6HHubxOelsBGLXh7ui?=
 =?Windows-1252?Q?zt6F6/rsZtHVYE1saSlE3QTXgyTxud5Qq5kSAvcGdGLQzm5zQOogn9TD?=
 =?Windows-1252?Q?RHk2APCJJbg0yCZWKmalucOKkbMNbt5N6YakSq8lLHcLAYyLlYvVvA6X?=
 =?Windows-1252?Q?0DqMTGXPYuHEN62CN6MwkINhQhiu97jiGA1wJm4Hw1GjFFxTEk5cOqT+?=
 =?Windows-1252?Q?tdlsef3rYYUgQ/EclV9xN9yin9bXjR491WI1swecIbXpJ5zwEzMlCaWG?=
 =?Windows-1252?Q?uVAyE+G2+QCrbJO2V0X8qMq70RwaVAr9JCsbj5csffx7WGR/b5ATOJPA?=
 =?Windows-1252?Q?nW+CzW8LWIr0bzVejtFNweZoNbzN9iECaD72WOQKS6BRUTSxxAItsMt3?=
 =?Windows-1252?Q?RbAyPKHBK2XP7hK1QHEMDE1UgybDMCjMtgQJgyJpi+p39+pWNvxnzVtC?=
 =?Windows-1252?Q?pJCvgK6L8oZQU2J2f9HRJodX9AGDkcXe5FsLFdkAx519v4mhcAG9hign?=
 =?Windows-1252?Q?8xqLs9wbSSQyKp/DqLo6Wqm6xpXbo+kc7MHVrOLmfMCCOYpGUdANrW0Y?=
 =?Windows-1252?Q?KI+tliku66NdPxK56sxu6USOvaTx71qT/oJ2JI2CNUiraT1qatPymMVM?=
 =?Windows-1252?Q?zfuVPeimDb+HI/FOOaRr7wRZaqOlMxYcjW5l9SQxiNXKsTS+1oEWB8Yc?=
 =?Windows-1252?Q?KSTqCY6Cb2qYkfFDzY4JEp7wdu5yYRXHHp5kuEBFKUK5N88I1eXk61RC?=
 =?Windows-1252?Q?FzOXQlUGUICzXORH/cgoN/qcfA1JjxpvndOjdvDW6W9+RlGDjLXZKSqM?=
 =?Windows-1252?Q?dL6wTuNM+sJ886yRfi3W+Ax8Ifke5kslU9hTXODa8sJbB4jNtVvNSCjY?=
 =?Windows-1252?Q?Ts390mwZ3dTPRKZyfcxUoNiq8hb7AK5+V+5yoBT4rYWWq4WZCxhwejK2?=
 =?Windows-1252?Q?Ytgkb3Lty1NZmd6yN17qlgtmoYbwZ1PyoEND5Hspn3HeA5c81lQKMfFn?=
 =?Windows-1252?Q?KfaGCe76VJuW0KTyiXnHFoyHZdJ21StNAjOae1mQz7cNi5rP8je+QOj4?=
 =?Windows-1252?Q?LfAYMRrbTxQx+qotEd+okHvQOwakpUz2XnLKesf5QfD4cOBxJGUY0Li+?=
 =?Windows-1252?Q?/8ZJVwkaDs/OUgCD+V0C5JrzkANgez4dE11pObj0TfjYHmxnvVAdYidT?=
 =?Windows-1252?Q?pXPgBGRh2ag9g94EAPeU6HRTlFXRR4PYBywCkzpA/8SoksFdaZoqjAIB?=
 =?Windows-1252?Q?0q4KcX5AmrMsckON2SpjwScIKgUwUsj8/OOlrS77eA+mySSgDt2s2FpV?=
 =?Windows-1252?Q?8u5L0SHoJbzSERcoZt6Sx7qHsvPldAaEJ4nq4BuLKnU8hQ4s1AuNaFHE?=
 =?Windows-1252?Q?/mGCSw=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6797.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41919d0-fa93-4050-0db2-08d9e4c58803
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 14:25:29.0134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mC3B65RONXL4KrzfzK0qe0CBhHvfylgs3p5gr1TFI+W+U7wiS+lxZ2Ni9oBXxe+J45zJDiRvElnh8xKc9cvBJp9oZ5qk1L2gdP7CRw1u2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2682
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

>> +     u32 devid;
>>
>> +             memcpy(data, (u8 *)&devid + eeprom->offset, eeprom->len);
>
> cast not needed.
>

We need to cast the u32 * into a u8 * because eeprom->offset is a count of =
bytes, isn't it?

Regards,

=97 St=E9phane






            De: Marc Kleine-Budde
Envoy=E9: Samedi 29 janvier 2022 14:58
=C0: St=E9phane Grosjean
Cc: linux-can Mailing List
Objet: Re: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined=
 flashed device number




On 28.01.2022 16:01:57, Stephane Grosjean wrote:

> This patch introduces 3 new functions implementing support for eeprom

> access of USB - CAN network interfaces managed by the driver, through the

> ethtool interface. All of them (except the PCAN-USB interface) interpret

> the 4 data bytes as a 32-bit value to be read/write in the non-volatile

> memory of the device. The PCAN-USB only manages a single byte value.

>

> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

> ---

>  drivers/net/can/usb/peak_usb/pcan_usb.c      |  9 +++

>  drivers/net/can/usb/peak_usb/pcan_usb_core.c | 69 ++++++++++++++++++++

>  drivers/net/can/usb/peak_usb/pcan_usb_core.h |  6 ++

>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  3 +

>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  3 +

>  5 files changed, 90 insertions(+)

>

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/us=
b/peak_usb/pcan_usb.c

> index b29daaab2e6e..60c9329701a5 100644

> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c

> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c

> @@ -981,8 +981,17 @@ static int pcan_usb_set_phys_id(struct net_device *n=
etdev,

>        return err;

>  }

>

> +/* This device only handles 8-bit user device id. */

> +static int pcan_usb_get_eeprom_len(struct net_device *netdev)

> +{

> +     return sizeof(u8);

> +}

> +

>  static const struct ethtool_ops pcan_usb_ethtool_ops =3D {

>        .set_phys_id =3D pcan_usb_set_phys_id,

> +     .get_eeprom_len =3D pcan_usb_get_eeprom_len,

> +     .get_eeprom =3D peak_usb_get_eeprom,

> +     .set_eeprom =3D peak_usb_set_eeprom,

>  };

>

>  /*

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_core.c

> index aa8bcdcfa2fb..4e858d592e59 100644

> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c

> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c

> @@ -782,6 +782,75 @@ static const struct net_device_ops peak_usb_netdev_o=
ps =3D {

>        .ndo_change_mtu =3D can_change_mtu,

>  };

>

> +/* CAN-USB devices generally handle 32-bit user device id.

> + * In case one doesn't, then it have to overload this function.

> + */

> +int peak_usb_get_eeprom_len(struct net_device *netdev)

> +{

> +     return sizeof(u32);

> +}

> +

> +/* Every CAN-USB device exports the dev_get_user_devid() operation. It i=
s used

> + * here to fill the data buffer with the user defined device number.

> + */

> +int peak_usb_get_eeprom(struct net_device *netdev,

> +                     struct ethtool_eeprom *eeprom, u8 *data)

> +{

> +     struct peak_usb_device *dev =3D netdev_priv(netdev);

> +     u32 devid;

> +     int err;

> +

> +     if (!eeprom->len)

> +             return -EINVAL;



There already is a check for len =3D=3D 0.



> +     err =3D dev->adapter->dev_get_user_devid(dev, &devid);

> +     if (!err) {



Please return on error.



> +             memcpy(data, (u8 *)&devid + eeprom->offset, eeprom->len);



cast not needed.

> +

> +             /* update cached value */

> +             dev->device_number =3D devid;

> +     }

> +

> +     return err;

> +}

> +

> +/* Every CAN-USB device exports the dev_get_user_devid()/dev_set_user_de=
vid()

> + * operations. They are used here to set the new user defined device num=
ber.

> + */

> +int peak_usb_set_eeprom(struct net_device *netdev,

> +                     struct ethtool_eeprom *eeprom, u8 *data)

> +{

> +     struct peak_usb_device *dev =3D netdev_priv(netdev);

> +     u32 devid;

> +     int err;

> +

> +     if (!eeprom->len)

> +             return -EINVAL;



There already is a check for len =3D=3D 0.



> +

> +     /* first, read the current user defined device value number */

> +     err =3D dev->adapter->dev_get_user_devid(dev, &devid);

> +     if (err) {

> +             netdev_err(netdev, "Failed to init device id (err %d)\n", e=
rr);

> +             return err;

> +     }

> +

> +     /* do update the value with user given bytes */

> +     memcpy((u8 *)&devid + eeprom->offset, data, eeprom->len);



cast not needed.



regards,

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
