Return-Path: <linux-can+bounces-3556-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91352AACD50
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 20:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF441C008B1
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 18:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BE72857FB;
	Tue,  6 May 2025 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gj1Qb6lH"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D081C5D55;
	Tue,  6 May 2025 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746556324; cv=fail; b=CZXMXfRJzwOYT58a/b8yPM4HKoDkv/9SVQKwjPowg2/j5OI71i7HW1UxixrHRFhUJC07cpeRvEZ5MwtadT6yODnq/N84iUm19HOUjfiawzNnmPRLI6koT1XeCMFL/nmSr5Up04nr/esPcpPIViVUbCG3sfmBLInAAuFfmQxxpXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746556324; c=relaxed/simple;
	bh=kcW2iK8H2dI4kXTHYhOYElBRr7vqk+NqLaCUEaH70gA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mROY9+BhC8W1kValdTzTS0WuBKOD5rMqWvO6RXrmmE+4/UCwUi/1v1phXdeR1uVtWzjhj5CMllVyYKL0XzP4tZy4HZMGEwEDDkrhVuxDYusi5VfEYStjJVSGKgbAqQ0ea+9jkSUi1rXeGjG9f5oIPx0OvqdzBlYr41k3uDjbKz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gj1Qb6lH; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746556323; x=1778092323;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kcW2iK8H2dI4kXTHYhOYElBRr7vqk+NqLaCUEaH70gA=;
  b=Gj1Qb6lHn+hHmXfkg6QYuBzf3uHs6y9C4RJFNOGN8qWzqbT3NowY8hat
   UufMD61uqz4vA4uqf+FmUcUKwVzA8PR+wQAhxlV///mDexpnEDlXPJ8Bv
   B3cFsOML/3BprpT9ecj9lz6koQglO0i+69WVhEN0OiycfIE/VDNWip2G8
   Xx6iLIEptzhQqTXIMOmhobk9EPbY1J51HakPh4kSeai7qfrMnJBZlEEkr
   BvnU0jvdcy1UBer528D9hJMqEkNRyAEULIxcbOuogCASrc/x7eOYHdCk3
   UA5yza0xCjMh+rcdYZx/T2qflHcMRezVEDCp5kQOoiUSYFDVtvt5irKm9
   Q==;
X-CSE-ConnectionGUID: Q4tS+heWRXavcWfWNi2I6A==
X-CSE-MsgGUID: 38vcmzxQQkyzRP11WmWxKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59234778"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="59234778"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:32:03 -0700
X-CSE-ConnectionGUID: BHaecmvmSwK81cWLRUKMvA==
X-CSE-MsgGUID: 2D4t/+DPRG2hUD7YA9Bn8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="172897261"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:32:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:32:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:32:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:32:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSPmj3bEQLOPX8JLL681zS49GyQN4qF/711g+UHwoCgu9GPvD/wVxWPk5EktUiM8NT/eIPoqltBKlH53PsYlSi198O2PuaEpaCYeXRgZq9QViJOdCJGI+sx0ihVCZWwSPIs/Tw9q0+L7Ae7z+Whn8e7shdzOJQk49EjW7HZEejwFl1CREJUXFCGVRjtCFu3v+nrE+t6vplnnsINjuJQ3O84QMkD1HBaTbJgYeZPC5verTglBkNhFjuSvOJHpVy1/4NbEY8sG2lW8QfNgx/nXAS7JDnVSYCAUd0b3NE/+f7CKpko6ddRPHSKVJE4EStzYKcrd3qZmZTNZswB5pND6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsJ9gM9jGHMvUumyqD1B8QDc4joB5hV6oKF8WsWbGrc=;
 b=p9zb9Dhwp1Xmtc3A/TFcEKOfMQMkBSO0BDK1Ht1xE8R6rDxoboVBQpeXKd5vSWP3jWoWZ719oStnvcYdGBQn6NcmWgXWrSDw+1wbQGtENPdbC+MojujXeQ3M3YPut8EfA8byxyoVrbcYTeeC/iC+4YifF8cjZ9wVhQ6+HHfnNnc4T0aH5v0ETDQG0Dg58kBGj759geekKED2xaiYJfqsGs5IenG9E64hJygXjKKuMuSsGKROD5x7ewrIhlBc1B79kg/m0+N9sk2thVxIUG4CWyANVyMP45EXDGPj6kFOgAjgEdhXUAK2zPVGhU4/EqOuWX8Ugu63ZGvHj1gp9Sf2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB7497.namprd11.prod.outlook.com (2603:10b6:510:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 18:31:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:31:53 +0000
Message-ID: <a48f2f20-6aea-400e-a441-7273c5349e2f@intel.com>
Date: Tue, 6 May 2025 11:31:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 6/6] can: gw: fix RCU/BH usage in cgw_create_job()
To: Marc Kleine-Budde <mkl@pengutronix.de>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-can@vger.kernel.org>,
	<kernel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>
References: <20250506135939.652543-1-mkl@pengutronix.de>
 <20250506135939.652543-7-mkl@pengutronix.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250506135939.652543-7-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:303:85::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 699a4b0c-ff7d-456d-7958-08dd8ccc4612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjVnOFF5UzRGaThCUGppZzE2UnQ1N1FDajBsVldhVmFCRyt3SkNDVExpV0lN?=
 =?utf-8?B?V1ZPS1Z3bk5rQU1QVGZQSmp2Y3Jiek9KQ1p5VzZvVjRnaTJlcGVFOUJ5Qk04?=
 =?utf-8?B?emhmSG9yK0gxZE1NWlg0aE1VUHhjR3BZZmFXb3RyR1VTU3FVeUVzc0ZMQ3h6?=
 =?utf-8?B?eFhqQzNiTk12cWxlTUVjeVd2L0JkSW1Ua2tMNS9ONytVY3BLcG1MSWp2ZnZh?=
 =?utf-8?B?MkJWUENYN1pPR3dJaEVHczU5QWZUUHpoQUpXTHVXdjBmUmxQSUR6VzBtWVlQ?=
 =?utf-8?B?U0EzenZZTDJoWkxSZ21wb1k3c2ZFbGZEdTh1SnRqZEhOOVlMNFBKOHdLUDNS?=
 =?utf-8?B?blNkRndTa1JFRTQrNVNOVmt2SGhvRk4rZjlYSzhVYVp1eVJrZm1yeGhWN1Vz?=
 =?utf-8?B?M1B2cXNHR0svRjNGeVNDeFdjSmE3ZlZ6eDdlcEJzVUNmMmtvbndaZTRqQ0FS?=
 =?utf-8?B?SWh3TzBsKzB3OUxsSlBlRVdZSVFFVWFnK21rYXkyaktwcVFsQ1VXa09mVVZu?=
 =?utf-8?B?OUJEOTFLbk1wOWRXK2J0UHJBcGxJU3RpQ2QvbEVoTnFpNGNVZU5INUNiM0dN?=
 =?utf-8?B?VEoxYk9KUmkzYW9XRG1RVUMwOWpXWmU2WFo3MUJpUXhlMm0wcWVZNDVaQVZj?=
 =?utf-8?B?OGM0eVR3cjRpT084RzFaVjhHRDVkUDF1ejNRZWFCWTlSVDBXZUpGcWljTjJX?=
 =?utf-8?B?N1hRanR1aFpYaDNYS0k4SE1wV2w2VkRzQTdwam5qVC90QmpHQi9uOHcwWm5R?=
 =?utf-8?B?SDNtOW5VQUpZa3NnUDhtTmxaOU9Oa3ZRWVd2eEx5L1NnQTBTU2h3ZCtOQ2xn?=
 =?utf-8?B?SEVNSHhWZjhPOGVvaFRuZzBnR3pIL05DbmtudlFwcHhLOGIrUVJJSUltN1Zl?=
 =?utf-8?B?Q0EwNmNTL0RjdTU1MGdvTHRxaUFiamEyTE1OSzBBR1ZoN0R0Q0djc1A2QXpv?=
 =?utf-8?B?WllObHNYNXNqTHQ0Q2luZVVmT0JuL1AvWWxuWnR2MHJRSEp1MDUrVko5c1p0?=
 =?utf-8?B?VzJKTCtOWVY1bXdsSFpYdTRuampCS2YwZ05NRmNTKzVRV2xBYVduT081bFBw?=
 =?utf-8?B?VisvNW1MYlM5Q1BMVjR3MVBxM05GR2IwTmw4TVEvcDNiQUVQVWtHSkxaUm5i?=
 =?utf-8?B?dU5aamtvRVpYMUU0Zm5IK3JkNDRkenRNWlNaSU04L1lBZW9OaExLWDJnc25N?=
 =?utf-8?B?KzBuc0pSdHg3b2pJRUtPZzNxWHRqaXU5dy8zYW9qR091S2RNWUVtNnJkbVVC?=
 =?utf-8?B?ai9ENXhrSzRNV2JyVEVMcG9BU0Q3OEcvUmRXVDl1c1lzcWVnVmZ1VjMrVFNy?=
 =?utf-8?B?dEk3NkNSenRTN0JUSlhmc3ZXbTJCZXJDUFEvK3VOTWNMeXE2eGVvMVpBQ3U2?=
 =?utf-8?B?bmpqNURGaS9wY2g5WXdVNWxqYmFWY3ZJY05GajEvN1JxQlBtVG90Rml5aXBU?=
 =?utf-8?B?OWVvdHZ6dTZISjZsQ2tLd3VXMDNvSGdLQnhMM0w1Qk1nK2NneUZhakFWVEYv?=
 =?utf-8?B?SThYeFFFVDdyaDUvTmRJU3dBNk0yaVppTmxVNGNjcHRNcm9JQ29WMVp2VXl0?=
 =?utf-8?B?YWM1TzBkRnBCN3VaaXI0MkdzRnpzWWZ4dlZERGRXVnZpK0FnTnJ0Zng1OHlW?=
 =?utf-8?B?NkRmczVJYWFGbjRKZDdqRjFGMlMzWGx3TFFyeGdMWlBSbThNU1BGVVpxVkZl?=
 =?utf-8?B?N29Vand0Yy84ZldDNkRKdG1QVnBJdXg2VTJEZkNJbEdwelRSTXl0ZFBtNHRE?=
 =?utf-8?B?OWFSdW1EbHNjNUFzRkJZdjZuN0hpWWI2MURsSlo0elhyOEpDdXdnTGZsYkNE?=
 =?utf-8?Q?76WgFJInSMdJTiUAmTV72K/EE/YzWFvHYwIwU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2hxdUUxWC9yQnRid0ZiL2gwK2tRYnRVRFp3NldXOXVTRVlkSUpBSmFza1o2?=
 =?utf-8?B?NmJiL3JjUW81Yk9BT0lMMmx6bTlBNzgzcnRnbmFPcE1kTDJDNWhETnMxTTdS?=
 =?utf-8?B?TGlaWU5Nc3psQldtNGtxek9NZVlGKzh5NGg1eGNKRyt5ZDNzVE00Y0NUUDNk?=
 =?utf-8?B?Q2dDanFKSnkvZVRkZGl4NUZ2UklIWGxxbFFNSzd2ZUNlYUVCdWpTTDhGWFFo?=
 =?utf-8?B?S2dDNDlkNVpyb1FaTVRDWkFuS3lLcEFseGhsZFBtRGo1cEVkRnBPUjFERFRE?=
 =?utf-8?B?S0thZUxLbDZGYjM1OTFnMlJaalJiMGxTNyt2bHk1R1FKZDhLUU44R241dGpH?=
 =?utf-8?B?R1lTMHZDWVVER3d6Y0RDUUZ2WVVzbEF3SEZFbFBKWUxkMUMrVFNGU041QkJx?=
 =?utf-8?B?N3pPS0xOaGtBR2owUHMrOVhzRXZzd1RIZG9IU2VhZzhxWFJReDU3QXpha25L?=
 =?utf-8?B?cktBTTNYYlJ6VkdibW5lRGNLOVQvQUpqeUMyOVNiZFEvZS9vZ29DZ3JuSklv?=
 =?utf-8?B?RTNFSjBnS1MvSHZpSHRrSUNGMEpzL2tOUnUxVDUyaFgwNHRMTk9HZGVnZnNK?=
 =?utf-8?B?Q29ZTVJIM3VETUI2VEFYdndyTlh6ZVQ1ZGhseVF3ZWFoTHNGUVY3WVRDRkdt?=
 =?utf-8?B?Z1F0NDVuRGJxR3lKbjNZWmtGelVpejlDbGJDRCtDYVR6MnFwL3ZveWJNQnU5?=
 =?utf-8?B?WDJmcXU5MWxRZ29nNTRRdkJseFNlZFM0eWhmKzM3LzJyNU44VUpHanVyNGRU?=
 =?utf-8?B?NXczbkd4a3MvbW1HUElRWitFN2Z2blpzVzYxa1puc1l5bHNjaUJXbW9wVmNL?=
 =?utf-8?B?S2xDZnBsNXJ4RTJhWkdsOUJ0Q2pOUEduRXZ1bTVYT3pjcTJMdE9QQ3hmdzZa?=
 =?utf-8?B?Z1VEL0Q1ekF6Zys2RjRYTEdxZVFIVVFGM2NRaDkzYjdObTQrblBOalh4MlM2?=
 =?utf-8?B?SCtLSGNzVkZ3WmRxNWJCcHZxSEZLMkM5ZWlKOURIMkR6cW82aFh3dk9wRUpm?=
 =?utf-8?B?VUpvYktnWGtQaXQ4ZCtGY0ZlRC8rbXVFUXJoS1ppL2N6STlNWURBekVtd1Za?=
 =?utf-8?B?L0tXc2FBSW1RZlJhU1B2cmd2dnJpMG5FS2IzMERtWDllbUtrNkYxL1ltRitp?=
 =?utf-8?B?elpjWElPVGsyQTZKa3kzN3pta296aUJwTkRPM3VvRy9VWFVyZ2Zsbms3NWhk?=
 =?utf-8?B?elRnRkZLZVpaOFVYbitJVitlRmgvcDdjazJqUVk2Y0ZVY0tsdis2anJRYXdr?=
 =?utf-8?B?ZXRBTnJVTnJVRks0KzgwbzI0R05CSVFHZjNyNHNxQVlJeHUwTXN6WGZob0lN?=
 =?utf-8?B?d3NEY2FZNlkyZ043TWNTNjhwSFI3bFVtRTAzQ09VdWo4bi8xRWptTWE1Qm5B?=
 =?utf-8?B?a1NyeWp6cGZEeEJzOG5FVGZNVmhPcitvUXVLMkdtdXh3SEU5MGljYnRKVWxx?=
 =?utf-8?B?VTQvR1dJaHZPbjVyU09UbElHcXRseUNkaWgrRHJ4Nk1tR1VGWmxEL291eVZy?=
 =?utf-8?B?K3l2bG96V2l1TU1qc1FNVWlVVkhyVll6VFZJKzNpaEJZVDkzb0RiN2RqU1J1?=
 =?utf-8?B?b3NtS0FwNWlvK0tYR3lkUzF2YjUybHBGT3AzaXFZUHU3M1hKSnFQSllUcXd0?=
 =?utf-8?B?VDluMGJCRTBxeHFsalFsN1VQRmNHVi9aS292cmxHbVcxQW9MdmVBdmEvNjhv?=
 =?utf-8?B?RkF4a0dPcEJnblFmOVd5c25OdVFJRTBCQnpSUTRYd3hSdjkveWExWG9Bb3pH?=
 =?utf-8?B?cE9QT1FndlY1bm5HU29FdDBOb3FDL1M4TWpua1FRTXpXWlNhS3BaNTdZOFNp?=
 =?utf-8?B?TnliVTlhUWZFc2E1TjBpYm0zM1Z4VHRsZ1Y3MlpPU1NRcWd3SFdnVW1xYnIy?=
 =?utf-8?B?czRXWTZOTXkvTlJ2NW5DTnlrMi93dHYrNURLTVRiTTM0OWN4eVRnZWMzZUxa?=
 =?utf-8?B?OXIzQ0Vpenhpd0VWMGdhb1NtTjJ3L1Zhb25LUFhCckVzWk14ZEVtL0FQeUF3?=
 =?utf-8?B?cjFnUW5ETWVlT1NWc2E4QkNTYjNPMmptbStyRi9QRFNxTDRZWkcxaWx4RjNw?=
 =?utf-8?B?WXF1bWQzOG5hb2p0dXF2WkNPSHpsVWhieGI0Nys3YnJZdVhRVEdSV2k2MXVv?=
 =?utf-8?B?ZzJRZ0NCdGtpbnI3S0d5bFl0MTVDL3Q2N1lBNTFOUDlLMVFCVHVTclRlOVNu?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 699a4b0c-ff7d-456d-7958-08dd8ccc4612
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:31:53.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gs4kWo0xfzKVcatKXHg++DYxcXV21kN8p0+lljvj+pfAZYDIn1WD0r2/A3qrTTlutVncbh6PbM0rvl5D721aTqIi5h1JF8YiN6AG17tNdq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7497
X-OriginatorOrg: intel.com



On 5/6/2025 6:56 AM, Marc Kleine-Budde wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> As reported by Sebastian Andrzej Siewior the use of local_bh_disable()
> is only feasible in uni processor systems to update the modification rules.
> The usual use-case to update the modification rules is to update the data
> of the modifications but not the modification types (AND/OR/XOR/SET) or
> the checksum functions itself.
> 
> To omit additional memory allocations to maintain fast modification
> switching times, the modification description space is doubled at gw-job
> creation time so that only the reference to the active modification
> description is changed under rcu protection.
> 
> Rename cgw_job::mod to cf_mod and make it a RCU pointer. Allocate in
> cgw_create_job() and free it together with cgw_job in
> cgw_job_free_rcu(). Update all users to dereference cgw_job::cf_mod with
> a RCU accessor and if possible once.
> 
> [bigeasy: Replace mod1/mod2 from the Oliver's original patch with dynamic
> allocation, use RCU annotation and accessor]
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Closes: https://lore.kernel.org/linux-can/20231031112349.y0aLoBrz@linutronix.de/
> Fixes: dd895d7f21b2 ("can: cangw: introduce optional uid to reference created routing jobs")
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://patch.msgid.link/20250429070555.cs-7b_eZ@linutronix.de
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

