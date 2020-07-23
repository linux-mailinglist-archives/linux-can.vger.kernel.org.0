Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E48422B1CF
	for <lists+linux-can@lfdr.de>; Thu, 23 Jul 2020 16:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgGWOuG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 Jul 2020 10:50:06 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:16514
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbgGWOuG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 23 Jul 2020 10:50:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNqJbIynLzyhVamFAoclP4W9T3kCSXtBK+9ziXj84RrGBrqiPI5UTTsbsnTaq08j7JAY9UOM2uQ99ZQS4BuJ70MYOm1Eh9CjZp0hbdAQlePSARt3V02M0kOaRrWKwuk+nBCfX2nXjsgmwt6z/8fM2DQhgtfNnbLfW0JkMuGsl8WRPRXULrzBtBGPNdhrLCNzMju8DsFDjZSfkhUzbc3j2DrD1xe9AP4Dv5KD6PbunL7gW/15/OZpVdeH5Jvel4fcryy7B2e6u5fWe944Lc2Z4tNXuMTbfie7dzpWVbxluIySxfg+TL4HHbS1/78S7mfmHetmfHSYd72VmCpaYI300Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk57asHVfHuLVuDzRU36iY0SxKKsUX15x/mq4BG4hBI=;
 b=bhY6nP1ozYjkW1jY4agq4vohTIWT7WyRIGbOVkJzBE6fpV00tmkLjssYWMGZTCtNn1swNdO/P7jZeiTd2uy9Q1MWRhGlpIih41qpvjAV2I3W+h5QLBgZFk/RsNvIjkKywtD/G1qbTF3GoWwnOj72qOaMmEbHLhCvD7MgqX/hmQiJgEb2OoOtz/I8qbTJqxKU1Z3ImbHgVIGpievu/D+eSFOxj+H7WUiyi5/JGoKnhuOAQpnRFo0TacSsUp6CoRYFwmd+3eKwk8eYHgrE0fmj6Ve7RMMqzydcR9JH+lx7M8M9S+Rk07I0so2QCdJ1yLsPyzI5Q/fY6B6gFiBeDiPGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk57asHVfHuLVuDzRU36iY0SxKKsUX15x/mq4BG4hBI=;
 b=4QmkwWF/8DWYhSrEXww4SuwLRIugorH7VyJdqxQtuYEuJTmHrpSt9qBFmJg/D4cxhJS2LTLJQQgLL6cGu+iflY3yqqIayI9tn5aOskou46MO5hJZ++Va/pB81gn+u2ya0PNC6w4LO4Pz02QDuH9qQ29QLS548vj/CcpQ7a2Vnqc=
Received: from VI1PR03MB5053.eurprd03.prod.outlook.com (2603:10a6:803:bb::18)
 by VI1PR03MB4319.eurprd03.prod.outlook.com (2603:10a6:803:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Thu, 23 Jul
 2020 14:50:02 +0000
Received: from VI1PR03MB5053.eurprd03.prod.outlook.com
 ([fe80::6816:82a2:7f79:f1a9]) by VI1PR03MB5053.eurprd03.prod.outlook.com
 ([fe80::6816:82a2:7f79:f1a9%5]) with mapi id 15.20.3216.021; Thu, 23 Jul 2020
 14:50:02 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: About sysfs usage by socket-can drivers
Thread-Topic: About sysfs usage by socket-can drivers
Thread-Index: AQHWYP9G2WsNUL4tvU6tSrg3yOiV4g==
Date:   Thu, 23 Jul 2020 14:50:02 +0000
Message-ID: <VI1PR03MB5053B1FB7A45D4243BD1F095D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=peak-system.com;
x-originating-ip: [89.158.154.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2359da59-d21c-4fba-8870-08d82f17adea
x-ms-traffictypediagnostic: VI1PR03MB4319:
x-microsoft-antispam-prvs: <VI1PR03MB431975213FDD215B69E9D2C8D6760@VI1PR03MB4319.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: atlDBGlWsIzzxWHK+2ahrb0cnW1H2jFbi3rz92wspofHK48980/xP+WS+JERJe6GS0xGrh9IrqJnQCvr4FhVKWJbV+hikk9jkq6BesK4bubsGEPxrjCGQ+gAGQmbmIfm0gwQo4ETUcJ3wmt9BoguQcivIkat1CWjteWwQEt6CX28gCYIXvF3TykwoD3DSppKpr2PLdiA+pj4sSwDwYq5NFF4IEwV/4kcVbuydrlqFbG8CtCXoLxzGYhm8Gggax3BouEHBNFnmNyBG7gzW5VOUsIIItiFpkjwvlk0RG0jNs8IydNYrYLIlD1FjE/EDlKbGq7KkVJDcqg/e4tn9deARo+3hNgJldAfj2lKs09ceKAgxZEEjk6hl3YfaZ5cwWOTrq4AbN+HfHUVjbIjBtE8JA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB5053.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(346002)(39840400004)(376002)(396003)(2906002)(316002)(64756008)(83380400001)(66476007)(66556008)(5660300002)(66446008)(55016002)(15974865002)(66946007)(86362001)(83080400001)(76116006)(91956017)(71200400001)(966005)(66574015)(7696005)(26005)(8676002)(4326008)(9686003)(8936002)(6506007)(186003)(53546011)(508600001)(52536014)(6916009)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: GpzAQTgaXM7o3W755koJO/OXWG1n6J5rVcktBDiaPveCrDyIhUuwEoolJUQxmFujsdReXzNWHctCyRrl2Ccr3uA+1K22+UBrLFhSn2qct98OTJONqFHmSn0At32mvCLHbBzEnJTJ7GbH7iZPAtbpAI7prg8ze7ufulzA3JvaHnOmfGjBtFjIqA8j8nOnGBEepial/qAO2y9XPLi54u3Bghqv7xv3SxmMv1D/qGEkxSfODYdhAgI8L4NejFS9v6e1I3Ztz1FCpNOVLyBcoXKaz6Qr2/NYpMUH52c2nC4yUiRkkPNXumutr1a39dgJfMdoQffJ5qBD7SZ27wulEdxnvTElF3V9Nhm8zmd5OcYYOIYwH2Lgr0DQDsk+lf7PZSykG7AS2rHBjTcPUZpVioOHa6ZcVs64nO2o+nT5D2wSGILXkYwq0g4nKR9qMbJ0cP1HjWvSI2dJ6KrlfzMPz04zkSGZTvdG7LxIzHL+4ZUVSBOyq1BWJlVXgj0Yw2PEDlbW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB5053.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2359da59-d21c-4fba-8870-08d82f17adea
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 14:50:02.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XlXu5xTg65F6Fk3ol+tgMe7k+EGkUkR+fLXfdFzTjpB7ge4iH33ZXzwrBxfo5Br+6xmS6OIuw8mr7FGtpA0qPCCsxIKgtZVM5BxvC6+9DZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4319
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Mark,

Thank you for your answer.

We've several pending requests regarding:
- changing the default clock value,
- reading the bus load value,
- using a flashed device id. to better control the can interface number,
- identifying the (USB) channel
- ...

Adding attributes under /sys/class/net/canX (or into a specific/private gro=
up) could be a solution.
---
St=E9phane Grosjean
PEAK-System France
132, rue Andr=E9 Bisiaux
F-54320 MAXEVILLE
T=E9l : +(33) 9.72.54.51.97







            De: Marc Kleine-Budde
Envoy=E9: Jeudi 23 juillet 2020 15:37
=C0: St=E9phane Grosjean; linux-can@vger.kernel.org
Objet: Re: About sysfs usage by socket-can drivers




On 7/23/20 11:18 AM, St=E9phane Grosjean wrote:

> Are there rules for using network interface sysfs, in particular, can a

> socket-can driver add its own attributes, please?

First let's discuss, why you need a sysfs attribute?

Is there a better way to do this?



Then you have to describe the sysfs entry, e.g.:

Documentation/ABI/testing/sysfs-platform-at91



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
