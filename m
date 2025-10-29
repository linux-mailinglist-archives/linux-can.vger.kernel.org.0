Return-Path: <linux-can+bounces-5278-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0DC19E6B
	for <lists+linux-can@lfdr.de>; Wed, 29 Oct 2025 11:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A7D4068C2
	for <lists+linux-can@lfdr.de>; Wed, 29 Oct 2025 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408B62DBF73;
	Wed, 29 Oct 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="VIgdCToC"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020105.outbound.protection.outlook.com [52.101.84.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA38332C326;
	Wed, 29 Oct 2025 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761735203; cv=fail; b=SFWOzmlom2DSP+9AZ8CBzUFKyVJkqhAnMhFMc/TviSS52vWPrkK31R9gbVaxzKMSNYRWWrDA9E3yGNDEnQ028ChZBkvtl9TOAV61TztASBGA+LzvNHlNeb/ZGhSkW3/yqdryMRyAgNeF5b1vgixW+4jourLXBTqk1KDsz0SN3sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761735203; c=relaxed/simple;
	bh=BzeZwNpt5LVmjC8ZIibfNU7wMSc6uIlntgMWhJaPorM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YNTtv+ZzakluK40rfELIsVLvU3nAt8FJQTWKuKwY2ok6qMrLyZQO8A8KLfWE3yq7F2UwOKwXKIWP7MVy5AyApMq+KsXELPm3JiL8oWGta2iEMwHkIwDrg5DPXuuSNehdnAelavc6eR1wtAF0XOq83bKsG9xNcyjKxSl8angQiNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=VIgdCToC; arc=fail smtp.client-ip=52.101.84.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJzBXt1qr57won2LCHdhLgTve4EmhkaxbG1a/4yRznlQjnNECKkcGCDZ3IDIW/Lc/0mkvrBvnVzLq56wgK3jVGH0G2Xv3aWRG92oO7fIvHnC2JgZ82egnb3BkM6sxUpUglVOP2zdZGP8j3BLWC1J7hpXyVoL1opyBguRnmqW5a6nSlbyQTVxnRRwGt7OEAQIGjrhZ2L3bYymbrsxLeTHv8nDl1utEj7RcSUSEwFE/VRjCsybP/uKCxiBVtgPDeBrH90s/rhkMKyJqKL2/jSINI+Ihxk2E2TApeCzVH5jiOi9g7ZjIhCbOEWyw09e0RbT+FBdgYwHGu2AcyNo7X71pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20K100AnseVlL6IDVQ3O4af/2NI1AQJRG8Xy2dOqGk8=;
 b=EjyDaf+toXXkQU89nVUpRzsyrWLSz/L5BLx4qjAiL6GAFTZYNwaP73urpVCA8f+mXYFqkRDXt6IjTdfnt7IGALHsfmgHpdoWwDUaG6IpCFEulVbwYhizNPgcQZGaiO0W5UR5XRSB3wCEenknSE1O+ypE9p56LurBYEJdsO7aeRKBPj14t7YTci4DSombq870y/Hwqw1STRy5agKdAdUWuy5zyO1oyilL6qDxh1s5KbEqEPVj36N5RT1KfOOWASONn5QdVrO/lpIgAm1dOhVS82gpqBDJB4nLTKCaKWLKlyaEIdOD9vDss0l3Yqd+Wae9h7X7UX0SQ8dRXm/WyXIWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20K100AnseVlL6IDVQ3O4af/2NI1AQJRG8Xy2dOqGk8=;
 b=VIgdCToCilOcKkwuWIU1nDzq+NSIEaqyBFt/ww8jbv/Z9HLkCINHfIooj8J7ki3mf2AUZ9rsc3eOWLLMIO6NOYosQ2CkfZNfb+OGGfY563cIlFehRC89tZBZZ+1vNyTqhP+yQlToHW4vAg88spMelnp0BcIucBQDr1VAlF4jF2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by PA1P193MB2662.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:4e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.19; Wed, 29 Oct
 2025 10:53:16 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.9228.016; Wed, 29 Oct 2025
 10:53:16 +0000
Message-ID: <5d794063-9f4a-452e-b19a-6442b0ce5fd3@kvaser.com>
Date: Wed, 29 Oct 2025 11:53:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: kvaser_usb: leaf: Fix potential infinite loop in
 command parsers
From: Jimmy Assarsson <extja@kvaser.com>
To: pip-izony <eeodqql09@gmail.com>
Cc: Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
References: <CAAsoPpV7Kzap1Sn8QFtBbvwW-DJMTTcU_bBOUDYYC286Uaddtg@mail.gmail.com>
 <20251023162709.348240-1-eeodqql09@gmail.com>
 <1d960d0d-06ab-4f38-817f-b9a5e949d3c7@kvaser.com>
Content-Language: en-US
In-Reply-To: <1d960d0d-06ab-4f38-817f-b9a5e949d3c7@kvaser.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0029.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::17) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|PA1P193MB2662:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9d2e36-fa28-46b4-fa65-08de16d95d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3d5dXI2NGphTmxmOVhhdjdNSkwrYWpGYTZHMVF5Zk56YVlkaU5MdmRmekUv?=
 =?utf-8?B?ZzZ5L0tjWEI3YkgzbHhLVndnN3B0bWNWQ3orbjZEUWpzRFM4VllFajJkL0FY?=
 =?utf-8?B?MFNSV1FnN3AyY3Z2d2NRQVQxRmRIRDZWTUpaWmxkUWFyTkVHQnUxTmxXOTN1?=
 =?utf-8?B?cXFNQUFIZTFWOWZ2M2VVNllqaFZPOVp4MXFUajE5TjZNZVduRDBZMkQ0a0pG?=
 =?utf-8?B?TGtwOFdyM1pjYVh3NjBqMzlrQWpaN1dMVy9HTUxKSFNxWEFUa1l3cGJpUUlj?=
 =?utf-8?B?b1NaRGZLSk0zNlBPSk85N0xieDI3SzhzU05nelB2RkFWbVE0WGMwRHpMWGh3?=
 =?utf-8?B?RzNxYTYzUTQ3Sjc0aVp4M2dmdFlObVE2eS9FZnowNXhwNEs4K013bmxYOEZK?=
 =?utf-8?B?cEJjNE5DbWc5Umpxc3laZWlkVmRBaHdGbUlnUy9rb3V1ZS9ZL0V2NVZHMTJN?=
 =?utf-8?B?SHUxRVhVR3ZZa1ZGa0wvK1BES3V4YTVCaEhjbkZPa1BGWVlPT09pekdpeFZo?=
 =?utf-8?B?dldoRjFuZWN6Ly83N2grNkhRTk1jS1VONTU4MEdkcm9SM3BQcmhyaVh5S1Q2?=
 =?utf-8?B?ZFZDOFVxQW9JODlIWWx1WXNvcnorbXNyZVNKd0FRRjArSDZxZ1NvRjF1akVO?=
 =?utf-8?B?ZmIvbENISU9yTmg1eHVnM2NLN0RuN0lMMGtmeHo5NVVjRzQ0b2diTkVQR3JX?=
 =?utf-8?B?dlV0TUhqRnk2R0ZMSnA0Qk41RGJ0TXdYSHcwNDFNWXE1MzdhK1hadzRLTm9C?=
 =?utf-8?B?K1lESEVIK2Nld0VaWWFJVVRwZm5UUUEreHNOZFpCSHFvNEtHdE1UR3h6eU1D?=
 =?utf-8?B?SDJuMVBvTHJSRGNIb1BRVzcySXd1OEhuT0ErUTFEcVNUS1k0YjR4K25na1Bj?=
 =?utf-8?B?dGFNRE4rdkt1QmFWU25FbngxYXJSUVVkSWlna1ZVeTlsSC92ZHpVTjErSkNH?=
 =?utf-8?B?aHVmSVhGdmtNaWo1RTBrTnlGanJ4S3lyeGd2Z1lSMzlNMDRucExWVmdDWm96?=
 =?utf-8?B?UEdHZE95YlVxVHdqdEJDU24vNkswQXF1VGpuOVBDc2J1ekNtYW0xN1E5aTJ5?=
 =?utf-8?B?QmFJbU5HT0hkdEtOQVBjbmJrSHhYcHZ3UVBUWDRMODFRS3l3WDlRTGlJbUNV?=
 =?utf-8?B?S21RZklIeW5QT0NnQkJtZGxLNlZRdGU4QjNvV3ZLbUN6QmtWUW1SKzhGQkl2?=
 =?utf-8?B?VFZWNzJXdnRVR3BnbEhMOVVaTmpoZHM5R0VuM3duYVlkTUw1aE42d05VVEtC?=
 =?utf-8?B?Uy9sL3NUWVM4S0pGRjFRek4wNVczM00rRitoclVYOHVCd2x3TjdvcUtrdG1w?=
 =?utf-8?B?ZDBVU2VlRTk3TVV1QUpjMU1XRkl1Vk1uMnlPNzFFcU84NnllanBOOXFkOStJ?=
 =?utf-8?B?VTZQZFRFWmNOZi9VWDNZL0Exa2kvVWtDZHR4WHJMVWRZNG1YMXprQkczYkJj?=
 =?utf-8?B?S1cyMXZQeE9HRm5oTWRzbXpCQUJ6QUdPREozZjZ3QURtcTIvT0FKb0RqcmJ0?=
 =?utf-8?B?dWFxT1N3b0VFQXk0ZDUwRHZhMWdhdVlqSFZWbkR2UWlpVzVUbFpRWlAvWVFU?=
 =?utf-8?B?Q2JZWnNDOGV0YjVYQUxvQjVENGZiRHpJRWdKWmlwSEpDcnhpbmc3WG1JSHU5?=
 =?utf-8?B?citFbmlsZVh1RU5rMmhxUUpyZ3lKOVlFV0VrQmw4bHdMUjlMN2VTajdWcGZU?=
 =?utf-8?B?ZCtrcm40UmQ5KzFxd25oREtpakVZZzlrZXB6OVd0Y1ZQQW1wVnNMTjA2TkUr?=
 =?utf-8?B?K0pvZVIrZVBtZ2tFSE9ISmd4S3Y4Vm5JNVYxQ3I5dEMyemltS3ZoaGxRRVg2?=
 =?utf-8?B?K2srRjZpM0xyNFpjSm5sOGthU1prVEtEa056SUhOZUtLZW9zQ1kyUU15SzhJ?=
 =?utf-8?B?R1BZS3ZqUHUvc3ZJWVhjanBEemJDbXNOditNK3hKNm4zUlFWdGczNEZOOXlD?=
 =?utf-8?Q?j1j4CB5a+Uzq4y6uyhmq30aLN0DMzeSF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2NwSnpwaHdzd1I0K3pCaVRUQ3hYSkcwSzFlL0VlaXFxdWgvemMvR1huTUZJ?=
 =?utf-8?B?SkdDemN3a1dBdE9iOU1uMWIzMXNaa1NKMGlYc2VwTmpncWFpR3oyUTBRVlpU?=
 =?utf-8?B?VW1aRHJHOXhySDF6d2lPR1lwNVdXZi9ZTDRVT0xmb2QvNWp5YVNQSEFDVE4x?=
 =?utf-8?B?d0RGc09hVXBTWnp6Ym5yVHNheDRPanBlUGlmV0ZnL1hrVkV3Z2ZHenZsY3U0?=
 =?utf-8?B?TUh0cVdLMFRkR3Jkb1RMOWRZZW9xb1U2WEkxWlFYSHhPbGhXdlQ4WjZ3TklM?=
 =?utf-8?B?T25teEl5SW9zZEYrZ0FCL2FuWFZBc0xuTTFZRnRucGdRUFJ6SGVYRWxUUzlj?=
 =?utf-8?B?NnQ5aXU3c094aGxYNzd2SkhwWmhPdHNsVU1oRjJVTzQ1NGpNTndwUDljVGFO?=
 =?utf-8?B?bEt1ZDFucmZwdE52eGFicitDZlpaeEYzTXFpOGFoYWR5cEZTYm1jUXREL0Zo?=
 =?utf-8?B?eHFVU093aDRjelh1VW5Ha0ZVZ0U0blNadDZnYjBLZnE2UkJCMWl2aUhJQVZY?=
 =?utf-8?B?c3hydmx6VXN1aFJWNHRyS1E4N0dLcmRWaHVGeE9tWTNqbHFpUUlVclFUaVAv?=
 =?utf-8?B?U0p2dUxIenpHc3ZXcGhadFQ0TTBEWEpWQk9hbWdrNnZzeW5jVDVTK0FwV3ND?=
 =?utf-8?B?K0pQUG5tU21FYWFGMk5aQy9XWlREQ3B3UHBpWEdwRGdvMXJrWVREOFFoMUJR?=
 =?utf-8?B?ZVdqaUlOcHloenVsWmFUbDhZSHVzUjZhYkNESGJNK2hYQllLMHBwQmRSNEU4?=
 =?utf-8?B?RFIrNWo0S2tLNU5EcSt5U2oySVFjQkQxQ0sxZUpvY2hTNmR4V2RtSjZ3bVZi?=
 =?utf-8?B?ajl6S0Fteklsc0JTVXNhTnVVck9JUDEvMkdWT2NWZXRUaHBhSDJiWUdUTk9z?=
 =?utf-8?B?WC9xdHFoci90ZWp2Y2ZhRGsxdmhXYmxqaVBia1Y0RXIxOFFjYnBUaUJ2THV0?=
 =?utf-8?B?V1FpYUJzUytEVGF4RWwybjhDVFJiV2FmUm1IWkhvZHhWM2ZHWjcwQUxRQlVs?=
 =?utf-8?B?MFYxM3ZhTkhFRFpEOU54aGFFUlRmSmh1QWZ1SWp1UjJCdHU5K1RwT2o2UmZm?=
 =?utf-8?B?bks4a0JRZnd4ak41NE5iSEUzdDllZHdhd1NKZlJVeW94Z3k4c0hjQjNlYXpv?=
 =?utf-8?B?WXVwMHBhcEs0ZDRyQ1ZZS0VJMnk4QUIyMmVzeTRLWjNELzNQTlVOdllhVmNO?=
 =?utf-8?B?WlZoYzNLaVRGcFFpU2diSEx4cmxQWm5Vd05jeUFsUk9EYVR1WFZmaVZGcndE?=
 =?utf-8?B?Q1g1a3pudFFSaldmWEpTL3ErYnQ2S1BXbEI1NXhPQ0JzUTF5SVVTVCtCTm1U?=
 =?utf-8?B?K00vbEU4cDZwSlN6QVBxQzdkVGxTSnVhMGpLV1lpaUZpZTEwVG9BZzVmZWxU?=
 =?utf-8?B?MVVla01KRzNCaUVZK3FpZE9WZ00vYzA1MDRSSjVNQjA2RUVKZ1F0aVg5LzNl?=
 =?utf-8?B?U3BoRFQ5ME1jMkcwRzZWZzUzWFBhNVkwbG1uNkgzNGJvWW1hVlU3dmt0SkJq?=
 =?utf-8?B?TjZXdmsyMmVqMER4dEx5MGFsTktDT0FJUHhYY2VWUFRzM2ZDQUxRMkFGRmwv?=
 =?utf-8?B?UHEzd0grbGZaRkFNNVdaTUZIN2g4Qm9Vb0ZRUGxBclFVVTJPUVBqQ3BsaXlC?=
 =?utf-8?B?R05ZZitzcjk3bjRuMGI1WmdWKzZGdGJNTyttaXFKY2xZSzRsVnRrZ3lnT0Ew?=
 =?utf-8?B?WG85UDVKWFl2Z2RTc25RU3VMK2pqcW1wOGpCQUlmc0ZxdlZRQnJFV2RjZHli?=
 =?utf-8?B?Rk1DM1BmeTR0Q0R4aTNKOVBJYjNFSktLNlZWbVM2cE9xalNFakN4bnJyemxV?=
 =?utf-8?B?b2RmUVduK3Z2Um5vc0RhdGVubHZsa0dkbzR1S3FBTndvZEJKbXJPV056U3hI?=
 =?utf-8?B?MS9QNlB2SHQvMFFQRVZIMDZQSkowYmZIaDNYaTloTnk0ZVZVNWxIQk8vbGc3?=
 =?utf-8?B?V3VrOVRjckNvVERZY1JRekoxSWFNMzE2WWZyVWNyZ24yZFpLK0xSelRkK2ty?=
 =?utf-8?B?eGZpYlQvdjgxREYra3k1YVlYSVQxbEYwRnNZU1pnQUpNZFBqUHV6OFhobnNL?=
 =?utf-8?B?Ym1iUmVEcllvalNjNXJYZXlNOGJOY0czbWVKNU16S2ZyUnZ4MEJlUkExOUdM?=
 =?utf-8?B?dDZSNlkyOXNFcXc4ZlZXaEFhT0J0am1Zakh4U2kwOVZDQS9kUlZFSGluemp3?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9d2e36-fa28-46b4-fa65-08de16d95d40
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:53:16.3460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1Z0yMnQyUQga/B+nqb99sWHJ0bMcxc4sIG1wjCDGQeUOqFixi4A9A54d64f6k5TvUkIBV5t/Bm4aC+4F2zFKfzgPvCto3C0zUvj73sGcH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P193MB2662

On 10/26/25 14:26, Jimmy Assarsson wrote:
> Hi Seungjin,
> 
> Thanks for fixing this!
> I'll do some testing in the beginning of next week.
> Which Kvaser device did you use when you discovered the problem?
> 
> Best regards,
> jimmy

Hi Seungjin,

I've not been able to reproduce this problem, when testing with the
latest firmware on multiple different devices.

If the next command in the firmware packet queue, doesn't fit within the
current endpoint transaction (wMaxPacketSize), the firmware will
terminate the transaction with a zero byte. The driver then interprets
this as a zero-length command, and skip to the next transaction.

The firmware is responsible to insert a "zero termination byte" only
when there is already one or more packets in the current transaction.
Since all commands have even lengths (4,8,10,12,16,20,24,30,32 bytes)
and the wMaxPacketSize is also even (64 bytes or 512 bytes, depending on
the device), I cannot see a situation where the zero termination byte
would be inserted exactly at the wMaxPacketSize boundary.

Can you please provide which Kvaser device and firmware you use:
   lsusb -d 0bfd:
   ethtool -i can0

Best regards,
jimmy

> On 10/23/25 18:27, pip-izony wrote:
>> From: Seungjin Bae <eeodqql09@gmail.com>
>>
>> The `kvaser_usb_leaf_wait_cmd()` and `kvaser_usb_leaf_read_bulk_callback`
>> functions contain logic to zero-length commands. These commands are used
>> to align data to the USB endpoint's wMaxPacketSize boundary.
>>
>> The driver attempts to skip these placeholders by aligning the buffer
>> position `pos` to the next packet boundary using `round_up()` function.
>>
>> However, if zero-length command is found exactly on a packet boundary
>> (i.e., `pos` is a multiple of wMaxPacketSize, including 0), `round_up`
>> function will return the unchanged value of `pos`. This prevents `pos`
>> to be increased, causing an infinite loop in the parsing logic.
>>
>> This patch fixes this in the function by using `pos + 1` instead.
>> This ensures that even if `pos` is on a boundary, the calculation is
>> based on `pos + 1`, forcing `round_up()` to always return the next
>> aligned boundary.
>>
>> Fixes: 7259124eac7d ("can: kvaser_usb: Split driver into 
>> kvaser_usb_core.c and kvaser_usb_leaf.c")
>> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
>> ---
>>   v1 -> v2: Apply the same infinite loop fix to 
>> kvaser_usb_leaf_wait_cmd()
>>   drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/ 
>> drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>> index c29828a94ad0..1167d38344f1 100644
>> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>> @@ -685,7 +685,7 @@ static int kvaser_usb_leaf_wait_cmd(const struct 
>> kvaser_usb *dev, u8 id,
>>                * for further details.
>>                */
>>               if (tmp->len == 0) {
>> -                pos = round_up(pos,
>> +                pos = round_up(pos + 1,
>>                              le16_to_cpu
>>                           (dev->bulk_in->wMaxPacketSize));
>>                   continue;
>> @@ -1732,7 +1732,7 @@ static void 
>> kvaser_usb_leaf_read_bulk_callback(struct kvaser_usb *dev,
>>            * number of events in case of a heavy rx load on the bus.
>>            */
>>           if (cmd->len == 0) {
>> -            pos = round_up(pos, le16_to_cpu
>> +            pos = round_up(pos + 1, le16_to_cpu
>>                           (dev->bulk_in->wMaxPacketSize));
>>               continue;
>>           }
> 
> 


