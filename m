Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB22F4457F1
	for <lists+linux-can@lfdr.de>; Thu,  4 Nov 2021 18:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhKDRJk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 Nov 2021 13:09:40 -0400
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:1183
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232041AbhKDRJk (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 4 Nov 2021 13:09:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFAucN0eYOVzcLQRG5FuAJnIRzLJrv4BCCsBbRSwaHoWM4chV6e7+vPvQHWw73q3YBPlyemVg+9h5iWBn9Ltuj52kbemL+pzu3v4/rL49xKXHp+Dh5JmNFJkd0pylr2ouU+cuhKor3VqGjlVZ3uDL7JC+YWyC2lN+Zw79vKWpKpQRXX/t3LY4Z1tJw5Ihfc3WAPkfGe3IBXchHE0pFMGncna/eh/co0ZiRAAGJZTGkECiJDa4FWZLcyUJ0DmR+Yca1Trdm3if2y+px8zFyI8N/7v+q/rNuFE3Avabd8c06ls5N6V+zBYOvQBffAwd+ihwHgcovqcHe02CNKhusbVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M10f2QXuGrvJzQKBUhxAAh7tLkmNk7XXVLdsoib4zDQ=;
 b=b/jEVP3KOiQhRvgA0/hDeSkhF/zibXZWiibFciMv57e4hKPm7LUjT0yIWvyCxouiiSzTbMp9+oRXA1NruzI80SlP82ZHkGP68Qmz6jj3EhEk8wcKwlxdLuur1o+MprTqeieCXgqpBRhCMW5BY2SB5EjpPAzkRNbTK2727icn+aPp5r2ZckfXy+qSs65+rUZtcXApNfVOT4ZE7paF+W1c5PKVEvtvOOVild7SUofXdGOBWehz++3TDX6tAXv2YI8zBd5ijFQboKvtcHWd9tXzL/l4szJ57y8Wx2JLWUTF+EMcB6uY+QbEvcXZZ7ZTkgsq+vkl8G3VWRRM5d5MDY2N2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=peak-system.com; dmarc=pass action=none
 header.from=peak-system.com; dkim=pass header.d=peak-system.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itpeak.onmicrosoft.com; s=selector2-itpeak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M10f2QXuGrvJzQKBUhxAAh7tLkmNk7XXVLdsoib4zDQ=;
 b=E6egrC7PHjCcFZvF9xzzHtf63p6XqtRAKmpWo4VPJ8Ya09a6SLDVW/DHnMshIA8xP51w6nE+ObQOpDH/5E0WYtPt7Pj/v4FLXIze3DFTXjuuR1jrSbKOtcLGmAMCCnsZFm+Yr4h/MWglZ1X/UXZ9vYVLwVD4vD6YK6Bjn7J2w08=
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com (2603:10a6:102:f1::9)
 by PR3PR03MB6586.eurprd03.prod.outlook.com (2603:10a6:102:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 17:06:59 +0000
Received: from PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::8442:8aef:e942:f813]) by PA4PR03MB6797.eurprd03.prod.outlook.com
 ([fe80::8442:8aef:e942:f813%8]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 17:06:59 +0000
From:   =?utf-8?B?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: RE: [PATCH 1/2 v2] can: peak_usb: always ask for BERR reporting for
 PCAN-USB devices
Thread-Topic: [PATCH 1/2 v2] can: peak_usb: always ask for BERR reporting for
 PCAN-USB devices
Thread-Index: AQHX0ZhC8oAeiA/y1UuKZU0S9HlIAw==
Date:   Thu, 4 Nov 2021 17:06:59 +0000
Message-ID: <PA4PR03MB6797C3DDC084E6404B0BFBF6D68D9@PA4PR03MB6797.eurprd03.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: b3a46f3f-595c-d653-870d-0008b66068fa
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=peak-system.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 038aa60c-697f-4070-4083-08d99fb58386
x-ms-traffictypediagnostic: PR3PR03MB6586:
x-microsoft-antispam-prvs: <PR3PR03MB6586F420C8B08DF7AF028C04D68D9@PR3PR03MB6586.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P96qDdjw+aM8LxHkkJTSjG1VP72yi+l65gnZuiXLuQqYXAT8Xc3eff/VDp4gRBSwD9Be4mYjrjoXfDAzpoHKKliyrNrpsFsqiHoNPb0pbdKsvElmzoUETsST7d8OOz2eC4UsPHHpy1KUSH/+PzKZm1zJm6+d6NlUCqtflOCWnOqqtcM0mGVcAPiLfWRvZmyZILvV50Ncr32/FsTJ+vDSmkKOT78B3DOrkzBoYUzrPJysKsnhxXQdadeNgfDEaneyyDmPVvhFyZOcCoPRRWKBiWG21nsMnsBRacLdM2hR1oOJwKTEB3+5Ulqug/40pl/H6VJslbPzTHQKstdUmkThJe1Bbi9pVSjPiErZobwgO9cf/Xe7nJBVCOa3JbRyTSwAoVYmPvOOzOvlESVD9FA2TiJj5e3Xq/68vav61w8IcJ6iBh/RMwlaD+UWN1MigOg+9pxqZsW1Lm6Y2hkyWonDuo9DMV04NIhaPuAbsOAVwo+OuS0CVHSFLrpqPquJ71uw6xOJMQenqf9eMcGMYBFMs4igiSeudmrn0/OofPGp3Ae99wXV37ULaIizibo+VGyMFJ62xrG1guQWaQO5/TLGLPl1foQwlxqoHgkq8sYp7pVOk6luwftIKhszu5dp61ELR/9b207dX4rs7eMZ/YnreCl6pj3MpnmcbPAZ8Aq0a8Xf5vGuwOWEb7K+BFHcTM2QNWW7Kk5bIJ3ffp12MGoXOL4CWlJznVAKUOj0c4K0TIFAOtR49FwRvZuocJVWziIdgOssJ2u6+3a56OD6R9D3sYaCqYuoGfiuise1QyTYYR0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB6797.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39840400004)(366004)(396003)(346002)(122000001)(66574015)(38100700002)(33656002)(55016002)(15974865002)(4326008)(9686003)(2906002)(5660300002)(85202003)(76116006)(52536014)(66946007)(966005)(8676002)(38070700005)(83380400001)(26005)(186003)(53546011)(6506007)(66476007)(66556008)(66446008)(64756008)(6916009)(71200400001)(7696005)(316002)(86362001)(508600001)(8936002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDArY0hrbWo5TzVsRTNDWU05SnlwODFTcGhZVGdVVjgwL3pDV3p1U0xjV2h2?=
 =?utf-8?B?ODMxR2cxVUYwWk5seHN4a21SeWtUVEs3QlhpRFpZNmdEeExqbk11S0w0RGp1?=
 =?utf-8?B?RmpSTVB6MllGYVR5c1d4dGdVeHd2OHBNNFlYVW9PcHJtQ0FhdEJoTVNtZHlK?=
 =?utf-8?B?eW5OQllkcWVTV3RBdTA2VDllT1RuZFR3NUIrSW85RnEveE53eXBhT1hZWnR2?=
 =?utf-8?B?ZlZtV2RXNUdnWFJ2MW8vQlpBdzhWQS9YWXlxemQwNk4zOVVQL2pjY0FqejZ1?=
 =?utf-8?B?c3dRczBlVG9DdVZDSlpWOVdSS05kZWg4ZzRxV2M1dkZPeTJDbHFJMDg1RTMw?=
 =?utf-8?B?Z1ZKeVlqRnd4aFU3bVRXelY0R3B4ZmFzSnpzaFVPbkRMR1l3SU1WMmg4ZnBo?=
 =?utf-8?B?djVMdVhTMFRhQVh5ZHhHRzB6OHY3akhpa0tnYmJ2SEJjTllWaGpORzBReGx3?=
 =?utf-8?B?ZVBZNjdHVFBUOUlCck5TTE5vUVFnVVhsSm9MT200TG4zV09qK2RYSGQrbGlF?=
 =?utf-8?B?ZGZpQ21XK0o0K3VvZDB2U0RPT09HdWw2TVJadytDYkcrR2NnOWZoeERsZmVU?=
 =?utf-8?B?c0xET1E0VFBiSU1halJvaC9ndStVNWNrdU1pSGN2SFQ2VjJScVlaaFMrNFcv?=
 =?utf-8?B?cm1XYmk0MkdOc29uOThTQ1kzaFlKakx5b3R4TzBySzViWTA2WTM0SFpDajRY?=
 =?utf-8?B?Ry96Z2VOK3ovUlBOdjFja0ZQWnBvMVpnZE9jVjNoaUxxU0czZmUzb2x4WGNv?=
 =?utf-8?B?ZW5RVE5UME9jdDk1b2JGejFxaUdSY24vWW55b0dac0xPZTBzOWlpV3ZsMzZ0?=
 =?utf-8?B?b0hIVENTQk9WMUVGZzYwcTY2WGE0QUhoZEdNcmxiNm1WNXl1NG8vSFJGZ1Bh?=
 =?utf-8?B?TzJSZjJJWnR4U1B5dnVYaUJDNkZVVU5xU0QwZFZGa2xTMFlRMUZLd2ZoUXBk?=
 =?utf-8?B?cHBsRldia1ZuZm5pbFNsbko2V0JSZ3FxVmVRRVJ1dWIyU1hqYkJuSGdjZS9S?=
 =?utf-8?B?UkNHYlhJS1dla2w5ZmF4YmtwYlFSMGs0eXl1Z0ZvNU1Hb3FvdWxBdDc1VDZD?=
 =?utf-8?B?UXpEdGlDZys5UVFqekJFcm44SUMvYjRkSGMrSmdwcjJrRTFrdEhyaGlickdO?=
 =?utf-8?B?VTRpUGRWVkxHcVhwcjdNTDRja0wrMmlsa2c1Q1N6MXhsMXFvMHBFcUhwWk1j?=
 =?utf-8?B?UlBrcURTS1pzcjIwN29pdVF3b2lJZDltTEs4SktoRGhXeVdrUHdGanBtakpL?=
 =?utf-8?B?dUJ4R1RkL2ExM0wzN3djU0NCOVZSU3pRVHFOWS9qMTl2SnBLNE4zckc1NHlx?=
 =?utf-8?B?NXlSNDd1OXBQL0V4M09jMjhhbmYycXZLRzNOb3dZUC82cW4yUUpXSDhOSkVK?=
 =?utf-8?B?T2lGc24rZjB1MzhPRDQybWdnOEZJcHdrUXVsQmdhT2VNbm1PN1hYbGVrVW9x?=
 =?utf-8?B?OG9yeE1kcmJ5TjVwa0UrN004K3c1bWhvYlR5WnpKeHdCbDkzSFdHWWhpMlpF?=
 =?utf-8?B?S0ExQ0hLYlJxS0JGcDVOWmpQUTY3Zmk4UkRpd0RJT052R0ViVVZYdDlMejFs?=
 =?utf-8?B?ZEhrOWl5OFhIUTFNOStKQUU3OXB2SldKbTdMTzdUUFNNWTc1NVp2ajJEbFRp?=
 =?utf-8?B?UnZhOXpPeXNMSm1RK2FnTU5mamZVbUM5a0FyLzdXd2FwcEV1OE5MRVZrWmRN?=
 =?utf-8?B?Q0cxK0o1U1RHcmpzaElzQnV5TzgxLzFialVCSEJJZ2s0Qjc1Z0ErVklteU5I?=
 =?utf-8?B?YzF5Ym9nRXplRkpaYTVRWXZzS2FQT2RSUTRSRnVKeE8wQUlUTDh6cFBQZU10?=
 =?utf-8?B?QTJydit6VmZnQU4zR2UvRkpIVnRUZVNhMlBkMk5xQytjZHFBZTJleGdSYVdj?=
 =?utf-8?B?SnBKZDhNZGw2RnFiSDU5UTQ4T09oNUJPVUN4bzdqZ0N0KzNUaUxJcUJCaGc4?=
 =?utf-8?B?aFRoY1VaQjlhK3d4K3k1c2c1V3k1RVpoeHo3MDJkS01iemozSWI5a2dvTHd1?=
 =?utf-8?B?a0NYRTVwckR0TUVtNlFFUnVhcjdFWlp4YlZFL25iVFM3YXJOTUkvdFZMbmFF?=
 =?utf-8?B?ei90ZER0aVF3TnNldUhKeHRWRFFGRDBKbkhWQnhYejJUVmhmRGtDQ1pRN0kw?=
 =?utf-8?B?WnJMU3JJSDF2WHAxUjFqWjEwODdPWGJJTldrUHprcWhsM0x6ZCtoMldDa29n?=
 =?utf-8?B?M1V5QWxmVUlDbDRoY2doL3NCd0ROK0VyQTZjYkVEY1YyK2VTRGF6U3ZJV2dH?=
 =?utf-8?B?cTdKNXlKNERsQzh2ZlNHRjhGTzhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: peak-system.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6797.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038aa60c-697f-4070-4083-08d99fb58386
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 17:06:59.2732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e31dcbd8-3f8b-4c5c-8e73-a066692b30a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4OmZKNTPdEk+n5WaME+7RM4jw8lpYyu2d1k4eQ9+Pb/ZZEaDfEmESfCT4VxiZSJxEAysDrJQqkQjw1ld5JHseJErWTokwTP2E4h/YxYbZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6586
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

4oCLSGksDQoNCi0gdGhlIHJ4ZXJyL3R4ZXJyIGNvdW50ZXJzIHdlcmUgdXNlZCBmb3IgdGhlIGZp
cnN0IHRpbWUgdG8gZGV0ZXJtaW5lIHRoZSBuZXcgc3RhdGUgZnJvbTogaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1p
dC8/aWQ9YzExZGNlZTc1ODMwMjcwMmE4M2M2ZTg1ZTRjNGMzZDlhZjQyZDJiMw0KDQotIGJ1dCB0
aGVpciB2YWx1ZXMgY291bGQgYmUgcmVhZCBieSB0aGUgdXNlciBzcGFjZSBhY2NvcmRpbmcgdG8g
Y3RybF9tb2RlLCBzdGFydGluZyBmcm9tOiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD1lYThiMzNiZGU3
NmM4ZmNlZjM0N2I5YjljZjE1NjQ5ZmU0MWE1YTZlDQoNCldoaWNoIG9uZSBkbyB5b3UgdGhpbmsg
aXMgdGhlIG1vc3QgYXBwcm9wcmlhdGU/DQoNClJlZ2FyZHMsDQoNClN0ZXBoYW5lDQoNCg0KDQog
ICAgICAgICAgICBEZTogTWFyYyBLbGVpbmUtQnVkZGUNCkVudm95w6k6IFZlbmRyZWRpIDI5IG9j
dG9icmUgMjAyMSAxNDo1Mw0Kw4A6IFN0w6lwaGFuZSBHcm9zamVhbg0KQ2M6IGxpbnV4LWNhbiBN
YWlsaW5nIExpc3QNCk9iamV0OiBSZTogW1BBVENIIDEvMiB2Ml0gY2FuOiBwZWFrX3VzYjogYWx3
YXlzIGFzayBmb3IgQkVSUiByZXBvcnRpbmcgZm9yIFBDQU4tVVNCIGRldmljZXMNCg0KDQoNCg0K
T24gMjEuMTAuMjAyMSAxMDoxNTowNCwgU3RlcGhhbmUgR3Jvc2plYW4gd3JvdGU6DQoNCj4gU2lu
Y2UgZm9yIHRoZSBQQ0FOLVVTQiwgdGhlIG1hbmFnZW1lbnQgb2YgdGhlIHRyYW5zaXRpb24gdG8g
dGhlDQoNCj4gRVJST1JfV0FSTklORyBvciBFUlJPUl9QQVNTSVZFIHN0YXRlIGlzIGRvbmUgYWNj
b3JkaW5nIHRvIHRoZSBlcnJvcg0KDQo+IGNvdW50ZXJzLCB0aGVzZSBtdXN0IGJlIHJlcXVlc3Rl
ZCB1bmNvbmRpdGlvbmFsbHkuDQoNCj4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBTdGVwaGFuZSBHcm9z
amVhbiA8cy5ncm9zamVhbkBwZWFrLXN5c3RlbS5jb20+DQoNCg0KDQpUaGlzIGRlc2NyaXB0aW9u
IGluZGljYXRlcyB0aGUgcGF0Y2ggc2hvdWxkIGJlIGJhY2twb3J0ZWQsIGFzIGl0IGZpeGVzIGEN
Cg0KcHJvYmxlbS4gQ2FuIHlvdSBmaWd1cmUgb3V0IHdoaWNoIHBhdGNoIGFkZGVkIHRoZSBwcm9i
bGVtIGluIHRoZSBmaXJzdA0KDQpwbGFjZSwgc28gdGhhdCB3ZSBjYW4gYWRkIGEgRml4ZWQgdGFn
Pw0KDQoNCg0KcmVnYXJkcywNCg0KTWFyYw0KDQoNCg0KLS0NCg0KUGVuZ3V0cm9uaXggZS5LLiAg
ICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICAgfA0KDQpFbWJlZGRl
ZCBMaW51eCAgICAgICAgICAgICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlICB8
DQoNClZlcnRyZXR1bmcgV2VzdC9Eb3J0bXVuZCAgICAgICAgIHwgUGhvbmU6ICs0OS0yMzEtMjgy
Ni05MjQgICAgIHwNCg0KQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgfCBGYXg6ICAg
KzQ5LTUxMjEtMjA2OTE3LTU1NTUgfA0KDQoNCi0tDQpQRUFLLVN5c3RlbSBUZWNobmlrIEdtYkgN
ClNpdHogZGVyIEdlc2VsbHNjaGFmdCBEYXJtc3RhZHQgLSBIUkIgOTE4Mw0KR2VzY2hhZWZ0c2Z1
ZWhydW5nOiBBbGV4YW5kZXIgR2FjaCAvIFV3ZSBXaWxoZWxtDQpVbnNlcmUgRGF0ZW5zY2h1dHpl
cmtsYWVydW5nIG1pdCB3aWNodGlnZW4gSGlud2Vpc2VuDQp6dXIgQmVoYW5kbHVuZyBwZXJzb25l
bmJlem9nZW5lciBEYXRlbiBmaW5kZW4gU2llIHVudGVyDQp3d3cucGVhay1zeXN0ZW0uY29tL0Rh
dGVuc2NodXR6LjQ4My4wLmh0bWwNCg==
