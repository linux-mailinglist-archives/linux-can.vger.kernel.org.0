Return-Path: <linux-can+bounces-5463-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBE2C639F7
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 11:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D61E74E2885
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171DD30AABF;
	Mon, 17 Nov 2025 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="tBOc65gd"
X-Original-To: linux-can@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011069.outbound.protection.outlook.com [40.107.74.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968D273D9F;
	Mon, 17 Nov 2025 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763376647; cv=fail; b=jRQ1fic1fmTeabMHwgbOcQJd9TokH7+qZgHY25R5jAp30TF6pf7u69y6oU1hmfWJmWYt3fyQ5OnZ/CEmZU6WB5nr82wzxxAFFh3XeFuR5OEATbG5nK2mcqZQzow0h52ZTQ1ckSIbFOc4lvVxkvj8jfgvAH3R1sj3e2mZ2yW7kE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763376647; c=relaxed/simple;
	bh=HgbZO1t35YMRLqC3kQxs67A7UOU2d9FOffyxsgRRNSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GWaOn5OrtJ05ngdTG69rr6Es9VWc7vEPtWf+4ofaIiOEqGX62HqZVSD47uLHAKxwu//kahJvornY6c6hM9fQgNU81+eHvKafalN1aqh6CAi2l3nCu1+auqcXpYbf+FlTog0cOzGZPQCv7Pc9NJVwoWhGGN6HmQsBHbuEy+ra8io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=tBOc65gd; arc=fail smtp.client-ip=40.107.74.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLjY37U/5L02OMvLDx3LDI4V+sFxg+ftkPjmOb7LcJh4pqkqi4ELBqgz/Dg49BJb6PXhZ2fx4qDe6+CK7OuBo7+mBp8iLxQ6nMptuXwEoypI/0UTMB+q2JnX3Li5YJZAF9B97ztOe91PeRHIjOJ2MR3YxG1RXAiLwZPFsifRoA+QqwiWMsdnH7EzNMNnZa3Jj01GnfToFpb9dD+xgVibVwUXIdCzS0KgipFZSMZDuuSJT3KfgYr4s5rsD0MiXFhy3LMN+C4QVq6pgWaCsjoQ9vk69rC2xRCw5K9fKNtEZGhymJc7588Mov+pIcpOPgAyBOip6W0rK5DaJWsvyKxdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgbZO1t35YMRLqC3kQxs67A7UOU2d9FOffyxsgRRNSQ=;
 b=rOITkGUQ2lTZbjk3PAsu8fYJKYb7qZ9SQ8V41su6RnCo3NemnBMECGoQCl9TWR91nOpe+iZXKPuEuaijh1s0uOx2+uuVuzx3zxjKpXFAzU0ga57PBOJ0w6H+DcsvaBwJ0chOQLXnapyOHHKwKIHG1vnAfSN+5kplzZao0qmfxJCxGCtEROom2mv9nX88YxzcFVT5Ksy0NmoPvCVpy51y12GQT0F+23fQwHVQDI7Oqad3JRMcmSwBZts7A4EYcENcEsnm+zunxC7uSKd+EdwqMAd/msGm1IJn6J9WVHOIyEX3PiPESVMzZXYxTM2Gi42KdsucmT5F46f48U78HgpR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgbZO1t35YMRLqC3kQxs67A7UOU2d9FOffyxsgRRNSQ=;
 b=tBOc65gdCvVGzdrid6nxumj0IUfcZ0AjvOIKAfqixDtbc783/LdmTBGTEdIpuzoPpndby1dSbPAODvh6l4Nu5EtCPPnN6dRQLtGGC14xjO3+r8DwzoLQa5P2CMarRFdiu5F3Fm7Ot7ztBEiqZzRfxwLeSrJEtantJWOGzSePX08=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB14639.jpnprd01.prod.outlook.com (2603:1096:405:236::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Mon, 17 Nov
 2025 10:50:39 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9343.009; Mon, 17 Nov 2025
 10:50:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol@kernel.org>, magnus.damm <magnus.damm@gmail.com>, Tranh Ha
	<tranh.ha.xb@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] can: rcar_canfd: Fix controller mode setting for RZ/G2L
 SoCs
Thread-Topic: [PATCH] can: rcar_canfd: Fix controller mode setting for RZ/G2L
 SoCs
Thread-Index: AQHcSZVzMv+xB+/yKU6ldKbXUm40nLTuzr2AgAUCCvCAAWEmAIABkFSAgAAFVfA=
Date: Mon, 17 Nov 2025 10:50:38 +0000
Message-ID:
 <TY3PR01MB113466CCD4124417203663E2686C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251030120508.420377-1-biju.das.jz@bp.renesas.com>
 <20251112-warping-ninja-jaybird-22edde-mkl@pengutronix.de>
 <TY3PR01MB11346974232A057A7D5B6EBAD86CBA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134632B48784F5D72721611D86C8A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdVXSaaoOaECmBQmPyWQA7Z30BVBLfVoF-Uz01GfbFZNGw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVXSaaoOaECmBQmPyWQA7Z30BVBLfVoF-Uz01GfbFZNGw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB14639:EE_
x-ms-office365-filtering-correlation-id: f1af8f76-458b-457c-f977-08de25c7256f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?b1FHcWYyOUZXMXpCY2cybm5nTWxJNXRnbU02TCtpVlp1by83Y1k2bnI2R1Za?=
 =?utf-8?B?bFF6UHN3d0F4TGo5dUxlTjZ6TVp2bjd2d25CUEo0THdQaUdwbnpnMVY1V0Rx?=
 =?utf-8?B?cmJkam02RUd5QjYvM0o0YTEzYUR3ZkhlLzR1UHY0Z1pkRitubUJpY2Rsb0tK?=
 =?utf-8?B?aHJuSlJIWXY1R3V3eU5xdWgyd1lnKyt5aVBNY0N0OXZ1NjJ2NGxsZWY5eklk?=
 =?utf-8?B?cUpDcVNsaHg3Qlo0YVkyWGZ2bTJQaEs1OTRJaElEOTZweHM4WVd3cTcyUjhl?=
 =?utf-8?B?RzZxWHdUeHJJbEpmV2FVRzFtK3Y2WmFWU3dKUWRjbGVlNzVTUUV0ak5waFNi?=
 =?utf-8?B?MUZFREhMVzNXSHJVSk9WTTVmTXdCaG94YkJRYjJMOXZQRStreENubEdMOE1o?=
 =?utf-8?B?bGF0RUxVc2NoMG43NVhTY0liUTMzM1BxR1AwMTVaVUpaYzRuWGtyeGZoeXA3?=
 =?utf-8?B?enViZjFnVUdFNDNQZUxLS214MEdnWEVISkRTeGN4OENseURjVzlKVS9FV3di?=
 =?utf-8?B?M0xRVm9GWDNxMmxvWHY4b0YzVlFvMTZFZzZGRmJENUJwSXNhRERnU3E3NjNK?=
 =?utf-8?B?MzlDY1V0TEZVUnVuYmcwam1vS2NIMXdBWmhMcVlIbHdVMGg1U1pzcWRpV21x?=
 =?utf-8?B?MDNBWTJpTi9oK3pqakkzY09EUDlRR0w4M0MxQXdGWG1nczVHdXVUV3Jpbk1i?=
 =?utf-8?B?eUpzWVFybFc3SFhNRzBTc2R3RzBhcGpxbzNVV2xpV2Ivc1l6ZE5YYzRZbjhH?=
 =?utf-8?B?bTNzTUZFcnIvYmVUck1tVXBacWEwdXFVS3RoU2lXWDFWZ000MWlWT05PY1Nk?=
 =?utf-8?B?NUhxVlUwUWVINzVLTmw5eFBBVms0WlBRTG42bS9uNTgwWklTMllLVnZlYUZE?=
 =?utf-8?B?NC96cUtTVk5oaWo4aTMzQ1BONVJjYmR4bk80NHUvYjJPRStNVERObkFqU1Vi?=
 =?utf-8?B?anV2MUJFbGxhTUxqL1VtclI2bW9QRFVkdVFzV3ZhSkowVUJvenh4VjJVQUtr?=
 =?utf-8?B?MUdQUVk5L2twM1BIY0ZzdDlHYzgvR2dXT2k1emlWRDN2dGIvN2poeC8xRG1w?=
 =?utf-8?B?T3VGNU5yUE05clR2RWNnbDd0TEZaV3BPazVBYTd1eEUzVHZUSFFHaVVSL3BM?=
 =?utf-8?B?aW1vd0EwZG5rMTd1M3dTNmJ4SXF5ekxZUjdERFAxUkRVOWhtelZHaFZGZlFR?=
 =?utf-8?B?WloxRWtIRXdrb0pxbklaTWxjODJaOHlYblMwWlRaUXBoTy94NDNaT3A5bUJU?=
 =?utf-8?B?VHE1aW5YOXc0ZTNrOVhFdmNzbDhPVGNhUUxDeUpIZjgrVCs1UlUydk92TUtC?=
 =?utf-8?B?RGR3K1FwanE4c3gzQmYrTHpDWmJYbHAzT1Bjb1lJMk5QUEZiamkxc2ZXbGhC?=
 =?utf-8?B?VFlMVW95ejdyOFRTZEZJK2MyWFh6eWtJcy84aURTaDhFUHh4VVdaTm5DajF6?=
 =?utf-8?B?S3dBa1dwTktKKzdUblV0VnVzT3haYyt1WXJ0OWc3c1VkYlNMczhDcDB2MlNK?=
 =?utf-8?B?M3REU0VZTWhWdENoWkVMbWUxcDg3TG1WV3BZOGZtVG9BSm5ZNXBvSnR5Y2tq?=
 =?utf-8?B?NmsyL0hqVEpZdXRMb01kZXVoV1luOUNVa250Z0xhOXkxdStrU3QzaWpvWlU0?=
 =?utf-8?B?R0VQcHJ6SDRXMGhsZEhHdXZzZ0V5aFFqT3p3cFdtSDFuK1hUckRnQWRsblNs?=
 =?utf-8?B?dWx1c01mN0lTMVFTbGl2V3hvSUw2U1BERjlnVGVxKzBvV2FQRSt1c3dNMk45?=
 =?utf-8?B?YWhLc3hrN3M3YTh6RDdKaVJIY2FIT2dLQUpVVVNacDBGNUp0dmoySVovcTRF?=
 =?utf-8?B?ZElJN05yd01adW5CcVM0TXRUcmxNU215aDVXMjdIU0ZFV0Vqc0RDbHlOdDd6?=
 =?utf-8?B?dmlydEtQcVNzNnRZWG9uS285aS9UbFphWlowOGd1SU9hR0pzMnBNb1BMTjh0?=
 =?utf-8?B?WjZqdlEwTEhMK0M1SyswaGNGZTB2OVpUL3ladXB4VHhTVjVKeXZwaURMTEtK?=
 =?utf-8?B?dFVoUDFWMFZRemlpT0UyVDdMUzhpeTVEbWZHS296MElmM09rMXZPa09iZ0FM?=
 =?utf-8?Q?2rnT/J?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KzNxZklDbElWOHlRb25WR1lMNm55K1ZTY29hdEZxeENqVU9sYkYxbnhmektQ?=
 =?utf-8?B?cHBhUEMwaURaR0N6Y0Y1eHQrNG1OMDB0WDlkdFo5WFgzNW1JeCtLWm1uNEpZ?=
 =?utf-8?B?UW5GbHA4RWdIYWFTYmlncS8xUndrUFp4Q2dkSndkVjdQVlRxbkxVNSsyaVpa?=
 =?utf-8?B?ZGNraE5NcTV6cWpLMm96YURydGxnTkdTWTRuSGFsWW5GRHFDUldlV0VPMERN?=
 =?utf-8?B?MGRXTjJrZ2wrL2xYLzA2ZnNzazdyOWdmeEJxeVBRVTVTOEwxalFYdnVWdXV1?=
 =?utf-8?B?MDNYWHhjVVh1TFpPTE9oalBJQ2d3U2VKRmVTMGF4M2hZQ3ZCNkVKUnVZL01i?=
 =?utf-8?B?aEZVQi9RVkxyck40TE5qVkNQZWhiZGhWZTI1U0ExNmpPVE5mM2REVmxaZ2dq?=
 =?utf-8?B?Q2lINTFVeTdicjQrbnJxSVNXL1ZwWUt1QzhlRW8wR0x3VkR2aysyc2NwTG9q?=
 =?utf-8?B?VE1pcE5GLzdrcitXdjd2VlVETy9Md3FSZi92Y3FCemJSYkpIdFUrWElLdStY?=
 =?utf-8?B?QWdDWWc3QzI1UDZYQzR5a1N4V3NKOVdOWEsvcWIyS3Bsb09rbG91bm82UTlD?=
 =?utf-8?B?Mk8yVHZ6SVhBL0lkNlpZditqOEVicDkrS09ORkxVVU0yWWNDbUZpVHBRc1NE?=
 =?utf-8?B?b2k2N2E2Mk4wU0dGQzRWWU5YWkFTZjN6Z2U1RnlUdTJSbFhjbjJZNnFwYlB0?=
 =?utf-8?B?NW1zdFMwQU1oU2ZxMW90YmtmWEs5VmFlQUdHNDEvYzB2bDQ2YXliMDJ0d1Ni?=
 =?utf-8?B?QWM0UVo1RnlBT0oxU3AvU1pmWnRhNWVQZWdHbXhjYlh2SEM1V3pEUkNmRDhX?=
 =?utf-8?B?bEhDQkpCdUFRRy9MRzY1SEcwcG43TlVyYVErVmpCUGlQK2NNcitLQ3d4SW05?=
 =?utf-8?B?YlJJcnJNYngrVm1hY0tMZ09TSFhxNk9sT3hQRytQMGdXaVdaOVhST3RXM2I3?=
 =?utf-8?B?UXYyTFZTQzVBekQvVmNPZ25XRmd4OXpsKzZlM0xLV3REcTE2RU1jUWVWYmVM?=
 =?utf-8?B?SlY1Z2ZJOVF5ZExjTVpFK0UzcW85ZmoxRWZUS1o0bGtRZGtnZ0NlMENkOVlr?=
 =?utf-8?B?VXp0RWR1RGhSVE5SQ1crNFU1d1IwZlVNU2Zsc0UrOEhuOVlvOWdETmdQZW03?=
 =?utf-8?B?Nm5mYkRrb0RITWZkYkZ5MHRXT0tKRlkrNkpQaXdYbmNqZTVhWGM3b2hlQ1BF?=
 =?utf-8?B?WEtzWlZnTVlsQ2wrVnVsZmRIYTNJZTRaaFgyTmlyS3ozdmJKWmhQajI3L0dY?=
 =?utf-8?B?azJqRjUrZy9HNW9JVUNhNmpOT096WDlpaW5IbVpyaUcyTm8yclNhU1FmY2hq?=
 =?utf-8?B?TFdrNmtXd0pWV1hkd0NFYXY2REpOcFJnOHVBNG9SOEJIK2pDakM1RFJBZFRD?=
 =?utf-8?B?ZFlHZGEzclRrNHY4Q3pIZlAwUklOSWtoQXNOaU9IYkI4LzZ5dHJjdExhUmlk?=
 =?utf-8?B?eUlnS1B6UXVkTkJKamFRd3N0cTFKWFliUmhHbzI2cXR0M3hHQUhGam9pMHhE?=
 =?utf-8?B?NUZ5VXdId3lzb1UzWnkrR21GN01TOEFENkMwT3hJcldMOS9LM0hBSGUzMVhx?=
 =?utf-8?B?Tk1ZNEdyUXpJb0VuMUtqKzRXMEhXbTRscDlhWXhJM01BQVZPaDJmbTMzaGgv?=
 =?utf-8?B?TkR2b1V2ZWFBcXpWa05oZGlLdjVFM2JQKzdwa0plWktBU3h1VUV1S2h0UHFP?=
 =?utf-8?B?M3lYZGoyUWVkSGFqQi9ucnVyeTB0N2Jha3FaZkl0T3hxUWRkRHpKaHRwR0ZY?=
 =?utf-8?B?NWFCaHJxS3dIZVI2aW9YVFNLZ0J1RGdIVDBTVnVpV3k2OFRiNDA5bTM4YjVO?=
 =?utf-8?B?elk1bWc3MENMaldaeExGS0JGZzhCM2h5QUFxUU5BSS9uSVQ4TGFUQ0s5RmNF?=
 =?utf-8?B?OWpqd2VmbDViQ1VoS2JsUHppZzVxWHVMSDFYNGIrdUpDck9GV29QUHNKbFRt?=
 =?utf-8?B?a0E5WWM4MHg0K2gvY1ZTWjIyVGttelhPU0tHQ1RnaitkVmpqTTF4R1BTQzY4?=
 =?utf-8?B?ZE5sS2pzZnhoSEJOdjZaam9zYXh0Vk9nYVBCckkzNHhaWk9uUFBDZ25DNThN?=
 =?utf-8?B?Wkt6WVh1by96NG81QkYyVURqUlI1SFA1NFBUU0NOc2h2dmNzS3NEb09LMDcv?=
 =?utf-8?B?Wk02NGw2dGl0QmZqZ3JsWVdsSEpkblFIS2tuUDB0eXRuWklwRG9wZ2YwT0pF?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1af8f76-458b-457c-f977-08de25c7256f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 10:50:38.9921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u5N+cw6IRMdAojN6OWnnrs4DXz4Wgp6CvY3pQmru6UmW//AcdtDvZrdpka4Gi0Q7UfBRARNIn/sYCE9p+fPLS5HuzG2VwZYuCAKWnLbPT9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14639

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4
ay5vcmc+DQo+IFNlbnQ6IDE3IE5vdmVtYmVyIDIwMjUgMTA6MTMNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gY2FuOiByY2FyX2NhbmZkOiBGaXggY29udHJvbGxlciBtb2RlIHNldHRpbmcgZm9yIFJa
L0cyTCBTb0NzDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gU3VuLCAxNiBOb3YgMjAyNSBhdCAx
MTozMSwgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiA+
IEZyb206IEJpanUgRGFzDQo+ID4gPiA+IFNlbnQ6IDEyIE5vdmVtYmVyIDIwMjUgMDg6NDcNCj4g
PiA+ID4gT24gMzAuMTAuMjAyNSAxMjowNTowNCwgQmlqdSB3cm90ZToNCj4gPiA+ID4gPiBUaGUg
Y29tbWl0IDVjZmYyNjM2MDZhMSAoImNhbjogcmNhcl9jYW5mZDogRml4IGNvbnRyb2xsZXIgbW9k
ZQ0KPiA+ID4gPiA+IHNldHRpbmciKSBhcHBsaWVzIHRvIGFsbCBTb0NzIGV4Y2VwdCB0aGUgUlov
RzJMIGZhbWlseSBvZiBTb0NzLg0KPiA+ID4gPiA+IEFzIHBlciBSWi9HMkwgaGFyZHdhcmUgbWFu
dWFsICJGaWd1cmUgMjguMTYgQ0FOIFNldHRpbmcNCj4gPiA+ID4gPiBQcm9jZWR1cmUgYWZ0ZXIg
dGhlIE1DVSBpcyBSZXNldCIgQ0FOIG1vZGUgbmVlZHMgdG8gYmUgc2V0DQo+ID4gPiA+ID4gYmVm
b3JlIGNoYW5uZWwgcmVzZXQuIEFkZCB0aGUgbW9kZV9iZWZvcmVfY2hfcnN0IHZhcmlhYmxlIHRv
DQo+ID4gPiA+ID4gc3RydWN0IHJjYXJfY2FuZmRfaHdfaW5mbyB0byBoYW5kbGUgdGhpcyBkaWZm
ZXJlbmNlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIGFib3ZlIGNvbW1pdCBhbHNvIGJyZWFr
cyBDQU5GRCBmdW5jdGlvbmFsaXR5IG9uIFJaL0czRS4NCj4gPiA+ID4gPiBBZGFwdCB0aGlzIGNo
YW5nZSB0byBSWi9HM0UsIGFzIHdlbGwgYXMgaXQgd29ya3Mgb2sgYnkgZm9sbG93aW5nDQo+ID4g
PiA+ID4gdGhlIGluaXRpYWxpc2F0aW9uIHNlcXVlbmNlIG9mIFJaL0cyTC4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IEZpeGVzOiA1Y2ZmMjYzNjA2YTEgKCJjYW46IHJjYXJfY2FuZmQ6IEZpeCBjb250
cm9sbGVyIG1vZGUNCj4gPiA+ID4gPiBzZXR0aW5nIikNCj4gPiA+ID4gPiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRh
cy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gQXBwbGllZCB0byBsaW51eC1j
YW4uDQo+ID4gPg0KPiA+ID4gVGhlcmUgYXJlIDMgbW9kZXMgZm9yIENBTkZEIG9uIFJaL0czRQ0K
PiA+ID4NCj4gPiA+IDEpIENBTi1GRCBtb2RlDQo+ID4gPiAyKSBGRCBvbmx5IG1vZGUNCj4gPiA+
IDMpIENsYXNzaWNhbCBDQU4gb25seSBtb2RlDQo+ID4gPg0KPiA+ID4gSW4gdGhlICJGRCBvbmx5
IG1vZGUiLCB0aGUgRkRPRSBiaXQgZW5hYmxlcyB0aGUgcmVjZXB0aW9uIGFuZCB0cmFuc21pc3Np
b24gb2YgQ0FOLUZELW9ubHkgZnJhbWVzLg0KPiA+ID4gSWYgZW5hYmxlZCwgY29tbXVuaWNhdGlv
biBpbiB0aGUgQ2xhc3NpY2FsIENBTiBmcmFtZSBmb3JtYXQgaXMgZGlzYWJsZWQuDQo+ID4gPg0K
PiA+ID4gT24gUlovRzJMLCBjdXJyZW50bHksIENBTi1GRCBtb2RlIGlzIGVuYWJsZWQgYnkgZGVm
YXVsdCBhbmQgT24NCj4gPiA+IFJaL0czRSBhbmQgUi1DYXIgR2VuNCwgY3VycmVudGx5IEZELSBv
bmx5IG1vZGUgaXMgdGhlIGRlZmF1bHQuDQo+ID4gPg0KPiA+ID4gUHJpb3IgdG8gY29tbWl0IDVj
ZmYyNjM2MDZhMTAxMCAoImNhbjogcmNhcl9jYW5mZDogRml4IGNvbnRyb2xsZXINCj4gPiA+IG1v
ZGUgc2V0dGluZykgUlovRzNFIGFuZCBSLUNhciBHZW40IGFyZSB1c2luZyBpbmNvcnJlY3QgY29k
ZSBmb3INCj4gPiA+IHNldHRpbmcgQ0FOLUZEIG1vZGUuIEJ1dCBmb3J0dW5hdGVseSwgaXQgc2V0
cyB0aGUgbW9kZSBhcyBDQU4tRkQNCj4gPiA+IG5vZGUsIGFzIHRoZSBjaGFubmVsIHJlc2V0IHdh
cyBleGVjdXRlZCBhZnRlciBzZXR0aW5nIHRoZSBtb2RlLCB0aGF0DQo+ID4gPiByZXNldHMgdGhl
IHJlZ2lzdGVycyB0byBDQU4tRkQgbW9kZS4oR2xvYmFsIHJlc2V0LCBzZXQgbW9kZSwgY2hhbm5l
bA0KPiA+ID4gcmVzZXQpDQo+ID4gPg0KPiA+ID4gVGhlIGNvbW1pdCA1Y2ZmMjYzNjA2YTEwMTAg
bWFrZXMgKEdsb2JhbCByZXNldCwgY2hhbm5lbCByZXNldCwgc2V0DQo+ID4gPiBtb2RlKSwgbm93
IGFsaWduIHdpdGggdGhlIGZsb3cgbWVudGlvbmVkIGluIHRoZSBoYXJkd2FyZSBtYW51YWwgZm9y
IGFsbCBTb0NzIGV4Y2VwdCBSWi9HMkwuDQo+ID4gPiBCdXQgYmVjYXVzZSBvZiB0aGUgZWFybGll
ciB3cm9uZyBjb2RlLCBpdCBzZXRzIHRvIEZELW9ubHkgbW9kZSBpbnN0ZWFkIG9mIENBTi1GRCBt
b2RlLg0KPiA+ID4NCj4gPiA+IElzIGl0IG9rYXkgdG8gZHJvcCB0aGlzIHBhdGNoIHNvIEkgY2Fu
IHNlbmQgYW5vdGhlciBwYXRjaCB0byBtYWtlDQo+ID4gPiBDQU4tRkQgbW9kZSBhcyB0aGUgZGVm
YXVsdCBmb3IgUlovRzNFIGFuZCBSLUNhciBHZW40Pw0KPiA+ID4NCj4gPiA+IEFzIGFuIGVuaGFu
Y2VtZW50LCB3ZSBuZWVkIHRvIGRlZmluZSBhIGRldmljZSB0cmVlIHByb3BlcnR5IHRvDQo+ID4g
PiBzdXBwb3J0IEZELW9ubHkgbW9kZSBmb3IgUlovRzJMLCBSWi9HM0UgYW5kIFItQ2FyIEdlbjQu
IFBsZWFzZSBzaGFyZSB5b3VyIHRob3VnaHRzIG9uIHRoaXMuDQo+IA0KPiBIbW0sIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL3JlbmVzYXMscmNhci1jYW5mZC55YW1s
Og0KPiANCj4gICByZW5lc2FzLG5vLWNhbi1mZDoNCj4gICAgICRyZWY6IC9zY2hlbWFzL3R5cGVz
LnlhbWwjL2RlZmluaXRpb25zL2ZsYWcNCj4gICAgIGRlc2NyaXB0aW9uOg0KPiAgICAgICBUaGUg
Y29udHJvbGxlciBjYW4gb3BlcmF0ZSBpbiBlaXRoZXIgQ0FOIEZEIG9ubHkgbW9kZSAoZGVmYXVs
dCkgb3INCj4gICAgICAgQ2xhc3NpY2FsIENBTiBvbmx5IG1vZGUuICBUaGUgbW9kZSBpcyBnbG9i
YWwgdG8gYWxsIGNoYW5uZWxzLg0KPiAgICAgICBTcGVjaWZ5IHRoaXMgcHJvcGVydHkgdG8gcHV0
IHRoZSBjb250cm9sbGVyIGluIENsYXNzaWNhbCBDQU4gb25seSBtb2RlLg0KDQpNYXliZSB3ZSBu
ZWVkIHRvIHJlbW92ZSB0aGUgIm9ubHkiIHdvcmQgZnJvbSBiaW5kaW5ncyB0byBhdm9pZCBjb25m
dXNpb24uDQpUaGlzIGlzIGNvbWluZyBmcm9tIFItQ2FyIEdlbjMsIHdoaWNoIGhhcyAyIG1vZGVz
LiBBcyBwZXIgdGhlIGJpdCBkZWZpbml0aW9uDQpvZiBSQ01DDQoNCjA6IENsYXNzaWNhbCBDQU4g
bW9kZQ0KMTogQ0FOIEZEIG1vZGUNCg0KwqANCkFzIHBlciA0OC4xLjIgSW50ZXJmYWNlIE1vZGUg
b2QgUlovRzJ7SCxNLE4sRX0gbWFudWFsDQpSUy1DQU5GRCBoYXMgdGhlIGZvbGxvd2luZyB0d28g
aW50ZXJmYWNlIG1vZGVzLg0KDQrigKIgQ2xhc3NpY2FsIENBTiBtb2RlOiBPbmx5IGNsYXNzaWNh
bCBDQU4gZnJhbWVzIGFyZSBoYW5kbGVkLg0K4oCiIENBTiBGRCBtb2RlOiBib3RoIHRoZSBjbGFz
c2ljYWwgQ0FOIGZyYW1lcyBhbmQgQ0FOIEZEIGZyYW1lcyBhcmUgaGFuZGxlZC4NCg0KwqANCkJ1
dCBSWi9HMkwsIFJaL0czRSBhbmQgUi1DYXIgR2VuNCwgaGFzIGFkZGl0aW9uYWwgbW9kZSBjYWxs
ZWQgRkQtb25seSBtb2RlDQpmb3IgQ0FOLUZELiBJbiB0aGlzIG1vZGUsIHJ4L3R4IHRyYW5zZmVy
IHVzaW5nIHRoZSBjYW5mZHRlc3QgdG9vbCB3b24ndCB3b3JrLg0KQnV0IGNhbnNlbmQvY2FuZHVt
cCB3b3Jrc1sxXS4NCg0KDQpUbyBzdW1tYXJpc2UsIHdlIG5lZWQgdGhlIGZvbGxvd2luZyBzZXR0
aW5nIGluIHJjYXJfY2FuZmRfcmVzZXRfY29udHJvbGxlcigpOg0KDQpSLUNhciBHZW4zIGFuZCBS
Wi9HMkw6IE9uIEdsb2JhbCByZXNldCBtb2RlIHNldCBSQ01DIGZvciBDQU4tRkQgb3IgQ2xhc3Np
Y2FsIENBTg0KUlovRzJMOiBPbiBjaGFubmVsIHJlc2V0IG1vZGUsIHNldCBGRC1vbmx5IG1vZGUg
b3IgQ0FOLUZEIG1vZGUuDQpSWi9HM0UgYW5kIFItQ2FyIEdlbjQ6IE9uIGNoYW5uZWwgcmVzZXQg
bW9kZSwgc2V0IENBTi1GRCBtb2RlIG9yIEZELW9ubHkgbW9kZSBvciBDbGFzc2ljYWwgQ0FOIG1v
ZGUNCg0KSSB0aGluayB0aGVyZSB3aWxsIGJlIDIgcGF0Y2hlczoNCjEpIEZpeGVzIHBhdGNoZXMg
dG8gc2V0IENBTi1GRCBtb2RlIGFzIHRoZSBkZWZhdWx0IGZvciBhbGwgU29DcyANCjIpIEJpbmRp
bmcgKyBEcml2ZXIgY2hhbmdlcyBmb3Igc3VwcG9ydGluZyBGRC1Pbmx5IG1vZGUgZm9yIFJaL0cy
TCwgUi9HM0UgYW5kIFItQ2FyIEdlbjQuDQoNClsxXQ0Kcm9vdEBzbWFyYy1yemczZTp+IyBjYW5k
dW1wIGNhbjEgJg0KWzFdIDM5OQ0Kcm9vdEBzbWFyYy1yemczZTp+IyBbIMKgMjMyLjY5ODcyM10g
Y2FuOiBjb250cm9sbGVyIGFyZWEgbmV0d29yayBjb3JlDQpbIMKgMjMyLjcwMzIwMl0gTkVUOiBS
ZWdpc3RlcmVkIFBGX0NBTiBwcm90b2NvbCBmYW1pbHkNClsgwqAyMzIuNzcwMDc1XSBjYW46IHJh
dyBwcm90b2NvbA0Kcm9vdEBzbWFyYy1yemczZTp+IyBjYW5zZW5kIGNhbjAgMTIzIyMwLjAwMTEy
MjMzNDQ1NTY2NzcNCsKgIGNhbjEgwqAxMjMgwqBbMDhdIMKgMDAgMTEgMjIgMzMgNDQgNTUgNjYg
NzcNCnJvb3RAc21hcmMtcnpnM2U6fiMNCg0KUGxlYXNlIHNoYXJlIHlvdXIgdGhvdWdodHMuDQoN
CkNoZWVycywNCkJpanUNCg==

