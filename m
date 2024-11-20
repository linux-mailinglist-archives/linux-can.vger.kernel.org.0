Return-Path: <linux-can+bounces-2132-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCB59D3833
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 11:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC60B21D81
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A42198E91;
	Wed, 20 Nov 2024 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ooX9DeXx"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0442F198E69;
	Wed, 20 Nov 2024 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732097896; cv=fail; b=eb843WqRCj5pwCOZtOo6SygAeKKflS+aKKNatwqHq7XFwgTOFCXYZxBdVpjOr2CMnlAfaGZojeAqHTcomHgaM9fLxivxfAN8IoUe8hm+k9rNuG5OyFOt8VGyQmsbQTl5YEAlf8qvW3pr+kwFFtoqzrzHGjfG2pg4qBixLKxXgro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732097896; c=relaxed/simple;
	bh=JYL6msFy9I/fgkAoS/gVl2L+BbJpXfXw/NbJs4ViotU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GqO38FtTiIl/qVwgiBx62wjWQc2vL9/iWCdv/gBfvQRUTIsQYb6xPttaiAI/s6G0SCxjWAEi+KYwzg3RTYJH7PvgpNM2fn9ZZWtAuyQHZbO+RsOAqCRhoknqWuwkuXFvysj11DpnjNEg/rtAzZl3zyVzItdn3dkzMtbcKigvFvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ooX9DeXx; arc=fail smtp.client-ip=40.107.162.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLtSrU4XQiZNK52tDw4bo4/91ipCwiDQrKaB6ACSbScC/Ny8/zPyuCOrEjXyc/OGqqmeCdoNDfc2rQiF+Okceggw13ntwUAlfmtTgnvRugjA0CWiMieVOHLWj5xYDszt4qAFUOhTyNG2ZnyyWb5q2ju9nPRk/0XGzDq9NZnp2VtTp/3XLXXlR35c6z09rgmL1NMSQrwONJl0/VPD01+IKWus4/97SuW5QoXVkPe7oEV3kT+VAwPbpasEC7IMIcX/AQ4HXwiy7chHJQ8yDlv926bl2K4GlXuhNYb6LM0SAD/44BVa78jxvpH3DQsS+O+nfAKhf0CRRelnQ9zHT0IFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Gskv8tqWYr1ReNW3WVSjjlPMsKdfOF3gSUZOlAPYSg=;
 b=qFlv5YuVeM6FYYDuyseJVnAeWWFNyxaoEHCGccvUDIxCbFAj0MaEgeSoB/kpX0Y3JO/ZDJdikSW7E4Zt4NfhbX4rEJEdLab9801n+ypIdO9rkc3MmualgmYkiiwxc6MZGOZ4+kjPdb4HN9MVerTTZ0uLh5vh+DXoUoMb99CP/l1eVvVX//CHp4IFlq4Wn0jmJrOjvo/NH2xlQZ9G9TFLW0Wj9fMv4UX9yb74WMl38sZRJKp2CRBzC8bjTtO6u54rulq9FxSw7tr1IyLdARa/jhbCmmr0Fb7xNOHtNNtU4egIvARY2pBNhqSvg8euoEy3txeicpJegO66sNrSY79cnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gskv8tqWYr1ReNW3WVSjjlPMsKdfOF3gSUZOlAPYSg=;
 b=ooX9DeXxXULBgnQm1aRtblRnCfVt5A3/5DTakHBEjliR1yhzVjM+H8MKbhbMO8TRkDniAZ9hHdfxXObToPsN66fPqVrQdGOaR8BB5JXKU9L406CBirtayrNfupBwA2m0XzTZAvH9gjEhukLBRFnTIVPcIshIlzlRRzPk3PYr6XgTE+R5KKXzL3x/2S3ICYXHkmOp8wfVABHF8ZW/Xu/aLzpTRrqg1HAcpe0xafTsWOYMyRUxxxZAT2aGvI6YlpbmwJp/HT3ldNl+sXcfesOAFkI28Xf2FMJkC+6xK3O5EkLpCTVbb1aFfzp3/K9gCUkslcOmHREgT6ulqziksO4SvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS8PR04MB9094.eurprd04.prod.outlook.com (2603:10a6:20b:445::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 10:18:08 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 10:18:08 +0000
Message-ID: <aa73f763-44bc-4e59-ad4a-ccaedaeaf1e8@oss.nxp.com>
Date: Wed, 20 Nov 2024 12:18:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] can: flexcan: handle S32G2/S32G3 separate interrupt
 lines
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 NXP Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>
References: <20241119081053.4175940-1-ciprianmarian.costea@oss.nxp.com>
 <20241119081053.4175940-4-ciprianmarian.costea@oss.nxp.com>
 <20241120-magnificent-accelerated-robin-70e7ef-mkl@pengutronix.de>
 <c9d8ff57-730f-40d9-887e-d11aba87c4b5@oss.nxp.com>
 <20241120-venomous-skilled-rottweiler-622b36-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241120-venomous-skilled-rottweiler-622b36-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::20) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS8PR04MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: 84825a0d-a42f-4ae7-b093-08dd094ca11a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkNVYWQyRDRQdTZEQjBDVXIzZitMSXhUV0dFYlBXQ2NyMTRXdE5kcWNTZVNB?=
 =?utf-8?B?bzhpYjRocUNhQ3hYUGJuVXFlQXloYkFoL3E0NHJZblJjR0tSUzZsYTRsT3NG?=
 =?utf-8?B?d1hEREZ5a0VaMTgxZFBkWlZZaERuaDRxU3FxMTA4aEZyS1BrZ1YzZ2JQSXpn?=
 =?utf-8?B?blRTWExnTmFDaU84cis4UkU2VHN2TTZmbFUxQlFXeUhtb3JzODZzZmJ5NnhE?=
 =?utf-8?B?czNGek1RTzZhVnJPNnRFWndJNmpXeDhLeUZHbzBoNEFhUCtSejhVa1ZuSndG?=
 =?utf-8?B?QWRWSmFqL2RlZHdVa0tUNXpQOHhUL2pVUEtxWnN6OS9jR1Z3eEhLOXk3OU16?=
 =?utf-8?B?eHFEZXJHR2xNN3BxZ3lXMmFQdW9HZHRpdUpqc0hvQlM1ek80dEJKZWo0SGVu?=
 =?utf-8?B?YU4rRG1hTE84TFJKM3BwVWN1eW5MbUt2dFVWK0ttd1BIVzFneTRwWTk3M1h0?=
 =?utf-8?B?R20wWmlUVmR2RXU3QUZrMHRKN0Zlb3ZIbXNvTlZ6S3VnQXBFUFdRSW54bGxN?=
 =?utf-8?B?WmZtK3k4R3hqZlkwcEVSdm1DMjBpWTRzR1IwcHVDdWRjcUFYdnN0anRvOTFG?=
 =?utf-8?B?ZVhLUHIvYnpDVk9XZjdKdkhzNEtWOHJUYjBwN0YyY2V0ZTdTYU1nL3AxSjJW?=
 =?utf-8?B?bmUzZDlMQWZoeEJJNE81K3hMOU5hQUJrNk5hVjJDSUdUSzA0aGR5SGhHR2Fs?=
 =?utf-8?B?UEhVUUJwQ1F6Wi9pZHJOR3FlRW93VDQ0SmVEVlRDcjUzWjV1dlJod1BRdmZy?=
 =?utf-8?B?OFFZR0tHc0tLaTBvNmJBamVnN3BYYm95QXdGNmJiamFrV21Mc1FRNUlPMXBJ?=
 =?utf-8?B?VlRKMEVQakd0VStmLy9VUElVczNSUDliVWp6aXRmaUYycDdOMXJKZmJhMHlo?=
 =?utf-8?B?TC92OTRBMWVNRUVGWnBpYVFlcVZIdVRmQ2R2NjdIWmthYUFZaDE2cGpKa0Ux?=
 =?utf-8?B?Z0F2ektvcVlmWTJwdGlEdDZjSTNpRDFOWUdvaUhLUzg2bkhsNDVqYjBlQVhT?=
 =?utf-8?B?Q1hKbzc5eUdQTGNIYnZ0RWFML2tad1R5QjNHUHNOZS8zUk5GYlhBRk1VbElT?=
 =?utf-8?B?anRPTlpxYVZ2cmlIYWFlQ3NNeVFtWURDZkRiVExxQ1JjNGJ2RWYwUUJXVSs1?=
 =?utf-8?B?MTVwUFErU0ZFSnZYVVptYm82dGZ2RTBEOGtUVUxvbUM1ZytyZ3E3V29hZ05h?=
 =?utf-8?B?dEhjaVlZekVXSXAzTmE5bkNlTndhT1JucEwyTzdpcittOTZnZ3M5MXJLRnNs?=
 =?utf-8?B?WW5pUHJjdTBQbDB4NG9rQmw1VWNTakpnY1gxMkk3YVdNNHQ4Zjg1UGVMUmph?=
 =?utf-8?B?M29JV0EwektjZ29pVStyRFBsUkJVZmlpZ0E4M1ZNU0M0RDlDZXNwaytSa2Mx?=
 =?utf-8?B?bFEyQmo5L2FKeWVRZTVmdWF3N05nUmp4UDV4aHkrTDAwUk8xMW9aSE12RjRZ?=
 =?utf-8?B?SU55VmJsK0V3anNKVjFpenFVNUFnSmxCR2dHWnFnMUNWdEU0YVRZRDc1cWcx?=
 =?utf-8?B?U2c0RTVuelVBQ1VHVjlTdEtIbDJqRWx6aE9FSU1RM2JXK3kzQTlFMGNaUE5Z?=
 =?utf-8?B?NlZuQjZ6b0xuT1RzZDdtWWJlSC91bzFOMkJMRUxRSUtXcE1rNExUeUt3a29s?=
 =?utf-8?B?Y0dhK2hOdmI1Z0xHVXhYUy92T3NjMnZ3eWxGcHVQMmtsdGl5djZkazVkUzVx?=
 =?utf-8?B?THB5WWNYeGZEZWNPcnNKRUNXZ0liNUgrc2dGUVJFbHR1SVhDU3ZHbEtEMWFE?=
 =?utf-8?Q?1M7bvOjrVljF0plbLS8nNV7aST2LP2p06vqFwcs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnlsLzdhQU5Fd0tLVUVyelMvTHc5bm5ydFRYTXZ2c1RZYW5sQ3YvQmsxTFhM?=
 =?utf-8?B?dTdiaUFIclFhem9KN002R2wxRmxRelpaUDhGK3RjR0Q2MlZQRTF1Q2tOY29P?=
 =?utf-8?B?QjdIdnFKUEU1TkNZbWpFeGV3YlhtN0ZqYzF4TnU2RVhkNldFZ0Q2aTZzd3Vw?=
 =?utf-8?B?bjRXMW5TNHMrbFpNejM4aE1iaHVJaHBSZm9SU2tWVjJnTlBSSWFlZUM2a2E2?=
 =?utf-8?B?d2t0OWpRdENlUWtxK2YyS25BWG42UnNHbUpOSDA5Qzh5UiticllxbGhpWmlw?=
 =?utf-8?B?d3pNNWEycFFJM0lUYlFJUFAvQWFtTTAyUXU1eU5RRXpMMEh1N3RxcmtnYVJv?=
 =?utf-8?B?Vm40MmR6WnJDenYvMGRjRGo4NjdFcm16YzArVnZ5ZUgwZkcyeUxWYVRQaGxU?=
 =?utf-8?B?cys5ZmttZjVFMGw1VFBPb2FuTFlYNjcvV3lxL2IyOVdQMnhtU0ZnTmplbG11?=
 =?utf-8?B?WjR3QUNsdEpWOFkyN3J3S2Z3S0lXVExCM3ZObnJkOWd3UUZHMDNNUDVYeDdT?=
 =?utf-8?B?YTNpZ2s3M1RLZXBGR3JKSmtPTXJZVnZKS1YwZVJESURYOUYvOWgwNENPVXZn?=
 =?utf-8?B?UzF3Y0tld0xEbmxWL3BFTU1UQTgvd1JvUzllRWNlT2VzNkREbUlaSEJFRGxh?=
 =?utf-8?B?SWVCSVZ1b0YzNVlqM2hJRDYzZkthaFpyVlo1cnhGdG9xbVlJbFJrMFhvdzZo?=
 =?utf-8?B?QzcvS0hYZWQxOFFqOFlvVkNhNlIyM3RNK3ZzYUZNWksreHlHWFpibEpqaGVP?=
 =?utf-8?B?d0loSW9KWDNZUkJxWXZoaFVDMjh4N2xnaVI2SkZacEVJUHdHQzB4WHUwSDMw?=
 =?utf-8?B?bzlCTnhNaEM2cGtDSlVycFZxOTdOVjVjNVNXY1Znc3loRlZURzFiMmVjUE5w?=
 =?utf-8?B?ME84dWFKOFhVOVdaS0VLWEdpeUpQM1F0cGVZNm5SS1lrdXBVQ2pwQWUyL0ZZ?=
 =?utf-8?B?bFNOYWlQOFBaYXUzd3kwMysxS3FGaFdyamNCM3dYcEgyMHZwLzZkWFN1VW1D?=
 =?utf-8?B?K3ZlM2RRVkFwaFBHaExzV3lKU2w3bExmV2pwNXNmbnY4Yk5rUUlrbkZyRU9G?=
 =?utf-8?B?NmRwUHRDQmxvVzRVTTZFclJGMjJ1cFNrOEl1eEdIU2J1UWVlbVo4M0tlZTFU?=
 =?utf-8?B?SDVxakJ1U0pnSi9NOHFGOWZpZkdUcUVpdmdoeEZkWDdRajJJY0wwZ1pJMHUw?=
 =?utf-8?B?aXBwcDliR2hjaExEdXRxY05JOVgxVXNhRkJWaWdFZExEalUzTXd1NldSWDRQ?=
 =?utf-8?B?eWNJaXFodDdEV3lDaFBRa2N3eU53dEtUb3l5Y25EM0wzYXJUY205bHdBOFRS?=
 =?utf-8?B?M0I5UVlCVC93b2FqZjhrSCsrdUdGYk56ejdibStUK0cvOTcvQ1d2ZGFBTkMv?=
 =?utf-8?B?ZXZCY0orV0RlMmszUTk4K2lwOHVVbGw2RUxnV0hQRUU4cGR4WWNaN3ZOTHdj?=
 =?utf-8?B?MWQvcCsrYnlxM3VtVXJyM0pZNXl4QjZuenpCZ01vY0o5NVllbStkZ20zNUJz?=
 =?utf-8?B?MGliMTVaeHBIOGc3REVZY3BySUtJc2JRcytWRUo3SkV0RC84Zks2NFpmT3d0?=
 =?utf-8?B?U1lyaWVOZXlYOWJjeHc3OTlaQm44bzdERmN5U2RBTWlqSkZvQTdTVkE0VWE2?=
 =?utf-8?B?MGpqZXkwQU9DQlVRb0c5dElnNWdBVTh0a3Vkckp1MEU5UEFodDVpWU1yaU9B?=
 =?utf-8?B?QlM3TGtwd2xLSTVrQ1pnSVllekFkM2YwRWVyNStJbHhKMTE3K2FRa05lUnRF?=
 =?utf-8?B?M3lzdkJTVmRGNW1rOERFNTI5NHY0cmxFNlZLdkZaeUo0aXYwdW9sK3J0OFNS?=
 =?utf-8?B?MWRqUXh2alFJbHFuMDJFSmJ2ejFFbDNNM2htbnZPeGlhbkZ6MjdsS2RTYXA0?=
 =?utf-8?B?VEM0UDJUd2RhQlZLWWF0Y1FLYUlLaVQyVzlaeEdFWGVrTXZCc21tLzEyTktG?=
 =?utf-8?B?akZJRDQySDhXclNSZG9rOGgxaUV0UnBQc2svZzF4NXl3WTUzNkh5SVhDQ3Fr?=
 =?utf-8?B?YS9iT3lpcExJeU4xazNCSXhBNFZIc3hEd0pXZFZTNHFPSjhGRWR0VWVReThy?=
 =?utf-8?B?ZDJ4dUZpNGFQdlpaWGU3SG8raEpSeGpuMElXVjNwNmRaV0FXdWcxZ1lWMHNB?=
 =?utf-8?B?ZldYZ0RpakpCYzVQRG1WOWtCTUJDelNGdURjdnhNRlhmUEEwdUJFTWowemQ3?=
 =?utf-8?Q?y+NfLfGqOJvedTXRLBSe94w=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84825a0d-a42f-4ae7-b093-08dd094ca11a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:18:08.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IW1lcGwwIp3CbK5i4LDQRzww9/suNQjWzrb3YXDY4rsS9Md15f22rLhhay+kGOo5WFejSODGByfjgYLUFT5XxVc39JpGTeIl70VVjpAHUgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9094

On 11/20/2024 12:01 PM, Marc Kleine-Budde wrote:
> On 20.11.2024 11:01:25, Ciprian Marian Costea wrote:
>> On 11/20/2024 10:52 AM, Marc Kleine-Budde wrote:
>>> On 19.11.2024 10:10:53, Ciprian Costea wrote:
>>>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>>
>>>> On S32G2/S32G3 SoC, there are separate interrupts
>>>> for state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
>>>>
>>>> In order to handle this FlexCAN hardware particularity, reuse
>>>> the 'FLEXCAN_QUIRK_NR_IRQ_3' quirk provided by mcf5441x's irq
>>>> handling support.
>>>>
>>>> Additionally, introduce 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk,
>>>> which can be used in case there are two separate mailbox ranges
>>>> controlled by independent hardware interrupt lines, as it is
>>>> the case on S32G2/S32G3 SoC.
>>>
>>> Does the mainline driver already handle the 2nd mailbox range? Is there
>>> any downstream code yet?
>>>
>>> Marc
>>>
>>
>> Hello Marc,
>>
>> The mainline driver already handles the 2nd mailbox range (same
>> 'flexcan_irq') is used. The only difference is that for the 2nd mailbox
>> range a separate interrupt line is used.
> 
> AFAICS the IP core supports up to 128 mailboxes, though the driver only
> supports 64 mailboxes. Which mailboxes do you mean by the "2nd mailbox
> range"? What about mailboxes 64..127, which IRQ will them?
> 

On S32G the following is the mapping between FlexCAN IRQs and mailboxes:
- IRQ line X -> Mailboxes 0-7
- IRQ line Y -> Mailboxes 8-127 (Logical OR of Message Buffer Interrupt 
lines 127 to 8)

By 2nd range, I was refering to Mailboxes 8-127.



>> I do plan to upstream more patches to the flexcan driver but they relate to
>> Power Management (Suspend and Resume routines) and I plan to do this in a
>> separate patchset.
> 
> regards,
> Marc
> 


