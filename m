Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDF64B23C6
	for <lists+linux-can@lfdr.de>; Fri, 11 Feb 2022 11:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346492AbiBKK5j (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 11 Feb 2022 05:57:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239612AbiBKK5j (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 11 Feb 2022 05:57:39 -0500
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40088.outbound.protection.outlook.com [40.107.4.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36046DA8
        for <linux-can@vger.kernel.org>; Fri, 11 Feb 2022 02:57:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZNoCn9k0jjysIVyd4rkwY9u8gke/7B0i/xz4Ml58LBbanodKSeLgO07EKKQ8VvmOK6QR0a7grMPBYrIZzdB6flXCIaZrS+B9dTZZzJJKYEgmmk1yN94J4YtZOb4Te3BBdY2nr/JICg0RE7evccu3g1Bkpz8ZG0RDdwDp30aEPhOIUb8J65xSJp/WbEB7auvdMpD+8n1e3wubrmtzBqnzXjEvMv82bk2xrFmNwLImgLa+ODCkuzK8qRSCyJ6AbbRhnYgcC6dUEko+1Unv31yQB3Xui3qUKpKmrghatJU8GyQTBh/ztyDC/m+VApQz8wajfytXYupGJmtaRDCFmmsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJyRmA+Qz0QXDXpwO9gqTCC54OSGd5IH8CMqUFtN0Wc=;
 b=jr8rc07YZARl5roVDho4BjJCAMmEnquo229TQb0t/QcqIjC2DzR4oHwxoclSLnYqmvff+5xfqER/uHTLLzNQBj6l/hWWAQ1557+mfA0zgQ5nRLLLQi2ti8HzTIhGI9cG7TFY071+hKGGXqJRigBTc3IiEvbFMJn+HHHqZawkuj3lMc5SWCjswSvbdlBJs7Ks05rSa0k8sPPx4cUrmCEF3UMVMhUzuxksz9uYsbggnWcScZExwgcSM7ATB6nc/RTLygv2k9/xJiGwno+ooUQRl/0B9f2NSFF+EhkA01zQS88ALnaOaExU1OsKTY8f3qNYFI4FlG+aG2zRQU42+eSD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJyRmA+Qz0QXDXpwO9gqTCC54OSGd5IH8CMqUFtN0Wc=;
 b=geIPi+hFHnSxIwys3Lnp4wtixNPtJ7WbELhsF1lxuwLTxON4Z/eaEeW19r1nH3VUC7PsYWSGpY6O3MPbsS5sekrXB+QFpg8hJP5hDe/HEDLRU4sUmtxhlQ+F5QkFkwfsp8AFPiZx7tsCHnrc3Ait8vKKsEOFFXtbiF0+EKAw3GE=
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com (2603:10a6:102:f1::9)
 by PA4PR03MB6893.eurprd03.prod.outlook.com (2603:10a6:102:eb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 11 Feb
 2022 10:57:34 +0000
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::3460:fc17:db04:a018]) by PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::3460:fc17:db04:a018%5]) with mapi id 15.20.4951.018; Fri, 11 Feb 2022
 10:57:34 +0000
From:   =?Windows-1252?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: RE: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined
 flashed device number
Thread-Topic: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined
 flashed device number
Thread-Index: AQHYHzAodRMPm0lBD0C/3HprlXNq6w==
Date:   Fri, 11 Feb 2022 10:57:34 +0000
Message-ID: <PA4PR03MB679736316C8D5CF2079EB794D6309@PA4PR03MB6797.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 0e063836-7e4a-1a0b-0b84-f0670bc3cce0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=peak-system.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae98a5c5-eb11-4479-ae31-08d9ed4d4f27
x-ms-traffictypediagnostic: PA4PR03MB6893:EE_
x-microsoft-antispam-prvs: <PA4PR03MB689342D807C556AB41195CAAD6309@PA4PR03MB6893.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 94D+xoRnJyEfTYyE0GzCiNNTthzaGkqtTO6UHcnGZKv24IhSnuTR5wtBMHEy+sXA+gGi+Lv3kjQWg6awB7+uepuDdXCpQnv+b4yxgPfsSzhMhG5k7BpZiUVr0UHd+03zVCy02KKZQII3RhX4j+L1Sgxp41W7TqVEA95A+xiG/EVEqH/ItTUdERCuuNSVDOFC/7q4wJ1WMw2EDMK4NtVQjaNbfQ0QlHeE1mJAks2R5l8Df7DY5OTN5eix3JPMdbNn7vRnAw6fWDHa5xUxOeVlGRakQkH6B/LEaU1YZ8Csd8pTHIiJ2MnJertnvL0yd5+ZOJsgi6wVJcPoN8fHv/nIdOBC8Yvhs4yyNh8F6Fp+fMiZuoBXh7PoiZ1wQVPz3pQy+9nFAZ81bTWtvlmd+Vg/aLcwgwyg1If3e2phdhOedCu7kR3+PrQSpB5dnlnCM5X/vVSViwfzH2QKTN6IuhTVA7LdczotfQFJIrLtWOCw1GRpdIpPt/szbs0obfe9reGJqxVwb2xxIAJhTMGsropBsXwwuDKOlObhCLf9lyA82l615+FGX6wrVqX/jg+2YIR6B3fk4yBXxnJfY3orksF1nqZ56DrBVo9WLOf1YPkvNlKcmlpafHwj+HR+tvoMoTKSOuiPs5pknpp/mAKaPcgGT9WDNQJU14dvFV7auFLjbikHabD40KFScxiA3E+4LZAG6RR5dAjF8GkjmouSWjShpLhh7Zt61+qfZ6a3JP6kNj3ULf5O8df0jhHsf0qp/WwbO5TQdsRPuxhwsVfmms6iWDIORERp2ZLwf5DktazNoPQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB6797.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(366004)(346002)(376002)(136003)(39840400004)(64756008)(8676002)(8936002)(66946007)(66574015)(83380400001)(316002)(53546011)(6916009)(66446008)(66556008)(66476007)(86362001)(4326008)(76116006)(15974865002)(33656002)(55016003)(9686003)(26005)(186003)(5660300002)(52536014)(7696005)(38070700005)(2906002)(966005)(508600001)(71200400001)(6506007)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?ZLjRQJpootVMfDm88LaKol6v/tz1MSzjNWAyXBREwS+kWXoe8UpsyQWt?=
 =?Windows-1252?Q?f5AVnst4LLhxHiudMfQUuEFiPWdLnRkS0HaJsY6ppT+fri3C4wuDlnPz?=
 =?Windows-1252?Q?ZZcUxK4YuW4M8WtQwkG2GYsNAyOyMtnLq7DJ0sZI77N6wivIcxazK3Uu?=
 =?Windows-1252?Q?QqLAXwsA05QAeCyTgqRRELtIkLton1R9WE1AUsJkwjB/1WXTDfbJQZeL?=
 =?Windows-1252?Q?FMxAG7M0EQsJVcZfEZ9yf2ZamKf8i/AZBCTHyhBR0AQucqHXU9OU+Bgl?=
 =?Windows-1252?Q?f96f7fVBEfnh4x6lszbVPCJA46CWVZ7BKd4Krbd1FegYlLDIIO1PiiLu?=
 =?Windows-1252?Q?PUOJsU7EuOxS22Q1om/Nn53fK5u4bq+z9S5p81k590lt73vaTEk8hrU5?=
 =?Windows-1252?Q?4ZZhh9IoFrF9cWinA0yb9WXdSc964HYZK6zNMbt7pKov9+cTCMSfHU2Z?=
 =?Windows-1252?Q?QGGEGLTgMC1v+EHEyktjPcI6x9Kd18AK1aJfdKFdvz9PovFf2mxS/iYO?=
 =?Windows-1252?Q?Mx20K3LaFYj+n4OsXVwZi/xPxZnQ9ZAsCRvMQMk7ctqgoPrb9xZlAsUy?=
 =?Windows-1252?Q?W9EWQHG/0OZas+dqoiBKwyBVkGDAx6wKlCV7RWZxpAGH0dYdxFfcnIdZ?=
 =?Windows-1252?Q?z+FbsC9/SoJAaRsDnxJlyikpOM/QsnhEqAF8nDSkz2yyXgjBntYoerAQ?=
 =?Windows-1252?Q?1Wr8oYAuPNqsJCrIKtVcsd+i7q/DJCo2xrusYYORrlTtzaf9Vu6QXRdN?=
 =?Windows-1252?Q?kh7iZeBYBGKvDQXmwW0lSlVqwKv6kfrpfxIJzM2yDgYM+pD9ay/4+vCu?=
 =?Windows-1252?Q?bEMd8vq5n2OVmSAiQl985LYT/xjOwynEQSGLfPDIy6pHQz5IUBy0rekY?=
 =?Windows-1252?Q?mfrp62BxO2R3HKKMRx++pPUlVw8y12+6xGY4hT9/QVkCTFHl7lEZCYQ/?=
 =?Windows-1252?Q?gxf/IJREJ95G07iXuI0Jey1d4mK3kX+/mozBcM5aWjn26XSG38yUf9aW?=
 =?Windows-1252?Q?EJPkBb7kGmgHLC0nI9E/veCCWQy1MjahFpk6vO5D0WJOUveSICGNp/tJ?=
 =?Windows-1252?Q?OY9NOK2A7mJBavdC54VNgmsJ3lX08fXsj/C+GrXcFWof6ue1nf/c4WnA?=
 =?Windows-1252?Q?RxE1UAQ0Pba0U8WNugJWzF5hapDfbEYIqaYbt4Co1jPy7O4whfFP+KID?=
 =?Windows-1252?Q?8nRcztiJ0/wp4zWYOTSaii4ZQ5viaBMdHTg7f97Y23pb4z6GTvJvedZc?=
 =?Windows-1252?Q?BEcLtqLcMYERw+uFWK5YR5UXewQxL4Xjgj+bgcicsNjQRZwR+HqMNtRu?=
 =?Windows-1252?Q?gCDgeA7RSyW5XFFHj7JcLPcYDjAWm7jx+0YT+XbwcAbHEmO/Z/b/APdK?=
 =?Windows-1252?Q?NjFQ5QjmWjKdELrnjzWB52ScYUO9A9aCXcY7u7dy+ydqtH5M5vzvA9IB?=
 =?Windows-1252?Q?fTqUg5J7dxkmBEdyJuyN2ST7Kpi5Ffe3vI8feUuFG05ZjjmY59HyAvqX?=
 =?Windows-1252?Q?+QHVMlU5PtDC7619QY4ea8NClPCBmmXIz77ZujD832w2Y1B7inN8V6m3?=
 =?Windows-1252?Q?ZJZE+x4J3i+9KbKmsdFJQK06aGA68/E81nKok7VTSGgMwO0aWKz+9rkD?=
 =?Windows-1252?Q?blbA2K4UajMHB9j8slxB0/eFRq89Gxnq4KN2iEyCyGPeNab7dNeZ0h3/?=
 =?Windows-1252?Q?kAiE/lxDSHv1orfJyn87f4um/aCWyor+HT3ke+yw5NY+KsZlxYjaQb9j?=
 =?Windows-1252?Q?oZo5OHeC/D3OlBGvdKZeMlaez1ugWujYoOczvbAkuQTPoCJ4JbUfM3jG?=
 =?Windows-1252?Q?cEOTJQ=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6797.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae98a5c5-eb11-4479-ae31-08d9ed4d4f27
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 10:57:34.4807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7yMtGmYit42IqFDn32iwe5BZSEWdSvwdRkrsfpSn5cCnxpJ16jAp7XsCuer1twtxN6FF3LNkM3sk1nWA2b5BVOm1vtcH9SO5r5oGvqLMRPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6893
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

endianess is handled by lower level functions (see for ex pcan_usb_fd_get_u=
ser_devid()/pcan_usb_fd_set_user_devid() in PATCH 2/6).

This data is really a number and must be treated as such. The "ethtool -e" =
interface only displays a silly memory dump not very practical to read a nu=
mber (especially a 32-bit one), requiring the use of hexdump such as:

ethtool -e can1 raw on | hexdump -v -e '1 "%u\n"'

to have a usable display. Unfortunately, these formats do not take endianes=
s into account (AFAIK). Maybe you know another way?

Regards,


=97 St=E9phane


            De: Marc Kleine-Budde
Envoy=E9: Lundi 31 janvier 2022 15:31
=C0: St=E9phane Grosjean
Cc: linux-can Mailing List
Objet: Re: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined=
 flashed device number




On 31.01.2022 14:25:28, St=E9phane Grosjean wrote:

> >> +     u32 devid;

> >>

> >> +             memcpy(data, (u8 *)&devid + eeprom->offset, eeprom->len)=
;

> >

> > cast not needed.

> >

>

> We need to cast the u32 * into a u8 * because eeprom->offset is a count o=
f bytes, isn't it?



Doh! right.



What about endianness? I think it's better to use an array of bytes

everywhere.



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
