Return-Path: <linux-can+bounces-50-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA137F58DD
	for <lists+linux-can@lfdr.de>; Thu, 23 Nov 2023 08:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31491C20AB5
	for <lists+linux-can@lfdr.de>; Thu, 23 Nov 2023 07:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFDC14013;
	Thu, 23 Nov 2023 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TlqTbSXT";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="m8RbskFS"
X-Original-To: linux-can@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466A083
	for <linux-can@vger.kernel.org>; Wed, 22 Nov 2023 23:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700723329; x=1732259329;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=d6MA813NDmmwA6BA/Maja3bnFFj0ia55KXSEgKhgCuk=;
  b=TlqTbSXTCPk34FTr2nBhNd9UTwf3WP+1/B/mPxVXPVp9o7efAdmUQJTA
   ZzRYTvaTn/ludAS+F/6WcvvF+zhiqVVNcKgG+KUlAI+NeYV5QazpG3Fel
   iIUbFogFJ1qcCgjKdJnUFPBZ7vXoGyY14MSRBhoFIYcGnfMepXiDRZGxD
   HrUTlWle70dg1LiBCLgZKyR7tkg4s9Ckzs7HuICCgH4CLEFDpLK64pb0U
   dCMV8icnymRiJHLNN/m61/o8uCQqtlb42c1+ri6ZkDe08IbA/d4R5CCB5
   Qq+myHwq+lO8yKWsyUc7apWlTIYWf90zP7ndTzLrrC5H/ugyv/7bNyamk
   g==;
X-CSE-ConnectionGUID: Ha/qkcsSTyqQzd1wm9N6Ag==
X-CSE-MsgGUID: HTVejFSCST6aY3aRd+EmLg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="12917929"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 00:08:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Nov 2023 00:08:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Nov 2023 00:08:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsAv4IN8Fl8sB/ec7bssTAOFxL2EHzzVwufNMuZWcM75Sz8ILNu3VA0fB0JvtY1YUZSQKAPNycK4G6jmeKxngBn4f9D1xyDnbU81E4I6hFexNruIR94ELtUi9Y/Bf2f2VICOv9Ra2TuM5Sih8SKdjtZGu25kxeCNmtSeOK50JjTqMty3kNhgvm2vBlOBwo5+qTVdn8J8OFNShDkyiXDjbQB4PQC1gNwKjWxtPCiV4FHz4GcYRwQ/s8gYriSltKY6GHaBSq+lbJaZICxKwcLxqqr0tOriouE+qio+mWBOvjFyIGI4jUWI9PQglk+JWRkyMkAh1541HgmkQpDbuqOHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6MA813NDmmwA6BA/Maja3bnFFj0ia55KXSEgKhgCuk=;
 b=Ub4HNvK603mOlqFV/SMx6vWUeTAB8MG4LPsH5eiOd1SKBPczZE7E8GVDw3BDVVPTKfhAShgTJ8jCFQlDOY1YlGZdnXWWQMLoQD0kx+mK02897sAqYnP4G666ThoPQ8KxEFOScYNWCgxNR//4gT4pvx7kdn5gbHZFhIz0vi493XS8MiDXpGFSDY1YYqXWvoXFRhCqnFp+Qzg/Vn6ASs5gQv6CCbprDHXBnkPsLT+uWSg8I/qujIiWG7DpyZU4Ozoc0bHaWhTkxEtremYh/Th9AxfCUwOi7vbJd/eZ4TDnKM0CX4PRW/IknoWm4TOSlfNhAIcjrQuLSx4uqNKiI3OH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6MA813NDmmwA6BA/Maja3bnFFj0ia55KXSEgKhgCuk=;
 b=m8RbskFSZjBIAgrVl0F3I70Wwk7//R04VFDa/PEC6qrMfO7yGKX60Vtoh/QTwlZUDU/Mg6z1SsAxE7MxXkCLJbDRNvWpxB4HxOw/J+zQh90DiK2GNCX65ri5GAnSW4WGMy0HPVj5SXKub7EyCp5FdJajGDo+ds6EP4ckOdTsrFLXXjKanfREGbizOsUtVK4Po6KAB7yTay0RKMiFOSgtRTNUd3d/zlfXyXrU8qLQ4aiuEU3YljM8eAh2hmE2GduLPAsW4XNtoIu8P14eEBlNMWPLAWm1i2JK0hwbXUryQFDJZAkmBoCvyU8qvli1aDmyHobfzyyL5n9qEbBnjz/juw==
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by SN7PR11MB7603.namprd11.prod.outlook.com (2603:10b6:806:32b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 07:08:24 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::ab19:d726:238d:26a0]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::ab19:d726:238d:26a0%4]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 07:08:24 +0000
From: <Thomas.Kopp@microchip.com>
To: <petter@ka-long.de>, <linux-can@vger.kernel.org>, <mkl@pengutronix.de>
Subject: RE: mcp251xfd on NXP LX2160A
Thread-Topic: mcp251xfd on NXP LX2160A
Thread-Index: AQHaG80RZBTBnbzWcEqS/J1i1EDXV7CHe6Aw
Date: Thu, 23 Nov 2023 07:08:24 +0000
Message-ID: <BL3PR11MB64847C895A0918D99E6A9EACFBB9A@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <20231120161106.AA49E5B00817@dd15738.kasserver.com>
In-Reply-To: <20231120161106.AA49E5B00817@dd15738.kasserver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|SN7PR11MB7603:EE_
x-ms-office365-filtering-correlation-id: 8d621c55-6958-48e5-fb6f-08dbebf2fbd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H+XGvk0rrDYxQvm8KSma+2ah+48ENjz9rIjRjKDPTpmbRQN77cYhg2jLzKjQB/xtyZy4eCu76ytnHsOGKORDsxSbvQfGWSU7BSXNlzWUWs0a01Nj1PujCjVK2ljlX9ta8uxxRO4BbA3kKdA/On/0LjSjN5jTNwAeTOr7h9A/OwN7SUCouJd3pntHZOJ18J0UxUUWhUlvt33+Rzuc9HoXcM6dhcJzs0s4qNGtkT1dCirTWo2ojAWbcr5QoZ5JsOYYSarv+thd7FaKadc9EkxlQSSBYEV23nrM8me+4Jk+u8OdU8SQvavfO6UJfclLVdzUs1I4ladUz9/Tw4AnrC70opGdiiAMPHNrAzaqv6/6wSZzs8NJ6DlNo0vCH1nC6UVl6iBe9aVOHKBdLWrHCaDdmh6Ibuyed6oiy2666RLPC2YShGd7Sj3mcjFK+bhOMXI7c81PhONeELH/WK9hvhrXk8+8bDxINWfq9znkimAnTBYhYI4BFYl+sKwwVRVk/sjcAgJNyE5H6kO3dei4OMSpHkQaWczeDoaJP49P8wdq7Dcwmphcrr0tomuBTLFze7lNOg3o21n7smTa9Y2VZ2FPmMoN6ocyHmAPlXBWeHBck5HHodFwGd6VyPco9fU4ai1C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(7696005)(83380400001)(9686003)(6506007)(71200400001)(5660300002)(8676002)(8936002)(41300700001)(52536014)(2906002)(316002)(478600001)(26005)(66446008)(66556008)(110136005)(76116006)(64756008)(66946007)(66476007)(86362001)(38100700002)(33656002)(122000001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkdEYVR5UGJqKzcvMWwrYmMrVmtjQktwVTVKRW11WDUrL0pkbkEzMDMxd0t3?=
 =?utf-8?B?Z0tvS3RSTWJBNGk0dTlQQ2pYQnZTbHVTMDBsWkRKeTh2MDI4RkprRzRVQkV1?=
 =?utf-8?B?T2Iva204R1FTVlVYbFAwR2l0aHBzcHNQR2JPMG5ILzFibFFDR2dVYnlna1V6?=
 =?utf-8?B?MDB5ZjNiY0xZQUl6UkFzcjk3WlExSDdaR050MU9nMm1zalBwei9wLzBzRk10?=
 =?utf-8?B?K1pYS2hWT0hhSVlTZ2dhWVdsYksvUW1zMkVOSGphM2xiRTJ1TWpMcXZjSERo?=
 =?utf-8?B?ek9pdVUrRUl3Sm9mcFA4a0EzWnZsdm1tRzZZOHhjYUpmNk5OT084dVR1Mk9t?=
 =?utf-8?B?T1hnbXdFZk5SeTlsbUdjUzVkZ3dRL05HT3ZFSC8yVHNlZWFRU0g5MjhrVjBh?=
 =?utf-8?B?b2JJSVM5ckY5NjhxaXFIQVhnbHozU3RnZkVxRytTWE9SVldPQkN1anpxWVNX?=
 =?utf-8?B?MzFDenY3ajBEMWlpWlZXMFh0YkxGNG13aERlN0VpaUdLRlJURWM5YkNKU0dN?=
 =?utf-8?B?MUE0NER5eXVZYVo0ZkR3aXA2ejFJYnV0ODdLUU1uQWh5dkw0MjFLZFlZVkpB?=
 =?utf-8?B?eGJBQjR0c1orWUw2a01ZQ3hPM2dWaXZGRHlvK3FXeXlsL1NBdmYyaXVhczZC?=
 =?utf-8?B?ekN1V2tydkczRWRRelpiaXYwd1pSb3hOSnFWRTFZVC82YXVaMVozZEJHOWV5?=
 =?utf-8?B?V1Z2VFZQaTl0aGxvNWFPTEZBWHFaNE1XWnBpeWZQN08rNGk4OHNKa0diUmdF?=
 =?utf-8?B?eFF6WGVTY20yM2g2QXlDbnc4TkFEK3pWck9vSkVaajR1Q1IrMHFxaE93MnE2?=
 =?utf-8?B?L255M2pVWjliZXFhNGRyNXA0NkdlMHJWdHpCR3psYm11WjE2MWRFTldtM0lq?=
 =?utf-8?B?bXhZVWJhekdVdW54dU4xdW5uUVFCWHlvbHpKVnVzcExtazk0UXBnM2pkRTVj?=
 =?utf-8?B?dU5XVS8rWFVUUnppdDN1RFZ0MHdyanBDbXR0NEZzbGE5MnVIMGdPSk9GMHN4?=
 =?utf-8?B?cmNyWURya2o1QWxJTk12N2dmOHFPZ2xYY0tSay9JeC91d3pXQXNWT2dYNTh0?=
 =?utf-8?B?RnJWRy93b2c0bzFsOFFXU1dqSXNxR3pYUWhIWXZKYlFxemVWQlhxTXVYd09C?=
 =?utf-8?B?REhkcDJ0b0xsSDB4NG9GU3NnaG1TTDQ0MDJrdUw2Y3JXRHdreTZIUWhNZWNR?=
 =?utf-8?B?aW9LSElPN3h6d0huYzIwQ2NHN09vNE9xQXhma0UzMkhMQXNkQnVlb2xoYUZ6?=
 =?utf-8?B?QnZXMVkzWmp6eU16b0gyeVgzR2lMbXV4L2dzQUZKcVp1Y2JsVHduY0JiaHdo?=
 =?utf-8?B?YWdwUzN2OXloVXB0NUNNMmpuZnZ5eVR2T2xWbHU0dUJ6eWlRQjlOL3ZoMjdB?=
 =?utf-8?B?aTBYOVdLejltYU9xOVpEbjNlYUZWRC9iUjcxZXRnOWFlY0tCdlBzUjAwRUJs?=
 =?utf-8?B?MFhiMkN0Y253dUg5WnN1aVJIVjg3U01UM215Z0o2Rk5VS0doS3Fjc0NmVWtN?=
 =?utf-8?B?Q3RCTFNwN1VZYVY0QURkTlYxbldqc0dvV2JTWEJWemRxWWkrUjIzNDRXakF2?=
 =?utf-8?B?bEo3QzQ3dlBEaDdUQnFDaDMzRkFEa1ZidnZkcUJVM1NvLzM2NXJoa2lGRURU?=
 =?utf-8?B?cGIvNTROMVBRM1hZaElWSkNrbVA0R00vWDdXQ2dYV29OTldMWkk2Slk4NkJm?=
 =?utf-8?B?SC9PNlM5UUgvRHdzTmo2ajdNQkhnaDNGYWJMSW92TllWREJKdHNUNDBuU1Js?=
 =?utf-8?B?MDRTTURkQWZCaHRCVG0xOVZSclAxRzVMbDFsWlJDeDkwSW5WYXYrUmd3VkNZ?=
 =?utf-8?B?eE5kNGhzRTJYd0xSVGZZQ1lMaFRyUlNVYTdrRlZmVW81b2hoN29YVHdTWEpF?=
 =?utf-8?B?WXkyem9rWncxYXBXRUM1NEZIYkJDZVBmM2NHTFVnUHlTTzFHL0JxUXFDaXdn?=
 =?utf-8?B?Z1RtVGxXSzBYcGMycFF6dDZaN29leHVvSFV4NVZpSjlxcnZJQWQ1VFBZR2Nh?=
 =?utf-8?B?OEhLc21nRUZqampWNmZZaWNnbDkxc3FaTEViOEQ4TUtIK2FSVFdtQVJ3bEJI?=
 =?utf-8?B?WkVySkQwL1JNd0p5bU9wNkJ4TUJZSDFjbjZrMWNEN1dsZkVvZXJQcndSbzRu?=
 =?utf-8?Q?Qln6Q9ytqDyszefJzHgg5Dgoe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d621c55-6958-48e5-fb6f-08dbebf2fbd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 07:08:24.2125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0pQ0nqcnxYH3WgJ18Ssi2Adp2WqjUBohILNyBIeAyA55Oso/ZNqb6poUCH3YisLUsNlpoTyCXDOhCgLEbmdBJLPAQu3ZhGumFprSWrU398s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7603

PiBIaSBGb2xrcywNCj4gDQo+IFNvbWUgdGltZSBhZ28gSSBoYXZlIGFza2VkIGZvciBoZWxwIGZv
ciBtY3AyNTF4ZmQgZHJpdmVyIHdpdGggYW4gSU1YN0QsIHNvIEkNCj4gYW0gc29tZWhvdyBmYW1p
bGFyIHdpdGggdGhlIHN5c3RlbS4NCj4gVGhlIG5leHQgaXRlcmF0aW9uIGlzIHdpdGggYSBOWFAg
TFggMjE2MEEgLi4uIG5ldyBoYXJkd2FyZSBwbGF0Zm9ybSAuLi4gbmV3DQo+IGtlcm5lbCAoNi4x
LjEpIC4uLiBuZXcgcHJvYmxlbXMgOykNCj4gDQo+IFdoYXQgaXMgd29ya2luZyA6IERyaXZlciBp
cyBzdWNjZXNzZnVsbHkgaW5pdGlhbGlzZWQuDQo+IOKdryBzdWRvIG1vZHByb2JlIG1jcDI1MXhm
ZA0KPiBbIDQ0OTMuNTU3MDc1XSBtY3AyNTF4ZmQgc3BpMS4yIGNhbjI6IE1DUDI1MThGRCByZXYw
LjAgKC1SWF9JTlQgLVBMTCAtDQo+IE1BQl9OT19XQVJOICtDUkNfUkVHICtDUkNfUlggK0NSQ19U
WCArRUNDIC1IRCBvOjQwLjAwTUh6DQo+IGM6NDAuMDBNSHogbTo4LjAwTUh6IHJzOjguMDBNSHog
ZXM6MC4wME1IeiByZjo4LjAwTUh6IGVmOjAuMDBNSHopDQo+IHN1Y2Nlc3NmdWxseSBpbml0aWFs
aXplZC4NCj4gDQo+IElmIEkgdXNlIGEgIndyb25nIiBpbnRlcnJ1cHQgZm9yIHRlc3RpbmcgcHVy
cG9zZXMgKGludGVycnVwdCB3b250IGdldCBpdCB0byB0aGUNCj4gZHJpdmVyIGNvZGUpLCBJIGFt
IGFibGUgdG8gc2VuZCBvbmUgQ0FOIE1lc3NhZ2UgZnJvbSBTUEkgQ0FOIHRvIExYMjE2MEENCj4g
aW50ZXJuYWwgQ0FOIChjYW5nZW4vY2FuZHVtcCkuIFRoZW4gdGhlIGRyaXZlciBzdHVjay4NCj4g
VGhpcyBpcyBtb3JlIG9yIGxlc3MgZXhwZWN0ZWQuDQpBZ3JlZQ0KPiBFbmFibGUgdGhlIGludGVy
cnVwdCBvbiB0aGUgcmlnaHQgcGluIChJUlFfTEVWRUxfTE9XKSBkb2VzIG1ha2Ugc29tZQ0KPiB0
cm91YmxlLiBEcml2ZXIgaXMgc3VjY2Vzc2Z1bGx5IGluaXRpYWxpc2VkLiBJZiBJIGJyaW5nIHVw
IHRoZSBpbnRlcmZhY2UgKGlwIGxpbmsgc2V0DQo+IGNhbnggdHlwZSBjYW4gYml0cmF0ZSA1MDAw
MDAgOyBpcCBsaW5rIHNldCBjYW54IHVwKQ0KPiBJIHdpbGwgZ2V0IGNvbnRpbmVvdXMgZXJyb3Jz
Og0KPiANCj4gLg0KPiAuDQo+IC4NCj4gWyAgNTA4LjM1MjYxNl0gbWNwMjUxeGZkIHNwaTEuMiBj
YW4yOiBDUkMgd3JpdGUgZXJyb3IgZGV0ZWN0ZWQuDQo+IENSQz0weDY4NDQuDQo+IFsgIDUwOC4z
NjIwODFdIG1jcDI1MXhmZCBzcGkxLjIgY2FuMjogQ1JDIHdyaXRlIGNvbW1hbmQgZm9ybWF0IGVy
cm9yLg0KPiBbICA1MDguMzY4OTU2XSBtY3AyNTF4ZmQgc3BpMS4yIGNhbjI6IENSQyB3cml0ZSBj
b21tYW5kIGZvcm1hdCBlcnJvci4NCj4gWyAgNTA4LjM3NTI0Ml0gbWNwMjUxeGZkIHNwaTEuMiBj
YW4yOiBDUkMgd3JpdGUgY29tbWFuZCBmb3JtYXQgZXJyb3IuDQo+IFsgIDUwOC4zODE1MzFdIG1j
cDI1MXhmZCBzcGkxLjIgY2FuMjogQ1JDIHdyaXRlIGNvbW1hbmQgZm9ybWF0IGVycm9yLg0KPiBb
ICA1MDguMzg3ODIyXSBtY3AyNTF4ZmQgc3BpMS4yIGNhbjI6IENSQyB3cml0ZSBjb21tYW5kIGZv
cm1hdCBlcnJvci4NCj4gWyAgNTA4LjM5NDExN10gbWNwMjUxeGZkIHNwaTEuMiBjYW4yOiBDUkMg
d3JpdGUgY29tbWFuZCBmb3JtYXQgZXJyb3IuDQo+IFsgIDUwOC40MDA0MDJdIG1jcDI1MXhmZCBz
cGkxLjIgY2FuMjogQ1JDIHdyaXRlIGNvbW1hbmQgZm9ybWF0IGVycm9yLg0KPiBbICA1MDguNDA2
NzAwXSBtY3AyNTF4ZmQgc3BpMS4yIGNhbjI6IENSQyB3cml0ZSBlcnJvciBkZXRlY3RlZC4NCj4g
Q1JDPTB4NTM3Zi4NCj4gLg0KDQpJIGNhbid0IHJlbWVtYmVyIGVuY291bnRlcmluZyB0aGVzZSBm
b3JtYXQgZXJyb3JzIGJlZm9yZS4gRG8geW91IGhhdmUgYWNjZXNzIHRvIGEgbG9naWMgYW5hbHl6
ZXIgYW5kIGNhbiB5b3Ugc3BpIGR1cmluZyBjYXB0dXJlIGluc21vZCArIGludGVyZmFjZSB1cD8N
CkRvIHlvdSBoYXZlIGFueXRoaW5nIGVsc2Ugb24gdGhlIHNhbWUgU1BJPyBXaGVyZSdzIHRoZSA4
IE1IeiBjb21pbmcgZnJvbT8gRGlkIHlvdSBsaW1pdCB0aGlzIGluIHlvdXIgRFQ/DQpZb3UgY291
bGQgdHJ5IHdpdGggLUNSQ19SRUcgLUNSQ19SWCAtQ1JDX1RYIHRvIHNlZSBpZiB5b3UncmUgYWJs
ZSB0byBjb21tdW5pY2F0ZSB3aXRoIHRoZSBkZXZpY2UgKHRoaXMgaXMgbm90IHN1aXRlZCBmb3Ig
YW55dGhpbmcgaW4gcHJvZHVjdGlvbiB0aG91Z2gpDQoNCj4gU2luY2UgZHJpdmVyIHN1Y2Nlc3Nm
dWxseSBpbml0aWFsaXplcywgbm8gQ1JDIHJlYWQgZXJyb3JzIGFuZCBzZW5kaW5nIGEgZnJhbWUg
aXMNCj4gd29ya2luZyBJIGFzc3VtZSBTUEkgaXRzZWxmIGlzIG9rYXkuDQo+IC9wcm9jL2ludGVy
cnVwdCBzaG93cyBvbmx5IG9uZSBhZGRpdG9uYWwgaW50ZXJydXB0IGR1cmluZyBhIGRvd24gLyB1
cCBjeWNsZS4NCj4gVGhpcyBpbmRpY2F0ZXMgdGhhdCB0aGUgaW50ZXJydXB0IGlzIG5ldmVyIGNs
ZWFyZWQgdmlhIFNQSS4NCj4gU2luY2UgdGhlIGVycm9yIGlzIGEgY29tbWFuZCBlcnJvciBhc3N1
bWluZyB0aGUgY29tbWFuZCBpcyB0aGUgb25lIGNsZWFyaW5nDQo+IHRoZSBpbnRlcnJ1cHQsIHRo
YXQgbWFrZXMgc2Vuc2UuDQo+IFdoYXQgY2FuIGJlIHRoZSByZWFzb24gZm9yIHRoZSBjb21tYW5k
IGZvcm1hdCBlcnJvciA/IEFueSBpZGVhcyBob3cgdG8NCj4gaW52ZXN0aWdhdGUgZnVydGhlciA/
DQo+IA0KPiBCUg0KPiBOaWVscw0KPiANCj4gDQpUaG9tYXMNCg0K

