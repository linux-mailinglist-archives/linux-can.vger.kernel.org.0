Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530A46FDA85
	for <lists+linux-can@lfdr.de>; Wed, 10 May 2023 11:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbjEJJTA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 May 2023 05:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbjEJJS5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 May 2023 05:18:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E263A88
        for <linux-can@vger.kernel.org>; Wed, 10 May 2023 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683710334; x=1715246334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D+kwLAVrSPIIbWTWUvl2CgpkvUafPLlRa5p8NNvdWQI=;
  b=qXlKjFek32rgzN4cWBJrPA+N6qZylkMMasDCsci6yp3QdxJ/IYkuB2KQ
   x01lOcfwWGt5s7PKr+0MPX51maFcDvhV+wikBVvmyBaQoTdfXZ0pX76zG
   ZPFd8hQT29pnDuNhf2MOY/cAnyPLoBDthP/fafKp2ESfow4Gc63t8goht
   cF5nRJiohOAhgZ/12qKyVQ6hh+mptl7rX3e6rSkeIwMlgWo5Hvh8OBeuF
   a0EV3ItYfNVXAZ6C/vVIUylUSODC34g+ZVSPYiwlI9zDjO+K8SCHAy/nS
   GsUbA14q5GPuL7x4nERENrULuxnZBvBM1fWw1oAQ4xvrWSXJSJLSw3JjH
   w==;
X-IronPort-AV: E=Sophos;i="5.99,264,1677567600"; 
   d="scan'208";a="214619784"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2023 02:18:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 10 May 2023 02:18:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 10 May 2023 02:18:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li9LV+n7rqUPy3U3zvjaREBE5BQCqHbwHX9vFZj77quUssHSx1yoA7n4U4B9gLivzG18/OWRlwAC5ClsANYwAjuPH8IGlJV7P68Qsw/LP4NG/DhZ3ApDEKoCvUJL+BTMNa66Jlhs2+Sbts5c7sFaoxdtTwLhGp2EHvrbbWDcKhV37xFYVUeN7jrUruYe2gNxpCIczCWFQGM9j3xQgsHjNrTf6lKn8Az7gmnj3+uOww1+Ma+J6av+gMSMfwE4KcZBKTuoS9orzhV3y6DBxg7Yo66zi+XIgzvoDlCDG2fwPtU0joqfpl01jItGQgnVB4WVjOMmjQlHhcYyrjbZ0erY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+kwLAVrSPIIbWTWUvl2CgpkvUafPLlRa5p8NNvdWQI=;
 b=j50rmO3bey1mpLqld4G24FN5Gttm1Lg9D7QkQ68U15VOsIlv3eFsKaWarBDXG6PXjH6dM+3xX0xb6gI6Qw+KK9T6wQKpqXBOVEX0AuQ5zp8L99emkYtovfaH7HDrdXVHwnESwou3BUjxJD4/pEh+avbg6NfqJqihrrPMmPjH0DgN5q7FkHvM8EfiY5mv4bJdyaphjpwLzvKHhhSPB1r1+sQiX3MdZ40rCcBmONdb208rtTp7FKVJGBYl2mRVdCjALonqqoMk+7dm/VDdnETSSuE2f/Zlxtg7+WQO8cM+KBjJpsBIViPKzxDS5i/2LJuI9U0cuB2p2geawUoyWHycew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+kwLAVrSPIIbWTWUvl2CgpkvUafPLlRa5p8NNvdWQI=;
 b=eFk54FATqBjfZNRwHaeAvBfbed2dezf7zAk04r/rt2DCtik5qZPLBxKZmi7swmg6CORTrcGCdxfHqQPSwDUTr+9UaxgUXc1eQL8uRHzk+hdKEarDoqDvpSbxO34iYDANQ5AhCRrpiW9cSLFRoTaayb8de5OZXc7VhTxpJjQK/JI=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by SA3PR11MB7611.namprd11.prod.outlook.com (2603:10b6:806:304::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 09:17:28 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c13:dcee:8af:bbfb]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c13:dcee:8af:bbfb%5]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 09:17:28 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <vincent.mailhol@gmail.com>
CC:     <mkl@pengutronix.de>, <marex@denx.de>, <linux-can@vger.kernel.org>,
        <fedor.ross@ifm.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <lgirdwood@gmail.com>, <mani@kernel.org>,
        <broonie@kernel.org>, <pabeni@redhat.com>, <wg@grandegger.com>
Subject: RE: RE: [PATCH] can: mcp251xfd: Increase poll timeout
Thread-Topic: RE: [PATCH] can: mcp251xfd: Increase poll timeout
Thread-Index: AQHZfsHPIp3PLFFLr0mLQ+HLgrlDx69LPlkAgAAEhACAAA5zAIAABmKQgAez8+CAAB7/AIAAFaWA
Date:   Wed, 10 May 2023 09:17:28 +0000
Message-ID: <BL3PR11MB64843D32844A848AAC7BFDF1FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <20230504195059.4706-1-marex@denx.de>
 <20230505-kilt-exclusion-fd2a2423deb1-mkl@pengutronix.de>
 <BL3PR11MB64846C83ACD04E9330B0FE66FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230505-unhearing-paragraph-9b5b994f185f-mkl@pengutronix.de>
 <BL3PR11MB648479549F7120050ED93740FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <BL3PR11MB6484A68C2B2CFFAA44AD3E09FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqJo=j7wsfOPsYRn++vMSnhKBuQAwckZ-u7qwjBdsb_d_g@mail.gmail.com>
In-Reply-To: <CAMZ6RqJo=j7wsfOPsYRn++vMSnhKBuQAwckZ-u7qwjBdsb_d_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|SA3PR11MB7611:EE_
x-ms-office365-filtering-correlation-id: 36ac8c86-b6d9-42f0-e77f-08db51376059
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VxERtFF2C8Uo4o6XBa7tUIE3RdxAgjSyYYUkMhGlWgTi0iXRfz3v+8lzA6iUfWNyeDPZD/ECV5QicQiL696VQbmjfmjT2R1e76qKA18p7qdZn7uugeH2fEEVUEx5+I8oEys9Qvd/bnpy1M/mKa8ybSNS4micRjWi0uGzw0gFMDsQ7pMpPk3RDgLXHU/stbEghZCFsVUqhMEhZY1vLxmBqhutgdOAzvpquIuOcDA9IW9uGsL6nXWMI8IvY3pjkvItANNUzAAJx07w2txQAeYYFeG7nptcnJDWGkSp4CFE4Fl7RvIbndroRFlzUFpps2DPiytxsT2ls7d4CaXAx9i1CQFp/dkgkuGW8Agf3sSD7Znj/l7yM7ghb/ATlokxnSewe5kTqvaTdGYyT3HaLG8Ir0AJEh/GuKdp5/3JkOBLuNghLALhWcTiqONfxbFmHkE4fXDdCpQmR+Nyf4bYzwOQ87GZTrax3DrRK8TzEZQWMmWX28qsIlLV3qUnUCfdWo8oqDZmrVmoW4y+gDhlAQvUCNfzQ1T3cdIiTJ7CGH1yNXqTtOOoMvfalYGN3hrXvgzWfUCCG5PLDFG2PGH6OVsOyTYEKHLsx13xluTQX9Qs2aWC8S/JZ3ET/lQ0tKvuAKX0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(41300700001)(83380400001)(64756008)(66446008)(122000001)(6916009)(316002)(4326008)(55016003)(86362001)(66476007)(66556008)(66946007)(76116006)(52536014)(54906003)(38070700005)(26005)(186003)(6506007)(9686003)(71200400001)(33656002)(7696005)(478600001)(7416002)(8676002)(8936002)(53546011)(5660300002)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0ZoaHRjMlBrdjRtL09Kcnl2a0M4MEhhVkZyc2hjZDlKZVh6L3cwQzA4cnN5?=
 =?utf-8?B?TWNLcThacGpWRlk4cTBZNmdoL3FVMUg0WFNlWTEvR1JseThGS0NIMEhUSmNW?=
 =?utf-8?B?WTZERmVLNGJEbE9TUWd2L0dFODVkYlhGS0lYVE9kZkZ5WW0vUU9jTjhLT25E?=
 =?utf-8?B?UWdLZFArZDNRUUpOblFCNlZYUVA2dnV3YUthQ3U1eVFoWVhCakY2STUvZ3Fm?=
 =?utf-8?B?Tmljc09GZDVack96WnJLQnlrK09WMFlYYVI5dWZhZzkrbi9sdWw5cEhmTjVa?=
 =?utf-8?B?QlBYUHVpeGdkWW1tTENUQ2FPb1lKVVdCUDhTMjM0cG14ekpGaW1MYWVWM0RL?=
 =?utf-8?B?Y2RKVHhaYUNsVlVEZjJuYmQzSlBhaUdJWWJBdVlSVnlweUxCcG9HZUtlK0kr?=
 =?utf-8?B?S1pZaHMwSVpDcjhMZGpqUFpQRnI3TldzWUk2dGpOYkZQQ1o1Umg3RzlLQmJ5?=
 =?utf-8?B?Z1J5bG5sWFZPM0JDL29HN2F4QkZ4NWxKQ1NhUnBySDRnV0J2RVA4UlpoQ3Fr?=
 =?utf-8?B?ZC9yYUdwTFNaRndkSm91YkZTVzljekVsVU9ZUWhVS3FHc285RXFRUmEvNnoy?=
 =?utf-8?B?T0RHcTBCK2JiRm0yL1pHaVY2UmpHOFZ6TjJEZDUzWndVUkVZRTNLWDd5ODho?=
 =?utf-8?B?bjJVZERmVER2R0llTkhIT21nS3RUUmRTSENJL05iWU9qK1A2REFRRUJhbkkv?=
 =?utf-8?B?QnByeWs5aElEaHhIQjhjM0N1amR2TEQxaFNOajFkMUpZYUF5RG03aWlvVmdO?=
 =?utf-8?B?aDNPRERzRUQ3UlJnOVczZ3NBanZtM2s5STVaZnJ6a016dDNWOVRXOG95VExq?=
 =?utf-8?B?T0lBYm1OdjgyZXI5SXNjTHlDNmNMc0VBcVR3NjFBTE5LeXFiZUNRMEthdFp2?=
 =?utf-8?B?QVoyVGl2TmxxcGs1TXdvamcvUDNCMVV1U0ZoSThmcVFWbG9KbVhEM2g5YlZR?=
 =?utf-8?B?czE4dm9zbnZyKzYxSFFrSGkrV1ZSeUJUWTAycXQzcExXYVUwVlVEaFF5eklB?=
 =?utf-8?B?R01iUUtpTkI1QXBYY3UwZ3pRTGZFVklmek82N3AwMGYyV0JrOU1FT3gyR00x?=
 =?utf-8?B?Ny82eVh4OVFHandGa056ay9ybVZpVFh2RitDWVpqNGVwejYwVFVsNmF1M2ZW?=
 =?utf-8?B?Q2ljQUwrYTRCYWovUGdsaDV4RUowa040RXFtN3BGQVpJNm5tMHM3NFBLNGYz?=
 =?utf-8?B?cStoNmFtbUo5RWVUOFdVc3JwbFMxZUVBUW84Y05oL3h5WWx0aHN5VlN1Z2JH?=
 =?utf-8?B?bTQ0Qm5ZRU1OR3RaMm9vM1NvTjdFbDFmM1NqYWZGYlAvS3BXK3VYbGpYQjVT?=
 =?utf-8?B?QlpwVkhOd2tKY1Q5NEJDeGNMWVVhNUJleGZyZFhKdEhtRC95S1NEWDM1TDZS?=
 =?utf-8?B?Z0JpK01aeCtjTWJRRXI0OXNKVWxQQXNzUGVlWDZZQUVDZGxUa3ROUmNWZk1r?=
 =?utf-8?B?YTVTbzNlRGRtMlZ3MW8wM2tTRXlTU2xaWUdxUGxuenlwd2pDaXpkTDYybWtP?=
 =?utf-8?B?TUxpZUswcEFla1F5RzZsSDRHdXZHZzQ1b0RBN2hSQTdVcTNDeS9nanNvZDI3?=
 =?utf-8?B?ZFRQcFZRNkI4R0FKODFaTU45Q2pSSkx6UWVXRk03RUlBYXJTSm9XcTU2cTJr?=
 =?utf-8?B?V24zbkdwb0FYT0ZYZVlVbGJzbFU0LzNpM3dzWjBwMk1BUjlFN2hURkp6Sk0v?=
 =?utf-8?B?amlrVDd6NWp2OVVRNjJFRlordjQ1WXFUL1RjaGZZNDJvbkdDVU5udlFqM3Fy?=
 =?utf-8?B?R2lqMWsyQWRTNFg4ODNrV1lZbVI1ZG1yS3JhcmhRbFRKbGV5UVoraWlKWmZh?=
 =?utf-8?B?QTNhVFYvT01CdzljTUYydUhSMVQxSTJiNFVxNVVMSXNNaGJXY3FWSEZWQVVY?=
 =?utf-8?B?a0V4bVJwUWFuOWJNb3lPTEZDSGdVQ21jdkdkYktWQkxIT1hXaTVTZDFxNUNI?=
 =?utf-8?B?YUtzNVhqaVFIRmRJSThqaGROVStwN0dUWlNCeXBNK0lZb0RFM0pHQjNOeWxh?=
 =?utf-8?B?bmpoK09RL1NmVHNoSUhwcS9hcUdjM3ZvZ28wbWlnalJsdTArM1Y2VExGaDkx?=
 =?utf-8?B?YndHMHhkMXBxQXVDQkJRUnJ2Z2lOOXJacnpwQkpKZ0ZiVHNHZ0t1OUJNVTVj?=
 =?utf-8?Q?q+RzOznN5EkWazpF9zE6/DjPk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ac8c86-b6d9-42f0-e77f-08db51376059
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 09:17:28.4429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Krj8KFahStkSWL7zoNesiaagNb3u9wHTRGguMRz1B6ehIc4gqV+QaQImapxCMGGkgfPzXjAY/TK9L3BBZJos8kSLG+pFPT9BVCbjJU/+o4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7611
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBPbiBXZWQuIDEwIE1heSAyMDIzIGF0IDE1OjMwLCA8VGhvbWFzLktvcHBAbWljcm9jaGlwLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiA+ID4gT24gMDUuMDUuMjAyMyAwNzowNzowMywgVGhvbWFzLktv
cHBAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4gPiA+ID4gPiA+IFRoZSBkYXRhc2hlZXQgIk1DUDI1
eHhGRCBGYW1pbHkgUmVmZXJlbmNlIE1hbnVhbCIgc2F5cyBpdCBuZWVkcw0KPiBhbg0KPiA+ID4g
aWRsZQ0KPiA+ID4gPiA+ID4gYnVzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGVjaG5pY2FsbHkg
d2hhdCdzIG5lZWRlZCBpcyBhbiBpZGxlIGNvbmRpdGlvbiBvbiB0aGUgYnVzIGFzIHNwZWNpZmll
ZA0KPiA+ID4gPiA+IGluIHRoZSBJU08uIGkuZS4gMTEgY29uc2VjdXRpdmUgc2FtcGxlZCByZWNl
c3NpdmUgYml0cyBhZnRlciBhIGZ1bGwNCj4gPiA+ID4gPiBmcmFtZSAoaWYgb25lIGlzIGN1cnJl
bnRseSBpbiB0cmFuc21pc3Npb24pLg0KPiA+ID4gPg0KPiA+ID4gPiBSaWdodC4gV2hhdCBoYXBw
ZW5zIGlmIGFub3RoZXIgQ0FOIGZyYW1lcyBjb21lcyBiZWZvcmUgdGhlcmUgYXJlIDExDQo+ID4g
PiA+IGNvbnNlY3V0aXZlIHNhbXBsZWQgcmVjZXNzaXZlIGJpdHM/IFRoZSBJRlMgZm9yIENBTiBp
cyAzIGJpdHM/DQo+ID4gPg0KPiA+ID4gTm90IHF1aXRlLiBCZXR3ZWVuIHRoZSBGcmFtZXMgaXMg
YW4gSUZTIHRoYXQncyBjb3JyZWN0IGJ1dCB0aGUgSUZTIGNvbnNpc3RzDQo+IG9mDQo+ID4gPiBh
biBJbnRlcm1pc3Npb24gd2hpY2ggaXMgMyBiaXRzIGxvbmcgKyBhIGJ1cyBpZGxlIGNvbmRpdGlv
biBvZiAxMSBiaXRzLiBSZWd1bGFyDQo+ID4gPiBmcmFtZXMgaGF2ZSB0byB3YWl0IGZvciB0aGUg
SUZTIHRvIGVsYXBzZSBCVVQgdGhlcmUncyBhbiBleGNlcHRpb24gZm9yIGVycm9yDQo+ID4gPiBm
cmFtZXMgYW5kIG92ZXJsb2FkIGZyYW1lcy4gRUYgbWF5IGJlIHVwIHRvIDEyIGJpdCwgT0YgYXJl
IDggZG9taW5hbnQgKyA4DQo+ID4gPiByZWNlc3NpdmUgYml0cywgYnJvd3NpbmcgdGhyb3VnaCB0
aGUgc3BlYyBJIHRoaW5rIG9ubHkgMiBPRnMgY2FuIGhhcHBlbg0KPiA+ID4gY29uc2VjdXRpdmVs
eS4gQWRkaW5nIGFub3RoZXIgMzIgYml0cyB0byB0aGUgZm9ybXVsYSBzaG91bGQgY292ZXIgdGhp
cy4NCj4gPg0KPiA+IFJlLXJlYWRpbmcgdGhlIHNwZWMgYWdhaW4gSSBub3RpY2VkIHRoYXQgdGhl
IHBhcnQgd2hlcmUgSSB3cm90ZQ0KPiA+IHRoYXQgdGhlcmUncyBhbiAiaWRsZSBjb25kaXRpb24i
IGFmdGVyIHRoZSBpbnRlcm1pc3Npb24gaXMNCj4gPiB3cm9uZy4gV2hhdCBmb2xsb3dzIHRoZSBp
bnRlcm1pc3Npb24gaXMganVzdCAiYnVzIGlkbGUiLA0KPiA+IGRlZmluZWQgdHdvIHBhcmFncmFw
aHMgbGF0ZXIgYXMgIlRoZSBwZXJpb2Qgb2YgYnVzIGlkbGUgbWF5IGJlDQo+ID4gb2YgYXJiaXRy
YXJ5IGxlbmd0aC4iIFRoZSAxMSByZWNlc3NpdmUgYml0cyBjYW4gYmUgcmVtb3ZlZCBmcm9tDQo+
ID4gdGhlIGZvcm11bGEgYWdhaW4uIFRoZSBsb25nZXN0IHBlcmlvZCAodW5kZXIgdGhlIGFzc3Vt
cHRpb24NCj4gPiB0aGVyZSBhcmVuJ3QgbXVsdGlwbGUvY29udGludW91cyBlcnJvcnMgb24gdGhl
IGJ1cykgd2lsbCBiZQ0KPiA+IEZyYW1lICsgRXJyb3IgRnJhbWUgKDEyIGJpdCkgKyAyIHggT3Zl
cmxvYWQgRnJhbWUuDQo+ICAgICAgICAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXg0KPiANCj4gSG93
IGRpZCB5b3UgZmluZCB0aGF0IGEgZXJyb3IgZnJhbWUgaXMgMTIgYml0cz8gRnJvbSBzZWN0aW9u
IDEwLjQuNA0KPiAiU3BlY2lmaWNhdGlvbiBvZiBFRiIsIEkgY2FuIHJlYWQ6DQo+IA0KPiAgIFRo
ZSBFRiBzaGFsbCBjb25zaXN0IG9mIHR3byBkaWZmZXJlbnQgZmllbGRzLiBUaGUgZmlyc3QgZmll
bGQNCj4gICBzaGFsbCBiZSBnaXZlbiBieSB0aGUgc3VwZXJwb3NpdGlvbiBvZiBlcnJvciBmbGFn
cyBjb250cmlidXRlZA0KPiAgIGZyb20gZGlmZmVyZW50IG5vZGVzLiBUaGUgc2Vjb25kIGZpZWxk
IHNoYWxsIGJlIHRoZSBlcnJvcg0KPiAgIGRlbGltaXRlci4NCj4gDQo+IFRoZW46DQo+IA0KPiAg
IFR3byBmb3JtcyBvZiBlcnJvciBmbGFnIG1heSBiZSB1c2VkLCB0aGUgYWN0aXZlIGVycm9yIGZs
YWcgYW5kDQo+ICAgdGhlIHBhc3NpdmUgZXJyb3IgZmxhZywgd2hlcmUNCj4gDQo+ICAgIC0gdGhl
IGFjdGl2ZSBlcnJvciBmbGFnIHNoYWxsIGNvbnNpc3Qgb2YgNiBjb25zZWN1dGl2ZQ0KPiAgICAg
IGRvbWluYW50IGJpdHMsIGFuZA0KPiANCj4gICAgLSB0aGUgcGFzc2l2ZSBlcnJvciBmbGFnIHNo
YWxsIGNvbnNpc3Qgb2YgNiBjb25zZWN1dGl2ZQ0KPiAgICAgIHJlY2Vzc2l2ZSBiaXRzIHVubGVz
cyBpdCBpcyBvdmVyd3JpdHRlbiBieSBkb21pbmFudCBiaXRzDQo+ICAgICAgZnJvbSBvdGhlciBu
b2Rlcy4NCj4gDQo+IEZpbmFsbHk6DQo+IA0KPiAgIFRoZSBlcnJvciBkZWxpbWl0ZXIgc2hhbGwg
Y29uc2lzdCBvZiA4IHJlY2Vzc2l2ZSBiaXRzLg0KPiANCj4gU28gdGhlIGVycm9yIGZyYW1lIHNo
b3VsZCBiZSAxNCBiaXRzICg2ICsgOCksIG5vdCAxMiwgcmlnaHQ/DQpUaGF0IHdhcyBpbXByZWNp
c2UsIHlvdSdyZSByaWdodCAtIEkgbWVhbnQgYW4gRXJyb3IgRmxhZywgbm90IEZyYW1lIGFuZCBo
ZW5jZSB0aGUgOCByZWNlc3NpdmUgYml0cyB3ZXJlIG1pc3NpbmcuIFRoZXJlJ3MgYW4gYWN0aXZl
IGVycm9yIGZsYWcgKyBwYXNzaXZlIGVycm9yIGZsYWcgdGhvdWdoIHdoaWNoIGNhbiBiZSA2IGJp
dHMgbG9uZyBlYWNoLiBJbiBzZWN0aW9uIDEwLjQuNC4yIFRoZSB0b3RhbCBsZW5ndGggb2YgdGhp
cyBzZXF1ZW5jZSBtYXkgdmFyeSBiZXR3ZWVuIGEgbWluaW11bSBvZiA2IGJpdCBhbmQgYSBtYXhp
bXVtIG9mIDEyIGJpdC4NCg0KPiBGb3IgdGhlIGdyZWF0IHRvdGFsLCBpZiB5b3Ugd2FudCB0aGUg
YWJzb2x1dGUgd29yc3QgY2FzZSwgeW91IHNob3VsZA0KPiBjb25zaWRlciB0aGF0Og0KPiANCj4g
ICAtIFRoZSBlcnJvciBmcmFtZSBtYXkgc3RhcnQgYXQgYW55IHBvaW50LiBGb3IgZXhhbXBsZSwg
eW91IG1heQ0KPiAgICAgb2JzZXJ2ZSB0aGUgZmlyc3QgdHdvIGJpdHMgb2YgdGhlIGludGVybWlz
c2lvbiBhbmQgaGF2ZSBpdA0KPiAgICAgYnJva2VuIGJ5IGFuIGVycm9yIGZyYW1lLiBJdCBtYXkg
YWxzbyBhcHBlYXIgaW4gdGhlIG1pZGRsZSBvZg0KPiAgICAgYSBkYXRhIGZyYW1lLiBTbyB5b3Ug
bWF5IGNvbnNpZGVyIGNhc2VzIHN1Y2ggYXM6IHBhcnRpYWwNCj4gICAgIGZyYW1lICsgZXJyb3Ig
ZnJhbWUgKyBpbnRlcm1pc3Npb24gKyBmcmFtZSArIC4uLg0KPiANCj4gICAtIFRoZSBvdmVybG9h
ZCBmcmFtZSBpcyByZXF1aXJlZCB0byAiZGVzdHJveSB0aGUgZml4ZWQgZm9ybSBvZg0KPiAgICAg
dGhlIGludGVybWlzc2lvbiBmaWVsZCIuIFNvIGV2ZW4gaWYgbm90IGV4cGxpY2l0bHkgc3BlY2lm
aWVkLA0KPiAgICAgSSB0aGluayB0aGF0IG92ZXJsb2FkIGZyYW1lIG1heSBzdGFydCBhZnRlciB0
aGUgc2Vjb25kDQo+ICAgICByZWNlc3NpdmUgYml0cyBvZiB0aGUgaW50ZXJtaXNzaW9uLCBlLmcu
IGZyYW1lICsgMiBiaXRzIG9mDQo+ICAgICBpbnRlcm1pc3Npb24gKyBvdmVybG9hZCBmcmFtZSAr
IDIgYml0cyBvZiBpbnRlcm1pc3Npb24gKw0KPiAgICAgb3ZlcmxvYWQgZnJhbWUgKyBmdWxsIDMg
Yml0cyBpbnRlcm1pc3Npb24NCj4gDQo+ICAgLSBBbiBlcnJvciBmcmFtZSBvciBhbiBvdmVybG9h
ZCBmcmFtZSBtYXkgdHJpZ2dlciBhbm90aGVyIGVycm9yDQo+ICAgICBmcmFtZSBpZiBhIG5vZGUg
ZG9lcyBub3QgY29ycmVjdGx5IHJlY2VpdmUgb25lIG9mIHRoZSBiaXRzIGluDQo+ICAgICB0aGUg
Zml4ZWQgZm9ybSBkZWxpbWl0ZXIuIFRoZSBvbmx5IGV4Y2VwdGlvbiBpcyB0aGUgbGFzdCBiaXQN
Cj4gICAgIG9mIHRoYXQgZGVsaW1pdGVyIChjLmYuIHNlY3Rpb24gMTAuMTEgIkVycm9yIGRldGVj
dGlvbiINCj4gICAgIHBhcmFncmFwaCBkKSAiRm9ybSBlcnJvciIpLiBJbiBvdGhlciB3b3Jkcywg
eW91IGNhbiBoYXZlDQo+ICAgICB0aGUgdHdvIG92ZXJsb2FkIGZyYW1lcywgdGhlbiBhbiBlcnJv
ciBmcmFtZSwgdGhlbiB0d28NCj4gICAgIG92ZXJsb2FkIGZyYW1lcyBhZ2Fpbi4NCj4gDQo+IFRo
aXMgaXMgdG8gc2F5IHRoYXQgdGhlIHdvcnN0IGNhc2Ugc2NlbmFyaW8gaXMganVzdCBub3Qgc29t
ZXRoaW5nDQo+IHdvcnRoIGNvbnNpZGVyYXRpb24uDQoNCkFDSw0KPiBUaGUgYXNzdW1wdGlvbiB0
aGF0IG9ubHkgb25lIGVycm9yIGZyYW1lIG9jY3VycyBpcyBwcmV0dHkgYXJiaXRyYXJ5LiBJDQo+
IHdvdWxkIHN1Z2dlc3QgbWFraW5nIGl0IHNpbXBsZXIgYW5kIHNpbXBseSBpZ25vcmUgZXJyb3Ig
YW5kIG92ZXJsb2FkDQo+IGZyYW1lcy4gQXMgbG9uZyBhcyBmcmFtZSArIGludGVybWlzc2lvbiB3
b3JrcyB3ZWxsIGluIGVtcGlyaWNhbCB0ZXN0cywNCj4gSSB3b3VsZCBzdWdnZXN0IHRvIHN0YXkg
d2l0aCB0aGF0IGFuZCBjYWxsIGl0IGEgZGF5Lg0KDQpDb3JyZWN0LCB0aGF0J3Mgd2h5IEkgd3Jv
dGU6ICh1bmRlciB0aGUgYXNzdW1wdGlvbiB0aGVyZSBhcmVuJ3QgbXVsdGlwbGUvY29udGludW91
cyBlcnJvcnMgb24gdGhlIGJ1cykgYnV0IEkgYWdyZWUgdGhhdCdzIGEgcHJldHR5IGFyYml0cmFy
eSBsaW1pdC4gU28gSSdtIGZpbmUgd2l0aCBjaGFuZ2luZyBpdCB0byBvbmUgb3IgdHdvIGZ1bGwt
c2l6ZWQgZnJhbWVzICsgaW50ZXJtaXNzaW9uKQ0KDQpCZXN0IFJlZ2FyZHMsDQpUaG9tYXMNCg==
