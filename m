Return-Path: <linux-can+bounces-343-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E910F85E26A
	for <lists+linux-can@lfdr.de>; Wed, 21 Feb 2024 17:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183441C244D0
	for <lists+linux-can@lfdr.de>; Wed, 21 Feb 2024 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69098121B;
	Wed, 21 Feb 2024 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="yoocxbxc"
X-Original-To: linux-can@vger.kernel.org
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487FC81735
	for <linux-can@vger.kernel.org>; Wed, 21 Feb 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531297; cv=fail; b=tecfc3AqxW4pG81FxJXgIlgi3b5bdBPMhC7tnZdVgDUHqerB5Ttn6z6FfItTK8wAXQNAo44yqBlFAF+Ns8aCSOXvSFhvefhXUkLTq6iEU3A4+DavnVmIqgPPMaNovtihiDCIr+hFiJrLUenRZjwEO7pk4IdAI1DaN9L8tVqZN7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531297; c=relaxed/simple;
	bh=oRF7D6xmMc7S6eTIXirB6AQkqY9CD9gx8MT6FYSo/Cw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMDuR6uljQ9HOd/j80hbzNPTMFG82bS4T5HrryifBqIVdFI39XjEj6eg2RvZKrjwWO1h/iMKllbqX1/hxBEPM9LIUY+IC41w/Y7HN64mf7kyoWFZaB/r4ubXt5+mdUI7UNlIm2UTHC8GIrfA0CsvlK/WpiCBdmJAqLsIyTUkzig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=yoocxbxc; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.9.72])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id E312F10044843
	for <linux-can@vger.kernel.org>; Wed, 21 Feb 2024 15:42:32 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.168.141])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id CAF7D10014C16;
	Wed, 21 Feb 2024 15:42:24 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1708530141.730000
X-TM-MAIL-UUID: 592f073f-ce6a-4005-9ce9-c1947b27b59c
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id B26E010001517;
	Wed, 21 Feb 2024 15:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwLs37KEeQkkchrbzsKVEoBOhSqgEFA0NMekyhgw1yOTjnjq52h68+XIG/XkHRiRBqJBtvARY+P4ejtoUVIK05lOmR7VjuDY6nZmReqAiaLfjHjlhaXMJPfyakt+5H2mTB6E2V6RH20ZVlXyl+3UYaokYfp4o2z77D/+uwkvKCIS+yLTs2MJ8CSwX5qt3SAInsCBo5HF/8e1pQDZGgAXpaz5ycFTpnmz7p041qXYnfnDan496v0kPMfFuGc6zJbYv5yYC497w6Tia3TxP6brDJWNgKIXPCJrGeGrttiyrnbkiDU4bhQ/Z3ABNjfJTenGIXhrio/VChraxyyFlINrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlsPmf9YPXrdh8zN3hgB1vMi6NPvbOOuC6eZyPDeUO0=;
 b=mBuFHGI2BoOOR8GzRsMVn5Y33b82PhwS1T4FCdgWzDyjmEGsMO5NRowp2F8T4AtVN1Dk2tyHbK9aICHNgIu/L14gMLwLeOd4R0oNLmixXZpRep18bpUJ3WhbCkSI0rlZCOOgzjYnf0dh1uoLOw04wu7sXqXRqSM4FEoNTi0GHlYodSl7pGm7jrD1nbWmaj4DfgyxLB1SuMd3svfeLPfgY7tW19n3huVyvfjDqJjopV/UbIMj5Ks04ZQwyPQzCj01Nn7g9e3Mjonhxl8XN4dPTM5kU1DF96UmMgIP5PBTVbQGpKL5JOPJZ55lYFF3SX+PHXvlUJup1QF6Hsc6GnpLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <0874278c-9497-414e-b1e5-4ebdf5db6da7@opensynergy.com>
Date: Wed, 21 Feb 2024 16:42:18 +0100
Subject: Re: [virtio-comment] [RFC PATCH v3] virtio-can: Device specification.
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 linux-can@vger.kernel.org, Harald Mommer <harald.mommer@opensynergy.com>
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
 <ZdSYtPtn5UzKNhAi@fedora>
Content-Language: en-US
From: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>
In-Reply-To: <ZdSYtPtn5UzKNhAi@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::8) To FR0P281MB2861.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:55::8)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR0P281MB2861:EE_|BEVP281MB3712:EE_
X-MS-Office365-Filtering-Correlation-Id: 93efb96e-aaa8-410d-383c-08dc32f3b046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QIlTT8ZrFwaIW99TEzpEqZ9RohFotzS/z2NKCf8jb8/jl95w9bqXfUIcsc3fW5bCCXf0Bej0PBAT5rtM11WcTacNrPkIomr42G2hzeeXgYYIzsy5Pr7qIYLkPhwxjyc5/7c5KJS8kdx6ebVmOuVWaA6VWbQfU1ws90CAV4mV29uvZdgCtDuIr9wFAfErLIfi/Z0zWxjQRFaQ1FabNXiJ/4mIRako4PiU9d4lS62FzRPzaDiYJk7TNLWMgIoJHkLjyU/jNxXVnjzHqxhwGKOLgQce1jQHyMV2n6J2QEgKQlMgG4YxKf88ogWDUcXGewxzNWLgB9Fr7FVoJwG0CUs3X94xhgczcdFZOPtS0NFjD7kEHDyv/r+upEVs33Y2PArhkoRfqYEY6EWF75WPqXRqJM8K9jkGrublblWpwKIW2PsGe65ZlyvMhYlA5tjoHcroivOGTK1vaND7x7AzwP9FhQphclfcAwEe9nkxu/IdhufVRHNlt7Js3NgqcmS1KZWagHtsbyuZmJXlWbpbb9U1eQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB2861.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V21RL3I5aC81eUQ4UlF2SVVKb0JYbVI3MjkzeFYrZmROZUptTzJxa3J0R2VR?=
 =?utf-8?B?T01EV2Vockk2NDYwNzJ1eXhtdy9YTzdLUUNDcjBHbkYvYnZ5RlhpdGRKUWhZ?=
 =?utf-8?B?bGV6U240eUY5Mzg3ZEEwLzNsaXJyUkNrS2ExK0o1N1J4QUVmQ2pLWFlSbUZD?=
 =?utf-8?B?K21iV1JtTUhoa2k1bGhZOUdXcFFnVWhtOHlMMDNUaVpONXcyQzBmdGg4Q0Z2?=
 =?utf-8?B?Z2h0M0VURnFkNWQ1SHBnWVo5bjBuTnlZNFRacmNFb0tybWdCYWVQZnlTM3Nn?=
 =?utf-8?B?Ty9lTDA0NGpBVjVLVmk3aHM2YW9FQkxCeDhZNXl4MGQzOHlDUUdHSjUrT1BN?=
 =?utf-8?B?ZWF3UW9DcHpjL3BvbUNXNDd5a3hLVFE5WEgrMysyU2VjemxQVjgwclYwR2Ft?=
 =?utf-8?B?LzM4ZHRBQUc4VXluWHowYm91eXdqa3pwM0hoSXdTRVprdHZGYncxUG1VNSsw?=
 =?utf-8?B?VS8wR1RaVG9UZkJlem1ibzR2aEVzdEtVMlpvNUVtMGF1MVJsTm9GcUNrVzAy?=
 =?utf-8?B?aXh5dlVvSjJYTVhOMUlicll5QWhQRmJLUmcwQ3lOVmhLUXFFSkdVeUJUd3VN?=
 =?utf-8?B?VVVwdFhLZFVUVlA5YTVGRXJPek9iYjU4NTd5V3U1bStwczR4VFVtSWNlclZO?=
 =?utf-8?B?LzVCcXJGMEhISysvWFlEeS9tWTVLMlZ3enZRMTJhWnBRcmVla2dOWnJpUkhR?=
 =?utf-8?B?dWhRajFBTmNkUzYwamFqRVN3emYwaWg4MHhLWlVOVlNUTkpkMER0KzJOZkJ6?=
 =?utf-8?B?V1BFSFJKZnNnMElYb2h4dXdoNXF2TGFMZzRQaWtDSTJBSE10T2dkRXRrV09M?=
 =?utf-8?B?bkh4STVnbW1uaklneXZhem1OMHVEYjdtdVE0MUtOcDFENkFUS0xHeEZpYmVh?=
 =?utf-8?B?RHIzWjlqUm1xaVNlNDFsRWQrN0dWaG16eFphUWUyM1ZXQ0Zid1F0c1Axa2VU?=
 =?utf-8?B?cnUwakx5Y2FaMVNyOXYyVHRsUXRnbHc1b1haRVBVZGdmcDA0bnh0Y01xMUV6?=
 =?utf-8?B?VG5BRlRXTW9lTzVwU0hIV3ZEc2hEdGpuRVRYMHNYQ1Z3YmRiMXZuYWdTWDBa?=
 =?utf-8?B?SEdibnFFb2owK0FlSTRGc05ZQkJjdUxuVHlBZExQd0tvcGVyTk9wczYwdmly?=
 =?utf-8?B?eElKazZleEJxK0RWM1ZiUWpDR3VpZG5vZjVVTjdJSmlDWkdXdzFtTXY0N3ZF?=
 =?utf-8?B?djlNWnJvZGRnU2pRdkgzYStpVlg2blhRTlgyRkFIQVRwRE15c0ltZUNZMjdy?=
 =?utf-8?B?VFh0MXFGOVQxL3NVT3VnNW9JRGh1NEpVUnl4MG9oL3R5empacWtCODBxQ3lD?=
 =?utf-8?B?cmJzYnVMcnVjT05PQnN2cWZBQUFyZUtHemlOV2JZUnBtSGt3Vm9CeHJaUWlO?=
 =?utf-8?B?NUw3SjdXcWlTdVhIVnRHYlVGR2lyWXdBRGlDRDd6L3hGbFdHbGN2SFFYaTA0?=
 =?utf-8?B?QVVrdE1iZUw5YU9HVWtKSUlMN21TbWEyN2p6TC9oaVVmMk1Ic1BVdWJPWndZ?=
 =?utf-8?B?Ly9ONDdVdG10ZndLUkYzQSsyUVlZNXd3SmcwcGI4MExmMGFTQUhGRXVRYjk3?=
 =?utf-8?B?TjBPUlZKZEswMGpEUHVzbHAvS21kSnpoSW1QWDR0WTlDZWJFeU5RZTgrZmR5?=
 =?utf-8?B?ZFdyVnNPZDRIS3A0T29mRVR3MDdLWTFtWFZrclNoanc5VnJDUm8rYjROUVEr?=
 =?utf-8?B?VnBQbFZKRkJvZHp2b0VkTFNlVmJXcThINUZxSDI3b3dXck41QXNzWERGanZK?=
 =?utf-8?B?M0cwRXZDWVBNRG5tN3liaWdDUG1JVWxCak9HSEttWWVENktzZDUwRWVITU9q?=
 =?utf-8?B?cUhGVnRqYmsyV3hjRThuU0hjYmpkZ1BNNkxXaC9aNm1ibWYyWGVYT0tWQ0tX?=
 =?utf-8?B?dlozSC9aa1VNTDdPRGdvd3VqcThqdGZDb2hvQllKbGZ1aU9yYm96RTMxZE1L?=
 =?utf-8?B?SVdhU1hraVNZRXY5ZVZMdGxJVWExWEhvOGhZTU4zM3dyTkczK3RCQ0huRVJ1?=
 =?utf-8?B?Z1hOUjdDcVlvNmZrMHNtcXV1T0JxQ1Z0NVZXS0g0UDZhQ1ZFbzQzUnJ4aStD?=
 =?utf-8?B?Y3IxNGlSM3Y0SFc2M2Q2SjlxY1p5aWZEZWtpeGFjV1dLZGVMbEIvSURyclA2?=
 =?utf-8?Q?UqZvwLTPHm4242KyhLPk7fDqB?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93efb96e-aaa8-410d-383c-08dc32f3b046
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2861.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 15:42:19.7262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWwwNJrdAronoVmdsp9SY0t8hGgIR0A5tk4xxH/SQLeL/w62EHL7kf+QgZlVa5wwiVLpKF3amPpx7+2kj5d3Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEVP281MB3712
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28206.000
X-TMASE-Result: 10--35.858700-4.000000
X-TMASE-MatchedRID: pS5owHKhBO2bPh0YdpLKJgw4DIWv1jSV2rA23rnjZq3mGnpkx4PF3f/G
	4u3mr5gn+1Az4DPPSQ7ulpUPFNVmlRw/umn41b2EeJchdZcr1K2n2i3kZizDsQamO6yeRcv4Xxu
	7E3LmFekKkSy+0sJ7WjflegrNxV84IB4QI+RMYET3vtfEQLhtk0Ip2pwQ814L5TQA00qx4JWjxj
	+USeWICI4Run7ir6ZRizvYf5Ge5kJ5BzMVCHZcS/gxOc6+WoXc3O2+pOfl+vcwLJ9PZUBQhZu1m
	GZ02rt+oo1aMRuRjHAH6GYarfxUhNietYYu6qmy1nMR7J09d083RfriMbLZ1j7Qn1lMCQHYs8JJ
	q4jocuLDcEA+w7rkfgbQjJTpuY6ourtb7tuq+cBocGPeyBudkP2OXvUImtUp5jqb/qjiEApz3h/
	NOzc2C5tPk4+sXOK3/DaN09Cl21zerKG6thXV+p0UyaWO1QCnvP2es7dSq66JJkzvS3iM4iIYB4
	gb/WaWiXgLtI9HUUTOviDBCiGrJhH4pydzeozMc6MQph12+/rVTpze4vlqBrVhq2KCoRs2NnbX4
	cMr0CI3zgqPM4M5Fz0K9KJyC2voZ4n57YIG4wAlQx76zly9o2KGUT4Ubc9ShE17EBM1S6J6F1n9
	vCrdVjptBmu6Eve7vtnFGScenZ1kLSwvYCgXaCQptwyVJHc8bw5Fan+Oqwqs+XNZ1TH4CYhIitX
	bPvbeFqFHzbNeeDW5rVzLsTlYy0c9f5KYEFBVlEJO70qtU7ZyfGzN/EfYKXvBA9C/1eiFIj4oYG
	/COlFFq3Di+PoXZtXNOAQ2MSi22anGH/Lzelzz2Ve/9BWrZSJUNkNrt5r93+6k97GsyDiUTGVAh
	B5EbQ==
X-TMASE-XGENCLOUD: 846236df-5223-4ed9-bf30-f08e70a28a1a-0-0-200-0
X-TM-Deliver-Signature: 3334A056FF6743983BBC3A7A11817831
X-TM-Addin-Auth: Po3YDObs48X940iJO+rvgtNqBbL0/PCh1PIXtSynCIDzO12PGhgr4SQszPv
	O+PWL4YgWTpprA7TZt4j/NyNe11kWIFOTxLYF/yiOXmH7O03ZBR5X4BHx5cgVeXp794ZDhfiqgL
	PsWzIURLe0z/Yya9tVP16lsXjQNbF9+pF2EyBdDkQ2HV+E2Chd0b9xhNzr+xAz75tbNJkB3es//
	Ol51sxDFxh6dUynNs5x1FQEaTlKOkEmxCV4SysoQvpuIQDdRvoJuDy+7veQR37Hmy4MaDksvQ1B
	8RMuPrWlphlYlkw=.xtgkmV1cErDyiUF9oeHAukyZ+q/dJc1qMvunsMzkaksoDEmzgBSHaLhWeu
	r8P2bqBE5J+YnnyJo66NvTuylkYttbKakJQKnMTj17bQhN6W47dmdpfmJO4469o0IBPVc01B739
	FWHWhh7GhLV1lHMFog8yYjKk6fA/rgaDkQl1Mi2frJNH+Him+OMqUVwn9+2Lu9S7yFsDepLxgMJ
	rXlyZOSPaAztTXNy4u/QAjOwaT0SEcMCDdQop1UI6pDNYEPpbJCgJnfRjcZx969f9kOsv/3OeDw
	RVJq5EM+wO++bhvUOJjZfH4vwQUxetY3u3MSYCUXT05yUqoWM4K+J3K1xTg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1708530144;
	bh=oRF7D6xmMc7S6eTIXirB6AQkqY9CD9gx8MT6FYSo/Cw=; l=12951;
	h=Date:To:From;
	b=yoocxbxcAKQKcZjM1xz0GveZdftOQjwOTa8HA0/y6qyCRSFkJxA5yPaz6aaVAKB/p
	 BPMSw2R/wLZNBHALCMCwRzZN7kufPJrSo4gJBXLkCWVGy/ZTxBuW+KQwU3e98ZvmZ+
	 I8n8Z2wq9V1iy2CkzsESuinOfrw4ZyXsmCL/SIvCyS0G9RwLcwiHpbL1nk/81DICkZ
	 0Z7cHuQUbJvkUh1H8s3Tkf+nsODXFWjh/EK7SCoPC/Gr49T3AbDbVVQxSUNwlySZPw
	 GeEe8rcwk6G6vUbOag//siI1NUH+pItM4JI/bnUfZWstxAJao/PICDIteSePbMPYmJ
	 D11sgPQEiCRnQ==

Hi Matias,

On 2/20/24 13:19, Matias Ezequiel Vara Larsen wrote:
> Hello Mikail,
> 
> On Mon, Jan 08, 2024 at 06:18:50PM +0100, Mikhail Golubev-Ciuchea wrote:
>> Hi all!
>>
>> I kindly request a vote.
>>
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/186
>>
>>
>> Best wishes,
>> Mikhail Golubev-Ciuchea
>>
>>
>>
>> On 6/9/23 16:22, Mikhail Golubev-Ciuchea wrote:
>>> From: Harald Mommer <harald.mommer@opensynergy.com>
>>>
>>> virtio-can is a virtual CAN device. It provides a way to give access to
>>> a CAN controller from a driver guest. The device is aimed to be used by
>>> driver guests running a HLOS as well as by driver guests running a
>>> typical RTOS as used in controller environments.
>>>
>>> Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
>>> Signed-off-by: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
>>> ---
>>>
>>> RFC v3:
>>> * Add length fields in CAN RX and TX messages.
>>> * Replace bus off indication queue with a config space bit.
>>> * Clarify handling of unknown flag bits set in CAN frame.
>>> * Remove MISRA C suffixes in constants.
>>> * Reserve 16 bits in RX/TX messages for CAN XL priority.
>>> * Reserve 8 bits in RX/TX messages for CAN classic DLC.
>>> * Rework according to general virtio spec POV.
>>> * Implementation:
>>>     driver: https://lore.kernel.org/all/20230607145613.133203-1-Mikhail.Golubev-Ciuchea@opensynergy.com/
>>>     QEmu device: https://github.com/OpenSynergy/qemu/tree/virtio-can-spec-rfc-v3
>>>
>>> RFC v2:
>>> * Add CAN classic feature flag.
>>> * Add feature flag VIRTIO_CAN_F_LATE_TX_ACK.
>>> * Add feature flag VIRTIO_CAN_F_RTR_FRAMES.
>>> * Reserve 32 bits in RX/TX messages.
>>> * Remove priorities of messages.
>>>
>>>    conformance.tex                         |  12 +-
>>>    content.tex                             |   1 +
>>>    device-types/can/description.tex        | 249 ++++++++++++++++++++++++
>>>    device-types/can/device-conformance.tex |   8 +
>>>    device-types/can/driver-conformance.tex |   7 +
>>>    introduction.tex                        |   2 +
>>>    6 files changed, 275 insertions(+), 4 deletions(-)
>>>    create mode 100644 device-types/can/description.tex
>>>    create mode 100644 device-types/can/device-conformance.tex
>>>    create mode 100644 device-types/can/driver-conformance.tex
>>>
>>> diff --git a/conformance.tex b/conformance.tex
>>> index 01ccd69..a07ef02 100644
>>> --- a/conformance.tex
>>> +++ b/conformance.tex
>>> @@ -32,8 +32,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>>    \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
>>>    \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance},
>>>    \ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
>>> -\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance} or
>>> -\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
>>> +\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance},
>>> +\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance} or
>>> +\ref{sec:Conformance / Driver Conformance / CAN Driver Conformance}.
>>>        \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
>>>      \end{itemize}
>>> @@ -59,8 +60,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>>    \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
>>>    \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance},
>>>    \ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
>>> -\ref{sec:Conformance / Device Conformance / GPIO Device Conformance} or
>>> -\ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
>>> +\ref{sec:Conformance / Device Conformance / GPIO Device Conformance},
>>> +\ref{sec:Conformance / Device Conformance / PMEM Device Conformance} or
>>> +\ref{sec:Conformance / Device Conformance / CAN Device Conformance}.
>>>        \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
>>>      \end{itemize}
>>> @@ -152,6 +154,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>>    \input{device-types/scmi/driver-conformance.tex}
>>>    \input{device-types/gpio/driver-conformance.tex}
>>>    \input{device-types/pmem/driver-conformance.tex}
>>> +\input{device-types/can/driver-conformance.tex}
>>>    \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
>>> @@ -238,6 +241,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>>    \input{device-types/scmi/device-conformance.tex}
>>>    \input{device-types/gpio/device-conformance.tex}
>>>    \input{device-types/pmem/device-conformance.tex}
>>> +\input{device-types/can/device-conformance.tex}
>>>    \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
>>>    A conformant implementation MUST be either transitional or
>>> diff --git a/content.tex b/content.tex
>>> index d2ab9eb..8806b57 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -765,6 +765,7 @@ \chapter{Device Types}\label{sec:Device Types}
>>>    \input{device-types/scmi/description.tex}
>>>    \input{device-types/gpio/description.tex}
>>>    \input{device-types/pmem/description.tex}
>>> +\input{device-types/can/description.tex}
>>>    \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>> diff --git a/device-types/can/description.tex b/device-types/can/description.tex
>>> new file mode 100644
>>> index 0000000..2511d9c
>>> --- /dev/null
>>> +++ b/device-types/can/description.tex
>>> @@ -0,0 +1,249 @@
>>> +\section{CAN Device}\label{sec:Device Types / CAN Device}
>>> +
>>> +virtio-can is a virtio based CAN (Controller Area Network) controller.
>>> +It is used to give a virtual machine access to a CAN bus. The CAN bus
>>> +might either be a physical CAN bus or a virtual CAN bus between virtual
>>> +machines or a combination of both.
>>> +
>>> +\subsection{Device ID}\label{sec:Device Types / CAN Device / Device ID}
>>> +
>>> +36
>>> +
>>> +\subsection{Virtqueues}\label{sec:Device Types / CAN Device / Virtqueues}
>>> +
>>> +\begin{description}
>>> +\item[0] Txq
>>> +\item[1] Rxq
>>> +\item[2] Controlq
>>> +\end{description}
>>> +
>>> +The \field{Txq} is used to send CAN packets to the CAN bus.
>>> +
>>> +The \field{Rxq} is used to receive CAN packets from the CAN bus.
>>> +
>>> +The \field{Controlq} is used to control the state of the CAN controller.
>>> +
>>> +\subsection{Feature bits}{Device Types / CAN Device / Feature bits}
>>> +
>>> +Actual CAN controllers support Extended CAN IDs with 29 bits (CAN~2.0B)
>>> +as well as Standard CAN IDs with 11 bits (CAN~2.0A). The support of
>>> +CAN~2.0B Extended CAN IDs is considered as mandatory for this
>>> +specification.
>>> +
>>> +\begin{description}
>>> +
>>> +\item[VIRTIO_CAN_F_CAN_CLASSIC (0)]
>>> +
>>> +The device supports classic CAN frames with a maximum payload size of 8
>>> +bytes.
>>> +
>>> +\item[VIRTIO_CAN_F_CAN_FD (1)]
>>> +
>>> +The device supports CAN FD frames with a maximum payload size of 64
>>> +bytes.
>>> +
>>> +\item[VIRTIO_CAN_F_RTR_FRAMES (2)]
>>> +
>>> +The device supports RTR (remote transmission request) frames. RTR frames
>>> +are only supported with classic CAN.
>>> +
>>> +\item[VIRTIO_CAN_F_LATE_TX_ACK (3)]
>>> +
>>> +The virtio CAN device marks transmission requests from the \field{Txq}
>>> +as used after the CAN message has been transmitted on the CAN bus. If
>>> +this feature bit has not been negotiated, the device is allowed to mark
>>> +transmission requests already as used when the CAN message has been
>>> +scheduled for transmission but might not yet have been transmitted on
>>> +the CAN bus.
>>> +
>>> +\end{description}
>>> +
>>> +\subsubsection{Feature bit requirements}\label{sec:Device Types / CAN Device / Feature bits / Feature bit requirements}
>>> +
>>> +Some CAN feature bits require other CAN feature bits:
>>> +\begin{description}
>>> +\item[VIRTIO_CAN_F_RTR_FRAMES] Requires VIRTIO_CAN_F_CAN_CLASSIC.
>>> +\end{description}
>>> +
>>> +It is required that at least one of VIRTIO_CAN_F_CAN_CLASSIC and
>>> +VIRTIO_CAN_F_CAN_FD is negotiated.
>>> +
>>> +\subsection{Device configuration layout}\label{sec:Device Types / CAN Device / Device configuration layout}
>>> +
>>> +Device configuration fields are listed below, they are read-only for a
>>> +driver. The \field{status} always exists. A single read-only bit (for
>>> +the driver) is currently defined for \field{status}:
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_can_config {
>>> +#define VIRTIO_CAN_S_CTRL_BUSOFF (1 << 0)
>>> +        le16 status;
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +The bit VIRTIO_CAN_S_CTRL_BUSOFF in \field{status} is used to indicate
>>> +the unsolicited CAN controller state change from started to stopped due
>>> +to a detected bus off condition.
>>> +
>>> +\drivernormative{\subsubsection}{Device Initialization}{Device Types / CAN Device / Device Operation / Initialization}
>>> +
>>> +The driver MUST populate the \field{Rxq} with empty device-writeable
>>> +buffers of at least the size of struct virtio_can_rx, see section
>>> +\ref{struct virtio_can_rx}.
>>> +
>>> +\subsection{Device Operation}\label{sec:Device Types / CAN Device / Device Operation}
>>> +
>>> +A device operation has an outcome which is described by one of the
>>> +following values:
>>> +
>>> +\begin{lstlisting}
>>> +#define VIRTIO_CAN_RESULT_OK     0
>>> +#define VIRTIO_CAN_RESULT_NOT_OK 1
>>> +\end{lstlisting}
>>> +
>>> +Other values are to be treated like VIRTIO_CAN_RESULT_NOT_OK.
>>> +
>>> +\subsubsection{Controller Mode}\label{sec:Device Types / CAN Device / Device Operation / Controller Mode}
>>> +
>>> +The general format of a request in the \field{Controlq} is
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_can_control_out {
>>> +#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201
>>> +#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202
>>> +        le16 msg_type;
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +To participate in bus communication the CAN controller is started by
>>> +sending a VIRTIO_CAN_SET_CTRL_MODE_START control message, to stop
>>> +participating in bus communication it is stopped by sending a
>>> +VIRTIO_CAN_SET_CTRL_MODE_STOP control message. Both requests are
>>> +confirmed by the result of the operation.
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_can_control_in {
>>> +        u8 result;
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +If the transition succeeded the \field{result} is VIRTIO_CAN_RESULT_OK
>>> +otherwise it is VIRTIO_CAN_RESULT_NOT_OK. If a status update is
>>> +necessary, the device updates the configuration \field{status} before
>>> +marking the request used. As the configuration \field{status} change is
>>> +caused by a request from the driver the device is allowed to omit the
> 
> Is this to indicate that when a driver requests a change, the device can
> omit notifying of the change? As I understand the specification, the
> device can omit the notification, but the change must still occur? Is it
> possible for the device to omit the change as well? What else could have
> triggered the status change if it wasn't the driver?
> 
> Thanks.
> 

The change request notification OK/NOT_OK for every mode transition 
request is there in any case. In some cases the device would 
additionally notify the driver about the controller status via 
'virtio_can_config' in config space (config space change notification 
mechanism), e.g. in case of a BusOff event on the device side. Although, 
it is possible to omit the config space notification e.g. when 
transitioning to stopped mode.

In the previous draft version of the spec a separate asynchronous queue 
was used to send BusOff events and the proposal had an issue with races: 
it was not possible to distinguish whether a received BusOff event was 
meant to be from an old session or is already from the new session. 
Hence, the indication queue was removed and a config space status was 
added instead.


Best regard,
Mikhail

-- 
Mikhail Golubev-Ciuchea

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin
Telefon: +49 (30) 60985400
EMail: 
mikhail.golubev-ciuchea@opensynergy.com<mailto:mikhail.golubev-ciuchea@opensynergy.com>

www.opensynergy.com

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616B
Geschäftsführer/Managing Director: Regis Adjamah

