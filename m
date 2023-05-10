Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FA16FD6FB
	for <lists+linux-can@lfdr.de>; Wed, 10 May 2023 08:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjEJG0R (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 May 2023 02:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbjEJG0P (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 May 2023 02:26:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A5D3A93
        for <linux-can@vger.kernel.org>; Tue,  9 May 2023 23:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683699967; x=1715235967;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IOXiWU8jU+OHH0m8repxmCitr2GJgNSbdIKW3AhxO+U=;
  b=0B16f/bmcpFfNQFMqOkQy39SCJxwt8luke4P+g7kSmQAqPecKO04GB/R
   qutD/8SN9zZyMW+vZbIQaWOd+XqJkPwtvtwmvFjrEiH/c4VFBky6gxF45
   9lad3h5bbSTQ54O/WF2Kwr258JtQckCcW7MwyL52YSCZCFOYb205GRETo
   Ldff/8URPsMPp9uOmUxR97zFF80QWr7pf7IFOaD+bh0TspZu4QTa0QDMo
   AoZ62IFLnneEIuQri10pYgxRI05TZqsk91SYl9XjUy0pzsRGvfseAA3oW
   6yo3G0Emh5BAhCujIsoWDtz/z6J4aY3w51QVVR3WEI3APVb78q5cAaSpZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,263,1677567600"; 
   d="scan'208";a="151266473"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2023 23:26:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 9 May 2023 23:26:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 9 May 2023 23:26:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1yXmkzZ4GjLFZUEH5Vc+vfgSigzJZAjvSr0EPA4FcO2I0V/p9McY7fh8P/fVffgQHQRHX2DE4t9TWZVuDYoWNuj2mqgietLzB9/pKEwLxe02E2mHZl/bkfAHGIgsXjJG7B/Ka00rmo3z6WeQDkcU2gRAONWuyUMDlLeq5SZkV8qD4RvGAXm6lZ2prQ+nUjjdL9s53C6F6Faje34Boz1RijmYjvzWQRXWhKwwGbakprG7IEjogw+xFivrB/9kLT7hbWW80QC9iHXDqaXBpxwTeNXOMdyuptbhp6gxbDLvseh5t+/pkI1M3y274ooH/rbWnDb6vv4w3ctXn3buxwC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOXiWU8jU+OHH0m8repxmCitr2GJgNSbdIKW3AhxO+U=;
 b=jgto+JeVc8T3F89Cj1nB3YIKAELuc22SnJnxKW4uKMJxxjaw2kgj9V1wNIpT4dtUGJDw5wasT7Kl56IytjVnzUVMhe+gBMXqMP4cnVnVIYDMCyp+whvXfoqjQ/qh/BbhUdbARS/ywwC4fneDy+2P3DxVkd8JL70GBT+T4cxDe7gi7L8hvAb34CCnW03QmDG46YSf59LF3lfykQflyJ8IopNB3lnB8Bh1Z4parHfJGpKoMjKK2J87k1p1ySv+Nb3scTHJf4kURipcEqaJ9JJgN/xYF1pEnnCXZllb1yMKWCqu7o2WxroIMhrUg+ZdirfQm+gkuJKzBffWseciX1SYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOXiWU8jU+OHH0m8repxmCitr2GJgNSbdIKW3AhxO+U=;
 b=RRSPCvai+LVHFQKlgQLToDbwExu96p8zIqcNw0y6ROi//HGeI+3p6RwoH/WP7C5rQhRQ3mZm6CE3tlNiPn+vc92AEnGDmKNkJmSlXK7Mj1+zTpCQJpSnve3znXjSbTa8w7gBOqVcUlcpYWLXw6cNuFR5J7H+AXIq0zae46lgWQs=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 06:26:04 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c13:dcee:8af:bbfb]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c13:dcee:8af:bbfb%5]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 06:26:04 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <marex@denx.de>
CC:     <linux-can@vger.kernel.org>, <fedor.ross@ifm.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <lgirdwood@gmail.com>, <mani@kernel.org>, <broonie@kernel.org>,
        <pabeni@redhat.com>, <wg@grandegger.com>
Subject: RE: RE: [PATCH] can: mcp251xfd: Increase poll timeout
Thread-Topic: RE: [PATCH] can: mcp251xfd: Increase poll timeout
Thread-Index: AQHZfsHPIp3PLFFLr0mLQ+HLgrlDx69LPlkAgAAEhACAAA5zAIAABmKQgAez8+A=
Date:   Wed, 10 May 2023 06:26:04 +0000
Message-ID: <BL3PR11MB6484A68C2B2CFFAA44AD3E09FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <20230504195059.4706-1-marex@denx.de>
 <20230505-kilt-exclusion-fd2a2423deb1-mkl@pengutronix.de>
 <BL3PR11MB64846C83ACD04E9330B0FE66FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230505-unhearing-paragraph-9b5b994f185f-mkl@pengutronix.de>
 <BL3PR11MB648479549F7120050ED93740FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
In-Reply-To: <BL3PR11MB648479549F7120050ED93740FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|BL1PR11MB6051:EE_
x-ms-office365-filtering-correlation-id: 661c95ef-bef6-4dc6-1917-08db511f6e8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0bSPhUM0+6YI4oEc07YSR2zsUaOmae/iZs6JJFsosM3IoMEG2h1yslt5mnUeGKmNeL+AOX3CI8awbiuXSmvyzpux5gosr+XWDy6cIWQYzEtEOpGkyIWDjS6R0cWEadF5FvOYzhfkRN6NUcF6pLmY8lJpndi69isb95jbvQuF+DZMM0eYiWo4nUD5TynqdkRNnuUDZsEtR/AaIWvOPNEJCrE1Bpy/leVZtd+J+PjB1UUfXS2Ugo1Ozj20iBiBTtt+uPjayBkrlLZTJCPFkcyiDsLMBMYtR4oYDMNHddlGVRC3tAMzFlmIo4jJJgHssoSq2c7BCikx8fOl2g1/6c2tMwFQQBSgUR1DJ+7rYjgphHUZ97cADgEtpbnMPRZ5UBrJAd4L0n4E5/VJLwDQeGXMhBCp6aQJSC6JnoamcsJ9AIZEXhPKPG5wlySJ8BxvG8g4W7+mqoePEheWn/oHqgQrQn/dCQJlPcVqVxtfz2g/9esD4F82Uxq9HLXYmESiGb7m2I0dIh7IbbFsHNRq+CUMF1nE5B/sgkHksu5zfYhEJKi4pZpz6xPBjVhGeyU8p4OlxRFNhAWMOaJV7PCozE+YAxlGiudEOv+6Ro5+sAZg0p6n4KYnapTzcuyolqz45i6K/DgdNYj+NWrH06t77c7NJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(55016003)(71200400001)(6506007)(26005)(4326008)(76116006)(64756008)(66946007)(66476007)(66446008)(66556008)(316002)(41300700001)(7696005)(478600001)(110136005)(54906003)(9686003)(7416002)(8676002)(8936002)(5660300002)(52536014)(53546011)(86362001)(186003)(2906002)(33656002)(83380400001)(122000001)(38070700005)(38100700002)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elIvamtXZEQ2QzNBZjI0eUx0SFozakg2dzZnN1dsL1VwOVE1M2dySldvek1Z?=
 =?utf-8?B?WlA1RmhiaHdCWXM0bDVZczluK0tndjFlYitkSnZoSkdmR2ZUdFlLM3JWMmto?=
 =?utf-8?B?Y0g4V2NOMFQ1aFNJTjdCTFozbCtVRFVUMVBsdXdYVG5GRUU4dlpQWUo4d2Zj?=
 =?utf-8?B?NmQxQnh6Q3BNSTZzajVzMjRLd2VJbXZxenpuL0xJOWh5Rnh0aUdWU05pYVBR?=
 =?utf-8?B?OHFJM1lLQmNDd3Y0eTdJSUxiL1VKMGNiMENObFdWcE13eHNNeU9QMzlHeHh2?=
 =?utf-8?B?a1lGZzY0c3p1V2hzakx2YUFzaDNpUmNhMVAzZ2YzbFRBTEFlcEdtSkZHS1h2?=
 =?utf-8?B?cmZmQUtSQU1UMFhqb3hwU1BIbUw0R3lDZkI0Rm54VXpTVGgxd1pZUWE5VzMv?=
 =?utf-8?B?dzRjQXdscUU0UnA5MVc0Mmk0NTdYYTdPZHNtYnJXdEVoVXptUCtFTjBRN3hw?=
 =?utf-8?B?c005T1FkVkNCeFhoeHB4Q0xmamdqYUNjYWMzQnJWeitTVnI3MElQaThYdWRv?=
 =?utf-8?B?ZEVqUVlvVzlVTTRSaUovdFFJaDAzWEpLS0VpeW14Zmx1NHZzZFpmYVd6Nm82?=
 =?utf-8?B?ZFk2bk5iTXV6bkh2NFlZRW9aZjRxcUw5WnFndWFtb0pOd05ORTNyeEFLTHBR?=
 =?utf-8?B?dExqRis4S05vR2JwbXRXT1RGa0NaUXBRa0RHbTZzcklzOCtsTFRWZERkaklI?=
 =?utf-8?B?Vkd5dmx5Umh0aTlSZzFEQUcxT2NqY1RzQ01wcXBVdW4yOWEyUlVvbzBGY3F6?=
 =?utf-8?B?QnVrc1Q3cS80bkRSdG9Xemk0MUxMWmhGZ2dudEpGTDhhajdSOUVpQndnU3ZT?=
 =?utf-8?B?R0VxVUV0c1hWY2VCb1VneStHeW9XQjFJV2VmNlk0OTJPamliWkJLVmo4aUFK?=
 =?utf-8?B?VHpBd1cweThPV0s0MURMMFlrRFVKRnZLbEdpZmcyU1ZKUUxVSHhEVHA1RWtM?=
 =?utf-8?B?cFFNOGZWQXVkdE04Ylh4R1N2aU1vcXZuZjlnSEpWV205dU1Bd1BoTE53OVVN?=
 =?utf-8?B?SzVXSm8vc0JWbms0VmI2TEtPNERveEIrTnZFRWFmOFlXOTY5SDZCSjUxZ0hr?=
 =?utf-8?B?UDJOUEJ0ZjhONGpHWUEydzZRcGtGbjhLZTN2NWZxZDcwY0IraVE0UWEvTEtq?=
 =?utf-8?B?MnVjb3F5dXpIM2NSeDVMYlU5U05TR0JkV3lOWjJTUWU4VlB3QjlMTXd5T1hr?=
 =?utf-8?B?TGlaVFNoR3Zmb0dGckcrMUdCQm1ZTFNFSWJBY2pOZEhEdm0ybnlXcmZqS3Mz?=
 =?utf-8?B?VXQ0L2VEUyticW1qS28yQldxVlNkS2NCMTdJQytVWUUwK0oyQ24xQ096dGho?=
 =?utf-8?B?dktZd2RkSVRSdkJCZy9lNTJtVk12c1Vic2dycjRscHU1cHZ2VGpLdVNVWHR4?=
 =?utf-8?B?cFdRVkpUelFYVGNlMnpJR29CR3pmeHdRNFlMNUpmaVdwSFRWOFhsNS9VdGhy?=
 =?utf-8?B?bnFNd2cxS0MrVWZYcGFSN0xiam9DWlNERjdNQ1RoR3Q2Q21lS21UOFF1MDY1?=
 =?utf-8?B?V3VobFVHZlJzQ1RkNVg5NzZST203YUgzWEExZjRIVG1mWUk1dzd4ZThkSUUr?=
 =?utf-8?B?U0xrMGdDTXdRU1lHNGZIdTJ6eFZjNlZTZmRSKzVjT01yL0tCNGpuWW50TzUv?=
 =?utf-8?B?T0hXNnB1L3VTdEh6VDBvWGRxSXl0OWpnRlp5ZmViZTFCbEtqTWU1WUgzcDBK?=
 =?utf-8?B?dTdWMklhbVRxblVKTzgrSHdjL0pobkZPUkxST1Z1MHZUblcrVFNtVWg5NkJJ?=
 =?utf-8?B?OGZYUUd2dVQ1SjlXc1JMVUVBNGhvYWx0UXdtOEpnWXhSLy9QRUMwMWxCWXZn?=
 =?utf-8?B?MEZDYUFFMGVEQXBuU1N2RElGdmpOY0thbElBWS9JbmxNdU9KM0pVV0lxSEtv?=
 =?utf-8?B?cXN0QWJiZTVtQ2NRb3JmQXNsdGpzd1ZsMWd4M2RLaTUwYkpNb2JnV3g4Q3JB?=
 =?utf-8?B?TG01NmhCV0QwRlk5K0E5VlVvd2RycE54Wm11L3AwMkkyOS9naldTU21DbnA1?=
 =?utf-8?B?ZHJBZHFVemoyQVVPMWEwS1N5ZlkxL3hYU3dBbXhoclV2ODllR3RpeVhQby9Y?=
 =?utf-8?B?WHJYWVZwcjl3czRoUkdibnpiTkhtWnVTWHlRYytEWFk2aTNVL3ZKbDcxZmdN?=
 =?utf-8?Q?q9YE9+lnRA7/8S/qqCr3umqsh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661c95ef-bef6-4dc6-1917-08db511f6e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 06:26:04.3340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VSqq/be44RBft+lEXK+1ERSpRFmuO9FDs5lFNkcKwn6v84bmoq6u01O6MIDR/Rk7lP9Q1Kz9yeKdn6bkOq5cUXCl8Zk07qVDg/jIJbV0QTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiA+IE9uIDA1LjA1LjIwMjMgMDc6MDc6MDMsIFRob21hcy5Lb3BwQG1pY3JvY2hpcC5jb20gd3Jv
dGU6DQo+ID4gPiA+IFRoZSBkYXRhc2hlZXQgIk1DUDI1eHhGRCBGYW1pbHkgUmVmZXJlbmNlIE1h
bnVhbCIgc2F5cyBpdCBuZWVkcyBhbg0KPiBpZGxlDQo+ID4gPiA+IGJ1cy4NCj4gPiA+DQo+ID4g
PiBUZWNobmljYWxseSB3aGF0J3MgbmVlZGVkIGlzIGFuIGlkbGUgY29uZGl0aW9uIG9uIHRoZSBi
dXMgYXMgc3BlY2lmaWVkDQo+ID4gPiBpbiB0aGUgSVNPLiBpLmUuIDExIGNvbnNlY3V0aXZlIHNh
bXBsZWQgcmVjZXNzaXZlIGJpdHMgYWZ0ZXIgYSBmdWxsDQo+ID4gPiBmcmFtZSAoaWYgb25lIGlz
IGN1cnJlbnRseSBpbiB0cmFuc21pc3Npb24pLg0KPiA+DQo+ID4gUmlnaHQuIFdoYXQgaGFwcGVu
cyBpZiBhbm90aGVyIENBTiBmcmFtZXMgY29tZXMgYmVmb3JlIHRoZXJlIGFyZSAxMQ0KPiA+IGNv
bnNlY3V0aXZlIHNhbXBsZWQgcmVjZXNzaXZlIGJpdHM/IFRoZSBJRlMgZm9yIENBTiBpcyAzIGJp
dHM/DQo+IA0KPiBOb3QgcXVpdGUuIEJldHdlZW4gdGhlIEZyYW1lcyBpcyBhbiBJRlMgdGhhdCdz
IGNvcnJlY3QgYnV0IHRoZSBJRlMgY29uc2lzdHMgb2YNCj4gYW4gSW50ZXJtaXNzaW9uIHdoaWNo
IGlzIDMgYml0cyBsb25nICsgYSBidXMgaWRsZSBjb25kaXRpb24gb2YgMTEgYml0cy4gUmVndWxh
cg0KPiBmcmFtZXMgaGF2ZSB0byB3YWl0IGZvciB0aGUgSUZTIHRvIGVsYXBzZSBCVVQgdGhlcmUn
cyBhbiBleGNlcHRpb24gZm9yIGVycm9yDQo+IGZyYW1lcyBhbmQgb3ZlcmxvYWQgZnJhbWVzLiBF
RiBtYXkgYmUgdXAgdG8gMTIgYml0LCBPRiBhcmUgOCBkb21pbmFudCArIDgNCj4gcmVjZXNzaXZl
IGJpdHMsIGJyb3dzaW5nIHRocm91Z2ggdGhlIHNwZWMgSSB0aGluayBvbmx5IDIgT0ZzIGNhbiBo
YXBwZW4NCj4gY29uc2VjdXRpdmVseS4gQWRkaW5nIGFub3RoZXIgMzIgYml0cyB0byB0aGUgZm9y
bXVsYSBzaG91bGQgY292ZXIgdGhpcy4NCg0KUmUtcmVhZGluZyB0aGUgc3BlYyBhZ2FpbiBJIG5v
dGljZWQgdGhhdCB0aGUgcGFydCB3aGVyZSBJIHdyb3RlIHRoYXQgdGhlcmUncyBhbiAiaWRsZSBj
b25kaXRpb24iIGFmdGVyIHRoZSBpbnRlcm1pc3Npb24gaXMgd3JvbmcuIFdoYXQgZm9sbG93cyB0
aGUgaW50ZXJtaXNzaW9uIGlzIGp1c3QgImJ1cyBpZGxlIiwgZGVmaW5lZCB0d28gcGFyYWdyYXBo
cyBsYXRlciBhcyAiVGhlIHBlcmlvZCBvZiBidXMgaWRsZSBtYXkgYmUgb2YgYXJiaXRyYXJ5IGxl
bmd0aC4iIFRoZSAxMSByZWNlc3NpdmUgYml0cyBjYW4gYmUgcmVtb3ZlZCBmcm9tIHRoZSBmb3Jt
dWxhIGFnYWluLiBUaGUgbG9uZ2VzdCBwZXJpb2QgKHVuZGVyIHRoZSBhc3N1bXB0aW9uIHRoZXJl
IGFyZW4ndCBtdWx0aXBsZS9jb250aW51b3VzIGVycm9ycyBvbiB0aGUgYnVzKSB3aWxsIGJlIEZy
YW1lICsgRXJyb3IgRnJhbWUgKDEyIGJpdCkgKyAyIHggT3ZlcmxvYWQgRnJhbWUuDQoNCj4gPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4ZmQvbWNwMjUxeGZk
LWNvcmUuYw0KPiA+ID4gPiBiL2RyaXZlcnMvbmV0L2Nhbi9zcGkvbWNwMjUxeGZkL21jcDI1MXhm
ZC1jb3JlLmMNCj4gPiA+ID4gPiBpbmRleCA2OGRmNmQ0NjQxYjVjLi45OTA4ODQzNzk4Y2VmIDEw
MDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9zcGkvbWNwMjUxeGZkL21jcDI1
MXhmZC1jb3JlLmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC9jYW4vc3BpL21jcDI1MXhm
ZC9tY3AyNTF4ZmQtY29yZS5jDQo+ID4gPiA+ID4gQEAgLTIyNyw2ICsyMjcsNyBAQCBzdGF0aWMg
aW50DQo+ID4gPiA+ID4gIF9fbWNwMjUxeGZkX2NoaXBfc2V0X21vZGUoY29uc3Qgc3RydWN0IG1j
cDI1MXhmZF9wcml2ICpwcml2LA0KPiA+ID4gPiA+ICAJCQkgIGNvbnN0IHU4IG1vZGVfcmVxLCBi
b29sIG5vd2FpdCkNCj4gPiA+ID4gPiAgew0KPiA+ID4gPiA+ICsJY29uc3Qgc3RydWN0IGNhbl9i
aXR0aW1pbmcgKmJ0ID0gJnByaXYtPmNhbi5iaXR0aW1pbmc7DQo+ID4gPiA+ID4gIAl1MzIgY29u
ID0gMCwgY29uX3JlcW9wLCBvc2MgPSAwOw0KPiA+ID4gPiA+ICAJdTggbW9kZTsNCj4gPiA+ID4g
PiAgCWludCBlcnI7DQo+ID4gPiA+ID4gQEAgLTI1MSw3ICsyNTIsOCBAQCBfX21jcDI1MXhmZF9j
aGlwX3NldF9tb2RlKGNvbnN0IHN0cnVjdA0KPiA+ID4gPiBtY3AyNTF4ZmRfcHJpdiAqcHJpdiwN
Cj4gPiA+ID4gPg0KPiA+ID4gPiBGSUVMRF9HRVQoTUNQMjUxWEZEX1JFR19DT05fT1BNT0RfTUFT
SywNCj4gPiA+ID4gPiAgCQkJCQkJIGNvbikgPT0gbW9kZV9yZXEsDQo+ID4gPiA+ID4gIAkJCQkg
ICAgICAgTUNQMjUxWEZEX1BPTExfU0xFRVBfVVMsDQo+ID4gPiA+ID4gLQkJCQkgICAgICAgTUNQ
MjUxWEZEX1BPTExfVElNRU9VVF9VUyk7DQo+ID4gPiA+ID4gKw0KPiBtYXgoTUNQMjUxWEZEX1BP
TExfVElNRU9VVF9VUywNCj4gPiA+ID4gPiArCQkJCQkgICA1NzYgKiBVU0VDX1BFUl9TRUMgLyBi
dC0NCj4gPmJpdHJhdGUpKTsNCj4gPiA+ID4NCj4gPiA+ID4gTGV0J3MgdXNlIENBTkZEX0ZSQU1F
X0xFTl9NQVggKiBCSVRTX1BFUl9CWVRFIGluc3RlYWQgb2YgNTc2LiBJDQo+IGNhbg0KPiA+IGZp
eA0KPiA+ID4gPiB0aGlzIHdoaWxlIGFwcGx5aW5nLg0KPiA+ID4gPg0KPiA+ID4gU28sIEknZCBz
dWdnZXN0IENBTkZEX0ZSQU1FX0xFTl9NQVggKiBCSVRTX1BFUl9CWVRFICsgMTEgKw0KPiBzdHVm
ZmJpdHMsDQo+ID4gPiBhcyBmYXIgYXMgSSBjYW4gdGVsbCB0aGUgQ0FORkRfRlJBTUVfTEVOX01B
WCBpZ25vcmVzIHN0dWZmYml0cywgc28gYXMNCj4gPiA+IGFuIG92ZXJhcHByb3hpbWF0aW9uIHNv
bWV0aGluZyBsaWtlIChDQU5GRF9GUkFNRV9MRU5fTUFYICoNCj4gPiA+IEJJVFNfUEVSX0JZVEUp
ICogMS4yICsgMTEuDQo+ID4NCj4gPiAuLmFuZCBhIGRlZmluZSBmb3IgdGhlIDExIGFuZCBhIGNv
bW1lbnQgZm9yIHRoZSAqIDEuMg0KPiA+DQo+IFJpZ2h0LCBJIHRoaW5rIGRlZmluaXRpb25zIGZv
ciB0aGUgMTEgYW5kIHRoZSAxLjIgbWFrZSBzZW5zZSBpbiB0aGUNCj4gaW5jbHVkZS9saW51eC9j
YW4vbGVuZ3RoLmggYW55d2F5Lg0KDQpCZXN0IFJlZ2FyZHMsDQpUaG9tYXMNCg==
