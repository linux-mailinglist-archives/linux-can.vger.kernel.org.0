Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CF94557DE
	for <lists+linux-can@lfdr.de>; Thu, 18 Nov 2021 10:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245086AbhKRJWP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Nov 2021 04:22:15 -0500
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:11318
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243344AbhKRJUk (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 18 Nov 2021 04:20:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9DiynNar87lwt8Ds8LY5pORvt2wIwGLUflkwaxMa5G2hmyhWeCjViE7tIidzpaeyiUufoCOcFBQ1qYizR/qgUmbbywoy/BkL+RMOz3rD/cIHGJyv6sV+9CcENvFCjYdyuI0aOY8fxzWe0i+ZXEqb2G6Bt0zNL6Y7aTE128/4C6CuW6sqHihflPq3H+WptGuEiZo+99mUtBtpjEtax/CMNuJiAujEkNniQW7onSJphS4FkhN80Y0HDaFa2OnlUBeGst5MlhupBJeu9tgIn1ETXjaaCQXEVGA+xlW3u3E4NosIXeDx7EKb8luiq+a7397QQMNftqsamNgSRefExncxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmDncsg5NCnP1CAQGXm0xAkq8QSC2B7WKZzYf/mS8QQ=;
 b=FDSslPSF45GVICvYpjYhLs+91swGK/Lub6AAEBR41rAFusTBT49Dnt2ExrXPMUhI3ZfAOVNnGQudmkx8guKeGK59dFn2zhbA4XnmX03+gMGBK8Ckzj6X4e84KYAd70c/5b6V+ghWiZpVu5PReMurXKUUW7fVMFdMk9nHNM3ePvCp3+yO7EEl9Xs3zEF9In/h0nWuQGCgOGrqEB4A6GnbZuulCkIbaIDLET0xY4aAeXGMRSs+Crn3nD+A9SsyN5CVvPT8V5ou4ffdF/yL6CCRHn//NWfG/SnfQ/enyEEc3hVzsvmDdIdzeX7+ofX5soECLqftY6xq+1Ml7SKwZkK+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmDncsg5NCnP1CAQGXm0xAkq8QSC2B7WKZzYf/mS8QQ=;
 b=42eGOZhNENysT6/o7tCAKJFFkNeT6XazYBhdBzHxmnSzUC5XJf9yb4Hrkmqk4rzqxa9KwTJhZqhADbrMI9r274eq2PY1TXy5dPm5Gk/NG1FKZ+RmSnq1wxJ1kRG1bqNXyAXFXjPTjhcTFmf4zV99DW+4HTxnIRClqSlcsk/QHpQ=
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com (2603:10a6:102:f1::9)
 by PA4PR03MB7070.eurprd03.prod.outlook.com (2603:10a6:102:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 09:17:37 +0000
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::6019:5c45:ecb4:1982]) by PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::6019:5c45:ecb4:1982%3]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 09:17:37 +0000
From:   =?Windows-1252?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: RE: [PATCH 6/6] can: peak_usb: add sysfs interface to internal device
 user value
Thread-Topic: [PATCH 6/6] can: peak_usb: add sysfs interface to internal
 device user value
Thread-Index: AQHX3FqapgYG1rXCWE6c4hmVJj5lNQ==
Date:   Thu, 18 Nov 2021 09:17:37 +0000
Message-ID: <PA4PR03MB6797D7F5CAA2F3AA0E08AB5CD69B9@PA4PR03MB6797.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 04bc8351-3e6a-bdd8-b9c7-577a43217b58
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=peak-system.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5064ef30-b7b9-49f7-655e-08d9aa7443bc
x-ms-traffictypediagnostic: PA4PR03MB7070:
x-microsoft-antispam-prvs: <PA4PR03MB70709BAE54472ED9E93B59B1D69B9@PA4PR03MB7070.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4kQ1qxDmJdCxvKglTiNQjXPs3BJWvhnxfMCxKgCHc/9AEPpZoHjc8BYDcO7mK+b+Fsf8HicpiffmPdEl+Cx+jLWnC1dC6bvja74uqQUKH5sRmTQbH/gMLUP1qieP6X6fy5z8VRtjEFIUk3Ln27czCu6DCAnhv3atZkoOiF3/wyDuTtaB2JDVbqA9HIDoxZSs3UOMWTZ3fxIHF58jscTXE2Vm+jF6lqFYtrlFWNhl/v3XycZQ56OYuEvud/pto7kcWm5tFZ9xQ61N1PDWJsfiopeQUEIpUTYCOS02eO24yJV5qu9PvBFf6M6xMIYF/GXy4G+BZMe0rTZ8mmZlaz+auXuMvpJ5y2EJE8/mUbYrFxH6UMujoubHs1FU7l/bex/u/U/RWKdqvK9Z/7d7VcLLbZzCADe9y0hyeXKZ8rAxmXUKxxdH53msT8ACCRVAFSyxptbd9AGDu5EthnJ+ypolP+FyJj3qSupAPH5+yXN+Q5fT5X7TedcTLE1w67geby8617dKaMbjK3Y0/p4FlfAC43n4DsKRrrb/C93NdmlWHSAiMz3KQBKj5miSPyu4oWRVOjN13WQcuxRJ/cP+0fGtoFhsw1RX3lnllpVq/pQK91krabl8DxVUKsEAjMz5YO/Hef8jHO4jCmicSpMiZwgQkhIm4gfpY3rqK1g5euaFLR4iyDD9pL84WDbOHLuB3ykOfsuVobwzQfk1HLjBHZ3Wv3IeN7bi2M4nsuIOrl4LOkCiXUucj7PeL7rsT4bTUazOLZjnV7PXYZHLGmCc7ZP2j+x0VZZoX/uAjpMGM4iWM3Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB6797.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39840400004)(396003)(376002)(366004)(136003)(33656002)(38100700002)(122000001)(4326008)(83380400001)(26005)(186003)(71200400001)(86362001)(5660300002)(55016002)(38070700005)(15974865002)(2906002)(508600001)(8936002)(53546011)(6506007)(6916009)(7696005)(966005)(316002)(8676002)(9686003)(66446008)(64756008)(66476007)(66574015)(66556008)(52536014)(66946007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?OaOQSL2l+da5uhP+tnJLN9USYtgX96VOya80macz19Vm7nNdzNkMNzZw?=
 =?Windows-1252?Q?XMR6c9B45BTiV6Y3Jn6JdH6TGqBWJ8GTaLCFcr8Js6XLwhJqGAdOADJ2?=
 =?Windows-1252?Q?IYbCnlusQrcx4r2UfE9KcdpFq8duQJUn6BY7qj4tY00s3qMHdBa+FmrR?=
 =?Windows-1252?Q?/H0ENshc9OSE8Q6ZLDrKrT/NjLJolCkvruZyKjA/iO8GIqSgyDYyTnv5?=
 =?Windows-1252?Q?GkcsEAq5gp+JTORbWBk+kobmUPK4EMLbN/Dk7CW+bzXZ3CW1P+/FXiQ7?=
 =?Windows-1252?Q?UkHU45mmdeS0giFvW9TVdztfpXv7ku9WKS4v2j5AY1hS0/hWEBx2YiaB?=
 =?Windows-1252?Q?KaJzRn3I8/Cft8a/rQaPt3MPd77wnArGbFiB0PM0IzG+iaUs6CMLKEa5?=
 =?Windows-1252?Q?nWrE/xz2TIrDgfn71RWOCwHtQ00OwmgC7zkFL7Eq7dUbygObuUOaBffC?=
 =?Windows-1252?Q?h7SUSLpGblu74iEbJMWCl6kWxIwe6RSOD531qxZp3oySjMzn5Hpv7AtP?=
 =?Windows-1252?Q?BTDkyv82psCzre8aAyiA1nIwG8meraKBO4IJOlhJQxQubD3XO4VvUpqu?=
 =?Windows-1252?Q?f55kefGgJL7ywfUyvwjan9choDQCqok+gKOKqV1wqRC2Uwf7zJGwfIy/?=
 =?Windows-1252?Q?cvKt3XZmeQsArOI50l8iO1SNdos8NK8rfErFtXb7Uu1/6O9QcaHXuzl0?=
 =?Windows-1252?Q?TXWHWiXuinwcQXFiJHkpHMdYD7rqKMe7DXrSswyTCpia5HuhAjUfVf/v?=
 =?Windows-1252?Q?E2FjbjlSXOQwOj+q1aWD9NzjIyAw+OdMs9W0fHZ3H2YugIW3q38lSBg6?=
 =?Windows-1252?Q?AyaBOApaIgCCT0NExiKomEDMTDcIHCYMbWtc9bgIAyBpsgOQJO5Z8I72?=
 =?Windows-1252?Q?tfw/UOnZKw8EXoT7km+L2UaRHF7BvQqiuusyFR6eOXc620RofAC5RfkV?=
 =?Windows-1252?Q?Bpolzym6cwgNVzBVjEMKVK18gy4ShXD1AMmW5huNa12/V/cp3PivfZxj?=
 =?Windows-1252?Q?ESj/Cx52rn6w7g0/q69yLP1TLzHOz3Hdl9a5xBGcbMBFLPBfiFZfhnsf?=
 =?Windows-1252?Q?Z3hb+zCq6h5YbwZ8Ix3R0o12YbQokwwefsSRFmnqHbVDn2bTL9fGCkBI?=
 =?Windows-1252?Q?EVIKS53Z7UXGB0Vf73XWhF46S5jgqYFuN5MQa9Or9QO6s9gsG1++yOVS?=
 =?Windows-1252?Q?uwe5SYry3631WqsAiGPHISV0I6FqehgM/tlH6bDhvH2sO6D8G8qmxKIM?=
 =?Windows-1252?Q?eQXu3FVtG4vt2BsR71WsE3WSsX+BIaE5980R/wyJoV3LfHsH9AIxUbFq?=
 =?Windows-1252?Q?3JOtFqO8ii95awVk60fNvtg3cw3bA/Nq+bDZiKIkcE5LZfpfV9T4R/jy?=
 =?Windows-1252?Q?rTQt1lKV4/SM7QEd224QFCE6mPEZLG0lUujswB4ve3UnhXjypxbbAOKq?=
 =?Windows-1252?Q?RUTeg2PP9PsSucF4nWp/H+I715lqgPyitEYisxKDFb/z7dud8QVy+Lps?=
 =?Windows-1252?Q?98MRLFOqp2zixPRu6e7L6uoBeR84u6vPKjoTHQLm9PGvyRufkQHKvCA6?=
 =?Windows-1252?Q?wKtu87BOQ+EkTP6I5vfdrtqxh8W3AYlTnDIH5z0pzD1pZ9XWbwtSf9fo?=
 =?Windows-1252?Q?d1haeB3yQoRMy9HwsIiAIz71IWs+tYddUSOVPLqS548Wz/Ig95T9qMVB?=
 =?Windows-1252?Q?xHRq8/MvIE8sMtmggLf7KvFq8VvXdF68DWjUj8QZTA8IKcjGxfGIERiu?=
 =?Windows-1252?Q?fi3sp3cyey06tG1vvbJT9fQwpXI/SwlmIIPdLkMwuatca0USGtGyv74S?=
 =?Windows-1252?Q?8lTvHw=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6797.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5064ef30-b7b9-49f7-655e-08d9aa7443bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 09:17:37.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ih9ir6eADFY/vJH3I56jn852YsCJ5dxcIszamGPpeoXwrbndVtTT1UhMXBaCHeud2Zs9A/vE8EVOvhbPlg4groPxVqXdDxW25Wz2lD34mdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7070
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

=97 St=E9phane






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
