Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454E0332936
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 15:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhCIOxl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 09:53:41 -0500
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:47696
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230147AbhCIOxi (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 9 Mar 2021 09:53:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuQFy+PeJvKDm2XPbHad9ytAk6aNP3YzGJBjnixhKrtw3wpV6BmG6otTM/bcIf4PzIYhay0nvs2w4nNRwPZTg68kU3ddHfDu35fEaKtzh7KTA9Cg1HLhP+WCCMDGEq5iE3AWBExqmyFpfW6wxh2wGB2uT/85hJYISgZjH4/+CMUuufnrwr54rUTDGAXwJ0goU7vTk8t7T9wFgmQI6e9wyQJz5YRB1ChbfjdgbBjiwgEz1LjzesYsz2MXtTm8/Fo3wfzhz3RPNHQi9tC47uCN97Jgcvxxu6lL8w2dwkZ9TfPmyIX4658jB9rIj4nCGmq7Uza78dl6JDb120MeamcglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrBd/FmUfM7e1aAJewcZErBcNTZaIX7GrVCYjWQQR7c=;
 b=FInNufn4SeXH/MG7TUyp2XCyINTgjbI3nJa/KA5nIvhtOJF3MCovSN51hAvPJ0Dy7W1BDPyE/StLXPIgazj8vix/tzGGu+Hs/1CCTCx/WDmxbAVHjBgVhCfWVJsZXVvCygb+7zCryB/8z/tYn+dQl7TtBCX54NHfDoK6b7Yt+EqPuBNPWu3bqXpIsS3gtc42eLwOB6u6vnB1OWxOOiVLqoso81jHQdrfiZccPtRPOr4KmT26NJ1QuqmkF3993wsnwf+GRGsHi4w/+8pLzR4xDBaaYW3v9BaXKk7x5RxI4lXCuxCTdhUIqNwKSvv55FF94D6GRCGFC7qBKCs784gvWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrBd/FmUfM7e1aAJewcZErBcNTZaIX7GrVCYjWQQR7c=;
 b=JpY71drahFgSlW6nHlzmNgx7NrRaL+UzQsX9wyNECTP5VUYcgPIDbBVpfAYUfVnHqFPXNshLI3C9BipPY3ed5V1Qaq62VAudFU0sXBpiztrDmrKCvPnNV0YrXsL8vKGxfPmTMCOfRY0fmEcbJF84DFyXeaEgiTsuxWDdJyqSkT8=
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com (2603:10a6:102:f1::9)
 by PR3PR03MB6635.eurprd03.prod.outlook.com (2603:10a6:102:5c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Tue, 9 Mar
 2021 14:53:36 +0000
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::6195:aebc:daed:9e0b]) by PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::6195:aebc:daed:9e0b%7]) with mapi id 15.20.3912.029; Tue, 9 Mar 2021
 14:53:36 +0000
From:   =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 3/3] can/peak_usb: add support of ONE_SHOT mode
Thread-Topic: [PATCH 3/3] can/peak_usb: add support of ONE_SHOT mode
Thread-Index: AQHXFPIyGLGu5owiGUCGVJdeaskvlg==
Date:   Tue, 9 Mar 2021 14:53:36 +0000
Message-ID: <PA4PR03MB67977F22B9373573ABD62A59D6929@PA4PR03MB6797.eurprd03.prod.outlook.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=peak-system.com;
x-originating-ip: [89.158.155.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 001c3317-8418-4d42-7dc7-08d8e30b1e38
x-ms-traffictypediagnostic: PR3PR03MB6635:
x-microsoft-antispam-prvs: <PR3PR03MB66355C779531A5ABC6A23E7CD6929@PR3PR03MB6635.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sqf0mKYxP4I+Ojnxcs7sg5rRHM8ePIwi9z9ZXwkVt+mZtBegIM2xGEKDqCtFW3TlOCaXAIkr4z7ZjPw4OaMbs/5ODL8L9gBv3sTDUCUM0ityyCVGF21sCiZYSuJVg8KS7afUHSKBKLbMfIAZOy/HhjBOP1qwdwBBC/aZufp4a1UYcSfyMVdZ2lYHh3k6OLuyEbE/easrY8C5u7iZPBcvfhSpxn8YxqlGHaz2YtYus4T1KTvdSIuyPax9urFWFs1VRJ3vwwacwC7ovJAI/DHB6vE9Ed8n0YLIcVAMyUdCUgmUJQLDi3hO0ocT+7hqr8XH2KY1pluKZ6S7NJ2gPdaGyyUMg/8KPr4VhVyS3XXHdX020xXj2MvWbkxWMCWCLbEEmjBHz+YIR5/KJ6VeU0hoFK/vvz+7/iihhUkiQ7T5sMPEM755Q8tNLi7Xu3NR6GEBCDjPjfBLDKKNYSUNsnxIo+geR3Dip5FEGW6sKKrYA50zMmXA4bSzOwpSONoPyFGGY63yCL/okvsaW33c61VFWJxBCuI2uHYblHIB9oCQxJ7+9NRk5Gc4t+n/Aw+zf9WNQsRR+zIzSpbwEO9H+f6+Jv6Q5xIK/OTySFi1QpQdyWk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB6797.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(396003)(39840400004)(316002)(186003)(110136005)(9686003)(55016002)(6506007)(966005)(76116006)(33656002)(8936002)(71200400001)(7696005)(8676002)(66446008)(86362001)(2906002)(478600001)(66556008)(52536014)(64756008)(53546011)(15974865002)(26005)(66476007)(5660300002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?6roQdaOD+6GxpouSrTvBxgvwj7QBaWThgK1UfK7eHTn+zfB1Sfw2NSmYAN?=
 =?iso-8859-1?Q?UDH4J4T7cIMo7aGTQRIWwWk6C0gp3bAj5AUDF4EGyq4NxOl4rUce8eQCxb?=
 =?iso-8859-1?Q?DxeQSoT0mLLlFsfXW6XQU/VgjVcVLa5iwrTrUZBMJg8cSZrf9KXEGVNvGY?=
 =?iso-8859-1?Q?o0aXQdBu2S7ggCzPdNv2sN+wZpGh+iPZgzdnpf33RLlhEkKa7NsYKJDKon?=
 =?iso-8859-1?Q?HllikZAuyq5USxteFeBE1S/V8pvsjGMP8M+/mLzus64usO9wlcfHJYcEGo?=
 =?iso-8859-1?Q?D5T8AiWktPdMxYcDOet3et7HJ4rjCB2bPFnaLSiYk+gLXQWTT14htWzGQt?=
 =?iso-8859-1?Q?iQpp+xarodCqwLtJitPTx2KBxuxLX01KoGgM4/Sqh+whS/eJ4WSPq12E5a?=
 =?iso-8859-1?Q?Be/fSxjx/ejdUf9SFBXG85TGiqfc6kse9X1dKjEQrJTqPxhMz1Zl35uHIl?=
 =?iso-8859-1?Q?kPRAli31MEnMOfWdmiIBzA+V4EvB2vECVF1lDsO2TkYnqja6FjMFpe5e8T?=
 =?iso-8859-1?Q?XvYiLgLbCGgmXhs9/EWtIe3Qy5oPqnmeCdwCGtKF2S0GLl1UL05pWB2wlR?=
 =?iso-8859-1?Q?SPSo8qLT2XgKFKM/7jHLx4UHtreLCfVRdw0yLtS4crbGeH3F5ydEODme5a?=
 =?iso-8859-1?Q?NzA8GwNzi/i7MS/dY4ubIuj/Biz4/68RQAhylWnwE7NZAoxW7UFwguWt2M?=
 =?iso-8859-1?Q?fXia9rxTjWEMwm2fnWn7lonBN7UY9XNkSmtVm1HCxC8w+o5G/GiVzn9itY?=
 =?iso-8859-1?Q?eVlbNvUi9lYlpZEF41yofMPD8mGzWKFZo4T49qjiWEsdgAo3G6Uvxr6G0P?=
 =?iso-8859-1?Q?7DYOuYAiQ8ldnZTCBVKV2yT1TzEeC2xo+hAHm05ao0N6Qo9GhU5qHsBbae?=
 =?iso-8859-1?Q?GSj5y8ibd0RDmof/hecSEGqzpiHkow1UNlxN3jvpJMc+aEsa6IIzuaWw2t?=
 =?iso-8859-1?Q?LmsFKCKGApXDTH644SygYzEAGOO82n4TQHNOIQMIbwUnBHXlXpsmqJNwzL?=
 =?iso-8859-1?Q?jr/+L0UYyAz2TDC1SiT7nTHQ6xnLYSRpy2QZ8wDm7uXFdx8dNs6zwvo0je?=
 =?iso-8859-1?Q?+HSlTR6sJQlUc+bVcc67RZFwAaoErBdANxVI8SNLNmZ/k3Xb4N35XKuCgd?=
 =?iso-8859-1?Q?ZB9sgtVAc7CvDIFjHm+/ctM6FXIA/2DHYqrwmErTq4YdfJ9H2Yx9g4Jp6r?=
 =?iso-8859-1?Q?l7G5CBuCeuD0eTazmt1D5ZCDUT5Jzuo0tfDmmVxKJMZ6/FdJ1DqjTE3MFM?=
 =?iso-8859-1?Q?wlQuRavMOE8xQi2/J2MBlA/JjKP6KZrH5dulXJaCmqKMojobK4e8ttPThP?=
 =?iso-8859-1?Q?Ds3ePcOf6v55YY57Tli0srfowJTTuxx0QCV0rnfoEqxbqpYlfCW6hsLYq2?=
 =?iso-8859-1?Q?gTrygdP1ne?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6797.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001c3317-8418-4d42-7dc7-08d8e30b1e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 14:53:36.3014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/DZzC03bQvIsQ+QFE6T1jizauua1FNu7euxwg7JP/uFpgb0cHtl3j9YWRo04BYQDha1S5ebBbyeJlhgxI0UzfqR4gJkNff6jFMt2s9HPWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6635
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In the usb drivers, the echo skb is always released by the USB write comple=
te callback.


--- St=E9phane





            From: Marc Kleine-Budde
Sent: Tuesday, March 9, 2021 11:58
To: Oliver Hartkopp; St=E9phane Grosjean; linux-can Mailing List
Subject: Re: [PATCH 3/3] can/peak_usb: add support of ONE_SHOT mode




On 3/9/21 11:53 AM, Oliver Hartkopp wrote:

>> What happens if in one shot mode and the frame is not send? Who takes ca=
re of

>> the echo skb?

>

> ONE-SHOT only means that the CAN controller would not retry the

> transmission when e.g. loosing the arbitration or getting an error flag.

>

> The sja1000 does it this way, when the TX interrupt flag is set in the

> interrupt register:

>

>                  if (isrc & IRQ_TI) {

>                          /* transmission buffer released */

>                          if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT &=
&

>                              !(status & SR_TCS)) {

>                                  stats->tx_errors++;

>                                  can_free_echo_skb(dev, 0);

>                          } else {

>                                  /* transmission complete */

>                                  stats->tx_bytes +=3D

>                                          priv->read_reg(priv,

> SJA1000_FI) & 0xf;

>                                  stats->tx_packets++;

>                                  can_get_echo_skb(dev, 0, NULL);

>                          }

>                          netif_wake_queue(dev);

>                          can_led_event(dev, CAN_LED_EVENT_TX);

>                  }

>

>

> Do we need to check this for the other drivers?



Yes.



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
