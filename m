Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCA14923B7
	for <lists+linux-can@lfdr.de>; Tue, 18 Jan 2022 11:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiARKW4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jan 2022 05:22:56 -0500
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:19843
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229561AbiARKWz (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 18 Jan 2022 05:22:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mryXq1jxDnElhlugpmVRH95tCa4P3L2EOHQ1fh7iSFunf3FpcY/61VR+ao5Fd578OZ6LDCeuOD5fNNkzsOCnFBv1pflRR0aUUsAxvq+zDyMnmq6ePfqu7zH6xk0XfD10TMaK38d+VXvCmn5TaNzFHp18d2v58Hp51sQKwE+WyeXk8Q1LqUVJSyp9HhRL7LEccmdmvqu9YgB4xdU6wVan1naZfIG3Yk+JVfcT4AqCg1zsccmZhgutfJNURs6enfMc4mnnnq0BDWcXOnjdduY6xThioEPcagQ5QnWOTHM/i2hx9lrVet/Wje0v6b9SsOlvIqW1yKMwLAFQdhaPyC3TdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Db+lDknJJY2SA+ilCV3pOPFtT6ACuo/RrHRWmZK8zw=;
 b=hr3qWSaKXRVLbH18aGe67EYqlEoJIqzYgRFMKpz4eeTNJnF3wyaJl4+pMq7hBrenW5mC3OHDyp4vvznceWnaOUKUe5GAh4A8f390km4xM4L2LL1HWlH2njFw2ZzTgL3Ici5Z//tz2Rg40uZk0RLmLPKofgsDfp/wMzsMqvt3T9Q1CeTxdQGpaRMjhe0BaUznGmihl5S8FUrtWBd5jH36xFGUGpPvDCRLHsa98zWkFTojeR50lutGldj4gTau6uPpOVauH/wefOzJEV2iB4RrDer8k3gnruDbRs2V2DKaRrrdTtz+88iHRSce1KWOAGpVkSssH5aVUOarGmiDcD6OEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dpsolutions.se; dmarc=pass action=none
 header.from=dpsolutions.se; dkim=pass header.d=dpsolutions.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dpnorge.onmicrosoft.com; s=selector2-dpnorge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Db+lDknJJY2SA+ilCV3pOPFtT6ACuo/RrHRWmZK8zw=;
 b=hcLCZjL7ekRPci7hIRnZhzp+LKxwBSQGgwJUl3E7TjbjcEw1T4Wbq/xp64RJpEDryBRXxgo2BjwXuiIIgmIboWftme2ySM04ocpcleI5CM0zhhY/hnWzTlqH3uh3sOvfNFtNari2xyvonZICjVtr1h0u4ZJcfVlrI7f9uWPIKKg=
Received: from HE1PR04MB3100.eurprd04.prod.outlook.com (2603:10a6:7:21::21) by
 DB8PR04MB5721.eurprd04.prod.outlook.com (2603:10a6:10:aa::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Tue, 18 Jan 2022 10:22:53 +0000
Received: from HE1PR04MB3100.eurprd04.prod.outlook.com
 ([fe80::4949:5038:5888:d0ff]) by HE1PR04MB3100.eurprd04.prod.outlook.com
 ([fe80::4949:5038:5888:d0ff%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 10:22:52 +0000
From:   Markus Mirevik <markus.mirevik@dpsolutions.se>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Sv: MCP251xFD runs interrupt handler twice per message.
Thread-Topic: MCP251xFD runs interrupt handler twice per message.
Thread-Index: AdgJLvj3LYiHrdzWT92Iflx1OZxh8QAFQxoAAAAoddAAYTnugAAzWo6wAAO+JAAAAXHvwAACF5yAACgVrwAAABeG8A==
Date:   Tue, 18 Jan 2022 10:22:52 +0000
Message-ID: <HE1PR04MB3100C3E1AB46843977907849E6589@HE1PR04MB3100.eurprd04.prod.outlook.com>
References: <HE1PR04MB310066D557C9D77FE357D90AE6549@HE1PR04MB3100.eurprd04.prod.outlook.com>
 <87o84e1oj1.fsf@hardanger.blackshift.org>
 <HE1PR04MB3100B7CD240526C06FCA048EE6549@HE1PR04MB3100.eurprd04.prod.outlook.com>
 <20220116110941.6cqzm3skp57pnvth@pengutronix.de>
 <HE1PR04MB3100E5991C6FB420821F1F54E6579@HE1PR04MB3100.eurprd04.prod.outlook.com>
 <20220117132716.y5q3vuayjgqhwpro@pengutronix.de>
 <HE1PR04MB310040456777CCDE2DF03FEAE6579@HE1PR04MB3100.eurprd04.prod.outlook.com>
 <20220117150833.d4e4f4dhjvsvmxkt@pengutronix.de>
 <20220118101618.5xhgy7psrfjnjmpn@pengutronix.de>
In-Reply-To: <20220118101618.5xhgy7psrfjnjmpn@pengutronix.de>
Accept-Language: en-US
Content-Language: sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dpsolutions.se;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 661b1b85-a671-4f87-23fc-08d9da6c7c76
x-ms-traffictypediagnostic: DB8PR04MB5721:EE_
x-microsoft-antispam-prvs: <DB8PR04MB57218DE2D02A44835C689FB2E6589@DB8PR04MB5721.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qHZyVeZPStV1DJzUM32VaC7nsxNwJ38lKJutyKOazMHDUToRaz1IvehlawSY9evjKe/X9VwBZ2AaWQA+YRynH1OGD1e4B5W2SwkMSCvObJ0RXkh5lxuR4rkIbDnAEfmvkvvayO1YH2ffMCgoOaAI8GVV/gWO5H74S2ZNhihn1NFihfoeHiTT61JpUH/jGMjE9IyoGe9FXtznRM+s4jcHgKW/3nzgoXeNrAs53sL7x2P9Tbj/FgBGsXIWFcqVR3o2tWMm+HbTnkl8nDFphNp4m4i8lghqmOYIr1Koz6676/5oZb8+mzZvCyoy2OIMGC/avQ0Ba+qAQVOrIuQPm+QXyDYMgUG8KGtFme68OIPZr4CztJsvzmsoyxiI/CfYKeoxSHPtMiy+EtiLZBz7NMEr0XlZtSNWlmHYuMrnIzEE0UrriMWyDS2IYoIUPPgbtC+cRIszOI9TOYPmENV2satnKEIoAZNOllU8xmeSQoj4C2CQS6mc82F9tPxmMVYrDP0zeirnbE3+mC2Ae/7K+9UzqiY9tMWFXNoQOBnES7NujHfCpLQwLKcyNrtfi2MK7Ig6er/E0gtSY+HOMc/0digkt/ge4u4MYTyn1VWTxLn/F09yzbrorQ8mN1VF0NLyov4BF2Pmz60zKfFceelYlL+9ZoebygqqbzSrngc+FTMuWRnuZBQAM5RHXklaiO9bxY+Gw0BTy5FNAWDRglgS58xY8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3100.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39840400004)(376002)(136003)(366004)(44832011)(66476007)(66946007)(5660300002)(316002)(52536014)(8936002)(55016003)(6916009)(86362001)(4326008)(38100700002)(508600001)(53546011)(2906002)(6506007)(38070700005)(71200400001)(4744005)(122000001)(26005)(64756008)(7696005)(66446008)(186003)(8676002)(9686003)(76116006)(66556008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Kys1TEZQOGJzc0JnSDBsTVZQdXZTcGRFNHViNHhEYi9VK3loNEl3ek9QbWt1?=
 =?utf-8?B?ejM5WDI5dnpSeWk4Q1ZtdGNaaWNzSFhHV3ZjYnJyYlp2UkJWZGxBQWZoSG1V?=
 =?utf-8?B?aU05a1dRQlQ5emsxQjhaNE1Od2RsRDliVnFEYzdBSUROdHJMZXFrVms1ZC80?=
 =?utf-8?B?QkJJTGdsN05tb1UvMVF0aGYwVlZZSkdNWWV0N0lXS05ja01KVlhia3c4TURp?=
 =?utf-8?B?bXk4dFJsREVyOXQra1RHeDd6anEvWGNXajZoQUZEMEhYeDFRdnlEZndleExa?=
 =?utf-8?B?UDRsTmZLcGxyOGZuL1cyVmIxcDBxNGZKSXFjbG5UbHhIYlEzczNvbkptaXR4?=
 =?utf-8?B?NTNwYjQ4YkZBcFA4RlBYQWhRMWFNMllrRjlWZWhFUlYvcWxhaDRqREpnZDJB?=
 =?utf-8?B?bldYRHFISnVXZTZUQTUvMWQ4S2JzVGhFVTcyb0d2UjF3TCs5OUIvVEhSYTc5?=
 =?utf-8?B?VEJRRG1EcU5RMGZlaVNUMjNxOXJ2MWx6aUJ0alhiZVU0TUxxNXpqcDNMcTU5?=
 =?utf-8?B?UkdvQUM3Y0Q0OTZFM0VHMXRlMzFpckNhcFpsNVpjRVpHVWIxRXJIZThSaXp3?=
 =?utf-8?B?OUhrOGpYZGtmK2tZQkF6RjdpbWpFR1htbkhUb2dPMThNMGZubTRjZWxNVmpT?=
 =?utf-8?B?cDB0Zjl5UXdLNXluM1l2ZTlOdmd5MEN2TVV0NWE3VEU3aHJ1MVZYeDNoMUM5?=
 =?utf-8?B?K1IyT1VTUytOYUZKSlhyMVQ4WGVoeG1aVG5LcXJXRGRjWGtNVG5sUys4cHNX?=
 =?utf-8?B?L3Y2Y3JHOG1RYU9CRFhtQ1hRM05HYm90TkpCRTE4Y1F4Qk4wS2hSRDJNUzdz?=
 =?utf-8?B?a3dIZjFIUFhYTUZjM1o0dDV6M2I5emRjL3I1N3V3U28wZ0pQd0M4Mk1HMG1M?=
 =?utf-8?B?aEV4RnI5NjM4SkpoVlhJdXBlOFgrY2ZqMkNab0ttdXlhVnNQTzFSZzZDbUM5?=
 =?utf-8?B?TzNhL2ZhVlJNYjJDRVNhelZVaW5KQjBsd1lnT3A4OGtJS2hxQjh5aXZRYTU4?=
 =?utf-8?B?Yzh5eUdWUXZaZFcwaTZJNHFpb0FVTFNMMVE3bWJPVkFDdkErMG5TUFp6OVBH?=
 =?utf-8?B?bHFDbXBUMXBlcWhMMkFCWWgrcjRpSnEwQjBOcjd6QlFPK0VtREVBV1d3cFlp?=
 =?utf-8?B?dUZocEYzMVo0bmVseUwwcktUY1d5ajA3QjY1UUY0VytHb3pmajZNL2gvdFlx?=
 =?utf-8?B?Mk1ZTWk1dXpIR2YwaGpaZVBFOE51NUhLbjRVQnZjVm5vUGpUWVU2ZUZNQm1Z?=
 =?utf-8?B?bFFST2d1WVlxOW5RWktBUUI5Y05lYklkUEw5TEJaTzZsV010eVA0anZDNzBE?=
 =?utf-8?B?Q1FFQnBMRW85U2todUl5M0lWVHU5am8vUTJMSmJOUG9icXVLdTltU0VucEVS?=
 =?utf-8?B?aFJTbXlreTU1V3plTS9WdjVKa3pidVY0N3hhRHdGbFFvNW5rTXRSV2p3L2pp?=
 =?utf-8?B?Uy9mQkQ3Tzc5MnpUWHM3dGwrOHU3aTMrbFlXTHZDbzBiR0ltckhiWTdtd1J3?=
 =?utf-8?B?VVc0c29EZ3RyV2VTZ2pxaEpLM21HYk82VURXemRqMWhNUVo4VlZMeENCRUM0?=
 =?utf-8?B?UlRMS20xZDdNclZJRFBlNlRGaHVKcXlSZzltN05VejBLSWV0c25DN2ZLTUZR?=
 =?utf-8?B?VmVtOW9janZ4NUwzcmtGa2pIZ2ttKzZZYWxLSVZFbzJPMHRHbzFuaVBlbVRq?=
 =?utf-8?B?ck1Sa1lqcCtvZkNMSkZQQ3JvT2FFOVo0QW5MWnpTazBHalF0ZGxxUVZ0Q1N1?=
 =?utf-8?B?azdqTytkWFYzU00vcllwLzIrUklma0xuYmkxcEwxUUxDVHFkRGRVK3R0Wm9h?=
 =?utf-8?B?MXc1blBrWmZ1T0puZWRNVStUb2lZOVk5aUhnTHNYVkxsUVpVUnA4R1JJWk5S?=
 =?utf-8?B?NXNCaG9tNmxMVmxoQVVUQnVPNlBnOWs0dDRRUXBDZVF5dVhZUXdGTVJUUkFi?=
 =?utf-8?B?ZC9zUmFKRklnYXlyUTJ2RVFpcVFEeWZJdXdyRlMxSHpLVXdYWTNDNXhxVmIx?=
 =?utf-8?B?T1I3M2tLL21JNkdvcWFDUkN1czRCb2hHVGIwU2RWVWtoUURDL0htUXY0NnNB?=
 =?utf-8?B?SkJidUVhU1dCS1Rma0hZS2JGZkVsbkhmWXlmL3lSNmgra2pJK3RtVTdUc2E2?=
 =?utf-8?B?OERhdmpjSENoY2o0c3l0STlDekxRejBjSHRBWmhjVmFiWWlwQ0kvdklXWlcw?=
 =?utf-8?B?RFdoNHk4OHdVczlsOE9RY2QxSDBGdkFVS0s4R2ZJMW50WFJGaTlnZXlBVUoz?=
 =?utf-8?B?Z0krNVpkd0E4RjJCOWgyd1N1cDJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dpsolutions.se
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3100.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661b1b85-a671-4f87-23fc-08d9da6c7c76
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 10:22:52.7513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3a2c5ea5-12ca-4b9d-9883-156f72a0a4ae
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uUT/qi8n2JjddNzViftGXrHZSB7qcilkBwAO4CXEoVDFTyIRdTA44CQnbkdfGDUy3VWbyzjzv+7kLc8xSywCJwT2gi9vyXsj8A/UQvv8arw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5721
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBPbiAxNy4wMS4yMDIyIDE2OjA4OjMzLCBNYXJjIEtsZWluZS1CdWRkZSB3cm90ZToNCj4gPiBP
biAxNy4wMS4yMDIyIDE0OjUzOjQ2LCBNYXJrdXMgTWlyZXZpayB3cm90ZToNCj4gPiA+ID4gVGhh
dCBzY29wZSBwaWN0dXJlIGxvb2tzIGdvb2QhIENhbiB5b3UgaW5jbHVkZSBib3RoIHJ1bnMgb2Yg
dGhlDQo+ID4gPiA+IElSUSBoYW5kbGVyIGluIG9uZSBzY29wZSBwaWN0dXJlPyBJJ20gaW50ZXJl
c3RlZCBpZiB0aGVyZSBpcw0KPiA+ID4gPiBhY3Rpdml0eSBvciBhIGdsaWNoIG9uIElSUSBsaW5l
Lg0KPiA+ID4NCj4gPiA+IEJvdGggYXJlIGluY2x1ZGVkLiBUaGUgbGFzdCAobnVtYmVyIDcpIGlz
IHRoZSBvbmUgZXh0cmEgcmVhZGluZyBvZg0KPiA+ID4gdGhlIHJlZ2lzdGVyIT8NCj4gPg0KPiA+
IERvaCEgSW5kZWVkLCB5b3UnciByaWdodCwgbWlzc2VkIHRoYXQuDQo+IA0KPiBDYW4geW91IHRh
a2UgYSBzY29wZSBwaWN0dXJlIHdpdGggZmFsbGluZyBlZGdlIHRyaWdnZXJlZCBJUlE/DQoNClll
cywgYnV0IEkgZG9u4oCZdCBoYXZlIHRoZSBzY29wZSB0b2RheS4gR2V0IGJhY2sgdG8geW91IHdo
ZW4gSSBoYXZlIGl0Lg0KIA0KPiAoTm90ZSBmb3IgdGhlIG91dCBvZiBjb250ZXh0IHJlYWRlcjog
X0Fsd2F5c18gdXNlIGxldmVsIHRyaWdnZXJlZCBJUlFzICB3aXRoDQo+IHRoZSBtY3AyNTF4ZmQg
aW4gcHJvZHVjdGlvbiB1c2UuKQ0KDQoNClJlZ2FyZHMNCk1hcmt1cw0KDQo=
