Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F7867B123
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 12:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjAYLZx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 06:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjAYLZw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 06:25:52 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454C572A1
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 03:25:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMvQoTO8D68gyxX+kvc7vpREM0MZ18yuLgaNoLF2hrYGd7GqgR6eX/a4+hjGWc9xb3G5031teRmmWmcY2Fj/3lWj0F8D2IB70LFyEE72NX8sk0jxxZSacLxn9fi+QuS7eLzTWWi1SMQLmziPuYEmhY+S5g+lDAXOymwzVFlOwWx9oesPTFmx5GKcv6JUFnVwrP7gVLjtN69SWwStUTIk6U/7dixTG63gOER1uFkK5kwAfAeCSKafCO0d97n3flwmOCMOJkPorXUbWBf4JEZVs9oBX0BZ2Mq+PazWB9bo9o8vNcQoaz8hBYZkdFkUttqsvCn2APVqSM4gdIAhuDhhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fk1P7Abhj7ND9ICCgp+q3i7rjRf/wPtA5YY/k9Hib4=;
 b=QPlEfdSPEk6el2FQBt2meJ24qHfr40d54deB7ReF0BFRbZK/MsY+A75b4VeTZks2A3zUpNNeqEiBUboodLSCrd5Msm+NQMnQ2w3ztT2yyJOcQX8Ar6fsP/q52iwIVIfvJRecA9vic8t3IA9mTGv0JqXH3c2e61NflZfn/PjMKFU185G/yOilPbF8HMw9EEH3NnJIaiAy6zIrsx4y3vtyTLTDmt4KCy5B6U4YphoBVA98k7CvBU9oMddu78PMat7ANksv5zAms/C7mt3/XpexXVfUowbzUv/mAXbBWCD0yle0DxZE9n6cBfsPl5j+I7ZN3yHLLFIOV4tV9Uk2QZjuhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=janztec.com; dmarc=pass action=none header.from=janztec.com;
 dkim=pass header.d=janztec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janzag.onmicrosoft.de;
 s=selector1-janzag-onmicrosoft-de;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fk1P7Abhj7ND9ICCgp+q3i7rjRf/wPtA5YY/k9Hib4=;
 b=n+byQZNxWn190+6Fh41yfzfV4Mmi6yjXhs4VPKDqBXSpofgdjdnB35i5upLone8nxP3PLKGE6QKgskNYSqY6zM9grNbqXu+IndWX0WRrv6vwO0SLyVVCUAiXtO3D//F+lPaqmtyK4SZWGG0s3Rx7VE6hbH+pFg/j9Udj5yLfAMQ=
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:26::13)
 by BE1P281MB2961.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:6f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Wed, 25 Jan
 2023 11:25:48 +0000
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fa47:ffd4:d4ca:76e1]) by FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fa47:ffd4:d4ca:76e1%7]) with mapi id 15.20.6043.017; Wed, 25 Jan 2023
 11:25:48 +0000
From:   =?utf-8?B?U3RlZmFuIEFsdGjDtmZlcg==?= <Stefan.Althoefer@janztec.com>
To:     "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: AW: RE: mcp251xfd: rx frame truncation (1/2)
Thread-Topic: AW: RE: mcp251xfd: rx frame truncation (1/2)
Thread-Index: AQHZKzjliniR2Rjet0qunKK2mAziB66kOILggAAd4YCAAPuhYIAARQeAgAAbIACAAACgIIAAC5oAgAIFcICAABmWgIAADieggAF9MYCAA9Z98IABpwzwgAAHP6A=
Date:   Wed, 25 Jan 2023 11:25:48 +0000
Message-ID: <FR0P281MB1966FC9C7A02816BA8542A5097CE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
References: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966F32AD422DDD867F8C53A97C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB6484911640CCC738ED799E6FFBC79@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19663A60B0F7CE7F684A7A6297C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64842584529FAEF279F7B137FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19669083201C1B9C2DFB9E5497C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB196633E4F8E1195086E2402B97C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB648434F2B7DE7F75E291E159FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230119133214.ofapvfc2rzi3gvn4@pengutronix.de>
 <FR0P281MB1966B0AD5BD74FA1AE550F2797C59@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20230120215547.ewa5npqsxf5jxjcr@pengutronix.de>
 <BL3PR11MB64841AD10C3CFBC21A2A16FFFBC59@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19669C3FDDBE07D6B320C18997CA9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64844C1C95CA3BDADAE4D8CCFBC99@BL3PR11MB6484.namprd11.prod.outlook.com>
 <BL3PR11MB648459B22CB39606D18FAED1FBCE9@BL3PR11MB6484.namprd11.prod.outlook.com>
In-Reply-To: <BL3PR11MB648459B22CB39606D18FAED1FBCE9@BL3PR11MB6484.namprd11.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=janztec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1966:EE_|BE1P281MB2961:EE_
x-ms-office365-filtering-correlation-id: 0984a55b-a16e-4a9c-2920-08dafec6e87f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 32bxuutrA6/Mm1f0xSFJ8EATNMcwcSeDkkNw9dKAe6iiSO8eIcO8z5r23D6KkzyM+j6T8NuYGmG89o4kIfu+UPGQOhsgCv6pSaI+Fgtn2iDX32lEpSO6aeRUuV8YgYxh6Q4/z613VQV3oawRyjlYmvIbzXOyXAWZew22ibiFgqOvB1Ky2jMvty9wexUdxZZ/WwvzSNtkHmCyKvoEwMJZThvtpBWAtTo+HV2wa5d5CCdFWJtEm/kmdYITrZ/Qd1uUyN+41BQF/Ab04LGd3uFRqDuldSrx6pRdcAWHXzmmEJIKdUgiu8HJzabNA8FdLCrjuEqOao1Psl8O9BCyq120j3+2wl4MFRVcKpPWrkwcfHcrfLaaWDtoCX+A5qkQ0+fHgXYI64eymVleHH4MXx4YCgeyvZbFrsExjiu15QMDsdTLir24SykkPh//GY3IiYuw0g+U8+/3GgLTKYXXZnmQhKyYa/W2R8lMJt20L6l9pPTc3gRSSxcM+YAjLk2mWB20eqjhnsKkIV4Zaf9kDFGgWBYnMLK5ncF3mdSqwv4FG22laiYWshJOR1OfvRRIxovym0Lqa9ESxZFiGFQvxOdySz/VyziOSa485kyok5U2En6KZsJ+fD+GZycLQPspBp/mM8YROiZKyRPmNl30glvP1vkjEchfbCxrrPpRN5cnEYfSXieBhTPTPm+oKPV//dekiYwBvyzNEwjpHi2Pob0Klw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39840400004)(346002)(376002)(396003)(366004)(451199018)(55016003)(2906002)(110136005)(7696005)(478600001)(71200400001)(316002)(86362001)(33656002)(38070700005)(85182001)(85202003)(122000001)(38100700002)(6506007)(66556008)(66476007)(64756008)(66446008)(8676002)(76116006)(52536014)(41300700001)(4326008)(4744005)(8936002)(5660300002)(9686003)(66946007)(26005)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFNLcm0xSUxLRHc0dGd4UjJEY1NLWHZJcXM4YURSSmlib3JrS1NQbFF4M1E2?=
 =?utf-8?B?R2JHWVVSM3J4Nnk3ZFdya0tYclo0Q3NJNW5lUThNQVM2Z0FMamZOQm9STmNp?=
 =?utf-8?B?c0prV1BOV1hvSEc1ZmxmY1UxWTh6M1FOZk42dHF4N2xrWjhSOHE0VWZ6akN6?=
 =?utf-8?B?YW4vemdpcC9Eckh1d20yZ2dmNHhOMURIRHJJTE5sbkVETUlNQVVoSE9uQ0tN?=
 =?utf-8?B?QVh0WTA5NnFLUzEzNFZUVXl2THpsWGhRa1lTS20rR3Y2TlcyalFKakVsdGdQ?=
 =?utf-8?B?VnNhbDdkMXByVkZ0RFlZeitEV1FMNFRkczJFQlcwdXZ6cXJHbi9MekkvSmg3?=
 =?utf-8?B?cUJpR2lzcGxtS1FhWFVVeXhrdmtwTWZnRmozdXk0SldKUGFtNlE3OEc5NkVL?=
 =?utf-8?B?SzJqNkUwSkJpbWJtd0tKWUs5cFFsWkJNQ2ExSm13Wmd2SWhhRHkyUE12UUNE?=
 =?utf-8?B?UTRFWG1SUU54OXZlcEFUMFZ3VGozV3NXZHp0Q0pvM1hJc2x3c0NCZHFwa1RC?=
 =?utf-8?B?Y3h2aUI5ZDdNMzQwTGRNZk1QSWsyanlIK3FPSDBNS05RbWhrWXJ4THFEZ05O?=
 =?utf-8?B?ejNpb1NNL2IyVGZVQ1F1Q2pGSWhaZlJDSlhmKzlPMnZiYno1Qm1ydzA1U3NL?=
 =?utf-8?B?Vmt0RFI1eUlMQUdKb3Q4T1U4ZkFzOUt4cTZINXRzblpIc0tadDdnNDRqSFQ2?=
 =?utf-8?B?SEFXeVU5YWRFREw5VVJ2UFlTQU5LT1hlNVREaHRNSU5wN3FpSm1TS0dtTnFn?=
 =?utf-8?B?empvRTcza1FJcWV2OEhmSzAvblpJWGk3T1NRS0RNaDlqZW1ZQUkxQ1AyaTRz?=
 =?utf-8?B?YkcxWmtQTEJZcGhvZDkyK0VuWXE1cTREN0ZtMnVqbTI2d2laeUFvSlFnK0Za?=
 =?utf-8?B?RnVLdW4xY3pIQUMxNEltSWhVVDZIS3B3YmpSaFJvL2sxbE1DRzRjUWlFT0ZO?=
 =?utf-8?B?WmloMU5TWjk4bU9GZTdSVkdsUU03OERBOC95SlVwMllGRU9abm0zN0Rja09k?=
 =?utf-8?B?QjZmUzI5VGltS0l6ZFdYVFBkeXNrNzBCdHJlMmcvYzM4WmM1dzJES2dDUERk?=
 =?utf-8?B?YnRPVkVUZDhrQVo1L2pIblNMcUovaCtkenRuNGVDU2hxbng4RzBYMVpOVEJ0?=
 =?utf-8?B?NEhuWTJGcnBJL0lWRGlFQ3ZDeFlOeFkzaU9zR3N3OVBndnNXdFN1UFJpQ1cy?=
 =?utf-8?B?WFFneXp4eUNIemFSbWUvYW5kRGQ1NkgrK1ZOeWZBNGVDMjlwMHdaZmYvajU3?=
 =?utf-8?B?OWNCclYwMDhicXVObjRLa1NndUd4RlFiZ1o4UU95Y3pvZHRQb25pMWJ4V2FM?=
 =?utf-8?B?eEJPbm55bWtGSitrQ0dXdTF0RnYzdGlmQkljRGVxS21oZ3lBeUlMSFdpS1lu?=
 =?utf-8?B?dHEyRGR5c2dMeHlCdU5nNzBaZ3czM2JQbUUrc0I3UHBBbG16UjA4a0dzS040?=
 =?utf-8?B?NEYzWEFUR2IxelRyblJQYm5YRGR0YzJqemhoWWdCaHFxaHR1b0tMalNEUjJ4?=
 =?utf-8?B?eXQwUUVYdXFkU0hvZHBQREY1aVBiMU5xaGlncm5vaU5tN2JtV0pkczNHVHhs?=
 =?utf-8?B?Uk9jSzA2K1BLL3FZaitRTGhqcnpSMjZFc0IvNlk2SitIQVNUYmNFbWxEVFZE?=
 =?utf-8?B?cVZJa2VwTFVlSFdQc05oUGQ0bXhhem8yK29YWGcwMEQvQUFDZ2ExRWh4cDB2?=
 =?utf-8?B?MHlwUWQveWdOcUhuT01Vd1N3bW00aWQzREJReHNhSXRoa2RTUHlIMi9TSDBP?=
 =?utf-8?B?UzdhbzdiMmNRNkFBZE9remJqajRNdE12aUdaWHE3NUJpSGZlTHdQdVdJVmc2?=
 =?utf-8?B?VkRoWDlZYy82b2RVUkxZUy8xU093akdMQjdZVGo1R2VENEJTdUhWS1VUSklW?=
 =?utf-8?B?RDR6bUFucjJzUjl1MkMyTVZ0YmtBU3dHMHdSQzBHYkFYdERlQmZNRzQ3NFdR?=
 =?utf-8?B?RmhURkZHdldsaHBWdWNTQzA4VTM0WElPcmVwWGxFaUpyL3p6bUZNY3NtQ0tB?=
 =?utf-8?B?eEVPQ0pxV1NhNFltSzRlWGVZVGZPTm1YV0xVeGNFMjJKaTVubHJRTXNYRzNy?=
 =?utf-8?B?ckhLaXVWdEdiYTJ0QTQzRjNDdzZLTVo3YnA1SmJEbnkzZlpabFhVWnA0OXpm?=
 =?utf-8?B?U3Z2SFQ2aXcxcGtVRi9wUkNZUUZWaGdYcGhuK1lFMGluKy9aNGtuZGE4a1U4?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: janztec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0984a55b-a16e-4a9c-2920-08dafec6e87f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 11:25:48.3349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c1dae847-7bcf-493f-b143-af65743cbb23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H132b9d+TjbF5LxsqzVXG/U/vKTouLjsSr3XbfgZkConCF7aKOJ4szXjxG5E9P1SuNlVRXCA6lZ7UPFkgifODF9+ZjJyOPgyCTp3pTZEd+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2961
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBUYWtlbiBmcm9tIG9uZSBvZiB5b3VyIHRyYWNlcyBpcyBkYXRhIGJlbG93IFdlIGhhdmUgYSB0
ZWYgZmlmbyBzaXplIG9mIDQsIHNvIHllYWggaW4gdGhpcyBzY2VuYXJpbyBpdCdzIGV4cGVjdGVk
IHRvIGhhdmUgVEVGIGZ1bGwgc2l0dWF0aW9ucy4gQSBsYXJnZXIgDQo+IFRFRi9GYXN0ZXIgU1BJ
L2JldHRlciBTUEkgdXRpbGl6YXRpb24gd291bGQgYWxsIHJlZHVjZSB0aGUgb2NjdXJyZW5jZSBv
ZiB0aGUgaXNzdWUuDQoNCkkgd2FzIHByZXR0eSBzdXJlIHRoYXQgbXkgYXBwbGljYXRpb24gbmV2
ZXIgaGFzIG1vcmUgdGhhbiB0aHJlZSBmcmFtZXMgb24gdGhlIGZseSAtIGhhdmluZyBzZW50DQp0
aHJlZSBmcmFtZXMgSSB3YWl0IGZvciB0aGUgZmlyc3QgdG8gYmUgYXJyaXZlZCBiZWZvcmUgSSBz
ZW50IHRoZSBuZXh0Lg0KDQpIb3dldmVyLCBpdCBzZWVtcyB0aGF0IHRoZSBSWCBJUlEgcHJvY2Vz
c2luZyBpcyBmYXN0ZXIgdGhhbiB0aGFuIHRoZSBUWCBJUlENCnByb2Nlc3NpbmcgYW5kIEkgYW0g
c2VuZGluZyB0aGUgbmV4dCBmcmFtZSB3aGVuIHRoZSBUWCBldmVudCBmaWZvIGhhcyBub3QgeWV0
DQpiZWVuIHJlYWQuDQoNCkFzICJidWZmZXIgZnVsbCIgaXMgbm8gZXJyb3IgKGFzIG9wcG9zZWQg
dG8gYnVmZmVyIG92ZXJmbG93KSwgc2hvdWxkIHRoaXMgcmVhbGx5IGJlDQphIG5vbiBkZWJ1ZyBr
ZXJuZWwgbWVzc2FnZT8gU29tZSBvdGhlciBtZWFucyBvZiBnZXR0aW5nIHN1Y2ggc3RhdGlzdGlj
cyBhcHByZWNpYXRlZA0KKHNlZSBteSBwb3N0aW5nICIgbWNwMjUxeGZkIGRpYWdub3N0aWMgb3V0
cHV0cyIpLg0KDQotLQ0KU3RlZmFuDQo=
