Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA47966B80A
	for <lists+linux-can@lfdr.de>; Mon, 16 Jan 2023 08:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjAPHTN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Jan 2023 02:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjAPHTM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Jan 2023 02:19:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EB0CC20
        for <linux-can@vger.kernel.org>; Sun, 15 Jan 2023 23:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673853550; x=1705389550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2U6wDViKRZIHSz7xpSrafEM5mSNeI7p0zWHrC6kQiks=;
  b=y5sTo1tQyh6jaY64EdevodPR6zfuyBv45s5EdziL5slbXZpioTBxOtnW
   7ZKso6OI0WQb5OiBoHopMHBcxWjEeB46yho7KWOD18o14jeeFo6QWKrV+
   /iaJCQtwQ4yUcwfIjRbxmvr1NqvGnVe3tcxs5L0d1uxzIzRCFTe0ADv9p
   JT/OowXaBQXQAMHKj+ba7GsA3WvIuP0lBpK0ZyCjf9NN7PnhRpCxaLKQb
   bczc7H35+7sTWvMANRCo1TcvbymwB66tpGQyc/LqvVM9H+5zQgkzrX5t/
   4BJ/wKoEfgKLxunRMllVraUwNxXp/7+IWig9Nr0y6fkhHbrfj0cW+diIQ
   w==;
X-IronPort-AV: E=Sophos;i="5.97,220,1669100400"; 
   d="scan'208";a="207920814"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jan 2023 00:19:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 16 Jan 2023 00:19:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 16 Jan 2023 00:19:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhTk/0J0jwEfutr1a8Fr2dS7p/DCB9H3rlDRLsh1jntUDVzCoXWr5DkWK1+qHhD6+uaMNJYdCIIiLx15AyEqPj5CVaIq+bq56McH5Kc25IeWf8olEOQXghtzcSniRt4/N0XiODS+FM68QtMWpR5Qh0GuAyVs4HzJGyJzDlFuSFVsNbWA5XbGUXXNt/2l2WgYiwrowWcqRFF+Qe7zxiyAJYQ4pRYcYGRoF3LGZoPfYIotW/59KxN9DGElEXtT1Wc0UidlJRkQWw3nOmhsYutgCS6jIdwUISuRuovCuJg5DeCeaFLgfeTmOOwYKGdgj86JJoX9iXO5NgFSgKt1C51C/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2U6wDViKRZIHSz7xpSrafEM5mSNeI7p0zWHrC6kQiks=;
 b=oJFm0PPE57YDg24cwfKNpGVLAWgZycbtyKFDANTu+SvH046gTI6W77oQcF5JKcLKzYwmFyNiUTN93aWTcfZm01dAdVIT2qIBn8u/d7bc/tSr8e2v5w+P55NiKfchR/yh9d6dTOePgU9iN9vFT3EYe3C4Btb5QXUK1Vqe5ZEsgCpxhbRTzXS4ziu7Ze2nnE+rwB+y6WQQc28n54LCH8XD04GqeOnZf2I5hCgc5DFXCNJmMBFtooa6xh9CIdAtdUhmsoRadff4TjQy8oYxUITH5EyCVweS7mSeIYe16X7nMbVWcDkbZjAjgKZGPizoFc8UMXrmCqM1iFZqFOydeO3e6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2U6wDViKRZIHSz7xpSrafEM5mSNeI7p0zWHrC6kQiks=;
 b=XVpKDHtZ4OlQkljq3H5k0qP+0aLUHpg5tQG2Jea09TRIKpA+XgT53jheLXUHkRlNXwZjEiYFB0/vVduvXJ4KnwfP2EUWezWLLuSw/eP0oyEStZ6g9CXeZqaFjFYmeQCLmiGgWV3RSIuU1EstSNIGBGsQ71YivS/RVbW/q/Tl5CM=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by MN2PR11MB4758.namprd11.prod.outlook.com (2603:10b6:208:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 07:19:08 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096%3]) with mapi id 15.20.5986.018; Mon, 16 Jan 2023
 07:19:08 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mkl@pengutronix.de>, <Stefan.Althoefer@janztec.com>
CC:     <linux-can@vger.kernel.org>
Subject: RE: AW: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Thread-Topic: AW: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Thread-Index: AQHZJgs1ergp/bMJp0qTjmcZ1NcfU66ZzGkAgACdzgCAAeH9AIAACAkAgARVUHA=
Date:   Mon, 16 Jan 2023 07:19:08 +0000
Message-ID: <BL3PR11MB648420948C993C005328D39DFBC19@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <20230111222042.1139027-1-mkl@pengutronix.de>
 <20230111223004.w7z4ghdahe7jvebe@pengutronix.de>
 <20230112075452.4v3ba2hibxx3i5rm@pengutronix.de>
 <FR0P281MB1966D75DB56E45D225313B5697C29@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20230113130844.spbdtq2kumcjn42k@pengutronix.de>
In-Reply-To: <20230113130844.spbdtq2kumcjn42k@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|MN2PR11MB4758:EE_
x-ms-office365-filtering-correlation-id: d2067786-34fa-4bf5-42ee-08daf791f536
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MubiCTvMLWG/QKQD2B67Ml5sFzswt9DoAkgsAyIDr9B6J3kb2X8+XY5zASxu0P+QGYBr88CYPrXtXqf149h7ZijmyALTfXe6lqvjFhF9YNs2aObEMT1XTI0q56lrQbxmcjnzG8co+XSewsFomvxQLDoBuafFLJ+ik0w44y4Xg4b6oiqaQAlu4fFJS95u+7qZHyqITussocB2um6uquu7jBHFwR36EL8sqss7eWx9asKSfRGI+MV7M4aGyoYmtBDS9oUJUVPDiCYx/MYLSklT+1wHkhlMvhy9Tl3w5jEt/dQq3q07s5dwg6XU4Vm1lE+UOMdex6J8uuIVQ5eB3L80jDyw/S25YuRsR3DzsWe4Q97/vyYBs9jPEP3j2fEbrjTNboCh1T4m+olqS6+b7bXOJVWyaxycr0kRhBfbTiSQaAL5AX3HZm1D8LiEZXZllmlsxlapjULpeLYaRHXT6w3I01vH+EJ69ET2s8gJTCvzWLpPJUUb8Sb/54YXVPQxupxz7D8z0hb5lvqoY78PtGv+2Rie9jexfr2Q5ahrm2+v0AqZN3wEJkN9Rh0kPQFmBARCE5xgMZKILq3Y/YHnkWYqKQlSvw6x8bn44WFZ7ZIv5z55m9jHiA+s5fnt9+i1MWrX42YgJqq3szK4xMKoMTOiwzaZZ/ZnaAPO+0L394dycZUwI4Khl8agf/V/SMP2SfaHuFFYSB6kCIbKJgodU2bx4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199015)(33656002)(122000001)(38070700005)(86362001)(38100700002)(4744005)(2906002)(5660300002)(8676002)(8936002)(52536014)(66556008)(55016003)(66446008)(76116006)(66946007)(4326008)(64756008)(66476007)(41300700001)(9686003)(186003)(6506007)(26005)(110136005)(316002)(478600001)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjN0TmZBejBxQkE0NzlpakY5WUY2eE40b2NsY3ZvNlZ3akdFalJSQi9tbXU5?=
 =?utf-8?B?YXJTUHdDWlh3SThteVFmbEEwQytqanl0cXRnTEwySzVORWFEcmVGbmcwV0Rh?=
 =?utf-8?B?b2plZzhqajhTKzJ6c2RJOVhKQXRvYWhmaXFQU3lDQU4zSjJWS0VEOFdicm9T?=
 =?utf-8?B?M01EbmtqckdFMXdYN1RmNkdIRlJkWml1Y253Rll5VXl3dnlBaEpKa2lOS29a?=
 =?utf-8?B?M3VyL2czSy9YUlloajFGekNteS9Ob2txbG1oazJTQzdLd2RxMWNaOG80TjZG?=
 =?utf-8?B?djJRSnNxSlRMdzFqZFdxajNvVG4rdEVkd3gwVTBGRTN5SFByVjJNckF0TmZ0?=
 =?utf-8?B?R3FHb3BJaWRoYjhpS2FpMW5mbXJNSVpiVXRMZU4yT1VFY21sNXB2b25nTHdQ?=
 =?utf-8?B?V0pqTGY5c2xzUU12UnNka2FNRVZqSFFPd0I3R2pEUi9NV0U5dzMxOUVFcVNZ?=
 =?utf-8?B?NzI0Y1FzTHJ3ZWNpczlGangzM0gvY3BWUU9FV2xKOG9kblJhYUZzS1NDd05T?=
 =?utf-8?B?QnJUbUVweDlocDd1WXVoNGd3Q3loWWJMRnkwc1hJMWdOaFJTYmI2Z1NCTHlI?=
 =?utf-8?B?aTB0dWVVdHdrdGE3ZHIycXI2cGhXb3haL0J3a0dCRkFMVVhLRHZ4RlUxTXhE?=
 =?utf-8?B?N3M2RThPYWloREVzbU52bzBLOXk0WU9ZVmlMYVk4OThJb2hzTVp1WWZzZHBo?=
 =?utf-8?B?eE50WlFWMDlzSU9GaWhNZDkzYlUrVkMvYVhBd2JCZU1raGo4ZDBJL25WUERP?=
 =?utf-8?B?MVBNSWtMR2QzT0JNWjhzYW81NkgyVFBvUVhpRTdvOVRZK3Q4Y1I5REowOTV4?=
 =?utf-8?B?dE9NTVBsdFNOL3BIS0NFNGEwZW5WSUFGRzRVSjRhdEROVy9ySkVXeDNtZHNj?=
 =?utf-8?B?U1FEYUZGNHdvb1lqcGFSa2dMRXVaNndFcFdGam0rS08rSnNFV0FSUGxUajZC?=
 =?utf-8?B?Q0crWGRNcjBqYndVN3pkUVMvb0NZdXR6VkNIUlVOQlMxYnpWZHA1QlZyK0Fu?=
 =?utf-8?B?Sk5QcjBROGhpRU03b2ZBWHpyYVpFRmR0T1FqWjJHZGJ3b1ZOQk52YkpVNlFw?=
 =?utf-8?B?U042czEralRaYU44cEZrTFlUcVVZTWloekRxekhmT1U3T1VWbjA1VWo3Skpl?=
 =?utf-8?B?OHN3U1hHcGkxS2p5ZUpJY3RTaUNmMS9UMnZaTnBDcS9nWU5lU1ZuRnpOQ3Ft?=
 =?utf-8?B?bTBnV0YydWp6UTBURlN0ZXAzVnNaYXl3YXVtODBDRkdqUHNIQlpTSDNjalJM?=
 =?utf-8?B?eWJZSFZkanVYb04rTE1rMnFsM0ZmMGFPWGVRZGdwdVBhL3NLRnBoR0pPV1lz?=
 =?utf-8?B?MSsvYzhqcWVPQmRWc3V4bzhzRlJGZU5KMkY0WkVEbDVhWHFuaEF6eXNDdzVr?=
 =?utf-8?B?ZmI1ZlYxRXgzTFZlMmdZaDRpWnJ3eU1GeGkxeGloU0VrNmxqMHpEQ3FEbjNp?=
 =?utf-8?B?MUJEVGl5OC9sZzRmZUIwanptWENDKzdvc0J0NHAwalMyNHFva3Axc0Fkd2Vy?=
 =?utf-8?B?RGJuSHlFclVPc09OMkpYMHpWRUYydDlWUFl1SmhOZnk1ZmZHaHAwcXVVTmcy?=
 =?utf-8?B?aUYzRngwTElROGZURHJzbmZxSkpqTU9vY3RxQjlwVmlWdHprVVZLWEtzUmNI?=
 =?utf-8?B?Yld6SDc3R29MRnhTNDBXSFR0Ujh6VEhZeEJLaWV2b0dwSHQ4RThqcXJaRHQv?=
 =?utf-8?B?WnBZQ1luREJobFN0aU5ITTZJRXY1MG9TUHpQRWRsUmxxeGlMdytXUExIalFQ?=
 =?utf-8?B?eWR0SnRuQysvdEJOK041YkZwV0UyYmtNTUMvSk82aWtCREcrUlYzd2lISGZS?=
 =?utf-8?B?S1JpQlZjRnZOWnM2cndiTWIwcVEzbjI1b3AwdmNrVld1UTA5WTZieUllb1Rx?=
 =?utf-8?B?Nlp3NlVCVEd0aS9BdnNaeHRhRFR4REk5OVh3ek1tSjdGWUp3ekpTSjIyMmRo?=
 =?utf-8?B?c1VYWkp1d2VhMTJZZ0dwUXVjMzFBV3hYcDhqWEJJNG83am5PVGxwR1dXYVhi?=
 =?utf-8?B?MGl0TmlhbXpiQWc3QzFEQ3ZwRG4wTS9uc2drT1lxeVM1Q0FJK3ZDSzN6Z3or?=
 =?utf-8?B?MW5EeEkrcVpYVmVJQXVDVE9HNzRwSlc4RVA4T0ZoeTNHRjFTcG00SVhqdE04?=
 =?utf-8?Q?bRsLoGgbFmoDomgG1tfu67MeB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2067786-34fa-4bf5-42ee-08daf791f536
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 07:19:08.2326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZMu1xG+QOhmYl8PegLmrYpSIHE+2LbiD4RGn0XwOFP6v3aPznv29oDz3FD654w/f8xtfmfXmA4yRIkO6wYDGOJNsW71URG2kf9N9LTwODc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4758
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PiA+ID4gSW4gbXkgb3ZlciBuaWdodCB0ZXN0IHRoZSB3b3JrYXJvdW5kIHRyaWdnZXJlZCAzMSB0
aW1lcy4gVGhlIHRlc3QNCj4gPiA+IGhhcyBmb3VuZCBubyBwcm9ibGVtcy4NCj4gPg0KPiA+IFRo
aXMgaXMgZnJ1c3RyYXRpbmc6IGhvdyBkaWQgeW91IG1hbmFnZSB0byBnZXQgdGhhdCBtdWNoIHRy
aWdnZXJzIDstKQ0KPiANCj4gSSBkb24ndCBrbm93LiBJbiBhbiBvbGRlciB2ZXJzaW9uIG9mIHRo
ZSB3b3JrYXJvdW5kIGl0IHRyaWdnZXJlZCBhYm91dA0KPiBldmVyeSAxMiBNaW51dGVzLg0KDQpE
b24ndCBoYXZlIG51bWJlcnMgYnV0IGluIG15IHRlc3RzIHRoZSBXb3JrYXJvdW5kIHRyaWdnZXJl
ZCB3YXkgbW9yZSBvZnRlbiB0aGFuIHRoZSBvcmlnaW5hbCBpc3N1ZSAoaW4gdGhpcyBrZXJuZWwg
cmVsZWFzZSkuIFRoZW4gYWdhaW4gdGhpcyBpc3N1ZSBpcyBhbGwgYWJvdXQgdGhlIHRpbWluZywg
c28gc2xpZ2h0IGNoYW5nZXMgaW4gdGhlIHRpbWluZyBjb3VsZCBoYXZlIHRoYXQgZWZmZWN0Lg0K
SSBoYWQgdGhlIHRlc3QgcnVubmluZyBmb3IgdGhlIGVudGlyZSB3ZWVrZW5kIG9uIGEgcGk0IHdp
dGggdGhlIG9yaWdpbmFsIFNFRUQgQ0FORkQgaGF0IGFuZCB0aGUgbGF0ZXN0IDYuMiBSQyBrZXJu
ZWwgZnJvbSB0aGUgUlBJIGdpdGh1YiByZXBvIGFuZCBkaWRuJ3QgZmluZCBhbnkgaXNzdWVzIHJl
bGF0ZWQgdG8gdGhpcyBidWcsIHNvLCANClRlc3RlZC1ieTogVGhvbWFzIEtvcHAgPHRob21hcy5r
b3BwQG1pY3JvY2hpcC5jb20+DQoNCkJlc3QgUmVnYXJkcywNClRob21hcw0KDQo=
