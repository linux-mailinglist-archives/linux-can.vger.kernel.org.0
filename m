Return-Path: <linux-can+bounces-5272-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF394C0A88A
	for <lists+linux-can@lfdr.de>; Sun, 26 Oct 2025 14:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567FD3ACF49
	for <lists+linux-can@lfdr.de>; Sun, 26 Oct 2025 13:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665301B4F09;
	Sun, 26 Oct 2025 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="jC+yLq5j"
X-Original-To: linux-can@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020115.outbound.protection.outlook.com [52.101.84.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2666D72639;
	Sun, 26 Oct 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761485255; cv=fail; b=oTDa9R85PBzPYRYsMYNw+sx1yV+KTHi26Gce8dbRDHK70PxyTxzlDQhMu0RlFKuQh1hbXNy5ySkcKvWdYdRT92G6CSXhC/qqeZykt2mZjV/Moac2LSveAvRRuIjNVKSk/rQunv8eGYkim4rOghoORN3ip65mf4Y19lTvpxNjKqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761485255; c=relaxed/simple;
	bh=omNPYlYh/3PdFnNOfZCBIbNE3c54/kC3bJFiDCXYiUs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NDvmT0quXaWMQjNabdRy+No7bWScuCBpvm+rLZehC1w2ToRH8DQ7IFia2LmovBD27qcm8ldZHkDKQ2vJgTzdkT+eEfA7uOXY/gC2OBcB96eJ4AomiqyQGFNNFMIOmTQMPrUSG10Udq/RaAH2hVNGfcnU1O9UN0jO7QldUxjZtQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=jC+yLq5j; arc=fail smtp.client-ip=52.101.84.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjWQbYnfGJXim8KGOe4/YCtSYqsRPJ30hyRpmsB40qCzI+rV7sIrdZb6GCTJ975h2DkOXV9qZlaTgHCV8+qFoPientd9LuPdyf5ROeiZ0FovH8T2fVQA29wQTmb7jTtGs4o9NgRvpGnj985m64Bw3YBICKqBhtAMkHfawq3Q5Jp7tbus1bjBciTM4ZatN1mPDRBTP5mHQ6ST+vdYb6T5pKecGcum3c06WjkZWcrOgTYMf/HIILjn63zXNcpjh3QxWoFSOGoC27jkYYMHrQbjWs+E59PzqGrl3QqG1qlcfNp8lWa7hkHpdYaeELnz4JeHe6TWPIsghsm8oiNPFTWyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWAYzGZAJqPLBA73DTgFKoXMzDrEDbbdQCI9MfL2eHc=;
 b=HL/ZYhgKYjPhzjYDJ7ZLA8Le+PwUjCmGPmJqAvTMncItlVQYIS64l0psQVKIxJvzJ80d46n8NsZ1DjSNaCh19tpbShuawwEu9o5CzHANbZKeKpqDf/L9OleHYMq/EcnwH3GRj2pBVYQy1wpwTtrjyIacIolp3eSvUz5JfxTS0ulXliY0/Ns7irbqPdgwY4PllAHGnIwiWCm3IRQPGmXofA8s130vGJOOsRqnmoXUOPI5NGZereJAg4J+eqLruQ53aoz4DrQgrkUFWGwmIvUMI0IHaEB3B/Vf1oHBJwbdrknYtSW3t2HQBKVxLG0Lky8jfPUsyWu9zq2e8YFuckR5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWAYzGZAJqPLBA73DTgFKoXMzDrEDbbdQCI9MfL2eHc=;
 b=jC+yLq5jm/S0nAPmzDIOjvbm1ZY5e5JXhEWYeTRMeSJTePsUbPSkhwYnRFVRwikZCs1lA1ljTamv2ivQTp2YZY9p4grX8ZD77LJMvCqYPMAQSfPtDj67kaz7aXLZELBBc+gxQkzz4XgTV7mOXINBeWCwtxMxABnJA6OSbrozYU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by DU0P193MB2770.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:5a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Sun, 26 Oct
 2025 13:27:29 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::7f84:ce8a:8fc2:fdc%3]) with mapi id 15.20.9228.016; Sun, 26 Oct 2025
 13:27:29 +0000
Message-ID: <1d960d0d-06ab-4f38-817f-b9a5e949d3c7@kvaser.com>
Date: Sun, 26 Oct 2025 14:26:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: kvaser_usb: leaf: Fix potential infinite loop in
 command parsers
To: pip-izony <eeodqql09@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
Cc: Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAAsoPpV7Kzap1Sn8QFtBbvwW-DJMTTcU_bBOUDYYC286Uaddtg@mail.gmail.com>
 <20251023162709.348240-1-eeodqql09@gmail.com>
Content-Language: en-US
From: Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <20251023162709.348240-1-eeodqql09@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::18) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|DU0P193MB2770:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e4f73f9-3d6f-4405-a482-08de14936933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnVjMDFsSmpMME00MXhwQVNhT1FCV3lncktTa1FqVW9IRmlrVzkwdGJOMU52?=
 =?utf-8?B?dTZNdURXUkEzb0N0T1B1dzdpb0E3M1lWVTJkQ2piR3Z0dHgyZGZYL2pFbjZw?=
 =?utf-8?B?eGZvaVkxdWFwc056SHFVdmwxZ3hoRThpS3o4Yjc2ay9BVXVqbmEremNZNTRF?=
 =?utf-8?B?bXFIb2tjQXFPYjUvV1hydFdTQmFsNGxsaitRbTFIWS9ScjByNVRIVjJhTVJh?=
 =?utf-8?B?czdWRjhCaDdMc0hTY012YS80eXJ5Qmk3UndsS2xjK1BucU1tVGMrTzc3RDI0?=
 =?utf-8?B?K1NZaUlMdy9WR1JseU5Yc3REQkJiYTg2SytJeExFWWl2KzJ5bW83YmdqeElT?=
 =?utf-8?B?VjBSaFhFYmIxUXZwQ3ZjNUdRQXFZQTNRNTZLVU4vZ0tQd1E5U3ZMczZTdTYr?=
 =?utf-8?B?N2VGV2F5djRPc20yQUJiVEZVZ1FRdE12MEMzZW1zam5nSDVxNWtzaklwMElN?=
 =?utf-8?B?b3NVUXJtQVlNcSs2RmhoaGtZZmlaQWdsRyszR1IxSUV5NzQvZFMwazFyNTdG?=
 =?utf-8?B?eHRZK1U5ckJUSThxTlFBMWQ0UkRrRzh2RXp4aDJSQ1BsNk4wVFYySFpoN1FF?=
 =?utf-8?B?eUZwWFFKRHBHaWhlSEs3UzB3RHVONjQ5VjZqeVZKeGNhd2dKeXl5NGFXenBq?=
 =?utf-8?B?ZTl1NUw3OFBpOXErRFNSMHorWkRVRjRyQU5na2VtN3phRzVPbWRjMnRGYW8w?=
 =?utf-8?B?R3p2UVdrNUZEdUlqbGZrRWtTZk9Db244TjN1L3hzOUx6RmpCays2VDA0aEY0?=
 =?utf-8?B?emliN0t1WnMyMThQV0FUaVJ0ejliZzd5Sk92dGlnakUzcHdqbUFWaks2SGZy?=
 =?utf-8?B?Z3dyUVRhSkEvam9yaklIWVc1azU1Y05ZNTdHK2V0OXJocm91UFFBT0hhalVC?=
 =?utf-8?B?TXd5aWpIMCtEU3FRcVZ0bFVkaW05OS8yZ1IrTU1zTThMMGVDQklLdTN2THJt?=
 =?utf-8?B?UmJSMHNhekFkV2ZiaUdBNS9tR2M5dWFRbm00WEJ6QzYvT011eENxMlhmNTBX?=
 =?utf-8?B?T3oxeWxZNUVtSExTRWRTNlNLMDZwTzhURnVEdVlxYTlYWklxbmwwUFRtL1NE?=
 =?utf-8?B?NDM4S0t6dUFyQmVGbUMwYndlQmFTU2czVEY1UTlNTS9ucUNtRVBhRkNjenpK?=
 =?utf-8?B?a1E3MGVGb1dqbzdBNHR5Q2VPQWZTc05FOERka1U5UWJla1h0MnBmSklxL1ZZ?=
 =?utf-8?B?RmduQW9lNm1UOFJ6TzhNNEt0emtaelpVUloxbzN5SVVXWDBrYkh1WTVvd2RX?=
 =?utf-8?B?V3p3RjNSVnJuNytSMEo3dHdjK0xGZVBneE11NWpieHMyTW5tdnNoeVVjK0xZ?=
 =?utf-8?B?ekt3SDQxME5UNWhNTUx3bE5hSDNrcnZwaEE3d0x4RHQ0ZGtQQmVHMm5qN1Ux?=
 =?utf-8?B?NzRuMDdONXIxYklsTnF5dFIxVGRsbW1lc21DME9aZEVjQXFpOFdrQ0F0UEgx?=
 =?utf-8?B?ZVhrUWVIMjhsSm9qSTBQZ1plbkNCQ3F4b2pLbC9BUlFpcGNEV01FMnJMMlJP?=
 =?utf-8?B?eG9GbWw2bGFGTFJkOG5JQXhHVWs2ZzFLWW10NzU5OENSK2dva01rcG9vK1hJ?=
 =?utf-8?B?Y3NGVXprUXpYUFNVbC85dEt5cU94TXFxTzZGd3FkRUZvdFFzc01kL09vRVFt?=
 =?utf-8?B?VmsvT3RUdmxGZWVualFJU1VqVGFLSHZhdENtWUpUSVdqNEk2Vkp1MFJjc2ph?=
 =?utf-8?B?SGptZWhLTk5sL1U1MzRJS1dKdlRjYkQ3Mk1MTWk1TllqOW1FWEdHUnRZbkhl?=
 =?utf-8?B?L2Nob21xMHE1dy9FVUZxd2xqVWllRklEOHVyZHI1MTkrQjFnMERvd09YK3Vu?=
 =?utf-8?B?SzgweUNtaTlmN1BQeTJjMnJDKzhlRE1IU1lQMjJiS0o4Y0ZlSHpHOFJySEhG?=
 =?utf-8?B?bWN1WnVKd0owNE5MaFdBTWNnaitlM2NYNDhsWFJjQXRKNVU2UzZLY2dGc1JF?=
 =?utf-8?Q?Vqrhi6FX8Ax96/zQbPZ+akuRPUsSQ35Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWJzWlgxTW9HWXlkb0RsSUV1dlRKRUx0UXdJcTNpSk5OVmRKaGh6ejFvWHZW?=
 =?utf-8?B?bWc3dis2dEswdjVqTjJIaFY2T1JuS2lkcmZyR3hDRkoySTkvQ1B0RnZ1YXJ0?=
 =?utf-8?B?RDVuMHdkeGhYOGJjMVhnTXprNjMxZEplUS9STXZJRmxxYjQ1V1Z3NmdXeWR2?=
 =?utf-8?B?TmM4RU10dWxabmlONk5ZY0R4YjU4a3ZFY0k5cC91RC9SQjZpMituaDFiQ3FJ?=
 =?utf-8?B?WHhYTVIzcUV1b3lDbVlHaDI2Y0szVkVRYzF2NkVsNTR1ZkdRNGo3WEpVc01G?=
 =?utf-8?B?dVhpcVQzRGQyOEpFZDlRSlIxcFJob09CKzJaajNOdktPREo0ak5lb05rWnB6?=
 =?utf-8?B?ck85VXp3ZnNzWnJxZVp5K3VWVTdteVZTZWZSZFRjUWdXNDdPU2tvTFdCTExZ?=
 =?utf-8?B?TnMrR0w2TmJsZWZsN0xFdHZvMFVuUUFNcWwxcXVReXZ2QVNXMTdpZ3dHbW5M?=
 =?utf-8?B?NTY4QVdIaXY0amNOelMwTHh4TndDbEM5MHkxeWY3bnB2MWdtU2x4TzgwMjdp?=
 =?utf-8?B?STNsbzJLR09UQndFWWdPS1dQWmtuYlYyZTI4dUNwdnlyN3UzVFgxeWg4VWV6?=
 =?utf-8?B?TTB0a05GelJkZFFlQTV3MEhBZkFQV3UycjhOWDVqdkRaMkZreDRIcm1FMktO?=
 =?utf-8?B?a0t6VkgzaCtCZDZDcW1Keit5eStMcmoyY0FySVY0cFV4STdoYXZSb1NrcVlH?=
 =?utf-8?B?WW1LMGNjcWdCZTFncldNVHZ5L3I4RTU1Zm5ld1JrZGV2SkNxbldqMEQ5MFpV?=
 =?utf-8?B?OVF3b01QQzZJYmlkY21EVVl4a1RkbFdPL0lxV1EwcG9WNDNaYk9LOU5LZ2cx?=
 =?utf-8?B?RXZMREtCWGJCbzhQKzBqNnlrdGl1cTJCN25rWUlFZ0hVS1hRbVM3bnV1a01D?=
 =?utf-8?B?cXU1UXpzaDFwUmR5Uzc5cHIxSldHRmRyQVk0TXUyWWNiYXhsVFJkT0k1L1Vx?=
 =?utf-8?B?T0RuQTJqb1ZOVFJhODdYQ3BJYVk5NHNvYWtCNjBzRHgvVVJ3RE5YN3FiUS9T?=
 =?utf-8?B?TXhTTkdhMnpVT3pUZ25BbmxYdzB0cW9LT3NSd3JleWZTY0RURlZDdU1QdnQz?=
 =?utf-8?B?RThLWHpRUlhKMlVXOTZDbzNGUlFkT2cvNVNuKzNOQW55N3VBRjdlbDZjUUVx?=
 =?utf-8?B?aUhZYkRMR1BwSS9IdkVKTlJBbkxRRk56UkRvNzJVMEhhcjE4YkFwOHYvSUNu?=
 =?utf-8?B?TFgyNjJGVWNSVUF0bXhlOVF1bUZzUk9UdE42UHRLc3ZtWS85ZHUydStKL1Q0?=
 =?utf-8?B?Rk9TRlRSWWtRRVV3dENNbkRQK21CWnZGRW5lOW4rLzg2UnpOWjlLak5lbTl3?=
 =?utf-8?B?NlJ0QUdWeW5na3FNWkRYTTlWNnNsR0NRWGZHMEROV0ZKWndoUkVua294RU93?=
 =?utf-8?B?SUUzZXhOWURjekVLaEpzZUs3NkZuNDBEWXp5OTJBa21oL0VjTHVDRmJDTGwz?=
 =?utf-8?B?S3pIenVYc2Z3dWNSMUZXUStBNmRRREtGSUt2U0RyTVJKQ2Nlb28rWUFrUUNK?=
 =?utf-8?B?M08wNUNxYThkUldYQlF5ME1FTS9BaVNqdEdXaGt4VHowQnZHMUIwek8zZUNz?=
 =?utf-8?B?cU1mb0REaTRWOHJFM2g5MllFdzNkQVpvcGllaklBZk1tSWhUQUtBUkdBQXJJ?=
 =?utf-8?B?U3Q4azlSU1poM0pwQmliRzhERGpQNmFPcm9Udm9STDJRY3E0bXVQS0Z2eStz?=
 =?utf-8?B?V2NDVjFTZUw5Qno4SnZ1TExKbm1YYWJLZTZLU1kxSnZxM3d1MG83Z2RFZmhM?=
 =?utf-8?B?a2h5MDdyTkRUVkdPSklwY1phQTNpa3R2VGZvUGJFYUZOeUVvRjZUU3hzYUdx?=
 =?utf-8?B?SStpNllUN0tIU1JUakRFMEFJUzJSRUd0NzZnNThHSWRicld4SGpibWwyVnBO?=
 =?utf-8?B?UkIzM25GSUdNSEltUlpQVnhuajZaQTU2b0ljaEtxTkVMU1psSVZnUFBPNWZh?=
 =?utf-8?B?S2dkbzdsbXVvOFllWDB3cHhUbWNlajVCOGxhNlVPM2RTV1pYS0FiSFV4SGcz?=
 =?utf-8?B?N21HYklFZGVLSkQxM3VDQ3dqbEJZdWZjR2w5OUdYNG1KVlJQaGpPRUlYMEFF?=
 =?utf-8?B?WkkydzVEYWhhcmp1bTJ3dXIxTDVrZmpWSXYzQ08xSGhiT0J1bFJLSWJHZTRx?=
 =?utf-8?B?dEdOMzAzR05XbkFJMUxNQVJIN2ZLTWRKd24yMjRPZHMrazJxQ0swdlUwQ2dH?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4f73f9-3d6f-4405-a482-08de14936933
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2025 13:27:29.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfGmVJ+qDut+Okb/AjkAP7TjY97jVmq7GgtRaxo0c9ae+ej34JoFiks7QlDmWwFtkaQqoSuuUM2XUkOQ0+3jKI/GF/1deC0HihTY66x2xcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P193MB2770

Hi Seungjin,

Thanks for fixing this!
I'll do some testing in the beginning of next week.
Which Kvaser device did you use when you discovered the problem?

Best regards,
jimmy

On 10/23/25 18:27, pip-izony wrote:
> From: Seungjin Bae <eeodqql09@gmail.com>
> 
> The `kvaser_usb_leaf_wait_cmd()` and `kvaser_usb_leaf_read_bulk_callback`
> functions contain logic to zero-length commands. These commands are used
> to align data to the USB endpoint's wMaxPacketSize boundary.
> 
> The driver attempts to skip these placeholders by aligning the buffer
> position `pos` to the next packet boundary using `round_up()` function.
> 
> However, if zero-length command is found exactly on a packet boundary
> (i.e., `pos` is a multiple of wMaxPacketSize, including 0), `round_up`
> function will return the unchanged value of `pos`. This prevents `pos`
> to be increased, causing an infinite loop in the parsing logic.
> 
> This patch fixes this in the function by using `pos + 1` instead.
> This ensures that even if `pos` is on a boundary, the calculation is
> based on `pos + 1`, forcing `round_up()` to always return the next
> aligned boundary.
> 
> Fixes: 7259124eac7d ("can: kvaser_usb: Split driver into kvaser_usb_core.c and kvaser_usb_leaf.c")
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
> ---
>   v1 -> v2: Apply the same infinite loop fix to kvaser_usb_leaf_wait_cmd()
>   
>   drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index c29828a94ad0..1167d38344f1 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -685,7 +685,7 @@ static int kvaser_usb_leaf_wait_cmd(const struct kvaser_usb *dev, u8 id,
>   			 * for further details.
>   			 */
>   			if (tmp->len == 0) {
> -				pos = round_up(pos,
> +				pos = round_up(pos + 1,
>   					       le16_to_cpu
>   						(dev->bulk_in->wMaxPacketSize));
>   				continue;
> @@ -1732,7 +1732,7 @@ static void kvaser_usb_leaf_read_bulk_callback(struct kvaser_usb *dev,
>   		 * number of events in case of a heavy rx load on the bus.
>   		 */
>   		if (cmd->len == 0) {
> -			pos = round_up(pos, le16_to_cpu
> +			pos = round_up(pos + 1, le16_to_cpu
>   						(dev->bulk_in->wMaxPacketSize));
>   			continue;
>   		}


