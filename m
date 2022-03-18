Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB124DD772
	for <lists+linux-can@lfdr.de>; Fri, 18 Mar 2022 10:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiCRJ4I (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Mar 2022 05:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiCRJ4F (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Mar 2022 05:56:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21CA2B8818
        for <linux-can@vger.kernel.org>; Fri, 18 Mar 2022 02:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBJlCpX9fCze275A7D4MYfZA82khvEe69hnVkpmVmCTAF/fUiq1zdF3b4pp798IMVipdohz3HGuTu2szWWq95lLCgfXRs3nMimDOEjhJbOjQaeE1O5QEMxAGRUNQ+boq5AgW6F6NROiV68BT+7LDZt8VPBuvPuUGhCZ5PWWTn/F+mUIFoL97l9AKPa3vRquNaBL9NKPDrBTLyOKdThfuQhqwFxw7sCOg+xJuOH6JrGFa8FA/d2Vx63iN5cP14ZogDuVtVJixxOYiG7QgEmQXXdANn8Y3GmpY/wAet35apS9RQJpWZHzNPbBuhI3M+vIcyhYZpu/ZsmqiX3kD7KlDzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z91xttiPfceX9IpftVx3iFjzelz0I+pW7YWmS07eXhw=;
 b=cy+U5Yb767VaCGYeQv5GRplPM3NY3nh9b/h0VITdDQIUmOwnDWbhq9e2Y8bce6145RpgP17a2hIc12D4pXKCjrJBl0M7NAx91H52StHvn1z8scj6NH7x8X3xgftMhKv0VMFP4OU320+OMXM9JR1jlSBoV8jILkXdmYSVgEZ4CZIZ+lFv9z2jMUilrL2OnRFWzHYfMkj0pmSmSFNwBYAORq1tST7eF8vagUgFpMDGHYCnPiC0MoDwkRBe2MbcSjBPkxzH3qACU1mqfEz7b32AyBq5HjNf98FwIzsaMxjTsO+gRa3wW18aQ2tZyixD4D5R+wqgnY+PbgN3aQPuIMDxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z91xttiPfceX9IpftVx3iFjzelz0I+pW7YWmS07eXhw=;
 b=GYR1dnw51h9VXAQQwvOSNS/FhsmkwKR0s4vRS6NIvQZVGt4Y1mP/3A1TVXi5+VTBiITaYvr2Crcca+NDPUsojj6uqipYTgKkjauPlo6Vn+B3IgI+CEDWBJI5oObjv9TxEsI0Mr1dqpq9YSzTczpDl4X64Yo0OP+TQUnn7yxbOAo=
Received: from DM6PR02MB5386.namprd02.prod.outlook.com (2603:10b6:5:75::25) by
 MWHPR0201MB3451.namprd02.prod.outlook.com (2603:10b6:301:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 09:54:38 +0000
Received: from DM6PR02MB5386.namprd02.prod.outlook.com
 ([fe80::b990:6b88:f32f:1e9d]) by DM6PR02MB5386.namprd02.prod.outlook.com
 ([fe80::b990:6b88:f32f:1e9d%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 09:54:38 +0000
From:   Srinivas Neeli <sneeli@xilinx.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <stefan.maetje@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: RE: Queries on CAN frame work
Thread-Topic: Queries on CAN frame work
Thread-Index: AdgIqTVMB9fKzsHaTwKoGWnAYyrjVgAEyNAAAAFntwAAaVWWgAcyW0GgBMZsb4AAEFxkcAAFp2EAAAKQCfA=
Date:   Fri, 18 Mar 2022 09:54:37 +0000
Message-ID: <DM6PR02MB5386167ECF8C0CE87AC15DA6AF139@DM6PR02MB5386.namprd02.prod.outlook.com>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
 <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
 <20220115232621.4ybmmrmgogies3o5@pengutronix.de>
 <DM6PR02MB538689AA158B340FE287CF05AF3A9@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220317220033.pxfioxhgxmm55b3f@pengutronix.de>
 <DM6PR02MB53866545ABAF3FBC596D43A6AF139@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220318083054.iukyynbnrnrvtrqd@pengutronix.de>
In-Reply-To: <20220318083054.iukyynbnrnrvtrqd@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b16a133-6598-43e0-2183-08da08c5509f
x-ms-traffictypediagnostic: MWHPR0201MB3451:EE_
x-microsoft-antispam-prvs: <MWHPR0201MB3451527139D0BDCF5AD253CFAF139@MWHPR0201MB3451.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wRl4iDsf7rnWQTHMgcEpiJKOStEkAgbusyHWUAqrolqxMrW18YEqF1qQlSmE8dfKxP+FMhgfDSPvFzeydv+geuhWqZ+MyDyuzIEs+HdWNSS48/cl2w4in8w/c2G8gAXrQQK0mTGrZYBO9tahIm6OE76yxZpaWgiQ1fN35u8WrAdxTrkH1Ei6+5jhYLIghr59mFtAYhVZuze6j/Aq5PcXIW9dMb9Q7hoMvDRswfLZqPgUOxReXCUn9uMO7Pb3vuf2c5ySZM059StcDWXb3lCMiG9hymMQtE7oYY6hxfMEWSmaT6kn+Gri7iCrwJHKaO10c/UTb87pX9P2brT92a2XMJsZ/3pckbFtGmMp4Gj4FJCmVlB42y2/d51TTTnbOjEAedLAHq5usso9aLujFYvoFq00TYILR+uygYyV1OODwhsN6R5WuTSxL5eD8okMi1j+s8kCkXcG5LLbGfsd1PIOh0IV2m8M7CIDR3gE7ckyFjvkFezWBw4pbfckY0W1TMR00Wn/J60UCRZQ4BBXczbX1908C0XmyTFqKZO4sG2522xmp47MLNPvA9DSoK8GDIF7NwSGgKPCHI/VYy+Fk8ALDCKgc8o1/pfiF+1rGTO2SaUEJd+FTKJ2aEecLDdmCaz2Ta+hRqknBpylSzwQMLJwLzEXf2g9Fsi+bDm0SdfhNNHR2iG4aXPFpzEj6k0lksVPrnQ8QEgIRAbLm2lkAnlB8Y4p6g7HI9rzW95GmJaiSCZLbt3pPBA6Cyl1j5OJBDEMd8iYpUdCPCxHH3IhrdCp4f2Buvc6VQrai7nE8lNiWX36JdFmRh7JhvL3Q5lJuzPjoHsVlS8qyuhqxh1jtz3sBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5386.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(54906003)(316002)(76116006)(4326008)(55016003)(38070700005)(66946007)(64756008)(66556008)(66476007)(8676002)(2906002)(52536014)(8936002)(122000001)(5660300002)(7696005)(53546011)(6506007)(966005)(9686003)(508600001)(186003)(26005)(83380400001)(38100700002)(86362001)(33656002)(71200400001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkRobHJiSVc4S0Z3MVR0QXlUanJtaDdjSTJ4b2dXSlVkMFQ0U1MvMVlUdUNX?=
 =?utf-8?B?dUlIdndOQ3BTZEN2aWVxd1YrYVVBSzA1S3lkUVRML2ovS1VyS0ZMMVJFaFVJ?=
 =?utf-8?B?L1NUUG02MTVKWU04dFpEQ0hLUTZEUUl0UXB5MjdqdXVTWHU1OFBHek5DekNk?=
 =?utf-8?B?ZExXdmZHTXA2ZkVTQmlxbFdZRVNNSWRPNUlHZmNWNkRmc09tcXM4SGZYZG1n?=
 =?utf-8?B?MVFpZThTVmt6cEdaSXN1WXVJZ2FTSStZSWViaThaeHl6QStuZ2dGdzdYYWJw?=
 =?utf-8?B?Zjh2VldZM0ZDS25MQ2RzZDNYZTBXY2g4c3pJdUpFdGVudWNBSkkzZTBjRXhw?=
 =?utf-8?B?L0p1ekZ1SHFrMHBBUnk2TFJ3QWcrYWJtc21Kc2VpSVBRYU12c2dDaWlrY2NH?=
 =?utf-8?B?SjJVVHRnZVRDSE9mdENhWDgyVUwvbHhtZmMxQ3hLSWtnb2o2SWZyZnNSaVpp?=
 =?utf-8?B?NjZHc2lXSTIvQlJGOEFISElZNWZ3T0pXU2pFb1pZdVR3eGUydm5oRXRyWUZM?=
 =?utf-8?B?bFU1Sy80UDI4VkxnWlJyVG1xRWkyUmhGMUp3RkF5ZW5mQ0tLcHppa25tN0xr?=
 =?utf-8?B?ZkVrNlN5ZHZtNHFDaEM1MitNZnNMQzVkVndZdWlPaG43QnMxZGlWc0VYU1JI?=
 =?utf-8?B?OVZmSVk4YlkxYlJnZUI3Snk2aEplSmZDR1VRcU5rQjRQS1p0Y010VlU0ZzFR?=
 =?utf-8?B?dVpyQUVSTTVHMER4Ym9RaVRsY2JuY3gxcjNGNGpoNTFENGNOV2FrQitIT0E0?=
 =?utf-8?B?L2lmTUlJY0Y5M3g1Q0J3QnhtYUdmKzYzdlNneXhDK3ZQYlF6cG1SOE1YclVW?=
 =?utf-8?B?U3U2cVVJT2gzNldiYTlpNVBtTUZ3emVEYjBLUVp3RmhuZk43K1Fhb0RhYWxk?=
 =?utf-8?B?VDJ3SmNDRFBydjZLN0tyaHAyRkZRU1F4QzF4bE81Nm83N0g1STFxTTUwS3k3?=
 =?utf-8?B?OTFhQUFWRG5kQWFrenQzMXJ6N0ZxOTZ4QXhiN2dVT0dwcTNCd1EyWWtWNVFs?=
 =?utf-8?B?MVFla3BPSVRhalVvenJtRHBvOXd3VTFpZWVzYXpYU0ptZ3NidmtxTGRtdk5Q?=
 =?utf-8?B?cjVTOC8ya21STmMwcjZsbTFIbmVXUmZYbU9GMnNCbjAra08wcS92UU5FUyt1?=
 =?utf-8?B?MXVMZ2lZbDNWeFl3Szl4ZTM1VzJlVzlmUmJSbG44a2JaMXNOZlRTaTd0SVhZ?=
 =?utf-8?B?SzloUGN0cldlZ1NsNmRnbko2dGROQlVtc3htaXBXS1NKRGRIRmJ0MmdySEZ0?=
 =?utf-8?B?TGhXaTlCK0hlTE5qRjJuQ2xVZU4raXd4QWNyM0g0b1hQSGtEbmRlUENjQ3VE?=
 =?utf-8?B?VC90TlgvbDFFdU1XUEpzSlJSVUVYYkU1d3VxeC9CODhrenlOc3Z1d2JKYitG?=
 =?utf-8?B?VFBhN2hJUFpxSzZOU0EvTjVaWG0vdE55M3A2bmZUOElkOUk5NVFWUnlOM2dK?=
 =?utf-8?B?R3lYK2ludERmYXEzZHJvKzFTRFZPSjRPbTRIcDVkbWFKY21GWlNQVzMraTNS?=
 =?utf-8?B?VXR3a3YwN0g1WFlUQXhiSFhjbjN3cEFPaEtLMDd3ZzN0UE1TajdHQXJXZjUz?=
 =?utf-8?B?NE1kclJzVDJsVEd5bWZUK0pCQWpTdGNRRHI4Zi8zTU83MzNmY0dNRlAwdHhS?=
 =?utf-8?B?RDA4RmtPdkFvdVhvSU1CckQrdDlET0JlenB6empvU3lONVdlZHNqNk9JQjFH?=
 =?utf-8?B?MElwTDRCRzBTcE1OL1oxUGtkZHlQbFhiZ2VUWjJkTDVGUDFIYjllbVdXTmQ3?=
 =?utf-8?B?MWdmM1NLY2FzRVhOZitRZmE1a3JyQWt6Q0l3anVnTkQwMWJtbWtBbTkxTzU1?=
 =?utf-8?B?akZ0KzAzSzExZzRsdGIyYWZTL290TkVLKzNVc2RtNmpXaisxWnZiajZNR0c0?=
 =?utf-8?B?TTBMWVZ3OWxoVWhaMmFSWTN5aFhWUUJScy9rc3lxNVdWOUdkSFpEZjM5MWt0?=
 =?utf-8?Q?Bt8Urs+WS12CJQKdTOknaQo1g4QpeqhN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5386.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b16a133-6598-43e0-2183-08da08c5509f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 09:54:37.9750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YNlW8/GhZDgedQl8eI9Nro7ClFo/gGaEEGuCiVUomNLkntD7dG2uFc9aXfosqJl7gwzmSt8Y6qf6o4gOcRVFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3451
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgbWFyYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEts
ZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDE4
LCAyMDIyIDI6MDEgUE0NCj4gVG86IFNyaW5pdmFzIE5lZWxpIDxzbmVlbGlAeGlsaW54LmNvbT4N
Cj4gQ2M6IFNyaW5pdmFzIEdvdWQgPHNnb3VkQHhpbGlueC5jb20+OyBOYXZlZW4gS3VtYXIgR2Fk
ZGlwYXRpDQo+IDxuYXZlZW5rdUB4aWxpbnguY29tPjsgUHJhc2FkIEJlZXIgUHJhc2FkIDxwcmFz
YWRiZUB4aWxpbnguY29tPjsgbGludXgtDQo+IGNhbiA8bGludXgtY2FuQHZnZXIua2VybmVsLm9y
Zz47IFN0ZWZhbiBNw6R0amUgPHN0ZWZhbi5tYWV0amVAZXNkLmV1PjsNCj4gVmluY2VudCBNQUlM
SE9MIDxtYWlsaG9sLnZpbmNlbnRAd2FuYWRvby5mcj4NCj4gU3ViamVjdDogUmU6IFF1ZXJpZXMg
b24gQ0FOIGZyYW1lIHdvcmsNCj4gDQo+IE9uIDE4LjAzLjIwMjIgMDY6MTI6MzAsIFNyaW5pdmFz
IE5lZWxpIHdyb3RlOg0KPiA+ID4gQXJlIHlvdSB1c2luZyB0aGUgbWFpbmxpbmUgeGlsaW54X2Nh
biBkcml2ZXI/IFRoZSAiaXAiIGNvbW1hbmQgc2F5cywNCj4gPiA+IHlvdSdyZQ0KPiA+ID4gdXNp
bmc6DQo+ID4NCj4gPiBZZXMgLCBtYWlubGluZSBhbmQgaW50ZXJuYWwgZHJpdmVycyBhcmUgc2Ft
ZS4NCj4gDQo+IE5vLCB5b3UgYXJlIG5vdC4gQXMgZXhwbGFpbmVkIGluIG15IGxhc3QgbWFpbCwg
dGhlcmUncyBubyBzdHJ1Y3QNCj4gY2FuX2JpdHRpbWluZ19jb25zdCBpbiB0aGUgbWFpbmxpbmUg
ZHJpdmVyIHRoYXQgbWF0Y2hlcyB5b3VyICJpcCINCj4gb3V0cHV0Lg0KDQpKdXN0IGNyb3NzIGNo
ZWNrZWQgdGhlIG1haW5saW5lIGRyaXZlciBhbmQgb3VyIGludGVybmFsIGRyaXZlci4NCkkgYW0g
bm90IHNlZWluZyBkaWZmZXJlbmNlIGluIHN0cnVjdCBjYW5fYml0dGltaW5nX2NvbnN0IHN0cnVj
dHVyZXMuDQpXZSBhcmUgdXNpbmcgNSBzdHJ1Y3R1cmVzIA0KQ0FOIC0gMSBzdHJ1Y3R1cmUNCkNB
TkZEIDEuMCAtIEFyYml0cmF0aW9uIDEsIGRhdGEgcGhhc2UgMQ0KQ0FORkQgMi4wIC0gQXJiaXRy
YXRpb24gMSwgZGF0YSBwaGFzZSAxDQpQbGVhc2UgY2hlY2sgYmVsb3cgbGluayBvbmNlLg0KaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2ZXJzL25ldC9j
YW4veGlsaW54X2Nhbi5jI0wyMTYNCg0KQ291bGQgeW91IHBsZWFzZSBsZXQgbWUga25vdyBpZiBJ
IG1pc3MgYW55dGhpbmc/DQoNCj4gDQo+ID4gWGlsaW54IG1haW50YWlucyBjb21tb24gZHJpdmVy
IGZvciBtdWx0aXBsZSBDQU4gYW5kIENBTkZEICBJUCdzLg0KPiA+IFhpbGlueCBzdXBwb3J0cyBi
ZWxvdyBDQU4gSVAnczoNCj4gPiB4bG54LHp5bnEtY2FuLTEuMCAoenlucSBwbGF0Zm9ybSAmIHp5
bnFtcCBwbGF0Zm9ybSkNCj4gPiB4bG54LGF4aS1jYW4tMS4wMC5hICggU29mdCBJUCB2ZXJzaW9u
IDEuMDApDQo+ID4geGxueCxjYW5mZC0xLjAgKFNvZnQgY2FuZmQgaXAgdmVyc2lvbiAxLjApIHhs
bngsY2FuZmQtMi4wKFNvZnQgY2FuZmQNCj4gPiBpcCBWZXJzaW9uIDIuMCkNCj4gPiB4bG54LGNh
bmZkMi4wIGVxdWFsIHRvIHZlcnNhbCBjYW5mZCBpcCwgc28gdXNpbmcgc2FtZSBjb21wYXRpYmxl
IHN0cmluZyBmb3INCj4gYm90aC4NCj4gPg0KPiA+IEZvciBlYWNoIGlwIHNqd19tYXggYW5kIGJy
cCB2YWx1ZXMgYXJlIGRpZmZlcmVudC4NCj4gPiBEdWUgdG8gdGhpcyByZWFzb24gY3JlYXRlZCBt
dWx0aXBsZSBiaXQgdGltaW5nIHN0cnVjdHVyZXMuDQo+IA0KPiBBQ0suIEJ1dCB5b3VyIGRyaXZl
ciBpcyBvYnZpb3VzbHkgZGlmZmVyZW50IHRvIHRoZSBtYWlubGluZSBkcml2ZXIgKHNlZSBhYm92
ZSkuDQo+IA0KPiA+ID4gPiAgc2p3IDEuLjEyOCAgYnJwIDEuLjI1Ng0KPiA+ID4gPiBkc2p3IDEu
LjE2ICBkYnJwIDEuLjI1Ng0KPiA+ID4NCj4gPiA+IExvb2tpbmcgYXQgdGhlIG1haW5saW5lIHhp
bGlueCBkcml2ZXIsIHdlIGhhdmU6DQo+ID4gPg0KPiA+ID4gfCAvKiBDQU4gQml0dGltaW5nIGNv
bnN0YW50cyBhcyBwZXIgWGlsaW54IENBTiBzcGVjcyAqLyBzdGF0aWMgY29uc3QNCj4gPiA+IHwg
c3RydWN0IGNhbl9iaXR0aW1pbmdfY29uc3QgeGNhbl9iaXR0aW1pbmdfY29uc3QgPSB7DQo+ID4g
PiB8IAkubmFtZSA9IERSSVZFUl9OQU1FLA0KPiA+ID4gfCAJLnRzZWcxX21pbiA9IDEsDQo+ID4g
PiB8IAkudHNlZzFfbWF4ID0gMTYsDQo+ID4gPiB8IAkudHNlZzJfbWluID0gMSwNCj4gPiA+IHwg
CS50c2VnMl9tYXggPSA4LA0KPiA+ID4gfCAJLnNqd19tYXggPSA0LA0KPiA+ID4gICAgICAgICAg
ICAgICAgICAgIF4NCj4gPiA+IERvZXMgbm90IG1hdGNoIGR1ZSB0byAic2p3IDEuLjEyOCIuDQo+
ID4gPg0KPiA+ID4gfCAJLmJycF9taW4gPSAxLA0KPiA+ID4gfCAJLmJycF9tYXggPSAyNTYsDQo+
ID4gPiB8IAkuYnJwX2luYyA9IDEsDQo+ID4gPiB8IH07DQo+ID4gPiB8DQo+ID4gPiB8IC8qIEFY
SSBDQU5GRCBBcmJpdHJhdGlvbiBCaXR0aW1pbmcgY29uc3RhbnRzIGFzIHBlciBBWEkgQ0FORkQg
MS4wDQo+ID4gPiB8IHNwZWMgKi8gc3RhdGljIGNvbnN0IHN0cnVjdCBjYW5fYml0dGltaW5nX2Nv
bnN0DQo+IHhjYW5fYml0dGltaW5nX2NvbnN0X2NhbmZkID0gew0KPiA+ID4gfCAJLm5hbWUgPSBE
UklWRVJfTkFNRSwNCj4gPiA+IHwgCS50c2VnMV9taW4gPSAxLA0KPiA+ID4gfCAJLnRzZWcxX21h
eCA9IDY0LA0KPiA+ID4gfCAJLnRzZWcyX21pbiA9IDEsDQo+ID4gPiB8IAkudHNlZzJfbWF4ID0g
MTYsDQo+ID4gPiB8IAkuc2p3X21heCA9IDE2LA0KPiA+ID4gICAgICAgICAgICAgICAgICAgIF5e
DQo+ID4gPiBEb2VzIG5vdCBtYXRjaCBkdWUgdG8gInNqdyAxLi4xMjgiLg0KPiA+ID4NCj4gPiA+
IHwgCS5icnBfbWluID0gMSwNCj4gPiA+IHwgCS5icnBfbWF4ID0gMjU2LA0KPiA+ID4gfCAJLmJy
cF9pbmMgPSAxLA0KPiA+ID4gfCB9Ow0KPiA+ID4gfA0KPiA+ID4gfCAvKiBBWEkgQ0FORkQgRGF0
YSBCaXR0aW1pbmcgY29uc3RhbnRzIGFzIHBlciBBWEkgQ0FORkQgMS4wIHNwZWNzDQo+ID4gPiB8
ICovIHN0YXRpYyBzdHJ1Y3QgY2FuX2JpdHRpbWluZ19jb25zdCB4Y2FuX2RhdGFfYml0dGltaW5n
X2NvbnN0X2NhbmZkID0NCj4gew0KPiA+ID4gfCAJLm5hbWUgPSBEUklWRVJfTkFNRSwNCj4gPiA+
IHwgCS50c2VnMV9taW4gPSAxLA0KPiA+ID4gfCAJLnRzZWcxX21heCA9IDE2LA0KPiA+ID4gfCAJ
LnRzZWcyX21pbiA9IDEsDQo+ID4gPiB8IAkudHNlZzJfbWF4ID0gOCwNCj4gPiA+IHwgCS5zandf
bWF4ID0gOCwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICBeDQo+ID4gPiBEb2VzIG5vdCBtYXRj
aCBkdWUgdG8gImRzancgMS4uMTYiDQo+ID4gPg0KPiA+ID4gfCAJLmJycF9taW4gPSAxLA0KPiA+
ID4gfCAJLmJycF9tYXggPSAyNTYsDQo+ID4gPiB8IAkuYnJwX2luYyA9IDEsDQo+ID4gPiB8IH07
DQo+ID4gPiB8DQo+ID4gPiB8IC8qIEFYSSBDQU5GRCAyLjAgQXJiaXRyYXRpb24gQml0dGltaW5n
IGNvbnN0YW50cyBhcyBwZXIgQVhJIENBTkZEDQo+ID4gPiB8IDIuMCBzcGVjICovIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgY2FuX2JpdHRpbWluZ19jb25zdA0KPiA+ID4geGNhbl9iaXR0aW1pbmdfY29u
c3RfY2FuZmQyID0gew0KPiA+ID4gfCAJLm5hbWUgPSBEUklWRVJfTkFNRSwNCj4gPiA+IHwgCS50
c2VnMV9taW4gPSAxLA0KPiA+ID4gfCAJLnRzZWcxX21heCA9IDI1NiwNCj4gPiA+IHwgCS50c2Vn
Ml9taW4gPSAxLA0KPiA+ID4gfCAJLnRzZWcyX21heCA9IDEyOCwNCj4gPiA+IHwgCS5zandfbWF4
ID0gMTI4LA0KPiA+ID4gfCAJLmJycF9taW4gPSAyLA0KPiA+ID4gICAgICAgICAgICAgICAgICAg
IF4NCj4gPiA+IERvZXMgbm90IG1hdGNoIGR1ZSB0byAiYnJwIDEuLjI1NiIuDQo+ID4gPg0KPiA+
ID4gfCAJLmJycF9tYXggPSAyNTYsDQo+ID4gPiB8IAkuYnJwX2luYyA9IDEsDQo+ID4gPiB8IH07
DQo+ID4gPiB8DQo+ID4gPiB8IC8qIEFYSSBDQU5GRCAyLjAgRGF0YSBCaXR0aW1pbmcgY29uc3Rh
bnRzIGFzIHBlciBBWEkgQ0FORkQgMi4wDQo+ID4gPiB8IHNwZWMgKi8gc3RhdGljIHN0cnVjdCBj
YW5fYml0dGltaW5nX2NvbnN0DQo+IHhjYW5fZGF0YV9iaXR0aW1pbmdfY29uc3RfY2FuZmQyID0g
ew0KPiA+ID4gfCAJLm5hbWUgPSBEUklWRVJfTkFNRSwNCj4gPiA+IHwgCS50c2VnMV9taW4gPSAx
LA0KPiA+ID4gfCAJLnRzZWcxX21heCA9IDMyLA0KPiA+ID4gfCAJLnRzZWcyX21pbiA9IDEsDQo+
ID4gPiB8IAkudHNlZzJfbWF4ID0gMTYsDQo+ID4gPiB8IAkuc2p3X21heCA9IDE2LA0KPiA+ID4g
fCAJLmJycF9taW4gPSAyLA0KPiA+ID4gICAgICAgICAgICAgICAgICAgIF4NCj4gPiA+IERvZXMg
bm90IG1hdGNoIGR1ZSB0byAiZGJycCAxLi4yNTYiLg0KPiA+DQo+ID4gVmVyc2FsIGVhcmx5IHNp
bGljb24gd2Ugb2JzZXJ2ZWQgYml0IGVubGFyZ2luZyBpc3N1ZSB3aXRoIGJycCAgPTEgaW4NCj4g
PiBzaWRlIElQIHVzaW5nIHNpbXVsYWl0b25zKE5vdCBvYnNlcnZlZCBvbiBzb2Z0d2FyZSBzaWRl
KSAsIGJ1dCBpdA0KPiA+IGZpeGVkIGluIHByb2R1Y3Rpb24gc2lsaWNvbi4NCj4gPg0KPiA+IFBs
YW4gdG8gcmV2ZXJ0IHRoaXMgcGF0Y2ggdG8gc3VwcG9ydCBUREMgZmVhdHVyZShUbyBzdXBwb3J0
IGhpZ2hlcg0KPiA+IGJhdWQgcmF0ZXMgd2UgbmVlZCBicnAgPTEpLg0KPiANCj4gT2suDQo+IA0K
PiByZWdhcmRzLA0KPiBNYXJjDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAg
ICAgICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgICB8DQo+IEVtYmVkZGVkIExpbnV4
ICAgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUgIHwNCj4gVmVy
dHJldHVuZyBXZXN0L0RvcnRtdW5kICAgICAgICAgfCBQaG9uZTogKzQ5LTIzMS0yODI2LTkyNCAg
ICAgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiB8IEZheDogICArNDktNTEy
MS0yMDY5MTctNTU1NSB8DQo=
