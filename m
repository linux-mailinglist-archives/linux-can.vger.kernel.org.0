Return-Path: <linux-can+bounces-2280-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6343E9DE867
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 15:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13AB91639B0
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8063D288B1;
	Fri, 29 Nov 2024 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="snrWNQ97"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268424C9D;
	Fri, 29 Nov 2024 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732890354; cv=fail; b=jRqLrTX+BPG+gZC1X++SQGEKithqIdgcOdg0M5MReZv7lCHBLauKT5Q1XH4rWNaTEBt9Kj+ZyFt1x9ufBh80Igehn2GO02o2yU6OY31/awqc9o47tnzJtiC+dUOutNwpHx6Tr57Ta/OVhE2ZHvdD0d+ffMZU7AumWAXY3tIEAmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732890354; c=relaxed/simple;
	bh=edFd+inA9dcicpBf664xI6coZ274eru4iAfozGXpGew=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ffhDPRxPJS/iJhA/LRWvGsJEcupGfgTPOudZVNhnmbNse/Oh+N2jNgRJVBCpdxIr8mB4P/LQMD/bJggljKFOUYpZX+7a2K8w6mmm7HRBubRhQ3lrMGVXOYLzC7wjjSLB61LSA0/M7XgIcjNfVjl/DWXyw7KXWCqi2kmiNyTjvJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=snrWNQ97; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe8qtTtZTHv+icx+YvW6T54/tye4kEIIQdDKZAx+U0Ner0unWPPHG/jMVtFeKbNt6tD0efVXLWFIaOJeMMKKIIrA+nWSNIjSGsdIttATtyaMWi8WIRK4YQkPI1ahEySO5TkjF+ODD/U+cYZLE/hv1TD0mGDF2ezTgVJTLmZ0APLtpLHNzsLHaLvS04zDLSNlhbEkWO5q4ZUIh+NqR91pxPyPUve/d2XEvjYMXc4egLA/ryVLvJuOuOs3cKleKaPxkGTLAZ+kKTXIyZCsVf/zKMM3+xGKLy3rHD4lGB5BTXhoeX4hQDKfqcBvWOhL9wHFb5gvNMbdA2Di6CxQGdy5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfK7MOBypUQRjC5Mph936WPO5FksmWIk+RONz9vihjw=;
 b=p9XuOWysl5Vcntrzb4Qh51bfNzSRNeL0o0wfv4VVz4uUvoUEE1db43UOujIXU9dwLueOAd6+15hCZ78qrZm4C0OIhzp/0Ek7EN9zt0NSXu7NLJDLGu7hxk7jdH9nHVHhyiOeXhwuMMhVTP5bzhBZ+DqnCWKLQPRkNr4cRsaYWdobIlKCZo5Dm0V22h2ebB2mOHpw8kBfmgVxthc+iAAMZ/3xh7t73c+2uNQOLS7L5oroFz9Mv6+TbwrzQWXftDO0Tz8voHvhQ4/4M6gRO09EyKGRyvdrN75qGHB/158Tg9jm51D1uFXV8UK9cajlmIrzVoP1XlvUUKHYBAwi7/lXKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfK7MOBypUQRjC5Mph936WPO5FksmWIk+RONz9vihjw=;
 b=snrWNQ9748aqxnykBaiJw+poVeEh0htF81uHVeaFkDic0WNH48RtFsJ6QSDS0uqf9IAeHjJCysW4qtqKK8OY+NHWUS0hgHEL2EyMG+deRLQ5ZJMxKEk3QFHb1YrOt2pHC3cuah4BnGTe1ZHR38wiitgbyFk1DYeu1TN2xoOno6CuPAJ+meOCI9HPxbbTk6Q7KNiggo6SHYkoXnVstzMu1WLy4bGr+rOU7/V4HlyT6zPTdeB2WNkJlKmEqRqOK6g5J24eEIthE1N/M3Cd98XERdZzRPOhh8YLAQt7lMPK9eLUtapZ4dqXdqJxmndpfbkPusUPDO0M/XIzpdHI/JtYKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8810.eurprd04.prod.outlook.com (2603:10a6:20b:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 14:25:48 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 14:25:48 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v3 0/3] add FlexCAN support for S32G2/S32G3 SoCs
Date: Fri, 29 Nov 2024 16:25:32 +0200
Message-ID: <20241129142535.1171249-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0025.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::15) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: c0687aab-1ad0-40b3-b95e-08dd1081b841
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHpvYStlYXNkMkliQmJmWVRUWGt6eEZYT2xQaHZGblNaQkZkR2hvazdEUERq?=
 =?utf-8?B?WXYwVFE1azJ3UWYweFovZDErRWw1ZE1JdStSWUg2ZUU5cCsySEZpMlU5dy85?=
 =?utf-8?B?VWN6ZVd6RzNsKzJMZE1CMnRKQS9jZW96VDE4TFozVGhPZlg2eFFtR1JJaTVp?=
 =?utf-8?B?azdtSGNwd2ZpWU93V3dnZWs3OXdRbUp0WlRFREh3N3RNakF2c2xjTk9wUEhE?=
 =?utf-8?B?aWVkazhHOVcxS2Eyb0tjSnlrWUtxT0FPMnNwaXNxQi95cldRc0RXVjBpUWtP?=
 =?utf-8?B?VVhrUElSS3RtUDIyNGJCQUUrdzdhdkp5UjNvRVpWbExyRDZ1YXNEZmFkZHFF?=
 =?utf-8?B?NU53dHFSNjBsRkszRS9IV0k3dm9SL1dRQ3BkRzJWWWZQUjR6dCtObHRSRmVl?=
 =?utf-8?B?Z1pHM1d0a2h6a2h2NzQ5K2JOaVM0Mmt4SHRrTWdBY29qcm1zT0FQNWVXTFJZ?=
 =?utf-8?B?aHk0c09wT2MwbEw4Q0k5SDI5Z1FsRXkyMngybmErbXNlSHd1V0JGMGxLaWVR?=
 =?utf-8?B?djhjRWRXQXBudGNFMjRCT1hBSFkrbkp6NDljNzhCbytER1pTakV3dkFIYzlI?=
 =?utf-8?B?MW1OUC9XbVpQZmhDZFhoczlRVXVkNTRkaFpBY0NjSVU2ODA5MisrRTZCSWVy?=
 =?utf-8?B?Q3lGNmNQZGJmVU1icFRBU0FWMG5NOVVvcm1tQUdXNVJBc3k4bW12ZC9NMm1a?=
 =?utf-8?B?MzlVaGsxOG9rQllEK2UvM2RlWS9VcHFuZ3NGcm5xeHl5dGJwelVkd0tIYzdi?=
 =?utf-8?B?TUw5VllMY2VmbFdMSk1KWDYxYnhVUzlWYjVWZ1FyNGFDWjFkU255RkxDZ25Y?=
 =?utf-8?B?dUtneWFUMGhoYlowTmx1aTRuNmRvL0lnRG9TdFRNMkFiZTlUUHVvN3d1KzJI?=
 =?utf-8?B?c0NIUUpub1VVSG1KUDYwSS9DaVUwL3U2bURzWjVHQm5PbDJ3SmpzOGJjSGVv?=
 =?utf-8?B?TUI4WU1Ccm5ObVBGM2VnU25GTU1tZjlFc09OUE4zM3V5alFaa0lvQzcyZzRG?=
 =?utf-8?B?QXphZ0lLRTU2SmE2cHo1MWl6N2RUNHBSMGZFZmRTcWhnenpkWkRNTFZYdVJS?=
 =?utf-8?B?bFp2dXZ4dHFMWmk3ci9aWFZ4WGQyQ2kwR3kyejhHVXh4eUhscm5acVpkaklU?=
 =?utf-8?B?Y1dVNUxxVjNobncybEQxZW8waUowcTRTWWZ1WGVMclpIU3IwTnR4eDNJVTZv?=
 =?utf-8?B?a2U5OW5qN1NOaG5mUnpDV1BLZDNYZ3RkRGZub1BEaEcxQ2hkYjQwdXJBZFBi?=
 =?utf-8?B?WXBxL1owNkxSSlg0a3lkQjhKQTBObWZLRUthdnhoVFZ0UWg4OWV4eGdUUjh2?=
 =?utf-8?B?TEM2TVhXb21VR2F0VTlYUTZDakZJVzFrc2lLNVZuTGNZL2ZBQlliNm1COXlW?=
 =?utf-8?B?Z1pCa0Q3S1U5ODFvdnNPUDlta0plcW9kRXRWQVlEUDlzWWxlM09NWVJZSmYr?=
 =?utf-8?B?WDF6VFM0TE90UEYrQzU1U3VVdWQwM2g0R1MybTZpM20vSlRhT2ZrWnBiNWUy?=
 =?utf-8?B?T2FjbWZweFBSQ3BiVU82Q1FtRnhYWFQvR1dacDFGQ0ZWUWhYazhqWXlCZkdE?=
 =?utf-8?B?RU45MVQzbW00Z1NrMHRhaWxmR1oyeHpoRXNyc1BTSUFzWkJMa0E4VGN1VFpV?=
 =?utf-8?B?eEJtQ2dBbFFqYzM4dkQ4bDB0VUs3WHhhbzJSeHAzakJwcnM4UTJaZkdjLzZE?=
 =?utf-8?B?NDR3cjBzKy9kc3hGZTg2WXI5bjFHY2ZDTHNmVm9jdjhCWVVMOG43N0tTMDkv?=
 =?utf-8?B?VkNsYkJ4YTQzUlFYeng5SEticnJFUTVjdWx3bTYvWHNnNHFzaDg0WnhvcDhB?=
 =?utf-8?B?SUk1VURqUVcrVzBpQUMvUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnVtZ0hIZXBQM2ZsOGRnbnFhWHEzUnJkQVhFZXpIME1CZFpRaFdlaEhLZStO?=
 =?utf-8?B?a1VCaG9KTnhUaS9uR28wc3NpNWNGdVdNSzgxaFV2bkpueE92cGF3NWhESjdL?=
 =?utf-8?B?S2QxaU1aT3NrYkNLbHlpTE9oRW11ZlFRcVJtdW9nUDQwcXhLRVp5ZU12LzVE?=
 =?utf-8?B?QmJTMllJT3BWbTJVOHdmSUw3a2E5YWVNRkMzWEJlTTZTd0lHbndUd1RPc2Mx?=
 =?utf-8?B?STdpZUdkWTluQktlVUt3NlNZUG12S1NvNEwveGpua2VpeUNDMTVhZGxHMzdm?=
 =?utf-8?B?WTBTYTJTUzFoeU1pWnZGbXFnbDJwNmI0MHVJQUlkV3dpYXVVSldIZzFwc3Nh?=
 =?utf-8?B?VEw2K2lhclhRZ2FRY3RKK3NjUlNKVW1pZ2tNNGJtZGVIOU5EamdCVGZwRXRU?=
 =?utf-8?B?S1JvbFZXWU1pZVUvMDZUZ1hDU29tVUxvdU1CUkVMT3lUb0hQZDV2Y1V3aWxv?=
 =?utf-8?B?dXJxZXpzYndwUGNROHg3dERmaWtqV0JHTzJ3Y2hpOERvWGlkb3U4N3VidVZG?=
 =?utf-8?B?cmJxamVubWx6MU5NZXdOZ3pvK205M1ZramxrQ2ZYOXRQVFBUdzU3TkxpQnVi?=
 =?utf-8?B?UDFJeCtndGZwTlQ3TXFobDUyc2k1RVJBM0N2OTdSWTRxRENoc3UxV09MZS9m?=
 =?utf-8?B?Q3FwbTUzaWlSeFM2dUxaMWdjVzIyUmxDMnlVNjZlWUxBL0xaNlAvbDM3Qlg2?=
 =?utf-8?B?NUVBZVJ0L1RLVDJDQlZPV1dEODhHVTlJNG9qaHlsaHlWOW0rSCtDR2tNV24r?=
 =?utf-8?B?bTRnRmpjUThGUm1ubmNiSkdXeVRZNTRPZTNzVW5xOEx3S1pES0FXNlpoZU94?=
 =?utf-8?B?QkVreko3aGlhemMrTnBOVUdpbm1PZjlhUUkrUk9qWnp4dTFaL09vcWJYRFVX?=
 =?utf-8?B?cFpOZmx0UDcvL2d1QnVMSC8vZjlFRVlFN3JPSmFwL0VIUTF3WFBPSnpLa3E1?=
 =?utf-8?B?Tys5VWYvVkdWSTdpSlZ5Vlp1Q0RPeUFKMU9SVnFDNUE0WlYzT2JlOU9lS3RY?=
 =?utf-8?B?Z3FEUHhnN2ZOQUo2U0hiNGhibXJNc0F6a3BvMzQ2RnVaZTUrUHg5OUdNSmtQ?=
 =?utf-8?B?b3V0NEdBU05KcGE2V0ZTUURhdzZIWWgrazZBWDdNaWpBY0h6M3grZFE0dmZY?=
 =?utf-8?B?NGZldDBqU0JlNmk5RVhmaFNxa0ZMRnk3SkMyc1hMZ1hsNzk2TUJKVDZndDZh?=
 =?utf-8?B?UVV3QVVyemNuS2NuUjd5bkJpQ2ZxTjZqRkk2YzMwMTVmbXlyUXZFS1R3c0tx?=
 =?utf-8?B?cWs2T01HQTlMV0VHMHhXZVF4eWQ2dkhaaDVZckg0bTNiOXlFQ21ick5STWlh?=
 =?utf-8?B?eTliTm1BcURBTE5SMnZ2K3h5dExPcVRPWXhPZy9tdUxEd0VOc05EbWZ1Z2dw?=
 =?utf-8?B?aWR6TCtPbWpVa20yM1BFRldPTjU0ZVlTVGg1bjdFeXdjRE1rOHNHaGdtemhD?=
 =?utf-8?B?MVAwVmhRRXdZdDRUU0tTRlNDNEtPWkFnSWNmVGVKdDQyWGIvcWtGakF5akxI?=
 =?utf-8?B?MXRSaGNjeGNXdGkyYWNtQU8yeVlwbkpPWm41NHlydlZJdStDWTZRdVdGNkxy?=
 =?utf-8?B?V3RQVkw3TE1MVlVGSkVGa2EwVE9EaGxDdXNVaE1Kd3RYcVV1dmRoTlBFTWE3?=
 =?utf-8?B?MUw3T2JhdmplcEV2Y0tndDA2VWpUUWpxUkdUQ0I5K2VHR0twV2I2b2tRNFVD?=
 =?utf-8?B?OFBQQTMvdGlmWDEzZEJZbHc3Vm4vc1A3ZzQ5TEhJRnBtOXBuT1BuTXR4WGxU?=
 =?utf-8?B?d0pUR2VsVEVKemVqQUFWaDZJczYrTG9aQ20zbnN1UHNlaFA3U29KSEFHVDRl?=
 =?utf-8?B?dzdGbFpNb0lyZEJIQjNCQzU2dFZtTTM3SXhUTERZZS9RdnhSTWdBV0NkNTQx?=
 =?utf-8?B?TktMZ0lUNFVBb3FRVW5vdXJHR1JTaUVmS0tHNC93ZjUzVlFuU2IvZEtQMmg2?=
 =?utf-8?B?VVE4cVJFMjN3YWwxc0VtbXJyQTZaOEhZNmpxOWVkaS95em43VTVXNExMRkNq?=
 =?utf-8?B?N1ZxL0g0ajl3M2hsanUwaU5NQXV2YUVWTE1rZ21LS0RpdE1lZzlDSnlmV0lC?=
 =?utf-8?B?UGE4QWZFSHgzSTFnM2dEN3lhN0ZVdUpkeUlzYWxrdjA1dzZwL3FESUwxOWV1?=
 =?utf-8?B?bWxJdmNwamFVbjVLT3ZBOUYvZDBZOW1RODB1UW1tQUJLWmkvRUlRUmJCTEJa?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0687aab-1ad0-40b3-b95e-08dd1081b841
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 14:25:48.6524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBc5O/JAFJyEoTc1WsBX6tdqKHJEfm4iZxMxLg/nYCcXvWuwAYuAihGHIPzLVmbkFjNzpap+VkTXvAlNoAdxjTOGi2TUycCLs+xhR1/IEVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8810

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

S32G2 and S32G3 SoCs share the FlexCAN module with i.MX SoCs, with some
hardware integration particularities.

Main difference covered by this patchset relates to interrupt management.
On S32G2/S32G3 SoC, there are separate interrupts for state change, bus
errors, MBs 0-7 and MBs 8-127 respectively.

Changes in V3:
- Added Vincent Mailhol's Reviewed-by tag on the second patch
- Changed to 'platform_get_irq_byname' for second range of mailboxes
- Made several rephasing in bindings doc
- Removed Frank Li's Reviewed-by tags since changes were made afterwards.

Changes in V2:
- Separated 'FLEXCAN_QUIRK_NR_IRQ_3' quirk addition from S32G SoC Flexcan
  support.
- Provided more information in dt-bindings documentation with respect to
  FlexCAN module integration on S32G SoCs.
- Fixed and irq resource freeing management issue.

Ciprian Marian Costea (3):
  dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
  can: flexcan: Add quirk to handle separate interrupt lines for
    mailboxes
  can: flexcan: add NXP S32G2/S32G3 SoC support

 .../bindings/net/can/fsl,flexcan.yaml         | 46 +++++++++++++++++--
 drivers/net/can/flexcan/flexcan-core.c        | 35 +++++++++++++-
 drivers/net/can/flexcan/flexcan.h             |  5 ++
 3 files changed, 81 insertions(+), 5 deletions(-)

-- 
2.45.2


