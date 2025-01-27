Return-Path: <linux-can+bounces-2700-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41720A1D23A
	for <lists+linux-can@lfdr.de>; Mon, 27 Jan 2025 09:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869E97A26AD
	for <lists+linux-can@lfdr.de>; Mon, 27 Jan 2025 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165D516F8E9;
	Mon, 27 Jan 2025 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dF3l9Dpy"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC6DF71;
	Mon, 27 Jan 2025 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737965830; cv=fail; b=ufHCsw5anLjba4x5OM8DS2j3rG/0ZKw5rDEaCCra5O9nUMI5y+HGZCD8UWaaLn287C5FvpY63ZvHawHVWfofp355ejz7b3qB22bflXNvTI8pTvLfkjFoa0S6ZKDiQBRSZfDdVwK5abG/7pVe/rT3l93fvE2GKFbd0RyhmoYXyD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737965830; c=relaxed/simple;
	bh=hljZ56M83KHqy133yMvY02VJ9D2cdrPag+JvMPj7OnU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=inHmX1sbBEdt/SSjIfFFqfP0kchF7PACxCyyRyHrflOFy52ad7sV+uLTUByW2c2YjxzKh0+SOUUrstRRZE1mBwxdjKbzXO21fhYdgq48PpybiSbJ9n6iD19Ox+ImoWQZ5P3Va8WghyTYKULPm57K8LESiRua1dNXfcU2gq9uaTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dF3l9Dpy; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737965828; x=1769501828;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hljZ56M83KHqy133yMvY02VJ9D2cdrPag+JvMPj7OnU=;
  b=dF3l9DpyF5K/4scRMQtQtSvXGR2Ma8hFcyWcBl9zRXBu8AK8oLM15eEb
   LGnqC7R3hracaVWvdNrgMk8ic16kWzG4alFj3kftadcRR75AlLph3BU93
   dViagBEQ/T3J/v10LJxl8s/hsWnF5utJfZPuouOiHBq8Ead8YLkq8JnLS
   Y0cKm92iTMAW3pN/SCQQ0VHhmJejvPNTBmdzfYXv6naWuzJfT2pf0PuqB
   4m1C3FNj05GtvIKVPp9WePCZgvWmWuR4Fs7owJXPQXIkbq371VTkUv1nl
   32w2jsEGRGiOUbrhLd6QP8xD4UDGs5kC3pw3m/qm3P/UkzEBSzbRef2bB
   Q==;
X-CSE-ConnectionGUID: aLOlTgV1SbGm1QzZVdes5w==
X-CSE-MsgGUID: PHaRdAqKQp6yfWBlvWY7Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38517660"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38517660"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 00:17:04 -0800
X-CSE-ConnectionGUID: CkwL4pdYSK686yLv01Z3sQ==
X-CSE-MsgGUID: XEzmLGiWSSOQzHENM3fa4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,237,1732608000"; 
   d="scan'208";a="108267314"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2025 00:17:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 27 Jan 2025 00:17:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 27 Jan 2025 00:17:03 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 27 Jan 2025 00:17:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymq9xdTkoZMDST14MXGYseUsCL3AT9Pv9Y1cd7ScjGLOZN9A5YCfyba4U9xQ2GKMXptHaZhFlQoK7snOrPaoylJnvF7UReJMnElUoiuRkmzkLKR/NUZTqkIVYwLVG5ueKtUQAArbKtSF9jpO8bezCmBfvQr/i8ogHIQ7LTEvACVInCBECYEbExRdZDdxneQ6f3htR9ucmpSFVLPdTfGP73iizObjRdO9ei9avOUFyxau7Q9pLcFhW0Fz8dGX9AmQQviNLNZDi/m7pJjEEoak4bHHBP9SlbAfNsnEq4UJc3Vjdff2JiAqGffhfWYEYRqyPjLCvn0WjwJK5FAarHyhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiPMCzmunvIkCJl1UxdSKNzJ5GpUF9Zfr5fxMMZ5LrA=;
 b=kNsSxJim04SoaQgkdyJDG7qpTebrkkjY7ku7OdocySJcATlzpecBltkafA5MqZ8LDbYMMO3J5187CW5akTxlkxAkhyL4BIGbbOEk1WvUDNNWli7+iGbkZS7jRmy+CnoH88z/Ms6WwFaivbf3Q8o+FyzBT6MjOU5bQziV08fVTj2N4UrRC+8WiuhsMG32CfbPwyEFI7Lewr2rGQUqQ91wBPzJ7Xlc/3gBwNPRcK3jc2Iy6Yd1mfwrz5Ex6MnfYrNEziOmF8rQdmGMRaBC66qJoLwZN3olzNtPcwhGw76e2H1e2JLQDAu4FYBat6vwDsL64RwGa9pBC24eqkR6I2gFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB7558.namprd11.prod.outlook.com (2603:10b6:8:148::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 08:17:02 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 08:17:01 +0000
Message-ID: <009d8ff8-7b77-4b3c-b92a-525b1d6bd858@intel.com>
Date: Mon, 27 Jan 2025 09:16:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] documentation: networking: fix spelling mistakes
To: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
CC: <shuah@kernel.org>, <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<socketcan@hartkopp.net>, <mkl@pengutronix.de>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <corbet@lwn.net>
References: <20250123082521.59997-1-khaledelnaggarlinux@gmail.com>
 <69da3515-13c8-4626-a2b8-cce7c625da43@intel.com>
 <5248fbae-982e-4efa-9481-5e2ded2b4443@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <5248fbae-982e-4efa-9481-5e2ded2b4443@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::42) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b393223-524a-4864-9c73-08dd3eaafa0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjU1bkVycGprck81b2ROYWpreDQ4Q3lqdkhWcDBnNW9lOW9oNEM3K0xkdlBS?=
 =?utf-8?B?cmZUcWxrSTFLeTBwVlhseFJLaUZaa1ptY09OOXVzZmpvWWVUMXRrMTd5dTRB?=
 =?utf-8?B?UmtRWTFmMGhIWWJ4MVBYSzVUUXgyS1lEcUVQL1YvWFRKdWpwOWMwK0FoNlRl?=
 =?utf-8?B?MGI1QTRUQlJVNXdnTFNhZ3U5V2FKeFBCL3psUFY5ZVZVTHZjY1lrYlF6bTJj?=
 =?utf-8?B?d0p4R3hIM0dHeExLTDVKUzNBQ3RmZXZoZHJUd1R0cGNTREpvQ21zNWhqV3Yw?=
 =?utf-8?B?VWdLMTJPN3M0TWlSMGJHOTJOVXZKM25hcUg1dnRsY1ZNa3dlYUszSkhteEFV?=
 =?utf-8?B?MGtZQlFmOWtablFLaVp3VmN1SUgrUFI2L1QyanJXQkFNb2Rza2t4Z3RxNm5y?=
 =?utf-8?B?VzBBMmtraXdGQzlQM092NUV6eWVxVnRFc3RjbUt1TWN6czBPNEF5R1F0V3FX?=
 =?utf-8?B?cldFOWdKZndJVC9od0dYbXNMendBQjJsWTY2ZC9TU1FYMC9ZS0ExRWdORnI3?=
 =?utf-8?B?UTJzUjBOeXBOU2YybXN1T2JEeWpMSnNrUUsxRkc0TWd2em5RUTRsRGg1RVp0?=
 =?utf-8?B?RXVUenlWdzN3R2ZERkt6TmVxUjhxNW9xakJsckRTLzZQNUdoSmlOWHhLL2Yr?=
 =?utf-8?B?Q2hab2g5eEFLOUxPc0VzK3NSQkVSVmNqNHRlQ2t4MGUzb0QwbElFWnU0a3hY?=
 =?utf-8?B?bDhvUXBvWVdYR0d6dncrVFJJWGt1TEtqaGlPa2dBNm1PSCtMVmVTazZyMnBF?=
 =?utf-8?B?YmRnTjQ2Ull1WFo0R21uUlNKU0E4ekJ0NjFjK25RZGxBZGw2STFJL3BNTVNk?=
 =?utf-8?B?Y0p0WHNkeDVPUVN5YnBuN3FIMzdtL1dYNklRcVNZR0lWcUhEWFNKK25NaWZX?=
 =?utf-8?B?UVJhU3V4QXNUSVFOekFRd3p4Qnc5WmpyYjYwbFpZM0tjdnZtb2NNZU1YcVpx?=
 =?utf-8?B?ekxPSk5pd2ZKc1NMQ0ZNR2wwK2xkemEvejlXTFlnemFNeVdIWVg5d0w5dVds?=
 =?utf-8?B?a3FaQW8xWmpiZ2UvUllFKzhSK0NFRytMblAwSlk3WGhVNlEzOTMvV1d6cnNH?=
 =?utf-8?B?SEVhNjhlV1FnTDI2T2Zad3hqMzVHVUxmd0d3RWN4VDI1YlRTUjZKZFIwSzN5?=
 =?utf-8?B?ZE9yeXFoS3greDU5YTN3eDJJbnJVK2pTREVlUjZlOUx2ZmRqT1JwNFM5VUl3?=
 =?utf-8?B?alJuK0QxN29SckFON1U3dVlWK045cjUrVlFvNE5KODFEZDI4QVRVQkZTKzFF?=
 =?utf-8?B?WkdPOWd3QnoxbWR0UzZ5UjVSRnI0eUxVWGMzcXZ2anErN1VnYXFXcVo2OXF6?=
 =?utf-8?B?YWJBRE5ENEtSUXJEVUpSUkJUdlYyVWd1Y2N4dkdRMjBEOUxJcVZiV1ZlMXpq?=
 =?utf-8?B?ZTFxWlFRd2MzWmVWY3RZOXYvdXpYMnRxcllCN293WnhIU3FVV2FBaGNvZDJH?=
 =?utf-8?B?YStpMXBSL3g0T051OTRTSklkSGkrK0lkNkhvNmk1NmlvYS9rQW9uUHlXKzJU?=
 =?utf-8?B?OHVGMWpzYUZIUEVlRlhDRTBSZEJIRndRT281K0hJUi9yR3B2Wi9jOVZCYUpY?=
 =?utf-8?B?dVpzc1VLZ01tUWNheUtvV1dRS3ZjaGtGR01NNmFDVk1TOUZlY3VmVGFkZmxy?=
 =?utf-8?B?TEErU0JXWk9UQ1JJZ0lHU25SbGFZejdZSXU5bjRrbjgzdXAyQWRRdmJUT0hC?=
 =?utf-8?B?Si9GQ1pLZ2ovdmd6Vm13SEdDNjF1MDJuQ2RhaVVmK0srRDdpTGtBNTZsUkZ4?=
 =?utf-8?B?c0txdFFxN3dXcEpiZkQrYXZrYVJqSUZtVHZQcUZQM2I5Rm8yd2VJQ05WZm4y?=
 =?utf-8?B?RnZDYVRKNUQxdmdoSlpjZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0tjR0pFQmpLMlNaZGNTekEyZjdBUUpwb21FKzFJbmVyVGx1WnJtZGlCOHJi?=
 =?utf-8?B?TFVLRjJWaGl3R0FTaE5WY1g3b1RZZzZTVDlxQWpsYXpoZGVvV0dTeU9ZelNX?=
 =?utf-8?B?REFWay9PVXRmN0piblYxenQzaEdBRGh4UlN6Ykh5VEJ1bmRFRWZNTWR4Qzla?=
 =?utf-8?B?NkU2Vno1MmR5a0R0SXJEWEFtTWZuUXBuTElGT1h2RnBZNWtmM1JMdkFtZUJn?=
 =?utf-8?B?dk9NQ2NTdVp4eC9pUWN0S1MraWpRc3V2Y3p3UktiMUgvLzd6Wm9vZERzQW96?=
 =?utf-8?B?UnFhdVZqbTZGSlBmSmI3b0F3K2JmeXpRa1ZOeHJ6OUZ5TzkxU2Q4TEp4UGxj?=
 =?utf-8?B?Z2lwY1Z4MUd3dk5SczlGNzIzZXJIaVBSbnVDcklUVnhCRGVwUVpab052WFdK?=
 =?utf-8?B?blVOdUVIS3hQZisrTWdCTzVTcHNDaWpxUFNUaHVVcUtPTVkvSDNiMDBzOWlK?=
 =?utf-8?B?ZUJOM2hNUjROUHluQi9mZXZDWGdOYkpSeGltME5uZlgwNWptb0lZenQ4K3Az?=
 =?utf-8?B?dUoyNlVDbHFtTnlJaG1rYVdaVnJvVTlsTGwvL3RhOVZIV2FyZ1c2cWpsbkw4?=
 =?utf-8?B?UlEzWVpuOVZRaTI1ODdwM3NGWE5jc0JubkhHdGJoTGpveGZ4TktkRVg1b3Fj?=
 =?utf-8?B?T0Q3NGtTUXkyM0RYaUJVT1RKRXY0UVR6a1ZTbmNvSFBUNk4zVDhMeWtLNGlh?=
 =?utf-8?B?YXRUbFJBT3Zxdk8wc3k3N2xMMWx3eFlxcmxOSmxrMEVtanlHMEVVRGNaSlpJ?=
 =?utf-8?B?RnRUblVuNGtGZXhERDZOZVo2TWI5S1dmU2ltTzJUaW1pcnY0ejBFbG00MnVP?=
 =?utf-8?B?ZXcxNzdJajlNL2ZGcDJFV1BNSzN3aXk3SDlURzNUQW16SDljcm1FbHFUak9E?=
 =?utf-8?B?bWxUVVQ0bGd6RmExWFUrNnlPS0RKYjNtTWxjNjNmVHlGRTI5bE5jMnczbEZk?=
 =?utf-8?B?ZGRZRngzWFhuZnFaVGRJZmJRUkgrZUcyNk10YllaV0prb3U4Y25PMWVkRjZy?=
 =?utf-8?B?RHA5RzA5YkdNUEpqWE10VStnMElpRjg2NXprNFRYQVN2NEkydzU2WG0yZk5N?=
 =?utf-8?B?MytnV2tqcHFteHcwZ0g2Ui8yemtDanNmSTFnYkR3RmlMMHpyanQyUWFyQ3Bi?=
 =?utf-8?B?SGx5WklrOEtwVWUvWjBZSXJnNHhrWGJodmhMZXp0UVptMmNHeWJzTklOOHJl?=
 =?utf-8?B?dHBCbFJrRjVYNVdxM1NyakcwQXV0emF4UHJuZjFIUlkrTGdKWnQ3d2FZZ3NM?=
 =?utf-8?B?OU43QkhqaVlXTjByYTV1bnpzQ09nMWs2RHpwcUY3Mm94ZThnMWZvTHc5R0Jn?=
 =?utf-8?B?Um0xWEo5ZkxkYmlmazJhQzFJSnk1WkxIaVdUMzJwUi9hNUQzSHpEVmFBQ3p2?=
 =?utf-8?B?RWhxd0RMZzJrZU40REhUMDErRm5DYmJjNDFBZ1ExUE16eGtQK3V6YXhJZFAy?=
 =?utf-8?B?NVdFSW13S0JlaUlMeDUrSU5mRXpnT29SMSs2dktWQkhZd0VsQkxjSmZxVlhr?=
 =?utf-8?B?VlNZRUlWeDRRd0ZZdUNuRDA3UHhNM2kvNW5FemhUN1Qya0hXS053Mm5DSUx0?=
 =?utf-8?B?Q0w4K0VOUTZ3NW5rTzJSNW5YVk41L2dZRHZTcGpZZlI2aWtHTGV0b2tqVGZV?=
 =?utf-8?B?cVRhd3ZhSlhyTGdKaFBHU0lHK3VMYWpZUmRkSGNYZ1ZMQlNNa2RRVmU0UTBB?=
 =?utf-8?B?YldOY3NwU0RtRVFMT2FnU3NUdkZjdldhOERDM3E4QzY4S0Fxa3U1OFhHbG1F?=
 =?utf-8?B?Ty9PVkh4UzFHb2twOHlyZm5GdHQxVEU5RXNyQzJiaWViRGl2WCtGcVE3akJW?=
 =?utf-8?B?UG5kSTBjeGdTUEZEdmZjM1UzTVNUK09HS21CVk1jbzBrZmU4NTg3ZHNpeHg0?=
 =?utf-8?B?VzBObjJKVlpxY1p5YzNKUXBxanROVHZTcWRKVG94RFFnUDZZSFduV1hISElP?=
 =?utf-8?B?WkZyNWtYMm14MjltNlUwUkFLTnAxUE5xajZ1MnQydDlQbUZwUGRZR2l2MjRQ?=
 =?utf-8?B?U1BQd2U0V3FPRHN0UUxLNk1kalRFMVBGSzZBSy9RN1oyUkNUc0VMeWFaM09W?=
 =?utf-8?B?eE1MOFFMRFhUQWxha2NwVFczbnlGNmRhMXJoNXhTRVZUOENUZzNGeGsvU3V2?=
 =?utf-8?B?YVNTL1REUGJuNCtkRkxrOFFib1NQWVRySCthZ1RBZVhLRXZEYnBGa3ZhZFI2?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b393223-524a-4864-9c73-08dd3eaafa0c
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 08:17:01.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRG9HBFqyq7C0qKjrnIEeRYKt8zVj6E6JqKUTFbO321pJ7H5jUMzMyuikOG2sOwQN4j2qoGOCrBtkwXHVgcysv8dCHuIawqZ5wk7JXQ/YUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7558
X-OriginatorOrg: intel.com

On 1/25/25 13:11, Khaled Elnaggar wrote:
> On 1/23/25 11:12 AM, Przemek Kitszel wrote:
> 
>> looks good, also process wise, also this comment is properly put
>> (one thing to possibly improve would be to put "net" as the target in
>> the subject (see other patches on the netdev mailing list); for
>> non-fixes it would be "net-next"; but don't resubmit just for that)
> 
> Ahaa, I also should not have sent this patch during a merge
> window where net-next is closed?

this patch is fine for -net, as this is fixing the bugs in the text,
those are rather special, as there is no risk of regression :)
I'm not sure if Fixes tag is necessary for spelling fixes though.

> 
> Thank you for the heads up, I will be spending more time with
> https://docs.kernel.org/process/maintainer-netdev.html
> 
>> I'm assuming you have fixed all the typos in that two files, with that:
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Yes that was all I could find in these two files.
> 
> Thanks,
> Khaled
> 


