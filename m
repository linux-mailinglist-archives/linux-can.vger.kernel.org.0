Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6004BEE95
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 02:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiBVAlZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Feb 2022 19:41:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiBVAlY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Feb 2022 19:41:24 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5414924BC9
        for <linux-can@vger.kernel.org>; Mon, 21 Feb 2022 16:41:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0W3ff+ZN4b9b0mkQhMCQjRnPqGza4tZ6kJvlKfbzcFzLcwX3B+TVExJfQIfGIJkDI9L+ilYH8rrgyH7JTc8igVuHbCq16pxyIk75cITiQqKbBsG24pN+CfNCgxqHp6sYm0F2vLaidS9SznsAmd6/8iN32bqvYCgcKHo/rbWPoL3gC0FJxE5OY9UbpQs2WX7DjlzRCWl76negYc/WKzYMsAd1BIXqM1Eqmk//5EDFcLh03sorUO6beJvq7cDPNpDENXCwP0JQZEQWR83FhprPU1mxRi0N12KTxyQNRAeVn2djg2kSnoDbnjlK0GE78MQUEZOwI+bTc9GI4n6+fwvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKvXl9vYr1sPQNEz9SYRulpz/FvGfF3NN4+RvGqa610=;
 b=fiOLAIxRIiLj1LT6+AghIyf16/CppQZoZy4g7W4jmj4JKZFj667s9E6n9D9DEImGvz9LUhWypyN5Y4foFb+DlqjQgG9q5kcWHdgtK+eZhWnEaCBQhZ6Rao5ULf1Q/CiG+Ci83t1VhEgptEmB6IPAj6zxfHD/5ja84zOrTxiy90wKifhQSjl94vW4PI9DeGUMuF4vSErE9PgiA1mD7QcG4VpR1p7251VjxZLGvPu/BdKCra+JWUbBMqnwCYIX50YmVduktI2nDKuasTf6FmPO4A8cgmlLpm1LgvtwWJhWGicH+rTGy9Yn5Mc3XL7So8kUerQQyKRV5sMd5DK3NEm7hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKvXl9vYr1sPQNEz9SYRulpz/FvGfF3NN4+RvGqa610=;
 b=EW2HPvc+Rrvj06KRixUp7PBYAxPYlj2nKG3cf1FUogl/I2vmZxKkGV9s5XVDXI5HH3p/acTgTAnSn2sbfNx+pA1mGkqXM9zQ/XOjY6XS1+sCUva5NDRGamTVP/av5ejfEOLt7lNV37sUXfE3mtYbsUcJXN84J1AW6fE0m3t3Hsc=
Received: from DM6PR02MB5386.namprd02.prod.outlook.com (2603:10b6:5:75::25) by
 DM5PR02MB2236.namprd02.prod.outlook.com (2603:10b6:3:51::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Tue, 22 Feb 2022 00:40:57 +0000
Received: from DM6PR02MB5386.namprd02.prod.outlook.com
 ([fe80::a9db:f9ca:3a9d:3a86]) by DM6PR02MB5386.namprd02.prod.outlook.com
 ([fe80::a9db:f9ca:3a9d:3a86%6]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 00:40:57 +0000
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
Thread-Index: AdgIqTVMB9fKzsHaTwKoGWnAYyrjVgAEyNAAAAFntwAAaVWWgAcyW0GgAAwv0AAACLJZwA==
Date:   Tue, 22 Feb 2022 00:40:57 +0000
Message-ID: <DM6PR02MB53863A690DBA53A41B867084AF3B9@DM6PR02MB5386.namprd02.prod.outlook.com>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
 <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
 <20220115232621.4ybmmrmgogies3o5@pengutronix.de>
 <DM6PR02MB538689AA158B340FE287CF05AF3A9@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220221202742.pamu76aloh2i5iw7@pengutronix.de>
In-Reply-To: <20220221202742.pamu76aloh2i5iw7@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3933656-ce0f-490c-08ad-08d9f59bfdb3
x-ms-traffictypediagnostic: DM5PR02MB2236:EE_
x-microsoft-antispam-prvs: <DM5PR02MB2236AE5BC748EF780A01C040AF3B9@DM5PR02MB2236.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3u/3Tmju+Jff4kqECJuic6i7MBn1LEtp76xryVARG35Gn4obG1F8eZN/mUlpt2W8us25Yv/8YET+WlWRAJ061LURbHQyOfbVgU/wCc5sZcYYBzZpu7JNtbhzJgQPqV+S3P0W5/gTzBt4nBWlE+JFNtMA0iPB6Ft/zGdqMScWKt3F+zu1eiBYSomTfZbytxT0HUw01k8SKsd+BSrmwk04kcLPq5/KUx0HedQRMstAxCTg3BNCpqSLJmGphp261RwWPB54PA6YcFpur63z/KFvjgzHt6dATP3zJWFNpeQvifSDpTrcml95vNglXtGzE8CFAoqOK9YMitxYqUsg1u1gX/JVkklKj6oPNCNqvxTrnwoXWLql4Xa9EQehI7GJZAKvKQGMgTwD7tSDzWkqp12auP4VTSNaRXeFXLuYJGfOmDn7a4V0E1BOTAAZaqMz15ZJMr5qkDxYKfolefVwTw6oGmdNYm5TprkUkfEUuucoROfhk7YADo4gWDPOq+KeRehM3a3VfM8qEQlidHYrdVtl7XbHZ7KIpgu2l75yjMZGyX2IdY+gJHNG+IKV8OoqR3wfyAkRKvWNp0464TWL4UVNU0YeH3QdgZl0I6sjc0V9QdxAsuheGlSGzNYcwNW1WAQ9g3i0z0yHhcrcTK07PGVDfo4yawHnPXYIl1kTUkpW7RO6KZpMBXZpo0o2J5pjQxOgu3ilvRvL28KgPTdRMhVrWugu5SH2/htHka6QPD9MM5K3De1qhFdNSYILka8jVZ24yOmEzdyZn6jnsCAaPRJKiUdrUcjxwAG42hxcH4uuuHT8HGORTvMdm2plT1Iwt0KOgkCnN5jxLu+8h96Jhv1OGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5386.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(76116006)(83380400001)(54906003)(6916009)(38070700005)(316002)(55016003)(66556008)(8676002)(2906002)(66446008)(66476007)(6506007)(9686003)(84970400001)(52536014)(7696005)(966005)(508600001)(38100700002)(8936002)(71200400001)(53546011)(64756008)(86362001)(26005)(186003)(66946007)(122000001)(4326008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGhJRkxDUkxMdzE1N2pGVGVpakZKa2N4bW5jSHNjTjNTa3NWbE5CVk5zdk5Y?=
 =?utf-8?B?bTR5bDlsRUZYekZpOXQ1akJhL0IyWUN0V2FTdStONEc2NzhXa3llV0dXakNG?=
 =?utf-8?B?dk5uRFRxSzRmWTlxNE1KdHd6LzE2L0hFRndrckJaeFA4dlhQZ254VzRqV0Zw?=
 =?utf-8?B?ZHZIeTZNOURkcGUvaFlxY0RwYnVXaC9tNnJPWThOUnBFdmdvVG9ueEx4N2di?=
 =?utf-8?B?NGxWMnFNa3NlVHN5bmtyQ24yVjdvZ2NPa2RqdHErMDlSQVpDNExLaEdidXhV?=
 =?utf-8?B?MnhyRGozdDNYTkZLZWJqZjJmS1JSNDBJQXFmT2EwaWRPc1BnM0dyQkdHSjUr?=
 =?utf-8?B?OUtRZ2d4eGtURnllNHJvT1VOb1hyMTgrVjRQaDlnL2VTcXFXcVJBSnVXeUJn?=
 =?utf-8?B?eHVNYys1Z2UyMFFPQlk0S2xuRjZEMUpid1hkdXFoZzFLTFZxdjhNNUY3b3R0?=
 =?utf-8?B?ckM2T2xjMWJvUzJUQ05Qb21ZK2dCMlhTY1llVTR3WE5kZkY2Y2N2eWY2OEJH?=
 =?utf-8?B?OUUrNUQxcW5UQlBMSWdpQzkvUVpPYzRqQmd6K0FYSlIzelc1T01aaktYS05l?=
 =?utf-8?B?TVRoZi81MG81Mlc0djhxVzJienJFOExNWS96Mm9lb3E3STR5K0NaeHdBTVZq?=
 =?utf-8?B?SXJIRFRxUGg0dWx0NzFxY29EQnhTNTI2UjM3dUg2YzAwenRQc3FqbDIxbHAv?=
 =?utf-8?B?VjhjN2NybnIyZi9CTjFrVjdzOEpiUWliOXZWaVFYM3Q4Um5waW5ETGxwUWUx?=
 =?utf-8?B?czlnOFByYlIzdVlVVVVQS3l0dnZZL0lSa25ISXkzUWcwODJ1VlI4cWpHelFW?=
 =?utf-8?B?ZHBPbmc1YXRXd2ZvbjBCZGdEWEtTRzNrclQvVnJmM3M0L1hVTUVTbU5WSW1G?=
 =?utf-8?B?Y3VPTDZpd2UvVnF0ZVg0U2F4dFA0bmNtTUJJb0hYYkk1Ti9iQXJuREYzbHU0?=
 =?utf-8?B?eGY1aUxPK2t2WnF2UHFqM2pZRWZnTlZMUnFRaFA0UTludlBRY2NiSWlZUlI3?=
 =?utf-8?B?RVRGSnNTUkpSWWFqTlJGMkxqV25ad2ZtRllqLzU1dEloWjI1UTZnc3IzUWVX?=
 =?utf-8?B?RmFOaW05MTFOL1p3aStueG83NkdyOEU3VWVJMStDQndQNkdVM2tBNWJqa1hC?=
 =?utf-8?B?K3cxaHRueFcySytvOVUrNUlRNWV3SWgyZjVYWFU5aVU3bVpKa0ZDcU1ybmZZ?=
 =?utf-8?B?NTZNRU84NitqVUdBYXowV0diNExnUjE0Sm1Ob1dJU2hMclhoVWE0cE9mNGxj?=
 =?utf-8?B?T2czZFBHVnM3b1lhUXJvQytKeDlrOHRQWklmeDhzUTRLVVB4Q1NHdDNqVDFs?=
 =?utf-8?B?Sm9iSVErdjMram4vWmJIVG84aGZlR2RHSTNPaGZlUmJyZVVITGE3MzRzWXFF?=
 =?utf-8?B?dG9JMTIrajdDbjVzd2MrNjZnS2JrMEZsOWRFdm04SVQxMVpXZW5ZZ1c5SEZh?=
 =?utf-8?B?a1NzTVB4U2YvL1lpOWszOXBPdVBZOUMwZ3duc1pyWGNLdlVsMmVrUnZ4RENX?=
 =?utf-8?B?Nkh6dENZeVhWMFI2bW9LaHQyMExpd1p0MG91NSsydmliUklQb3lJZ0hqbml4?=
 =?utf-8?B?OXVxNStCQUttbTNTdGdLK29URzduK1pkUWM1ak1lc3doRGorQ2RqMXJnb2JH?=
 =?utf-8?B?ay8wNFp1aU1lTlhKWlBsVFltb1J5UnlDWERXUEVhak5qaWdiczJjb0lQQnRS?=
 =?utf-8?B?ZEIyamRRRG9uNCsrajlNOHVNM0hvcWRET0tYUy9nZlluMzNCNURBeFpZL3RP?=
 =?utf-8?B?SW5xOW1SL01SeGtEYnJXUEZ5cHZFUFhYcDBKb0ttaDI5ck93ellpSHp6Y29p?=
 =?utf-8?B?c3FHYldlMG9uZTRqZkM2YlJQbzBqOFo5NzJHTDdUdFVaV0krUVh6N1RjdXZK?=
 =?utf-8?B?Wkd2ZlpESjhsQm8vOUFqVnhBZkhtcEhuSU1La29XQVphQ05Wd1A4RlJES0lj?=
 =?utf-8?B?NzlNc3hnWWxQSUs1ZEQrc0NoRlVDYXZSUVFacEhkT2QwNnNhY25EQzFWVXF6?=
 =?utf-8?B?bGo5SU11THdHSG1LMzZaTVF2cUIwenhMaXdEOUJRTENtbFBNeUdZZGErRTJl?=
 =?utf-8?B?b05mV3dpbHBNNXBiLzM0RE9JTnB5L04yeXVOTnpHYUhjRVd2YXQrQmkxdTF6?=
 =?utf-8?B?Vzh0cDFjYjhkNEVKV0ExWGxCNEdBcHdqc0lFRTZPNmx6U1VYanJlRHFKSElZ?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5386.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3933656-ce0f-490c-08ad-08d9f59bfdb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 00:40:57.3490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NbOBHdHp2T9n50NdE035Zlhz8G+5WZAK6jnhruTOQi6F/tzlwMcxfv/GkAdsBMvBCIT/1+Mc54yBNpeJrVEMyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2236
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgTWFyYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEts
ZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFy
eSAyMiwgMjAyMiAxOjU4IEFNDQo+IFRvOiBTcmluaXZhcyBOZWVsaSA8c25lZWxpQHhpbGlueC5j
b20+DQo+IENjOiBTcmluaXZhcyBHb3VkIDxzZ291ZEB4aWxpbnguY29tPjsgTmF2ZWVuIEt1bWFy
IEdhZGRpcGF0aQ0KPiA8bmF2ZWVua3VAeGlsaW54LmNvbT47IFByYXNhZCBCZWVyIFByYXNhZCA8
cHJhc2FkYmVAeGlsaW54LmNvbT47IGxpbnV4LQ0KPiBjYW4gPGxpbnV4LWNhbkB2Z2VyLmtlcm5l
bC5vcmc+OyBTdGVmYW4gTcOkdGplIDxzdGVmYW4ubWFldGplQGVzZC5ldT47DQo+IFZpbmNlbnQg
TUFJTEhPTCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+DQo+IFN1YmplY3Q6IFJlOiBRdWVy
aWVzIG9uIENBTiBmcmFtZSB3b3JrDQo+IA0KPiBPbiAyMS4wMi4yMDIyIDE0OjQzOjU3LCBTcmlu
aXZhcyBOZWVsaSB3cm90ZToNCj4gPiA+IENhbiB5b3UgcGxlYXNlIHByb3ZpZGUgbWU6DQo+ID4g
PiAtIHRoZSBiaXQgdGltaW5nIGNvbnN0YW50cyBvZiB0aGUgSVAgY29yZSBmb3IgdGhlIGFyYml0
cmF0aW9uIGFuZCBkYXRhDQo+ID4gPiAgIHBoYXNlDQo+ID4gPiAtIHRoZSBiaXQgcmF0ZSBmb3Ig
dGhlIGFyYml0cmF0aW9uIGFuZCBkYXRhIHBoYXNlDQo+ID4gPiAgIChlc3BlY2lhbGx5IHdoZXJl
IHRoZSBmcmFtZXdvcmsgY2FsY3VsYXRlcyBub3QgY29tbW9uIHByZXNjYWxlcnMpDQo+ID4gPiAt
IHRoZSBjbG9jayByYXRlIG9mIHRoZSBDQU4gYnVzIGNsb2NrDQo+ID4gPg0KPiA+ID4gQ2FuIHlv
dSBhbHNvIHByb3ZpZGUgdGhlIGhhbmQgY2FsY3VsYXRlZCBiaXQgdGltaW5nIHBhcmFtZXRlcnMg
Zm9yDQo+ID4gPiB0aGUgYWJvdmUgc2NlbmFyaW9zPw0KPiA+DQo+ID4gQmF1ZCByYXRlIDEvNU1i
cHMNCj4gPiA9PT09PT09PT09PT09PT09DQo+ID4gcm9vdEB4aWxpbngtdmNrMTkwLTIwMjFfMTp+
IyBpcCBsaW5rIHNldCBjYW42IHR5cGUgY2FuIGJpdHJhdGUgMTAwMDAwMA0KPiBkYml0cmF0ZSA1
MDAwMDAwIGZkIG9uDQo+ID4gWyAgIDI2LjgzNzA1N10geGlsaW54X2NhbiBmZjA3MDAwMC5jYW4g
Y2FuNjogYml0cmF0ZSBlcnJvciAwLjAlDQo+ID4gWyAgIDI2Ljg0MjczMV0geGlsaW54X2NhbiBm
ZjA3MDAwMC5jYW4gY2FuNjogYml0cmF0ZSBlcnJvciAwLjAlDQo+ID4gIGNhbjYgdHhxcm9vdEB4
aWxpbngtdmNrMTkwLTIwMjFfMTp+IyBpZmNvbmZpZyBjYW42IHR4cXVldWVsZW4gMTAwMA0KPiA+
IHJvb3RAeGlsaW54LXZjazE5MC0yMDIxXzE6fiMgaXAgbGluayBzZXQgY2FuNiB1cA0KPiA+IFsg
ICAyNy4zNDA4ODBdIElQdjY6IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBjYW42OiBsaW5rIGJl
Y29tZXMNCj4gcmVhZHkNCj4gPiByb290QHhpbGlueC12Y2sxOTAtMjAyMV8xOn4jIGlwIC1kIC1z
IGxpbmsgc2hvdyBjYW42DQo+ID4gIGNhbjY6IDxOT0FSUCxVUCxMT1dFUl9VUCxFQ0hPPiBtdHUg
NzIgcWRpc2MgcGZpZm9fZmFzdCBzdGF0ZSBVUA0KPiBtb2RlIERFRkFVTFQgZ3JvdXAgZGVmYXVs
dCBxbGVuIDEwMDANCj4gPiAgICAgbGluay9jYW4gIHByb21pc2N1aXR5IDAgbWlubXR1IDAgbWF4
bXR1IDANCj4gPiAgICAgY2FuIDxGRD4gc3RhdGUgRVJST1ItQUNUSVZFIChiZXJyLWNvdW50ZXIg
dHggMCByeCAwKSByZXN0YXJ0LW1zIDANCj4gPiAJICBiaXRyYXRlIDk5OTk5OSBzYW1wbGUtcG9p
bnQgMC43NTANCj4gPiAJICB0cSAyNTAgcHJvcC1zZWcgMSBwaGFzZS1zZWcxIDEgcGhhc2Utc2Vn
MiAxIHNqdyAxDQo+ID4gCSAgeGlsaW54X2NhbjogdHNlZzEgMS4uMjU2IHRzZWcyIDEuLjEyOCBz
ancgMS4uMTI4IGJycCAxLi4yNTYgYnJwLWluYyAxDQo+ID4gCSAgZGJpdHJhdGUgNDk5OTk5OSBk
c2FtcGxlLXBvaW50IDAuNzUwDQo+ID4gCSAgZHRxIDUwIGRwcm9wLXNlZyAxIGRwaGFzZS1zZWcx
IDEgZHBoYXNlLXNlZzIgMSBkc2p3IDENCj4gPiAJICB4aWxpbnhfY2FuOiBkdHNlZzEgMS4uMzIg
ZHRzZWcyIDEuLjE2IGRzancgMS4uMTYgZGJycCAxLi4yNTYgZGJycC1pbmMNCj4gMQ0KPiA+IAkg
IGNsb2NrIDc5OTk5OTk5DQo+ID4gCSAgcmUtc3RhcnRlZCBidXMtZXJyb3JzIGFyYml0LWxvc3Qg
ZXJyb3Itd2FybiBlcnJvci1wYXNzIGJ1cy1vZmYNCj4gPiAJICAwICAgICAgICAgIDAgICAgICAg
ICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgIG51bXR4cXVldWVz
IDENCj4gbnVtcnhxdWV1ZXMgMSBnc29fbWF4X3NpemUgNjU1MzYgZ3NvX21heF9zZWdzIDY1NTM1
DQo+ID4gICAgIFJYOiBieXRlcyAgcGFja2V0cyAgZXJyb3JzICBkcm9wcGVkIG92ZXJydW4gbWNh
c3QNCj4gPiAgICAgMCAgICAgICAgICAwICAgICAgICAwICAgICAgIDAgICAgICAgMCAgICAgICAw
DQo+ID4gICAgIFRYOiBieXRlcyAgcGFja2V0cyAgZXJyb3JzICBkcm9wcGVkIGNhcnJpZXIgY29s
bHNucw0KPiA+ICAgICAwICAgICAgICAgIDAgICAgICAgIDAgICAgICAgMCAgICAgICAwICAgICAg
IDANCj4gPiByb290QHhpbGlueC12Y2sxOTAtMjAyMV8xOn4jDQo+ID4NCj4gPiBQYXJhbWV0ZXJz
DQo+ID4gQlBSQSAtMjAsIFRTMSA9IDIsIFRTMiA9MSxzancgPTEsDQo+ID4gQlBSRCAtIDQsIFRT
MSA9IDIsIFRzMiA9IDEsc2p3ID0xLA0KPiA+IENsb2NrIH44ME1oeig3OTk5OTk5OSkNCj4gPg0K
PiA+IEhhbmQgY29uZmlndXJhdGlvbjoNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gPiBpcCBsaW5rIHNldCBjYW4wIHR5cGUgY2FuIHRxIDEyIHByb3Atc2VnIDI5IHBoYXNlLXNl
ZzEgMzAgcGhhc2Utc2VnMg0KPiA+IDIwIHNqdyAxIGR0cSAxMiBkcHJvcC1zZWcgNSBkcGhhc2Ut
c2VnMSA2IGRwaGFzZS1zZWcyIDQgZHNqdyAxIGZkIG9uDQo+ID4gKEEvRDogMS81TWJwcywgU2Ft
cGxlIHBvaW50PTc1JSkNCj4gPg0KPiA+IEJhdWQgcmF0ZSAxLzRNYnBzDQo+ID4gPT09PT09PT09
PT09PT09PQ0KPiA+IHJvb3RAeGlsaW54LXZjazE5MC0yMDIxXzE6fiMgaXAgbGluayBzZXQgY2Fu
NiB0eXBlIGNhbiBiaXRyYXRlIDEwMDAwMDANCj4gZGJpdHJhdGUgNDAwMDAwMCBmZCBvbg0KPiA+
IFsgIDIwOS41NzI5MzhdIHhpbGlueF9jYW4gZmYwNzAwMDAuY2FuIGNhbjY6IGJpdHJhdGUgZXJy
b3IgMC4wJSBbDQo+ID4gMjA5LjU3ODYyN10geGlsaW54X2NhbiBmZjA3MDAwMC5jYW4gY2FuNjog
Yml0cmF0ZSBlcnJvciAwLjAlDQo+ID4gcm9vdEB4aWxpbngtdmNrMTkwLTIwMjFfMTp+IyByb290
QHhpbGlueC12Y2sxOTAtMjAyMV8xOn4jIGlwIC1kIC1zDQo+ID4gbGluayBzaG93IGNhbjYNCj4g
PiA5OiBjYW42OiA8Tk9BUlAsRUNITz4gbXR1IDcyIHFkaXNjIHBmaWZvX2Zhc3Qgc3RhdGUgRE9X
TiBtb2RlDQo+IERFRkFVTFQgZ3JvdXAgZGVmYXVsdCBxbGVuIDEwMDANCj4gPiAgICAgbGluay9j
YW4gIHByb21pc2N1aXR5IDAgbWlubXR1IDAgbWF4bXR1IDANCj4gPiAgICAgY2FuIDxGRD4gc3Rh
dGUgU1RPUFBFRCAoYmVyci1jb3VudGVyIHR4IDAgcnggMCkgcmVzdGFydC1tcyAwDQo+ID4gCSAg
Yml0cmF0ZSA5OTk5OTkgc2FtcGxlLXBvaW50IDAuNzUwDQo+ID4gCSAgdHEgMjUwIHByb3Atc2Vn
IDEgcGhhc2Utc2VnMSAxIHBoYXNlLXNlZzIgMSBzancgMQ0KPiA+IAkgIHhpbGlueF9jYW46IHRz
ZWcxIDEuLjI1NiB0c2VnMiAxLi4xMjggc2p3IDEuLjEyOCBicnAgMS4uMjU2IGJycC1pbmMgMQ0K
PiA+IAkgIGRiaXRyYXRlIDM5OTk5OTkgZHNhbXBsZS1wb2ludCAwLjc1MA0KPiA+IAkgIGR0cSA2
MiBkcHJvcC1zZWcgMSBkcGhhc2Utc2VnMSAxIGRwaGFzZS1zZWcyIDEgZHNqdyAxDQo+ID4gCSAg
eGlsaW54X2NhbjogZHRzZWcxIDEuLjMyIGR0c2VnMiAxLi4xNiBkc2p3IDEuLjE2IGRicnAgMS4u
MjU2IGRicnAtaW5jDQo+IDENCj4gPiAJICBjbG9jayA3OTk5OTk5OQ0KPiA+IAkgIHJlLXN0YXJ0
ZWQgYnVzLWVycm9ycyBhcmJpdC1sb3N0IGVycm9yLXdhcm4gZXJyb3ItcGFzcyBidXMtb2ZmDQo+
ID4gCSAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAg
ICAgIDAgICAgICAgICBudW10eHF1ZXVlcyAxDQo+IG51bXJ4cXVldWVzIDEgZ3NvX21heF9zaXpl
IDY1NTM2IGdzb19tYXhfc2VncyA2NTUzNQ0KPiA+ICAgICBSWDogYnl0ZXMgIHBhY2tldHMgIGVy
cm9ycyAgZHJvcHBlZCBvdmVycnVuIG1jYXN0DQo+ID4gICAgIDAgICAgICAgICAgMCAgICAgICAg
MCAgICAgICAwICAgICAgIDAgICAgICAgMA0KPiA+ICAgICBUWDogYnl0ZXMgIHBhY2tldHMgIGVy
cm9ycyAgZHJvcHBlZCBjYXJyaWVyIGNvbGxzbnMNCj4gPiAgICAgMCAgICAgICAgICAwICAgICAg
ICAwICAgICAgIDAgICAgICAgMCAgICAgICAwDQo+ID4gcm9vdEB4aWxpbngtdmNrMTkwLTIwMjFf
MTp+Iw0KPiA+DQo+ID4gUGFyYW1ldGVycw0KPiA+IEJQUkEgLTIwLCBUUzEgPSAyLCBUUzIgPTEs
c2p3ID0xLA0KPiA+IEJQUkQgLSA1ICwgVFMxID0gMiwgVHMyID0gMSxzancgPTEsDQo+ID4gQ2xv
Y2sgfjgwTWh6KDc5OTk5OTk5KQ0KPiA+DQo+ID4gSGFuZCBjb25maWd1cmF0aW9uOg0KPiA+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gaXAgbGluayBzZXQgY2FuMCB0eXBlIGNhbiB0
cSAxMiBwcm9wLXNlZyAyOSBwaGFzZS1zZWcxIDMwIHBoYXNlLXNlZzINCj4gPiAyMCBzancgMSBk
dHEgMTIgZHByb3Atc2VnIDcgZHBoYXNlLXNlZzEgNyBkcGhhc2Utc2VnMiA1IGRzancgMSBmZCBv
bg0KPiA+IChBL0Q6IDEvNE1icHMsIFNhbXBsZSBwb2ludD03NSUpDQo+ID4gUmVmZXJlbmNlOg0K
PiA+IGh0dHBzOi8vd3d3Lmt2YXNlci5jb20vc3VwcG9ydC9jYWxjdWxhdG9ycy9jYW4tZmQtYml0
LXRpbWluZy1jYWxjdWxhdG8NCj4gPiByLw0KPiA+DQo+ID4gaXMgdGhlcmUgYW55IHBsYW4gdG8g
aW1wbGVtZW50IG5ld3NsZXR0ZXIgcmVjb21tZW5kYXRpb25zIGluIGZyYW1lDQo+IHdvcmsgPw0K
PiA+IGh0dHBzOi8vY2FuLQ0KPiBuZXdzbGV0dGVyLm9yZy91cGxvYWRzL21lZGlhL3Jhdy9mNmEz
NmQxNDYxMzcxYTJmODZlZjAwMTFhDQo+IA0KPiBUaGFua3MgdGhvc2UgcGFyYW1ldGVycy4gSSB0
aGluayBJIGhhdmUgZXZlcnl0aGluZyBJIG5lZWQgYW5kIEknbGwgdHJ5IHRvDQo+IHJlcHJvZHVj
ZSB0aGUgcHJvYmxlbSBoZXJlLg0KPiANCj4gSSB3YW50IHRvIGFkZCB0aGUgY2xvY2sgcmF0ZSB0
byB0aGUgY2FuLWJpdC10aW1pbmcgdXNlciBzcGFjZSB0b29sLg0KPiBXaGljaCBTb0MgdXNlcyB0
aGlzIDc5OTk5OTk5IEh6IENsb2NrPw0KDQpWZXJzYWwgQUNBUCBTT0Mgd2UgYXJlIG9ic2Vydmlu
ZyA3OTk5OTk5SHogQ2xvY2suDQpodHRwczovL3d3dy54aWxpbnguY29tL3N1cHBvcnQvZG9jdW1l
bnRhdGlvbi9hcmNoaXRlY3R1cmUtbWFudWFscy9hbTAxMS12ZXJzYWwtYWNhcC10cm0ucGRmDQoN
Cj4gDQo+IHJlZ2FyZHMsDQo+IE1hcmMNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAg
ICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgIHwNCj4gRW1iZWRkZWQg
TGludXggICAgICAgICAgICAgICAgICAgfCBodHRwczovL3d3dy5wZW5ndXRyb25peC5kZSAgfA0K
PiBWZXJ0cmV0dW5nIFdlc3QvRG9ydG11bmQgICAgICAgICB8IFBob25lOiArNDktMjMxLTI4MjYt
OTI0ICAgICB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiAgICs0
OS01MTIxLTIwNjkxNy01NTU1IHwNCg==
