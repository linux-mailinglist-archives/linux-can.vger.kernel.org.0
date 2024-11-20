Return-Path: <linux-can+bounces-2139-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920E09D39B7
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 12:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E15B25BB2
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 11:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5980D1A0B13;
	Wed, 20 Nov 2024 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s8kB8qIJ"
X-Original-To: linux-can@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013065.outbound.protection.outlook.com [40.107.162.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1260019C56C;
	Wed, 20 Nov 2024 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732102967; cv=fail; b=TuPl2ZXSlCJJuAtf9gqDmLOJRbysPmFaSrBNWWpUhVwztwwW7OhZqPoooCrCDQ4hG6uq8RRurJMhO9GZ9TjwZULVl+SnuN55zVNXVdXjcRNO+yD9OdBQvxFhWGXx7blt3V8YwAVia57yKOYOcC6fiTeM4Ox8HOO86ve9wKd0VTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732102967; c=relaxed/simple;
	bh=NLUunoI/UIy/EziwNKfFO3mv6zm09grYHISziC37atM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LCzXbLB1Bk7XDZ/zEhZbPhETmo2rHw2tShtBRiX7rGZkw266OPjbQzDddYoOvrFQg6Z44+1Zm4KMzADjXD+3/gnNUl2gIXnYLsJ/+N97O7IE2GWl5d/71U3fJcoj6E2zK2vdVPJrjPh6o8wTljpjVFWmVVTYTHEBWtAQqXp4DWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=s8kB8qIJ; arc=fail smtp.client-ip=40.107.162.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2UQPPipnmCxAZm4CyzXcX8l1K9RDaawvsaCOQODZGoHCkEIvDFBZvq0CA2rUJaXOXWWsjpR1acUQdd+/MVXS5LS/vbhw+8RgKCHwdOKLC2fbosqU2w8+YKgvw4vk1ERlh4nw4CnJfihevMOJhqN/KWzUTu6m01m2MjiBqJi5FzrKGI18vOyS+pNT9ci527aH+Cm+ePjmtu7dDilGxhlr0Lc4cCdmSn5tN3WHTb8xuYunZyBV/5jujvEsgDoAFVicUyazUPmYETzYBF91oMCwB9RunufY6jup3bNDHaWD+wi4YDKvyS/124dOwLPDeNha4k6NHEdWhjz+RYJTpl1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0PnJOUd9HVSAcAE/ZMq0C8td3bIvW7btAqboUZ9fvI=;
 b=V8RvD1fSJ+/gh/9yFXGzjQg6prhbtxK+hV2oIjfbOrzezz4deoZhp2XWIdSMjv5V2DvUQrNujedW6CGO/eDAieR3+saOfJZOa9Q2JsHRi9c2bvW1mgdj+ynYOF1NkrARiBEzJGY8vyN5JaFnNhILlgnM3OgayGBLslw1NUS3qvqc6qjSeClIDmk8RefD35Ik7H0J/oEAicAhlg8oW+4B7s3p4b0rz6w4JhqXvA0X3yWKiHplYC+IUMibUHNy4ln2H2NONHS46owqRbxKdHf05ArdbCizBZpmtp9tYkadf6sC4kgY06DDdoSx/qczHvXdV2lBVgHRSLYmf85CUMfgAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0PnJOUd9HVSAcAE/ZMq0C8td3bIvW7btAqboUZ9fvI=;
 b=s8kB8qIJkl4/HurrTwZQRfM1feg6LfW1x/1qaiH2yoXRaZtVfHO5V5EO1/wD98yKHxQLCc1v+ZBQUabDlba9n5e3hcMcc/nngllVv/PImHA9+lrLFnEhNxct7JF2J9rMYl37UqCWmzZO97y8rDZZsfFZr8432g9I6V4rj6sAx905VonF/WDElkovhXKT9ZlBDIXMev3F8jv+ZMSNWwS4uwUTGG3xF1APkiZdMnQWScdIEtkDxZelTSrNWhQUD93XEFKhVgAwyNYuQ/ZwSU1MCdfekzRSSBAYiCKBoZ5TyGOwlm7LMVd9T8Cio5ZX2Nj6ZUb6ImNLwqsYb0txYnuzyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DU2PR04MB8597.eurprd04.prod.outlook.com (2603:10a6:10:2d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 11:42:40 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 11:42:40 +0000
Message-ID: <48171b0f-b0cd-4c9a-a93b-5537000329f8@oss.nxp.com>
Date: Wed, 20 Nov 2024 13:42:18 +0200
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
 <06acdf7f-3b35-48bc-ab2e-9578221b7aea@oss.nxp.com>
 <20241120-spirited-vulture-of-coffee-423adb-mkl@pengutronix.de>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241120-spirited-vulture-of-coffee-423adb-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::17) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DU2PR04MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8cd518-b807-4659-1ccb-08dd09587065
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHZ3T0F6Z2p3b1hjUGIzN2xnUWh1OXJ4cG1ZWkFLRXp5RHk4UFMwU2Myb2FH?=
 =?utf-8?B?VFg5VXF6T1I2NS9BeHBHSzRKWGxUbmJ4LzNYSlZsN0RYR1p2dGJxRjJweE8w?=
 =?utf-8?B?aEpoNHRHN2djWXJxYjJ4WDdrWXQxVGx3VzJ2MDhqVS8zcjc4cjNFZTEzaXVU?=
 =?utf-8?B?dmhoSnlnT2JhMk16NytEWnRuQUtRTjlqRUU3TzU3dS9GVk16S1lFdlI4SHZC?=
 =?utf-8?B?a05YV090bWc3TkNCMU11aTBNTnMrclVjMytpRTFaVHc0Tm54ckc1N3dIdUlr?=
 =?utf-8?B?ZFo5b2NjUzdjRXNha1ZqTnFXUStjQmVkYloyVWFvcEp2TUozUCt3aXpZcVBn?=
 =?utf-8?B?Wnpvd21jcFRlMm9VSGxzUUoxWDFFYTJjVUJSVG5za1Z3UmtqUWxVcXlEWW5n?=
 =?utf-8?B?b1lXZjh1cW12aG1UTCtCZjcvQlVTemxUQTl6RWlVOXNCd0R4LzRjVXRScjl5?=
 =?utf-8?B?RHdEcUtQOVYxcDZzdWViUXZqeWUrZHB0Tzcrbm1PTGwyaFVEMjQyT2VYQ0hB?=
 =?utf-8?B?TlhwRDlxbDJRZ0Y5ekZsd1lGOStXa25GS1hZNmlTNnZwcGdoUzJhR2cram9X?=
 =?utf-8?B?Qm5GZjF0c0doN2JqSExTS1VwV0RxMWc5aklyRUhNbktOeUljcHFVNWk2SDNo?=
 =?utf-8?B?azYxbG1OQ1JGVTBmM2RxcDYxeUFiQ3NiWU1iMEFlNU1kU3NXb3FpTzhOK3BD?=
 =?utf-8?B?RnJiYWZLVlVrbG5JWkd2WkhmUEFTVm5iSkF0YitCVDJUZ2RDY2dFbzh5WUlP?=
 =?utf-8?B?aDJlY0hnRmJqTDdHdXY2dFZCRXlPbWhpS3JoUGlBczNPcHpzem13aitYUy8w?=
 =?utf-8?B?NFZhOEhnOHZ5WUdFSHh5MFZOMysvSkFHZzlQODZ1ZEZYRmhCUlExb1Uzanhl?=
 =?utf-8?B?cEsvNmF4YnVxSHNOd1p4SldQMkdlb0djbVh0Q3lTbUVKVEN6ZzlLNmwvd0py?=
 =?utf-8?B?SzVtWXRnZmtGeS9MTjhFNEFuYUxpbkhtbk5YVy9RMURwRWlWeFY0NkhXZFdp?=
 =?utf-8?B?T2FITWxMN2pRK0UvbGhBSE53Yjc3YU52V05HdXF2NlZncDNRV0VmMVFRMEUw?=
 =?utf-8?B?K1FNYVNRSzJiYmVuNG9aY2NTTHVPY1pWc0FMcHRBL09MbG5UbXpzVjRydU1B?=
 =?utf-8?B?bjNMemgveGFwM3Ayc3BQV0RTZnpKOTVWZTZsRTY5MUVVck5EZEVOL2doVzFK?=
 =?utf-8?B?UmhTYjAzWHdBQ0lrcktKN1BwazB5ZXF4TGNtT2VLZldJQ2RPeUpSd0xSVEw2?=
 =?utf-8?B?cUpPUURVcmc1VndiZ1QyQWdPS2lJd04xK0xqcGg1dmtmaENQRFo0TzJJbkNN?=
 =?utf-8?B?V2o4bXk2QmdVQURmMHZiaUsrU2RsdDZEKzVUMkJIaUpsUzR5alVxdVlwMFU4?=
 =?utf-8?B?MXpDR2wxMFpxbXNJaWZlamtkUHFqOUZmdDhXb1ozSFBzTnBaTGtSMjB0eFkv?=
 =?utf-8?B?OUNqSis2QktrZVkwRkY5aFQ4S0lUNHo1L2w3YlhnczFLcWN2K3E0THQ2bnFo?=
 =?utf-8?B?SlpOQTdGdy84L3N1NUQ3S0xpbnprcVg3dWZyb0d2bFF6b0orU3RnVDVYem0v?=
 =?utf-8?B?U2pBWVVVeHV0OS9wZWswR0l6VWJwMjZSb0pUWnhVZkJUajJTWjltbFBMam9K?=
 =?utf-8?B?dWl4NDZQZGQrRXBiTXRqZGRYNkV4R2lSZXpwZjAveUl3VjBGb2N3NnpTM2NH?=
 =?utf-8?B?MTU0ZlNpeElxY0VSdDNhUUxoN3VQclhZVStZYWYrVFdibS96K1BPWGJRTjgy?=
 =?utf-8?Q?JLRx9XbCkcyMOEANGWlcRd22O+i/omSU0DsuL8T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?em5TMzkyUzVlazFKeWFuSTMwaDBTb1hXU3AvT1RhTzU2N3hKN1lXOWx0dVJG?=
 =?utf-8?B?aVZVdkNXYkZPVU1hT0JtN2hhNTRiM3NSWG0xY1dRZXVZUjVFd0lpRkZmenpo?=
 =?utf-8?B?SS90VU4zRXZHOGxEeHBoSTBodFBZWEZtS2dkeWN4RGdmVGdNRjdqZEd2WGl5?=
 =?utf-8?B?WXNLSlR6cHdtazhKbkZKeWtsaXZBNENBUkNpZGtwZTFuNFZ4bjNENUxiUWZH?=
 =?utf-8?B?TXVaL1hQcjVGN2R4NkxjTnpWVWdocGJYTURqZ0JxZGdUR2Zwc3M2QTJCNVNP?=
 =?utf-8?B?c1pBM3NKVWZtQW5FV1QwN1podTE4V3cyZEIrcFVUWi9ITkdrUkZPNWQzV1J5?=
 =?utf-8?B?NmRnVlN0bW5EMG9PbnFPSm1tSlVKNDg2ZU5qbVVzY2s4MFB6eENjLzZ4QTYr?=
 =?utf-8?B?TjFuRWZOdTRmeFdzVmNOdjhqRCs5b2NxQko1ZEVRWnRyai9Ea25PTmxDUTR3?=
 =?utf-8?B?OXpFaVBhcFdBbjR3RHAwODlFMjRkRnNMR1FUdS8xOUd2R3FPUUFjVStEbVQ4?=
 =?utf-8?B?NnR6QVRoRWVUeXRoVERvaUNXWEp1V2phdjRlb2x4S29FZVRwOWRVVitKSHR5?=
 =?utf-8?B?ZEVRcHR3ZDJVR3I5czJvTUM1czJkYjBTVW5HUUpZSDR5Mm9LMTZkNGswV0s5?=
 =?utf-8?B?Rm1JbnZVOUVJZ3VpVHVqd2g5T0lReEE0RXlxQmhCNktac3ZWKzgvQTQvUGZ1?=
 =?utf-8?B?dlFpT0F3N2lVNW9uY2hUdmNKRWlFaHVjR1MveW5IMTZveE9wem9NVElPTHRx?=
 =?utf-8?B?UXZTZDhjcFBoNGdzUlFWb3hGbVhWRUpMdCtMTlNJdGJNY1p1NDdINFlHSVcw?=
 =?utf-8?B?bm5lSVJuSHJjWEN3TzdyejlSZDgrRS9jUnMvazZ6TDJrT0s2c1V2MHhDeVVQ?=
 =?utf-8?B?WnlQc2RaSTlQQnVsS0dGZGJ0c2xISzRZTVVJRUowQUcvczJpZmw4Zk9OTzlv?=
 =?utf-8?B?MGl0S3kxbGJaLzgxWm9ZaE9RZlE4RWxPT0dJLzVJZXBVcTBPRzZrdWMza1V2?=
 =?utf-8?B?SHoxaDhGZkFydHNLTTM0WW96dm9JY3NUVmpMMG5wU1JtQmF6NGdwU2x4enNH?=
 =?utf-8?B?dEFidzlCSmRmRVFmblVnaGFpaEZFbVZrMjZwSU9SQ1RnSHhESHFhUnRtMXI0?=
 =?utf-8?B?cXVITEFVdkJNR0NzSFozTGRBMWp4dHQ3Yi9KWGpqR1RuSWN1WHZzUXF0b09r?=
 =?utf-8?B?T2pERDM0cmJZcGlLZnV4aDBQNlZYeTgzb1hnL21waS9RTXlQUEJ4QnBYT3c2?=
 =?utf-8?B?ckl6VWY0OWl3Vjk1Y1FINlJYYUtvWDBncVJpMW9JdFNLdUxvYTJwNXV3RUpD?=
 =?utf-8?B?VTV4ZStIbTNmVzh0OFVpK0owbHFIRFRJY05uNE1oZ2JBVklSd2FzNkNBT1dM?=
 =?utf-8?B?WTZwdUNLNWdWTEJCbUxKT0tXWllsSndhOFRHUDlIU0txemtoQ0crUnVjYWFl?=
 =?utf-8?B?dXUwa1pFeTBoZkxGNmM0am9mMWpLTzgzcGowbzUrTkpFdGN6eVZDY3ZUR3pQ?=
 =?utf-8?B?OGs4SXhPS0ozQ0l2VTlNMVBkaERuSm1QMWJ0bEE0ZmtjYldtYUpYMzNXVlJF?=
 =?utf-8?B?cjB1ejlpSTh5ZjVZcDFuWCsyQzlGeWo4RVFxenJySXdEemRqU0RJYkV2Y2Ir?=
 =?utf-8?B?SDdPWDRzR0lEeXN1VjIxOHM3Sm42NVdxRWh4QjZkTjFaOHdmL1lidk5iSW9s?=
 =?utf-8?B?ZHQvRUwxZmU1WmR5WnZpdlN4QVplN0Ewb0kvRG5YMGpGT3h3T2ZaME56R1FD?=
 =?utf-8?B?b3BCWTJMLzVtTVBnVEgvNlhveXU5VUw3dkFzUzM5QnNIOFZWZmhKZlJYZFRl?=
 =?utf-8?B?VE8wWEhuYytQMGowQkZ0Q3pCSCtJQUN5YU1XcHBOZi85ckw4YUdDYjQzUEJT?=
 =?utf-8?B?SDRjZ2tiK05iMjRUajJKQ1duVi9Ub1VxWDdYaUp4bmg2MlNMa2l4aVpqcmI4?=
 =?utf-8?B?eHp1dGNWMUh3NGVyaEh0WCtIWlF3bDJtZ2k0YUVDcnY4djlQMU14SjFkNEFM?=
 =?utf-8?B?cDFXRUlXaEV5dDVhblhzc2pJSXg3VUh6MWw5a0xWenJoMW9rajcvRGRGMGhz?=
 =?utf-8?B?bnpIeGFUeWRrc1RQSlVpRUVwTFRiTVlZaGd1dVM1OU1UUnlTNmUvVDUrdC9o?=
 =?utf-8?B?SWVpYkw1aFRwMElPUXEzWExWYkRuR211eWRiWmhUbnh0Y0wxWWZJWDRYc05m?=
 =?utf-8?Q?iKEd1Im/L+9bHQJl+rXizgg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8cd518-b807-4659-1ccb-08dd09587065
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 11:42:40.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBhIpnrj6UC41S8ZhJtTttSRdmxvBpENQuNHM+quIijE6pGmmfl/+K/wyyX6UNbvcXbvcVphUXLBp6fuT//iI/rjB32SBiI/BkR9d+1oWtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8597

On 11/20/2024 1:33 PM, Marc Kleine-Budde wrote:
> On 20.11.2024 13:02:56, Ciprian Marian Costea wrote:
>> On 11/20/2024 12:54 PM, Marc Kleine-Budde wrote:
>>> On 20.11.2024 12:47:02, Ciprian Marian Costea wrote:
>>>>>>>> The mainline driver already handles the 2nd mailbox range (same
>>>>>>>> 'flexcan_irq') is used. The only difference is that for the 2nd mailbox
>>>>>>>> range a separate interrupt line is used.
>>>>>>>
>>>>>>> AFAICS the IP core supports up to 128 mailboxes, though the driver only
>>>>>>> supports 64 mailboxes. Which mailboxes do you mean by the "2nd mailbox
>>>>>>> range"? What about mailboxes 64..127, which IRQ will them?
>>>>>>
>>>>>> On S32G the following is the mapping between FlexCAN IRQs and mailboxes:
>>>>>> - IRQ line X -> Mailboxes 0-7
>>>>>> - IRQ line Y -> Mailboxes 8-127 (Logical OR of Message Buffer Interrupt
>>>>>> lines 127 to 8)
>>>>>>
>>>>>> By 2nd range, I was refering to Mailboxes 8-127.
>>>>>
>>>>> Interesting, do you know why it's not symmetrical (0...63, 64...127)?
>>>>> Can you point me to the documentation.
>>>>
>>>> Unfortunately I do not know why such hardware integration decisions have
>>>> been made.
>>>>
>>>> Documentation for S32G3 SoC can be found on the official NXP website,
>>>> here:
>>>> https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32g-vehicle-network-processors/s32g3-processors-for-vehicle-networking:S32G3
>>>>
>>>> But please note that you need to setup an account beforehand.
>>>
>>> I have that already, where is the mailbox to IRQ mapping described?
>>>
>>> regards,
>>> Marc
>>>
>>
>> If you have successfully downloaded the Reference Manual for S32G2 or S32G3
>> SoC, it should have attached an excel file describing all the interrupt
>> mappings.
> 
> I downloaded the S32G3 Reference Manual:
> 
> | https://www.nxp.com/webapp/Download?colCode=RMS32G3
> 
> It's a pdf. Where can I find the execl file?

Correct, and in the software used after opening the pdf file (Adobe 
Acrobat Reader, Foxit PDF Reader, etc.) you should be able to find some 
excel files attached to it.

Regards,
Ciprian

> 
>> In the excel file, if you search for 'FlexCAN_0' for example, you should be
>> able to find IRQ lines 39 and 40 which correspond to Maiboxes 0-7 and 8-129
>> (ored) previously discussed.
> 
> regards,
> Marc
> 


