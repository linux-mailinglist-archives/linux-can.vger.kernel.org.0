Return-Path: <linux-can+bounces-2688-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC14A1A0AD
	for <lists+linux-can@lfdr.de>; Thu, 23 Jan 2025 10:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A339C16E42B
	for <lists+linux-can@lfdr.de>; Thu, 23 Jan 2025 09:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8059820CCCD;
	Thu, 23 Jan 2025 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqC2gWz/"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB7620C49F;
	Thu, 23 Jan 2025 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737623568; cv=fail; b=uBVtDHdN6oS3gJKpTMC30YN9f/L2FAbJRxr+/HEUJnrUsfTxMocbAfEqFdAvYpewBt4jeZROKoyv7NtfOu/rfQFpacb3EruwV4g6ccPwN/WTN3kLAL5pnKNLFbWt9X3KIrBrg62Ji12qwopEZGxhP1xscuVql9w+0UH0lLb3Fzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737623568; c=relaxed/simple;
	bh=eJH5aWY3EvrmlNQiOEnAfbJOJ9eR365dnu/fuIseK54=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QTFsKgupe9FGrdqGzZRoxugjFU/eArF2nxXH5PGx1v3PRLsq9eiD3lMZONDSSS1GhGAJ8ghtK8RnfhKDfGYBz6vK4pIIkCr/or4cwniF6yjPM8cv5ucZ1OYlSOQaIuxXPxqKGKF1VjH26aQS6Tu65x6Pqf+85/cZRfHPoaACor0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqC2gWz/; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737623567; x=1769159567;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eJH5aWY3EvrmlNQiOEnAfbJOJ9eR365dnu/fuIseK54=;
  b=aqC2gWz/RmF1k+0PZHYBg4MAxabJajDESmJ4LdoKxDiwZ5VV9NU37A4X
   Hu8L76hxIkgZdylL6y/0OHbognalcsp+sQo4+y591zJYMDKYqXBdEPSZK
   /71kgobw/Ib0fX5aYHGZtjQI1KsRzhOas2EvHHaAn9LDVzB4maLJzOPhT
   F/SIPGyre5M6mQrWc4ZIf/eTkxRNyaIW6AvoyMtz1ZEBX90nPMyR6IjFd
   Y/KXdrKhJLP6DsxuyZK5jS0Su0vDzUemDedWl9fB0LxAeafGea9MKac59
   UhAoMOqmWS8oCrB6koZI1u8yTdBQWrklCFfp19owoHwYtEdLncwstpD4M
   Q==;
X-CSE-ConnectionGUID: Z7npp/8HRgyZZ3EMRb/Q3Q==
X-CSE-MsgGUID: KPKwUHfbT0OZ389zDberTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="63460236"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="63460236"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 01:12:45 -0800
X-CSE-ConnectionGUID: F7sLA33aQ4mr4R1iVkTdxw==
X-CSE-MsgGUID: gytGftuARz+UWG41KtI9Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107253717"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 01:12:45 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 01:12:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 01:12:44 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 01:12:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tY5T3W+l8N0s8k+/V+z/E1NpGCr218t6+CmwW6VdcLxh5K3PgGkw0s2z1LjizhagaZ3gelF4evkCH53oTwRItbzjaG+lgXJ7o96AEsQTnWvm9iIcUNjjH6Wq7roYMVgNaY5jmlqubYD1QfkJt/3m/LpdxtUp5pnREe2h/4pu4OS7Y/wK2byHrffHHL4gH6KjfJYxuOcbH0yLUDFoqS+7f3GFpq1IuxnMXNkrS7FctWSerMrVLBHa4g2MiYD26XbDGeSIjO97bVh+997/rB3JSuJSuBESYCPvKx9ui+9iUS4zRIshoJhGvLaHDI1mSBZLBNthmd1L+S1tkcPVqv+0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTTXYb91HOheB0cU8J+H8fV61peXV2b5Nj3eVakS5+Y=;
 b=sZ5pYr6fpTS/le2VQzZGNGW98XQbA/MDZm//bAVsySFjXci7g5fvmLlXnL+VuRowyy7s9Qfr1ouDMFRL/3RP9jkdRiAAf2CM7Z6Q/W49Loc2JseeKa3chjAAMNZ6EbsrZHpSV387j4oiQzOXC7+k7zJUKspe5FRNPD2/uEnbP7kGSRzRch8m8Q70RnevUd+n1JYQpOAaZyxCtfQK7LubxCw68jFphLlNDsU+zETMdfSY4Nkdp0Shf9KHQjPv7e8hp2dvVX6ZdY73KjTVGuGwmDaT2Xaz7EXkmELX8cIfJnHBcTt5FCFdPH3S68W4PS3H3HnE4PBpZT1i68ai/nz/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 09:12:29 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 09:12:29 +0000
Message-ID: <69da3515-13c8-4626-a2b8-cce7c625da43@intel.com>
Date: Thu, 23 Jan 2025 10:12:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] documentation: networking: fix spelling mistakes
To: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
CC: <shuah@kernel.org>, <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kernel-mentees@vger.kernel.org>, <socketcan@hartkopp.net>,
	<mkl@pengutronix.de>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>, <corbet@lwn.net>
References: <20250123082521.59997-1-khaledelnaggarlinux@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250123082521.59997-1-khaledelnaggarlinux@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::33) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: b42128cf-dec1-4eeb-e2ac-08dd3b8e0fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REt0bUxQWG1XU1lJY2xsUjJjSVNzVURKVXZpUjE2Uy9ZMEU5eFNiM1hYbDVH?=
 =?utf-8?B?VUVUalcwaERIdWRKcHBuZXFGUFZMb3B3UWx1VmNkcXoxWnlsVXgvRkd2L2VS?=
 =?utf-8?B?b3lyaTBKdXk2Q3RadVpIVmtLdVFCa2hScjREQXMzTFE1ZU5pWS9ObFdrbUNV?=
 =?utf-8?B?R2tpdVZBK2JzVVBCczN3M0E5WWJEQXlKdUY3WGFrcVFXRGZvUmk3TzAyZ2wx?=
 =?utf-8?B?dlVUZWNidWN1ZFJtbWFpMGpZc2Q1L3VnWHcxcEZYaGY3aVZ6cW5xVUl4a25F?=
 =?utf-8?B?WEJMaVV0anNLRnJvY0JsNXRQMnZrWWMweDlXWmZVTzhWMFAvSWdwRzR5SExE?=
 =?utf-8?B?dEFKdkFUT3JMaTRIZklpem1XYlI2Y08vSUxuMGVkdzhNSnRhTjB4b29VeU5J?=
 =?utf-8?B?ckNBUkdNaGpPV2IvakhHRWRPbGdZWHhsMjNwRXRqc09kOFhNVmcyeE54QXpr?=
 =?utf-8?B?WlNkdWU1NzBzRGZoeEw1eHlBYm0vL24wVXFyUUtJalVWcmNONFByQXlOUElN?=
 =?utf-8?B?RkJlS0pFYVlKb2U0YWJwMlB3VDM1RU5oajAxUlBzbExRRnBIT0cvOXVaenY5?=
 =?utf-8?B?YkE1aEpSdi9SaEhYRk5jdHorNGNaeFRnUWZsTE1PNDZCR3NuZ3NweDQwV3Q1?=
 =?utf-8?B?UmZmd1g5Wm1GbFpaaENRQk1XUkc4SmpPc1JacVFVSWI4WEFkc0xpWFRSbnRR?=
 =?utf-8?B?VVZPV3psZkJHY3ZjNDZwRzVKYzJCdHAraUlYWS9XbWJDanR5TG1hQjVOc1Ey?=
 =?utf-8?B?STlSUHVpSkVYMUl3ekhib2xUc1J1TFprUk5YYWFmTlYxR0JabFQ0SzYreUhu?=
 =?utf-8?B?bEUyUW1qa0lGbXMxbEtuWW01cCsyQWZML29zQkc2cjEvTExiMWs1OElDV3lB?=
 =?utf-8?B?Y1RCV2c4Vm5qUjlLM3J5YUpSMjI0QlR1aVdJcUpCWVlFSEhGTGg1TTRpaTZX?=
 =?utf-8?B?Y2ZyUUhBT3Y0ejMwd1RlYWRTbDlqeTFOd3E2VFk4RHdIOEZVellnejVsTDlv?=
 =?utf-8?B?OHZXL2R0cXJLc010b2FndWtibk12NHZzckIwb2ZrbWhOZzZNQ1VWeG5QLytY?=
 =?utf-8?B?Z1cwWWZacy9MdGs0V3owa2hZMHF2OFlJbCt6NE1jU3ZVK2JxSmdaRk9hcE8v?=
 =?utf-8?B?UXlGVUxJQUJVMHdzM29mU1FsMEg2SHkyNWYrTVNsWGU1RUZsMnpaTkpXY0M1?=
 =?utf-8?B?cWRJYVZBVEZ6RGRScGZIQVpZampkMUswQW1yTUxrdnJxYU5SNlBmb0k2OXBr?=
 =?utf-8?B?WCtUa2JudGlGc2xXc3NXdk9POTZHU3FwTGVqTVlyZml5d2hqNXN5V3d2bDVQ?=
 =?utf-8?B?aTlnTTBTS3h6dW4yQTNvNkZIQ3dGQ1BIY2Q2Ym8xcFFiQitibG9YZmFvMW9B?=
 =?utf-8?B?aVFYNnFUS1dXUUlQZk85ODBONXBlU1lpb1pPbGtLSThWSGtnUjFHemlIVEVP?=
 =?utf-8?B?Z0dJVG84TElXVFlrcEhUSWYyR0kvdVpJaG95WW8wbnRUS3R3ZmpDRTd4SElM?=
 =?utf-8?B?U1U4dkZZbnN1NXVGUFVuSFF4MllVU1BTSVFVbDBqa3dwYkR4cjdYdGRKdm5E?=
 =?utf-8?B?a0t4VlR3d1BBU0F5ZVczVm9Xam9qVWVySjBsSmt6ZUVSMlR4aXZIV2RjOFBZ?=
 =?utf-8?B?REs5NWQ1OGVjNGNTeTF2ZUJiRFZqMUEwdVFPaHRpSDg5aFZRR2N1RW1jWEpS?=
 =?utf-8?B?RzN0V1E5VURpcWZac3RxYXZGQ3JHbE9HZTcvb2QzNFB2d2V1V2Mzb0t3TzdW?=
 =?utf-8?B?U0ZDam1vSS8xaFJWS29sd2UwTE9SY0ZwTnpoMjhZakdUaXV0N2FtZmo0M01y?=
 =?utf-8?B?U0cxRmlUeUFWQnp2TWlvZ0xNVnlVVkV3dkp4eHpxOWl0UUxwTFh1SlFDbklu?=
 =?utf-8?Q?2OSwctQBblPni?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDhaaGZMWEhPN2hTRG1mSDZSUHFaWGVzdU9zc3pRbHUycDNpb1VvVjM0eFJk?=
 =?utf-8?B?ajBhck9IRktzVFRUVy9FR3lKYmNBQjg4am00UER4dkRzWitnbTZxclpxNkx2?=
 =?utf-8?B?aFNMVkdVS3A5ODhPQUxwSEdZSlpqRmJ6TzRKWXZ1TnNwZ3NEZ0tNaFFYT2ow?=
 =?utf-8?B?bjNxSWNSWnA4dmNjWDZFdENNaTBaaExkcGdrQUtsQXdCN1BCZFJYWVlFQlRW?=
 =?utf-8?B?K3RSYmxnRFpIM1pVNktMQU4wMDZxaE9jQ29INjY2ZHdyVUFnaWlGL1JyVCtr?=
 =?utf-8?B?OHV0aFZuVjRRVHlCZkx0MkZCUm1rMSttQXgwd0ZvMTUxcTZsRmpacE5SUU5r?=
 =?utf-8?B?ZE03NHFRK3lTb1VVUlEzYVpXNXZuRUQzWkUydlI2WjR3T1J5b0pmZUNRbk5u?=
 =?utf-8?B?eEdXQnFoYjN6cHk5aUdjeFdSWEIxbEUzVnVKdkVydkQ5TWJuNVhZMjhMeEE3?=
 =?utf-8?B?b1FTeld3QWp0S3N6NEF1Y0dtNmZJaW5UcStHenNhM2t2UlJHRmx1Q1o2ZDY1?=
 =?utf-8?B?SU9iTTZRZXMwZFFXNjdoQXYzektqWDducEpwMUp6djVLNHhkWmloakpHS216?=
 =?utf-8?B?YmM4ZW9kMWE4UVhaQ3pLcWZMTFEzOXVMeFZvZEhpRFMwdEwzYldHZVdjTzhD?=
 =?utf-8?B?K3hUZHFXaUVsN1o0aVVsTGo5cGdhK1hLc2tMUEZKdFRSdkMzVHZEZk1YaEND?=
 =?utf-8?B?UmdIVHJrTUZYU2JwMXBEdDZRMFQxL3pLdzBMUGQ3R3oxSWFtT3RsajNuSHpU?=
 =?utf-8?B?aHhXYjQ2ZGx1OWJ0bVF6cEU5dkZwRmVQUFg4WGh2bDRlSlpCZVFUZ1VTMGFP?=
 =?utf-8?B?M0t5ZE9HaGlJWlhaTnlLdUt1NjQ4NTl1b045cXZYNjc2d1I0eVEyR3RYT0Y4?=
 =?utf-8?B?VVg3dzdUMDc5RExzYWFYcDE1VGNBVXBNQ0FOOEFnOFVld3g5clFabWY2ZkFM?=
 =?utf-8?B?enBxMmZCWCs3QnUzZWdubkJWN3hIcDREbk5BU3hvL1UxQkRQaUtTYlNSNlEz?=
 =?utf-8?B?QXhpOHc4NVR3bngvckFreW9zNk45UFdYbjF2dG95eDRFVzVkdld5M1lSRjho?=
 =?utf-8?B?M1ZMc2FFa1E2MlIwVmpOMDczOTFNMll3RlhtTVFOZGhNQ2tuR2tubWd1SFo3?=
 =?utf-8?B?Y004bkIxc3FvOWdSMitZWFlNQTJNakRyQmVEdG9IY2VJeUx4b3J5UTdYaWt6?=
 =?utf-8?B?WEtoaWo0WVAzMERlS1hkTGE2NENWQjFxZTVPcW8vT3ZXMEZxOVoxVStyaFlw?=
 =?utf-8?B?cUt0aWhxU25QUTJuUjNPWGVVbkdUVWQ0WEs5TXdocFZyUjJla291cFpuODZ4?=
 =?utf-8?B?VDVrQjFMdnVHMHRFZzUzdHNwZ0VLWE1wRTV5S3RpYXEyRFdLSWQzbFdtNWlj?=
 =?utf-8?B?V1RPOXJNYlV3SjZTOTkxTmgycVdaaThXWnBRbXdjNzhNTzdPYlZLRnV4cVF2?=
 =?utf-8?B?SlpYbHBVdjlXTWdyRWJwWjcwa0xRNE9aSFhPL2R5SjBxbzlQam5MNGpBa0lm?=
 =?utf-8?B?TEdFWmdmaWNwL2RIRC9Nc212L3VITTZJZ1Fqd21YTXIyTy96czRnamhYbW5K?=
 =?utf-8?B?QVFHNDA3QVNsMC9hK0phWHdFb3VoZTRKeGF5OHhjcHZxU2xRRmFNalhvR2NU?=
 =?utf-8?B?dko5Ym1vMlBEeWFGa1BaNjZCRFpxTU9GOG1nYkdLcWM5cGNXLzlaR2p5b1lU?=
 =?utf-8?B?QzNrbEwrU21PaVcxVEJUbzR5d3c1K1FmM3laME1oY1Y3cWxmRXR5eXFDQjJY?=
 =?utf-8?B?YWFIUnpVcWR3VEx2Z1NCZ1B5NlFpdGJPR3BNWWdzUFA0WWFNYm43VGRlRnhn?=
 =?utf-8?B?bzIrQnpmQW9QSEJybG9PTVJJVG14YVZkZ0Jnb2lFNFUwcGFIQU9SVjQ1UVA0?=
 =?utf-8?B?TnZUMU92UTRCRnhjcGdXK3JERXAycWY5RWVtQW9KN0tEM3QrWFJ5K0UwK2da?=
 =?utf-8?B?Y0paOGNQS0tHeERaQkNPSm9YYnhJMm9uTTBTa1Arc0N2Tmlpb2JuNGJKOGgx?=
 =?utf-8?B?a1g3eFNreXRUYXNSOEdEeVpRdlRiZERnRm80Nnd3dTRXNGVRNGZ3T1R3SVdX?=
 =?utf-8?B?RFZCL01VcTF5Mi9RUmxFVmFLSWJqU2lXTS9WaStFYXdHYmw4d1BtUm1mNDB2?=
 =?utf-8?B?MksxRk5GN1ZzSXNKaTZVVmRRMmlkR0NiZTZxK3VhU1dZUzVvbXpoVVpsd243?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b42128cf-dec1-4eeb-e2ac-08dd3b8e0fc8
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 09:12:29.4493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0daRQS4AwT1AOa4/GRsNCs/93kSdPuJuwMyqDTgWWuEXAwDExjxwbiCzkVVmjeZMwtT/+2nBU3MldNrGr22eKrpSVPtyzKeE0Sv3iaguac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8182
X-OriginatorOrg: intel.com

On 1/23/25 09:25, Khaled Elnaggar wrote:
> Fix a couple of typos/spelling mistakes in the documentation.
> 
> Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
> ---
> Hello, I hope the patch is self-explanatory. Please let me know if you
> have any comments.

looks good, also process wise, also this comment is properly put

(one thing to possibly improve would be to put "net" as the target in
the subject (see other patches on the netdev mailing list); for
non-fixes it would be "net-next"; but don't resubmit just for that)

I'm assuming you have fixed all the typos in that two files, with that:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> 
> Aside: CCing Shuah and linux-kernel-mentees as I am working on the mentorship
> application tasks.
> 
> Thanks
> Khaled
> ---
>   Documentation/networking/can.rst  | 4 ++--
>   Documentation/networking/napi.rst | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
> index 62519d38c58b..b018ce346392 100644
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -699,10 +699,10 @@ RAW socket option CAN_RAW_JOIN_FILTERS
> 
>   The CAN_RAW socket can set multiple CAN identifier specific filters that
>   lead to multiple filters in the af_can.c filter processing. These filters
> -are indenpendent from each other which leads to logical OR'ed filters when
> +are independent from each other which leads to logical OR'ed filters when
>   applied (see :ref:`socketcan-rawfilter`).
> 
> -This socket option joines the given CAN filters in the way that only CAN
> +This socket option joins the given CAN filters in the way that only CAN
>   frames are passed to user space that matched *all* given CAN filters. The
>   semantic for the applied filters is therefore changed to a logical AND.
> 
> diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
> index 6083210ab2a4..f970a2be271a 100644
> --- a/Documentation/networking/napi.rst
> +++ b/Documentation/networking/napi.rst
> @@ -362,7 +362,7 @@ It is expected that ``irq-suspend-timeout`` will be set to a value much larger
>   than ``gro_flush_timeout`` as ``irq-suspend-timeout`` should suspend IRQs for
>   the duration of one userland processing cycle.
> 
> -While it is not stricly necessary to use ``napi_defer_hard_irqs`` and
> +While it is not strictly necessary to use ``napi_defer_hard_irqs`` and
>   ``gro_flush_timeout`` to use IRQ suspension, their use is strongly
>   recommended.
> 
> --
> 2.45.2
> 
> 


