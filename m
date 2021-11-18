Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B78245586C
	for <lists+linux-can@lfdr.de>; Thu, 18 Nov 2021 10:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245402AbhKRKBM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Nov 2021 05:01:12 -0500
Received: from mail-eopbgr150079.outbound.protection.outlook.com ([40.107.15.79]:59268
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245298AbhKRKAm (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 18 Nov 2021 05:00:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx4laZTx9ls8LHDEU4gPM72stbjqhVq+nuGHFpOkdfKjlWf4HBp8JyS4gqHTCqlJyGTg6gpYPzqhbqifYsxMWkZvo6HeyWLdK0obWSMLPtw97L3K56UgP9IaRgilNEZ+ge6tgCctd5mCKVHln1V4Bchf+4Uj0ZbX07qhZBwqSQl6UszNuYPzy5Y+coGeLeVB555Yj3ZFRowqH0q01kRspH9oFkeJArQX5jFXQZoLpyx0lID7MG/noVMrrjr9J69aeJuEKWoJcyrrRnm2C9VoPR5bdfQbv7MHKC7gMmjmTa/LKaqec7XIJqhbWxVgqwGWzDhRMph37SiYzWIVJkH7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9IACGmBzqbmezz3IbLDsjxOeBOnIgq0hH5d0RL4h3w=;
 b=KV5muneqwfW2FZxjFO2hLorQX/1c8icYfxMLtowfhIuhyKs9FCtc21ag0MK/FomVHDLvmG61wXzbQOxegfmhAqoXfkrOJbpAGfp+J4aTRpjltaVGFNFw5XRHqwQvHbwC43A5TyLx1i4k8exW4NGm+IC1q/SqqqojTUZNoP+XJtpFaST/w33es4k2fqD2rYrIj6+HKPmwdaaP3ebg1tyaCjXRi8EoEy+qJjMDY9ZJukACcqfEk93uhk70QzOWidci8PcGhKMBXuY2/aUCyyokJdEXgv6aLY13cKaYH/KIVXIznYtX13OywZJivExohsn4LRjGG3QMA2jMQx+fwymiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9IACGmBzqbmezz3IbLDsjxOeBOnIgq0hH5d0RL4h3w=;
 b=X3sJrfN7nTkIXn638bDLQ711apdqD8CzGCRU9h9/NTwoUHyXbpfpWTVcB+nHlLiLaexeTWCQHwJjOUZqqRrHH0pzClum6s6NaEQk6ldqh5ydF1q6nP97jzNNsIPWUtJsDVykv9LFGV9+pz1hu1mV80QONLUvoRmYsPUkFqWWyuE=
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com (2603:10a6:102:f1::9)
 by PA4PR03MB6861.eurprd03.prod.outlook.com (2603:10a6:102:ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 09:57:40 +0000
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::6019:5c45:ecb4:1982]) by PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::6019:5c45:ecb4:1982%3]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 09:57:40 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: RE: [PATCH 6/6] can: peak_usb: add sysfs interface to internal device
 user value (resend)
Thread-Topic: [PATCH 6/6] can: peak_usb: add sysfs interface to internal
 device user value (resend)
Thread-Index: AQHX3GGE5OusfFVuXEKQqDdIlNmmBQ==
Date:   Thu, 18 Nov 2021 09:57:40 +0000
Message-ID: <PA4PR03MB67977EAB8E9F1B720B12167DD69B9@PA4PR03MB6797.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 9e437f29-a57e-51e6-c0b4-9481fb461ac6
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=peak-system.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b22430a6-a5f4-42fd-9532-08d9aa79dbdd
x-ms-traffictypediagnostic: PA4PR03MB6861:
x-microsoft-antispam-prvs: <PA4PR03MB6861261BEC453A44B692D67AD69B9@PA4PR03MB6861.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iYAK6OWl2NOlxQpHdFWWESwNTUJaywXAveil7At7x/Uep9dtmssYhOkixNuj2UmdZ1i/AnhLvQzvkU76oA9uBX21tlUppYXwhYHkr1C7vkV9PCao6OhCmRPINarUTpIb6F8KIYV+A4B9XyfrkLEm3krJXyJUdE5ijaoTZo++PgkxEIP81JJQx6oWUojd85ZdCQezUAW43+omrQmV7XgMUsx31hriRqJ9d9q26lt5O/HI/hZlwJ8TB4L6M9BOvfR8NG437ROGieLxWKXneW1dFMhKUWasAxzUFbDDNruvMaPqSb0ujtN/5MqD/5BRj60vcW40SixxERGVy3fn08ArNuCHMwlFu45Qfj0oxhANXmrOqWod5kzn/ot6Nkw6eRkGxq2NAxK4Bcbg/1n+rq1aYac3P5buIcYiXtrf3VTjmb+geUp6MxCbSq32ROplc7M5IcYZSYiFLhF09G4fqPjV7TcLWJH9NodATr/WJdi8UN+9OHNKXgQWmHoA2QlhuaobRYJFkHgZ4zADwLRQuENnEO9zFet0YUW+IIY8ySWRlni3MK87HRr9YLOUD5hXb3GXcPOIBuAsX11DUBPftSA3Lv9bZD2iXlR8YcUyU5cRdFvYkBLs7rkROzqrpu3d36Kkd+Dn2/SHpb1qdjwM/m/JRN7bsQuv9xV2zBaNvchmXAaLqSyR7AKIcg6FfZfvT2S8YZ6TExZFv/Ld0UvYMrhAtQ53q7TIWr6X5+eSzcLJYpCsump72nLiYr8NfKjIq1viVYXoapgRDeVeHQpnayVUg1Hj5r5vV6/S2gQRuU0C3wc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB6797.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(396003)(136003)(346002)(366004)(376002)(9686003)(76116006)(86362001)(66446008)(64756008)(2906002)(66556008)(52536014)(4326008)(66476007)(71200400001)(83380400001)(38070700005)(33656002)(8936002)(26005)(53546011)(66946007)(66574015)(15974865002)(55016002)(966005)(508600001)(316002)(7696005)(186003)(122000001)(5660300002)(8676002)(6916009)(38100700002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Re5HK1Un+5fdD9MnSBVD2vdhUVqdxKMgvF78pM/uTaRUteR1Le8JkOa+zD?=
 =?iso-8859-1?Q?AE7p2geUNvA6Dbo8EH5LmU3RsUsVzfnAvuCZtelRucsbl/aAuL+PiBc5sJ?=
 =?iso-8859-1?Q?FejQj+4Qf57qmNg9znDfmgCTXtjzt7MY8t300LeViNMufPf3ii85iDMcN+?=
 =?iso-8859-1?Q?l42yJXu1f6aTAk2OKrXisv/Z14P7srk2cPgJbIIYbIYNjb6nmnlUGrNaCx?=
 =?iso-8859-1?Q?/tnnkfDYoQGbuV5ScS/i6sf18o+ZOpUQpFqP3UlABjD3GXmjPLqit4aYaM?=
 =?iso-8859-1?Q?/GCYQxrSygldYqomj+1dJ3b6Qu230/Q7NrgIQ81x3cc+Q8TES7NvrZ4RX2?=
 =?iso-8859-1?Q?moqX2jcFfs1YQkhVfK5tJJ70fydb2O9I10hFtn6WcBHE8+52pIMDuGnRMv?=
 =?iso-8859-1?Q?5FdCs0t3v9QBhDIRppwXnQoWKynR746JCZC/0+yHedOYka7sdtZm0yNtyK?=
 =?iso-8859-1?Q?Cj3/VKcTMv50XU38+tyFFnu+BqguZS7b6O3ePddtHtjbV1Rl54xmRXuDZh?=
 =?iso-8859-1?Q?A+/yYbx6EyqRgz9/EdWlFXD5wyKzraVL0fcRpkvGpx8W9+8C1BODl/SpN/?=
 =?iso-8859-1?Q?e3noCNTSIemrR7SiEf7C5IzCG7QhZuaIVgBzdCb8d6gg9zFQ1u3eXAgFgD?=
 =?iso-8859-1?Q?TiMcnfEkWJXtcGgbQ2wBE1lCZLfBhXJ1rCiBp1GnDozRWSpCneH0bDEQyF?=
 =?iso-8859-1?Q?ZETVYFaBE4JCVuFmAJ1kLqALDNpbzf6ZlVdsHsqqc6pX4PLU5gFyyxELiw?=
 =?iso-8859-1?Q?lyCgfLsQczyGQ39V963Xoog2erZqDngxezCLXiocFgeI3dM6hWrrozh/7t?=
 =?iso-8859-1?Q?y13HYGCC77Q4F0DMaYvinxNQ5LjkV1lAnd7wau5mfVmTk1AnQTIbUQze4d?=
 =?iso-8859-1?Q?OLN4d7VyA6ua8/EP4AXplIa9l9SUAp6ocVPehGEtAaUM1ByEMLRRRuQVNY?=
 =?iso-8859-1?Q?8PFevHqxUv/p0xZTQYrCBI5qpshoo2I9D0lcVG+Bra6PqNsvSY/ge+MuIp?=
 =?iso-8859-1?Q?/LeeGDK2gHhKprikdObJYZjfUt5rdaqeem4FbDABHzdxxOw4LiO5rQAKqP?=
 =?iso-8859-1?Q?g0Nfgr4KUPyZhua/Ya/BPuJI8qRdN1OnZDpQV+zYzw+5kHsiU3k+Rkgz4O?=
 =?iso-8859-1?Q?s+VZL13OakyvvzdULQ1NmZpjmCSM3epDecqnTsFX56qXFGUtlqr3U6Gr+s?=
 =?iso-8859-1?Q?bmhCz6h6iU5x856R+g3LrGO6Cg3LY/oiMdLkMoPGJlFosNtnrqsJuUCy5N?=
 =?iso-8859-1?Q?+bF2CEJgvixHkuXwwcY/AZaZSKEQKDY0oo/F6UB3/XO5Xgko++7jMbJv8r?=
 =?iso-8859-1?Q?nMqsv53K8Er8f/bPJl2ci3nOGCPS4fEsnRept81uCC0GTwaq+UlB12AV4O?=
 =?iso-8859-1?Q?yyk13skaWoAtAW69NKjtCn30f1xD7ywTuL0wUwwsO8OpQeA1xPaxWIqK8K?=
 =?iso-8859-1?Q?MsiURklQRacwam07Jgdm4KRfXeqSOgeUh+TE+KPRuA0/nfcgA9O1yDRnkD?=
 =?iso-8859-1?Q?Y7cgJBUNwssPK7xM3asfqnmy52PnVZVu2fYp/wsRjXHUM0u9xuqyL9HZOU?=
 =?iso-8859-1?Q?xImAnHLtAA0BqKEWxq1Gzpjuz4jYN+jVa6Z04UT0nHmWh7W0+8bFitvx8k?=
 =?iso-8859-1?Q?0Gk26jJ7u0phcvrlOPKXyHxX2kpxGRq8J8CCCA3F4sxnl4RtRnz7l6A9iN?=
 =?iso-8859-1?Q?C3Kg+4rWVFOBajKPfSuoSXZ9+flDBz3nbfgrkX8dLGLRp4Uf/moHGG1bvn?=
 =?iso-8859-1?Q?WVaw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6797.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22430a6-a5f4-42fd-9532-08d9aa79dbdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 09:57:40.4878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0O8/4ueQ1oHcVMR7JtF3DtKmF3QQh09bw+oCmoOfShxpm7Gv6BHOCBXsvWmQODJ/pAEGd9gPPqVO1DoAO7/c274W2KPWM0Njdzok40uWEJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6861
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

I understand and why not. But:

1 - we were inspired by the existing in some socket-can drivers
2 - these identifiers are not literally stored in an eeprom
3 - the memory storage address is not necessarily an information known by t=
he user, is different depending on the CAN-USB interface and can be subject=
 to change over time
4 - reading sysfs makes the assignment of an interface name much easier IMH=
O

Maybe you have another suggestion for the location of this entry in sysfs?

Stephane




            De: Marc Kleine-Budde
Envoy=E9: Mercredi 17 novembre 2021 16:16
=C0: St=E9phane Grosjean
Cc: linux-can Mailing List
Objet: Re: [PATCH 6/6] can: peak_usb: add sysfs interface to internal devic=
e user value




On 17.11.2021 16:01:32, Stephane Grosjean wrote:

> This patch adds under /sys/class/net/canX a new group named "peak_usb"

> which contains a "dev_num" entry accessible for reading (display in

> decimal of the numerical value stored in non-volatile memory of the USB

> device) and also for writing (modification by the user of this value).

>

> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>



Please have a look at the ethtool eeprom interface:



| ethtool -e|--eeprom-dump devname [raw on|off] [offset N] [length N]

| ethtool -E|--change-eeprom devname [magic N] [offset N] [length N] [value=
 N]



That looks better than adding a custom sysfs entry.



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
