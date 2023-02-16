Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD46998F8
	for <lists+linux-can@lfdr.de>; Thu, 16 Feb 2023 16:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjBPPfK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 Feb 2023 10:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjBPPfJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Feb 2023 10:35:09 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2101.outbound.protection.outlook.com [40.107.101.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32A44DBE2
        for <linux-can@vger.kernel.org>; Thu, 16 Feb 2023 07:35:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuYdCg4b6Z5Es5esUbG+nGreKXUSO1nSSFQvCEoPkAc5KXnqV1n5jdQeknNufLtQg2UUUKcdqJDkSyZyVKbz/zehTuCQDkAkwu7KKaWVEjGXmKL//K57P8JN5kEYQNfcQb+G2lgB8zNUa4iTQOHGv+GsruFOlkbkTS6h/rvH45VobSqKoLubw0NBQpdTjKFSXDNgEaZFGjd/sJsvGjSIQtY5FaaySr6HAs8XPlnyuD+1wqOBL0m2L4Ar1gycb0VQtlFgmcMYRRt6dwMjFForbOmKrkWTssJKleiuNloXNCwdVK0BHGOw7VopUL3Zkq4HBbCxmfHMngjPHohvONiyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeC1fLIbkdz92vx9niJteinYkb0d+kDob6Fvm39sl5U=;
 b=lMf2rAMy5vLIhqnQLOJdiEwCGRbYDzFM73MFLv3Ao4P6Xy2+J2WqWPWGSUBmykUjqxYsfcJeghTdv9FGPKWVuiUlW8OAs/vrJqU5qyMenY+Z8pIzNqKcr67/niY+w+3NlT5LW8Xj7JZSCR8yxLXssjFoUprKKxZ6JnrVTTb32LmSL/IgwJU5ixshZzTjPYKLXdWux1GbMf4VXrlo5wx7QkcSzwllsVm20uBp6lXtDWiXr77YOQzNyTt7LMFHdgcsDzmXZV8qxzL+/jIgNRDHzuDrXt/ls8pbOOcbbW2cGFbjqqX3rh7jZkzCfQccmokZtnZ+FoTeDcHMazBZCMNnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=visionengravers.com; dmarc=pass action=none
 header.from=visionengravers.com; dkim=pass header.d=visionengravers.com;
 arc=none
Received: from BY3PR01MB6515.prod.exchangelabs.com (2603:10b6:a03:356::12) by
 DM6PR01MB3819.prod.exchangelabs.com (2603:10b6:5:87::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Thu, 16 Feb 2023 15:34:58 +0000
Received: from BY3PR01MB6515.prod.exchangelabs.com
 ([fe80::523f:b55:348c:22f6]) by BY3PR01MB6515.prod.exchangelabs.com
 ([fe80::523f:b55:348c:22f6%9]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 15:34:57 +0000
From:   Hartley Sweeten <HartleyS@visionengravers.com>
To:     Michal Simek <michal.simek@amd.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: RE: xlinix_can: bug when sending two RTR frames
Thread-Topic: xlinix_can: bug when sending two RTR frames
Thread-Index: AQHZOzUfWBTdxO8rPEqAP4DTfIcja67G6HAAgAqSEYCAAEKXMA==
Date:   Thu, 16 Feb 2023 15:34:57 +0000
Message-ID: <BY3PR01MB6515CC4390A51A5564C69634D0A09@BY3PR01MB6515.prod.exchangelabs.com>
References: <94e3c5bc-6af9-f240-86fa-2b780a58533f@hartkopp.net>
 <a2256c85-4253-dff5-fa8e-00fc02916095@hartkopp.net>
 <ea15524a-1ed9-0dbb-9511-c333a66a2555@amd.com>
In-Reply-To: <ea15524a-1ed9-0dbb-9511-c333a66a2555@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=visionengravers.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR01MB6515:EE_|DM6PR01MB3819:EE_
x-ms-office365-filtering-correlation-id: 1d54af37-6e51-4bf1-995f-08db10335c35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yNPVLjPJwk8ceLbtLg0pD2ZfIh0F+aMi0Yji2IbXg7em4qgkw4UdNkR7elyu6frAXi1qd/yWSpjDbMBwXRtGzUsc8Md7YvP9Rgc3V+1fOEhBlfDjAzCOxIddSbcRHDHJYuDTB9AUoKe6fPZ2M8+zVLR8TTIfwEFzTee10BGq4i7M1v15rTQRKwe8t1T9+eUDqbIBrO4CFcz35lodJjyOjlUNOBpDVW9xX/fxmJCvOP7770EJ08fS0prETaxHyyxA7ou2wW8Ow/j4DTysBV+jto8aEdsqYOIE4YENOb1AlPJo7TrDzIqsVDjNHV3pvPQJmstZ0j1yqOZbozIj9+1UCgUUq4rpSq1e1ERYZL7vkPKYhb2xYlsx+u5w72JncpygmYtARcheOYDXuQYKET+Jl9kAh1nmg4XV1dHJdZx9T2MiWQgzLfiGgetsS4xojjaY7PEmKy0/zE9bk3qk3MeX6AbkPbelikBlRvTA4ndyI7bwSlh6puo14A79yolW6ftpjGfJjOd2Zr3TiqNFU5/gOG5NMNRl9lp4Q/eXR6EQ0yRbm7KkT/e8kZ2Ca8/2WbYxNIZGq1oZbqPOHSc77YBMRNEOd6Gda9UwNsZ4wMzTfVxID3pgsnep3f2jmWZZ6Na4ZK/Cbdf1rz6rVlEqHCZrCpkrMrtlsJINV08Szd6tgMmTB6NJA1ceUvZnf05Mv6Qr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR01MB6515.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39830400003)(346002)(136003)(376002)(366004)(451199018)(2906002)(86362001)(33656002)(966005)(110136005)(478600001)(7696005)(83380400001)(26005)(6506007)(71200400001)(8936002)(186003)(53546011)(316002)(9686003)(38070700005)(4326008)(55016003)(122000001)(5660300002)(64756008)(52536014)(38100700002)(66476007)(76116006)(66446008)(41300700001)(66556008)(8676002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVlsSlJXVkY3RFlNdHVydXd4Tk5rN3JoRFJjdGQvdWlTVWFHWUdBbFFNdE1B?=
 =?utf-8?B?KzJrZjVTYkprcVJKaVQ5ZEgxTGFRZnozelZSSWp6VzhSbU9HaTM2VVdpaHFV?=
 =?utf-8?B?US91TkdlZ0FDMndiUXhQVnBQcHVuM09BQkZXbDVPNE40NW84cWRvQmh1cGFI?=
 =?utf-8?B?anFxWC9QOStnUGVCbDZkRW05d2pVMGFjZW84dXFJM1JmMC9ZZEVWZFFYNzdh?=
 =?utf-8?B?MHFUMnlzbGRHb3RNeXBuMkNJOFlZMzZmK2FCRXZENkJRM09Ecm5uU1RhNnUx?=
 =?utf-8?B?cG9wUUYwLzRGYlZZK2tMUGJuQ0FsUnN0M3NRUmdaeUs2Ui9Kam5OenZOdERX?=
 =?utf-8?B?a0ZqeDFBcmgwZFBGcmNGaFFFUVRjK24vOVNMMzdJWFBTOXptdmQvb0VidGtt?=
 =?utf-8?B?WXZwK3NDSXNESUhNSTBSNjgxWlNHZE1MTkRWQXpOTUJlWWFEL2VlV3Z3SnQy?=
 =?utf-8?B?RllmVitxeVZMWVlWUVBUVVZMOW1mYnlzZWVvUlpuY2gxSVFiNVlQNUE1Qk1s?=
 =?utf-8?B?b29zRVdzV3hVM0RkMTJ1Z2RDTWpSTzFtWnZ6blc4RVJZQW9wVjZBSngySWc3?=
 =?utf-8?B?UFhKWnJGM2xkNmM4Y1gvTTVhRXhuWjU0UE4vVHBQdTVmdE9BQzJ4eENVQzh1?=
 =?utf-8?B?aVAyTWlka3A1K0g4WkY2U2I5VSswbmlQQnI2OG1XTDRhdlZJa3hpK0RaaS9H?=
 =?utf-8?B?YjdaN2tBdWpjdlFibzdQN2VLTU5ha0hJeEs1SEFCSCt4K0p4SDNlRFdRRU9R?=
 =?utf-8?B?NXl3MVFQN1BVTFQ4SEFVaWhxc01OY1dTallpY20yekNKazh2T1dHNEJWaDNW?=
 =?utf-8?B?U0VKNzZJRExjUnFxQ0kvL1orckNWVEYxY2JQN1Y4SnowTzBZV2pvUTZ6R2pN?=
 =?utf-8?B?TlFyRjZBVURiT090dzBIL01ROWhIaUV0aWEzZUFndUsxbUxzV3JhcDdac3Ey?=
 =?utf-8?B?Y0VLRm1GZzhCdnBUU2w2WEd6WUVEWmVucHFSWjBzR3NkNkdLaERFMVFUTUVS?=
 =?utf-8?B?T3RLcTkyRE9PSkhDUVNUVG84L01hL01SV1V2bG5vblAxT0Yra1JOdlFqUlo5?=
 =?utf-8?B?eG9qVWdUa2xzaE5yR1RDNzFHQjJRdDI5dzR3cysyOWJzK2hRRTBaSVhreHJF?=
 =?utf-8?B?QSt4cG9uMjN4K1FlT3o1S1R2UVFOdXhXYVd2QXlhcjRBWTRWdWtWQjNwdFRr?=
 =?utf-8?B?SDdNem8rd2hMbzFZSllJcW5VRW8zeVJLNVJZQmMvTjNxZE5zNDk5UllTdjRy?=
 =?utf-8?B?RnR4RHZ3cjMwZ2tjTWorbG5kV01MQmREN1hIVkYzUTFtcmhibjlvQVhmYU1i?=
 =?utf-8?B?VGdkb0xHVkJYa3VzY0ViN21hR2hTcndDcy9tWUh6MkFIWUUzencrREpoUk1m?=
 =?utf-8?B?L0FpZXZDbW9OanV6WFcwZjRiWjZVSmc4RElCcFNGNTRiTnk5SWtQYkgwMjVU?=
 =?utf-8?B?RU1Vc1EyWVkrK1ZZTFhaTm55WU5nWnBIc0dJM3lHRXZNN1U0Szk0YTYzMmFI?=
 =?utf-8?B?ZHhkRzlHbDh2Ym9KUFdIWElMR05ZNXYxTGNLT1ZmenJleXVzaGJyS0VsRy9R?=
 =?utf-8?B?M0tDZk1Rcjhuc1QvNFQ2Vml0c3Q2US8zMm5NbnRzbFhNS0JDNG1BUkpRV2Qz?=
 =?utf-8?B?VkZ6cTJNcHkvZmFYMjhEd0tBNDcvRG12ZXFpamxxUlJ3WWFWSDJLTmxVUE5H?=
 =?utf-8?B?Y2MzcUpjaFpMZFhQVUtTT21qMnQxUDdka01uYkFyR1NDYjJORkJ5WUsrLzNP?=
 =?utf-8?B?d1I0WXNWNDB4VHBCUzFyVG5kaDVlYnMzVGFKNktsT1pobGZiTmdLOGhqWkJs?=
 =?utf-8?B?RzZvZFdMYlVNOTlLQzJpcUcvTml6aC93ZnFwaWZ6eGVLNCtXbmY4bm8xTWJ1?=
 =?utf-8?B?aVJKdkhaOGVic0QrZW5KbWZrK0pxRWpOelBWMHZYMFIwSmZuQ00waGFZdFBl?=
 =?utf-8?B?WFZYN1h4WEtKdHM4U0w4eXN0S0Z5aG00V05IMGFIc0JVZlJuK2M3c1RTTUtW?=
 =?utf-8?B?SXhoaFlhdjA5cTcwV2ZrVGpla0VIL2VvQ09hdFB4RHpRMzVBcnpORjhaWDNU?=
 =?utf-8?B?WnJvUFlpMW9QOWM5Q3RDM1VJU1pJZXU3dzhqT1hhdTB2TFBybFJoWmV5OEpm?=
 =?utf-8?B?ek1zZnVLOEU0U1E1dDFINUcrZjdGVGw0SmYvdXMyYk9ORi9Rbyt2czJPV1gw?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: visionengravers.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR01MB6515.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d54af37-6e51-4bf1-995f-08db10335c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 15:34:57.8825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d698601f-af92-4269-8099-fd6f11636477
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iCI48Ga3EGuBUxbPpJDANJTuBzkazh4ndxkVn2UNY1fHirYaSk+uE99PqRo2R7AvxyxABa+eTMkZj7K28TW/Dn8YoAgsqxhVddoVyFzENmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB3819
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

T24gVGh1cnNkYXksIEZlYnJ1YXJ5IDE2LCAyMDIzIDQ6MTkgQU0sIE1pY2hhbCBTaW1layB3cm90
ZToNCj4+IE9uIDIvNy8yMyAyMTo0NSwgT2xpdmVyIEhhcnRrb3BwIHdyb3RlOg0KPj4gSGkgeGls
aW54X2NhbiBtYWludGFpbmVycywNCj4+Pg0KPj4+IEhhcnRsZXkgU3dlZXRlbiByZXBvcnRlZCBh
IGJ1ZyB3aGVuIHNlbmRpbmcgUlRSIGZyYW1lcyB3aXRoIHRoZSANCj4+PiB4aWxpbnhfY2FuIGRy
aXZlciBoZXJlOg0KPj4+DQo+Pj4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LWNhbi9jYW4tdXRp
bHMvaXNzdWVzLzQwNSMNCj4+Pg0KPj4+IFRoZSBwcm9ibGVtOiBXaGVuIHNlbmRpbmcgYSBzaW5n
bGUgUlRSIGZyYW1lIChlLmcuIHdpdGggJ2NhbnNlbmQgY2FuMA0KPj4+IDAwMSNSJykgbm90aGlu
ZyBoYXBwZW5zLg0KPj4+DQo+Pj4gT25seSBhZnRlciBzZW5kaW5nIGEgKnNlY29uZCogUlRSIGZy
YW1lIHdpdGggJ2NhbnNlbmQgY2FuMCAwMDEjUicgdGhlIA0KPj4+IHR3byAocGVuZGluZykgUlRS
LWZyYW1lcyBhcmUgc2VudCBkaXJlY3RseSBhZnRlciBlYWNoIG90aGVyLg0KPj4+DQo+Pj4gVGhp
cyBmYXVsdHkgYmVoYXZpb3Igb2YgUlRSIGZyYW1lIHNlbmRpbmcgaXMgaW5kZXBlbmRlbnQgb2Yg
dGhlIHRpbWUgDQo+Pj4gZ2FwIGJldHdlZW4gdGhlIHR3byBjYW5zZW5kIGF0dGVtcHRzLg0KPg0K
PiBJIHJlYWQgdGhhdCB0aHJlYWQgYW5kIEkgYW0gbWlzc2luZyBkZXRhaWxzIGFib3V0IFp5bnEg
Ym9hcmQuDQo+IEFyZSB5b3UgdXNpbmcgYW55IGN1c3RvbSB6eW5xIGJvYXJkIG9yIGFueSB4aWxp
bnggc3RhbmRhcmQgZXZhbHVhdGlvbiBib2FyZD8NCg0KVGhlIHN5c3RlbSBpcyBhIFRyZW56IFRF
MDcyMCBTb00gb24gYSBjdXN0b20gY2FycmllciBib2FyZC4NCg0KQ0FOMCBpcyByb3V0ZWQgdG8g
RU1JTy4NCglUeCAtPiBwaW4gRTE2IChMVkNNT1MzMykNCglSeCAtPiBwaW4gRjE2IChMVkNNT1Mz
MykNCg0KVGhlIENBTiBpbXBsZW1lbnRhdGlvbiBvbiB0aGUgY2FycmllciBib2FyZCBpcyBsaWtl
IG9uIHRoZSBaQzcwMiAoVFhTMDEwNCBidWZmZXIgLyBUSkExMDQwVCB0cmFuc2NlaXZlcikuDQoN
Cj4gQ2FuIHlvdSBwbGVhc2UgYyZwIGR0IGZyYWdtZW50IHlvdSB1c2U/DQoNCkFsbCBvZiB0aGUg
Y2FuQGUwMDA4MDAwIG5vZGUgaW5mb3JtYXRpb24gaXMgZnJvbSB3aGF0IGlzIGNyZWF0ZWQgYXV0
b21hdGljYWxseSBieSBQZXRhTGludXguDQoNClRoaXMgaXMgdGhlIG5vZGUgaW5mbyBmcm9tICdk
dGMgLUkgZnMgL3N5cy9maXJtd2FyZS9kZXZpY2V0cmVlL2Jhc2UnDQoNCiAgICAgICAgICAgICAg
ICBjYW5AZTAwMDgwMDAgew0KICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJ4
bG54LHp5bnEtY2FuLTEuMCI7DQogICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8MHgw
MSAweDEzIDB4MDEgMHgyND47DQogICAgICAgICAgICAgICAgICAgICAgICB0eC1maWZvLWRlcHRo
ID0gPDB4NDA+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiY2FuX2Ns
a1wwcGNsayI7DQogICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAib2theSI7DQogICAg
ICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPDB4MDQ+Ow0KICAgICAgICAg
ICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwweDAwIDB4MWMgMHgwND47DQogICAgICAgICAg
ICAgICAgICAgICAgICBwaGFuZGxlID0gPDB4MWE+Ow0KICAgICAgICAgICAgICAgICAgICAgICAg
cmVnID0gPDB4ZTAwMDgwMDAgMHgxMDAwPjsNCiAgICAgICAgICAgICAgICAgICAgICAgIHJ4LWZp
Zm8tZGVwdGggPSA8MHg0MD47DQogICAgICAgICAgICAgICAgfTsNCg0KPiBZb3UgYXJlIHVzaW5n
IDUuNCBrZXJuZWwgd2hpY2ggaXMgcXVpdGUgb2xkLiBDYW4geW91IHBsZWFzZSBzd2l0Y2ggdG8g
dGhlIGxhdGVzdCB1cHN0cmVhbSBvciA1LjE1IHhpbGlueD8NCg0KVWguLiBEaWZmaWN1bHQuDQoN
CkknbSB1c2luZyBQZXRhTGludXggMjAyMC4yIHJpZ2h0IG5vdyBhbmQgX2ZpbmFsbHlfIGhhdmUg
c29tZXRoaW5nIHdvcmtpbmcgd2l0aCBpdCBhZnRlciBzcGVuZGluZyB0aGUgbGFzdCB5ZWFyIHRy
eWluZyB0byBmaWd1cmUgaXQgb3V0Lg0KDQpJJ20gYSBiaXQgbmVydm91cyBhYm91dCBpbnN0YWxs
aW5nIGEgbmV3ZXIgdmVyc2lvbiBvZiBWaXZhZG8vVml0aXMvUGV0YUxpbnV4IHJpZ2h0IG5vdy4g
QW5kIEkgZG9uJ3Qga25vdyBob3cgdG8gbWFrZSBQZXRhTGludXggMjAyMC4yIHVzZSBhIGRpZmZl
cmVudCBrZXJuZWwgdmVyc2lvbi4NCg0KVGhhbmtzLA0KTWljaGFsDQoNCg0K
