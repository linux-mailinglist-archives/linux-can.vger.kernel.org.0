Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E860615D
	for <lists+linux-can@lfdr.de>; Thu, 20 Oct 2022 15:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiJTNT3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 20 Oct 2022 09:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiJTNTL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 20 Oct 2022 09:19:11 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on0609.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e19::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1598319D8B4
        for <linux-can@vger.kernel.org>; Thu, 20 Oct 2022 06:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZjwt5seaINR7LveO2iRk7EWYSSbQ23DSfeKXP79TgNsJI8OqxI5Y9kOGjoNtuJsr06rMTemZe+PB/75BsZ/i0b5OnMAEamzAgOoGI16ujItSr29A6KZ/PW5De/5/ke89YTfgeZvSO6iWH8KRn7r2XTrPzIAbtqd6P3lsKMsBYQRQYNr1LwPZJ7DkdIM2r/5R/hQeke3jmTuqzOEcay6BulxLG8Exa07WircY61+5M1VKWYfC1hYMuYknJc13jsHwc3dRfiOvJH5YlR5ofpc719aYtIfbtjOU2X5QPsvswHQhHr7Jda7lZK95is+S1+vyMCPx/JEYxIzSC+uyoNswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzeKHV6vgdKD+rHMGKFZSrhltjC+Sunj6/3HFSVwY80=;
 b=QZQ+S+59tEvUM52d4KhrUOCGmcol7wG3PCK9aau4aM770wReLoQGLO2zbdhlML7RciUV/4CYvKliAf1Vx+7EGlDZNm2GLNJPyySWwH7ePNIr61NYNeEzmyxxJXR8ZCpIo+XJNWuMvGcDW8iIN2l0TZs2T7gKwhcmXSBBLP+lnZ8gD3MuXoCQn0ENTkUHvJbab8Drsmwlk+jSZTE+hT3V9e6V7ASq9UsVS9asinsB+oxgnAd9MC9EufZZhAhOrwWxfUiVhNJesaYIZCSB7NhvbZ14sHly/lVoj/IAeZQmuD57WrUwYCpDvJnKy/PmEi6T2JnsTU9pWfBf32jV2GcF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=actia.fr; dmarc=pass action=none header.from=actia.fr;
 dkim=pass header.d=actia.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=actia.fr; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzeKHV6vgdKD+rHMGKFZSrhltjC+Sunj6/3HFSVwY80=;
 b=GH5HzgqdnpSXSTpNmLandZL7idVIHEVBsh9Lyp/aNnAwDNpwJ07dYpWQyWnBP9FBsaGcHYcSITfFp8IMzJQZ9trEmzA5dwl5bsvSNvETFVdC4fTRjBbis1OkCRoHK5QcU6Un2PqHsDZvOdVSrmjS3bfQ5IcZ9uGryTtj3Utvqns=
Received: from PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e0::12)
 by PR0P264MB1866.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:169::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 13:17:37 +0000
Received: from PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM
 ([fe80::4cbd:493e:7d7f:22ce]) by PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM
 ([fe80::4cbd:493e:7d7f:22ce%2]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 13:17:36 +0000
From:   Sebastien FABRE <sebastien.fabre@actia.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "ore@pengutronix.de" <ore@pengutronix.de>
Subject: RE: J1939: Send messages without acknowledging
Thread-Topic: J1939: Send messages without acknowledging
Thread-Index: AdjiOArCihCCUJS2S0aV5OLbcs6cdQAqML8AAGhoI9A=
Date:   Thu, 20 Oct 2022 13:17:36 +0000
Message-ID: <PR0P264MB23094D0D6CA05334809ACEE1922A9@PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM>
References: <PR0P264MB23096FC238E648331A32B5A492299@PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM>
 <20221018110016.sgvh2prqm5ehstxv@pengutronix.de>
In-Reply-To: <20221018110016.sgvh2prqm5ehstxv@pengutronix.de>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=actia.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR0P264MB2309:EE_|PR0P264MB1866:EE_
x-ms-office365-filtering-correlation-id: 0650b69c-cb12-473c-e7c5-08dab29d750a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G9qILPDcmHobYpePvc/Yc8Sgaq8oCUTRpsr6PyyPYGBU2Hj0fTMtEk9GvE6lyJHA2SjQ4sNk746Hyb4mNo7k20dMp1i2R3RqXwmvo+4+zUaRYllAZFqf87QfE50IP8LVMwSvr3uxleo1vU8zcrvKFkV9FPQTVn/O6DMmFG7tnU7jH1zB0XB9m7fZO1y1M+kHOAIqVX4Ce8SGg66BlnYC5CMAKl70Sc84kEVs+JWbEjYy+3kU5WDK5sNJVVLhmn6j4T5vvW7ygEXxivON7uBgTiXUUPTyVj+0W6bjSrgcy7E9UoMR7IrTZv6TaWijOdwTLBnJYN6eVnvVbsH+ai+Lljv3X27wX14seqt2klY3LiWKYlyak/HWOTyCEH7oMyhfE3b8lr03+l4pmy7gsRsgQr2tNj1qOKI25qP6LufaPfAntA4fXXp9xO6V55Z74lkapiUQhIqQZxdQHglPril3OQzmerSRHXhYI3K9xPeT/DThLkMCCNP5kMIkAQtk+hlxBqUR9Y1aGXbHH0B8oWg+O1bIxHlCTftZ/PtkvY5bBLNZGolVuH05uPMA1qWeBVZuQeU5I58gTpsxB7D9wA/BDsRK+fhG+2lgfwL7faP7WcB2JuziegZ87e8sXVUOXYDr519E/nCtTb4GTLCiW3VasFmGQXKamA9ggjHo5rl+rau62Ys5pId884rZ+GkhXzctvkQ15IRjvpc0Km8rYRdIDSnCm0EmyCamibSmnM3SfWm4MNW69r4gEKeg80WPs6dW5GiDquMmn6H5NpcejX1Fxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199015)(316002)(33656002)(8936002)(2906002)(6916009)(52536014)(15650500001)(54906003)(71200400001)(38100700002)(9686003)(122000001)(478600001)(38070700005)(5660300002)(86362001)(53546011)(6506007)(7696005)(26005)(76116006)(64756008)(66446008)(66476007)(66946007)(66556008)(8676002)(66574015)(186003)(55016003)(41300700001)(83380400001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGo1OVJKMXByc2FaZWFHT05VR2dYUWZXN1Vqc1YrbnBicE5xc2VTSGh1SWkz?=
 =?utf-8?B?Zjk0WWJPbmFwUUhLeFRLQmdSMWZoanFyT3FLRmJoU1JaeUVkcHZTaEhtZ2RT?=
 =?utf-8?B?NytlNFIzMWpnbTd6QW5yUmhxWllTQTNzTmIxTmhlQXNGNnB3azJNUnhseFdW?=
 =?utf-8?B?bFI2c0JFckhxdjhNVHZHd1lzZzQxVVhDblJSSzIzSDYrY1BaM0d2YUpGNEYz?=
 =?utf-8?B?RjNaVXltY1dIZGlhWStMNjRhNG9SSlJrcnV0OWNOc2J0UGo3UXBhM3VScEQy?=
 =?utf-8?B?RnRrRVIrL1dzOEsrQTRSOStJVHU5UFpHMCs2N0Rja3duTEFMeGxRb0gyTit1?=
 =?utf-8?B?VzhxQkV2MGtMNDArQ2hBS1ZELzFaaVZNOTNBL3lWNkxScUozd29jSGtaelND?=
 =?utf-8?B?L01pMStveUxBaEpMR1lxRThKY3Z6Z0Z1SGlpUG5ETEZhU3BxdG5WYzlVMzB5?=
 =?utf-8?B?YzI5emRaamVWOERycG45eFVaTUppTVUrdURKelhlSk9PQjFpTmc3OEFzRHRM?=
 =?utf-8?B?RWEraFZMOW1oYW5FRmxIcUpsdk9Sb0lTWC9lQUZnZ0wzVU5HdVZDOFBEczNS?=
 =?utf-8?B?REJ5aXhFMUZEeFc1TmtlZTVWK3psN3dWWVZKVVRqdWNORC94aWRxTXBtcWln?=
 =?utf-8?B?VlQ2ZElXb2R5anZ5eUpzU0lYaHpOSmovRzZaUG5mU2NQZWg2MVpEYjF3Y29J?=
 =?utf-8?B?M3hGbmdaWk94eHVZYU15WkM5NTFJOXpraEVpVmNmRldsQUl2Y1VEb2c4aUJK?=
 =?utf-8?B?OUpiRXl1MzJ6VFZ4SzF1a1ZxWEF0Qi96RnJmb0tDY3NRTXoyRUF6Zmh1Qk03?=
 =?utf-8?B?L2NqYjFsTGdaaHhxWXltaHZ1dnl3L0dLNW41RDUvZVBRVk5UOWYxQVZVN0VM?=
 =?utf-8?B?VjlHRVpIaDg2WXQ3WlRXdWpINGZ2TnJUdGJLQ0RhOU9lZ1hJZlNKdFVUNWpZ?=
 =?utf-8?B?WUoweVVQU0F2bjI5UENqZ3FjYS9sZk9tUHRwVjFuUXF0a01uS2FQQU5Gd2VZ?=
 =?utf-8?B?MFJzdW10T1BTbnNPSHJUMXRJcTlYVjRGaFJTQmFtY3c3OXJRWmtlMncrUTB3?=
 =?utf-8?B?eGRWcVlmbUZTVTRRd1F3R2hPb0NleG0vQVJZSW9DTnlpT2Q1dGlTL3ZJOW1D?=
 =?utf-8?B?L0VrQmIwSlVHdnZRa2ljRk91V000a1d4c0l4VkMwUU1UZkM2UytPbjU0LzFu?=
 =?utf-8?B?a3RoTzVDeWtkdGk4V3huUnpqTU44M1JaaUdwZzdaUGV4UGM3amZ6REcrdUgw?=
 =?utf-8?B?NllXcndaSnNoNGE2c0p2UExPbUNzdjByakYxUUxaVnEzNlBBa2ZrOWovTnJt?=
 =?utf-8?B?em5hSE84WDR6N2NmNkJRbndsTzl6SFZ0WHZ0SllxbmgwQ2xNcGQyQzAwamdn?=
 =?utf-8?B?UktuK0hGbGtjY1lWYVJsaFl4L3BJREpCSTBzOHduR0tLL2didjZ5cUZNbCt5?=
 =?utf-8?B?OVJ5WlN6Z3grY3FPckRScEFvczhRSy8weFZGdkpldW9TMTU1RDdOWm44MU5C?=
 =?utf-8?B?NHlnL1FIakljMk1jYTBUMUszVVV5MDJmWmZJeStEaHNwV2NQS1VDYUFSOWJD?=
 =?utf-8?B?RUppcVlCeHhzTHgyT0dEUjFWNzhPb0lLakxXU2h6MnVMSGYvcUFQYkhSbm41?=
 =?utf-8?B?YSt5clk3SUxQcVhqbGlWaEFiNVMwZHROalZBbU9VbGdhT2FhOTliUUNDSjdh?=
 =?utf-8?B?Wm9MclRyNE1pN2dveHJJaklPQitmYWlSNVB4Z01zaHl0MU1NTzZ4WmNWR2FX?=
 =?utf-8?B?U1Y4UmlWRkpjcnJEdHhLQlo4dTFQNDhYVDJNbjYxT2R1VW9qYW41ZEZFRkN2?=
 =?utf-8?B?bTZkS21TSXNiRDArcjdJTGRONmo4RW1Ja2V2azBoaFcrMHNSL0dxWER3Ti8v?=
 =?utf-8?B?alVMeDVNU3djQjBLVE00TENmRVBXM3o4OVZBSHZpSWdUd1hGVGkrOWcrRFJ0?=
 =?utf-8?B?YUZaMU5sZkdGQnI2UVZib3ZaTWY5UUNZclVjaXVHTk02Um1tTGp4aGNMVmxT?=
 =?utf-8?B?S0JOZmowZTJCWGtERXV1d0JhZzZjb1crZnRJTnpXS0lhd25aY0FUMERHSldV?=
 =?utf-8?B?bE9jWUhUQjVacXdSaXBHV3ROM2Z1c1UrZlRqcDJJMml5L1pSZEJOU05UNVY2?=
 =?utf-8?Q?lUEhUNS4zcPXGhjXyfxHPtJTb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: actia.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2309.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0650b69c-cb12-473c-e7c5-08dab29d750a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 13:17:36.8981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86314f06-03e8-4460-82f3-a44f992a19c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2B2uuGm9pzmh2bHaWrljWYsk0K+LdX7URHCvgFS07cGJdgnUX1k+KGw936IEQ0NcGWhHuVCi4mduqymd5LesHLbXclp8GNBqWJyoo8HU5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1866
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBPbiAxNy4xMC4yMDIyIDE0OjU1OjU4LCBTZWJhc3RpZW4gRkFCUkUgd3JvdGU6DQo+ID4gSGVs
bG8sDQo+ID4NCj4gPiBJIGFtIHdvcmtpbmcgb24gNS40IGtlcm5lbCwgYW5kIEkgaGF2ZSB0aGUg
c2FtZSBiZWhhdmlvciB3aXRoIDUuMTANCj4gPiBrZXJuZWwgdmVyc2lvbi4NCj4gPg0KPiA+IEkg
cmVwcm9kdWNlIHRoZSBiZWhhdmlvciB3aXRoIGEgY3VzdG9tIGFwcGxpY2F0aW9uLiBBIGoxOTM5
IHNvY2tldCBpcw0KPiA+IGNyZWF0ZWQgd2l0aCBTT19CUk9BRENBU1QgYW5kIFNPX0oxOTM5X1BS
T01JU0Mgb3B0aW9ucyBhbmQgaXMgYmluZGVkLg0KPiA+IFRoZSBhcHBsaWNhdGlvbiBzZW5kcyBh
IGNsYWltIG1lc3NhZ2UgdGhlbiA1MCBicm9hZGNhc3QgbWVzc2FnZXMgaW4NCj4gPiBsb29wICh3
aXRob3V0IHdhaXRpbmcpIHdpdGggc2l6ZSBncmVhdGVyIHRoYW4gOCBieXRlcyAoNTApLg0KPiA+
DQo+ID4gRXZlcnkgc2VuZHRvIG1ldGhvZHMgcmV0dXJuIHN1Y2Nlc3MgZGlyZWN0bHkgYW5kIHNl
c3Npb25zIGFyZSBzdG9yZWQNCj4gPiBpbiBza19zZXNzaW9uX3F1ZXVlLg0KPiA+DQo+ID4gSWYg
dGhlIGNhbiBpcyAnb24nIGJ1dCBub2JvZHkgYWNrbm93bGVkZ2VzLCBhZnRlciBzb21lIHRpbWVz
LCB0cmFtZXMNCj4gPiBhcmUgbm8gbG9uZ2VyIHNlbnQgKEVOT0JVRlMpIGJ1dCB0aGUgYXBwbGlj
YXRpb24gZG9lcyBub3QgaGF2ZSB0aGlzDQo+ID4gaW5mb3JtYXRpb24gKHNlbmR0byByZXR1cm5l
ZCBzdWNjZXNzKS4NCj4gPg0KPiA+IE1vcmVvdmVyLCB0eHF1ZXVlbGVuIGRvZXMgbm90IGhhdmUg
aW1wYWN0IHRvIHRoaXMgYmVoYXZpb3IgKHF1ZXVlIHNpemUNCj4gPiBzZWVtcyB0byBiZSBpbmZp
bml0ZSkuDQo+ID4NCj4gPiBUbyBmaW5pc2gsIGNsb3Npbmcgc29ja2V0IHdpbGwgdGFrZSBhIGxv
bmcgdGltZSBkZXBlbmRpbmcgb24NCj4gPiBza19zZXNzaW9uX3F1ZXVlIHNpemUgYmVjYXVzZSBv
ZiBKMTkzOV9YVFBfVFhfUkVUUllfTElNSVQ6IGtlcm5lbA0KPiA+IHNlZW1zIHRvIHRyeSB0byBz
ZW5kIGV2ZXJ5IG1lc3NhZ2UgMTAwIHRpbWVzIGlmIEVOT0JVRlMgaXMgcmVjZWl2ZWQuDQo+ID4N
Cj4gPiBJcyBpdCB0aGUgZXhwZWN0ZWQgYmVoYXZpb3I/IEhvdyBjYW4gdGhlIGFwcGxpY2F0aW9u
IGtub3cgdGhhdA0KPiA+IG1lc3NhZ2VzIGFyZSBubyBsb25nZXIgc2VudD8NCj4gDQo+IEl0J3Mg
c29ydCBvZiBleHBlY3RlZC4uLi5JIHRoaW5rIHdlIGhhdmVuJ3QgdGhvdWdodCBvZiB0aGF0IGNv
cm5lciBjYXNlLg0KPiBUaGVyZSBpcyB0aGUgc29ja2V0IFRYIHRpbWVvdXQgb3B0aW9uLCBzZWVt
cyB3ZSBoYXZlIHRvIGltcGxlbWVudCB0aGlzIGZvcg0KPiBqMTkzOS4NCj4gDQoNCkkgcmVwcm9k
dWNlZCB0aGUgc2FtZSBiZWhhdmlvdXIgd2l0aCB1cGRhdGVkIHRlc3RqMTkzOSAoc28gbm8gY2xh
aW0gbWVzc2FnZSkgdG8gYmUgYWJsZSB0byBzZW5kIG11bHRpcGxlIG1lc3NhZ2VzLg0KVGhlIHRl
c3RzIGhhdmUgYmVlbiBkb25lIHdpdGggcGVhayBjYW4gb3IgZmxleGNhbi4NClNob3VsZCB3ZSBs
aW1pdCB0aGUgc2tfc2Vzc2lvbl9xdWV1ZSBzaXplIHRvIG5vdCBiZSBhYmxlIHRvIGhhdmUgdG9v
IG1hbnkgbWVzc2FnZXMgaW4gdGhpcyBxdWV1ZSA/IEluIHRoaXMgY2FzZSwgc2VuZHRvIHdpbGwg
cmV0dXJuIGFuIGVycm9yIChhbmQgbm90IHN1Y2Nlc3MpIHdoZW4gaXQgaXMgZnVsbC4NCg0KUmVn
YXJkcywNClPDqWJhc3RpZW4gRmFicmUNCg==
