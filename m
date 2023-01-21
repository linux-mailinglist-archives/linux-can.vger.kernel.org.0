Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095DA676998
	for <lists+linux-can@lfdr.de>; Sat, 21 Jan 2023 22:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjAUVax (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 21 Jan 2023 16:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUVaw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 21 Jan 2023 16:30:52 -0500
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2085.outbound.protection.outlook.com [40.107.127.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15C3233EA
        for <linux-can@vger.kernel.org>; Sat, 21 Jan 2023 13:30:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9PEPqMayFM/fcDVbQxn5El5WCL+Ori2n6wtpY4aJ7TKoV8q2PmGdNaDRtVeyFu3xQ8nS2AyinvEts1m+tJQv/wJcQmlztLb09n1F3g8aN0teHEyK2zUVddr878tryrOrY6+PF4pIpkfdFtjCB5xwdhP7kXPyU7EVWPBS/Qkg3OhpRHJ/tnUVm7W7ZdrHPWW6iLeACpG1kbdlJbxSwSHVFPcl8Tp0CisycypenqnTsB6jsG/arAGBo2+CxMOyW8+AwyAZHa2YkxazfTnWGjH8IJ/SKsFtB8P2G7YACpbA4Wt8kAiKrEeMHFSlPrn+bjZDCK9PHxhdcxDinpjoCudPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGMHZ5n52Bn6cp1c+KSJxLPyEOkMhb3LtuKyOvuNWvg=;
 b=I0smBlwyM8rqcAUfD3BAKMxKT4cLY06OpxwE0LYNOFU+/uVQDed2KnvUZGaWmooH/Ps2clD82NDlXLZJaAiagyFy14KY+Q9NCczIDOfmi5Y4o/xS4UJZgZkE3xvnsBhZvK9Peo/JZ4hLySoiKbxgwnT3+yBLjRe+tYdDbCdGA/ysklo9ZPMRNTuJ2dW/ZLYLOk6Wc7eAS2nbjSj2x7C/q5BLSKIYdpMF+OUuKYbiuvZ9qDLHY6XcwrC8ckLMSUmViDxaOPUF5AgIu7jEfsVg57/GCfl7Mk8V5eyx5MrkaMZ25hm0qMgegoW+ACOWWfxblbMLZkKQqBXv7LQnJ71XSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=janztec.com; dmarc=pass action=none header.from=janztec.com;
 dkim=pass header.d=janztec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janzag.onmicrosoft.de;
 s=selector1-janzag-onmicrosoft-de;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGMHZ5n52Bn6cp1c+KSJxLPyEOkMhb3LtuKyOvuNWvg=;
 b=ne7tvyjntXs5z3b7n/zvgB8pD7CC8UrF2HbtV7Gg3h0KjVW9YIGcSm1r7gfHOFleq47XpCM/kQGH5mUOs1hvrn1GVYU2xXOm+wzbXUNz7e3MVYQVJpE/YtJFUdu8TrFJzV0v7qnRe3r/QD6xjyGccUF+O+CX92O/TRfPFuqjmx8=
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:26::13)
 by FR0P281MB1708.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:80::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sat, 21 Jan
 2023 21:30:48 +0000
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba]) by FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba%8]) with mapi id 15.20.6002.028; Sat, 21 Jan 2023
 21:30:48 +0000
From:   =?utf-8?B?U3RlZmFuIEFsdGjDtmZlcg==?= <Stefan.Althoefer@janztec.com>
To:     "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: AW: AW: RE: mcp251xfd: rx frame truncation (1/2)
Thread-Topic: AW: RE: mcp251xfd: rx frame truncation (1/2)
Thread-Index: AQHZKzjliniR2Rjet0qunKK2mAziB66kQAkAgAATQtCAARGHgIAAD7xXgAA3PL2AAAsMAIAAB5oAgAIDZiCAABufgIAADiiAgAF7qSA=
Date:   Sat, 21 Jan 2023 21:30:47 +0000
Message-ID: <FR0P281MB19669C3FDDBE07D6B320C18997CA9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
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
In-Reply-To: <BL3PR11MB64841AD10C3CFBC21A2A16FFFBC59@BL3PR11MB6484.namprd11.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=janztec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1966:EE_|FR0P281MB1708:EE_
x-ms-office365-filtering-correlation-id: 0f46710c-2d12-4db0-630e-08dafbf6c311
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rJGpRv851Ai8oObDkT2IH6NOguoBEPIlCgKYjB+5iKLHMPyxiWHfOkPHlov6vO+5aY0CduZG8a6VvnMWdNz2CJ9x5Uq67FTyJm/8j0GDGV/Fa3FwtFxjCK7WOzC+qI4jWBtXkMnhBDD9I5PecAvr1isYEUls7HDETYzYbOSHG5v+1fAG4AESAWjSn5Asy4KKdRVlpYR5sC1UtODq39D1J8ukWXrdlt0kO2a2YaBQ0Feaww8Ee+LvaNkhkRDnYpK0W3OdUsQ/dU5Uc8AxghD2YrmzY9NPobPnP1mDDtQhMI5LeYZurs8RJMZKXmJ+BmtWmI8hZGdP2qyBsroxscJU4s3Z/G46GUqvTX6UBf9gLneZP5wxlge3JoiCTukiP2+eUdeKUQX1+NY8FE7n45fIig8nsPK/SIb8Gh9AuboFnSDUidnG25XBdXDLaStxaFf92x0PA/MO8RG7NRCQSYePXjPQC/k1JmZQg9zDZ6NNdP95qrggJjPAmZI7i9ptR+xrj2OCpZ3FbCQSD/gR8UTctcVteC4SEwyTyX/sxenHFnVdMWPZvhYv/7R0LiKQ+pb3r0Cckl5INUjyLSoCZkXbiZvhit/OoQjwuLbESp7VYq3S2zbSNcBsPCE89X1UMEcU1Ouz8mtjmga3veebjasn59UqmwAjjivfFStxmn0dXRfeSvfP1HXcO6KMWYcXmT1yNutkvqusM46Ywf+szLczNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39830400003)(346002)(366004)(136003)(396003)(376002)(451199015)(86362001)(55016003)(2906002)(33656002)(4744005)(76116006)(9686003)(41300700001)(66946007)(66476007)(186003)(26005)(64756008)(8676002)(66446008)(4326008)(66556008)(478600001)(71200400001)(316002)(7696005)(110136005)(6506007)(122000001)(5660300002)(38100700002)(8936002)(38070700005)(52536014)(83380400001)(85182001)(85202003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDBUZGg3dDREZTJ6djZKaFYyVFlkUFQ3ZFhVaDlySGEydnNYOUZXZ1BiTk01?=
 =?utf-8?B?V0pYOFdkT1IvYWk2aXVGOGpsTW9YWWoxNU5uQ3dObWxjREVwRjB6VmhobVVK?=
 =?utf-8?B?WlZ0b1lpdG1uYnlUSnJmYVFnSmxvZjczbGRLQVFQaHZKcjFDdktzWkRld0Uy?=
 =?utf-8?B?Y09qYjB3QnRwWUlPT1hDcDlvNFJ6dTE2ZW54SWVkV3c1bktLYzJJZmdrZVlV?=
 =?utf-8?B?bVdHWnR5Qmd1akFBWFNhaEpld3psSEV2L2xuQm1Ha3JVeUJlUmVRVDZEbnVy?=
 =?utf-8?B?L3NiVFh4bmdocDEwWmo0VmxrMU5wT2k4SjZ6K0NZeW9EY1hWeElONG1SZmp0?=
 =?utf-8?B?MkJUKzhJV0ZIK1RzN1RGU25yRVFnd3daVDFOQ2MzUGtpUUFGdlZhNXVCamZD?=
 =?utf-8?B?T1lBT2l4NDFMaW5XdFM2Y2cvY0pXYUZwQ3lZQ0tmM0VrdjhGbmxWamRWbEpB?=
 =?utf-8?B?bHBxbnozVkx4a3R2Ukd2USt1aU9wNzRPWnppVnpSSVZubDdrQWJ0WXZlcUQ2?=
 =?utf-8?B?cG95MDRCWDhSeUk0N1NGOFZhcnBoSFI1TjExdEl6OTl1N2lWZlZkNnp2bmtR?=
 =?utf-8?B?MHJrNGZ1UUZnU3JMUmhSK3lMZUxIU2JQS0RMUW9CWUl6K2tGeDhaT281SmJQ?=
 =?utf-8?B?ZlVYSk9zbW5YNWYzODhFM0NYbzhWUmFnWlpnRkZ3Yi9zMXZCQjBDb0o4a0p6?=
 =?utf-8?B?cDh6TTBMaWk4SVVMTXFJOVgwQzBmbXp0Z2RKbDdvWjk1QmR5cC85UFNJK0ky?=
 =?utf-8?B?MC9hN0NpM2phbEJOc1ErZnlIbFRjSTBJTnV6WnpuaHhNTitDUVhteTFPS0U3?=
 =?utf-8?B?OXZnRUhNL0VVTkkzQ3pCa3VDcDN0dTEybXFreEIzZ0lMelRqUE5WZURSSDh1?=
 =?utf-8?B?M0J1SlNRQkFpZkpVZllqWVU2dUc3QWo3dXdxNGgycTJ5MGRJTEtQUnkrNm5T?=
 =?utf-8?B?cnhCdmFDa25LSXU2YVVqRGtJeFdIYktqUEtDd1VNS3RIMjFUcndTUXd1ejFI?=
 =?utf-8?B?Z0FDYlowNHNlNElNNm5ZWmUwdHVxYWF5WTBWbzgxMnd6Mit6UjNHNzZ1cnlw?=
 =?utf-8?B?SE84aWVxNTdNTzZEWGZUSW90Y29iSGFHYlNxdGtHMlZubjNQcUREYUdtc295?=
 =?utf-8?B?azJzbTdHcDAwcnhGcHlZWnJseHVoWkdzOFdXeUZrZzQzRlFxYmFRZ0xMTEZs?=
 =?utf-8?B?bEh1c1VVM3JYdmh6OWRDYUw2Rzk0V08yMTBQd3FlUFpXajd3ZERNRGsvMDFr?=
 =?utf-8?B?MmlQUkEzbWloaEZwTEJnMlVuQkVoNDd5TVhkb1I0TDVKQklMeUJ2QzdTdjZz?=
 =?utf-8?B?a3JQYXBKMlZDN1lKYjVCK3NmQTBDUmJKZjNZVWFlakZOWDgxVm02NzR3ci96?=
 =?utf-8?B?a3g5ZlVCZkJXOXJpT3h2cGhLZitOTXZMQVVXY1pYa1NsR2Zmd0xvNlpvSUJK?=
 =?utf-8?B?ZGhrbk11U2dYSHRPemgvVUREV2hFVXh6NG5HNUVCeXJNTEVKL3V4RVZYWDNH?=
 =?utf-8?B?WFVLVU4wbEllZ1RRYmQ4QVQ4MTZRK0ZYeVJjZU05N1cxRWlmR3dmVmdGZWlt?=
 =?utf-8?B?dWc1T2RxUksrcEN6YU9VdEw0cndtMTlwQWFNdllkcEVuNDE4aWlrWDNhTHZV?=
 =?utf-8?B?OEE2QjlneXNsNldlOTRoMFhiY3FWaDNJTmNQM0F2UG9KQ1NrR1VHNnRJeWdj?=
 =?utf-8?B?Z29jMVdjOU83eVphN2pCdVBHT3UrWHIrekN4NXB1NEV5V0NuTDNNbFdkamts?=
 =?utf-8?B?T3Q5ekxWaHU4M1htL1M1NTVVUENjZkg4ekYwOHBNQVNWRThJMjVETXRvMkdr?=
 =?utf-8?B?WURwZUpxalBGVWtVV2RZcTFOQ1NNVlVLSWkwd1hmZ1dDMEFpUWFBZmFxaXVK?=
 =?utf-8?B?SDhXbkdlM3FUMnVZMVI1a05OWE0yMzVFcDZFdXo1b0VVVEpReGhlZDRWWGsz?=
 =?utf-8?B?SjIvcUtZWklRM284b0R4azd3SWVRV0dleS9hQzZ5QWxaUGhyRHN0eDFvRmVF?=
 =?utf-8?B?S1N5M0dlNkVzM1RaeGNXcldCa25JOUpjcDJNTlVFLytZYVk1YWQrWXV2aURp?=
 =?utf-8?B?VUFQWHh3VkM0aU1VMEZNOXZxZlRWZ04xcXpKOXo3ZGdVSXV4VWRJS3FDb2JS?=
 =?utf-8?B?OUZOWkk1dGtKRkxmUU9jemxPZlY0cE1ZdEt1Z1lZM1JyeHhYMzR1Nm1Za3NV?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: janztec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f46710c-2d12-4db0-630e-08dafbf6c311
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2023 21:30:47.9258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c1dae847-7bcf-493f-b143-af65743cbb23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXRZz5wSoo7ZpxriKhLXdt2H6D9xi5bU4iBGF4kzk5scSrAbgQut1XttaopW9F/EyWWIVp/w+3dEgXqbydmON32n0QjzSheoH8ASp12t04c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1708
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

U29tZSBhZGRpdGlvbmFsIGVyb3JzIGNhcHR1cmVzLg0KDQpPbiBtb3JlIGV2ZW50IG9mIHRydW5j
YXRlZCBDQU4gZnJhbWUuIFRoaXMgdGltZSA4IGRhdGEgYnl0ZXMgKGluc3RlYWQgb2YgNjQgYXJl
DQpyZWNlaXZlZCkuIFNvIG11Y2ggdG8gbXkgMjAgYnl0ZXMgb2JzZXJ2YXRpb24gLi4uDQoNCkFu
ZCB0aGVuIHR3byBjYXNlcyBvZiAiVHJhbnNtaXQgRXZlbnQgRklGTyBidWZmZXIgZnVsbCIgYWxv
bmcgd2l0aCB0aGUgcmVxdWVzdGVkDQpjb3JlZHVtcC4NCg0KRGF0YSBzZW50IHRvIHRoZSBndXJ1
cyBwZXJzb25hbGx5LiBJZiBhbnlib2R5IGVsc2Ugd2FudCB0byBicm93c2UgdGhyb3VnaCAxMCBt
cw0Kb2YgZXhpdGluZyBTUEkgd2F2ZWZvcm0sIGp1c3QgYXNrIQ0KDQotLQ0KU3RlZmFuDQo=
