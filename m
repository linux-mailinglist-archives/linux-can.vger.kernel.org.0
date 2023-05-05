Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B889E6F7E99
	for <lists+linux-can@lfdr.de>; Fri,  5 May 2023 10:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjEEIVo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 May 2023 04:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjEEIVm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 May 2023 04:21:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A787516349
        for <linux-can@vger.kernel.org>; Fri,  5 May 2023 01:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683274901; x=1714810901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O7c6ylya4MDsKon1hQNOAQnazAGMyRFiI9YyGRI7ASA=;
  b=zVR8ODivcGF/Y2/Uj2uQik8NQAoEjh1WcCYZfBAHvrAwqCfpVG874SSR
   O9Tt4XNuSNiCkrIo5qbovvsiq3tKLuACZ/jbVnxrEmKjWAZ5cMLQsM9LY
   YOy9IlR2DL8LJ1R0TQGif2930AiobtyBGP3zRDTI2I0iwsx1BVYHEZBfd
   ClfBVJWQpEpvdHHJmraBClGgCVzrbtIrATAWyUgdHVLDCFsKcQu57Qlrq
   NZiH/NVvPaLx03AhcjyfA0YHlc0vb3GUubO47+q8othLOelVVbZJaTRjB
   VmtlW6r1ia/IC3CkA2ds7trFpXa+V57lonexlVgsVoHaBY23n21xOSE2P
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,251,1677567600"; 
   d="scan'208";a="213845827"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2023 01:21:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 5 May 2023 01:21:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 5 May 2023 01:21:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIKr9WSAvMjioA+HvW+Ln3NssfFj0yWyR+F99QeVz5AvnP3uYEg68uYLf89cQv1E3u9F+f61WEIm/zD5iXJJ9WYn4s+oO2AP9AhNI9XdYrXYxT0OohqkJYfJ1IkEvFlh6LOUA3EDiOY4UP/6p9q5cSG6doPR8MsmJoksXRULf+EbpA+Jape8DaZmeve7qAvbp2d8je+pahg12FPS85sGezmtNiPrCQL0sjY/pJkazGawwqA4SuhbEpCZLdZq6wVZvD2PuCJ1Pew/O6GsUddWaNoDaIF1YTRin9rdlvAsAcqozT9bueC7t3WaiZMW+B6w24egCOdqEQcKEedauxcabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7c6ylya4MDsKon1hQNOAQnazAGMyRFiI9YyGRI7ASA=;
 b=Xthc7YhDwsR2hyrzDrxgpheEl2YJKBUvzyjFJj8RuN+p0iXPzgQ6SB7zyyvW5qKilpcPpH6Bo0rlgrtJjGZPX66Ks/YRaFNWw3vj3GQ+x9pAXD+uZVcRmxpSCJdWeRZdwW6XL2I9knsR6j+ghfjPFYw3o3Z76EeCfgwhVrVJiSH08OS96YfDHpiAH68F0+Yo+JHsgisCAMM12GdfUW0ZfjEXIRXorm31LJJ0uv4luGxD/qnLBQ+qDdkUhuQ8X5y3LwJ1UEjqzu2G8DjqV8I5qerTihFUe0H3n2lvYyjVAskUFJkO5MKpBl3p4ZRhsOTCkeyOG718uyqGuoFumKrcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7c6ylya4MDsKon1hQNOAQnazAGMyRFiI9YyGRI7ASA=;
 b=vU3YYKhfgr/CkhkkkatJzJ065+eYlyCXwWqMqjUBPpWHu6FeHeTwOiHkq1obZTpWb4Y43HH+KnkYekTERtTVc9BAwm73W85WL1G8dhPndUK3PpQAl508vGC7rgnJd9W+WzvH2xXAVqWyt46DpjoKNUZpOlbMI0aChAuPEwPgjgk=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by CH3PR11MB7866.namprd11.prod.outlook.com (2603:10b6:610:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 08:21:37 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c13:dcee:8af:bbfb]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c13:dcee:8af:bbfb%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 08:21:36 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>
CC:     <marex@denx.de>, <linux-can@vger.kernel.org>, <fedor.ross@ifm.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <lgirdwood@gmail.com>, <mani@kernel.org>, <broonie@kernel.org>,
        <pabeni@redhat.com>, <wg@grandegger.com>
Subject: RE: RE: [PATCH] can: mcp251xfd: Increase poll timeout
Thread-Topic: RE: [PATCH] can: mcp251xfd: Increase poll timeout
Thread-Index: AQHZfsHPIp3PLFFLr0mLQ+HLgrlDx69LPlkAgAAEhACAAA5zAIAABmKQ
Date:   Fri, 5 May 2023 08:21:36 +0000
Message-ID: <BL3PR11MB648479549F7120050ED93740FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <20230504195059.4706-1-marex@denx.de>
 <20230505-kilt-exclusion-fd2a2423deb1-mkl@pengutronix.de>
 <BL3PR11MB64846C83ACD04E9330B0FE66FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230505-unhearing-paragraph-9b5b994f185f-mkl@pengutronix.de>
In-Reply-To: <20230505-unhearing-paragraph-9b5b994f185f-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|CH3PR11MB7866:EE_
x-ms-office365-filtering-correlation-id: b8dffe7f-1c2c-4f93-9ec1-08db4d41be5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LjK0ApMOtV33vLnPPegHDCuXVf3qJaOqsCcCZ+uQmNg4zyDZmKhwkbkWBIyDwM3knWtjgOM4x98mS436MlS7JurHfsdY0smDEZn/XWjDn1oEAOMQa0Wg6ikb3NzjpvZ3RQCgpb9L7TfkcQ443y9D+WZyPYGwNHAuuW7kKsXlkbKuxhYes6DAZPylbAJraeoRDhWDayKl2LOEArrjCZAeNib4rp5iFX8TNAfp09tzoGWQ5FUJ9FAydS796QVqrXEqmOkPxiaW2DGWrKiP0dl5gF/+q53K6JlBmzUv5vz0+WVT/UXPcEZjhk42FhMlVu4XpsI2uhHwFuPRtJ6elER3yRBUAK85Q9hafrxVSkECfXbQS7t+yhm4ESQRPSTF+i3WhtCGwo5IDfC2kbhFtVHuyl4xyiFUCdGOwv5zOQZQSrszaGthN/TweIwk4qjqfZRwmPk5wzq6wuELO2mTXI7S0zR6W6Q23G/Miw+WjZLNj5rSg0LeONg6tF7tNsyprNmRaWU4ctNwiPFdAW6Ci2IGeiVhoLm3X8eVKXpMrewwDlAaYZ9HjeWcUjomJ0yKcLotgUO57bN4rtqumCxA8qVHQLr9pQB1bvWUT9W+9J415KQyKC7sNyjSJLBqkkz/H0Oy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(76116006)(66556008)(66476007)(71200400001)(66946007)(66446008)(6916009)(4326008)(7696005)(64756008)(316002)(54906003)(33656002)(86362001)(478600001)(83380400001)(53546011)(9686003)(6506007)(26005)(5660300002)(8936002)(8676002)(52536014)(2906002)(41300700001)(7416002)(55016003)(122000001)(38070700005)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVNxRWc1VVo1dzI3VE5PaGF0RFdGTXErUzZ4c2p1YXJxZlI2ZkdVbzVOWk5M?=
 =?utf-8?B?c3ZDSlczMnFDYkRqQlNPNVEra0plMUtLRkVwNVMwZ0dzOXhKaU9PWWxFekth?=
 =?utf-8?B?TGdsUXJBZktrUHpjQ3FaNitWamNhbXBidXV6a0Rxc0Y1UWxXaXFIa3hJKzFO?=
 =?utf-8?B?NDVlNG11UEhaVEgzWHNLQVlneTZ0SUFUTS82Ny92aDRVMGRNVUFvcTMyYjV0?=
 =?utf-8?B?Ynp2czNkSTh6dHFKRTRFbTFKaXhQeWN3bisxaWJoMmVpbDlXbVNWcHRUTmVt?=
 =?utf-8?B?SEdQSENXQ1BMNmRvSXVScDBETUpNZUVXMUZTZ2JMb1FiVHNoYmZ2S3YzWEFy?=
 =?utf-8?B?dTZwWFJrSzF1REJtTnV6dlR4b0lBRGpaWVJuR0duYnhvQ3dTTDN1UXVlak5T?=
 =?utf-8?B?Z1VLc0tvSFVZUVBwVlJtVXBaTUtMblFaUE9EaytpUnh2U0NlNGZMUVR2amo3?=
 =?utf-8?B?T1pVRzJXQWNsRUgybXdmYXRremxXaHhQZnR1UVgxWFY1bWxlQ3VMV0hsMFl2?=
 =?utf-8?B?SWwxUVVyMGx1KzN6SEV1QnkyQWxtWXRJUGVCNTJIQk0zWEJ1SDVZZGxHQmlJ?=
 =?utf-8?B?SS9EUVppRHhLV2FOTXhZeEV4UXVBZitHNGlPMGNWU3d5bmtMNE1aYUpsWnBz?=
 =?utf-8?B?OHZtT0VmbHNsMDhkVVRIeno1REY0K3FwWlZxbWxodWx6RTN4YXRGSHBNR0lm?=
 =?utf-8?B?QWRZbE5ITjV6blpLRDd3N1YzYmZNRHJucmNMeDkrQnR5YVhTNnQ1ZGMzNVJU?=
 =?utf-8?B?VFZNSFFNMzFMNWRJT25UZjBtdWczcGVuSkdkbC9tR1BLNit1eGo0MENUM3RX?=
 =?utf-8?B?STRNQWxmWnBNY1pGOXY4TFFiTkxDTVdjV1RjQk8xbndNbVpIQWtZeHRoeDYz?=
 =?utf-8?B?d0swd0pkTVdWT2xneTA3MEFpbzNzcjNXSkJpMk12dEhqU0prVmpQdTdtZnlO?=
 =?utf-8?B?cUs1dmhyWjNEMlQ5elJtaEhEMDhwWVM5ME5ZTDBQcHRsM01iL2xDSDhCM3Zw?=
 =?utf-8?B?aEtoYzRMUkVPc0pTNlkxbjJWZzFNUy9EbURtUGpLM2JNNTRvVHNQVC8vdkN5?=
 =?utf-8?B?RmFWWVQrV1kzbGkwdEpTcUdySG5WVkRpSmFjNGdEMm1EMVd1Z1BaRUZFZmxy?=
 =?utf-8?B?MWh0bWM4YVZUUm5iZGEzWXVvb1Y2N3J0RU9JdFBNOE16RHpYRlZveHBQYnds?=
 =?utf-8?B?dHdJc1c4dFBPQnIvZUlLdFFia0U0SG9FQ3ByZDN1K1RFQzRRbHh6RHp0a0Jh?=
 =?utf-8?B?NDQ2UGI2dkEwUTV4T2VEWXBhbEdYcFJKcU81ajZMWmEyVk1XRVp1UFFScXNQ?=
 =?utf-8?B?NTBsalNFYTEyRFF5NDhqZGh3bHdXOTVQYWVuR04vcTY5Z0JJb0JzTUJOUGY5?=
 =?utf-8?B?VlNIZk1OUHI4eDlrNGJTS0IvT2ZiakpJSWI2L3paUWptUjlMRy9sTEZuM1dq?=
 =?utf-8?B?Q2p5RGVMUGc4R0hWNVh3S056aXdlaWJCTUE2dldCYzRJb09DVU5FclprUU1V?=
 =?utf-8?B?bUNYSFFIZm9XSHR2VjlEK1JIekJ5S0xPVFZSdTMrZDhxUHdDSjZBZnRPQ0ZW?=
 =?utf-8?B?cHllNUtwMHJ6bFpqTGlFU2ZkSTV6cS9HUmVuMTROMExKMEtOaEF5WnZFZ0Fn?=
 =?utf-8?B?ZktNOWJudFVKSmdpK2xCVGlSS0MzVjZBZmtQdE9GUFhaQVFkU1l1MVlxYTZM?=
 =?utf-8?B?UzNmL3RveUVLdVpEODFUam83NWZFU1ZmT1V0ZVFwWlZpS2NLYnNONnRYVUth?=
 =?utf-8?B?emRtdUVyeVZraFFYOXVtb3BmUlNmYzZmZVBUV2RMZENRUHRCV1hSZWVqd0t2?=
 =?utf-8?B?TFVWYVpRL0hnb0ZXZ25NTjN3bVhseTNlQUlCaE94cXFxMllrNWFqOS9ZbkRp?=
 =?utf-8?B?S3BaMTdtSXpGQ3p3c3FnQnFuUXFuVW15ckxpZnhWWXliR1RnWjVGbzkrT2RV?=
 =?utf-8?B?SjR2QkdSb2pSUnBXVHhXRnMreFMvR2NhaEpZeWRCRWI2UWZzd1VzU0ZWeGNk?=
 =?utf-8?B?VG1oNjdpSnJlVGxNWWw4NFptYUVWSU9mdjM5MURzTy9GM1d6Ykc1NG1CMldP?=
 =?utf-8?B?U21qNnlTS2dUQ1llbHBveWdtUnRwN2IvSzN2UnAxck1GeGtPWFhZRC9EWFBX?=
 =?utf-8?Q?KwOFRuNlcZsVK2HfeOLAh1YWd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dffe7f-1c2c-4f93-9ec1-08db4d41be5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 08:21:36.4415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IFvgCPw9UYqG+noyvzmTmX99KvLQEAZHQh1ZbbldrRtA4sc8ihInDLCM6/FBmvQjSoTNR/Oefb/fWjqDotCoCUlSP0ypKdj+/FtdljPKRRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7866
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiBPbiAwNS4wNS4yMDIzIDA3OjA3OjAzLCBUaG9tYXMuS29wcEBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPiA+ID4gVGhlIGRhdGFzaGVldCAiTUNQMjV4eEZEIEZhbWlseSBSZWZlcmVuY2UgTWFudWFs
IiBzYXlzIGl0IG5lZWRzIGFuIGlkbGUNCj4gPiA+IGJ1cy4NCj4gPg0KPiA+IFRlY2huaWNhbGx5
IHdoYXQncyBuZWVkZWQgaXMgYW4gaWRsZSBjb25kaXRpb24gb24gdGhlIGJ1cyBhcyBzcGVjaWZp
ZWQNCj4gPiBpbiB0aGUgSVNPLiBpLmUuIDExIGNvbnNlY3V0aXZlIHNhbXBsZWQgcmVjZXNzaXZl
IGJpdHMgYWZ0ZXIgYSBmdWxsDQo+ID4gZnJhbWUgKGlmIG9uZSBpcyBjdXJyZW50bHkgaW4gdHJh
bnNtaXNzaW9uKS4NCj4gDQo+IFJpZ2h0LiBXaGF0IGhhcHBlbnMgaWYgYW5vdGhlciBDQU4gZnJh
bWVzIGNvbWVzIGJlZm9yZSB0aGVyZSBhcmUgMTENCj4gY29uc2VjdXRpdmUgc2FtcGxlZCByZWNl
c3NpdmUgYml0cz8gVGhlIElGUyBmb3IgQ0FOIGlzIDMgYml0cz8NCg0KTm90IHF1aXRlLiBCZXR3
ZWVuIHRoZSBGcmFtZXMgaXMgYW4gSUZTIHRoYXQncyBjb3JyZWN0IGJ1dCB0aGUgSUZTIGNvbnNp
c3RzIG9mIGFuIEludGVybWlzc2lvbiB3aGljaCBpcyAzIGJpdHMgbG9uZyArIGEgYnVzIGlkbGUg
Y29uZGl0aW9uIG9mIDExIGJpdHMuIFJlZ3VsYXIgZnJhbWVzIGhhdmUgdG8gd2FpdCBmb3IgdGhl
IElGUyB0byBlbGFwc2UgQlVUIHRoZXJlJ3MgYW4gZXhjZXB0aW9uIGZvciBlcnJvciBmcmFtZXMg
YW5kIG92ZXJsb2FkIGZyYW1lcy4gRUYgbWF5IGJlIHVwIHRvIDEyIGJpdCwgT0YgYXJlIDggZG9t
aW5hbnQgKyA4IHJlY2Vzc2l2ZSBiaXRzLCBicm93c2luZyB0aHJvdWdoIHRoZSBzcGVjIEkgdGhp
bmsgb25seSAyIE9GcyBjYW4gaGFwcGVuIGNvbnNlY3V0aXZlbHkuIEFkZGluZyBhbm90aGVyIDMy
IGJpdHMgdG8gdGhlIGZvcm11bGEgc2hvdWxkIGNvdmVyIHRoaXMuDQoNCj4gPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9zcGkvbWNwMjUxeGZkL21jcDI1MXhmZC1jb3JlLmMNCj4g
PiA+IGIvZHJpdmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4ZmQvbWNwMjUxeGZkLWNvcmUuYw0KPiA+
ID4gPiBpbmRleCA2OGRmNmQ0NjQxYjVjLi45OTA4ODQzNzk4Y2VmIDEwMDY0NA0KPiA+ID4gPiAt
LS0gYS9kcml2ZXJzL25ldC9jYW4vc3BpL21jcDI1MXhmZC9tY3AyNTF4ZmQtY29yZS5jDQo+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9zcGkvbWNwMjUxeGZkL21jcDI1MXhmZC1jb3JlLmMN
Cj4gPiA+ID4gQEAgLTIyNyw2ICsyMjcsNyBAQCBzdGF0aWMgaW50DQo+ID4gPiA+ICBfX21jcDI1
MXhmZF9jaGlwX3NldF9tb2RlKGNvbnN0IHN0cnVjdCBtY3AyNTF4ZmRfcHJpdiAqcHJpdiwNCj4g
PiA+ID4gIAkJCSAgY29uc3QgdTggbW9kZV9yZXEsIGJvb2wgbm93YWl0KQ0KPiA+ID4gPiAgew0K
PiA+ID4gPiArCWNvbnN0IHN0cnVjdCBjYW5fYml0dGltaW5nICpidCA9ICZwcml2LT5jYW4uYml0
dGltaW5nOw0KPiA+ID4gPiAgCXUzMiBjb24gPSAwLCBjb25fcmVxb3AsIG9zYyA9IDA7DQo+ID4g
PiA+ICAJdTggbW9kZTsNCj4gPiA+ID4gIAlpbnQgZXJyOw0KPiA+ID4gPiBAQCAtMjUxLDcgKzI1
Miw4IEBAIF9fbWNwMjUxeGZkX2NoaXBfc2V0X21vZGUoY29uc3Qgc3RydWN0DQo+ID4gPiBtY3Ay
NTF4ZmRfcHJpdiAqcHJpdiwNCj4gPiA+ID4NCj4gPiA+IEZJRUxEX0dFVChNQ1AyNTFYRkRfUkVH
X0NPTl9PUE1PRF9NQVNLLA0KPiA+ID4gPiAgCQkJCQkJIGNvbikgPT0gbW9kZV9yZXEsDQo+ID4g
PiA+ICAJCQkJICAgICAgIE1DUDI1MVhGRF9QT0xMX1NMRUVQX1VTLA0KPiA+ID4gPiAtCQkJCSAg
ICAgICBNQ1AyNTFYRkRfUE9MTF9USU1FT1VUX1VTKTsNCj4gPiA+ID4gKwkJCQkgICAgICAgbWF4
KE1DUDI1MVhGRF9QT0xMX1RJTUVPVVRfVVMsDQo+ID4gPiA+ICsJCQkJCSAgIDU3NiAqIFVTRUNf
UEVSX1NFQyAvIGJ0LT5iaXRyYXRlKSk7DQo+ID4gPg0KPiA+ID4gTGV0J3MgdXNlIENBTkZEX0ZS
QU1FX0xFTl9NQVggKiBCSVRTX1BFUl9CWVRFIGluc3RlYWQgb2YgNTc2LiBJIGNhbg0KPiBmaXgN
Cj4gPiA+IHRoaXMgd2hpbGUgYXBwbHlpbmcuDQo+ID4gPg0KPiA+IFNvLCBJJ2Qgc3VnZ2VzdCBD
QU5GRF9GUkFNRV9MRU5fTUFYICogQklUU19QRVJfQllURSArIDExICsgc3R1ZmZiaXRzLA0KPiA+
IGFzIGZhciBhcyBJIGNhbiB0ZWxsIHRoZSBDQU5GRF9GUkFNRV9MRU5fTUFYIGlnbm9yZXMgc3R1
ZmZiaXRzLCBzbyBhcw0KPiA+IGFuIG92ZXJhcHByb3hpbWF0aW9uIHNvbWV0aGluZyBsaWtlIChD
QU5GRF9GUkFNRV9MRU5fTUFYICoNCj4gPiBCSVRTX1BFUl9CWVRFKSAqIDEuMiArIDExLg0KPiAN
Cj4gLi5hbmQgYSBkZWZpbmUgZm9yIHRoZSAxMSBhbmQgYSBjb21tZW50IGZvciB0aGUgKiAxLjIN
Cj4gDQpSaWdodCwgSSB0aGluayBkZWZpbml0aW9ucyBmb3IgdGhlIDExIGFuZCB0aGUgMS4yIG1h
a2Ugc2Vuc2UgaW4gdGhlIGluY2x1ZGUvbGludXgvY2FuL2xlbmd0aC5oIGFueXdheS4NCg0K
