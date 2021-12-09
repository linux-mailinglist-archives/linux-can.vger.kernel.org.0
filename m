Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706E246F754
	for <lists+linux-can@lfdr.de>; Fri, 10 Dec 2021 00:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhLIXZ1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 Dec 2021 18:25:27 -0500
Received: from mail-vi1eur05on2112.outbound.protection.outlook.com ([40.107.21.112]:48025
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229760AbhLIXZ1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 9 Dec 2021 18:25:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkayRHzh2ZhKBL9IyeNznNzm7H/hLfouj+3vqXgwYicqDwDJOhFS5I0qqHGS3ZiwriB2giKWAQ4epfooc3M8xqi97uhlVPwgJleDMBAJEnAkpNzrsqtjrQ5CjwAYwevo4RGXzo+WONUyNwroHV621yRQ+MNHWo+bUx9FkyL2lzNS0BuI9bup/NyICW/cdQa3mxBHl1zL9/FfbN5pKvkqQs/5vGsnvVI3b8ghIZw02obiegRXDvsHQCK5okFw3Hf2frFsEYSCeOODwLSHWDXWQdXydF9AJhZVV6QkwhbmD4jdIO3AcBIPP+iFjwAW5VRZDchmnagHNQ+JWbQpRmEmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVL2pHYnQ5v2sC/KD44/r1a6Akc5Do8XVOW4FvC8oM4=;
 b=dEAZB0c90T7VtFmJwFZ35NcEzUQw+bLM/cc+DCOuiafN4md5FAgolCxztIpaHsGUUOhHuu0JNZdXcolOvbPhgLzKKPPB7+ZG/bQ1UYwz/OJJbJu4az8YIjQQx/n3X1xo3N9NqPiwadxDj+PCm4szks34lqDD6+JEkfW/aOPhB5ewVQbsppNtWwMJpL/9GPB/l5FQE36U0G2HlDMGW5aW8ZetXfJQ6rjzH73A4GlrWHDpbOkrRXaxYOhCd6wVmoNwMD00CVuQWsvSdSNztaR2Xn2keBUNJPVRulBGySRNqUYTUF5lBkV6bggX39pKsWZ4D/IMiDeLjeD2EPJ5bQhWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVL2pHYnQ5v2sC/KD44/r1a6Akc5Do8XVOW4FvC8oM4=;
 b=N7v4yjNDCx3/VJXhbd/M9gWjiwDxviq5vowrf9Utvm6nugjWoYprZjRSPKthvcAUo0IQsa8uOucTTtQtHTI/msEEcv9ywnrtP5Je/QDnUNEcxSFtmECla9sSBDUD8//j9NQKbbVM6+IEr3EbWvQJKbfb2XXlqu3NBn/UGOjdlGA=
Received: from AM6PR03MB4296.eurprd03.prod.outlook.com (2603:10a6:20b:3::16)
 by AS8PR03MB6758.eurprd03.prod.outlook.com (2603:10a6:20b:23e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 23:21:49 +0000
Received: from AM6PR03MB4296.eurprd03.prod.outlook.com
 ([fe80::6cf6:10d0:3050:4cf2]) by AM6PR03MB4296.eurprd03.prod.outlook.com
 ([fe80::6cf6:10d0:3050:4cf2%4]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 23:21:49 +0000
From:   =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <Stefan.Maetje@esd.eu>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
        "extja@kvaser.com" <extja@kvaser.com>
Subject: Re: [PATCH v5 0/5] fix statistics and payload issues for error
Thread-Topic: [PATCH v5 0/5] fix statistics and payload issues for error
Thread-Index: AQHX62Q5yTpa5Igu10+tyASzAIdx16wq0EsA
Date:   Thu, 9 Dec 2021 23:21:49 +0000
Message-ID: <5c68ff433c708f517e841885314ecd90b263e888.camel@esd.eu>
References: <20211207121531.42941-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20211207121531.42941-1-mailhol.vincent@wanadoo.fr>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 715c4123-c861-484c-1d55-08d9bb6aad46
x-ms-traffictypediagnostic: AS8PR03MB6758:EE_
x-microsoft-antispam-prvs: <AS8PR03MB6758627D9DF89EDBD748E46581709@AS8PR03MB6758.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h8q990RWILuJsPGT+MEKEBno1HnMGMsnv+oQscwtWlDsVwtflpCvvWu13xRZySl6uVhbrb8wta3maIrSlbsoyZqcegDIr/FGbyCfKRWbZNaqkvbeTX2NEzKkUgcVDzR6MmshC/GEgmLJMZBZT0pmGqMwIAjk8ZlEnpPriAx5zyS5sOGvYDf79SigQBK7vtJ/KTlpbaXR09D4WcSFlcFr6X9jdl22kmvZpDMRCeLuGaY85YW2xOWvBmoV+CZLCfLY3YpjF0LhKPYMaXcWjWjpeNYcqqAR5gRoLDL35GjJ/wrTpisW1Qw2U/KuBcZQ/1B6rxTut9pjFqHUoQDCzIxFMlT5p+8FkrMROvf0JrS9JrMFeHzxMYHVVCFhAqEXwM9vIodlDF7Tb2E3KAa2qzQacYyd06gEjFbzJ/jua3VVl6NQockpm6MxhgmwrKtd5xa3SI9+YwGmTY7G52E/8tfgKlN58lYNPdAl622QuSUpoR4AAcY7LLqG4D8DiOrSeUdfoQCdcrxNd96mEpSb0B7DmOPAQ1DLehL3yDtna2RuTVazCjZa8EzuSL+dwtjmYvtqTyZxzoCcnsVMD9NsaemdiTrqvux0BbpwDwIrPYFK1emN9/WBDrlVutH1to5mVmdOR2AP9Czl3EHnfa7L5BGTML6emzqxJnz1/q0698TKlkuH68TW7jEgDB6o2zhZfP7YKEtPa6QNPIM5FOELEKY2r6UfE/f8Dhf6T2RdkgMRs/9xsUj5id/pcj6TMes6o6z5lDjT6RaC7jVCfthzqtlcljYjrR+MdfkN9IyCxmZ1cm8nka5c9E+0PpIXvIJjLnIe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB4296.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(136003)(396003)(366004)(376002)(86362001)(85182001)(26005)(6486002)(38070700005)(2616005)(66446008)(64756008)(66556008)(8676002)(66476007)(38100700002)(8936002)(122000001)(5660300002)(316002)(508600001)(83380400001)(186003)(66946007)(71200400001)(76116006)(2906002)(6506007)(85202003)(36756003)(6512007)(966005)(54906003)(110136005)(66574015)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzR6dmdsQU1WVWVxZDJHMzR5QWFTNWF3eGtiN2NIelQzZHhpQWQ0Z2xkVFJu?=
 =?utf-8?B?T3ZReTUzZzZmK1laMDIwOVdMVnZHVDJjelN5YWEwaitENHFjQWJQYk9SaXJp?=
 =?utf-8?B?V3JzblBwM1V6TytsUmh2bEw0dnNtOGFrcUhPdnJLdnVFcXViZWd2MTRwQ000?=
 =?utf-8?B?Nytvbk5tSS9wZkp2Y2EyMyszQ2V4TzVpUW1pSHRuTmhzbXFycEdUOWRhanZm?=
 =?utf-8?B?c2FOOUkveDFiSk9MTWxYSzhvRFRLV1dQNmJXcWRSYVBOdGszTWFnbDF4OU9s?=
 =?utf-8?B?TGNaWWdDUXFFVGY5OXU1eTA5Vm1oa0JwSjVSekNVTVlZcUVLMlQ5VlVuVTl0?=
 =?utf-8?B?Z2lZN0VOLy9HdkpWVlU2RXdBQ2ZhMzRpWDRSUkNJWkd4UUFpMi8zWjA3Q1VW?=
 =?utf-8?B?cTJ2dnp3SjlZdVlBbHd4amhIUzBHeG1VNTIzVHVSTjFDbFc0cXB6KzNJc3N4?=
 =?utf-8?B?WWRXZm5lUmlvOFVudTBOMDdFRm02YUFkc0pjN2FmTVE3UXpJN3QxcDU3SlYx?=
 =?utf-8?B?UEwyaFR5Q2ppTVNPQXJGanNsNWlLaW15MTBPVU90b1lTOE00NzRjTnpmemRB?=
 =?utf-8?B?RXV1ZFdFZGJROThMMTJFOXhHOE43SFZwN3ppSzR4MGRFdGxvZkRYUGNsakpi?=
 =?utf-8?B?TlVtTVp4TjZMOHByQjhJMStyakt5dEEzUUJaVGxSVGJlT1B3RGRlWi83aVNj?=
 =?utf-8?B?UVpoK09SL1NGdTNCNThWMHQ5SWVkU25RSGdJK1pFSG13b3Rob2VQSGRzQUZ1?=
 =?utf-8?B?aXc4UG5JVjFNc2tJZi9yUnF1bFFpc2h1WFV5bUJDM1RJdGkzaU0wdmtBSlFS?=
 =?utf-8?B?V3lBU0orWEhTRkE2ZGVTU1V0WHY2YTlQNmlLNTBiQTVuTkNMRFZvYWVZdTFL?=
 =?utf-8?B?dFNzaC8xNWlnK210SFpFbVBxQU9WYUZtSkgxVEhDSVQ3djQralhqWGQwVTcy?=
 =?utf-8?B?Z3B2cHVoYkZvdEdnZ3ZXeWYwMEk3bWhLU2hIYml1UVp0WkpyTjNBc29nVVN0?=
 =?utf-8?B?ZWMzNndXeG9BbGhqaUo4YWZ2TFBqVFdUUG4vRG02UXpYZDZFUDlJSGJHcFpw?=
 =?utf-8?B?MzVaQnNjNHhSK0JJMzBXbnFsR1NqZjRyTDh6endvdGw5R2lLRmJXU3ZJbGtB?=
 =?utf-8?B?Sk5Sb0VWbGQyYm5jMi9uMjFWRVM4TzBWWWl3UXovWm1VeEZ3SUNHbDA2MWRG?=
 =?utf-8?B?bUJHNGhPOEY3YWVxYVo1N0ZENjd2UDhSZDJLRGV4UTVOR0w1d3ErbHNPRjVY?=
 =?utf-8?B?SUYxUkNtcWFmMWJ0bHd2RHJIV2tpeGZxc04xTVE3bHMySWkyOWZoUkZkYm5O?=
 =?utf-8?B?TFVSRi9zaW81Q3JSVUQ0NFdwRlFrZDd2dFhTMTZUdTk3aVBlNTJrcklVRDBM?=
 =?utf-8?B?L1FlK1BuSzBNMm9iUmtCWTFKM2hRTGFFdUhIejF6QnpPUCsxaEZvdldGeGNR?=
 =?utf-8?B?aVd0cXZqNnN1eFJ5UVlWY1B5cStsdUxXWDNvRThkNytROFFidVZ5RmpjY0Zr?=
 =?utf-8?B?eEVETEk3L3JIa3RUZTczNWxQOWNwVEIxVDkzT2NucUxiQ3JMekFmeHQ4dnJv?=
 =?utf-8?B?b3BWdXVXa25adzFVUlV3YlVIV2tQZVNsZCtBZ2xTT2M4WWgxSlNPSEVXeXBR?=
 =?utf-8?B?MWFzK2JZanVuL3hpelIzY1dqdWxlVDhFb3hxRERQazQ2Qm1mQUVhclNhVk1E?=
 =?utf-8?B?Q0dRNEQ4V1orZVpZL3RTQ29pdGVTWnM2bE1EN25lb1NWTlRMcmpGS1l2d0U0?=
 =?utf-8?B?LzRySVJXU2dPWmtTaHBtM0RqSmFqMHBnWjdSM0V2UEpCdXVQSzZuRTllNG9J?=
 =?utf-8?B?UnFCcG84YnBDRmZjMDBtaHlvajNpaVdVZVpxN2txYnUxak9ZTW12V0ZaWW9G?=
 =?utf-8?B?RldRcFpuRXQwKzBIZ0czaGt0OUdMcGtsZXNlcFNMWUhSUEhBSSsvZlhERFR6?=
 =?utf-8?B?RXZqdy8vdHhva0dBZ1dNbXhFYlYvditJTHBtY0dBV21xMzB2ZWZiZnExMkx6?=
 =?utf-8?B?UjVLSFBBMTJFc2x6ckNqQjQyYmpiMzhjNWF3TEV5cEs1cE1pYjZrSUE1Mndv?=
 =?utf-8?B?QVNZR2dqNzBISkc0VzZ5T3E4bDhlQk1idnpuZGFBd3VBeVY3SDc1NldPdXlz?=
 =?utf-8?B?NmZteDkwZDNONVI4T0YyZVZrcEZoRDA4S0YvV2FqTVgwcWkyOXlNRk1DbWFF?=
 =?utf-8?Q?Ky7L5Sj90rgEZuZtZ25y+zY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0CF550105E0754FB46CB5D4A76DFE00@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB4296.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715c4123-c861-484c-1d55-08d9bb6aad46
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 23:21:49.6054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsHAcJH81Sg6fvzmCCnxuNIwBeTfI4ff98cjyf98yPfVlpBYq+QhZ+PHN0h/odfaL0aOuStrEANOktTYt83Grw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6758
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGVsbG8gVmluY2VudCwNCg0KSSBub3cgaGFkIHNvbWUgdGltZSB0byB0ZXN0IHRoZSBwYXRjaGVz
IFsxLzVdLCBbNC81XSBhbmQgWzUvNV0gZm9yIGVzZF91c2IyLmMgDQphbmQgdGhleSB3b3JrIGFz
IGV4cGVjdGVkLiBZb3UgbWF5IGFkZA0KDQpGb3IgZXNkX3VzYjIuYw0KQWNrZWQtYnk6IFN0ZWZh
biBNw6R0amUgPHN0ZWZhbi5tYWV0amVAZXNkLmV1Pg0KVGVzdGVkLWJ5OiBTdGVmYW4gTcOkdGpl
IDxzdGVmYW4ubWFldGplQGVzZC5ldT4NCg0KVGhhbmtzIGZvciB0aGUgd29yayBjaGFuZ2luZyBh
bGwgdGhlIGRyaXZlcnMuDQoNCkJlc3QgcmVnYXJkcywNCiAgICBTdGVmYW4gTcOkdGplDQoNCg0K
QW0gRGllbnN0YWcsIGRlbiAwNy4xMi4yMDIxLCAyMToxNSArMDkwMCBzY2hyaWViIFZpbmNlbnQg
TWFpbGhvbDoNCj4gSW1wb3J0YW50OiB0aGlzIHBhdGNoIHNlcmllcyBkZXBlbmRzIG9uIGJlbG93
IHBhdGNoOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1jYW4vMjAyMTExMjMxMTE2
NTQuNjIxNjEwLTEtbWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnIvVC8jdQ0KPiANCj4gVGhlcmUg
YXJlIHNvbWUgY29tbW9uIGVycm9ycyB3aGljaCBhcmUgbWFkZSB3aGVuIHVwZGF0aW5nIHRoZSBu
ZXR3b3JrDQo+IHN0YXRpc3RpY3Mgb3IgcHJvY2Vzc2luZyB0aGUgQ0FOIHBheWxvYWQ6DQo+IA0K
PiAgIDEuIEluY3JlbWVudGluZyB0aGUgIm5vcm1hbCIgc3RhdHMgd2hlbiBnZW5lcmF0aW5nIG9y
IHNlbmRpbmcgYSBDQU4NCj4gICBlcnJvciBtZXNzYWdlIGZyYW1lLiBFcnJvciBtZXNzYWdlIGZy
YW1lcyBhcmUgYW4gYWJzdHJhY3Rpb24gb2YNCj4gICBTb2NrZXQgQ0FOIGFuZCBkbyBub3QgZXhp
c3Qgb24gdGhlIHdpcmUuIFRoZSBmaXJzdCBwYXRjaCBvZiB0aGlzDQo+ICAgc2VyaWVzIGZpeGVz
IHRoZSBSWCBzdGF0cyBmb3IgMjIgZGlmZmVyZW50IGRyaXZlcnMsIHRoZSBzZWNvbmQgb25lDQo+
ICAgZml4ZXMgdGhlIFRYIHN0YXN0cyBmb3IgdGhlIGt2YXNlciBkcml2ZXIgKE4uQi4gb25seSB0
aGlzIGRyaXZlciBpcw0KPiAgIGNhcGFibGUgb2Ygc2VuZGluZyBlcnJvciBvbiB0aGUgYnVzKS4N
Cj4gDQo+ICAgMi4gQ29weWluZyB0aGUgcGF5bG9hZCBvZiBSVFIgZnJhbWVzOiBSVFIgZnJhbWVz
IGhhdmUgbm8gcGF5bG9hZCBhbmQNCj4gICB0aGUgZGF0YSBidWZmZXIgb25seSBjb250YWlucyBn
YXJiYWdlLiBUaGUgRExDL2xlbmd0aCBzaG91bGQgbm90IGJlDQo+ICAgdXNlZCB0byBkbyBhIG1l
bW9yeSBjb3B5LiBUaGUgdGhpcmQgcGF0Y2ggb2YgdGhpcyBzZXJpZXMgYWRkcmVzcw0KPiAgIHRo
aXMgaXNzdWUgZm9yIDMgZGlmZmVyZW50IGRyaXZlcnMuDQo+IA0KPiAgIDMuIENvdW50aW5nIHRo
ZSBsZW5ndGggb2YgdGhlIFJlbW90ZSBUcmFuc21pc3Npb24gRnJhbWVzIChSVFIpLiBUaGUNCj4g
ICBsZW5ndGggb2YgYW4gUlRSIGZyYW1lIGlzIHRoZSBsZW5ndGggb2YgdGhlIHJlcXVlc3RlZCBm
cmFtZSBub3QgdGhlDQo+ICAgYWN0dWFsIHBheWxvYWQuIEluIHJlYWxpdHkgdGhlIHBheWxvYWQg
b2YgYW4gUlRSIGZyYW1lIGlzIGFsd2F5cyAwDQo+ICAgYnl0ZXMgbG9uZy4gVGhlIGZvdXJ0aCBw
YXRjaCBvZiB0aGlzIHNlcmllcyBmaXhlcyB0aGUgUlggc3RhdHMgZm9yDQo+ICAgMjcgZGlmZmVy
ZW50IGRyaXZlcnMgYW5kIHRoZSBmaWZ0aCBvbmUgZml4ZXMgdGhlIFRYIHN0YXRzIGZvciAyNQ0K
PiAgIGRpZmZlcmVudCBvbmVzLg0KPiANCj4gDQo+ICogQ2hhbmdlbG9nICoNCj4gDQo+IHY0IC0+
IHY1Og0KPiANCj4gICAqIGF0OTFfY2FuOiBuZXRkZXZfdHhfdCBhdDkxX3N0YXJ0X3htaXQ6IHJl
cGxhY2UNCj4gICAgIHwgZGV2LT5zdGF0cy50eF9ieXRlcyA9IC4uLg0KPiAgICAgYnkNCj4gICAg
IHwgZGV2LT5zdGF0cy50eF9ieXRlcyArPSAuLi4NCj4gDQo+IHYzIC0+IHY0Og0KPiANCj4gICAq
IHBhdGNoIDIvNToga3Zhc2VyOiBpbmNsdWRlIHRoZSBzdWdnZXN0aW9uIGZyb20gSmltbXkgQXNz
YXJzc29uIHNvDQo+ICAgICB0aGF0IHdlIGRvbid0IG5lZWQgdG8gZ2V0IHRoZSBvcmlnaW5hbCBD
QU4gZnJhbWUgYW55bW9yZSB0bw0KPiAgICAgZGV0ZXJtaW5lIHdoZXRoZXIgb3Igbm90IGl0IHdh
cyBhbiBlcnJvciBmcmFtZS4gcGF0Y2ggNS81IGlzDQo+ICAgICByZWJhc2VkIGFjY29yZGluZ2x5
Lg0KPiANCj4gICAqIHBhdGNoIDUvNToga3Zhc2VyOiBrdmFzZXJfdXNiX2h5ZHJhX2ZyYW1lX3Rv
X2NtZF9zdGQ6IHJlbW92ZQ0KPiAgICAgdW5yZWxhdGVkIGNoYW5nZS4NCj4gDQo+ICAgKiBwYXRj
aCA1LzU6IHNsY2FuOiBiZXR0ZXIgZmFjdG9yaXplIGNvZGUgZm9yIHRoZSB0eCBSVFIgZnJhbWVz
DQo+ICAgICAocmVvcmRlciB0aGUgbGluZSBpbnN0ZWFkIG9mIGFkZGluZyBhIG5ldyAiaWYiIGJy
YW5jaCkuDQo+IA0KPiANCj4gdjIgLT4gdjM6DQo+IA0KPiAgICogRml4IGFuIGlzc3VlIGluIHRo
ZSBmb3VydGggcGF0Y2ggKCJkbyBub3QgaW5jcmVhc2UgcnhfYnl0ZXMNCj4gICAgIHN0YXRpc3Rp
Y3MgZm9yIFJUUiBmcmFtZXMiKS4gSW4gdWNhbl9yeF9jYW5fbXNnKCkgb2YgdGhlIHVjYW4NCj4g
ICAgIGRyaXZlciwgdGhlIGNoYW5nZXMgaW4gdjIgbWFkZSBubyBzZW5zZS4gUmV2ZXJ0ZWQgaXQg
dG8gdjEuDQo+IA0KPiANCj4gdjEgLT4gdjI6DQo+IA0KPiAgICogY2FuX3J4X29mZmxvYWRfbmFw
aV9wb2xsOiB2MSB1c2VkIENBTl9FUlJfTUFTSyBpbnN0ZWFkIG9mDQo+ICAgICBDQU5fRVJSX0ZM
QUcuIEZpeGVkIHRoZSBpc3N1ZS4NCj4gDQo+ICAgKiB1c2UgY29ycmVjdCB2b2NhYnVsYXJ5LiBU
aGUgY29ycmVjdCB0ZXJtIHRvIGRlc2lnbmF0ZSB0aGUgU29ja2V0DQo+ICAgICBDQU4gc3BlY2lm
aWMgZXJyb3Igc2tiIGlzICJlcnJvciBtZXNzYWdlIGZyYW1lcyIgbm90ICJlcnJvcg0KPiAgICAg
ZnJhbWVzIi4gImVycm9yIGZyYW1lcyIgaXMgdXNlZCBpbiB0aGUgc3RhbmRhcmQgYW5kIGhhcyBh
DQo+ICAgICBkaWZmZXJlbnQgbWVhbmluZy4NCj4gDQo+ICAgKiBiZXR0ZXIgZmFjdG9yaXplIGNv
ZGUgZm9yIHRoZSByeCBSVFIgZnJhbWVzLiBNb3N0IG9mIHRoZSBkcml2ZXJzDQo+ICAgICBhbHJl
YWR5IGhhdmUgYSBzd2l0Y2ggdG8gY2hlY2sgaWYgdGhlIGZyYW1lIGlzIGEgUlRSLiBNb3ZlZCB0
aGUNCj4gICAgIGluc3RydWN0aW9uIHRvIGluY3JlYXNlIG5ldF9kZXZpY2Vfc3RhdHM6cnhfYnl0
ZXMgaW5zaWRlIHRoZSBlbHNlDQo+ICAgICBicmFuY2ggb2YgdGhvc2Ugc3dpdGNoZXMgd2hlbmV2
ZXIgcG9zc2libGUgKGZvciBzb21lIGRyaXZlcnMgd2l0aA0KPiAgICAgc29tZSBjb21wbGV4IGxv
Z2ljLCBwdXR0aW5nIGFuZCBhZGRpdGlvbmFsIFJUUiBjaGVjayB3YXMgZWFzaWVyKS4NCj4gDQo+
ICAgKiBhZGQgYSBwYXRjaCB3aGljaCBwcmV2ZW50IGRyaXZlcnMgdG8gY29weSB0aGUgcGF5bG9h
ZCBvZiBSVFINCj4gICAgIGZyYW1lcy4NCj4gDQo+ICAgKiBhZGQgYSBwYXRjaCB0byBjb3ZlciB0
aGUgdHggUlRSIGZyYW1lcyAodGhlIGZpZnRoIHBhdGNoIG9mDQo+ICAgICB2MikuIFRoZSB0eCBS
VFIgZnJhbWVzIGlzc3VlIHdhcyBzdXBwb3NlZGx5IGNvdmVyZWQgYnkgdGhlDQo+ICAgICBjYW5f
Z2V0X2VjaG9fc2tiKCkgZnVuY3Rpb24gd2hpY2ggcmV0dXJucyB0aGUgY29ycmVjdCBsZW5ndGgg
Zm9yDQo+ICAgICBkcml2ZXJzIHRvIGluY3JlYXNlIHRoZWlyIHN0YXRzLiBIb3dldmVyLCB0aGUg
cmVhbGl0eSBpcyB0aGF0IG1vc3QNCj4gICAgIG9mIHRoZSBkcml2ZXJzIGRvIG5vdCBjaGVjayB0
aGlzIHZhbHVlIGFuZCBpbnN0ZWFkIHVzZSBhIGxvY2FsDQo+ICAgICBjb3B5IG9mIHRoZSBsZW5n
dGgvZGxjLg0KPiANCj4gVmluY2VudCBNYWlsaG9sICg1KToNCj4gICBjYW46IGRvIG5vdCBpbmNy
ZWFzZSByeCBzdGF0aXN0aWNzIHdoZW4gZ2VuZXJhdGluZyBhIENBTiByeCBlcnJvcg0KPiAgICAg
bWVzc2FnZSBmcmFtZQ0KPiAgIGNhbjoga3Zhc2VyX3VzYjogZG8gbm90IGluY3JlYXNlIHR4IHN0
YXRpc3RpY3Mgd2hlbiBzZW5kaW5nIGVycm9yDQo+ICAgICBtZXNzYWdlIGZyYW1lcw0KPiAgIGNh
bjogZG8gbm90IGNvcHkgdGhlIHBheWxvYWQgb2YgUlRSIGZyYW1lcw0KPiAgIGNhbjogZG8gbm90
IGluY3JlYXNlIHJ4X2J5dGVzIHN0YXRpc3RpY3MgZm9yIFJUUiBmcmFtZXMNCj4gICBjYW46IGRv
IG5vdCBpbmNyZWFzZSB0eF9ieXRlcyBzdGF0aXN0aWNzIGZvciBSVFIgZnJhbWVzDQo+IA0KPiAg
ZHJpdmVycy9uZXQvY2FuL2F0OTFfY2FuLmMgICAgICAgICAgICAgICAgICAgIHwgMTggKystLS0N
Cj4gIGRyaXZlcnMvbmV0L2Nhbi9jX2Nhbi9jX2Nhbi5oICAgICAgICAgICAgICAgICB8ICAxIC0N
Cj4gIGRyaXZlcnMvbmV0L2Nhbi9jX2Nhbi9jX2Nhbl9tYWluLmMgICAgICAgICAgICB8IDE2ICsr
LS0tDQo+ICBkcml2ZXJzL25ldC9jYW4vY2M3NzAvY2M3NzAuYyAgICAgICAgICAgICAgICAgfCAx
NiArKy0tLQ0KPiAgZHJpdmVycy9uZXQvY2FuL2Rldi9kZXYuYyAgICAgICAgICAgICAgICAgICAg
IHwgIDQgLS0NCj4gIGRyaXZlcnMvbmV0L2Nhbi9kZXYvcngtb2ZmbG9hZC5jICAgICAgICAgICAg
ICB8ICA3ICstDQo+ICBkcml2ZXJzL25ldC9jYW4vZ3JjYW4uYyAgICAgICAgICAgICAgICAgICAg
ICAgfCAgNiArLQ0KPiAgZHJpdmVycy9uZXQvY2FuL2lmaV9jYW5mZC9pZmlfY2FuZmQuYyAgICAg
ICAgIHwgMTEgKy0tDQo+ICBkcml2ZXJzL25ldC9jYW4vamFuei1pY2FuMy5jICAgICAgICAgICAg
ICAgICAgfCAgNiArLQ0KPiAgZHJpdmVycy9uZXQvY2FuL2t2YXNlcl9wY2llZmQuYyAgICAgICAg
ICAgICAgIHwgMTYgKystLS0NCj4gIGRyaXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jICAgICAg
ICAgICAgICAgICB8IDEzICstLS0NCj4gIGRyaXZlcnMvbmV0L2Nhbi9tc2Nhbi9tc2Nhbi5jICAg
ICAgICAgICAgICAgICB8IDE0ICsrLS0NCj4gIGRyaXZlcnMvbmV0L2Nhbi9wY2hfY2FuLmMgICAg
ICAgICAgICAgICAgICAgICB8IDMzICsrKystLS0tLQ0KPiAgZHJpdmVycy9uZXQvY2FuL3BlYWtf
Y2FuZmQvcGVha19jYW5mZC5jICAgICAgIHwgMTQgKystLQ0KPiAgZHJpdmVycy9uZXQvY2FuL3Jj
YXIvcmNhcl9jYW4uYyAgICAgICAgICAgICAgIHwgMjIgKysrLS0tDQo+ICBkcml2ZXJzL25ldC9j
YW4vcmNhci9yY2FyX2NhbmZkLmMgICAgICAgICAgICAgfCAxMyArLS0tDQo+ICBkcml2ZXJzL25l
dC9jYW4vc2phMTAwMC9zamExMDAwLmMgICAgICAgICAgICAgfCAxMSArKy0NCj4gIGRyaXZlcnMv
bmV0L2Nhbi9zbGNhbi5jICAgICAgICAgICAgICAgICAgICAgICB8ICA3ICstDQo+ICBkcml2ZXJz
L25ldC9jYW4vc29mdGluZy9zb2Z0aW5nX21haW4uYyAgICAgICAgfCAgOCArLS0NCj4gIGRyaXZl
cnMvbmV0L2Nhbi9zcGkvaGkzMTF4LmMgICAgICAgICAgICAgICAgICB8IDMxICsrKystLS0tDQo+
ICBkcml2ZXJzL25ldC9jYW4vc3BpL21jcDI1MXguYyAgICAgICAgICAgICAgICAgfCAzMSArKysr
LS0tLQ0KPiAgZHJpdmVycy9uZXQvY2FuL3N1bjRpX2Nhbi5jICAgICAgICAgICAgICAgICAgIHwg
MjIgKysrLS0tDQo+ICBkcml2ZXJzL25ldC9jYW4vdXNiL2Vtc191c2IuYyAgICAgICAgICAgICAg
ICAgfCAxNCArKy0tDQo+ICBkcml2ZXJzL25ldC9jYW4vdXNiL2VzZF91c2IyLmMgICAgICAgICAg
ICAgICAgfCAxMyArKy0tDQo+ICBkcml2ZXJzL25ldC9jYW4vdXNiL2V0YXNfZXM1OHgvZXM1OHhf
Y29yZS5jICAgfCAgNyAtLQ0KPiAgZHJpdmVycy9uZXQvY2FuL3VzYi9nc191c2IuYyAgICAgICAg
ICAgICAgICAgIHwgIDcgKy0NCj4gIGRyaXZlcnMvbmV0L2Nhbi91c2Iva3Zhc2VyX3VzYi9rdmFz
ZXJfdXNiLmggICB8ICA1ICstDQo+ICAuLi4vbmV0L2Nhbi91c2Iva3Zhc2VyX3VzYi9rdmFzZXJf
dXNiX2NvcmUuYyAgfCAgNCArLQ0KPiAgLi4uL25ldC9jYW4vdXNiL2t2YXNlcl91c2Iva3Zhc2Vy
X3VzYl9oeWRyYS5jIHwgNzEgKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgLi4uL25ldC9jYW4vdXNi
L2t2YXNlcl91c2Iva3Zhc2VyX3VzYl9sZWFmLmMgIHwgMjAgKystLS0tDQo+ICBkcml2ZXJzL25l
dC9jYW4vdXNiL21jYmFfdXNiLmMgICAgICAgICAgICAgICAgfCAyMyArKystLS0NCj4gIGRyaXZl
cnMvbmV0L2Nhbi91c2IvcGVha191c2IvcGNhbl91c2IuYyAgICAgICB8ICA5ICsrLQ0KPiAgZHJp
dmVycy9uZXQvY2FuL3VzYi9wZWFrX3VzYi9wY2FuX3VzYl9jb3JlLmMgIHwgMjAgKysrLS0tDQo+
ICBkcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiX2NvcmUuaCAgfCAgMSAtDQo+
ICBkcml2ZXJzL25ldC9jYW4vdXNiL3BlYWtfdXNiL3BjYW5fdXNiX2ZkLmMgICAgfCAxMSArKy0N
Cj4gIGRyaXZlcnMvbmV0L2Nhbi91c2IvcGVha191c2IvcGNhbl91c2JfcHJvLmMgICB8IDEyICsr
LS0NCj4gIGRyaXZlcnMvbmV0L2Nhbi91c2IvdWNhbi5jICAgICAgICAgICAgICAgICAgICB8IDE3
ICsrKy0tDQo+ICBkcml2ZXJzL25ldC9jYW4vdXNiL3VzYl84ZGV2LmMgICAgICAgICAgICAgICAg
fCAxNyArKy0tLQ0KPiAgZHJpdmVycy9uZXQvY2FuL3ZjYW4uYyAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDcgKy0NCj4gIGRyaXZlcnMvbmV0L2Nhbi92eGNhbi5jICAgICAgICAgICAgICAgICAg
ICAgICB8ICAyICstDQo+ICBkcml2ZXJzL25ldC9jYW4veGlsaW54X2Nhbi5jICAgICAgICAgICAg
ICAgICAgfCAxOSArKystLQ0KPiAgaW5jbHVkZS9saW51eC9jYW4vc2tiLmggICAgICAgICAgICAg
ICAgICAgICAgIHwgIDUgKy0NCj4gIDQyIGZpbGVzIGNoYW5nZWQsIDI1NCBpbnNlcnRpb25zKCsp
LCAzNTAgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4gYmFzZS1jb21taXQ6IDExZjJjM2M1N2YzN2Jl
ZmIxYWY2Y2NhYzBkZWZhY2I4MTM0MTFkOWQNCg==
