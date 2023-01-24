Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B686793C4
	for <lists+linux-can@lfdr.de>; Tue, 24 Jan 2023 10:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjAXJQK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 24 Jan 2023 04:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjAXJQI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 24 Jan 2023 04:16:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA7E2C644
        for <linux-can@vger.kernel.org>; Tue, 24 Jan 2023 01:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674551762; x=1706087762;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WMvGEFu+D2wYdNEi5CbNwPy2vqTz4UQyhVmeluNKDIg=;
  b=gLLDHdKZ7TQvYQtYnJ4QubesY4fico1tAakwcR3siTFkSceOU/x2ZiYJ
   v3DYnuoBb1vx19C4s7A3RlYhL767x+A0ZXHjKWzKXOqr3hv8lHHi9Xwgb
   NxLzIIPOwzsHv0DFXyEucrp7//2XhPGHz+G5HDrXOXwK1XkLUNGSPzDe3
   9DMVppeSx3Xj65MqdMBHP45fgaWUiXauOMth4FOc8Me394GZjWVKTbs53
   sRSXg9ckPDKKBB6o7XnfnXlP73QrCsYFf+8eg0RKO7jW94oVuLXTPOMB+
   IZ0FnUYGzWe+pF/9N1d9tuTz2BvxssWiAEcsLAJzKPPtzmbY6VfH0oHBp
   A==;
X-IronPort-AV: E=Sophos;i="5.97,242,1669100400"; 
   d="scan'208";a="198029304"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jan 2023 02:16:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 02:15:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 24 Jan 2023 02:15:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqMuODgWeUDaV4N93iJaYEXYqCrpjfNC9cDxicjq3aBSDnKOIS9O5MFbc6CuzcyFyfMVDg45luBVHeSGJn7rAmXzM2i8fd4we5ACYNI1ROOaf9adOj6iv1SrLTcA9jUksFl5ZySZQGIlBM/RXhMmUfLZdf8KxNsd5gjMS0BNB4rtiUO4KmQkEAaDwMxeUieVemq3Eb41CkbEjj0/JyucDDZCYWTunVjJRdz8VmZUqC1zc1eIat0lYF7Lb0f9q07ewFTWWxSdD9+veT18Da0mMjMUCCXmydKAwTKDltfuHOeIRTRChdaCHKpQqTH/pAfdr6RiUVAPZh1ob9K/m+4Y0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMvGEFu+D2wYdNEi5CbNwPy2vqTz4UQyhVmeluNKDIg=;
 b=XD+AaumpD6J7X8PmSx67Xg/hxhURcPxNefvBNmWqPszPoY/R1nvj6O9R/BCwGu/D0BSX5xbV8UVdvuJ69HUcxk+ksPQeSBXlmkMO47VzIFBQdNaGL2dTdoMiB/ZXHvCtbHzesxLQtNKStItp3g0f9yFTihIwVLxHnT91vMiIx9mXELtt3GyDyut5OQUjN/ar9e2pmxKBjwpYUGPNvbkOXUFDp9wr5ElnURUayJH2skv7E/Ccyu8ji9svqoz6Cqo17MLHCUeBTFilYjPhVLQ9eCO8IlIhAbD/FeytrpPNmbu6hsYcOrxomid+VfbNRM1No4fMokfzmxC5pqapbIHAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMvGEFu+D2wYdNEi5CbNwPy2vqTz4UQyhVmeluNKDIg=;
 b=gweDDLItcR4nkdOOt9d0mUOek45pgz/ImqL/K4bOLQJ9V9AeLXhiax4ktY1iMkB7oaHCEIheL9UEYrcCIG+NSJNaHh6Oi3zKvWFk3smD2PMks/JJkmdzMI/q0JlgdtaXNrCIPBTQ9l8iY2ZDkb7busGctlaQWYSdo6UFoO5QeGk=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by SJ0PR11MB6741.namprd11.prod.outlook.com (2603:10b6:a03:47a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Tue, 24 Jan
 2023 09:15:57 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 09:15:57 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <Stefan.Althoefer@janztec.com>, <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>
Subject: RE: AW: RE: mcp251xfd: rx frame truncation (1/2)
Thread-Topic: AW: RE: mcp251xfd: rx frame truncation (1/2)
Thread-Index: AQHZKz4szMq49nyLkUucW5HyhGITIq6kOILggAAd4YCAAPuhYIAARQeAgAAbIACAAACgIIAAC5oAgAIFcICAABmWgIAADieggAF9MYCAA9Z98A==
Date:   Tue, 24 Jan 2023 09:15:57 +0000
Message-ID: <BL3PR11MB64844C1C95CA3BDADAE4D8CCFBC99@BL3PR11MB6484.namprd11.prod.outlook.com>
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
 <FR0P281MB19669C3FDDBE07D6B320C18997CA9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR0P281MB19669C3FDDBE07D6B320C18997CA9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|SJ0PR11MB6741:EE_
x-ms-office365-filtering-correlation-id: 80cf20c0-ddf5-417d-78e3-08dafdeb9a6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: byCpnpcqSv7xu5z+2uzvOoFZwlloFvjH1yr5f0IXiFlZARYiZT6DKenGYzs6b+tqc3eMGj63x1DCnQIg+5cx8iqk+dn3JoBFCR8T1K2Svq+PB9D4BAwmiEuI2rSiuoNKkGeKXfRXMAJMkHBv8qFZHnyi7LQZKk9M1VbhqIstZILhRtKPYiC4iMInTKCJ1tGyYz28KLo1AtQ02A5w8pX6MUYGl5UBLgIXZIpSJPOLRKdaRzqbuvS2bBNWtwQMdKb+QZjz5pUCILMDXuQssYhbRexE6QXsIKdvllu1u6GMbr/WFdA8dLA8H2f2twJZMHQQMRAQ8g/e7zT4i5dOgE7uc2w36pHNXvtKKjHPI59i741PHknQB2cpQijvnYj6qfVfQsWZ+9PhkGtjd76/JY7HrMVCpCAaGtIBTN6sIOxRJgCVIYR4b/6Dt5kDypx3oCnFHws9RCfQ46GsA2PsuI4raVKb8aRto+0gqlFxkup9DIJdMLXmn1zn9Z9AnDYiWzE6lIrP3u+nLoopN41IfSqUUBQYRlokK2DZZSwFxg/yHi88ipg2g4ouffB6c8NQssX/Pxgtu8epy2SPTzvW8CkLMDTl9caEti5UhSczVi/uU6DSxAd4Rpac9VtQdj/1T/2i4kViTZwi5+zJCkZI2eFHuzG9oJjiDRNfRP8pJEOzNvgE9DKh1A9GcOLMw7jBHI/5qr3TU5oB9veNS3ANzYD3KA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199015)(4326008)(33656002)(8676002)(64756008)(2906002)(66446008)(478600001)(66946007)(66556008)(76116006)(66476007)(26005)(186003)(9686003)(86362001)(55016003)(7696005)(83380400001)(41300700001)(110136005)(6506007)(122000001)(71200400001)(316002)(38070700005)(52536014)(8936002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFhFbDRScmp1MnhheDZVOG1lRkV2ZWFwQkdtQXEzdWNNMWZOYTBBYkNwMWdF?=
 =?utf-8?B?K09mdlBjSlRjZ1NVS3ZvV3g2U3hvdnp6TEtjVGg1QjVzSHRNeFRzaEJNWC96?=
 =?utf-8?B?a3BCR3NzUElkdDVWeHhmU2dnZjZxOGw1T1NaZ3E1QmVacFdzbW5helhjUGJ0?=
 =?utf-8?B?SHRuTXZXQWVYcUovMzBGa2lZblpZQ3RYVFFScDVPWUpMWjNZUjV1bk8xWk5m?=
 =?utf-8?B?b0ZFaU5tOXgzNGw4MUxnUTl6N1dqc2lpdGxkWjlmVkNxeWdsZ3ZtUmVLVS9M?=
 =?utf-8?B?aDAvRFpyWkowNjR4Y3NVelFYZFo3NXRhTExJTEh2U2dJcnFMOGt2MldEeU93?=
 =?utf-8?B?cHBGTTVBdzl3bVNxZGljTTZTS1phdDR4TlM4Mzl6aWQzdWQyei9JYkZpa0cv?=
 =?utf-8?B?UlNuRTFzaGphWjlxMTRmZVFBZTRnL0lQb0ozdnhTdnc5Z0VaVCtralBzbHZi?=
 =?utf-8?B?VFh6SEVMVWpSaHBPZWVwMWF2eHNJcmhOY29aa2krbm1yUlgzQnA1b1RRbmth?=
 =?utf-8?B?SUxQUU1GbUdIc0JhdG9vaTQrb2JzR3R5ZWVaMGVPRTFSUDJlN3dmM0hBSDJU?=
 =?utf-8?B?cER6TXUrdHQzNmlzeVhmWmlQRFZHMVVlamRtV1Vqa1NtbjZhUUZWVUM1aTRt?=
 =?utf-8?B?aEVRTG9oeVRrcmZZVjRHNHZrZ3VXeExlcERqL0dGa2tsVEVpSk5CbWNmalh2?=
 =?utf-8?B?UFFDQklqaG9rN3A2UU12NHZoWFpLM1JLbVEvVFNtd01RNmZid2VCZW82bzVp?=
 =?utf-8?B?TnJWWnNTSi9wYzA2Wm1YUFZYdVNYZDJkOWNRY2dQeExMNFRXdTY4bnBpN3h1?=
 =?utf-8?B?MlVqMjNHL3ZxRkVFTllvcXJNSlROYUZDbnBTSzhHTkJLVUQzZkpySzRmVE55?=
 =?utf-8?B?eGN6YjVMRlBWMEVod2prSkgxOWpRMDhsR0ZrMkhUTmYyVWIxNmVTR2JBRzV1?=
 =?utf-8?B?SEFtV3paQmVMVXhvNVVkc3psRDduaG5jWDRkMVhBN01IQ0s0QlhEL1pEWTk3?=
 =?utf-8?B?ckJscURzakdIRkRhUFYzeHVUVlUxd1Z3alRFTWl1UjcvRkZCdlphVWxKcU1z?=
 =?utf-8?B?OUp5SXcwZGxaWW9Bb0hzU0t6SEM1RGdCd1dYTVFJUmFlL3ZyTDhURy9UZ1dt?=
 =?utf-8?B?dzVrMzZwSzF3MHdtQXZHc0ZMekVUbTVzek9UdUJBVU8zalJoUjZxa1VRdWUr?=
 =?utf-8?B?U1ROQkxCd1d3dDgwU1pCcmxjcVY5UVQyMGdYNVF4VlJEYUNUekZRNndpcERk?=
 =?utf-8?B?YlhDUy91UFRrNG1oN0gzNnVrWE5pNFFTNzdjU2U5dDRhSk1KTm55cENCQ1RG?=
 =?utf-8?B?cU9HMEFmcGxlMnFXOTltckNrQ3Q3V2czVVZGL3hFKzhFRlltWno1TDBoNUhD?=
 =?utf-8?B?NVdQdE9obTJIaW40QTkybmJTVmtiMnNQdDI4VzlvcThnUUFabzhLNzZFOFRF?=
 =?utf-8?B?b0dOWG9MNFpJWXNHMlhqUDlOYmVyQmgxa3hZRUlEUi9lWlpWQmZibnBzK1J6?=
 =?utf-8?B?REJ3b1R6eHZTcW9TeG1HSEo0eUxFZlRZUk9ubHU4Slp2cGYvNXl5clVzOWdx?=
 =?utf-8?B?WGY5b1U0RGlXcWtDQTBjMVlGVFIzZzZCcmt5NXR0L1lnNHFtNWZIT05Ic05k?=
 =?utf-8?B?WFpVVzgwU1lWaTlFL3JJb2VFV2RmOWFTWUYwcEFLSFVGU0RjdnpxQmdiSlFH?=
 =?utf-8?B?dWlvNGJzbkJoNWFCMVRuU24vTU5QcjNXVGZaUzhOM3B1UXpWNkg2Rk1kRTA1?=
 =?utf-8?B?T1pyZmhEYjFBeDk0bDRzaGNkS0JkSkVoRDBKSVVLMU83RkpOZFpWYm1YdVFO?=
 =?utf-8?B?TXRDdzI3dDIvYVlyNXhwK1Z5UjF0aURBSlpBaERIeVFzakliRVNHbjZ5YUNj?=
 =?utf-8?B?Q3FWa3E4OWRPcHR3RWZ5NE1hb3B6cmRyR3ZYT2VtRFNjdW5tVE9uOTFOOE9I?=
 =?utf-8?B?Y1BpVDhlZ2kyR3pudzRVbUJTeTFuaHZ6UWx0NmU3KzdVUXhNNkovS05qR1JE?=
 =?utf-8?B?VGZyOUZrK2o5NUZQdTJDRFNZUEo1S0ROMkJhdHhoQ21FUllCb1BVREdRalZ4?=
 =?utf-8?B?YlZ3bldyeGEzaEVlY3VQTVZxRFN6THJYeDRRenl0VzVGUng3T092YjRFSVYx?=
 =?utf-8?Q?AnYVjaZL0njdSDhrvAgg2pkMF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cf20c0-ddf5-417d-78e3-08dafdeb9a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 09:15:57.6001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DN3qxgGxtY+6Smh1mCXoD4TuA+VRyTEXJKeEDX/2tsBRgjrcY76/bI9HsohI/Kd6rtJej2dYmSRVcDQCwferhz8suCEpfApjA3afT8FD85o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6741
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

DQo+IFNvbWUgYWRkaXRpb25hbCBlcm9ycyBjYXB0dXJlcy4NCg0KVGhhbmtzIQ0KDQo+IE9uIG1v
cmUgZXZlbnQgb2YgdHJ1bmNhdGVkIENBTiBmcmFtZS4gVGhpcyB0aW1lIDggZGF0YSBieXRlcyAo
aW5zdGVhZCBvZiA2NA0KPiBhcmUNCj4gcmVjZWl2ZWQpLiBTbyBtdWNoIHRvIG15IDIwIGJ5dGVz
IG9ic2VydmF0aW9uIC4uLg0KDQpUb29rIHNvbWUgdGltZSBidXQgSSB0aGluayBJIHVuZGVyc3Rv
b2Qgd2hhdCdzIGdvaW5nIG9uLiBUaGUgaXNzdWUgaGVyZSBpcyB0aGF0IGR1ZSB0byB0aGUgYnVn
IHRoYXQgTWFyYyB3cm90ZSB0aGUgd29ya2Fyb3VuZCBmb3IsIHdlIHJlYWQgYSBmYWxzZSBIRUFE
IGZyb20gRklGT1NUQSBhbmQgcmVhZCBtdWx0aXBsZSBSWCBtZXNzYWdlIG9iamVjdHMgaW5jbHVk
aW5nIG9uZSB0aGF0J3MgY3VycmVudGx5IGluIHRoZSBwcm9jZXNzIG9mIGJlaW5nIHVwZGF0ZWQg
d2l0aCB0aGUgQ0FOLUZyYW1lIHRoYXQgaXMganVzdCBpbiB0aGUgcHJvY2VzcyBvZiBmaW5pc2hp
bmcgb24gdGhlIGJ1cy4gQXQgdGhpcyBwb2ludCB0aGUgVGltZXN0YW1wIGlzIGFscmVhZHkgdXBk
YXRlZCBidXQgdGhlIERMQyBpcyBub3QsIHNvIHlvdSdyZSByZS1yZWFkaW5nIHRoZSBvbGQgRExD
IGZyb20gdGhlIHByZXZpb3VzIGl0ZXJhdGlvbiBvZiB0aGUgUmluZyBidXQgdGhlIG5ldyB0aW1l
c3RhbXAgc28gdGhlIHdvcmthcm91bmQgZG9lc24ndCBmaXJlIGFzIGl0J3MgYSBwb3NpdGl2ZSBy
ZWxhdGl2ZSB0aW1lc3RhbXAuIEF0IHRoaXMgdGltZSBJIGRvbid0IGtub3cgaWYgdGhpcyBpcyBj
b25zdHJhaW5lZCB0byB0aGUgRExDIG9yIGlmIGRhdGEgYnl0ZXMgY291bGQgYWxzbyBiZSBhZmZl
Y3RlZC4gSSB3aWxsIGhhdmUgdGhpcyBjaGVja2VkIGluIHNpbXVsYXRpb24uDQpOb3csIHRoZSBv
bmx5IHdvcmthcm91bmQgSSBjYW4gY3VycmVudGx5IHRoaW5rIG9mLCBpcyBjb21wbGV0ZWx5IGRp
c2FibGluZyBmZXRjaGluZyBtb3JlIHRoYW4gb25lIFJYIE1lc3NhZ2UgT2JqZWN0IGF0IGEgdGlt
ZSBhbmQgZm9yY2luZyByZS1yZWFkaW5nIHRoZSBGSUZPU1RBIGFmdGVyIGV2ZXJ5IGl0ZXJhdGlv
bi4gVGhpcyB3aWxsIGJlIGEgcGVyZm9ybWFuY2UgaGl0IHNvIGl0J3Mgbm90IGEgbmljZSBzb2x1
dGlvbiBidXQgdGhhdCAqc2hvdWxkKiBnZXQgcmlkIG9mIHRoaXMgZXJyb3IgaW4geW91ciBjYXNl
LiBJIHN1cHBvc2UgaXQgY291bGQgYmUgZmFzdGVyIHJlYWRpbmcgZGlhZzEgYW5kIHVzaW5nIHRo
ZSBlcnJvciBmcmVlIG1lc3NhZ2VzIHRvIGRldGVybWluZSBob3cgbXVjaCB0byByZWFkLiBUaGlz
IGFsc28gbWVhbnMgYW4gYWRkaXRpb25hbCBTUEkgdHJhbnNmZXIvU1BJIG1lc3NhZ2UgYnV0IEkg
c3VwcG9zZSByZWFkaW5nIEMxSU5UIGFuZCBESUFHMSBpbiAxIE1lc3NhZ2UgdXNpbmcgdHdvIHRy
YW5zZmVycyB3b3VsZCBiZSBmYXN0ZXIgKGF0IGxlYXN0IG9uIGEgU1BJIGRyaXZlciBjb21wYXJh
YmxlIHRvIHRoZSBQSSkuDQoNCj4gQW5kIHRoZW4gdHdvIGNhc2VzIG9mICJUcmFuc21pdCBFdmVu
dCBGSUZPIGJ1ZmZlciBmdWxsIiBhbG9uZyB3aXRoIHRoZQ0KPiByZXF1ZXN0ZWQNCj4gY29yZWR1
bXAuDQpXaWxsIHdvcmsgb24gdGhpcyBuZXh0IGJ1dCBkaWRuJ3QgaGF2ZSBhIGNoYW5jZSB5ZXQu
DQoNClRob21hcw0K
