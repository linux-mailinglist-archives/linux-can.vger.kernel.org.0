Return-Path: <linux-can+bounces-3554-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00030AACD42
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 20:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5E04C427F
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 18:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5898028640C;
	Tue,  6 May 2025 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8nvaJMe"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB21917D0;
	Tue,  6 May 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746556163; cv=fail; b=Es7mu1f2nwqVVTgx4Qi8m7Pft4ueqG0IjQLIRQI8/qUKX8sAWq+rn2T/X1JI9ocZnw/yJMtGuSPGA67CXNgkINX20KgYAPu0scS6kv6DeWnAFRpG8CE7FfPhOEyl1dOdiamndBhNmeLTS1WiMAEWpr1Jw+EGb5M7loaQSmXXM30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746556163; c=relaxed/simple;
	bh=fvnZO5mcth8AOOXblD+/gF3/loANEkgMvoo+DL5AFXU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rm9KisfimdemTFtyxIjIHvtsiT0zvqVI5MAt0ku9pETFCpfu6IhwdMtG0/4oTITWDn2Lk760BILKwKtofXzUNx3B18YKgn8DEI1fcd12cDuHHc9hyJgNE5I4J+jU2fIuUAKfMqi/1rSPziOe23GlYr5HHtTmXXa7hSC9l6Ur/lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8nvaJMe; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746556162; x=1778092162;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fvnZO5mcth8AOOXblD+/gF3/loANEkgMvoo+DL5AFXU=;
  b=l8nvaJMeyUtltfjFGKO/2cTi/sRCmE8OFlGTgrqWWzAq0/cySSR+tmO1
   bvW6VzEMX10eLtac9BuGYn5gJLmvPqKEb0Y4A4CBlgxW+F99Q4DhnM6cP
   8ui3K7n2Pr15CUlvJ2/6lr/1STeDqm51qXHCmEa9lLtB/Ljc2E/yhDP9m
   o6XC0WgWbeBOZ8k+0uXT9eCHg8O2+OAsSpoiE+T94AfXFfwi17n+trKnj
   WZZC4rd7Pu4nJ8mXWjlfhufvvETt16LEE1m9jiT4ju1Hq5XiMBmG05dQZ
   2hAffBp8UR//e7d2cDgY7OntBG1WG2oKoOSLDsqGGdRsWEdRCNNegX3wm
   Q==;
X-CSE-ConnectionGUID: lFL+fbytSTmvzfqd1xF4Jw==
X-CSE-MsgGUID: gpDsThHzQAeA7CSk1Th7iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="51896197"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="51896197"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:29:21 -0700
X-CSE-ConnectionGUID: DT/D092WSqSWavZ3b++dIQ==
X-CSE-MsgGUID: 1KQTKWrKRR6DOx2QcKMK3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="135601252"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:29:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:29:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:29:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:29:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=om3/gA89THR+Mx/iS7CsSzXEEfjswrpWN25fjkIwHbGK5512zRSANoIiwIHgU413fbduo8W1v+99tCy2zQBtxKClVrfwSlt2gNQxyoCkWNzIOit66kkUPYSFHYynrZEBLCnkt3PB7n4fe+l9UE1XkicXlDKPQ2iFcZvKAQtEM7x5dRHlizv5WbYpqCkKK97vE90wVIlzIqXbnPhgfxDMzDGmBrnKiaq1iymSb23oi1EYyAAW1ghzb+s0W81RiQmYZz37fvct3JBKE+PzW2ynBqjG7FT3Z/HRstMNi2FNVYFQdmImRGAeJnBhYSIYxP1+LLJ6Qo2Ir6OUGSmjGdzP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfkV8xUpFM0c+rhUU4qC4adTUOSKrrpoZ/btSg2jxQ8=;
 b=E6AU8m9P1Aq+fnKSmytsSoQAQ42T7sVWaPB74gerSXvVO3LSZjYt/OGmpmX6fm8MgRDzo+MtWR9pPynafI1/jj3QRGlHglQNzDOd6HpTtH15PdgH2K2mOeWtJ/s6pGkrd/09eJ21aNkrGfVNd+HAoORTdAqY4edktcP+1+gFgcxPiCYYKAdyK9KCmzk57WNTjIhMd7ACf83oZ69A++Fh3predVzejNcV1nOXNAs+FTkFScTXiz9w5/1HBAY2QOcB/7YUTShsE5FhWFwb+vrpUFiOpjW07XfKg0jz2/f3i2FqbGZ/wV1xsOC2QjLIPHrHYiXUtoekyLZ45k1hlrIP3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5123.namprd11.prod.outlook.com (2603:10b6:303:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 18:29:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:29:14 +0000
Message-ID: <09889011-29f9-4a0d-9087-0bb4a135498d@intel.com>
Date: Tue, 6 May 2025 11:29:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/6] can: rockchip_canfd: rkcanfd_remove(): fix order
 of unregistration calls
To: Marc Kleine-Budde <mkl@pengutronix.de>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-can@vger.kernel.org>,
	<kernel@pengutronix.de>, <stable@vger.kernel.org>, Markus Schneider-Pargmann
	<msp@baylibre.com>
References: <20250506135939.652543-1-mkl@pengutronix.de>
 <20250506135939.652543-5-mkl@pengutronix.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250506135939.652543-5-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:303:b5::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 68620abe-3513-4b7c-b03b-08dd8ccbe717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmxIZTRoK2lEWmlLZmQ5c1NOMWNKRnd6RU95NXF0QUN5VmkxZk9XUDR4U0VB?=
 =?utf-8?B?MDl4d1AvbXByV0hsQzg5dS9vZjM2eW1YWUdtdXJmaEplbnU0RXZ3Z1hRUVJt?=
 =?utf-8?B?RW1hRk1jSGRZQkVISVM4c3YxaWt6c2x6U0kvTFhETnhlUW1Zay9ucEplYkRu?=
 =?utf-8?B?MFZuRWQwQ0Q3MDhSc05lTSs1djlKaHNwYVYxdCtIN2tLVVd3VVpONlRTaDVS?=
 =?utf-8?B?UnZtd2QwWm1laHU2Zk1jRFExZzJHSnFkK2RzZkRYcE1DU1hEOGVrYjZQZG5R?=
 =?utf-8?B?TnYyU2ZkRWdFTCtWbjVaRG1uRDU5elNvTDUrdVRvd2ZEOFd2OHJIUXU2cTNR?=
 =?utf-8?B?VnpOSmlUa0FYS0RSZ1VURmQwekNxSGRKVGZiaTEveGpoMm95MTZ2NjFheG1q?=
 =?utf-8?B?YUEwRmhUMmpKcGN3NENqM1c1TmRCMWRITG1tK1JCbjRpY3Y4MUpYQmoxWUJw?=
 =?utf-8?B?c0RXZUE3U05pNkdaeTUvVlhPbmNKcWRXVE5pK1o0MDJKbmV3SHBXT0RaVG45?=
 =?utf-8?B?Z25ZSXpQRnZLakQwWWtQMWJvWVNISWZId29Sbml4QlhiNVdLKzZ6bFlDL2xQ?=
 =?utf-8?B?Nm05YVk3ak5wS3ZQZXk0Mk1XTTgrN2RHbElRbkhRSmRDOXdFRUUwMUNNdzBn?=
 =?utf-8?B?Z0gwZEtqV0NCZXQ4RUFoeVZPMlY1K25sdlV3bTdJNGRnaVdtV25peFlBK0Nn?=
 =?utf-8?B?czdoY21PN1VlcWVMNXlvUFhRc1hqZmlXUDZ4cVpjTGVudUcwSGsyMUZ4cS9X?=
 =?utf-8?B?Q0lMSDg0MFZ0WmpSMjltWDAwZlRDTzA4ZnRaYWRIdVJaZDhZalc3L2NnR2xr?=
 =?utf-8?B?cGh1SnNQNU1VVmtOZ1NWK2RCYmt4K3BtZmo2STlsbjRCRGlBMWYrQ1JyZkFN?=
 =?utf-8?B?OFNIYjVSMy9hTGhyTzZocWxtREtJUlhRTlVyaHpDZWwrWlFwSzkrYmgxMDR2?=
 =?utf-8?B?WVRGYWFLZDdqdDJaelBHSDQ1QUdZQ3FRR3QyNzNKc1Z3WXFQQ2h6bVVHUk1R?=
 =?utf-8?B?dVNNR3dIQnVNbmQ3VitUakM3cmFXQzNkSTNkL1NGbkxwMmd4TlhiVk5BRTR4?=
 =?utf-8?B?d3VXajlFVXdkZmc5L2dBbEFDUU5GV0ZraVd6TU41TjdNUk0vMGZEY2VnelpB?=
 =?utf-8?B?eTRNZExybkNhWURBV0FwKzMybXVPQzdVeStqd3VVSy90UGszNnZ6ZXQrUjNx?=
 =?utf-8?B?SStzdVIzbDRldHIxRFB1QkxrZnJuYVFLTngzNURScDROMVFxRzlnSHNDMkow?=
 =?utf-8?B?M1JHY29CWTFCM3RibWx2MzgxaE1JekkvWjhOcHlNMUl0UG5JZGU3TnU4MEhB?=
 =?utf-8?B?SEZZS1B5S0RJNHdNblhlSHMvSjE3Y0tJS1kvQWxWR01GVnBTak1KLy9QcDhW?=
 =?utf-8?B?MTZqZGlVaXJhcEwzQnhpWVlnQUpYVUpOVXRVYVVRK09HYUlPR2lHL3RDcDRj?=
 =?utf-8?B?dHBZYXhZNXlpdmRpUWg4TXUyMmpOMzh5bnhjdEtvT09TMnlQT2RKWUVucEtI?=
 =?utf-8?B?bk5PQW9sVGIyeGh0OTV6eTF4U1h6VGwvdlVldWd6Y0RLYlg1VXF5NWQ4OE4w?=
 =?utf-8?B?a0JNTUtFM3FiSGlqK1ZYVFBuKytYUWI2MEZ1RENDK0JnMkZwWUxuU3Q3SXJ0?=
 =?utf-8?B?VHc3NzU1aW5DN2pSbVFZSmZPKytlUGEva0hoTkZHOUNSZUxtaVhCd3dCUEdw?=
 =?utf-8?B?cUl2RE9RZW5sTUVjdDJXbnI3V2Q4aEFUNEVPUkk3NVJYYkJZMjBKYkRQTVhE?=
 =?utf-8?B?MC9uanZoRTN1SmR6bnVHdEVxd1JWNWl5bXcraXhMbmZvTzFhMm1WS1hzVXNP?=
 =?utf-8?Q?uBfajFKFsdieHqOO2Q8AYQoccE9ROYKTRQTdw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGNQN21Gd21QVldJWHVNQ3cyRTJtcTRPUEpuUnYwR09iR2ZrYU9SUHIvWCtH?=
 =?utf-8?B?UUp2VG8zU05jdGZwRW1odVlwM01wdUNYQVhtSzRFM09JSm5FVUIzM1FJaXk5?=
 =?utf-8?B?WnlDc3A2ZGVmR1RjNkhiNGhNSGtoZkdOYVFDV0c0SU5jUzM2TDNLalFRbFFM?=
 =?utf-8?B?YUNFYW1kUVlmV0hHNDM3RHBJaTNYUG1aN2NPd04wNHdKSk94RXpQV2g4d1RB?=
 =?utf-8?B?R1N5ckZFM2lVVHRSaHJFN25MaE5uS1VKTkEzZWt3N2ZaTUxFSFN6b1N6UTMw?=
 =?utf-8?B?dEFjV013VzZhYmpNK09HbnFOck44S3Q5TXpENGU2VTdrUC9YOTZmZktab2Jx?=
 =?utf-8?B?U1NqZU9YYjRpSityQmR2Zm9iOHU3QjJZWXBSRE5ZclVsNmZCaFVPNlV2U24w?=
 =?utf-8?B?MTdxb2RpcFZpSS9PWTNtN3JUMVNXdW83emlEdWxCUjh2NzhWU1QyWkpLWXNw?=
 =?utf-8?B?bTJqdnlqTksyS1hsQ01nSXVSbkZwZExQRjNidGtDemVLM1d5ZlFCeGdzYUdV?=
 =?utf-8?B?RWZtRUl4Q2F5YVh2Tk1OSHE1T0NlbTVvcEtQUlM3TDc0Y29XVTZXR0t1dk41?=
 =?utf-8?B?OFlPUExITVF0ZDV3UG1DL1llZXozeUFRakw1eDJrbEJpRHVySm5QdVFQemhU?=
 =?utf-8?B?MnBWQVdSMW5VUDF0dFp0YjEwdHZzYUFNZ3NOQjNIZmJFWFIyUUN1R3p6alpG?=
 =?utf-8?B?NFlOK2hZb3dHWS9FSWhQRDcyYUU2bnZXcXZxU0dGbmJ0SXNocDNOVk0rS09a?=
 =?utf-8?B?V2REWi9XbnFuVnVaTzNiOXM0a1ZaY2YvOHo1R25FbWtsaGw3K09VZjVIUGdP?=
 =?utf-8?B?QXJFZkkwcFdBTi9tMHF6WjFFNlVrcnBNZVlvZjhMQSs3TUh0aUtwVWMyWjlV?=
 =?utf-8?B?aGx1bThETFFNdzQya3BTMGtBLzA2RW9IMEJMVHFKQnJXcW5PQ1MvdGphWk8w?=
 =?utf-8?B?YWc0bVVMWUk1M1FlS3BzZXN0RGNyLzZPT3FKUTUvc2lieGNxV1grMS91Y0Jt?=
 =?utf-8?B?WHZBdUlMcHEvbk1JbXk5MWsxbUlBTFdzdGZNcnlQY3lwMTNya3BXNDBKMjRN?=
 =?utf-8?B?VkZaV1RjTHVmcXk2d2wyV0l0VXFGTEY2bmdsUUdqbEdzcWxrWDZmWUdYRjBq?=
 =?utf-8?B?cmdjTW5HeEtpU1YrdGhRSE1FT3Z3cXJNOGwvWWVaYU9xZ2tuNXNCL1AvcnRr?=
 =?utf-8?B?emlRMFZkQTlVbGRkSERGZWZpelRSeUxwbU0rYUdEVlVsRlh5b1k2K044VXdz?=
 =?utf-8?B?aWZoL0RwamxLU2F4U0hvR1g5cDNwb0xJcVJGNVFnMk9SR3dOZjRLQzA5YnZX?=
 =?utf-8?B?dk1icVd6YWhGVnE2dnJiSjcwbDBZM2JSWU51bEFQeHhXbEVQVVQ2aytzMFJq?=
 =?utf-8?B?Mk5WWElwSmVSb2NiRjhneWN5cVVGZU5oQ1ROa2c2ZGJ6VndzYXY0cUpoVzMr?=
 =?utf-8?B?WTRhQnlsUHNWODEwbDBvUTlYd25KVFVtSmI0NWdVT0Jjc0JkaEJuVG9VODFW?=
 =?utf-8?B?WDI2RzhraTZkUHI5QnlTc3VSWHRNdnJnM084NldUR1VObGF2eE5ieCtOUUhn?=
 =?utf-8?B?Z2d2NlE3UmdUakZwM1o2ZXZURm5mTlRkVGgyM1RaR3BVN0RkRGIyKzg1T2M1?=
 =?utf-8?B?TGlIUmg4V1VzZVQwMllzc1hVR3hBMmRYRjdmdzRPZGFQeVVsT3ZJSlBXVGZQ?=
 =?utf-8?B?Z0h0TVpPTC8wTUxiSHF1SFIwQVEvUW5tbWVmNnFzTHhQeXlmVVo1RkdaWWdJ?=
 =?utf-8?B?RFdkS2tqK2hEeW1lMkZ3anB0N3VpcDhhV2kyc2c1c00rMWU1YnVxWTg4L0Za?=
 =?utf-8?B?aFpJUUpNNC9wNVJqRFVRek84V0oxaCt2ZXBub3lvcDZpcGt6c2R5YkhRL2th?=
 =?utf-8?B?R3N1MmVKMDBxOEx2ZVdVNkZKcGc0b1VQemFRQUE5Vys1STRQQjFaSTRGVk5W?=
 =?utf-8?B?Zmx2MDRHZDZIQ2FmemUrYXowRHlGNnVXc0hWWDkrb2ZPWFNKTjA4VkZMbTNp?=
 =?utf-8?B?UUk1OUVrd2VEWFVlZHFpdWVkUlE0WFZJNFdycGhNV3ZLL1RFdm1URDIvaHhQ?=
 =?utf-8?B?VU5rdHJUSVAya1FkaWFQeHdLU0V5dFJwMG5GT0NkTGZ2V3NLR1l3VkUzZE1P?=
 =?utf-8?B?WlFMREZPZnp6S0dDODROclllN2dtc2VrWTkxZk9lQVo0a3FFdFQvMkpVNytN?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68620abe-3513-4b7c-b03b-08dd8ccbe717
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:29:14.2365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4QE15Up6422YqkufZn/MyKlN9Hm8u27Ch7RroBqZ+XqUcd5ee+M3pdH3LLVbK/S41J5wnF+01crgQUpYfmsWN8EAYDhGItzna1R+SF/Qxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5123
X-OriginatorOrg: intel.com



On 5/6/2025 6:56 AM, Marc Kleine-Budde wrote:
> If a driver is removed, the driver framework invokes the driver's
> remove callback. A CAN driver's remove function calls
> unregister_candev(), which calls net_device_ops::ndo_stop further down
> in the call stack for interfaces which are in the "up" state.
> 
> The removal of the module causes a warning, as can_rx_offload_del()
> deletes the NAPI, while it is still active, because the interface is
> still up.
> 
> To fix the warning, first unregister the network interface, which
> calls net_device_ops::ndo_stop, which disables the NAPI, and then call
> can_rx_offload_del().
> 
> Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20250502-can-rx-offload-del-v1-2-59a9b131589d@pengutronix.de
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

