Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B090166B936
	for <lists+linux-can@lfdr.de>; Mon, 16 Jan 2023 09:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjAPInh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Jan 2023 03:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjAPIng (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Jan 2023 03:43:36 -0500
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2085.outbound.protection.outlook.com [40.107.127.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B9512F0B
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 00:43:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nL/JgmDeAWe80ZKzr2t0YQRWz9ZFZj/GKFDv2Qd+90j3ATuwtHl6Iyz1avQtNOJdoD+2Xt88oNW0Rrdcc4C/+uAcqXjn05UnWR+XL/CUkP47zvhK1Z4F97/aXKiLuuZ5s6MgWya7BBl/JIMiyEdvgWWRjrHX6WgXw97bAqFfm4uDDc4R6LJurxGZ2ePFT0hEZFP9PqdiVm9EfWQ48rtur+pnMExj3j7GvtHNdPQm1PcX8xS3CSSsHfu9MIK6EVFJmh5KZMCx1R1CTlDZwk3BHBH8XyaSA5e3GlkjOx8m00qekeUKmCnZp9t7AiedZdqe1thUbgg07oJBtnEa4SrXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZObY8cksicOvCJWNxlQEajz3UFBPhnYTRrd5x6aDDM=;
 b=UYPBnBJISo4tLB8mNXVRSTMS+p0PTyijlghEDjHQf7mx8sriTJtM55OLFJnOKiccQKPNx+R3dWKyCahRdg9I/w6qzO3Whv9zVACEXMDB8kRoitX+qE0OezY3E12EUUxEXARnOqe1eridzcDvKHc8LrMfwCD73ADoutTc6vOGIl5qFWBMhNK5fDfegpXdU1kpIQUXcqtGZJu+9gE9bNbIh9Vw9eKqs47sROnAXIQJq5VR9D6CaHKdAl9R7z6YJp5Bp588trmpbkV3EfDTNNckjpj03h1vRp5xQGX6rGO6pf+REh5LrKS+f3PA6fyjhiY9esOUfpkz9xrffqsoEPi4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=janztec.com; dmarc=pass action=none header.from=janztec.com;
 dkim=pass header.d=janztec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janzag.onmicrosoft.de;
 s=selector1-janzag-onmicrosoft-de;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZObY8cksicOvCJWNxlQEajz3UFBPhnYTRrd5x6aDDM=;
 b=pd4+H76i3exlvXIIo4cxJsLciIrWndCRm6u8paDM5FvYCBpfnUitPe6lQWBjcnTvaCDkxlrZa7q+o6Wb7Hw9tkuymcpmQ3Zd9pe2CwEG/0PnCPJmLqpg0fZhWKDsHkRje+vEBR7ywntbOvsFF6I2hW/wX7Wd6yzlV0Flh9P6v8Y=
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:26::13)
 by FR3P281MB1453.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Mon, 16 Jan
 2023 08:43:29 +0000
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba]) by FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba%7]) with mapi id 15.20.6002.012; Mon, 16 Jan 2023
 08:43:29 +0000
From:   =?utf-8?B?U3RlZmFuIEFsdGjDtmZlcg==?= <Stefan.Althoefer@janztec.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        "kernel@pengutroniux.de" <kernel@pengutroniux.de>
Subject: AW: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Thread-Topic: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Thread-Index: AQHZJgsgtPZlzMMAzkyw+q4DrZcdvq6gwPyQ
Date:   Mon, 16 Jan 2023 08:43:29 +0000
Message-ID: <FR0P281MB1966FB48421E718CFD09E7A997C19@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
References: <20230111222042.1139027-1-mkl@pengutronix.de>
In-Reply-To: <20230111222042.1139027-1-mkl@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=janztec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1966:EE_|FR3P281MB1453:EE_
x-ms-office365-filtering-correlation-id: f4875032-5351-44e3-0ddb-08daf79dbe21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lVko8XajSINCrDqpE1bxkiWYTJ3Slwbc1s4J+aH6LTD86lFrZviBOkGfov8I9fHpoJl195G3AoEJWr69SBenIoTn/ZKTGKNDT1NbC2tZZ8k/SiK7eqlQc9fOwx7I2fBg3u0y9B5zEWSgMgEHk5hkKRVLuU8Zpt05j1SKfzFKCtC0E96Z3Q/cTdtYMmo3u/mBJ6i/l3GhwyeTvD1pXyHnFMNHfwnJ//FOI+FzJ160Z0J0Q8NC6IxNCI0NiNXCf4r8HhHAlyoepulA2J0akvNnCPfOZAZyaUMPM+aulEUskF6OBKYPNCOK2dciC0AGor94vf4e9vrxC4qgr0P8g5rShc+IEqv3d5K4Y0Jlvdj1KJuYQBZU0Ey77sa6HlFTuAPVzW7lHzpWdN65wpm+ljlgh87xbNZE/x1nCmQyYov2ci9XAr8lQyB9egFUdFoHpz4Hs8oNuQW82SY9YnvmEDGqlrDfhNKegyRJ0YXHV6SshPKBqjFOOHL7z+9M3/FCaVczN5Z1C1Ns4a+zvyyurFgzKDAbRBvOpCAQFSwIYh4sSuWFWpubxn4jjqDttTsG7qv3gQwM+52nVzo65ftPzwKjRTXzt4tTXtl78dtiZOiD0dPPUb9uOIwOd6X5CuwiUQyBq/SeczCez51Am9jwE81YtPx/TQd2hRvJGyxk5luy0fzTvuNlA1qJz7D1ActUuG7DH/9CO82gxojFWE2EUoy5Pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(366004)(39830400003)(136003)(451199015)(71200400001)(7696005)(8936002)(85202003)(85182001)(478600001)(4744005)(5660300002)(86362001)(110136005)(122000001)(38100700002)(52536014)(2906002)(38070700005)(83380400001)(55016003)(33656002)(316002)(54906003)(66946007)(66446008)(8676002)(41300700001)(66556008)(64756008)(4326008)(66476007)(76116006)(6506007)(9686003)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmhoS3A1d05LZ0gwNmR4RVZHVzNtK1RtdUh4VkZ6MnZ4UEZ2Qm1Ya1RjK0Zq?=
 =?utf-8?B?azhWQnFmNFRoMmlEd2RSSjhiUlJyekp2UTAwWm1lWDZBamhoSnhqRmdJb21w?=
 =?utf-8?B?T1lWalJlbTBkSzMycS92d1doNTd2blQ2Slo1YUxWMVMvcmQ0VE5ENm5IWkZO?=
 =?utf-8?B?ajJDdzJKb25YSVhJVHU3a0k0REJ5NXFrNEt5clBLblIzblJNTFJtc1dMRFZl?=
 =?utf-8?B?bkkzTWxGMXd4a2NHKzZUSnQzL3h5YTBOTHVNbjJLUWlGNjlSS3NISUxiMlpt?=
 =?utf-8?B?UXhjL0VuY1NBYTBwNnRVTjhpYkRjSGRDdzRkcFRoOGZwaFdvMW12RldQNElO?=
 =?utf-8?B?WHV0azBKRU80WlMySXFEV2VkTlg1Vkozbkpva0lHRGo0K0U1YmdlWUJDSVJt?=
 =?utf-8?B?MVFQTWZ3cXp6N1F0M0o4SWE4czIramRqSlpKazkrZVM3eklKZXhFVkxPUFNI?=
 =?utf-8?B?T3ZBMTJMV3RBN01Yb3p4T2E4cWlPZDdzNjNRZHZqK1dQN0ZCNzhscnFOTDNO?=
 =?utf-8?B?ajZ3QU9VSTNNRk1sdW16MTZqa0FPSHE3aVFEYmxib0Fyemx5SEIrekkxTGl2?=
 =?utf-8?B?aG9XOE9IUE5yTlFVTUNDYTI2cTdBTXBxNlcwZVR4a3dScEVhMlZwb29rNFpM?=
 =?utf-8?B?U2FiTHRIdmIzSml5V1g1NGdDNnlKM2dXeC9FQzBHak1KNWRSODhORFFZSW5n?=
 =?utf-8?B?NFl2TXk3RU5PV3ZiajFib0RnODFHZERNdWFxUnRESUdKSXdIMWVRNDBKS1Fw?=
 =?utf-8?B?NTI3czlnVWlJcXJiVW1mTHBZeEpkSDVvbUxLU2dBd0k1MGJqK0RPZGtHYTBr?=
 =?utf-8?B?Q3ZqOU53UlZvZ3BmZ1VVUTdvajUwWXJxM24zMTdXcHdIQlNhZ1o5K1FveUJY?=
 =?utf-8?B?VWRTWHBPV2NCOHZJUlJSNDVrdGVXVDVHRExndVlRcW12UDR3bGFXYm9LOHNv?=
 =?utf-8?B?U3hlZkZLQlBTMlRKMHBlY0Qzd0E5S1JoNzNDZUxWL0orU1RnTkZMWllCVVN5?=
 =?utf-8?B?Q2RueDZWUkpaZlNpbjByZzBRT1RnV3VLRnZZc1BCZStNdGtBUXRtRXlmakQ0?=
 =?utf-8?B?NHZORVFENjQ1dVU2YllsUXZHZU5YNE5XbTM4MUY0L3FwVGJJMHBVNitmZTEv?=
 =?utf-8?B?cnZIRW4zdHVBYzN2ZzNvODlBaHdVeURqb0hzZjJiYll4MmxJR0NDRmJwcHFw?=
 =?utf-8?B?SVRLWnFKVTdsMmdBWmk1YmhvSzFrSEpBeis4YWkvSTRPWkdnVG9EUVVrQjFv?=
 =?utf-8?B?WVpZVU5yYnQvRW1PUmcrTFoybkdsN1FmYlMxVERMeXA2Z1dES3VFaGhaUExS?=
 =?utf-8?B?bjl1c254czMycUd5aXdBa00weHczVlZ4Q2ZaS0pWVHh1WjcwRG42Mnd4UEFN?=
 =?utf-8?B?VHpRZ1V0V0g4clpkYjMrZStSck1FRjFRdFJEeDFTRE5OQWhDREM3MVB1S3pa?=
 =?utf-8?B?N3V5SDVMb3BaRnJkRnJ1VHV1bGlzZGQxdisvUEx6SXNtMWJGSkhKRFY3WW5r?=
 =?utf-8?B?cHBLMVh0cS8wSU96QVpXc2FkY0I0dlkwVlNYQlpGSWtDV05FckhJSUMrclA4?=
 =?utf-8?B?djFrelRZSkdPbWY2NjlzMDhXYUVibng4MU9vRk9VWnlJRkJKNG5oSmFtM0RK?=
 =?utf-8?B?WHdkc3hkTmN5emYzNkZQYWZFZXM4NFg5TmpqaGcveFZVOEd5R0VYby9uMCtk?=
 =?utf-8?B?WUZ4R3J0ZnZZUWw2eCsydDZFdEUxdjBZa2dQZS9tamxDUCtLajQvWTd1ajZJ?=
 =?utf-8?B?cUppWUorUmdJMEtWWEpuNU10dE9LTkZCSEFabFVtQUFCU1FqMGY1VHR3N0Uv?=
 =?utf-8?B?cjlSWk82VjkvSVFQdDBRYU9qQnE1aFlrMVpWSnlGR0NIMEJXbnBTNkNtTnBB?=
 =?utf-8?B?Q0RtQzVGc0tQeFQzT3h0N1ZkVWJNQlVmWFhXVTFCcllrMHNFU2w4alhLd3ZI?=
 =?utf-8?B?Tmw1WVpTb25DTVhFcEw3MHNRQm9CdEFrYmt6S2V5MFFsTXltbnEwZVg3MEp6?=
 =?utf-8?B?UVIwTTRWSUluTXRBSnpVNW55ajR0RW9qamNvZHNJZ29PUDdkdEUyNWsxNG1I?=
 =?utf-8?B?RVFhWXI5aVI5NlhJa1JCemtqclExbmVnQWc5eWRqMTRjNmR5cXA3emI2NXRr?=
 =?utf-8?B?NmRBLytnK2Vaa21TUFZ0QXYxK2VtNmk3cE5BcHowdU1pemRNWkl2bmJtQURq?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: janztec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f4875032-5351-44e3-0ddb-08daf79dbe21
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 08:43:29.7953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c1dae847-7bcf-493f-b143-af65743cbb23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssFvOjozi8ANcxnuxMYL6LiANF5NdcNUOdfbc48pkWAImXz4QaZVmQNmfOQBaiTSukfgfGX2e7G0+ZK3RsxauGZDx21UccqkXqdsFsX5KOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1453
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

VGVzdGVkIHRoaXMgb24gdHdvIHJhc3BiZXJyeSBDTTQgd2l0aCB0d28gTUNQMTUxOCBjb250cm9s
bGVycyBlYWNoLiBDQU4gZnJhbWVzIGFyZSBzZW50IChhbmQgcmVjZWl2ZWQpIGJ5IGJvdGggc2lk
ZXMgInNpbXVsdGFuZW91c2x5Ii4NCkluIDY3IGggb2YgdGVzdGluZyBhbiBhdmVyYWdlIG9mIGFi
b3V0IDEwMCBmaWZvIGVycm9ycyBvY2N1cnJlZCBmb3IgZWFjaCBDQU4gY29udHJvbGxlci4gTm8g
d3JvbmcgbWVzc2FnZXMgd2UgcmVjZWl2ZWQgYnkgdGhlIGFwcGxpY2F0aW9uLg0KVGVzdGVkLWJ5
OiBTdGVmYW4gQWx0aMO2ZmVyIDxTdGVmYW4uQWx0aG9lZmVyQGphbnp0ZWMuY29tPg0KDQpKdXN0
IHRvIG1ha2Ugc3VyZSBJJ20gY29ycmVjdGx5IHVuZGVyc3RhbmRpbmcgdGhlIGlzc3VlcyBpbXBh
Y3Q6IFRoZSBkcml2ZXIgcmVhZHMgb25lIGNvbXBsZXRlIHRpbWVkLWJhY2sgbWVzc2FnZSAoNzYg
Ynl0ZXMpIGFuZCB0aGVuIA0KcmUtc3luY3MgdG8gdGhlIGZpZm8gdG8gcmVhZCB0aGUgbm93IGhv
cGVmdWxseSBjb3JyZWN0IHBvaW50ZXJzOiBIZW5jZSB0aGVyZSBpcyBhIHNwdXJpb3VzIGV4dHJh
IGxhdGVuY3kgb2YgYWJvdXQgPCAxMDAgdXMgKGFzc3VtaW5nIConDQoxMCBNSHogU1BJIGNsb2Nr
KT8NCg0KLS0NClN0ZWZhbg0K
