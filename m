Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915866FDBCD
	for <lists+linux-can@lfdr.de>; Wed, 10 May 2023 12:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbjEJKjk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 May 2023 06:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbjEJKjj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 May 2023 06:39:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F08E66
        for <linux-can@vger.kernel.org>; Wed, 10 May 2023 03:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683715178; x=1715251178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G30xePVhuUMBM3c5r7q2RE+XnvAcC88NS/igDAOJTbU=;
  b=NYPfLZlwMcnYu/Skfa9Q6J/j/oWJmc1vcBIfLwdWikNXMry/28VqlFuZ
   KIAH+Fgb8RKBPF+1qjd+1f2//GQEPsKRmp0GWcG0EG4AP461YxRbBhAiM
   nw6GMgGf0zhd3Q4UbhkTFNeMYIykbYlX8Yy6CT2QmnJVZZsHDW9mmeun5
   k1Yacb1m9xT4atqdkpA+cxEFmng8O+xPtxwIQiEQTEP7UAxWoGaLof9sC
   Tym3wMhQdS/5pTvm+xVk3iMC6+rESghu8owxQwgW7JlakxqMaD1wpaB5v
   f+GYuNe0+GMFM3Iq9Ky8uJxvDB6b9x5bGKNMTnOs2xzhBK54TAR/y1lcV
   g==;
X-IronPort-AV: E=Sophos;i="5.99,264,1677567600"; 
   d="scan'208";a="214628503"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2023 03:39:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 10 May 2023 03:39:30 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 10 May 2023 03:39:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQsl8OPcBu+k7JiXgJmLBc2zjJNbihwZcT5BgP4hUdqWyx+zCwALUmnLNcsaXzZplshInkZV5ZzvAyJkqH99RIfOi3tHCxnbI5i2woGGUv6M55HtunOKg8MB2bNtVTJHZIGmgalSMAVRgP8rBJbKFjmTrCTWuCCwvn0Jgo7j4NJIOnINVuFcSTUTT1+bPcexvoxTUYG+tMuhQEHyokOxkWf3IwQyprKU/opfAjrER3PXvzh03NFOrpV1qU9ShG8IllkDWhBS69FhXBVqW9IH3vIarOKCrQvVY92nPz2Q+DXWLFddbpshfEti9BvMZNEZrsD7WiffvmIlbFjj1VVfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G30xePVhuUMBM3c5r7q2RE+XnvAcC88NS/igDAOJTbU=;
 b=Cy52v8+W+itouCZ0aU8nDBAbYcBej7z5R6RA5KpKSIpUXfhnED7Fi3BxSiK7vmwkC+QbZ7/eAs6oQ2MT3YB6leYD93fJdqPoH+Ue4mmdstf1OrdMfPp474Zpz8HAsnjFsFoD+azZPvLer0JTpbhAzZLxZUKeVI2OCH4IOsztRj9AFJrQ571vcA9XDwhGjMSqiCAQ7e4KYYFUDw8nKp7pqdsCgKW5e65xYD9y3p8ySE8N2GrXYhwwbNwTHjorbaQkaOOqoyWFZh4TW20A5ipVl6Abc+Sf5obWmljsnVMKaqMWTWqTSGULrmZP5nV1Kh0km0h8goj/ITIWv58ifcI3sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G30xePVhuUMBM3c5r7q2RE+XnvAcC88NS/igDAOJTbU=;
 b=lh25f06mN/UXEYO8I4TJ2Wh6w/r6I3MT1iVkvcYKRAuCCmy0IpDgUzR/CfO57ONN6t9DbrqK+343wV0MrAf40V5k9kJoMck2He3TpAGU9W/XE2PoC6ClmZkMcSHe/JlhWcQSES/yNeQXY6oos2MkqUt9gVUH8qcsFXGiRsC2Lyc=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by PH7PR11MB6331.namprd11.prod.outlook.com (2603:10b6:510:1fd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 10:39:25 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c13:dcee:8af:bbfb]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c13:dcee:8af:bbfb%5]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 10:39:24 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <vincent.mailhol@gmail.com>
CC:     <mkl@pengutronix.de>, <marex@denx.de>, <linux-can@vger.kernel.org>,
        <fedor.ross@ifm.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <lgirdwood@gmail.com>, <mani@kernel.org>,
        <broonie@kernel.org>, <pabeni@redhat.com>, <wg@grandegger.com>
Subject: RE: RE: [PATCH] can: mcp251xfd: Increase poll timeout
Thread-Topic: RE: [PATCH] can: mcp251xfd: Increase poll timeout
Thread-Index: AQHZfsHPIp3PLFFLr0mLQ+HLgrlDx69LPlkAgAAEhACAAA5zAIAABmKQgAez8+CAAB7/AIAAFaWAgAAPRgCAAAcnAA==
Date:   Wed, 10 May 2023 10:39:24 +0000
Message-ID: <BL3PR11MB64846AD5ACBC42C74D11DF7DFB779@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <20230504195059.4706-1-marex@denx.de>
 <20230505-kilt-exclusion-fd2a2423deb1-mkl@pengutronix.de>
 <BL3PR11MB64846C83ACD04E9330B0FE66FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230505-unhearing-paragraph-9b5b994f185f-mkl@pengutronix.de>
 <BL3PR11MB648479549F7120050ED93740FB729@BL3PR11MB6484.namprd11.prod.outlook.com>
 <BL3PR11MB6484A68C2B2CFFAA44AD3E09FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqJo=j7wsfOPsYRn++vMSnhKBuQAwckZ-u7qwjBdsb_d_g@mail.gmail.com>
 <BL3PR11MB64843D32844A848AAC7BFDF1FB779@BL3PR11MB6484.namprd11.prod.outlook.com>
 <CAMZ6RqK266c+taxgUqd_2kSfbNDgTawkcthTaM+4JXpeLV0cfQ@mail.gmail.com>
In-Reply-To: <CAMZ6RqK266c+taxgUqd_2kSfbNDgTawkcthTaM+4JXpeLV0cfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|PH7PR11MB6331:EE_
x-ms-office365-filtering-correlation-id: 9f8651d5-3d2a-4832-9979-08db5142d2ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C3TWEZcq2PG20Qw2nlo9R77afBU0wvpe0fXEhvMR0uXCxj8h3fjDSiXUOM3D3IhMQWEK+/jKBSRz97GJEwopv+aypgkgDKkdofstF7o8FibcxK3HMh0xHg+74og98hkAen6OpN2obPeE+EJ5055gMPk8HxNMROGMrrFEuIG+kZDOBMlWUY22hL0gZJv2BXijvZkIxE7AeLdm934N3IvJ1M0NQH4bSvBUyE0CbhI8LM4EJ+J5Ok02SrGvQK2gs3wqXUUcSvCCKwHMYvBqoC4VOZ0886Dk7EP53nVY88Ju7FNQYxogiGPibOXapfSorvQls+QItTsgigDH3XSt9WxXOxRYx8PCfK46LuOv5qyjQ1MxqUQt2yJ0R43nVjYjFgrGcIhCnH9vcuBElEvcrmVF89AdAaUu9YF7tjSb8cYlxIJUUiutyGzZu+shD5YWrfmaAPbdOTmzgwqWLzyLLrngn6cSFzPmw+Uh/m8W7uFcIMZV2ny2gP7pJJITruspAFVfoclyOOVeS1t+wkjuCDoFgYQ00n/lWRLDeIeeCSCHrlCV7CuVapVWeScbGsiBq2evYua8+SypMibrGICXFroSK7divpwawF78iB7QTXkMR1Sbb/Rwjc8Ns+4ksGYnmluV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(66476007)(86362001)(33656002)(4326008)(66446008)(54906003)(316002)(6916009)(76116006)(66946007)(7696005)(66556008)(478600001)(64756008)(55016003)(5660300002)(8936002)(41300700001)(52536014)(7416002)(71200400001)(8676002)(122000001)(186003)(38100700002)(38070700005)(2906002)(26005)(9686003)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjJ6TStyZWFtem00QXg5RFQ4MktOZjNoenprbXJVbFhCK2hlbzRTN2YrOEdm?=
 =?utf-8?B?eTVrRVBiYUZiT3hPRUJBbHc5VjNmTW9qVTNCUGtVRFVvQkk2YzI3dDZIOUl0?=
 =?utf-8?B?OW5VNDJpSlZjbS9hZ1RKaWFCdzZQUUZiVXhEelNGT3FiMTA4NkUrMFFZcEU4?=
 =?utf-8?B?Y2pnMHhjWHdncGxoRVlueTJyd2MxblhJazFwUlVhdm9GZDc0TDJRUnZOTFFS?=
 =?utf-8?B?Vi9yYmwxcXhwNEFaakVmTVFrclVDbGloYlp0c0RHMmRzOUxBZ1hNWHdMc0JL?=
 =?utf-8?B?dStQZ1piKytWQUo4ZHA0RitZSjByVmhpbVFXc0ZMdHFML0dhcVNvejA1NkI2?=
 =?utf-8?B?YUFkOVByQ2NnWXdZalBnOXQrOFpyUU1rS0MrNTBDekpId0xLc1BROVIzSGxE?=
 =?utf-8?B?emliTFIvUU41ckUrcVR1cy92d3F1eEVGTGNMQjFZQ0lWRHVmYlpxZ0lhVURy?=
 =?utf-8?B?R2lYajRrNjk2MHFGaTUzbTltRWlBeGNUVUt2VjVjOGxOc2piS3FZc0MvMFZ4?=
 =?utf-8?B?VHZ1RkZlMUtmU25Oa01sRWZVNVdoL1VrZzlETFpYRi9EWnIyOUFCUzZJVkJr?=
 =?utf-8?B?aHZ0OUFFdVFBekZaR1p6dmdVS0d3Mmd6QXlZTXJzUDZwRUMvaHdVVytFVk9o?=
 =?utf-8?B?U0s3c2pMYUFYU3czWEZNZEo0cnpzc0l6Wm1RTjFVdURVdEt0am1mcjg5N3dQ?=
 =?utf-8?B?SzRrdHI4VTdEUE9lNVFYR2pyNm90UWJHa1ZQamo1c1E0ZE9FT3lOaXdFWUxR?=
 =?utf-8?B?bEU3UlZGRzBCSDdMb0I0bTlaM0JoWVBmNm9QMTRtNmVDQU9LTDlXK3VDY2tL?=
 =?utf-8?B?QW1UdVI0aXQzazh4cXVaOXpLOE53dVgwbHY4WDVWMTRwUWd0M0hnTTRKOEVx?=
 =?utf-8?B?T0VSanJkZmF4ekNkbm8rNjR4YURSWm5uTVRZK2E4R2tpcERBWnpaZjdhckJS?=
 =?utf-8?B?SkVydHB4VUt5WDhoczIreU1nbElSblNEZ3FzNGcyM0N5L2wvQkVNVm91bHdi?=
 =?utf-8?B?RDNLN2dNVHBCWnRwWXNxbVQrLzV3R2JXZ0JFZjBXeEh2K0cvYlFrbmZ1YXVs?=
 =?utf-8?B?VG9QQmppTkxNRDBSa2VlSXYxTlFVUW5jL2phRFd4cTNuZkVzTnh0MVB5N3Y2?=
 =?utf-8?B?dmY1ZFovVjI0VWQ3dHNoem1IV3F6Z082MW9iN29sMStZQ1VBdTR5ZWJMMWNp?=
 =?utf-8?B?MW5ZcWNRMUJiMy9hNy9CYVlyRVJkd1k4a0lmaXNrby9FSmpFRGpPc1BWeDg3?=
 =?utf-8?B?R2ovaTlza2g2SmVvbEN2MmdwYkxrNjBCREY3WlVjVm0za1hEeGh5b1JpSGsv?=
 =?utf-8?B?MGZra1NlS3M0RURja2hvemN4TVNqYWtidWQ5ZWlzOW9qbVNFSGh0eFNZOUlk?=
 =?utf-8?B?bjEvdU1oVmcxVXcwdVgvdnZvYlpYa2o2VGpNT2s2Y2hmOVFGZ3NzNEFpbFZU?=
 =?utf-8?B?eUdwWEhIMDV4eGNOOVlwT1I5cG9KQ1VZbm85NE40cFRVbnhQKzByRDdFeEQz?=
 =?utf-8?B?REROTWQyVWlqZU5PbGpZOCs5ZjQwTHN6OU5PVG51cjlwRVlNUjI1eGZLTEIy?=
 =?utf-8?B?b1lFV25LZHBSVlY4S016MEhubXFIaVUvbTZkSWRlbWVpN2t0ZmlhY20wTzJ0?=
 =?utf-8?B?eitMdThqSWw1aXN3WGw0NlF1SmV3K2FiZ1lkSXVRVnFkK2JtVXVKdUQ4VkxH?=
 =?utf-8?B?MWVUaW9pWUxBL1hpSGVKSW1qTGJwRGZvTC9uVTRVZXFZcUsrZVhHUFI0NkFk?=
 =?utf-8?B?RVlDaGd0ZUJPbTFYbEtEalg3WFdVUk1UWW9pOWZpRGNvTllTWXVOQzhGcWpB?=
 =?utf-8?B?UEFFTXRtb0dHQlVlemxMeUpPaU8wRXp5UjhkbWJzN2FrNkVDWU5TdS9iYW1l?=
 =?utf-8?B?K1RPaStmRDd2cjluMHpkQ0JGaG9ialJ4K1pXenR1dUZDaHgyNEo2RVl5dFZu?=
 =?utf-8?B?UHdPblJiRi9LcVIwcDBQd3dTaTRFcmFBL3ZoUHZmRkJEcXJPUWhWZ1NXbEQ2?=
 =?utf-8?B?VDR3T3BKVmk1YzVWWnRtczRNTEd1SUEvWTRJMURvb0paemRKYXhzT1dXaXBO?=
 =?utf-8?B?S3dLN2pjb2kyajdFU0ZMYlA0VmJwZklsTDRnOUFtdFgwYjU1T2tkeExoUmhL?=
 =?utf-8?Q?4hTCQCMfBtwjlduMS4pi3/vmn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8651d5-3d2a-4832-9979-08db5142d2ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 10:39:24.7036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5yvD+dsqKqUkvzQLh9LZVEa6lLRdqh5EwTzlv7/S5N1Kbf87oiKdLzPqfLDZJxoPJIKQTx29FrE54O8UF/M66UBaU3M0FvGzw6204DO5is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6331
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiA+ID4gYW4NCj4gPiA+ID4gPiBpZGxlDQo+ID4gPiA+ID4gPiA+ID4gYnVzLg0KPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiBUZWNobmljYWxseSB3aGF0J3MgbmVlZGVkIGlzIGFuIGlkbGUg
Y29uZGl0aW9uIG9uIHRoZSBidXMgYXMgc3BlY2lmaWVkDQo+ID4gPiA+ID4gPiA+IGluIHRoZSBJ
U08uIGkuZS4gMTEgY29uc2VjdXRpdmUgc2FtcGxlZCByZWNlc3NpdmUgYml0cyBhZnRlciBhIGZ1
bGwNCj4gPiA+ID4gPiA+ID4gZnJhbWUgKGlmIG9uZSBpcyBjdXJyZW50bHkgaW4gdHJhbnNtaXNz
aW9uKS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBSaWdodC4gV2hhdCBoYXBwZW5zIGlmIGFu
b3RoZXIgQ0FOIGZyYW1lcyBjb21lcyBiZWZvcmUgdGhlcmUgYXJlDQo+IDExDQo+ID4gPiA+ID4g
PiBjb25zZWN1dGl2ZSBzYW1wbGVkIHJlY2Vzc2l2ZSBiaXRzPyBUaGUgSUZTIGZvciBDQU4gaXMg
MyBiaXRzPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gTm90IHF1aXRlLiBCZXR3ZWVuIHRoZSBGcmFt
ZXMgaXMgYW4gSUZTIHRoYXQncyBjb3JyZWN0IGJ1dCB0aGUgSUZTDQo+IGNvbnNpc3RzDQo+ID4g
PiBvZg0KPiA+ID4gPiA+IGFuIEludGVybWlzc2lvbiB3aGljaCBpcyAzIGJpdHMgbG9uZyArIGEg
YnVzIGlkbGUgY29uZGl0aW9uIG9mIDExIGJpdHMuDQo+IFJlZ3VsYXINCj4gPiA+ID4gPiBmcmFt
ZXMgaGF2ZSB0byB3YWl0IGZvciB0aGUgSUZTIHRvIGVsYXBzZSBCVVQgdGhlcmUncyBhbiBleGNl
cHRpb24gZm9yDQo+IGVycm9yDQo+ID4gPiA+ID4gZnJhbWVzIGFuZCBvdmVybG9hZCBmcmFtZXMu
IEVGIG1heSBiZSB1cCB0byAxMiBiaXQsIE9GIGFyZSA4IGRvbWluYW50DQo+ICsgOA0KPiA+ID4g
PiA+IHJlY2Vzc2l2ZSBiaXRzLCBicm93c2luZyB0aHJvdWdoIHRoZSBzcGVjIEkgdGhpbmsgb25s
eSAyIE9GcyBjYW4gaGFwcGVuDQo+ID4gPiA+ID4gY29uc2VjdXRpdmVseS4gQWRkaW5nIGFub3Ro
ZXIgMzIgYml0cyB0byB0aGUgZm9ybXVsYSBzaG91bGQgY292ZXIgdGhpcy4NCj4gPiA+ID4NCj4g
PiA+ID4gUmUtcmVhZGluZyB0aGUgc3BlYyBhZ2FpbiBJIG5vdGljZWQgdGhhdCB0aGUgcGFydCB3
aGVyZSBJIHdyb3RlDQo+ID4gPiA+IHRoYXQgdGhlcmUncyBhbiAiaWRsZSBjb25kaXRpb24iIGFm
dGVyIHRoZSBpbnRlcm1pc3Npb24gaXMNCj4gPiA+ID4gd3JvbmcuIFdoYXQgZm9sbG93cyB0aGUg
aW50ZXJtaXNzaW9uIGlzIGp1c3QgImJ1cyBpZGxlIiwNCj4gPiA+ID4gZGVmaW5lZCB0d28gcGFy
YWdyYXBocyBsYXRlciBhcyAiVGhlIHBlcmlvZCBvZiBidXMgaWRsZSBtYXkgYmUNCj4gPiA+ID4g
b2YgYXJiaXRyYXJ5IGxlbmd0aC4iIFRoZSAxMSByZWNlc3NpdmUgYml0cyBjYW4gYmUgcmVtb3Zl
ZCBmcm9tDQo+ID4gPiA+IHRoZSBmb3JtdWxhIGFnYWluLiBUaGUgbG9uZ2VzdCBwZXJpb2QgKHVu
ZGVyIHRoZSBhc3N1bXB0aW9uDQo+ID4gPiA+IHRoZXJlIGFyZW4ndCBtdWx0aXBsZS9jb250aW51
b3VzIGVycm9ycyBvbiB0aGUgYnVzKSB3aWxsIGJlDQo+ID4gPiA+IEZyYW1lICsgRXJyb3IgRnJh
bWUgKDEyIGJpdCkgKyAyIHggT3ZlcmxvYWQgRnJhbWUuDQo+ID4gPiAgICAgICAgICAgXl5eXl5e
Xl5eXl5eXl5eXl5eXl4NCj4gPiA+DQo+ID4gPiBIb3cgZGlkIHlvdSBmaW5kIHRoYXQgYSBlcnJv
ciBmcmFtZSBpcyAxMiBiaXRzPyBGcm9tIHNlY3Rpb24gMTAuNC40DQo+ID4gPiAiU3BlY2lmaWNh
dGlvbiBvZiBFRiIsIEkgY2FuIHJlYWQ6DQo+ID4gPg0KPiA+ID4gICBUaGUgRUYgc2hhbGwgY29u
c2lzdCBvZiB0d28gZGlmZmVyZW50IGZpZWxkcy4gVGhlIGZpcnN0IGZpZWxkDQo+ID4gPiAgIHNo
YWxsIGJlIGdpdmVuIGJ5IHRoZSBzdXBlcnBvc2l0aW9uIG9mIGVycm9yIGZsYWdzIGNvbnRyaWJ1
dGVkDQo+ID4gPiAgIGZyb20gZGlmZmVyZW50IG5vZGVzLiBUaGUgc2Vjb25kIGZpZWxkIHNoYWxs
IGJlIHRoZSBlcnJvcg0KPiA+ID4gICBkZWxpbWl0ZXIuDQo+ID4gPg0KPiA+ID4gVGhlbjoNCj4g
PiA+DQo+ID4gPiAgIFR3byBmb3JtcyBvZiBlcnJvciBmbGFnIG1heSBiZSB1c2VkLCB0aGUgYWN0
aXZlIGVycm9yIGZsYWcgYW5kDQo+ID4gPiAgIHRoZSBwYXNzaXZlIGVycm9yIGZsYWcsIHdoZXJl
DQo+ID4gPg0KPiA+ID4gICAgLSB0aGUgYWN0aXZlIGVycm9yIGZsYWcgc2hhbGwgY29uc2lzdCBv
ZiA2IGNvbnNlY3V0aXZlDQo+ID4gPiAgICAgIGRvbWluYW50IGJpdHMsIGFuZA0KPiA+ID4NCj4g
PiA+ICAgIC0gdGhlIHBhc3NpdmUgZXJyb3IgZmxhZyBzaGFsbCBjb25zaXN0IG9mIDYgY29uc2Vj
dXRpdmUNCj4gPiA+ICAgICAgcmVjZXNzaXZlIGJpdHMgdW5sZXNzIGl0IGlzIG92ZXJ3cml0dGVu
IGJ5IGRvbWluYW50IGJpdHMNCj4gPiA+ICAgICAgZnJvbSBvdGhlciBub2Rlcy4NCj4gPiA+DQo+
ID4gPiBGaW5hbGx5Og0KPiA+ID4NCj4gPiA+ICAgVGhlIGVycm9yIGRlbGltaXRlciBzaGFsbCBj
b25zaXN0IG9mIDggcmVjZXNzaXZlIGJpdHMuDQo+ID4gPg0KPiA+ID4gU28gdGhlIGVycm9yIGZy
YW1lIHNob3VsZCBiZSAxNCBiaXRzICg2ICsgOCksIG5vdCAxMiwgcmlnaHQ/DQo+ID4gVGhhdCB3
YXMgaW1wcmVjaXNlLCB5b3UncmUgcmlnaHQgLSBJIG1lYW50IGFuIEVycm9yIEZsYWcsIG5vdCBG
cmFtZSBhbmQgaGVuY2UNCj4gdGhlIDggcmVjZXNzaXZlIGJpdHMgd2VyZSBtaXNzaW5nLiBUaGVy
ZSdzIGFuIGFjdGl2ZSBlcnJvciBmbGFnICsgcGFzc2l2ZSBlcnJvcg0KPiBmbGFnIHRob3VnaCB3
aGljaCBjYW4gYmUgNiBiaXRzIGxvbmcgZWFjaC4gSW4gc2VjdGlvbiAxMC40LjQuMiBUaGUgdG90
YWwgbGVuZ3RoDQo+IG9mIHRoaXMgc2VxdWVuY2UgbWF5IHZhcnkgYmV0d2VlbiBhIG1pbmltdW0g
b2YgNiBiaXQgYW5kIGEgbWF4aW11bSBvZiAxMg0KPiBiaXQuDQo+IA0KPiBUaGUgYWN0aXZlIGVy
cm9yIGZsYWcgYW5kIHRoZSBwYXNzaXZlIGVycm9yIGZsYWcgbWF5IGJvdGggb2NjdXIsIGJ1dA0K
PiBpbiB0aGF0IGNhc2UsIHRoZXkgb2NjdXIgYXMgYSBzdXBlcnBvc2l0aW9uIChjLmYuIGFib3Zl
IHF1b3RhdGlvbikuDQo+IFRoaXMgYWxzbyBtZWFucyB0aGF0IHRoZSBwYXNzaXZlIGVycm9yIGZs
YWcgaXMgc2VlbiBpZiBhbmQgb25seSBpZiBhbGwNCj4gdGhlIG5vZGVzIHNlbmQgYSBwYXNzaXZl
IGVycm9yIGZsYWcuIEFzIGxvbmcgYXMgb25lIG5vZGUgc2VuZHMgYW4NCj4gYWN0aXZlIGVycm9y
IGZsYWcsIHRoZSBzdXBlcnBvc2l0aW9uIHdpbGwgaGlkZSBhbnkgb3RoZXIgcGFzc2l2ZSBlcnJv
cg0KPiBmbGFnLg0KPiANCj4gU28sIEkgdGhpbmsgdGhhdCB0aGUgZXJyb3IgZmxhZyBpcyBhbHdh
eXMgNi4NCg0KSSB0aGluayBpZiBvbmUgbm9kZSBkZXRlY3RzIGEgYml0IGVycm9yICh0aGF0J3Mg
bm90IG9uIHRoZSBidXMgYnV0IGluc2lkZSB0aGUgcmVjZWl2aW5nIG5vZGUpIG9uIHRoZSBzZWNv
bmQgYml0IG9mIHRoZSBpbnRlcm1pc3Npb24gaXQgd2lsbCBzdGFydCBzZW5kaW5nIHRoZSA2IGRv
bWluYW50IGJpdHMsIHN0YXJ0aW5nIG9uIHRoZSB0aGlyZCBiaXQgb2YgdGhlIGludGVybWlzc2lv
bi4gTm93LCBhY2NvcmRpbmcgdG8gMTAuNC4yLjIgIiBBIG5vZGUgc2FtcGxpbmcgYSBkb21pbmFu
dCBiaXQgZHVyaW5nIGl0cyBzdXNwZW5kIHRyYW5zbWlzc2lvbiB0aW1lIG9yIGF0IHRoZSB0aGly
ZCBiaXQgb2YgaW50ZXJtaXNzaW9uIHNoYWxsIGFjY2VwdCBpdCBhcyBTT0YuIiwgdHJlYXRpbmcg
dGhlIG5leHQgNSBkb21pbmFudCBiaXRzIGFzIHBhcnQgb2YgdGhlIElEIG9mIGEgbmV3IERGIGFu
ZCBvbmx5IHRoZW4gc2VuZGluZyBpdHMgb3duIGVycm9yIGZsYWcsIGdpdmluZyBhIHRvdGFsIG9m
IDEyIGRvbWluYW50IGJpdHMgZm9sbG93ZWQgYnkgOCByZWNlc3NpdmUgYml0cyBFRiBkZWxpbWl0
ZXIgZXRjLiBBbSBJIG1pc3Npbmcgc29tZXRoaW5nIGhlcmU/IEZvciB0aGlzIChJIGJlbGlldmUg
d29yc3QgY2FzZSB3aGVuIG9ubHkgY29uc2lkZXJpbmcgMSBFRiB5b3UgY291bGQgZGVkdWN0IG9u
ZSBiaXR0aW1lIC0gdGhlIHRoaXJkIGJpdCBpbiB0aGUgaW50ZXJtaXNzaW9uKQ0KDQo+ID4gPiBG
b3IgdGhlIGdyZWF0IHRvdGFsLCBpZiB5b3Ugd2FudCB0aGUgYWJzb2x1dGUgd29yc3QgY2FzZSwg
eW91IHNob3VsZA0KPiA+ID4gY29uc2lkZXIgdGhhdDoNCj4gPiA+DQo+ID4gPiAgIC0gVGhlIGVy
cm9yIGZyYW1lIG1heSBzdGFydCBhdCBhbnkgcG9pbnQuIEZvciBleGFtcGxlLCB5b3UgbWF5DQo+
ID4gPiAgICAgb2JzZXJ2ZSB0aGUgZmlyc3QgdHdvIGJpdHMgb2YgdGhlIGludGVybWlzc2lvbiBh
bmQgaGF2ZSBpdA0KPiA+ID4gICAgIGJyb2tlbiBieSBhbiBlcnJvciBmcmFtZS4gSXQgbWF5IGFs
c28gYXBwZWFyIGluIHRoZSBtaWRkbGUgb2YNCj4gPiA+ICAgICBhIGRhdGEgZnJhbWUuIFNvIHlv
dSBtYXkgY29uc2lkZXIgY2FzZXMgc3VjaCBhczogcGFydGlhbA0KPiA+ID4gICAgIGZyYW1lICsg
ZXJyb3IgZnJhbWUgKyBpbnRlcm1pc3Npb24gKyBmcmFtZSArIC4uLg0KPiA+ID4NCj4gPiA+ICAg
LSBUaGUgb3ZlcmxvYWQgZnJhbWUgaXMgcmVxdWlyZWQgdG8gImRlc3Ryb3kgdGhlIGZpeGVkIGZv
cm0gb2YNCj4gPiA+ICAgICB0aGUgaW50ZXJtaXNzaW9uIGZpZWxkIi4gU28gZXZlbiBpZiBub3Qg
ZXhwbGljaXRseSBzcGVjaWZpZWQsDQo+ID4gPiAgICAgSSB0aGluayB0aGF0IG92ZXJsb2FkIGZy
YW1lIG1heSBzdGFydCBhZnRlciB0aGUgc2Vjb25kDQo+ID4gPiAgICAgcmVjZXNzaXZlIGJpdHMg
b2YgdGhlIGludGVybWlzc2lvbiwgZS5nLiBmcmFtZSArIDIgYml0cyBvZg0KPiA+ID4gICAgIGlu
dGVybWlzc2lvbiArIG92ZXJsb2FkIGZyYW1lICsgMiBiaXRzIG9mIGludGVybWlzc2lvbiArDQo+
ID4gPiAgICAgb3ZlcmxvYWQgZnJhbWUgKyBmdWxsIDMgYml0cyBpbnRlcm1pc3Npb24NCj4gPiA+
DQo+ID4gPiAgIC0gQW4gZXJyb3IgZnJhbWUgb3IgYW4gb3ZlcmxvYWQgZnJhbWUgbWF5IHRyaWdn
ZXIgYW5vdGhlciBlcnJvcg0KPiA+ID4gICAgIGZyYW1lIGlmIGEgbm9kZSBkb2VzIG5vdCBjb3Jy
ZWN0bHkgcmVjZWl2ZSBvbmUgb2YgdGhlIGJpdHMgaW4NCj4gPiA+ICAgICB0aGUgZml4ZWQgZm9y
bSBkZWxpbWl0ZXIuIFRoZSBvbmx5IGV4Y2VwdGlvbiBpcyB0aGUgbGFzdCBiaXQNCj4gPiA+ICAg
ICBvZiB0aGF0IGRlbGltaXRlciAoYy5mLiBzZWN0aW9uIDEwLjExICJFcnJvciBkZXRlY3Rpb24i
DQo+ID4gPiAgICAgcGFyYWdyYXBoIGQpICJGb3JtIGVycm9yIikuIEluIG90aGVyIHdvcmRzLCB5
b3UgY2FuIGhhdmUNCj4gPiA+ICAgICB0aGUgdHdvIG92ZXJsb2FkIGZyYW1lcywgdGhlbiBhbiBl
cnJvciBmcmFtZSwgdGhlbiB0d28NCj4gPiA+ICAgICBvdmVybG9hZCBmcmFtZXMgYWdhaW4uDQo+
IA0KPiBDb3JyZWN0aW5nIG15c2VsZjogdGhhdCBsYXN0IGV4YW1wbGUgd2FzIGludmFsaWQuIFRo
ZXJlIGFyZSBhdCBtYXhpbXVtDQo+IHR3byBvdmVybG9hZCBmcmFtZXMgYmVmb3JlIHRoZSBuZXh0
IGRhdGEgb3IgcmVtb3RlIGZyYW1lLiBTbyB0aGUNCj4gcHJlc2VuY2Ugb2YgYW4gZXJyb3IgZnJh
bWUgc2hvdWxkIG5vdCByZXNldCB0aGUgb3ZlcmxvYWQgZnJhbWUgY291bnQuDQo+IA0KPiA+ID4g
VGhpcyBpcyB0byBzYXkgdGhhdCB0aGUgd29yc3QgY2FzZSBzY2VuYXJpbyBpcyBqdXN0IG5vdCBz
b21ldGhpbmcNCj4gPiA+IHdvcnRoIGNvbnNpZGVyYXRpb24uDQo+ID4NCj4gPiBBQ0sNCj4gPiA+
IFRoZSBhc3N1bXB0aW9uIHRoYXQgb25seSBvbmUgZXJyb3IgZnJhbWUgb2NjdXJzIGlzIHByZXR0
eSBhcmJpdHJhcnkuIEkNCj4gPiA+IHdvdWxkIHN1Z2dlc3QgbWFraW5nIGl0IHNpbXBsZXIgYW5k
IHNpbXBseSBpZ25vcmUgZXJyb3IgYW5kIG92ZXJsb2FkDQo+ID4gPiBmcmFtZXMuIEFzIGxvbmcg
YXMgZnJhbWUgKyBpbnRlcm1pc3Npb24gd29ya3Mgd2VsbCBpbiBlbXBpcmljYWwgdGVzdHMsDQo+
ID4gPiBJIHdvdWxkIHN1Z2dlc3QgdG8gc3RheSB3aXRoIHRoYXQgYW5kIGNhbGwgaXQgYSBkYXku
DQo+ID4NCj4gPiBDb3JyZWN0LCB0aGF0J3Mgd2h5IEkgd3JvdGU6ICh1bmRlciB0aGUgYXNzdW1w
dGlvbiB0aGVyZSBhcmVuJ3QNCj4gbXVsdGlwbGUvY29udGludW91cyBlcnJvcnMgb24gdGhlIGJ1
cykgYnV0IEkgYWdyZWUgdGhhdCdzIGEgcHJldHR5IGFyYml0cmFyeQ0KPiBsaW1pdC4gU28gSSdt
IGZpbmUgd2l0aCBjaGFuZ2luZyBpdCB0byBvbmUgb3IgdHdvIGZ1bGwtc2l6ZWQgZnJhbWVzICsN
Cj4gaW50ZXJtaXNzaW9uKQ0KPiANCj4gQUNLLiBBdCB0aGUgZW5kLCB5b3UgaGF2ZSB0aGUgaGFy
ZHdhcmUsIHNvIHlvdSBzaG91bGQgZGVjaWRlIHdoYXQgaXMNCj4gdGhlIGJlc3QgZGVsYXkgdG8g
Zml4IHRoZSBpc3N1ZS4gSSBqdXN0IGhvcGUgdGhhdCBteSBtZXNzYWdlIHdhcw0KPiBoZWxwZnVs
IHRvIHNpbXBsaWZ5IHRoZSBmb3JtdWxhLg0KDQpJIGFncmVlIGEgc2ltcGxlIGZvcm11bGEgd2ls
bCBiZSB0aGUgYmVzdCB3YXkgZm9yd2FyZCBhcyB0aGUgcmVzdCBpcyBhY2FkZW1pYyBvbmx5IGFu
eXdheS4NCg0KQmVzdCBSZWdhcmRzLA0KVGhvbWFzDQo=
