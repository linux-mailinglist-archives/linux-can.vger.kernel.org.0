Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D94F92F0
	for <lists+linux-can@lfdr.de>; Fri,  8 Apr 2022 12:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiDHKbq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Apr 2022 06:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiDHKbp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Apr 2022 06:31:45 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2113.outbound.protection.outlook.com [40.107.20.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624BA31B176
        for <linux-can@vger.kernel.org>; Fri,  8 Apr 2022 03:29:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9LnkCAC2EEEdKyC6yiChqXOnd5hmqdb4AjssmTcAE9tDphjCBRwKCRXwqacd83LtKUEI94Epbbg9+8v/i+1h9I2TQaLFaJWVvBkPsmp20mqXhSarntmY6DBploZI5ssCxuQCy0Z+RBl+ifE5Q6KHJfkv0kGEI5c1Fu9MCNLKpOt8o6YvBNSg4OMazjiyB/KGqLiWfNpGScGx/Mwgnk6061QiT+2Y9oIY7Yx+Av8AdBeLYCCjWMo2xTW3TfEQAVZy0mPjxRIqK0nNUTVi5QkOgxL2yePrUFCYl/LfJtbyjHmf8pOeHwoYzt46pZ2nTJNjSRuFNKCRIfap2kDXn7MwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBK5mUbydFMUqrtnaiVRf6lZfWqlhWjI7AUjLmHLRho=;
 b=l9sl0orvxKrqsSNh8d2i7DKiu2YtQgu7k/upykwBeqWR06t9T8NFSyMVJOPNZRHanWmc7ENJPxFfYgaqEEEnyyTx74Hu3Lxr1lrbeCeVxOxO9OM/r9yUsP/vu35omXCUXjG6gYHnYiHHPN1npUJyz6+lZnOHFRFL86DrQydExqOeZNODHMgA7z/Cte2/e+fcYseVGR8uKM3NQidAwbiyQ/PepooMIWzY4zuaV4KUd56A5JpzXIqB14fdMgs4Jxr0X68HHvYx/wiPQIZYlAW94I1VNAgnzfpkX+s9ncdMXgTbAE+Q3KcmZ6GW20qxWyiEhaXsqQG9oxwKnWmE+9EZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass action=none
 header.from=prodrive-technologies.com; dkim=pass
 header.d=prodrive-technologies.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBK5mUbydFMUqrtnaiVRf6lZfWqlhWjI7AUjLmHLRho=;
 b=oxzop/Nd87o8ty059vK6U1q/dp/O+PkxipmGqKfgmXIcGfbGy5o96ovEjKm1n0bD3j7XvwlsAFl5OVykPoTQmE15JSmtpfUuCWlLdHJg5EOAgfoly2z0ckR3GOzGXxj5b4iBsjj6NxlKUXVvbuG4CMF2zIplwnWthxiVQpvE3nw=
Received: from AM0PR02MB5923.eurprd02.prod.outlook.com (2603:10a6:208:187::17)
 by VI1PR0201MB2445.eurprd02.prod.outlook.com (2603:10a6:800:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 10:29:39 +0000
Received: from AM0PR02MB5923.eurprd02.prod.outlook.com
 ([fe80::ec30:e2aa:61fb:7f3e]) by AM0PR02MB5923.eurprd02.prod.outlook.com
 ([fe80::ec30:e2aa:61fb:7f3e%2]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 10:29:38 +0000
From:   Wouter van Herpen <wouter.van.herpen@prodrive-technologies.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Marc Kleine-Budde <mkl@blackshift.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: PROBLEM: tcan4x5x nINT stays asserted under high RX/TX interrupt
 load
Thread-Topic: PROBLEM: tcan4x5x nINT stays asserted under high RX/TX interrupt
 load
Thread-Index: AdhFyuJj1zOoVQ3MQF6tNgMHZCJ37QBfrqgAAGa3FZAAAGYtgACTSQqA
Date:   Fri, 8 Apr 2022 10:29:38 +0000
Message-ID: <AM0PR02MB59238FFE89994FBA392A33E6EAE99@AM0PR02MB5923.eurprd02.prod.outlook.com>
References: <AM0PR02MB592368F53A7BEA4154D24A87EAE09@AM0PR02MB5923.eurprd02.prod.outlook.com>
 <20220403105730.fnurim5vnnuxb7s5@pengutronix.de>
 <AM0PR02MB59236CF6507DD614F60D078FEAE49@AM0PR02MB5923.eurprd02.prod.outlook.com>
 <20220405120959.qwtmcafby2jjxc26@pengutronix.de>
In-Reply-To: <20220405120959.qwtmcafby2jjxc26@pengutronix.de>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prodrive-technologies.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 809cbbe3-18c9-4aa8-31df-08da194aaf7d
x-ms-traffictypediagnostic: VI1PR0201MB2445:EE_
x-microsoft-antispam-prvs: <VI1PR0201MB24457CF1B919D2B67507B141EAE99@VI1PR0201MB2445.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wmRoj2a4l3i5TVKqovRWh+9JaIPPPvbWbnh/MqzbxMWqfNk6ealgbC4sP7s7gUBrYVuzXWRtpY58nhBAsC5ys/CqjypPE48gMXJkayo9dGzNFwkGLusyuG4+0PkyxRIbSHvGfvtBQOEMuHHLc/Cqn7umIT4h1zG19MRsMyZsKNgJ7+rmuAh2EmON7/RWZAh5gZAnEqghKh6MCaqARBelONr+yg3DY/r9Am040fxA5ZYPOlLih1HrSbKaRjgt1Y6wlGF3Kg65GLprihB+2N/cSG5VTJAcaFlNQlfup7vf30iHgjI2DYS7D8C3O6rcc1FllpyEcT8UT0cYm6WvjFmFdjTl1TRjW4LTRqw74AbUC07R4C9Qkr49g0Xsy5+n93dYduq3GK3AC6qoHzSinLrU1oNn0fURbjk9+/JUg0B1Ojtq3WO6OY17xFACGc3UjKw6RbAlAhzwu0BWDagh6jfHg9bKGv9g3XmRiSkzOjGBDpztaa5Ac8QsMhFAkICvUNT14wLgpQC3x0ggQ4Sbx60iQbOTtzzuSBDaGJuv1TQLn0cjDnQpv/75WnBBLkvz2uhzLMoVSwLgV25EuebAf0BBdz8GFAqUs6uvSMxtnXfcZgwZ+7+nPndzQJyiQ0tFOHo1JOa2nGBiyyxVG31UDmk7VyNoYay4S1tJK75yXMXzzHemsEN2qtjIxdSPe3nAKMzRAdQOlUPZLDhac5aTiyDBGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5923.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(122000001)(7696005)(6506007)(71200400001)(2906002)(38100700002)(83380400001)(76116006)(54906003)(9686003)(86362001)(316002)(26005)(5660300002)(8936002)(186003)(52536014)(33656002)(55016003)(4744005)(6916009)(508600001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anplZW9UOGZnbTI1aUFmMko4ckpmakZFWkZ1SkgwUXhBOEtXMXNVVFByMjZB?=
 =?utf-8?B?SERNMnFHMFJiTHhVczZJZ2hMT3lqNldnTDkrbkZQY0hWTWs3V0ZMSTg0enlu?=
 =?utf-8?B?Ryt4MzM0eVl6OGhFM2o2WTJ1TTJoaWd6Lytuc3p3VUpNcWZKaWpSL29keHNy?=
 =?utf-8?B?aFpOUGdSeTk1VEtEZXhhVWZIbmMvMytva2p3SUJ0SE5kN3BQNXgwa3BkZEEx?=
 =?utf-8?B?eERiSGo2VDJvbW01U0VnNVBxNTBXTUt2bGo1TWYzZjNhaDgrWk1aRjROeVY5?=
 =?utf-8?B?MXBDcUtyU1pob3g0WlBUQ1NzSHJoZ200M0xFQUJjR1FpK2VkT0MrYzE4WS90?=
 =?utf-8?B?T25WRVlrQ2JJYkZrZVVRYUVqc3EyblFnbG1KTlJ5Zk9jYTdBa3pEcXpZVUtQ?=
 =?utf-8?B?dTVnQzUyY2syc3FOVXkzSjRTMmpPVHVtcDVxY3NEY1dpTFlWZ0xhcmVmVFh0?=
 =?utf-8?B?cW9qU25lYUVsaWVPYnhuZFdrbmhSZnZCWmt3LzAvUTBuQTZreEVrM3Azd3Rw?=
 =?utf-8?B?TXVwa2lXbTdORzRpRWMzdjVMRTh6bGZPbEd0K041VWd0NEQ2ZzJuZGZ3Q1Vq?=
 =?utf-8?B?bnpxOEwzUlRqSTNWQzh3SjdyWStlRE1wSk0wTTlkSEtvS0ppb09aYkpZSDJS?=
 =?utf-8?B?eFd5S05pb2ZLOTVRU1ZHeUp6RE5MMVVIS1Q1WEtkRVBQK0JjQmhxcy9ObHhL?=
 =?utf-8?B?c2NNWGtUSzF4V1BNYi9mSGhRK0tWamIzTmlPMDZMOVk3U3p0L3czZmMzS3Zv?=
 =?utf-8?B?U2pWRC9rUnI0eVNsTzJZK2h1ajhDTG0xUWdrSlVsb04wMk9KcVFqK3E2QXMx?=
 =?utf-8?B?WFZRODNHMmZaUzJ4WTFwdlpFUmVIbnowRDZLZE5QajhLQUdaaTlKQUpkaGdU?=
 =?utf-8?B?aXhCMVRvdEcxY3MvWGVpT0YyZm8vK21qL3NiNDQ4WC9xV0kxc0thY2lxZEdU?=
 =?utf-8?B?aEZBSVF5eHo5WEJFa055R0hhZFJwQU5FUWZha3c3a0xaa0JvRXNHUzN1Q0Zt?=
 =?utf-8?B?d09ISFdzSUZGOVRYUnNQMDhrK0U3dWNSdWtLTUUxa1NsQzNNTXZYUXhHNFZt?=
 =?utf-8?B?UVJWZEtFRE9ibGh0ZXBHSmpTRzBkeXlGSGJWcTJvWktBWnFTeUZtSm95MTlq?=
 =?utf-8?B?TGtWbHdTTytQN0hsZTdiU3JIUFo5eU5zSzB3R2IrZXBNQ3hydGpWcHdqRDla?=
 =?utf-8?B?WXJXb3lTT0xIb0d2NXJLWi9tWkp3dTBhNDJPSlo5UjBqNitEbjY0RmM2SDlB?=
 =?utf-8?B?b0xrRVl5ZEFzVmZ0YmhjVnliaEZUMUw2a1dCZjRwakorTzh0WlFQUGpqU2xR?=
 =?utf-8?B?bUtUcjIrRGZ2NkxUNWZNY3dPU2FvS1gyV1BpZFpwTWpnOU9PV0E1em9Ydy9G?=
 =?utf-8?B?enBEdHdKOU9qa25TT0ZHNTA3NHBIZ1pHVW1HdjNEWG9SWlRtNzdodGlVMGlV?=
 =?utf-8?B?dFgxNzhHa1FEUi8zZTVOQUZLbEVCeWpXQWY0cXVQaVcwZWloREJhWmMxYkFp?=
 =?utf-8?B?Skc4aEZqSlV1WmZBRDlMbnNsTGpOTEYzZDRIQ1lBcVljSFZkbG1XOWxRQ0hs?=
 =?utf-8?B?UnNXZ00ra0xhR2pwSjg4ak8wVUVINGM0c2pQYjN6RlFFekhnT25vZVV1VW5M?=
 =?utf-8?B?Szk5am1OWUNqanV2S0VnY1g2OTdqOXlXbDFyRHUxeXRGVHpQTzdWUWk1RE96?=
 =?utf-8?B?Z09GWVVXcWRCUGwrcVJ6WURSTmw5ZGV2ODFtMHduMDlvaXVsNWJxOGUxYzBW?=
 =?utf-8?B?Wnh2cjNHTWtZK0NuSnZVWG1rYTVuMC9kSFRHbVdtMWxZc3BONmQ0WGNaZkZC?=
 =?utf-8?B?UUp6YlFPVVZZZ25JQmtLbG91R1J4N2tURElDUFlrblFXQU5IN0k4OC9tSzVW?=
 =?utf-8?B?ZE5ZejNvRDlLMmlSR3E4UHFEbzNUdmhBZk1NcWJlZEUrK202NmpCVHE3VDIv?=
 =?utf-8?B?SjJPZkNwem84bDBtaVpZSTJpUTIxQ25HWC80MnkzamlXOXR6Sk5PM1g5Zmhs?=
 =?utf-8?B?TC9HL3NNRk9UNktJUUtLOHNQL0J5QmxaZlpXMUs3bzlyTnlyNWt4NGZZak5S?=
 =?utf-8?B?WHNiRVluai9yeUlkKzRRN1cvOW5xNG5VKzVRbGoxcUsrZ1pwTlBsRk5MV3ZH?=
 =?utf-8?B?SzdmOEY3UCtSM05oUFpGNWNLZEpjVDdnY2sxRW1RbUZaa01Hb3g2QmpjRHY4?=
 =?utf-8?B?VnpRQjllUWFlbWdqWTZ3SjZYdTIzR25ycHR2WENlbXROeSt1R2ZESHRQTjhk?=
 =?utf-8?B?ejIxS2Y5bDB3VzVuSkQ1MEdRRXJzMllxcnI3ZWF0eDdnMGQ4eXcrdFFxYTBz?=
 =?utf-8?B?b1dCL0xnOWMxU3BIVUZqTGV6Rm5CVm9iZXJrTFV5SE1DcUlQWEJFSVRxWWph?=
 =?utf-8?Q?ethugBDpw/eALUJCSXl8NfEtQEsqscHNw+rkrjkuzGqur?=
x-ms-exchange-antispam-messagedata-1: WyeYspeoPybr8g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5923.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809cbbe3-18c9-4aa8-31df-08da194aaf7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 10:29:38.7432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUg6mtGYC0qmKh4hC9fcDFMzewNjET1RLnsH4VENEwLZltzU9OQUOJZJf0q9Q5UhZwMJsGRCjyGo44fDSmvFVMXNQ22x/UkOvu/SCgYmPk+hhWLNpIjLx1BfvE5WGDByTmJqdFH2cSe0STstiDkEIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2445
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBGZWVsIGZyZWUgdG8gc2VuZCB0aGUgcGF0Y2ggYWdhaW5zdCB2NS40LjI0LCBwbGVhc2UgbWVu
dGlvbiB0aGlzIGluIHRoZSBwYXRjaCBpdHNlbGYgdG8gYXZvaWQgY29uZnVzaW9uLg0KDQo+IHJl
Z2FyZHMsDQo+IE1hcmMNCg0KRm9yIGNvbXBsZXRlbmVzcywgSSBzdWJtaXR0ZWQgYSBwYXRjaCBv
biAwNS0wNC0yMDIyIHdpdGggc3ViamVjdDoNCltQQVRDSF0gY2FuOiBtX2NhbjogbV9jYW5faXNy
KCk6IGRpc2FibGUgbWNhbiBpbnRlcnJ1cHRzIGR1cmluZyB0ZWZuIGhhbmRsaW5nDQoNCihJIG5v
dGljZWQgdGhlIHBhdGNoIGlzIG5vdCBsaXN0ZWQgb24gdGhlIGFyY2hpdmUgbWlycm9yIGFuZCBJ
J20gbm90IHN1cmUgaWYgdGhpcyBpcyBiZWNhdXNlIGl0IG5lZWRzIHByb2Nlc3Npbmcgb3IgaWYg
SSBkaWQgbm90IHN1Ym1pdCBjb3JyZWN0bHkpDQoNCldvdXRlciB2YW4gSGVycGVuDQo=
