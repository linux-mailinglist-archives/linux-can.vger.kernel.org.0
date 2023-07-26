Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EBF76348C
	for <lists+linux-can@lfdr.de>; Wed, 26 Jul 2023 13:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjGZLKn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jul 2023 07:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjGZLKm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Jul 2023 07:10:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1EC132;
        Wed, 26 Jul 2023 04:10:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtMSgxNUCDGH58YrLKzXKmvS3NXTu09nET7vF+pBSJLcKCZ2K0xUQs4WDso+LZSUMtUTCDi2CdC4E8vM7wCG7TAGA6hJd+RGarmaSBYt+V1hplUCAi703PRCFUAbBFvqsVk+qsNY7afrpxj4mVM298Tpk1AY1mnPTu9yeCdLSSNmXyM3QugjGBMXkHW9BJxP3iPURPf3ALSuZ14GLhzjOG1xAqgmeT8KvVjRuOZqfy71MPiuAS143Pb1PoxFWI2a13kNWteR8P2qe56UuUGhv8u5qYS+TVdwpzRadaxOYFKh3Tx/4GZmX+PKH4HwhdZRpPK0nF3bJq8JPaOaSoLxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2TXRzXs9UkoXhcGBvKwzjrVM28QD0da8+sUTw8c020=;
 b=AZ/OuXQBSmaO6wBa0TvgKoT+wFnnebFBbxJmoV+DQPlP1dwreCnaxIVttrCP4biRgMjYKrsHYy/S5M/hhh340jIMvLpQaJ3lFPlg1DFs6xPMziEHLG7H54fmXbU4WeIAXe6aX+TKzCskdIogVr0lf4/J532xUTz2OPX3sy7v81O0ErSwkIc/zqC3js+NjqNVY6igGiKqXyckfSTIzmR9R062EevOxEoOUh+hlIscUIlAymTSae1A2ygGD9MYdaVyeaddvtX1FXcPAZT8ZT4CAekotF6KEzleoul4x9wKUiCWeLibZnGJDqXyC7cPzEC3bTAsRysRqkHxLz71z5zedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2TXRzXs9UkoXhcGBvKwzjrVM28QD0da8+sUTw8c020=;
 b=HcV6E1qVEvez8ULLZtoAkJMRkAZRe+yzSt41iV1+FeXaS/gI3VrKaCn0ap+5z4NUBkaU+cdpvYBzTCknunV6b8kXvAGbItWPmO129I4qhDiXi0gbcwKi8QbDUcvY2JFdf7C/KZIK3wjB2qwK/BmXOjqvfZ1DWwCs6Q+K9I0d59I=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PAXPR04MB8351.eurprd04.prod.outlook.com (2603:10a6:102:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 11:10:38 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:10:38 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] can: flexcan: lack of stop mode dts properity
 should not block driver probe
Thread-Topic: [PATCH v2 3/3] can: flexcan: lack of stop mode dts properity
 should not block driver probe
Thread-Index: AQHZv6BZOHIdwg9SbUi+kJ1cqJxryq/L1UMAgAAPBNA=
Date:   Wed, 26 Jul 2023 11:10:38 +0000
Message-ID: <DB7PR04MB40105C2B16E710DBD3F8BB9E9000A@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230726090909.3417030-1-haibo.chen@nxp.com>
 <20230726090909.3417030-3-haibo.chen@nxp.com>
 <20230726-majorette-manor-ea82bb4afa68-mkl@pengutronix.de>
In-Reply-To: <20230726-majorette-manor-ea82bb4afa68-mkl@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|PAXPR04MB8351:EE_
x-ms-office365-filtering-correlation-id: cda17029-f726-4cc1-1446-08db8dc8f11a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KYSkqwoM8TnD6nyP+wmEpTKcayDl1WhJrOtFz2jNk2BsniD1PuXt9M7xrHKpUKfl5wkkBSoTPkPESJ5AXOyhHt5o3zrGJS4CD9bKAHi2p71pV8dWcgn9mVgW+wqdkUJUMyV7uqg++zUyonE/hvxMujRAjXjvFhqraWjoQp/Wkc4LYkg86Zwv8qao6SkzUDUs834MGwUp2FKUzIVdawrKT6e5We6VnxGy35YGCHuJjK3CCAjIvVbDNegL4vKUOqKEkcUd4kl6RXMoTDGzyf3DbeiVNqSa75bq1FT5se2AiiAVXPh4wWuVHrFDPtnnSkO32gb1oDtuPopgNVvnDzGvTV3LnUVMKUnEUp62qyP4VmUIvawh6M8rYRQhtRBn1fMDHNUlRPX//asKLkEBtXFb4DQK+Q4E3o8FcJ4lynAtQpVJWaECOsj8k2SKaCHu+VdOh33WdpwioCnxsCgKJzFDnJDOyZsrIFrfpyVHKsT5bs87a0TAs4TdoKRYRVti53dSpHZLRXwIeewhHaGEsssvinqlvTRF7Cmruj1mdPAVVVjeb/gIFxpnyYq7bvKyqPndCNHiDNHEMmnSXbEnjiYCENCAyVYbBNj5L7h+7lxlOX0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(86362001)(122000001)(33656002)(38070700005)(55016003)(2906002)(54906003)(478600001)(38100700002)(66574015)(26005)(186003)(6506007)(71200400001)(53546011)(5660300002)(64756008)(52536014)(41300700001)(7696005)(66476007)(966005)(9686003)(7416002)(66946007)(316002)(4326008)(8676002)(83380400001)(66556008)(8936002)(76116006)(6916009)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWN1MG0vVXRqRE5XUHRzZy9ldUw1dFBOWnNTV0dvajh5UWlZVXFjVVhCSmdz?=
 =?utf-8?B?YzNIZnNEYklUOHNjaFZjTkxLUGhCTkdqOHNHaVNnb2NTTDdxajVvY0VIc3hN?=
 =?utf-8?B?V3VXT3BMQ1A2UEQ0Y25XOWljb29ISkEzb2FjU09kQ1VjK3dSdmFJenhTMzhR?=
 =?utf-8?B?aHFuNEJOMlJWMDl2Z0FneTU1UzRXWWIzSGNxVWptek1mdHMyUEZBY2FUS0pS?=
 =?utf-8?B?QjJEMWdPbkpud3Y0UG9YZWFJYWZyd0JHazdSaVVjSDY1VjZHK0lhdXUxRElZ?=
 =?utf-8?B?OXhJQTB5TEswRHI4VSttZHVKNU1CK2FMRjZjaXc3NWIrRWVobndJTndVOWVZ?=
 =?utf-8?B?d3dMZ3lKTm5QM2ZRbElIeXhoUGNJS3hxcGhWVWc2UDFPMkpiSDhyT1lmSnF4?=
 =?utf-8?B?T3RValp2UmxxMDZ3QUVBY1ZZMGIyRVBuT2NYZ3JOZXY5M2xFanppTEw4bmxq?=
 =?utf-8?B?NlloNXYwbkdTSHNabFJINmMxSFR1N3NqcVd1VkdvcTlaR21tWjdpeTk0eGY0?=
 =?utf-8?B?S3dMY053ZTQ2bnk1SGhOd0s4aHN3VlViMGxMcVduMTd4bjdYRlBMaEtJVzhs?=
 =?utf-8?B?SVlXQ1JwMFV2eWdtZHloTDdmRWpjSW0wd1RWVWRvcW9abzNqZUdCb1Y5Y2lE?=
 =?utf-8?B?c1NDQ1U2U3lnUnFIR2NNMkdtQkxtNWRiYTA5N2dvc0dHam16QWNJNmVLVmx4?=
 =?utf-8?B?czZXdG4xOURJL0dZNHBtUEZVQlNTOXdvNzVOZWFNc2l3L3Avb1psZTVVZEs1?=
 =?utf-8?B?a1pTa0V4REllMk0zSXdQVUo4dWNNTDB4SnpiYmd6QnFPVjlqV2NFdFJMSFNw?=
 =?utf-8?B?aXhodkVrZDN1LzJVb3RSdzdDV2JqalBWU2dyUW5IOGM4TjdZVUpXdStyZFZU?=
 =?utf-8?B?bGZTem1rVGRvaVBEOFBwblFnVmpDTVlhNi9kdjBTYzdzcHNNTngvejlFSjRz?=
 =?utf-8?B?SWNycGIvWmIrVHhEelEvSUZhOVZKU2JDUEYyNTFjQlRObnllYWoxZ082bzN3?=
 =?utf-8?B?cHV0UDlaZG5WMUlRNGRTNW9EUXpWZkhDb1VsZnNtN0RmcTdZSWgwODBzVEFJ?=
 =?utf-8?B?QzJ2YUovTmNiYm1mbUlvVDhWSjc5NDRISnhYRTF1c0phdDUzdktMYmZzMFc2?=
 =?utf-8?B?SktkM2tNeEhJa1NOanpETDBCb3BtdSt5L3IzVEh2Mmt0MkcvMHpSdjFxZ2xJ?=
 =?utf-8?B?elNWWmZpVjVLQjl3eHNFRmtMK1Y2bTQrRWZ5V1hpTHN6Y2RObUdEeDRLZFVo?=
 =?utf-8?B?VUthWGJKRWJpalVGNVBYVnQxV3F6ZWRnczRpU3MzUHdZem9ROCszdXFRSkE3?=
 =?utf-8?B?MXRXMGorcmZOR2FGcVpHWC9ydXZwL0tQN3ZoWng2T3NZVlJNODZYb2UvM2ky?=
 =?utf-8?B?UGxxYUkvMUY1Nzc5VkJoQ0diTW01aDhEcnlLWHYweUdSbkpqejNyQUNFc1po?=
 =?utf-8?B?YUxzSEMrb2F3c2VVQjRSU0dKTXFPdVRCVEg3T2pkT2hFZERzbW1jeDUyZ2pi?=
 =?utf-8?B?Mjc1bTEwSzQ3K0FHWWlvS011amwyTXFvczRua3hoRm9VVjZaemlIZVIzZUd0?=
 =?utf-8?B?Zzk4VDBDamwxZUdMQWMrY3JaTGV4R3EwRUFjY0l1bk03ZkNpZ0kwWlZQL3c0?=
 =?utf-8?B?bFBDWklQZ0tENHl6d0o2eE4rdUZTRDRBK1JkTGZqQlVNUE95bDBiT0djdXlY?=
 =?utf-8?B?bzc2Tmh2a3ZyNmFaYTBkc2dVT3puTU5LbkEvdnFVTGVxT0Y3V01IZ1hWa1B1?=
 =?utf-8?B?SmhiUml4YWlyUkpCd1FLOXZ6L0dmVGJVTEZYWG5DUCtkb3h5bHduR3ppQ1B5?=
 =?utf-8?B?L3kzdUZjWXVoZmpOeWFGNk8vSVVDMnREalZaZ0ZvS3Z2MFd2dGRmUEVkbHNW?=
 =?utf-8?B?RHI4MFJFQkdyL3orUGlwMm8wRnk3MXA0djhYbW1JYlRZVEZSbHpBUzRQNHZF?=
 =?utf-8?B?RjdwanRuRVZ4K0NVbXFIWldTQ1JFUkdSUkcxRWU5amFNQmFoVXJrVXBzcGJU?=
 =?utf-8?B?TjJNS0Y1UGhqQXMyRXVnUHh0KzhjRkJqRzVabUtKc21rY3dNK0RmZElhVHVQ?=
 =?utf-8?B?aitGUVdsclhGT2lHRDNWd2k2di9KVkhPM3BrUjZlNzkyMDhJK0U4bnVmZ3hn?=
 =?utf-8?Q?qLuQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda17029-f726-4cc1-1446-08db8dc8f11a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 11:10:38.0966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uo0vfCnFbQ5NmEHmzccYiEjPTCieMNsis3M+/H1MY5ZaoAVr41O7MeyqLQOzJRtA0PqCZJwaHhv9PPKKHuwxtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8351
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8
bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDIz5bm0N+aciDI25pelIDE4OjE3DQo+IFRv
OiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IENjOiByb2JoK2R0QGtlcm5lbC5v
cmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gY29ub3IrZHRAa2VybmVs
Lm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gd2dA
Z3JhbmRlZ2dlci5jb207IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxs
aW51eC1pbXhAbnhwLmNvbT47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5j
b207DQo+IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOw0KPiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy8zXSBjYW46IGZsZXhjYW46IGxh
Y2sgb2Ygc3RvcCBtb2RlIGR0cyBwcm9wZXJpdHkgc2hvdWxkDQo+IG5vdCBibG9jayBkcml2ZXIg
cHJvYmUNCj4gDQo+IE9uIDI2LjA3LjIwMjMgMTc6MDk6MDksIGhhaWJvLmNoZW5AbnhwLmNvbSB3
cm90ZToNCj4gPiBGcm9tOiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4NCj4g
PiBJZiBTb0MgY2xhaW0gdG8gc3VwcG9ydCBzdG9wIG1vZGUsIGJ1dCBkdHMgZmlsZSBkbyBub3Qg
Y29udGFpbiB0aGUNCj4gPiBzdG9wIG1vZGUgcHJvcGVyaXR5LCB0aGlzIHNob3VsZCBub3QgYmxv
Y2sgdGhlIGRyaXZlciBwcm9iZS4gRm9yIHRoaXMNCj4gPiBjYXNlLCB0aGUgZHJpdmVyIG9ubHkg
bmVlZCB0byBza2lwIHRoZSB3YWtldXAgY2FwYWJsZSBzZXR0aW5nIHdoaWNoDQo+ID4gbWVhbnMg
dGhpcyBkZXZpY2UgZG8gbm90IHN1cHBvcnQgdGhlIGZlYXR1cmUgdG8gd2FrZXVwIHN5c3RlbS4N
Cj4gDQo+IFRoaXMgc3RpbGwgYnJlYWtzIG9sZCBEVFMgb24ga2VybmVscyB3aXRoIHBhdGNoIDIg
YXBwbGllZCwgYnV0IG5vdCAzLg0KPiBQbGVhc2Ugc3F1YXNoIHRoaXMgaW50byAyLg0KDQpPa2F5
Lg0KDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9jYW4vZmxleGNhbi9mbGV4Y2FuLWNv
cmUuYyB8IDkgKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vZmxl
eGNhbi9mbGV4Y2FuLWNvcmUuYw0KPiA+IGIvZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4vZmxleGNh
bi1jb3JlLmMNCj4gPiBpbmRleCBhM2YzYTljOTA5YmUuLmQ4YmU2OWY0YTBjMyAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi9mbGV4Y2FuLWNvcmUuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuL2ZsZXhjYW4tY29yZS5jDQo+ID4gQEAgLTE5ODcsNyAr
MTk4NywxNCBAQCBzdGF0aWMgaW50IGZsZXhjYW5fc2V0dXBfc3RvcF9tb2RlKHN0cnVjdA0KPiBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAkJLyogcmV0dXJuIDAgZGlyZWN0bHkgaWYgZG9l
c24ndCBzdXBwb3J0IHN0b3AgbW9kZSBmZWF0dXJlICovDQo+ID4gIAkJcmV0dXJuIDA7DQo+ID4N
Cj4gPiAtCWlmIChyZXQpDQo+ID4gKwkvKiBJZiByZXQgaXMgLUVJTlZBTCwgdGhpcyBtZWFucyBT
b0MgY2xhaW0gdG8gc3VwcG9ydCBzdG9wIG1vZGUsIGJ1dA0KPiA+ICsJICogZHRzIGZpbGUgbGFj
ayB0aGUgc3RvcCBtb2RlIHByb3BlcnR5IGRlZmluaXRpb24uIEZvciB0aGlzIGNhc2UsDQo+ID4g
KwkgKiBkaXJlY3RseSByZXR1cm4gMCwgdGhpcyB3aWxsIHNraXAgdGhlIHdha2V1cCBjYXBhYmxl
IHNldHRpbmcgYW5kDQo+ID4gKwkgKiB3aWxsIG5vdCBibG9jayB0aGUgZHJpdmVyIHByb2JlLg0K
PiA+ICsJICovDQo+ID4gKwlpZiAocmV0ID09IC1FSU5WQUwpDQo+ID4gKwkJcmV0dXJuIDA7DQo+
ID4gKwllbHNlIGlmIChyZXQpDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPg0KPiA+ICAJZGV2aWNl
X3NldF93YWtldXBfY2FwYWJsZSgmcGRldi0+ZGV2LCB0cnVlKTsNCj4gPiAtLQ0KPiA+IDIuMzQu
MQ0KPiA+DQo+ID4NCj4gDQo+IHJlZ2FyZHMsDQo+IE1hcmMNCj4gDQo+IC0tDQo+IFBlbmd1dHJv
bml4IGUuSy4gICAgICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgfA0K
PiBFbWJlZGRlZCBMaW51eCAgICAgICAgICAgICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJv
bml4LmRlIHwNCj4gVmVydHJldHVuZyBOw7xybmJlcmcgICAgICAgICAgICAgIHwgUGhvbmU6ICs0
OS01MTIxLTIwNjkxNy0xMjkgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiB8
IEZheDogICArNDktNTEyMS0yMDY5MTctOSAgIHwNCg==
