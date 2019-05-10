Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC5019ADC
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2019 11:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfEJJlo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 10 May 2019 05:41:44 -0400
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:26588
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727136AbfEJJlo (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 10 May 2019 05:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jT/OmlD8ta9+sKIPPK5/U00pxS1Q4UGMa5xw4WAWZBQ=;
 b=EN097ZuzmsAbqsL3rqHkVZx8a8yWz5o/lbpCkQqWkQER+nwyPGJGNlcrCoUQY4JLdhzsbeE/REiAsnOnL/L6P46vTIsba+oDB1YcXUOGro7yJW405D7I7hdhrRZ26Z+RiRmTqUlWwTxRjLuUAtXI9TX7h+FyzsZ/BF5SbcYjTPE=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2381.eurprd04.prod.outlook.com (10.169.134.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Fri, 10 May 2019 09:41:40 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7%3]) with mapi id 15.20.1878.022; Fri, 10 May 2019
 09:41:40 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Pankaj Bansal <pankaj.bansal@nxp.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Leo Li <leoyang.li@nxp.com>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH 0/2] can: flexcan: add clocking information
Thread-Topic: [PATCH 0/2] can: flexcan: add clocking information
Thread-Index: AQHVBxIc32e9Suxso0usQOUY69PgyaZkGvAw
Date:   Fri, 10 May 2019 09:41:40 +0000
Message-ID: <VI1PR0401MB2496E2C0184B58FA7F70A53AF10C0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20190510144724.16447-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190510144724.16447-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.120.0.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ec9955a-32d5-4d7e-6033-08d6d52bb48d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2381;
x-ms-traffictypediagnostic: VI1PR0401MB2381:
x-microsoft-antispam-prvs: <VI1PR0401MB238141696AD2E9E9F47B634AF10C0@VI1PR0401MB2381.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(366004)(13464003)(189003)(199004)(81156014)(33656002)(71190400001)(6506007)(99286004)(64756008)(68736007)(4744005)(66446008)(8676002)(66476007)(66556008)(102836004)(6246003)(86362001)(8936002)(3846002)(7736002)(6116002)(110136005)(14454004)(81166006)(52536014)(6436002)(4326008)(486006)(476003)(26005)(6636002)(256004)(316002)(53936002)(74316002)(25786009)(53546011)(44832011)(71200400001)(5660300002)(446003)(11346002)(7696005)(229853002)(478600001)(76176011)(55016002)(76116006)(73956011)(66946007)(54906003)(2906002)(66066001)(186003)(305945005)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2381;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UFcORcKJIjWMBGCGZNaYOGrI7VzgpmbnZ6xSuC3STpRS8N0Tx46eibR1jp49Zv/WZkF4pirbPS9TxSwnb2RoByb1CX5DSEndZhp9GfI98of0NZn93nV/jVVQRE2uoYWgTLID4MC9wQvORxuU5yHX64uE+O5LkIKTj9UDqH+VIMfY1oyjcMksJl66zs/XR/yIHXhXqgZ+C42OMWD9RxsSlemLf0NdPoijwS1Sn7/ATRC90f60rsIGhA2XXvI5LSnOg2r2fsnq9bV/gyNktvOaSIcyAwXry+gnIj8qSHyba7tCOKT+hBmqja8xeSt/5vdHtYHafpPxQptCWQCRz/mU9U+SUxGeV+JdF65HqO05/UFwx5QetIhhCrYLgIWrtwkK2nYMt86/SXhCRuSn2h9lc8ykxM84w5JfuoxIy3Bk0PI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec9955a-32d5-4d7e-6033-08d6d52bb48d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 09:41:40.8137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2381
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

KyBMZW8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW5rYWogQmFu
c2FsIDxwYW5rYWouYmFuc2FsQG54cC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgMTAgTWF5LCAyMDE5
IDAyOjU0IFBNDQo+IFRvOiBXb2xmZ2FuZyBHcmFuZGVnZ2VyIDx3Z0BncmFuZGVnZ2VyLmNvbT47
IE1hcmMgS2xlaW5lLUJ1ZGRlDQo+IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IENjOiBsaW51eC1j
YW5Admdlci5rZXJuZWwub3JnOyBQYW5rYWogQmFuc2FsIDxwYW5rYWouYmFuc2FsQG54cC5jb20+
OyBWYXJ1bg0KPiBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMC8y
XSBjYW46IGZsZXhjYW46IGFkZCBjbG9ja2luZyBpbmZvcm1hdGlvbg0KPiANCj4gVGhlIGNsb2Nr
aW5nIGluZm9ybWF0aW9uIGlzIG1pc3NpbmcgZnJvbSBmbGV4Y2FuIGRldmljZSB0cmVlIGJpbmRp
bmdzLg0KPiBUaGlzIGluZm9ybWF0aW9uIGlzIG5lZWRlZCB0byBiZSBhYmxlIHRvIHVzZSBmbGV4
Y2FuLiBEb2N1bWVudCB0aGUgc2FtZS4NCj4gDQo+IEJhc2VkIG9uIHRoZSBpbmZvcm1hdGlvbiBp
biBkb2N1bWVudCwgbWFrZSB0aGUgUEUgY2xvY2sgcGFyc2luZyBjb25kaXRpb25hbCBpbg0KPiBm
bGV4Y2FuIGRyaXZlci4NCj4gDQo+IENjOiBWYXJ1biBTZXRoaSA8Vi5TZXRoaUBueHAuY29tPg0K
PiANCj4gUGFua2FqIEJhbnNhbCAoMik6DQo+ICAgRG9jdW1lbnRhdGlvbjogY2FuOiBmbGV4Y2Fu
OiBBZGQgZmxleGNhbiBjbG9ja3MnIGluZm9ybWF0aW9uDQo+ICAgY2FuOiBmbGV4Y2FuOiBtYWtl
IFBFIGNsb2NrIGluZm8gY29uZGl0aW9uYWwNCj4gDQo+ICAuLi4vYmluZGluZ3MvbmV0L2Nhbi9m
c2wtZmxleGNhbi50eHQgICAgICAgICAgfCA0NyArKysrKysrKysrKysrKysrKystDQo+ICBkcml2
ZXJzL25ldC9jYW4vZmxleGNhbi5jICAgICAgICAgICAgICAgICAgICAgfCAzOSArKysrKysrKysr
LS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25z
KC0pDQo+IA0KPiAtLQ0KPiAyLjE3LjENCg0K
