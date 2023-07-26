Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D9E763488
	for <lists+linux-can@lfdr.de>; Wed, 26 Jul 2023 13:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjGZLKQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jul 2023 07:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjGZLKP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Jul 2023 07:10:15 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7499B;
        Wed, 26 Jul 2023 04:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yp92uzgR6pKF4FgVjjrpXINDIf03LiMuyNPjJYYMp47xXBaw+JL/fVM85R3S/9DC1QZ712Z8FPszLhzfEbaAsJ7JypVFufJ8JdBcPgUXuixB/FUpf+DDjkYOQBiZ9wJprpM75TBGmF1HqstwIStwWEjT/bNRHUOW5kT929VldUg9GDpGDb2wF96vqq6IiZd/dv944m5YYIe7RIGdkYKohgiOUrSoot86SKMT9mDI0vcI+tMhExwJJqao10IpP7cFRwkWG/otxdkLis0mlw9SEvI6xbhufejx5Z9z03cfNQBJK035RWmlj7gonVGw0zzGLiWeMKVF+8IpD7KS0hYDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IopBww9iRtGVJt4gm0GeRdgztAuF38UvVMrOqV99Sa8=;
 b=NEz1xbZ1THiXBJuJc4Wn/I9pcbxryXHDueusrSOmR9PvoszcqtdXJbxPp33KrRFxoHTHYL3W+RtQNuApOn5Sk4GkaSDnLdj5cIFIIbKo06iHY0+ElAdr+E50/5yjGNOUpyOFqKx7OPXRJkDY0njJxKuTOCUB+EuKr/+TQj2s1lMrK/bfWXkMAfki/7zSh/qgltLT+EBxKidp96Qcp27Uoa1ObvllPUjNWFum1ZSNyRaTMzJ3IkoXkblCu00Jqry3SkStcceYk5/hQzoJgWj5Xjs7dznFPrRulTDDdWgcCdoSXnnD//TR0SXH76Wel+A+1CSEaun+BYsfNO/ILQLPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IopBww9iRtGVJt4gm0GeRdgztAuF38UvVMrOqV99Sa8=;
 b=bKSBLGga3Xge72nKVMLcwEcU0ZLOG4g6LQzoq/k4jATocp4uxCIuPZ1iAx3GoUYLx6sHi+gRPEP32oA5LUNmkSFh5qXenF8NTWffroBS9bkRcNb5E5Ih001Wz8bzMDS6a8RrLwaD4SCZHoteog44DIhTUP18ULCU6TiVrqFK4bc=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PAXPR04MB8351.eurprd04.prod.outlook.com (2603:10a6:102:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 11:10:10 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:10:10 +0000
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
Subject: RE: [PATCH v2 1/3] arm64: dts: imx93: add the Flex-CAN stop mode by
 GPR
Thread-Topic: [PATCH v2 1/3] arm64: dts: imx93: add the Flex-CAN stop mode by
 GPR
Thread-Index: AQHZv6BTiuWPddEK702tBPRWQzfjHK/Lz9aAgAAOk1A=
Date:   Wed, 26 Jul 2023 11:10:10 +0000
Message-ID: <DB7PR04MB40107ED22966EF83DDA0759B9000A@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230726090909.3417030-1-haibo.chen@nxp.com>
 <20230726-moocher-managing-5a5352a4266a-mkl@pengutronix.de>
In-Reply-To: <20230726-moocher-managing-5a5352a4266a-mkl@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|PAXPR04MB8351:EE_
x-ms-office365-filtering-correlation-id: 0f1af3b8-5a82-44b6-1069-08db8dc8e07d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f2nsY91Hnn7I4tUPDkzXULmB2xrzw+YXlSZjgRqH2oKPUCh7+yN29z5fMadEuxnXS/vHqyue+C47EbUsLyMRAhud+ZYPJlyaczXR+l9GNx2woHqTLfiV34yu9zCeL95TRIl8s9+RTka50Flx5M0aTsQdlSBFAlduqQ4k2M0bdOtPKO2b6lT46j5D4l7Qw6/K4l1yGt5+rUVmyGjZmpXEMpfWbNFgMulRVMDZGLRX3tLSEBqwqRisioDMlThO5yKfoVzq19NmSRaXjAilo9NKWBDyMjRPrgWekV/AA2WNp9rZrCXuofTykq8xHKsFq4MwjIXd7iOgJwHTsHTVG3Rxwe/uCmC0YwEC8JKWh45Fsh7bM9MsVEBteQA0YFAai9AgkEHiBW63RQTQUQ1MHMaf6QkaPvtBptuTFAX4uAvpbZGJAAejE+mfiQl4/ulY98NS9NP+I5R1dvJqWXdySFskQ+yTjVgUKSO/bZTeySUZ6JYOiv8fNx6Px278YQ/XhMFJy+b5ZMmncptFdBrP6dlTGWi5f/poec8qEYmxZqP4xMh+x5tt6E/oWOnkQxEOnZVMV6boYlAWyYUJzrTDTjydCo/Rpi8Vs1w4F2bBPcgbr0w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(86362001)(122000001)(33656002)(38070700005)(55016003)(2906002)(54906003)(478600001)(38100700002)(66574015)(26005)(186003)(6506007)(71200400001)(53546011)(5660300002)(64756008)(52536014)(41300700001)(7696005)(66476007)(966005)(9686003)(7416002)(66946007)(316002)(4326008)(8676002)(83380400001)(66556008)(8936002)(76116006)(6916009)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFA1Y2ZtTEZmS2RJdVpKT0F5djY2ZnZ0dUEyTTRRaEwyUXFLNHBvSnV5Mjht?=
 =?utf-8?B?YXIwYU8vZUxCM3VYdkRhbkVjcWtJZU1RL2RmN0U5bUdrcTJxMHlLT3MxaW9n?=
 =?utf-8?B?aS9SY1huNldNQjJPTkVVZENXN2lWZi9tOThTMi9SSm1xamhmUDRnSHcvdnFp?=
 =?utf-8?B?S0s3b0tudHFzOUhTK1l6WlE4MlZtZlFOWHhnY2U0TEpNM1VyS05NWUdCVi9Q?=
 =?utf-8?B?ZkdYUkVJeFN0ZElFY3RBK0dNaWZKaENqMk9lK0puS3dQWFpDMVdvZUJMQmtP?=
 =?utf-8?B?WWszTEZzVEZrT2N5NVY5dStkNURWZUVNOGZNQzZTZ0lWeUNzSEZ2MWFNbXZP?=
 =?utf-8?B?K1BJQUZodzlBWmw5V1FVaFV6czVTRkF5U0ptT2ZTVUR1NXd2Uy9kc3RXUzky?=
 =?utf-8?B?QnhwZW1EV2tKNEJLbzA0aXRDdmFDTHRWeWZFTTR0dnZTSlZtS1BqNExVYkZC?=
 =?utf-8?B?a3c4b3FCUmZQZURSZXdISEFibHozTGxFd0dJYklrSzlmZ0tqK2tJUUIraG1O?=
 =?utf-8?B?QTcycU9NRU13RERFYzhoSkNOaUcyZFlmS0h4TlBsbEJ0aVJBR1dFdU5YUFd1?=
 =?utf-8?B?T08xdkJlOWlJQjZUN2tDWVowOFo3NksrR0p5MTB5MnlWelc4THZVYXlGV01S?=
 =?utf-8?B?a1FYdXZRWGdKakVoZzNwM05ad2FRMEVVelo0WjNFMUxiMUdVa3hGbFI1Qlg3?=
 =?utf-8?B?b1FGS1FXU2FhTDF3YXJZemVzeFU4UlUwK1RSaW5aNnR5ZmlrNDlKUjI2OE1R?=
 =?utf-8?B?WFdCaS81VHFybEJpSTNmaFVUK2RxL2FHbTRieFpTcy9BT2xpaFlHdlo4WWFD?=
 =?utf-8?B?MTlzL2tGbnV5Tnp3S1pzS1I4Y21VcjJES3VRUTBGaEFsTTNMYjl1VHB2bjVN?=
 =?utf-8?B?aFpkcTZ6QWFZaE9LRVVZWkhWTmExbGZobkQ5T2F2Rk94bGc2ZWtVVHpadFFw?=
 =?utf-8?B?eWpsNUFDV0dZMU1PZ3Z6MVZEMkZ2MGQ1Z3lqL25kY254L1JrUzhLQ1lZTGxz?=
 =?utf-8?B?TzRBc2pmNUU2dmJuMGwrY3p1YlF3MVI2dkQzYWRBRjMrclFXdG9LSjFBUXhv?=
 =?utf-8?B?ZnRKeTQyLzBOZUlucXhzbW9lSHBmUVM5TzBOM3J5RWZZb3F5VStLdGs3Ty9I?=
 =?utf-8?B?REE0TTAyRjNJL0VxVjBFT01jWXV1VndkWTh2bkhJTWh0eUsvcStNUVdDdVQ1?=
 =?utf-8?B?cmVjU2Q3aTdxV2RzdnRXeENDNWtBN0lmSDgzZyt3Y0V0UHdIWDlsMm1tQ0tu?=
 =?utf-8?B?TittZ21wc2VObnRDRTJqTGlaUXQzcmFYd1pWMGh0aWpzYVYyLzFCWmhiSmdC?=
 =?utf-8?B?dDhkZ3YrdllYZndoeFM5YnpBdVV4RVJ6V1RTL0NCRzgxek8vRVRUMm5Qa2RS?=
 =?utf-8?B?WmxKVUxTOERzVFBjemlodVg3UG9kVmhReTlVU3F5bWYvMWNQRjg4VXlka3Fr?=
 =?utf-8?B?TGRLSUlpc3doc3JQb0dZeWQwSUlnRWJiem5Vc1hoVUNVSm5rZU5PdmhWcW1y?=
 =?utf-8?B?YS9pK2tMajZpajlyK3J3ZEtNN1MvKzd6MGoxRS9ieUs0RTRGVm9jdThjVjFK?=
 =?utf-8?B?aTFCYU85NHl1VEgwOTAzdmNnUHFpd2V6T0VCUjNxVTJ2V2plZ0Uvc21yb1A2?=
 =?utf-8?B?cWV5OVo0UktkNGh4THpacnZFdXN6SlJlWTUzQ3lYQTcxSWJlU2V5R2RETnd5?=
 =?utf-8?B?NDJOd2RWdm5jL0k4eXNvMUV1MVFGQWhkcXpySzBqT2ZXSlZ4QVRwcTcrNUpO?=
 =?utf-8?B?Q3hqZTNWUHlSMHFxcnRuZnJDZmJ1aytCWEVlUHVodTJTMUVYVHpsdUZzNFQy?=
 =?utf-8?B?WTQ5dmFGaVhldWI3VzFqK0FueFJDVDhTcWpyRWEyTzh3RGVKdE1yVkJBZ0lv?=
 =?utf-8?B?bk9URnJHS096dk5pSXlxMDV0U2VtQ0VkeUxDaDZJZDFnbWhrZDJ1eFZ2amN4?=
 =?utf-8?B?RlRDdks0cmxkYytYOWI3a21EbnRhcjNjbFBaa2hNWTI4N3BPeDRnbjNtaUNp?=
 =?utf-8?B?L2FzNzJRU0dMZlpicTlLMzNjQ25IU1NUZmp4MDRWT0E5ZUJYY1Vka2NqYjNV?=
 =?utf-8?B?QXdZNGZHUnVLV1BkZThpSFNNM3l0SnFIMG1WVU52SU5Rc2p2c3dCa1VhcHlP?=
 =?utf-8?Q?qkbM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1af3b8-5a82-44b6-1069-08db8dc8e07d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 11:10:10.1896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HFMWz+WRe9NT0Us7tqHC+NoxG0vpfcUFj/CyuKuHjQjl4tjNNfRmiHp6Cblqbvss70EekxczN0sxMA/bmBDWOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8351
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSA8
bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDIz5bm0N+aciDI25pelIDE3OjU3DQo+IFRv
OiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IENjOiByb2JoK2R0QGtlcm5lbC5v
cmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gY29ub3IrZHRAa2VybmVs
Lm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gd2dA
Z3JhbmRlZ2dlci5jb207IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxs
aW51eC1pbXhAbnhwLmNvbT47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5j
b207DQo+IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOw0KPiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8zXSBhcm02NDogZHRzOiBpbXg5
MzogYWRkIHRoZSBGbGV4LUNBTiBzdG9wIG1vZGUgYnkNCj4gR1BSDQo+IA0KPiBPbiAyNi4wNy4y
MDIzIDE3OjA5OjA3LCBoYWliby5jaGVuQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogSGFpYm8g
Q2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+DQo+ID4gaW14OTMgQTAgY2hpcCB1c2UgdGhl
IGludGVybmFsIHEtY2hhbm5lbCBoYW5kc2hha2Ugc2lnbmFsIGluIExQQ0cgYW5kDQo+ID4gQ0NN
IHRvIGF1dG9tYXRpY2FsbHkgaGFuZGxlIHRoZSBGbGV4LUNBTiBzdG9wIG1vZGUuIEJ1dCB0aGlz
IG1ldGhvZA0KPiA+IG1lZXQgaXNzdWUgd2hlbiBkbyB0aGUgc3lzdGVtIFBNIHN0cmVzcyB0ZXN0
LiBJQyBjYW4ndCBmaXggaXQgZWFzaWx5Lg0KPiA+IFNvIGluIHRoZSBuZXcgaW14OTMgQTEgY2hp
cCwgSUMgZHJvcCB0aGlzIG1ldGhvZCwgYW5kIGludm9sdmUgYmFjayB0aGUNCj4gPiBvbGQgd2F5
77yMdXNlIHRoZSBHUFIgbWV0aG9kIHRvIHRyaWdnZXIgdGhlIEZsZXgtQ0FOIHN0b3AgbW9kZSBz
aWduYWwuDQo+ID4gTm93IE5YUCBjbGFpbSB0byBkcm9wIGlteDkzIEEwLCBhbmQgb25seSBzdXBw
b3J0DQo+ID4gaW14OTMgQTEuIFNvIGhlcmUgYWRkIHRoZSBzdG9wIG1vZGUgdGhyb3VnaCBHUFIu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+
DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLmR0c2kg
fCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5My5kdHNpDQo+ID4g
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5My5kdHNpDQo+ID4gaW5kZXggNGVj
OWRmNzhmMjA1Li5kMjA0MDAxOWU5YzcgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OTMuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDkzLmR0c2kNCj4gPiBAQCAtMzE5LDYgKzMxOSw3IEBAIGZsZXhjYW4xOiBj
YW5ANDQzYTAwMDAgew0KPiA+ICAJCQkJYXNzaWduZWQtY2xvY2stcGFyZW50cyA9IDwmY2xrDQo+
IElNWDkzX0NMS19TWVNfUExMX1BGRDFfRElWMj47DQo+ID4gIAkJCQlhc3NpZ25lZC1jbG9jay1y
YXRlcyA9IDw0MDAwMDAwMD47DQo+ID4gIAkJCQlmc2wsY2xrLXNvdXJjZSA9IC9iaXRzLyA4IDww
PjsNCj4gPiArCQkJCWZzbCxzdG9wLW1vZGUgPSA8JmFub21peF9uc19ncHIgMHgxNCAwPjsNCj4g
DQo+IEkgdGhpbmsgdGhlcmUncyBhIHR5cG8gaW4gdGhlIG1haW5saW5lIGlteDkzLmR0c2kuIEFG
QUlDUyBpdCdzIHN1cHBvc2VkIHRvIGJlDQo+ICJhb25taXhfbnNfZ3ByIiwgbm90ICJhbm9taXhf
bnNfZ3ByIi4gQnV0IHRoYXQncyBhIGRpZmZlcmVudCBwcm9ibGVtIHRvDQo+IHBhdGNoIDopDQoN
ClllcywgdGhpcyBpcyBhIHR5cG8uDQo+IA0KPiBBRkFJQ1MsIGFjY29yZGluZyB0byBpbXg5Mywg
cmV2MiBkYXRhIHNoZWV0LCBvZmZzZXQgMHgxNCBpcyA3Ni42LjEuMyBRQ0hBTk5FTA0KPiBESVNB
QkxFIChRQ0hfRElTKSBhbmQgYml0IDAgaXMgIkdQSU8xIi4gQXJlIHlvdSBzdXJlIHRoaXMgaXMg
dGhlIGNvcnJlY3QgcmVnPw0KPiANCg0KSW14OTMgQTEgZG9jIGhhcyBzb21lIHVwZGF0ZSwgSSBk
b3VibGUgY29uZmlybSB3aXRoIHRoZSBpbnRlcm5hbCBkb2MgYW5kIElDIHRlYW0sIHRoZSBzZXR0
aW5nIGlzIGNvcnJlY3QuDQpJIGFsc28gdGVzdCBvbiBpbXg5My05eDkgcXNiIGJvYXJkLCBzeXN0
ZW0gY2FuIGJlIHdha2V1cCBieSB0aGlzIHNldHRpbmcuDQoNCj4gPiAgCQkJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7DQo+ID4gIAkJCX07DQo+ID4NCj4gPiBAQCAtNTkxLDYgKzU5Miw3IEBAIGZsZXhj
YW4yOiBjYW5ANDI1YjAwMDAgew0KPiA+ICAJCQkJYXNzaWduZWQtY2xvY2stcGFyZW50cyA9IDwm
Y2xrDQo+IElNWDkzX0NMS19TWVNfUExMX1BGRDFfRElWMj47DQo+ID4gIAkJCQlhc3NpZ25lZC1j
bG9jay1yYXRlcyA9IDw0MDAwMDAwMD47DQo+ID4gIAkJCQlmc2wsY2xrLXNvdXJjZSA9IC9iaXRz
LyA4IDwwPjsNCj4gPiArCQkJCWZzbCxzdG9wLW1vZGUgPSA8Jndha2V1cG1peF9ncHIgMHgwQyAy
PjsNCj4gDQo+IGxvb2tzIHBsYXVzaWJsZSwgcGxlYXNlIHVzZSBsb3dlciBjYXNlIGZvciBoZXgg
YWRkcmVzc2VzLg0KDQpNeSBiYWQsIHdpbGwgZml4Lg0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENo
ZW4NCg0KPiANCj4gPiAgCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gIAkJCX07DQo+ID4N
Cj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo+ID4NCj4gDQo+IHJlZ2FyZHMsDQo+IE1hcmMNCj4g
DQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUt
QnVkZGUgICAgICAgICAgfA0KPiBFbWJlZGRlZCBMaW51eCAgICAgICAgICAgICAgICAgICB8IGh0
dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlIHwNCj4gVmVydHJldHVuZyBOw7xybmJlcmcgICAgICAg
ICAgICAgIHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0xMjkgfA0KPiBBbXRzZ2VyaWNodCBIaWxk
ZXNoZWltLCBIUkEgMjY4NiB8IEZheDogICArNDktNTEyMS0yMDY5MTctOSAgIHwNCg==
