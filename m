Return-Path: <linux-can+bounces-1198-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E8956A30
	for <lists+linux-can@lfdr.de>; Mon, 19 Aug 2024 14:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D91C288C2D
	for <lists+linux-can@lfdr.de>; Mon, 19 Aug 2024 12:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA70E168491;
	Mon, 19 Aug 2024 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0SLuZeV"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E2166312;
	Mon, 19 Aug 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068842; cv=fail; b=SEwsMoe1yOcSSz4dLI2V1kYWzJN+J4cti184iemdt+DgIDNVoccFMuxMv7emRaMNagJE7ccY+8o2gQfqYigBFofbSGMw/Fwi237C2E9EK8Pq/Bgcex1eiGt33dGY56olFHysYmQJx5PiQhuxMVi145iUEWr0JVBSHwuwRPfinas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068842; c=relaxed/simple;
	bh=4MRXN469J7Rvs0r/2tFv+Sdmelm1WMq0Faxd4oP0nDY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KyxtHlf9+bLaLFqIWvZy4qzCSJq26gueyCadeZu8XksJty/sM3A0DTyjDWC8ucqgJWlWUIVGWcODUgxIYkytFOTmeDushZhfcQ101qI8PikllKr7Y0VNm6RYhdm39alTYvX1UsDh+W3y8LX+8jCQrCojNfJe3AIH1aRn7gTZNIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0SLuZeV; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724068840; x=1755604840;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4MRXN469J7Rvs0r/2tFv+Sdmelm1WMq0Faxd4oP0nDY=;
  b=V0SLuZeVmVGaJGgp5YVOjnJoBXuO51ZFlRcjebyfk5gTR9F2wdbfv6Vu
   ylH3Gz4lfuIwQcrpAuKfPH0kvvakSDoX7sxPnfofZk2yay2phypxAbuN6
   h7ytdfbF5IPJpJ9CWGHqWaCeZsp+Brczsp41d6fssxOkn4vsBT+MUqxpY
   lubC0BBzUO457YS1CMg46QFO9Z6LB+uzQhUdg0MSu/Fm2xR4he95b1Utm
   DwLMiQxG+HAhE+LHWBUe2J7NJXdPWRLc8jI1WJHYr30w08RWELgIDZVvt
   08ZBylcjo6DO8cVD5615lsxfiTQdFyJ4YaqT0+4G/L1fJK1tIWukC8zyW
   w==;
X-CSE-ConnectionGUID: dNsc+4YAQhGBVOkAskX9Mg==
X-CSE-MsgGUID: yuVItHvtSueH1ZGdrB9Vjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33690434"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="33690434"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 05:00:40 -0700
X-CSE-ConnectionGUID: jfw4kajmRVuzVkd4j0T8VQ==
X-CSE-MsgGUID: 9H2NpzNJS/G8hUfVNLIz+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="83570238"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 05:00:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 05:00:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 05:00:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 05:00:38 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 05:00:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omIwvIqjHlxOVT5+CvNjvEXQUb9+KfNzlU8YxROsUGWgGC/VA4xbRgt/8OZRaAEu75b3tjKLHUuM9L6odK1l/Y02xbPOWE8IKNND1uSJCvFICQdXUOgwx00rTe6t3p4bGAmpS6cEN0m1IGSRudCffIinsDB6S/wrIfBPvYyUou8bKIrqT87/LVLZueHJGTAyEllm3PwUQA85hc3jQWKv37kOqfkH+KIkOkcO3Tp2Nw7643NDcIFVKPhSBT6VM3VglPwgcmVNLDZUY2AoxddpdY99aiuc9z7vM+iDNq3sgUgfrqTBe1k0g+7zMJAdiB8rUl1KR0CzhATFo8GiliX2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlW3UUsbb8zGRkcyhXg6UOsZ3bhTChF5SMWRlW+T9YI=;
 b=JUi/DjF2XZ0KBfDYs10ImbAc9Csko9vexM4YsZQBfZ7V+WvAGJpNUAwcpA2TpwGS20kkRmY9uaTeaNjR4HumPchTThs75JjWo+iM+flL/v0c2SedmmfFybL1p0WtlRZptSzx0P0U0lEHBixq6mZpkXzvWoeT18M3DIMQmfuM8WU8hhypq8yXP27p85pXRgGKS0ZpeARZ96J6Orx07kQ8yCHjlL5suDY/PVhdByNRy+JdWpjymh9gz6/N0YaVV3UJKUKCS1aIzWJcHtUjSgsGgd4uaBw8/bSiDgOCfjGrlHdvlb278ra1HZnaMLTCz0rlgwPDQCBgm0YNqnpomDsLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB8468.namprd11.prod.outlook.com (2603:10b6:610:1ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 12:00:35 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 12:00:35 +0000
Message-ID: <0c45e6aa-3712-431a-8198-eb87d04a7cab@intel.com>
Date: Mon, 19 Aug 2024 14:00:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: mcp251x: fix deadlock if an interrupt occurs during
 mcp251x_open
To: Simon Arlott <simon@octiron.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol.vincent@wanadoo.fr>
References: <ea44fb76-0a9d-4009-8eba-021f0928cc77@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ea44fb76-0a9d-4009-8eba-021f0928cc77@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb52f03-0ffe-45bc-46d4-08dcc04688ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cndvYXhxOUdCREdKelk1cWppSGNVdksyOWNaOW43dzdLR2c4YTdGQmtxZmJk?=
 =?utf-8?B?cGU3MGt6aUJrcnhoM3Y5WTV6STFiWEpJRnA1cmlkWElSdlZoOERic2EzSW5Z?=
 =?utf-8?B?aXppKzRwNjFTN0cxMjd6Y1UyNUdQbmZPMEExSk5RMkJzSEpzRFZnZW54cXhG?=
 =?utf-8?B?RUZoRmVzSG1YOEZFVU1ZYVFOMzRpdUlpQlJEeEZvb01mMGJPbytDZGk4Q0l6?=
 =?utf-8?B?VWxydTdYZXRuaWE1TS9yUE5qVmVDRUwraWNMOVF4Q05ZbE14ZkVOMVhuTVJl?=
 =?utf-8?B?MzRmZGVYTzdJMTYzTGhWRVNaUkc3a2ZXV2t5L21pcnN1aVFnNnZSSU1SY1FS?=
 =?utf-8?B?VnZlOWdFU1VscHNkTGRMYzZxZ0N5R3pNRUx0ekNlMElEOVdBdEs1dnhKVGhq?=
 =?utf-8?B?NUpuZ242UnhVNjR0TVgxSWhUTHZrbTk0TEZFaS9WcDgySE9uVXh1VmNFb0F2?=
 =?utf-8?B?SXJ0VW9aWEpacWlBVzVsNjdCYkFtVUxpOStsSnNSWDhmVk83eFZFclJrTEQz?=
 =?utf-8?B?UXZ1OHZicFpkaC9rUEpBOE1PMlNkamhUcnBrcVZtTmRGK1A3ZFpqcTV3TCtB?=
 =?utf-8?B?SCtFbXMwenFnYmhaaktRYzVNKzgrTHhUbDJNelVqSU1id2cwNXBsY2NUT3o0?=
 =?utf-8?B?Q1hBNHdnS1MwamttNWNHYU1SN09UUk5MOEpVUXFCUVEwS2p0U280TVBlUVJn?=
 =?utf-8?B?M3dWYTRyQU1aaC9hS2t3d3NVdHlzd3NZUnp4WG9ZMkNMNkJ5RURzd0kwcFFQ?=
 =?utf-8?B?djFZT0duSlpwRWJNc1NkUkpDM2x5YjM5TlhzeGp1eHkyYjJLRTZuK3BCY01p?=
 =?utf-8?B?YkdGMWNWd3Z2MURVWmI4c0RsMDVva1JNbUhKampjYk1jeTNyTHlFb1NLZjdi?=
 =?utf-8?B?SFJHNkM3NS9rRXFOTGxOMFM3UDJVVFloN2NSajZHS3ZUV2xYbStrQlpKSXpQ?=
 =?utf-8?B?elg3SThhSFZXMjlrblpNSXErb1d4dmpLb3lZci91VHhqY0NqOWdPdkRYUzhW?=
 =?utf-8?B?VXJCUU1qUWdUYnVVaVBmcHBUTDRsVXVib3BMNU9rWmVNb3owQnZpSjdmSyts?=
 =?utf-8?B?TmI4MjFkOVdYMlQxRGJKWlFSaEVldTliSzVMWHM1a2F2cmRGOGRSd3BhcU0y?=
 =?utf-8?B?ZmxLNURmQTU0WENFVWlKV1ZDOGNhaHh5MFRPNTJYS2pjOHJCYWl0NnJpZXFO?=
 =?utf-8?B?Z0RuaWREc2VIQTVaR0dXREdPWEFJNUhGSVBRR2NSZDBVUENKSGVKSGF3REVp?=
 =?utf-8?B?Z0dXdHU4eXZ4dUF4ZmdzTjU0dEt5SnptSVpWMmN2bUNnSzJReWQyNU1rd29S?=
 =?utf-8?B?YzZIMXVaVjE3RGVsUkpVZ2JQaWc4SjNNaWtLV2Q1aCtzcDR0cUZMaE5QUjZD?=
 =?utf-8?B?UElYUnU4MWthS0MydENGMHpFcm5TUDRrbXNVMVdDU0FrVTB4dXhMbCt6RSt0?=
 =?utf-8?B?c1pvMitGWkVCUllkMmUvMDEyMGdQM3VwbUg3cFUzSXZucTRjOFBlMTlRdlFs?=
 =?utf-8?B?anc2NHQ2R3lNaVBBK1czbmlrOUVkWUxyUUE3eHhRQjF6a3dVQ25yYzJHbXBT?=
 =?utf-8?B?c1o0RzIyZEdYakZGcHl3VDhmU2NObC9EWXlJcGpFWHlYS0JqdlBCcTBqTTZu?=
 =?utf-8?B?clE0aiszekkySFdlSTgzekpSYllyanp4eHF0YXJqdGNnQkhvcXlsbGRMVjlr?=
 =?utf-8?B?cldCeG81RUt3TGxta0hRV0hXb1R3TzlzR0V3eVFrUUwrbjBjaVV1bTVscGlh?=
 =?utf-8?B?TTl2ZGcwdFg3QUc2cFhTdDhQZ2lUNDJwN21WMTF3WVQ5QkJna0JRTjRqVUw5?=
 =?utf-8?B?aUZoRFd3cTd3b3FucUNTdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlAxUHRlNUtXRTNxNE85bUs3aVRsUC82YndtZTBEd2NtRnFjTkgyeVVNOE54?=
 =?utf-8?B?Tlo3N3Fpc1dhb0JsMktNRStjWXpKRFpzc3ArRHlsTlMvUkVhQ2QyVU5wc3Zy?=
 =?utf-8?B?OVRLODFCbjVOMituNmFLYXRnRHo4L2FXSDFpTDJnSENIOU1sWDFQVVF3a3VW?=
 =?utf-8?B?OERBZGhtZHFHMWx1UFAxT04xcFdGZ05Xa0RGWWNVY3hpZDRwWmYzYTlxUUtn?=
 =?utf-8?B?RGk4ZG8wa3lkTkRheVlYZ3ZMaGxlVnNZVy95cTRSUEhrREZQOVdQWVpMKzNz?=
 =?utf-8?B?NmllblBtaklnYXl6UmlaUThQSFB0R2ltMnlCZU9JQnFGckRmY0JrbWJnN3pi?=
 =?utf-8?B?RER5RCtjTzBCL05UWkVzMEtxV0V1NXVVQTJCNUlkR3BGeHNsZlp2SnFtV2F1?=
 =?utf-8?B?QlUxOWlTNkxCWDhJZWNzbEQ0akhkZWhKRTdUY0xUaGZsWWFZRlREN3NRbDJP?=
 =?utf-8?B?ejFacVhuUHhJMnd4czdqTWdKMkRETDhjb1RaT0ZUbGdBdlB1cGNuWERTbmFU?=
 =?utf-8?B?ckx1SjlLVHpoaEgraTNJZUpCVlRoRFovc295WXoveXYvMlZXWjRldW8zSGRV?=
 =?utf-8?B?eDVyWmp5bHNGTHoyVG53VWl5RHNqVUFEUkVkalRQcGkvaDhoaHUxcGNrb3cx?=
 =?utf-8?B?VjlUR2lkRkNWd0pwcTRQVE5kVkpvQjVDMjgyMGV3aEVQMzg2T0xiQWtHTDYx?=
 =?utf-8?B?a3JPa2pIYmhNZTVaSWxiT0lnN0tHR3VtSXRLOS9pcnA3ekxNZGV6TFh5L3FC?=
 =?utf-8?B?MUErbjRDSk5ZSWQraldWakVPSDNZc2k4OE5zcnZ2ckpScU13VnRjT21hWThB?=
 =?utf-8?B?RWpCelJxNWJJV2s4anoyUmsxUnNTYnV3SSszZENMUENkcnhIcGZhLzUwMmxq?=
 =?utf-8?B?d1Y2L2tPcDRQOVV0dUU1TlRSbG5ZSU5YNzY1VHV1R2t0RFVJZmxDZ1VIQkVy?=
 =?utf-8?B?aEMxTnFBamVQaFI4SnNVYm9MTnZHOFdibjd2cGpGemlDM1pWY0xUWUs5c3JR?=
 =?utf-8?B?SG8vbWx2cDJvN2RXZVNwMi9ORGdTblV6QitNd3ozalVCdGVpSkxmeEg3TzZw?=
 =?utf-8?B?VW53LzdnTXZyMFg3L3RVT2xCc2M1SmdNUUtjZHVIZFFNeUo1QnhsaWVoMGtS?=
 =?utf-8?B?OE5jSC85Y0xIaWtHaFJ4UExwRmVQd0JMWUlyWFVTeXBIRXBXN2cvRUtRaTF0?=
 =?utf-8?B?am0rVys5eGxuS05BV3pKNHhxM0RMeW5GZXdDaEtMcDZLK29JbDBYVHBKakdJ?=
 =?utf-8?B?bDRJMS9wN2YxYlk1RjYveWRYVWRvNzJHTEhFRXNoM0FVUmdxUUgyMFJSSk5R?=
 =?utf-8?B?RTRMcEVIcENJUDM4VHRQT1FEV0lieGtWcHljd3lMMkI3QzJoa0x5cWR0c25l?=
 =?utf-8?B?cGdHdUpnSEEzTjZGR1cyM0F1bFBWdVVNa1A4Mk54YWh4ZkNlc2dUZmU1Q2tD?=
 =?utf-8?B?NmJvZ2tzN2ViVEV4NFdZcmM3eC9zS1BtQjJMMzk1QzhBbTdBNkJqVHpKYlJl?=
 =?utf-8?B?bnlPNXJzMkRmY0RZQ0xiWjNVeWdyejVrdmFUNmxqaThHQWlldkdWT0ZCMzkx?=
 =?utf-8?B?TzhTTmIyOFlCT051NXRUcTYzbDdVbkozcEJaQ09VWWZkbE5aNjM3dVUvTW83?=
 =?utf-8?B?K1BYSGhCalZmNjdueVZTWXlNY1VhMDVNRjBQSzJOV1EyR1h3RzBSNUZGWFNS?=
 =?utf-8?B?ZmxsY05QdDBIT2o5V01xdUZ1c0xtZnE5Vk1ScnpMbXFTdGV6NUpZSUFRTXNH?=
 =?utf-8?B?RURud3BKY0dNcU9ZSktWSXJUeXF2VlRKdlRPUnFBUzNrNDFpVVFXaEFETW0x?=
 =?utf-8?B?V004dmhyYTVCQVhXVVg2M3Zkc1pWSWV4YmQxd1d4Y2ZYcHNPeHRFd2NDMHBN?=
 =?utf-8?B?aWxvS2tYTUE3REhvaVk4elZwWkFweTZwZU8xbEZkYUJPK2IyNGU3L0dYaU1h?=
 =?utf-8?B?aTlVOCs2MHUxZXN2NWoyRmJrak9HczdDbENVMmsxdTZrS1FWNlNyWG5INnZL?=
 =?utf-8?B?TEpmd0FKc1ova1hyMC92Y1o2bjhsWUFIRytkd052cTBTUUNkNG8wZE5rNVNo?=
 =?utf-8?B?SzhYWjJKK0E4QVJUY3dOVi8yYmIvUDlVZklRQVpTSkVwRDUrTHc1TVNIRnBY?=
 =?utf-8?B?WTdmdm1CazRvZW0yQkJIK0NmYmFBNHRrQ2MzZllZWEU2ai9GS0t5dFlVUFRq?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb52f03-0ffe-45bc-46d4-08dcc04688ce
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 12:00:35.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0R38OQ2il2VTOwzr2QlMGokd6fb35Iip1xC9vc8nHDt2n/IbevYftAPsJVxZqNQ00GkATBOaXKcJnXKpDqrj2e/7+5mENoQZJZtPPdqbS6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8468
X-OriginatorOrg: intel.com

On 8/17/24 17:45, Simon Arlott wrote:
> The mcp251x_hw_wake() function is called with the mpc_lock mutex held and
> disables the interrupt handler so that no interrupts can be processed while
> waking the device. If an interrupt has already occurred then waiting for
> the interrupt handler to complete will deadlock because it will be trying
> to acquire the same mutex.
> 
> CPU0                           CPU1
> ----                           ----
> mcp251x_open()
>   mutex_lock(&priv->mcp_lock)
>    request_threaded_irq()
>                                 <interrupt>
>                                 mcp251x_can_ist()
>                                  mutex_lock(&priv->mcp_lock)
>    mcp251x_hw_wake()
>     disable_irq() <-- deadlock
> 
> Use disable_irq_nosync() instead because the interrupt handler does
> everything while holding the mutex so it doesn't matter if it's still
> running.
> 
> Signed-off-by: Simon Arlott <simon@octiron.net>

You have to provide a Fixes: tag for bugfixes [PATCH net]

otherwise the change looks fine for me,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
>   drivers/net/can/spi/mcp251x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index 3b8736ff0345..ec5c64006a16 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -752,7 +752,7 @@ static int mcp251x_hw_wake(struct spi_device *spi)
>   	int ret;
>   
>   	/* Force wakeup interrupt to wake device, but don't execute IST */
> -	disable_irq(spi->irq);
> +	disable_irq_nosync(spi->irq);
>   	mcp251x_write_2regs(spi, CANINTE, CANINTE_WAKIE, CANINTF_WAKIF);
>   
>   	/* Wait for oscillator startup timer after wake up */


