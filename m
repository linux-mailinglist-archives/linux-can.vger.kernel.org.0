Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25874BDD00
	for <lists+linux-can@lfdr.de>; Mon, 21 Feb 2022 18:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378173AbiBUOoY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Feb 2022 09:44:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbiBUOoX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Feb 2022 09:44:23 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88284205E6
        for <linux-can@vger.kernel.org>; Mon, 21 Feb 2022 06:43:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFCk4XAZ4zKzqIF6lN30ei4jGQATn0F5yU4fE7AY5YTGqBKWdHcItI/MzsBiJI9i01tEz2kLxR/o4mAezOSqAsSnyyZm9I2FRVTMOkGsVFRfpDBUzZfzhUqkfoFcE3cJpq8N4DUya4xhWoop3JegY8USQnJaKPwIkIvYEUKdhtEkRyYYNmvuwlZn7rHzl3uZdNQsO8QXZV/hl1TS1xUBdbJvJ4KMqVDii+SEL5MbuRZip4BqqohYswlipdNwwMCXzokn9Jz3wxjPK9lM5d9YSASE9ZuCc1WvkSTrib850lqKKh6gvUUPYdXhCWkB0X6Y9C6ekrI0kJAB/NhrvCXNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mIj0JhqyMvYcKOVrMnKjoVgf5D5KfzmcBGJTMqba/U=;
 b=S6m/xMahh7ZjUIJJZE4y12JyqWBq6Bj83pz/4ppSRekuS1/RolFcfKEOvXinQRVUo7gWWdYePRNL6FR/0GyAVgGas6NRAZ+W1dTv4wtX2iZckY8KG17IFrQHcs6OP7n88AgA3e51Qp1zsJdIeZbLomOb2E2FMwIYfSrHsQISqTc+D/ae65jpl6W2gOOJYaDSeAUzo8Xpti5KqgM+0kVFWa1qL1qjjM/ccn5QxxUlermIuYbuamGE2sbVTGY1R+1XItqICFmeb99t+HSLXAMo7X2YkZAUPmsO/dbjT9hQnZKBFq0z4lNCM7gHI6kwy72YfZ8VCpdwxR5xTT3ku/fmVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mIj0JhqyMvYcKOVrMnKjoVgf5D5KfzmcBGJTMqba/U=;
 b=oado6xGtcO7YTY/okIyytc1694ZT3W7XFJM87HtXj3jMgbIp3g3PqqxLLbg8SDx76gS5ywQJ2YynQnCE/1PXmO0+wryUjtLzEk4MH7hvOz8xQi/H7eUz6BfTean/l5E28pWJZ9o3x0XGcGA0hegwLG2FJfVYIKi6nXU1Z3FjjIo=
Received: from DM6PR02MB5386.namprd02.prod.outlook.com (2603:10b6:5:75::25) by
 DM5PR02MB3798.namprd02.prod.outlook.com (2603:10b6:4:b0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Mon, 21 Feb 2022 14:43:57 +0000
Received: from DM6PR02MB5386.namprd02.prod.outlook.com
 ([fe80::a9db:f9ca:3a9d:3a86]) by DM6PR02MB5386.namprd02.prod.outlook.com
 ([fe80::a9db:f9ca:3a9d:3a86%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 14:43:57 +0000
From:   Srinivas Neeli <sneeli@xilinx.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <stefan.maetje@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: Queries on CAN frame work
Thread-Topic: Queries on CAN frame work
Thread-Index: AdgIqTVMB9fKzsHaTwKoGWnAYyrjVgAEyNAAAAFntwAAaVWWgAcyW0Gg
Date:   Mon, 21 Feb 2022 14:43:57 +0000
Message-ID: <DM6PR02MB538689AA158B340FE287CF05AF3A9@DM6PR02MB5386.namprd02.prod.outlook.com>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
 <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
 <20220115232621.4ybmmrmgogies3o5@pengutronix.de>
In-Reply-To: <20220115232621.4ybmmrmgogies3o5@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e56cada-df11-4d94-1d02-08d9f5489721
x-ms-traffictypediagnostic: DM5PR02MB3798:EE_
x-microsoft-antispam-prvs: <DM5PR02MB3798110868D9A9776C046D3FAF3A9@DM5PR02MB3798.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTFWnk7xOXqYvnhY9Dl213dzO1I9zvsJV8AxlMJDTyS0+T589NYUR7HKdTvsry4k4S41wMGJkjQun7RyOrk6zT0Mu54YOM25DQLFaqTAKG9movCGzD2JKTywWXbXubbC+u/lVLUNWsvCEWqd3m0JQrlhn4EnuAJbFYAqWLDmpiuB7LeYcqJNDEPyvH33EgAlthEVE0Lq9WMzGQBMAi9rxBfrnWKwJZ6OOXpsZypQ5ix7BsjxviKpFwdfKDxn9vVJXAQjkwEQhwfWlhunbTeC+dFcNdndO4zKBUpJGlNOjYuQjey7nB6uLKn7qTyt2ZCAakmRVez2HEi8BEMPAk9PIGnOCHBikwLHxxhH3UzTU6n9a7skjK9UY2Am9v1PeYqO4rost1Jync/Cc0bvu+DJmrJaoLQCkkHdsx5uE7iSoaQMYJ8kh1nYpA5Q6KbiqOreXjith3Ci04JGIhPwrjXz39Atm21rd+oVR8BC4t03HZgVB6naDVLWqwU9uWFK2qxmMBZ3TIE1JDi/7/Riljk7L3YwOlHZAmISRL/ZgFWvpxtlCMsbZoNljkD54TL5De0u4LNXWwFB8y/rHaG2+AZc0dR06XWWuNjcwlPWpx1QmvrKD5aTji0GxgsdAVeJw+L8JbxEzKyziZie7UcCHTf8qWY7FyyABMJZTufxfilUlvdZu3/4lEUU6QswmqFbleXP6E75d+StcYWfo286WwF0q3byNQi+82eAr6ZiWiJy4ibno9RO/Qg3KmtQNWp95BT4WLPknLcDonGDJmOJEyVNgs8OE93GY5EvGQxJLb8rbMg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5386.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(33656002)(6916009)(316002)(2906002)(86362001)(83380400001)(53546011)(26005)(122000001)(186003)(52536014)(6506007)(76116006)(38100700002)(5660300002)(66556008)(66476007)(7696005)(66446008)(8676002)(64756008)(71200400001)(38070700005)(66946007)(8936002)(966005)(55016003)(508600001)(9686003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tk1qZzF3Y3hhNW1yWUpzc2htaWw3Z1Exc1NJTWJVd0dmNWtaODJVMnlmNHZX?=
 =?utf-8?B?cUdxbkxtTmtWblRhUDdvYjQ0RmVRZVMvZzd5TzkxV3dMN3dPanY2Q3h3a1ZQ?=
 =?utf-8?B?VGdWVTF2cWk4SFl4QnJJOS9RZEdqT24vQ25RVUt1ZVNmV0xOcVZqOUlCbUNz?=
 =?utf-8?B?WVl3MXYzQnpnRXhmTGFvRjdPRHRNa25vamF2dEFrK1FkbTkzcy9FOG5URVp0?=
 =?utf-8?B?VXJ5NEswWm1hTnF3S3RyNVljZ1lHeVpjdGZBYXIveVBMczYwL3hCU0xkV29R?=
 =?utf-8?B?Q2ZpR0w5bjNaTHRyVlZlMU9oeVVHdUtmVEh6OVhTci9Rcy8zNDNQNUhtaEZi?=
 =?utf-8?B?bk40bGswU1o2NzUzNkV1YTg2enVJTVBCNURNb0ovSnF6YnVCTjI1QSs5Zm5o?=
 =?utf-8?B?Z3hVbXZQU0hGa2E0V0Zxb1FXaS91bjQ5bjJ4UFk0MVRmQ0dXRXR2OVJOVjhi?=
 =?utf-8?B?akt0b2dJOUpRbFZhMG54Y3pUbGthaGp3YzI1c1ZnRFhrVnlyYkhSZFZqZUcz?=
 =?utf-8?B?RlM0c3lqck9SNEU4WXRYOElHQUFIYVNsclViTUFDaHhpcDM2KzY0MUlKbjZi?=
 =?utf-8?B?MURSd2o5SjRjVjNFRE95dzBjeUFWb1V6bldpRFFzNHkzNVFWbmh5U0wvTGky?=
 =?utf-8?B?UmJUblVVb21iUWFHamxYQlBKelo5S0Nia1hIVm4xb2Y5MTJSR1BIcW1yN1Jy?=
 =?utf-8?B?Mk1MNDVINUlaekh5UStRY1VsdHJqQzVTNk1UbWFPdWNrNFBVN1lTTE9kV0Yy?=
 =?utf-8?B?N0gzMk02ck1ISUJ1QVptYTJwalpKcWxzZ2FIMDhqRkpFWnozYUlNaWwxVHIw?=
 =?utf-8?B?aFh3THY4S2tHZkt5VzN0V1c4WkY2eVpjZitPR3B6czhtL1NOL2UrVHBtRUR1?=
 =?utf-8?B?YWcyVklVMUdMSnJFbFlSMXA3Qzd6REwzK0hsdHFHMHdwQ201WVJBa2Q1NC8y?=
 =?utf-8?B?b2pJa0plZEVrWlRnSVdhQTRaVTJtdWxvR2ZIQUxNTFJBRDRMYXN1ZHpZTDA4?=
 =?utf-8?B?NkFKRUNKMmdtdzhlQVEwdlQ3eCtqalRPL1VHQ1BCaldTbGlyMWJEdlJXaEN0?=
 =?utf-8?B?YWJYNWtGL25idjV3eUdxY3ZDN2t0d3ZGVHkvMFVySGxBcFMzdGNqNENCYTBN?=
 =?utf-8?B?aGErRkh6azJ6eitIcVpySnpwc0VsVzNZTzV6S1JySjJ4eW8wdTZDR0NNWEZT?=
 =?utf-8?B?aUYrT0FxNEZieSt0QjFxeEdES0M2V2Y3SUh3aEdWNHVGNlR3MGV5dE44K1l2?=
 =?utf-8?B?RGJwbGw5NDlWT09uT2VKdlhVVzdmS29tYS9TQVRtRG1HbmM5dWNlTk9YYjhC?=
 =?utf-8?B?REdjb0dCQzRQMUNRUVo0NW1qRGhQa1NMaTJCUlFDVjVXa2d4WUNBNTlDSnVq?=
 =?utf-8?B?R0JXRmVYWkorajR2UVFRMHFpeklQSnVvOXBSMFY2U2o0SnNZNUl6VlBDcXl6?=
 =?utf-8?B?b25kRVV6WXFiS2NjR2tKWTlXTmlOVFNvdkJHeW1CMzFGdm12a2FudFVzZmFF?=
 =?utf-8?B?OU9xdG5neEJtMUNzTVIwenErZERIWWNqdFJIVjlwWXJQc3Q4eHNJV0N2Q2hL?=
 =?utf-8?B?eUpEVXduOGJQTmZSY1hzS0xEdnpTVXpIVnpUYktmTnhMZmVuUkZlWllsU1dX?=
 =?utf-8?B?WnYybGZtN2tqUGpRcmNGeCtZZkFzRzdpdWdpdTdDSVlFdm1oelM3SU5rUlN5?=
 =?utf-8?B?MTN4dnJrZzVuUy82NEN6a0RWQndaN0FXVzA3RWNLMkJQQzFCNTZLNktaOUVX?=
 =?utf-8?B?THQraVpBbEx1aGpDekRRaTE5aHFMVXdtbXJEbjhQWng2WXJxalNQT0prR0ht?=
 =?utf-8?B?cmVuR3RRZzRmK0VHdkZuS2dPR1UwUm9HYlNHRnlWM0MrNG5teXpqNE9PVmxX?=
 =?utf-8?B?MFNleVlVbXZSekhvVDhHTzlXQkNYWjgwNEFEL284M2hMaWR1WjJZTFdiQzVD?=
 =?utf-8?B?MGpnUWppU2hYajBlTFU2NkhJSmFiNnhpSmlGSEI5Y2l3cnlFU2hDdWdVRFlI?=
 =?utf-8?B?NCtNZEt6QXQ4cU82RWVSSkRPVDVuUlpDYjNraStkVGhNSVZ6dHlzbS9UQkw0?=
 =?utf-8?B?VW1lVnk4NFBPdmNIY0hYdXJwbk9uMnJ6d0x5SnA5TTRBQ0pQM0tHdHZLUzJy?=
 =?utf-8?B?aFEzYWEzVlFCRU0rY1MwZVhURnlaRFNrT2dxY005QzZzWjAxU0FoNzdUZXB1?=
 =?utf-8?Q?ybqhIR30mE1FxhV6co5xq+M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5386.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e56cada-df11-4d94-1d02-08d9f5489721
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 14:43:57.0834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sH7mcF1Z/nFFso3CRTafqZv9a20SDHKumHf0I9ZXsRG4D36H1WFWJ/HSHUFFYspI0IfycmAKTXes83AgfXtKcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3798
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgbWFyYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEts
ZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBTdW5kYXksIEphbnVhcnkg
MTYsIDIwMjIgNDo1NiBBTQ0KPiBUbzogU3Jpbml2YXMgTmVlbGkgPHNuZWVsaUB4aWxpbnguY29t
Pg0KPiBDYzogU3Jpbml2YXMgR291ZCA8c2dvdWRAeGlsaW54LmNvbT47IE5hdmVlbiBLdW1hciBH
YWRkaXBhdGkNCj4gPG5hdmVlbmt1QHhpbGlueC5jb20+OyBQcmFzYWQgQmVlciBQcmFzYWQgPHBy
YXNhZGJlQHhpbGlueC5jb20+OyBsaW51eC0NCj4gY2FuIDxsaW51eC1jYW5Admdlci5rZXJuZWwu
b3JnPjsgU3RlZmFuIE3DpHRqZSA8c3RlZmFuLm1hZXRqZUBlc2QuZXU+Ow0KPiBWaW5jZW50IE1B
SUxIT0wgPG1haWxob2wudmluY2VudEB3YW5hZG9vLmZyPg0KPiBTdWJqZWN0OiBSZTogUXVlcmll
cyBvbiBDQU4gZnJhbWUgd29yaw0KPiANCj4gT24gMTMuMDEuMjAyMiAyMjoxMDoxOCwgTWFyYyBL
bGVpbmUtQnVkZGUgd3JvdGU6DQo+ID4gT24gMTMuMDEuMjAyMiAyMTozMDowNCwgTWFyYyBLbGVp
bmUtQnVkZGUgd3JvdGU6DQo+ID4gPiA+IFJlY2VudGx5IHdlIGRpZCBmZXcgZXhwZXJpbWVudHMg
d2l0aCBvdXIgQ0FORkQgbmV0d29yay4gU3R1ZmYNCj4gPiA+ID4gZXJyb3Igb2JzZXJ2ZWQgd2l0
aCBkaWZmZXJlbnQgTm9taW5hbCBhbmQgRGF0YXBoYXNlIHByZXNjYWxlcg0KPiA+ID4gPiBjb25m
aWd1cmF0aW9uIHZhbHVlcywgd2hpY2ggd2UgZ2V0IGZyb20gdGhlIGZyYW1lIHdvcmsuDQo+ID4g
PiA+DQo+ID4gPiA+IEZvciBsb3dlciBiYXVkIHJhdGVzIHNlcGFyYXRlIHByZXNjYWxlcnMgYXJl
IHdvcmtpbmcgZ29vZCwgYnV0DQo+ID4gPiA+IHdoZW4gd2Ugc3dpdGNoIHRvIGhpZ2ggYmF1ZCBy
YXRlcyhsaWtlIDRNYnBzIGFuZCA1TWJwcykgb2JzZXJ2ZWQNCj4gPiA+ID4gdGhlIEJVU09GRiBz
dGF0ZShEdWUgdG8gc3R1ZmYgZXJyb3JzKSBvbiBJUChYaWxpbngpLg0KPiA+ID4gPg0KPiA+ID4g
PiBXaXRoIHNoYXJlZCBwcmVzY2FsZXIobG93IHByZXNjYWxlcnMpIHdlIGFyZSBub3Qgc2VlaW5n
IHRoZQ0KPiA+ID4gPiBpc3N1ZS4uDQo+IA0KPiBDYW4geW91IHBsZWFzZSBwcm92aWRlIG1lOg0K
PiAtIHRoZSBiaXQgdGltaW5nIGNvbnN0YW50cyBvZiB0aGUgSVAgY29yZSBmb3IgdGhlIGFyYml0
cmF0aW9uIGFuZCBkYXRhDQo+ICAgcGhhc2UNCj4gLSB0aGUgYml0IHJhdGUgZm9yIHRoZSBhcmJp
dHJhdGlvbiBhbmQgZGF0YSBwaGFzZQ0KPiAgIChlc3BlY2lhbGx5IHdoZXJlIHRoZSBmcmFtZXdv
cmsgY2FsY3VsYXRlcyBub3QgY29tbW9uIHByZXNjYWxlcnMpDQo+IC0gdGhlIGNsb2NrIHJhdGUg
b2YgdGhlIENBTiBidXMgY2xvY2sNCj4gDQo+IENhbiB5b3UgYWxzbyBwcm92aWRlIHRoZSBoYW5k
IGNhbGN1bGF0ZWQgYml0IHRpbWluZyBwYXJhbWV0ZXJzIGZvciB0aGUNCj4gYWJvdmUgc2NlbmFy
aW9zPw0KDQpCYXVkIHJhdGUgMS81TWJwcw0KPT09PT09PT09PT09PT09PQ0Kcm9vdEB4aWxpbngt
dmNrMTkwLTIwMjFfMTp+IyBpcCBsaW5rIHNldCBjYW42IHR5cGUgY2FuIGJpdHJhdGUgMTAwMDAw
MCBkYml0cmF0ZSA1MDAwMDAwIGZkIG9uICAgDQpbICAgMjYuODM3MDU3XSB4aWxpbnhfY2FuIGZm
MDcwMDAwLmNhbiBjYW42OiBiaXRyYXRlIGVycm9yIDAuMCUNClsgICAyNi44NDI3MzFdIHhpbGlu
eF9jYW4gZmYwNzAwMDAuY2FuIGNhbjY6IGJpdHJhdGUgZXJyb3IgMC4wJQ0KIGNhbjYgdHhxcm9v
dEB4aWxpbngtdmNrMTkwLTIwMjFfMTp+IyBpZmNvbmZpZyBjYW42IHR4cXVldWVsZW4gMTAwMA0K
IHJvb3RAeGlsaW54LXZjazE5MC0yMDIxXzE6fiMgaXAgbGluayBzZXQgY2FuNiB1cA0KWyAgIDI3
LjM0MDg4MF0gSVB2NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGNhbjY6IGxpbmsgYmVjb21l
cyByZWFkeQ0Kcm9vdEB4aWxpbngtdmNrMTkwLTIwMjFfMTp+IyBpcCAtZCAtcyBsaW5rIHNob3cg
Y2FuNg0KIGNhbjY6IDxOT0FSUCxVUCxMT1dFUl9VUCxFQ0hPPiBtdHUgNzIgcWRpc2MgcGZpZm9f
ZmFzdCBzdGF0ZSBVUCBtb2RlIERFRkFVTFQgZ3JvdXAgZGVmYXVsdCBxbGVuIDEwMDANCiAgICBs
aW5rL2NhbiAgcHJvbWlzY3VpdHkgMCBtaW5tdHUgMCBtYXhtdHUgMCANCiAgICBjYW4gPEZEPiBz
dGF0ZSBFUlJPUi1BQ1RJVkUgKGJlcnItY291bnRlciB0eCAwIHJ4IDApIHJlc3RhcnQtbXMgMCAN
CgkgIGJpdHJhdGUgOTk5OTk5IHNhbXBsZS1wb2ludCAwLjc1MCANCgkgIHRxIDI1MCBwcm9wLXNl
ZyAxIHBoYXNlLXNlZzEgMSBwaGFzZS1zZWcyIDEgc2p3IDENCgkgIHhpbGlueF9jYW46IHRzZWcx
IDEuLjI1NiB0c2VnMiAxLi4xMjggc2p3IDEuLjEyOCBicnAgMS4uMjU2IGJycC1pbmMgMQ0KCSAg
ZGJpdHJhdGUgNDk5OTk5OSBkc2FtcGxlLXBvaW50IDAuNzUwIA0KCSAgZHRxIDUwIGRwcm9wLXNl
ZyAxIGRwaGFzZS1zZWcxIDEgZHBoYXNlLXNlZzIgMSBkc2p3IDENCgkgIHhpbGlueF9jYW46IGR0
c2VnMSAxLi4zMiBkdHNlZzIgMS4uMTYgZHNqdyAxLi4xNiBkYnJwIDEuLjI1NiBkYnJwLWluYyAx
DQoJICBjbG9jayA3OTk5OTk5OSANCgkgIHJlLXN0YXJ0ZWQgYnVzLWVycm9ycyBhcmJpdC1sb3N0
IGVycm9yLXdhcm4gZXJyb3ItcGFzcyBidXMtb2ZmDQoJICAwICAgICAgICAgIDAgICAgICAgICAg
MCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgIG51bXR4cXVldWVzIDEg
bnVtcnhxdWV1ZXMgMSBnc29fbWF4X3NpemUgNjU1MzYgZ3NvX21heF9zZWdzIDY1NTM1IA0KICAg
IFJYOiBieXRlcyAgcGFja2V0cyAgZXJyb3JzICBkcm9wcGVkIG92ZXJydW4gbWNhc3QgICANCiAg
ICAwICAgICAgICAgIDAgICAgICAgIDAgICAgICAgMCAgICAgICAwICAgICAgIDAgICAgICAgDQog
ICAgVFg6IGJ5dGVzICBwYWNrZXRzICBlcnJvcnMgIGRyb3BwZWQgY2FycmllciBjb2xsc25zIA0K
ICAgIDAgICAgICAgICAgMCAgICAgICAgMCAgICAgICAwICAgICAgIDAgICAgICAgMCAgICAgICAN
CnJvb3RAeGlsaW54LXZjazE5MC0yMDIxXzE6fiMgDQoNClBhcmFtZXRlcnMNCkJQUkEgLTIwLCBU
UzEgPSAyLCBUUzIgPTEsc2p3ID0xLA0KQlBSRCAtIDQsIFRTMSA9IDIsIFRzMiA9IDEsc2p3ID0x
LA0KQ2xvY2sgfjgwTWh6KDc5OTk5OTk5KQ0KDQpIYW5kIGNvbmZpZ3VyYXRpb246DQotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0gDQppcCBsaW5rIHNldCBjYW4wIHR5cGUgY2FuIHRxIDEyIHBy
b3Atc2VnIDI5IHBoYXNlLXNlZzEgMzAgcGhhc2Utc2VnMiAyMCBzancgMSBkdHEgMTIgZHByb3At
c2VnIDUgZHBoYXNlLXNlZzEgNiBkcGhhc2Utc2VnMiA0IGRzancgMSBmZCBvbiAgKEEvRDogMS81
TWJwcywgU2FtcGxlIHBvaW50PTc1JSkNCg0KQmF1ZCByYXRlIDEvNE1icHMNCj09PT09PT09PT09
PT09PT0NCnJvb3RAeGlsaW54LXZjazE5MC0yMDIxXzE6fiMgaXAgbGluayBzZXQgY2FuNiB0eXBl
IGNhbiBiaXRyYXRlIDEwMDAwMDAgZGJpdHJhdGUgNDAwMDAwMCBmZCBvbiAgIA0KWyAgMjA5LjU3
MjkzOF0geGlsaW54X2NhbiBmZjA3MDAwMC5jYW4gY2FuNjogYml0cmF0ZSBlcnJvciAwLjAlDQpb
ICAyMDkuNTc4NjI3XSB4aWxpbnhfY2FuIGZmMDcwMDAwLmNhbiBjYW42OiBiaXRyYXRlIGVycm9y
IDAuMCUNCnJvb3RAeGlsaW54LXZjazE5MC0yMDIxXzE6fiMgDQpyb290QHhpbGlueC12Y2sxOTAt
MjAyMV8xOn4jIGlwIC1kIC1zIGxpbmsgc2hvdyBjYW42DQo5OiBjYW42OiA8Tk9BUlAsRUNITz4g
bXR1IDcyIHFkaXNjIHBmaWZvX2Zhc3Qgc3RhdGUgRE9XTiBtb2RlIERFRkFVTFQgZ3JvdXAgZGVm
YXVsdCBxbGVuIDEwMDANCiAgICBsaW5rL2NhbiAgcHJvbWlzY3VpdHkgMCBtaW5tdHUgMCBtYXht
dHUgMCANCiAgICBjYW4gPEZEPiBzdGF0ZSBTVE9QUEVEIChiZXJyLWNvdW50ZXIgdHggMCByeCAw
KSByZXN0YXJ0LW1zIDAgDQoJICBiaXRyYXRlIDk5OTk5OSBzYW1wbGUtcG9pbnQgMC43NTAgDQoJ
ICB0cSAyNTAgcHJvcC1zZWcgMSBwaGFzZS1zZWcxIDEgcGhhc2Utc2VnMiAxIHNqdyAxDQoJICB4
aWxpbnhfY2FuOiB0c2VnMSAxLi4yNTYgdHNlZzIgMS4uMTI4IHNqdyAxLi4xMjggYnJwIDEuLjI1
NiBicnAtaW5jIDENCgkgIGRiaXRyYXRlIDM5OTk5OTkgZHNhbXBsZS1wb2ludCAwLjc1MCANCgkg
IGR0cSA2MiBkcHJvcC1zZWcgMSBkcGhhc2Utc2VnMSAxIGRwaGFzZS1zZWcyIDEgZHNqdyAxDQoJ
ICB4aWxpbnhfY2FuOiBkdHNlZzEgMS4uMzIgZHRzZWcyIDEuLjE2IGRzancgMS4uMTYgZGJycCAx
Li4yNTYgZGJycC1pbmMgMQ0KCSAgY2xvY2sgNzk5OTk5OTkgDQoJICByZS1zdGFydGVkIGJ1cy1l
cnJvcnMgYXJiaXQtbG9zdCBlcnJvci13YXJuIGVycm9yLXBhc3MgYnVzLW9mZg0KCSAgMCAgICAg
ICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAg
ICBudW10eHF1ZXVlcyAxIG51bXJ4cXVldWVzIDEgZ3NvX21heF9zaXplIDY1NTM2IGdzb19tYXhf
c2VncyA2NTUzNSANCiAgICBSWDogYnl0ZXMgIHBhY2tldHMgIGVycm9ycyAgZHJvcHBlZCBvdmVy
cnVuIG1jYXN0ICAgDQogICAgMCAgICAgICAgICAwICAgICAgICAwICAgICAgIDAgICAgICAgMCAg
ICAgICAwICAgICAgIA0KICAgIFRYOiBieXRlcyAgcGFja2V0cyAgZXJyb3JzICBkcm9wcGVkIGNh
cnJpZXIgY29sbHNucyANCiAgICAwICAgICAgICAgIDAgICAgICAgIDAgICAgICAgMCAgICAgICAw
ICAgICAgIDAgICAgICAgDQpyb290QHhpbGlueC12Y2sxOTAtMjAyMV8xOn4jIA0KDQpQYXJhbWV0
ZXJzDQpCUFJBIC0yMCwgVFMxID0gMiwgVFMyID0xLHNqdyA9MSwNCkJQUkQgLSA1ICwgVFMxID0g
MiwgVHMyID0gMSxzancgPTEsDQpDbG9jayB+ODBNaHooNzk5OTk5OTkpDQoNCkhhbmQgY29uZmln
dXJhdGlvbjoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQppcCBsaW5rIHNldCBjYW4wIHR5
cGUgY2FuIHRxIDEyIHByb3Atc2VnIDI5IHBoYXNlLXNlZzEgMzAgcGhhc2Utc2VnMiAyMCBzancg
MSBkdHEgMTIgZHByb3Atc2VnIDcgZHBoYXNlLXNlZzEgNyBkcGhhc2Utc2VnMiA1IGRzancgMSBm
ZCBvbiAoQS9EOiAxLzRNYnBzLCBTYW1wbGUgcG9pbnQ9NzUlKQ0KUmVmZXJlbmNlOg0KaHR0cHM6
Ly93d3cua3Zhc2VyLmNvbS9zdXBwb3J0L2NhbGN1bGF0b3JzL2Nhbi1mZC1iaXQtdGltaW5nLWNh
bGN1bGF0b3IvDQoNCmlzIHRoZXJlIGFueSBwbGFuIHRvIGltcGxlbWVudCBuZXdzbGV0dGVyIHJl
Y29tbWVuZGF0aW9ucyBpbiBmcmFtZSB3b3JrID8NCmh0dHBzOi8vY2FuLW5ld3NsZXR0ZXIub3Jn
L3VwbG9hZHMvbWVkaWEvcmF3L2Y2YTM2ZDE0NjEzNzFhMmY4NmVmMDAxMWENCg0KDQo+IA0KPiBy
ZWdhcmRzLA0KPiBNYXJjDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAg
ICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgICB8DQo+IEVtYmVkZGVkIExpbnV4ICAg
ICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUgIHwNCj4gVmVydHJl
dHVuZyBXZXN0L0RvcnRtdW5kICAgICAgICAgfCBQaG9uZTogKzQ5LTIzMS0yODI2LTkyNCAgICAg
fA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiB8IEZheDogICArNDktNTEyMS0y
MDY5MTctNTU1NSB8DQo=
