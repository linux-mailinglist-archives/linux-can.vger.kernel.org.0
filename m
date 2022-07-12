Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7861D571FB4
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 17:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbiGLPmA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 11:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiGLPl7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 11:41:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2093.outbound.protection.outlook.com [40.92.21.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81826C3AD9
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N47s0z8o5EEFRTU1zgcifRQa+cjdno9eX2gGPZsxDEXjtYWd2X6FHpQC51htgpM3H7Ft4GEDzYIqk5oxSzZs5CRCsInacakULhE2r+D0n6QvNcygWkcEXiDA+J0liHcY+WyF37n6n9vcIcNYNG4YhZw3dVHY5h/cf0yUDlOgK2TL9VZPgGMliZlrKHfK3MnYtjmnKUaFhbo7htAJDLoS3WlFf6mQVzVmr9ByBNOsybfxNlY9h05wBTTlVYTGKwKDp6ipa5oQzVnrHjmegSVN9XYzrg55WSi1T5LdzwsMfcEdD70I1EsHWaULnoN+yJ6mx8t74wU9qEHZIKWv1zVK+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHP85iow2iG7N/tgZKMtTPqEL9hKpSoMCGLwUEZg2mM=;
 b=S2T/0xYAwmJzR2zm/CzUUyjI03kXlwTx6GzNJyfuAi2uCriHhEWOV3pdpOAvW0lupOP5ittaz8/mAMa57g2784op2ONbcBp/WT8Vtxe2bt2MBQfry4p+xFDb86pRHTihif4hCQRZOfIsS0Vr/SchpOWRcmrX4+YsypAlSjPTIsDMUg+RYmekyRFw/bgMXUXUPhKnOdJ0fdMaOzVjw1DlxBqtOZhWm5M41+ZUCqLSmDNRbjro5IA34Zl8EcZ5TNwXFYlog4KIAJxEeYau3oe3+YcQmUHV0htNRF1djKWFaTQxLdjJInRzs04WHiynfxPpy0EmvJvt0wHclGQ76Jxyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHP85iow2iG7N/tgZKMtTPqEL9hKpSoMCGLwUEZg2mM=;
 b=nfBqyBjLgsWa2x575+lG7iJ6PiHEQYeakKUQWTZf6/OfY3sGPP/iC2M0XuA7Z4LNMxKbbdLJN/uW81wAJ8HPYwba6nX1mZQ4icYJAvUBRxm5CSSVZjKsr0N3WgFKcvyHzEix443p8URhn6yEc6mRNjKMybvcCePq/+SxhgFXjeMGy7L9q8CGEiR1t9JZ3XQYWVSeCPoFq9p0DvF5n+HCHM4avZT3JhRlc6PhLBUm9PI3sWMGA1Fg9WIe/u4VdRpNgAO20GI/INuVQIg1x7eG1SgYhOQyJ+Cs4y6vNt2Wbom8vA/diS/Wl3pSTudW84lzlim0E2YaulPNe2D7LSBJ4Q==
Received: from SN7PR14MB4270.namprd14.prod.outlook.com (2603:10b6:806:10c::9)
 by BY5PR14MB3956.namprd14.prod.outlook.com (2603:10b6:a03:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Tue, 12 Jul
 2022 15:41:55 +0000
Received: from SN7PR14MB4270.namprd14.prod.outlook.com
 ([fe80::5484:2724:f7d6:b0ff]) by SN7PR14MB4270.namprd14.prod.outlook.com
 ([fe80::5484:2724:f7d6:b0ff%3]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 15:41:55 +0000
From:   Sergio Alberto Valdivia <salberto2000@hotmail.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: vcan OpenWRT
Thread-Topic: vcan OpenWRT
Thread-Index: AQHYlgXq2ZnGuBwybUyscbp868S3Gg==
Date:   Tue, 12 Jul 2022 15:41:55 +0000
Message-ID: <SN7PR14MB4270AE6DC8F68C87E6FD2876DD869@SN7PR14MB4270.namprd14.prod.outlook.com>
Accept-Language: es-MX, en-US
Content-Language: es-MX
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [pBX3jr2DbdREnU6wqGg6DGyMSvBflmXe+m0P4rnOzt4=]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2734a333-b52a-41ae-d32b-08da641d0cc5
x-ms-traffictypediagnostic: BY5PR14MB3956:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PQ/isPWBmjGRv525/8MKKXzpkF/L1mldekKgV8PbZImWVSAdlo8QdarVtBe03Xs5ypDsau7H9Zp15Y1xPJ/VHhVRELiqGtrx4QWRek/V4JvreK/Z8Ht+5DVroP0qVsL/02BW8/WB0oXb71fpxKePTiFTlV1Zzx91svCRIH3LmuaJCpw8Uzfra4RDzJ2Vo7cTR5oqWpe2zImcT/Lf0bl/vhBSSt8T1XlKmjclRXYWop/DgLQIxO99XRYmlFVCR/aKXHJAJRBDF8G+tVTqmwxR1/9gJooqyQpCjvHJhLOMM0MU0XFnVYqe/betZKRL1MEDw9UbsYz9gUErgzmBy4inCyNeGTjvFHsN8Emh1oNq38KIoyvICeHbzCd8vZHdKLbbqlw9OC0igDi1x1caFh3bPUMrdv8z0z155z8aSDbEQSZoP65QuxwMXgfvrk2piUYLb4+FosYjLfA4i3Ai1VaEEEK+sz70MJwuiEvBVlvMvDjCA73yc4kXvBwGXlExhibsv0bYaGgTOl7URySPkRdNZ5t7H5CV9/BXlsIT2fjy8QH8qrVMQR7+R0Ttxr/AW5eCJu7PWqrpmXk0FbAQLpx6FZyeenWwou9u1veZeww0j49DtuX1FrvIwuUQOPzvMRshHo5t3YS2C8Fe0swbKTkAyC+HPdFnPWtGWMeutI4LKWmyQ/zp9y49K923OZD3tcA1TYHHbDIWu/08bZ9ZvNGR0w==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEQ4ZHdpTkI0ZHRRY1laNkJ2N0dYd2l1emJzaU9aQXpsMjhQMDVrdFVwMXdN?=
 =?utf-8?B?VVRIWjlRcElTL1Z5SzJ6R3AzK3FVUzNTLytHVUJ3NzNCUW1XaHpBRVZXbDA1?=
 =?utf-8?B?S1ZsOXBtUGFMeStTVWsvTXE2M24zYkxWY0hMcDVUYlk5d0F3cHFKK2YzaVZW?=
 =?utf-8?B?VVo0aXNMMnBaWlFLaVVONWIwYURLRkJnemtuVEJ2NDdRcnpPZG9CNWE3Z3cy?=
 =?utf-8?B?QlpGMUJhaGUvZEp6STl4aUdpRXlXN1ZKTFZKaDVCbHFTQzdiS2U0Yk16dzdq?=
 =?utf-8?B?MkNtenpkRWE4R3FtN0szVWlXWEJKa0p3VTdKYnc4cU15aDdMU1VqUEhTcHhY?=
 =?utf-8?B?ekMyU1I0YjZnUnR1cGJmTFNyWkRKNzNHTW9jWTNBQVg4SkRvQmJrc3VhMUxs?=
 =?utf-8?B?NUIxb2ZjL3RROGVwSWxZcVpQb0ZPTVlrMDlnMDhhcVVIRC9vSkY1R05lQU9W?=
 =?utf-8?B?dGROYms3WDFjNlpOSHNsaUVNUDlGRWRpRFNPcnhkeUUreElvNXVxU1o0SVRP?=
 =?utf-8?B?RkRjbkQvU0svS1ltVjFldGE3czBPd3hhRVdjM0VNcGY4YlZpNVc3MWJWemJH?=
 =?utf-8?B?WUR3b0wzbVdoNnYrZjNoOHdmZnNGSTRhM3JSc0ZjTGpCLzFidjlraGxHcXRF?=
 =?utf-8?B?dVZDb28rdW5FeHhaTVZmQnJ6bkxLL2cyK2VFcC9PbytWWlJ0RUNuUnl5RXlt?=
 =?utf-8?B?bWNXZTJRTWJVR1lXY3p5M0ZTV3gwVUp6UGU0MWNPZmlYUFYrMkg0ZnZVbEV1?=
 =?utf-8?B?UDhPRVZKdzdGa2dGb1lvSlh5MVJxaHozakxSK3J1bFo0ZktCVUxmdVEvRjFi?=
 =?utf-8?B?dEQwTVBXSDhWR0xrN3I0STNhc3Z1OG00VU1vWlp6d1VJaGozWFEwdHFJTkhZ?=
 =?utf-8?B?eGlQYVZYa2lVSXpJcDlKaVZlRWFrQ3FkNzBzcFREV2d3WmJHUDNEakV5ZUFy?=
 =?utf-8?B?VFlja3lCa29wL2VJQzFrV05GaUErbHg0WWFsOXBmaTdpcUZ5VWF4TEZtaFE1?=
 =?utf-8?B?SHhCcS9jV2NmaDdDUHZxNnk0dEY0TUFmKzRseCtIemlGekpOeVY3L0JNYjN0?=
 =?utf-8?B?aWJCdjVDZXFJNit2OU00S3BlbnlYZzZ2akVDSUcySjBPeUc2UnJDTUR5c0VU?=
 =?utf-8?B?b2NHNjIySGI2QTNZVnk2Q0hHZ2xBajFmY1RTTXE2N2dWNjg1cjhSYm9od0RH?=
 =?utf-8?B?d25YUm5RL1hSSXFNdU1yUng0MjF1U1ljZWJXNW9xbHBFeXNmWTIzLzNDYjBw?=
 =?utf-8?B?MWIxdzdIa0J3eThGbDM5MUF1YVpqTmM5eVJnSm9oNEZpRGxndTlXSElFZzZv?=
 =?utf-8?B?YVJsbnJuUTYrREt3WkQ2eHF3cFZ0ZEhrTEc4L01Cd0NpWkYrckI2NTFrMjdC?=
 =?utf-8?B?WnlxWndZZGM1WlBLdk1USWZzbUYzejg4Z0t1TEVJdFBKcHRWc0NEMk5aWnpx?=
 =?utf-8?B?a3N6a2xabXRHd05Jd0hBYVhYdURMVW5yYlBkQ0ZVNDhVUHBGZnErODBmYUZs?=
 =?utf-8?B?ZERXVDdoQ2JHdXJtNi9rVkp3VnJWMmZWVnZQSlh6QjZ4dXNGNFZVcnFPVEor?=
 =?utf-8?B?UUwvQW1MUWZqcmZQNVpaZW5XOU1aSjE4S3NVT3gwUWFENUVYeVBuelgzS0Fh?=
 =?utf-8?B?bXJod3I3bzJZaU5OSDdnZy9HR1VBQ1hwVkVqYXBxOXhBVTNUNlZ5Y2Z4Z29L?=
 =?utf-8?B?dUFkZXlWcTJZK0ZDVFpwRDhHcDQ3cGZMOXJGQnptMHVVakxXVnNRdTduSVFv?=
 =?utf-8?Q?PKHH2Yb0Lp5SW3Hx9A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BEB3DABC5878D46B648D6E45E1049F2@sct-15-20-4755-11-msonline-outlook-cd57b.templateTenant>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-cd57b.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR14MB4270.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2734a333-b52a-41ae-d32b-08da641d0cc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 15:41:55.7310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR14MB3956
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgbXkgbmFtZSBpcyBTZXJnaW8sIEnigJltIHRyeWluZyB0byB1c2UgY2FuLXV0aWxzIGluIGFu
IE9uaW9uIE9tZWdhIDIgcHJvLCB3aGljaCBydW5zIE9wZW5XUlQuIA0KDQpJIGhhdmUgYWxyZWFk
eSBpbnN0YWxsZWQgdGhlIGNhbi11dGlscyBwYWNrYWdlcywgYnV0IHdoZW4gSSB0cnkgdG8gY3Jl
YXRlIGEgdmlydHVhbCBDQU4gaW50ZXJmYWNlIEkgZ2V0IHRoZSBmb2xsb3dpbmcgZXJyb3I6IGZh
aWxlZCB0byBmaW5kIGEgbW9kdWxlIG5hbWVkIHZjYW4uIA0KDQpIb3BlIHlvdSBjb3VsZCBoZWxw
IG1lIHNvbHZlIHRoaXMgdXNzdWUuIFJlZ2FyZHMsDQoNClNlcmdpbyBBLiBWYWxkaXZpYQ==
