Return-Path: <linux-can+bounces-1242-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B220C966205
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 14:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1FEEB20956
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 12:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA07218E758;
	Fri, 30 Aug 2024 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7TjDHQW"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B2179652;
	Fri, 30 Aug 2024 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022279; cv=fail; b=gVr04Z1pM44+iPvIOQUop68NecPDlQhP1cnr4vLdMiyuV+f7TkWl43qkRaE+G/UVUKSlGoWf3dkRVVBrxDVnvS5qgXgtXSxqKpKTpvuftIJ0+oKyuaqAzWvfxgqPHHgIZMqXQ35PcBNIehqjjkp1cjVF4aDlVQFOhrdYqRFZCsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022279; c=relaxed/simple;
	bh=F7JcJnR12M20bgKiRFfoDQYAAz6N5bQv7o77S5UDK1M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nXMxQzNFNbVYA0b3zt3I0IB/0cek06ql4BKENbnMBJQOs1GgPJk1F+4OUkCMUI+gKVDn16OGywXtpiPOez+XT8HG1NNNoSjGLK4IgEmZD45hw7L3QgsTkLMx8toTp+Jeq1SlnrXoqksDh996gSjZ3nBrrJ0dXJ4lQAJGkwvgmso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7TjDHQW; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725022278; x=1756558278;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F7JcJnR12M20bgKiRFfoDQYAAz6N5bQv7o77S5UDK1M=;
  b=B7TjDHQWvCRLCGfJeHE3c6aCAvLM/SYHAtL6YFqtsORQCPqq9TUQ3Oyq
   /HDTSPa5Z5bIdpMcwuNF+2YS4ra+haZL6GTQ3I6govI9yY6By5ExBWn3J
   jOM18z5Y5su/K44l9cqyoBiP8RlhxvQ7nk+rYdKHzoyEAfOOtiwwDZRHM
   BTYEf5PwAHQT/ABe+3D+TV7lIBM+nojjFdcTzkTeTgWgzlgDgqja/yvoe
   nF4Iy5GU8KEze1EivO8F1+j1Q52OwZujUMhSwwdLok2Ih4fuYiPG0JLj8
   eDuK2Shr3033jnoxFlSn6xHC3JJqhn1DzAKiODYQeeBrEbG6YlRbfJ9Sd
   g==;
X-CSE-ConnectionGUID: uWxxn1UsQ26C5X0wZPLTeQ==
X-CSE-MsgGUID: E2ddRfa4SVSn9J1PtLrDbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="41161187"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="41161187"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 05:51:17 -0700
X-CSE-ConnectionGUID: MkmlSKS9QxSRRUsx7yb4fA==
X-CSE-MsgGUID: 9uarp9QkQD6A/RMkWhwYgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="68293915"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 05:51:17 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 05:51:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 05:51:16 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 05:51:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9LJUZMS/eQFv12dCtwc9UafeSCsEDfTirWQDwOFy2UfM5h1UeDBtGokpwVb6bcoYNkL5SkfCOWih3ajx5rizXsvjo8Oel5XMTY+TFpuXQ3jxlIFiZjdv14Ulr1UNTPMB0sOI0HyYOaFftBCexaYCMAzq/Ya0chhGNLPMXsQYtTiHZtEBi0ZdzC/nybhMI31nHhuoaA5XjEKkgacI/uBcv9Z9C6+Dzf/eBZSv9gTnMxjELTY8sHTc7RacKLynCv+Sxn6wzyhGM6G5k6pW/+vkjNAnQMoMY0PPJwvBexigKfONvRCT39y8tT4yKy+ZLqGDObGKNO4rP8z7d+WrZvWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liRSmD3flD75EBBoS3ykuPqDeDqB1bY2lJN5G4Byoi0=;
 b=JVz7SAZWbNP0A+VTunm0zByogu1/IC13hGvjnOjyjzMPgDm+Ax6DkgUK/oCjFMwB95spkEigX+BfNvxd8DuvPgIt4zLYTSL9QqVaHUE4C8rSgqg1QcFs3zatuDEXFW0MJ4oSL8PXq9YI7ZjWTN8vXJVjLjBJAcaPHf3JW8hv0QAKr+Cslay+OlPSMfIOCbIzRGuXjhLbcS1620rHNkMXr6oL0DOd0h5PFE6CO5UMXMxbLfrWmDKvDNK1iJMYvT2/UGAXKmjZjT83uh7ddZlFuYws7Th/viZUHYk7K2FXKjUZyGUHOovHSAAWXH3ICT+nAu1TxgEWy4rLAiFixIOn9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB6801.namprd11.prod.outlook.com (2603:10b6:510:1c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 12:51:13 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Fri, 30 Aug 2024
 12:51:13 +0000
Message-ID: <e0effc27-f16b-4449-9661-76f0fc330aa9@intel.com>
Date: Fri, 30 Aug 2024 14:50:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] can: kvaser_usb: Simplify with dev_err_probe()
To: Yan Zhen <yanzhen@vivo.com>
CC: <mkl@pengutronix.de>, <mailhol.vincent@wanadoo.fr>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <opensource.kernel@vivo.com>
References: <20240830110651.519119-1-yanzhen@vivo.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240830110651.519119-1-yanzhen@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0087.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 1626d63f-3691-4fdd-332e-08dcc8f26e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djdublZMN1lVZnpGdnZkVEdIQW1oZUFSQzRtQ1N4clZyeUtDdkpUSDArTkl0?=
 =?utf-8?B?TFcwMEZSRE1NVWJXcm9Ka2trdXRxRzhCWnJaakVBaUhraGdvRi9Gazg1Rit5?=
 =?utf-8?B?Zk4wVld5OHZwK055K2dUNk1uUUdaQkIvQW1VbndRaDdzMXNDUkVIa1JRb3pK?=
 =?utf-8?B?YUdTVVJkYnJBdStpTXdKLzJwWTgyTzhJUVhydUVadG5tZkpQb085UGUxNVUx?=
 =?utf-8?B?eVM2VFZqaXFzemg3UDQ0V3lHVncwbWhUQjdIQ3J3SjVNS2IycFAySGdHQXlS?=
 =?utf-8?B?bURobTZwMm54U2t0c3dHbmFVbHIwM0NYb2RmK1Bmazc0NmlmNExEUjU3WEdN?=
 =?utf-8?B?WmNsS3IzMFl6VVJCbW1KL1hMMTJWcktOcHV5UFZYeUZ3TmZMTHZpajE1MHgw?=
 =?utf-8?B?VWl1Tmt4UEFnZXB1N2tyK3VoQWNKSW5uUk1Tc1VGYS8vRHE2NVNWYmRxcldH?=
 =?utf-8?B?QXJJK2EyZFRBaGJFVDA4RGhtYkZrZVQxd2VpL09BdVdvNkoycjVoc3U4Qnlx?=
 =?utf-8?B?ci9KcHRGNGpjV2VvdzNyWW1PY2w3RHBsUHBLdWJreEVkYStkQ0JqY2tFYXNL?=
 =?utf-8?B?YjgzRm9maFJ1WWpPblJveHl4ZkhpZFpTd01NZVc2TGJ4bmdwR1FveWxFenRT?=
 =?utf-8?B?eWtIQWlWa3l1RW5oWXMxTitqT08yckR5R1VUWmYzemxDUDRYbWxGVU96Slla?=
 =?utf-8?B?T2VtNUhsM2pDLzhMU1FueWR6N0Z4UjQ5bXNrelFnYW5UTjF3QTNHZDF2TTRh?=
 =?utf-8?B?bzVUWGF0TmJxdVpRbjZVRXRaMTl4UnZ1UGhEYWxwN0tPMjl6ckpLSVhoYkFh?=
 =?utf-8?B?VzBwWCsxVFpUZTJsaFZmRjEwZW15QXRIaTVPcFJVUWxQOWkxUkZqSEx2REFo?=
 =?utf-8?B?WkpzUENDRVhIZ1E2MjByLzJqaWZpaGNQbHcwYldBOEl5dytyVXNxcDd4S3RC?=
 =?utf-8?B?VE9YeXhuc3Zid1BXdFgzMXBLcjh5RDdGaUV1ZlBGeEdEUGdjcXNHMXpHRWpj?=
 =?utf-8?B?dmNTcmlhbDVHVkRaR1lmQldiUks0MFVGM1VpVzBnTHg2WitEaU9jankrZ3c2?=
 =?utf-8?B?c2N5WUpsNXNnSENKWUl0cFpDUG9jb2JEc0xERDVhYS90dmN1c3pGTDBHeUZm?=
 =?utf-8?B?UEVxbkNOb1dkQVdGNWlOWktaNDhSeFhjMVlmYXV6dVk3Szh0MTkzQlVIOVZD?=
 =?utf-8?B?ZnpRTXBoQTNJbTgyQ1VCdHphUTRYVXJialBVZGduazBlbVc4N1o5K00rREsy?=
 =?utf-8?B?VW5IaGJndWFyZTZHWCtxUFh4c2NsaTdxQnl1d0lVb2UyYmJZSENhQ3pFdGph?=
 =?utf-8?B?T3FRcWZlZytIaHFUNnFNYXVuaXd1c21XSExGQUgrc1c0dWtuN05NWGhPRDVa?=
 =?utf-8?B?RXl5ODZxLzJJT2MxdFhTZjJPYlhwdkl3L1BNL2R1MWJXQnlUNFN4VnRMRUxV?=
 =?utf-8?B?V2ZIM2ZUK25pVUFRN1d4aVFwRW84TEZ3MVNuVUU5Z1RRWlJQNWJnM1RXQVZ4?=
 =?utf-8?B?OEowVkZqM015TTR4bU5YR0RRL2VySlhMek4rWW9FVmszcExXNmloK0pHc0RS?=
 =?utf-8?B?VU9jSzlMSGdLSjJETy9RZGVEdFBldW1TalhnVUF3OGxST3JZcjZXYXJKeGxJ?=
 =?utf-8?B?V1p0ODRaKzYyd1FqZ2l5Y1BGZ0ZyQUtPa2Nnc1FiOHkvTHFZOENsNkNMc0Ew?=
 =?utf-8?B?OGxiaHhXUElZVnhtSlQzRW5NLy83b0ZmVkR1RTI4cDlERGJBaVJkVDJ4NnFw?=
 =?utf-8?B?RGRLaXg2NUVIRnpzRW5QcjkvdEZPczA1VVUvTFEwNnh2RkZwbkYvejFBVlRQ?=
 =?utf-8?B?TmtBRWpQc1ovU2NJbitQQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0t4NXFmSm52dzNubDNva3pCaFNnWUtoRlBQWWN6UW5yK2ZINmxESG50Z1RI?=
 =?utf-8?B?Ky9FUjZCVTVWb1B5bjJwd2UvYzdDcE85dDFtUUhIZHdWcVJsZHVjWjZUcWcx?=
 =?utf-8?B?Kyt6WGE2V2RlTDhRMTQ3eU5wYWJHc05KUnBnNGZSV3JLalBHUGtmQTZVMFZi?=
 =?utf-8?B?UFpmS29QajJnQ25GaC95K2RGV05wZkVMV096dWVkbzcwVXlaWXpVWkduQWJM?=
 =?utf-8?B?dHo3d0JwWGU0UW9mV244SWIwQStUSkx6Mi90Mk4xOXFWNFlxVFprRDBleSs5?=
 =?utf-8?B?ajN6TnNMY3lNemU4c01oV3MxamwxbElzOTdEaWhwV29IRHRtYSs1NFJUU2s2?=
 =?utf-8?B?NUpwbW9Ed09uSDNuVzRLV1B0YjFmd2Njek1kZ0ZjY1VhMStOVnFvcG1RMERL?=
 =?utf-8?B?bVB2bEdMamR3OW1JVUxYNlBkciszNjQ4QlVRV1hGM0VTMjZGUlhJRlFIcG9U?=
 =?utf-8?B?NTZaQmFvaG9PMThaTFdFdTlQZWw5MXVIUHk5TFBkdTczSGVrOWFVMkVxOE9K?=
 =?utf-8?B?Y2YwQ0k2YU16L2gyTlg0ZzBYSTJDSVdDMVN1T3VjaWp3U2lOb1p0d1BmelFt?=
 =?utf-8?B?NFR6UXM3OFhUdjlCZTR6RnNCWmIvSkcwVW1hTkFWTmRxSVpPTGVpMXZHcXlq?=
 =?utf-8?B?YVVIdy9LeUZhNU9aWU8rSzlNRGVBNks5RDBCRGIrTHplYTI4MDlsZ1lFa3Rs?=
 =?utf-8?B?OTNLNmNDd2s5VWtpanVWN3BjamhOdk56VlZsalVaTUhTLzZvU01JZnN4ZW5s?=
 =?utf-8?B?c0dRb1pBRzIvZEhRWHl6cUhBY01kM1MwemFKTllQWmd2NTljSysvQWFnT1Ns?=
 =?utf-8?B?NUlmTjBLL3I5bzl6TC9RY0k3aGN3enRqdFUyMDlkUDdobnd1UVhQc3VvTmxR?=
 =?utf-8?B?U0U3cDZDZzA2SXRNZ2h0WTZoRzRQbkNIQkdXRE5vRU9wSXBlcHpyamZqY3la?=
 =?utf-8?B?eGNidUVEbVlDMkpNenN4WVpvS05WQzYzNzBMZWRISm9lTUdLc29zWEY5M2s2?=
 =?utf-8?B?bHBFZjVrOGs3N1hkVlF5b1BCbFd0U0FodnU2am96VDJNUHJXZm1jWjdhMENG?=
 =?utf-8?B?a2hOTnVSQXlSbStoQlVWZFJ6ZWRnRUZsRnp3anZtclVnVW9SaXVydFZRaWJB?=
 =?utf-8?B?NFMwRmpnbmcyVTl2a2JlZjdzallEckU5VFU5ZWd3ZG1pMk5zT1V1N0VwbjVK?=
 =?utf-8?B?RmRBQ25idkF1SEVUbVlDbUZ5ZXBZVFU5ZFVGZjlscEdTdXhKcUo0UHJDQVF5?=
 =?utf-8?B?WWU2MkJXeXh0bkxIcEdVMkFvNmRGdXJDMUZTejZSdlhvY1ltcWh2YmVwclBC?=
 =?utf-8?B?VThkRjc4d3R2U0V6MlBJNytUN2NaVHhDTkdpOXplcG41ZFpiaTNOWjN3dkNI?=
 =?utf-8?B?TWhjT3d4U3RBSGY1aUcxMG9FOHcyclVwU1d6OEd1b01qTmdaL1VDZ052bnFj?=
 =?utf-8?B?V2UvQzg0d3VWZ3JwejhJVG1mUDNUQmprRE02TkM3MldwSTBSSmI0SG9tMEtM?=
 =?utf-8?B?L21hZjIxM1g2eUZ6Si9uSGc4YTBLa3dsa1FXQTFDejMxQjZ5QnhHRlFqSmdi?=
 =?utf-8?B?UlpqVkFIdHg1WjJxOFFzSzI2UWo4L2NnRC83N3IyTVErZVQvdTg5YlN3MllE?=
 =?utf-8?B?Zmx1ZVpOTktJekV6ZlcvcDRRUFhaOTVYaEFKT3pDTEpVTFE4VnAvaEUzcnhr?=
 =?utf-8?B?cTlJai9HdDRKcHhpWjg2bWE2UkpTdzllMng0SEVpL3VnNzNwYlh5cncya1Jq?=
 =?utf-8?B?dHJUdFcybGlFTEkzNXhUZHRraVNESGRFYnRFUXptLzIybzVkZVZCTnJaTGFH?=
 =?utf-8?B?bUY1eXVtQU1JcDdBck9HYjd5SjZqY1loMUdRT05yUTcwR1Q2bFB2cFlIcit2?=
 =?utf-8?B?S2t5NC9XUDMzalk5ay9OOU1IMERWNGpSL2tZSEsrUi9oNmY0Y2NrcW1WREZQ?=
 =?utf-8?B?WW9YVk91ZDFsakYyV1dQM05jaFRhM1Q2WjR3QnlzOFI4QVMvaFRJeklqdCtD?=
 =?utf-8?B?ZmJObkdyTVkrU2ZSRkxaSDlVUW9Id0RlUGJRRXFyVkFDZkl1VkYya2RRT1NS?=
 =?utf-8?B?OHJVOHFYWlJRamEyM3NnK3VQTUtvZzdnLytYSlFRY3IzeStET0pzSE1UOG83?=
 =?utf-8?B?MEI5UjBTcmRNaHUxZE1HdTNBUGxnQ3p3Smh5TDEra1NKRGh6cTRQd1ZJNDgy?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1626d63f-3691-4fdd-332e-08dcc8f26e02
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 12:51:13.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95QWwMKi9g0rHRYgyLormpoWRcrbuWK8uPAqUXoNFdASh8uM8GIyy/dfqRCu0z58jLEqNU4405Is8V6olioEF5v9bwpeFlOOnlnWAb7mf0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6801
X-OriginatorOrg: intel.com

From: Yan Zhen <yanzhen@vivo.com>
Date: Fri, 30 Aug 2024 19:06:51 +0800

> dev_err_probe() is used to log an error message during the probe process 
> of a device. 
> 
> It can simplify the error path and unify a message template.
> 
> Using this helper is totally fine even if err is known to never
> be -EPROBE_DEFER.
> 
> The benefit compared to a normal dev_err() is the standardized format
> of the error code, it being emitted symbolically and the fact that
> the error code is returned which allows more compact error paths.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>  .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 42 +++++++------------
>  1 file changed, 16 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> index 35b4132b0639..bcf8d870af17 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> @@ -898,10 +898,8 @@ static int kvaser_usb_probe(struct usb_interface *intf,
>  	ops = driver_info->ops;
>  
>  	err = ops->dev_setup_endpoints(dev);
> -	if (err) {
> -		dev_err(&intf->dev, "Cannot get usb endpoint(s)");
> -		return err;
> -	}
> +	if (err)
> +		return dev_err_probe(&intf->dev, err, "Cannot get usb endpoint(s)");
>  
>  	dev->udev = interface_to_usbdev(intf);
>  
> @@ -912,26 +910,20 @@ static int kvaser_usb_probe(struct usb_interface *intf,
>  	dev->card_data.ctrlmode_supported = 0;
>  	dev->card_data.capabilities = 0;
>  	err = ops->dev_init_card(dev);
> -	if (err) {
> -		dev_err(&intf->dev,
> -			"Failed to initialize card, error %d\n", err);
> -		return err;
> -	}
> +	if (err)
> +		return dev_err_probe(&intf->dev, err,
> +					"Failed to initialize card\n");

The line wrap is wrong in all the places where you used it. It should be
aligned to the opening brace, like

		return dev_err_probe(&intf->dev, err,
				     "Failed ...)

Replace one tab with 5 spaces to fix that, here and in the whole patch.

>  
>  	err = ops->dev_get_software_info(dev);
> -	if (err) {
> -		dev_err(&intf->dev,
> -			"Cannot get software info, error %d\n", err);
> -		return err;

Thanks,
Olek

