Return-Path: <linux-can+bounces-1149-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6337948D66
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 13:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04104B24BDD
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 11:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB861C0DED;
	Tue,  6 Aug 2024 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnW13MB7"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2CD143C4B;
	Tue,  6 Aug 2024 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942195; cv=fail; b=fJrlAk65A2y8P4gcsFrwFTeGUtyzQga4FR+h4oZuj0t2G5vDL6XAPUhs2wlLn7W7T6J3CNSAeK+k6n94c7gtT3BZTmgDH8upaayjUlZGRuyQ35HbeIGgRrwI1IjzCMvX+fKBHijeDlaXVXhl4LWVb+T8abEczgzxMWRhsRJYc2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942195; c=relaxed/simple;
	bh=8Sf4b+XKSeNpRnPSHssvs8pVFjKbyezX64J7bf7PRjY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E44NEjswNOfll3G7/ZSS1jg7ylVs93eblOojZyQFaZlpPy1vJDEWHM0Gjql2ciCUyHNS6xlU7VjeFPz0s3/+DlWCVRAvcwe5zW+utVytQRsX7TUsdXZ2pIG5bwKac1CA3H28EVCzdyqAbJgNB/cu9mCWiyHaymE+bx8xz0Xp9lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnW13MB7; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722942194; x=1754478194;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Sf4b+XKSeNpRnPSHssvs8pVFjKbyezX64J7bf7PRjY=;
  b=WnW13MB7ZkUAp+pkVy2ZEI5QRXskDwaZON8AK5PX9UStZ8l+lLP8FcNi
   20CzocfexTq6DTK9efrctKio8oS/0veevrQYvT4b0/ypyYcdZUBK8XN5V
   vugE5TFDIkCDBe4XbLVyBVqpU74z0U8XlFxvpgKLa8iXmLg0BYpmahOqO
   i7/tvd5ibJ4DCZrSxDLCDmxbY1smjupw/FR4jXTe2rXVjGo5T3g2BcjW3
   tt6QUSa78ehWu4aUoUa7QXqA2UDQeQ/v/osoV6uH8MV96RXQZkYoujERK
   859Bjmr67FbqPyvfONA8jKZreDaCqt5uctU5eCGgwLAT7MKyWZxxXWr+/
   A==;
X-CSE-ConnectionGUID: TNyrw7MeSC+JKMZFLoXgNg==
X-CSE-MsgGUID: 4msbOFywRdyKSu/hyLNAig==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20527309"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="20527309"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 04:03:13 -0700
X-CSE-ConnectionGUID: +Kg1DCXPTVm+x5gZMNRbAA==
X-CSE-MsgGUID: BdHwFr2BQVuZbT53ea2Z1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56431493"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 04:03:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 04:03:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 04:03:12 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 04:03:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUvhlCsIEvTqrGETKOasAhxjrIOKD2x9VhRfVbqzQN46hPrTLu7gazGKsUpchFyROCvR3/6T3IznUkJdd3YHb/0ngX8URBeOZUkEhWW1BXLPJFwvIMoJ9uC2MqfStMEvNQJ/HHLyX4yej53TK8ZVFLRVINU4Kh9S2vUmUUHh+vrjfbkAUncwFL1RYeNzF1htn29dWlwC3ZR/oGuXl1umd5l496dzxhgZZJmDkm1A0OSMPUBDuLdKWNJHZQBiL+UgYeWhSGcZTemf1CUUDUOdlG12iIx6X1TWJTmCxlIzNpEe/yxlVE4V0D8W+uE/yWg98W4NY+pYViQzqCH85/8aNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTrm1judK2kGPt1uDnffdxPM3+QskAEWcK20GHq0iVQ=;
 b=lK2h0ZHxQb7xv0RyK3BSeQDpvV/O9Gjc0sXMWi0xPJY5tyZ1U2YDBx4+gObaYjIOYerA14YQ3eGc0OHXiKX+kmwFSmsEuqOMjG3k77Bof8DMZa6TJFHtqSaGl9vRIymW3u2XkJqmkAZSbKQ/x41RkrbcxoA7/nO+tUGDZSENAQW1Q9sfzU1TZhvJhjmcNm9eM5Q2r16DXPNatVmmBixnfIuuTGIyt3B2UdvQ+FNeK7XEmvGVexgy/rEHZ6I8i2OxghnAN9qd/C0w9ntGU2N5rRu872fs0wbvifl3r5XW5OOqFhShPxiapTYgGOUzu5prTVcQXF0gli86cPCShfmvWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 11:03:09 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 11:03:09 +0000
Message-ID: <6ac470f9-c918-49d5-8b71-0b7c6ed2c83e@intel.com>
Date: Tue, 6 Aug 2024 13:03:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] can: mcp251xfd: Enable transceiver using gpio
To: Anup Kulkarni <quic_anupkulk@quicinc.com>
CC: <quic_msavaliy@quicinc.com>, <quic_vdadhani@quicinc.com>,
	<mkl@pengutronix.de>, <manivannan.sadhasivam@linaro.org>,
	<thomas.kopp@microchip.com>, <mailhol.vincent@wanadoo.fr>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240806090339.785712-1-quic_anupkulk@quicinc.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240806090339.785712-1-quic_anupkulk@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::7) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|LV2PR11MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a583693-aa9c-4aa6-0faf-08dcb6075b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3ZkL2VmYUJQaVo5cHRqaWNWUFFnY3MyY3RnZ21CL0ZOWC8zZEg4cUZZeHND?=
 =?utf-8?B?TzFyL0xoeE91Nmp2aXV3eXEvYmlhTXJJME5rYVZIekZ2YUM1U2dLRkUrODVj?=
 =?utf-8?B?UnVWa0hncGdVaWxLTVFZemRhTW5mN1VqZVdjUHJtWjZGU25ZSUY4WW1IZWpn?=
 =?utf-8?B?NC9UbGJJaHkrRlRvZ0YzR002RVRrUlRqdGtUb0lnWWFwYko4VXNwb1ZWS3p4?=
 =?utf-8?B?bFBvYjBNdSsydUhXbWtqc21uTkNQcG9IaUhuemF3eDhiMWx6VEV5TURBQUlF?=
 =?utf-8?B?TlU4eGNVb2liTlJKY0U1bFowTFNaMUoxZFVWeW5DZTN5SVhkZ3BscUI1dVQ0?=
 =?utf-8?B?Z2UvWGs3MnVpcHVWd05xYXBuL29KcjRHc0VWc3lKNDA2eVlKQ1BqeEVaQ1pO?=
 =?utf-8?B?dCtoY3Jia0g5UnZnYXNCd2l3K2lBelVMTmRlSXFicjBKMml0Z0o1QWlzVm9a?=
 =?utf-8?B?NXVoOWI1OEVWZUNLYzhmdUcybVEzS1JvWGNpVmtjRkxyQzVodlJwL1lRbUtC?=
 =?utf-8?B?OWVRL0FjTStyM0VqOXhJQlNaRmhMYVVoTFA5YkFMU2Q2Z1A2SjNGUWU1RGNY?=
 =?utf-8?B?VnNHQUgyb0QreXdabFM3NTIzZ3dEZDdyUGpjYjZSQTM4aklCbDZCUnREcFM5?=
 =?utf-8?B?TzhHQnhtRDFBVHpBQzFmQzFHbkpLMVZxMGJoWVVhVHVBL1BFSitRV3IwVWlT?=
 =?utf-8?B?bktLV291Y1craTB5Z29zR3VIU1NuSUw1L0V6SDhCeXM1cHZsV0lkb1hhdmlR?=
 =?utf-8?B?dWV3Nk05QlZ1ZS9EZ2pxSVZTNi85OFdNbTArTStSdFBmcVdmRmJKblhvYmFK?=
 =?utf-8?B?SDNKNzlBV2ZlYjRqZk9HaWFLa3V6SWRkWi9IZDlIUHJmQTdKOXNKTjVsRUU1?=
 =?utf-8?B?NitUT3VPbFJMOHRVYTBPbHdkczR4SmpRVmpERWQxUDJYNVJGUGx4R01HdkJ2?=
 =?utf-8?B?WndISDZBaWFTM1JuZ25PRmFrekVCaEdSYXNTbnh0eWRtV1Y4djNqTy83NnNQ?=
 =?utf-8?B?N25BZ1cyVklEczJZOHBFcUU3WGtIME5ydzRxZ0dXZCtHbG9Wc1FsNFdNYmhp?=
 =?utf-8?B?cjRkUWUvVFZKOXhaNHNLOCtkdXdzWUFOYTZUaW1rNG1pYTNwelViZEIrcDcv?=
 =?utf-8?B?MDZXL2paQ3BTWmI5dVBuZ29tZ0IyMUlERnkxbTRZUHJpUFBYMmJQNVVQT3Jr?=
 =?utf-8?B?Zm5Jb1cxV3RzdkpYK2xiT2F4V2tldkdWTHZsSDR4RGdlbVc4WmxNNGVTTjF3?=
 =?utf-8?B?VmZDNmRsQ3RCdmhMWXFPdGpqajBjd2h6UmRHVGkvbXcwUWZ4dEloSXZaam1n?=
 =?utf-8?B?YThHZWdKR1hKYmcvcFpPaVhkUGQ4cmJpYzZCOUpEQlZ6L200SUhZS2MrK2wy?=
 =?utf-8?B?RnNGb2dsWTNsT2ZLU2REbjAvbmFwV2tZWm56dkhQWGo5cGNFbmZjRHhGcDQ2?=
 =?utf-8?B?RnFyMUFBeDdqS0JiOTBMaVhrK2JXWGttUCtoVW1FUm9HTmNCMXB4K2xiMmJZ?=
 =?utf-8?B?TmE0Zkt4dnhHTnZZQ1RRSlRZenhsTGJXbEc0aGQyY2V5YTliRjRVNlByQjdU?=
 =?utf-8?B?cFNQNUMwcTR0K1B0c3JVdjg0eCs1UzJRelF3ZUpKZVZudk5LaEhEcEdxSEtP?=
 =?utf-8?B?R0N4T0FZOEt6YVhIWnh4WU1sTjBPTzhzZm82SWR3c0s0d29xRGw3bXRSQWE3?=
 =?utf-8?B?R0sxUnRoVUVPdkYrRUZKbWhPYVdMakZoZ1RwN0RyNi9BWTRLM0s2bE5mcDAx?=
 =?utf-8?B?djVIRElkTEtmeDA1d1RRK2s3K1FrTkpmVDI4VnJIamk0TXN2MFJxTkVaYWVB?=
 =?utf-8?B?NFFPSWZmOTNuVno3dkdxZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGJWaFNKbmhLU3J3Ym1mSlkyYmNjZ1QyMHBPTlVWcHRhaXRTaFBZeWJkMXpN?=
 =?utf-8?B?ajlVa1dMOUt3aitydEN0R3BWalNvRU1RWWhoODRjbEhYWlNFSFNsMVJDMWti?=
 =?utf-8?B?N3F3TnZuZWcrYmtpME9FQ3hCTHJaM3hobEV6OU1VYTBxcHY2ajQwMkhwU01P?=
 =?utf-8?B?ZXU2ZWpZUllSZkRhYkN4K05HeDIzUC96TnZraHB4NEtuV2ZQdlBoWWwzOXBp?=
 =?utf-8?B?T29zT1ozSE14SWttMnF6NG55L0FCRmNXbmcwWVpPKzNpTnQ0bFZheXV6QW8x?=
 =?utf-8?B?UStod1hxRnEzQVBwNEl4K0d0cW1BV1hTZTJwTWd2MnM0ZlNpeGZtc2RuNmUz?=
 =?utf-8?B?d0FqQTduelZIdHU2elFSWE14dHA2VWoyUjlGN0I5SFE2ODZUTkw2M2hRaDNZ?=
 =?utf-8?B?bThsZVpOUG5OeEJYVHJPRjI3NVRreDNXd2tKRUkvaGd6TU1SdFUwM2M3b0ND?=
 =?utf-8?B?Mk1Wcnh0dVhoMGtRWDN2Qkw1UVV5OG5uZUJBRzFlVmI2WFBIMjg5SktFZ2cy?=
 =?utf-8?B?ZjU4cXQreTJxQno0eWdZa2NqTkJvRld0T2REVmVyb3pxN1hmSVdYT3hHaXp1?=
 =?utf-8?B?Rk5EWG5wcGtEMlFyQ2hNSFpJQTV2OUhvK3BNUFdtcFQxY0J1cWpTdDg4ZVoy?=
 =?utf-8?B?eUpKMmV4K2FlTCtnMGRMM1Z1MFM3Y0NPNjV3TTBJWUhhK2w0UjJKMHlhQlUz?=
 =?utf-8?B?ZjdLSk93dE0vTEkrNjhzT3BCcUtVRnlyMTJqY2tWa1VwL1dKTThVV2VJbmlQ?=
 =?utf-8?B?c00wR2NibjJaK2t3aitYWERlWVQ5cEpOV3JobWtpeTE5cWFnQlk5RmRZYnpo?=
 =?utf-8?B?allEeDU5UU1KYktOdlpPbjdxQVRyZTRRdU5vaTBsY2lwbEVlaVl1UkdYWFRG?=
 =?utf-8?B?RSt0K2w1VURjcDNsaWVGV1RwSzEvSFRSSmo0WXVRRTNSSXdoRmtzVWF6OWhr?=
 =?utf-8?B?emx4VGNJRy9ackY2NXF0aE9tVEdSZHpYTHNEazF6cTlaS00wai8yWmVsL1NL?=
 =?utf-8?B?dWZJckplazloNWFJSHp5ZVJoSUdDc053OGhsTE8xYk4xSGNCRFBaMDkrSCt1?=
 =?utf-8?B?RGgyOFNHK3ppQXh1Y2MrSC95NklHVk9qQnlBTTYzN2J2d0VnVHl5ZlFmSjhM?=
 =?utf-8?B?ZUlac2VPNjU3MlBVZExieGNtRGdQeGtEbFVFY0NBUEg0VHpwNHdIZFpsWEMw?=
 =?utf-8?B?SmhsZXdTWTdVQngyc3Y4QnpreXhrL2FzSXgveDd6VmlrQmsvV0xwQzlmTy9O?=
 =?utf-8?B?SnBjTWxYZ1kxaklqRmVHZVNmZHdaSU8vdi9WNE4vanh2UzArc0dVaWpLVjcy?=
 =?utf-8?B?V1grOXpXaTRSMnpkTCtQcU10ek9WcjE3MHlFcExkZmdZOUpCY1IwVityZHl2?=
 =?utf-8?B?VUY1a1EvbU0wZS9zRU56c204V3VRL1N5d0w4aFF5bDhVV3phN1laNGdwN00r?=
 =?utf-8?B?QVVsYmQyL01mY3grUjFNcitZd0VnWnhlL3VMRFgrTGp5cktLNHBzanJZWlB2?=
 =?utf-8?B?eXNCTWhLL2tvTzhmMlU4YzZjcXdmOUVsY3JpTnBUV1dqQnhxR3FPUkhoTWZw?=
 =?utf-8?B?UDhMRWdSZjZmTTZIY3NoZ3JMZHlzYU0rc0h3STJLVEt3UW9UaEdyVzhhTStJ?=
 =?utf-8?B?WU5WYjh6SUhTTUZDckVxbXQzalFSbWY4WlRidEorcHBXUFFXdldRYyt5VGFv?=
 =?utf-8?B?S252K0YxazR6dGdoM1B0QmkwbXE1TGFROGltTGVkZE10S0FNaGQ1eHR6OTBn?=
 =?utf-8?B?SFRlZFNDQmUvdmhVVjV3K1czZ29QWjBPS21CRTlHbnhmVW5IZ3R4U2dxTkpZ?=
 =?utf-8?B?aURMMnRZWENmb1VjUWdsU0JBbGcwdWk3Z0lqVFY1VG9NTlh6Q1oxVU9RczJl?=
 =?utf-8?B?MVNPL1lMS2pIRjMza3RwTVlUWWJ5cEJFYnpnQ2w4YmVtUHZEODJYajdPczdr?=
 =?utf-8?B?OEhST3RNVlVwSlIxL1hSQ2Vnek1pU3FqUFZLdThvV2ZseDRuY0Q1NDVkdTZj?=
 =?utf-8?B?NmZBUlJINU11Yi9XN0pxWFU0YzRpVUZHTE5oQ1IxTnpXRzdmcmRtdTlHdC9F?=
 =?utf-8?B?N2F0WlUxcHp4ZzNPOUZDcmZQazl4Q3ljSVFPVXVCM09NbXB3azBkeTVoMGhn?=
 =?utf-8?B?OVRrM0RuREd2KzV1cjY0YkNnNVIzZ2x2NTc0Y0lMYmJld3R3bVJyeWF6bzFw?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a583693-aa9c-4aa6-0faf-08dcb6075b57
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 11:03:09.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiK4yC0sVN2SfiLT0rVt8OwgyqsccxZBShccQ2FKQ1otVj+AawMfE9A7n7f13NrZ0k7KZgI9Ul9ZZ5hbYHk2EW1OzKaEf0i3ubPCsQ6/iPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6070
X-OriginatorOrg: intel.com

On 8/6/24 11:03, Anup Kulkarni wrote:
> Ensure the CAN transceiver is active during mcp251xfd_open() and
> inactive during mcp251xfd_close() by utilizing
> mcp251xfd_transceiver_mode(). Adjust GPIO_0 to switch between
> NORMAL and STANDBY modes of transceiver.
> 
> Signed-off-by: Anup Kulkarni <quic_anupkulk@quicinc.com>
> ---
>   .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 32 +++++++++++++++++++
>   drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  7 ++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index 3e7526274e34..3b56dc1721a5 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -153,6 +153,25 @@ static inline int mcp251xfd_vdd_disable(const struct mcp251xfd_priv *priv)
>   	return regulator_disable(priv->reg_vdd);
>   }
>   
> +static int
> +mcp251xfd_transceiver_mode(const struct mcp251xfd_priv *priv,
> +			   const enum mcp251xfd_xceiver_mode mode)
> +{
> +	int val, pmode, latch;
> +
> +	if (mode == MCP251XFD_XCVR_NORMAL_MODE) {
> +		pmode = MCP251XFD_REG_IOCON_PM0;
> +		latch = 0;
> +	} else if (mode == MCP251XFD_XCVR_STBY_MODE) {
> +		pmode = MCP251XFD_REG_IOCON_PM0;
> +		latch = MCP251XFD_REG_IOCON_LAT0;
> +	} else {
> +		return -EINVAL;
> +	}

@pmode is always the same, no need for separate assignment
this if-else chain will be better as an switch statement

> +	val = (pmode | latch) << priv->transceiver_pin;

put a newline here

> +	return regmap_write(priv->map_reg, MCP251XFD_REG_IOCON, val);
> +}
> +
>   static inline int
>   mcp251xfd_transceiver_enable(const struct mcp251xfd_priv *priv)
>   {
> @@ -1620,6 +1639,10 @@ static int mcp251xfd_open(struct net_device *ndev)
>   	if (err)
>   		goto out_transceiver_disable;
>   
> +	err = mcp251xfd_transceiver_mode(priv, MCP251XFD_XCVR_NORMAL_MODE);
> +	if (err)
> +		goto out_transceiver_disable;
> +
>   	clear_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
>   	can_rx_offload_enable(&priv->offload);
>   
> @@ -1668,6 +1691,7 @@ static int mcp251xfd_open(struct net_device *ndev)
>   
>   static int mcp251xfd_stop(struct net_device *ndev)
>   {
> +	int err;
>   	struct mcp251xfd_priv *priv = netdev_priv(ndev);
>   
>   	netif_stop_queue(ndev);
> @@ -1678,6 +1702,9 @@ static int mcp251xfd_stop(struct net_device *ndev)
>   	free_irq(ndev->irq, priv);
>   	destroy_workqueue(priv->wq);
>   	can_rx_offload_disable(&priv->offload);
> +	err = mcp251xfd_transceiver_mode(priv, MCP251XFD_XCVR_STBY_MODE);
> +	if (err)
> +		return err;

perhaps it would be better to continue here anyway?

>   	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
>   	mcp251xfd_transceiver_disable(priv);
>   	mcp251xfd_ring_free(priv);
> @@ -2051,6 +2078,11 @@ static int mcp251xfd_probe(struct spi_device *spi)
>   					     "Failed to get clock-frequency!\n");
>   	}
>   
> +	err = device_property_read_u32(&spi->dev, "gpio-transceiver-pin", &priv->transceiver_pin);
> +		if (err)
> +			return dev_err_probe(&spi->dev, err,
> +					     "Failed to get gpio transceiver pin!\n");
> +

remember to fix it as Christophe J. has pointed out

>   	/* Sanity check */
>   	if (freq < MCP251XFD_SYSCLOCK_HZ_MIN ||
>   	    freq > MCP251XFD_SYSCLOCK_HZ_MAX) {
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> index dcbbd2b2fae8..14b086814bdb 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
> @@ -614,6 +614,12 @@ enum mcp251xfd_flags {
>   	__MCP251XFD_FLAGS_SIZE__
>   };
>   
> +enum mcp251xfd_xceiver_mode {
> +	MCP251XFD_XCVR_NORMAL_MODE,
> +	MCP251XFD_XCVR_STBY_MODE,
> +	MCP251XFD_XCVR_MODE_NONE

no need to add NONE mode if you don't make any use of it,
also the name is not consistent with the other modes

> +};
> +
>   struct mcp251xfd_priv {
>   	struct can_priv can;
>   	struct can_rx_offload offload;
> @@ -670,6 +676,7 @@ struct mcp251xfd_priv {
>   
>   	struct mcp251xfd_devtype_data devtype_data;
>   	struct can_berr_counter bec;
> +	u32 transceiver_pin;
>   };
>   
>   #define MCP251XFD_IS(_model) \


