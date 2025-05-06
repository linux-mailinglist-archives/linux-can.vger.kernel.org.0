Return-Path: <linux-can+bounces-3552-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68075AACD3E
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 20:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB923BEDE5
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 18:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2127628641E;
	Tue,  6 May 2025 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZ/iWqAq"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE231917D0;
	Tue,  6 May 2025 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746556078; cv=fail; b=FVXH17CQd8gK3iKxc+NQcPvRJbBAC2NLwtG4WWBt3k0ygNsISBSLMySE+SJ6lsJ/vNjDhYfAn7Y3gHHb3I6OPaJuTqJFKMOEUjGtYo1oJAsFbXrisuzMLaYHy6iXy6R9aJj7GKeAhI5PIqcS5KWVJSdCre0uiMNrQEhjhwpGhTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746556078; c=relaxed/simple;
	bh=11AFKVSz2Zs5JEHk5HTs7UVu40gw++0SFcSHBuSD3sE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c/VFAJgBHwOGbF/qT9FBaGPCtoM4OVoDatK+gLet+ChkZchgXiF5okJgwT7bKu+zNRtndyPtvHp/DPniYr3zFN2nViM/LgLwv2jjqxayTUeXq48fciEAYZYCE3LFn0sbCTyEewPQmFs1quN6RiYjlC3leynUcMZ7EstiZIN+mvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZ/iWqAq; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746556076; x=1778092076;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=11AFKVSz2Zs5JEHk5HTs7UVu40gw++0SFcSHBuSD3sE=;
  b=dZ/iWqAqxzM4Eq/+zG6qgVep3LSwAbn4dMkyZseQd03YObWtr+uOKmUC
   0Y+akPtzY5SbrYbX1aQ2iu/PYknx8rug9e7f0Gi8NNRZ72W+B6kUYGNyH
   fTKP/+sIdshR9j7qamkCu6CPxOCerLeqw+D4IU+g6a+P596afjYjMV3AQ
   GI5ISs1fh+4rqDfCJB2+wXBetFauwIvu95fkw6yP/oLJZ67eV/avS6/UQ
   1BWG3JvwG7nb+ESa/rNFk6twPmT7TjuX10vHHYj24JSd6gjxJN/BRBLK/
   5+5bFOawJ5VOdxCev/qDgOa1p34ZPNWUoQFuXTqZIGUNa9M/Yws2ABnE5
   A==;
X-CSE-ConnectionGUID: SJQbDeeKQRyhrQwrJyFaMA==
X-CSE-MsgGUID: /MFr5pkJS7q1+X38xrZ6dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48152877"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="48152877"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:27:55 -0700
X-CSE-ConnectionGUID: xoiOPtoTQ46XzE8EL1yW3g==
X-CSE-MsgGUID: tNC+MtLqQUy2FsQH8q4ziA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140811302"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:27:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:27:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:27:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:27:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snXIVs38vQtHzp8uA4x+CXWRk5OpdiwU5nU7F/CNC+J5e3+6NgmzjTxaQzcWwZdhNxaVGp3xIXLrNFVCom8GoCFB9zyunlonT05xbYedmKibEG/JxtGP64MqRmOmk4PyyY8Q/5y17xETWZNci1+0akP0ALw+qo7klGPAe1PIY4n++1AUDYJXwJdjwRfKqxj2tuZ4Dp9aFfaRmeQ34DqjbYWosDEdSkHbtKS1LUmK/Eov/1Dya/ov3hPYh5r6GegoQ5j2TCsX/kmB6ntpcml7VrTWnL5KFSN4oZI0QPKmkfjcw/4XqtMqRJujqbs2wqBtToWAbKMKYEMJlMOVQYgSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3blok7QCoczwUIOCtXdz3hlN7Lcs5FA/lkqqUxPiM4=;
 b=ss0qYE6OIajF3ADXbFRTtxYG3RG56szbuRG+Yi6a1iqLBGH4oT/nqnJxVn+hoLVvinPdOJLGTgBNsv+5jyE9jpCSFTZIvJvq5+BfM85O8F/g644eox950hTRVtr0d6CkSLEAxb7AAePDFB8RTbE5V8IXcfks0l0ZD+HjarHCExTgDA3TzkSCH2vK4CcT2W5fn3oWxEV+bqQa3KPgeW1ocv33fostu9qmhja35DAYPkYtLhp4aBFtRUR30jFEznU3B6HBi4UZFIhG64GIMonRWblMbBDVww7I0TUO5ydxrMOi6HUozLThiMDDZcJybE98GJhAcTT+upY/aP+s4zRCsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PR11MB8684.namprd11.prod.outlook.com (2603:10b6:0:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 18:27:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:27:47 +0000
Message-ID: <2f4e07d9-36c6-43ce-bfa8-3272598d7d43@intel.com>
Date: Tue, 6 May 2025 11:27:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/6] can: mcp251xfd: fix TDC setting for low data bit
 rates
To: Marc Kleine-Budde <mkl@pengutronix.de>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-can@vger.kernel.org>,
	<kernel@pengutronix.de>, Kelsey Maes <kelsey@vpprocess.com>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>
References: <20250506135939.652543-1-mkl@pengutronix.de>
 <20250506135939.652543-3-mkl@pengutronix.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250506135939.652543-3-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:303:6a::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PR11MB8684:EE_
X-MS-Office365-Filtering-Correlation-Id: b262afd1-e21f-46ce-d765-08dd8ccbb32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cENJelRZelJmY3BZRk00ejQ5NERnZ21hVDRiMXc5aStTT0xZZnY3WEhod2px?=
 =?utf-8?B?eUJLMFhWdElhS0FlUHBYeW5tOWpnd0V0YlRjVkc3Z2pFRGgrQWJ5Ky85OUhy?=
 =?utf-8?B?WC9jWEhzVFpic0RUS2RwTlpXQXdMbEVFR1lXMk9yWDQzdWhudTRqWnFRRm5t?=
 =?utf-8?B?ZmhMZ3l0UEFlVFFPVUNmdWRVQkVnZk1XZVUyeThtam1aNEdVcDczV2pVU0F2?=
 =?utf-8?B?S1FYQXEzcjEweUs1bVRYSElVN2N1NE5OVWRtVDkzYWdXV2ZlMnMvZFEyZ2Rj?=
 =?utf-8?B?aFRQeFBYUXc0U1B3cFFHTS9YZGt0OFZrUmRicTM4UURmcVI2cmJZYndpcldN?=
 =?utf-8?B?cjJNMWdpM0NvSGlQa0NCSFRvaE1ZUVBzZG45azhNOVc1ZjlDdTdYeVhWZy9S?=
 =?utf-8?B?WGhTMXNrcnNPTVpMRmxvbjFHNDMvMjNMRVU5bmxEMU5UWTVFbytySERIbzUv?=
 =?utf-8?B?TWRsSC9ETlJUMERFckZYTEFicnBCNEFUSlNmS25HRm01d2JmUzJYOGE5ZE0x?=
 =?utf-8?B?RnMrTnlqSmo5RkwzSVpZRWNqeVl0SmF1N245THh5LzU5VHNpWjdWdGR0LzVa?=
 =?utf-8?B?bThLK2hPV2RiSGhHS3NLSGVHTzM1ajFDeGwwZFFBc2l6NnFmTjYzYVlxTzMz?=
 =?utf-8?B?RElwOE14QkRJTWRzV1EwWGdXR2VwMytKRW5zWEZGL3RtOHVLOEo0aEZrWTV6?=
 =?utf-8?B?eVl2UWZpcW9MZDB2SldjdE02MTFCY2YwY3JqQVhiM1VkaENQWksxMlZJVXla?=
 =?utf-8?B?aHUwejFTRUxjdGtBbUpUMWhCdGdpUXlqc2hERzhHV2ZUV0Q0Zi9oRmxCb1hu?=
 =?utf-8?B?QkZNZ1IrMWUzTXB2WGZyaEljQ1U1RXZycjRIR2l5TFB1cW5oakd5Y2d6UXNC?=
 =?utf-8?B?UTFZWXJUenNONThXd2NGOXFSUS9NNk9LM3lkZ3dFcTNMOFNjVVJONWpvMkZU?=
 =?utf-8?B?bDRKNGNRa1YrTjNOd1NWYVhXelA3TENCYTh3VEg4cDgrWU5XWk1TOXQzaGJt?=
 =?utf-8?B?bUJqZ0l3dERFbkIzVEZlZVBGS0pWa2RjN1Y5QjBBYVY4bGdYSllzemFZcTVG?=
 =?utf-8?B?L2Y0SVRreUtjL3hIR2VRdlBzWHBlTzIyeTMwMTk0MU5pVGlPMk44R05YVkNW?=
 =?utf-8?B?WlV3TTFKcThxajBuNjdTemVKYU5pOWxwUDQ0ZTF5cTdydlNaeHJKbDhvamg3?=
 =?utf-8?B?OUc0LzNiUFlsbjBxT0JqSzdrU1BWV0dqWTNiQlNxTFZVMXRSaDlMUnFvSkNt?=
 =?utf-8?B?dmp3Wm1XTHhQMlVTaEYyazBtai9sRDZabUQwbkFDYmhTT1M2U1FDNzZBdzdN?=
 =?utf-8?B?YzlCbXpXc1NhK1FWWU9MdkJHa1A0MWZmWExuMlcyaWthZG16QTY3WldWMGNj?=
 =?utf-8?B?WFBtUFNzMlJlSFoyU2lFTE0xK0R3enpPQVpBTkxVa1dxKzdRWHVLNWQrSFRo?=
 =?utf-8?B?dGFoQ0lVQ1hsdyszcFE5UGNHVFFXUmdFZS9pOTU2aFJBMkdzUjU2TXBKNGsx?=
 =?utf-8?B?TDJlRFgrMHBKczc4ZkwwQ0EyWCszd25oaFR6M0Fjdnc5WU1PWXRjb2pjR1J0?=
 =?utf-8?B?WThSMkQybGdnUmtVNUZJSW5zUXBjbGZjMUM5L3g2QTJmeDV2WmJPQTJJV3Jj?=
 =?utf-8?B?OWZ0ZlowbmVjOHN0TjlENk9oSnBqVXdrQk8rbk45M1lnRHZ5MkRseUJ5Qy9E?=
 =?utf-8?B?MkloMVN1MFY0ajJGZGRoZmw1a1p1Rjk0RjFCNVBGdzhzeFNTL3JjeWw4TkZC?=
 =?utf-8?B?RDVSdW5nVkJVbGMwOW5ySGRmZks0YjR0VU80SkNmVU9vTkZ2ZkZ4emgrN215?=
 =?utf-8?Q?C/gINsucnXbD2ng+YhQz3JrynDSCntksotah4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkdGYVB3bUZmZmo4dEd4dHRYZ01lcDdtZ2VSY2tkc2JZNWJsSCtmNUxZc0JH?=
 =?utf-8?B?dDN5VlpMQjJuWkVvNURvVk91elR5U3ZZOVJYL0FLa3Q1TjNSVjY0SFlCZDhF?=
 =?utf-8?B?SUFQZ2R3ZFM2SVJMNlN0VGZza3lDRDYrRE1KZG9WOUl4cFJYc1JjTExaLzJE?=
 =?utf-8?B?SE9nTnFnNC8xWjZoWEhDV0xDRUppVDNScXJyWjYybEJSY0R1Vk85Z3lPRGtk?=
 =?utf-8?B?Y3g3YzZ6eHBGM2RCYktXUXlTOURVVmU0SkRZTkFRNEJvUUhXS2JmYXhwOXFO?=
 =?utf-8?B?L1JiSzZZd1p2bGRUM0xvVHRveTFIem1jTDY2N3pvL3UyOHI3N3FDMVl6VkQy?=
 =?utf-8?B?Zkd1NHprU2NxaGd5Uk5hUytkNXlNYmJQTEQzU3hYdDJVdXVsNmRjNEtTVWNS?=
 =?utf-8?B?UEFhdFE4RmxuWWtZWWFmUExkaTI2UmJNSDcwbDVUQjJXbkpqSUQ5NmpHM3Nv?=
 =?utf-8?B?WDhZeWhsWlZwbGkyMDRuWDZhT3NacVQyNGRhRjhNZlRnSnlTeXhvTGtWYjQ3?=
 =?utf-8?B?QmR3MU9veTRyTmZQY1ZwTWNUNExhdVlGSFNsY1UybEk0RTd0bnd4MkVNZkY3?=
 =?utf-8?B?Y21ubWNJSHJXb281enVvQ3NqTFdDbXpoRHdHbU5COFZnNXJIck5UR2lBY1pq?=
 =?utf-8?B?VXhkYkJNaHMvZFg4cjBBMXcxcUJiTzZzVG5sd3N5eDUxMUc2MEZFR2hVZVFP?=
 =?utf-8?B?YlIwcnF2dStZMk9VV29IY1JDTm9nSEFMejFqcE95S1p1anJ4NngrMktFUDVt?=
 =?utf-8?B?WW1icjlKWGdBSEwyaENuMHBHekZoS0Eya2hyWnFvL3B4d0dNZlZ4Y3Y5Szc2?=
 =?utf-8?B?bkVDTU1tT1pqY2FlRWxwTE9hQm9XNFRBN2hISDJhT3NMRlBVbExrNncxT1Vk?=
 =?utf-8?B?Mk8xTFdxYVpBVnEvQWozL0xRVGZrL3NhS2tlc2NacUZvQWNBbVVyRWMxMmNk?=
 =?utf-8?B?bFl0S29GMTdMejdnakN5cGtYS08yYmI2R1NHendZOFlOUFRoYmVrbnNacmhM?=
 =?utf-8?B?QnAxeXlrWlVlcHNHVFMwd0crSUdmelpUbm9UcGpUZHRWSzBYUDRpVThVeVFu?=
 =?utf-8?B?YlY3YmJIZUN0TGV4M0hHK0hWdTZKMjF2NjZWS2JXd0NRUWJCckRpcm5CTU51?=
 =?utf-8?B?eHREa1lLSVYrZW5KNmNYTmdIT0JxVTNnTzMrcG05Q0toVkVNS2xqeHpFL20v?=
 =?utf-8?B?cjFOOTdvempucys0RngvNzd4U0lRM084OW16cHBSZWN6blYvMFQ5eVdTY2tE?=
 =?utf-8?B?Vk9rS01nKzJoZU5Ma1FZbHJQTkk0eFBhMm9KbEwxa29PaUt4dmgwOHV0VnFJ?=
 =?utf-8?B?RmRQd29HZUxOQ3FTVFVCZGlCSzIxaG4yamYyK0xsNWFjblRlUmJWTkxhcThu?=
 =?utf-8?B?YUdQOTFwbmJsMGRkSjJFaDZzdWRKZitFSE85MWxRb1BZa3AreWJsVWY2emRY?=
 =?utf-8?B?aVFtYjlRczNkNExNZExpRG1jREoxUUovSHMvYWh5bDdYV0ZZNFFZOXZFRjJv?=
 =?utf-8?B?a2RHTk5rTG5CL2cyMzl1WWtjVHJQTFlUN3d2aEJsazdLWkdDQnh4N2NWcnph?=
 =?utf-8?B?aEMzOUp2SzNON3dzSHNjZnpaQ1Q3N3YzcEYwdEtoL2d0ZE9FeEhUcEtWRXE0?=
 =?utf-8?B?QzVML0tBc3hxelpHVXY2eTVhUWl1aWlWUkJuTzB6QUlGQ01SaDBDYnNFdFBD?=
 =?utf-8?B?VExkbUJRRkJJU3JXbU5KcEU2QUgwdlkvZ2RNQlVsSVd5b2YwQjQ2UXlDU2Uy?=
 =?utf-8?B?aWxnVW1CY3J1UlMzd0x1bitYSEhSaWptZDVsSG5TRk5HOWdqUXdvVHFOa3lU?=
 =?utf-8?B?OE9TVU1ES0JwTENLRFl0cnJNcVBOTERIMWcxaTZ4OEtMNVZpQ05Pb0lCN2hQ?=
 =?utf-8?B?UjhtZ0NicDVTV2RlUDdmdkxDRFE4bWJXKy9GMWprOVRQT3YwRWd1dDUxZU9Z?=
 =?utf-8?B?Z3I3ZEFzQmg2d3FKK0RKSmc4bDU1NFRkeGdldGQ4NkNDOFVkRTBTWGxma1Zw?=
 =?utf-8?B?NjBkK0o0ajdZc2oyQ20rTkpIc0k5UUZPUExqb1JCTEcwT1N0dXJlOWlMUFhV?=
 =?utf-8?B?ODdpT3N6MDZpc2RkTEJuSUJZdmxXU2NJY1V3NWJrUDdhenFqdnN2WFh0UXpX?=
 =?utf-8?B?c0FNWVFmN1NYMDZwWXc3RVNkTE1GcEpiMjZ4K05jZnNZSWhmVHNwdFpjN3Nl?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b262afd1-e21f-46ce-d765-08dd8ccbb32e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:27:46.9884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8O1Q1W/eVkOAlDACDm2EdK5yGiU5KHQzijEZf7Y/i6ng3aqVpijxBSHp6CQQezxT4sJYmTyuMW3q7NYX3x5ezdkSTRuHIlTDqWSdkPpoeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8684
X-OriginatorOrg: intel.com



On 5/6/2025 6:56 AM, Marc Kleine-Budde wrote:
> From: Kelsey Maes <kelsey@vpprocess.com>
> 
> The TDC is currently hardcoded enabled. This means that even for lower
> CAN-FD data bitrates (with a DBRP (data bitrate prescaler) > 2) a TDC
> is configured. This leads to a bus-off condition.
> 
> ISO 11898-1 section 11.3.3 says "Transmitter delay compensation" (TDC)
> is only applicable if DBRP is 1 or 2.
> 
> To fix the problem, switch the driver to use the TDC calculation
> provided by the CAN driver framework (which respects ISO 11898-1
> section 11.3.3). This has the positive side effect that userspace can
> control TDC as needed.
> 
> Demonstration of the feature in action:
> | $ ip link set can0 up type can bitrate 125000 dbitrate 500000 fd on
> | $ ip -details link show can0
> | 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
> |     link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
> |     can <FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
> | 	  bitrate 125000 sample-point 0.875
> | 	  tq 50 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 2
> | 	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
> | 	  dbitrate 500000 dsample-point 0.875
> | 	  dtq 125 dprop-seg 6 dphase-seg1 7 dphase-seg2 2 dsjw 1 dbrp 5
> | 	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
> | 	  tdcv 0..63 tdco 0..63
> | 	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0
> | $ ip link set can0 up type can bitrate 1000000 dbitrate 4000000 fd on
> | $ ip -details link show can0
> | 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
> |     link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
> |     can <FD,TDC-AUTO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
> | 	  bitrate 1000000 sample-point 0.750
> | 	  tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 5 brp 1
> | 	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
> | 	  dbitrate 4000000 dsample-point 0.700
> | 	  dtq 25 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1 dbrp 1
> | 	  tdco 7
> | 	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
> | 	  tdcv 0..63 tdco 0..63
> | 	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0
> 
> There has been some confusion about the MCP2518FD using a relative or
> absolute TDCO due to the datasheet specifying a range of [-64,63]. I
> have a custom board with a 40 MHz clock and an estimated loop delay of
> 100 to 216 ns. During testing at a data bit rate of 4 Mbit/s I found
> that using can_get_relative_tdco() resulted in bus-off errors. The
> final TDCO value was 1 which corresponds to a 10% SSP in an absolute
> configuration. This behavior is expected if the TDCO value is really
> absolute and not relative. Using priv->can.tdc.tdco instead results in
> a final TDCO of 8, setting the SSP at exactly 80%. This configuration
> works.
> 
> The automatic, manual, and off TDC modes were tested at speeds up to,
> and including, 8 Mbit/s on real hardware and behave as expected.
> 
> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
> Reported-by: Kelsey Maes <kelsey@vpprocess.com>
> Closes: https://lore.kernel.org/all/C2121586-C87F-4B23-A933-845362C29CA1@vpprocess.com
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Kelsey Maes <kelsey@vpprocess.com>
> Link: https://patch.msgid.link/20250430161501.79370-1-kelsey@vpprocess.com
> [mkl: add comment]
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

