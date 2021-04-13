Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706F035D8CD
	for <lists+linux-can@lfdr.de>; Tue, 13 Apr 2021 09:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhDMH1a (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Apr 2021 03:27:30 -0400
Received: from mail-db8eur05on2060.outbound.protection.outlook.com ([40.107.20.60]:52052
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229838AbhDMH10 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 13 Apr 2021 03:27:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyDQ0VRolz85Y2ZBxVkyhDJBgMlDdukv4obVHmDiQOWd9wHsoriOIxtRAtatblS+LZKqtJldv8rTbA3Fdvj3Z76IpA9/xRAuuI7xe/I9qkD+IjsVM0vNsAKCkwnxaY0X8jH1hlpE5m7xI5mTCWRsiafAUpmE4zwJNlvRQT5ISCe/YzF87NIAmF9Z4F4s9Qs1GNCoMmhlxf/gb+yZB/Ofq+iCV45iYV8ebdydu3kNKjYakrkV3fO5IU9EKLfcv/LIo57vwH/XPf7ZtiNz67Ys5CBZ3xppLy3weAu5R4C6BbO4bBvYNVAjMeCG8/2+AAbEc97kaTkMYI0uJMS5SRIW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu+scwpDSxeEpHwtlgXclTl6B96q6Pd73yuQFDKSle8=;
 b=fFJWmCYPZGoK930MMVOpfEUTRv1Pa1QOxROoSq+MLxnm0lNzu16+O2+D8vSlPOcM1/wZxZ7vJ+oYgQSPfvAG18REktClaAfHn2NsbDy0o9w4G3U3M0VXDFBNJ2NXTMFrefNSRpf4VA9aG7X6wMlzTZV8dmzdNkA/H6vIgMtrv+shGOIjzA/bGMvJ3DYIFtnyHrfPbsiaQg6SqLt49dVpasdIn4GYAf+rIxifKAjSzqjGHu72E01FGdz0jqM114myuSGhNzlQ9mQb0qUvamLaem012tfz3HxJEStxHBzC3YRpxPrGeTiSkSJZUyOGvNJ1JTejQxkN7jbsCoK9NOO3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu+scwpDSxeEpHwtlgXclTl6B96q6Pd73yuQFDKSle8=;
 b=6kESn+sWkLWK74iFR3k23rQrnacXfd9GEWTF1YXMdy9cZexhE712NQVJ0XVIr9uZdlMKMvncuNK/O7DWEJXOoUffjo+AJQKKNt5TsZnag/nkoB/MlmTfPli8SIcxDaYyMjBtvZrBsLDUnIlOQ1YJvxHnXOcdwlP4CgWsca2QDIc=
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com (2603:10a6:102:f1::9)
 by PR3PR03MB6604.eurprd03.prod.outlook.com (2603:10a6:102:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 07:27:04 +0000
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::816e:66e6:d784:304]) by PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::816e:66e6:d784:304%4]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 07:27:04 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: [RFC]: can-next 2021-04-06: peak_usb cleanups
Thread-Topic: [RFC]: can-next 2021-04-06: peak_usb cleanups
Thread-Index: AQHXMDXvvdvaG0hVqEW1Q0I4zj3Tyw==
Date:   Tue, 13 Apr 2021 07:27:04 +0000
Message-ID: <PA4PR03MB6797B570609FE70C0C1670B7D64F9@PA4PR03MB6797.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=peak-system.com;
x-originating-ip: [89.158.142.148]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 267e8082-25df-46a6-c61c-08d8fe4d89b6
x-ms-traffictypediagnostic: PR3PR03MB6604:
x-microsoft-antispam-prvs: <PR3PR03MB660409AF9AEC9E2E46339652D64F9@PR3PR03MB6604.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LgfGT+6gx5TjVTwm5AaOwTXb0bCI+gx+HVeGoilGPn99I+KSvq+apK86Sf9tL4yl/avScZ8HCA9BsNRiEoTKp4jRhbBopEp9QihuNkZ3V0Sk5ebW6rdnbE8iaybIryQ2alT8bZ8XBChHF3P3bd5qvnx5qIeKIhLvMEhVp+uwEKCrP4Cy6zUKmmvvpBonL6Csl7ZHBEyJdo7s6Z1DFT/uLPOim7EHdPgiB43pVcDD2fj6xn4FfPB9WQE60Jhh7mhCMPBVWCAzfn2znNSazV2p0jiHEb7d7mSZ3El4U/q40FUf2SZaan6m0j4R/N2PgN3BIOdpupnqNyv3kN92uOHMB+EpUrOsCTEsa+QP8Zk2brMIuE17gXxx4gWwbfXfemuGXRGd5mdgVwylUrrZ651EcV6VT8s+FMYC1ha8VHiLms3xmPemAe3SIG2TBIJKfMyzGF/GJfILL5w7s/V9k2HKYam4VsJE0uKOiJ9G8LIfpS41y1+ubaUL8C74/nykNwKnacsCJSED4ywmwjh+oI2RsiGoFl+rcE/r75S1rP3O/MqLAzT3aAtUyw7DNGNpykCxNuZohAZhDG4zD6/+TJY0P3fxczkvM9N6gxmYh7ig7RduwN/4RE/CxRwwl/A60SlpJswvM/gUYxKWlnAvOgOmkswaJ8pAO2m1EhfZtBRyE+hHDpajiQRvDChjjMkvEMKB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB6797.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(376002)(396003)(136003)(366004)(7696005)(83380400001)(54906003)(66556008)(26005)(122000001)(2906002)(66446008)(6506007)(8676002)(53546011)(52536014)(186003)(966005)(33656002)(6916009)(316002)(66946007)(5660300002)(15974865002)(4326008)(9686003)(86362001)(478600001)(55016002)(38100700002)(64756008)(76116006)(8936002)(66476007)(71200400001)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Ue5U/uHyyH9eDdPJEr5TsFcEfCYIrdKWUw9WexzjMY5SWSblzeshg0D9JS?=
 =?iso-8859-1?Q?DcL0ICEeRILcqUaKIf+onixp6DasdZGnoGlLg7/1/trQxyui9LRYYkT98T?=
 =?iso-8859-1?Q?6v1EQlbNZaO2tjJWlig5kiSyyJA9i6OTBZ7i5sLuYshGzhKrubgTcUCsnB?=
 =?iso-8859-1?Q?jKIesyavJlV3ENRwohQLPoawUiqR+od39p3prrKi2s+SZhAgP9Qj2Csgdm?=
 =?iso-8859-1?Q?txSUVbmV5X6LsruwBlG5TQ07Yznza3JhGC8N+Gw7a3L/SU/6b/IuvKvoeI?=
 =?iso-8859-1?Q?LUMQjFszFndrE9B6TTo/P7NF5xiLti7zBWyvTAlLPfHozhjBoJS4sXfJjY?=
 =?iso-8859-1?Q?6lzjNIKPBXIqNdl2xs4KZ2Yri3X4cLNi/cjz7T/mX0s7x7N2zQE23BoXRB?=
 =?iso-8859-1?Q?7CyoVIAlB5asGlbk+h0U/KnKqHdTFGHilt47BBwf60xz8EUfR0HJBZB/Xf?=
 =?iso-8859-1?Q?uKTY0vJtz+U2Uk9+z/sHAqZVum2ujMRNxVl65gjcOIADZNOwNvamhjzBSR?=
 =?iso-8859-1?Q?qeJ8YFrFVStiqO5nGJuif1rpGv5EwUMgzSJQLZBhYWUwMpnETWkcL6KxWR?=
 =?iso-8859-1?Q?ZsSnQjYSdqG/UBNZilU69zTZY7fY/1S7tj1Pnk/k1l0j5sufWlqtNIBgCh?=
 =?iso-8859-1?Q?tILN9SlbBLk5U5sqr5qoa6ih8d5KfXbKmFfTnYyDIc9+bo27nUiWSGXjtY?=
 =?iso-8859-1?Q?11daF45xKAcnEa+klshgVuvO8YfDBsszpeMruNRLlGd5LWASzQolJGpeQB?=
 =?iso-8859-1?Q?dkrBecWibHYFTDr7TF7IknIu1At1I7TUxbE5QaTonM2fOIEnYA/j2cFTNW?=
 =?iso-8859-1?Q?N3Hg7Zi6OWRSgYdldYnQzDqBa5+Yg/vMOjbqyRqrrET4uuK82xEWgYkLc3?=
 =?iso-8859-1?Q?NAieGShsaYVqDADgSeHGyYL+mSMtuhl1eCn9fdlLr+CeIyYSbYmMqMojIC?=
 =?iso-8859-1?Q?3tkOVErHIJZhHGQ0mT0eLXpHbvZM6LIi3pBLgjbRJ85V/haj15N8qXFTBe?=
 =?iso-8859-1?Q?kWAJgVJmGqUT0EtCWG2Es3jvFMHjDeY10nCxE68sxTWIY0lOjw4JIore+B?=
 =?iso-8859-1?Q?QHZ1O6sWXQWng19YwxT8HQjk8Bfose2+tCKs2pi2i/fXFyMXHZb+lji+ic?=
 =?iso-8859-1?Q?0nuz9sA6USPAesnHKtPC9w0yUcPTaIIFnqIZBbZnGBjdCsu545Z+63a0Uv?=
 =?iso-8859-1?Q?8jSz0N0lrXRukKp4WW6X8VnojMjyVpEuciVmPVAFXjVgYwgoSmQs/NKlVU?=
 =?iso-8859-1?Q?5L6y6z4uH0vUN+cfYzkjMQCk7gWuZYeC7moxkFgPE13FcOiedbAG+kEytX?=
 =?iso-8859-1?Q?Sd9TvqGjjXfgoAzoQaj1yTbhVslfeigxXa5hHEDftMwPK9h3V9gFQojl6P?=
 =?iso-8859-1?Q?F5Ot1aLMHt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6797.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267e8082-25df-46a6-c61c-08d8fe4d89b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 07:27:04.7795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ys2fRuQtoJgi+dKjVM4p1jG5QVVb4Vx8FIuqueMixIhIGhYOdjfJoNQh08x/3Z9IQZRugivEhWTRN211JEDDCVM+cYcQkScaG8hfkGz22WA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6604
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

Take the one that best confirms (IMHO I would say "Acked-by").

Regards,

--- St=E9phane



            De: Marc Kleine-Budde
Envoy=E9: Lundi 12 avril 2021 13:03
=C0: St=E9phane Grosjean
Cc: kernel@pengutronix.de; linux-can@vger.kernel.org
Objet: Re: [RFC]: can-next 2021-04-06: peak_usb cleanups




On 12.04.2021 10:45:07, St=E9phane Grosjean wrote:

> I've tested that serie of patches with all the CAN-FD USB interfaces

> from PEAK-System GmbH (that is, PCAN-USB FD, PCAN-USB Pro FD, PCAN-USB

> X6 and PCAN-Chip USB) as well as with the CAN 2.0 only USB interfaces

> PCAN-USB and PCAN-USB Pro, and I confirm all of them.



Thanks for testing!



> Do you need my Acked-by and/or Tested-by for each patch?



No need to, I can add them here. What should I add?

Acked-by?

Tested-by?



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
