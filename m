Return-Path: <linux-can+bounces-3555-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54F2AACD48
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 20:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5C24C5E82
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 18:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16071C5D55;
	Tue,  6 May 2025 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3zXNFiJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B616E863;
	Tue,  6 May 2025 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746556235; cv=fail; b=DMyiNRoy4+DVUXnR5RXlHt4CMxXvquTey7JIMwZCYp8zMV/4mNvt31jIw+dJTLeWFk7/kTSweh3rx0L0U23S4JsiqfzdlEDxcMiRS+EGGHkjtwDS2fZr/iD2iazdxKW0a1PFYQSYQRVXdnBHoIOacuqchfsc/o5o6+S9uMoN2u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746556235; c=relaxed/simple;
	bh=Nx8s9LyitKJlS8ZhuRIhFdw3/56BQTQ8YyWiyjGjBAg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B/AOe8rs/wipZCpKbOcB9QQNoD36y3uRTwWR4E25jm9AnsCHSqaFUbkfbS6WZv1pB5JZqfImVsix7agRmYs+2Iguoj4YN9Vz84LsYI8whnslL2BK17FCMyGwZ+kO8xiNEKo1ciYMb5TfCfC+ahNtwOjDdv88rXkFDkBdUd3cKTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3zXNFiJ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746556234; x=1778092234;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nx8s9LyitKJlS8ZhuRIhFdw3/56BQTQ8YyWiyjGjBAg=;
  b=H3zXNFiJkXh1HnoVwzsu5U54HhU6HpIxAqmYHGNvR8e5Asbg192Il/3i
   YG1fApJr/kDdhFKc8uqf1piZK8o1YmUHCLrD9MhmRW8aOz4njaoOqamjX
   J0b1YooSYug3j49dJuM7kfPYf3F9H5ML08HESm2DDmQ/oddjZnnacvTkr
   SAiEbn0CJs8vCQsDOwBic/7ZTx9UwA2iGTbdsCr2oAG1dRXdkbJFpvfWW
   T/zCOCzdRbLVcxfrKVOweCTvMLu+v9UP4EtHbwDSb/4dSgN7ylrk8E58x
   avvlzbG4rDg9qmELkz4cdolHLhNp5tEx7G8jwdEwXtTuEE5fAweF4bJBd
   w==;
X-CSE-ConnectionGUID: qfmZzflTTx2Mq5DQJioNUA==
X-CSE-MsgGUID: 2mrrxGa7TOKl2CKdBol0gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59234544"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="59234544"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:30:33 -0700
X-CSE-ConnectionGUID: Mjrn0OXSTiOCHSD1xItcZg==
X-CSE-MsgGUID: WuiJhWENRbuHNFSelbQBtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="172896916"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:30:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:30:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:30:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:30:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBLGUn5DArP01Jqgvq3/7+wPHyaX1spHj79H3T0on1TT3RRVaOPDxfwxGuBN4O1Y/cRzIFATO5/Zo1JL6H/eauUlF8G6n/SNDCCl+xNU1Aphx+0MHDWALSTzNs05f5ljbdV3zQbbpfQkifWGoTSeRZf2kYyKnmGHjpYqibTqfYfL5K4Uv1JgDFk/cw/DetH/f42L7fRZwJj4CWxRX1lSgvW1REyyC4OZ9kDY5kdMCAMahGkWvN2jLg+h9JiGJ31cmIeU9qIH1W36mUaq2FVxfClN8RH8zw+jezm0ir24khh6svOuYKa+XIugrm4ugk0yq3ixf7vgM3WdzYyaoCKO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpLvww64v8cWlhOSeK8sC4x8XcZfJj8x+TQ0PoXOxIA=;
 b=diajGUdpH6zQ+eXuBKVX8SGPo7kXcxzHUDzYOY2cwNjPcYeW+burbthZSY1dkl84huKHh2qSM37X3/3HXAu7fqu+uxcsMqZB1AZES/XCcStbXSik++FV6W0mTWGyS3nWjaCLHeysK6ZididxU3fksUXjWwlMrF+jtTmO7yBkP2HhIC62KrMlq56dcoeSKysSSpCI9sdKL0iuRntSicc1E652c74nUGwiOmGcf1gg62eT4Em8MtOwrBClAPMeC0FjVEvjzZhlBv0dmQbdGAXiGN3bFRyFqvhS2r3bjE+Hr/7IL+rT7zj8/4rCj02eWro5iyjxEA8iVNSiyIZn6C6Zpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5123.namprd11.prod.outlook.com (2603:10b6:303:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 18:29:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:29:44 +0000
Message-ID: <1a595587-f0d2-4ac1-a751-bf80e186a180@intel.com>
Date: Tue, 6 May 2025 11:29:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/6] can: mcan: m_can_class_unregister(): fix order of
 unregistration calls
To: Marc Kleine-Budde <mkl@pengutronix.de>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-can@vger.kernel.org>,
	<kernel@pengutronix.de>, <stable@vger.kernel.org>, Markus Schneider-Pargmann
	<msp@baylibre.com>
References: <20250506135939.652543-1-mkl@pengutronix.de>
 <20250506135939.652543-6-mkl@pengutronix.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250506135939.652543-6-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:303:dd::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: a449b3bf-ea94-4327-8e9c-08dd8ccbf93f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXpKVzdpOW5qaVlIU21QTjZpMU5NZC9hdVgvT1ZmK0J5TlRyNFdpZHpnamcx?=
 =?utf-8?B?TFF5Ukg0S1NCeE01SVJKWFM5d2lCZXBIb3V2aERVVzRPWnUyOXJJVlEwVmNr?=
 =?utf-8?B?RjFONE9tbzk1dy9WMmQ4dVMyZmJxS09JbjhENTNVbTA1dksxaEU3Zkd6S1RB?=
 =?utf-8?B?NDBVK2xuUUtQZHJxTnFveklIelowTlNneVNxN0hKWHMzMEdjL2VqU2FsTi9J?=
 =?utf-8?B?SGVpRjI0RGlMbVRkcE9kYXErckFVejd3bFZnMVNUOFExeHpHT1FFMnNjTmRM?=
 =?utf-8?B?eTNvWnY0YnVqQ0o3ZTFLeDAxbUlmcERYNy8xeDBvSHdVYzljOWVEMlozZ2U5?=
 =?utf-8?B?KytHbFV0RjV3eTlwSmhWd1U0dlRucWpYZTJXRm54Wm5KN3pTUUh3MmprVmh1?=
 =?utf-8?B?SUJxankyMjNSai9JRS9NTXFtR3lCQzI0QmhRbTZCc0ZiN0tCanZXT3grcURl?=
 =?utf-8?B?ZzQzajloSEExOWNQa09FV296T0gyS3JoNDBoOXZzeEF6c1dWTk0zQmNWRjds?=
 =?utf-8?B?VHd4L29XVWhMVDJpK0t6Z1o5R1B6ajAraUJIUit6Z1lSRTNDUmxLU085NlN6?=
 =?utf-8?B?MS9jODN0NmVXWGxzRW5ocVh0U2tlKy9DYU1pUjhWeXZMYXIzVmlRU1FEU3dl?=
 =?utf-8?B?SnZjMGZWNXppY2JERUtWTlBqMHRnRWNzMHRLUGlSUjVaYkVzbGprM2ZTMzkx?=
 =?utf-8?B?WDB4TmlUaFZVeG4vemdjUk1XVHhEUHl4V1V0REErOUNub0o3Y242UWxNbmNB?=
 =?utf-8?B?dlR6c0p6RUxET1d3dDgxNEdkUDBMMVFPN0lsdzNQdXZEVnloZ1lWam85b1cz?=
 =?utf-8?B?RDJhbDZibmRVU1hNV2Y4KzFQUm4rRkdOSSszSlJjQmNmdXhWQ2F2cWlvNHdt?=
 =?utf-8?B?d3pOaDQ5cUdUTk5vUlAzVEVhUTJnVXRlMHNrSGgrY0h4dk9aY0FBUWRrbWU5?=
 =?utf-8?B?MmROdHZWNE15eWxPWlozMStjWUo2c09xK1RYNWs4VlZobFlabDh3UVBXSVY4?=
 =?utf-8?B?RU5HY2FlVXVnKzM3ZUtiNjRESWN0bEtHc2cwM3R0MlR5Y2VqNDVLMmJnUy9J?=
 =?utf-8?B?bUFOSkc4YzB5MEtIMGhoczNHWmkzdC9wRFdvb0tmSGI4V3FZRGpTR1VmeEFv?=
 =?utf-8?B?SXRsaC9ab1BHbEJhcFNWUWxsOVdJQU45T3FWSThlbjlhR21EeWx0aFVrOENs?=
 =?utf-8?B?ck81ZldzYjJ3eWpFMWwzcGFrdGQ0ellHYXFNTjlMVnBHdDJvSjBQaVZYelpk?=
 =?utf-8?B?UEkzMXZHckoyR2xVQ0xacGtzUi92dHhTeFZBWmhweVJBMFIrd3lQWmZMTnBo?=
 =?utf-8?B?VFBRTU1HY0hhQ040WUQyQzdtUCtSQ1VLSzg1Qmt6QURWMjhwd2NJcG4wdjJL?=
 =?utf-8?B?NWo4VDlZNVBSbGpvNkhSS1dxL3FkQ1VVaDNjT1hGeUZkT3ViYzlyZ05kbE5k?=
 =?utf-8?B?dXZ5aG5rRGEwdVZJaUhpMExPNzhkMkIxOFpKd0RuTjk0RU43LzB5RytQTHI0?=
 =?utf-8?B?djVzakdjNnRNVXVmdHNHMzFQdERyd2RGRFh1TEpISW96OWVhcGJiVWVyM0J0?=
 =?utf-8?B?b0J1ZWVEMW5rT0JLa3VvL2xXd2hDL3RJQmVRSHFscmxtTFpVaFpSb29SSW1O?=
 =?utf-8?B?K1VrcE9pZURnOTlkM2NTcU53T0ZiRGxkcndyQnd5VmhXWkJyWXgzaGkxTWh6?=
 =?utf-8?B?bTVwcWRPSTZuQUJqNnB2WVVoUXRKU0JzSGlXazVmb2R5REFjeUFsSXcwN05I?=
 =?utf-8?B?bDN6L0ZFUW92bHUxUHdBM1JMUzNSRU9QcTQ0SXdKVkRLVGs2aGtPcnJGMHdX?=
 =?utf-8?Q?ShuKZ6v/DoV5xF6biG95tRHA16E8hxcJtTu8c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3RhM1dqWjMwT045K01mV2VkdWpqdXVoS0FEbEtSVnhxcHVTMkh5d1RoNWJC?=
 =?utf-8?B?UG1YT1oxdlRKVnZxK2YycUVvWGIyY1ViSERvMzdJS0JrTVJRanFTT1lPak1i?=
 =?utf-8?B?KzlHMm1mcGRaZzM3TzM1N1AzV1FLOTFpZ0FrWmd6MUxmQkQxYlBuVno5ZG5F?=
 =?utf-8?B?cEIxQmljUWtybWl4blJnT1hNQmtzLys5L3JmRFRLL1JwVURNTWgzcE8xcHNB?=
 =?utf-8?B?ZDY2bXBBSEdzUjFsWWtiTGJYRFdUV1BhOXFOK295OU15akl3S1l6T2F4ZU4x?=
 =?utf-8?B?QjZmcmt2cUwydUNnRmYzYnNCVitBVys1dlk2OHZFZXhVdW9HRFNQakNZbU5x?=
 =?utf-8?B?WUVDcG9XOUovalRycEdPbHdMVUxOZG1qbkIvUkI1UWkvelZwQ3dFQmRDWU9z?=
 =?utf-8?B?V0g5UlhwTFkrbi9VOGMralRXMWtlQmlmSkx6UmRPcjJBdHhPZlhvdXJKeGZm?=
 =?utf-8?B?NXM4QTRZdGJWRXZXYk1MNExiY0d3akhlaXlIdjBrVjltVmNQcWxRSzlyeE0v?=
 =?utf-8?B?bjZNS1NycmJ1VzkwSkZtQ0ZCQkRya1h2VUdFdHdEekxhUGJmTDMzcHVUL1k1?=
 =?utf-8?B?VHJjSWlBVDJ5SGRhcVJKZy93ekUrK0V4SDIyQ3lBUGFiZkJVU2htaWJJbE5U?=
 =?utf-8?B?aVkrY1NGUzEvaHZhRkhPM2hQWDVpZjAzRnlEMzQ3cGwzbHpveGVWNUoyTnh4?=
 =?utf-8?B?aVVFODRNUFU4UWdtUmN6QTF0TGVsRnlPaFp3Z2NMRXVTc0NUWGtRSklPTm84?=
 =?utf-8?B?eFBYakI0TW43RjY4L2dETEJKb3hKMHRyTE5kcDFUYUNKREZsR254VTB5SjdJ?=
 =?utf-8?B?N0N0MFRIdGFUUUltNURZM0dKZ25SODVGOHdCMVcxZkhSb2djRy9GVGhtdjUx?=
 =?utf-8?B?c3pUSmltM1pFbTZxeXBPMUxYUlRlQTVyc0Jpd1NvV0pXK3oxUjc1azdmTkdT?=
 =?utf-8?B?UHZ4RXhyWW5GcVY2SGFlUGZTdDRFZ0ZtcmxKRmx4V28vMEl3R1ZqUGVQbU5P?=
 =?utf-8?B?c05RNlEzNW5sR2ZZZlhBWDFtSFhJZHJkWVVZT3UxSzR2TXVMVVFJZjFEbTlW?=
 =?utf-8?B?OXlpWXEvZU9yQ3NtZzdPZHhZMXdYempESnIybzFLMjJ4eTNUU3JMaW51ekgz?=
 =?utf-8?B?bVpBVGlVdnk3VFVtZytYWmZvUTMvWXphU091Wm9SSGloaW84SVhNNkhPakZz?=
 =?utf-8?B?VlAvbFlnRTJvYXVsdzhiYmtFRSs2Qk1JNUxzSHpQOWx3dkhnb1pOL3FUZDFC?=
 =?utf-8?B?VUo4c3hFTmhjQ1ZkMFpiZU54VklTb2xaZEhYNlN2dkpNTzE2VXNyQ3hzWTN5?=
 =?utf-8?B?c01SLzRDclp5V1E4TlV1alNwL1BCMmZCNFlsK3gwL2FKYVdPYWxyZHZIWVdS?=
 =?utf-8?B?bGlkdklrZk1sRWt6NGxrMXhCVVlYR3FaYU9QNithYlVPeUJXMDl6Nm9uckNB?=
 =?utf-8?B?cHM1VTROSVh1WlFCa1BjVU1RQyszNTJwS1F6Sk1MZzVjRHVKckNqUlAxTURV?=
 =?utf-8?B?MmtvYkQ5eFNFL2p3YUZPTGdlLytpUmJYbis0aCtJSmIyajlRci9LUzNnSlJl?=
 =?utf-8?B?V2J4Mk1DWFZ4SVlQMDA5a3BIaTFBd09nMytvMzBSVnJvMmlNUE5CNy8yQzBV?=
 =?utf-8?B?T1VnMXdXazVxY3JSOGFQdkJjcnI0OHphdWU3QjBxRnlSbmNzU1E4KzU0U3My?=
 =?utf-8?B?VDFBb1RHcUx1YlRrQ2VTUXVkYkhTVFpPWW1OQnJ4NUV1NjU3RVFrSUVySDVL?=
 =?utf-8?B?Y0NobWczRVVHb0t6N1YwRUgyYlVRcVg1Tk9ZditEeVRDTUNmcURjeG0rRHcy?=
 =?utf-8?B?N2hjdlY4RkM0cUtwZCtHUEFJYkkwRG9yRm1sRmdscTlsR1lRRmdHYnh1czBW?=
 =?utf-8?B?Q0VTNTRBYnVDMHpzVVNTcnE3ZW9LakFKUVZvcXhjblhCMzQyeXhjMlpINTMy?=
 =?utf-8?B?YWl4dnBUOXA3ZjZUTGREcVBQQzdpdkorT05VSDRVTnZoQWNJdUVJTWkwRFFy?=
 =?utf-8?B?V1VDSTh2cGlzOC9CZ2d0SnFzNGpIamdKRklwRGpWM1g3UGMvSlJxUi8rNmR6?=
 =?utf-8?B?VXByelVlZmkxcDJqekV4dUhnOXdiUXBla2ozc1ZUb0lsaXhNRWtGSHI0Q05T?=
 =?utf-8?B?T242Wi9TREZ2eHovMU9jZTlqYlF6YjFKMnFQY1BPNUNTMlBYNXVOWXYzZk1E?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a449b3bf-ea94-4327-8e9c-08dd8ccbf93f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:29:44.5796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5g4jKQ5xvbCXDC2K6QcOydqOmqS3Xi6RqQvje7S0pYJAimCS5Kihq3FeZEo+ScS75YTIUHYE58aAvvtZiAoWto0CIVZwYIA96W2cRyM70Q4=
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
> Fixes: 1be37d3b0414 ("can: m_can: fix periph RX path: use rx-offload to ensure skbs are sent from softirq context")
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20250502-can-rx-offload-del-v1-3-59a9b131589d@pengutronix.de
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/m_can/m_can.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 326ede9d400f..c2c116ce1087 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2463,9 +2463,9 @@ EXPORT_SYMBOL_GPL(m_can_class_register);
>  
>  void m_can_class_unregister(struct m_can_classdev *cdev)
>  {
> +	unregister_candev(cdev->net);
>  	if (cdev->is_peripheral)
>  		can_rx_offload_del(&cdev->offload);
> -	unregister_candev(cdev->net);
>  }
>  EXPORT_SYMBOL_GPL(m_can_class_unregister);
>  


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

