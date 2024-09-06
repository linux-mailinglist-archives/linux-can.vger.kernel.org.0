Return-Path: <linux-can+bounces-1429-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A97596FE4C
	for <lists+linux-can@lfdr.de>; Sat,  7 Sep 2024 01:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C181C21511
	for <lists+linux-can@lfdr.de>; Fri,  6 Sep 2024 23:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797B415A873;
	Fri,  6 Sep 2024 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teledyne.com header.i=@teledyne.com header.b="ZrC2EhIO"
X-Original-To: linux-can@vger.kernel.org
Received: from us1mail01.teledyne.com (us1mail01.teledyne.com [140.165.202.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947F1B85DC;
	Fri,  6 Sep 2024 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.165.202.241
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725663795; cv=fail; b=pbhxpY6sKta33S/7rlceKhHBwHwwN+Zi4SY9a4FlSTK1tTenAVSJSLsDW/hy+2FSG21+YSLitMqyqFetJ8UyKQ57xo7vtPnVQFPIFqGILpfbgMSALfz4NlM+xfmyCQR4dU+3N+tGfIF4SLqlVQ4wQSrc8dTq9BebkelQE6dOPew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725663795; c=relaxed/simple;
	bh=eCEs9BciXtdLgDG31dXVT/Iv7BRjYtnEloBHBdLG/WY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ci5YaJwkvpy+IRfR2YQ0DuqE7nkF2BDRGP7EDKJyQxMLhke2I3v7DW97sO9nZCxTGDGx64gcZNpghFyzobrTeK2UiVzlLdJPgNnoE796x9LnJWQWtFRL8IezQJ2bxvLhLzflkHY3awOmbOIY9q1FMR3kpkey/5yoogEI/56v/is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Teledyne.com; spf=pass smtp.mailfrom=teledyne.com; dkim=pass (2048-bit key) header.d=teledyne.com header.i=@teledyne.com header.b=ZrC2EhIO; arc=fail smtp.client-ip=140.165.202.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Teledyne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=teledyne.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=teledyne.com; i=@teledyne.com; q=dns/txt; s=TDY-2;
  t=1725663793; x=1757199793;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=eCEs9BciXtdLgDG31dXVT/Iv7BRjYtnEloBHBdLG/WY=;
  b=ZrC2EhIO6K7Q7nh6WPHmj8TW4lMGZCr0jlvub7QT0o+tvZYikcU1/ig8
   hk/JlPerSiTd4BA/CUKpF6mPWAIlbqP/y1mySqSPF5rrs3z4dCesrBOv/
   J/mb0MF6Dcdoh0LkW9N/CTMrNqtgYf2888RyiamrJnbB/5kpT/i3zUFiT
   i0t0DRw2bQs0KS3FjtZJNZv1RLskDC+p7jAeDrN1XCNTA87+5Q0Pt3BeH
   Nn+Y2sLzOy+5/9KsdrLuQ5C77SYYuHtd0tMwtHJlwnL68Zl2B8jPDvyXp
   ylm55+c8GG0MX8E8c0BpokOJPZx+Ob9zT98Mh7+2bLRePRnnDUx3xNGa+
   Q==;
X-CSE-ConnectionGUID: Eyl6SLQRT2Gr340P56CqpA==
X-CSE-MsgGUID: U66VPTW/RFqvz7x6GcqGJg==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:SiT/Cq7zEsZqKJxsSubNGgxRtCvGchMFZxGqfqrLsTDasY5as4F+v
 jMWWW7UbqvYZGXyLtgkOt+0px8FuJHVz9dnTAJr/yA3Eysa+MHIO4ilIxarNUt+DOWaFBg7t
 51GMrEsD+htFiWA/k/1atANiVEmiMlkk5KlULas1hhZHFIiFWF4z0o+xobVu6Yw6fChGQSBp
 NjulMPWPV6hylZcP3kdg065gEoHUM/a5nVB5jTSWdgR5AWCzyhNUspETU2MByCQrrd8T7fSq
 9nrnOnRElPxp38FFt6jm7DnRUwGKpa6FRSOkHdfR5+5iRFEoCEouo5jXBbLQR4K49kht4kZJ
 ORl7fRcey9wVkH/sL11vy1jLs1LFfEuFIkrg5SImZf7I0XuKxMAyhj1Za08FdVwFu1fWAmi+
 RGEQdykg9/qa++emdqGpudQassLAdjvYrg7g0tclx7DVqp+ec2daLzSzIoNtNswrpgm8ff2W
 vFALARXSS/vJjhlCg9OTo4yjaG0i33yfyxepRSeoq9fD2r7lVApluGzbZyPJoHMHp09ckWw/
 woq+0zbCxIXcvyWzDCU2m6hguLDjCX2HokVEdVU89Yz0QfJlzxDUkd+uV2TnKfntHaCZJVlB
 VUK6HU+84c57WOJQYyoN/G/iDve1vIGYPJUEusn+ESGw6z8/QmUHC4HQyRHZdhgs9U5LRQu1
 1mUj5bqCCZpvbm9V32Q7PGXoCm0NCxTKnUNDRLoViMY+ICmvpk2lR2KS9xzSPfzktHkXy39x
 z2GvS4zwb4UiKbnypmGwLwOuBr0zrChc+L/zly/sr6Nhu+hWLOYWg==
IronPort-HdrOrdr: A9a23:LYKOBq68N7jK+jsQ1APXwUCBI+orL9Y04lQ7vn2ZFiY7TiXIra
 yTdaoguCMc0AxhIU3I6urwQJVoJkmsvaKdgLNhdItKMzOW31dAQLsD0WKA+UyqJ8SdzJ866U
 4IScEXY7efbGSS5fyKpTVQeOxQouVvhZrY4ds2uE0dKD2CBZsQjDtRO0K+KAlbVQNGDZ02GN
 63/cxcvQetfnwRc4CSGmQFd/KrnayAqLvWJTo9QzI34giHij2lrJTgFQKD4xsYWzRThZ8/7G
 n+lRDj7KnLiYD39vac7R6e031loqqu9jJxPr3MtiHTEESttu+cXvUvZ1RFhkF3nAjg0idprD
 CGmWZaAy060QKqQojym2qo5+Co6kdT11byjVCfmnftusr/WXYzDNdAn5tQdl/D51Mnp8wU6t
 M+44u1jeskMfr7plWJ2/HYExVx0kakq3srluAey3RZTIsFcbdU6YgS5llcHpsMFD/zrNlPKp
 gZMOjMoPJNNV+KZXHQuWdihNSqQ3QoBx+DBkwPoNac3TRalG1wi0EY2MsclHEd849Vcegy28
 3UdqBz0L1eRM4faqxwQO8HXMusE2TIBQnBNWqDSG6XZ53v+0i926IfzI9Fld1CIqZ4s6fasK
 6xLm+xAgQJCj/TNfE=
X-Talos-CUID: 9a23:5NFLWWAKB0F1dW36EwR28BAvPvkfTify1iyMe3flV01wUJTAHA==
X-Talos-MUID: 9a23:BP8/NwnsXPOzaGz9pePDdnpfaplW25iRT3ojiIsU5NnaGidpFBWS2WE=
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="192298822"
Received: from us1-vpmsg-mbx01.tdy.teledyne.com ([140.165.245.30])
  by us1mail01.tdy.teledyne.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 16:02:04 -0700
Received: from US1-VPMSG-MBX01.TDY.Teledyne.com (140.165.245.30) by
 US1-VPMSG-MBX01.TDY.Teledyne.com (140.165.245.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Sep 2024 18:02:03 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (140.165.200.224)
 by US1-VPMSG-MBX01.TDY.Teledyne.com (140.165.245.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Sep 2024 18:02:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q27tCG17jg9NspBtWqF6/v2/3Jw8yAto81sWlfaGgPY3zQE8REgYKtJldxS5EMbvQipSXZxChbrqZESkv16Qetb71Vhg1RWGgpeKGeowHfxRw/HrNFSaa4aFWD5UwTHS86kVhDZCouXcVdS1MNZqjdC7B/zxYDCaDAMszE5U5AQy3p7P7R/EtBrAramifKAR2NJ1Wvcgb0ypALH/l+0E3S/nIE1THYrOXY3xIvdw9e/sj6b0gEAEAs3NRaQMKQeUaM0CX6B0rNwm6QU4+TPq76hRx4e9BxMXEIihLhfJlVRGvveVLofuKIShcd74M/0OAMdNNmVdwn+IZ9Sa8xpShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCEs9BciXtdLgDG31dXVT/Iv7BRjYtnEloBHBdLG/WY=;
 b=tz62D0joSuiQ9eXqyTO2C7ivcc2sxX82UOOTZLYRLOnFfg8kbZolMunsSSV4JImzXuEZVVDSlKeKGXv1F23doA7Agv2u01VeRwHDASPbdseW2IP6owpBSqR/cNwsf6viBoET4jlpVlLxRPoICacMosfFJdcrE52U9eJ0K0lcZhYWt/S4kSjAyX2/Et+XdC/19No/DL9vUNf/xOhOaDfTLNJtERUDXckPe8JjoKxInhusAxN/7Lzc99HT5/6uUOS++4njpp9rXqpU0A1Beok+82ie0kxhfVZzojJ8MVP0bSrbKJwF8pFrgyH0sfK5khvtef/6HnZox6v5LDBVbN5j9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teledyne.com; dmarc=pass action=none header.from=teledyne.com;
 dkim=pass header.d=teledyne.com; arc=none
Received: from DM8PR14MB5221.namprd14.prod.outlook.com (2603:10b6:8:28::14) by
 SN7PR14MB6540.namprd14.prod.outlook.com (2603:10b6:806:32a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Fri, 6 Sep 2024 23:02:00 +0000
Received: from DM8PR14MB5221.namprd14.prod.outlook.com
 ([fe80::608e:ffbc:5b4d:d1b2]) by DM8PR14MB5221.namprd14.prod.outlook.com
 ([fe80::608e:ffbc:5b4d:d1b2%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 23:02:00 +0000
From: "Hamby, Jake (US)" <Jake.Hamby@Teledyne.com>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] can: m_can: Enable NAPI before enabling interrupts
Thread-Topic: [PATCH] can: m_can: Enable NAPI before enabling interrupts
Thread-Index: AdsAsKe0i5KaguxcTDmRS4oD4ICOiw==
Date: Fri, 6 Sep 2024 23:02:00 +0000
Message-ID: <DM8PR14MB5221D8AA9BDB9719C94507ECEF9E2@DM8PR14MB5221.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-titus-metadata-40: =?utf-8?B?ZXlKRFlYUmxaMjl5ZVV4aFltVnNjeUk2SWlJc0lrMWxkR0ZrWVhSaElqcDdJ?=
 =?utf-8?B?bTV6SWpvaWFIUjBjRHBjTDF3dmQzZDNMblJwZEhWekxtTnZiVnd2Ym5OY0ww?=
 =?utf-8?B?Wk1TVklpTENKcFpDSTZJakF3TTJNeVlqUXpMV0U1TWpJdE5HVmlZaTFoWVRK?=
 =?utf-8?B?bUxUVTFNR1F4Wm1aa1kySXlOQ0lzSW5CeWIzQnpJanBiZXlKdUlqb2lSVU5K?=
 =?utf-8?B?UkdGMFlTSXNJblpoYkhNaU9sdDdJblpoYkhWbElqb2lUazl2Y2tWQlVqazVJ?=
 =?utf-8?B?bjFkZlN4N0ltNGlPaUpGUTBsS2RYSnBjeUlzSW5aaGJITWlPbHRkZlN4N0lt?=
 =?utf-8?B?NGlPaUpGUTBsSlZFRlNRMnhoYzNNaUxDSjJZV3h6SWpwYlhYMHNleUp1SWpv?=
 =?utf-8?B?aVJVTkpSVUZTUTJ4aGMzTWlMQ0oyWVd4eklqcGJYWDBzZXlKdUlqb2libTl1?=
 =?utf-8?B?VlZORGIzVnVkSEo1SWl3aWRtRnNjeUk2VzExOUxIc2liaUk2SW01dmJsVlRS?=
 =?utf-8?B?VU5KU25WeWFYTWlMQ0oyWVd4eklqcGJYWDBzZXlKdUlqb2lWVzV5WlhORGIy?=
 =?utf-8?B?MXdSWGgwSWl3aWRtRnNjeUk2VzNzaWRtRnNkV1VpT2lKWlJWTWlmVjE5TEhz?=
 =?utf-8?B?aWJpSTZJa052YlhCVFpXNXpJaXdpZG1Gc2N5STZXM3NpZG1Gc2RXVWlPaUpP?=
 =?utf-8?B?VHlKOVhYMHNleUp1SWpvaVNXNWpiSFZrWlVOdmJYQlRaVzV6VFdGeWEybHVa?=
 =?utf-8?B?eUlzSW5aaGJITWlPbHRkZlN4N0ltNGlPaUpEYjI1bVRHVm5VSEpwSWl3aWRt?=
 =?utf-8?B?RnNjeUk2VzNzaWRtRnNkV1VpT2lKT1R5SjlYWDBzZXlKdUlqb2lVRWxKUkdG?=
 =?utf-8?B?MFlTSXNJblpoYkhNaU9sdDdJblpoYkhWbElqb2lUazhpZlYxOUxIc2liaUk2?=
 =?utf-8?B?SWtOVlNVUmhkR0VpTENKMllXeHpJanBiZXlKMllXeDFaU0k2SWs1UEluMWRm?=
 =?utf-8?B?U3g3SW00aU9pSkRWVWxEWVhSbFoyOXllU0lzSW5aaGJITWlPbHRkZlN4N0lt?=
 =?utf-8?B?NGlPaUpFYVhOelpXMXBibUYwYVc5dUlpd2lkbUZzY3lJNlcxMTlMSHNpYmlJ?=
 =?utf-8?B?NklsSmxiRlJ2SWl3aWRtRnNjeUk2VzExOUxIc2liaUk2SWtScGMzQnNZWGxQ?=
 =?utf-8?B?Ym14NUlpd2lkbUZzY3lJNlcxMTlYWDBzSWxOMVltcGxZM1JNWVdKbGJITWlP?=
 =?utf-8?B?bHRkTENKVVRVTldaWEp6YVc5dUlqb2lNak11Tmk0eU5EQXpMakVpTENKVWNu?=
 =?utf-8?B?VnpkR1ZrVEdGaVpXeElZWE5vSWpvaVkxaGxlbEpqV0ZBNFRrMUZVVmRWVVdJ?=
 =?utf-8?B?elNWcHpTVXA0SzBvM1owUXdLMmhPUW5sbVVFazBTVTVsUVhOaFhDOHJWRFpr?=
 =?utf-8?B?Tm1ZMWIzQkxNV1pLWVd3M1VFd2lmUT09?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Teledyne.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR14MB5221:EE_|SN7PR14MB6540:EE_
x-ms-office365-filtering-correlation-id: 9e686e27-62f8-4944-845b-08dccec7ea45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SFhKQWlSV0VuN0xDd0JsWXg0WjFoTUFlUmpZVzFTSVhQWXBSUWRCOGlPaHEy?=
 =?utf-8?B?U0xYZC94U3FlQTdFcEtac1Baa2xoU1BSaTJBZUpZeWxVOXdzZ1BkMUlKbmtK?=
 =?utf-8?B?LzJrTmpFQmxhTytOc0dBSWlCVnM3YmJZbC9EbWxJOTJXdm9tRkt5d004SzdG?=
 =?utf-8?B?TVpiazJqL2hzK2Ntay9BcXRoYm5HNnN6a2RoeFhmeSsydnowNTMvaUozUXVS?=
 =?utf-8?B?RVZjbjFlYUI0eU9kYVRwMERVZm5uT3QyL0RpSkVmdk56Z25EYXgveDE3TzYr?=
 =?utf-8?B?dWE0S0xRQ09Sa0YrR09mR1ZxeStFV0R0dmlkRHYwYWFscmNWT1BrRG9aUVNs?=
 =?utf-8?B?dlhFRXUzSU8zTnJqQ3YvdFhzV3plRUVlRjE0WU83d3ZwYVFVUXNYUWJOT1FR?=
 =?utf-8?B?dlc4SldTclhxd1lNWTJNR09HaFEzK0k5NGZPcEFuN1lWMmMwc203MUFsSGFz?=
 =?utf-8?B?eXhzayszT0lsY0pwbytuclNYb25NT0lEc3dyMGQ4bkFQbmpTYkdVMWVoSmow?=
 =?utf-8?B?cXBxTlZ5NFVvVUhJL2JOQ3dRdHBwN254OE80SXl3SWtOTzFXWUQyY083aFJh?=
 =?utf-8?B?ZDQxaC9GOWVFaTVMYzVQMkJ0QkFoUHh3dWQ3RGlkQy9heGRQdGUwMEVxLzMx?=
 =?utf-8?B?bVZJeWtaaUkzTmM1MXpCTVdMMDlJVkt5dmcyaGQzMEo1S3laZE9wdWxYK1NK?=
 =?utf-8?B?SzY5SlNnNkRjMUEzYVFyMzQ3UFZCaTRvNEZmUWQ4bFpkaC84ZmtPY3lSMDlr?=
 =?utf-8?B?M0xjQTRMWFhUbDNuYTlkN2RveDc0UGtRWFJZYWVqMVQ0ZXVuSVVvejdzUXQ0?=
 =?utf-8?B?WGsrMWJwMXRnaWJUZFBQanRBTlhDK0R4U2oyOG5EOGNUNFB2ekxOZlFra0lN?=
 =?utf-8?B?NDFvaDR2bGdnZ01pQXcrWGtuNFZDcDArd3ZYN244WFNoNGJ3cjFGSmFkN0x0?=
 =?utf-8?B?Y3NOMktkamo2MTY0YVE0OHZzOG1wRW5JZXpjL2FoWnpKOGF5eVo1TEd5RXQ0?=
 =?utf-8?B?WGh3bWo5eWFUTE1tUnpyODdTemMvZW5vOFpja3REbitxMDNDdnJKV0xSZmd3?=
 =?utf-8?B?c0MxSTVFUmhwNmJHUzBKRzRSOUlJUDB2ZHBVL1FreEVIWGpGMGRBd1VQQjUr?=
 =?utf-8?B?ME90VHNNa3NvRmtMOGRaZDVkVU1MbDZ5QXpJVUtWZW5XS3VVcW0yVmkxR1Mr?=
 =?utf-8?B?OTVRRFdlMktuOUFDZytnSy90VHduSzdzdG9ZR2dZb3JicHVQTEp1WHc4ZUFl?=
 =?utf-8?B?M3dXdjBNNWVjZEluS2pLVktMRGFzY2FPSHdNaVhRb2RHeHVsMVpzMCs2a3J4?=
 =?utf-8?B?eko5czBUN2F6QTRxZU1qQlNaVVhTaW8rTTZjQURpa2w0ZndZdDhHV3kyWnNT?=
 =?utf-8?B?MjVjMXhXSllTU2ZnYUVoUGZwNUZleWh1cVVaWVZDTitRSk1GMDJENVFqU3FR?=
 =?utf-8?B?SExHRjVGRWJBZlJwVFNUalNodFE4bDZJK09xM0JCWTlmQ08wb2gzbmRlQk1y?=
 =?utf-8?B?U3ROMmdRdFVrWnlHMlh2OS9LSjByMHFDTTY4N3Q5NE5LSEo5R0VUcDNhVTYr?=
 =?utf-8?B?ZDA0WFhKbU5tSUZ4bWpOUUJQT01JRFhiRlZVdDk4WE1LLzgvVndBN2tIM0xu?=
 =?utf-8?B?L1BpWkRjelkzOXNBd0xXZ3JvdE1pZmQ3Q1ZCSkxqY0syUU55d0FwRGRJSVBU?=
 =?utf-8?B?aFpMNU9QNzZTWWRlT3ZhdDFWVDdCbkMvVlIwZDBhRlU2RklDbnRVTFMrZXVi?=
 =?utf-8?B?WXZkejM1MlRoSjFPaXdDS0F2ekpPKzkzU0MxOHFtVXNnbnJINlI5VU4rY3ps?=
 =?utf-8?B?L0w5UFNEOCtmR2JPSFZmSW1mZS8vZUZIdlNmWndFSjdaRXB3N3RXS1l1UzZV?=
 =?utf-8?B?YlBtV1lFYStjZlV4dzF3Zk1MekFVR013enI0Nkxsd0x6ZWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR14MB5221.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEhqSERFS3NMNi9kQ3daTWJMdXE1bHUzT0dxVmoyY05kUHpSaTNTNGVYb0lr?=
 =?utf-8?B?dWZjS1M3bUV1Z1VudTFLOTBUZHBOU1lVeUpMdVJSMFlIT0RYWTBBdGhhaTFi?=
 =?utf-8?B?ckMybXhVbVFYYjViL3R0cUhURlY5V05XVThtc0c2T3RXcGV4QkRxcWNiNW5w?=
 =?utf-8?B?QjFrSUxONFlzbVo3cTZxcFg4U3EwTW5za255NlV1SjFUakpGa2R1SCszTkhX?=
 =?utf-8?B?U1ZYRkRocHJzMGtER28zSWovcCtZa2lOeU1kYkdBUUI5M0V0Q2NHdEpOekZD?=
 =?utf-8?B?cGtEV2VIQ2tVZUd5OVZBMWo1aE9ycW16QzlCY2RHK2xWS0ZPUWQxL3RINHZV?=
 =?utf-8?B?L3BBNkFBMVczdGc5Qm9LUC9kdWdLQXhXKzBQSHRQVzBCeE5XMGlKM1cxWjBF?=
 =?utf-8?B?TjZDY3d0Vmxhalh1OHhPY0M4VDF0WStXc2phZHo1cldsZ09aL2s1K0hUUXpM?=
 =?utf-8?B?U0RPd2pCblA2eW1YWXpURTRDRmpxVDlsOU9wLzJjS1Q0Tk9LU0VoRzdVQ2NK?=
 =?utf-8?B?eVJ5QWZucVdpMnZka1ExWG1jSXBDUXB1eXdCQ3hmZ1ZFVnF3QXhYbUVzd3pG?=
 =?utf-8?B?OCttZno1enN4Zk4vRmplZU9XTUNUOUgxQ1pqWXlMV0hQMFBVd21vcjVOcHZm?=
 =?utf-8?B?Z0VCSUpoUkFVS1RFbS94VE5PREo3QngzRkxiazhFejRKYjlvdXdIUkluSFl2?=
 =?utf-8?B?S2ltRmROK3NGVm90VFd4aFFVSU05dUJaUTQ3N2JqNXlyT0xYcTFtUUpDNkx4?=
 =?utf-8?B?Mk1DVHRXdGNkaW92c0xWcVJlODNRQUdNRkd4elhUWnZlSFZpZUpIKzBkMGFv?=
 =?utf-8?B?VnQzOEhmNTl2UVJCdnZGd1dlS3krU0NlMm9sM3hBSDgrM3dUT1RvMVREU0E1?=
 =?utf-8?B?YjhGVzd0MnkzVTdoTGZYZFJxRU80M0JDZlFxZ0hLUmZ2NGNxcFNMcXNuMDZ1?=
 =?utf-8?B?Z0Z6YmdZZnNCZnZYdzAyYXhUR256WkdMTnEyRTFFc3dGTUt0NTRlempRUXhD?=
 =?utf-8?B?dHdxR2FjL3RKMEhudHBMWjNIbWJjSnRzTjBWWCtMZm1icXpsN0l0N3RnSlpE?=
 =?utf-8?B?UGFmRkN3SUpiWWxDd1B2dVUwdDZGYXl5R0VkVlNodmFYU1NmU3F1c29RdCtO?=
 =?utf-8?B?YXhUNS9rbFVIRGRpb0diY1dyQ3RFRWYvMG1Pb1pWZXZQQkZhWGYxSXNKWTIv?=
 =?utf-8?B?TWJnNE1UTEd2K0NvbEZMZE8rS2tIbWdDNDIvcmZyTkl5bEJuTWl2T2kvaThX?=
 =?utf-8?B?NjdDVE01YTI2UGRLMVFzSFUwaE4rSjhjUVhNODlXNm1CQkFKNElESkx0QmJQ?=
 =?utf-8?B?Z21TaGZaMnFFY01QNHZtYXFIMFl0aUV1UlJFNU1lYkRldlg1L3BGWWJ6WEs4?=
 =?utf-8?B?TGxEUnlaZERQRkRqOXV1d0NPSytVUUNFZVVRWlpNaUpZY2NsdXBxQnpGZTJ4?=
 =?utf-8?B?elF6YmxRQUVaeERPVlF3WHpWUVIyTXpTdDlwZkRvSEFTMEF6TEowRk5Ya0ND?=
 =?utf-8?B?N2ptbVVaNUg4cXdNc0hUM0dsOUZmRm1yTW0wU250Y3Q4Y28ySjRnSXdBZVFK?=
 =?utf-8?B?cjBSOU52SUw3K2JLZE9iS29QRGkySzk2dGM1c0VVanl0K0dyVGNtdVQwZ1lx?=
 =?utf-8?B?Tm9qc0pJb3BzSWx1SlIvMnkyNUVrTXFxM1ZFTS8xT2MvSHpaTGNteDFERUpj?=
 =?utf-8?B?K0hPak01ODdCR3ovZzFOMFVxMlU1WjFHdzQrSDRnejZXWGZENmV0M0syZnZG?=
 =?utf-8?B?L1pRUzJBMllZVS90MFV2azk5dkl2S2lrOWhGUm9vVUVHZEFZbmppdDZ5a282?=
 =?utf-8?B?alNHSk14cjBRNE15T2I0QmxnQjY3Kys2RU5FUm92WW1SVkVGT1lGbXJrbU1E?=
 =?utf-8?B?S0JLV2wyeDNPQlFBQ2FzZlcwMUlUTlIrd2EzM0FYVGI4WGZkNXIvMHNMallz?=
 =?utf-8?B?emI5TXRjZjUrUHNzT01XeHlWRlhFUkdJYkRrZCt6STNIYUNsV3NZMXZHTExk?=
 =?utf-8?B?azBMN01EQ2dUOGh3YmN5VE9NV2pJN1pGYzdHRlZSanBOeUZ4REdFSW5OTWVW?=
 =?utf-8?B?QTNLL3kwQ0FzbmQ4RkxEN2FyZ2JWM01hV29ZZ2tNeExIMllSVEhTejZCZ0Jt?=
 =?utf-8?Q?0ER+JHEZVXJhgL42iclnZmyNG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR14MB5221.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e686e27-62f8-4944-845b-08dccec7ea45
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 23:02:00.3944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e324592a-2653-45c7-9bfc-597c36917127
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPV3hGiE3VamMJAncPbmteHMK5pLznoPoIXj7IwET+csK04UNRzLVpDjZkTAHoXX4axVxy1ioNbg/19JaJtSpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR14MB6540
X-OriginatorOrg: Teledyne.com

SWYgYW55IGVycm9yIGZsYWdzIGFyZSBzZXQgd2hlbiBicmluZ2luZyB1cCB0aGUgQ0FOIGRldmlj
ZSwgZS5nLiBkdWUgdG8NCkNBTiBidXMgdHJhZmZpYyBiZWZvcmUgaW5pdGlhbGl6aW5nIHRoZSBk
ZXZpY2UsIHdoZW4gbV9jYW5fc3RhcnQgaXMNCmNhbGxlZCBhbmQgaW50ZXJydXB0cyBhcmUgZW5h
YmxlZCwgbV9jYW5faXNyIGlzIGNhbGxlZCBpbW1lZGlhdGVseSwNCndoaWNoIGRpc2FibGVzIGFs
bCBDQU4gaW50ZXJydXB0cyBhbmQgY2FsbHMgbmFwaV9zY2hlZHVsZS4NCg0KQmVjYXVzZSBuYXBp
X2VuYWJsZSBpc24ndCBjYWxsZWQgdW50aWwgbGF0ZXIgaW4gbV9jYW5fb3BlbiwgdGhlIGNhbGwg
dG8NCm5hcGlfc2NoZWR1bGUgbmV2ZXIgc2NoZWR1bGVzIHRoZSBtX2Nhbl9wb2xsIGNhbGxiYWNr
IGFuZCB0aGUgZGV2aWNlIGlzDQpsZWZ0IHdpdGggaW50ZXJydXB0cyBkaXNhYmxlZCBhbmQgY2Fu
J3QgcmVjZWl2ZSBhbnkgQ0FOIHBhY2tldHMgdW50aWwNCnJlYm9vdGVkLiBUaGlzIGNhbiBiZSB2
ZXJpZmllZCBieSBydW5uaW5nICJjYW5zZW5kIiBmcm9tIGFub3RoZXIgZGV2aWNlDQpiZWZvcmUg
c2V0dGluZyB0aGUgYml0cmF0ZSBhbmQgY2FsbGluZyAiaXAgbGluayBzZXQgdXAgY2FuMCIgb24g
dGhlIHRlc3QNCmRldmljZS4gQWRkaW5nIGRlYnVnIGxpbmVzIHRvIG1fY2FuX2lzciBzaG93cyBp
dCdzIGNhbGxlZCB3aXRoIGZsYWdzDQooSVJfRVAgfCBJUl9FVyB8IElSX0NSQ0UpLCB3aGljaCBj
YWxscyBtX2Nhbl9kaXNhYmxlX2FsbF9pbnRlcnJ1cHRzIGFuZA0KbmFwaV9zY2hlZHVsZSwgYW5k
IHRoZW4gbV9jYW5fcG9sbCBpcyBuZXZlciBjYWxsZWQuDQoNCk1vdmUgdGhlIGNhbGwgdG8gbmFw
aV9lbmFibGUgYWJvdmUgdGhlIGNhbGwgdG8gbV9jYW5fc3RhcnQgdG8gZW5hYmxlIGFueQ0KaW5p
dGlhbCBpbnRlcnJ1cHQgZmxhZ3MgdG8gYmUgaGFuZGxlZCBieSBtX2Nhbl9wb2xsIHNvIHRoYXQg
aW50ZXJydXB0cw0KYXJlIHJlZW5hYmxlZC4gQWRkIGEgY2FsbCB0byBuYXBpX2Rpc2FibGUgaW4g
dGhlIGVycm9yIGhhbmRsaW5nIHNlY3Rpb24NCm9mIG1fY2FuX29wZW4sIHRvIGhhbmRsZSB0aGUg
Y2FzZSB3aGVyZSBsYXRlciBmdW5jdGlvbnMgcmV0dXJuIGVycm9ycy4NCg0KQWxzbywgaW4gbV9j
YW5fY2xvc2UsIG1vdmUgdGhlIGNhbGwgdG8gbmFwaV9kaXNhYmxlIGJlbG93IHRoZSBjYWxsIHRv
DQptX2Nhbl9zdG9wIHRvIGVuc3VyZSBhbGwgaW50ZXJydXB0cyBhcmUgaGFuZGxlZCB3aGVuIGJy
aW5naW5nIGRvd24gdGhlDQpkZXZpY2UuIFRoaXMgcmFjZSBjb25kaXRpb24gaXMgbXVjaCBsZXNz
IGxpa2VseSB0byBvY2N1ci4NCg0KV2hpbGUgdGVzdGluZywgSSBub3RpY2VkIHRoYXQgSVJfVFNX
ICh0aW1lc3RhbXAgd3JhcGFyb3VuZCkgZmlyZXMgYXQNCmFib3V0IDEgSHosIGJ1dCB0aGUgZHJp
dmVyIGRvZXNuJ3QgY2FyZSBhYm91dCBpdC4gQWRkIGl0IHRvIHRoZSBsaXN0IG9mDQppbnRlcnJ1
cHRzIHRvIGRpc2FibGUgaW4gbV9jYW5fY2hpcF9jb25maWcgdG8gcmVkdWNlIHVubmVlZGVkIHdh
a2V1cHMuDQoNClRlc3RlZCBvbiBhIE1pY3JvY2hpcCBTQU1BN0c1NCBNUFUuIFRoZSBmaXggc2hv
dWxkIGJlIGFwcGxpY2FibGUgdG8gYW55DQpTb0Mgd2l0aCBhIEJvc2NoIE1fQ0FOIGNvbnRyb2xs
ZXIuDQotLS0NCiBkcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYyB8IDE5ICsrKysrKysrKysr
Ky0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jIGIvZHJpdmVy
cy9uZXQvY2FuL21fY2FuL21fY2FuLmMNCmluZGV4IDAxMmMzZDIyYjAxZC4uNGNlZDgzMGY1ZWNl
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2FuLmMNCisrKyBiL2RyaXZl
cnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jDQpAQCAtMTQzNCw3ICsxNDM0LDggQEAgc3RhdGljIGlu
dCBtX2Nhbl9jaGlwX2NvbmZpZyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KIA0KIAkvKiBEaXNh
YmxlIHVudXNlZCBpbnRlcnJ1cHRzICovDQogCWludGVycnVwdHMgJj0gfihJUl9BUkEgfCBJUl9F
TE8gfCBJUl9EUlggfCBJUl9URUZGIHwgSVJfVEZFIHwgSVJfVENGIHwNCi0JCQlJUl9IUE0gfCBJ
Ul9SRjFGIHwgSVJfUkYxVyB8IElSX1JGMU4gfCBJUl9SRjBGKTsNCisJCQlJUl9IUE0gfCBJUl9S
RjFGIHwgSVJfUkYxVyB8IElSX1JGMU4gfCBJUl9SRjBGIHwNCisJCQlJUl9UU1cpOw0KIA0KIAll
cnIgPSBtX2Nhbl9jb25maWdfZW5hYmxlKGNkZXYpOw0KIAlpZiAoZXJyKQ0KQEAgLTE3NjMsMTMg
KzE3NjQsMTQgQEAgc3RhdGljIGludCBtX2Nhbl9jbG9zZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
KQ0KIA0KIAluZXRpZl9zdG9wX3F1ZXVlKGRldik7DQogDQotCWlmICghY2Rldi0+aXNfcGVyaXBo
ZXJhbCkNCi0JCW5hcGlfZGlzYWJsZSgmY2Rldi0+bmFwaSk7DQotDQogCW1fY2FuX3N0b3AoZGV2
KTsNCiAJbV9jYW5fY2xrX3N0b3AoY2Rldik7DQogCWZyZWVfaXJxKGRldi0+aXJxLCBkZXYpOw0K
IA0KKwkvKiBkaXNhYmxlIE5BUEkgYWZ0ZXIgZGlzYWJsaW5nIGludGVycnVwdHMgKi8NCisJaWYg
KCFjZGV2LT5pc19wZXJpcGhlcmFsKQ0KKwkJbmFwaV9kaXNhYmxlKCZjZGV2LT5uYXBpKTsNCisN
CiAJbV9jYW5fY2xlYW4oZGV2KTsNCiANCiAJaWYgKGNkZXYtPmlzX3BlcmlwaGVyYWwpIHsNCkBA
IC0yMDMxLDYgKzIwMzMsMTAgQEAgc3RhdGljIGludCBtX2Nhbl9vcGVuKHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYpDQogCWlmIChjZGV2LT5pc19wZXJpcGhlcmFsKQ0KIAkJY2FuX3J4X29mZmxvYWRf
ZW5hYmxlKCZjZGV2LT5vZmZsb2FkKTsNCiANCisJLyogZW5hYmxlIE5BUEkgYmVmb3JlIGVuYWJs
aW5nIGludGVycnVwdHMgKi8NCisJaWYgKCFjZGV2LT5pc19wZXJpcGhlcmFsKQ0KKwkJbmFwaV9l
bmFibGUoJmNkZXYtPm5hcGkpOw0KKw0KIAkvKiByZWdpc3RlciBpbnRlcnJ1cHQgaGFuZGxlciAq
Lw0KIAlpZiAoY2Rldi0+aXNfcGVyaXBoZXJhbCkgew0KIAkJY2Rldi0+dHhfd3EgPSBhbGxvY19v
cmRlcmVkX3dvcmtxdWV1ZSgibWNhbl93cSIsDQpAQCAtMjA2Myw5ICsyMDY5LDYgQEAgc3RhdGlj
IGludCBtX2Nhbl9vcGVuKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpDQogCWlmIChlcnIpDQogCQln
b3RvIGV4aXRfc3RhcnRfZmFpbDsNCiANCi0JaWYgKCFjZGV2LT5pc19wZXJpcGhlcmFsKQ0KLQkJ
bmFwaV9lbmFibGUoJmNkZXYtPm5hcGkpOw0KLQ0KIAluZXRpZl9zdGFydF9xdWV1ZShkZXYpOw0K
IA0KIAlyZXR1cm4gMDsNCkBAIC0yMDc3LDYgKzIwODAsOCBAQCBzdGF0aWMgaW50IG1fY2FuX29w
ZW4oc3RydWN0IG5ldF9kZXZpY2UgKmRldikNCiAJaWYgKGNkZXYtPmlzX3BlcmlwaGVyYWwpDQog
CQlkZXN0cm95X3dvcmtxdWV1ZShjZGV2LT50eF93cSk7DQogb3V0X3dxX2ZhaWw6DQorCWlmICgh
Y2Rldi0+aXNfcGVyaXBoZXJhbCkNCisJCW5hcGlfZGlzYWJsZSgmY2Rldi0+bmFwaSk7DQogCWlm
IChjZGV2LT5pc19wZXJpcGhlcmFsKQ0KIAkJY2FuX3J4X29mZmxvYWRfZGlzYWJsZSgmY2Rldi0+
b2ZmbG9hZCk7DQogCWNsb3NlX2NhbmRldihkZXYpOw0KLS0gDQoyLjM0LjENCg0KQmVzdCBSZWdh
cmRzLA0KSmFrZSBIYW1ieQ0KDQo=

