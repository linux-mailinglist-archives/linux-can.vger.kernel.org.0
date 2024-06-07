Return-Path: <linux-can+bounces-713-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C81590058D
	for <lists+linux-can@lfdr.de>; Fri,  7 Jun 2024 15:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355161C20B6C
	for <lists+linux-can@lfdr.de>; Fri,  7 Jun 2024 13:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5F1194AD3;
	Fri,  7 Jun 2024 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="eHcWZa0D"
X-Original-To: linux-can@vger.kernel.org
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1978D195985
	for <linux-can@vger.kernel.org>; Fri,  7 Jun 2024 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768188; cv=fail; b=OcjEIl7KgffqXxFJqj4yQ4IiGMz/c66idZjfLbYZ22C+mt6itePg/UZ5A5IavHmc+8fND60dnEkMIk84ya1WK+6MCh9HY8CeBzP/9OUmg3wyCKTKHs8lKXZUjKbQN90hY253YEiMctngL+knyuo0Y5e6JRa15hFCuRuwU32X/q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768188; c=relaxed/simple;
	bh=vSVp8qYullQGb2YOwqYQ8gji+qVpmu/s4eV7OVBQneM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JRJIqMALF6hcAMBU356GIbJ8IQ/ZOzyXDIrqF04DXilV9Z1X//Pkg51DYnKtraiPktxCZjaCegcM92R6hLK6oPT39p9d8H9n4r2srZqBVBZRHKXXmnAllbZCZbIkebbK+Q2jmKNAYJU0EFNI0T3z6ce7TRehj3Mam7hPtAYpcVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=eHcWZa0D; arc=fail smtp.client-ip=18.185.115.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.172_.trendmicro.com (unknown [172.21.191.80])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 66A9F1000094E;
	Fri,  7 Jun 2024 13:49:44 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1717768182.400000
X-TM-MAIL-UUID: d0480192-645a-4d90-93c2-2f5b281208e5
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.172])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 61C95100003DA;
	Fri,  7 Jun 2024 13:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uvnb8O80Zs2RCTO5DIAzTGNBqiuaGA10CsbkS7d3DpuQVtJYitp9Uz9VIoDhckNRXDQe5NHnwiB+8devQemc1HXOIn1ECbOy+nd8Jgcd43tur/+6eqhKVQZddTSf9XgjXkZBu1r6d4SaUFRI51fkjlK2sQu13k4MV0QIcG3PXxDfDOtKba+q+1gbBTahv73n6zQhGVwRUdPFQYvfvZVTKrmdNs9dOoj35/f98Bv7rr4Sv29hm4lyt6JCQejn9mgfPb+It+yr559o9+CPR4Dz/wyNlw9FyPGg7EffqvDSXGZm79siRDvuh5PZp0+dOZg5cQvV72aSC5c1By4UIYWprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ch7v01T6b41KuivVkP92tGUhrS66jzc9kZldqqttiZ0=;
 b=V948hXnFcXUBavt3698IsVR4s0r49WSeNuzVhqxo7paoJXj13cs8h2mxwP+PtgInreKoyi1bL8/8DR/jYbWe+aXYzYf+yvkY0cpye4jei9ENou5U4JcnSB/2QTj3zHV7f93qa5HfSDA902th38XJyPRDZUQT8wV4Dy2FGFYFJizPgF+a2aZVeMUsif7U6E4LwvW2hyXPx0tG5wF0tM1LGJzxiX+0xpoUxO9Dpchjn9AXKIDkHsNU4IpQcq4X5ckDoEvfT5cEsgnSppyXpDJ4/NLPlXQF5CXcfaz61+U6ht1o0DVgF8n9rwv3j2oOMtS8jLnuDveANtlS+86TUrRtFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <5f9dbedc-eeca-4be4-af6b-7d8bf739f89a@opensynergy.com>
Date: Fri, 7 Jun 2024 15:49:38 +0200
From: Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [PATCH 1/1] virtio-can: Add link to CAN specification from ISO.
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: virtio-dev@lists.linux.dev, linux-can@vger.kernel.org,
 Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
References: <20240606141222.11237-1-Harald.Mommer@opensynergy.com>
 <CAMZ6RqK+doMKZfsbchHsfo9xYdEoKGyQk035PHbiW0quWFM+sg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAMZ6RqK+doMKZfsbchHsfo9xYdEoKGyQk035PHbiW0quWFM+sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::22) To BEZP281MB2376.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:44::7)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2376:EE_|FR4P281MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 21914c4c-d322-4e07-273e-08dc86f8ad5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmlnOGdKc1hZMytjMmdYOVg4d1FrdE1qMC9acEVraUxrMk9qTm4xSFZZdUMv?=
 =?utf-8?B?djVrclN1Vk00MDFLTkZuSEl3M2FPeHVKa0sxVmUxdlZpaU9VSEdINzJNR2hV?=
 =?utf-8?B?YjFkem1Xb3Zhd2xzYUVteENpdnI3Z0xSU1pYMHg0bko4ODdhbVdUS05rR0M1?=
 =?utf-8?B?WlV0RkNEWmswVHQ5NUE4MWhrdG93OHlXVkZXeWh6QitOUkpvSWc5Y2IrdGZj?=
 =?utf-8?B?N1NiYWoxU2JrdE9xb0xPdm50eThmVGFtenpHd0NRb3IwaVRKa0s0UDBFd2o0?=
 =?utf-8?B?c0gwSFBCZnFNYTAza0JqUlhycGFCRU1Zd3cwWnNrd25DS1A5YXluWDU3T0h1?=
 =?utf-8?B?Y1dPcGw2N0NrMUJqNGk1SzlGb0N4bXBYMWdkMG1UUW53THR0TXhralR1NFVJ?=
 =?utf-8?B?QjB2dE00N0U1dmhZd2Z5MjhLdkJvUWZGOVgwVzcyZFBvNXk3eHliVUJFbjNp?=
 =?utf-8?B?ak9pVXpGTUd3SEQ1VHhrWkErZ3VoRjRTNnhqNk9lRmROSjhaUkVVTDBtbkRm?=
 =?utf-8?B?RXFleHRJQ3g3b0xRKy8ycVBBWlV1VXJtSTc5aE5kU3JPd3lUU2paNDQrNU5x?=
 =?utf-8?B?Y1ZvcGRzdmhjR011NGhxS05QcFFzVDdLQmJlVTdkdWVzU2hIamVkbW9HUjRI?=
 =?utf-8?B?L3BCaFNFWFQ2cU1DQ1ZERFRZOG5GdHU0akNsWVNrSVRIdS9vajdqb1pibnRu?=
 =?utf-8?B?ZHY2aG5wRzRRU3RXOXpVZ0dEUlRmS0tkWWNBajc5OGVpT0FuV0Zibk13VFdI?=
 =?utf-8?B?RXpQak1BSG4zMXdVeVJCSFQ3WGlwUEwyVmM5WUJsaHJEem9qQ2xZMHhaSzF2?=
 =?utf-8?B?S0FMdVM4VVBDM1RpbDdwNDUySmowL0ZVNldNSTFWWjVGVDFTNjF0QVBMNnU3?=
 =?utf-8?B?ZTlSZFpaS2RPbGpVVkpVVGtkcDFpQTFwNkpPWXpFNlpYMHR4SnhQbzJXK3dN?=
 =?utf-8?B?WGVyY1BZNkdab1dXWTluL0p3TlJ3THNsVnFZZFZPUkY2VVovMXNkU2RSdld1?=
 =?utf-8?B?NHJ6T0tIdkYzWXdkZEVNb1drK0Y2aE9HYldkWWUvOGJzZWFES2M4VGJjUlRQ?=
 =?utf-8?B?aWRwc2tVMDI1ems5TzRrK01yOEZmMDR3Z0lZc0Erby85YkJjL2hmV1YzV3Jj?=
 =?utf-8?B?M3FDcFkzQkd1SDVnQXk3NERFOWk4b0VGczMrOW56bGs3c1Y1OHdubjJjYUoz?=
 =?utf-8?B?RjJEQjNRdmM0T2dxUEVQekdCampqUXFjU1NuUTluK2RtU2plWTRkTnMrWUtp?=
 =?utf-8?B?N1FINFFraFVxdHgyZkE0WmwwSVFFeUZZZHZRNGJtUTJSL3dWSUhIa2pBelJs?=
 =?utf-8?B?Y2o1c2txbFQ5VkRyRTIvaXdPMWRkTWhidkY0K1VxN25IS0QyMW5USS9CUUV3?=
 =?utf-8?B?TXNsWXZ3TnZDcmRHSHN5WG1KZlhkYjBqNk1IejlOc0hFNmU1ckRFa3o5SVhX?=
 =?utf-8?B?Z3JkVDlWVDA3T2RGSFRQU1J5MjlmVjlHTk9LMDhha0RYRGlMK05VUVJEazNq?=
 =?utf-8?B?TkgyL1FNbkNheXlqOFFWVG8yT1Y3QmxEVjgvSGRQQ1hTdkZ5eFZtdTJYQm5S?=
 =?utf-8?B?TmEzWWthZFBrR3JzU3ZRYUxIZytyZ1N0Q200SzV2Mkc1d1JwVXdnL1BCYUJp?=
 =?utf-8?B?N0FNTDB2RGNBUmFRZnc2NElhOVN1NTZjcXlzL0tzZWlWQnA4S2hRNExLTTF2?=
 =?utf-8?Q?koJysFMOSGxhFNrActgL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2376.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WElOVmhrSHlkWmE3dCs5U2hINW0xSldKTHNHTHRLc3BvOGEyV21HRjZLQytM?=
 =?utf-8?B?czNKd0w2dVF0aWJzWDc5R2xZWEJSVFlZVEVZdUhiNmdtQUE1OFcxTkFIcmFC?=
 =?utf-8?B?OU1vclBQYzdybitpNzJNbGdpUVNCZjRTaWxMK3U0clBxQW5zZ3QvRi9IWStz?=
 =?utf-8?B?dEJoMTF3UWdIK283V2lOMk95bS91cWFpTmM5cDFHSHdtaVZ1ejBQNEcwSE9V?=
 =?utf-8?B?c0RBNy9RUERsNHFpWkFyY0M1eWdQU1JpOTNpT2c0VW4wbUNzN3NaQjNKdjZl?=
 =?utf-8?B?NjFxSVdSRnBUUC8waE03cUxyZFdyRDU5alBsSnc0YWdYK21aaFNMSmY0ZXRy?=
 =?utf-8?B?OTAxT2hqNHRhcGQzcE50UzV6MWZMbkNDMTN6dlU2L3R6R2pVTlhMaFRoSklF?=
 =?utf-8?B?VUQyclRPd2ppSjFxMzZ4M3RzKzNwOWQ1Umw1WGFnZUFMcXVsK01CMmZ5YThX?=
 =?utf-8?B?Ung5L1hUWDFBU0FTSWZKZ3hKRzFNZzMwb0NmR0p4MVRjYWVBOVJ6NGwxZE5V?=
 =?utf-8?B?RUgxZDFEOXdORWpvTXlhRktIVW9SaUtncXpsWlBuN2FMMUVUUHZETGlhamcy?=
 =?utf-8?B?R2lnM1hhRFM4OVhNTDdJb0dLc0sxSkpQeFFLaS90THcxYkV0d1had1BoNGRm?=
 =?utf-8?B?NVJjN1FnVzJWbUVYV3NkZjNaMVhuYkNpNjJ5Nnhvem9QS2lVQk9SSk9DWDZn?=
 =?utf-8?B?Yzlib284K25lanpCY1R0TnB4QnNGWTJHSW1LV0g5ZUNWaWw3TDFmbzNlU3VI?=
 =?utf-8?B?TmtIVWhoY3NBSEN0OTdXMmpKSWZ4aFdHbUdlWm5Ja1F3bWNScGhIdGtHekhV?=
 =?utf-8?B?WTlhZzk0bEJZdmtyMlAxbWhldWlqZEpaUmVrNkZDbUJLK0NRWEVRTTJUMkVa?=
 =?utf-8?B?Z0VRVm5iQlpVamtLd0Q3L1BTV2hLeGwxT282U0puWUZXUFJHNVBxdzZyZjJQ?=
 =?utf-8?B?akNSQ1YwRGxsK2l3V3hObTQ2MllMd3pucUQ0cGNvelhma2MweDRHSSt4ZzM3?=
 =?utf-8?B?QWgxc3VVR3JFN2JUTWNGVnVNR2xOajBmK2JXVFp4U01SaWorT0JyMGVoem9V?=
 =?utf-8?B?amRxTnZ3eHRyckhpN3ZHYVZvT2N1Q3NGaXBUbERPalFHQ2VZOG9IZ2toY1VH?=
 =?utf-8?B?dnBzVmt6dUJHeXlaeEh5c3ViVGExS3daOXJzTHNjdFRkVmNkVU9BQTdYeFV4?=
 =?utf-8?B?Ny9xZnhNSkJ4bXJlaVF2ZVZKWG11L3lFTDhIU0ZOM1JHNVB4K0dGNlM1d1hw?=
 =?utf-8?B?ZzlZUXF2czZSMGVkeVkxUzhvdGw5ZjBha0tqaGU1VlZ0QW02VWdkZ0drWGxI?=
 =?utf-8?B?bWVsVmZCZ25ndWJsSDRHb3NyT1prRVpzeFRRbXpEZmU4ZDU5amdpTnByKzls?=
 =?utf-8?B?aHFGczFUeFF2cm51T1YyMDZuZnB3TE1oaWxwOHdBQzVrSFU5SCtTY3dTSUp3?=
 =?utf-8?B?L2M1TTA0UTlSUFVFWHhBRVdFRWVhbUQweFZURm1nRUFNSURIOHg0Qkhuazdr?=
 =?utf-8?B?Y3FWcEM1S1g4Vkp5QlNQVjZTN3pFN0MxV1RvR05DV0FrZXlzdUNjMVNWV1ZM?=
 =?utf-8?B?Wng2NzBWeC9tUnRsVmdoZFA2cm55c1B4VWNqcjlSYllqR0ZlZmVtcmhDb1JU?=
 =?utf-8?B?Ty9POGNTZWpzRHlOWjhIL2RadE5hWW9HdzBla09lMk9Ea2pEamgzKzJPay8y?=
 =?utf-8?B?enR4RzdwSmlSSFBFU2YxVWxCbERYKzdWbUpOZEozSHpkc0s4c2tjRndQR3Ar?=
 =?utf-8?B?WGhiYis2a3NWUFR2V2dWYkZVc05lKzNkUXBjVjlvVWM0bWV0a0UyaHB4aGhp?=
 =?utf-8?B?VXhBYUhmbkZLdEFnNWNpeHBlNmM1RU9kRmpTWmxvRHBkUC9ndlloRjFFZ2Zt?=
 =?utf-8?B?aURCRHRBa3dMbnkwdzUzaDVFN2l4MWZoNHAvemVSTkdOQzBsQ0Z5ZXRBUGh2?=
 =?utf-8?B?cmk0UVpWRlV4MjZtRFdQa3Rjbmc2ZW8zNDZwMHF6RmNqT29UZHYySmNhNGRR?=
 =?utf-8?B?RS83MDdIM3F0S0JucC92TW1Tbjg4dWJyaVVxWTdjYUVsQzNhUHVVd0RSZElt?=
 =?utf-8?B?a0RIYWZ3TDF2dGlQK0Y1YXpkallpZVFNZitBQjNJdXc2QW9zMVFYTGVJQ0FP?=
 =?utf-8?Q?8W1Gst7EspC++tPiY+7RYZFQ8?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21914c4c-d322-4e07-273e-08dc86f8ad5d
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2376.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:49:39.9292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nx6Gn5af3mObsYO9xZSEsY/sNTdlfiVA0z89mr5DL/tERoRgPe86is5KqgdNswTdZCAWt/WmBXytX5x+YdJntw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4277
X-TM-AS-ERS: 104.47.7.172-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1023-28436.002
X-TMASE-Result: 10--15.934400-4.000000
X-TMASE-MatchedRID: fE0JoqABJp35ETspAEX/noruruLIWfnxlR7tN56aWVVjIOKZDN+g+0m6
	zKX/LJcmeTE7faBxLhFrmb7PbPV1E8eYpzz6yNBUUlO0zoIcpU6B1fO2o4QGcEq1Q9/mzMAw1cY
	lE24XiBtAOktL5Ql5bQHVraLPJzFiqMfOugFNRj3s+7E98/tcINn8igpgGhRWPzc7pN6yeGrXCy
	ZzWaG+2WvLGkaLOFWhvN9vLubl3ARMKH6aQq1sw9F3EvIpSLuizmG9pmg8ncLxirsoKk0k35Z1P
	5vNF635yM1YS/HDjCTONdEsuxth3pueQsRC79SjawJUqbmGPB3aPuPIIqmcJ/p4OuSy0UFxr54J
	Ix46I6SuVcUZFgzFcICcOIh/AbcpWWSz4drjSLhimmowi1sSA4j+QP7WhY0Zq4ktdD6vjnaiWLh
	miI4dPyDilljGyWFtDjSolFn3I1sBijm8sRgYS19bwJ7hK8hemKx0YRsEdSh6vC5ezvZMsKXqJg
	85z+iX
X-TMASE-XGENCLOUD: 32f825eb-df6b-4ba4-80ac-94e78348a917-0-0-200-0
X-TM-Deliver-Signature: 8C71A2D33038F2EF49647969E5DC408A
X-TM-Addin-Auth: hsKKn5AlpFP4n9+mfwIsfGVZC6tJ9wkpqpB6Eyg5MCRKF2nPESIxkhG2sNo
	wzqqTCW0FLDcOoW9wAVPxoh2n6EOaT/C63mmhZdQ+2jHnrb8QeVlJd9DU56RyiUdmhJ/JK8KG0Y
	P6lN8ZzkrF6sZjVihtt/3uhMbKqyv9aqpIyb1YFeZTqvW/McsB0oj2eb+b6lD5xOQl95tQEdmB/
	LTjvqb0Dgi7HOsibUEMUd9ev0SpaMdOlVBYJoZzKLS+bL46uqRbeGLr2gIFvKsvEVxzPmT3qZEL
	XIAS6FUjSZ3xsqI=.KIwQyZMEfLaKaVvG7YmYAuMZZZUCjLETv4xyKjVCRcudfax2ZnC8WIHzai
	Xi5jC0PMVi3d4sGITbp1bb7RfksIaDQvgBUZTAicN8qVvcGJgtWlztfjUYRAvZCRDCaGHAuy5Rn
	Ct+dBRpLvYKcLxsjo/yL+va+ikpTepw6mRuSQiVAclAq1aca2IFfadn4oIyy5H/i3ymg6t29VrP
	xZuuSkb8HtV8M7Q2WPZ0113FeiE26aqd/lRSi9FrR1gEMxiYht6um9zwDNtbzXc0eOfE21AEmY1
	zcIPjbkoOktp01lTazW8a/d64HtiMeKloyGybNL1pRhxOviAn0M46mZH5gA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1717768184;
	bh=vSVp8qYullQGb2YOwqYQ8gji+qVpmu/s4eV7OVBQneM=; l=3000;
	h=Date:From:To;
	b=eHcWZa0DyHq/BaWGES3mlkLeXzd2uGS+qZlBLZ3GeLmhshonFvRokPlUsXi1yyzjF
	 DJ+n9ktg/9k0SNVeZZ2OIWz5YyclfkQWO5BP/Da+lrOZAqrd5yXjMHy3tgApjtTuav
	 Y9NkdbraEBgxiPSWzYfXEQycRxxlXSOLIl/REkU5oV9VDe2f9Ee5xoGd33zhAK+MOk
	 xuYg2omuk/XgF4KcQFCHFnXe33lPLCU5xUKirsoHYs9yErXEVeuESVcumsiLj5UwTv
	 3Vu/kKiXc8NaNwiMqwlsZxuJeleENpMlz8Miory8my/dF68C/jKaIr4+fhuunumqEf
	 4ZumKQ4PK8SUA==

Got a justified complaint about causing too much noise, so took out 
linux-kernel@vger.kernel.org and netdev@vger.kernel.org to shorten the CC.

On 07.06.24 05:43, Vincent Mailhol wrote:
> On Thu. 6 Jun. 2024 at 23:26, Harald Mommer
> <Harald.Mommer@opensynergy.com>  wrote:
>> Add link to the CAN specification in the ISO shop.
>>
>>    ISO 11898-1:2015
>>    Road vehicles
>>    Controller area network (CAN)
>>    Part 1: Data link layer and physical signalling
>>
>> The specification is not freely obtainable there.
>> ---
>>   introduction.tex | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/introduction.tex b/introduction.tex
>> index 8bcef03..72573d6 100644
>> --- a/introduction.tex
>> +++ b/introduction.tex
> Excuse my ignorance, this is not a patch toward the Linux tree, right?
> Could you let me know which git tree this patch is targetting?
targeted to git repository: https://github.com/oasis-tcs/virtio-spec.git 
branch: virtio-1.4 (37c6a406678a).
>> @@ -142,7 +142,8 @@ \section{Normative References}\label{sec:Normative References}
>>       TRANSMISSION CONTROL PROTOCOL
>>          \newline\url{https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fwww.rfc%2deditor.org%2frfc%2frfc793%7d%5c%5c&umid=65841137-ddc9-4901-90a4-a0cb61c155d1&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-04306aba055e4efd56e85e2894cfd163fc39b45a
>>          \phantomsection\label{intro:CAN}\textbf{[CAN]} &
>> -    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling\\
>> +    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling
>> +       \newline\url{https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fwww.iso.org%2fstandard%2f63648.html%7d%5c%5c&umid=65841137-ddc9-4901-90a4-a0cb61c155d1&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-0151c683df516f2ca3c42192c0ecb6e43e334d9f
>>   \end{longtable}
> I just realised that ISO 11898-1:2024 was published last month:
> https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fwww.iso.org%2fstandard%2f86384.html&umid=65841137-ddc9-4901-90a4-a0cb61c155d1&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-3887c3b5f94c9c2790492dc7ef4af9e35b9cc020.
>
> Just for confirmation, are you keeping the reference to ISO
> 11898-1:2015 until CAN XL support gets added? If yes, OK as-is.

Saw also yesterday the update at ISO when checking the link and thought 
a moment about it. The now superseded specification 11898-1:2015 is the 
one which was used when the virtio CAN specification was developed. So 
this is the one to be referenced now.

> On my side, I now need to read the new ISO 11898-1:2024.

On my side, before reading the new ISO 11898-1:2024 it first has to be 
ordered and to be delivered.

>>   \section{Non-Normative References}
>> --
>> 2.34.1
>>
> >

