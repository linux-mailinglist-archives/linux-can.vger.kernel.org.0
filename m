Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74DE60B46E
	for <lists+linux-can@lfdr.de>; Mon, 24 Oct 2022 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJXRnl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 24 Oct 2022 13:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiJXRnT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Oct 2022 13:43:19 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e19::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927D698C87
        for <linux-can@vger.kernel.org>; Mon, 24 Oct 2022 09:18:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOerW7uRo/aV5raMtVqCnlEevYrCAsPfskSZ2pr+8qCDcng8cRw1DBGXm3csFZTzacSdcmfES5iuI7xR5iWT2tiqWY/OOfX/PeIdp2htDrofqy49vjmUqQNBLCaYItXf1W7UfzLE0MKXsWXwdbvd4HW55W+bJyFihRxM7T0N86JRGdulMnbEgKv0FPmbcjnFzSJ95295aXK6XZp41Ht7r++5+mXeg8+J5nNCOlrTeNMqwqudgXeNveRlac35zmoNQpMVF885IwAACPPWyJ2nkR8Jf/TdHx+xJh8ZJXtDnE/bqLptaixlNYGUaGqdEzVfAHVzO+XbOnqgcoQPS5FLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtqpiJu1ta7MNjs1jQ7GmY4SOeXIUhU2dyNRLdLyXWg=;
 b=QwXkrq7+x7mBkdV/c0scU2nwLRqWxnuavws1nDPipaXyb0pSXaIp8XuSDGSbzFWVyZuzWBEieKz8u1ecewE4tHJLdO0pEyUGsPIyEpfLfqG2zrvqUrTj9zTDhyN2sMjNhHoqN+m6e/yQ+4brnfwwmkMs1TjXwoFdT39/hYut8OJQC7eOrSJhNZB4Qp+RdU4Cm2GLmJtMVORQmh1bNIA3yeRp4l16B3Fqj4MfJ/kxjTeNgQSLuZc/5JstwcuWKwxlKr9fQquOyVFJN9KnLNbrxLHXLq0ijd1Rhh68JX8YKLP+PdIfwOR1CJOBweEE1TAiVIblf3JgDzKiPGbDPvy48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=actia.fr; dmarc=pass action=none header.from=actia.fr;
 dkim=pass header.d=actia.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=actia.fr; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtqpiJu1ta7MNjs1jQ7GmY4SOeXIUhU2dyNRLdLyXWg=;
 b=ZZFxNGQ3Xdm5nlPR2xcSbf5K8QTh3TE1uV+TaaeGAtJAAOhhZdWsE77sCMZ1PbAGR/1Jk94zzD7cU1aCZ4PBqug/CyZ/bROBbQOIdBtHRKHlc9Jg+YHeZsz39J21j2H8NBT+BoQRUERskA/bUojmAX1fkcdQBH63OK3XwjUdbmU=
Received: from PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e0::12)
 by MR1P264MB2979.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 16:15:13 +0000
Received: from PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM
 ([fe80::4cbd:493e:7d7f:22ce]) by PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM
 ([fe80::4cbd:493e:7d7f:22ce%2]) with mapi id 15.20.5746.027; Mon, 24 Oct 2022
 16:15:13 +0000
From:   Sebastien FABRE <sebastien.fabre@actia.fr>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: RE: J1939: Send messages without acknowledging
Thread-Topic: J1939: Send messages without acknowledging
Thread-Index: AdjiOArCihCCUJS2S0aV5OLbcs6cdQAqML8AAGhoI9AANDR7gACbtSOg
Date:   Mon, 24 Oct 2022 16:15:13 +0000
Message-ID: <PR0P264MB2309B1D46E9125827D701875922E9@PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM>
References: <PR0P264MB23096FC238E648331A32B5A492299@PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM>
 <20221018110016.sgvh2prqm5ehstxv@pengutronix.de>
 <PR0P264MB23094D0D6CA05334809ACEE1922A9@PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM>
 <20221021134433.GG28729@pengutronix.de>
In-Reply-To: <20221021134433.GG28729@pengutronix.de>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=actia.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR0P264MB2309:EE_|MR1P264MB2979:EE_
x-ms-office365-filtering-correlation-id: ca97f941-3b2f-4d33-0247-08dab5daee59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d+dsucQrKvKz/ElAcLwwLIx9HKpbdJ6P+ol2QmAtEzKrzwqrzZNV292JsDA4IRvgjZ5hfXjvAKkUhgnO398CSEXjMlG7WkpBO9oqA7h1WzUFGMhqOSaZttrAF6PfMddJ5Q9p13vpOpHH/A4Mghjt93YpNLEv/uHSikRPZfZlUaRahkuZTX6NZ14JQoP7do9nkZnWgd+BVNzdmRo0CdgrIdsO6ZRAwdQ+OsEUR5VhWJ9jVAlMp8xISzQGyAmfT5++zQL/3HeVENyejQiBYdCXIQQplOpjgloU7wIu/sEf/iReh/m3zFoACURLOH1mLYpox+XkkO7JwPRzuKem7oPXNT7+Mu+2xdOo4GWg7tnUPFFwcpCgeuaI9v3MXCA1l8CE8hYfo9Ym6MxFBw55dxPKsUaQFWPg6oKN/g8wdCKqNKp+VxQGWggVRh/r12NSeq5/m1HI1IlRJVfmn2sQVqwdVrlGnJeaWJgUpLvow6HDTjRBRGbpHC5wID09WUW8F1FOkl+HusV4TyxeHJL41USWpqfCBfgCitrCLSmKd2stgMKs7Lsy6WxOFgXiboIHzj81+jVdPsHGSmpaNrAdFjXcuDB5RRQ20yXvOq7j4rHux/BHSNkShLD9AobOFkyCGb3gjDqrgwbw0JXpt1GQCwKj4gGrJ96QzkM4h521mdjQcuc0BABoOmb49tzNVIBAkczRhsIqrjMBLAnj/bJa9CF3UJ0fRmtpp6GJ9ORpb1IbW4r0xSJ+IwLi/JkAMRfBhUoF7G7bjwPA9ang/lzmYLiyGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(186003)(83380400001)(38070700005)(66574015)(5660300002)(86362001)(38100700002)(122000001)(15650500001)(2906002)(52536014)(8936002)(41300700001)(55016003)(478600001)(71200400001)(9686003)(26005)(53546011)(76116006)(6506007)(66446008)(66476007)(66556008)(4326008)(66946007)(316002)(64756008)(8676002)(7696005)(54906003)(6916009)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3hjOThsQy9aMGREVDlPeWplYXJPMTVDaFR1czB2dTVUV2p1d0JZMEVmNlk2?=
 =?utf-8?B?NFkvL2MyUXZCK0FyM0J0Q2NLcmNVVGJSbUp0NEs4YjZvVEZPVHVPMTNzdC9z?=
 =?utf-8?B?cERJaGFuSjRRTE11VlJvQXZFOXBZZndGYXJNZmxGZ2hpR2kyK3EzVkJ2UkRL?=
 =?utf-8?B?RW9LbTZoYVRuR0F6UVBqRTVqekR2N0JFblJ5ekk1Z1h4dGVqYjN4eGFmUjMz?=
 =?utf-8?B?ZE1oR0UxUVdGRklSSFRxaGNSL0VXTjlGMXByaDN3b2ZzclN6ZFZqV1laSUdq?=
 =?utf-8?B?cGpMQUZlRXhXcHJGc0p4UjR2b2VxUVdVSGtyOTVvUXFqckRxZjA1RlVIRi9D?=
 =?utf-8?B?SGlVZkZXTE1Qa2l0cC9lemVTUGpQaWZIOUU3SHVES0pwNjhEcHR1ZEdubWJ5?=
 =?utf-8?B?QnRsQ2UxcEZ6K1l3ZGdlSlJXRUlRYlhWY1ZaWG51N2pScWI0c0JDOGREaHQ2?=
 =?utf-8?B?TTFlRlFvZTRrU25zdFNSMkRoVjJKYzRPY3hLZWpoUnVZM0dKK3RRYU9sUnFZ?=
 =?utf-8?B?MjdOdldpRFRKK24vLzMxTWdBcE5UeDhDQXpMOEhQV3hreTFjeld5K2xpS3Z1?=
 =?utf-8?B?aHdFejFCM0RBbFhmNkVEeVNPaWM0MGUxMFRoOUF6ZDBDNTcyV203aFdDZXRX?=
 =?utf-8?B?ZUM2bkNWeXhpOTBuNE9QUVJvQ1VRem5SUE5xeWRnb3FuMlROdW9UU3JUblJy?=
 =?utf-8?B?STNYQlNUd0crWmd3UVo0cHlnY2VhWGRZWGhvOUVVajliQ0h2MnlQaTZrQzNk?=
 =?utf-8?B?b3NLNjB3cm1SZkdVZTNLejhmNU1FaXc2aWNLV01VenJlVlZTRmE5NWd3SkFj?=
 =?utf-8?B?TkhWMzhOeHg1dy9sU0RjWGJRK29CdzNtM2tJV3RtN1RoV1hSb0UxYytZSklC?=
 =?utf-8?B?ODNUaXZXUXNoU09OWC9XeXJTb2RTTmp2cW1XSFZZUEFDVTN5UHFvNDZ0S1Zw?=
 =?utf-8?B?VXVGanJrZ3hLeWdWcStZODlNVnR2ME0vQjQrVWxVaDZQZk9xQytLZ0VVWG9F?=
 =?utf-8?B?b0RyYmI3TytCQ3F4QURrbkFndE55U1h4Tk5CbE5ZR09XaG13QUpyRmh5N0dk?=
 =?utf-8?B?dysySGxuaVdXMXFKV044VWFPbFR3dVgraXYrTDRTaWMwZDFJL3FoMW42SW5a?=
 =?utf-8?B?SndtSXhuYW9qQXZQMks2WmtBNE5la2JZYmR2S3pZR2RRdDJoWnFqOEd4L3Y2?=
 =?utf-8?B?VHJFVVByM2FDaXRqbHkyUXMwQ2M4TmI1ZDVQN3VDM3A2bXNJbllDUDdwa1lt?=
 =?utf-8?B?YUlwL0RWWUt5R2tFbXFDTGdlMTZGdktXS1YvUUNoS1RQbG5WczVQd1FjNWFQ?=
 =?utf-8?B?SWhJbVN1NEkyR0NIcENQRU8zRVlxeUgxUC9CbUlPVGw0dUFpSktpTmkycnIx?=
 =?utf-8?B?M2plRGkyV3BGS2lCNGdWZG1rNFpFbDhmNnB6OHF5M0doNThFS090VGp0SWV5?=
 =?utf-8?B?VnFPUjREMkM0UEcrM0pSOHg4aGFvazdRN01qSGVxNmVHUnJEMTQ1WHpabTIy?=
 =?utf-8?B?V2xRVFhOUzg5UmZiTFlNTmpoVytzQmtFQkJIRkJpcU1mUVdCUkhYTlYyWlVo?=
 =?utf-8?B?amRBRTJwcmhialdjaWlqYnJkQnlEVVlJcXFtN0l4emJ4YlRZSmFjY1A1MUxQ?=
 =?utf-8?B?NGkzdDZ2TFZCN3RnVTgybDlLRUd3aitBTVNmendJS3ZmdTJDV1YwZUV5MmlT?=
 =?utf-8?B?ZjV3TDhOZEhTaWVqSCtHUlJRb2dEd1g5TzJTN09pZ1BxeVpmMjljdFVFVnA1?=
 =?utf-8?B?MVBpMkNuT0lQRVBTYjdTWlIyV1RSZkRONFhmQ3NHcDFtZjExUEdFTDFWUG9k?=
 =?utf-8?B?VTF0bnBDL3BhMXVpWDdBWCtpUER5bUcwR1JBOGI1NmlmL3hLaVNOWFhuZi9i?=
 =?utf-8?B?M3RZSTJrODFkY1IxREVSN1kySG0yRnJPZTdYQ0pIQ2ZBUWxtTFBkUjNSVEs3?=
 =?utf-8?B?bW9FOElERjc2aTRHaldrd0xBTU5CbzNCekRWOGp2bmpSYkV0RTk1cTFmVlRa?=
 =?utf-8?B?cmpTZ0p6Rm51dWx0WHRnb2dFbnh1elNKb3ZsYU1QZWQ5d0drL3lMSHpEOXd0?=
 =?utf-8?B?VGlVOWowL2VtamJBWTh0RnN4ZHhsK1lrM3VmRWVzWTFoRU9qVDd0WFRmSjVF?=
 =?utf-8?Q?iGEdAi9Th1ClNkyp/iiFm+H2f?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: actia.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ca97f941-3b2f-4d33-0247-08dab5daee59
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 16:15:13.2499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86314f06-03e8-4460-82f3-a44f992a19c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lfkKGrLj+mVwzBDWVW66pDJwZiHEVj3EY67009A5uKs3oofD/r/kJVnF14WDhRhmbpVPZOGczV6lWRQXAxTNoS9FgaTyHEYwpOsSABFyyPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2979
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgT2xla3NpaiwNCg0KPiBIaSBTZWJhc3RpZW4sDQo+IA0KPiBPbiBUaHUsIE9jdCAyMCwgMjAy
MiBhdCAwMToxNzozNlBNICswMDAwLCBTZWJhc3RpZW4gRkFCUkUgd3JvdGU6DQo+ID4gPiBPbiAx
Ny4xMC4yMDIyIDE0OjU1OjU4LCBTZWJhc3RpZW4gRkFCUkUgd3JvdGU6DQo+ID4gPiA+IEhlbGxv
LA0KPiA+ID4gPg0KPiA+ID4gPiBJIGFtIHdvcmtpbmcgb24gNS40IGtlcm5lbCwgYW5kIEkgaGF2
ZSB0aGUgc2FtZSBiZWhhdmlvciB3aXRoIDUuMTANCj4gPiA+ID4ga2VybmVsIHZlcnNpb24uDQo+
ID4gPiA+DQo+ID4gPiA+IEkgcmVwcm9kdWNlIHRoZSBiZWhhdmlvciB3aXRoIGEgY3VzdG9tIGFw
cGxpY2F0aW9uLiBBIGoxOTM5IHNvY2tldCBpcw0KPiA+ID4gPiBjcmVhdGVkIHdpdGggU09fQlJP
QURDQVNUIGFuZCBTT19KMTkzOV9QUk9NSVNDIG9wdGlvbnMgYW5kIGlzDQo+IGJpbmRlZC4NCj4g
PiA+ID4gVGhlIGFwcGxpY2F0aW9uIHNlbmRzIGEgY2xhaW0gbWVzc2FnZSB0aGVuIDUwIGJyb2Fk
Y2FzdCBtZXNzYWdlcyBpbg0KPiA+ID4gPiBsb29wICh3aXRob3V0IHdhaXRpbmcpIHdpdGggc2l6
ZSBncmVhdGVyIHRoYW4gOCBieXRlcyAoNTApLg0KPiA+ID4gPg0KPiA+ID4gPiBFdmVyeSBzZW5k
dG8gbWV0aG9kcyByZXR1cm4gc3VjY2VzcyBkaXJlY3RseSBhbmQgc2Vzc2lvbnMgYXJlIHN0b3Jl
ZA0KPiA+ID4gPiBpbiBza19zZXNzaW9uX3F1ZXVlLg0KPiA+ID4gPg0KPiA+ID4gPiBJZiB0aGUg
Y2FuIGlzICdvbicgYnV0IG5vYm9keSBhY2tub3dsZWRnZXMsIGFmdGVyIHNvbWUgdGltZXMsIHRy
YW1lcw0KPiA+ID4gPiBhcmUgbm8gbG9uZ2VyIHNlbnQgKEVOT0JVRlMpIGJ1dCB0aGUgYXBwbGlj
YXRpb24gZG9lcyBub3QgaGF2ZSB0aGlzDQo+ID4gPiA+IGluZm9ybWF0aW9uIChzZW5kdG8gcmV0
dXJuZWQgc3VjY2VzcykuDQo+ID4gPiA+DQo+ID4gPiA+IE1vcmVvdmVyLCB0eHF1ZXVlbGVuIGRv
ZXMgbm90IGhhdmUgaW1wYWN0IHRvIHRoaXMgYmVoYXZpb3IgKHF1ZXVlIHNpemUNCj4gPiA+ID4g
c2VlbXMgdG8gYmUgaW5maW5pdGUpLg0KPiA+ID4gPg0KPiA+ID4gPiBUbyBmaW5pc2gsIGNsb3Np
bmcgc29ja2V0IHdpbGwgdGFrZSBhIGxvbmcgdGltZSBkZXBlbmRpbmcgb24NCj4gPiA+ID4gc2tf
c2Vzc2lvbl9xdWV1ZSBzaXplIGJlY2F1c2Ugb2YgSjE5MzlfWFRQX1RYX1JFVFJZX0xJTUlUOiBr
ZXJuZWwNCj4gPiA+ID4gc2VlbXMgdG8gdHJ5IHRvIHNlbmQgZXZlcnkgbWVzc2FnZSAxMDAgdGlt
ZXMgaWYgRU5PQlVGUyBpcyByZWNlaXZlZC4NCj4gPiA+ID4NCj4gPiA+ID4gSXMgaXQgdGhlIGV4
cGVjdGVkIGJlaGF2aW9yPyBIb3cgY2FuIHRoZSBhcHBsaWNhdGlvbiBrbm93IHRoYXQNCj4gPiA+
ID4gbWVzc2FnZXMgYXJlIG5vIGxvbmdlciBzZW50Pw0KPiA+ID4NCj4gPiA+IEl0J3Mgc29ydCBv
ZiBleHBlY3RlZC4uLi5JIHRoaW5rIHdlIGhhdmVuJ3QgdGhvdWdodCBvZiB0aGF0IGNvcm5lciBj
YXNlLg0KPiA+ID4gVGhlcmUgaXMgdGhlIHNvY2tldCBUWCB0aW1lb3V0IG9wdGlvbiwgc2VlbXMg
d2UgaGF2ZSB0byBpbXBsZW1lbnQgdGhpcyBmb3INCj4gPiA+IGoxOTM5Lg0KPiA+ID4NCj4gPg0K
PiA+IEkgcmVwcm9kdWNlZCB0aGUgc2FtZSBiZWhhdmlvdXIgd2l0aCB1cGRhdGVkIHRlc3RqMTkz
OSAoc28gbm8gY2xhaW0NCj4gbWVzc2FnZSkgdG8gYmUgYWJsZSB0byBzZW5kIG11bHRpcGxlIG1l
c3NhZ2VzLg0KPiA+IFRoZSB0ZXN0cyBoYXZlIGJlZW4gZG9uZSB3aXRoIHBlYWsgY2FuIG9yIGZs
ZXhjYW4uDQo+ID4gU2hvdWxkIHdlIGxpbWl0IHRoZSBza19zZXNzaW9uX3F1ZXVlIHNpemUgdG8g
bm90IGJlIGFibGUgdG8gaGF2ZSB0b28gbWFueQ0KPiBtZXNzYWdlcyBpbiB0aGlzIHF1ZXVlID8g
SW4gdGhpcyBjYXNlLCBzZW5kdG8gd2lsbCByZXR1cm4gYW4gZXJyb3IgKGFuZCBub3QNCj4gc3Vj
Y2Vzcykgd2hlbiBpdCBpcyBmdWxsLg0KPiANCj4gQ2FuIHlvdSByZXByb2R1Y2Ugc2FtZSBpc3N1
ZSB3aXRoIGoxOTM5Y2F0IGluIGJyb2FkY2FzdCBtb2RlPw0KPiANCj4gVGhlIGRpZmZlcmVuY2Ug
YmV0d2VlbiB0ZXN0ajE5MzkgYW5kIGoxOTM5Y2F0IGlzIHRoZSBsYXN0IG9uZSBpcw0KPiBkZXNp
Z25lZCB0byBnZXQgZXJyb3IvY29tcGxldGlvbiByZXBvcnRzIGZyb20gdGhlIGtlcm5lbCBKMTkz
OSBzdGFjay4NCg0KSW5kZWVkLCB3aXRoIGoxOTM5Y2F0LCBJIGhhdmUgbm93IGFuIGVycm9yLCBi
dXQgaXQgdGFrZXMgYSBsb25nIHRpbWUgdG8gY2xvc2UgdGhlIHNvY2tldC4gSXQgc2VlbXMgdG8g
YmUgYmVjYXVzZSByZWN2bXNnIGlzIGNhbGxlZCBhZnRlciB0aGUgbGFzdCBtZXNzYWdlIChzbyBq
MTkzOSBxdWV1ZSBjb250YWlucyBhIGxvdCBvZiBtZXNzYWdlcykgYW5kIG5vdCBhZnRlciBlYWNo
IG1lc3NhZ2Ugc2VuZC4NClNvLCBpcyBpdCByZWNvbW1lbmRlZCB0byB1c2UgajE5MzljYXQgbWVj
aGFuaXNtICh3aXRoIGVycnF1ZXVlKSAgdG8gc2VuZCBqMTkzOSBicm9hZGNhc3QgbWVzc2FnZXMg
Pw0KDQpSZWdhcmRzLA0KU8OpYmFzdGllbiBGYWJyZSANCg==
