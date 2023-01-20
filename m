Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A925675FD2
	for <lists+linux-can@lfdr.de>; Fri, 20 Jan 2023 22:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjATV6F (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Jan 2023 16:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjATV6F (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2023 16:58:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FF31C30C
        for <linux-can@vger.kernel.org>; Fri, 20 Jan 2023 13:58:02 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pIzOa-00032f-Ov
        for linux-can@vger.kernel.org; Fri, 20 Jan 2023 22:58:00 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:2ea4:b8b6:f5b:5340])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 430D315F021
        for <linux-can@vger.kernel.org>; Fri, 20 Jan 2023 21:58:00 +0000 (UTC)
Received: from bjornoya.blackshift.org
        by bjornoya with LMTP
        id ShRaKnn4ymOmeQ4As6a69A
        (envelope-from <Stefan.Althoefer@janztec.com>)
        for <mkl-all@blackshift.org>; Fri, 20 Jan 2023 20:24:25 +0000
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6A7C315EF8C
        for <mkl-all@blackshift.org>; Fri, 20 Jan 2023 20:24:25 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5A7F715EF8B
        for <ptx@kleine-budde.de>; Fri, 20 Jan 2023 20:24:24 +0000 (UTC)
Received: from mail-be0deu01on2074.outbound.protection.outlook.com ([40.107.127.74] helo=DEU01-BE0-obe.outbound.protection.outlook.com)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <Stefan.Althoefer@janztec.com>)
        id 1pIxvt-0002Be-Q4
        for mkl@pengutronix.de; Fri, 20 Jan 2023 21:24:23 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljSe6EzaomudYy320TDlqJkzvJ6yxaUMPfuwoXrhs44Yp8ENSSA+2akWYGqS/z2ymkP5DduR8myB2Nuz5PkTJSYw88yvRsZRlvr7hGqirLKtdImxNtm8obIARIVeA7QEf02a4fuqbLMfbjjvUdWJAKGo2EveErUk+1qAOBf+gK6Pp1/2jpiuBx/gBEJBdFLcjO+56IuTyfE0Y+hvDHGIdwyMLq1sZ+RwQznHRbnNZn5uo640QisHLfdK9ujrzKyAqHjP+WOtImPXClpKjgCIsZRs5pd5zDgXKUovg5yo5QRxzJDCF5UYcaN595/UNp/m2zT2pmNFoG+ZDj17OdWdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbC2TRUHnXNduo0Dj76/zH/3mQvmtlNbKCOaB7KAeu8=;
 b=GfnTlr7iedQLxFKHDvSmOdBykUWxfhem68YWrOf9VVmOCYF7rJbcBnQ71/j8XOWR/MxsJF6nm8KhyktWYRXu4ybKp77eMWxgkm4z2EAANHVPIoVU4iIXnDErqfgMMTXMnazPwrWnZmsO3FaqShRMf1nyb8IMnOdKXRlIsMCB5uOqlFHtcWAEqIzVWsd97lVBejBGXU4sBKIGjRu02ToB4QSKhanBXxaJmXKQccx7dJS07urropp8ray1lJ6FcML9imRnlcXTCZ2ShOOa95lgJwDJi8AYqJl6bTGZiQ5xLpDYI/rhmzp8fV+B4z/Qd+MHAq4Cpw0VxLS1oFfg4DLSqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=janztec.com; dmarc=pass action=none header.from=janztec.com;
 dkim=pass header.d=janztec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janzag.onmicrosoft.de;
 s=selector1-janzag-onmicrosoft-de;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbC2TRUHnXNduo0Dj76/zH/3mQvmtlNbKCOaB7KAeu8=;
 b=o4YfWsOXpZOy+BIfDfBmyno7xUlpC+K9mqbaP0jUMt4LYLmwJhvugE64XrrSGy3RrOCvl/UKntoZ9lKjmPRTBRHB51MnKdUXoyBIwaV7WB7WHIdy4Fgav1trdhwf6QfPQzwDot25ef2B8vXfizyrDrXivR7jdex8r3Mpcl9cHd4=
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:26::13)
 by FR2P281MB1784.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:90::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 20:24:13 +0000
Received: from FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba]) by FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d76a:8be5:c810:d1ba%7]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 20:24:13 +0000
From:   =?utf-8?B?U3RlZmFuIEFsdGjDtmZlcg==?= <Stefan.Althoefer@janztec.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>
Cc:     linux-can@vger.kernel.org
Thread-Topic: RE: mcp251xfd: rx frame truncation (1/2)
Thread-Index: AQHZKzjliniR2Rjet0qunKK2mAziB66kQAkAgAATQtCAARGHgIAAD7xXgAA3PL2AAAsMAIAAB5oAgAIDZiA=
Date:   Fri, 20 Jan 2023 20:24:13 +0000
Message-ID: <FR0P281MB1966B0AD5BD74FA1AE550F2797C59@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
References: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966F32AD422DDD867F8C53A97C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB6484911640CCC738ED799E6FFBC79@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19663A60B0F7CE7F684A7A6297C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64842584529FAEF279F7B137FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19669083201C1B9C2DFB9E5497C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB196633E4F8E1195086E2402B97C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB648434F2B7DE7F75E291E159FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230119133214.ofapvfc2rzi3gvn4@pengutronix.de>
In-Reply-To: <20230119133214.ofapvfc2rzi3gvn4@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=janztec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB1966:EE_|FR2P281MB1784:EE_
x-ms-office365-filtering-correlation-id: 38c5060e-642f-48b2-4322-08dafb244bc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D2rQ4NEPXj3jfoLp2f9ZXW1Mh5pBYZz3ioBgOAt6ulupyjaXdoKZLO3Kl2VNdNanYiIGepSohf0J5IH9QiWKqUgdBVHmcmyeqEFEtQ8RJxZpwWrplL1IyLUC84nhYLMdMHV3/+xiTYjw1dyukjk2rdELgKSyjEvs9zarQf3H+TcgqZ9oVL5vyUBHhuoWo0RLGBf988zpWxvRwIdg2Nkuv8wZRbX81ZgTDjmH1lVwZqH4O+xTQiMMQCEoy5NY3h0UPKhS5dHUB6oy6HCWVwRovhAlWxDgNRKvLAQYGJD6VAtsowInkW9qsip13S/+4CucGPOInaWm7t5bAiKqvCLZxEdCEapzBToWHWsscB61d763neYpfk3t43GWFBpkC1Rxq2FFzDSNgbDLAZMzVQoxt5upUJbhItoMOmCL19/4XCKDvE438w/HO3XbD9sHfTrgU/QymCtqlIfbXHJrfU8w10vjYslMGMOmCUNmok2DuDE2oGulZXjjn8j0EKP8Yt1nTlbyhGrS1S5sykjIyyMfSXtxDASlB3o01hf1LhWM4jyFThlV8EupOwqWtGmQM1aVq8A+yfeVKGcDA3KgRCSR/4IlWIOAThqBcq+sxgBB9OYfc9FvDZDEZPyo9dyKGz0sco8VIT7UsFO6F8XoIO7TNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39830400003)(396003)(366004)(136003)(451199015)(55016003)(2906002)(33656002)(8676002)(316002)(66446008)(64756008)(110136005)(66476007)(66556008)(66946007)(76116006)(7696005)(186003)(478600001)(71200400001)(6506007)(9686003)(26005)(5660300002)(4744005)(86362001)(99936003)(122000001)(38100700002)(38070700005)(8936002)(52536014)(41300700001)(85182001)(85202003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFNXblh4VXVPZFFJL1hENVhKdWtDSUpDUXQxTjFxU3BmTmJ6b2Rmc1lrNXZD?=
 =?utf-8?B?K2xaMEZqc0Z2THYxWHhDVlRWdzQ3SVJpTHkwbjF2bHpMaklBNERSMXNuNWhO?=
 =?utf-8?B?QnRKTUVObmJ5b2tUZWU5SHBSaFduaytmTUNHc2NHa21YZmYwUFo0Skk4Umly?=
 =?utf-8?B?c2pJU1ZLQ1hUVjdHblA0V1YrdWxoRExvcFBCVTltQ3RzVENLOHR3VzF0M1NR?=
 =?utf-8?B?RklvdnJsZVAzc2M0L3U1RW9kc016VFoxZW1wbjRKOVphWmNQdjJSRGU2VnRP?=
 =?utf-8?B?OHA5QnBRZ3UxdlhLdDl1WlNBNVUxVDdzb25vc05ZRFhKaDQzNXJjOXM5RWFV?=
 =?utf-8?B?YjNHamJoZkdSSWxJSlptd1dYUm9oK0lYNUxkZmZSTXpyV0tWeFEyamprSEdT?=
 =?utf-8?B?NGE0WVMzS2VLL0U4YU1XTTc1amdhUmx1VHFhdW9tZjVzY3NVRGtsQVBiVE5Q?=
 =?utf-8?B?Mm1rUDkwejRlWjNDZ1VBU3N6UFVTUURvejdQZjB4ZFpkZFZFSG05ejR5dWpo?=
 =?utf-8?B?c3FmQ01BQzczNXhvdEJBeW9Hd0JVM2FDMVdKTFdwTDdKbmFrSHAvZXUxd2FI?=
 =?utf-8?B?TUhlQmR5eDlpZ3crenJiWGgvYVhoNzkvS0tZZHpmR3kxQnFMV2JJQkxPSXpN?=
 =?utf-8?B?d2M1TzFsUjVxN0txYnhSSzVWTDNaODZYUWlLL2wrRWhBaTd0NWtyT0Vubzlv?=
 =?utf-8?B?cVV0R1ZNVThkYnB6YnhRMGp1NnprMTBjc2hGK2RVazBrRExkL3hDcjB0Q2hH?=
 =?utf-8?B?aWdBNW5Dd0FWWHpieFJhQUJnSzZ0YkdKUVJxaDBXc2lpV3RUZlpETzlvdU9O?=
 =?utf-8?B?blVrNy8wOHI1N2hWMFZuRjNrcFBNcERQRUQ1eHhVRGttdWIrTjB6NWJBRXFv?=
 =?utf-8?B?U09VRWxya20xL1ZKNysvTEJSRExsY1lrLzBXVW96Y2oxSnVLOHJ2eXNMQ2hB?=
 =?utf-8?B?Y25vNksyekh0MCsremcxUDRDVWxFVE04Q0xtSzZudCtFZ3F1RmZDL254azdM?=
 =?utf-8?B?b08wWExlRXoyVW9oQXFPMllVdExLMzl6ck5OMFlMQmZEUC84VDcyc2xBaUd6?=
 =?utf-8?B?MStCYWJaVVMyN0l5NDF2cnJ6UnFFK1VpYnMyZHhuLzltQWc3QWtRRXFJeEts?=
 =?utf-8?B?QnNBVUtWM2Z3MnQzb3F0VllPK1BwMko1TXlxQ3ZScnlwZjQ5Sk9mYk5yZXJU?=
 =?utf-8?B?Mkd6cFg2VHZiWjhHTWtnZ2pZWkFPb1JYQXBMK245aVE1MWVwYjR0NlRnN0hQ?=
 =?utf-8?B?ZnMvV3dBTWNPNnIwT2N3K0NyMkJzUnFJWDZyWERlUnhxY3JzNTFMVXMvUTNm?=
 =?utf-8?B?M1Q1TlZyWU1UTy96WDdJM21ycEdyeWdOVFRaS0dhMkx2YXE5TjZaMW5taytX?=
 =?utf-8?B?a3loejE3VjRDU1FBbFVCamZFdlpkR3JpZVNXbThlcWNlSTlwRlFnb2hIZTJv?=
 =?utf-8?B?cHpzWTFqbitzYloyQUdKSWo3eitBbWhuanY1OGJhWTY4QjEvaktMcmdBVFAy?=
 =?utf-8?B?M0xOa3ZUMnQ0Q2ZKZTdTOHF5YlY4a1VIQUdDN2VqZllaSVJLc3FOMDJRRnd5?=
 =?utf-8?B?VnFTenpJblMyaDV3MmpEZURJL3VrdC83SlpHNmZPbkVtbEY1aHIwZjZQdXhD?=
 =?utf-8?B?bzhYOEExdHAwcTJsajhnaDNPelZzNmMrUFVNVXg5NXBoN2Vtd0lNMmg5TWky?=
 =?utf-8?B?eGd6djl1MG9GSDlmQVRWWkk5VCtZNmhHOWQwaVluVlh1TjdUVXlRVFBzVnpH?=
 =?utf-8?B?WDQ2blc5U3BLUXRCWkJJZU1RWTdBYUhDSm1ObnJRbE9kdTJ3UTREbllVVUVT?=
 =?utf-8?B?bHR0OWoyMjYwdmxNVlVzclFLSXl5cldkcmExY1FTbkpNZGlJTXRPaDJnbjRX?=
 =?utf-8?B?RUxCOFplZjluOFJCUmZIWldBS0d5aEpvVVZsUklGcDBKMWQ1ZWJKTzh2OFh5?=
 =?utf-8?B?Yi92d2xSMGg5aWFGeUVrcjJMbWFFckUxdGsvL0VuNXl1aG8yNGt1NWEyNzJh?=
 =?utf-8?B?RUNldDlOeUcrK0lrS0xLZksrYmpZb0Q4ZE5XaFFqK0xNWEpYZ1M4N01zdjAw?=
 =?utf-8?B?eTRDVnBtRDNVTlNsbWlETFloWVI5TzE4NUhvVHcra0dMeTl6eFZqWGk5TS9h?=
 =?utf-8?B?OFNISjB5aENNbkZQV21jamJETUlCSngwa3BTSmRJM0YreUhCb1ZtWElVaUZn?=
 =?utf-8?B?OWc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: janztec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c5060e-642f-48b2-4322-08dafb244bc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 20:24:13.4385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c1dae847-7bcf-493f-b143-af65743cbb23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A04n+laPA20oBebarb171fYF75YxRdLY4g61uQtq53jN2JeVNXa8lwbl0dvwF068sCVk9qXW4nfXeDetzjyQwWQ8Xx/5ZV3g+4wtwfcSwzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1784
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: AW: RE: mcp251xfd: rx frame truncation (1/2)
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: ptx@kleine-budde.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

RGFtbiBzaGl0LiBUaGUgZXJyb3IgdHJpZ2dlcmVkIHJpZ2h0IHNvb24gYWZ0ZXIgeW91IGxhc3Qg
ZW1haWwuIEl0IHRvb2sgDQp0d28gbW9yZSBlcnJvcnMgdW50aWwgSSBsZWFybmVkIHRoYXQgaXMg
YSBnb29kIGlkZWEgdG8gc2F2ZSBpbiBuYXRpdmUgZm9ybWF0DQpmaXJzdCwgYW5kIHRoZW4gYXR0
ZW1wdCB0byBleHBvcnQgdG8gdmNkICh3aGljaCB0ZW5kcyB0byBoYW5nKS4NCg0KVGhpcyB0aW1l
IHRoZSBmcmFtZSBpbiBxdWVzdGlvbiB3YXMgdHJ1bmNhdGVkIHRvIDQgYnl0ZXMuIFRoZSBvdGhl
ciBjYXNlcyBpdCB3YXMgDQphbHdheXMgdHJ1bmNhdGVkIHRvIDIwIGJ5dGVzLg0KDQpUaGUgcmVn
ZHVtcHMgd2VyZSB0YWtlbiBxdWl0ZSBhIHdoaWxlIGFmdGVyIHRoZSBlcnJvci4NCg0KLS0NClN0
ZWZhbg0KDQo=

