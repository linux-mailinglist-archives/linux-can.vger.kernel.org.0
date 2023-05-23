Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C26870D48F
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 09:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjEWHK6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 03:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjEWHK5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 03:10:57 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9839B109
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 00:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ido/+jr3VjpZW4ftjeGghXuBfJPs2EkWRS5ooLdHE1jn/XRcp7jMxr5xVQJL1zCp4aeifbJeEgxCdXacP4DBHd8CsUjK6rbxqwvzyTIiod/FJDljWbZ0Xv5hOZPkhNFzw7PIJjyM++MU9fmyrdYVNVKDSrgevXrykTA6nnH7FjGEpoZSIZDHIFgpe4TCSeFDW3YUNaN0cuwwGP7r9+EXw6e91KwqurHPh5vy/Lqbf0oUwFscnxkDH54JkrUT1ysJwBavbRcHL2ypZ+QOYTduBB4bnr5sfqNtnV2UY1ZuZvlBthrAIKfPOp/BfISMkzFNGyehHXp6a7r+jq73jE2G/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLxsfd3ICUXSi+Y/zT1vaMS267P37sPgoGUrApTfPlg=;
 b=C8qhglVBeZhAAdUJocX1iWsWLOvUC1sBYXW60NguBj58bIxtvu3+qMOHX3nUd/Op7qga1wUZOG65juH/T7SNzHX8/LEsMwWYyeRWHkHKR9JKOz/mGZ9KhuMQywm9CrOXbaMXNJvCN+TX+Z2J20B3Gg8lEqZpIidIYFwM6ss9eZhQkJ9qFx5qtwBr3Of5ZoTL3WSozQ1br5Ek3cyrlKgzKDVuPaihnMdVtje+ESiAjAj68i98QVjnyWIGuC2h9Ci1QhzNHuVcT4L2uj9GcRLQ6JaqWFm4kp6Sp+mob4TOT+jic+HvJ3sxFJ5h21uYgI9QpvwPwpCPxlFTyXxZOPA+8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hms-networks.de; dmarc=pass action=none
 header.from=hms-networks.de; dkim=pass header.d=hms-networks.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hms-networks.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLxsfd3ICUXSi+Y/zT1vaMS267P37sPgoGUrApTfPlg=;
 b=S7PaLVPRyR8gjMF6NJTUTxAdWTei80cj/obIuPKQ+VAtZeAe76NVTyTfGulTD5gvjA7Msw7MGh8Wv7Whc6c6HfS4tfCLi7QamyX1QuemZhSH5Ccxz5Uznp01rmtJr0LlStot02aEwPnBbylUwVI+vYitMZeN1mUk9gpvsEjcdZ8=
Received: from AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15b::22)
 by AS8PR10MB7428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 07:10:51 +0000
Received: from AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cc8d:5b2d:e8bf:75f5]) by AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cc8d:5b2d:e8bf:75f5%4]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 07:10:51 +0000
From:   Markus Marb <marm@hms-networks.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Peter Seiderer <ps.report@gmx.net>
CC:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: [PATCH v8] can: usb: IXXAT USB-to-CAN adapters drivers
Thread-Topic: [PATCH v8] can: usb: IXXAT USB-to-CAN adapters drivers
Thread-Index: AQHZh3RprfN70Qe1Z0yJ29whKaeAAa9coyUAgAocOACAALRAAIAAB3Bg
Date:   Tue, 23 May 2023 07:10:50 +0000
Message-ID: <AM0PR10MB3683AE142BDEC9A4551527B190409@AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM>
References: <20230515212930.1019702-1-mkl@pengutronix.de>
 <CAMZ6RqKToYbfsOX4v_jK7X28hLyiYnH7j784eVeFuKrj7ujRSA@mail.gmail.com>
 <20230522215354.2c79c007@gmx.net>
 <20230523-outlet-vaseline-b53d42733536-mkl@pengutronix.de>
In-Reply-To: <20230523-outlet-vaseline-b53d42733536-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hms-networks.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR10MB3683:EE_|AS8PR10MB7428:EE_
x-ms-office365-filtering-correlation-id: e72b5929-eb03-4955-6642-08db5b5cd742
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CS0q61kpr3qsHJxur3F+FmYrmwZ1KevDJTs2A6CHBe4foiAz2tZLuTlJ+IJTIJ1Sd/IHddVny8vK5tNryY8r82MBXGbTmTyh/s4DOH9ZKLNj3PT+sU90jgQhlmbchkZbzaAqFCWqHiNpllLkIVUnqxziTb1x1k5Ho81lxITgtp3Sp9iZAyIW/rZ8aaaN+oUKMnEY9K9AC+S5KtAlo57AO2XQu5NkvP99x3PFx/hik0Lka27hinzuo9M0ta1Cdw+RFgNBxPbrUc7I0hzcyzP1eCOgYFiZPcHLKtrCy0S0HNv6gUCP0B/IBoilhKROBPEcaKX/Dcfh9/LvIB5IA3tm1CJsWi/ieuphjThRXrfrEcQLiDOFDFdfgV+3aKQJidOD0WvC5nIhbQQuzyHvFwqgqhWplSlXUH7gajcq85qIndpqp4qA/wHzn20qGDQlPfrGC2n6Hf0zDdOOqPgpJwl7yJfqkSIqQpxcDtGQXEIpeJHcbUwTXFHt78TFb0jbx4NEZOuj5CXRIuFAYbMWjNYniJztBgo2dJ4giMpfHoeyWysimXL0aIz5MTYvPcYdYgzoQwKUPImrGuHDS6BVbpw/6qVBbMyMxe4psRiM+dv/hMo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(396003)(39850400004)(346002)(451199021)(8676002)(8936002)(52536014)(5660300002)(186003)(53546011)(6506007)(86362001)(9686003)(122000001)(26005)(38100700002)(83380400001)(38070700005)(41300700001)(7696005)(66446008)(71200400001)(33656002)(55016003)(966005)(66476007)(66556008)(66946007)(76116006)(64756008)(316002)(478600001)(4326008)(110136005)(54906003)(4744005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGV1Z1Arc0ZTN0NpSW5TanVpSWJUZWdMTmM0QW9nQ0o0UFpBTWcreGovZ2Ny?=
 =?utf-8?B?UUkrN1FiT3hIb2I5bXdITGlYc2x5WGt6bjhNSThEUGNNQmkrUThJSFRObHk5?=
 =?utf-8?B?WDNrckZCK0JKbmtOdVNZMCtqamJzLzJIZUpCTHFtWnNmU3djZVlBbVk3bFFU?=
 =?utf-8?B?N1ZiZnNHakFqeWt2VjNqN3JSdGp2YmZYSGlOenVBNEJtenByQUxtQk01V3Q3?=
 =?utf-8?B?LzVFZTRzam9xdE9hSFdUVzEzUlZzcDFVeU1zVXN5MG9lQlVHYndjNE15YmhF?=
 =?utf-8?B?bnZXbStDRDhqKzJkZ3NkWDViOXFNbkttd1pvb2RxaFVFakM1SmcrQVp5Mnk2?=
 =?utf-8?B?akZhMlJ2ZDBQZEFUQXZJZnRLM0hkdVBCdFNPTGVqdGxROG5UMEdheVcwMldi?=
 =?utf-8?B?RnJaYkJhNW1wV0VOOHVScm9HMGlBMmNtcmN2Z0tMQW02TXZCN2VaQmg1NXpz?=
 =?utf-8?B?Q0RWckx4d2sxaDBKUUFrZkE0ZWt2dGVIU3IxUjNBVFVhb01mU2pXdnI0ODdE?=
 =?utf-8?B?a3lCelk1OTh5WmhZVHF5eDlSbEF0UERRVTNRelZKdDdiRGM2Y0JwL2dGQ1Jx?=
 =?utf-8?B?VHpqRGs2Nk12UFBncm9kRlhlL1p0ZjhSOCtjN0JOUlFVNjVSeXRJOWRWUEpM?=
 =?utf-8?B?ZmtyZGxVbVpVdStFYzdDaWRBNFhnVTJ0U0xVenJyQ1RkOFRrN0ZkbE5NNDZZ?=
 =?utf-8?B?c3hkRjBwR3hlcXJPZVQ3K3ZwWHltdjRMS0c1VWt0TlB0K0RacUUvRHJvVDJr?=
 =?utf-8?B?Zi9uc0V4MFZKQ0k4OVlrZmU1eW1hN09KYlI2OTJOVXE0K0hIekpwb09UMWww?=
 =?utf-8?B?aFpVTk5mQnBYV1lTTlVkdFV4ZGtMcHQ5NnRWV2Q3TkorMGFzUnVWM1k0NGNZ?=
 =?utf-8?B?aktjSlI4SmRsT21KV2xWVS9vNElQODZpQlgzcUwrWmFBd0xFeFFYc05kMGJu?=
 =?utf-8?B?aDlUS3RpbEJOVlBtOEhITURZTjEvMXdNVlN6TTRmZXhZNE9GbmJ1VGVxb3Rv?=
 =?utf-8?B?T2FrSm5acjMyYytpMGdQTUY4czZlMTJUNExBZFBJZkozNFdqM05vVm8vMXpx?=
 =?utf-8?B?N0hydWdhWVVxV2ltdjgzZFhEQ3pRbTVMeExIaVBQOGlUejM0Zy9abWpzYkRY?=
 =?utf-8?B?ZmdocWh6TUYvQU50QzE1d0NwZkYvMFVyQVVwWDFYT3BzcE54MGpweTB4cXo1?=
 =?utf-8?B?ZityaFdBRm1xZ3ZUM1Y5TEs5S0ZvS3JxZE5xR1cyZ282T0IrbzBGMEFNWi9s?=
 =?utf-8?B?VVc1bVE5WWNpZGtibnQ4dFF0d1VwRlNvSnU3ZmFyZFRLMTB0bGphMGxURnRX?=
 =?utf-8?B?azNvZjNPYjlRcForK0E2ekQ2ak1jdHB5dzBHOExwYitEUyt2cWIyeFIyM0tn?=
 =?utf-8?B?emU3RWNXSllMUzROeXNacDBBQ0xheE4rdWZaS01ocXQ1bXg5QVdoWVRMRmFH?=
 =?utf-8?B?YmVHNU1Td3piL20wTld3K3JVNTdscnY1MjVESkYrOFIxMzhkdWVhbThHK1lL?=
 =?utf-8?B?TEJGb1cyNGRyaWFxdU0ya3dhY2UybWVVaHBWTEoyNEI4cCtNQ2NRRkZLUDZt?=
 =?utf-8?B?OEJuVkRNRmVLRGN3eW1qTzJzM0xWWTZrZFFqUHNLZU1ITGpxVFV6ME5mYjJP?=
 =?utf-8?B?NEViaGJzeDlubS9Kd21GdjVkL3dGRTBiMUJKbm90bmJLL09abU9JekdsbUNN?=
 =?utf-8?B?OEJSZ2FoUWlVeCsvSW1kemVxU1E5WGV1T3dtY1ZTMWZ2aGFIQ09peXBBd1Qx?=
 =?utf-8?B?LzBHZUd5WTd3UnJoN0xTUkZGSkd0Z0cySUU2Q2RQRUtEODlFMXhxQkQzVXUr?=
 =?utf-8?B?MzNub29mYmJZeUN5U2lwa29TZWVQcHkxcEdiODE0TVE3R0xMeC9PWGFEYWV1?=
 =?utf-8?B?eHM2Wkt3Um0vcTZxNjF0WUx2VEpIZklmZU5aeHFNTnQvWGp1UUk3bDByNkdr?=
 =?utf-8?B?Q0dKOFA1RjJ3cWJNclo2d0hEK2JVRmRCNG9PSWJCUGZCZ09XbG1SWXV1R3Y2?=
 =?utf-8?B?S1QzbTV1dGdhQ3RTR0dnNDF3bjVDcTJKMjVMQmV3b254ci9QbWtranNzRUx2?=
 =?utf-8?B?UjJkbjZMRUxqcTBEMW5BRlRuSlhxRTI3MGVWTy91K0U1REJKRFVnem5FcDBC?=
 =?utf-8?Q?PRgw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hms-networks.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e72b5929-eb03-4955-6642-08db5b5cd742
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 07:10:50.9070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7c1590-4488-4e42-bc9c-15218f8ac994
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEL/8uOR+B1zlepSkTONwjfZaJtsXx0qvTjC3LM75SmD2wBTGGTDYFrO0LiTmPNo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7428
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGksDQoNCnRoYW5rIHlvdSBmb3IgeW91ciBoaW50ISBJIGZpeGVkIHNvY2tldGNhbkBobXMtbmV0
d29ya3MuZGUsIGl0IHNob3VsZCBub3QgYm91bmNlIGFueW1vcmUuDQoNCkJlc3QgcmVnYXJkcw0K
TWFya3VzDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNYXJjIEtsZWluZS1C
dWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPiANClNlbnQ6IFR1ZXNkYXksIE1heSAyMywgMjAyMyA4
OjM5IEFNDQpUbzogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0Pg0KQ2M6IFZpbmNl
bnQgTWFpbGhvbCA8dmluY2VudC5tYWlsaG9sQGdtYWlsLmNvbT47IGxpbnV4LWNhbkB2Z2VyLmtl
cm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjhdIGNhbjogdXNiOiBJWFhBVCBVU0ItdG8t
Q0FOIGFkYXB0ZXJzIGRyaXZlcnMNCg0KT24gMjIuMDUuMjAyMyAyMTo1Mzo1NCwgUGV0ZXIgU2Vp
ZGVyZXIgd3JvdGU6DQo+IEFkZGVkIENDOiBzb2NrZXRjYW5AaG1zLW5ldHdvcmtzLmRlICh0YWtl
biBmcm9tIHRoZSBjb3B5cmlnaHQgaGVhZGVycykNCg0KUGxlYXNlIHJlbW92ZSwgdGhhdCBtYWls
IGlzIGJvdW5jaW5nLg0KDQp8IFlvdXIgbWVzc2FnZSB0byBzb2NrZXRjYW5AaG1zLW5ldHdvcmtz
LmRlIGNvdWxkbid0IGJlIGRlbGl2ZXJlZC4NCg0KZmxmZUBobXMtbmV0d29ya3MuZGUgaXMgYm91
bmNpbmcsIHRvbzoNCg0KfCBGbG9yaWFuIEZlcmcgKGZsZmVAaG1zLW5ldHdvcmtzLmRlKTxtYWls
dG86ZmxmZUBobXMtbmV0d29ya3MuZGU+DQp8IEEgcHJvYmxlbSBvY2N1cnJlZCBkdXJpbmcgdGhl
IGRlbGl2ZXJ5IG9mIHRoaXMgbWVzc2FnZS4gUGxlYXNlIHRyeSB0byByZXNlbmQgdGhlIG1lc3Nh
Z2UgbGF0ZXIuDQoNCk1hcmMNCg0KLS0gDQpQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAg
ICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgIHwNCkVtYmVkZGVkIExpbnV4ICAgICAgICAg
ICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUgfA0KVmVydHJldHVuZyBOw7xy
bmJlcmcgICAgICAgICAgICAgIHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0xMjkgfA0KQW10c2dl
cmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgfCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTkgICB8
DQo=
