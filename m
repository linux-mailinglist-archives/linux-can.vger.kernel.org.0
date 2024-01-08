Return-Path: <linux-can+bounces-119-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6256F82762F
	for <lists+linux-can@lfdr.de>; Mon,  8 Jan 2024 18:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF33283256
	for <lists+linux-can@lfdr.de>; Mon,  8 Jan 2024 17:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B9154663;
	Mon,  8 Jan 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="cSdYwCKN"
X-Original-To: linux-can@vger.kernel.org
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812154661
	for <linux-can@vger.kernel.org>; Mon,  8 Jan 2024 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.9.90])
	by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 5FD4D10A430B9
	for <linux-can@vger.kernel.org>; Mon,  8 Jan 2024 17:19:04 +0000 (UTC)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.165.80])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id D8B291000133A;
	Mon,  8 Jan 2024 17:18:56 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1704734333.770000
X-TM-MAIL-UUID: 9dd5a6cd-d6f9-4918-9930-a76e586ce885
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id BC3721000030C;
	Mon,  8 Jan 2024 17:18:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghqvVznOF3QGGU8OPIFwNvT9H77VB9+4Ro0yqamBGY6F5FPTRFewxmC+7iwSZvsh9Y0GtSMUCKsRDhaIomsKsK+p6wAq2QvgWspn5siBXe2NdWw8aMUOx1drvpmK65Fws0Mlsk6+cybVzwis5GfaXzEoxfN0b6CAp+gw6hoPhDRcqySIS9LFCcNS8UA5ucyvOObY37yVs0LeWXgdcWJs/ytiLJoofUCOfFsdktHTL2V/8D3vZIhz2JhLF1elHOgkDud4LhQoCAnldI6Dgd3WubA7rLbAl2nZTZpryuTMMYMP339gBhnb8vbLvEiKVcioQeGzYJ2M5inLUcqsi3IpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98vkvlxywDsVVLt4vftRW+nvQsQHOwlhzzhSQJPDtcg=;
 b=dyKetupUjqxD59pKL6OSp1/o3LW+SzTxKE1aDNW9+dDppBQsgs58TkG4JQ4U3ZV2Gj2IZRRpZ0C9SocXve7CL/YLzmxzIRWr+re3xtdJvNt3EIuoVDf/uFBW9H1NLKsZxExTNS3R59M0o2+94j7HVph/m6DryuvvmhgFsd3Cq7WtPoZGgpRmPlIQLsCGoNI7nEvhEkaVerZHG2P4jchGdb9Z6L5hGcZhdihZCL2EiKXO23OVCpCTOaSgR+zL006XDqrxKGFdFCjEmqzKVYvfqFkeKZIioU5bXKgksLEDDeD9La8BzZ7OBExfdtvE7GAi8BCxL8oEFzu8IqPtF3WN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
Date: Mon, 8 Jan 2024 18:18:50 +0100
Subject: Re: [virtio-comment] [RFC PATCH v3] virtio-can: Device specification.
Content-Language: en-US
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 linux-can@vger.kernel.org
Cc: Harald Mommer <harald.mommer@opensynergy.com>
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
From: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>
In-Reply-To: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0335.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::28) To FR0P281MB2861.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:55::8)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR0P281MB2861:EE_|BE1P281MB1732:EE_
X-MS-Office365-Filtering-Correlation-Id: 8528d52a-808c-49d1-8d7b-08dc106de278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y57OW5WPXiDVNvE73Dc+141tplxnbN0F5EknpBpvHBeOiqIIsh5HhhZtv16YrwmPCil9/srWoVoH0AoAmKcQpXcdQLm7+x1hhVR2OyUY1HzRJq+BiWLp6+ajwP18SAEZTE9pmdsh1DxhLlnb+nh9n4Y4PucAid838e/bfrsITGBmhq0AiDg1fObF1RU4F0WHMFmc2OL6Ftz6XZDgNSFu4OaM0csIe7msCiEM3T16ad8UfkBVxoABT8kC9LpdcXd7kbZOPGSID6GlqIn2drXS1p6IfN2R0jxUlP6pHFvw18DvEBZPbeDlR1B8rZ0Y8R4EoZ/n2BxkZdB8/ZBxVCjOmloRG+ICU+YCDV7rou5DbPC1edgwuDhvctKYbDR7IiFwPP6qLdbChKHuwThn3MHVcBjvawffqbkJELncO7kFn6yYwDcPvjCLp11+Fj4pM8IFzWGI7wlT71911z1UR0x5dWUa6aoojiLf/cuN4Fu5eYTz+6STSwvSE8S65olrab8G0fS1wKrisAquz95xgU/te4GrqP+NJ/p6C1/hX+UeiGJmKKaYJyn7NZAt1MgMZ3Fhzn3CfRM8fV38HwuhZqJCTmXSNWU2jNXB/mu9L9BMrXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB2861.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39840400004)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(966005)(478600001)(66574015)(4326008)(5660300002)(30864003)(107886003)(83380400001)(8676002)(66556008)(8936002)(53546011)(66946007)(2616005)(66476007)(2906002)(38100700002)(36756003)(42186006)(316002)(15974865002)(41300700001)(86362001)(31696002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUYzZEt6Wm5hbnpiUjJhS0RlV3BQcVF3S2J1a3phTUR6OTJIL3VnUEpYYWxI?=
 =?utf-8?B?MnBST0xhOURkSTBJTkZQVkxXU1FURlo1STd0KzlDbC80cjZNdWM1Qnk5NzE2?=
 =?utf-8?B?RXJIMDVlR0JucWlHMjEybXpwbW54djhlZTd5dE9WY2ZMVE9lak9BYTdpKzJG?=
 =?utf-8?B?R0VqanNkZFp6VFovYzVnNnpnWVVTMkFaMDZ0VnNTcUZuUnlVVUxGR2VRems4?=
 =?utf-8?B?UFEvamZVbUErTzM2Y2Y1anBhL1BKaFkwenZNNVdpYTh2U3hpNG5oMGduV0NK?=
 =?utf-8?B?L3FRbkhsS1R2VzFFR2dIMnFVOGFVeGhzTzYyTzBtb1VoNGo3V0NNWjN5QUgv?=
 =?utf-8?B?dkp3UXM2QkRsVnlIdHJ4aThrdDBFUERjT3hZeml1V29COXNOSk5HSEd1Q3Rw?=
 =?utf-8?B?OEtkcXRwc2phS25uV3d1TkNrcjB3VTFsanRleVl0Um5uUXhaOE05VGkvb1pp?=
 =?utf-8?B?T0ZJM1hQUSs0Y0NMRUw2VHozRkF5RE1mYmFoa1ZwYXUxR2lqekxZYTMrVjJM?=
 =?utf-8?B?OHpBVWN5U2lYQncwTW8yV01nQ3ZmRWdwcHdtM0JBRXU1cCtuZGRsTDRvOTdK?=
 =?utf-8?B?Tmk2azZLK3dzdVNKOWVob0dVNGVlbGUvaFVlTkpjSHVoOVVFMmlsc3hzbTM3?=
 =?utf-8?B?RHFoWEs4Tmw2UHpVaEppOExZVStsWmV6MmRxOXZSUkRSUmY4NEJ0VWNTSEpa?=
 =?utf-8?B?b1drSmVlSWg5NnRlcy9BZDdORHg0Sm5TeUlUSTFKQ0V6TElwRXozRERkTkpv?=
 =?utf-8?B?UnFXWm1jTE12L3R6UlkxbzM1UzdtUjNNTFM0Sk1yMkZjeDM3cjFiaU0wanJq?=
 =?utf-8?B?RFRla2FrTUxDMS95SW9wNmRkM1EzMkU4VzhVK1I4UEozOTUyQy83bDBQM0Fz?=
 =?utf-8?B?UkdacDEySW0zM2JsdSs0VFlZN2kxM3p5TG51ekdBWURqZG81UHlNTnlLZ3NZ?=
 =?utf-8?B?Q280MWsvQjJJVUdmMWoxN3U4NVp1ci9tZEVRSWNsTS9jeDdTdTVCbXBHZ281?=
 =?utf-8?B?WVI0QU1kQmV6NjVwWVlYOVhwcXloK2Znb3VOUUtJZ0VKUXpzaU5ueC9uMHFQ?=
 =?utf-8?B?aGprWU5NLzlnLy9Ta09nQjdlMkhZRmNBL1dYMG8ybjJLbmR5Rk80S004L2lq?=
 =?utf-8?B?M0YvaUROS1pTRFVxeG5jRHpBVmxKdmlCQzUrVmZrSVpXeUxQQ3NPOWxtMDM4?=
 =?utf-8?B?d1p6eG9PdFlLVCtwTFdzbG56S2NXUEJXaVhmeTZzREpaUFVlRGxlZkNHRWt6?=
 =?utf-8?B?cGlHWmp5R3VadXR2S2plMjgwVi9DRytQK05oMFdubGd2VjRUZEVWVDhjQWg2?=
 =?utf-8?B?SndyYmUyWmhoRmF2UG01b2hCOUJCTDFCVlZwQWs3L1hGSUNwbmJmS1MrL0k1?=
 =?utf-8?B?cjFzQVFPNUdNeDZKRERNK004V3MwQlhBVFhra0V6THlTNGIxVWJpbE1iNGIr?=
 =?utf-8?B?MzRnc1o3OEdWcnVqR3FhMG0zT3JRUGRhK0NKRkNwSjlyUU1vTUZ0cFhwbnhp?=
 =?utf-8?B?VUR3RGZqRjA5WnVmZFpHNUlFbXFHQS9BclUzNnFQaUZoUDIvek5xNS9QVjd3?=
 =?utf-8?B?TG1VUGZHOXBBZThLU3NIRTQrZ3ZSOEVHK3dWQnFBNTc0LzhrL0NyVUxxeWU3?=
 =?utf-8?B?cjBGY1haSHhiSThpbkZTSFZ6NGpBR3RxMmVRTk5QemVudjFLdHl4SnQ1Rm85?=
 =?utf-8?B?alNOeHFqN3hFekRMdXlzZXk5amxpOGlhazBnZXROZGJMeUZneE9Sb1hWS1ho?=
 =?utf-8?B?TnZSSk5LVjEwZEc1RGdpUlkzbHVueC9NK2VKYzRlR1YyMk5RbGtSNWZmd3M1?=
 =?utf-8?B?dUNkb0ZSZm1IcWdnWHFTQTRZWHNrR3JhVTNxVnRnV01lOVdWSVZCWnpTMnQv?=
 =?utf-8?B?a1RMNUx0K2VxU1VoWU43UVh2cUZ0S0JETFVjYVRiK2dJcE4rU2UyRTgzQ0Ri?=
 =?utf-8?B?TjE3dHZGSy8zc2llUHNWN2ZDUkJYdlQ2TldHMGxtcGRad3lNdWJKYm4rQmFk?=
 =?utf-8?B?SGRkSmIzUUV3THM5UWNLL09kOHdkVU0rNzk0T3YrUlNKSnBNcVUzUTl1eC9S?=
 =?utf-8?B?QkcyNGx3SUtQME9kWkNoaitTREg4azVZOHJGaUpwdXl2MENiSVhqRU1hUVox?=
 =?utf-8?B?MktWRm13eVc3STJaeGFHcUFKZzF2ODZRVjZsMWxTSUx2aU50QmVEemY3c2JY?=
 =?utf-8?Q?zE9cem54OMJnTjpO85ng2gtKkdNNG4K9z10OFI44oLFI?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8528d52a-808c-49d1-8d7b-08dc106de278
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2861.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 17:18:51.7976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NayiXsYdYYF21T3NERcack7XFhE6/nn8MGXv1iz081tzIuaYnEPs7d9XhxOVJ20JZsJnitziPs0G8OSZymWosg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1732
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28108.001
X-TMASE-Result: 10--26.839400-4.000000
X-TMASE-MatchedRID: IeZYkn8zfFqbPh0YdpLKJrr2u0KWqQKN6BFG8XEpG3o+Jg7sQdznaNvg
	EYRNbHS3giGMT9+4wgGSZ3SaETHm4d+JF1WYq48KGG92L3YEEC7n0oaU6WM++2l97S/dBhHEMv6
	3KPkpsVsiV5oa5+FymYHXFo1IeW9XpsOuxfGO3nYI1pqhes/vCZ1VuQ+lOPH3KHGQohQFy180Ri
	Z6Ct8rIqA2jwJY4wY+0/a3h2+DhqxRskjaGDMQnpIdC0Q5JDAcyiAijCjuVj1rIVA3IGfCC6DED
	Qa+uiKUWL15ehCslD7JKRtEgA/ITuWnLg8XLS8s4EfJdkIZseqFCkPhi2xezZGeN+9dVIq356v0
	NFZuss3bhj0bVm2k8Bh/Al+iqFMV2we4/1fEGL8J9830SX03A8hBDBG/yA+OohylTf+BwIwBLhI
	Ycosb0cclpo1iCSKCjNAvN1oAuKagBHhfl29INyE8raaf46xMzmG9pmg8ncIAs5rNbNSK9e7+wT
	HUWclzV4o4c6W8jBfLPGh5Ujntipvtu+4NxuXQCqJ0RbJ3bb0nfL6KqKSjb9NP7irnuo/fj7ukk
	TJcZN/tyngZFy3ttip9kJiO/6Fe52IgFIdChvaxfhoVgAwhg8F5fDL4n8i+c4ZU0JVmUiR5hV2J
	q9Ki5C7ouhdAH53QSSbqDRkRAeP/sZ5f6dOaSbK65uJPro/PJnEmMUXsLByS/N5DRl1oA5cPFDp
	4CqCka8saRos4VaFUWoUJy6Nz14OJPzg4sctil70udqm5Uk/z5QXJv66dQ4PQuX9/sTNh73KIEc
	JGVn9ee4H5J0bLx5Kk87qFGa+bx10k8QqyoAyRw3fxXeYCNqODSWu0oxbKa1P8Ik1zBcVtzZazF
	rwD0yaSuBfcJyImkGUtrowrXLg=
X-TMASE-XGENCLOUD: 20941e10-a7d1-4899-9887-a3f12d500a82-0-0-200-0
X-TM-Deliver-Signature: 91B5E697C46C12F80E656C3FCEFE032D
X-TM-Addin-Auth: pUknQ5XUZhTfS85jfKYBr3tENF/AQWeXpcAywyKoCoZx3aUqjlY5yhcr1Kv
	juEd74ahm+vdOm9FMtO80eRu5JvjHDot6+gCdyoD8oCRJB5Pj6zhe0AX1WtQOonLNR4TkQHpJgW
	/KqfTO3vNud9ZHk1KmZI37MTE/iLVX3BOgARMOjj7lli9fF8lOtGj7yHC+XhDWykOplcaV9Z3fU
	jB/HSk9JacfrEZnCki3JXM0QTnoMkUazSzz2Lh4QzINU7yVKdrG1AHsd3G7u7B7mLSYoe99qOz/
	IU0jfu75cYu4R+k=.0NqtNIH8fXkvqSydEUyJkzFA85krkc6bQBg7wHO6/F8ns7jIHFT3/eh0CC
	R3BO3fVTCSQuoHe0URqjCovN8aHnSO17Oej6bNLXdHn5kZ8zIrMuo5x2tKJBgXWBZuKR7DibFgr
	Qzy7KHob6EseS17xDqNt1P3cut9aSNZhj0uXKgq7iC7hbPZ0yko7o6o7TUkKLf52n4n9CF/k1qi
	bcxRHcWjO/Ib0/Nkc+9Id2wBkLhJJwrTiAz/Er9eF1XwnJqQFlVcAQrB8/VRHtCECqa6f6sW3Hr
	j1i5uwMNmRFmwYED+hZ8tv+V4zUWVn2YrAF9y8OI8vdWtQ1P7acTFVvkL1Q==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1704734336;
	bh=ArgUqMaGkiCfRdhpkBP69S2AVqvhbEBoJk6ii9JEYu4=; l=18340;
	h=Date:To:From;
	b=cSdYwCKN6uOqgQBCx+ww8VikDuYiI9Bqf6P+vjmzDFGbn2FbqxeSqW4fw/vxkx+tr
	 Hy7Inr2QFNaGsUfnrrxyCRhsdfepzeOccV5mCYrPJ93c7F1eJy+ZBprcPvwKXXa0nN
	 P4w21zMhkxljoymtjUr7gl+kb3CuSliM008m1RchD6pthq6QIB9/jT1t5k3A/DZpaa
	 QrRYqIvzzGAWQ5iwoQDcO1vnUxKRiF6wyhLqUjiCx2KfAhBZLmVi57X44mCwBLbyNk
	 xl5TCSTywOJSx6/teTV7mu6bDrfcAVP9klX+pix8LdE81Mhz2xpGVQ/hHwrd2kJ2NV
	 CTeMQIt6srUCQ==

Hi all!

I kindly request a vote.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/186


Best wishes,
Mikhail Golubev-Ciuchea



On 6/9/23 16:22, Mikhail Golubev-Ciuchea wrote:
> From: Harald Mommer <harald.mommer@opensynergy.com>
> 
> virtio-can is a virtual CAN device. It provides a way to give access to
> a CAN controller from a driver guest. The device is aimed to be used by
> driver guests running a HLOS as well as by driver guests running a
> typical RTOS as used in controller environments.
> 
> Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
> Signed-off-by: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
> ---
> 
> RFC v3:
> * Add length fields in CAN RX and TX messages.
> * Replace bus off indication queue with a config space bit.
> * Clarify handling of unknown flag bits set in CAN frame.
> * Remove MISRA C suffixes in constants.
> * Reserve 16 bits in RX/TX messages for CAN XL priority.
> * Reserve 8 bits in RX/TX messages for CAN classic DLC.
> * Rework according to general virtio spec POV.
> * Implementation:
>    driver: https://lore.kernel.org/all/20230607145613.133203-1-Mikhail.Golubev-Ciuchea@opensynergy.com/
>    QEmu device: https://github.com/OpenSynergy/qemu/tree/virtio-can-spec-rfc-v3
> 
> RFC v2:
> * Add CAN classic feature flag.
> * Add feature flag VIRTIO_CAN_F_LATE_TX_ACK.
> * Add feature flag VIRTIO_CAN_F_RTR_FRAMES.
> * Reserve 32 bits in RX/TX messages.
> * Remove priorities of messages.
> 
>   conformance.tex                         |  12 +-
>   content.tex                             |   1 +
>   device-types/can/description.tex        | 249 ++++++++++++++++++++++++
>   device-types/can/device-conformance.tex |   8 +
>   device-types/can/driver-conformance.tex |   7 +
>   introduction.tex                        |   2 +
>   6 files changed, 275 insertions(+), 4 deletions(-)
>   create mode 100644 device-types/can/description.tex
>   create mode 100644 device-types/can/device-conformance.tex
>   create mode 100644 device-types/can/driver-conformance.tex
> 
> diff --git a/conformance.tex b/conformance.tex
> index 01ccd69..a07ef02 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -32,8 +32,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>   \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
>   \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance},
>   \ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
> -\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance} or
> -\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
> +\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance},
> +\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance} or
> +\ref{sec:Conformance / Driver Conformance / CAN Driver Conformance}.
>   
>       \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
>     \end{itemize}
> @@ -59,8 +60,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>   \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
>   \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance},
>   \ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
> -\ref{sec:Conformance / Device Conformance / GPIO Device Conformance} or
> -\ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
> +\ref{sec:Conformance / Device Conformance / GPIO Device Conformance},
> +\ref{sec:Conformance / Device Conformance / PMEM Device Conformance} or
> +\ref{sec:Conformance / Device Conformance / CAN Device Conformance}.
>   
>       \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
>     \end{itemize}
> @@ -152,6 +154,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>   \input{device-types/scmi/driver-conformance.tex}
>   \input{device-types/gpio/driver-conformance.tex}
>   \input{device-types/pmem/driver-conformance.tex}
> +\input{device-types/can/driver-conformance.tex}
>   
>   \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
>   
> @@ -238,6 +241,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>   \input{device-types/scmi/device-conformance.tex}
>   \input{device-types/gpio/device-conformance.tex}
>   \input{device-types/pmem/device-conformance.tex}
> +\input{device-types/can/device-conformance.tex}
>   
>   \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
>   A conformant implementation MUST be either transitional or
> diff --git a/content.tex b/content.tex
> index d2ab9eb..8806b57 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -765,6 +765,7 @@ \chapter{Device Types}\label{sec:Device Types}
>   \input{device-types/scmi/description.tex}
>   \input{device-types/gpio/description.tex}
>   \input{device-types/pmem/description.tex}
> +\input{device-types/can/description.tex}
>   
>   \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>   
> diff --git a/device-types/can/description.tex b/device-types/can/description.tex
> new file mode 100644
> index 0000000..2511d9c
> --- /dev/null
> +++ b/device-types/can/description.tex
> @@ -0,0 +1,249 @@
> +\section{CAN Device}\label{sec:Device Types / CAN Device}
> +
> +virtio-can is a virtio based CAN (Controller Area Network) controller.
> +It is used to give a virtual machine access to a CAN bus. The CAN bus
> +might either be a physical CAN bus or a virtual CAN bus between virtual
> +machines or a combination of both.
> +
> +\subsection{Device ID}\label{sec:Device Types / CAN Device / Device ID}
> +
> +36
> +
> +\subsection{Virtqueues}\label{sec:Device Types / CAN Device / Virtqueues}
> +
> +\begin{description}
> +\item[0] Txq
> +\item[1] Rxq
> +\item[2] Controlq
> +\end{description}
> +
> +The \field{Txq} is used to send CAN packets to the CAN bus.
> +
> +The \field{Rxq} is used to receive CAN packets from the CAN bus.
> +
> +The \field{Controlq} is used to control the state of the CAN controller.
> +
> +\subsection{Feature bits}{Device Types / CAN Device / Feature bits}
> +
> +Actual CAN controllers support Extended CAN IDs with 29 bits (CAN~2.0B)
> +as well as Standard CAN IDs with 11 bits (CAN~2.0A). The support of
> +CAN~2.0B Extended CAN IDs is considered as mandatory for this
> +specification.
> +
> +\begin{description}
> +
> +\item[VIRTIO_CAN_F_CAN_CLASSIC (0)]
> +
> +The device supports classic CAN frames with a maximum payload size of 8
> +bytes.
> +
> +\item[VIRTIO_CAN_F_CAN_FD (1)]
> +
> +The device supports CAN FD frames with a maximum payload size of 64
> +bytes.
> +
> +\item[VIRTIO_CAN_F_RTR_FRAMES (2)]
> +
> +The device supports RTR (remote transmission request) frames. RTR frames
> +are only supported with classic CAN.
> +
> +\item[VIRTIO_CAN_F_LATE_TX_ACK (3)]
> +
> +The virtio CAN device marks transmission requests from the \field{Txq}
> +as used after the CAN message has been transmitted on the CAN bus. If
> +this feature bit has not been negotiated, the device is allowed to mark
> +transmission requests already as used when the CAN message has been
> +scheduled for transmission but might not yet have been transmitted on
> +the CAN bus.
> +
> +\end{description}
> +
> +\subsubsection{Feature bit requirements}\label{sec:Device Types / CAN Device / Feature bits / Feature bit requirements}
> +
> +Some CAN feature bits require other CAN feature bits:
> +\begin{description}
> +\item[VIRTIO_CAN_F_RTR_FRAMES] Requires VIRTIO_CAN_F_CAN_CLASSIC.
> +\end{description}
> +
> +It is required that at least one of VIRTIO_CAN_F_CAN_CLASSIC and
> +VIRTIO_CAN_F_CAN_FD is negotiated.
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / CAN Device / Device configuration layout}
> +
> +Device configuration fields are listed below, they are read-only for a
> +driver. The \field{status} always exists. A single read-only bit (for
> +the driver) is currently defined for \field{status}:
> +
> +\begin{lstlisting}
> +struct virtio_can_config {
> +#define VIRTIO_CAN_S_CTRL_BUSOFF (1 << 0)
> +        le16 status;
> +};
> +\end{lstlisting}
> +
> +The bit VIRTIO_CAN_S_CTRL_BUSOFF in \field{status} is used to indicate
> +the unsolicited CAN controller state change from started to stopped due
> +to a detected bus off condition.
> +
> +\drivernormative{\subsubsection}{Device Initialization}{Device Types / CAN Device / Device Operation / Initialization}
> +
> +The driver MUST populate the \field{Rxq} with empty device-writeable
> +buffers of at least the size of struct virtio_can_rx, see section
> +\ref{struct virtio_can_rx}.
> +
> +\subsection{Device Operation}\label{sec:Device Types / CAN Device / Device Operation}
> +
> +A device operation has an outcome which is described by one of the
> +following values:
> +
> +\begin{lstlisting}
> +#define VIRTIO_CAN_RESULT_OK     0
> +#define VIRTIO_CAN_RESULT_NOT_OK 1
> +\end{lstlisting}
> +
> +Other values are to be treated like VIRTIO_CAN_RESULT_NOT_OK.
> +
> +\subsubsection{Controller Mode}\label{sec:Device Types / CAN Device / Device Operation / Controller Mode}
> +
> +The general format of a request in the \field{Controlq} is
> +
> +\begin{lstlisting}
> +struct virtio_can_control_out {
> +#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201
> +#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202
> +        le16 msg_type;
> +};
> +\end{lstlisting}
> +
> +To participate in bus communication the CAN controller is started by
> +sending a VIRTIO_CAN_SET_CTRL_MODE_START control message, to stop
> +participating in bus communication it is stopped by sending a
> +VIRTIO_CAN_SET_CTRL_MODE_STOP control message. Both requests are
> +confirmed by the result of the operation.
> +
> +\begin{lstlisting}
> +struct virtio_can_control_in {
> +        u8 result;
> +};
> +\end{lstlisting}
> +
> +If the transition succeeded the \field{result} is VIRTIO_CAN_RESULT_OK
> +otherwise it is VIRTIO_CAN_RESULT_NOT_OK. If a status update is
> +necessary, the device updates the configuration \field{status} before
> +marking the request used. As the configuration \field{status} change is
> +caused by a request from the driver the device is allowed to omit the
> +configuration change notification here. The device marks the request
> +used when the CAN controller has finalized the transition to the
> +requested controller mode.
> +
> +On transition to the STOPPED state the device cancels all CAN messages
> +already pending for transmission and marks them as used with
> +\field{result} VIRTIO_CAN_RESULT_NOT_OK. In the STOPPED state the
> +device marks messages received from the
> +\field{Txq} as used with \field{result} VIRTIO_CAN_RESULT_NOT_OK without
> +transmitting them to the CAN bus.
> +
> +Initially the CAN controller is in the STOPPED state.
> +
> +Control queue messages are processed in order.
> +
> +\devicenormative{\subsubsection}{CAN Message Transmission}{Device Types / CAN Device / Device Operation / CAN Message Transmission}
> +
> +The driver transmits messages by placing outgoing CAN messages in the
> +\field{Txq} virtqueue.
> +
> +\label{struct virtio_can_tx_out}
> +\begin{lstlisting}
> +struct virtio_can_tx_out {
> +#define VIRTIO_CAN_TX 0x0001
> +        le16 msg_type;
> +        le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> +        u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> +        u8 padding;
> +        le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> +#define VIRTIO_CAN_FLAGS_FD            0x4000
> +#define VIRTIO_CAN_FLAGS_EXTENDED      0x8000
> +#define VIRTIO_CAN_FLAGS_RTR           0x2000
> +        le32 flags;
> +        le32 can_id;
> +        u8 sdu[];
> +};
> +
> +struct virtio_can_tx_in {
> +        u8 result;
> +};
> +\end{lstlisting}
> +
> +The length of the \field{sdu} is determined by the \field{length}.
> +
> +The type of a CAN message identifier is determined by \field{flags}. The
> +3 most significant bits of \field{can_id} do not bear the information
> +about the type of the CAN message identifier and are 0.
> +
> +The device MUST reject any CAN frame type for which support has not been
> +negotiated with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST NOT
> +schedule the message for transmission. A CAN frame with an undefined bit
> +set in \field{flags} is treated like a CAN frame for which support has
> +not been negotiated.
> +
> +The device MUST reject any CAN frame for which \field{can_id} or
> +\field{sdu} length are out of range or the CAN controller is in an
> +invalid state with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST
> +NOT schedule the message for transmission.
> +
> +If the parameters are valid the message is scheduled for transmission.
> +
> +If feature VIRTIO_CAN_F_CAN_LATE_TX_ACK has been negotiated the
> +transmission request MUST be marked as used with \field{result} set to
> +VIRTIO_CAN_OK after the CAN controller acknowledged the successful
> +transmission on the CAN bus. If this feature bit has not been negotiated
> +the transmission request MAY already be marked as used with
> +\field{result} set to VIRTIO_CAN_OK when the transmission request has
> +been processed by the virtio CAN device and send down the protocol stack
> +being scheduled for transmission.
> +
> +\subsubsection{CAN Message Reception}\label{sec:Device Types / CAN Device / Device Operation / CAN Message Reception}
> +
> +Messages can be received by providing empty incoming buffers to the
> +virtqueue \field{Rxq}.
> +
> +\label{struct virtio_can_rx}
> +\begin{lstlisting}
> +struct virtio_can_rx {
> +#define VIRTIO_CAN_RX 0x0101
> +        le16 msg_type;
> +        le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> +        u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> +        u8 padding;
> +        le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> +        le32 flags;
> +        le32 can_id;
> +        u8 sdu[];
> +};
> +\end{lstlisting}
> +
> +If the feature VIRTIO_CAN_F_CAN_FD has been negotiated the maximal
> +possible \field{sdu} length is 64, if the feature has not been
> +negotiated the maximal possible \field{sdu} length is 8.
> +
> +The actual length of the \field{sdu} is determined by the \field{length}.
> +
> +The type of a CAN message identifier is determined by \field{flags} in
> +the same way as for transmitted CAN messages, see section \ref{struct
> +virtio_can_tx_out}. The 3 most significant bits of \field{can_id} do not
> +bear the information about the type of the CAN message identifier and
> +are 0. The flag bits are exactly the same as for the \field{flags} of
> +struct virtio_can_tx_out.
> +
> +\subsubsection{BusOff Indication}\label{sec:Device Types / CAN Device / Device Operation / BusOff Indication}
> +
> +There are certain error conditions so that the physical CAN controller
> +has to stop participating in CAN communication on the bus. If such an
> +error condition occurs the device informs the driver about the
> +unsolicited CAN controller state change by setting the
> +VIRTIO_CAN_S_CTRL_BUSOFF bit in the configuration \field{status} field.
> +
> +After bus-off detection the CAN controller is in STOPPED state. The CAN
> +controller does not participate in bus communication any more so all CAN
> +messages pending for transmission are put into the used queue with
> +\field{result} VIRTIO_CAN_RESULT_NOT_OK.
> diff --git a/device-types/can/device-conformance.tex b/device-types/can/device-conformance.tex
> new file mode 100644
> index 0000000..f944ffd
> --- /dev/null
> +++ b/device-types/can/device-conformance.tex
> @@ -0,0 +1,8 @@
> +\conformance{\subsection}{CAN Device Conformance}\label{sec:Conformance / Device Conformance / CAN Device Conformance}
> +
> +A CAN device MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / CAN Device / Feature bits}
> +\item \ref{devicenormative:Device Types / CAN Device / Device Operation / CAN Message Transmission}
> +\end{itemize}
> diff --git a/device-types/can/driver-conformance.tex b/device-types/can/driver-conformance.tex
> new file mode 100644
> index 0000000..32e3e87
> --- /dev/null
> +++ b/device-types/can/driver-conformance.tex
> @@ -0,0 +1,7 @@
> +\conformance{\subsection}{CAN Driver Conformance}\label{sec:Conformance / Driver Conformance / CAN Driver Conformance}
> +
> +A CAN driver MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{drivernormative:Device Types / CAN Device / Device Operation / Initialization}
> +\end{itemize}
> diff --git a/introduction.tex b/introduction.tex
> index b7155bf..d560c63 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -101,6 +101,8 @@ \section{Normative References}\label{sec:Normative References}
>   	\phantomsection\label{intro:SEC1}\textbf{[SEC1]} &
>       Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
>   	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
> +	\phantomsection\label{intro:CAN}\textbf{[CAN]} &
> +    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling\\
>   
>   \end{longtable}
>   

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

