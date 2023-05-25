Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B847107CA
	for <lists+linux-can@lfdr.de>; Thu, 25 May 2023 10:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbjEYIm7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 May 2023 04:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbjEYIm5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 May 2023 04:42:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFDE18D
        for <linux-can@vger.kernel.org>; Thu, 25 May 2023 01:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVAH0151mfp5pm+L0wpJX3wY0cvK42cZzGYPkI2OQmyTJKvLxWGBWewseRkShixnzRAby7dCSJMHdtngws/6x2U0Uauo8YoUxT5/G9IiD8cNkzYkpgHXJpTSgI75Te06W7l7+CD6yk2U+XXHDoc4BoqQzYYYaSBkuGRZLij4tAPS+zIBitnwvbJMbDDwF8ySKiSDMrpz7d7Ym+b/umtZ0HMkruuQ09FtqH/NBKmgUzaYjfK0NBIm07s71YdplKaWCRxcqrTlzJvGk3j6ej6ZJSZuCeghBFAxhIutmDi45Ec+dTlG6cliea0w+roCVFEjOjktGilmc/2ds+aplGDWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQDFNTVAqjEss0FWSUqYrD3yntL4pQ+t7Z3y7XKqBfc=;
 b=kY7Q99jiToYKYCvtsszM0T23PSJM/FJcBVZLijx5iEFg1RbWJPPdRkxlddtdgpFsykl817nGchKa+Gi1SRb7qZhvVv3Ki+Guci596b9MhPhm7gYeTfo8jxW7ul+7XInPC/6AtlNpct8+fBqi0VTqg4N/90Iav9xzMfyIfUIZDBmxZZJhHcBmUFA9SCrxUn3EpL1xlMGMAxcHzgp43zdoiVee38f6Su7HpbyjvUtYxQbH83og1ikbJJs2jGTNO24AfRPeXqsxV/egFg+2G9LRurPAWGWw0Wu4r/UaunEKfhc/79DikJ7esw2R1/QwP3Ap9mfJo9N8znMTmVVuTaApIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hms-networks.de; dmarc=pass action=none
 header.from=hms-networks.de; dkim=pass header.d=hms-networks.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hms-networks.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQDFNTVAqjEss0FWSUqYrD3yntL4pQ+t7Z3y7XKqBfc=;
 b=SmYY7T7hBwqPtR2/sBhLHY2jF1Nn/rnTxLyi85GE014spM3tz1OpkpStb0hwO289PaYAPbavguAn+jZQAEGYODaiF21m/D6OTM521fasiF5dLKwbL5R+xNMweaXRmN8nV54y2VQ7czyQEc+ZsKGk4ms7PwpTkcUtjrCeiI3YztE=
Received: from AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15b::22)
 by VI1PR10MB7734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 08:42:51 +0000
Received: from AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cc8d:5b2d:e8bf:75f5]) by AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cc8d:5b2d:e8bf:75f5%4]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 08:42:50 +0000
From:   Markus Marb <marm@hms-networks.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
CC:     Peter Seiderer <ps.report@gmx.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        socketcan <socketcan@hms-networks.de>
Subject: RE: [PATCH v8] can: usb: IXXAT USB-to-CAN adapters drivers
Thread-Topic: [PATCH v8] can: usb: IXXAT USB-to-CAN adapters drivers
Thread-Index: AQHZh3RprfN70Qe1Z0yJ29whKaeAAa9coyUAgAocOACAAAOcgIACL/QAgABFhQCAAUjPAIAAMv0g
Date:   Thu, 25 May 2023 08:42:50 +0000
Message-ID: <AM0PR10MB36836627328A6BD24DC4B39E90469@AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM>
References: <20230515212930.1019702-1-mkl@pengutronix.de>
 <CAMZ6RqKToYbfsOX4v_jK7X28hLyiYnH7j784eVeFuKrj7ujRSA@mail.gmail.com>
 <20230522215354.2c79c007@gmx.net>
 <20230522-hesitant-dehydrate-d2af514565d0-mkl@pengutronix.de>
 <CAMZ6Rq+-4D_W8d_2wxuN5TnTmRZ4+C3MwGuBOVNH_vQ2UveTbw@mail.gmail.com>
 <AM0PR10MB3683D7C815CD334AE831F60490419@AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM>
 <CAMZ6RqKmmEHitD7Aaq+zjyBUHvvbu0szhxnRQS71wxATydjYSA@mail.gmail.com>
In-Reply-To: <CAMZ6RqKmmEHitD7Aaq+zjyBUHvvbu0szhxnRQS71wxATydjYSA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hms-networks.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR10MB3683:EE_|VI1PR10MB7734:EE_
x-ms-office365-filtering-correlation-id: e9924bb6-d3ca-457f-011b-08db5cfc05fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1FGRE0PMhHTCVliY3Z2OxV4NSXEfWcojq8CKRDNnvXN2Wm/Qc7ew/TZt/0EK1k2p30CAkKe3NgW6fpaC9RJ+qHzlPsbNZ0fMHK2URRNJaU7yjDHzxwY1e3h8S6Ii6xlwZqMnHz6wIsxZvlHHTYAcUnOgj7baeTA62tKc8WxpgASUxCyu8KZyebCkpoLOtaL5LZa9DOHUdgYVlUCKx50egWFxbg7pBK3TNP4xXBN4Qm5mYeSLQ1yylf30DIp0Ay2PlNDFCv3b3RCviYBy6u1pp4mmgRcupomCe0IX4ABw3wkn1UKH/iaW0dPF33GccpFOGHn++D0lrwpxfU1j7NnmoM9yTfOquntaZVKwwxNSxPVNnZXEKV1TnnNaNs9JsEPvNIZDSKYSkIlcD23RIJh8FRqE5y1zyvByfHW7xRInablRjeOMkTkeK2sOD+ADfX04CCm7XMYGr69GbMgpc787rrFx+RiY44/ssUJqfHeO0uyS5dobfjOpnMp+rTglxtO4pbxlJSpgEW6yIfFmilcfTf4N5829HgBibXydzsBOrfBNfgtWEaIpLDVFE1XFJp+e3+/+04Y+pXMd6gm99fQQRIW7AaAAmAYKggGKtfGnNhvv356Uy2OOM4E842TkDQEH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(136003)(346002)(366004)(376002)(451199021)(4744005)(2906002)(7696005)(86362001)(186003)(38100700002)(122000001)(33656002)(52536014)(5660300002)(9686003)(38070700005)(8936002)(8676002)(316002)(55016003)(41300700001)(107886003)(26005)(71200400001)(6506007)(478600001)(6916009)(54906003)(76116006)(64756008)(66556008)(66946007)(66446008)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnJpNTNXS1h6TWhBMVFmaXZlY0ExV3RFTmtyU2xkeTBUemVIRjlLeGpGNzJu?=
 =?utf-8?B?S3hiSTRGZUwvWHpDTk9ISXVGSEJwa3ZqZVV1NDgyUDZuOG9PVlpORWJjME5P?=
 =?utf-8?B?QnY2L255YU8wY2trbnB4UzNaNjJrTkk2d0NWbDdUc3VEcXQraUVXNGtTWksw?=
 =?utf-8?B?MFlUUFBhcWlJeFVteWR5V3NzVWR1R3RnSXlWMHhkUUhSLzlLUG92Z2F6QzQ3?=
 =?utf-8?B?UGFoWWQ1b3FRb2hidHB5dHNEdXowL3orb0NVRWtBR3JaaWpSRytJUGVVSnJ3?=
 =?utf-8?B?TEpBaE5adWoxcjhZM0wrK0xMbW95L09xMFFId2RzTFZUN2lONzZzOGNuK1E1?=
 =?utf-8?B?dE8waXpRUTVpUHg5VzMxcDh1L29iTkxRQUI5ZmZsQ3ZzbkJDdDFlclVzNHMy?=
 =?utf-8?B?dkxTdGFTTzZjZUdNbk5WVnA0ZTd1SWQ5SW5PV2dJRmsxTGUySytpY1hScDBV?=
 =?utf-8?B?UFQ0UnRBT0dvQk5vcUs5Ny9yU0o5LzkrRVRpUy9waG96TWlRMCtaRFZYUHAy?=
 =?utf-8?B?cXVVZ0kwZTl5dDRjUEQ0TUhyb0hIc0QzNWUrU2R4U2ZIWWx5aG5TQlMraE9S?=
 =?utf-8?B?SGZVbjJMVEd2OHE0QzJ4RXVMeFN6QXhPRXpHMmRYVk1LY3N3dndRZ0JzYk1H?=
 =?utf-8?B?V0p3YWpnNUtXdWVWN25vNXJWQSt2OVJNdWpOVkJYYlFKMnlHU0pwdW9iQWVH?=
 =?utf-8?B?Z1YwOUNFKzd6cHVIOVJHK3hyWno5bDNZNjJrbEVHZlhHNTd6ZHFVWDc0YS9X?=
 =?utf-8?B?TU9hbGRXUWpNR2ZycXNMUEZaRlZhNW5ueGN1eEliTlBESys5Yy91RXhvZG5F?=
 =?utf-8?B?VEhxSXErNTkwVDBDeWJicldObllrUHIvWVYwNFhZY1NZcDN3YVUvM1g4Si9n?=
 =?utf-8?B?dVFKODZxTjVwaEFrVHc2dFVjYUl3NEhDdnM1amIwK1BlQmU2TmxjZ3I2Rlpu?=
 =?utf-8?B?WjlDcUU3c0h1WWRrKzVEU1V6TDlDZGVPQ2N4d3pFeUVyM3ZpSE1LTjhUSFlN?=
 =?utf-8?B?empGQjNISFRFNjBwTWVQYWJsQk13TUloMEFMWk5SVnNqYlJJellSQ2ozWUZB?=
 =?utf-8?B?ajlsR3JtRVVaRlZCWk02WG9VNGh0dzkvV0kxaGpXTElCYUh2NjRGbzBKcStV?=
 =?utf-8?B?ZS9OR2Jua3Z5bE9taldxYmY3WkVVdTFZdkk3MjZmY2M3NEtiM0EyZzh0Nmha?=
 =?utf-8?B?SDlkMWlWZ04rMmgveGFGWi91aEdDaDRXOEZvcmhHTTRxSzJGdFYyOUJRcUlR?=
 =?utf-8?B?SzFCWEVrNjE4b2RlNmNoZEpJUEdQTi82alp3cUNNd1oyckp1cmJFb1F2azdY?=
 =?utf-8?B?Wi91aDB1dEo1NFEvU1JqZ2JRL2F6ODlkL08rekdDK1V2aUM1WTRlK2JXSnpU?=
 =?utf-8?B?NDRUU2RON2NJY1Iva2FKQ1BYMnBhVjZmVUF2RXpMa2RGYy85MWQzc3NKd2RS?=
 =?utf-8?B?RGZmK1hVWTRlU1JLME5NbzhEQ1p3RWx1VWtWRjBHMjJ3UWwyWjA1enpoZXBL?=
 =?utf-8?B?Vm5ZKzU0akZVc1JGVGFBZThXQkNOUFRZV081NThJcEdzUDdxVjZZVjNwWUtD?=
 =?utf-8?B?M01CTUo1azhSSWluRkdPcGVqUUovZVJveHlYQUJ5eWdXK0szYitoN0h4TGM1?=
 =?utf-8?B?MEkrSVk1TklnSkV3VmNPNEpiRlpzOEVBSEgyNURHRnM0aU5Xdmx1MFplbEtH?=
 =?utf-8?B?cHlpUmdvaXlMY0dsdk0xV0hHdENtS3hoNFJhQmpoUXZobm80Vk1CMHRSWTBj?=
 =?utf-8?B?dmsrVEx5S3BkZUFNdFNyMnlrMWorTDNMaTA0ZnYrVTd0bm1DV0RtV0NBT01x?=
 =?utf-8?B?Y1lMYVRVdFUzYlhJdWNNVWJsTWVJS1F3TVUvV3Q5M1BlK0FkcExwMkQxZ1Nt?=
 =?utf-8?B?UExoRUtCSVBYam9DbHNUd0wxRDFBanM5c1ZEZEsxYVdGNytUUWxjZVorYU1X?=
 =?utf-8?B?bEtDbW5KSFJUc0R5a3luY1RJNGNMOXprbXBBaHBabVBRa05JL045ckdMRFNW?=
 =?utf-8?B?RnQyZEhDbWhZWXNHbW5IWUJIa1hTaWlNWTMrc0NPd0hlTk14b3l3WU4xOHRM?=
 =?utf-8?B?SnFLVDRqZkZXMU5hNERpV0hjcWQyaE9KVUV4d3ZxUlptaXVIRVFPaEhjNGlY?=
 =?utf-8?Q?S0xQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hms-networks.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e9924bb6-d3ca-457f-011b-08db5cfc05fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 08:42:50.4970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7c1590-4488-4e42-bc9c-15218f8ac994
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzfqQ7lbKI0qi4I15JBpyvnxESht10GsgXrGq6E8KuVhDD2OEnbw3wOx+uwamKes
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7734
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgVmluY2VudCwNCg0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBjYW5fdGRjX2NvbnN0IGVzNTh4
X3RkY19jb25zdCA9IHsNCj4gICAgICAgICAgLnRkY3ZfbWluID0gMCwNCj4gICAgICAgICAgLnRk
Y3ZfbWF4ID0gMCwgLyogTWFudWFsIG1vZGUgbm90IHN1cHBvcnRlZC4gKi8NCj4gICAgICAgICAg
LnRkY29fbWluID0gPE1pbmltdW0gdmFsdWUgd1RETyBjYW4gdGFrZSwgc2hvdWxkIGJlIGRvY3Vt
ZW50ZWQgc29tZXdoZXJlPiwNCj4gICAgICAgICAgLnRkY29fbWF4ID0gPE1heGltdW0gdmFsdWUg
d1RETyBjYW4gdGFrZSwgc2hvdWxkIGJlIGRvY3VtZW50ZWQgc29tZXdoZXJlPiwNCj4gICAgICAg
ICAgLnRkY2ZfbWluID0gMCwNCj4gICAgICAgICAgLnRkY2ZfbWF4ID0gMCwgLyogTWFudWFsIG1v
ZGUgbm90IHN1cHBvcnRlZC4gKi8gfTsNCkkgY2hlY2tlZCB0aGUgcmVsZXZhbnQgZG9jdW1lbnRh
dGlvbiwuIC50ZGNvX21pbiBzaG91bGQgYmUgMCBhbmQgLnRkY29fbWF4IDQwOTUuDQoNClRoYW5r
IHlvdSBmb3IgeW91ciBoaW50cyENCg0KQmVzdCByZWdhcmRzDQpNYXJrdXMNCg==
