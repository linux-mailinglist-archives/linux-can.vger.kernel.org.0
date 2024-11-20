Return-Path: <linux-can+bounces-2137-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEFF9D390D
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 12:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996EC1F24215
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 11:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A33A19D8A0;
	Wed, 20 Nov 2024 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qtCb9kw/"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4871199E94;
	Wed, 20 Nov 2024 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100603; cv=fail; b=CgA6tCAWKJYDS/ez7zW95NZafcEOM7r9QViha7uJa7uURres13oGHILCRfUfiEjRcT3dYatCe2MRIX/Wr6NRaOC9wMwhiFexHHCu+95HLSs2y7cL4NNMQepexIcL+JXwPZVgKL1PeFbYAIZq5ZwO40qC2kJBcwMFTg+2/qqjlrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100603; c=relaxed/simple;
	bh=iWcYSiGb7C+6MwfMCDi1bUhUnrjTfq0CjhAv9kzeRxU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k1bcAxAMyR+7xLIYRKOTB+IUV5Ncgmu8YDGFrfn4UITUNLd70vkh/y3LNVjaXCOJDOLXU1FfpgOnnuIcVJSywneQuDOOH34DE0JlOljl/vqeByh36/sg71UsH9+Ofjvb+5ezN0H3oeNTJHRshhtDUlcRYAv7gKov2oT3AOzDRdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qtCb9kw/; arc=fail smtp.client-ip=40.107.105.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjnZW27UfwS5yFLbpKqtp3O0ETtKmIEN5vYTRIO1w0oxca3LpRQCWzDSD8AV4MEHQHYn0UwkenEfZSV/XJeS5IhyIXdSiukEMn/g+if8KxrzO8Qw6Obb5xJvQnAL9IcWZICeHdFHszA16i/Bb6kt23LtMGJCB0/70K0uVkGypfNeOxeJflRCBi7HToFBzEv6PgJz/3BT8iX6ihWccB094eWZZ2g+ZGRMNhWPo5IKdzk8FWOBPsFMtsqBwL0IUxFm+QEkQ7Kp/W6gJ++I92YIilpviuTV0rwFGA3JcjcuKxMvv8xCzYTft2RixDqnl2W2/V3chr8Tk1lj/7uY1J7v4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dc1yBLrLc4AAa2zDc+tS22Ebsua0D2OuUw9rpCJsfxU=;
 b=d4CitxFSe+x86ujKKcBJnyq3G5CY8kge5M85oILir/dc87fGQIQJek1uiKJ1/PgByXCA2fYigi3dRrC1gmIPYosLjnPr6GFC90rC+IKPZC0U0ZCQPrJ9mAtn8U0QR6/0zxKsEO49yJSQfT57W7SmOnVjn46wodcjyAV2I4bVSNAL8GpTmwaFMebkrElpjqQgJ4a/uhDifihIWXMoh/I1WrGglhKz8DLVx3SpA5/sQtcIf+Fmh1Jv/NFbSK8XrxDPX2pv65JsqTqGTW7FP4xdghqCA4gT8sj69b6TFyc+V8X8Of/luJdZYpxx338wmooKARQqVNUtpxKzZjVUJo82MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc1yBLrLc4AAa2zDc+tS22Ebsua0D2OuUw9rpCJsfxU=;
 b=qtCb9kw/I1md/VEkdFSW4kpydx/DQxwd5ChKJFZjwz5BT7Mazx3eneRhRG42KIKOAOxItP+BV7oki0Dawj+MLrm+KHmXfalzsUtOfrKuv3zvMV3d1HSrju6HbYkqt1ewuSn3X5B7D/ENmGFFt7JhMAtirLKv6GP0G5MDWUeqnLEuNdEBzY52CRnvoWP0yHSvZVRr2GoTgbfg4w7wLQXE79hDGpTQHzrP+h1wbAhLE6mBivJpCGdGoZepId8j2kjleJEx1VzK3k+XAw9arBebpVih9vgJilh7cLQ4AGrrtJiGMhS2zPe6mcMSSPTq4fs8GKrZWvHDkkV2wHfXPtYBNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA4PR04MB7775.eurprd04.prod.outlook.com (2603:10a6:102:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 11:03:18 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 11:03:18 +0000
Message-ID: <06acdf7f-3b35-48bc-ab2e-9578221b7aea@oss.nxp.com>
Date: Wed, 20 Nov 2024 13:02:56 +0200
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
 <aa73f763-44bc-4e59-ad4a-ccaedaeaf1e8@oss.nxp.com>
 <20241120-cheerful-pug-of-efficiency-bc9b22-mkl@pengutronix.de>
 <72d06daa-82ed-4dc6-8396-fb20c63f5456@oss.nxp.com>
 <20241120-rational-chocolate-marten-70ed52-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241120-rational-chocolate-marten-70ed52-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0024.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA4PR04MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a7a1ab-6117-4812-7fa2-08dd0952f000
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TW1sdmVhZWUzc3JQYkxMUGdBSFhJZ2xjVVpwcERzazJ1c2piOXpXdFFtdVNz?=
 =?utf-8?B?azZuU0Q3S3ZFZlFQZ2U1Q1IxaDJnMDNNRVhoRWNWN1dETVYyY2NXYzdLTzEy?=
 =?utf-8?B?SHA3bzhtK01MdXRVNnpQcXN1c3kxeUlNd21lM0M4WjFiOS9kd2J5Q09DZ3Jm?=
 =?utf-8?B?SFNVT0hMdFBTU1VNU09rYm15TmZDdFFQQWFOZGtZanZyL1ZLVHJzT2VXZlNN?=
 =?utf-8?B?NGNIdkZJL3NPYkZZSXNsd05aNDAwYmtETUhBcFFoaFlVdWRGZUtjNlBQRlha?=
 =?utf-8?B?V3R1S2w3b09IK0pWVWZRV01qQmE5WHRFbHd3S1c2TTE1QWJUczBuZ2RqTjc4?=
 =?utf-8?B?dWFYTG9sYlhDTlM2VThYaUtTckUvZDNWQmJ1UU52Z3oyZXR4c1hyclFsQWhi?=
 =?utf-8?B?cFMxREV2QWZlNENjaXRqdnpXbnp0YjdjZG9VQkZLS1NvYWhtWEhNTm1LWkR4?=
 =?utf-8?B?Sm5vWXhCUEVmYXF6bDRTaWhUTklnTXZpaVU0YkxLN28xdC9YT2FUdFpNWm9L?=
 =?utf-8?B?K1M4UjhmVjRxaVFXb1VBYmtxT3YvSlRCVzV1RlRKT0h6YlN4ck92MVpLdHRD?=
 =?utf-8?B?RFRwTE4zcU0yWWhQN1d1UnhMRC9aWVpycDRpa0d6RlFudmw2UHBWUDZTNjBx?=
 =?utf-8?B?MTh6VjB4eUU3OVJkbFh4U1dDSzhTQWJETVdtUHNxKzgzUWRTalVOb05aVTRs?=
 =?utf-8?B?bjNjZ3hxWkJIUE55c3A4R3JuSGlPdExrMW5UZjZzSGM3b2lrVzhVU2YzYy9D?=
 =?utf-8?B?NGdscVJZN0luV0FPTHc2ZEhXNndUK1FyeVFOek4rMnR2c21jbEFNcit5Q0JV?=
 =?utf-8?B?amlhSTdSTFlKVnpuMXRBbk50YTRXa1BWQWNHZnIrZWlYWTd6d3pSeWR6Tzg2?=
 =?utf-8?B?blJ3VGpmaEtJZ0J6KzNPMUxianc3OEg1QVJlUTFuRXk3TWk2MFBNVHIxNlpr?=
 =?utf-8?B?R1NJanVCaGpCQ2w5ZFlIVThBS0d4RUhveWJ5TVU2NXZyNEpDNzd0MDJOcVdO?=
 =?utf-8?B?cXducVlTbHpudlg1LzYycThQc2JqeDVYTG0ydm9BSXFrT2xjQkphaVlLbWNs?=
 =?utf-8?B?ZzdPM3p4L3lkSVRyLzk2d0xQV2VzT1BaZ0hrOW1OR0VPRFlJM2s4T3RSbDAx?=
 =?utf-8?B?d0hZcm8xZnpCVEVvQXRSNGsybDlZK3k0a2JJRmJXRURCbTRsSWRXdTlGWkRH?=
 =?utf-8?B?WGlHRHdSR0RkSnJleHkycUU3V3JmaG50YndndDduRWhYOUJ0cVdneWJCZ3NJ?=
 =?utf-8?B?aEI4d0plK3JJV2tGdUZGSSthSmdJbTF0UVNvSzNJbzJXNEhOdzd6QUhucEll?=
 =?utf-8?B?VzZJbkRyazFaQXk1NVlRamkyU0xBTTJDaHlTb1o2NVZsU2EwTDMzaGJubGhi?=
 =?utf-8?B?bm1qZ2ZNNjJSR3RVNU45cWJhdUdRdUNiOTlydDZnK253QXlSVzZvRkpqK3hs?=
 =?utf-8?B?VVBrQ2ZqeitXNXVCazNpV0JLczhQMzl5QzFuSWlSbW93VGtDSGNMbnZIYkpZ?=
 =?utf-8?B?YkJvS255YnhYTWxBdkR0VXdPNnZyUVhWdXBDL00rQ20vWnB0NHZIVW9aSGhT?=
 =?utf-8?B?MmlwaTU0UHFJM2Z0SzMrY01XS3gvbDYyOU9vSWFOSWVWYmkvQ25WbHRtNjky?=
 =?utf-8?B?NTlGek5udU5ucVcxWGlOUFNqRGl3Z2ZzVDFtNXp6eWNSQWozL3ZiYTlYaDF1?=
 =?utf-8?B?WVZBNE9BM0ZtWmhtdE4rQ3dJcGo1aE45Rk55ZGFFM21EMVhucGZVYWlyUjlV?=
 =?utf-8?Q?0yQedNmM1/8hIMxnn7jQN3/FeoMlHSSF/MDbjFb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGh5T3BpaXJMT3Y1QjFFU0dCWHdEZnhWWnJkemNrS213UU5JTHdIWmtQS21z?=
 =?utf-8?B?VVMzUnNSR2dwdThDVm1nMlRRbDRiN2pxdFI2Q3NVTVhNVUlDUjlWWGdZcW5h?=
 =?utf-8?B?NVVhVm9yTS94bjh0dHl4Tmd4V2JWdzNhcHBtbzQ4OEdUc2c1YjhOeElpaFhS?=
 =?utf-8?B?cmdFbnlRRmE0dU9ZQURQVWtJTU8xcXZSWmZwclN4QUEwWVNweUplV1dtVndP?=
 =?utf-8?B?b2g3cWIzRXdvWWdjbXFGQUI3S3F3K0FZSkJuQk5FcS9RdVpwU0dlaGdJV0lk?=
 =?utf-8?B?NTczTTBvT0tOaGxrNHArMUdzUjVobjBaQml4ZGhXUEhJN1o3TzN3QVFtcFB5?=
 =?utf-8?B?dGVaNTNHL0Q5L1ZDWHo1d2c5TTFZR1NIcCtlRG8rNFhiMzdONDVKbEJYeFJ0?=
 =?utf-8?B?TFhidEpLNnV4NUFmQ1FJVytWUVozRHRZLy9TdlB1QUNxT0h4Z0tURlhXUWVE?=
 =?utf-8?B?cUlNMHhRUm5Nc0FSRXNlZjIraXVBTUkzWHA5N0EwVUZtOXg1ZkUyNmM2L2tH?=
 =?utf-8?B?cGNUTXIvWFJ4KzM3M0pLWkFlRkxOKzBaZm13L3h2NzFYWjBsYk1FNkllUGFw?=
 =?utf-8?B?cWJQV2QvM2JpOWtOOFkyUFhReFRqUmZDallwTElYeitIaHhvTGNRNXcrWFRp?=
 =?utf-8?B?aGlJa3VZYVZDZlRwbGFuSlcyRjY5cm1wN2hoaEVIcWJZQjZ1Ti9YUERFWlFk?=
 =?utf-8?B?ZXY3bUZUQXVCaUtyZ0ZxOWdoaFdCL2wyREZPb28vK1I2cE5zWnRsMnVjQzRr?=
 =?utf-8?B?emN1OUU5UWM4bjVPNG5iV1NRMjFTZ2lTWlBPdzI5bXErRzJRWHpaSUhYNHZN?=
 =?utf-8?B?SzJKNFIyZllUSjdsbHlPRUdaeW5HTHB0SjJCNWxIL0FNRk1QSVFsTllPNHlR?=
 =?utf-8?B?VkVFVzJaNUQ1bk5kZWxwV0RJTFZIWlZLNm9MVUJuTW4zV0hnMk14dWk0UXlv?=
 =?utf-8?B?eWEreDYzeUtWcXZ0ZTdQenlQNlAzYWtjbnRMZ3NDTkt4WkVGcHpqNllLUWVD?=
 =?utf-8?B?WlFYMnVYWHI2Ymx1NmRMTmtjMk5CUCt2bzZnUnI1QytuM3ZtU2tLRnd1b0p5?=
 =?utf-8?B?VTR1RENyamo3dEFWNVA5SjlsVVZOaXJZQ0tmM05yK2NjeWRyQUpHUjlFRFM5?=
 =?utf-8?B?bUhqbGVxc3c2MFZwQUJMNFZNeEhYa1JFeTYrWGoyb1ZQZkJ1TWF2QnlvZ1U0?=
 =?utf-8?B?RmNWejlNZE56MVprNk16K2FPcUZIRzFCRUUwWVR0ZnpFVDBvd3JFQ3ZNUkFw?=
 =?utf-8?B?L0V0YzBxWjN1U1dzSUtTTGJYbjAvaTFTUm5KenZSdWVBTzIzZ3pidUJQK2RE?=
 =?utf-8?B?NUxKZno1eE9aVVE0TzNOclJXOXBSYWo4Q1BDSXg0K2Z6azA4em9TVFloYmlj?=
 =?utf-8?B?VmRYelRsKy9rc3R0bmdYYTFHcDZ6dFVRVkQzNlgyZk1xcXZRUUJ6c1U5Sm83?=
 =?utf-8?B?K0YzQkRMNGZkeHJkMWRsMGJlRmpERndNbkRZT2tsbWxCYkR3VzZHRWdEY2o1?=
 =?utf-8?B?dFZndzVwNnROU3VhdEQ2N05KTkxMeGNpRWhvQndJN1Nmd1N6cko1ZmR5Qmpn?=
 =?utf-8?B?WnlEYTRUZTRBWWVWaHVJV3Z4dVVpdWNlVW9HQWE3VllnQlkxYVpxT1NKV0ZI?=
 =?utf-8?B?TXdBVGFWZDl2aTh0ZTFUdkd1WDVPTlpvem94SFBpczB4TStKd0hwQ01Bazhj?=
 =?utf-8?B?bEt2OUkzbUxXdlNnZk0wVmpZbWRFSStXSDg3ektDTnovUER0L2o1R1lZVmxD?=
 =?utf-8?B?QjBtWW5DZERTald0dUlCWDY1MFZyQXFxdDhuUlhsSlFudytYeTNkcUg4L1Ax?=
 =?utf-8?B?VGlnRk9OVDdoalcrS1RGa2JYS0pRVklXekRrY0p1U3E2TVVHRVBkaUx3MVJl?=
 =?utf-8?B?Y3JXRzNocWxtVW1oQlQ3dzlqODgrQ096QWM5VW5Wb3ZHbEpJTUhsdUpWVEFn?=
 =?utf-8?B?YkZjMXpCVmloZGV5QW1RSG9IMmdUeU9lOC83cGFIVFRFQkVQZU9weERLRFBy?=
 =?utf-8?B?b0RoRjM1dWdzb1JhYVpFVEVud1hxSFRUTDNjM2FXQ1NLeXZaRzI3eURUYldx?=
 =?utf-8?B?dVZVODRBSUJuVTBKdlYzc2wvZytubkU0TnlvZ3ZWOWF5RXdUd1BleEtabEVE?=
 =?utf-8?B?dGxzUUFaU2k1bmJrN0dHSlkvMEt3V3o5NXNzNUtJcG5OMEtjdHpFQ1R3SjJL?=
 =?utf-8?Q?wkb9PTJWv30A4A6elp4DJ70=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a7a1ab-6117-4812-7fa2-08dd0952f000
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 11:03:17.9597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neVVmVPNV8l/2iffj1gB/FgEIOJvEc/ba6NwIgqoTU6QNi5yRpodIYxBEIv6icRlym+LoEv4zdWTF42udI6DS1y6ipZG08Ce6z3HGmDeYn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775

On 11/20/2024 12:54 PM, Marc Kleine-Budde wrote:
> On 20.11.2024 12:47:02, Ciprian Marian Costea wrote:
>>>>>> The mainline driver already handles the 2nd mailbox range (same
>>>>>> 'flexcan_irq') is used. The only difference is that for the 2nd mailbox
>>>>>> range a separate interrupt line is used.
>>>>>
>>>>> AFAICS the IP core supports up to 128 mailboxes, though the driver only
>>>>> supports 64 mailboxes. Which mailboxes do you mean by the "2nd mailbox
>>>>> range"? What about mailboxes 64..127, which IRQ will them?
>>>>
>>>> On S32G the following is the mapping between FlexCAN IRQs and mailboxes:
>>>> - IRQ line X -> Mailboxes 0-7
>>>> - IRQ line Y -> Mailboxes 8-127 (Logical OR of Message Buffer Interrupt
>>>> lines 127 to 8)
>>>>
>>>> By 2nd range, I was refering to Mailboxes 8-127.
>>>
>>> Interesting, do you know why it's not symmetrical (0...63, 64...127)?
>>> Can you point me to the documentation.
>>
>> Unfortunately I do not know why such hardware integration decisions have
>> been made.
>>
>> Documentation for S32G3 SoC can be found on the official NXP website,
>> here:
>> https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32g-vehicle-network-processors/s32g3-processors-for-vehicle-networking:S32G3
>>
>> But please note that you need to setup an account beforehand.
> 
> I have that already, where is the mailbox to IRQ mapping described?
> 
> regards,
> Marc
> 

If you have successfully downloaded the Reference Manual for S32G2 or 
S32G3 SoC, it should have attached an excel file describing all the 
interrupt mappings.

In the excel file, if you search for 'FlexCAN_0' for example, you should 
be able to find IRQ lines 39 and 40 which correspond to Maiboxes 0-7 and 
8-129 (ored) previously discussed.

Best Regards,
Ciprian

