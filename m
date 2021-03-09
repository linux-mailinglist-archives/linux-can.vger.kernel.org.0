Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7DA33287C
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 15:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhCIOXJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 09:23:09 -0500
Received: from mail-eopbgr90088.outbound.protection.outlook.com ([40.107.9.88]:35712
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231283AbhCIOWl (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 9 Mar 2021 09:22:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmCS8hTk3hSoq0ZWTvfIaNxFDGytTvl5gMx6wZRRISH8KfpD8hCuL+yx1YjF++DbDHE0zU+UX/csiIdEDLg+DP8Vd3ubzZ6bpdkmoFYnea19QQqhLKr5kO6AhS+jUKmtmkeQotqa66MwXkyIuj3oHBUYwr/oL8b1mfbUyW1TPGZDdS7mlf+3AQqduj5Dsp5BbS1DtfAw5j0ZgDH4ndzfs6fMlcvVVJByYtBHgvnr6vc/aM+j8OD/32qGnazLzNa7Ek0NwfqtVfiIsWsipRI/d1qu1xvCnUysZa0VoJTR4GpjL7qF+8xHUt+7SovnlpUZf5Innm98VKL1WfvWndUoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO/ChSH3iUpcWC5/b8vrXiMCBpzd+NcfwTuRqnyb+Qg=;
 b=HpzlfcFsn2vM7fcVvtMpvN6XuSow6f0eNcZMIs4pkNP8U3MMuBfgphlRAsFoTQFd6GhIVpCVne5mcoh5U2n/su6YlppsIK98uA4QW/YuT+OpH/BpRKwl/IADo9torqsf7KYsCiVE2cAUXbK1qgU6pKE6lmtqqpm2ZPjCqKlgPRUNrWvz3AGdJuFWI+9CWCpDIvXfpjHZiqKn2vcGhC8n8NV/lYdG8NBwkU0spgTXZG9MhDG88W/XgBFuuyqIV3hdMPhesgPF2NWhD5+ms+UAqsHsEoZGgV1wivUztyAJBOhWP3MsHvmVzluxlWsL9MDCOLX8t7LE8ILfRfc6pycMzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO/ChSH3iUpcWC5/b8vrXiMCBpzd+NcfwTuRqnyb+Qg=;
 b=JU0oO1yUwcMUAmCOoXUfrO/dzPOMEdIfy+XqdVP6w+MCTQcPRFnbqTLJEag23RubOVbAQgHMkz+nE1C2pbGzaGjTNigqkZKL59giMp9KX5P7oBmIK6czqpbKzHQuECwSKEWPfmqZPtYLi/w55jgQElMxa1XZ5Wn+/0SqQdklgMA=
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com (2603:10a6:102:f1::9)
 by PR2PR03MB5340.eurprd03.prod.outlook.com (2603:10a6:101:1a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Tue, 9 Mar
 2021 14:22:38 +0000
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::6195:aebc:daed:9e0b]) by PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::6195:aebc:daed:9e0b%7]) with mapi id 15.20.3912.029; Tue, 9 Mar 2021
 14:22:38 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 2/3] can/peak_usb: add forgotten supported devices
Thread-Topic: [PATCH 2/3] can/peak_usb: add forgotten supported devices
Thread-Index: AQHXFO11CaVOiqCz+UaED2Bt2GaNzQ==
Date:   Tue, 9 Mar 2021 14:22:38 +0000
Message-ID: <PA4PR03MB6797F30B0A13B189E969933AD6929@PA4PR03MB6797.eurprd03.prod.outlook.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=peak-system.com;
x-originating-ip: [89.158.155.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79277edb-2ed2-4f34-4e6d-08d8e306cac8
x-ms-traffictypediagnostic: PR2PR03MB5340:
x-microsoft-antispam-prvs: <PR2PR03MB5340CD6A468D096C176D1268D6929@PR2PR03MB5340.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IwuZvdy29QezM7gTtD1zMTBWmF7nBkIFvB2wxmWoYyhVviqJdDT42MhZWCzC7l8b8iYAfvMv3+lWZaVr/ukFOxSxV5WBOAqxS0GBl/IOA63fZsJryTETrm8pGg1n8ioRSVXO0ugiYIvR8c7eLya0ZUkuemd4qxNZ52nzP6cgeTiImXfs1yr4vdbi5SxiqCeFbtSfGh0LBOS3PL7C9gTXSuH9gLSc2+fRRPWFwyqdR/+M0QmfLzaowBO8i2+HyjnrcYEqaeWowsOE9jbw5hO6KXab9bkVilVYxKmZnd48ldket/hYIsB1S2xcT2vEAAV0RPbX4UhE2fZHea6eNICLV5uM8EFlLh1yX0lNSZLWvkam3P41SSIrmDJXFE0lFTLVdMff+Mnal+xt5aGns6LegHpujki/zvFTP41zsRBoG3zZVEOdWq2Q0Z09oTATWol3ohL5YmMRzgSHXXIPEqoihO9kLij0BIn/vnkHcLI78rxJm+1upCxU49jHNvC/d/mmyuKQOJGCC1UIHiQ6LIYv4T7mmKr5tcrIp6msWCR3IG13eKTowIkHAClVe6p5hlbpCx181Ch/6VfJveKGw+y7AcHWaoa7oQulmx42nvLmKSI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB6797.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(39840400004)(366004)(9686003)(8936002)(2906002)(4326008)(8676002)(316002)(478600001)(15974865002)(66574015)(64756008)(83380400001)(66556008)(6506007)(66476007)(66446008)(66946007)(55016002)(6916009)(53546011)(76116006)(7696005)(71200400001)(86362001)(33656002)(5660300002)(26005)(966005)(186003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?kFexEDFk3Q1tvVZ6614EhhSoCb2ONRY2/yw+ugjNWePfmdNurswNpRH13l?=
 =?iso-8859-1?Q?Zwipucw+rm2q23V0hzxzqjzQugYpa3LmzmAtwXrBCV/SO4V7cT/Zhvf7w3?=
 =?iso-8859-1?Q?dMJvhxjJposXUUn15cGubVrFzhgL86C4vxtJjID00BkCgtXPFsSOJ4JZJf?=
 =?iso-8859-1?Q?6vRX1E1rAYgCav2yleqK3DqWWXeDLUoxHOs2N8tiCF9iUh0B6pEab0jkqh?=
 =?iso-8859-1?Q?NB/VE4Dr42d8MHtrwuM62jBnuJ6KVbPv2FaOME/HO2v+orlhoGF+hwr1es?=
 =?iso-8859-1?Q?XOPQbPLQNHp3MOyo+CuUR/fZ7NpPJO3HFxjoXpiAPhNPM6zYqLzjt0UN7m?=
 =?iso-8859-1?Q?AUMJP0RdzIHBK9xB2WGmv5m2zmsTwDMpkM+q5vnm3Y3V76PeZGjDzyZ+ts?=
 =?iso-8859-1?Q?BB6vYIx26YzGK0326bOAc8v6woETZ24H8htaslWPOlM7GQrB4lB9J5oaJX?=
 =?iso-8859-1?Q?eCsFyyTdLjAnCObED04T75I+OpNsdTsGl0Hl/Phjn2VeEPAf3HJmKUvwTd?=
 =?iso-8859-1?Q?sfLalCSIQFKBHn7ibiEjaBh90pbjbd3vpkV0v8LOWqIrxZszL8oeu8Vtyo?=
 =?iso-8859-1?Q?nhv3FTsX/gTvoAC7tO42wNpQK3k3vzVz9ooxEPXut1yMaDUi4outS7Y9wa?=
 =?iso-8859-1?Q?8OUDHph3HVPG+pwvK0J2WuLaw1NBzz88GDZB0MWut6dQKyt4kU9oCcJdiu?=
 =?iso-8859-1?Q?Ebn+MIJbNNCLN5A5BquHjXakkCPUknYs34Gx/oASNR5nmTA6nzXNoJU7e7?=
 =?iso-8859-1?Q?NNDMWuxtQmnQKO8ifPdoFY8wmYqmY9w6kfAdPIFFshUy5tix/SEQ2H9tmY?=
 =?iso-8859-1?Q?LhVJFqsPNFg/ELsj6V245WkMm04ryGSRBPKWVrM6VKRysstUcHzMNjaFMX?=
 =?iso-8859-1?Q?Av5er/XRVWUPrzHNWSTQaooCC/r7C09SLR80vHevfpM9ow3b0YVnPfWV8J?=
 =?iso-8859-1?Q?ABK9wmGed7yhZWFU0pYdAIFrhiWapiaDga92FJ0SwFH1rAa6aaa4zYe5lX?=
 =?iso-8859-1?Q?ZuXd3S33bvkF8wtZsiqu9u1V9/26i9wXmxE0K3/Ng2lCsS5mgJMknL7wmU?=
 =?iso-8859-1?Q?+jBBv0L4IK+QzdkTCIjduMIeFq8s9t5/SDthT5yi/8jIq2lH5F3z4B3x0V?=
 =?iso-8859-1?Q?knbuXTX+VHdae0j22ex9/c4Eytx1VPy/VQMjlkEhDJbJZos3s2fk8BQn3I?=
 =?iso-8859-1?Q?Do//ZhPrOEtVqXaTIoqRkVoT/3oq/AN1Hv4503mdQurY9uF8NRaIKb3K6l?=
 =?iso-8859-1?Q?FBTaPBtkHTSvTk89CnHaUV4W9894l21eIh2Lx+UlBlgRbEmyQ1UWhBRzWl?=
 =?iso-8859-1?Q?GtcS1LSu5v0X4fiBa4+kV4WaK1et3KSfOzo8zhM4h23tMdzGBDykDWDdmW?=
 =?iso-8859-1?Q?lt47cgHAAX?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6797.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79277edb-2ed2-4f34-4e6d-08d8e306cac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 14:22:38.3353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjX1YTOv2C7PxmBErvjR5U1lyO0IZWdPq+6x8bJ0oHpi8BKCnEMbMsjd/VGPDHsPqlWKwSXUfUkoFc7MNxm50b+BCs3wiWuEHc67qhq3Y+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR03MB5340
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

PCAN-USB X6 support has been added by
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Df00b534ded60bd0a23c2fa8dec4ece52aa7d235f

PCAN-Chip USB support has been added by
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dea8b65b596d78969629562f9728f76cbf565fbec

Should I update the patch description with these commit Id and push a v2?

--- St=E9phane





            From: Marc Kleine-Budde
Sent: Tuesday, March 9, 2021 12:07
To: St=E9phane Grosjean
Cc: linux-can Mailing List
Subject: Re: [PATCH 2/3] can/peak_usb: add forgotten supported devices




On 09.03.2021 09:21:27, Stephane Grosjean wrote:

> Since the peak_usb driver also supports the CAN-USB interfaces

> "PCAN-USB X6" and "PCAN-Chip USB" from PEAK-System GmbH, this patch adds

> their names to the list of explicitly supported devices.



Can you look up which patch added support for these interfaces? Then we

can add a Fixes tag.



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
