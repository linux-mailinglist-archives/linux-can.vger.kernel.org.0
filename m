Return-Path: <linux-can+bounces-3551-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058EFAACD37
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 20:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039F61B68C2A
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 18:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E435A286405;
	Tue,  6 May 2025 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJ6GIrl2"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE5278146;
	Tue,  6 May 2025 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746555959; cv=fail; b=Sm7pOwyBGmUKq1nJkyEdSwGedIcXXpOO71eZ0419FkB+2ajPE0IkVQhab7LhxM7zOcMUn88ZyehCOYoKz+1zPw2a9s5GqE6CJG9pTvgmcKOAKX1V+8rf/v6c5odlhuFeeEtAD/kGoN67fBDsozhTGOQnI18+4D4kHI4kErFNblU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746555959; c=relaxed/simple;
	bh=ie4iznFuP46EX1vYwhFDvtfMhN/jOWau3XMhd3o4nEY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U8q5uOmi9C89Wvkmg58QjVTAwez6AaqDwipTr5H+3x/BS4f8e2iqlVKkpQXHBdrCQX1zBGGyPTwq9x0ak5+gfsOZ07exnzfaqYfXTskBQc64FEPCzN1mKebsuTIQPp9CjJ6Gz4KzRXReiwLbxbZb6RE6HmT4wHiqzQgr27SHZX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJ6GIrl2; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746555958; x=1778091958;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ie4iznFuP46EX1vYwhFDvtfMhN/jOWau3XMhd3o4nEY=;
  b=RJ6GIrl2Th6mCsjlcPlSezZ32eT/9i7k5kvf/cPfJ+HnnnQARvJspdBu
   EJxZy5yF3D1NGhnkv6qRY9VRuTumrU6FXPXBxA9800z9D7nLeQZsZzmih
   Ci//rIKRHq/CQ4mfZs1vZn+b8sj0APAY8yImggT4fvWbYFYTWJHLQj/H6
   org9eTrAh4Q+8hzGYfPiNxRPsbSMZNI3GrSOQx4aRNOemtgjcP+i8s10d
   clNvO0Y7eQEfLIuvgkWJsh/3fbKbwGeElBtSbbeKwsE+btd4Ysy1WEN/r
   B0aalbPwkYh8m/rtI5ZdDXnCHTZP4z7ANshIViqpbY8aDvhBwFNVMJc+0
   Q==;
X-CSE-ConnectionGUID: qKCfUYztT3icoj9/MNNCFg==
X-CSE-MsgGUID: os6co/M1Rh+f9dBU+UygHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="70751662"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="70751662"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:25:57 -0700
X-CSE-ConnectionGUID: oywixEuiSnKGNskVf3xXng==
X-CSE-MsgGUID: b5KPJHSoQSeTPJLIM9Amfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="158996560"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:25:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:25:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:25:46 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:25:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiO5a++V3MqTE/Vv6LacxbMPVtH2Dyv9QnhUDzfZ/8+KSdbU4VuC6m3MADqAqVnT7mdwbRFMzPf4QhLWOcVwyUDB09uoPnb15fzUHU7zZRbEl/8Qi3FDxceS0CLs7WEeEitCtDrgKFxBlp9VCcV3WxE4tZVrKG59RQ1tMNsgY+1ARAP8FL14gL1DkxA4M7QgyM+HiZfFPeqbG9kirE6t2tw2O2R9neUNC8aahB8n7Br0h2jv64KId0FfngiiQi8gwejiDWeCEgudxfbn25giVjmwZZ91orVQcorsjLKyEknyKAzw/eA7LIIi+Q4S7rrbEVqV4SaXEdw4ncAyStgm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8PW6nu0/1XMGj1RI6khVz70K2XqCCdNBQVlncQyGRY=;
 b=R/B6PZm/LtmxEGXhWmOVytvvgkbT6RPywYXHATdlDDeyrzLstctgC/O3BnyoZrtplBKyMshyBGFNnovmY3JLPpgKN/J5SMy7Udu+T0aOovMJ7iPdIqhCM1faRtyKz3Eg+GyfpOljQbQ8zWb/bZsEjxYqHK+fGi/ufKAWfLlU4QaaEPqOoTVcUUiV9cMs9/VLBBvVnXet2Z9c/bg1y3Dfq10NFkdSKPsIn/wB68iM7nfy8Lrgy7Duu0+vy2+NJVpiYN4lcv8SScIAJcVACiEJJ28IZYV2gTOWDocc9qsGLhUPHIBVSB2GFQtNrBVUAvpsl74a5hWjaJL8ir3oJ4jSxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH3PPF5ACB2DC0D.namprd11.prod.outlook.com (2603:10b6:518:1::d23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 18:25:41 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:25:41 +0000
Message-ID: <538c7191-dcaf-481c-8f33-03fd048bc99c@intel.com>
Date: Tue, 6 May 2025 11:25:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/6] can: m_can: m_can_class_allocate_dev():
 initialize spin lock on device probe
To: Marc Kleine-Budde <mkl@pengutronix.de>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-can@vger.kernel.org>,
	<kernel@pengutronix.de>, Antonios Salios <antonios@mwa.re>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Markus Schneider-Pargmann <msp@baylibre.com>
References: <20250506135939.652543-1-mkl@pengutronix.de>
 <20250506135939.652543-2-mkl@pengutronix.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250506135939.652543-2-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:303:b4::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH3PPF5ACB2DC0D:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e09228c-2006-4e90-1f9d-08dd8ccb663c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzZKdHdhaW9KWkpnc3hIWVA0UWpacnRZNDhLN2Z5TmlibUlaOGh6UXVEOU1D?=
 =?utf-8?B?bU5nN2xMR3pINEU5Y0NldUY1WUJHWXZZN1BhbVNOUHBjMmZPY1dOSGovK3pR?=
 =?utf-8?B?SkZpbHJ0NmRnclFFQTZkN1ppZU5ad0JQYnlRbnZSRDRRRmhCbXplNFd6WWpI?=
 =?utf-8?B?MWpRZ2dvclZBTWdEQUEzT3VyTldjVHRlb3l6R1BTNHBtMGRvRFZ1UzZTS3VL?=
 =?utf-8?B?eGNKMy9ocUU5eUtkOEVxTkxPQU95UC95YzMvS1FtelhlN29UTVNCcjFnRFVW?=
 =?utf-8?B?NHM2UktMamtyZjl4Z05sTUxvNGlJUjVqNlNqOEhSV01NT01wUWdlMEh4dmJq?=
 =?utf-8?B?OTVQSlBJOHdHOWdlcnljblNxaFREQTI5ZXlRS0hOTy9Sb2gzaVpWLyszRVVS?=
 =?utf-8?B?d1ZTMUlqVEtaOHNnbmMyRmw4QWFmSk1aK04wWlBpZ0czY01qTE0zb0FUMXJ4?=
 =?utf-8?B?TVFUN0tYUWNNcWEzcXlQbmM0U01zZkMwemtrWVJLc0JOaFc2Y1B0TVIzRGx0?=
 =?utf-8?B?Vy9PWHNKYmpqTkJXM1hzV0VvTDFjelViTktnRjBMTjVLcW8yalM1L0x1SURw?=
 =?utf-8?B?RDNES0hncCszMldJU3BvVmRtNjJHTTBvaWRqQ1AxRTNqV2RsNkpJdXBsNC9y?=
 =?utf-8?B?eGU2WXRyK2hldzJucERXc0lFb1lCazlSUlFGZlFwNmpiRXhVWE84R0RzWkFI?=
 =?utf-8?B?dTJZbjU3amNMdnRnMkFkL1ZzVGpvNjJ0elQwa0sxTk1ha2RGM0pyUm9uanNS?=
 =?utf-8?B?SDErWFFoN2lGdU9yQlQ4YzhpWVk1UTJmd3R1eEF4NzVJL3J4ems4QlBUbkhl?=
 =?utf-8?B?djltMXh4RVlCK0xLenhQNDVaNHlTT2xMZGZIM0dOYWdRYVA3UGF3ZmxObGJI?=
 =?utf-8?B?UlVVeXVxRE5aK09tRnpoQ0tBaUZJL0wrSloybkRhTTRUeVpjRytJTktkK3NX?=
 =?utf-8?B?ZkdqWFV6UWcxM1pGMHhPbjdxZTQrS2hVUVhydkM2OXh6UEJkVjA1eGp2R0wv?=
 =?utf-8?B?NHdiWE55OVVzM0V5N1FtbUx4RUJHRnpyY1M0QnpVWDhKeWdPUEFFeTBIdTcz?=
 =?utf-8?B?K3grTWxEMmlMV254VUZPSEx4Q0ltaTc1NjRNRnV2U1VDUVdHWVRFYU5rK0J0?=
 =?utf-8?B?M3VPU09UVkxLeG9wOVFtUlFzTDJOajd5c3VPRzZSVmxMbUgvR0hEQU5CK0pZ?=
 =?utf-8?B?T2lOYkVlTlVKRkxzdW9tSW04bVErR2g3Sk9YMUVQLzQyaUJ6dWhzZ2RmaFVZ?=
 =?utf-8?B?dXI0Z1dEamZhclRiUzZHd0hRUW42KzZUZzN2ZVBobmt1U0xVMGJCMlRZTkl4?=
 =?utf-8?B?aGY4S2x5eFdtUGNzaU5wS1E5RjJuQ0NkZXBUY1ZxV2UwblFDV1ZMOTJTMnBo?=
 =?utf-8?B?eUlrZ3BpVDQzbTkyY01sSDlvSmkxVDVNdzR4c1FGSHZ5WHI2M0tacWI2S04w?=
 =?utf-8?B?QUtmN3ltTWt4enY2Y24ybVAvQjY2UGV3N1liSWNRQ1FmRHZaVzV4QXlrOXd6?=
 =?utf-8?B?dDNDeDYyVGJOTTd4V2kzNkErWS9sekV2clUvYkcrallLMm9wL0NnNFFWS3Q0?=
 =?utf-8?B?c055eHJVUHo1eUZHLzlnQTliZ3BZM015SUNSbHRXWHNJSFdWQlNVcEZ5Nks0?=
 =?utf-8?B?M1JiaW8wSjJ0Y3RCUHhXYmtYZEE0Wi9EUklZekdXMG5zN2JMMDZuaG1qQncy?=
 =?utf-8?B?bXZLL0lYcjRVRTYzUnpEOFRBcFR4NGRoUzJwTXg2ZHE5T0ZBNW5IaFlrUHZj?=
 =?utf-8?B?bUtPQ1lUQUhlR0NKQzBBV0l1Z2prQWR6TjJHUVdEaEN4blMzVm44aDdmZVg4?=
 =?utf-8?Q?sIKiq3opALZQ1fowviM44Oy93Ot/aXb5IV+Sg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTF1aStuMmNRU25lbUJyOGdVS3NTZ25jQ2FXMzRWa3V0WFcySFZ5V21VeHNl?=
 =?utf-8?B?bmxvNDl2NFQ1cHdBSnV6dy82NlJ2bVdXcVhXWjZmWnhiQ3hqWGVNWjJtL1Bj?=
 =?utf-8?B?L21hbFd0dHRNMUdSTitJZU9aOWJ4cDhSMGphVnN6UzVwOE5IVjNVRFlmdXcx?=
 =?utf-8?B?QWI5REdqRFF3SmJVNG9sRjVWTWtDU0kxSXhNb3AyZEEwdjc4L0ZuczNndUx0?=
 =?utf-8?B?Zjl6UXhLQXFoc2dqd3pvRXUrcVBMcDUrbWl4dXQ3K2ZBSGg4R0dwRU1mL0N2?=
 =?utf-8?B?dVNmMlY2L2YyQlZPUjdnYkJQV09xaEZzdTRIRHR3UUFLWXNUUEVOdFBHNDdH?=
 =?utf-8?B?YlhYVXFYMzBwVkttUTdzTzkrRW85T2VNNXU4aWFvSkhpRk43OWRTeTZ6M3Rz?=
 =?utf-8?B?ZSs4akpHRjhickNBQkRUbkN0NmdzTFVJcVVlTE9WQ3RlY1J4VHllQmxkZE04?=
 =?utf-8?B?Z1haMm5PYnQyRWdtK2JjWXBZMWdnTTdCbldlaENsVkVNVWx3bm50d3NxSmI3?=
 =?utf-8?B?cFY5MHNTZWRENm4rVVIvbmdNdEtGL1pXanJtOHV1WWFqVVVXLytSWmh2Mndz?=
 =?utf-8?B?cXk0TjBWRmFybis4L0paMGx4dnYyVS81c1k3S3Z6NDNDSGdITHlIZFJVLzdE?=
 =?utf-8?B?aVBBK0xvbzlTQVdBWk9GRURGeDBIZHRIL05kUmE5bWNTSkFrbC8xTjZITkp4?=
 =?utf-8?B?TldZWWFhby9wM3R6MkhpY0Q5elJGWjFjZ0ZWbSs1TzU1aGVVcWpkRmNmZ29G?=
 =?utf-8?B?NGRWbDhzTm1uYmJ2cVN1R3V0WTY1UFNWYTg1VjdhdWJ3RjQyaGZScjYySUtC?=
 =?utf-8?B?SFIzdWs1MVQ3cVIvczBod0xSSkNkdFJ3cWY0K2ZJdFVWeEMySFB0RFBmNkVO?=
 =?utf-8?B?QjJ2UmhoREwwd0h0ZlZoU0FMUDdYUzNXeS8xOWNlbjFuYSt6aWtCS3EwNnkw?=
 =?utf-8?B?UHppaklCMHpkY1hvdFhxM1VQNkYzaXVMK0R2MkJUNjFOdHhMcVVJeXB5dHY5?=
 =?utf-8?B?SFVKd1lBeUhzWHNhdURBRjJTUXNhYjNjdjRiaVR4T2hERXljYm9DWXlCcWlz?=
 =?utf-8?B?Y2drMm9XaXdIWWU3VmM2Uml2WE4vTGZUOUY3VEpXc2tEcmJUR3BYL0szL0Qz?=
 =?utf-8?B?eWo5dWkvYW9oa0d4TjRzUmtYWTRNWXA0dXpFTHlscDdRY0FodnRTQXRURGs0?=
 =?utf-8?B?VVZUc2tYNkE1aDVRaVpyamNtZlVESDkwQWh1NDh6TmpFYVE1bllHbzNIaVNW?=
 =?utf-8?B?VjJVTFZXRUZvWlV6a1BUbkJacTYzK0ZPYWVJbnB1cWZyWXFRKytpOFFvdVNG?=
 =?utf-8?B?SlJEdS9qLzJHOGcyejB4YUxMektJNnNQY3VTcjVxWTVEdFliMGx2ZUNxSW5S?=
 =?utf-8?B?Ykk1bVVwTlI2Q3haWU1HbmJOVHowdmdHRXJ1aWNuc0xGcGQyU3ZYMW1jZFkv?=
 =?utf-8?B?Zk9Pc21QUUZDbmYwbVl3MEJjYXY5SVRHUnV1RDd5ZVFkWllZZjZJWGYvMGMx?=
 =?utf-8?B?dUJ4djNBWC9oSjV4Y0JCenRHNmdEYWYxY3R6S1o3NlBpd21RNTA5RlEzNGRj?=
 =?utf-8?B?bWFQY01jc2lKUzcwaTRYVmozZllMNGJkVEUyM0xkdDRrSE5sb0pmc3hLM0ZU?=
 =?utf-8?B?Tzk2aXNoWk9oUjR5bWVqSExHR0g0VmFtMHVKZXlEQW1XS2lmNU5FWURlSjcv?=
 =?utf-8?B?T1NiTC9lTFBnZTd6Y3Y4M2xzbG5iREVKSlowUzNsdmM5dlIwUyt0Q2JNdlE1?=
 =?utf-8?B?RzY1V3l2QjBodHVmcGhjNy9kVld6Sk1SNm1GODNXdUdlQzkwOWYzUUpBN2tW?=
 =?utf-8?B?cUYxQU44WkhpWGEzUURHUkFQclFQRE9vL2U4OFJ6dTlWOGhNVGExMzNteXQ0?=
 =?utf-8?B?TU0wazhYcVltcGt1bVJ0Y1lJbURVY1VMR3ZsYkN6WXM1VUJBMWZVNkdoZUlm?=
 =?utf-8?B?ci9yTEdsdk8wYjQwVzdERGZyN1Qvc29FOGpaYUtsTnBRUzRTYWpqUzJGYWVn?=
 =?utf-8?B?eHJsQVB2dmtQMG1mSjJrSEVWQVZBbllMS0ZFNmhpRE9DazNQQnNtS2M1SnBR?=
 =?utf-8?B?a2s3bmtBekw0bW1RNTZjT0tGdiswalc1RUdqbW0wSURSTzhtRStpLzg1dW4y?=
 =?utf-8?B?YVdEUm0zUWJoQUdRUUZRNm9IV2hpMk4zMHFOVDRIUlV0bm9adkplcWVtNlNU?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e09228c-2006-4e90-1f9d-08dd8ccb663c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:25:41.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCWeqgqJN1BBkDfQze4nYb/5MgEOg5j1vos2BLqdZAsjCXgbAbLrst9cNnuFYdu+5/OO/N0R5AhGttgNJJ5jwa+rLrLgbLrtFN4gkwxdf7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF5ACB2DC0D
X-OriginatorOrg: intel.com



On 5/6/2025 6:56 AM, Marc Kleine-Budde wrote:
> From: Antonios Salios <antonios@mwa.re>
> 
> The spin lock tx_handling_spinlock in struct m_can_classdev is not
> being initialized. This leads the following spinlock bad magic
> complaint from the kernel, eg. when trying to send CAN frames with
> cansend from can-utils:
> 
> | BUG: spinlock bad magic on CPU#0, cansend/95
> |  lock: 0xff60000002ec1010, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> | CPU: 0 UID: 0 PID: 95 Comm: cansend Not tainted 6.15.0-rc3-00032-ga79be02bba5c #5 NONE
> | Hardware name: MachineWare SIM-V (DT)
> | Call Trace:
> | [<ffffffff800133e0>] dump_backtrace+0x1c/0x24
> | [<ffffffff800022f2>] show_stack+0x28/0x34
> | [<ffffffff8000de3e>] dump_stack_lvl+0x4a/0x68
> | [<ffffffff8000de70>] dump_stack+0x14/0x1c
> | [<ffffffff80003134>] spin_dump+0x62/0x6e
> | [<ffffffff800883ba>] do_raw_spin_lock+0xd0/0x142
> | [<ffffffff807a6fcc>] _raw_spin_lock_irqsave+0x20/0x2c
> | [<ffffffff80536dba>] m_can_start_xmit+0x90/0x34a
> | [<ffffffff806148b0>] dev_hard_start_xmit+0xa6/0xee
> | [<ffffffff8065b730>] sch_direct_xmit+0x114/0x292
> | [<ffffffff80614e2a>] __dev_queue_xmit+0x3b0/0xaa8
> | [<ffffffff8073b8fa>] can_send+0xc6/0x242
> | [<ffffffff8073d1c0>] raw_sendmsg+0x1a8/0x36c
> | [<ffffffff805ebf06>] sock_write_iter+0x9a/0xee
> | [<ffffffff801d06ea>] vfs_write+0x184/0x3a6
> | [<ffffffff801d0a88>] ksys_write+0xa0/0xc0
> | [<ffffffff801d0abc>] __riscv_sys_write+0x14/0x1c
> | [<ffffffff8079ebf8>] do_trap_ecall_u+0x168/0x212
> | [<ffffffff807a830a>] handle_exception+0x146/0x152
> 
> Initializing the spin lock in m_can_class_allocate_dev solves that
> problem.
> 
> Fixes: 1fa80e23c150 ("can: m_can: Introduce a tx_fifo_in_flight counter")
> Signed-off-by: Antonios Salios <antonios@mwa.re>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Link: https://patch.msgid.link/20250425111744.37604-2-antonios@mwa.re
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

