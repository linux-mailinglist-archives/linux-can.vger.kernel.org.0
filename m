Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D804931E926
	for <lists+linux-can@lfdr.de>; Thu, 18 Feb 2021 12:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhBRLaY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Feb 2021 06:30:24 -0500
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:57119
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231216AbhBRKOY (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 18 Feb 2021 05:14:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STBa7M5SvUxUuRjJN2kxYBL1aammB8R2X+DHtChmwtYpfWod4L1hypsQQSK1bIf4z7KIHvMO1K1hUxkJ3HK58HL5T02QISnMrad9U6I75p0Zr3dQIZ/FsRHKNPSU9VWFzxuaG64Pd9WKqCxRLBsIvJuxFilgvqVIMhSzagdRnX//H8uibKrbxijbCiGd5EbCDTVtM1526SZ3tIESSNxuQSBub5ON4IUGF3wGcPfwZZqYxqQBATQVTbdlNmDsIbCZA8pFw0FQgyoe9jUp+G/EPq/HMSND/nkhI8GVBdOarCpyhR4VWAlRD5a+j231HW+8ej4ji+SZ7gRYq91Fzn+dbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+2UBnCndqLNZPohMvUpkV39NeDka/XKrA95sxhFr3w=;
 b=hcHoHqc0wSXvjttcQNufpTpVgbERzvMJUQ7PrMtAa6UxIV4woDTAhRv/+PTIDFuzzKAXn2qMW+ygBaPTZydZhLiDF7891/rmFunYbf5pu27Hmy4wLH/2DdbUI4IwwaiHHGKW6NR4ykv2JKHQV+ihAMOqUTCGgkPfcnvyDQN1u7ADqeCijQ2pQ8sICcYEoqL6zs+khL0VY4iIs0YL0CgSCEx8Rak7RWrv8+jYOnILVouNKWoCy8uOFDh+SCsqJFQcgaoLVrVTzF3VlP5sTYSybSFUUQLw8rnAvpgFKKiS4YerV/YvAvs5kFkSgTAJe9AV8glvbNHJME+3nduUjrRplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+2UBnCndqLNZPohMvUpkV39NeDka/XKrA95sxhFr3w=;
 b=iwSfQuJqydMIhzA7gSg7wKbyjeINY2NCZ75NRO69LE/tDTFMVAB9nSLMtlSzsZV8ehys+ZXc/NCwrLaM/+vgX+WHRpBcZnZ7I2EL+sKbK2xlWD4QsgN2U1HKYl6GmQFOAYvdr7wQvsgKc5HqNDwkwKANA8R9T7hX0Qq06EKzmMk=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0401MB2501.eurprd04.prod.outlook.com (2603:10a6:4:33::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 18 Feb
 2021 10:13:32 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978%4]) with mapi id 15.20.3846.042; Thu, 18 Feb 2021
 10:13:32 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 0/3] can: flexcan: fixes for freeze mode
Thread-Topic: [PATCH V2 0/3] can: flexcan: fixes for freeze mode
Thread-Index: AQHW+hOpaJvl0L4g9kmAuxRLuJJW8KpdyStQ
Date:   Thu, 18 Feb 2021 10:13:32 +0000
Message-ID: <DB8PR04MB67958AB710293B5F2107345EE6859@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210203100255.12472-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20210203100255.12472-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0624fe7-b7ee-427d-0571-08d8d3f5d896
x-ms-traffictypediagnostic: DB6PR0401MB2501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB25015D694E23B2DAE31445AFE6859@DB6PR0401MB2501.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KVK0nAMV9CsogqtuSKs4/jZpojGRLbgjCDAvT021CAbTKcwwK5hhCFdG5yHeNPCnILoz8YkNFyiv53wLQMKXIzCVOxFZ81Y/1lDWfZlTtnpb/Kd0BnDvB83HRVIw4AVr76lpfQwyptl764jdDOh/s2QGkXYgY0KEWbGTrQvizzB30ST2kOuzbcjaS6pvnRuAEn10g/NPAhpzFkrSo/lZWUrwHAAB4eIz27yFi8HQQxNDDMJN6+sSvAlPPaoGFA+k9fFp/Azgg+Czrw5e+JhIZ/xkTvfnbj25Inkmh+Mv62OaQFTSBssFWzXl2uVYvPCpyUP1gg7ptbNz2QfGXhGvQoBoSAevG7VbrKSesljjEitRVkffYMp6fwaiTn78MHEXSMXiPnmMJnFfpUPZc7HnwnYuIwyKiiSQQUP24qh5M6bU9XcYRGZ6w0zZRUZzj0X9UGoQjpyjKesB5b3KzTszkdGxWvwc3IUarONJi5DqThhBZ8Kv1to0X5DBVFqfrjFWqJfHFBEHcxVeSJe9MFfiIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(64756008)(76116006)(66476007)(6506007)(66446008)(5660300002)(55016002)(8676002)(8936002)(66946007)(7696005)(9686003)(316002)(478600001)(6916009)(26005)(33656002)(71200400001)(83380400001)(2906002)(66556008)(53546011)(4744005)(4326008)(86362001)(186003)(54906003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?VGV2OEhlM3U4aTEyYmpoSHhCWGRta2JHRmtINSs5TGJIdEhpMElUZmVLQTZZ?=
 =?gb2312?B?RXlEMnNmc1ZBaXZXYXVOV2hHMWloKzc1RGc0dU9uMytZbTVodUs1eDZwWkUy?=
 =?gb2312?B?eXB1ZlcxWkM0RDljNEc2dmhMQVZXUk15dEpQTEwweURxNDVNUUI4R2ttZFUy?=
 =?gb2312?B?S25zbnRvcXdOY3NMdlljQkc0dm9zdHR6NkUydzhKZS9FN0ZTSDZJU0dDL1d4?=
 =?gb2312?B?K04ycm9BMFpQY3pHUS90WE9NS2taS1dQOVlwamRkYlZmR0lyTGpFQkRoaTNQ?=
 =?gb2312?B?VXIyMGVOZzVSUmg3Ty9iTTRlcUNGbUNGdmJTV3BjbVpWQmxFUXRqdmNOcDE1?=
 =?gb2312?B?R0lvYjZWcFJLMll0RG1UU09ady9Kb2hrR25kQ04wajFQR01SR1RibDhzamRC?=
 =?gb2312?B?V29ZTjVseVpBNGFUbXFxTkdPaXVqOVVsMkZINm8yNk03cFp0dHVJTlRvclF4?=
 =?gb2312?B?SWt4NCt1RTFTd2lMY2o1T3VRcWVDMW8zMDgrbTlicHJTMnl1RGI0cEtlUC9z?=
 =?gb2312?B?TElPM0dkMlJLcHVFMWFrZm1LSitFaWhZYXlLdWRraE9SQVVrZVZsMnNKb2E5?=
 =?gb2312?B?RGFScFdCT0hlT2tIcWV3dkpHSURPWW8vT0VvT3ZpRzY2djNTdXE2RTlaUjZ4?=
 =?gb2312?B?Y3VHYVZoSkQ1eDVkY09jVjVTbGREb0Npdk8xVE5zTzFUUzNjY2JkZ1VMcGJS?=
 =?gb2312?B?em5HZmFlNTBUdDAxVGJuemxlKzBZY1l0UEpMTnE2Uy93VTVWU09NUG1WSkU0?=
 =?gb2312?B?R056UjVhT3lSQXdEZitjVHAzZFYwMUxsS1FjWW8zU3lRSGhzcUg3NmEwVlVF?=
 =?gb2312?B?M01UOGt5K1dmYXFqaDg1UjduY3lnT082elBFUWpvUFhZNnVJc1VUVUlLNEpl?=
 =?gb2312?B?VzJSUTJuMmtMMnFJQS82bVovakVlVUhoQXFDaFVLeVJadFRkeERERmRxRTJm?=
 =?gb2312?B?TUN5aWZ2TzdONW1LdXJySk5BRi9GREc0MU9kQWZvVVc1Ym1nRmtMSFdURS9P?=
 =?gb2312?B?VHNXeVFwMTVTWGVDWnZUNVpVczdRMW43MnBSbVkvSExYSHpzaGNPTE5sQXpD?=
 =?gb2312?B?amkwWXloRVZDNFRUV2JBTWV0RjlhR2lOSGFXOVhadXpPaUs1QTlTQkpTSlhh?=
 =?gb2312?B?RFBCbWtvcUJ4cWN4ZmdhdUszWnFXcTg0QXUybGJxRmlvTE85ZXFXRDhZZ05n?=
 =?gb2312?B?UWxQYjFLdnhwQ3NnNEN3NUtLY25pZUo4bFU1c1FwT0dNajMvc2IrdXlmU2JP?=
 =?gb2312?B?OFJXRTUrNzJyV3VsLy8zT3JOcXpXUW9maW1zUGdnQVVjTkNxSXVHSGVLbU90?=
 =?gb2312?B?d3l3OWh0ZGRVVFF5SjJCVTUzUWdUQUE4MkE2azBLdjJIQllhSjIxUXJ5c3No?=
 =?gb2312?B?VVhQenM3NWcyUXJrcE5Ea3U1ME9lbVZ1S2lJcEdLRmx3ZHBxc24rd1l1ZUJF?=
 =?gb2312?B?RnB5a1ZRdWZiZWtyeHZaMm9QYkUvZ1VHSXdQS0Y4SmdBcld5MjhIOTNjM2Vt?=
 =?gb2312?B?aGZXeWlzblZuQzNodDFsdWpFQnNuQnZVekZLa1ZLWlZpdmhBY0FFbFVWaTFp?=
 =?gb2312?B?d05zZml0UUJoMmQzbTY3eVFWL2JOVzNtOG1lbEtOYUtMbU95L1dwd1pNcFEv?=
 =?gb2312?B?VzUvbXNIcmRVRk1HcDFpZWNocm9DTDh0MTUrcktGOHFrSlZWY1NwOGpHWE5P?=
 =?gb2312?B?dU5OenhRYW1qK1hic1dadUVWMTEralZoOHUyMHJLQWt4TXVkSmw3VHliZlE0?=
 =?gb2312?Q?sP/yE8Bh9rtZ0gMD2rEwUStEbkKxPcdaCOhesPU?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0624fe7-b7ee-427d-0571-08d8d3f5d896
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 10:13:32.5769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOdxX86CQbUSorJUeQt/rlDZYefsdgrZnpPzZryFLycU1En/0TvmNTVc7b29UnuzueJUYFou4qsYhwMCBF0ZzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2501
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQpHZW50bGUgcGluZ2luZy4uLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2FraW0gWmhhbmcgPHFpYW5ncWlu
Zy56aGFuZ0BueHAuY29tPg0KPiBTZW50OiAyMDIxxOoy1MIzyNUgMTg6MDMNCj4gVG86IG1rbEBw
ZW5ndXRyb25peC5kZQ0KPiBDYzogbGludXgtY2FuQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgt
aW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIFYyIDAvM10gY2FuOiBm
bGV4Y2FuOiBmaXhlcyBmb3IgZnJlZXplIG1vZGUNCj4gDQo+IEZpeGVzIGZvciBmcmVlemUgbW9k
ZS4NCj4gDQo+IC0tLQ0KPiBDaGFuZ0xvZ3M6DQo+IFYxLT5WMjoNCj4gCSogbWFrZSB1c2Ugb2Yg
ZXhpc3RpbmcgZnVuY3Rpb25zIGZsZXhjYW5fY2hpcF9mcmVlemUoKS4NCj4gCSogYWRkIHBhdGNo
ICMxIGFuZCAjMy4NCj4gDQo+IEpvYWtpbSBaaGFuZyAoMyk6DQo+ICAgY2FuOiBmbGV4Y2FuOiBh
c3NlcnQgRlJaIGJpdCBpbiBmbGV4Y2FuX2NoaXBfZnJlZXplKCkNCj4gICBjYW46IGZsZXhjYW46
IGVuYWJsZSBSWCBGSUZPIGFmdGVyIEZSWi9IQUxUIHZhbGlkDQo+ICAgY2FuOiBmbGV4Y2FuOiBp
bnZva2UgZmxleGNhbl9jaGlwX2ZyZWV6ZSgpIHRvIGVudGVyIGZyZWV6ZSBtb2RlDQo+IA0KPiAg
ZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYyB8IDI1ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4g
DQo+IC0tDQo+IDIuMTcuMQ0KDQo=
