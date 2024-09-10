Return-Path: <linux-can+bounces-1461-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F916973DF0
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 19:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C411C25360
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD3F1A2C38;
	Tue, 10 Sep 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teledyne.com header.i=@teledyne.com header.b="LlKVVRTa"
X-Original-To: linux-can@vger.kernel.org
Received: from us1mail02.teledyne.com (us1mail02.teledyne.com [140.165.202.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA9198842;
	Tue, 10 Sep 2024 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.165.202.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987601; cv=fail; b=NmCTa3mdPZFsaJGidaN07d59hk1XkU/YOZZSX2PcuZY+TJSeboanjOnUvdK4mi74kAq+X1weD8HVieMl5Wefevb7WFbBZoq5v/NGG8+C3upChjA44C8RcXKoN/YQlkfbCtPDX+ZaGmA3qVIKoXhMnZJC1+1HQLftFnL5PiykVxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987601; c=relaxed/simple;
	bh=3hJdrIW9bWfZZOdQEehOizaSTPla5V+mRtwNAA9+Uak=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nphDQ9JvaGL6uWuHQI2HUqGdvDbe1O+2HaOE4PCX5Ek87H1IErLgocJPcdcldwMB33oaNyTpb5+lFI4NgRr+nXW/ddnVFlBIzQ5PU1UclAZbffj4A6usEIO9/lUGEGK8HsDXHmXw45HHZXoLQ26hfhq2nBk7xn2SU+v6cyB6Prg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Teledyne.com; spf=pass smtp.mailfrom=teledyne.com; dkim=pass (2048-bit key) header.d=teledyne.com header.i=@teledyne.com header.b=LlKVVRTa; arc=fail smtp.client-ip=140.165.202.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Teledyne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=teledyne.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=teledyne.com; i=@teledyne.com; q=dns/txt; s=TDY-2;
  t=1725987600; x=1757523600;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=3hJdrIW9bWfZZOdQEehOizaSTPla5V+mRtwNAA9+Uak=;
  b=LlKVVRTa7bMkss2pIPQ1vEsWBrOsxlcifs+trwsuxXZ8AN7p1VWyVfHs
   l65DDdGsrGC4pRY50NUklmopmoTjudt8HVgqfobruSJxkyhVC0RJad0kL
   C4QwnTtKKUiSys9pMk5OhWOU7Z1LOaa7m9S39Zj8A5+G5bLqK6j1GABZ5
   S15H/m9IQb4OFG1wdxOQLaWLBS/UR2BZx/kKVJJBLYZcNG40TExrUIXXA
   72xHFl636MbSId7OJaaLtF6Re/lCl4sSFTu2mVfWBVVkuxla8WE7A+M9q
   RoVhBLEtAHrm34qf+aJ6GMI6u+QpVWNVI5FhlNPKSr8eZRFsyg4NC1MZR
   g==;
X-CSE-ConnectionGUID: mSr69cgsT8K/cT0JjAeUHA==
X-CSE-MsgGUID: odRie8Y0TVOk+galmB0QOA==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:RrVdq6M1xUNY9UjvrR2glsFynXyQoLVcMsEvi/4bfWQNrUpz1TwAn
 zMfW2zXOqyPamvwf9ogbovkph4AsMSGxoJlTgZtpSBmQkwWlceUXt7xwmXYZnvIcpWbFBoPA
 +Y2M4GacJhsFie0SjOFaOWJQaxUjPnQLlbEILeZfH03HEk8FXpJZStLw4YRmpRvjcWyHzSDs
 Nbzp9y3EFK+0laYCEpNg06+gEgHUMra6WpwUmMWNagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nVKtio2nhc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuodcrLZUj2CA6IoKvn3bEmp1T4E8K0YIw/91tXzBF+
 uckeBNKZSzbpeCfzY+bY7w57igjBJGD0II3h0o5iA/hKM0JBLXpc/2Qo8NUzXEsi8RDEefYa
 owSbj8HgBboOkEXfA5JVdRkwLru3SCXnz5w8Tp5oYIV6mveiix41bL8GMbYftGGVMNY2E2fo
 woq+kygU0hBbIbFlWbtHnSEgeP1nC6radouKpq7tfFjhFi5nlU0IUhDPbe8ibzj4qKkYPpbK
 koJ6m8lpK4a6kOmVJ/+Uge+rXrCuQQTM/JUEusn+ESOx7DS7gKxGGcJVHhCZcYguctwQiYlv
 mJlhPv0HmUqrqWQUn3Y872E9Wn0JSQEa3MPYSIIXA0IpdLkpenfky7yczqqK4bt5vWdJN066
 2niQPQW71nLsfM26g==
IronPort-HdrOrdr: A9a23:FjRXDaiIR0L8yfTT5rUV/tZBjHBQX1513DAbv31ZSRFFG/FwyP
 rAoB1L73PJYWgqNU3IwerwQ5VoMkmsj6KdhrNhd4tKPTOW81dAQ7sSircKrweBJ8S6zJ8k6U
 4CSdkyNDSTNykdsS+S2mDReLxPoeVvsprY/Ns2p00dCj2CAJsQjTuRfzzrdnGeMzM2YKbReq
 DshfZvln6FQzA6f867Dn4KU6zovNvQjq/rZhYAGloO9BSOpSnA0s+3LzGomjMlFx9fy7Yr9m
 bI1ybj4L+4jv29whjAk0fO8pVtnsf7wNcrPr3CtiFVEESjtu+bXvUgZ1SwhkF3nAhp0idprD
 D4mWZgAy200QKVQoj6m2qo5+Cq6kdS15ar8y7lvZKkm72+eNtyMbs+uatJNhTe8EYup9d6ze
 ZC2H+YrYNeCVfakD36/MWgbWAdqqOYmwtXrQcotQ0pbaIOLLtK6YAP9kJcF5kNWCr89YA8Ce
 FrSMXR/uxff1+WZ23Q+jAH+q3lYl0jWhOdBkQSsM2c1DZb2Hh/0ksD3cQa2nMN7og0RZVI7/
 nNdq5oiLZNRMkLar8VPpZJfeKnTmjWBR7cOmObJlrqUKkBJnLWspbypK444em7EaZ4uafaWK
 6xIm+wmVRCCH4GU/f+raGj2iq9MFlU6l7Wu75j26Q=
X-Talos-CUID: =?us-ascii?q?9a23=3A7nmSxGib1BuRa/5CPXhC5N1NFzJud0bHkibbLFS?=
 =?us-ascii?q?EWUUuQ4HNa1259Z5Eup87?=
X-Talos-MUID: 9a23:bfvuQwlqKHauYwqyUPqRdnplOP1p7vSfUHwztpZFtMCAMAYoAhC02WE=
Received: from us1-vpmsg-mbx02.tdy.teledyne.com ([140.165.245.31])
  by us1mail02.tdy.teledyne.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2024 09:59:52 -0700
Received: from US1-VPMSG-MBX01.TDY.Teledyne.com (140.165.245.30) by
 US1-VPMSG-MBX02.TDY.Teledyne.com (140.165.245.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 11:59:51 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (140.165.200.224)
 by US1-VPMSG-MBX01.TDY.Teledyne.com (140.165.245.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 11:59:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZ410JGsoM36I8XXKzaRRfVbSeqmAPGDf3rnvpkgnDtpwe3uvOQUf2c9VyYFuXJNyKRg6ZWlWmPB2qG6ZCXyK9Azk9HzSDMYYeh0yqjEXlCuu1Q2TeVIHx4dGpsQDCRy228icI/pbUa28Sbt9St539A1DFvyjczd8qQoZFswKmD71digcsvvcAv8QSp3xWSsEGEFuNWBzOHUkLBZIBzUWm2ZQRxbMpdr+2KkO+XJU6UoTqndugCLzogq9rtsgn/MPQPLNabvOZTS6eQWCgwnLpaZZV2bVRB1/2SrsTdTypEIMVxOnzHPGrpjI5SN/JkTUhSJpiXP+ObQRIhqOe5Rxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hJdrIW9bWfZZOdQEehOizaSTPla5V+mRtwNAA9+Uak=;
 b=djZpjxf3/hYlaRkvTNUeRvccm2KYbvvxhCX3jdDLoOFdLxj6lvwVeNZ2tDt6gKmyz8vmA0OV2VjnipLPZ/0bFzR3OVGWJwa2pfyszO5DRgcKMf0FGVn3LXeA4xwtcwj73DwBMJ0acrTMdQQ6tHfc3AsUelF2IIOVU4kNbCcP3LUY4AJiYdgw1C2bHZGnzBA1AfQgsvZEFxhHZ6E6xbVCS5nnXdn+JDi/l56KTl0aRMhdy28+H0VzTjc/cCUZe4eVIyWsRQhZI89vqw3tRtG1daj/xoqg20FZFmdeol16utA2dCPQZEHD1dqJ8YPU+ECnKbYH+DJlD4dEFO1m04v8uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teledyne.com; dmarc=pass action=none header.from=teledyne.com;
 dkim=pass header.d=teledyne.com; arc=none
Received: from DM8PR14MB5221.namprd14.prod.outlook.com (2603:10b6:8:28::14) by
 IA0PR14MB6408.namprd14.prod.outlook.com (2603:10b6:208:430::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Tue, 10 Sep
 2024 16:59:48 +0000
Received: from DM8PR14MB5221.namprd14.prod.outlook.com
 ([fe80::608e:ffbc:5b4d:d1b2]) by DM8PR14MB5221.namprd14.prod.outlook.com
 ([fe80::608e:ffbc:5b4d:d1b2%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 16:59:48 +0000
From: "Hamby, Jake (US)" <Jake.Hamby@Teledyne.com>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] can: m_can: Enable NAPI before enabling interrupts
Thread-Topic: [PATCH] can: m_can: Enable NAPI before enabling interrupts
Thread-Index: AdsAsyKTGmJ+XkFHSO22ELaGzk/2HwC75BCw
Date: Tue, 10 Sep 2024 16:59:48 +0000
Message-ID: <DM8PR14MB522141E1B64C5AAEA8239D18EF9A2@DM8PR14MB5221.namprd14.prod.outlook.com>
References: <DM8PR14MB5221D9DD3A7F2130EF161AF7EF9E2@DM8PR14MB5221.namprd14.prod.outlook.com>
In-Reply-To: <DM8PR14MB5221D9DD3A7F2130EF161AF7EF9E2@DM8PR14MB5221.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-titus-metadata-40: =?utf-8?B?ZXlKRFlYUmxaMjl5ZVV4aFltVnNjeUk2SWlJc0lrMWxkR0ZrWVhSaElqcDdJ?=
 =?utf-8?B?bTV6SWpvaWFIUjBjRHBjTDF3dmQzZDNMblJwZEhWekxtTnZiVnd2Ym5OY0ww?=
 =?utf-8?B?Wk1TVklpTENKcFpDSTZJamhoT1RVeE1UVTRMV05pWkdRdE5HTTRNQzFpWWpF?=
 =?utf-8?B?MExUQXdaRE13WlRJek5EQmhPQ0lzSW5CeWIzQnpJanBiZXlKdUlqb2lSVU5K?=
 =?utf-8?B?UkdGMFlTSXNJblpoYkhNaU9sdDdJblpoYkhWbElqb2lUazl2Y2tWQlVqazVJ?=
 =?utf-8?B?bjFkZlN4N0ltNGlPaUpGUTBsS2RYSnBjeUlzSW5aaGJITWlPbHRkZlN4N0lt?=
 =?utf-8?B?NGlPaUpGUTBsSlZFRlNRMnhoYzNNaUxDSjJZV3h6SWpwYlhYMHNleUp1SWpv?=
 =?utf-8?B?aVJVTkpSVUZTUTJ4aGMzTWlMQ0oyWVd4eklqcGJYWDBzZXlKdUlqb2libTl1?=
 =?utf-8?B?VlZORGIzVnVkSEo1SWl3aWRtRnNjeUk2VzExOUxIc2liaUk2SW01dmJsVlRS?=
 =?utf-8?B?VU5KU25WeWFYTWlMQ0oyWVd4eklqcGJYWDBzZXlKdUlqb2lWVzV5WlhORGIy?=
 =?utf-8?B?MXdSWGgwSWl3aWRtRnNjeUk2VzNzaWRtRnNkV1VpT2lKT1R5SjlYWDBzZXlK?=
 =?utf-8?B?dUlqb2lRMjl0Y0ZObGJuTWlMQ0oyWVd4eklqcGJleUoyWVd4MVpTSTZJazVQ?=
 =?utf-8?B?SW4xZGZTeDdJbTRpT2lKSmJtTnNkV1JsUTI5dGNGTmxibk5OWVhKcmFXNW5J?=
 =?utf-8?B?aXdpZG1Gc2N5STZXMTE5TEhzaWJpSTZJa052Ym1aTVpXZFFjbWtpTENKMllX?=
 =?utf-8?B?eHpJanBiZXlKMllXeDFaU0k2SWs1UEluMWRmU3g3SW00aU9pSlFTVWxFWVhS?=
 =?utf-8?B?aElpd2lkbUZzY3lJNlczc2lkbUZzZFdVaU9pSk9UeUo5WFgwc2V5SnVJam9p?=
 =?utf-8?B?UTFWSlJHRjBZU0lzSW5aaGJITWlPbHQ3SW5aaGJIVmxJam9pVGs4aWZWMTlM?=
 =?utf-8?B?SHNpYmlJNklrTlZTVU5oZEdWbmIzSjVJaXdpZG1Gc2N5STZXMTE5TEhzaWJp?=
 =?utf-8?B?STZJa1JwYzNObGJXbHVZWFJwYjI0aUxDSjJZV3h6SWpwYlhYMHNleUp1SWpv?=
 =?utf-8?B?aVVtVnNWRzhpTENKMllXeHpJanBiWFgwc2V5SnVJam9pUkdsemNHeGhlVTl1?=
 =?utf-8?B?YkhraUxDSjJZV3h6SWpwYlhYMWRmU3dpVTNWaWFtVmpkRXhoWW1Wc2N5STZX?=
 =?utf-8?B?MTBzSWxSTlExWmxjbk5wYjI0aU9pSXlNeTQyTGpJME1ETXVNU0lzSWxSeWRY?=
 =?utf-8?B?TjBaV1JNWVdKbGJFaGhjMmdpT2lKRlRVWjVRek5aUlhabWFtaEhibTVxUjBw?=
 =?utf-8?B?dlZscHRlWFIwTjJsdVRqVTRlVkZ0ZGt4RWNEQm5Wa2RvYzJWd1ZtWk5jMEpV?=
 =?utf-8?B?WEM5Q1Ixd3ZTa1pWUVZCQ00zTWlmUT09?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Teledyne.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR14MB5221:EE_|IA0PR14MB6408:EE_
x-ms-office365-filtering-correlation-id: 7906ea01-0ca2-40ac-cdcf-08dcd1b9fab0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MlZpaXhORC9IZzh0TlV5NElNVzV5RG03WU5GeGRRWXVOVU5uN2FlZ25qdXNB?=
 =?utf-8?B?OVJid21wdi9UMDJBSzY2RENnb09RdnRSZnAvbDh2b2RubjdsTmFIU3k3K1BC?=
 =?utf-8?B?dG9RcW9xWGVDU2djN0hMMzl2N29SQUcvelUrZ0pGMHF6ZmxMcTJaVW1jZk8x?=
 =?utf-8?B?TGl5ckg2LzRZOHZsUExoM21NWHJoTWxuNVpMaStxU2Mxcm5DVXNIeHUvaUlN?=
 =?utf-8?B?SUJTenRTeW5VNFIxRnFpZk1oZ2kzSTVPWUNXZjRCMElJWk05cWxMNjNQeGQw?=
 =?utf-8?B?bGhJRXBCVXZDdDdTcjNsZk9PVGRpTGFmaCtVa0JIdUF6WWYwbGhjN0kyYUtp?=
 =?utf-8?B?cEMzakMxTmc4cEI2RVJYZTIwVDV1QU1RbTMzWWVOOURJNmxPQm1qQkZnR1FT?=
 =?utf-8?B?K1FzVFN3YTIwU3lIZDYzN0ZobGxaR0lwNVpmT3dPaGhXMFErM0hYN2JQbjF4?=
 =?utf-8?B?ditMdFJCU0F5TlJLQ0MyQVk4ZDFvdnFNNWMxQ3oyQjhOcFhXWnNNcGtScDNo?=
 =?utf-8?B?d3JhVDU3OTQxWU9qU2ZTcW5TTWVrWlArbWt6aVA4TG42VktySXhzYU1TdGdF?=
 =?utf-8?B?L1RoMVN0cEpTVjdEYjI1QkFRamhCUnU4YWQzVktkR3FaZUhrZFRGaVVBOVVH?=
 =?utf-8?B?UytwUTEveDVmTk1HYVlmY2MvMzg4bEhoc3U1ajBrZEZ1c2I5ODF2R05QVU52?=
 =?utf-8?B?RDlLV1BLWTJQQ0VHZ0hZOGg1N1piMnVmZFg2T1RuUGVsNWJXR3FYU1lWcEFM?=
 =?utf-8?B?R0wzQVJqYkVqUWxQb1VHSFduVzV2L1ZrOFhSdEhodXZJdGpGRjZTa3hMZGNC?=
 =?utf-8?B?Q1cxVDVvTWlsZDRVRjV5cGdnQnllcHpiaUJSeUVHQmpJVGQrZHJvMTloQ0Zt?=
 =?utf-8?B?WmRQQVIwbE15c3BISUJoS2t4bWdEdFdpNlQrTWRTNTYvUDFPUktZQnNMMnRy?=
 =?utf-8?B?WTFHV2N3eVFqVDdTVW5xN0ZGbmdCNkFwRUZGUTVsUTlSYUFqakt3a015QTQw?=
 =?utf-8?B?a2xvVmxQZzUxb0k2MHl0TVhVVlZUNWFsalZ2STM3U3o5ejBUTkkxcFdMRTJa?=
 =?utf-8?B?NHZVZnVOTS9WYnVzRXBqL2NhQ3dOOXBaUGRDZDRLZmVrYklSQTh4eWswU2Qr?=
 =?utf-8?B?a2M3aktGMW9qRk9MN2p0RWU2Y2Z2a2E3Syt3ZEh5UjMrVnVlOFhia3J1NkZH?=
 =?utf-8?B?UStaNEUyYlpsN2ZvSEk1Um82cVJYUEdzTGdIWmVRcGRDVDBLS0x4WkxrbzU2?=
 =?utf-8?B?L2REK0V3NFlud09DUWppNE4zcHRWTndIZHB3bXRHV0V1SFlkV0VrQVVUMFNs?=
 =?utf-8?B?cW1MNjlNbTJvM2NJalJNM2Z5YWdJRFgwNjJQWGh0VDU4c3FRcThDbmVPS1FK?=
 =?utf-8?B?QlBxd0c4eU52VVZ2NGVNTS9jL2xZUUpESythejBIZUV4NFFkYVN3UnN1dkwx?=
 =?utf-8?B?UEVpK29VSUsrNzg2cjh1eW9VY2x0TFhtYWxnZ040NXZhdTN2aWxUdGR1c3NQ?=
 =?utf-8?B?bm51UG8yWHFkU2pKZXNQc0FkcEluM2Y5ZndKalh4MmtucTU1eWJSQ2M3bHN6?=
 =?utf-8?B?djdSSmY0WG1nRVhaUm5IdUV0ckgzK2QrMjN3dkJtRjlWN2RGaHdPWXJGT1Z5?=
 =?utf-8?B?d2tyTDdNZXI2UTFFbFRZejkzZkgrTkZtMDFXejJQb3F2eENXc1Qwa0ZjWEcz?=
 =?utf-8?B?Uy9ORXRkaHJwYmpZcldoeEVEdjJyd0J1by9paFlmSUhWZnc2UzQ4ay9uYm5u?=
 =?utf-8?B?Z1gwV29QcE9ZRldYYzgrYk9LWkQ3NmVwU0pTcXpaOExWZmlPeFlmTFRmU1Np?=
 =?utf-8?B?NW4vMDErTEM1YXhGdEQ3SVRBcjhyMEl0QzYvcVRQT1dtOWtsWTVoY1B4SXRJ?=
 =?utf-8?B?UTJwRURwejlqSjV0L3lWZ1c2dkpOUXZMQ3FTc2J5d0hlWEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR14MB5221.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWdIMnZDUjBJYVhLbkpORlQ1VkRQUkdab0hhUmc5Sk1YZlZMa2dYYk8xU1Av?=
 =?utf-8?B?cWVPdjN4WTRrdlc4UkViSEZ2Vy9VdFNNbWh1eWoyVHdCeExPMXBKMkhzc21G?=
 =?utf-8?B?QzlGZU5qUG9PUXJnMDdCMmlCNVo3bjZwUXJYNW41Ny9Zd04zNmVpRU5hQW5B?=
 =?utf-8?B?WXk0SDYyWFZQbUsxVENUbXZlSXNGODJjSnNRUTNRcUsvS0lOeGdtb1N5Q0NK?=
 =?utf-8?B?Y0EvdmRBS1ViVmRiS0sraHNIL0doK1hvS0p2NUloNGpOQWRwemtrZFRaNXZR?=
 =?utf-8?B?WHMxdVh5UlRMdDVweGt6K1ozQkJpa1FNWU5VNG9pZGI0VDMyc2FCUG9KMjEy?=
 =?utf-8?B?ZWpQZnVGODZIclpJcWhjcWU0R21hN2ErekVjTmVpcmtIMldHbkxYRmNacHZG?=
 =?utf-8?B?TmpuNEZrTUMvKzQ3MFJ1ckl2UGIyOVo3ZE96eng1ZTlLOXlWdGVVa2Z3ZzR5?=
 =?utf-8?B?Q1VoTmY2cHdoL2RpQWVvcXlxWTZqZ0NVdjUyNWhXRnI4SVlZWk5tdjJ4Nzlh?=
 =?utf-8?B?aFhwQVc1MGozbGprb1FZYXZDOXRqQmZaNkJmTXh6RHF6K1J0S1BZWnJJanFG?=
 =?utf-8?B?OTlpNmRNN3lwNUthQnVBRFUxREo3WHhxRXlWREMyRXhTOVFrcEJjYVdoSS9J?=
 =?utf-8?B?b3NEY0ZvTzlTT05oeVFFQ0VnWk5qSVlyVnFQT1N6SWg5WUZKR3ZQN0V3NmZq?=
 =?utf-8?B?YjNyU3BUVlRWV1VONFZGaVc3YTNaZEpGelpSVHdab0JUd3FaeWcxR0NRTUU2?=
 =?utf-8?B?MUYwdWx5YXJVRGtmOG84cmtzY0J4VGwzQno4endkWmU4WW4reDVuUS9xTXJY?=
 =?utf-8?B?akRROXI5WXFLYkI3b1gxNjZmNGNYcnFlV0JqdSt3Nnl0YUd5bC9DR0ZIOC9l?=
 =?utf-8?B?MXJFSERUVC9FVjZtV1JuY1JjYTdxVm41QUJXc1ZOSGlYbFp2dEFXS3I0WHlG?=
 =?utf-8?B?MmRQZHpMU1dncUJEc0pKN01IRUxrSjRRL3dUSXdvaklJd1NnN3RYdUdHU0FK?=
 =?utf-8?B?Z2RweEtsMWM4cmFPZGVnZjlYQ1ZlMGxFSGVZcndLRlIwWW1GMzlWTjJnSkFa?=
 =?utf-8?B?RjYwTHh5ODlnMjZ0TUpIUXdYUWRHVkQ4RkpJUDVnelV5Y0lOVDdCUHZjNW1j?=
 =?utf-8?B?S1FTSkhheDVhb2xGTXJzV2M4QWhoZVJuc0FMRkxMVEQ2L0Z0NkswV1RBQVNy?=
 =?utf-8?B?aXNrWlZKTjRSa2NhbHRjODdNcjdCQ2p6MFh4RktVUWJBUEgvSGMycU4rU1dy?=
 =?utf-8?B?UFBicDliYklGV3JuWHRScTRZMWc3WFFwY0dURFZuejZmSEFodFk2Rkl6b2Nm?=
 =?utf-8?B?bTI2K3VUbVZDSVpIZDkzNkN1OGYyQmpZdFNGRG9PUzJLQ3gwSjNCeWo0dEdT?=
 =?utf-8?B?bXVxTjQxYXJoRm1lOGZ2Q3NCUlFpeFd3WkNOMWx5blJ3dUxvcE1mYnNJd1U4?=
 =?utf-8?B?aFB6OGNpWWFpdFNld3BsbU1KZmVuWTVzU3RwZEh6NFord09RR2VtOU1ZdlI4?=
 =?utf-8?B?Q0xqd0ZsM0FjekJlWU5nc1JqdDZmaytMN3dKOVhpN2N6RTN0WWg0ZVpWMXQz?=
 =?utf-8?B?aFQxejdiMmJjZndhVFBzcU9tTUxmMGVJNUJOT1ZPcVZiNHl3QXhjSEQzbUZK?=
 =?utf-8?B?bWlEV0lPQmJScnJkcmNQSllQaW91by9zemc4bXlFbjJ6NldvZlBnTklCQzJH?=
 =?utf-8?B?WFdtS0NqbUNtYXpKTFZFNmNsK1A4RDlsNHdtTmxkK1MwRE11NExBL0lrdjdq?=
 =?utf-8?B?WXBRdER0L0t3Z2ZWRks0TEx2cG5ML0hpRG5nMlB6UGt5a3pJUWRWbjgwQXlo?=
 =?utf-8?B?NjlWcVlVdE5WdG1taGJ5WmZyQ1VUenZ4L0NEaFcxS09pTEtseUlXZlBQdElP?=
 =?utf-8?B?M0VGbktrQ1RxRnBGNzRYSmdwcm9vdklVc0RnTlF2a1l0MHlldGUyYVJtcDBO?=
 =?utf-8?B?MzZVTE4xNU9PRkljOTBKY3Q2bmZBVUtjbUN2dHNObks0QjRtRlhnRGFYbkVD?=
 =?utf-8?B?TGpjNXdrTEp3c1VjR3pzQ1BRQjhmMFhsYThuSGoxTlZocU0yb09NdzFWeFA0?=
 =?utf-8?B?Y3h6WnU3U1pxdGF2TXRodTRqWWIrNlZiVGlWbnRSZ01IS2VXOUd3bFFjLytr?=
 =?utf-8?Q?7CQvvt62E2R2uCt0ozZCVRxiU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR14MB5221.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7906ea01-0ca2-40ac-cdcf-08dcd1b9fab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 16:59:48.4420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e324592a-2653-45c7-9bfc-597c36917127
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efRkJLvMwXFVC5gT/++Bsvvlm0YHu9iR8AmBPHEnFQXXMfwzxIRv3+opabt8MTIn3GkUtxStVBsB8q98QwVhVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR14MB6408
X-OriginatorOrg: Teledyne.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW1ieSwgSmFrZSAoVVMpDQo+
IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDYsIDIwMjQgNDoyMCBQTQ0KPiBUbzogbGludXgtY2Fu
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBbUEFUQ0hdIGNhbjogbV9jYW46IEVuYWJsZSBOQVBJIGJlZm9yZSBlbmFibGluZyBpbnRlcnJ1
cHRzDQo+IA0KPiBJZiBhbnkgZXJyb3IgZmxhZ3MgYXJlIHNldCB3aGVuIGJyaW5naW5nIHVwIHRo
ZSBDQU4gZGV2aWNlLCBlLmcuIGR1ZSB0bw0KPiBDQU4gYnVzIHRyYWZmaWMgYmVmb3JlIGluaXRp
YWxpemluZyB0aGUgZGV2aWNlLCB3aGVuIG1fY2FuX3N0YXJ0IGlzDQo+IGNhbGxlZCBhbmQgaW50
ZXJydXB0cyBhcmUgZW5hYmxlZCwgbV9jYW5faXNyIGlzIGNhbGxlZCBpbW1lZGlhdGVseSwNCj4g
d2hpY2ggZGlzYWJsZXMgYWxsIENBTiBpbnRlcnJ1cHRzIGFuZCBjYWxscyBuYXBpX3NjaGVkdWxl
Lg0KPiANCj4gQmVjYXVzZSBuYXBpX2VuYWJsZSBpc24ndCBjYWxsZWQgdW50aWwgbGF0ZXIgaW4g
bV9jYW5fb3BlbiwgdGhlIGNhbGwgdG8NCj4gbmFwaV9zY2hlZHVsZSBuZXZlciBzY2hlZHVsZXMg
dGhlIG1fY2FuX3BvbGwgY2FsbGJhY2sgYW5kIHRoZSBkZXZpY2UgaXMNCj4gbGVmdCB3aXRoIGlu
dGVycnVwdHMgZGlzYWJsZWQgYW5kIGNhbid0IHJlY2VpdmUgYW55IENBTiBwYWNrZXRzIHVudGls
DQo+IHJlYm9vdGVkLiBUaGlzIGNhbiBiZSB2ZXJpZmllZCBieSBydW5uaW5nICJjYW5zZW5kIiBm
cm9tIGFub3RoZXIgZGV2aWNlDQo+IGJlZm9yZSBzZXR0aW5nIHRoZSBiaXRyYXRlIGFuZCBjYWxs
aW5nICJpcCBsaW5rIHNldCB1cCBjYW4wIiBvbiB0aGUgdGVzdA0KPiBkZXZpY2UuIEFkZGluZyBk
ZWJ1ZyBsaW5lcyB0byBtX2Nhbl9pc3Igc2hvd3MgaXQncyBjYWxsZWQgd2l0aCBmbGFncw0KPiAo
SVJfRVAgfCBJUl9FVyB8IElSX0NSQ0UpLCB3aGljaCBjYWxscyBtX2Nhbl9kaXNhYmxlX2FsbF9p
bnRlcnJ1cHRzIGFuZA0KPiBuYXBpX3NjaGVkdWxlLCBhbmQgdGhlbiBtX2Nhbl9wb2xsIGlzIG5l
dmVyIGNhbGxlZC4NCj4gDQo+IE1vdmUgdGhlIGNhbGwgdG8gbmFwaV9lbmFibGUgYWJvdmUgdGhl
IGNhbGwgdG8gbV9jYW5fc3RhcnQgdG8gZW5hYmxlIGFueQ0KPiBpbml0aWFsIGludGVycnVwdCBm
bGFncyB0byBiZSBoYW5kbGVkIGJ5IG1fY2FuX3BvbGwgc28gdGhhdCBpbnRlcnJ1cHRzDQo+IGFy
ZSByZWVuYWJsZWQuIEFkZCBhIGNhbGwgdG8gbmFwaV9kaXNhYmxlIGluIHRoZSBlcnJvciBoYW5k
bGluZyBzZWN0aW9uDQo+IG9mIG1fY2FuX29wZW4sIHRvIGhhbmRsZSB0aGUgY2FzZSB3aGVyZSBs
YXRlciBmdW5jdGlvbnMgcmV0dXJuIGVycm9ycy4NCj4gDQo+IEFsc28sIGluIG1fY2FuX2Nsb3Nl
LCBtb3ZlIHRoZSBjYWxsIHRvIG5hcGlfZGlzYWJsZSBiZWxvdyB0aGUgY2FsbCB0bw0KPiBtX2Nh
bl9zdG9wIHRvIGVuc3VyZSBhbGwgaW50ZXJydXB0cyBhcmUgaGFuZGxlZCB3aGVuIGJyaW5naW5n
IGRvd24gdGhlDQo+IGRldmljZS4gVGhpcyByYWNlIGNvbmRpdGlvbiBpcyBtdWNoIGxlc3MgbGlr
ZWx5IHRvIG9jY3VyLg0KPiANCj4gV2hpbGUgdGVzdGluZywgSSBub3RpY2VkIHRoYXQgSVJfVFNX
ICh0aW1lc3RhbXAgd3JhcGFyb3VuZCkgZmlyZXMgYXQNCj4gYWJvdXQgMSBIeiwgYnV0IHRoZSBk
cml2ZXIgZG9lc24ndCBjYXJlIGFib3V0IGl0LiBBZGQgaXQgdG8gdGhlIGxpc3Qgb2YNCj4gaW50
ZXJydXB0cyB0byBkaXNhYmxlIGluIG1fY2FuX2NoaXBfY29uZmlnIHRvIHJlZHVjZSB1bm5lZWRl
ZCB3YWtldXBzLg0KPiANCj4gVGVzdGVkIG9uIGEgTWljcm9jaGlwIFNBTUE3RzU0IE1QVS4gVGhl
IGZpeCBzaG91bGQgYmUgYXBwbGljYWJsZSB0byBhbnkNCj4gU29DIHdpdGggYSBCb3NjaCBNX0NB
TiBjb250cm9sbGVyLg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jIHwg
MTkgKysrKysrKysrKysrLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvY2FuL21f
Y2FuL21fY2FuLmMNCj4gYi9kcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYw0KPiBpbmRleCAw
MTJjM2QyMmIwMWQuLjRjZWQ4MzBmNWVjZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvY2Fu
L21fY2FuL21fY2FuLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2FuLmMNCj4g
QEAgLTE0MzQsNyArMTQzNCw4IEBAIHN0YXRpYyBpbnQgbV9jYW5fY2hpcF9jb25maWcoc3RydWN0
IG5ldF9kZXZpY2UNCj4gKmRldikNCj4gDQo+ICAJLyogRGlzYWJsZSB1bnVzZWQgaW50ZXJydXB0
cyAqLw0KPiAgCWludGVycnVwdHMgJj0gfihJUl9BUkEgfCBJUl9FTE8gfCBJUl9EUlggfCBJUl9U
RUZGIHwgSVJfVEZFIHwgSVJfVENGDQo+IHwNCj4gLQkJCUlSX0hQTSB8IElSX1JGMUYgfCBJUl9S
RjFXIHwgSVJfUkYxTiB8IElSX1JGMEYpOw0KPiArCQkJSVJfSFBNIHwgSVJfUkYxRiB8IElSX1JG
MVcgfCBJUl9SRjFOIHwgSVJfUkYwRiB8DQo+ICsJCQlJUl9UU1cpOw0KPiANCj4gIAllcnIgPSBt
X2Nhbl9jb25maWdfZW5hYmxlKGNkZXYpOw0KPiAgCWlmIChlcnIpDQo+IEBAIC0xNzYzLDEzICsx
NzY0LDE0IEBAIHN0YXRpYyBpbnQgbV9jYW5fY2xvc2Uoc3RydWN0IG5ldF9kZXZpY2UgKmRldikN
Cj4gDQo+ICAJbmV0aWZfc3RvcF9xdWV1ZShkZXYpOw0KPiANCj4gLQlpZiAoIWNkZXYtPmlzX3Bl
cmlwaGVyYWwpDQo+IC0JCW5hcGlfZGlzYWJsZSgmY2Rldi0+bmFwaSk7DQo+IC0NCj4gIAltX2Nh
bl9zdG9wKGRldik7DQo+ICAJbV9jYW5fY2xrX3N0b3AoY2Rldik7DQo+ICAJZnJlZV9pcnEoZGV2
LT5pcnEsIGRldik7DQo+IA0KPiArCS8qIGRpc2FibGUgTkFQSSBhZnRlciBkaXNhYmxpbmcgaW50
ZXJydXB0cyAqLw0KPiArCWlmICghY2Rldi0+aXNfcGVyaXBoZXJhbCkNCj4gKwkJbmFwaV9kaXNh
YmxlKCZjZGV2LT5uYXBpKTsNCj4gKw0KPiAgCW1fY2FuX2NsZWFuKGRldik7DQo+IA0KPiAgCWlm
IChjZGV2LT5pc19wZXJpcGhlcmFsKSB7DQo+IEBAIC0yMDMxLDYgKzIwMzMsMTAgQEAgc3RhdGlj
IGludCBtX2Nhbl9vcGVuKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpDQo+ICAJaWYgKGNkZXYtPmlz
X3BlcmlwaGVyYWwpDQo+ICAJCWNhbl9yeF9vZmZsb2FkX2VuYWJsZSgmY2Rldi0+b2ZmbG9hZCk7
DQo+IA0KPiArCS8qIGVuYWJsZSBOQVBJIGJlZm9yZSBlbmFibGluZyBpbnRlcnJ1cHRzICovDQo+
ICsJaWYgKCFjZGV2LT5pc19wZXJpcGhlcmFsKQ0KPiArCQluYXBpX2VuYWJsZSgmY2Rldi0+bmFw
aSk7DQo+ICsNCj4gIAkvKiByZWdpc3RlciBpbnRlcnJ1cHQgaGFuZGxlciAqLw0KPiAgCWlmIChj
ZGV2LT5pc19wZXJpcGhlcmFsKSB7DQo+ICAJCWNkZXYtPnR4X3dxID0gYWxsb2Nfb3JkZXJlZF93
b3JrcXVldWUoIm1jYW5fd3EiLA0KPiBAQCAtMjA2Myw5ICsyMDY5LDYgQEAgc3RhdGljIGludCBt
X2Nhbl9vcGVuKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpDQo+ICAJaWYgKGVycikNCj4gIAkJZ290
byBleGl0X3N0YXJ0X2ZhaWw7DQo+IA0KPiAtCWlmICghY2Rldi0+aXNfcGVyaXBoZXJhbCkNCj4g
LQkJbmFwaV9lbmFibGUoJmNkZXYtPm5hcGkpOw0KPiAtDQo+ICAJbmV0aWZfc3RhcnRfcXVldWUo
ZGV2KTsNCj4gDQo+ICAJcmV0dXJuIDA7DQo+IEBAIC0yMDc3LDYgKzIwODAsOCBAQCBzdGF0aWMg
aW50IG1fY2FuX29wZW4oc3RydWN0IG5ldF9kZXZpY2UgKmRldikNCj4gIAlpZiAoY2Rldi0+aXNf
cGVyaXBoZXJhbCkNCj4gIAkJZGVzdHJveV93b3JrcXVldWUoY2Rldi0+dHhfd3EpOw0KPiAgb3V0
X3dxX2ZhaWw6DQo+ICsJaWYgKCFjZGV2LT5pc19wZXJpcGhlcmFsKQ0KPiArCQluYXBpX2Rpc2Fi
bGUoJmNkZXYtPm5hcGkpOw0KPiAgCWlmIChjZGV2LT5pc19wZXJpcGhlcmFsKQ0KPiAgCQljYW5f
cnhfb2ZmbG9hZF9kaXNhYmxlKCZjZGV2LT5vZmZsb2FkKTsNCj4gIAljbG9zZV9jYW5kZXYoZGV2
KTsNCj4gLS0NCj4gMi4zNC4xDQo+IA0KPiBCZXN0IFJlZ2FyZHMsDQo+IEpha2UgSGFtYnkNCg0K
U2lnbmVkLW9mZi1ieTogIkpha2UgSGFtYnkiIDxKYWtlLkhhbWJ5QFRlbGVkeW5lLmNvbT4NCg0K

