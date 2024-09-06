Return-Path: <linux-can+bounces-1430-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB8C96FE62
	for <lists+linux-can@lfdr.de>; Sat,  7 Sep 2024 01:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071341C21F87
	for <lists+linux-can@lfdr.de>; Fri,  6 Sep 2024 23:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AA815AAC1;
	Fri,  6 Sep 2024 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teledyne.com header.i=@teledyne.com header.b="NflJBE3C"
X-Original-To: linux-can@vger.kernel.org
Received: from us3mail01.teledyne.com (us3mail01.teledyne.com [130.50.171.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65CF1B85DB;
	Fri,  6 Sep 2024 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=130.50.171.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725664802; cv=fail; b=FOYHEbIGzcahStBcr5Uul8ZIOjXat1PdULQwUEyxyXwhLFw4D2zNAys78filbo+2XRkgYfitYw1jG46yIiU79WzOXKeBffmh7M2YE5hQbBBB+3xBzzyyCLqAUA/jz8t53mECTboqKOtgUr9Dg2W0diodKd63ZdEWiwDj89M15nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725664802; c=relaxed/simple;
	bh=eCEs9BciXtdLgDG31dXVT/Iv7BRjYtnEloBHBdLG/WY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jCjShwSxsuPwN/wsu4BWBj0MawCRhBmInWF1j7og0MDcSGKNfTKOM9Tonyv6WoGvHeSdwWKfozVcclyRUu6dYZ512q24i3mPW6E0HMiQpZw/eYF8IYCwBBdaLzd3z3KgChc3qFrgk+S1ZUO134GTfTPVaITJt+0F3TT3dfynPew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Teledyne.com; spf=pass smtp.mailfrom=teledyne.com; dkim=pass (2048-bit key) header.d=teledyne.com header.i=@teledyne.com header.b=NflJBE3C; arc=fail smtp.client-ip=130.50.171.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Teledyne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=teledyne.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=teledyne.com; i=@teledyne.com; q=dns/txt; s=TDY-2;
  t=1725664801; x=1757200801;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=eCEs9BciXtdLgDG31dXVT/Iv7BRjYtnEloBHBdLG/WY=;
  b=NflJBE3C4pjSv9FVHMq/DGIadctH3te2Ly6y0dgRP8YltIiwpd2ycMht
   4tiC8c2Tat6otAvOV9/7dtbsE2j5zSMP5nHwYDwTmrAEl0EMJcs3OX4zv
   06Heq48ISq3c5YuMBULgKuxS8VZSiVHglEZpaPeIqKrBaw/Q2guThqh8B
   Qf9LvtOmxYVQqj+wHqGO0H5xURA0b8FMETjIr1F7de3mIRrxm3lzQc2A3
   +XsUY+dYNe06Uean9fI65hxod06geMmPrxAyuE/aYnK6mQh+uCbng/bRG
   uE2M6TzM9OWV2VEgVV909RjM4A38idcHFIBI5CUp1Q2AVCjLlm/lpmJkI
   w==;
X-CSE-ConnectionGUID: 2jJ+v9ZPQlmRqPxVvatogA==
X-CSE-MsgGUID: jUPltII0SBGtBhXdKa83mA==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:Rss+dKNH50FTWmPvrR3flsFynXyQoLVcMsEvi/4bfWQNrUoh32ECm
 jccUGjVbvfYMWX1e4olPdi+8EsDvcOGn9JhSAZtpSBmQkwWlceUXt7xwmXYZnvIcpWbFBoPA
 +Y2M4GacJhsFie0SjOFaOWJQaxUjPnQLlbEILeZfH03HEk8FXpJZStLw4YRmpRvjcWyHzSDs
 Nbzp9y3EFK+0laYCEpNg06+gEgHUMra6WpwUmMWNagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nVKtio2nhc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuodcrLZUj2CA6IoKvn3bEmp1T4E8K0YIwoORVQn8fx
 8QhLDU3dyiTufy/3LW0Y7w57igjBJGD0II3h0o6iA/hKM0JBLXpc/2To8NUzXEsi8RDEefYa
 owSbj8HgBboOkYXfApPTshiwaHz3hETcBUBwL6RjYg+4GWV7AV02qnFLNfRd9CbQ8gTlUGdz
 o7D1z2lUkBAaYLDklJp9Fquu9fLgQLaALk4O6GS9s5mo1TDnWk6XUh+uVyT5KPRZlSFc9ZeL
 VEEvyEnq4As+0GxCNrwRRu1pDiDpBF0c95RFfAqrQKA0KzZ5y6HCWUeCD1MctorsIkxXzNC6
 7OSt87yX3lxqLiORjeY/KfM9HWuNTlTMWIGaCMVSwZD6N7myG0usi/yoh9YOPbdprXI9fvYm
 lhmcABWa20vsPM2
IronPort-HdrOrdr: A9a23:GJP5WKiyz3wN/21VY/4G+UUvHXBQX1J13DAbv31ZSRFFG/FwyP
 rAoB1L73PJYWgqNU3IwerwQZVoMkmsjaKdhrNhdYtKPTOW8VdAQ7sSircKrweBJ8SczJ8X6U
 4DSdkZNDSYNzET5qyVgTVQe+xQheVvm5rY59s2uk0dKT2CHJsQijuRZDzrcXFedU1jP94UBZ
 Cc7s1Iq36LYnIMdPm2AXEDQqzqu8DLvIiOW29NOzcXrC21yR+44r/zFBaVmj0EVSlU/Lsk+W
 /Z1yTk+6SYte2hwBO07R6f030Woqqs9jJwPr3DtiEnEESstu9uXvUgZ1S2hkF7nAho0idorD
 CDmWZjAy050QKrQoj8m2qW5+Cn6kdr15aq8y7lvVLz5cP+Xz40EMxHmMZQdQbY8VMpuJVm3L
 tMxH/xjesiMfrsplWO2zHzbWAeqmOk5X451eIDhX1WVoUTLLdXsIwE5UtQVJMNBjjz5owrGP
 RnSJi03ochTXqKK3TC+mV/yt2lWXo+Wh+AX0gZo8SQlzxbhmpwwUcUzNEW2n0A6JU+QZ9Z4P
 msCNUeqJheCssNKa5tDuYIRsW6TmTLXBLXKWqXZU/qEakWUki92KIfII9FlN1CVKZ4vafawq
 6xL2+wnVRCBX4Hvqe1reB2ziw=
X-Talos-CUID: 9a23:mdp9jWG8rCMrR6isqmI99mxXBJEXSkTZyU3JG1+GF291T7K8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A9xK9+g7yl78SEdyHj4RdcYU2xoxq3pyqFGEsya4?=
 =?us-ascii?q?slNWuNRx8GD7N1zGeF9o=3D?=
Received: from us2-vpmsg-mbx01.tdy.teledyne.com ([130.50.245.30])
  by us3mail01.tdy.teledyne.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 16:19:55 -0700
Received: from US2-VPMSG-MBX01.TDY.Teledyne.com (130.50.245.30) by
 US2-VPMSG-MBX01.TDY.Teledyne.com (130.50.245.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Sep 2024 16:19:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (130.50.245.239)
 by US2-VPMSG-MBX01.TDY.Teledyne.com (130.50.245.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Sep 2024 16:19:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSRCxCb2DSe45Eshkqpp9TMwa70WGgsynVVwcphbOk2m5SzKWSkgq9OrbTCth5M8BRogcoq58R4Zy3QvGfp0hWrUvJVJpYA/bPnFD8ZU8SqW3gQxQWvOC1jG+W4Jex/WBHecjOvqYbnqkcv8EGLoy+mTT+Lm+4FalBWwHnir43ury2E3l4T6eKFfYE3lALvoA1pmrHSoA+O6M6l6CXp7pfbqGxRZGo+xCcB3edSs8BLPcnlRosCUSnkKzc45uY6oHvJ2g+XCvPgVujMe5NokKLFjXenQuZysqJg/fxjZ0IB524aZcProHZcax1XFtSBehiopEK3j8AnwbIdgHVwEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCEs9BciXtdLgDG31dXVT/Iv7BRjYtnEloBHBdLG/WY=;
 b=lCcpqVzuVOkTYDFvyagCKgkVuIHiZ/LcdvQOxwU2G77AwTulZYq+gZO4al+JNo5PMbfpGSu6NOdKshEZRH9sUjh4XJSl2+IrzMaf7LhUCdm/Ey7Xan9jsMUvsDXSVyLhlRlUtSYLec/LvhqumNbtxmjbNBjUEqdwkvnHHZpTMmHgQ+oBLo0Rp3+UD3z4Qy+OSz0nKj4P1Q+CH3dpnMHXb2SiFmaq9eHeGjw5tbD8wX7o7t5DzWyU107PEt6GDgRdhQYQC5iTwgiwTfVJuu40KNof+H2vzoCz0mP77q+SQl57rHUCyDJHkve1M/WvWPlN0Gah0Ar8zbgTCDtfn698rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teledyne.com; dmarc=pass action=none header.from=teledyne.com;
 dkim=pass header.d=teledyne.com; arc=none
Received: from DM8PR14MB5221.namprd14.prod.outlook.com (2603:10b6:8:28::14) by
 SA6PR14MB7644.namprd14.prod.outlook.com (2603:10b6:806:41c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 23:19:51 +0000
Received: from DM8PR14MB5221.namprd14.prod.outlook.com
 ([fe80::608e:ffbc:5b4d:d1b2]) by DM8PR14MB5221.namprd14.prod.outlook.com
 ([fe80::608e:ffbc:5b4d:d1b2%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 23:19:51 +0000
From: "Hamby, Jake (US)" <Jake.Hamby@Teledyne.com>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] can: m_can: Enable NAPI before enabling interrupts
Thread-Topic: [PATCH] can: m_can: Enable NAPI before enabling interrupts
Thread-Index: AdsAsyKTGmJ+XkFHSO22ELaGzk/2Hw==
Date: Fri, 6 Sep 2024 23:19:51 +0000
Message-ID: <DM8PR14MB5221D9DD3A7F2130EF161AF7EF9E2@DM8PR14MB5221.namprd14.prod.outlook.com>
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
x-ms-traffictypediagnostic: DM8PR14MB5221:EE_|SA6PR14MB7644:EE_
x-ms-office365-filtering-correlation-id: 587844c8-a3d5-4b3f-ca5f-08dcceca68a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eURHZC9uUzErY3MyaXJBS29MU2JkN2ErWllmSURCekMza2F3eWhpcWJEY2Y0?=
 =?utf-8?B?d21OQlhyQzBYblloZEhVbmNMUlpCUG1yeXBaamVmbnZsMmxUSjg0T2xlekJa?=
 =?utf-8?B?WUh4K245YjB3bFYwTlBxWWQrdFV5TnMzaFgrV1EzTExUN3VDdUFtTnpUZGRy?=
 =?utf-8?B?cTlGOFV1TmFlUGtMaDRnb1ZGakgxZk42R3krd1FNclZ0WmFJbnUyblBONzd3?=
 =?utf-8?B?REprT0Y1aFU1Slc1L1IxelE1Q1JnS1hkS1BiYTl5YWNVaUhRRHk3Nmo4WjlJ?=
 =?utf-8?B?SStMcFZWMjJQQ0R0bHcwQjRSMUVkWXpnNDRTSk9kNSt1NmRQU1FWZ2VlOTNR?=
 =?utf-8?B?aFRNd2pNaUxmRnRDN0Y1QTQ2dk96TWNWaVNra3c3VXpDWHdUMzVKcVdxeUhn?=
 =?utf-8?B?T241bXk5ZExWSXIxNjU5c2JISE1RUFRrVWV0L2RKL0tTcFZJbHRSUUNpUVpX?=
 =?utf-8?B?Qk5RUXNWcGRocXpCbE5HaG56c1NxNnMyWlNxL2drMnhLUkNMdGsyekIrWU93?=
 =?utf-8?B?ZzZ0WDZmRExsTGhQWHowejkxYXpvVlJUZUdUTnZoV0tBOWErdDNDTnZaVUtR?=
 =?utf-8?B?bk4vYm5wS2dVUVZzdSs0K2xuWTBmYy9MOS9nRjgrSUhlcFRTQkxJSmRrQ3lF?=
 =?utf-8?B?ZTkxVlZ0UFVJdU9XQzAyVFZrUHd3cHRUZFlkSDhWbVh1aVlUQ1hjbDhubnY3?=
 =?utf-8?B?UWx0VVZLMWt4bDVKcFFSU3U4VWpHUExlVjZ1YS9xRWZXUnI3dG9DSUJDb3Fa?=
 =?utf-8?B?NitOUVVGblRjZWhSWDFseVNjMTJ4QWEzdlFjK3grTHg5aFVhN1JEZjJiSVpY?=
 =?utf-8?B?cE4xRFVlaUJhSTRKRy9kR2pnSjVEUGNUallXNjVuWG52bzhVeEtWNXg0T0g2?=
 =?utf-8?B?VUlIT1pWdi9NVjBZQ0ZHTnpleTJlUEpSMHZGS3ZyMHE1L2xPb2QxV3MycTV3?=
 =?utf-8?B?TC8wWWVaQlJUTnNRWWtnMWovTUYxTjRpa1M1N3JjV2dxamRFUUlLTkZzaFJ1?=
 =?utf-8?B?eW03MHVweTJpckdCSVk2Ly9BTzRpdXp3OGw0UTdSeDJOelhIOEdkRzNzSjhm?=
 =?utf-8?B?VUlrbU8vTDhwMHVLaG9CTGpFRmJVOEJ0VlRPWkl0di9LY1FKUlFia3I2bDF4?=
 =?utf-8?B?UnJuVkJXTWdWRC9WTDB2ZWk3Ym5rT0pydUwzZWc5QjIvaXB4RGhQdFNaL1NJ?=
 =?utf-8?B?a05QZHZrNTA2VmVjb1ZVWXRjeldmZVRSZUh4K1pTbHU2dGs3RzM2YzJwOFpS?=
 =?utf-8?B?anJLTEFlaSt2UkpRWlJSK3ArMnJodUh2akJyekNzOFFmVlZwOUhpZ3FMMHhE?=
 =?utf-8?B?NTRnQlIxWVZoUkErUUdlR244WU5DMVRHSkszVjViN0tJa1hlZHZXS3QxRkpE?=
 =?utf-8?B?WS9QNnlSOG8zL0tPZ1dsTTB0Qk4yUjkrei8xdDFkYlMxSlFMaXNoempGMElU?=
 =?utf-8?B?a1FrMXhlTnBlczdVYml6anNvb29IR2xpemNwaGR3ckNFamxzL1BZbWFyLzZJ?=
 =?utf-8?B?RHRjYnlaSGwxbjNjRUVFUnhGSGFLeXJyazJvQnpPRVBMRUM1VGgwV0M5b0Qw?=
 =?utf-8?B?Y1pzQzVwSWtXanpnNGg2YkVsb2NDWUZRU01mQzJ1NmlIalZGcHBLcTlBcEN6?=
 =?utf-8?B?N0ttYzFUQSsyTkpBR3lmSVFIS0EvZWFZRXJ1RXpaTXdzWVVMTDRpczlMb0di?=
 =?utf-8?B?ZWVaREtvOUFvck1SVnlXNCtTQ2hpdE5wNDlYVksrZ0xPcnlLTzZtb1kvVkNo?=
 =?utf-8?B?cTF0MTRTWjZSZjdmMG1tQWdCTXFPVkJBZDJoRVZibXVucWZpVlpDaDBkRmJj?=
 =?utf-8?B?T2x6S1NHUDJndVhJZXc0SWhSRXdXc0RtaWdhakxkN1ZKVFJ3MDl6SHVKK2lK?=
 =?utf-8?B?ckd1Q2NLQktOb0ViRkJYNkR2dWpzTCt5T2YzckMwY1pmc3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR14MB5221.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjBVcE1ZOFRFSHNLMWQxUUNDdklqQ0Fkb0ZGK21lUjZhT3ZMbnFoV1hiY3Nw?=
 =?utf-8?B?NWxBNTlTVUx3aUR3eHBpQ3ZyeEFKMVJmWCtaQmlFWVVHY08wNDhGV1JzTjBR?=
 =?utf-8?B?a0VHSGJhS2N6SWRaaC9ZR3BIQ2xxNEZkLzhkTzA0OElZcU9tUTBtbzBSeFNp?=
 =?utf-8?B?emF5V21JQnlsZkpoZHo3UjBYN29sQnlXWGtVekhwSmFhYVlrLys1QU5xVTQ0?=
 =?utf-8?B?RlhFazFWdFNLWUJ5WTZ3aUlwWTRqZUdSTXEyY3BXMGVWdktLZ0xWampPUEVp?=
 =?utf-8?B?VjNiQk9ENS90Sms4MHU0YW5qa2NMbENNelhiWFVJUDRBRVB1RzVab1dsWnVL?=
 =?utf-8?B?eHdCdy9rTTh6N2MxaG5HV2psTGFrbE5FSDI4UU1iZXk2aWw3NE95cGtzWVFq?=
 =?utf-8?B?aXllaE9oVkt2UmNqQ0k4a0k5QmRjaGtCcStuUDlMKzh2Nlh6NEwrZVp4R3pP?=
 =?utf-8?B?ZUVWSVJWdTRpRmNsMVp3VzVJeUg3ckhlTkluZnZsWlZ1Y05JeStTRXc4SEx5?=
 =?utf-8?B?Q2o4RCtEamRPVDQ2VSt4OW1NdXhxMFkzUzUvMVl3bldid0FjdXNtK1VTb3Ni?=
 =?utf-8?B?SFlTZ1F5ZTlGanJEVURVQ29uV3dPN1F4Unl3U0l5alFiRmpzekdNMklnazdz?=
 =?utf-8?B?RGZSckJmS0VOZG1GN29mV0VYOU9GOEdvYlV6SUR6bjRhaXN2KytmczdXTDFy?=
 =?utf-8?B?Z2N5K0VWWnlZU2RVdTNMbThwb3FxM0cvZFFuOFNFOUZmc2U1WWJGY2FkdXJj?=
 =?utf-8?B?WmV2WlE5S05rRFl5M2tlSEFjSzJ2NHBFZ1JmVmthdWJtNFFReDdrZ2NhNTc3?=
 =?utf-8?B?elNzMHZkZlBwZVFqRTh4c1NpVHNVRnBzSENhWkdVaGFtcDhvMTVtOUh4U0Mr?=
 =?utf-8?B?YTQ3cHFUTmxiQlBYYUJUMThLLzU0aFpqdjdKcW11amhHQ0pXUFMyVG00Wkpa?=
 =?utf-8?B?Rmw2YVJQaFFjUUp6K2pKR2xrM2NGM3JVQVFtdVRIbmUvUE5wdDZMSGFZZTZB?=
 =?utf-8?B?bzRGcnZkMW10ZXpvL1ozK280azFTckp5TmtUMFZBZ0NlNzJZOXN5QW9PMnJT?=
 =?utf-8?B?NThuOFdWQzBEMEJGeVo2S2dob3ozcGlEUlgvUVNzRWdIRzVRK296dEZvZWk0?=
 =?utf-8?B?VEVXZGRrQlZ3eVBEZlVSaytHTXZSNTN1N2JPbEhPYTJRVFpCMndmR3BOYm1o?=
 =?utf-8?B?aUFIaGI2M0IyOVpacC9nYXZPU1FQdC9MV3U4MFhkTU4zM1IyUzhBYzN2cWd0?=
 =?utf-8?B?cXd1bUwzZjlUdlNMTk9rSTBPa1dITjAwbmJTWFg0dFRsTEs1MXJhNFpKZkc0?=
 =?utf-8?B?ampzeGlwakhwb0FXNDg2QXNvYTVncWRLdHg3SE53K1V1QVRwNytaM28zTHEx?=
 =?utf-8?B?OFk3bzJlQnZ3dTdzQXNQclFLOC9kOUlwNktVbmpSZWlqVnYwZEV6Y1JZbk5k?=
 =?utf-8?B?c3pDdzhONU00YWc0SER5WlVsWnU2UnloK2VGNGFQQTBaSlJ2eDZURjh1R1ZT?=
 =?utf-8?B?VVIxdE9laWpodDNrZU96TlY3a3o4Q21GdGx3SFQxeUZrdnRYR1pnMXI4L2pi?=
 =?utf-8?B?WmtBZ2x4TVI1K0dXTEo4Nkk2UzUzWkIwd3kvZVNlaXlWR2VXRzhsUVJ0bVJO?=
 =?utf-8?B?MDhTL2ZZdmhxb1Z5b1dWdHZuREtOR3FOWWl1a2NCRTNlTXdtbWt1eUszOC93?=
 =?utf-8?B?SENEdDFKOVNQUzVTZ3ZiK1hXSW1qZ29hbUFEaFNraDdxeG4rT1ZYZGlJeTN6?=
 =?utf-8?B?RzVEbGlJcmFhVGVjME8zcGduMUVITlJLZUVxL3RST1NtU3p2T2VVb0F6ditr?=
 =?utf-8?B?bjRvdUVRNGxwMmU3NEVkWldSMEpPazB3YWJFWHhmTHB6TlZuZ1lqajB2K2R1?=
 =?utf-8?B?ZVpyWlFrTGJmUTAwNG5obWFGR3FaUkc1Q2tET2dCcHlxQkpVZ3ZOVVowMjZR?=
 =?utf-8?B?MFlJR1RmU3lhY0JRZTBJWktFa1lkQ0pEVm5KN1Q0UllYWDJ1YVpDZ3hKOFRv?=
 =?utf-8?B?UVVVclUyT2xRM1VZYzhEaGJtSVVEWkhOWFI4TU96Y3IrUWQxMGdGZ1UybUVU?=
 =?utf-8?B?WHEweXprUjhiekdxV1ZCcFErejFkazBwajNIWDhKOEQ5TkdtdFBzUTJHL2xw?=
 =?utf-8?Q?ZJCFXO++zrqbDfNVkq8Yd4wjP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 587844c8-a3d5-4b3f-ca5f-08dcceca68a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 23:19:51.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e324592a-2653-45c7-9bfc-597c36917127
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otpBKrotSsu6utJnmw1/nq+Ir3ZdbyX2puapZmYqe4ZERKsmj65bdp+TmkWQbUHoI1oVffTOqFIXFSQWjcZOOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR14MB7644
X-OriginatorOrg: Teledyne.com

SWYgYW55IGVycm9yIGZsYWdzIGFyZSBzZXQgd2hlbiBicmluZ2luZyB1cCB0aGUgQ0FOIGRldmlj
ZSwgZS5nLiBkdWUgdG8NCkNBTiBidXMgdHJhZmZpYyBiZWZvcmUgaW5pdGlhbGl6aW5nIHRoZSBk
ZXZpY2UsIHdoZW4gbV9jYW5fc3RhcnQgaXMNCmNhbGxlZCBhbmQgaW50ZXJydXB0cyBhcmUgZW5h
YmxlZCwgbV9jYW5faXNyIGlzIGNhbGxlZCBpbW1lZGlhdGVseSwNCndoaWNoIGRpc2FibGVzIGFs
bCBDQU4gaW50ZXJydXB0cyBhbmQgY2FsbHMgbmFwaV9zY2hlZHVsZS4NCg0KQmVjYXVzZSBuYXBp
X2VuYWJsZSBpc24ndCBjYWxsZWQgdW50aWwgbGF0ZXIgaW4gbV9jYW5fb3BlbiwgdGhlIGNhbGwg
dG8NCm5hcGlfc2NoZWR1bGUgbmV2ZXIgc2NoZWR1bGVzIHRoZSBtX2Nhbl9wb2xsIGNhbGxiYWNr
IGFuZCB0aGUgZGV2aWNlIGlzDQpsZWZ0IHdpdGggaW50ZXJydXB0cyBkaXNhYmxlZCBhbmQgY2Fu
J3QgcmVjZWl2ZSBhbnkgQ0FOIHBhY2tldHMgdW50aWwNCnJlYm9vdGVkLiBUaGlzIGNhbiBiZSB2
ZXJpZmllZCBieSBydW5uaW5nICJjYW5zZW5kIiBmcm9tIGFub3RoZXIgZGV2aWNlDQpiZWZvcmUg
c2V0dGluZyB0aGUgYml0cmF0ZSBhbmQgY2FsbGluZyAiaXAgbGluayBzZXQgdXAgY2FuMCIgb24g
dGhlIHRlc3QNCmRldmljZS4gQWRkaW5nIGRlYnVnIGxpbmVzIHRvIG1fY2FuX2lzciBzaG93cyBp
dCdzIGNhbGxlZCB3aXRoIGZsYWdzDQooSVJfRVAgfCBJUl9FVyB8IElSX0NSQ0UpLCB3aGljaCBj
YWxscyBtX2Nhbl9kaXNhYmxlX2FsbF9pbnRlcnJ1cHRzIGFuZA0KbmFwaV9zY2hlZHVsZSwgYW5k
IHRoZW4gbV9jYW5fcG9sbCBpcyBuZXZlciBjYWxsZWQuDQoNCk1vdmUgdGhlIGNhbGwgdG8gbmFw
aV9lbmFibGUgYWJvdmUgdGhlIGNhbGwgdG8gbV9jYW5fc3RhcnQgdG8gZW5hYmxlIGFueQ0KaW5p
dGlhbCBpbnRlcnJ1cHQgZmxhZ3MgdG8gYmUgaGFuZGxlZCBieSBtX2Nhbl9wb2xsIHNvIHRoYXQg
aW50ZXJydXB0cw0KYXJlIHJlZW5hYmxlZC4gQWRkIGEgY2FsbCB0byBuYXBpX2Rpc2FibGUgaW4g
dGhlIGVycm9yIGhhbmRsaW5nIHNlY3Rpb24NCm9mIG1fY2FuX29wZW4sIHRvIGhhbmRsZSB0aGUg
Y2FzZSB3aGVyZSBsYXRlciBmdW5jdGlvbnMgcmV0dXJuIGVycm9ycy4NCg0KQWxzbywgaW4gbV9j
YW5fY2xvc2UsIG1vdmUgdGhlIGNhbGwgdG8gbmFwaV9kaXNhYmxlIGJlbG93IHRoZSBjYWxsIHRv
DQptX2Nhbl9zdG9wIHRvIGVuc3VyZSBhbGwgaW50ZXJydXB0cyBhcmUgaGFuZGxlZCB3aGVuIGJy
aW5naW5nIGRvd24gdGhlDQpkZXZpY2UuIFRoaXMgcmFjZSBjb25kaXRpb24gaXMgbXVjaCBsZXNz
IGxpa2VseSB0byBvY2N1ci4NCg0KV2hpbGUgdGVzdGluZywgSSBub3RpY2VkIHRoYXQgSVJfVFNX
ICh0aW1lc3RhbXAgd3JhcGFyb3VuZCkgZmlyZXMgYXQNCmFib3V0IDEgSHosIGJ1dCB0aGUgZHJp
dmVyIGRvZXNuJ3QgY2FyZSBhYm91dCBpdC4gQWRkIGl0IHRvIHRoZSBsaXN0IG9mDQppbnRlcnJ1
cHRzIHRvIGRpc2FibGUgaW4gbV9jYW5fY2hpcF9jb25maWcgdG8gcmVkdWNlIHVubmVlZGVkIHdh
a2V1cHMuDQoNClRlc3RlZCBvbiBhIE1pY3JvY2hpcCBTQU1BN0c1NCBNUFUuIFRoZSBmaXggc2hv
dWxkIGJlIGFwcGxpY2FibGUgdG8gYW55DQpTb0Mgd2l0aCBhIEJvc2NoIE1fQ0FOIGNvbnRyb2xs
ZXIuDQotLS0NCiBkcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYyB8IDE5ICsrKysrKysrKysr
Ky0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jIGIvZHJpdmVy
cy9uZXQvY2FuL21fY2FuL21fY2FuLmMNCmluZGV4IDAxMmMzZDIyYjAxZC4uNGNlZDgzMGY1ZWNl
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2FuLmMNCisrKyBiL2RyaXZl
cnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jDQpAQCAtMTQzNCw3ICsxNDM0LDggQEAgc3RhdGljIGlu
dCBtX2Nhbl9jaGlwX2NvbmZpZyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KIA0KIAkvKiBEaXNh
YmxlIHVudXNlZCBpbnRlcnJ1cHRzICovDQogCWludGVycnVwdHMgJj0gfihJUl9BUkEgfCBJUl9F
TE8gfCBJUl9EUlggfCBJUl9URUZGIHwgSVJfVEZFIHwgSVJfVENGIHwNCi0JCQlJUl9IUE0gfCBJ
Ul9SRjFGIHwgSVJfUkYxVyB8IElSX1JGMU4gfCBJUl9SRjBGKTsNCisJCQlJUl9IUE0gfCBJUl9S
RjFGIHwgSVJfUkYxVyB8IElSX1JGMU4gfCBJUl9SRjBGIHwNCisJCQlJUl9UU1cpOw0KIA0KIAll
cnIgPSBtX2Nhbl9jb25maWdfZW5hYmxlKGNkZXYpOw0KIAlpZiAoZXJyKQ0KQEAgLTE3NjMsMTMg
KzE3NjQsMTQgQEAgc3RhdGljIGludCBtX2Nhbl9jbG9zZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
KQ0KIA0KIAluZXRpZl9zdG9wX3F1ZXVlKGRldik7DQogDQotCWlmICghY2Rldi0+aXNfcGVyaXBo
ZXJhbCkNCi0JCW5hcGlfZGlzYWJsZSgmY2Rldi0+bmFwaSk7DQotDQogCW1fY2FuX3N0b3AoZGV2
KTsNCiAJbV9jYW5fY2xrX3N0b3AoY2Rldik7DQogCWZyZWVfaXJxKGRldi0+aXJxLCBkZXYpOw0K
IA0KKwkvKiBkaXNhYmxlIE5BUEkgYWZ0ZXIgZGlzYWJsaW5nIGludGVycnVwdHMgKi8NCisJaWYg
KCFjZGV2LT5pc19wZXJpcGhlcmFsKQ0KKwkJbmFwaV9kaXNhYmxlKCZjZGV2LT5uYXBpKTsNCisN
CiAJbV9jYW5fY2xlYW4oZGV2KTsNCiANCiAJaWYgKGNkZXYtPmlzX3BlcmlwaGVyYWwpIHsNCkBA
IC0yMDMxLDYgKzIwMzMsMTAgQEAgc3RhdGljIGludCBtX2Nhbl9vcGVuKHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYpDQogCWlmIChjZGV2LT5pc19wZXJpcGhlcmFsKQ0KIAkJY2FuX3J4X29mZmxvYWRf
ZW5hYmxlKCZjZGV2LT5vZmZsb2FkKTsNCiANCisJLyogZW5hYmxlIE5BUEkgYmVmb3JlIGVuYWJs
aW5nIGludGVycnVwdHMgKi8NCisJaWYgKCFjZGV2LT5pc19wZXJpcGhlcmFsKQ0KKwkJbmFwaV9l
bmFibGUoJmNkZXYtPm5hcGkpOw0KKw0KIAkvKiByZWdpc3RlciBpbnRlcnJ1cHQgaGFuZGxlciAq
Lw0KIAlpZiAoY2Rldi0+aXNfcGVyaXBoZXJhbCkgew0KIAkJY2Rldi0+dHhfd3EgPSBhbGxvY19v
cmRlcmVkX3dvcmtxdWV1ZSgibWNhbl93cSIsDQpAQCAtMjA2Myw5ICsyMDY5LDYgQEAgc3RhdGlj
IGludCBtX2Nhbl9vcGVuKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpDQogCWlmIChlcnIpDQogCQln
b3RvIGV4aXRfc3RhcnRfZmFpbDsNCiANCi0JaWYgKCFjZGV2LT5pc19wZXJpcGhlcmFsKQ0KLQkJ
bmFwaV9lbmFibGUoJmNkZXYtPm5hcGkpOw0KLQ0KIAluZXRpZl9zdGFydF9xdWV1ZShkZXYpOw0K
IA0KIAlyZXR1cm4gMDsNCkBAIC0yMDc3LDYgKzIwODAsOCBAQCBzdGF0aWMgaW50IG1fY2FuX29w
ZW4oc3RydWN0IG5ldF9kZXZpY2UgKmRldikNCiAJaWYgKGNkZXYtPmlzX3BlcmlwaGVyYWwpDQog
CQlkZXN0cm95X3dvcmtxdWV1ZShjZGV2LT50eF93cSk7DQogb3V0X3dxX2ZhaWw6DQorCWlmICgh
Y2Rldi0+aXNfcGVyaXBoZXJhbCkNCisJCW5hcGlfZGlzYWJsZSgmY2Rldi0+bmFwaSk7DQogCWlm
IChjZGV2LT5pc19wZXJpcGhlcmFsKQ0KIAkJY2FuX3J4X29mZmxvYWRfZGlzYWJsZSgmY2Rldi0+
b2ZmbG9hZCk7DQogCWNsb3NlX2NhbmRldihkZXYpOw0KLS0gDQoyLjM0LjENCg0KQmVzdCBSZWdh
cmRzLA0KSmFrZSBIYW1ieQ0KDQo=

