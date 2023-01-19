Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7E067397D
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 14:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjASNIw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 08:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjASNIH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 08:08:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611045EFB7
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 05:08:05 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pIUeB-0003iU-N6
        for linux-can@vger.kernel.org; Thu, 19 Jan 2023 14:08:03 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7961:17f5:9ae5:1a41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3AA3515D398
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 13:08:03 +0000 (UTC)
Received: from bjornoya.blackshift.org
        by bjornoya with LMTP
        id UArBIAtAyWNq7A0As6a69A
        (envelope-from <Thomas.Kopp@microchip.com>)
        for <mkl-all@blackshift.org>; Thu, 19 Jan 2023 13:05:15 +0000
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6B75115D392
        for <mkl-all@blackshift.org>; Thu, 19 Jan 2023 13:05:15 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2420F15D391
        for <ptx@kleine-budde.de>; Thu, 19 Jan 2023 13:05:14 +0000 (UTC)
Received: from esa.microchip.iphmx.com ([68.232.153.233])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <Thomas.Kopp@microchip.com>)
        id 1pIUbL-0003Bv-Ph
        for mkl@pengutronix.de; Thu, 19 Jan 2023 14:05:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674133507; x=1705669507;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=T+I5I8AgsrFKg601WVjf2eonvHXHDtrPOdjLvNw93CA=;
  b=0goo0lu2zQ9RAr3ExusoSmnNlL84ML37WDBOCRtaaBKcMm2bFkE94ml0
   6akG/U+JOXcqzq2bCO8PAGGYoDRYRyuYMi4Axk3Mrb30nticruI3dfVz0
   +P3rBlJfd8KFT/33ffJrH7zi1/H2/X0hSIn2wuK5wNJUMxL/GdDfRHVSs
   aQBTCGNq7KCGtHFGOn6jw2LPk4AWM4kqxRCyv06M6RCTxiQldzvibgU39
   IMZX5KYsKlU1ZyOAnZsgxYDDet1MQmnjJnkWRXWSDcaFPIxWVffvdY8dM
   mXQ2sYtoa2ysnnausu3Mtb2wgrZOGucfWX+kjF8U0iYmFG16Bj7AxHqiS
   A==;
X-IronPort-AV: E=Sophos;i="5.97,229,1669100400"; 
   d="scan'208";a="208465222"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jan 2023 06:05:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 06:05:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 06:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoVl432/ASHAo5WiLikUEj9XaUR1tvfCgfE1sYPf0JmejaUoGLX5pEVruCDc+LWLrfBHFUzik89TGALeE4BCekgvDjlu87Kpr0KEQLEiSmJ6Pdi3Qlw47fvmhnQpwaLAlBLdqQcw0qWeHZABJK53y8stIlv7S0AfN9dr0ldlXniaokN14NR856YpugeUR85wYIpozy1B10/YeA6s4eH678y+8iQm3vk5VyvebBNQULvC8SrIZuKO/Trzdz8wcg/YNcwJVioWj9LCEkbtcpSZxrkxJa/6A0C8wEeL8huVQVhK5ebyHGIoyxv4YbXeyuQ/DwBdutj4IBDCBNKYd4qd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+I5I8AgsrFKg601WVjf2eonvHXHDtrPOdjLvNw93CA=;
 b=i/IJ3AftbwRNqJ2CdoZrrK7Zdosk92yXOMzUWSK2PHUCQmLSSuZPNl8IaJ4PdhthvM7y/BW8rPbzTLfbSqBzLYNDgypBHO6kKM6YybtPQoUX+2DeLRQfaAh8VGkDYmmcYX7s5nt7Lz3fOdB9w8zJxZzQ9h3xpQlrDgQhbC2srgfwcuN9D+L3VHg6lFk9Lu6DGAJldTD8CnK6rUBSY/+aSW0wppWZmQ+5K9PX9+RxxbGZjBrsvVxYoq/hNJPCRGpK278TQUkFIMZjcKWU1d/eUJoZmZpzC16al5vRSotuxaPsvF6R2L6StIrniZ7wbjCDC73SjRe7RZp790BK2cmnyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+I5I8AgsrFKg601WVjf2eonvHXHDtrPOdjLvNw93CA=;
 b=KFZuGB/1/d0xWS42srzoNv1nbpeyX2F4W+ge4ic0e9fOZfSeI65UccMpiJs1Z6Ovb2vLmfiyYCkRkxzfdxXSTwT2xFbCnkSueB1QwooQhV73O4aEn/pFVb6sd8dTE0Nboyth6qkhJQ/I4U3JwgdFAyR/Fytl49JycFhxCUm8374=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by CY8PR11MB7797.namprd11.prod.outlook.com (2603:10b6:930:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 13:05:03 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096%3]) with mapi id 15.20.6002.026; Thu, 19 Jan 2023
 13:05:02 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <Stefan.Althoefer@janztec.com>, <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Thread-Topic: mcp251xfd: rx frame truncation (1/2)
Thread-Index: AQHZKz4szMq49nyLkUucW5HyhGITIq6kOILggAAd4YCAAPuhYIAARQeAgAAbIACAAACgIA==
Date:   Thu, 19 Jan 2023 13:05:02 +0000
Message-ID: <BL3PR11MB648434F2B7DE7F75E291E159FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966F32AD422DDD867F8C53A97C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB6484911640CCC738ED799E6FFBC79@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19663A60B0F7CE7F684A7A6297C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64842584529FAEF279F7B137FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19669083201C1B9C2DFB9E5497C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB196633E4F8E1195086E2402B97C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR0P281MB196633E4F8E1195086E2402B97C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|CY8PR11MB7797:EE_
x-ms-office365-filtering-correlation-id: 8f354815-786f-40af-47aa-08dafa1dc70d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uzm8km49pHpAcFo4yoq5YKBEQjW6UZAO3cqISacaWd0IUsyfr7SyaJyhkQWdcvfe4/YDMyxhPna6iDaLOCKDEoVO7mVHNJQRzFK+d8NvzpxmtYKnH1oKCFYMWlPww5AtCR07Ei5jH0JMl7TMoWdnxLjz+/h07mLyDa4zNujEunYKfkONefXnuBs8jWYEz2lw+cJ98NDR1b5/FjkLTRSB90uHD//fdQkgWzp2P5mXDfULcfA9x71ki4Q/hwjNTjsADCdpzvcZtgdWJaJ8FslQvoihaSIH90HlTg/0ak6XFuUAz4yaqjWrwm+KQcdNx0H5ZNNu9YuI0zkJGB4chdlTlH5bQItUN9g6dzOk6evTQuSBgZ1kwKVY3vnx8ufrczSstDg3t03DZMQDcyreY+b92I+LLzHdAhNOyyGA6oknEqczvFqTKrZqVPyBv29loZEgpumg0Wn8Gdc/77Do4Myi4eYqu9y+qaOOwXnytdzdNrHyvWvGkEmJrBFu8NTLp3Z2ldmvtRBm6kfNOUtJVjIJdrVv0uJfbCmNO5PGxSrUCG0TEZ9ovWon9FxkJucBJMDQ/5rwO32wJovSmuJiXxMeBCQ2fhxBEVSlrGQiFQeWxAzJRA1Z+f0YqJDI+SUegt0n2O+5dNCnzakPo8WVdV/6vmumzVcJ8znN2its/V/DguYCsVpFD6dOdJA6cLvccbOILJw+72px1mU3ZEqbOOtFzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199015)(55016003)(33656002)(41300700001)(66446008)(76116006)(64756008)(66556008)(66476007)(66946007)(8676002)(83380400001)(5660300002)(8936002)(52536014)(478600001)(9686003)(186003)(26005)(6506007)(110136005)(7696005)(316002)(71200400001)(86362001)(38070700005)(2906002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c204TW5Gd3dPSEVqYnFFMHR4L25CckZOaXVxdVpGMm80WVVEbkRlemp6NWVh?=
 =?utf-8?B?aktXMnJ6UGRLb1RuMkwyV2NBMlFoVUJqQW14TUM4cktwTkpnV3JCTEZaZTIw?=
 =?utf-8?B?SlE3U3RnUzdEb0RUZVIwV3k5TzYzSnFWNTZnUmZjT3BKRVFoSGZsWkhoU2NC?=
 =?utf-8?B?UWVnTW1HdlorL3NQUlRmY3dQbXNHRktjYUVYZVgrWi9XTmVqTzRrandyd0xR?=
 =?utf-8?B?cW5Kc0pJaUtlVGxSa1hJVnIvc1cwckVOUGlRS0k5bDEyUW44OFk4TUx4UEpo?=
 =?utf-8?B?UlNTb0pPdU5jMlJEYkt4QytVTmFGZ0NEU2xxd2E2S25tekx1V3hVL2loYkhU?=
 =?utf-8?B?Ny80cEVMK2s5V3ZMUnVvOFVGNGZVSngyMEo2RzVHSjJKMVBoMFJZaG5BeFU5?=
 =?utf-8?B?WEtiOE1VL0FKZ1pJNkpudEF2Y0YxWUtjc3VRQlBmc1pkTGFkc0ZoVEowTVJJ?=
 =?utf-8?B?MGZGL3pJcVhtdHFSOUNuSlZRb3RoTDA2V2dVUm1KN3AzWmxUY3pGOW1GTXJK?=
 =?utf-8?B?WmFOWUh2UjB3T0hVbU81dDExTkUyNXZ5SWpZV0xycDdBTmVKVU5NL0pNRG9l?=
 =?utf-8?B?djFHNVI4WmdabE5MZmkxRURmR1IrbWh4SitCVWFyMWs5WEkvVXZqMERabjlW?=
 =?utf-8?B?MmszTWNqWmowVE0xektmMDE2R3F3bTl0QW9xcit5S21ZMUoyamZ1UXdPRUhl?=
 =?utf-8?B?VlNYcVNSWllnd2Zzb1dvOS85dlg1TjlxaExKeFFac2hRcWk1YU1nVWdCM0dR?=
 =?utf-8?B?Z3crZStFSjA5ekNWMDJsZEc0Nk9sQ29oTmJad3RTTmR3RWJadWNqVkZETzIz?=
 =?utf-8?B?L080aDE4aG81L3pnTysybjBiZTNSTy9OVEhBbnYwMmxOQVNhZnVqZkF4YndI?=
 =?utf-8?B?RFAzS0FqVEVyeFZkZEE1M0thWjdVZW5nSDZHWjZWK1hORStoVmFGa3pxMUpq?=
 =?utf-8?B?cTNPV0xEeUYzTS9lL0M0cmI3TCszOFpOTk1EdENMbGpNRFVYYlVWOWRQVHZv?=
 =?utf-8?B?RjkrM1dwZndzVGpNODdsdW5pZCtyVUNkdHdTbXp2OTRWSWJkc05rZ2p2NlRv?=
 =?utf-8?B?OXAzTE91U1FSVzhoUXFHeWJwSGh5OXF0dnY3bmZxVEgzYmdVLzZCbzE4eVc2?=
 =?utf-8?B?TXNkMDcrRVBhYzViRXZLT1F0SXVTNFg4WUhaVEFIOUlXMk5LUFhqMXlyZHBT?=
 =?utf-8?B?RkdCVVVONjFrOUtPN2pEbDJ2dWpNdVRSZld1R0QvR3hvSmpuVExXUGY1UVN5?=
 =?utf-8?B?ZjJIbkUzYVVjdlhkZ2hVNGJsanlQdFB3QThYYjBwa3VTbDZYL2ZLZE50TU0w?=
 =?utf-8?B?SlE4M2lsZWs2cnA1cFA1ZWoxMjQrYlZKZDJzOEF5OGlyYW9XMFl5Y1RsYlRH?=
 =?utf-8?B?amx0dmFrNkpsRWRkMFJLdWRDRThhMm82K28yTXU2Z3BhekdjWFVsYmZHTW80?=
 =?utf-8?B?UGMyb2dWT1VBZG83THBQcllHMjJNcUMyN0lTSEM0QjErSFRlb0lxMldsWTFZ?=
 =?utf-8?B?ckk0UVhnSWRYVmpUaDZ6OTRaejdiak1oWFV5Y0pFdWU0K1RWNFVKZW1pVU9V?=
 =?utf-8?B?SWU4YjJ0YmoxOW13bFlEdnZIYlYyTzVYdndaelpLejVsTER5cjJTTWgxNjVm?=
 =?utf-8?B?QytJZmZvTm9uRU9Oakc4UStZbUJCOTJibnhFK09GWm1zR3RqcXF2UXVOdXVH?=
 =?utf-8?B?cTY5ekF3RVc3TmFucVRqNzZnTUgxV2xwK3FyNkVlRStIZzRoc2NWeG9aNllx?=
 =?utf-8?B?UlZ4Zno0dG5JWmlUZjgyQWZ5YlBGbnJrSm9teXBIeWVDQ0lJV3hPN3BmU1Jk?=
 =?utf-8?B?aEo5MjczR1NjdkJ1TGwrQ01TbVdMTVcvSUxTOUVKU3ZueWdJMHhaZkx2QWJm?=
 =?utf-8?B?eFo5TjByeHg0aVVjcUpFYmJnSmdLZFJQV3h6c0pZUEpJOWI5TlgwaHBBQklV?=
 =?utf-8?B?RnE0aGczRTM0MERCMkVYaDJYYVIxSHRIUnNBYUlIaXU1SUY0b3FHck5EdVNO?=
 =?utf-8?B?S09Fcm5ORXd2dStNSXlhSE42ajVwU2hFbkloS3FXVGFHYnJmNnpWZmlZYkFN?=
 =?utf-8?B?TklTcnlNd3EwSmJQck96cmZteUFVWlRFMWgzM0YzYXVOTmlHUHY3NFBoR2Nq?=
 =?utf-8?Q?IAr7OARFMNBkGw0hrM0B+H2dy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f354815-786f-40af-47aa-08dafa1dc70d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 13:05:02.6565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmKa3CHsGYNfQiMP/jvQVWnnsVD3NdTaPp3gBK5jttiX5FLKM0ZL3CrgTVslI1wc6oZbPzAIBb/sgpzAsms4L5yH73GZXLcw/4Isef2tLUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7797
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: RE: mcp251xfd: rx frame truncation (1/2)
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: ptx@kleine-budde.de
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQoNCj5VcGRhdGU6DQo+SSBtb3ZlZCBteSBjbGljayBib2FyZHMgdG8gdGhlIHN0YW5kYXJkIFJQ
SSBhbmQgYXR0YWNoZWQgdGhlIGxvZ2ljIGFuYWx5emVyLiBUaGUgc2FtZSBzcGkwL3NwaTYgMTYv
MTAgTUh6IHNldHVwLg0KPkhvd2V2ZXIgdGhlIHRydW5jYXRpb24gZXJyb3IgaGFzIG5vdCBhcHBl
YXJlZCB3aXRoaW4gMTZoLiBOZXZlcnRoZWxlc3MgSSBzZWUgbG90cyBvZiBUcmFuc21pdCBFdmVu
dA0KPmlzc3VlczoNCiBNaG0g4pi5IFRoYXQgY291bGQgZXhwbGFpbiB3aHkgSSBjYW4ndCBjYXRj
aCBhbnl0aGluZy4gSSdtIHVzaW5nIHRoZSBQaTQgd2l0aCB0aGUgb3JpZ2luYWwgU2VlZWQgU3R1
ZGlvIEhBVChzb2xkZXJlZCB0aGUgMThGRCBvbnRvIGl0IGluc3RlYWQgb2YgdGhlIDE3RkQpIG9u
IFNQSTAgYW5kIFNQSTYgYW5kIG1hdGNoZWQgeW91ciBTUEkgZnJlcXVlbmNpZXMuDQoNCkphbiAx
OSAwNDoxNzo1MiByYXNwYmVycnlwaSBrZXJuZWw6IFs0MzE1NS4yODA5NjddIG1jcDI1MXhmZCBz
cGk2LjAgY2FuMTogVHJhbnNtaXQgRXZlbnQgRklGTyBidWZmZXIgbm90IGVtcHR5LiAoc2VxPTB4
MDAwMDE4YWEsIHRlZl90YWlsPTB4MDAwMDE4YWUsIHRlZl9oZWFkPTB4MDAwMDE4YWYsIHR4X2hl
YWQ9MHgwMDAwMThhZikuIA0KSmFuIDE5IDA0OjE4OjM4IHJhc3BiZXJyeXBpIGtlcm5lbDogWzQz
MjAwLjg1OTA0MF0gbWNwMjUxeGZkIHNwaTYuMCBjYW4xOiBUcmFuc21pdCBFdmVudCBGSUZPIGJ1
ZmZlciBmdWxsLiAoc2VxPTB4MDAwMDBkNDIsIHRlZl90YWlsPTB4MDAwMDBkNDYsIHRlZl9oZWFk
PTB4MDAwMDBkNDcsIHR4X2hlYWQ9MHgwMDAwMGQ0NykuDQpKYW4gMTkgMDQ6NDg6MDQgcmFzcGJl
cnJ5cGkga2VybmVsOiBbNDQ5NjcuNTE4MDI4XSBtY3AyNTF4ZmQgc3BpMC4wIGNhbjA6IFRyYW5z
bWl0IEV2ZW50IEZJRk8gYnVmZmVyIG5vdCBlbXB0eS4gKHNlcT0weDAwMDAwMGFlLCB0ZWZfdGFp
bD0weDAwMDAwMGIyLCB0ZWZfaGVhZD0weDAwMDAwMGIzLCB0eF9oZWFkPTB4MDAwMDAwYjMpLg0K
SmFuIDE5IDA0OjQ5OjAzIHJhc3BiZXJyeXBpIGtlcm5lbDogWzQ1MDI2LjExNDkwM10gbWNwMjUx
eGZkIHNwaTAuMCBjYW4wOiBUcmFuc21pdCBFdmVudCBGSUZPIGJ1ZmZlciBub3QgZW1wdHkuIChz
ZXE9MHgwMDAwMTViMCwgdGVmX3RhaWw9MHgwMDAwMTViNCwgdGVmX2hlYWQ9MHgwMDAwMTViNSwg
dHhfaGVhZD0weDAwMDAxNWI1KS4NCkphbiAxOSAwNDo1MToyMiByYXNwYmVycnlwaSBrZXJuZWw6
IFs0NTE2NS4wMTIyMDZdIG1jcDI1MXhmZCBzcGk2LjAgY2FuMTogVHJhbnNtaXQgRXZlbnQgRklG
TyBidWZmZXIgbm90IGVtcHR5LiAoc2VxPTB4MDAwMDBlMTIsIHRlZl90YWlsPTB4MDAwMDBlMTYs
IHRlZl9oZWFkPTB4MDAwMDBlMTcsIHR4X2hlYWQ9MHgwMDAwMGUxOCkuDQpKYW4gMTkgMDU6MTM6
MzMgcmFzcGJlcnJ5cGkga2VybmVsOiBbNDY0OTYuMjIyMzIxXSBtY3AyNTF4ZmQgc3BpMC4wIGNh
bjA6IFRyYW5zbWl0IEV2ZW50IEZJRk8gYnVmZmVyIG5vdCBlbXB0eS4gKHNlcT0weDAwMDAxYzNl
LCB0ZWZfdGFpbD0weDAwMDAxYzQyLCB0ZWZfaGVhZD0weDAwMDAxYzQzLCB0eF9oZWFkPTB4MDAw
MDFjNDMpLg0KSmFuIDE5IDA1OjM0OjUyIHJhc3BiZXJyeXBpIGtlcm5lbDogWzQ3Nzc1LjgwNTE2
MF0gbWNwMjUxeGZkIHNwaTAuMCBjYW4wOiBUcmFuc21pdCBFdmVudCBGSUZPIGJ1ZmZlciBub3Qg
ZW1wdHkuIChzZXE9MHgwMDAwMjQ0ZSwgdGVmX3RhaWw9MHgwMDAwMjQ1MiwgdGVmX2hlYWQ9MHgw
MDAwMjQ1MywgdHhfaGVhZD0weDAwMDAyNDUzKS4NCkphbiAxOSAwNjowNDo1NyByYXNwYmVycnlw
aSBrZXJuZWw6IFs0OTU4MC44NTA2MjZdIG1jcDI1MXhmZCBzcGkwLjAgY2FuMDogVHJhbnNtaXQg
RXZlbnQgRklGTyBidWZmZXIgbm90IGVtcHR5LiAoc2VxPTB4MDAwMDEwM2EsIHRlZl90YWlsPTB4
MDAwMDEwM2UsIHRlZl9oZWFkPTB4MDAwMDEwM2YsIHR4X2hlYWQ9MHgwMDAwMTAzZikuDQpKYW4g
MTkgMDY6Mjg6MzMgcmFzcGJlcnJ5cGkga2VybmVsOiBbNTA5OTYuNDAzNDQ1XSBtY3AyNTF4ZmQg
c3BpNi4wIGNhbjE6IFRyYW5zbWl0IEV2ZW50IEZJRk8gYnVmZmVyIGZ1bGwuIChzZXE9MHgwMDAw
MWVkNiwgdGVmX3RhaWw9MHgwMDAwMWVkYSwgdGVmX2hlYWQ9MHgwMDAwMWVkYiwgdHhfaGVhZD0w
eDAwMDAxZWRiKS4NCkphbiAxOSAwOTo0NzoxMyByYXNwYmVycnlwaSBrZXJuZWw6IFs2MjkxNi4z
MzU3NTFdIG1jcDI1MXhmZCBzcGk2LjAgY2FuMTogVHJhbnNtaXQgRXZlbnQgRklGTyBidWZmZXIg
bm90IGVtcHR5LiAoc2VxPTB4MDAwMDE0M2UsIHRlZl90YWlsPTB4MDAwMDE0NDIsIHRlZl9oZWFk
PTB4MDAwMDE0NDMsIHR4X2hlYWQ9MHgwMDAwMTQ0NCkuDQpKYW4gMTkgMDk6NTY6MTQgcmFzcGJl
cnJ5cGkga2VybmVsOiBbNjM0NTcuNzIxNDA2XSBtY3AyNTF4ZmQgc3BpNi4wIGNhbjE6IFRyYW5z
bWl0IEV2ZW50IEZJRk8gYnVmZmVyIG5vdCBlbXB0eS4gKHNlcT0weDAwMDAxODA4LCB0ZWZfdGFp
bD0weDAwMDAxODBjLCB0ZWZfaGVhZD0weDAwMDAxODBkLCB0eF9oZWFkPTB4MDAwMDE4MGQpLg0K
SmFuIDE5IDExOjEyOjQ0IHJhc3BiZXJyeXBpIGtlcm5lbDogWzY4MDQ3LjM0NjAzOF0gbWNwMjUx
eGZkIHNwaTAuMCBjYW4wOiBUcmFuc21pdCBFdmVudCBGSUZPIGJ1ZmZlciBub3QgZW1wdHkuIChz
ZXE9MHgwMDAwMjJmZSwgdGVmX3RhaWw9MHgwMDAwMjMwMiwgdGVmX2hlYWQ9MHgwMDAwMjMwMywg
dHhfaGVhZD0weDAwMDAyMzAzKS4NCkphbiAxOSAxMTo0ODo0MSByYXNwYmVycnlwaSBrZXJuZWw6
IFs3MDIwNC41NjAxNzFdIG1jcDI1MXhmZCBzcGk2LjAgY2FuMTogVHJhbnNtaXQgRXZlbnQgRklG
TyBidWZmZXIgbm90IGVtcHR5LiAoc2VxPTB4MDAwMDFlYTgsIHRlZl90YWlsPTB4MDAwMDFlYWMs
IHRlZl9oZWFkPTB4MDAwMDFlYWQsIHR4X2hlYWQ9MHgwMDAwMWVhZCkuDQpKYW4gMTkgMTE6NTk6
NTQgcmFzcGJlcnJ5cGkga2VybmVsOiBbNzA4NzcuNjQ1OTY1XSBtY3AyNTF4ZmQgc3BpMC4wIGNh
bjA6IFRyYW5zbWl0IEV2ZW50IEZJRk8gYnVmZmVyIG5vdCBlbXB0eS4gKHNlcT0weDAwMDAwOTMy
LCB0ZWZfdGFpbD0weDAwMDAwOTM2LCB0ZWZfaGVhZD0weDAwMDAwOTM3LCB0eF9oZWFkPTB4MDAw
MDA5MzgpLg0KSmFuIDE5IDEyOjEwOjIzIHJhc3BiZXJyeXBpIGtlcm5lbDogWzcxNTA2LjUyMTA2
Ml0gbWNwMjUxeGZkIHNwaTAuMCBjYW4wOiBUcmFuc21pdCBFdmVudCBGSUZPIGJ1ZmZlciBub3Qg
ZW1wdHkuIChzZXE9MHgwMDAwMTM1ZSwgdGVmX3RhaWw9MHgwMDAwMTM2MiwgdGVmX2hlYWQ9MHgw
MDAwMTM2MywgdHhfaGVhZD0weDAwMDAxMzYzKS4NCg0KQXJlIHlvdSBpbnRlcnJlc3RlZCBpbiBh
bmFseXppbmcgd2hhdCdzIGdvaW5nIG9uIGF0IHRob3NlIHRpbWVzPyBJZiBzbywgd2hhdCB0byBk
byBpbiB0aGUgZHJpdmVyIHRvIHN0b3Agb3BlcmF0aW9uDQphZnRlciB0aGUgbWVzc2FnZSBoYXMg
YmVlbiBpc3N1ZWQgc28gSSBjYW4gc3RvcCB0aGUgYW5hbHl6ZXIgYW5kIHNhbXBsZSB0aGUgY2hp
cCByZWdpc3RlcnM/DQoNCkFic29sdXRlbHkgaW50ZXJlc3RlZCwgeWVzLiAgSSBzZWUgdGhlIG5v
dCBlbXB0eSBjYXNlcyBwcmV0dHkgb2Z0ZW4gYXMgd2VsbCBhbmQgdGhleSBzaG91bGRuJ3QgYmUg
YW4gaXNzdWUuIEkgc3RpbGwgY2FuJ3QgcmVwcm9kdWNlIHRoZSBidWZmZXIgZnVsbCB0aG91Z2gu
IEkgcHJldHR5IG11Y2ggb25seSBsb29rIGF0IHRoZSByYXcgU1BJIGNvbW11bmljYXRpb24gd2hl
biBhbmFseXppbmcgdGhpcy4gU28gd2hhdGV2ZXIgeW91IGNhbiBjYXB0dXJlIG9uIHRoZSBTUEkg
dHJhY2VzIGZvciBTUEk2IHdvdWxkIGJlIGludGVyZXN0aW5nIGZvciBtZSB0byBsb29rIGF0LiBJ
ZiBwb3NzaWJsZSBpdCB3b3VsZCBiZSBncmVhdCB0byBjYXB0dXJlIGVpdGhlciBDQU5MIG9yIENB
TkggYXMgd2VsbC4gWWVzLCBhIGZ1bGwgZHVtcCBvZiB0aGUgY2hpcCByZWdpc3RlcnMgYW5kIFJB
TSBoZWxwIHRvIGNvcnJlbGF0ZSB0aGluZ3MgYnV0IGluIHRoZSBlbmQgaXQncyB0aGUgcHVyZSBT
UEkgdHJhY2VzIHRoYXQgaGVscCBmaW5kIHByb2JsZW1hdGljIHRpbWluZ3MuDQpOb3Qgc3VyZSBo
b3cgbXVjaCB5b3UgY2FuIGxvZyBhdCBhIHRpbWUgYnV0IG1heWJlIGl0J3MgcG9zc2libGUgdG8g
Y2hlY2sgdGhlIGRtZXNnIGxvZyBhbmQgdGhlbiBraWxsIHlvdXIgdGVzdHNjcmlwdCBhbmQgc2V0
IGEgR1BJTyBvbiB0aGUgcGkgdG8gdHJpZ2dlciB5b3VyIGxvZ2ljIGFuYWx5emVyIHRvIHN0b3Ag
YWNxdWlyaW5nIGRhdGE/IFRoYXQgd291bGQgd29yayBpZiB0aGUgYW5hbHl6ZXIgY2FuIGtlZXAg
YSBjb3VwbGUgc2Vjb25kcyBpbiBhIFJpbmdidWZmZXIgb3Igc29tZXRoaW5nLg0KDQpUaGFua3Ms
DQpUaG9tYXMNCg0KDQo=

