Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5ABF2CD643
	for <lists+linux-can@lfdr.de>; Thu,  3 Dec 2020 13:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbgLCM6x (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 3 Dec 2020 07:58:53 -0500
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:24196
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730491AbgLCM6w (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 3 Dec 2020 07:58:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEuyEA5xEFCKwNfUWPFs25vYWOfc5QAQFmlVKMwGuPMi+nUIrkH6ZtmIj0FHS8gctcFUzjnyhhgki0BHJCg7gX1v2zs7bdVBNKEd18tlUSZMxTdP9uh+pLWBRFJeXKwGYDAmBJ+ap8EIjHVgExidFmfSqhagtozNF9pqLOx7ccryrEydbqvSD+hMPjnCeZdWpRnU/emzxXpR0xWuOwFHQh969r3eELTw4FAOlQ37ACMbvVHJ7iPEOj7cRf4sNSgUAjhTim37OTzW32ABVo5Ahk/M2QFCV+a11xwAqrVUrueVjus7zAFNSf1V/uqhhgD3rh7uOMCHt7sPzzDG9x8Muw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+xfOteZ23wW0drQLxFmFKVhqkA87UMrXxE+vQ075/E=;
 b=b8cXIuQGORazBXRCiDY0vRoQ0IJD5+vkWVA8OXSB0b3D8ZLSkxG+rdJ4tIAS3MiTwnrZvFkSd10+YTBdksv2HE2ZiYgEV/7PYqSAwCDOWSQLyB2MtNbvFRiAxIhg8ALLPlfHL/gN7epKk7hrBb0oe+hCI6kqjVdkbPJGA9P+METRmUmb031Q/Rq93+Izt8/9P60MuXyIvyvI4IOHRLmzYdi2oPLbpWySOsfc9grivodlwWURsYUFtKHbbiiM7JjTOuH4nMKfUQVmkg/QjAypdBh1Z44xnjWar5YJVkpROsBVtclcTaEmgOWk97b21ErcfO5zbFe0RcLwEftwRrgQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pa-systems.de; dmarc=pass action=none
 header.from=pa-systems.de; dkim=pass header.d=pa-systems.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mahapa.onmicrosoft.com; s=selector2-mahapa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+xfOteZ23wW0drQLxFmFKVhqkA87UMrXxE+vQ075/E=;
 b=oZYrupJTPMv6jVtXbNfGV5R1ejxDl34f79hzp43eKk5olhVMNjxnQvN4RxKHARNz4tYcJsf9thzfGeFUaN6dbP2zlyM7Gys+R95u5VjY9dip14Tdz4gcFhQ1rGyzG5c2XT/6bOrcxmaWeE4t+Lfz5jOSjVXfUdf0TZoLf3MCKSM=
Received: from AM9PR06MB7283.eurprd06.prod.outlook.com (2603:10a6:20b:2d3::15)
 by AM0PR06MB6450.eurprd06.prod.outlook.com (2603:10a6:208:198::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Thu, 3 Dec
 2020 12:58:03 +0000
Received: from AM9PR06MB7283.eurprd06.prod.outlook.com
 ([fe80::e14b:5647:7ace:196c]) by AM9PR06MB7283.eurprd06.prod.outlook.com
 ([fe80::e14b:5647:7ace:196c%6]) with mapi id 15.20.3632.017; Thu, 3 Dec 2020
 12:58:03 +0000
From:   Thomas Wagner <thomas.wagner@pa-systems.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "thwa1@web.de" <thwa1@web.de>
Subject: RE: Suggestion to have a functional addressing/broadcast option for
 ISO-TP sockets
Thread-Topic: Suggestion to have a functional addressing/broadcast option for
 ISO-TP sockets
Thread-Index: AdbIokQ7wYkfmwdQQtioWWQAsiVkcgADUMmAAAFyUvAAAx3IAAAKFjmAABqXJOAABk+XgAABaaRg
Date:   Thu, 3 Dec 2020 12:58:03 +0000
Message-ID: <AM9PR06MB7283C0079E317FCFCAB8CE07B5F20@AM9PR06MB7283.eurprd06.prod.outlook.com>
References: <AM9PR06MB72834DE8FE187784AE914AB2B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
 <bf1b3dd2-1a43-0bc7-d1db-f4ad010944ed@hartkopp.net>
 <AM9PR06MB7283F123B4B9B5A781597379B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
 <a01a36d2-725f-6de0-51bb-5a40be8d3e5b@hartkopp.net>
 <420f13ef-2993-7dd5-d537-085c1445be61@hartkopp.net>
 <AM9PR06MB7283E62151D53EF677B87517B5F20@AM9PR06MB7283.eurprd06.prod.outlook.com>
 <06e4fc83-3297-53d9-e4a0-cb6b115faf96@hartkopp.net>
In-Reply-To: <06e4fc83-3297-53d9-e4a0-cb6b115faf96@hartkopp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hartkopp.net; dkim=none (message not signed)
 header.d=none;hartkopp.net; dmarc=none action=none header.from=pa-systems.de;
x-originating-ip: [2003:ed:2713:f00:383f:de88:b80a:dcae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7497d80-048e-408d-d6ff-08d8978b127d
x-ms-traffictypediagnostic: AM0PR06MB6450:
x-microsoft-antispam-prvs: <AM0PR06MB6450EF2DDE9A209FD1FE690BB5F20@AM0PR06MB6450.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3KLStP4u1xUO0PxZi16bCjm7esmDDNuL6/KmHnabrO/0wpvs3skNgwYuQ/LM0Z3N5XVagMiYQsrKUqGDAcDTYy37U08+wEOkThyMCNTZd7RNNIMiROyBK6sVvMkpLEcE3eArr/inqc0b3fnRKEOR9hCplRxSg4GbR/c8i1IJYDuUemjN3PnyLXiirz+WOJtAGYZVJLjWCbpC4Rqa6F5CadA/qxSiEdgofMzkrdXSOt6IcAVxjmZh5x7X1kMRk5NvnRyyopTniysm/fVCRp3PVedfdsC/kjSaNKzG9aXW4m4sAztzt8I7ODyiePNExAwyn4IAlZzMH8Hab//yEt8cwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7283.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39830400003)(396003)(366004)(346002)(52536014)(44832011)(55016002)(2906002)(66946007)(8936002)(76116006)(53546011)(33656002)(9686003)(186003)(7696005)(316002)(5660300002)(4326008)(66556008)(8676002)(66476007)(66446008)(478600001)(110136005)(64756008)(6506007)(71200400001)(86362001)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Y0pmY1VCdGRjQ1VNZ3ZQYWNtV1FYdXJDSzFpNEpTaGRmT25PTDJOd2xNRVFx?=
 =?utf-8?B?cjkxeGpyMFlBdXQ3WTNTMytsUmJjeG90ZW9uWlpQaXJrUnhPSUFmSFBWekI1?=
 =?utf-8?B?N01POU1WcVdtK0tkWUZKU2xyeVI4cERGUUJOQnY3ekR1bk1WK0pOWWdkMTlo?=
 =?utf-8?B?dG5FaVVtdDRXZis1US9Hbm5WTFdwWGZBTDNsdDBZMzNmRTJEdmkzQng2eUJl?=
 =?utf-8?B?L2hRZ3lmNFlHb1NQQThXVFhKL1lxdkJER2h0VmpZMXVOeVhIbXZ2WklLeHk3?=
 =?utf-8?B?cklMWDJLV2dTM1FOME9aNlBWUlJ1aXRPNW4rdUpXSnBrdFZoVFMrVnBaSlR2?=
 =?utf-8?B?aEcyRVNFaWNGZlVYS01JcmJlaXBEQkQ4bnNtK28zc0RWOVRqUklQV0dKaXVk?=
 =?utf-8?B?NnV3Wk9kck4yV2o4eE1WODRoU1VBeFFsSklqK0pobTFJUXVHWU5UR0g4bUpH?=
 =?utf-8?B?dTRoNmVtNGs5RitWSmRyd0F2c2pZVmF4Tis3WlBpc25zeUJ1Tkh1cVB6Tnc0?=
 =?utf-8?B?WGduQ1c3OGdQOWFIbVRtWFBGVFhpcU5OUWlBYm95d2tmLzRrZGh4cko2OWFi?=
 =?utf-8?B?R1d0S3p6dGZpcURrR2ljbFRNM2RQbVphWCtobnVobFViSEZwVDQ0c2lYdmZq?=
 =?utf-8?B?RGpta1Z4QXMxcWNrejlUZHYxcncya2QzRTh3d0pjMUlwdCtKazZRdGxUMjRk?=
 =?utf-8?B?YkxwQ3NMaXU0cGwrZytiSDZZMW43dWZBendVbkNuV3NqY1RnU1Vibk8xUXVT?=
 =?utf-8?B?aU41T0U2TE82ajJYemZsejdQczdBQUdHbThlQWczU2ZCUElJdFFYZnl6V3p4?=
 =?utf-8?B?STRUNzBMWDJRNHFNK1BHN0tHdDJxd2U3aVJsZjRER01yaHBiaDhoYjd2VWV2?=
 =?utf-8?B?aGxmNGdqVG1jZEpBYUdrK281TVc2UHBUYkd3UmcxTTlnUDVVS0F4SnlYVTNS?=
 =?utf-8?B?WVJPbFdLRUdML3NCT3kwWSszMmN6Z0pFSzVSQUQzSzdVcTlwTFpxTjJUeTBZ?=
 =?utf-8?B?OE5EUlowakM2Qjk3NUlWSXNVa2FhUURZeGozVSt1N2FmRG8yNmZETGdkbjJQ?=
 =?utf-8?B?N3lTU0Q5a0dMZk5pOHh6OGxRdFhPcEU4dlBqZ2M4dU1Hck9qa2Vhekd0aG5E?=
 =?utf-8?B?ZkdLQnI3TGJ3bkNTdlhJNTV6U2czck1FdWVmT2VUQjg5MHpKYzhxSkJpZmNk?=
 =?utf-8?B?Nk9GbW5pZ09tTXhXRnFLUUVLR2ZOU09jNXB0dlRHM3oyLzcwODJTTk15a0lo?=
 =?utf-8?B?M1RkSFh4SU9jOGhjRTVmNkdsS1lOVkFETnVaNFZZNlQ5aFZLOEpYYk5tOUND?=
 =?utf-8?B?dGd4Y0lsL0pMSHpuSU0wTmFDVjZ1Qy91TzUrcXlkUXg0OXR3SWhGVTdRT21p?=
 =?utf-8?Q?y9OplD1mJmnlE+ZGm+3fpVwrvIdUKRjU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pa-systems.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7283.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7497d80-048e-408d-d6ff-08d8978b127d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 12:58:03.9012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8c1b19d-12b7-4029-a8de-e069486288e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nyiJ2vdTrOXSQHGBifCyitchJoqF9ZNuSUEmD5IlrMFbF+8Tgy1z7cqH2evT18ELaYrIqqvuwoJcjpx2D5KA5ehqDr0fQYmM9BM0ZhXUHMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6450
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgT2xpdmVyLA0KDQpPbiAwMy4xMi4yMCAxMzoxNCwgT2xpdmVyIEhhcnRrb3BwIHdyb3RlOiAN
Cj4gSSB3b3VsZCBsaWtlIHRvIGFkZCBzb21lIFN1Z2dlc3RlZC1ieTogYW5kIFRlc3RlZC1ieTog
dGFncyB0byB0aGUgcGF0Y2gNCj4gaWYgaXQncyBmaW5lIGZvciB5b3UuDQo+DQo+IFdoaWNoIG9m
IHlvdXIgdHdvIGVtYWlsIGFkZHJlc3NlcyB3b3VsZCB5b3UgbGlrZSB0byBzZWUgdGhlcmU/DQoN
ClN1cmUhIE15IHByaXZhdGUgbWFpbCB0aHdhMUB3ZWIuZGUsIGFzIHVzZWQgb24gR2l0SHViIGFu
ZCB0aGUgbGFzdCByZXBvcnQsIGlzIGZpbmUuDQoNClJlZ2FyZHMNClRob21hcw0K
