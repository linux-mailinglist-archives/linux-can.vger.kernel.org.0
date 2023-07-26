Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DF3762F66
	for <lists+linux-can@lfdr.de>; Wed, 26 Jul 2023 10:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjGZIOh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jul 2023 04:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjGZIOG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Jul 2023 04:14:06 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3160D1FCF;
        Wed, 26 Jul 2023 01:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APWiJQzl4ApLJQOyiWMhABKwas9XwfeaBJp8Nh44stb1DOe0WFqyqHsSlg1F0G01IPDAiIicpN484sskyYYXRXrUl2c5P7EhdpNkH+KvtT/N9koPMi4HRHQtVdWsfQsPID2jTljbzgpEEYiXAhTp0hcthbeHCsdhGE8AFRFlH6fvGYSA5E3nIKpbJH+cPUEP6JhtgOUjFkMlqbFEiJ9kdJGFJkCetolmR7p/Ecx2vTexk8jkJOZj7JbX1zzGIWElS6nwimBplAhtmPpht6BMJ4wgDiQaaI4gicH+0J2dAcIFcpbyqK02ZrGw6QhgMGI5rHCbvhzF28o7WG4j1MiMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc8CwPMyBws0Pkk+x3vkuHgrYaGSXDsMRFMoNe0BpiQ=;
 b=XdtaML4IsAa0Eh8lgFqpzbCNUcomEPp9lZfmuU6KB5aaUy11ahj2efwhSn+GYq5P3Hl6CYZ9o0FEjRqZU9Ivbn2T4OiS8nTlMI65CR69FdK7eGQsC+0DffVR06aBVQLP87gnqVkVt9rZLFQXGPKJBQidSoFUg+uJ7tjtNbVpxvIdjl2+efg7/0mSWhCXe+yN+HGRRfw9DDMLsA/WzO9KcvZ1H5JEDjuNQLfFMrKrlilrDqELJhQx7zk/kTwVvbEfjfDEUZlLGjjql8s1uMNCv2sU2DJVVwUp8otYd3r6qrGuZZRlXXw+fvmwD0UaNmVp77Ksz74zUKJR6DKDzCObGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc8CwPMyBws0Pkk+x3vkuHgrYaGSXDsMRFMoNe0BpiQ=;
 b=hPBfALbZT1xOvdjdKdZkDQCvrwMQxCKnywV33qKR5FX5LCirmP1KXBMKvCYQ3asn3rawtVRKje03bGU5J5gy2KsenbyxPsjSoJKyi1ozfFvVb70qtuCQRZwhVnBNGE8FbShK71Rvi38SDrtzvu87CijcGdPk6vEGwdxk2sGvBvE=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM0PR04MB6932.eurprd04.prod.outlook.com (2603:10a6:208:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 08:04:55 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 08:04:54 +0000
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
Subject: RE: [PATCH 2/2] can: flexcan: remove the auto stop mode for IMX93
Thread-Topic: [PATCH 2/2] can: flexcan: remove the auto stop mode for IMX93
Thread-Index: AQHZv3Qh2+s2I5Ho9kSKS1iIRSH7fK/Ll9gAgAAYbUA=
Date:   Wed, 26 Jul 2023 08:04:54 +0000
Message-ID: <DB7PR04MB4010889C81AA255FD2C8D32A9000A@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230726035032.3073951-1-haibo.chen@nxp.com>
 <20230726035032.3073951-2-haibo.chen@nxp.com>
 <20230726-deflected-slider-8e928de8616a-mkl@pengutronix.de>
In-Reply-To: <20230726-deflected-slider-8e928de8616a-mkl@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AM0PR04MB6932:EE_
x-ms-office365-filtering-correlation-id: 51aa0b5f-067c-4f5e-d4f7-08db8daeff25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2mVaYw1EeKf1b3OvpyanhJm80A7Tttd80KvmrgmbW1V7GR9EOsunL8XuB6xoivs3hC/4SuUQnKUwbhN03jFFiQk1gMxszmnVY6wvyLoF4GLS+NpoQVU7RtrWt1XH5MH5MNFKe3Un0UOtv1ClZ8CFqTu/fFpDJzRHchOIQH0/uYM48zmssWvSiDQgoBulH55X5ZnOGiKKSXLCptUAOPN9wY+6HkHAdqVdvfEhYz6/eACisO2IwizwFV1O/cM+UabtKnkbjCaEOFt5l2vNVfpUqLvHWZmygrl5hMkBYdg0rSC2ABoEKie5uJoEVa4lPM2auXMNBAUrQhBOZqn2v6Ko+IqNUgKFPMDnEYDLHI+zPvahcc0WOxKCxb6TzgCe9dflTbo866nPrxCuKSOgSHdgyLsVorNoOcvJYvLGPtNUwFqNMTNVTVyh0nE2FSaFLC2LPJtfHa4Z/SAel9/cBcr3I62UgB39JSz4mrCuUPZBdmsy7ztY0zIwA9AQPlbjxf6jeohb8RifAmxgO2Nl6SLwq9YG4XUjU54hZzX4HX3t8KX+HiRimcVIrqjhnGxH9pKmkqtjnXye+wksYDT9dOMh6vsBxhkC6bE2v3XHpHe4JKs+NOjtp4xTufZicqjB+5CNc1RW4K6XHgatpccMJX9YQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(9686003)(54906003)(7696005)(966005)(478600001)(66446008)(71200400001)(66574015)(26005)(186003)(53546011)(6506007)(2906002)(66476007)(66556008)(6916009)(4326008)(316002)(66946007)(76116006)(8676002)(7416002)(5660300002)(8936002)(41300700001)(52536014)(64756008)(122000001)(38100700002)(33656002)(38070700005)(86362001)(55016003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1hLQkxqZWpsZGdQaTI4Sm9ZUVpOQkw5S092QTRmVUZZbUtkQitxOTI0TC9Y?=
 =?utf-8?B?YnZSVVNuakVmMDhRNGpHaGR1SWEyL25PYlFRbUxwcm1yeHN4aElVeFMxVnBI?=
 =?utf-8?B?NWc4TXYyVFNBcjd3bGk1bHdGS0hreExxM3hhdXVCMTUrR2ZzYWpWWm5mZXdM?=
 =?utf-8?B?YUJDK2tObDZrZ2tBczlMZ0dPcmFqQmlTaFhTd3BzUFVKKzhocFhrWE9pRk13?=
 =?utf-8?B?Mi9XbEcybWRnSnJpQlpGdVk2dnRXTTJPU2VrSndWMVc1eEhLV2UzRWxlMS9M?=
 =?utf-8?B?ZUpRNW9KL1p4bmZCN01wdUZ2V0JxZGtvYWpvNlFPUThOc2NMQ2NKWkc2M3ph?=
 =?utf-8?B?SjJTZ1QreHAxUll3NzhSUHd5bFZFV2NuS3FIQnpLaVpmNlFXQS9wNU5nc3k4?=
 =?utf-8?B?MytkZ2diNks3Vkp2SEJTdENKQzc3YUpGMVp6T3N2aGpyVnQ5dytxcTNJM3Yw?=
 =?utf-8?B?eTVwWVlGQ2ZUbmhrTUJDT0lWOGNXYnE2SUVFR093MjlEWVJWK21Vb3lUbXhT?=
 =?utf-8?B?Ui9UWHNreGZwS0ViOEZLR0FmODZvMVNUeWJoN2c2M3A3SlNaaTdUNVNINmsy?=
 =?utf-8?B?VGx1Z2drclhCK3VwRUZ5Tk9oL3NEOUtmSEdKZlNzbWNCa0lPajRKNXNVdFpB?=
 =?utf-8?B?bnNNdkJOMVRmZ0N2aVd4Rm5qYWhCaG9EcTl5SmFmSTZTZjROVWdIdmFrY1lK?=
 =?utf-8?B?VmpoVzhadm1MbE5QMDQySHJpSmtKSVRDaVVra3VTR09PUWtRSGp2NUcvK1pn?=
 =?utf-8?B?VmR2bm5JM21iTmhDWDRBSTZaNGI3NTkvUndPQnlld08yZ0pxUFZNOG9LQWZB?=
 =?utf-8?B?N1JYWGpabVVZSkJoZkloektxMkwrcW45V2tqSTQ4NllrcFIxKysveHUvU0VM?=
 =?utf-8?B?NUdHNmpzM0dqajlTZUdEcGdRRWJ0MFFDay9JS3BGbjk2NTRWNEppVU0wRlNV?=
 =?utf-8?B?dE5uVDVpMTlpR1pwSU9XOUYrWUVoWmd6cVZISHRpTlQrSmlLdnBSNnlrVU52?=
 =?utf-8?B?VkVpZEZsQUhrcmNhbGp2ZG1TK0UvQ1hQMzFrUkt3NS9RUGY5Q3FObE44eXQ4?=
 =?utf-8?B?Rk13cHorWEN4dDB6SVpZTThoQUVCRk95NFJrQjc0NTEvL2JFNWZjSW42aloy?=
 =?utf-8?B?VUdZWjUwZ1dLbWxlWGRJa1VaNmRjUStmVzJ3eXR5cXQzTGVmRENZc295SmhX?=
 =?utf-8?B?Wk1yRzVRbVpRdDVKOHRmT054MFE3STRuMnJwM0c3T0RIWlZmRmo4Qklrb3B6?=
 =?utf-8?B?TUl2WTJLb2p5cmllcm00Z29YWFFXT20waTRXSUFTWS8vZTRPSkZGWUdqQ25T?=
 =?utf-8?B?aWFJTlJmZlVib2VoLzluaW9CWk5VK2krQmVOb2syaDdabFBDSERRWUxBM2ZS?=
 =?utf-8?B?RWFnMlhsS2FTckNWV3ptN09XZ0NBMHhKaWFPVWY5VjM5SEYrdElPY2hqYUFy?=
 =?utf-8?B?Y1Bad3M2bEx0R0JOMHpXT0o2SCszbnRpcDFjUys3V2tOOTJvT3oxbHNRZVNB?=
 =?utf-8?B?MGJ3K1NmZlNWYXQ3RW5BQzIvNW5McUlDdTZSUGxmSWhnYWZ1eGR4T2FYVTZF?=
 =?utf-8?B?dWVHSGZkTVNYMG93a0xBWEIyTG9iL2VUVi9PeXZqRjhzYTRQNjVPY3ZWWExC?=
 =?utf-8?B?dTBIQ3J1eXduaGVEbWVueE5Jb2xEcTFXS2l4QWs1YlczZUJzNDRsTjNsMWFO?=
 =?utf-8?B?WnI2THQ3bjE0cHFqSnpOWU1MN0lzbXRiSTBJUWhHUEdLbTNPTFB4b2pZeXVH?=
 =?utf-8?B?OThzbjU1cHZ2V2FTbTR3Q0crWGRDUFFsUWtWUTRqeUxsN2Y0SUpBT09pUFh1?=
 =?utf-8?B?OGhGODYrWHJKMnZwQ2FibUJoRHJwWUlqYTZReE1yQmRVK0YvQnRSa2h2K09X?=
 =?utf-8?B?cFI1Szg4MktUb0hzUzZMMHNRWTE5dTA3RFczSGw5ekFCcW52TlI1cGdNWWp5?=
 =?utf-8?B?cDRpTWpYNXFyNE9KOUJQQUZzc1ZuWWtTb2dxZDkwZ1hYSDlXZlQ2Qis1Y0ZY?=
 =?utf-8?B?aVhMRWRMNG50bjJsVjUvUnVmc0VlMkJnVTNVd0ZjWjBMSnhXTmdQbXR3NG1o?=
 =?utf-8?B?ZE1CRHdmV2ZmRFgyVVUvbVdPT1YvTG4vbUptMmR4WTRnQ1hyeThVTW9lOFZY?=
 =?utf-8?Q?F0BE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51aa0b5f-067c-4f5e-d4f7-08db8daeff25
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 08:04:54.7327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pDPFMFj04k5zBXVxR+EBB3fNyrNgNJKI6x1q146L7cjWpnd/CU/crAeeOE59Bihw6thKK0wds8KfbC6ZCG93qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6932
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
bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDIz5bm0N+aciDI25pelIDE0OjM2DQo+IFRv
OiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IENjOiByb2JoK2R0QGtlcm5lbC5v
cmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gY29ub3IrZHRAa2VybmVs
Lm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gd2dA
Z3JhbmRlZ2dlci5jb207IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxs
aW51eC1pbXhAbnhwLmNvbT47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5j
b207DQo+IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOw0KPiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBjYW46IGZsZXhjYW46IHJlbW92
ZSB0aGUgYXV0byBzdG9wIG1vZGUgZm9yIElNWDkzDQo+IA0KPiBPbiAyNi4wNy4yMDIzIDExOjUw
OjMyLCBoYWliby5jaGVuQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogSGFpYm8gQ2hlbiA8aGFp
Ym8uY2hlbkBueHAuY29tPg0KPiA+DQo+ID4gSU1YOTMgQTAgY2hpcCBpbnZvbHZlIHRoZSBpbnRl
cm5hbCBxLWNoYW5uZWwgaGFuZHNoYWtlIGluIExQQ0cgYW5kIENDTQ0KPiA+IHRvIGF1dG9tYXRp
Y2FsbHkgaGFuZGxlIHRoZSBGbGV4LUNBTiBJUEcgU1RPUCBzaWduYWwuIE9ubHkgYWZ0ZXINCj4g
PiBGTEVYLUNBTiBlbnRlciBzdG9wIG1vZGUgdGhlbiBjYW4gc3VwcG9ydCB0aGUgc2VsZi13YWtl
dXAgZmVhdHVyZS4NCj4gPg0KPiA+IEJ1dCBtZWV0IGlzc3VlIHdoZW4gZG8gdGhlIGNvbnRpbnVl
IHN5c3RlbSBQTSBzdHJlc3MgdGVzdC4gV2hlbiBjb25maWcNCj4gPiB0aGUgQ0FOIGFzIHdha2V1
cCBzb3VyY2UsIHRoZSBmaXJzdCB0aW1lIGFmdGVyIHN5c3RlbSBzdXNwZW5kLCBhbnkNCj4gPiBk
YXRhIG9uIENBTiBidXMgY2FuIHdha2V1cCB0aGUgc3lzdGVtLCB0aGlzIGlzIGFzIGV4cGVjdC4g
QnV0IHRoZQ0KPiA+IHNlY29uZCB0aW1lIHdoZW4gc3lzdGVtIHN1c3BlbmQsIGRhdGEgb24gQ0FO
IGJ1cyBjYW4ndCB3YWtldXAgdGhlDQo+ID4gc3lzdGVtLiBJZiBjb250aW51ZSB0aGlzIHRlc3Qs
IHdlIGZpbmQgaW4gb2RkIHRpbWUgc3lzdGVtIGVudGVyDQo+ID4gc3VzcGVuZCwgQ0FOIGNhbiB3
YWtldXAgdGhlIHN5c3RlbSwgYnV0IGluIGV2ZW4gbnVtYmVyIHN5c3RlbSBlbnRlcg0KPiA+IHN1
c3BlbmQsIENBTiBjYW4ndCB3YWtldXAgdGhlIHN5c3RlbS4NCj4gPg0KPiA+IElDIGZpbmQgYSBi
dWcgaW4gdGhlIGF1dG8gc3RvcCBtb2RlIGxvZ2ljIHdoZW4gaGFuZGxlIHRoZSBxLWNoYW5uZWws
DQo+ID4gYW5kIGNhbid0IGZpeCBpdCBlYXNpbHkuIFNvIGZvciB0aGUgbmV3IGlteDkzIEExLCBJ
QyBkcm9wIHRoZSBhdXRvDQo+ID4gc3RvcCBtb2RlIGFuZCBpbnZvbHZlIHRoZSBHUFIgdG8gc3Vw
cG9ydCBzdG9wIG1vZGUgKHVzZWQgYmVmb3JlKS4gSUMNCj4gPiBkZWZpbmUgYSBiaXQgaW4gR1BS
IHdoaWNoIGNhbiB0cmlnZ2VyIHRoZSBJUEcgU1RPUCBzaWduYWwgdG8gRmxleC1DQU4sDQo+ID4g
bGV0IGl0IGdvIGludG8gc3RvcCBtb2RlLg0KPiA+DQo+ID4gTm93IE5YUCBjbGFpbSB0byBkcm9w
IElNWDkzIEEwLCBhbmQgb25seSBzdXBwb3J0IElNWDkzIEExLiBTbyB0aGlzDQo+ID4gcGF0Y2gg
cmVtb3ZlIHRoZSBhdXRvIHN0b3AgbW9kZSwgYW5kIGFkZCBmbGFnDQo+ID4gRkxFWENBTl9RVUlS
S19TRVRVUF9TVE9QX01PREVfR1BSIHRvIGlteDkzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
SGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25l
dC9jYW4vZmxleGNhbi9mbGV4Y2FuLWNvcmUuYyB8IDM3ICsrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ID4gIGRyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuL2ZsZXhjYW4uaCAgICAgIHwgIDIgLS0N
Cj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuL2ZsZXhjYW4tY29y
ZS5jDQo+ID4gYi9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi9mbGV4Y2FuLWNvcmUuYw0KPiA+IGlu
ZGV4IGZmMGZjMThiYWYxMy4uYTNmM2E5YzkwOWJlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
bmV0L2Nhbi9mbGV4Y2FuL2ZsZXhjYW4tY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvY2Fu
L2ZsZXhjYW4vZmxleGNhbi1jb3JlLmMNCj4gPiBAQCAtMzQ4LDcgKzM0OCw3IEBAIHN0YXRpYyBz
dHJ1Y3QgZmxleGNhbl9kZXZ0eXBlX2RhdGENCj4gPiBmc2xfaW14OG1wX2RldnR5cGVfZGF0YSA9
IHsgIHN0YXRpYyBzdHJ1Y3QgZmxleGNhbl9kZXZ0eXBlX2RhdGENCj4gZnNsX2lteDkzX2RldnR5
cGVfZGF0YSA9IHsNCj4gPiAgCS5xdWlya3MgPSBGTEVYQ0FOX1FVSVJLX0RJU0FCTEVfUlhGRyB8
DQo+IEZMRVhDQU5fUVVJUktfRU5BQkxFX0VBQ0VOX1JSUyB8DQo+ID4gIAkJRkxFWENBTl9RVUlS
S19ESVNBQkxFX01FQ1IgfA0KPiBGTEVYQ0FOX1FVSVJLX1VTRV9SWF9NQUlMQk9YIHwNCj4gPiAt
CQlGTEVYQ0FOX1FVSVJLX0JST0tFTl9QRVJSX1NUQVRFIHwNCj4gRkxFWENBTl9RVUlSS19BVVRP
X1NUT1BfTU9ERSB8DQo+ID4gKwkJRkxFWENBTl9RVUlSS19CUk9LRU5fUEVSUl9TVEFURSB8DQo+
IEZMRVhDQU5fUVVJUktfU0VUVVBfU1RPUF9NT0RFX0dQUg0KPiA+ICt8DQo+IA0KPiBBRkFJQ1Mg
dGhpcyBjaGFuZ2UgYnJlYWtzIHN5c3RlbXMgd2l0aCBvbGQgZGV2aWNlIHRyZWVzIChpLmUuIHdp
dGhvdXQNCj4gImZzbCxzdG9wLW1vZGUiKSBhbmQgbmV3IGtlcm5lbHMuIFRoZSBmbGV4Y2FuIGRy
aXZlciB3aWxsIG5vdCBwcm9iZSBhbnltb3JlLg0KDQpZb3UgYXJlIHJpZ2h0LiBMYWNrIG9mICJm
c2wsc3RvcC1tb2RlIiBzaG91bGQgbm90IGJyZWFrIHRoZSBmbGV4Y2FuIGRyaXZlciBwcm9iZS4N
Ckkgd2lsbCBzZW5kIFYyIHBhdGNoIHRvIGZpeCB0aGlzLg0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJv
IENoZW4NCj4gDQo+IE1hcmMNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAg
ICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgfA0KPiBFbWJlZGRlZCBMaW51eCAg
ICAgICAgICAgICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlIHwNCj4gVmVydHJl
dHVuZyBOw7xybmJlcmcgICAgICAgICAgICAgIHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0xMjkg
fA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiB8IEZheDogICArNDktNTEyMS0y
MDY5MTctOSAgIHwNCg==
