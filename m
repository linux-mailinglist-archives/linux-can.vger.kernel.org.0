Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36EF31E92B
	for <lists+linux-can@lfdr.de>; Thu, 18 Feb 2021 12:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhBRLcZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Feb 2021 06:32:25 -0500
Received: from mail-am6eur05on2075.outbound.protection.outlook.com ([40.107.22.75]:55520
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231808AbhBRKpd (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 18 Feb 2021 05:45:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4xafbwSA4FgxCZtFoO3EVM7QQnWt0ObP3dAWnn4r398Ze9qgEX/zgVKYCYgPKyge4o0na8+LAE42p08WICfJnNrGotOr/ejmQ8Zqw+r5Q5klnz8tJYsvsRzwCQowW98XlXoYnl/kBUWJs/LDOTDrDieWqpXeCWtH4xntHUlyOcAC5UAEgS5RhXU2eNuHgeaS/cyNz9ZJ4Za+ccx/s9P6l8CDc+QjrsLk7kNIPQqi/nF6akofULohwh3gCzzF0RkH3AoXcgZFnolGMQdLIVWuZrq0zGwU8/9TnFjIxIq5+20sg9LlUgww0YIQxXliSz/0ZD9J1SJNvi7Jk5kvMETDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybi86cQa1bWGvGau/IBj34Bkz7aKuhP56Npq3ZnxTfg=;
 b=f8uSIO9zpkjNDIDx9Zb0+ikEGiLCcokkcRUkF7DFayGxZwe9/lL6A/HtrhrmsI/0y9Fl0k6KkDskaDKzFd4Z2mcw2IakxcVryJXnLIzOFSIrMUDe0LS91gDWos7EyZHxAVI1PTDUxurI+HbqamO0UBCQzr8VWsMPKzTa2BM4QyUqgy3bzSxRpxfW+6+EBSQTownz3tMtwqe6V81WdbS/R1HR76JLgJ8JsXVfZb+8UOpzc5GTxi77muxNxQI99P8dRagQps9696nRGQaSf0uEWEGxapwArClqKFEVjJcsF32QmiXlqHztGsiMIvlcSwSmCS/iCPe6aC9kj8ju6uyNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybi86cQa1bWGvGau/IBj34Bkz7aKuhP56Npq3ZnxTfg=;
 b=XHOLeW7eAwSsWYrmiEZzT6o89HdgUccNKyMJKEzWmG2vo9cBwBs7/iPJV+aw3XjzW7rIt+RbVICQdmUvZQMTp4NAyLQCp59Uc3AFiKYplwOOF5ZbvGq8CMcQWU87QF2UgRMg+EJ2VHYpbXCGVjkOS2h32ozvlWKxPlP+DDBe3RY=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4105.eurprd04.prod.outlook.com (2603:10a6:5:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 18 Feb
 2021 10:44:29 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::7d13:2d65:d6f7:b978%4]) with mapi id 15.20.3846.042; Thu, 18 Feb 2021
 10:44:29 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/3] can: flexcan: enable RX FIFO after FRZ/HALT valid
Thread-Topic: [PATCH V2 2/3] can: flexcan: enable RX FIFO after FRZ/HALT valid
Thread-Index: AQHW+hOrxIB3PsW+mEKTOwps8rH8y6pdy5oAgAAFuwA=
Date:   Thu, 18 Feb 2021 10:44:29 +0000
Message-ID: <DB8PR04MB6795E0DF357D4014AB443B23E6859@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210203100255.12472-1-qiangqing.zhang@nxp.com>
 <20210203100255.12472-3-qiangqing.zhang@nxp.com>
 <20210218102154.es44sbablhr2p5o5@pengutronix.de>
In-Reply-To: <20210218102154.es44sbablhr2p5o5@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b56b07ce-3c3c-43c5-7e7a-08d8d3fa2b27
x-ms-traffictypediagnostic: DB7PR04MB4105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4105437858CAF89CBD8F15D7E6859@DB7PR04MB4105.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pE7X3N3YBbVLbHDE2obMQsvjPJKrFiwFfLiy9P84Z+tVX4eHjUQWLlgUgEK62g3PTMwpjKykaS6drIPEF1CiODV1oYgIg0pzbIS6luIorbFu3gYcaUhyhMObxyiD4QmqDDpNM+lJwYXzOHKYyxuvSvRHmgN3KcQELUMp/GwKx3EKvqA1h2dOSeBeBoMNO3h11NHeYhtVpL53tW904eRNlAF2S3uGwDmgbA0qraSwAbFiZS2H7s+PtoeFW8TF7+hI3wQuZUjfQaEWmdsGmvFyPrZ9X4fwZhadY+mOlqJ0D9V+sIOQpC6pfF/Gsj4hyePRiTQAdNNBM3B7RoIO4fO5qHWbcqEah5YqMcXmTFAojU8fVsQUYLVtQRE3AU13eQyEMebFiXmPaApA/xFCigE5fsTluSInKNydVqZkCbaZc6TnxxqHdpHecgxakVhSw8O4v3qWYVm2LmCps+wzJwbgJMNhr3oTT2DpY6aztX+DTN2tihpJI828W24YWxPjQFahQQNwRjlmKQ35PKxz/WPpAZmaeQf2u5zDm7AorekxwOUWud1fuTEaEbFDmaSYGWFBFDrJqIZRQxO3hXFyE9J1blroV9/84IiEYondm5Z288McEnnqqtDwxFC28ZstoYNKCXGW02bTYokkRBt0ik3E7SkebVb64qMhixAbWDEuhQw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(478600001)(8936002)(5660300002)(71200400001)(76116006)(2906002)(6916009)(83380400001)(54906003)(8676002)(86362001)(66946007)(4326008)(966005)(66476007)(316002)(66446008)(9686003)(83080400002)(53546011)(33656002)(52536014)(6506007)(64756008)(26005)(7696005)(55016002)(66556008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NzV1Q2J6ditodkY2eFdpSlFKZHpYd0x1dk96OGdBeFBBWHNJdXYyYWZLUkcx?=
 =?utf-8?B?M0xqRi9GdUZrSlo0d0pVaHY0RTJzamdWQVdKeTU3Tm81K1g3Um5LTkQ3YTBn?=
 =?utf-8?B?Q3BmdHl3WUVYTXIvNGo1QUhWL0U5OUhUajBDYzJselJqUkNoZEMrM0lNSk9U?=
 =?utf-8?B?Z0s5WE9OeEczanN2TDR0bEhhMythS3FLUElMeEI4SWlSSFBoYnN2NFhCeFho?=
 =?utf-8?B?U2ZibG9UbjY1OFlzaWpTblF6VDZVOHhwQ3VGSjJEMmFaTzl4bXd6TCtqdm0w?=
 =?utf-8?B?YTZQaWJ4Q1FQVnArekRObG9YNjg5b1dyeEdSUUNjVTAzWEQ5a2VxVXA2WXVm?=
 =?utf-8?B?SVg3OWh0TkRCS2tNOGxPVTZFMnphQnFORFZEcG9RUlE4T3UxVHlBdFJVVHN6?=
 =?utf-8?B?L25nbndTWjJ2anJsc3dEWXlSSnNISzBNdmdwQklGbnFBdDE4bE1OY0RYaHZr?=
 =?utf-8?B?bUNYQ1luN2hSRHJtRFc1bWtERHN2bDd4TC9PM0FhNGtvTDV1dTJ4K3RrcEZr?=
 =?utf-8?B?UGx3eUlTS3VCWVA0djVHUmNWenlxSmZoWkd0eEtPMEJ5NnprWktjb2FPTXND?=
 =?utf-8?B?NWxwa3c0RnpkTE1Sa20rVTFoc3EyWWtVaDgzdjJ5NjkrcDJUZW5OS3ZVNmh2?=
 =?utf-8?B?NVJuQTdIYlNTcVUxRUtOWW91T2h1UVFWZkwzV3Fua2FGOUI3dHVNaHpYaDNa?=
 =?utf-8?B?TEh4eU1NOEdKUStncnZvMGJrYWlhS1R6aUk4c2ticGhpQmZESS9TMms0cXk4?=
 =?utf-8?B?L0piQzl2QUpuT2dja3ZvVUdEdkM5blNTZlI2RUNkaFVKM0NKQzY2MmVkaE5r?=
 =?utf-8?B?dXhyMGJnT0ovTTZCdTZJeGFXbDVwN1F6c2ZiamlkSUVxZy9HUzlzODJBdlpK?=
 =?utf-8?B?NWJ2K1NpcDZGcEZzQ1Z4Y2NqK2YzeHc1NDN0UjRNb0ZJY2VYUzRvZUduOVVn?=
 =?utf-8?B?UHl3ZUZ4all6VEJNbVh0YjNKRzlXTmdZVDh3aFhlZm1od2dRdXc4ZVVWQXg4?=
 =?utf-8?B?amNFR25rYVdqVmE4QkpneTg3QU9nR1FTcm5jdEVLNXJVTHhpOTZSSGJldE9U?=
 =?utf-8?B?Szl1UnhNYTBYdUcwWENwSkV0UHdjNnpqWTdFQ1NHWklFTTZXbXp1R3BzcWpo?=
 =?utf-8?B?UDhXNTlySFBpWXNLNERRWEJrc0QyU0J6S0Z5cnJrSlRnRzFyUUM3alVTUDNC?=
 =?utf-8?B?U3JxRDJ3SEgyYnhHT1R4dmZFUENrbWJQVlRYTXdtd1pZMG9zZU9yM0ZldWcy?=
 =?utf-8?B?TzNKWnovYitZeDRZS255eUVOcWU2VmRkQURuT040Qk1aQU8rYlV6KytEY1R0?=
 =?utf-8?B?UVlXV3E3WU1ILzQrdDRsazV1Q2hXTFRZS21oVzNtZkRIbktCMFJsOFgxQzI2?=
 =?utf-8?B?Sk9YL0ExRG93eDBtNkxHRC95VHRjYlY5NnhUd1p2aXgxeERSNjF6Wld0Z3lX?=
 =?utf-8?B?Y3JHSG1XanNIRUVqampJYkZadSthTWt6OFliRlFkMXZpMDVHQ29KVjdZM3ZC?=
 =?utf-8?B?VDR0ckowYnh3S2ZzUFRZeE5uZ25IU0VzQzNIMUM1bEoxaUZPdElGbkFkT2V2?=
 =?utf-8?B?d3pnSElvaU1acms2VTU3YVF2ejgwc0JHbStacmcwZXlmQmtQemg5eHd0SDF5?=
 =?utf-8?B?cVFVN204eFhPYWdnMVhyZ3hxNnJ6TWJuZWkvMGcvVmZqd0t2NktvTTlFSnBi?=
 =?utf-8?B?ZHFoaHRNdFhTMEJNckJHNnpNcEErMnR5K0w1WlladzA0SWd5L1lZUjdPMm0r?=
 =?utf-8?Q?wW15ow8MqCh7JGqWQJPP8vu7J+7XzTx4sSra2zf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56b07ce-3c3c-43c5-7e7a-08d8d3fa2b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 10:44:29.1531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLNHcdxlOslJ5fvX9LIwasOkzuK12Su2RuaK7CtpUEGHXq/SE28GLzvzZDMXCbLBup4R73lw4DBsptSiHN+DjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4105
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRl
IDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjHlubQy5pyIMTjml6UgMTg6MjINCj4g
VG86IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+IENjOiBsaW51eC1j
YW5Admdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIFYyIDIvM10gY2FuOiBmbGV4Y2FuOiBlbmFibGUgUlggRklGTyBh
ZnRlciBGUlovSEFMVCB2YWxpZA0KPiANCj4gT24gMDMuMDIuMjAyMSAxODowMjo1NCwgSm9ha2lt
IFpoYW5nIHdyb3RlOg0KPiA+IFJYIEZJRk8gZW5hYmxlIGZhaWxlZCBjb3VsZCBoYXBwZW4gd2hl
biBkbyBzeXN0ZW0gcmVib290IHN0cmVzcyB0ZXN0Og0KPiA+DQo+ID4gWyAgICAwLjMwMzk1OF0g
ZmxleGNhbiA1YThkMDAwMC5jYW46IDVhOGQwMDAwLmNhbiBzdXBwbHkgeGNlaXZlciBub3QNCj4g
Zm91bmQsIHVzaW5nIGR1bW15IHJlZ3VsYXRvcg0KPiA+IFsgICAgMC4zMDQyODFdIGZsZXhjYW4g
NWE4ZDAwMDAuY2FuICh1bm5hbWVkIG5ldF9kZXZpY2UpICh1bmluaXRpYWxpemVkKToNCj4gQ291
bGQgbm90IGVuYWJsZSBSWCBGSUZPLCB1bnN1cHBvcnRlZCBjb3JlDQo+ID4gWyAgICAwLjMxNDY0
MF0gZmxleGNhbiA1YThkMDAwMC5jYW46IHJlZ2lzdGVyaW5nIG5ldGRldiBmYWlsZWQNCj4gPiBb
ICAgIDAuMzIwNzI4XSBmbGV4Y2FuIDVhOGUwMDAwLmNhbjogNWE4ZTAwMDAuY2FuIHN1cHBseSB4
Y2VpdmVyIG5vdA0KPiBmb3VuZCwgdXNpbmcgZHVtbXkgcmVndWxhdG9yDQo+ID4gWyAgICAwLjMy
MDk5MV0gZmxleGNhbiA1YThlMDAwMC5jYW4gKHVubmFtZWQgbmV0X2RldmljZSkgKHVuaW5pdGlh
bGl6ZWQpOg0KPiBDb3VsZCBub3QgZW5hYmxlIFJYIEZJRk8sIHVuc3VwcG9ydGVkIGNvcmUNCj4g
PiBbICAgIDAuMzMxMzYwXSBmbGV4Y2FuIDVhOGUwMDAwLmNhbjogcmVnaXN0ZXJpbmcgbmV0ZGV2
IGZhaWxlZA0KPiA+IFsgICAgMC4zMzc0NDRdIGZsZXhjYW4gNWE4ZjAwMDAuY2FuOiA1YThmMDAw
MC5jYW4gc3VwcGx5IHhjZWl2ZXIgbm90IGZvdW5kLA0KPiB1c2luZyBkdW1teSByZWd1bGF0b3IN
Cj4gPiBbICAgIDAuMzM3NzE2XSBmbGV4Y2FuIDVhOGYwMDAwLmNhbiAodW5uYW1lZCBuZXRfZGV2
aWNlKSAodW5pbml0aWFsaXplZCk6DQo+IENvdWxkIG5vdCBlbmFibGUgUlggRklGTywgdW5zdXBw
b3J0ZWQgY29yZQ0KPiA+IFsgICAgMC4zNDgxMTddIGZsZXhjYW4gNWE4ZjAwMDAuY2FuOiByZWdp
c3RlcmluZyBuZXRkZXYgZmFpbGVkDQo+ID4NCj4gPiBSWCBGSUZPIHNob3VsZCBiZSBlbmFibGVk
IGFmdGVyIHRoZSBGUlovSEFMVCBhcmUgdmFsaWQuIEJ1dCB0aGUNCj4gPiBjdXJyZW50IGNvZGUg
ZW5hYmxlIFJYIEZJRk8gYW5kIEZSWi9IQUxUIGF0IHRoZSBzYW1lIHRpbWUuDQo+ID4NCj4gPiBG
aXhlczogZTk1NWNlYWQwMzExNyAoIkNBTjogQWRkIEZsZXhjYW4gQ0FOIGNvbnRyb2xsZXIgZHJp
dmVyIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0Bu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jIHwgMTEgKysr
KysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jIGIv
ZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYw0KPiA+IGluZGV4IDczN2U1OTRjYjEyYy4uODRjOThl
YTdkZDU1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMNCj4gPiAr
KysgYi9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jDQo+ID4gQEAgLTE4MjUsMTAgKzE4MjUsMTMg
QEAgc3RhdGljIGludCByZWdpc3Rlcl9mbGV4Y2FuZGV2KHN0cnVjdCBuZXRfZGV2aWNlDQo+ICpk
ZXYpDQo+ID4gIAlpZiAoZXJyKQ0KPiA+ICAJCWdvdG8gb3V0X2NoaXBfZGlzYWJsZTsNCj4gPg0K
PiA+IC0JLyogc2V0IGZyZWV6ZSwgaGFsdCBhbmQgYWN0aXZhdGUgRklGTywgcmVzdHJpY3QgcmVn
aXN0ZXIgYWNjZXNzICovDQo+ID4gLQlyZWcgPSBwcml2LT5yZWFkKCZyZWdzLT5tY3IpOw0KPiA+
IC0JcmVnIHw9IEZMRVhDQU5fTUNSX0ZSWiB8IEZMRVhDQU5fTUNSX0hBTFQgfA0KPiA+IC0JCUZM
RVhDQU5fTUNSX0ZFTiB8IEZMRVhDQU5fTUNSX1NVUFY7DQo+ID4gKwkvKiBzZXQgZnJlZXplLCBo
YWx0ICovDQo+ID4gKwllcnIgPSBmbGV4Y2FuX2NoaXBfZnJlZXplKHByaXYpOw0KPiA+ICsJaWYg
KGVycikNCj4gPiArCQlnb3RvIG91dF9jaGlwX2Rpc2FibGU7DQo+ID4gKw0KPiA+ICsJLyogYWN0
aXZhdGUgRklGTywgcmVzdHJpY3QgcmVnaXN0ZXIgYWNjZXNzICovDQo+ID4gKwlyZWcgfD0gIEZM
RVhDQU5fTUNSX0ZFTiB8IEZMRVhDQU5fTUNSX1NVUFY7DQo+ID4gIAlwcml2LT53cml0ZShyZWcs
ICZyZWdzLT5tY3IpOw0KPiANCj4gWW91IGFyZSBiYXNpY2FsbHkgd3JpdGluZyB0aGUgY29udGVu
dHMgb2YgdGhlIENUUkwgcmVnaXN0ZXIgaW50byB0aGUgbWNyIHJlZ2lzdGVyLA0KPiB0aGF0J3Mg
bm90IGdvb2QuDQoNCkhpIE1hcmMsIHRoYW5rcyBmb3IgeW91ciBjYXJlZnVsIHJldmlldywgaXQg
aXMgYSBtaXN0YWtlLCBJIHdpbGwgY29ycmVjdCBhbmQgcmUtc2VuZC4NCg0KQmVzdCBSZWdhcmRz
LA0KSm9ha2ltIFpoYW5nDQo+IE1hcmMNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAg
ICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgIHwNCj4gRW1iZWRkZWQg
TGludXggICAgICAgICAgICAgICAgICAgfCBodHRwczovL3d3dy5wZW5ndXRyb25peC5kZSAgfA0K
PiBWZXJ0cmV0dW5nIFdlc3QvRG9ydG11bmQgICAgICAgICB8IFBob25lOiArNDktMjMxLTI4MjYt
OTI0ICAgICB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiAgICs0
OS01MTIxLTIwNjkxNy01NTU1IHwNCg==
