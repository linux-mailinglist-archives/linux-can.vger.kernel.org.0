Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263684B663A
	for <lists+linux-can@lfdr.de>; Tue, 15 Feb 2022 09:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiBOIfB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Feb 2022 03:35:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiBOIfA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Feb 2022 03:35:00 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C74E687A
        for <linux-can@vger.kernel.org>; Tue, 15 Feb 2022 00:34:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McQOTfzB087TsNB0kD8/+eMbMB+K3uy7xIXAcaGFuDcbFE/t4ISyUiajSHwYlrBbk7ptcyraBJcvA2OL6/FDKOOEtX7szvkUdM0PZFtftS24lL4FvSv2XRzHP5INNuA39nCTChdk/W1pt3yCQZkY1ICScb306TQdXE1iJoyNmYMNMbmLNo5BrrtJ2YDR8AlkFjmKNrwbXy1vGYX7lBfczGMRlsaKEuMxXaVU2OpYg8qP5sFTR8Y5n4MB8eQ1WTxcWPlsJY8ijv5uIeQWRmvyTH69BauVXxdwvtKds4gqphOEgI9cDfdlhoVcpqLoNg/kkIHabIMz54zxGVbr89dpxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybkCvxowY2m7c0cUx5L19dM7Cxb081ZNVDx59KuZG+4=;
 b=j1lKtDzFDwr+KxfEkC/lsMcWuxWu9FTLimEaXhkVODIOjiqVCLEcVOsIg1JX+Pf+7/GOjqFuAU65jeZVC89kyH8WdHqgS0HG4VapRkyDw5/SAmUqZENdU6622A1ZghslBJ19QpZWW50TvFimtXXSIj0IbZ56ycW/t2rW+8Cq/W6MA229MHmZtAvC9mJ7uexByf4eaACxbEM79yU5nI1M6lxhzAlZ1bdkzJj/VaIWD27svko2RSeAD72Jc3xllXzw+pGsYLINmgBSdv5JcOqcjq3G02zjKUoW7ZFUPhRNbYt/Js5GgjK03bYTT0evLMVhYc0LNyYm5/VMLhnQEQneBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybkCvxowY2m7c0cUx5L19dM7Cxb081ZNVDx59KuZG+4=;
 b=fAyQabPQy/iRXAwDuHP82fY/eNXdd7fog5pyPjHdoRoBqbYoJg2mHqODeHh/iUsVwoQi3biq3SWL0qzijjIZTM3qAx6NmQuRupoe0xRQ9b0Vk4Zl6oZz3Of8L0sjTTsYWVYxd0DUS/AiaWqBgsWa0ZJiXQsHYDgZrqu0lLVA0gs=
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com (2603:10a6:102:f1::9)
 by DB6PR03MB3030.eurprd03.prod.outlook.com (2603:10a6:6:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 08:34:46 +0000
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::3460:fc17:db04:a018]) by PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::3460:fc17:db04:a018%5]) with mapi id 15.20.4951.018; Tue, 15 Feb 2022
 08:34:46 +0000
From:   =?Windows-1252?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: RE: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined
 flashed device number
Thread-Topic: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined
 flashed device number
Thread-Index: AQHYHzAodRMPm0lBD0C/3HprlXNq66yUTrAY
Date:   Tue, 15 Feb 2022 08:34:46 +0000
Message-ID: <PA4PR03MB67979D094A88FCAADAC3B14AD6349@PA4PR03MB6797.eurprd03.prod.outlook.com>
References: <PA4PR03MB679736316C8D5CF2079EB794D6309@PA4PR03MB6797.eurprd03.prod.outlook.com>
In-Reply-To: <PA4PR03MB679736316C8D5CF2079EB794D6309@PA4PR03MB6797.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: b688fdbd-94a7-5cd5-c849-ce4d8b7d41f5
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=peak-system.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7cbeae8-4447-4f7d-1b6e-08d9f05e05cc
x-ms-traffictypediagnostic: DB6PR03MB3030:EE_
x-microsoft-antispam-prvs: <DB6PR03MB303030A3C742022FAE854C04D6349@DB6PR03MB3030.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8JKaTHXqHtn4mpJxmDWBUn/eno/Rn/tENYNlSUpynLuW6iPMCllQvqgEQtr4RWzKhphdQ/ZywKS6Pbz0H+kuuWoKMnn9mqJ9qaIDOp17XAjJjpjNyhAU2SJYSgIeNMeJKxzqm6Opujbdnn8O7lm9JZFjY+tCfIA70z6RG5B4jDlCkioBZOmYx7MfQS0upBxkY0mVOmWBf0K5wqw5JEk13yXvzgyung5b1ZjYDnulNLiARHBZscA4GREnQPI2PComJ34QIdbkY1vySBN/vbLXtzV02XfLMukQjesZIRb1jPFsgg5xEHLoTo3ZQRMfE1RAb+fJLz2yed2/84IFDdDRXpTXtQcD677X8/KTwKZ9ol2gkcsv6ilTXMejG04MwyfW/3Nn9V38dtJ+ppOIJmaC8W2HPTLHONeoyB2yO1I8Esfd4UsER37M+JK0Nx3UpW/odzO3RBKEMrsSCcD8QctQ8PZm6y1QojsW74JsEDzZ7jn7lPI2DJqnECJozvV1oi6ZbP98uVEGZ+0xsjVsE6iSzzaQa+K2LuzmTbJD9Ah1AuMlaDSzGbPOycUsmt46tpBuzaZgqVwV8bLM3Ze0rlSek4H4weAZTof2WjlZzoQZGMpGuqzeNk+ZQZeCS+ujlNpoUrqizmfsfl7ljdB0NwCELisJKekTfWHHs2mCVRpyfEI1ByjVh2z7SERR7OlkZXQ6obkmo9/+6tzsvOjRR1ApPfUZZSrQWJ81raNSHugZpTNzlmSHkZf1pPxu/00xR1Oo/pBYXN0WPpNztAPnYpBjBEBoXQYF5Lspt3MgHIbttnc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB6797.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(39840400004)(366004)(136003)(346002)(53546011)(7696005)(6506007)(2906002)(71200400001)(66556008)(316002)(966005)(508600001)(64756008)(33656002)(66446008)(6916009)(66946007)(5660300002)(8936002)(86362001)(52536014)(15974865002)(8676002)(76116006)(26005)(186003)(66476007)(38100700002)(122000001)(4326008)(83380400001)(66574015)(9686003)(38070700005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?u6I/b5aVxcmDGI44/jFESFpQS+ji7V2iF0OryfkLxjbRCPpKuCLhkgdV?=
 =?Windows-1252?Q?pnbb4FuoeLHhqu9/tAW6BweUs4FDXWPdrvWpzYcvlmz6AQqyu3uCxvYc?=
 =?Windows-1252?Q?dXjrp/r2hv/dFPF3P3EUy4BRMvDBal/AxvaQwbiiqRLmEG30qA63jjHF?=
 =?Windows-1252?Q?sf+OmVmlq7BbYUpnI+O9911ckKApiPQkntKFYEni3TEsJHDBE6dDkZs4?=
 =?Windows-1252?Q?9zBvCpFtGGokKgibWfSONmKzFpUSSjfSEGMiTKyivUTRLyrqROnjcEOP?=
 =?Windows-1252?Q?WkPLo/rrc/vHKWBBnaKjZC6XHXCEH3tmsUb5FX5gXycx+5J5uorhWIJf?=
 =?Windows-1252?Q?2j5CES4gzOBHBzOgnvvYklz3E+sebJaUClfLWGqGPt6JbHqWPh38piYL?=
 =?Windows-1252?Q?26CJwHLlBuib35FzdUxQxHvWhIJ1I2r2V37t7qX7OEiirwUW82e+5l5x?=
 =?Windows-1252?Q?nS4Y9HFUoy7IDhJbo53idxH7H0lBOeMDPb9khFq1+1Osr9jIZrl+ijRU?=
 =?Windows-1252?Q?eDBhoT16Ze0+9tY4/6ajKd7ITNLuRnfb8v/EJK1tT+wDMl5ar3tAiDNN?=
 =?Windows-1252?Q?CUrWGCPfCUS3a/jaOsVwEkVhSZQBfYxZPgeo0vWyMepdCanht/+OhNOg?=
 =?Windows-1252?Q?O6jyW2LPG/a1/eWB+MwJv7cQ1fCf1m57ti7Jg+OOmZY4YzT0QquY+WMM?=
 =?Windows-1252?Q?exF39bDbcqypXWxsJk3c+gZC55PEAmNZaIlLeIqXYW2j7VYwFJf69c7A?=
 =?Windows-1252?Q?Bo+sut2AckkHn8RW6Pd/dV+jhCEUfhh4y95SXkBjE50QGp40ds6AxY/r?=
 =?Windows-1252?Q?gm8zs1PX1SUFNy4Ap3ImJY5S4w4P0hNlvf0fs3Hv0/eQy0nNaI64kzW8?=
 =?Windows-1252?Q?BMUfhTWbTb2xwYr/9QuEmhzRA7eqEknwo4/KAAAX2VoQ+3QRUDzbnwoh?=
 =?Windows-1252?Q?Y5pAdvcLKmu/+V0YUs0j1z6PLqmuYuCFQRW1E/tUl0nXVULAeDUNFi37?=
 =?Windows-1252?Q?gY07J2+4ijQ1lfmMJKwWJeVVQRJUKeoCVh5qd8Hx1SnPxL/injK6w6Ph?=
 =?Windows-1252?Q?1kBbj3B+ksZS8BhdkBf0/jtPZhY/eCza9cX9jvCVaKVRVJyqEq5iBzy3?=
 =?Windows-1252?Q?gA6xTqgTBAUhBE8BiiOhfBWf2flN9/yzSmK+z7vUmvCS7EV2f0G2X+W5?=
 =?Windows-1252?Q?AyIKF/jLTsVbV6itmFbCt7DjT04t5TkHwmb13PGgPYelU+H5oZLy1ivB?=
 =?Windows-1252?Q?lNTz1/sSAN9zvVuImV9dEqr6Zhttiq2RXK0WLEkzaPUm8TBEkGD4eaAq?=
 =?Windows-1252?Q?YLubZDCfD5gcy1dyHgILAYEXvNSZUYDws480kL43itUTdvzUquz61juR?=
 =?Windows-1252?Q?U/EqL6nPSwQJttXSUSrBClu6ijsM1uN6uocusCMk2cKhuM4Ssc/SPIdr?=
 =?Windows-1252?Q?qm/v/WLdKtVroUM0D0told07hilb44ot9enJ9FiKKhNN8h4FwZO0kZOf?=
 =?Windows-1252?Q?g9Ry5qskaQAqHxeYaFOwC+i/Vekq9ekjE5WW6tA7sRVR4g+HcksCD8L6?=
 =?Windows-1252?Q?lutefh/kPAzP81a2rvtTJwVzUPKEniqZMmzCmGOL5z7fCXEcdgVV7ynT?=
 =?Windows-1252?Q?Zs2zNVUTuKaPQmnFAUAMWdCKkdJ+LKvKF4KzFO0/rvh/3S+llVjS5Pbz?=
 =?Windows-1252?Q?EceQYmPFb1b4f8nM1dHupqjUl63YlzujMWZIRgmcTvCTcfpKuO4z/jX8?=
 =?Windows-1252?Q?iGHqNJsbpkyPv9UOEq1ki72LIYBcNUYLbXJ6c56wCl9nXNS3jAgXDTBc?=
 =?Windows-1252?Q?eCnSvQ=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6797.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cbeae8-4447-4f7d-1b6e-08d9f05e05cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 08:34:46.3240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JusQHcmSvM8PH5w/W3nU6A4SFC11yITBXGPdqU+4TfN80Bl3ThOk8TMZwQlTzknt6i3gHT1VWOErU8biSpBGNNoptLwrXCNH1SE/zriLYeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR03MB3030
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

Any news about this please?

Stephane

________________________________________
De : St=E9phane Grosjean <s.grosjean@peak-system.com>
Envoy=E9 : vendredi 11 f=E9vrier 2022 11:57
=C0 : Marc Kleine-Budde
Cc : linux-can Mailing List
Objet : RE: [PATCH 6/6] can: peak_usb: add ethtool interface to user define=
d flashed device number

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

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
