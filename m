Return-Path: <linux-can+bounces-3553-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3AEAACD40
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 20:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A86B4E5598
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2406E286417;
	Tue,  6 May 2025 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVmlaJp+"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A5A1917D0;
	Tue,  6 May 2025 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746556124; cv=fail; b=SajVgE1BHOl9TCYN93R6/YX0ez666hHMGspCWg2/M4FOnNZqNYjA4WllMCy/zDGtM938QG2wN1hgnIbfoGcP6Nq5CU3ryXrmyfv9dSAhyunzwufseZ7u4UE8MxOpB2MLl+VNfwd6hFINt64tx5i3K/dduW/bNIQtEu5RSnTdQnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746556124; c=relaxed/simple;
	bh=twyrq7hezfhNVnZXPYFz7nkonJsUNguYc3w2hSGV0WE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CShFhYuxqafru9IcdcsCsrk61xWhyXRpIxgkOMWrxcTfCarLktGb2VLmKp/Z8hqjtHDlEKmwBhIUr9Qg+Hxp/x/HRcWS+y9+6VvwQ9ncMFBaQObc5xHLbPgg1ZGmkXkBXMPvn9Q2XXrsYsiborIshV2JypJFpYZAGLouatCwgQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVmlaJp+; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746556122; x=1778092122;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=twyrq7hezfhNVnZXPYFz7nkonJsUNguYc3w2hSGV0WE=;
  b=UVmlaJp+NBjcZMpbLQ4JBFk2vhd9Is6XHc6Nljj2pHvYd2SSHpVacvcD
   SIzOJ9rbHOG3T98FZJLEQ/9M/jq07qshnaYpQTt548u9cFOXGnIFUHF3J
   bUq59sO0qtDXkUrsz3XzmXBEwZ6Ct3g4c3tGS+xiwoVgDas7izxFagBaw
   lMgNPZ9aMqgOhJtu3dDxayErAO/NmNVqqjP58FQjJtzdc9AZ21NfnYcMO
   OW8ZyqTXDmuwZPSBm3hn/me0PKns/1AozekO54VWp+a/9VVv+iKWQeAoX
   oGt80CdROW0gL6LLxnkfccyQeH1PpPeojK1CTifRj9HRoL73/IqqPKd31
   Q==;
X-CSE-ConnectionGUID: 3bzNVPPgQSmLab5T/P062A==
X-CSE-MsgGUID: 3kD49RtsQaq5Hqb7jvBmEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="51896128"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="51896128"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:28:41 -0700
X-CSE-ConnectionGUID: hBIAc2ZrT/GwO4P/GL/YRw==
X-CSE-MsgGUID: HHb7oLXhSsSAKbr6JE1lQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="135601171"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:28:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:28:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:28:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:28:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHVg+siap/3aqxelXxe6eRobbq+D6SlpqraJwrX1MI2ZPJd3LXDg8Ydy2F4fU6YvC/5Qvi4fARvqjorS+IxyZLJr+Y0nCEaGPY+zGt4lObcZ/CvRjqS+x4AztpOi6OKRw58vTA41lBzIlQ7efLDEMDxlRDVxyyWJjEq/WkBH8JJPlRbZvfKR8BF15o2WuoXRYBjtbaIpDnUGhWe/cIBo4c7vHzUSP4oM2MgSMLF2Ldgk1lqzxgb6K6fgCzrFIIT37QDk8v9M2mgOFFrNgq2lG+H0v6xefJoq+1Y7jHkm5v98QVpRe0mVz2ELA8uj+VzoD2vDDdl3QBDPYH9nWmuf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V73+gj1KeaqXc+8CH53qhlNpkVzcZRVwCYW5UsxR4DQ=;
 b=UcvAA/Hj3ktDIJn3Q2XbbL0nhnEDtqkxxsMtKqOAlqb72t6ZECD273jBEr4Wc1JyYscYI1lieQHWFg/d3jPFJY5Vd4gBMR0R9nCXX0GKq+PHlU46rIKltutC13oR8Ud50iHychZ0YPt2Sd2BJOqgtqcnNxv9BAVTb7InDkqVWckDUotyjGYqifxZfCp1hbaji2kv3v+OKxDpbsXbDnndr3Z4eiri2eDcssW3b2JXJ+r4Mc9Sy/ncFG7FoWV34g0//Rgstp7Z//SbhzBr47V+YR/DbkUh57qbSuk0h6oYE/d/J/dRZtE79PydIedEvhkOu0sqSrIx1pqUay6eYJaW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH3PPF5ACB2DC0D.namprd11.prod.outlook.com (2603:10b6:518:1::d23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 18:28:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:28:33 +0000
Message-ID: <f9c7881f-b568-4d06-8266-0aa602edfcbc@intel.com>
Date: Tue, 6 May 2025 11:28:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/6] can: mcp251xfd: mcp251xfd_remove(): fix order of
 unregistration calls
To: Marc Kleine-Budde <mkl@pengutronix.de>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-can@vger.kernel.org>,
	<kernel@pengutronix.de>, <stable@vger.kernel.org>
References: <20250506135939.652543-1-mkl@pengutronix.de>
 <20250506135939.652543-4-mkl@pengutronix.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250506135939.652543-4-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:303:6a::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH3PPF5ACB2DC0D:EE_
X-MS-Office365-Filtering-Correlation-Id: 283f2b24-979f-4e5c-bae8-08dd8ccbceab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXgvb3pFaFAzcFhwOU9ENE1TUFk4MFo3dmQxazU0d1lDWkl3L1RzVGFCcml4?=
 =?utf-8?B?bVBxeXBzaUMzT0RiWjdqb29qbmlqaFJ5em1IcFl5WG84czdKNm1ONEV2bHdX?=
 =?utf-8?B?Qmp0a0RVWjB5ZE5aVWlITGlhNXQ2V05QQU9IYXJlYS94NnVHSTFJdzhhNjRs?=
 =?utf-8?B?V0tIVHRqemdKcUY2cit5Tzl2YVhtOUFxYjdkbXFKR0NidUhGRW9YZkh2SW5p?=
 =?utf-8?B?eXp3SUowREFBQnpHNWdUdVk5b3YzMmUwTXlQczlVT2ZSMDdHS3ovS0JzTFA4?=
 =?utf-8?B?VXg4RVdXRzUwQ1lkZlBqUjQwR1plZjd6NW1MakJBNmtoUUMwOHJ5MG5DeTJT?=
 =?utf-8?B?SytzTGl5RnQ0eTdXMnB5RTN1emwwbU9HeW4xbjNyZzZBKzVrTTF4NkttTnJq?=
 =?utf-8?B?VEJVUU5QYTF0SDRRNXhTRVNOV3R0NVdxNW5ncnlCYUNCaDNxWUNDUThwVEk0?=
 =?utf-8?B?SytjTGVlNFhaMVJIZFIvOTB0d2RkcmlMKzY5ZFJUUEZDWEF6NUVsUEFpcWJG?=
 =?utf-8?B?NUw2akFFRVdlU2tMZ3BEeTdhODdPYUdOZFUxZlRlU1NCRmhlWkduOU1TM2dC?=
 =?utf-8?B?Q0NsQnBQRlpCSVVGQXlGNWl4d2JSS0lzcE9BRFJyczJaRDVaVkhRTVdEVjlT?=
 =?utf-8?B?R2RYWHB5bDdNVlFBNlMxOVdHMzRvUHZ3VlV5QVpYWGhZVklxcVRsMXhjMWVI?=
 =?utf-8?B?UUxoK1pBOFF2ZEZnSXUzb1N0YTgzYnZLNEpEWGRQSURESnlPV0tTTGFvN2Fl?=
 =?utf-8?B?eUttL2VOa1R4SXpRTEdaTGRIU2NNTzdObkNQUjJSb2lKbzRkVkdaek1RdmFU?=
 =?utf-8?B?cWpRZW81bDJHNGFCdmhGV25ZS1dOSVdKNkV0czhkQWNqUUxTWHNHaEQ3cW1J?=
 =?utf-8?B?TzB6SVdCM3I5Wm1YY0xaRDRhYWdVdFMxcVV4WUJwWmpSSVkvcDhnOThhMjVz?=
 =?utf-8?B?S0YrS0lpaFdsWkR4a0VSTENrOERVbXVWSkRxSE9reDdWZmZGTmhKbjJBNW4r?=
 =?utf-8?B?UmtldWZ1L0ZUTkpGRFkvZHRHbk1zcGxORW1aVlhJcTBXR2dDemFzd0JlTGVz?=
 =?utf-8?B?cEtCSUJKYkxKcHVOaFFvbTRDRzE4WnVEMWN3QXdpSXJOb0lKT3NZVFNjdVhF?=
 =?utf-8?B?a25OUW1rTTVoQ3JjcjlwV3hwZFRnSjUwRmthczhNbTR6SWh5RnZta1B3WUlQ?=
 =?utf-8?B?TnRqSEFNM1lHcytISnJXbWRSY3U1NWl5bXFacXBTTDhjWDNnWXRFVHFiSWFu?=
 =?utf-8?B?d0pyNWoyT2xVc3BtYzE2SmpxeE1jR3JvVEczUWFhUFUyS1Zaa1NYdDVTMVl0?=
 =?utf-8?B?Tk9TeENHa0JIR2oyQU1EYUJPZi9QbElOSzkzU01LLy8welFnaXd3SDExL3E4?=
 =?utf-8?B?ZW9qUDRHVXdvQkgyNGRaMjNPT3ZCYy9Vd3BuMksxSzRCRG1nbU9wTjB3OHd1?=
 =?utf-8?B?QlhiQk9zdUlHZnpyWXdwUkpjS0I5dE9kV3RiZUhqM3I1NUJBeVNxUnhVUXVZ?=
 =?utf-8?B?WFNQWXh0RHJUZytZUHh4cnhIQ0MyaXRNSHhKUnF4L3RXdHpzcm5tdDJUOThn?=
 =?utf-8?B?QndpUnpRYXZ4dXBZM0hBL3ozQlNKNWcrbUFtUUF6eEV0Sng0VGNHK3pOdVAv?=
 =?utf-8?B?NFZnY3kvUTJVUmwwNWFvRFJFNUhpZW1WOE53cXlRNm5tNUNxV0cvYXJKcUlk?=
 =?utf-8?B?L1piaVhNc2lRQ2pOTzhvcktZeUJsWkxyZkZlVVdPc1pPTFNEL0l6OXZVa3Bn?=
 =?utf-8?B?SXpxY2ora1NwS1U1Mk5HZVFlTkNob0toVURYMTNqQk5HOFFUYXkvajNMclhL?=
 =?utf-8?Q?1vD5cKikFCiKqjIWwTsdG4Xu7duoVhpxMfiEs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkJKT1FlRVVPbnVoeU5HSVA5ZTA4SVk1L2tMOHJENDlKMXlUdmJUK1o2a0hX?=
 =?utf-8?B?WFhOalh5ZFlTaEZzVlJPVWw0YXhqb3JIWEtyRjFnTWRQSGxoNUFHaEtlUTNw?=
 =?utf-8?B?eG5RaW1iYzBNZjc3WnY2RHZJSm1CV1lDcmc3M3dRYnNmWENNQWk3aHRVY0Uz?=
 =?utf-8?B?VnlUNGREc0N6cXFHUWx5ekE3bHE3VnQrZW91bXVFWU4veGdxMWVyVUhnQ2py?=
 =?utf-8?B?R2dDZ3luL0NvWTl0Ym0wMUJSdjlYeWh5WXo0MnJMRDFxSEJlZmdrTmllbjFx?=
 =?utf-8?B?SHB3eVhzaGsyS2JiNmQ2a1hya1RsQ2hOMjNnUXgvMnhtTHpVQU1uLzdVWGRE?=
 =?utf-8?B?UTVreGErSXZkTGR5RHhJTzY3ZXpvci9BTmMweDd2OTVkRVRtR1lSMWdmWHd3?=
 =?utf-8?B?ekg5NVhZTk5EWHZna0Z4V1VIUllucTNPTVdVMC9lTm4vejNBMk9vUXVzUTYy?=
 =?utf-8?B?QmM5SnMzNUQyL2tRcEdPQVRzZ0REZDhGWmZWVWRPQ05MbU5tWEo5b2RiZVBm?=
 =?utf-8?B?UjdMbUdQbTZVTUNubERyZHp5ZmtsUTk5RnNRSVU2VnlENVlpRDdXbG5mVGJq?=
 =?utf-8?B?UG50d1JjZzUyZnlSa1RMajlSUGxjd2Q0aGpjKzVtL3k4ejVRaThNRFJ5QlRo?=
 =?utf-8?B?YkhnMFdiWE9seDFnU0dkZkMvNmVVRVJqbTRHTnBMMWhZc01KbytYb0N0bVhs?=
 =?utf-8?B?T0NoVE9DbmY5ZWhtdnY1VUJJS0NCZWNzbXRmR01PV1V4RW94ZEJCTGlDM2gr?=
 =?utf-8?B?NWRPMUlqY3l6b1FhVmF6NlQwRmZnWEFqWWt1cUh2cDdmbWFNRWRUbS9iWUpC?=
 =?utf-8?B?QUQ1M0MwVmlFNURuSFpWdFBSM0VqaGdoK2k0Z0s5dUY3d21vY2wrUlFNNlU0?=
 =?utf-8?B?Zkl1dEFleUdlbTJLWGVNekhQZHlnNXFpN3pBNjdxRTJHQjBUL21oeGZ3NGFE?=
 =?utf-8?B?dnlyaHI3M0t3UnN2SnZUUnp5cDVzWVJoT0ZSK0V6anFsTHIzOUtmL0dSaHg4?=
 =?utf-8?B?c25qekttYjFvbVBJbkVWajFLL1lGSjV2Uk0zLzkvZUhGa1d6N3VlTVB5dXpX?=
 =?utf-8?B?RXg1SW5BbkY4aGprbkJFUE1uU3dGYWFxaDFOUGk2dGVaeENUNFIyRHJBMHgy?=
 =?utf-8?B?NUxyODlpWERjZzNRM1pRbU5OaWNQWUhQT01KT3Qrb2luTld0TlhEdUhzenR1?=
 =?utf-8?B?d1JTWGs4MTE1WDk5dGxOWTFjQkxtdkt6NFhkREtUckNkSlViM3NBd1Q5YWto?=
 =?utf-8?B?dFA2alQ4ODJsMzFQREsvVTVPc1hqVHZXTHpXQ3VyT2NEY2hSWmdQeHNubmlG?=
 =?utf-8?B?Z0FvSWdCOGVhUU0reVRJb29mUFlsVllVak9GemxqTklyRWVrM1lFYXA2ODFO?=
 =?utf-8?B?NmNTMDdZY0lRRDdJYUFseEZxdTErMXBXdXZnYjA0M3VUM3M5dXYyUnIreE5s?=
 =?utf-8?B?Q0lkVXJlMEhFQ0g3VG5GSVRPMHFheUFtYklJWU5wb0F6bnZvcFh3U3R4MWxn?=
 =?utf-8?B?YUt5N01HT1N1YVZMWFVDbkhrNFJRbmtyM29PaFZVV1kzd2tDZmdpRmRvOGg1?=
 =?utf-8?B?bnhGUndQWkcvU1o1TzA4amNTNFFIQ2l3cHdmek5jOWc4d3J0dkd2UzZWTlhJ?=
 =?utf-8?B?cWRUN2tsWlg4azhleXBrcU1qcVg5QmZWZ2ZLTzU3eGFROCt3cC9iUTZYT3Vm?=
 =?utf-8?B?ZzNSUDJFeUVTREpIMUpINGtacXErRUJHaXhiYVU1MnNtV0VQOWRmWTJ3dG5i?=
 =?utf-8?B?TGc4WWZIS1NRbjFrZE5YMnlCOW9jQjhkQzBRbVJQRVJKc3JpNWljaGxNZmVa?=
 =?utf-8?B?bTdZTWovK1ZocHo2bUxFc1piNDFBT0h0NndqUHBtWkR6ejViY1dIWHlNY29X?=
 =?utf-8?B?cnMxVDNHSHNRa0Yzc09CR3pkZEhyM1pvQTZZdDBKNmZUMTd4NlBWczJTNy9x?=
 =?utf-8?B?UERzMm8vdnpwMFpjQlFjM0lyMXk2TG5RTEpwSXVjSTR4bU9jaitnUHlJelVo?=
 =?utf-8?B?TGxtTkF3QlU1cVkrMVlLaXZKZUZFY1pwV2xFdExMZlVUN2xZRFhlMUQrM2My?=
 =?utf-8?B?Z2hDSm1Gak9ha1BwMnZoY2NMUW8yeTRabVZNemdmMUhnNmFoWTNMcG95TGh0?=
 =?utf-8?B?S1VlcnZUT1dKa0RKSGxMampMc1k3TUFmNThLQWNqMGZlSzZYR2YzMUpzOGxW?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 283f2b24-979f-4e5c-bae8-08dd8ccbceab
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:28:33.1540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+rxPOjuxON2L/f8cGU9XYqdEUy6ktFK6qPyCYTjtOTQAOabU8lGUMTyANYysLK/bQrmaY7bRf4Zgr4LAuzXq8x/6FZjBvkJJyUF/mnIjOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF5ACB2DC0D
X-OriginatorOrg: intel.com



On 5/6/2025 6:56 AM, Marc Kleine-Budde wrote:
> If a driver is removed, the driver framework invokes the driver's
> remove callback. A CAN driver's remove function calls
> unregister_candev(), which calls net_device_ops::ndo_stop further down
> in the call stack for interfaces which are in the "up" state.
> 
> With the mcp251xfd driver the removal of the module causes the
> following warning:
> 
> | WARNING: CPU: 0 PID: 352 at net/core/dev.c:7342 __netif_napi_del_locked+0xc8/0xd8
> 
> as can_rx_offload_del() deletes the NAPI, while it is still active,
> because the interface is still up.
> 
> To fix the warning, first unregister the network interface, which
> calls net_device_ops::ndo_stop, which disables the NAPI, and then call
> can_rx_offload_del().
> 
> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20250502-can-rx-offload-del-v1-1-59a9b131589d@pengutronix.de
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

